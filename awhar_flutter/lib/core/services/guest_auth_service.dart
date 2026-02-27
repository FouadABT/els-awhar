import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../controllers/auth_controller.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../../app/routes/app_routes.dart';

/// Service to handle guest mode and lazy authentication
/// 
/// This service provides:
/// - Check if user is guest (not logged in)
/// - Show login prompts when actions require auth
/// - Navigate to login with return path
/// - Store pending action for after login
class GuestAuthService extends GetxService {
  /// Pending deep link or action to execute after login
  String? _pendingRoute;
  Map<String, dynamic>? _pendingArguments;

  /// Check if user is currently a guest (not authenticated)
  bool get isGuest {
    final authController = Get.find<AuthController>();
    return !authController.isAuthenticated;
  }

  /// Check if user is authenticated
  bool get isAuthenticated {
    final authController = Get.find<AuthController>();
    return authController.isAuthenticated;
  }

  /// Set pending route to navigate to after login
  void setPendingRoute(String route, [Map<String, dynamic>? arguments]) {
    _pendingRoute = route;
    _pendingArguments = arguments;
  }

  /// Get and clear pending route
  String? consumePendingRoute() {
    final route = _pendingRoute;
    _pendingRoute = null;
    return route;
  }

  /// Get and clear pending arguments
  Map<String, dynamic>? consumePendingArguments() {
    final args = _pendingArguments;
    _pendingArguments = null;
    return args;
  }

  /// Check if there's a pending route
  bool get hasPendingRoute => _pendingRoute != null;

  /// Require authentication for an action
  /// 
  /// Returns true if user is authenticated, false if redirected to login.
  /// Use this for actions that require login.
  /// 
  /// Example:
  /// ```dart
  /// if (!guestAuthService.requireAuth(
  ///   context: context,
  ///   action: 'guest.action_create_request',
  ///   returnRoute: '/client/create-request',
  /// )) {
  ///   return; // User will be prompted to login
  /// }
  /// // Continue with authenticated action
  /// ```
  bool requireAuth({
    required BuildContext context,
    required String action,
    String? returnRoute,
    Map<String, dynamic>? returnArguments,
  }) {
    if (isAuthenticated) {
      return true;
    }

    // Store return route for after login
    if (returnRoute != null) {
      setPendingRoute(returnRoute, returnArguments);
    }

    // Show login prompt
    showLoginPrompt(context: context, action: action);
    return false;
  }

  /// Show a beautiful login prompt dialog
  void showLoginPrompt({
    required BuildContext context,
    required String action,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: colors.primarySoft,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.login,
                  size: 48.sp,
                  color: colors.primary,
                ),
              ),
              SizedBox(height: 24.h),

              // Title
              Text(
                'guest.login_required'.tr,
                style: AppTypography.headlineSmall(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),

              // Message with action
              Text(
                action.tr,
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'guest.login_benefits'.tr,
                style: AppTypography.bodySmall(context).copyWith(
                  color: colors.textMuted,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),

              // Benefits list
              _buildBenefitItem(context, colors, Iconsax.security_safe, 'guest.benefit_secure'.tr),
              SizedBox(height: 12.h),
              _buildBenefitItem(context, colors, Iconsax.message, 'guest.benefit_chat'.tr),
              SizedBox(height: 12.h),
              _buildBenefitItem(context, colors, Iconsax.clock, 'guest.benefit_track'.tr),
              SizedBox(height: 32.h),

              // Buttons
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.toNamed(AppRoutes.authLogin);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'guest.sign_in'.tr,
                    style: AppTypography.labelLarge(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: OutlinedButton(
                  onPressed: () {
                    Get.back();
                    Get.toNamed(AppRoutes.authRegister);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors.primary,
                    side: BorderSide(color: colors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    'guest.create_account'.tr,
                    style: AppTypography.labelLarge(context).copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'guest.continue_browsing'.tr,
                  style: AppTypography.labelMedium(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  Widget _buildBenefitItem(
    BuildContext context,
    AppColorScheme colors,
    IconData icon,
    String text,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: colors.success),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: AppTypography.bodySmall(context).copyWith(
              color: colors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  /// Show a simple snackbar prompting login
  void showLoginSnackbar({String? message}) {
    Get.snackbar(
      'guest.login_required'.tr,
      message ?? 'guest.login_to_continue'.tr,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 4),
      mainButton: TextButton(
        onPressed: () {
          Get.closeCurrentSnackbar();
          Get.toNamed(AppRoutes.authLogin);
        },
        child: Text(
          'guest.sign_in'.tr,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// Navigate to login and return to current route after success
  void navigateToLoginWithReturn() {
    final currentRoute = Get.currentRoute;
    setPendingRoute(currentRoute);
    Get.toNamed(AppRoutes.authLogin);
  }

  /// Process pending navigation after successful login
  void processPendingNavigation() {
    if (hasPendingRoute) {
      final route = consumePendingRoute();
      final args = consumePendingArguments();
      if (route != null) {
        debugPrint('[GuestAuthService] Processing pending route: $route');
        Get.offAllNamed(route, arguments: args);
      }
    }
  }
}
