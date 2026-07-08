# Audit Report: ecardo_merchantapp_v1 (Merchant App)

> Repository: `/home/z/my-project/repos/ecardo_merchantapp_v1`
> Audit scope: Identity, Localization (for 5 target regions: CN, IR, TR, RU, AE), Fonts, Theme, Network, Architecture, Date/Currency, Country, Screens, Security, Performance, Build/CI, Deep Links, Push, Biometrics, Merchant-specific features, Region-specific gaps.

---

## Executive Summary

The repository is a Flutter (Dart 3.9.2 / Flutter 3.35.7) mobile-banking/fintech **merchant** app built on **GetX** for state, DI, and routing, on top of **Dio** for HTTP and **shared_preferences** for persistence. The codebase is well-structured (feature-first folders under `lib/src/presentation/screens/<feature>/{controller,model,view}`), has ~478 active translation keys for English + Arabic, and exposes a solid merchant feature set (wallets, transactions, exchange, withdraw, invoices with PDF, QR codes, API access keys, 2FA, KYC). However it is **incomplete on every dimension required for the 5 target regions**: it is still branded **`qunzo`** everywhere (Dart package `qunzo_merchant`, Android `com.qunzo.merchant`, iOS `com.qunzo.merchant`, Firebase project `qunzo-b2252`, app label "Qunzo Merchant", splash screen even renders "unzo" due to a bug); only `en` and `ar` locales are supported and a `_normalizeLocale()` whitelist **silently forces every other locale to English**; the bundled font **Plus Jakarta Sans has no glyph coverage** for Arabic/Persian/CJK/Cyrillic; the **release build is signed with the debug keystore**; tokens, FCM token, **and the user's plain-text password** (for biometric re-login) are stored in plaintext `SharedPreferences`; **no certificate pinning, no ProGuard/R8, no flavors, no dark theme, no deep links/app links, no HMS/JPush fallback for China**. Most issues are tractable in days-to-weeks of engineering work, but P0 items (release signing, plain-text password, qunzo→ecardo rebrand including Firebase project rename) must be fixed before any production rollout.

---

## 1. App Identity & Branding Issues

The app has **NOT been rebranded** from "qunzo" to "ecardo". Concrete leftover references:

| Layer | File | Value |
|---|---|---|
| Dart package name | `pubspec.yaml` (line 1) | `name: qunzo_merchant` |
| Dart imports | every single Dart file under `lib/` (~193 files) | `import 'package:qunzo_merchant/...'` |
| Root widget class | `lib/src/app/app.dart` (lines 12–17, 26) | `class QunzoMerchant` / `runApp(const QunzoMerchant())` |
| App label (Android) | `android/app/src/main/AndroidManifest.xml` (line 12) | `android:label="Qunzo Merchant"` |
| App label (iOS) | `ios/Runner/Info.plist` (lines 21, 29) | `CFBundleDisplayName` / `CFBundleName` = `Qunzo Merchant` |
| Static app name | `lib/src/app/constants/app_strings.dart` (line 3) | `static const appName = "Qunzo Merchant";` |
| Android applicationId / namespace | `android/app/build.gradle.kts` (lines 9, 24) | `com.qunzo.merchant` |
| Android Kotlin package | `android/app/src/main/kotlin/com/qunzo/merchant/MainActivity.kt` (line 1) | `package com.qunzo.merchant` |
| iOS bundle ID | `ios/Runner.xcodeproj/project.pbxproj` (lines 505, 689, 713) + `ios/Runner/GoogleService-Info.plist` (line 12) | `com.qunzo.merchant` |
| Firebase project ID | `lib/firebase_options.dart` (lines 45–55) + `android/app/google-services.json` + `ios/Runner/GoogleService-Info.plist` + `firebase.json` | `qunzo-b2252` |
| Firebase Android API key | `lib/firebase_options.dart` (line 42) + `google-services.json` | `AIzaSyBDecN3TGV6vDJPRbswbOKvrJ9dt7VkZUE` |
| Firebase iOS API key | `lib/firebase_options.dart` (line 50) + `GoogleService-Info.plist` | `AIzaSyDgFfu2VI5eHHsXsy_FlI0bXHy3-hzp6uo` |
| `google-services.json` | contains clients for `com.qunzo.agent`, `com.qunzo.merchant`, `com.qunzo.user` | ⚠️ leftover clients for sibling apps |

**Splash-screen rendering bug:** `lib/src/presentation/screens/auth/splash/view/splash_screen.dart` line 205 hard-codes `Text("unzo")` (missing the "Q"). Combined with `app_screen_icon.png` on the left, the user sees `<icon> unzo` instead of `<icon> Qunzo` or `<icon> ecardo`.

**Action required (P0):**
1. Rename Dart package via `change_app_package_name` (already a dev tool dep) or `pubspec.yaml` rename + `dart pub get` + IDE refactor of all imports.
2. Update Android `applicationId`/`namespace`, Kotlin package dir, iOS `PRODUCT_BUNDLE_IDENTIFIER`, `CFBundleDisplayName`/`CFBundleName`, `AppStrings.appName`, AndroidManifest `android:label`, splash "unzo" → "ecardo".
3. Create a **new** Firebase project (`ecardo-merchant` or similar) and re-run `flutterfire configure`; replace `firebase_options.dart`, `google-services.json`, `GoogleService-Info.plist`. The current Firebase project name `qunzo-b2252` is shared with `qunzo.agent` and `qunzo.user` clients — that is a leak across the three apps and must not ship.
4. Replace launcher icons (`assets/logos/app_icon.png` is the source for `flutter_launcher_icons`) and in-app logos (`app_icon.png`, `app_logo.png`, `app_screen_icon.png`).
5. Audit Lottie/JSON, splash frame PNG, home header frame PNG, profile frame PNG, withdraw success frame/shape, etc. — they likely contain "Qunzo" baked into the artwork.

---

## 2. Localization Status

### 2.1 Existing ARB files (`lib/l10n/`)

| File | Lines | Active keys (excluding `comment_*`) | Total entries |
|---|---|---|---|
| `app_en.arb` | 650 | **478** | 560 (incl. 82 `comment_*` placeholders) |
| `app_ar.arb` | 650 | **478** | 560 |

- `l10n.yaml` is correctly configured (`arb-dir: lib/l10n`, `template-arb-file: app_en.arb`, `output-localization-file: app_localizations.dart`).
- Generated files exist: `app_localizations.dart` (3,534 lines), `app_localizations_en.dart` (1,835 lines), `app_localizations_ar.dart` (1,822 lines). Generation was performed; nothing is out of date.
- No `app_fa.arb`, `app_zh.arb`, `app_tr.arb`, `app_ru.arb` exist.

### 2.2 supportedLocales list

`lib/src/app/app.dart` line 79:
```dart
supportedLocales: const [Locale('en'), Locale('ar')],
```
`lib/l10n/app_localizations.dart` lines 96–99 (generated):
```dart
static const List<Locale> supportedLocales = <Locale>[
  Locale('ar'),
  Locale('en'),
];
```

### 2.3 The `_normalizeLocale` whitelist bug (P0 for non-EN/AR users)

`lib/src/app/app.dart` lines 22–33:
```dart
Locale _normalizeLocale(String? localeCode) {
  if (localeCode == null || localeCode.isEmpty) return const Locale('en');
  final normalizedCode = localeCode
      .replaceAll('-', '_')
      .split('_')
      .first
      .toLowerCase();
  if (normalizedCode == 'ar') return const Locale('ar');
  return const Locale('en');   // ← everything else silently falls back to English
}
```

This is wired into **both** `localeResolutionCallback` (line 70) and the saved-locale loader (line 48). Net effect: **on first launch on a Persian / Chinese / Turkish / Russian device the app forces English**, and even if the backend returns `language_switcher=1`, the in-app picker (profile_screen.dart lines 179–182) only offers `["English", "Arabic"]` — there is no way for a user to pick fa/zh/tr/ru.

The `HomeController.changeLanguage()` (home_controller.dart lines 84–106) also hard-codes only the `English`/`Arabic` branches; everything else defaults to `en`.

### 2.4 Dynamic language loading via API

- `SettingsService.fetchSettings()` (settings_service.dart lines 146–170) calls `GET /get-settings` and stores a flat `RxMap<String,String> appSettings`. The keys observed in use:
  - `language_switcher` (gates the UI picker in `profile_screen.dart` and `home_controller.dart`)
  - `email_verification`, `fa_verification`, `referral_bonus`, `site_currency`, `site_currency_decimals`
