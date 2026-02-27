import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app_locales.dart';

/// GetX Translations class for loading and managing translations
class AppTranslations extends Translations {
  /// Loaded translations map
  static final Map<String, Map<String, String>> _translations = {};

  /// Load all translation files
  static Future<void> loadTranslations() async {
    for (final locale in AppLocales.supportedLocales) {
      final languageCode = locale.languageCode;
      try {
        final jsonString = await rootBundle.loadString(
          'assets/translations/$languageCode.json',
        );
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        _translations[languageCode] = _flattenTranslations(jsonMap);
      } catch (e) {
        // If translation file not found, use empty map
        _translations[languageCode] = {};
      }
    }
  }

  /// Flatten nested JSON to dot notation keys
  /// e.g., {"auth": {"login": "Login"}} becomes {"auth.login": "Login"}
  static Map<String, String> _flattenTranslations(
    Map<String, dynamic> json, [
    String prefix = '',
  ]) {
    final Map<String, String> result = {};

    json.forEach((key, value) {
      final newKey = prefix.isEmpty ? key : '$prefix.$key';

      if (value is Map<String, dynamic>) {
        result.addAll(_flattenTranslations(value, newKey));
      } else if (value is String) {
        result[newKey] = value;
      }
    });

    return result;
  }

  @override
  Map<String, Map<String, String>> get keys => _translations;
}

/// Extension for easy translation access
extension TranslationExtension on String {
  /// Translate with optional parameters
  /// Usage: 'validation.min_length'.trParams({'count': '8'})
  String trWithParams(Map<String, String> params) {
    String result = tr;
    params.forEach((key, value) {
      result = result.replaceAll('{$key}', value);
    });
    return result;
  }
}

/// Translation keys for type-safe access (optional but recommended)
abstract class TrKeys {
  // App
  static const String appName = 'app_name';

  // Common
  static const String ok = 'common.ok';
  static const String cancel = 'common.cancel';
  static const String save = 'common.save';
  static const String delete = 'common.delete';
  static const String edit = 'common.edit';
  static const String close = 'common.close';
  static const String back = 'common.back';
  static const String next = 'common.next';
  static const String done = 'common.done';
  static const String loading = 'common.loading';
  static const String error = 'common.error';
  static const String success = 'common.success';
  static const String warning = 'common.warning';
  static const String info = 'common.info';
  static const String confirm = 'common.confirm';
  static const String yes = 'common.yes';
  static const String no = 'common.no';
  static const String search = 'common.search';
  static const String retry = 'common.retry';
  static const String submit = 'common.submit';
  static const String continueKey = 'common.continue';
  static const String skip = 'common.skip';

  // Auth
  static const String login = 'auth.login';
  static const String logout = 'auth.logout';
  static const String register = 'auth.register';
  static const String email = 'auth.email';
  static const String password = 'auth.password';
  static const String confirmPassword = 'auth.confirm_password';
  static const String forgotPassword = 'auth.forgot_password';
  static const String resetPassword = 'auth.reset_password';
  static const String createAccount = 'auth.create_account';
  static const String alreadyHaveAccount = 'auth.already_have_account';
  static const String dontHaveAccount = 'auth.dont_have_account';
  static const String signInWith = 'auth.sign_in_with';
  static const String or = 'auth.or';

  // Settings
  static const String settingsTitle = 'settings.title';
  static const String language = 'settings.language';
  static const String theme = 'settings.theme';
  static const String themeLight = 'settings.theme_light';
  static const String themeDark = 'settings.theme_dark';
  static const String themeSystem = 'settings.theme_system';
  static const String notifications = 'settings.notifications';
  static const String privacy = 'settings.privacy';
  static const String about = 'settings.about';
  static const String help = 'settings.help';
  static const String terms = 'settings.terms';
  static const String privacyPolicy = 'settings.privacy_policy';
  static const String version = 'settings.version';
  static const String changeLanguage = 'settings.change_language';
  static const String selectLanguage = 'settings.select_language';

  // Home
  static const String homeTitle = 'home.title';
  static const String welcome = 'home.welcome';
  static const String welcomeBack = 'home.welcome_back';
  static const String greetingMorning = 'home.greeting_morning';
  static const String greetingAfternoon = 'home.greeting_afternoon';
  static const String greetingEvening = 'home.greeting_evening';

  // Profile
  static const String profileTitle = 'profile.title';
  static const String editProfile = 'profile.edit_profile';
  static const String myAccount = 'profile.my_account';
  static const String fullName = 'profile.full_name';
  static const String phone = 'profile.phone';
  static const String address = 'profile.address';

  // Errors
  static const String networkError = 'errors.network_error';
  static const String serverError = 'errors.server_error';
  static const String unknownError = 'errors.unknown_error';
  static const String sessionExpired = 'errors.session_expired';
  static const String invalidEmail = 'errors.invalid_email';
  static const String invalidPassword = 'errors.invalid_password';
  static const String passwordsDontMatch = 'errors.passwords_dont_match';
  static const String requiredField = 'errors.required_field';

  // Validation
  static const String validationRequired = 'validation.required';
  static const String validationEmailInvalid = 'validation.email_invalid';
  static const String validationMinLength = 'validation.min_length';
  static const String validationMaxLength = 'validation.max_length';
  static const String validationPasswordWeak = 'validation.password_weak';
}
