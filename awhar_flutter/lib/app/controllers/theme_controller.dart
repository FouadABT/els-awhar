import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../core/services/storage_service.dart';
import '../../core/theme/app_colors.dart';

/// Theme mode options
enum AppThemeMode {
  light,
  dark,
  system,
}

/// Controller for managing app theme
class ThemeController extends GetxController {
  final StorageService _storageService;

  ThemeController(this._storageService);

  // Observable theme mode
  final Rx<AppThemeMode> _themeMode = AppThemeMode.system.obs;

  /// Current theme mode
  AppThemeMode get themeMode => _themeMode.value;

  /// Check if current theme is dark
  bool get isDarkMode {
    if (_themeMode.value == AppThemeMode.system) {
      return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode.value == AppThemeMode.dark;
  }

  /// Get current colors based on theme
  dynamic get colors => isDarkMode ? AppColors.dark : AppColors.light;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromStorage();
  }

  /// Load saved theme from storage
  void _loadThemeFromStorage() {
    final savedTheme = _storageService.themeMode;
    _themeMode.value = _parseThemeMode(savedTheme);
    _applyTheme();
  }

  /// Parse theme mode string to enum
  AppThemeMode _parseThemeMode(String mode) {
    switch (mode) {
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      default:
        return AppThemeMode.system;
    }
  }

  /// Convert enum to string
  String _themeModeToString(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'light';
      case AppThemeMode.dark:
        return 'dark';
      case AppThemeMode.system:
        return 'system';
    }
  }

  /// Set theme mode
  Future<void> setThemeMode(AppThemeMode mode) async {
    _themeMode.value = mode;
    await _storageService.setThemeMode(_themeModeToString(mode));
    _applyTheme();
  }

  /// Toggle between light and dark mode
  Future<void> toggleTheme() async {
    if (isDarkMode) {
      await setThemeMode(AppThemeMode.light);
    } else {
      await setThemeMode(AppThemeMode.dark);
    }
  }

  /// Apply the current theme to GetX
  void _applyTheme() {
    ThemeMode getxThemeMode;
    switch (_themeMode.value) {
      case AppThemeMode.light:
        getxThemeMode = ThemeMode.light;
        break;
      case AppThemeMode.dark:
        getxThemeMode = ThemeMode.dark;
        break;
      case AppThemeMode.system:
        getxThemeMode = ThemeMode.system;
        break;
    }
    Get.changeThemeMode(getxThemeMode);
  }

  /// Get icon for current theme mode
  IconData get themeModeIcon {
    switch (_themeMode.value) {
      case AppThemeMode.light:
        return Icons.light_mode_rounded;
      case AppThemeMode.dark:
        return Icons.dark_mode_rounded;
      case AppThemeMode.system:
        return Icons.brightness_auto_rounded;
    }
  }

  /// Get label for current theme mode
  String get themeModeLabel {
    switch (_themeMode.value) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.system:
        return 'System';
    }
  }
}