- There is **no endpoint that returns a list of supported languages or remote ARB translations**. The set of available languages is hard-coded to `en`/`ar`. Even if backend `language_switcher=1` is enabled, the front-end can only show two languages. Any additional language requires a new app build.

### 2.5 RTL handling

Sparse but present. Only 6 files explicitly handle RTL:
- `lib/src/app/navigation/navigation_screen.dart` (line 43, 87)
- `lib/src/common/widgets/app_bar/common_app_bar.dart` (lines 30, 55 — `flipX: isRtl` on icons)
- `lib/src/common/widgets/dropdown_bottom_sheet/image_picker_dropdown_bottom_sheet.dart`
- `lib/src/presentation/screens/profile/view/profile_screen.dart` (line 56, 220)
- `lib/src/presentation/screens/profile_settings/view/profile_settings_screen.dart` (line 282, 358)
- OTP fields in `forgot_password_pin_verification.dart` (line 113) and `verify_email_screen.dart` (line 136) force `TextDirection.ltr` (correct for digits).

The codebase relies on Flutter's `Directionality` propagation (which works for `Locale('ar')` → RTL), but no widget-level tests verify Arabic layout. Many screen layouts use `Row` with hard-coded `EdgeInsetsDirectional` so they will mirror correctly — but several use plain `EdgeInsets.symmetric(horizontal: ...)` and `Row(children: [icon, text])` without `Directionality` awareness, which will cause visual glitches when more RTL languages (Persian, Urdu, Hebrew) are added.

### 2.6 iOS Info.plist localization gap

`ios/Runner/Info.plist` has **no `CFBundleLocalizations`** key. Without it, iOS does not know the app supports Arabic — App Store metadata and per-language system prompts will not be available. Also `CFBundleDevelopmentRegion` is `$(DEVELOPMENT_LANGUAGE)` (Xcode default = `en`).

### 2.7 Sample 30 translation keys (coverage map)

Maintenance, splash, navigation, image_picker, biometric_auth, network_service, api_access_key, forgot_password, reset_password, pin_verification, login, two_factor_auth, auth_id_verification, email screen, personal_info, set_up_password, sign_up_status, verify_email, welcome, change_password, exchange (controller + screen + amount/review/success sections), home (controller, drawer, header, navigator, transactions, wallets, transaction_details, settings_bottom_sheet), kyc (details, history, id_verification), create_invoice (controller, screen, add_item, information, pdf), update_invoice (screen, add_item, information), invoice_details, invoice_screen, notification, profile, profile_settings, qr_code, add_new_ticket, replay_ticket, support_ticket, transaction_filter, transactions_screen, two_fa_authentication (disable/enable/generate_qr), create_new_wallet, delete_wallet, wallet_details, wallets_screen, create_withdraw_account (controller, screen), edit_withdraw_account, withdraw (controller, screen, account_filter, account_section, amount_step, review_step, success_step, toggle_section, delete_account_dropdown), dynamic_attachment_preview, no_internet_connection, web_view.

Coverage is broad for **merchant UX strings** but **absent** for:
- Anything that would be specific to a region (no strings for "Jalali date picker", "Persian digits", "Iranian Sheba/IBAN", "WeChat Pay", "Alipay", "YooMoney", "Mir", "iyzico", "PayTabs", "Network International", "HMS Push", "JPush", etc.).
- Many API error messages from the server are shown verbatim via `ToastHelper().showErrorToast(errorMessages)` in `network_service.dart` — those are NOT localized through ARB; they need a translation layer on either backend or client.

---

## 3. Fonts & Typography

### 3.1 Bundled fonts (`assets/fonts/`)

Five weights of **Plus Jakarta Sans** only:
- `PlusJakartaSans-VariableFont_wght.ttf`
- `PlusJakartaSans-Medium.ttf` (weight 500)
- `PlusJakartaSans-SemiBold.ttf` (weight 600)
- `PlusJakartaSans-Bold.ttf` (weight 700)
- `PlusJakartaSans-ExtraBold.ttf` (weight 900)

### 3.2 Theme binding

`lib/src/app/config/theme/light_thtme.dart` (note the filename typo **"light_thtme.dart"**):
```dart
ThemeData lightTheme(context) => ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightBackground,
  fontFamily: "Plus Jakarta Sans",
);
```
No `ThemeData.darkTheme`, no `theme:` per-route overrides. The `fontFamily` is set globally — every `Text()` widget inherits "Plus Jakarta Sans".

### 3.3 Glyph-coverage gaps (CRITICAL for 5-region launch)

Plus Jakarta Sans is a Latin-only family. It has **no glyphs for**:
- **Arabic** (`ar`) — currently shipping, will render as `.notdef` tofu boxes (no Arabic glyphs!)
- **Persian** (`fa`) — same as Arabic plus extra Persian letters (پ چ ژ گ ک ی)
- **Chinese** (`zh`) — CJK ideographs not present
- **Russian** (`ru`) — Cyrillic not present (Plus Jakarta Sans actually has limited Cyrillic; verify before relying on it)
- **Turkish** (`tr`) — Latin with dotted/undotted i; generally OK with Plus Jakarta Sans but verify glyph ı/İ.

The current ARB file `app_ar.arb` **already has full Arabic text** but the bundled font will render it as tofu or fall back to a system font. This is a P0 — the Arabic translation is shipping but currently broken on some Android devices and unstyled on iOS.

### 3.4 PDF font

`lib/src/presentation/screens/invoice/view/invoice_details/sub_sections/invoice_pdf.dart` uses `pw.Document()` from the `pdf` package with **no `Theme(defaultTextStyle: ...)` and no `pw.Font.ttf(...)` registered**. The `pdf` package falls back to Helvetica (WinAnsi). Consequence: **any invoice PDF generated on a device in Arabic (or future fa/zh/ru) will render localized text as blank/tofu boxes**. This must be fixed before any non-English merchant can use invoice printing.

### 3.5 Recommended font stack

| Region | Font | License |
|---|---|---|
| Latin (en/tr) | Plus Jakarta Sans (already bundled) | SIL OFL |
| Arabic (ar) | Noto Sans Arabic or IBM Plex Sans Arabic | SIL OFL |
| Persian (fa) | **Vazirmatn** (preferred for Iran) or Noto Naskh Arabic | SIL OFL / OFL |
| Chinese (zh) | **Noto Sans SC** (Simplified) + Noto Sans TC (Traditional) | SIL OFL |
| Russian (ru) | Plus Jakarta Sans actually has Cyrillic in newer releases; otherwise Noto Sans | SIL OFL |
| Turkish (tr) | Plus Jakarta Sans (OK) | — |

For the PDF generator: register `pw.Font.ttf(ByteData)` for each script and switch fonts based on the invoice locale.

---

## 4. Theme

- Single theme file: `lib/src/app/config/theme/light_thtme.dart` (10 lines). **Filename has a typo** ("thtme") that has propagated into `app.dart` line 6 — fix on rename.
- **No dark theme** even though `assets/icons/png/common/dark_moon_common_icon.png` and `dark_moon_common_icon.png` exist (suggesting dark mode was once planned). `app.dart` line 64 hard-codes `themeMode: ThemeMode.light`.
- Palette (`lib/src/app/constants/app_colors.dart`): `lightBackground=#F8F8F8`, `lightPrimary=#4CD080` (the brand green), text colors, plus `error/warning/success/white/black/transparent`. That's it — no secondary/tertiary, no surface variants, no semantic colors for transaction types. Transaction colors are hardcoded per-widget (`transactions_dynamic_color.dart`, `notification_dynamic_color.dart`).
- `android/app/src/main/res/values-night/styles.xml` exists (so the Android launch screen respects dark mode) but the Flutter app itself ignores `ThemeMode.dark` — visually jarring handoff.
- No `ThemeController` / no `Get.isDarkMode` / no `GetX` `ThemeService`. Adding dark mode would require (a) writing `dark_theme.dart`, (b) exposing a `ThemeController` Rx<ThemeMode>, (c) wiring it into `GetMaterialApp`, (d) updating every widget that reads `AppColors.lightXxx` directly (most of them).

---

## 5. Network Layer

### 5.1 `lib/src/network/service/network_service.dart` (Dio)

