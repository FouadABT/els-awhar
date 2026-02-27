import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../shared/widgets/floating_settings_button.dart';
import '../../../screens/enhanced_profile_screen.dart';
import '../../../screens/store/store_dashboard_screen.dart';
import '../../../screens/store/store_orders_screen.dart';
import '../../../screens/store/store_products_screen.dart';
import '../driver/dashboard/driver_dashboard_screen.dart';
import '../driver/rides/driver_rides_screen.dart';
import '../driver/earnings/driver_earnings_screen.dart';
import '../driver/messages/driver_messages_screen.dart';
import '../client/explore/explore_screen.dart';
import '../client/orders/orders_screen.dart';
import '../messages/messages_screen.dart';
import 'home_controller.dart';
import 'home_landing_screen.dart';
import '../../../core/controllers/auth_controller.dart';
import '../../../core/services/guest_auth_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../routes/app_routes.dart';

/// Main home screen with role-based bottom navigation
/// Supports guest mode - users can browse without login
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    
    return Obx(() {
      // Show loading while auth is initializing
      if (!authController.isInitialized.value) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: 16.h),
                Text(
                  'common.loading'.tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      }
      
      // GUEST MODE: Show home screen even without authentication
      // Users can browse and will be prompted to login when needed
      return Scaffold(
        body: _buildBody(context, authController),
        bottomNavigationBar: _buildBottomNavigationBar(context, authController),
      );
    });
  }

  Widget _buildBody(BuildContext context, AuthController authController) {
    final isAuthenticated = authController.isAuthenticated;
    
    // Role-based content for authenticated users
    if (isAuthenticated) {
      if (controller.isDriverMode) {
        return IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            DriverDashboardScreen(),
            DriverRidesScreen(),
            DriverEarningsScreen(),
            DriverMessagesScreen(),
            EnhancedProfileScreen(),
          ],
        );
      } else if (controller.isStoreMode) {
        // Store mode
        return IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            StoreDashboardScreen(),
            StoreOrdersScreen(),
            StoreProductsScreen(),
            MessagesScreen(),
            EnhancedProfileScreen(),
          ],
        );
      } else {
        // Client mode (authenticated)
        return IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            HomeLandingScreen(),
            ClientExploreScreen(),
            ClientOrdersScreen(),
            MessagesScreen(),
            EnhancedProfileScreen(),
          ],
        );
      }
    } else {
      // GUEST MODE: Show limited client screens
      return IndexedStack(
        index: controller.currentIndex.value,
        children: const [
          HomeLandingScreen(),
          ClientExploreScreen(),
          _GuestOrdersScreen(),      // Show login prompt
          _GuestMessagesScreen(),    // Show login prompt
          _GuestProfileScreen(),     // Show login prompt
        ],
      );
    }
  }

  Widget _buildBottomNavigationBar(BuildContext context, AuthController authController) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildNavItems(context, authController),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNavItems(BuildContext context, AuthController authController) {
    final isAuthenticated = authController.isAuthenticated;
    
    if (isAuthenticated) {
      if (controller.isDriverMode) {
        // Driver navigation
        return [
          _buildNavItem(context, 0, Iconsax.element_3, Iconsax.element_4, 'driver.dashboard.title'),
          _buildNavItem(context, 1, Iconsax.box, Iconsax.box_1, 'driver.orders.title'),
          _buildNavItem(context, 2, Iconsax.wallet_2, Iconsax.wallet, 'driver.earnings.title'),
          _buildNavItem(context, 3, Iconsax.message, Iconsax.message_copy, 'messages.title'),
          _buildNavItem(context, 4, Iconsax.profile_circle, Iconsax.profile_circle_copy, 'profile.title'),
        ];
      } else if (controller.isStoreMode) {
        // Store navigation
        return [
          _buildNavItem(context, 0, Iconsax.shop, Iconsax.shop_copy, 'store_management.title'),
          _buildNavItem(context, 1, Iconsax.box, Iconsax.box_1, 'store_management.orders'),
          _buildNavItem(context, 2, Iconsax.box_add, Iconsax.box_add_copy, 'store_management.products'),
          _buildNavItem(context, 3, Iconsax.message, Iconsax.message_copy, 'messages.title'),
          _buildNavItem(context, 4, Iconsax.profile_circle, Iconsax.profile_circle_copy, 'profile.title'),
        ];
      }
    }
    
    // Client navigation (both authenticated and guest)
    return [
      _buildNavItem(context, 0, Iconsax.home_2, Iconsax.home_1, 'home.title'),
      _buildNavItem(context, 1, Iconsax.search_normal, Iconsax.search_normal_1, 'client.explore.title'),
      _buildNavItem(context, 2, Iconsax.box, Iconsax.box_1, 'client.orders.title'),
      _buildNavItem(context, 3, Iconsax.message, Iconsax.message_copy, 'messages.title'),
      _buildNavItem(context, 4, Iconsax.profile_circle, Iconsax.profile_circle_copy, 'profile.title'),
    ];
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData outlineIcon,
    IconData filledIcon,
    String labelKey,
  ) {
    final isSelected = controller.currentIndex.value == index;
    final color = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5);

    return Expanded(
      child: InkWell(
        onTap: () => controller.changeTab(index),
        borderRadius: BorderRadius.circular(16.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.5)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? filledIcon : outlineIcon,
                color: color,
                size: 24.sp,
              ),
              SizedBox(height: 4.h),
              Text(
                labelKey.tr,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Guest placeholder for Orders screen
class _GuestOrdersScreen extends StatelessWidget {
  const _GuestOrdersScreen();

  @override
  Widget build(BuildContext context) {
    return _GuestLoginPromptScreen(
      icon: Iconsax.box,
      title: 'guest.orders_title'.tr,
      message: 'guest.orders_message'.tr,
    );
  }
}

/// Guest placeholder for Messages screen
class _GuestMessagesScreen extends StatelessWidget {
  const _GuestMessagesScreen();

  @override
  Widget build(BuildContext context) {
    return _GuestLoginPromptScreen(
      icon: Iconsax.message,
      title: 'guest.messages_title'.tr,
      message: 'guest.messages_message'.tr,
    );
  }
}

/// Guest placeholder for Profile screen
class _GuestProfileScreen extends StatelessWidget {
  const _GuestProfileScreen();

  @override
  Widget build(BuildContext context) {
    return _GuestLoginPromptScreen(
      icon: Iconsax.profile_circle,
      title: 'guest.profile_title'.tr,
      message: 'guest.profile_message'.tr,
      showRegister: true,
    );
  }
}

/// Generic login prompt screen for guests
class _GuestLoginPromptScreen extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final bool showRegister;

  const _GuestLoginPromptScreen({
    required this.icon,
    required this.title,
    required this.message,
    this.showRegister = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(32.w),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 64.sp,
                  color: colors.primary,
                ),
              ),
              SizedBox(height: 32.h),

              // Title
              Text(
                'guest.login_to_access'.tr,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),

              // Message
              Text(
                message,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48.h),

              // Sign In Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton.icon(
                  onPressed: () => Get.toNamed(AppRoutes.authLogin),
                  icon: const Icon(Iconsax.login),
                  label: Text(
                    'guest.sign_in'.tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                ),
              ),

              if (showRegister) ...[
                SizedBox(height: 16.h),
                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: OutlinedButton.icon(
                    onPressed: () => Get.toNamed(AppRoutes.authRegister),
                    icon: Icon(Iconsax.user_add, color: colors.primary),
                    label: Text(
                      'guest.create_account'.tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: colors.primary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                  ),
                ),
              ],

              SizedBox(height: 24.h),

              // Continue browsing
              TextButton(
                onPressed: () {
                  // Go back to explore tab
                  final homeController = Get.find<HomeController>();
                  homeController.changeTab(1); // Explore tab
                },
                child: Text(
                  'guest.continue_browsing'.tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
