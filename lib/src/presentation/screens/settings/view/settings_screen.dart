import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/common/service/app_update_controller.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/app/routes/routes.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/common/widgets/dropdown_bottom_sheet/common_dropdown_bottom_sheet.dart';
import 'package:qunzo_agent/src/presentation/screens/home/controller/home_controller.dart';

class SettingsScreen extends StatefulWidget {
  final bool? isSettingsMainScreen;

  const SettingsScreen({super.key, this.isSettingsMainScreen = false});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final HomeController homeController = Get.find();
  final bool isSettingsMainScreen =
      (Get.arguments != null && Get.arguments is Map<String, dynamic>)
      ? Get.arguments["is_settings_main_screen"] ?? false
      : false;

  void _handleBackNavigation() {
    if (widget.isSettingsMainScreen == true || isSettingsMainScreen == true) {
      final HomeController homeController = Get.find();
      if (homeController.selectedIndex.value == 0) {
        Get.back();
      } else if (homeController.selectedIndex.value == 3) {
        homeController.selectedIndex.value = 0;
        Get.back();
      }
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, __) {
        if (!didPop) {
          _handleBackNavigation();
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF3F3F3),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                const SizedBox(height: 60),
                isSettingsMainScreen == true ||
                        widget.isSettingsMainScreen == true
                    ? CommonAppBar(title: "Settings", selectedIndex: 0)
                    : CommonAppBar(title: localization.settingsTitle),
                const SizedBox(height: 30),
                Expanded(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        _buildNavigationOneSection(),
                        const SizedBox(height: 16),
                        _buildNavigationTwoSection(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Image.asset(PngAssets.bottomScreenShape, fit: BoxFit.cover),
            Obx(
              () => Visibility(
                visible: Get.find<HomeController>().isSignOutLoading.value,
                child: CommonLoading(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationOneSection() {
    final localization = AppLocalizations.of(context)!;
    return ColoredBox(
      color: AppColors.white,
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildNavigation(
            icon: PngAssets.profileSettingsMenu,
            title: localization.settingsProfileSettings,
            onTap: () => Get.toNamed(BaseRoute.profileSettings),
          ),
          const SizedBox(height: 25),
          _buildNavigation(
            icon: PngAssets.changePasswordMenu,
            title: localization.settingsChangePassword,
            onTap: () => Get.toNamed(BaseRoute.changePassword),
          ),
          const SizedBox(height: 25),
          if (Get.find<SettingsService>().getSetting("fa_verification") ==
              "1") ...[
            _buildNavigation(
              icon: PngAssets.twoFaAuthenticationMenu,
              title: localization.settingsTwoFaAuthentication,
              onTap: () => Get.toNamed(BaseRoute.twoFaAuthentication),
            ),
            const SizedBox(height: 25),
          ],
          _buildNavigation(
            icon: PngAssets.idVerificationMenu,
            title: localization.settingsIdVerification,
            onTap: () => Get.toNamed(BaseRoute.kycHistory),
          ),
          const SizedBox(height: 25),
          _buildNavigation(
            icon: PngAssets.supportTicketsMenu,
            title: localization.settingsSupport,
            onTap: () => Get.toNamed(BaseRoute.support),
          ),
          if (Get.find<SettingsService>().getSetting("language_switcher") ==
              "1") ...[
            const SizedBox(height: 25),
            _buildLanguage(),
          ],
          const SizedBox(height: 12),
          _buildBiometric(),
          const SizedBox(height: 25),
          // ----- App self-update entry -----
          _buildNavigation(
            icon: PngAssets.arrowRightCommonIcon,
            title: "Check for Updates",
            onTap: () => Get.toNamed(BaseRoute.appUpdate),
          ),
          const SizedBox(height: 16),
          // ----- Auto-update toggle -----
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 18),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.auto_mode_rounded,
                    color: AppColors.lightPrimary,
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Auto-update',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: AppColors.lightTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Automatically check and notify about new versions.',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    final controller = Get.isRegistered<AppUpdateController>()
                        ? Get.find<AppUpdateController>()
                        : null;
                    final enabled =
                        controller?.autoUpdateEnabled.value ?? true;
                    return Switch.adaptive(
                      value: enabled,
                      activeColor: AppColors.lightPrimary,
                      onChanged: controller == null
                          ? null
                          : (v) => controller.setAutoUpdateEnabled(v),
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildLanguage() {
    final localization = AppLocalizations.of(context)!;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          CommonDropdownBottomSheet(
            onValueSelected: (value) async {
              await homeController.changeLanguage(value);
            },
            isShowTitle: true,
            notFoundText: localization.settingsLanguageNotFound,
            textController: homeController.languageController,
            title: localization.settingsLanguageSelectTitle,
            selectedValue: ["English", "Arabic"],
            dropdownItems: ["English", "Arabic"],
            selectedItem: homeController.language,
            bottomSheetHeight: 400,
            currentlySelectedValue: homeController.language.value,
          ),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(PngAssets.languageIcon, width: 26),
                    const SizedBox(width: 12),
                    Text(
                      localization.settingsLanguage,
                      style: TextStyle(
                        letterSpacing: 0,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: AppColors.lightTextPrimary,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 18),
                  child: Row(
                    children: [
                      Obx(
                        () => Text(
                          homeController.language.value,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                            fontSize: 13,
                            color: AppColors.lightTextTertiary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Transform.flip(
                        flipX: isRtl,
                        child: Image.asset(
                          PngAssets.arrowRightCommonIcon,
                          width: 22,
                          color: AppColors.lightTextPrimary.withValues(
                            alpha: 0.50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 57),
            child: Divider(
              height: 0,
              color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiometric() {
    final localization = AppLocalizations.of(context)!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(PngAssets.biometricIcon, width: 26),
                  const SizedBox(width: 12),
                  Text(
                    localization.settingsBiometric,
                    style: TextStyle(
                      letterSpacing: 0,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppColors.lightTextPrimary,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 18),
                child: Obx(
                  () => Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      padding: EdgeInsets.zero,
                      value: homeController.isBiometricEnable.value,
                      activeThumbColor: AppColors.lightPrimary,
                      inactiveThumbColor: AppColors.lightTextTertiary,
                      inactiveTrackColor: AppColors.lightTextPrimary.withValues(
                        alpha: 0.05,
                      ),
                      onChanged: (_) async {
                        await homeController.toggleBiometric();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 57),
          child: Divider(
            height: 0,
            color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigation({
    required String icon,
    required String title,
    required GestureTapCallback onTap,
    Color? titleColor,
  }) {
    titleColor ??= AppColors.lightTextPrimary.withValues(alpha: 0.80);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(icon, width: 26),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: TextStyle(
                        letterSpacing: 0,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: titleColor,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 18),
                  child: Transform.flip(
                    flipX: isRtl,
                    child: Image.asset(
                      PngAssets.arrowRightCommonIcon,
                      width: 22,
                      color: AppColors.lightTextPrimary.withValues(alpha: 0.50),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 57),
            child: Divider(
              height: 0,
              color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationTwoSection() {
    final localization = AppLocalizations.of(context)!;
    return ColoredBox(
      color: AppColors.white,
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildNavigation(
            icon: PngAssets.logOutMenu,
            title: localization.settingsLogout,
            titleColor: AppColors.error,
            onTap: () => Get.find<HomeController>().submitLogout(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