- Two Dio instances: `_dio` (secured, adds Bearer token) and `_globalDio` (no auth, for public endpoints like `/get-settings`, `/get-countries`, `/get-register-fields/merchant`).
- `baseUrl` = `https://ecardo.ir/api` (hard-coded in `ApiPath.baseUrl`, `lib/src/network/api/api_path.dart` line 4). **Single environment — no dev/staging/prod switch.**
- **No `connectTimeout` / `receiveTimeout` / `sendTimeout` set.** Dio defaults are `0` (infinite) for connect/receive, which means a hung server can freeze the app forever. The error handler at line 320–325 catches `DioExceptionType.connectionTimeout` and `receiveTimeout` but those will never fire with current config.
- **No certificate pinning.** No `IOHttpClientAdapter`/`SecurityContext`/`BadCertificateCallback` override either — Dio uses the system trust store, which is fine for normal TLS but offers no MITM protection. For a fintech app this is a P1.
- **No retry interceptor.** A single failed request is final.
- **No cache interceptor** (no `dio_cache_interceptor` package).
- **Logging interceptor is hand-rolled** — `_log()` writes via `debugPrint` gated by `kDebugMode`. Acceptable, but no structured logging, no Sentry/Crashlytics integration, no request ID.
- **Auth interceptor** (lines 60–80): adds `Authorization: Bearer <token>` if present. On 401 it just logs "Unauthorized. Please login again." — the actual redirect-to-login logic is in `_handleDioErrorResponse` (case 401, lines 372–447) which pops up a dialog and routes to `BaseRoute.login`. There is **no token refresh** mechanism; once a token expires the user is forced to log in again. For a merchant app that's borderline acceptable but annoying.
- The `login()` method (lines 85–123) **clears the interceptor list** (`_dio.interceptors.clear()`) before the call and re-adds them after — this is to avoid sending the old Bearer token during login. It works but is fragile: any concurrent request fired during the login window will also lose its interceptor.
- Error responses: server `message` string from JSON is passed verbatim to `ToastHelper().showErrorToast()`. Not localized client-side.

### 5.2 `lib/src/network/service/token_service.dart`

- Uses `shared_preferences` — **plain text on disk**, readable via `adb shell run-as` on debuggable builds, or via backup extraction. For fintech this is a **P0**; should be `flutter_secure_storage` (Keystore on Android, Keychain on iOS).
- Only stores `access_token`. No refresh token, no expiry, no scope.

### 5.3 Base URL / environments

| Setting | Value |
|---|---|
| `baseUrl` | `https://ecardo.ir/api` (production) |
| Dev/staging/prod switch | ❌ none |
| Flavors | ❌ none |
| `--dart-define` usage | ❌ none |

Hard-coded prod URL means every developer and CI build hits production.

### 5.4 Endpoints (`lib/src/network/api/api_path.dart`)

Complete API surface (good documentation):
- Settings, countries, profile, terms, FCM setup, currency converter
- Auth: `/auth/merchant/{login,register,forgot-password,reset-verify-otp,reset-password,2fa/verify,logout,send-verify-email,validate-verify-email,personal-info-update}`
- Registration fields: `/get-register-fields/merchant`, KYC rejected-data: `/merchant/kyc/rejected-data`
- Wallets: `/merchant/wallets`, currencies: `/get-currencies`
- Transactions: `/merchant/transactions`
- Notifications: `/get-notifications`, `/mark-as-read-notification`
- QR: `/merchant/qrcode`
- API access keys: `/merchant/access-keys`, `/merchant/access-keys/regenerate`
- Change password, profile update, support tickets, withdraw (+ methods), KYC (+ history), 2FA (generate/enable/disable), exchange (config/wallet/history), invoices.

---

## 6. State Management & Architecture

### 6.1 Pattern

- **GetX 4.7.2** is used uniformly for: state (`.obs`/`Rx`/`Obx`), dependency injection (`Get.put`, `Get.lazyPut`, `Get.find`), routing (`GetMaterialApp`, `Get.toNamed`, `Get.offAllNamed`), and i18n (`Get.updateLocale`, `Get.deviceLocale`).
- Bindings: `lib/src/app/bindings/app_bindings.dart` (~314 lines, one Binding class per feature) + `lib/src/app/bindings/initial_binding.dart` (registers `TokenService`, `SettingsService`, `NetworkService` at app start). Note: `InitialBinding` is defined but **never wired** into `GetMaterialApp.initialBinding` (see `app.dart` line 61 — no `initialBinding:` argument). Instead, `main.dart` line 29–39 manually `Get.put`s the same services. Functionally equivalent but redundant.
- Folder convention: `lib/src/presentation/screens/<feature>/{controller,model,view}` — strictly enforced. 76 view files (incl. sub_sections), 37 controllers, 17 models under `screens/`. Plus 5 common controllers, 5 common models, 4 common services, 14 common widgets, 10 presentation widgets.
- Routes: `routes.dart` (string constants), `routes_config.dart` (widget factory), `routes_handler.dart` (GetPage → binding wiring). 33 distinct routes + 2 system routes (noInternet, maintenance).
- Routing inconsistency: `BaseRoute.idVerification` is registered **twice** in `routes_handler.dart` (lines 107–111 and 177–181) — second registration silently overrides the first. Not a bug today (same binding) but a code smell.

### 6.2 Sample: `home_controller.dart`

`HomeController` (268 lines) is the main post-login controller. It:
- Holds `walletsModel`, `transactionsModel`, `language`, `isBiometricEnable`, `selectedIndex`, `selectedDrawerIndex`, `currentWalletIndex`.
- Calls `loadData()` on init which (1) reads `language_switcher` setting, (2) sets initial language, (3) fetches user profile, (4) fetches wallets, (5) fetches transactions.
- `changeLanguage(String)` only knows "English" and "Arabic" — adding `fa/zh/tr/ru` requires editing this method (and the picker in `profile_screen.dart`).
- Uses `WidgetsBinding.instance.addPostFrameCallback` for navigation in error handlers (correct pattern).

### 6.3 Sample: `qr_code_screen.dart`

The QR screen renders an SVG returned by the API (`/merchant/qrcode`) via `SvgPicture.string(controller.qrCodeModel.value.data)`. Downloading the QR uses `Permission.manageExternalStorage.request()` and writes to `/storage/emulated/0/Download/qr_code_<ts>.png` — this is the **deprecated MANAGE_EXTERNAL_STORAGE** permission, which Google Play restricts to file managers / antivirus apps. The merchant app will likely **fail Play Store review** or require a policy exception. Use the MediaStore API via `path_provider` + `saf_util` or the `gal` package.

### 6.4 Sample: `api_access_key_controller.dart`

Straightforward: GET `/merchant/access-keys`, POST `/merchant/access-keys/regenerate`. Public + secret keys displayed in read-only TextFields with copy buttons. **Issue:** keys are displayed in plain text with no reveal/hide toggle and no copy-to-clipboard audit log. A shoulder-surfer can read the secret key.

---

## 7. Date/Time, Currency, Number Formatting

### 7.1 `intl` package usage

`intl: ^0.20.2` is declared. It's used in 14+ files. Patterns observed:

| File | Pattern |
|---|---|
| `common_single_date_picker.dart` | `DateFormat("dd/MM/yyyy")` |
| `kyc_history.dart` | `DateFormat("dd MMM yyyy hh:mm a")` |
| `kyc_history_bottom_sheet.dart` | (date format) |
| `home_transaction_details.dart` | **`NumberFormat.currency(symbol: '', decimalDigits: decimals, name: '')`** |
| `profile_settings_screen.dart` | `DateFormat(...)` (display), `DateFormat("dd/MM/yyyy").parse(...)` (input) |
| `profile_settings_controller.dart` | `DateFormat("yyyy-MM-dd").format(DateFormat("dd/MM/yyyy").parse(...))` |
| `support_ticket_screen.dart` | `DateFormat("dd MMM,yyyy - hh:mm a")` |
| `reply_ticket.dart` | `intl.DateFormat(...)` (twice) |
| `create_invoice.dart` / `create_invoice_information_section.dart` | `DateFormat("yyyy-MM-dd").format(...)` (issue date) |
| `invoice_screen.dart` | `DateFormat("dd MMM yyyy")` |
| `update_invoice_information_section.dart` | `DateFormat("yyyy-MM-dd")` |
| `invoice_details.dart` | `DateFormat("dd MMM yyyy")` |
| `invoice_pdf.dart` | `DateFormat("dd MMM yyyy")` |

