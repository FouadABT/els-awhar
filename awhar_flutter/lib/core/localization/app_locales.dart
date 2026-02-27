import 'dart:ui';

/// Supported app locales configuration
class AppLocales {
  AppLocales._();

  /// Default locale
  static const Locale defaultLocale = Locale('en', 'US');

  /// Fallback locale
  static const Locale fallbackLocale = Locale('en', 'US');

  /// All supported locales
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'), // English
    Locale('fr', 'FR'), // French
    Locale('es', 'ES'), // Spanish
    Locale('ar', 'MA'), // Darija (Moroccan Arabic)
  ];

  /// RTL language codes
  static const List<String> rtlLanguages = ['ar', 'he', 'fa', 'ur'];

  /// Check if a locale is RTL
  static bool isRtl(Locale locale) {
    return rtlLanguages.contains(locale.languageCode);
  }

  /// Get locale from language code
  static Locale getLocaleFromCode(String code) {
    return supportedLocales.firstWhere(
      (locale) => locale.languageCode == code,
      orElse: () => defaultLocale,
    );
  }

  /// Get text direction for a locale
  static TextDirection getTextDirection(Locale locale) {
    return isRtl(locale) ? TextDirection.rtl : TextDirection.ltr;
  }
}

/// Language information model
class LanguageInfo {
  final String code;
  final String name;
  final String nativeName;
  final String flag;
  final bool isRtl;
  final Locale locale;

  const LanguageInfo({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flag,
    required this.isRtl,
    required this.locale,
  });

  /// All available languages
  static const List<LanguageInfo> languages = [
    LanguageInfo(
      code: 'en',
      name: 'English',
      nativeName: 'English',
      flag: '🇺🇸',
      isRtl: false,
      locale: Locale('en', 'US'),
    ),
    LanguageInfo(
      code: 'fr',
      name: 'French',
      nativeName: 'Français',
      flag: '🇫🇷',
      isRtl: false,
      locale: Locale('fr', 'FR'),
    ),
    LanguageInfo(
      code: 'es',
      name: 'Spanish',
      nativeName: 'Español',
      flag: '🇪🇸',
      isRtl: false,
      locale: Locale('es', 'ES'),
    ),
    LanguageInfo(
      code: 'ar',
      name: 'Darija',
      nativeName: 'الدارجة',
      flag: '🇲🇦',
      isRtl: true,
      locale: Locale('ar', 'MA'),
    ),
  ];

  /// Get language info by code
  static LanguageInfo? getByCode(String code) {
    try {
      return languages.firstWhere((lang) => lang.code == code);
    } catch (_) {
      return null;
    }
  }

  /// Get language info by locale
  static LanguageInfo? getByLocale(Locale locale) {
    try {
      return languages.firstWhere(
        (lang) => lang.locale.languageCode == locale.languageCode,
      );
    } catch (_) {
      return null;
    }
  }
}
