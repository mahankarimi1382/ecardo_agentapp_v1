// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get comment_common_maintenance => '==== Maintenance ====';

  @override
  String get maintenanceTitle => 'تحت الصيانة';

  @override
  String get maintenanceSubtitle =>
      'نقوم حاليًا بإجراء صيانة مجدولة لتحسين تجربتك.';

  @override
  String get comment_common_alert_bottom_sheet =>
      '==== Common Alert Bottom Sheet ====';

  @override
  String get commonAlertConfirmButton => 'تأكيد';

  @override
  String get commonAlertCancelButton => 'إلغاء';

  @override
  String get comment_common_alert => '==== Common Alert ====';

  @override
  String get commonAlertExitTitle => 'الخروج من التطبيق';

  @override
  String get commonAlertExitMessage =>
      'هل أنت متأكد أنك تريد الخروج من التطبيق؟';

  @override
  String get comment_image_picker_dropdown_bottom_sheet =>
      '==== Image Picker Dropdown Bottom Sheet ====';

  @override
  String get imagePickerDropdownTitle => 'اختر مصدر الصورة';

  @override
  String get imagePickerDropdownCamera => 'الكاميرا';

  @override
  String get imagePickerDropdownGallery => 'معرض الصور';

  @override
  String get comment_common_country_dropdown =>
      '==== Common Country Dropdown ====';

  @override
  String get countryDropdownSearchHint => 'بحث';

  @override
  String get countryDropdownNotFound => 'البلد غير موجود';

  @override
  String get comment_all_controller => '==== All Controller ====';

  @override
  String get allControllerLoadError => 'حدث خطأ ما!';

  @override
  String get comment_splash_screen => '==== Splash Screen ====';

  @override
  String get splashAgentBadge => 'وكيل';

  @override
  String get comment_agent_navigation_screen =>
      '==== Agent Navigation Screen ====';

  @override
  String get agentNavigationBottomNavHome => 'الرئيسية';

  @override
  String get agentNavigationBottomNavWallets => 'المحافظ';

  @override
  String get agentNavigationBottomNavTransactions => 'المعاملات';

  @override
  String get agentNavigationBottomNavSettings => 'الإعدادات';

  @override
  String get agentNavigationQrInvalidFormat =>
      'رمز QR غير صالح. يجب أن يكون أرقاماً فقط أو بتنسيق UID.';

  @override
  String get comment_image_picker_controller =>
      '==== Image Picker Controller ====';

  @override
  String get imagePickerGalleryError => 'فشل اختيار الصورة من المعرض';

  @override
  String get imagePickerCameraError => 'فشل التقاط الصورة من الكاميرا';

  @override
  String get comment_biometric_auth_service =>
      '==== Biometric Auth Service ====';

  @override
  String get biometricDeviceNotSupported =>
      'هذا الجهاز لا يدعم التحقق البيومتري.';

  @override
  String get biometricNotEnrolled =>
      'لا يوجد بصمة مسجلة. يرجى إعداد بصمة الإصبع';

  @override
  String get biometricUnavailable =>
      'ميزات التحقق البيومتري غير متوفرة حالياً.';

  @override
  String get biometricAuthenticationFailed => 'فشل التحقق البيومتري.';

  @override
  String get biometricCheckFailed => 'تعذر التحقق من توفر التحقق البيومتري.';

  @override
  String get biometricAuthReason => 'التحقق لتسجيل الدخول';

  @override
  String get comment_network_service => '==== Network Service ====';

  @override
  String get networkErrorGeneric => 'حدث خطأ غير متوقع. حاول مرة أخرى.';

  @override
  String get networkErrorTimeout => 'انتهت مهلة الطلب. حاول مرة أخرى.';

  @override
  String get networkErrorNoInternet => 'لا يوجد اتصال بالإنترنت';

  @override
  String get networkErrorUnauthorized =>
      'غير مصرح لك بالوصول إلى هذا المورد. يرجى تسجيل الدخول مرة أخرى!';

  @override
  String get networkErrorOccurred => 'حدث خطأ. حاول مرة أخرى.';

  @override
  String get unauthorizedDialogTitle => 'غير مصرح';

  @override
  String get unauthorizedDialogDescription =>
      'غير مصرح لك بالوصول إلى هذا المورد. يرجى تسجيل الدخول مرة أخرى!';

  @override
  String get unauthorizedDialogButton => 'موافق';

  @override
  String get comment_add_money_controller => '==== Add Money Controller ====';

  @override
  String get addMoneySuccess => 'تمت إضافة الأموال بنجاح';

  @override
  String get validationSelectWallet => 'يرجى اختيار محفظة';

  @override
  String get validationSelectGateway => 'يرجى اختيار بوابة دفع';

  @override
  String get validationEnterAmount => 'يرجى إدخال المبلغ';

  @override
  String get validationAmountGreaterThanZero => 'يجب أن يكون المبلغ أكبر من 0';

  @override
  String validationAmountMinimumDeposit(Object amount) {
    return 'الحد الأدنى للإيداع هو $amount';
  }

  @override
  String validationAmountMaximumDeposit(Object amount) {
    return 'الحد الأقصى للإيداع هو $amount';
  }

  @override
  String validationUploadFile(Object fieldName) {
    return 'يرجى رفع ملف لـ $fieldName';
  }

  @override
  String validationFillField(Object fieldName) {
    return 'يرجى ملء حقل $fieldName';
  }

  @override
  String get comment_add_money_screen => '==== Add Money Screen ====';

  @override
  String get addMoneyScreenTitle => 'إضافة أموال';

  @override
  String get comment_add_money_amount_section =>
      '==== Add Money Amount Section ====';

  @override
  String get addMoneySelectWallet => 'اختر المحفظة';

  @override
  String get addMoneySelectGateway => 'اختر بوابة الدفع';

  @override
  String get addMoneyEnterAmount => 'المبلغ';

  @override
  String addMoneyAmountRange(
    Object currency,
    Object maxAmount,
    Object minAmount,
  ) {
    return 'الحد الأدنى $minAmount $currency والحد الأقصى $maxAmount $currency';
  }

  @override
  String get addMoneyContinueButton => 'متابعة';

  @override
  String get addMoneyDropdownWalletNotFound => 'المحفظة غير موجودة';

  @override
  String get addMoneyDropdownGatewayNotFound => 'بوابة الدفع غير موجودة';

  @override
  String get addMoneyDropdownSelectWallet => 'اختر المحفظة';

  @override
  String get addMoneyDropdownSelectGateway => 'اختر بوابة الدفع';

  @override
  String get comment_add_money_pending_section =>
      '==== Add Money Pending Section ====';

  @override
  String get addMoneyPendingTitle => 'عملية الإيداع الخاصة بك قيد الانتظار';

  @override
  String get addMoneyPendingDescription => 'تمت إضافة أموالك بنجاح.';

  @override
  String get addMoneyAmount => 'المبلغ';

  @override
  String get addMoneyTransactionId => 'رقم المعاملة';

  @override
  String get addMoneyWalletName => 'اسم المحفظة';

  @override
  String get addMoneyPaymentMethod => 'طريقة الدفع';

  @override
  String get addMoneyCharge => 'الرسوم';

  @override
  String get addMoneyType => 'النوع';

  @override
  String get addMoneyFinalAmount => 'المبلغ النهائي';

  @override
  String get addMoneyBackHome => 'العودة للرئيسية';

  @override
  String get addMoneyAgain => 'مرة أخرى';

  @override
  String get comment_add_money_review_section =>
      '==== Add Money Review Section ====';

  @override
  String get addMoneyReviewTitle => 'مراجعة التفاصيل';

  @override
  String get addMoneyReviewAmount => 'المبلغ';

  @override
  String get addMoneyReviewWalletName => 'اسم المحفظة';

  @override
  String get addMoneyReviewPaymentMethod => 'طريقة الدفع';

  @override
  String get addMoneyReviewCharge => 'الرسوم';

  @override
  String get addMoneyReviewTotal => 'الإجمالي';

  @override
  String get addMoneyReviewAddMoneyButton => 'إضافة أموال';

  @override
  String get comment_add_money_success_section =>
      '==== Add Money Success Section ====';

  @override
  String get addMoneySuccessTitle => 'تم الإيداع بنجاح';

  @override
  String get addMoneySuccessDescription => 'تم إيداع أموالك بنجاح.';

  @override
  String get addMoneySuccessAmount => 'المبلغ';

  @override
  String get addMoneySuccessTransactionId => 'رقم المعاملة';

  @override
  String get addMoneySuccessCharge => 'الرسوم';

  @override
  String get addMoneySuccessType => 'النوع';

  @override
  String get addMoneySuccessFinalAmount => 'المبلغ النهائي';

  @override
  String get addMoneySuccessBackHome => 'العودة للرئيسية';

  @override
  String get addMoneySuccessAgain => 'مرة أخرى';

  @override
  String get comment_forgot_password_screen =>
      '==== Forgot Password Screen ====';

  @override
  String get forgotPasswordTitle => 'نسيت كلمة المرور';

  @override
  String get forgotPasswordEmailHint => 'البريد الإلكتروني';

  @override
  String get forgotPasswordSendButton => 'إرسال رابط التحقق';

  @override
  String get forgotPasswordBackButton => 'رجوع';

  @override
  String get forgotPasswordEmailRequired => 'حقل البريد الإلكتروني مطلوب';

  @override
  String get comment_forgot_password_pin_verification =>
      '==== Forgot Password Pin Verification ====';

  @override
  String get forgotPasswordPinVerifyTitle => 'تحقق البريد الإلكتروني';

  @override
  String get forgotPasswordPinVerifyOtpSent => 'تم إرسال رمز التحقق إلى ';

  @override
  String forgotPasswordPinVerifyCountdown(Object seconds) {
    return 'رمز التحقق خلال $secondsثانية';
  }

  @override
  String get forgotPasswordPinVerifyContinue => 'متابعة';

  @override
  String get forgotPasswordPinVerifyBack => 'رجوع';

  @override
  String get forgotPasswordPinRequired => 'حقل رمز التحقق مطلوب';

  @override
  String get comment_reset_password_screen => '==== Reset Password Screen ====';

  @override
  String get resetPasswordTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get resetPasswordHint => 'كلمة المرور';

  @override
  String get resetPasswordConfirmHint => 'تأكيد كلمة المرور';

  @override
  String get resetPasswordButton => 'إعادة تعيين';

  @override
  String get resetPasswordBackButton => 'رجوع';

  @override
  String get resetPasswordRequired => 'كلمة المرور مطلوبة';

  @override
  String get resetPasswordMinLength =>
      'كلمة المرور يجب أن تكون 8 أحرف على الأقل';

  @override
  String get resetPasswordConfirmRequired => 'يرجى تأكيد كلمة المرور';

  @override
  String get resetPasswordMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get comment_sign_in_controller => '==== Sign In Controller ====';

  @override
  String get signInEmailPasswordEmpty =>
      'البريد الإلكتروني وكلمة المرور لا يمكن أن يكونا فارغين.';

  @override
  String get signInEmailRequired => 'يرجى إدخال بريدك الإلكتروني.';

  @override
  String get comment_sign_in_screen => '==== Sign In Screen ====';

  @override
  String get signInTitle => 'تسجيل دخول الوكيل!';

  @override
  String get signInEmailHint => 'البريد الإلكتروني';

  @override
  String get signInPasswordHint => 'كلمة المرور';

  @override
  String get signInForgotPassword => 'نسيت كلمة المرور';

  @override
  String get signInLoginButton => 'تسجيل الدخول';

  @override
  String get signInNoAccount => 'ليس لديك حساب؟ ';

  @override
  String get signInCreateAccount => 'إنشاء حساب';

  @override
  String get signInBiometricPrompt =>
      'أول تسجيل دخول باستخدام البريد الإلكتروني وكلمة المرور';

  @override
  String get signInBiometricNotEnabled => 'التحقق البيومتري غير مفعل';

  @override
  String get signInEmailFieldRequired => 'حقل البريد الإلكتروني مطلوب';

  @override
  String get signInPasswordRequired => 'حقل كلمة المرور مطلوب';

  @override
  String get comment_auth_id_verification_screen =>
      '==== Auth ID Verification Screen ====';

  @override
  String get authIdVerificationInvalidField => 'نوع الحقل غير صالح';

  @override
  String authIdVerificationUnknownField(Object fieldType) {
    return 'نوع حقل غير معروف: $fieldType';
  }

  @override
  String get comment_file_type_section => '==== File Type Section ====';

  @override
  String get fileTypeChooseFileButton => 'اختر ملف';

  @override
  String get comment_kyc_submission_section =>
      '==== KYC Submission Section ====';

  @override
  String get kycSubmissionTitle => 'التحقق من الهوية';

  @override
  String get kycSubmissionSubmitButton => 'إرسال';

  @override
  String get kycSubmissionNextButton => 'التالي';

  @override
  String get kycSubmissionReUploadButton => 'إعادة رفع';

  @override
  String get kycSubmissionRetakeButton => 'إعادة التقاط';

  @override
  String get comment_submit_valid_id_verification =>
      '==== Submit Valid ID Verification ====';

  @override
  String get submitValidIdVerificationTitle => 'تقديم هوية صالحة للتحقق';

  @override
  String get submitValidIdVerificationChooseIdType => 'اختر نوع الهوية';

  @override
  String get comment_email_screen => '==== Email Screen ====';

  @override
  String get emailScreenTitle => 'تسجيل الوكيل!';

  @override
  String get emailScreenEmailLabel => 'البريد الإلكتروني';

  @override
  String get emailScreenContinueButton => 'متابعة';

  @override
  String get emailScreenBackButton => 'رجوع';

  @override
  String get emailRequired => 'يرجى إدخال البريد الإلكتروني';

  @override
  String get comment_personal_info_screen => '==== Personal Info Screen ====';

  @override
  String get personalInfoTitle => 'تسجيل الوكيل!';

  @override
  String get personalInfoSubtitle => 'المعلومات الشخصية';

  @override
  String get personalInfoFirstName => 'الاسم الأول';

  @override
  String get personalInfoLastName => 'الاسم الأخير';

  @override
  String get personalInfoUsername => 'اسم المستخدم';

  @override
  String get personalInfoSelectCountry => 'اختر البلد';

  @override
  String get personalInfoPhone => 'الهاتف';

  @override
  String get personalInfoSelectGender => 'اختر الجنس';

  @override
  String get personalInfoSubmitButton => 'إرسال';

  @override
  String get personalInfoBackButton => 'رجوع';

  @override
  String get personalInfoDropdownSelectCountry => 'اختر البلد';

  @override
  String get personalInfoDropdownSelectGender => 'اختر الجنس';

  @override
  String get personalInfoDropdownGenderNotFound => 'الجنس غير موجود';

  @override
  String get personalInfoFirstNameRequired => 'الاسم الأول مطلوب';

  @override
  String get personalInfoLastNameRequired => 'الاسم الأخير مطلوب';

  @override
  String get personalInfoUsernameRequired => 'اسم المستخدم مطلوب';

  @override
  String get personalInfoCountryRequired => 'البلد مطلوب';

  @override
  String get personalInfoPhoneRequired => 'رقم الهاتف مطلوب';

  @override
  String get personalInfoGenderRequired => 'الجنس مطلوب';

  @override
  String get comment_set_up_password_screen =>
      '==== Set Up Password Screen ====';

  @override
  String get setUpPasswordTitle => 'إعداد كلمة المرور';

  @override
  String get setUpPasswordLabel => 'كلمة المرور';

  @override
  String get setUpPasswordConfirmLabel => 'تأكيد كلمة المرور';

  @override
  String get setUpPasswordAgreeTerms => 'أوافق على ';

  @override
  String get setUpPasswordTermsConditions => 'الشروط والأحكام';

  @override
  String get setUpPasswordButton => 'إعداد كلمة المرور';

  @override
  String get setUpPasswordBackButton => 'رجوع';

  @override
  String get setUpPasswordRequired => 'كلمة المرور مطلوبة';

  @override
  String get setUpPasswordMinLength =>
      'كلمة المرور يجب أن تكون 8 أحرف على الأقل';

  @override
  String get setUpPasswordConfirmRequired => 'يرجى تأكيد كلمة المرور';

  @override
  String get setUpPasswordMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get setUpPasswordAcceptTerms => 'يرجى الموافقة على الشروط والأحكام';

  @override
  String get comment_sign_up_status_screen => '==== Sign Up Status Screen ====';

  @override
  String get signUpStatusTitle => 'تسجيل الوكيل!';

  @override
  String get signUpStatusSubtitle =>
      'لنقم بإعداد ملف الوكيل الخاص بك في بضع خطوات.';

  @override
  String get signUpStatusEmailVerification => 'التحقق من البريد الإلكتروني';

  @override
  String get signUpStatusSetupPassword => 'إعداد كلمة المرور';

  @override
  String get signUpStatusPersonalInfo => 'المعلومات الشخصية';

  @override
  String get signUpStatusIdVerification => 'التحقق من الهوية';

  @override
  String get signUpStatusInReview => 'قيد المراجعة';

  @override
  String get signUpStatusRejected => 'مرفوض';

  @override
  String get signUpStatusNoReason => 'لم يتم تقديم سبب';

  @override
  String get signUpStatusNextButton => 'التالي';

  @override
  String get signUpStatusSubmitAgain => 'إرسال مرة أخرى';

  @override
  String get signUpStatusDashboard => 'لوحة التحكم';

  @override
  String get signUpStatusBackButton => 'رجوع';

  @override
  String get signUpStatusErrorProcessing =>
      'خطأ في معالجة الخطوة التالية. حاول مرة أخرى.';

  @override
  String get comment_verify_email_screen => '==== Verify Email Screen ====';

  @override
  String get verifyEmailTitle => 'تحقق البريد الإلكتروني';

  @override
  String get verifyEmailOtpSent => 'تم إرسال رمز التحقق إلى ';

  @override
  String verifyEmailResendCountdown(Object seconds) {
    return 'يمكن إعادة الإرسال بعد $secondsثانية';
  }

  @override
  String get verifyEmailResendReady => 'يمكنك طلب رمز تحقق جديد الآن';

  @override
  String get verifyEmailContinueButton => 'متابعة';

  @override
  String get verifyEmailBackButton => 'رجوع';

  @override
  String get verifyEmailDidntReceive => 'لم تستلم الرمز؟ ';

  @override
  String get verifyEmailResend => 'إعادة إرسال';

  @override
  String get verifyEmailOtpRequired => 'حقل رمز التحقق مطلوب';

  @override
  String get comment_two_factor_auth_screen =>
      '==== Two Factor Auth Screen ====';

  @override
  String get twoFactorAuthTitle => 'التحقق بخطوتين';

  @override
  String get twoFactorAuthVerifyButton => 'تحقق';

  @override
  String get twoFactorAuthBackButton => 'رجوع';

  @override
  String get twoFactorAuthOtpRequired => 'حقل رمز التحقق مطلوب';

  @override
  String get comment_welcome_screen => '==== Welcome Screen ====';

  @override
  String get welcomeScreenTitle => 'مرحباً بك في الوكيل';

  @override
  String get welcomeScreenDescription =>
      'لوحة التحكم الخاصة بك جاهزة. تتبع العملاء، أدر الأموال، وازدهر';

  @override
  String get welcomeScreenCreateAccount => 'إنشاء حسابك';

  @override
  String get welcomeScreenLogin => 'تسجيل الدخول';

  @override
  String get comment_cash_in_controller => '==== Cash In Controller ====';

  @override
  String get cashInValidationEnterUserUid => 'يرجى إدخال معرف المستخدم';

  @override
  String get cashInValidationSelectWallet => 'يرجى اختيار محفظة';

  @override
  String get cashInValidationEnterAmount => 'يرجى إدخال المبلغ';

  @override
  String cashInValidationAmountMinimum(Object amount, Object currency) {
    return 'الحد الأدنى للمبلغ هو $amount $currency';
  }

  @override
  String cashInValidationAmountMaximum(Object amount, Object currency) {
    return 'الحد الأقصى للمبلغ هو $amount $currency';
  }

  @override
  String get comment_cash_in_screen => '==== Cash In Screen ====';

  @override
  String get cashInScreenTitle => 'إيداع نقدي';

  @override
  String get comment_cash_in_amount_section =>
      '==== Cash In Amount Section ====';

  @override
  String get cashInAmountSelectWallet => 'اختر المحفظة';

  @override
  String get cashInAmountRecipientUid => 'معرف المستلم';

  @override
  String get cashInAmountEnterAmount => 'المبلغ';

  @override
  String cashInAmountAmountRange(
    Object currency,
    Object maxAmount,
    Object minAmount,
  ) {
    return 'الحد الأدنى $minAmount $currency والحد الأقصى $maxAmount $currency';
  }

  @override
  String get cashInAmountContinueButton => 'متابعة';

  @override
  String get cashInAmountDropdownWalletNotFound => 'المحفظة غير موجودة';

  @override
  String get cashInAmountQrInvalidDigitsOnly =>
      'رمز QR غير صالح. يجب أن يكون معرف المستلم أرقاماً فقط.';

  @override
  String get cashInAmountQrInvalidPrefixNotFound =>
      'رمز QR غير صالح. بادئة معرف المستلم غير موجودة.';

  @override
  String get comment_cash_in_review_section =>
      '==== Cash In Review Section ====';

  @override
  String get cashInReviewTitle => 'مراجعة التفاصيل';

  @override
  String get cashInReviewAmount => 'المبلغ';

  @override
  String get cashInReviewCharge => 'الرسوم';

  @override
  String get cashInReviewAccount => 'الحساب';

  @override
  String get cashInReviewWallet => 'المحفظة';

  @override
  String get cashInReviewTotal => 'الإجمالي';

  @override
  String get cashInReviewCashInButton => 'إيداع نقدي';

  @override
  String get comment_cash_in_success_section =>
      '==== Cash In Success Section ====';

  @override
  String get cashInSuccessTitle => 'تم الإيداع النقدي بنجاح';

  @override
  String get cashInSuccessDescription => 'تم إيداع أموالك بنجاح.';

  @override
  String get cashInSuccessAmount => 'المبلغ';

  @override
  String get cashInSuccessTransactionId => 'رقم المعاملة';

  @override
  String get cashInSuccessWalletName => 'اسم المحفظة';

  @override
  String get cashInSuccessAccountNumber => 'رقم الحساب';

  @override
  String get cashInSuccessCharge => 'الرسوم';

  @override
  String get cashInSuccessType => 'النوع';

  @override
  String get cashInSuccessFinalAmount => 'المبلغ النهائي';

  @override
  String get cashInSuccessBackHome => 'العودة للرئيسية';

  @override
  String get cashInSuccessAgain => 'مرة أخرى';

  @override
  String get comment_exchange_controller => '==== Exchange Controller ====';

  @override
  String get exchangeValidationSelectFromWallet => 'يرجى اختيار محفظة المصدر';

  @override
  String get exchangeValidationSelectToWallet => 'يرجى اختيار محفظة الوجهة';

  @override
  String get exchangeValidationEnterAmount => 'يرجى إدخال المبلغ';

  @override
  String exchangeValidationAmountMinimum(Object amount, Object currency) {
    return 'الحد الأدنى للمبلغ هو $amount $currency';
  }

  @override
  String exchangeValidationAmountMaximum(Object amount, Object currency) {
    return 'الحد الأقصى للمبلغ هو $amount $currency';
  }

  @override
  String get comment_exchange_screen => '==== Exchange Screen ====';

  @override
  String get exchangeScreenTitle => 'تبديل';

  @override
  String get comment_exchange_amount_section =>
      '==== Exchange Amount Section ====';

  @override
  String get exchangeAmountSelectFromWallet => 'اختر محفظة المصدر';

  @override
  String get exchangeAmountSelectToWallet => 'اختر محفظة الوجهة';

  @override
  String get exchangeAmountEnterAmount => 'المبلغ';

  @override
  String exchangeAmountAmountRange(
    Object currency,
    Object maxAmount,
    Object minAmount,
  ) {
    return 'الحد الأدنى $minAmount $currency والحد الأقصى $maxAmount $currency';
  }

  @override
  String get exchangeAmountExchangeRate => 'سعر الصرف:';

  @override
  String get exchangeAmountExchangeButton => 'تبديل';

  @override
  String get exchangeAmountDropdownFromWalletsNotFound =>
      'محافظ المصدر غير موجودة';

  @override
  String get exchangeAmountDropdownToWalletsNotFound =>
      'محافظ الوجهة غير موجودة';

  @override
  String get comment_exchange_review_section =>
      '==== Exchange Review Section ====';

  @override
  String get exchangeReviewTitle => 'مراجعة التبديل';

  @override
  String get exchangeReviewAmount => 'المبلغ';

  @override
  String get exchangeReviewFromWallet => 'من محفظة';

  @override
  String get exchangeReviewCharge => 'الرسوم';

  @override
  String get exchangeReviewTotalAmount => 'المبلغ الإجمالي';

  @override
  String get exchangeReviewToWallet => 'إلى محفظة';

  @override
  String get exchangeReviewExchangeRate => 'سعر الصرف';

  @override
  String get exchangeReviewExchangeAmount => 'مبلغ التبديل';

  @override
  String get exchangeReviewExchangeNowButton => 'تبديل الآن';

  @override
  String get comment_exchange_success_section =>
      '==== Exchange Success Section ====';

  @override
  String get exchangeSuccessTitle => 'تم التبديل بنجاح';

  @override
  String get exchangeSuccessSubtitle => 'تمت عملية التبديل بنجاح';

  @override
  String get exchangeSuccessAmount => 'المبلغ';

  @override
  String get exchangeSuccessTransactionId => 'رقم المعاملة';

  @override
  String get exchangeSuccessPayAmount => 'المبلغ المدفوع';

  @override
  String get exchangeSuccessConvertedAmount => 'المبلغ المحول';

  @override
  String get exchangeSuccessCharge => 'الرسوم';

  @override
  String get exchangeSuccessDate => 'التاريخ';

  @override
  String get exchangeSuccessFinalAmount => 'المبلغ النهائي';

  @override
  String get exchangeSuccessBackHomeButton => 'العودة للرئيسية';

  @override
  String get exchangeSuccessAgainButton => 'مرة أخرى';

  @override
  String get comment_home_controller => '==== Home Controller ====';

  @override
  String get homeControllerBiometricDeviceNotSupported =>
      'هذا الجهاز لا يدعم التحقق البيومتري.';

  @override
  String get homeControllerBiometricEnableSuccess =>
      'تم تفعيل التحقق البيومتري بنجاح';

  @override
  String get homeControllerBiometricDisableSuccess =>
      'تم تعطيل التحقق البيومتري بنجاح';

  @override
  String get homeControllerBiometricAuthenticationFailed =>
      'فشل التحقق. لم يتم تغيير إعداد التحقق البيومتري.';

  @override
  String get homeControllerLogoutSuccess => 'تم تسجيل الخروج بنجاح';

  @override
  String get homeControllerBiometricDialogTitle => 'التحقق البيومتري غير موجود';

  @override
  String get homeControllerBiometricDialogMessage =>
      'لا توجد بصمة أو تحقق بيومتري مسجل على هذا الجهاز. يمكنك إعداده من إعدادات النظام.';

  @override
  String get homeControllerBiometricDialogOpenSettingsButton =>
      'فتح إعدادات الأمان';

  @override
  String get homeControllerIosBiometricInstructions =>
      'يرجى الذهاب إلى الإعدادات > Face ID & Passcode لإعداد التحقق البيومتري.';

  @override
  String get comment_home_screen => '==== Home Screen ====';

  @override
  String get homeScreenTransactionHistory => 'سجل المعاملات';

  @override
  String get homeScreenSeeAll => 'عرض الكل';

  @override
  String get comment_all_menus_section => '==== All Menus Section ====';

  @override
  String get allMenusSectionTitle => 'جميع القوائم';

  @override
  String get allMenusSectionMyWallets => 'محافظي';

  @override
  String get allMenusSectionQrCode => 'رمز QR';

  @override
  String get allMenusSectionAddMoney => 'إضافة أموال';

  @override
  String get allMenusSectionCashIn => 'إيداع نقدي';

  @override
  String get allMenusSectionExchange => 'تبديل';

  @override
  String get allMenusSectionWithdrawMoney => 'سحب أموال';

  @override
  String get allMenusSectionProfitHistory => 'سجل الأرباح';

  @override
  String get allMenusSectionTransactions => 'المعاملات';

  @override
  String get allMenusSectionLogout => 'تسجيل الخروج';

  @override
  String get allMenusSectionAccountNumberCopied => 'تم نسخ رقم الحساب';

  @override
  String allMenusSectionAid(Object accountNumber) {
    return 'معرف الوكيل: $accountNumber';
  }

  @override
  String get comment_home_header_section => '==== Home Header Section ====';

  @override
  String get homeHeaderSectionAccountNumberCopied => 'تم نسخ رقم الحساب';

  @override
  String homeHeaderSectionAid(Object accountNumber) {
    return 'معرف الوكيل: $accountNumber';
  }

  @override
  String get comment_home_quick_links => '==== Home Quick Links Section ====';

  @override
  String get homeQuickLinksTitle => 'روابط سريعة';

  @override
  String get homeQuickLinksQrCode => 'رمز QR';

  @override
  String get homeQuickLinksMyWallets => 'محافظي';

  @override
  String get homeQuickLinksAddMoney => 'إضافة أموال';

  @override
  String get homeQuickLinksCashIn => 'إيداع نقدي';

  @override
  String get homeQuickLinksWithdrawMoney => 'سحب أموال';

  @override
  String get homeQuickLinksProfitHistory => 'سجل الأرباح';

  @override
  String get homeQuickLinksTransactions => 'المعاملات';

  @override
  String get homeQuickLinksSupport => 'الدعم';

  @override
  String get comment_home_transaction_details =>
      '==== Home Transaction Details Section ====';

  @override
  String get homeTransactionDetailsTitle => 'تفاصيل المعاملة';

  @override
  String get homeTransactionDetailsDescription => 'الوصف';

  @override
  String get homeTransactionDetailsWallet => 'المحفظة';

  @override
  String get homeTransactionDetailsCharge => 'الرسوم';

  @override
  String get homeTransactionDetailsTransactionId => 'رقم المعاملة';

  @override
  String get homeTransactionDetailsMethod => 'الطريقة';

  @override
  String get homeTransactionDetailsTotalAmount => 'المبلغ الإجمالي';

  @override
  String get homeTransactionDetailsStatus => 'الحالة';

  @override
  String get comment_home_wallets_section => '==== Home Wallets Section ====';

  @override
  String get homeWalletsSectionTopUp => 'شحن';

  @override
  String get homeWalletsSectionWithdraw => 'سحب';

  @override
  String get homeWalletsSectionAddWallet => 'إضافة محفظة';

  @override
  String get comment_profile_section => '==== Profile Section ====';

  @override
  String get profileSectionAccountNumberCopied => 'تم نسخ رقم الحساب';

  @override
  String get profileSectionProfileSettings => 'إعدادات الملف الشخصي';

  @override
  String get profileSectionChangePassword => 'تغيير كلمة المرور';

  @override
  String get profileSectionNotifications => 'الإشعارات';

  @override
  String get profileSectionSupportTickets => 'تذاكر الدعم';

  @override
  String get profileSectionLogout => 'تسجيل الخروج';

  @override
  String profileSectionAccountNumberDisplay(Object accountNumber) {
    return 'معرف الوكيل: $accountNumber';
  }

  @override
  String get comment_id_verification_screen =>
      '==== ID Verification Screen ====';

  @override
  String get idVerificationTitle => 'التحقق من الهوية';

  @override
  String get idVerificationHistory => 'السجل';

  @override
  String get idVerificationCenter => 'مركز التحقق';

  @override
  String get idVerificationNothingToSubmit => 'لا يوجد شيء لتقديمه';

  @override
  String get idVerificationStatusVerifiedTitle => 'مركز التحقق';

  @override
  String get idVerificationStatusVerifiedMessage =>
      'لقد قدمت مستنداتك وتم التحقق منها';

  @override
  String get idVerificationStatusPendingTitle => 'مركز التحقق';

  @override
  String get idVerificationStatusPendingMessage =>
      'لقد قدمت مستنداتك وهي في انتظار الموافقة';

  @override
  String get idVerificationStatusFailedTitle => 'مركز التحقق';

  @override
  String get idVerificationStatusFailedMessage =>
      'فشل التحقق من KYC الخاص بك. يرجى إعادة تقديم المستندات.';

  @override
  String get idVerificationStatusNotSubmittedMessage =>
      'لم تقم بتقديم أي مستندات KYC بعد';

  @override
  String get comment_kyc_history_screen => '==== KYC History Screen ====';

  @override
  String get kycHistoryTitle => 'سجل التحقق';

  @override
  String kycHistoryDate(Object formattedDate) {
    return 'التاريخ: $formattedDate';
  }

  @override
  String get kycHistoryStatus => 'الحالة: ';

  @override
  String get kycHistoryStatusPending => 'قيد الانتظار';

  @override
  String get kycHistoryStatusApproved => 'تمت الموافقة';

  @override
  String get kycHistoryStatusRejected => 'مرفوض';

  @override
  String get kycHistoryViewButton => 'عرض';

  @override
  String get comment_kyc_details_bottom_sheet =>
      '==== KYC Details Bottom Sheet ====';

  @override
  String get kycDetailsTitle => 'تفاصيل التحقق';

  @override
  String get kycDetailsStatus => 'الحالة:';

  @override
  String get kycDetailsCreatedAt => 'تاريخ الإنشاء:';

  @override
  String get kycDetailsMessageFromAdmin => 'رسالة من الإدارة:';

  @override
  String get kycDetailsSubmittedData => 'البيانات المقدمة';

  @override
  String get kycDetailsStatusPending => 'قيد الانتظار';

  @override
  String get kycDetailsStatusApproved => 'تمت الموافقة';

  @override
  String get kycDetailsStatusRejected => 'مرفوض';

  @override
  String get comment_notification_screen => '==== Notification Screen ====';

  @override
  String get notificationTitle => 'الإشعارات';

  @override
  String get notificationMarkAll => 'تحديد الكل كمقروء';

  @override
  String get comment_profit_history_screen => '==== Profit History Screen ====';

  @override
  String get profitHistoryTitle => 'سجل الأرباح';

  @override
  String get comment_profit_history_filter_bottom_sheet =>
      '==== Profit History Filter Bottom Sheet ====';

  @override
  String get profitHistoryFilterTransactionIdHint => 'رقم المعاملة';

  @override
  String get profitHistoryFilterSearchButton => 'بحث';

  @override
  String get comment_qr_code_screen => '==== QR Code Screen ====';

  @override
  String get qrCodeTitle => 'رمز QR الخاص بي';

  @override
  String get qrCodeScanTitle => 'مسح رمز QR';

  @override
  String qrCodeAccountNumber(Object accountNumber) {
    return 'معرف الوكيل: $accountNumber';
  }

  @override
  String get qrCodeDownloadButton => 'تحميل';

  @override
  String get qrCodeDownloadSuccess => 'تم التحميل بنجاح!';

  @override
  String get qrCodePermissionError =>
      'الإذن مطلوب. يرجى السماح به في الإعدادات.';

  @override
  String get comment_change_password_controller =>
      '==== Change Password Controller Messages ====';

  @override
  String get changePasswordCurrentPasswordEmpty =>
      'يرجى إدخال كلمة المرور الحالية';

  @override
  String get changePasswordNewPasswordEmpty => 'يرجى إدخال كلمة المرور الجديدة';

  @override
  String get changePasswordPasswordLength =>
      'كلمة المرور يجب أن تكون 8 أحرف على الأقل';

  @override
  String get changePasswordConfirmPasswordEmpty =>
      'يرجى إدخال تأكيد كلمة المرور';

  @override
  String get changePasswordPasswordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get comment_change_password_screen =>
      '==== Change Password Screen ====';

  @override
  String get changePasswordTitle => 'تغيير كلمة المرور';

  @override
  String get changePasswordCurrentPasswordHint => 'كلمة المرور الحالية';

  @override
  String get changePasswordNewPasswordHint => 'كلمة المرور الجديدة';

  @override
  String get changePasswordConfirmPasswordHint => 'تأكيد كلمة المرور';

  @override
  String get changePasswordSaveChangesButton => 'حفظ التغييرات';

  @override
  String get comment_profile_settings_screen =>
      '==== Profile Settings Screen ====';

  @override
  String get profileSettingsTitle => 'الملف الشخصي';

  @override
  String get profileSettingsFirstNameHint => 'الاسم الأول';

  @override
  String get profileSettingsLastNameHint => 'الاسم الأخير';

  @override
  String get profileSettingsUserNameHint => 'اسم المستخدم';

  @override
  String get profileSettingsGenderHint => 'الجنس';

  @override
  String get profileSettingsGenderNotFound => 'الجنس غير موجود';

  @override
  String get profileSettingsGenderSelectTitle => 'اختر الجنس';

  @override
  String get profileSettingsDateOfBirthHint => 'تاريخ الميلاد';

  @override
  String get profileSettingsEmailAddressHint => 'البريد الإلكتروني';

  @override
  String get profileSettingsPhoneHint => 'الهاتف';

  @override
  String get profileSettingsCountryHint => 'البلد';

  @override
  String get profileSettingsCountryNotFound => 'البلد غير موجود';

  @override
  String get profileSettingsCountrySelectTitle => 'اختر البلد';

  @override
  String get profileSettingsCityHint => 'المدينة';

  @override
  String get profileSettingsZipCodeHint => 'الرمز البريدي';

  @override
  String get profileSettingsJoiningDateHint => 'تاريخ الانضمام';

  @override
  String get profileSettingsAddressHint => 'العنوان';

  @override
  String get profileSettingsSaveChangesButton => 'حفظ التغييرات';

  @override
  String get comment_two_fa_authentication_screen =>
      '==== 2FA Authentication Screen ====';

  @override
  String get twoFaAuthenticationTitle => 'التحقق بخطوتين';

  @override
  String get comment_disable_two_fa_section => '==== Disable 2FA Section ====';

  @override
  String get disableTwoFaTitle => 'التحقق بخطوتين';

  @override
  String get disableTwoFaInstructions =>
      'أدخل كلمة المرور لتعطيل التحقق بخطوتين';

  @override
  String get disableTwoFaPasswordEmpty => 'يرجى إدخال كلمة المرور';

  @override
  String get disableTwoFaDisableButton => 'تعطيل التحقق بخطوتين';

  @override
  String get comment_enable_two_fa_section => '==== Enable 2FA Section ====';

  @override
  String get enableTwoFaTitle => 'التحقق بخطوتين';

  @override
  String get enableTwoFaInstructions =>
      'امسح رمز QR بتطبيق Google Authenticator\nلتفعيل التحقق بخطوتين';

  @override
  String get enableTwoFaPinLabel => 'رمز PIN من تطبيق Google Authenticator';

  @override
  String get enableTwoFaPinEmpty => 'يرجى إدخال رمز التحقق من Google';

  @override
  String get enableTwoFaEnableButton => 'تفعيل التحقق بخطوتين';

  @override
  String get comment_generate_qr_code_section =>
      '==== Generate QR Code Section ====';

  @override
  String get generateQrCodeTitle => 'التحقق بخطوتين';

  @override
  String get generateQrCodeDescription =>
      'عزز أمان حسابك باستخدام التحقق بخطوتين';

  @override
  String get generateQrCodeGenerateButton => 'إنشاء رمز التحقق';

  @override
  String get comment_settings_screen => '==== Settings Screen ====';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsProfileSettings => 'إعدادات الملف الشخصي';

  @override
  String get settingsChangePassword => 'تغيير كلمة المرور';

  @override
  String get settingsTwoFaAuthentication => 'التحقق بخطوتين';

  @override
  String get settingsIdVerification => 'التحقق من الهوية';

  @override
  String get settingsSupport => 'الدعم';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsLanguageNotFound => 'اللغة غير موجودة';

  @override
  String get settingsLanguageSelectTitle => 'اختر اللغة';

  @override
  String get settingsBiometric => 'التحقق البيومتري';

  @override
  String get settingsLogout => 'تسجيل الخروج';

  @override
  String get comment_add_new_ticket_controller =>
      '==== Add New Ticket Controller Messages ====';

  @override
  String get addNewTicketTitleEmpty => 'يرجى إدخال العنوان';

  @override
  String get addNewTicketDescriptionEmpty => 'يرجى إدخال الوصف';

  @override
  String get addNewTicketGeneralError => 'حدث خطأ ما!';

  @override
  String get addNewTicketSuccess => 'تم إنشاء التذكرة بنجاح';

  @override
  String get comment_add_new_ticket_screen => '==== Add New Ticket Screen ====';

  @override
  String get addNewTicketTitle => 'إنشاء تذكرة';

  @override
  String get addNewTicketTitleHint => 'أدخل العنوان';

  @override
  String get addNewTicketDescriptionHint => 'الوصف';

  @override
  String get addNewTicketAttachments => 'المرفقات';

  @override
  String get addNewTicketAttachFile => 'إرفاق ملف';

  @override
  String get addNewTicketAddButton => 'إضافة تذكرة';

  @override
  String get comment_reply_ticket_screen => '==== Reply Ticket Screen ====';

  @override
  String get replyTicketCloseButton => 'إغلاق';

  @override
  String get replyTicketMessageEmpty => 'يرجى إدخال رسالة';

  @override
  String get replyTicketUnknownFile => 'ملف غير معروف';

  @override
  String get replyTicketAttachmentPreview => 'معاينة المرفق';

  @override
  String get replyTicketAttachments => 'المرفقات:';

  @override
  String get replyTicketTypeMessageHint => 'اكتب رسالتك';

  @override
  String get replyTicketSendButton => 'إرسال';

  @override
  String get comment_support_ticket_screen => '==== Support Ticket Screen ====';

  @override
  String get supportTicketTitle => 'تذكرة الدعم';

  @override
  String get supportTicketCreateTicketButton => 'إنشاء تذكرة';

  @override
  String get comment_transactions_screen => '==== Transactions Screen ====';

  @override
  String get transactionsTitle => 'المعاملات';

  @override
  String get comment_transaction_details_drop_down =>
      '==== Transaction Details Drop Down ====';

  @override
  String get transactionDetailsTitle => 'تفاصيل المعاملة';

  @override
  String get transactionDetailsWallet => 'المحفظة';

  @override
  String get transactionDetailsCharge => 'الرسوم';

  @override
  String get transactionDetailsTransactionId => 'رقم المعاملة';

  @override
  String get transactionDetailsMethod => 'الطريقة';

  @override
  String get transactionDetailsTotalAmount => 'المبلغ الإجمالي';

  @override
  String get transactionDetailsStatus => 'الحالة';

  @override
  String get transactionDetailsDescription => 'الوصف';

  @override
  String get comment_transaction_filter_bottom_sheet =>
      '==== Transaction Filter Bottom Sheet ====';

  @override
  String get transactionFilterTransactionIdHint => 'رقم المعاملة';

  @override
  String get transactionFilterSearchButton => 'بحث';

  @override
  String get comment_create_new_wallet_screen =>
      '==== Create New Wallet Screen ====';

  @override
  String get createNewWalletTitle => 'إنشاء محفظة جديدة';

  @override
  String get createNewWalletCurrencyHint => 'اختر العملة';

  @override
  String get createNewWalletCurrencyNotFound => 'العملة غير موجودة';

  @override
  String get createNewWalletCreateButton => 'إنشاء';

  @override
  String get createNewWalletCurrencyTitle => 'العملة';

  @override
  String get comment_delete_wallet_bottom_sheet =>
      '==== Delete Wallet Bottom Sheet ====';

  @override
  String get deleteWalletTitle => 'هل أنت متأكد؟';

  @override
  String get deleteWalletMessage => 'بمجرد حذف بياناتك، لن تتمكن من استرجاعها!';

  @override
  String get deleteWalletConfirmButton => 'تأكيد';

  @override
  String get comment_wallet_details_screen => '==== Wallet Details Screen ====';

  @override
  String get walletDetailsHistory => 'السجل';

  @override
  String get walletDetailsTopUp => 'شحن';

  @override
  String get walletDetailsWithdraw => 'سحب';

  @override
  String get walletDetailsWalletsNotFound => 'المحافظ غير موجودة';

  @override
  String get comment_wallets_screen => '==== Wallets Screen ====';

  @override
  String get walletsTitle => 'محافظي';

  @override
  String get walletsTopUp => 'شحن';

  @override
  String get walletsWithdraw => 'سحب';

  @override
  String get walletsDelete => 'حذف';

  @override
  String get comment_create_withdraw_account_controller =>
      '==== Create Withdraw Account Controller Messages ====';

  @override
  String get createWithdrawAccountWalletEmpty => 'يرجى اختيار محفظة';

  @override
  String get createWithdrawAccountMethodEmpty => 'يرجى اختيار طريقة سحب';

  @override
  String get createWithdrawAccountMethodNameEmpty => 'يرجى إدخال اسم الطريقة';

  @override
  String createWithdrawAccountFileRequired(Object fieldName) {
    return 'الملف مطلوب لـ $fieldName';
  }

  @override
  String createWithdrawAccountFieldRequired(Object fieldName) {
    return 'حقل $fieldName مطلوب';
  }

  @override
  String createWithdrawAccountFieldFill(Object fieldName) {
    return 'يرجى ملء حقل $fieldName';
  }

  @override
  String createWithdrawAccountFileUpload(Object fieldName) {
    return 'يرجى رفع ملف لـ $fieldName';
  }

  @override
  String get comment_withdraw_controller =>
      '==== Withdraw Controller Messages ====';

  @override
  String get withdrawAccountEmpty => 'يرجى اختيار حساب سحب';

  @override
  String get withdrawAmountEmpty => 'يرجى إدخال المبلغ';

  @override
  String withdrawAmountMinError(Object currency, Object minAmount) {
    return 'الحد الأدنى للمبلغ هو $minAmount $currency';
  }

  @override
  String withdrawAmountMaxError(Object currency, Object maxAmount) {
    return 'الحد الأقصى للمبلغ هو $maxAmount $currency';
  }

  @override
  String get comment_create_withdraw_account_screen =>
      '==== Create Withdraw Account Screen ====';

  @override
  String get createWithdrawAccountTitle => 'إنشاء حساب سحب';

  @override
  String get createWithdrawAccountSelectWalletLabel => 'اختر المحفظة';

  @override
  String get createWithdrawAccountSelectMethodLabel => 'اختر الطريقة';

  @override
  String get createWithdrawAccountWalletNotFound => 'المحفظة غير موجودة';

  @override
  String get createWithdrawAccountMethodNotFound => 'طريقة السحب غير موجودة';

  @override
  String get createWithdrawAccountMethodNameLabel => 'اسم الطريقة';

  @override
  String get createWithdrawAccountCreateButton => 'إنشاء';

  @override
  String get comment_edit_withdraw_account_screen =>
      '==== Edit Withdraw Account Screen ====';

  @override
  String get editWithdrawAccountTitle => 'تعديل حساب السحب';

  @override
  String get editWithdrawAccountMethodNameHint => 'اسم الطريقة';

  @override
  String get editWithdrawAccountUpdateButton => 'تحديث';

  @override
  String get comment_delete_account_dropdown_section =>
      '==== Delete Account Dropdown Section ====';

  @override
  String get deleteAccountTitle => 'هل أنت متأكد؟';

  @override
  String get deleteAccountMessage => 'هل تريد حذف هذا الحساب؟';

  @override
  String get deleteAccountConfirmButton => 'تأكيد';

  @override
  String get comment_withdraw_account_filter_bottom_sheet =>
      '==== Withdraw Account Filter Bottom Sheet ====';

  @override
  String get withdrawAccountFilterAccountNameHint => 'اسم الحساب';

  @override
  String get withdrawAccountFilterSearchButton => 'بحث';

  @override
  String get comment_withdraw_account_section =>
      '==== Withdraw Account Section ====';

  @override
  String get withdrawAccountSectionTitle => 'جميع الحسابات';

  @override
  String get comment_withdraw_amount_step_section =>
      '==== Withdraw Amount Step Section ====';

  @override
  String get withdrawAmountSelectAccountHint => 'اختر حساب السحب';

  @override
  String get withdrawAmountAmountHint => 'المبلغ';

  @override
  String get withdrawAmountContinueButton => 'متابعة';

  @override
  String withdrawAmountRangeMessage(Object currency, Object max, Object min) {
    return 'الحد الأدنى $min $currency والحد الأقصى $max $currency';
  }

  @override
  String get withdrawAccountTitle => 'حساب السحب';

  @override
  String get withdrawAccountNotFound => 'لا توجد حسابات سحب';

  @override
  String withdrawAccountCurrencySubtitle(Object currency) {
    return 'العملة: $currency';
  }

  @override
  String withdrawAccountMinMaxDescription(Object max, Object min) {
    return 'الحد الأدنى: $min | الحد الأقصى: $max';
  }

  @override
  String get comment_withdraw_pending_step_section =>
      '==== Withdraw Pending Step Section ====';

  @override
  String get withdrawPendingTitle => 'السحب قيد الانتظار';

  @override
  String get withdrawPendingSubtitle => 'أموالك قيد انتظار السحب.';

  @override
  String get withdrawPendingAmount => 'المبلغ';

  @override
  String get withdrawPendingTransactionId => 'رقم المعاملة';

  @override
  String get withdrawPendingCharge => 'الرسوم';

  @override
  String get withdrawPendingTransactionType => 'نوع المعاملة';

  @override
  String get withdrawPendingFinalAmount => 'المبلغ النهائي';

  @override
  String get withdrawPendingBackHomeButton => 'العودة للرئيسية';

  @override
  String get withdrawPendingAgainButton => 'مرة أخرى';

  @override
  String get comment_withdraw_review_step_section =>
      '==== Withdraw Review Step Section ====';

  @override
  String get withdrawReviewTitle => 'مراجعة التفاصيل';

  @override
  String get withdrawReviewAmount => 'المبلغ';

  @override
  String get withdrawReviewCharge => 'الرسوم';

  @override
  String get withdrawReviewTotal => 'الإجمالي';

  @override
  String get withdrawReviewWithdrawButton => 'سحب الآن';

  @override
  String get comment_withdraw_toggle_section =>
      '==== Withdraw Toggle Section ====';

  @override
  String get withdrawToggleWithdraw => 'سحب';

  @override
  String get withdrawToggleAccount => 'الحساب';

  @override
  String get comment_withdraw_screen => '==== Withdraw Screen ====';

  @override
  String get withdrawScreenTitle => 'سحب أموال';

  @override
  String get withdrawScreenAddAccountButton => 'إضافة حساب';

  @override
  String get comment_dynamic_attachment_preview =>
      '==== Dynamic Attachment Preview ====';

  @override
  String get dynamicAttachmentPreviewTitle => 'معاينة المرفق';

  @override
  String get comment_no_internet_connection =>
      '==== No Internet Connection Screen ====';

  @override
  String get noInternetTitle => 'لا يوجد اتصال بالإنترنت';

  @override
  String get noInternetMessage => 'يرجى التحقق من إعدادات الشبكة';

  @override
  String get noInternetRetryButton => 'إعادة المحاولة';

  @override
  String get comment_qr_scanner_screen => '==== QR Scanner Screen ====';

  @override
  String get qrScannerInstruction => 'ضع رمز QR داخل الإطار للمسح';

  @override
  String get qrScannerProcessing => 'جاري المعالجة...';

  @override
  String get comment_web_view_screen => '==== Web View Screen ====';

  @override
  String get webViewPaymentSuccess => 'تمت الدفعة بنجاح!';

  @override
  String get webViewPaymentFailed => 'فشلت الدفعة!';

  @override
  String get webViewPaymentCancelled => 'تم إلغاء الدفعة!';
}