**Every `DateFormat` and `NumberFormat` is constructed without a locale argument.** That means:
- Month names will always be English (`Jan`, `Feb`, …) even when the app is Arabic.
- Number digits will always be Latin ASCII even in Persian/Arabic locales.
- No Hijri / Jalali calendar support whatsoever.

### 7.2 `lib/src/helper/dynamic_decimals_helper.dart`

A 16-line helper that picks decimal precision (2 for fiat, 8 for crypto, or `site_currency_decimals` from settings). It does NOT format numbers — it just returns an `int` that callers pass to `toStringAsFixed()` or `NumberFormat.currency(decimalDigits: …)`. Acceptable but primitive.

### 7.3 Persian/Jalali support

- ❌ No `shamsi_date`, `jalali_calendar`, `persian_datetime_picker`, or `flutter_localizations` `fa` locale delegate.
- ❌ No Persian-digit conversion (no `\u06F0`–`\u06F9` mapping).
- ❌ The bundled `flutter_rounded_date_picker` package does not support Jalali calendar; Persian merchants will see a Gregorian picker.

### 7.4 Currency

- `site_currency` and `site_currency_decimals` come from `/get-settings`. Many widgets read them via `Get.find<SettingsService>().getSetting("site_currency")!` — the `!` is risky; if the settings call fails the app will null-deref crash. Already noted in invoice_pdf.dart line 25–29.
- `NumberFormat.currency(symbol: '')` is used so the symbol is appended manually as `<amount> <currencyCode>` (e.g. `"100.00 USD"`). There's no localized symbol mapping (no `€`, no `¥`, no `﷼`/`تومان`).

---

## 8. Country/Region Handling

### 8.1 Models and controllers

- `lib/src/common/model/country_model.dart`: `CountryData{name, dialCode, code, flag, selected}`. Standard flat structure.
- `lib/src/common/controller/country_controller.dart`: fetches `/get-countries`, stores `RxList<CountryData> countryList`.
- The list comes from the backend; the client does NOT filter to the 5 target regions. The merchant's country is selected **at registration** (`personal_info_screen.dart` lines 64–87) — backend returns one country with `selected: true` (presumably geo-IP based) and the client pre-selects it.

### 8.2 Phone-number handling

- `personal_info_screen.dart` line 85: when a country is picked, the dial code is **prefilled into `phoneNoController.text`** as plain text (e.g. `"+98"`). The user then types the rest of the number directly after the dial code in the same TextField. There is no validation, no `libphonenumber` integration, no country-aware formatting, no separate dial-code display.
- `merchant_phone_show` and `merchant_phone_validation` toggles come from `/get-register-fields/merchant` and gate whether the field is shown/required.

### 8.3 Region detection

There is **no client-side region detection**. Country is whatever the backend returns as `selected: true`. The client does not read SIM ISO, device locale, or GPS.

---

## 9. Screens Inventory

Total screen view files (top-level `*_screen.dart` and equivalents under `view/`): **37**
Total view dart files (including `sub_sections/`): **76**
Total controllers: **37** (under `screens/`) + **5** common = 42
Total models: **17** (under `screens/`) + **5** common = 22

### Grouped by feature

| Feature | Screens | Notes |
|---|---|---|
| **Auth** | splash, welcome, login (with 2FA sub-screen), forgot_password, pin_verification, reset_password, email (register step 1), verify_email, set_up_password, personal_info, auth_id_verification (5 sub-sections: camera/file/front_camera/back_camera/kyc_submission), sign_up_status | Multi-step registration wizard driven by `registerFields` API |
| **Home / Dashboard** | home_screen + sub_sections: header, wallets, transactions, transaction_details, drawer, settings_bottom_sheet, home_section_navigator, home_skeleton_loader | Skeleton loader (Shimmer) only on home |
| **Wallets** | wallets_screen, create_new_wallet, wallet_details, delete_wallet_bottom_sheet | Multi-currency wallets |
| **Transactions** | transactions_screen, transaction_filter_bottom_sheet, transaction_type_list | **Pagination implemented** (ScrollController + `loadMoreTransactions`) |
| **Invoice (merchant-specific)** | invoice_screen (list, paginated), create_invoice (+ add_item, information), update_invoice (+ add_item, information), invoice_details (+ invoice_pdf) | PDF generation via `pdf` + `printing`; share via `share_plus` |
| **API Access Keys (merchant-specific)** | api_access_key_screen | View/copy/regenerate public+secret keys |
| **QR Code (merchant-specific)** | qr_code_screen | Server-generated SVG QR for merchant ID |
| **Exchange** | exchange_screen + amount/review/success step sections | Multi-step wizard |
| **Withdraw** | withdraw_screen + 8 sub_sections (account, amount, review, success, toggle, account_filter, delete_account_dropdown, withdraw_section) + create_withdraw_account, edit_withdraw_account | Most complex screen in the app |
| **KYC / ID Verification** | id_verification_screen, kyc_history, kyc_history_bottom_sheet | Status states (pending/approved/rejected) |
| **2FA Authentication** | two_fa_authentication + 3 sub_sections (generate_qr, enable, disable) | TOTP via Google Authenticator |
| **Notifications** | notification_screen | Merchant-specific notification icons (payment, ticket reply, withdraw approved/rejected) |
| **Support Ticket** | support_ticket_screen, add_new_ticket, reply_ticket | Attachments supported |
| **Profile** | profile_screen (with language picker, biometric toggle), profile_settings_screen |  |
| **Change Password** | change_password_screen |  |
| **System** | no_internet_connection, maintenance_mode, web_view_screen (for payment gateway redirects) | WebView parses `/success` and `/cancel` URLs by reading `document.body.innerText` and JSON-decoding — fragile |

### Major merchant flows

1. **Onboarding**: splash → welcome → email → verify_email → set_up_password → personal_info → auth_id_verification (KYC) → sign_up_status → navigation.
2. **Daily use**: home dashboard (wallets + recent transactions) → drawer → wallets/withdraw/exchange/invoice/qr/api_access_key/transactions/notifications/support_ticket.
3. **Invoice**: create (with line items) → list → details → share payment link / open WebView payment / print PDF.
4. **Withdraw**: select wallet → select withdraw account (or create) → enter amount → review → submit → success receipt.

### Settlement/reconciliation reports

❌ **None**. There is no settlement report screen, no reconciliation export, no CSV/PDF statement download. For a merchant app this is a feature gap.

### Staff / sub-account management

❌ **None**. Only one merchant account per login. No role-based access, no staff invites, no permission scoping.

---

## 10. Security Audit

