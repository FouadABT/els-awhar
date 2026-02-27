import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// App typography configuration
abstract class AppTypography {
  /// Get text theme for light mode
  static TextTheme get lightTextTheme => _buildTextTheme(const Color(0xFF0F2F2E));

  /// Get text theme for dark mode
  static TextTheme get darkTextTheme => _buildTextTheme(const Color(0xFFF4FFFD));

  /// Build text theme with specified color
  static TextTheme _buildTextTheme(Color textColor) {
    return TextTheme(
      // Display styles - for hero text, large headlines
      displayLarge: GoogleFonts.poppins(
        fontSize: 57.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        color: textColor,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 45.sp,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 36.sp,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),

      // Headline styles - for section headers
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32.sp,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),

      // Title styles - for cards, dialogs, list items
      titleLarge: GoogleFonts.poppins(
        fontSize: 22.sp,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: textColor,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: textColor,
      ),

      // Body styles - for main content
      bodyLarge: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: textColor,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: textColor,
      ),

      // Label styles - for buttons, chips, captions
      labelLarge: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: textColor,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: textColor,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: textColor,
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPER METHODS - Convenient access to text styles with context
  // ═══════════════════════════════════════════════════════════════════════════

  static TextStyle _fallback(BuildContext context) =>
      TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.onSurface);

  /// Display styles
  static TextStyle displayLarge(BuildContext context) =>
      Theme.of(context).textTheme.displayLarge ?? _fallback(context);
  static TextStyle displayMedium(BuildContext context) =>
      Theme.of(context).textTheme.displayMedium ?? _fallback(context);
  static TextStyle displaySmall(BuildContext context) =>
      Theme.of(context).textTheme.displaySmall ?? _fallback(context);

  /// Headline styles
  static TextStyle headlineLarge(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge ?? _fallback(context);
  static TextStyle headlineMedium(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium ?? _fallback(context);
  static TextStyle headlineSmall(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall ?? _fallback(context);

  /// Title styles
  static TextStyle titleLarge(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge ?? _fallback(context);
  static TextStyle titleMedium(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium ?? _fallback(context);
  static TextStyle titleSmall(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall ?? _fallback(context);

  /// Body styles
  static TextStyle bodyLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge ?? _fallback(context);
  static TextStyle bodyMedium(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium ?? _fallback(context);
  static TextStyle bodySmall(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall ?? _fallback(context);

  /// Label styles
  static TextStyle labelLarge(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge ?? _fallback(context);
  static TextStyle labelMedium(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium ?? _fallback(context);
  static TextStyle labelSmall(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall ?? _fallback(context);
}
