import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/model/user_profile_model.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';
import 'package:qunzo_agent/src/network/service/token_service.dart';

class SignInController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isBiometricEnable = false.obs;
  final RxBool isPasswordVisible = true.obs;
  final Rx<UserProfileModel> userProfileModel = UserProfileModel().obs;
  final localization = AppLocalizations.of(Get.context!)!;

  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Biometric credentials
  final RxString biometricEmail = "".obs;
  final RxString biometricPassword = "".obs;

  @override
  void onInit() {
    super.onInit();
    clearSignUpStatus();
    setLogInState();
    loadSavedEmail();
    loadBiometricStatus();
  }

  /// Load saved email from local storage
  Future<void> loadSavedEmail() async {
    final savedEmail = await SettingsService.getLoggedInUserEmail();
    if (savedEmail != null && savedEmail.isNotEmpty) {
      emailController.text = savedEmail;
    }
  }

  /// Clear sign-up progress and tokens
  Future<void> clearSignUpStatus() async {
    await Get.find<SettingsService>().saveEmailVerified(false);
    await Get.find<SettingsService>().saveSetUpPassword(false);
    await Get.find<TokenService>().clearToken();
  }

  /// Load saved biometric status
  Future<void> loadBiometricStatus() async {
    final savedBiometric = await SettingsService.getBiometricEnableOrDisable();
    isBiometricEnable.value = savedBiometric ?? false;
  }

  /// Set login state to "logged_in"
  Future<void> setLogInState() async {
    await Get.find<SettingsService>().saveLoginCurrentState("logged_in");
  }

  /// Submit sign-in credentials
  Future<void> submitSignIn({bool useBiometric = false}) async {
    isLoading.value = true;

    final String email = useBiometric
        ? biometricEmail.value.trim()
        : emailController.text.trim();

    final String password = useBiometric
        ? biometricPassword.value.trim()
        : passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ToastHelper().showErrorToast(localization.signInEmailPasswordEmpty);
      isLoading.value = false;
      return;
    }

    try {
      final response = await Get.find<NetworkService>().login(
        email: email,
        password: password,
      );

      if (response.status == Status.completed) {
        await postFcmNotification(
          email: email,
          password: password,
          useBiometric: useBiometric,
        );
      }
    } catch (e, stackTrace) {
      debugPrint('❌ submitSignIn() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization.allControllerLoadError);
    } finally {
      isLoading.value = false;
    }
  }

  /// Send verification email to user
  Future<void> sendEmailVerification() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      ToastHelper().showErrorToast(localization.signInEmailRequired);
      return;
    }

    try {
      final response = await Get.find<NetworkService>().post(
        endpoint: ApiPath.verifyEmailEndpoint,
        data: {"email": email},
      );

      if (response.status == Status.completed) {
        Get.toNamed(
          BaseRoute.emailVerification,
          arguments: {"email": email, "is_exit_App": true},
        );
        ToastHelper().showSuccessToast(response.data?["message"]);
      } else {
        ToastHelper().showErrorToast(response.message!);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ sendEmailVerification() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(localization.allControllerLoadError);
    }
  }

  /// Post FCM Token and handle next navigation steps
  Future<void> postFcmNotification({
    required String email,
    required String password,
    required bool useBiometric,
  }) async {
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final savedFcmToken = await SettingsService.getFcmToken();

      String deviceId = '';
      String deviceType = '';

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.id;
        deviceType = 'android';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? '';
        deviceType = 'ios';
      } else {
        deviceId = 'unknown';
        deviceType = 'unknown';
      }

      await Get.find<NetworkService>().post(
        endpoint: ApiPath.getSetupFcm,
        data: {
          'device_id': deviceId,
          'device_type': deviceType,
          'fcm_token': savedFcmToken,
        },
      );
    } catch (e, s) {
      debugPrint('❌ postFcmNotification() error: $e');
      debugPrint('📍 StackTrace: $s');
      ToastHelper().showErrorToast(localization.allControllerLoadError);
    } finally {
      await fetchUserProfile(useBiometric: useBiometric);
    }
  }

  // Fetch User Profile Function
  Future<void> fetchUserProfile({bool useBiometric = false}) async {
    try {
      final response = await Get.find<NetworkService>().get(
        endpoint: ApiPath.getUserProfileEndpoint,
      );
      if (response.status == Status.completed) {
        userProfileModel.value = UserProfileModel.fromJson(response.data!);

        final user = userProfileModel.value.data?.user;
        final requires2FA =
            (user?.google2faSecret == true &&
            user?.twoFa == true &&
            Get.find<SettingsService>().getSetting("fa_verification") == "1");

        await _saveCredentials(
          email: useBiometric ? biometricEmail.value : emailController.text,
          password: useBiometric
              ? biometricPassword.value
              : passwordController.text,
        );

        if (requires2FA) {
          Get.toNamed(BaseRoute.twoFactorAuth);
          return;
        }

        if (user?.boardingSteps?.completed == true) {
          Get.offAllNamed(BaseRoute.navigation);
          resetFields();
        } else {
          Get.toNamed(
            BaseRoute.signUpStatus,
            arguments: {"is_login_state": true},
          );
        }
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchUserProfile() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {}
  }

  Future<void> _saveCredentials({
    required String email,
    required String password,
  }) async {
    await Get.find<SettingsService>().saveLoggedInUserEmail(email);
    await Get.find<SettingsService>().saveLoggedInUserPassword(password);
  }

  /// Reset login fields
  void resetFields() {
    emailController.clear();
    passwordController.clear();
  }
}