| Check | Status | Detail |
|---|---|---|
| Token storage | ❌ **INSECURE** | `TokenService` uses `shared_preferences` (plaintext XML on Android, plist on iOS). Should be `flutter_secure_storage`. |
| User password storage | ❌ **CRITICAL** | `SettingsService.saveLoggedInUserPassword()` (settings_service.dart line 68–72) stores the user's **plaintext password** in `shared_preferences` so biometric re-login can re-POST it to `/auth/merchant/login` (login_controller.dart lines 130–138). Anyone with file-system access (rooted Android, jailbroken iOS, backup extraction) gets the password. |
| FCM token storage | ⚠️ | Stored in `shared_preferences` (`current_fcm_token` key). Less sensitive but should be in secure storage. |
| Login state, email, biometric toggle | ⚠️ | All in `shared_preferences`. Low-sensitivity but still better in secure storage. |
| Certificate pinning | ❌ | None. Plain Dio with system trust store. |
| Release signing | ❌ **CRITICAL** | `android/app/build.gradle.kts` line 31–34: `release { signingConfig = signingConfigs.getByName("debug") }`. Release APK is signed with the debug keystore — Google Play will reject, and any APK published elsewhere is trivially forgeable. |
| ProGuard / R8 | ❌ | No `proguard-rules.pro` file exists; `minifyEnabled` and `shrinkResources` not set. APK ships with full symbols. |
| `usesCleartextTraffic` / `networkSecurityConfig` | ⚠️ | Not set in AndroidManifest. Defaults to `false` on Android 9+ (good), but no explicit `network_security_config.xml` for stricter pinning. |
| API key exposure in `firebase_options.dart` | ⚠️ | Firebase Android & iOS API keys are committed to the repo. Firebase API keys are by design public-facing (restricted by SHA-1 / bundle ID) but still better kept out of source via `--dart-define`. |
| Per- environment config | ❌ | Single `https://ecardo.ir/api` URL in `api_path.dart` line 4. No flavors, no `--dart-define`. |
| SSL/TLS | ⚠️ | Default Dio = system trust store, TLS 1.2+. No issue per se but no defense in depth. |
| API access key handling | ⚠️ | `ApiAccessKeyScreen` displays the secret key in a read-only TextField with no reveal/hide toggle. Anyone glancing at the screen sees the full secret. Copy-to-clipboard is not audited. Should be masked by default with a "reveal" button (which would itself trigger a 2FA prompt ideally). |
| 2FA / TOTP | ✅ | Properly implemented via QR + Google Authenticator pattern (two_fa_authentication flow). |
| Biometric gate | ⚠️ | Biometric is **optional** and gated by `isBiometricEnable` toggle in profile screen. There is **no biometric gate enforced on app launch** — a user with biometric enabled can still skip it; and if biometric is disabled, the app opens straight to home after splash. For a fintech app, biometric should be a hard gate on every cold start (and configurable as required by backend `force_biometric` setting). |
| WebView JavaScript | ⚠️ | `WebViewScreen` uses `JavaScriptMode.unrestricted` and parses `document.body.innerText` as JSON. Acceptable for a trusted payment gateway but ensure the URL is always `https://ecardo.ir/...` and not user-controllable. |
| Image picker / camera permissions | ✅ | Properly declared; `permission_handler` used. |
| `MANAGE_EXTERNAL_STORAGE` permission | ❌ | Declared in `AndroidManifest.xml` line 8 (`android.permission.MANAGE_EXTERNAL_STORAGE`) and requested in `qr_code_screen.dart` line 124. This permission is **restricted by Google Play**; the app will be rejected or require a policy exception. Replace with `path_provider` + MediaStore. |
| `READ/WRITE_EXTERNAL_STORAGE` | ⚠️ | Declared but deprecated on Android 13+; should target `READ_MEDIA_IMAGES` etc. |
| Hard-coded `kDebugMode` logs | ⚠️ | Network service logs request bodies (including password) in debug builds. Fine for development, but make sure release builds strip these (the `if (kDebugMode)` guard does that, but verify no `print()` slipped through). |
| Token clearing on logout | ✅ | `submitLogout()` calls `TokenService.clearToken()` and navigates to login. |
| Session timeout / idle lock | ❌ | None. Once logged in, the session stays alive until the token is rejected by the server. |

---

## 11. Performance Audit

| Check | Status | Detail |
|---|---|---|
| Image format | ⚠️ | **101 PNG icons** under `assets/icons/png/`, only **10 SVG** under `assets/icons/svg/`. Plus 28 more PNGs (logos, frames, shapes, wallet images, avatars, welcome illustration). Total **~129 PNGs**. Should migrate icon PNGs → SVG (or `.webp`) to cut APK size dramatically. Current PNG icons are typically 2-4 KB each but at 101 files that's ~200–400 KB of icons that could be ~30 KB as SVG. |
| Image caching | ❌ | `cached_network_image` package is **NOT** in `pubspec.yaml`. The app uses raw `Image.network(...)` in 9 places (wallet avatars, KYC images, profile avatar, support ticket attachments, withdraw account images, dropdown wallet icons). Every navigation re-downloads. |
| Shimmer / skeleton loaders | ⚠️ | Only **1** skeleton loader (`home_skeleton_loader.dart`). Other long-loading screens show a generic `CommonLoading()` spinner. |
| Lazy loading on long lists | ⚠️ | `transactions_screen.dart` implements pagination via `ScrollController` (good). `invoice_screen.dart` also paginated (good). `wallets_screen`, `notification_screen`, `support_ticket_screen`, `kyc_history` are **not paginated**. |
| HTTP cache | ❌ | No `dio_cache_interceptor`. Public GET endpoints (`/get-settings`, `/get-countries`, `/get-currencies`) are re-fetched every cold start. |
| Deferred components / dynamic feature modules | ❌ | None. Single APK. For a 5-region app with multiple font families and locale packs, consider Play Asset Delivery or deferred components. |
| Code splitting | ❌ | No `deferred as` imports. |
| Heavy operations on main thread | ⚠️ | PDF generation (`pdf` package) is synchronous on the UI isolate — `InvoicePDF.generate()` returns a `Future<Uint8List>` but the work is CPU-bound; for large invoices it will jank. Consider `compute()` or `flutter_isolate`. |
| Image picker / camera | ✅ | `image_picker` + `camerawesome` used. |
| `flutter_screenutil` | ✅ | Design size `Size(376, 812)` (iPhone 13 mini-ish). `minTextAdapt: true`. |
| Lottie animation | ✅ | One Lottie file (`wifi_connect.json`) used in `no_internet_connection`. |
| Animation controllers | ⚠️ | Splash screen creates **4 AnimationControllers** (logo, text, background, merchant) — fine, but verify they're all disposed (they are, in `splash_screen.dart` line 149–155). |
| `kotlin.incremental=false` | ⚠️ | `android/gradle.properties` line 4 — Kotlin incremental compilation disabled. Slower clean builds, no benefit to release builds. |
| JVM args | ⚠️ | `-Xmx8G -XX:MaxMetaspaceSize=4G` — very aggressive; will OOM smaller CI machines. |
| `enableJetifier=true` | ⚠️ | Still enabled. Should be disabled once all Android deps migrate to AndroidX (most are). |

---

## 12. Build & CI/CD

### 12.1 Flavors / build variants

❌ **None.** Single `release` build type signed with debug keystore (see §10). No `productFlavors` block, no `dev`/`staging`/`prod` separation.

### 12.2 Environment separation

❌ **None.** Hard-coded `https://ecardo.ir/api` in `api_path.dart`. No `--dart-define=BASE_URL=...` usage.

### 12.3 CI/CD

- `.github/workflows/flutter.yml` (39 lines): on push to `main` or workflow_dispatch, builds a release APK with Flutter 3.44.0 on Ubuntu, uploads as artifact.
- ❌ No iOS build job.
- ❌ No test job (`flutter test` is never run — and there are **zero test files** in the repo).
- ❌ No lint job (`flutter analyze` not run in CI).
- ❌ No version bumping, no Play Store upload, no TestFlight upload.
- ❌ No fastlane, no codemagic.yaml.

### 12.4 Versioning

`pubspec.yaml` line 5: `version: 1.0.0+1`. Not bumped in CI. `versionCode = flutter.versionCode` and `versionName = flutter.versionName` in `build.gradle.kts` — fine but requires manual pubspec edits.

### 12.5 Flutter / Dart versions

- `pubspec.yaml`: `sdk: ^3.9.2`, comment says Flutter 3.35.7, Dart 3.9.2.
- CI uses Flutter 3.44.0 (mismatch — pubspec says 3.35.7, CI installs 3.44.0). Not a hard error since `^3.9.2` is a Dart SDK constraint, but the comment is misleading.
- Gradle 8.11.1, AGP 8.9.1, Kotlin 2.1.0, compileSdk 36, minSdk 24, NDK 27.0.12077973.

---

## 13. Deep Links / App Links

### 13.1 Android

❌ **No `<intent-filter>` with `<data android:scheme="..."/>`** in `AndroidManifest.xml`. The only intent-filter is the standard LAUNCHER one. No `autoVerify="true"` app links.

### 13.2 iOS

❌ No associated domains entitlement in `Runner.entitlements` (only `aps-environment`). No `CFBundleURLTypes` in `Info.plist`.

### 13.3 Consequence for merchants

- The invoice "share" feature (`invoice_screen.dart` line 378) uses `SharePlus.instance.share(ShareParams(text: invoice.transaction?.paymentGatewayUrl ?? ""))` — it shares a **plain URL string** via the OS share sheet. The recipient opens it in a browser; there's no way to deep-link back into the merchant app.
- After a successful payment in `WebViewScreen`, the result is passed back via `Get.back(result: {'success': true, ...})` — fine for in-app, but no mechanism for a payment-link recipient to land back in the app.
- For a merchant product, **payment-link deep links** (`https://ecardo.ir/pay/{invoiceId}` opening the user-side app, not this merchant app) and **invoice-edit deep links** (`https://ecardo.ir/m/invoice/{id}` opening the merchant app) are commonly expected. Both are missing.

