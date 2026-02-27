import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_typography.dart';

/// App theme configuration
abstract class AppTheme {
  // ═══════════════════════════════════════════════════════════════════════════
  // 🌞 LIGHT THEME
  // ═══════════════════════════════════════════════════════════════════════════

  static ThemeData get light {
    final colors = AppColors.light;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Colors
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.background,
      dividerColor: colors.divider,

      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: colors.primary,
        onPrimary: Colors.white,
        primaryContainer: colors.primarySoft,
        onPrimaryContainer: colors.primary,
        secondary: colors.primary,
        onSecondary: Colors.white,
        secondaryContainer: colors.primarySoft,
        onSecondaryContainer: colors.primary,
        surface: colors.surface,
        onSurface: colors.textPrimary,
        surfaceContainerHighest: colors.surfaceElevated,
        error: colors.error,
        onError: Colors.white,
        errorContainer: colors.errorSoft,
        onErrorContainer: colors.error,
        outline: colors.borderSoft,
        outlineVariant: colors.divider,
      ),

      // Typography
      textTheme: AppTypography.lightTextTheme,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        titleTextStyle: AppTypography.lightTextTheme.titleLarge?.copyWith(
          color: colors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: colors.textPrimary),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        color: colors.surfaceElevated,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colors.borderSoft),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: colors.primarySoft,
          disabledForegroundColor: colors.textDisabled,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceElevated,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.borderSoft),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.borderSoft),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.error, width: 2),
        ),
        hintStyle: TextStyle(color: colors.textMuted),
        labelStyle: TextStyle(color: colors.textSecondary),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.surfaceElevated,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Navigation Bar Theme (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.surfaceElevated,
        indicatorColor: colors.primarySoft,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colors.primary);
          }
          return IconThemeData(color: colors.textMuted);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              color: colors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            );
          }
          return TextStyle(color: colors.textMuted, fontSize: 12);
        }),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: colors.surface,
        selectedColor: colors.primarySoft,
        disabledColor: colors.surface,
        labelStyle: TextStyle(color: colors.textPrimary),
        side: BorderSide(color: colors.borderSoft),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primary;
          }
          return colors.textMuted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primarySoft;
          }
          return colors.borderSoft;
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        side: BorderSide(color: colors.borderSoft, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surfaceElevated,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        titleTextStyle: AppTypography.lightTextTheme.headlineSmall,
        contentTextStyle: AppTypography.lightTextTheme.bodyMedium,
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surfaceElevated,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.textPrimary,
        contentTextStyle: const TextStyle(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: 1,
        space: 1,
      ),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        tileColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarThemeData(
        labelColor: colors.primary,
        unselectedLabelColor: colors.textMuted,
        indicatorColor: colors.primary,
        indicatorSize: TabBarIndicatorSize.label,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colors.primary,
        linearTrackColor: colors.primarySoft,
        circularTrackColor: colors.primarySoft,
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 🌙 DARK THEME
  // ═══════════════════════════════════════════════════════════════════════════

  static ThemeData get dark {
    final colors = AppColors.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Colors
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.background,
      dividerColor: colors.divider,

      // Color Scheme
      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        onPrimary: Colors.white,
        primaryContainer: colors.primarySoft,
        onPrimaryContainer: colors.primary,
        secondary: colors.primary,
        onSecondary: Colors.white,
        secondaryContainer: colors.primarySoft,
        onSecondaryContainer: colors.primary,
        surface: colors.surface,
        onSurface: colors.textPrimary,
        surfaceContainerHighest: colors.surfaceElevated,
        error: colors.error,
        onError: Colors.white,
        errorContainer: colors.errorSoft,
        onErrorContainer: colors.error,
        outline: colors.borderSoft,
        outlineVariant: colors.divider,
      ),

      // Typography
      textTheme: AppTypography.darkTextTheme,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        titleTextStyle: AppTypography.darkTextTheme.titleLarge?.copyWith(
          color: colors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: colors.textPrimary),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        color: colors.surfaceElevated,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colors.borderSoft),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: colors.primarySoft,
          disabledForegroundColor: colors.textDisabled,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceElevated,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.borderSoft),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.borderSoft),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.error, width: 2),
        ),
        hintStyle: TextStyle(color: colors.textMuted),
        labelStyle: TextStyle(color: colors.textSecondary),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.surfaceElevated,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Navigation Bar Theme (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.surfaceElevated,
        indicatorColor: colors.primarySoft,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colors.primary);
          }
          return IconThemeData(color: colors.textMuted);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              color: colors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            );
          }
          return TextStyle(color: colors.textMuted, fontSize: 12);
        }),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: colors.surface,
        selectedColor: colors.primarySoft,
        disabledColor: colors.surface,
        labelStyle: TextStyle(color: colors.textPrimary),
        side: BorderSide(color: colors.borderSoft),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primary;
          }
          return colors.textMuted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primarySoft;
          }
          return colors.borderSoft;
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        side: BorderSide(color: colors.borderSoft, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surfaceElevated,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        titleTextStyle: AppTypography.darkTextTheme.headlineSmall,
        contentTextStyle: AppTypography.darkTextTheme.bodyMedium,
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surfaceElevated,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.textPrimary,
        contentTextStyle: TextStyle(color: colors.background),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: 1,
        space: 1,
      ),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        tileColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarThemeData(
        labelColor: colors.primary,
        unselectedLabelColor: colors.textMuted,
        indicatorColor: colors.primary,
        indicatorSize: TabBarIndicatorSize.label,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colors.primary,
        linearTrackColor: colors.primarySoft,
        circularTrackColor: colors.primarySoft,
      ),
    );
  }
}
