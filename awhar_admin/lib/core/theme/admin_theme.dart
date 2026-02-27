import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'admin_colors.dart';

/// Admin dashboard theme configuration
class AdminTheme {
  AdminTheme._();

  // ═══════════════════════════════════════════════════════════════════════════
  // LIGHT THEME
  // ═══════════════════════════════════════════════════════════════════════════

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AdminColors.primary,
      scaffoldBackgroundColor: AdminColors.backgroundLight,
      dividerColor: AdminColors.dividerLight,
      colorScheme: ColorScheme.light(
        primary: AdminColors.primary,
        onPrimary: Colors.white,
        primaryContainer: AdminColors.primarySoft,
        secondary: AdminColors.primary,
        surface: AdminColors.surfaceLight,
        onSurface: AdminColors.textPrimaryLight,
        error: AdminColors.error,
        onError: Colors.white,
      ),
      textTheme: _buildTextTheme(AdminColors.textPrimaryLight),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AdminColors.surfaceElevatedLight,
        foregroundColor: AdminColors.textPrimaryLight,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AdminColors.textPrimaryLight,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: AdminColors.surfaceElevatedLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AdminColors.borderSoftLight),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AdminColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AdminColors.primary,
          side: const BorderSide(color: AdminColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AdminColors.surfaceElevatedLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AdminColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AdminColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AdminColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      dataTableTheme: DataTableThemeData(
        headingTextStyle: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AdminColors.textSecondaryLight,
        ),
        dataTextStyle: GoogleFonts.inter(
          fontSize: 13,
          color: AdminColors.textPrimaryLight,
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DARK THEME
  // ═══════════════════════════════════════════════════════════════════════════

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AdminColors.primary,
      scaffoldBackgroundColor: AdminColors.backgroundDark,
      dividerColor: AdminColors.dividerDark,
      colorScheme: ColorScheme.dark(
        primary: AdminColors.primary,
        onPrimary: Colors.white,
        primaryContainer: AdminColors.primarySoft,
        secondary: AdminColors.primary,
        surface: AdminColors.surfaceDark,
        onSurface: AdminColors.textPrimaryDark,
        error: AdminColors.error,
        onError: Colors.white,
      ),
      textTheme: _buildTextTheme(AdminColors.textPrimaryDark),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AdminColors.surfaceElevatedDark,
        foregroundColor: AdminColors.textPrimaryDark,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AdminColors.textPrimaryDark,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: AdminColors.surfaceElevatedDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AdminColors.borderSoftDark),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AdminColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AdminColors.surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AdminColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AdminColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AdminColors.primary, width: 2),
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme(Color textColor) {
    return TextTheme(
      displayLarge: GoogleFonts.poppins(fontSize: 48, fontWeight: FontWeight.bold, color: textColor),
      displayMedium: GoogleFonts.poppins(fontSize: 36, fontWeight: FontWeight.bold, color: textColor),
      displaySmall: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: textColor),
      headlineLarge: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600, color: textColor),
      headlineMedium: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: textColor),
      headlineSmall: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: textColor),
      titleLarge: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: textColor),
      titleMedium: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: textColor),
      titleSmall: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: textColor),
      bodyLarge: GoogleFonts.inter(fontSize: 16, color: textColor),
      bodyMedium: GoogleFonts.inter(fontSize: 14, color: textColor),
      bodySmall: GoogleFonts.inter(fontSize: 12, color: textColor),
      labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: textColor),
      labelMedium: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: textColor),
      labelSmall: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500, color: textColor),
    );
  }
}