---

## 14. Push Notifications

### 14.1 `lib/src/common/services/firebase_messaging_service.dart`

- Singleton (`FirebaseMessagingService._internal()`).
- `init()` requests permission, gets token, saves to `SettingsService` (in `shared_preferences` — see §10), listens to `onMessage` (foreground) and `onMessageOpenedApp` (background tap), processes `getInitialMessage()` (terminated launch).
- Foreground messages are forwarded to `LocalNotificationsService.showNotification(title, body, payload)`.

### 14.2 `lib/src/common/services/local_notifications_service.dart`

- Singleton. Creates one Android notification channel `channel_id` / "Default Channel".
- No per-category channels (e.g., payment received, withdraw approved, ticket reply). All notifications go to "Default Channel" — user cannot mute just "ticket replies" without muting everything.

### 14.3 Region-specific push gaps (CRITICAL)

- **China (CN)**: FCM is **blocked**. There is **no HMS Push Kit, no JPush, no Getui, no OPPO Push, no Vivo Push, no Xiaomi Push** integration. Chinese merchants will receive **zero push notifications**. This is a P0 for the Chinese market.
- **Iran (IR)**: FCM works but is **slow/unreliable** due to bandwidth shaping; consider a fallback SaaS push provider (e.g., Pushe — an Iranian push service) or a self-hosted MQTT/WebSocket.
- **iOS in China**: Apple Push Notification service (APNs) works in China but is also throttled.
- **Russia (RU)**: FCM works (Google services still generally available; situation fluid post-sanctions). No special handling needed today but plan for a Matreshka/VK alternative if sanctions tighten.
- **Turkey / UAE**: FCM works normally.

### 14.4 Notification channel strategy (Android O+)

Only one channel. Recommendation: split into `payments`, `withdraw`, `tickets`, `security`, `marketing` channels with proper importance levels so users can fine-tune.

---

## 15. Biometric / Local Auth

### 15.1 `lib/src/common/services/biometric_auth_service.dart`

- Uses `local_auth: ^3.0.0` (Flutter plugin wrapping Android BiometricPrompt and iOS LocalAuthentication).
- `authenticateWithBiometrics()` checks `canCheckBiometrics`, `isDeviceSupported()`, `getAvailableBiometrics()` and calls `auth.authenticate(localizedReason: ..., biometricOnly: true)`. `biometricOnly: true` is correct (prevents PIN fallback which would weaken the gate).

### 15.2 Enforcement

- Biometric is **opt-in** via profile screen toggle (`profile_screen.dart` line 244–270 → `HomeController.toggleBiometric()`).
- When enabled, the user's **plaintext email + password** are saved to `shared_preferences` (login_controller.dart lines 127–139) so that on next launch, biometric auth → re-POST credentials to `/auth/merchant/login`. This is the critical security flaw.
- ❌ No biometric gate on app cold-start. The app launches → splash → `SplashController.navigateBasedOnAuth()` checks only `getLoginCurrentState()` (splash_controller.dart line 21). If "logged_in" state is set, it routes to `BaseRoute.login` (which would then auto-fill credentials and use biometric). However, if the user is mid-session with a valid token, the app goes straight to `BaseRoute.navigation` (home) without any biometric challenge.

### 15.3 Recommendation

Replace the "save password & re-login" pattern with a **refresh-token / long-lived session** approach:
- Server issues a long-lived refresh token (HttpOnly cookie on web, secure storage on mobile).
- Biometric unlocks a key in `flutter_secure_storage` that decrypts the refresh token.
- App uses refresh token to get new access tokens; no plaintext password ever stored.

---

## 16. Merchant-Specific Features

### 16.1 Invoice generation (PDF)

`lib/src/presentation/screens/invoice/view/invoice_details/sub_sections/invoice_pdf.dart` (368 lines). Uses `pdf: ^3.11.3` + `printing: ^5.14.2`.

- Layout: logo top-left, ref number + issued date top-right, customer info + Paid/Unpaid badge, total amount, item table (name/quantity/unit price/subtotal), totals, "Thanks for the purchase" footer.
- ✅ Localized labels (via `localization.invoicePdfXxx`).
- ❌ **No bundled fonts in PDF** → Arabic/Persian/CJK/Cyrillic will be tofu (see §3.4).
- ❌ Date format hard-coded `"dd MMM yyyy"` — month names will be English even in Arabic.
- ❌ PDF generated synchronously on UI isolate.
- ❌ No PDF preview screen — `Printing.layoutPdf()` sends directly to system print dialog. A "share PDF" option (via `share_plus`) would be more useful for merchants.

### 16.2 API access key management

`api_access_key_screen.dart` (see §6.4). Two fields (public + secret), copy buttons, regenerate button with confirm dialog. Endpoint: `GET /merchant/access-keys`, `POST /merchant/access-keys/regenerate`.

### 16.3 QR code generation

`qr_code_screen.dart` (see §6.3). Server returns SVG string via `/merchant/qrcode`. Client renders via `SvgPicture.string(...)`. Download via `Permission.manageExternalStorage` (problematic — see §10).

### 16.4 Settlement / reconciliation reports

❌ None. No screen, no endpoint, no CSV/Excel/PDF statement export.

### 16.5 Multi-currency wallet handling

✅ Each wallet has `currency`, `isCrypto`, `balance`, `isDefault`. `DynamicDecimalsHelper` switches decimal precision. Converter endpoint `/convert/{amount}/{currencyCode}/{isThousandSeparatorRemove}` (and currency-to-currency variant) provides live rates.

### 16.6 Staff / sub-account management

❌ None. Single-tenant login.

### 16.7 Webhook configuration

❌ None. Merchants integrating the API access key need to set webhooks somewhere — there's no in-app screen for it.

### 16.8 Transaction dispute / chargeback

❌ None.

### 16.9 Refund issuing

❌ None (refund icons exist in `assets/icons/png/transactions/refund_transaction_icon.png` but no refund-issuing screen).

---

## 17. Region-Specific Features Missing

### 17.1 Iran (fa)

| Feature | Status | Recommendation |
|---|---|---|
| Persian language (`app_fa.arb`) | ❌ missing | Add ARB file with 478 keys |
| Persian font (Vazirmatn) | ❌ missing | Bundle `Vazirmatn-Variable.ttf` |
| Persian digits (۰۱۲۳…) | ❌ missing | Add `NumberFormat(..., 'fa')` + `intl` `fa` locale; or hand-roll a digit mapper |
| Jalali (Shamsi) calendar | ❌ missing | Add `shamsi_date` or `persian_datetime_picker`; replace `flutter_rounded_date_picker` for fa locale |
| Iranian payment gateways (Zarinpal, Shaparak, Sadad, Melli, Sep) | ⚠️ backend-dependent | The `paymentGatewayUrl` returned by `/merchant/invoices/{id}` presumably routes through whatever backend integration exists. Client just opens WebView. **No client-side change needed** unless merchants should pick gateway at invoice creation. |
| Iranian IBAN (Sheba) validation | ❌ missing | Add `iran_sheba` package or regex validator on withdraw account creation |
| Persian (Rial/Toman) currency formatting | ⚠️ partial | `site_currency` is configurable; need to ensure `IRR` symbol and 0-decimal rendering works |
| FCM reliability | ⚠️ slow | Consider Pushe fallback |

### 17.2 China (zh)

| Feature | Status | Recommendation |
|---|---|---|
| Chinese language (`app_zh.arb`) | ❌ missing | Add ARB; consider both `zh-CN` and `zh-TW` |
| Chinese font (Noto Sans SC / TC) | ❌ missing | Bundle — adds ~5–10 MB; consider Play Asset Delivery or `google_fonts` runtime fetch (but Google Fonts blocked in CN) |
| Chinese ID (身份证) verification | ❌ missing | Need a Chinese ID validator; KYC fields may differ — backend `/get-register-fields/merchant` should return CN-specific fields |
| Chinese phone format (+86, 11 digits) | ❌ missing | Add `libphonenumber` with region `CN` |
| WeChat Pay / Alipay | ❌ no client integration | If backend supports them, payment gateway URL works; otherwise need WeChat SDK integration (`fluwx`) and Alipay SDK (`tobias`) |
| HMS Push / JPush / OPPO/Vivo/Xiaomi push | ❌ missing | P0 — FCM is blocked in CN |
| Mainland China app store distribution | ❌ not addressed | Need separate build for Huawei AppGallery, OPPO, Vivo, Xiaomi, Tencent MyApp stores |
| ICP filing (ICP 备案) | ❌ not addressed | Required for any app distributed in CN; legal/regulatory blocker |

