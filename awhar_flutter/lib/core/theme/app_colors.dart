import 'package:flutter/material.dart';

/// Base type for color scheme - allows type-safe access to colors
abstract class AppColorScheme {
  Color get primary;
  Color get primaryHover;
  Color get primaryPressed;
  Color get primarySoft;

  Color get background;
  Color get surface;
  Color get surfaceElevated;
  Color get border;
  Color get borderSoft;
  Color get divider;

  Color get textPrimary;
  Color get textSecondary;
  Color get textMuted;
  Color get textDisabled;

  Color get success;
  Color get successSoft;
  Color get info;
  Color get infoSoft;
  Color get warning;
  Color get warningSoft;
  Color get error;
  Color get errorSoft;
}

/// App color palette for light and dark themes
abstract class AppColors {
  // ═══════════════════════════════════════════════════════════════════════════
  // 🌞 LIGHT MODE PALETTE
  // ═══════════════════════════════════════════════════════════════════════════

  static const AppColorScheme light = _LightColors();

  // ═══════════════════════════════════════════════════════════════════════════
  // 🌙 DARK MODE PALETTE
  // ═══════════════════════════════════════════════════════════════════════════

  static const AppColorScheme dark = _DarkColors();

  /// Get the color scheme for the current brightness
  static AppColorScheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dark : light;
  }
}

/// Light theme colors
class _LightColors implements AppColorScheme {
  const _LightColors();

  // Primary & Accent
  @override
  Color get primary => const Color(0xFFFF7A2F);
  @override
  Color get primaryHover => const Color(0xFFFF8E4F);
  @override
  Color get primaryPressed => const Color(0xFFE96820);
  @override
  Color get primarySoft => const Color(0xFFFFE2CC);

  // Backgrounds & Surfaces
  @override
  Color get background => const Color(0xFFFFF1DF);
  @override
  Color get surface => const Color(0xFFFFF8F0);
  @override
  Color get surfaceElevated => const Color(0xFFFFFFFF);
  @override
  Color get border => const Color(0xFFE0D4C4);
  @override
  Color get borderSoft => const Color(0xFFF0E2D3);
  @override
  Color get divider => const Color(0xFFE8D8C6);

  // Text
  @override
  Color get textPrimary => const Color(0xFF0F2F2E);
  @override
  Color get textSecondary => const Color(0xFF3E5F5B);
  @override
  Color get textMuted => const Color(0xFF7B9A96);
  @override
  Color get textDisabled => const Color(0xFFB8C9C6);

  // Semantic Colors
  @override
  Color get success => const Color(0xFF2ECC71);
  @override
  Color get successSoft => const Color(0xFFDFF5EA);

  @override
  Color get info => const Color(0xFF3DA9FC);
  @override
  Color get infoSoft => const Color(0xFFE4F2FF);

  @override
  Color get warning => const Color(0xFFF5A623);
  @override
  Color get warningSoft => const Color(0xFFFFF0D6);

  @override
  Color get error => const Color(0xFFE74C3C);
  @override
  Color get errorSoft => const Color(0xFFFCE4E1);
}

/// Dark theme colors
class _DarkColors implements AppColorScheme {
  const _DarkColors();

  // Primary & Accent
  @override
  Color get primary => const Color(0xFFFF8A3D);
  @override
  Color get primaryHover => const Color(0xFFFFA266);
  @override
  Color get primaryPressed => const Color(0xFFE6762F);
  @override
  Color get primarySoft => const Color(0xFF4A2A14);

  // Backgrounds & Surfaces
  @override
  Color get background => const Color(0xFF0B1F1E);
  @override
  Color get surface => const Color(0xFF112B2A);
  @override
  Color get surfaceElevated => const Color(0xFF183635);
  @override
  Color get border => const Color(0xFF2A5250);
  @override
  Color get borderSoft => const Color(0xFF244C4A);
  @override
  Color get divider => const Color(0xFF1E3F3D);

  // Text
  @override
  Color get textPrimary => const Color(0xFFF4FFFD);
  @override
  Color get textSecondary => const Color(0xFFB6D1CC);
  @override
  Color get textMuted => const Color(0xFF7FA8A2);
  @override
  Color get textDisabled => const Color(0xFF4F6F6B);

  // Semantic Colors
  @override
  Color get success => const Color(0xFF3EDC81);
  @override
  Color get successSoft => const Color(0xFF163D2C);

  @override
  Color get info => const Color(0xFF4DB3FF);
  @override
  Color get infoSoft => const Color(0xFF132F45);

  @override
  Color get warning => const Color(0xFFF7B955);
  @override
  Color get warningSoft => const Color(0xFF3E2F12);

  @override
  Color get error => const Color(0xFFFF6B5E);
  @override
  Color get errorSoft => const Color(0xFF3D1A17);
}
