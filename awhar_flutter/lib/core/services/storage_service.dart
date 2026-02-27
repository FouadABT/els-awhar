import 'package:get_storage/get_storage.dart';

/// Service for persistent local storage
class StorageService {
  static const String _themeKey = 'theme_mode';
  static const String _localeKey = 'locale';

  late final GetStorage _box;

  /// Initialize storage
  Future<void> init() async {
    await GetStorage.init();
    _box = GetStorage();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // THEME
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get saved theme mode: 'light', 'dark', or 'system'
  String get themeMode => _box.read<String>(_themeKey) ?? 'system';

  /// Save theme mode
  Future<void> setThemeMode(String mode) async {
    await _box.write(_themeKey, mode);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LOCALE
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get saved locale code (e.g., 'en', 'ar')
  String? get locale => _box.read<String>(_localeKey);

  /// Save locale code
  Future<void> setLocale(String localeCode) async {
    await _box.write(_localeKey, localeCode);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // GENERIC
  // ═══════════════════════════════════════════════════════════════════════════

  /// Read a value
  T? read<T>(String key) => _box.read<T>(key);

  /// Write a value
  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  /// Remove a value
  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  /// Clear all storage
  Future<void> clear() async {
    await _box.erase();
  }
}