### 17.3 Russia (ru)

| Feature | Status | Recommendation |
|---|---|---|
| Russian language (`app_ru.arb`) | ❌ missing | Add ARB |
| Russian font | ⚠️ Plus Jakarta Sans may have Cyrillic; verify, else bundle Noto Sans |
| YooMoney (ЮMoney) | ❌ no client integration | Backend may support; if not, need SDK |
| Mir card | ❌ no client integration | Backend-dependent; ensure payment WebView supports Mir's 3DS flow |
| Russian phone format (+7) | ❌ missing | Add `libphonenumber` with region `RU` |
| RuStore distribution | ❌ not addressed | Required if Google Play unavailable |

### 17.4 Turkey (tr)

| Feature | Status | Recommendation |
|---|---|---|
| Turkish language (`app_tr.arb`) | ❌ missing | Add ARB |
| Turkish font | ✅ Plus Jakarta Sans covers Latin TR |
| iyzico / PayTR | ❌ no client integration | Backend-dependent; ensure 3DS flow works in WebView |
| Turkish phone format (+90) | ❌ missing | Add `libphonenumber` with region `TR` |
| Turkish IBAN (TR\d{2}\s…) | ❌ missing | Add IBAN validator |

### 17.5 UAE (ar-AE) — already partially covered by `ar`

| Feature | Status | Recommendation |
|---|---|---|
| Arabic language | ✅ `app_ar.arb` exists |
| Arabic font | ❌ Plus Jakarta Sans has no Arabic glyphs — bundle Noto Sans Arabic or IBM Plex Sans Arabic |
| Arabic-Indic digits (٠١٢٣…) | ❌ missing | `NumberFormat(..., 'ar')` produces them; ensure widget `TextDirection` is RTL |
| Hijri calendar (optional) | ❌ missing | Some UAE users prefer Hijri for personal dates (DOB); add `hijri` package as opt-in |
| PayTabs / Network International / Telr | ❌ no client integration | Backend-dependent |
| UAE phone format (+971) | ❌ missing | Add `libphonenumber` with region `AE` |
| Emirates ID verification | ❌ missing | Backend `/get-register-fields/merchant` should return EID fields; client should add EID validator |
| RTL layout correctness | ⚠️ partial | 6 files handle RTL explicitly; many don't — needs full RTL audit pass |

---

## Critical Issues (P0 — must fix before launch)

1. **Release APK is signed with the debug keystore.** `android/app/build.gradle.kts` lines 31–34. Google Play will reject; APK is forgeable. Create a proper release keystore, set up `signingConfigs.release`, and store the keystore + passwords in CI secrets.
2. **User's plaintext password is persisted in `shared_preferences`.** `SettingsService.saveLoggedInUserPassword()` + `getLoggedInUserPassword()`. Used for biometric re-login. Switch to refresh-token + `flutter_secure_storage` pattern (see §15.3).
3. **Access token stored in `shared_preferences`.** `TokenService`. Migrate to `flutter_secure_storage`.
4. **Firebase project is `qunzo-b2252` and shared with `qunzo.agent` and `qunzo.user`.** `google-services.json` contains 3 clients. Create a new dedicated Firebase project for `ecardo.merchant`, re-run `flutterfire configure`, replace all config files.
5. **App is still branded "qunzo" everywhere.** Dart package, Android applicationId/namespace, iOS bundle ID, app labels, `AppStrings.appName`, class name `QunzoMerchant`, splash screen "unzo" typo. See §1 for full file list.
6. **`_normalizeLocale` whitelist forces fa/zh/tr/ru users to English.** `app.dart` lines 22–33. Must be extended (or removed) when adding new locales.
7. **Bundled font (Plus Jakarta Sans) has no Arabic glyphs.** Arabic translation already shipped but renders as tofu on devices without system Arabic fallback. Bundle Noto Sans Arabic / Vazirmatn immediately.
8. **FCM is the only push channel.** Chinese merchants will receive zero notifications. Add HMS Push + at least one Chinese push provider.
9. **`MANAGE_EXTERNAL_STORAGE` permission declared.** Will fail Google Play review. Replace with `path_provider` + MediaStore API in `qr_code_screen.dart`.
10. **PDF generation has no fonts.** Arabic/Persian/CJK/Cyrillic text in invoice PDFs renders as tofu. Register `pw.Font.ttf(...)` for each script.

## High Priority Issues (P1)

1. **No certificate pinning.** Add `dio_certificate_pinning` or implement via `IOHttpClientAdapter` + `SecurityContext`.
2. **No ProGuard/R8.** Create `proguard-rules.pro`, enable `minifyEnabled true` + `shrinkResources true` in release build.
3. **No dark theme.** Either remove `values-night/styles.xml` and the dark-mode icons or implement `dark_theme.dart` + a `ThemeController`.
4. **No flavors / no environment separation.** Add `dev`/`staging`/`prod` product flavors and `--dart-define=BASE_URL=...`.
5. **No `cached_network_image`.** Network images re-download on every navigation. Add the package and replace `Image.network(...)` (9 call sites).
6. **No iOS `CFBundleLocalizations`.** iOS won't expose supported languages to the system.
7. **No deep links / app links.** Merchants cannot return to the app from a shared payment link. Add `ecardo.ir` app links (Android `autoVerify="true"`) + iOS associated domains.
8. **No retry interceptor + no timeouts on Dio.** A hung server freezes the app. Add `connectTimeout: 15s`, `receiveTimeout: 30s`, and a retry interceptor for idempotent GETs.
9. **No token refresh.** Users must re-login on every 401. Implement refresh-token rotation.
10. **API access key secret is displayed in plain text.** Add reveal/hide toggle and consider re-auth (biometric/2FA) before reveal.
11. **No biometric gate on cold start.** For fintech, biometric should be a hard gate when enabled.
12. **No settlement / reconciliation reports.** Major merchant feature gap.
13. **No tests.** Zero test files. CI doesn't run `flutter test` or `flutter analyze`.
14. **CI builds only Android.** No iOS CI, no TestFlight upload.
15. **No Sentry / Crashlytics / Firebase Analytics.** No crash reporting in production.
16. **Locale-unaware `DateFormat` / `NumberFormat` everywhere.** Will display English month names and Latin digits even in fa/zh/ru.

## Medium Priority Issues (P2)

1. **Filename typo `light_thtme.dart`.** Rename to `light_theme.dart`; update import in `app.dart` line 6.
2. **`BaseRoute.idVerification` registered twice in `routes_handler.dart`.** Lines 107–111 and 177–181. Deduplicate.
3. **`InitialBinding` defined but never wired to `GetMaterialApp.initialBinding`.** Either remove or wire up.
4. **Hard-coded `kDebugMode` `print()` statements in `firebase_messaging_service.dart` lines 40, 49, 54, 71.** Use a proper logger.
5. **`home_controller.dart` hard-codes language names "English"/"Arabic".** Refactor to be locale-driven.
6. **All server `message` strings passed verbatim to toast.** No client-side error code → localized message mapping.
7. **Plain `Image.asset` for icons.** 101 PNG icons should be SVG for smaller APK and better scaling.
8. **`shimmer` skeleton only on home screen.** Add skeletons to wallets, transactions, invoices, notifications.
9. **No pagination on wallets, notifications, support tickets, KYC history.**
10. **Single Android notification channel.** Split into `payments`, `withdraw`, `tickets`, `security`, `marketing`.
11. **`kotlin.incremental=false`** slows dev iteration.
12. **`-Xmx8G` gradle JVM args** will OOM small CI runners.
13. **No splash screen proper native splash.** `launch_background.xml` is just a white color; should use `flutter_native_splash` with the ecardo logo.
14. **No `flutter_launcher_icons` config for adaptive icons.** Android adaptive icon foreground/background not configured.
15. **`pubspec.yaml` version comment mismatch** (says Flutter 3.35.7, CI installs 3.44.0).
16. **`app_ar.arb` has no `@` metadata for parameterized strings** — relies entirely on ICU `{var}` syntax. Verify all parameterized keys (e.g., `invoiceDetailsRefNumber`, `qrCodeMerchantId`, `exchangeMinMaxLabel`) render correctly in Arabic.
17. **Settings keys read with `!`** (e.g., `getSetting("site_currency")!` in `invoice_pdf.dart`). Will crash if settings fetch fails.
18. **No `--split-per-abi` build** in CI; ships a fat APK.

