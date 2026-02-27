import 'dart:ui';

import 'package:get/get.dart';

import '../../core/localization/app_locales.dart';
import '../../core/services/storage_service.dart';

/// Controller for managing app locale/language
class LocaleController extends GetxController {
  final StorageService _storageService;

  LocaleController(this._storageService);

  // Observable current locale
  final Rx<Locale> _currentLocale = AppLocales.defaultLocale.obs;

  /// Get current locale
  Locale get currentLocale => _currentLocale.value;

  /// Get current language code
  String get currentLanguageCode => _currentLocale.value.languageCode;

  /// Check if current locale is RTL
  bool get isRtl => AppLocales.isRtl(_currentLocale.value);

  /// Get current text direction
  TextDirection get textDirection =>
      AppLocales.getTextDirection(_currentLocale.value);

  /// Get current language info
  LanguageInfo? get currentLanguage =>
      LanguageInfo.getByLocale(_currentLocale.value);

  @override
  void onInit() {
    super.onInit();
    _loadLocaleFromStorage();
  }

  /// Load saved locale from storage
  void _loadLocaleFromStorage() {
    final savedLocale = _storageService.locale;
    if (savedLocale != null) {
      final locale = AppLocales.getLocaleFromCode(savedLocale);
      _currentLocale.value = locale;
      _applyLocale();
    } else {
      // Try to use device locale if supported
      final deviceLocale = PlatformDispatcher.instance.locale;
      final isSupported = AppLocales.supportedLocales.any(
        (l) => l.languageCode == deviceLocale.languageCode,
      );
      if (isSupported) {
        _currentLocale.value = AppLocales.getLocaleFromCode(
          deviceLocale.languageCode,
        );
      }
      _applyLocale();
    }
  }

  /// Change locale by language code
  Future<void> changeLocaleByCode(String code) async {
    final locale = AppLocales.getLocaleFromCode(code);
    if (_currentLocale.value == locale) return;

    _currentLocale.value = locale;
    await _storageService.setLocale(code);
    _applyLocale();
  }

  /// Apply the current locale to GetX
  void _applyLocale() {
    Get.updateLocale(_currentLocale.value);
  }

  /// Get all available languages
  List<LanguageInfo> get availableLanguages => LanguageInfo.languages;

  /// Check if a language is selected
  bool isSelected(String code) => currentLanguageCode == code;
  
  /// Get current locale display name
  String get currentLocaleName {
    final names = {'en': 'English', 'ar': 'العربية', 'fr': 'Français', 'es': 'Español'};
    return names[currentLanguageCode] ?? currentLanguageCode;
  }
  
  /// Change locale by language code string
  Future<void> changeLocale(String code) async {
    final locale = AppLocales.getLocaleFromCode(code);
    if (_currentLocale.value == locale) return;

    _currentLocale.value = locale;
    await _storageService.setLocale(code);
    _applyLocale();
  }
}