## Low Priority Issues (P3)

1. **README.md missing.** No project documentation.
2. **No `CHANGELOG.md`.**
3. **No `.env.example`.**
4. **No `CODEOWNERS`.**
5. **No branch protection / PR template** (out of repo scope but worth noting).
6. **Inconsistent comment style** — some files use `// ----- SECTION -----`, others use `// ===== SECTION =====`.
7. **`comment_*` keys in ARB files** (82 of them) are passed through to `AppLocalizations` as `String get comment_xxx` — wastes generated code size. Filter them out via `l10n.yaml` `synthetic-package: false` + custom generation, or just delete them from the ARB.
8. **`api_path.dart` mixes `static const String` and `static String getConverterEndpoint(...)`** — inconsistent.
9. **`UserProfileController` does not refresh on locale change.** If profile contains localized fields (e.g., country name), they won't update.
10. **Hard-coded color `Color(0xFF043844)` in `settings_bottom_sheet.dart` line 150** — magic color not in `AppColors`.
11. **`exit(0)` used to quit app** (home_screen.dart line 38, login_screen.dart line 35) — not recommended on iOS; `SystemNavigator.pop()` is preferred.
12. **`drawerDashboard` key exists in ARB but drawer uses `drawerDashboard`** — fine, just verify consistency with `navigationHome` (which is "Home" — same concept, two keys).

---

## Recommended Localization Stack for 5 Regions

### Languages to add

| Locale | ARB file | Native name | Priority |
|---|---|---|---|
| `fa` | `app_fa.arb` | فارسی | P0 (Iran is primary market per ecardo.ir) |
| `zh` | `app_zh.arb` (Simplified) + optionally `app_zh_TW.arb` | 中文(简体) | P0 |
| `tr` | `app_tr.arb` | Türkçe | P1 |
| `ru` | `app_ru.arb` | Русский | P1 |
| `ar` | `app_ar.arb` (exists) | العربية | P0 (UAE) — needs font fix |
| `en` | `app_en.arb` (exists) | English | — |

### Fonts to add

| Script | Font | File(s) | Size |
|---|---|---|---|
| Latin | Plus Jakarta Sans (existing) | 5 weights | ~700 KB |
| Arabic | Noto Sans Arabic | 4 weights | ~600 KB |
| Persian | **Vazirmatn** (preferred for fa) | Variable | ~700 KB |
| Chinese (Simplified) | Noto Sans SC | Subset or full | 4–8 MB (consider dynamic delivery) |
| Chinese (Traditional) | Noto Sans TC | (optional) | 4–8 MB |
| Cyrillic | Plus Jakarta Sans (verify) or Noto Sans | — | — |

Bundle strategy: declare all fonts in `pubspec.yaml` under per-script `family` names, then in `light_theme.dart` set `fontFamilyFallback: ['Noto Sans Arabic', 'Vazirmatn', 'Noto Sans SC']`.

### Date calendars

| Locale | Calendar | Package |
|---|---|---|
| `en`, `tr`, `ru`, `ar-AE` (business) | Gregorian | `intl` (default) |
| `fa` | **Jalali (Shamsi)** | `shamsi_date` or `persian_datetime_picker` |
| `ar` (optional personal) | Hijri | `hijri` package |
| `zh` | Gregorian (with Chinese lunar for festivals) | `intl` + `chinese_lunar_calendar` (optional) |

Replace `flutter_rounded_date_picker` (which is Gregorian-only) with a locale-aware picker that switches calendar based on `Locale('fa')`.

### Number / currency formatting

- Use `NumberFormat.currency(locale: 'fa', symbol: '﷼', decimalDigits: 0)` for Iranian Rial.
- Use `NumberFormat.currency(locale: 'ar', symbol: 'د.إ', decimalDigits: 2)` for AED.
- Use `NumberFormat.currency(locale: 'zh', symbol: '¥', decimalDigits: 2)` for CNY.
- Use `NumberFormat.currency(locale: 'ru', symbol: '₽', decimalDigits: 2)` for RUB.
- Use `NumberFormat.currency(locale: 'tr', symbol: '₺', decimalDigits: 2)` for TRY.
- For Persian/Arabic digits, ensure `NumberFormat(..., 'fa')` / `'ar'` is used (it auto-converts to ۰۱۲۳ / ٠١٢٣).

### Payment gateways per region

| Region | Gateways | Client action |
|---|---|---|
| Iran | Zarinpal, Shaparak, Sadad, Melli, Sep, Asan Pardakht | Backend-driven via `paymentGatewayUrl`; verify WebView 3DS redirect works |
| China | WeChat Pay, Alipay, UnionPay | Native SDK integration (`fluwx`, `tobias`) — WebView alone won't work for in-app payments |
| Russia | YooMoney, Mir, SberPay, Tinkoff Pay | Backend-driven; verify Mir 3DS |
| Turkey | iyzico, PayTR, Papara | Backend-driven; verify 3DS |
| UAE | PayTabs, Network International, Telr, Stripe | Backend-driven |

### Push alternatives per region

| Region | Primary | Fallback |
|---|---|---|
| Iran | FCM | Pushe (Iranian) or self-hosted WebSocket |
| China | **HMS Push Kit** (Huawei) + **JPush** (covers OPPO/Vivo/Xiaomi/Meizu) | FCM (unavailable) |
| Russia | FCM | RuStore Push (if distributing via RuStore) |
| Turkey | FCM | — |
| UAE | FCM | — |

Implement a `PushService` abstraction with region-specific providers selected at runtime based on device locale / SIM ISO / backend config.

### Phone validation

Add `libphonenumber_plugin` (or `phone_number`) and validate on Personal Info and Profile Settings screens per selected country code.

### IBAN / bank account validation

- Iran: `iran_sheba` package or regex `^IR\d{24}$`.
- Turkey: standard IBAN regex `^TR\d{2}\s?\d{4}\s?\d{4}\s?...`.
- Russia: standard Russian bank account (20 digits) + BIK (9 digits).
- UAE: standard IBAN `^AE\d{2}\s?\d{3}\s?\d{16}$`.

### ID verification per region

- Iran: National ID (کد ملی) — 10-digit checksum.
- China: 身份证 — 18-digit checksum.
- Russia: INN (10 or 12 digits), SNILS.
- Turkey: T.C. Kimlik No — 11-digit checksum.
- UAE: Emirates ID — 15 digits with checksum.

The backend `/get-register-fields/merchant` endpoint should return region-specific KYC fields; the client's `auth_id_verification` screen uses dynamic field rendering (`file_type_section.dart`, `camera_type_section.dart`) which can accommodate this — just ensure the validators exist.

---

## File Counts

| Category | Count |
|---|---|
| Total Dart files in `lib/` | **193** |
| Screens (top-level `*_screen.dart` and equivalents under `view/`) | **37** |
| All view files (including `sub_sections/`) | **76** |
| Controllers (under `screens/`) | **37** |
| Models (under `screens/`) | **17** |
| Common controllers | **5** |
| Common models | **5** |
| Common services | **4** |
| Common widgets | **14** |
| Presentation widgets | **10** |
| Helper files | **3** |
| ARB keys (English, excluding `comment_*`) | **478** |
| ARB keys (English, total including comments) | **560** |
| ARB files | **2** (`app_en.arb`, `app_ar.arb`) |
| PNG icon assets | **101** |
| SVG icon assets | **10** |
| Other PNG assets (logos, frames, shapes, wallet images, avatars, welcome) | **28** |
| Total PNG assets | **129** |
| JSON (Lottie) assets | **1** |
| Fonts | **5** (Plus Jakarta Sans, 4 weights + 1 variable) |
| GetX routes (`BaseRoute.*`) | **34** |
| GetPage registrations | **33** (one route registered twice) |
| Bindings | **~30** (in `app_bindings.dart`) |
| Test files | **0** |
| CI workflows | **1** (Android only) |
| Firebase projects referenced | **1** (`qunzo-b2252`, shared with agent+user apps) |
| Languages supported | **2** (`en`, `ar`) |
| Languages needed for 5 regions | **6** (`en`, `ar`, `fa`, `zh`, `tr`, `ru`) |
