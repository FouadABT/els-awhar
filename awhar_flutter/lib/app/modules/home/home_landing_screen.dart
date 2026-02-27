import 'package:awhar_client/awhar_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/controllers/auth_controller.dart';
import '../../../core/controllers/driver_status_controller.dart';
import '../../../core/controllers/service_catalog_controller.dart';
import '../../../core/controllers/request_controller.dart';
import '../../../core/controllers/client_store_order_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency_helper.dart';
import '../../../shared/widgets/promo_banner_widget.dart';
import '../../routes/app_routes.dart';
import 'home_controller.dart';

class HomeLandingScreen extends StatelessWidget {
  const HomeLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final authController = Get.find<AuthController>();

    return Obx(() {
      final isDriver = authController.primaryRole == UserRole.driver;
      return Scaffold(
        backgroundColor: colors.background,
        body: isDriver
            ? _DriverHomeLanding(colors: colors)
            : _ClientHomeLanding(colors: colors),
      );
    });
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Driver Home Landing
// ═══════════════════════════════════════════════════════════════════════════

class _DriverHomeLanding extends StatelessWidget {
  final AppColorScheme colors;

  const _DriverHomeLanding({required this.colors});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final userName = authController.currentUser.value?.fullName ?? 'Driver';

    // Initialize DriverStatusController if not already
    if (!Get.isRegistered<DriverStatusController>()) {
      Get.put(DriverStatusController());
    }
    final statusController = Get.find<DriverStatusController>();

    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          // Greeting Header
          _buildGreetingHeader(context, userName),
          SizedBox(height: 16.h),

          // Promo Banners
          const PromoBannerWidget(userRole: 'driver'),
          SizedBox(height: 16.h),

          // Online/Offline Toggle Card
          _buildOnlineToggleCard(context, colors, statusController),
          SizedBox(height: 24.h),

          // Quick Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  colors: colors,
                  context: context,
                  icon: Iconsax.car,
                  label: 'driver.stats.trips_today'.tr,
                  value: '8',
                  color: colors.primary,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildStatCard(
                  colors: colors,
                  context: context,
                  icon: Iconsax.wallet_2,
                  label: 'Today\'s Earnings',
                  value: '₫420',
                  color: colors.success,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  colors: colors,
                  context: context,
                  icon: Iconsax.clock,
                  label: 'driver.stats.hours_online'.tr,
                  value: '6.5h',
                  color: colors.info,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildStatCard(
                  colors: colors,
                  context: context,
                  icon: Iconsax.star,
                  label: 'driver.stats.rating'.tr,
                  value: '4.8',
                  color: colors.warning,
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          // Action Buttons Row
          Row(
            children: [
              // Find Requests Button
              Expanded(
                child: SizedBox(
                  height: 56.h,
                  child: ElevatedButton.icon(
                    onPressed: () => Get.toNamed('/driver/available-requests'),
                    icon: Icon(Iconsax.search_normal, color: Colors.white, size: 20.sp),
                    label: Text(
                      'Find Requests',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Store Deliveries Button
              Expanded(
                child: SizedBox(
                  height: 56.h,
                  child: ElevatedButton.icon(
                    onPressed: () => Get.toNamed('/driver/store-requests'),
                    icon: Icon(Iconsax.box_tick, color: Colors.white, size: 20.sp),
                    label: Text(
                      'Store Deliveries',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.info,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          // Active Ride Alert (if any)
          _buildActiveRideAlert(context, colors),

          SizedBox(height: 24.h),

          // Recent Activity
          _buildSectionHeader(context, 'Recent Activity'),
          SizedBox(height: 12.h),
          _buildRecentActivityList(context, colors),

          SizedBox(height: 24.h),

          // Quick Actions
          _buildSectionHeader(context, 'Quick Actions'),
          SizedBox(height: 12.h),
          _buildQuickActions(context, colors),
        ],
      ),
    );
  }

  Widget _buildGreetingHeader(BuildContext context, String userName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getGreeting(),
          style: AppTypography.bodyLarge(context).copyWith(
            color: colors.textSecondary,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          userName,
          style: AppTypography.headlineSmall(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'home.greeting_morning'.tr;
    if (hour < 17) return 'home.greeting_afternoon'.tr;
    return 'home.greeting_evening'.tr;
  }

  Widget _buildStatCard({
    required AppColorScheme colors,
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24.sp),
          SizedBox(height: 12.h),
          Text(
            value,
            style: AppTypography.headlineMedium(context).copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: AppTypography.bodySmall(context).copyWith(
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveRideAlert(BuildContext context, AppColorScheme colors) {
    // Sample data - replace with actual active ride
    final hasActiveRide = false;

    if (!hasActiveRide) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary, colors.primaryHover],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Icon(Iconsax.car, color: Colors.white, size: 32.sp),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Active Ride',
                  style: AppTypography.titleMedium(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'To Airport • 12 km',
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          Icon(Iconsax.arrow_right_3, color: Colors.white, size: 24.sp),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: AppTypography.titleLarge(context).copyWith(
        color: colors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildRecentActivityList(BuildContext context, AppColorScheme colors) {
    final activities = [
      {
        'time': '2 hours ago',
        'title': 'Completed ride to Airport',
        'amount': '+₫85',
      },
      {
        'time': '4 hours ago',
        'title': 'Completed ride to Mall',
        'amount': '+₫45',
      },
      {'time': 'Yesterday', 'title': 'Weekly bonus unlocked', 'amount': '+₫50'},
    ];

    return Column(
      children: activities
          .map((activity) => _buildActivityItem(context, colors, activity))
          .toList(),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    AppColorScheme colors,
    Map<String, String> activity,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title']!,
                  style: AppTypography.bodyLarge(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  activity['time']!,
                  style: AppTypography.bodySmall(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            activity['amount']!,
            style: AppTypography.titleMedium(context).copyWith(
              color: colors.success,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, AppColorScheme colors) {
    final actions = [
      {
        'icon': Iconsax.box_tick,
        'label': 'Store Deliveries',
        'route': '/driver/store-requests',
      },
      {
        'icon': Iconsax.wallet_2,
        'label': 'Earnings',
        'route': '/driver/wallet',
      },
      {
        'icon': Iconsax.setting_2,
        'label': 'Settings',
        'route': '/driver/settings',
      },
      {'icon': Iconsax.chart, 'label': 'Statistics', 'route': null},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions
          .map((action) => _buildQuickActionItem(context, colors, action))
          .toList(),
    );
  }

  Widget _buildQuickActionItem(
    BuildContext context,
    AppColorScheme colors,
    Map<String, dynamic> action,
  ) {
    return GestureDetector(
      onTap: () {
        final route = action['route'] as String?;
        if (route != null) {
          Get.toNamed(route);
        }
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 64.w) / 4,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: colors.border),
        ),
        child: Column(
          children: [
            Icon(action['icon'], color: colors.primary, size: 28.sp),
            SizedBox(height: 8.h),
            Text(
              action['label'],
              style: AppTypography.bodySmall(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w500,
                fontSize: 10.sp,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnlineToggleCard(
    BuildContext context,
    AppColorScheme colors,
    DriverStatusController statusController,
  ) {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: statusController.isOnline.value
                ? [colors.success, colors.success.withValues(alpha: 0.8)]
                : [colors.surface, colors.surface],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: statusController.isOnline.value
                ? colors.success
                : colors.border,
            width: 2,
          ),
          boxShadow: statusController.isOnline.value
              ? [
                  BoxShadow(
                    color: colors.success.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            // Status Indicator
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: statusController.isOnline.value
                    ? Colors.white.withValues(alpha: 0.2)
                    : colors.border,
                shape: BoxShape.circle,
              ),
              child: Icon(
                statusController.isOnline.value
                    ? Iconsax.tick_circle
                    : Iconsax.close_circle,
                color: statusController.isOnline.value
                    ? Colors.white
                    : colors.textSecondary,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),

            // Status Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statusController.isOnline.value
                        ? 'You\'re Online'
                        : 'You\'re Offline',
                    style: AppTypography.titleMedium(context).copyWith(
                      color: statusController.isOnline.value
                          ? Colors.white
                          : colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    statusController.isOnline.value
                        ? 'Ready to receive requests'
                        : 'Go online to receive requests',
                    style: AppTypography.bodySmall(context).copyWith(
                      color: statusController.isOnline.value
                          ? Colors.white.withValues(alpha: 0.9)
                          : colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Toggle Switch
            statusController.isLoading.value
                ? SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: statusController.isOnline.value
                          ? Colors.white
                          : colors.primary,
                    ),
                  )
                : Switch(
                    value: statusController.isOnline.value,
                    onChanged: (_) => statusController.toggleStatus(),
                    activeColor: Colors.white,
                    activeTrackColor: colors.success.withValues(alpha: 0.5),
                    inactiveThumbColor: colors.textSecondary,
                    inactiveTrackColor: colors.border,
                  ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Client Home Landing
// ═══════════════════════════════════════════════════════════════════════════

class _ClientHomeLanding extends StatelessWidget {
  final AppColorScheme colors;

  const _ClientHomeLanding({required this.colors});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final userName = authController.currentUser.value?.fullName ?? 'Client';

    // Initialize controllers if not already registered
    if (!Get.isRegistered<ServiceCatalogController>()) {
      Get.lazyPut(() => ServiceCatalogController());
    }
    if (!Get.isRegistered<RequestController>()) {
      Get.lazyPut(() => RequestController());
    }

    final serviceCatalogController = Get.find<ServiceCatalogController>();
    final requestController = Get.find<RequestController>();

    // Load data on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (serviceCatalogController.drivers.isEmpty) {
        serviceCatalogController.loadNearbyDrivers();
      }
      if (requestController.requestHistory.isEmpty) {
        requestController.loadRequestHistory();
      }
    });

    return SafeArea(
      child: RefreshIndicator(
        color: colors.primary,
        onRefresh: () async {
          await Future.wait([
            serviceCatalogController.loadCategories(),
            serviceCatalogController.loadNearbyDrivers(),
            requestController.loadRequestHistory(),
          ]);
        },
        child: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            // Greeting Header
            _buildGreetingHeader(context, userName),
            SizedBox(height: 16.h),

            // Promo Banners
            const PromoBannerWidget(userRole: 'client'),
            SizedBox(height: 16.h),

            // Create Request Button
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton.icon(
                onPressed: () => Get.toNamed('/client/create-request'),
                icon: const Icon(Iconsax.add_circle, color: Colors.white),
                label: Text(
                  'Create New Request',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 2,
                ),
              ),
            ),

            SizedBox(height: 12.h),

            // AI Concierge Button
            _buildAiConciergeCard(context, colors),

            SizedBox(height: 24.h),

            // Browse Stores Section
            _buildBrowseStoresSection(context, colors),

            SizedBox(height: 24.h),

            // Service Categories (Dynamic)
            _buildSectionHeader(
              context,
              'Services',
              onSeeAll: () {
                Get.find<HomeController>().changeTab(1);
              },
            ),
            SizedBox(height: 12.h),
            _buildDynamicServiceCategories(context, colors),

            SizedBox(height: 24.h),

            // Popular Drivers (Dynamic)
            _buildSectionHeader(
              context,
              'Nearby Drivers',
              onSeeAll: () {
                Get.find<HomeController>().changeTab(1);
              },
            ),
            SizedBox(height: 12.h),
            _buildDynamicDriversList(context, colors, serviceCatalogController),

            SizedBox(height: 24.h),

            // Recent Orders (Dynamic)
            _buildSectionHeader(
              context,
              'Recent Orders',
              onSeeAll: () {
                Get.find<HomeController>().changeTab(2);
              },
            ),
            SizedBox(height: 12.h),
            _buildDynamicOrdersList(context, colors, requestController, Get.find<ClientStoreOrdersController>()),
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingHeader(BuildContext context, String userName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getGreeting(),
          style: AppTypography.bodyLarge(context).copyWith(
            color: colors.textSecondary,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          userName,
          style: AppTypography.headlineSmall(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'home.greeting_morning'.tr;
    if (hour < 17) return 'home.greeting_afternoon'.tr;
    return 'home.greeting_evening'.tr;
  }

  Widget _buildAiConciergeCard(BuildContext context, AppColorScheme colors) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.aiConcierge),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colors.primary.withValues(alpha: 0.15),
              colors.primary.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: colors.primary.withValues(alpha: 0.25),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 46.w,
              height: 46.w,
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.auto_awesome,
                color: colors.primary,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'concierge_home.title'.tr,
                    style: AppTypography.titleSmall(context).copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'concierge_home.subtitle'.tr,
                    style: AppTypography.labelSmall(context).copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: colors.primary,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title, {
    VoidCallback? onSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTypography.titleLarge(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: Text(
            'See All',
            style: TextStyle(color: colors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicServiceCategories(
    BuildContext context,
    AppColorScheme colors,
  ) {
    final controller = Get.find<ServiceCatalogController>();

    // Map service category names to Iconsax icons
    final categoryIconMap = {
      'Transportation & Rides': Iconsax.car,
      'Delivery Services': Iconsax.box,
      'Shopping & Errands': Iconsax.shopping_cart,
      'Moving & Transport': Iconsax.truck,
      'Food & Restaurant Delivery': Iconsax.coffee,
      'Professional Services': Iconsax.briefcase,
      'Home Services': Iconsax.home,
      'Health & Wellness': Iconsax.heart,
      'Beauty & Personal Care': Iconsax.brush,
      'Pet Services': Iconsax.star,
    };

    // Dynamic color palette based on category
    final Color Function(int) getColorForIndex = (index) {
      final colors_list = [
        colors.primary,
        colors.info,
        colors.warning,
        colors.success,
        colors.error,
      ];
      return colors_list[index % colors_list.length];
    };

    return Obx(() {
      if (controller.isLoadingCategories.value) {
        return SizedBox(
          height: 120.h,
          child: Center(
            child: CircularProgressIndicator(color: colors.primary),
          ),
        );
      }

      final categories = controller.categories;

      if (categories.isEmpty) {
        return SizedBox(
          height: 120.h,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.category,
                  size: 40.sp,
                  color: colors.textSecondary.withValues(alpha: 0.5),
                ),
                SizedBox(height: 12.h),
                Text(
                  'No services available',
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return SizedBox(
        height: 120.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final icon = categoryIconMap[category.name] ?? Iconsax.box;
            final color = getColorForIndex(index);

            return _buildModernServiceCard(
              context,
              colors,
              category: category,
              icon: icon,
              color: color,
            );
          },
        ),
      );
    });
  }

  // ============================================================
  // BROWSE STORES SECTION
  // ============================================================

  Widget _buildBrowseStoresSection(
    BuildContext context,
    AppColorScheme colors,
  ) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.clientStores),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colors.primary.withValues(alpha: 0.9),
              colors.primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: colors.primary.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Iconsax.shop,
                color: Colors.white,
                size: 28.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'client.home.browse_stores'.tr,
                    style: AppTypography.titleMedium(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'client.home.browse_stores_subtitle'.tr,
                    style: AppTypography.bodySmall(context).copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Iconsax.arrow_right_3,
              color: Colors.white,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernServiceCard(
    BuildContext context,
    AppColorScheme colors, {
    required ServiceCategory category,
    required IconData icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        // Select category and switch to Explore tab
        Get.find<ServiceCatalogController>().selectCategory(category);
        Get.find<HomeController>().changeTab(1);
      },
      child: Container(
        width: 100.w,
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                category.name,
                style: AppTypography.bodySmall(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DYNAMIC DRIVERS LIST
  // ============================================================

  Widget _buildDynamicDriversList(
    BuildContext context,
    AppColorScheme colors,
    ServiceCatalogController controller,
  ) {
    return Obx(() {
      if (controller.isLoadingDrivers.value) {
        return SizedBox(
          height: 160.h,
          child: Center(
            child: CircularProgressIndicator(color: colors.primary),
          ),
        );
      }

      final drivers = controller.drivers.take(3).toList();

      if (drivers.isEmpty) {
        return Container(
          height: 120.h,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: colors.border),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.user_search,
                  size: 32.sp,
                  color: colors.textSecondary.withValues(alpha: 0.5),
                ),
                SizedBox(height: 8.h),
                Text(
                  'No drivers nearby',
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Try adjusting your location',
                  style: AppTypography.bodySmall(context).copyWith(
                    color: colors.textSecondary.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Column(
        children: drivers
            .map((driver) => _buildDynamicDriverCard(context, colors, driver))
            .toList(),
      );
    });
  }

  Widget _buildDynamicDriverCard(
    BuildContext context,
    AppColorScheme colors,
    DriverProfile driver,
  ) {
    final rating = driver.ratingAverage.toStringAsFixed(1);
    final trips = driver.totalCompletedOrders;
    final isOnline = driver.isOnline;

    return GestureDetector(
      onTap: () {
        // Navigate to driver profile or explore tab
        Get.find<HomeController>().changeTab(1);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: colors.border),
        ),
        child: Row(
          children: [
            // Avatar with online indicator
            Stack(
              children: [
                if (driver.profilePhotoUrl != null &&
                    driver.profilePhotoUrl!.isNotEmpty)
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: driver.profilePhotoUrl!,
                      width: 48.w,
                      height: 48.w,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => CircleAvatar(
                        radius: 24.r,
                        backgroundColor: colors.primarySoft,
                        child: Icon(Iconsax.user, color: colors.primary),
                      ),
                      errorWidget: (context, url, error) => CircleAvatar(
                        radius: 24.r,
                        backgroundColor: colors.primarySoft,
                        child: Icon(Iconsax.user, color: colors.primary),
                      ),
                    ),
                  )
                else
                  CircleAvatar(
                    radius: 24.r,
                    backgroundColor: colors.primarySoft,
                    child: Icon(Iconsax.user, color: colors.primary),
                  ),
                if (isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: colors.success,
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.surface, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          driver.displayName,
                          style: AppTypography.titleMedium(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isOnline)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: colors.successSoft,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'Online',
                            style: AppTypography.labelSmall(context).copyWith(
                              color: colors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Iconsax.star, color: colors.warning, size: 14.sp),
                      SizedBox(width: 4.w),
                      Text(
                        '$rating • $trips trips',
                        style: AppTypography.bodySmall(context).copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            ElevatedButton(
              onPressed: () {
                // Navigate to explore with this driver selected
                Get.find<HomeController>().changeTab(1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                minimumSize: Size.zero,
              ),
              child: Text(
                'View',
                style: TextStyle(fontSize: 12.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DYNAMIC ORDERS LIST
  // ============================================================

  Widget _buildDynamicOrdersList(
    BuildContext context,
    AppColorScheme colors,
    RequestController requestController,
    ClientStoreOrdersController storeOrderController,
  ) {
    return Obx(() {
      // Combine service requests and store orders
      final activeRequests = requestController.activeRequests;
      final requestHistory = requestController.requestHistory.take(2).toList();
      final activeStoreOrders = storeOrderController.activeOrders.take(2).toList();
      final completedStoreOrders = storeOrderController.completedOrders.take(2).toList();
      
      // Create a combined list with mixed items (limit to 4 total)
      final List<dynamic> combinedOrders = [
        ...activeRequests,
        ...activeStoreOrders,
        ...requestHistory,
        ...completedStoreOrders,
      ].take(4).toList();

      if (combinedOrders.isEmpty) {
        return Container(
          height: 120.h,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: colors.border),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.box,
                  size: 32.sp,
                  color: colors.textSecondary.withValues(alpha: 0.5),
                ),
                SizedBox(height: 8.h),
                Text(
                  'No orders yet',
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Create your first request',
                  style: AppTypography.bodySmall(context).copyWith(
                    color: colors.textSecondary.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Column(
        children: combinedOrders
            .map((order) => order is ServiceRequest
                ? _buildDynamicOrderCard(context, colors, order)
                : _buildStoreOrderCard(context, colors, order as StoreOrder))
            .toList(),
      );
    });
  }

  Widget _buildDynamicOrderCard(
    BuildContext context,
    AppColorScheme colors,
    ServiceRequest order,
  ) {
    // Determine status styling
    final isActive =
        order.status == RequestStatus.pending ||
        order.status == RequestStatus.accepted ||
        order.status == RequestStatus.in_progress;
    final isCompleted = order.status == RequestStatus.completed;
    final isCancelled = order.status == RequestStatus.cancelled;

    final statusColor = isActive
        ? colors.info
        : isCompleted
        ? colors.success
        : isCancelled
        ? colors.error
        : colors.textSecondary;

    final statusIcon = isActive
        ? Iconsax.timer_1
        : isCompleted
        ? Iconsax.tick_circle
        : isCancelled
        ? Iconsax.close_circle
        : Iconsax.box;

    final statusText = _getStatusText(order.status);
    final destination =
        order.destinationLocation?.placeName ??
        order.destinationLocation?.address ??
        'Destination';
    final date = _formatDate(order.createdAt);
    final amount = order.agreedPrice ?? order.clientOfferedPrice ?? 0.0;

    return GestureDetector(
      onTap: () {
        // Navigate to order details
        Get.find<HomeController>().changeTab(2);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: colors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 4.w,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14.r),
                      bottomLeft: Radius.circular(14.r),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(statusIcon, color: statusColor, size: 14.sp),
                            SizedBox(width: 6.w),
                            Text(
                              statusText,
                              style: AppTypography.labelSmall(context).copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      if (amount > 0)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: colors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Iconsax.wallet_2, color: colors.primary, size: 14.sp),
                              SizedBox(width: 6.w),
                              Text(
                                CurrencyHelper.format(amount),
                                style: AppTypography.labelSmall(context).copyWith(
                                  color: colors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Icon(Iconsax.location, color: colors.primary, size: 16.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          destination,
                          style: AppTypography.bodyLarge(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Iconsax.arrow_right_3, size: 16.sp, color: colors.textSecondary),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(Iconsax.calendar_1, size: 14.sp, color: colors.textSecondary),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          date,
                          style: AppTypography.bodySmall(context).copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                      Text(
                        'See details',
                        style: AppTypography.labelSmall(context).copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreOrderCard(
    BuildContext context,
    AppColorScheme colors,
    StoreOrder order,
  ) {
    // Determine status styling
    final isActive =
        order.status == StoreOrderStatus.pending ||
        order.status == StoreOrderStatus.confirmed ||
        order.status == StoreOrderStatus.preparing ||
        order.status == StoreOrderStatus.ready ||
        order.status == StoreOrderStatus.driverAssigned ||
        order.status == StoreOrderStatus.pickedUp ||
        order.status == StoreOrderStatus.inDelivery;
    final isCompleted = order.status == StoreOrderStatus.delivered;
    final isCancelled = order.status == StoreOrderStatus.cancelled;

    final statusColor = isActive
        ? colors.info
        : isCompleted
        ? colors.success
        : isCancelled
        ? colors.error
        : colors.textSecondary;

    final statusIcon = isActive
        ? Iconsax.timer_1
        : isCompleted
        ? Iconsax.tick_circle
        : isCancelled
        ? Iconsax.close_circle
        : Iconsax.shop;

    final statusText = _getStoreStatusText(order.status);
    final date = _formatDate(order.createdAt);

    return GestureDetector(
      onTap: () {
        // Navigate to store order detail with order ID
        Get.toNamed(AppRoutes.clientStoreOrder, arguments: order.id);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: colors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 4.w,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14.r),
                      bottomLeft: Radius.circular(14.r),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(statusIcon, color: statusColor, size: 14.sp),
                            SizedBox(width: 6.w),
                            Text(
                              statusText,
                              style: AppTypography.labelSmall(context).copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Iconsax.wallet_2, color: colors.primary, size: 14.sp),
                            SizedBox(width: 6.w),
                            Text(
                              CurrencyHelper.format(order.total),
                              style: AppTypography.labelSmall(context).copyWith(
                                color: colors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Icon(Iconsax.shop, color: colors.primary, size: 16.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'Store Order #${order.orderNumber}',
                          style: AppTypography.bodyLarge(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Iconsax.arrow_right_3, size: 16.sp, color: colors.textSecondary),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(Iconsax.calendar_1, size: 14.sp, color: colors.textSecondary),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          date,
                          style: AppTypography.bodySmall(context).copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                      Text(
                        'See details',
                        style: AppTypography.labelSmall(context).copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusText(RequestStatus? status) {
    switch (status) {
      case RequestStatus.pending:
        return 'Pending';
      case RequestStatus.accepted:
        return 'Accepted';
      case RequestStatus.in_progress:
        return 'In Progress';
      case RequestStatus.completed:
        return 'Completed';
      case RequestStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  String _getStoreStatusText(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.pending:
        return 'Pending';
      case StoreOrderStatus.confirmed:
        return 'Confirmed';
      case StoreOrderStatus.preparing:
        return 'Preparing';
      case StoreOrderStatus.ready:
        return 'Ready';
      case StoreOrderStatus.driverAssigned:
        return 'Driver Assigned';
      case StoreOrderStatus.pickedUp:
        return 'Picked Up';
      case StoreOrderStatus.inDelivery:
        return 'In Delivery';
      case StoreOrderStatus.delivered:
        return 'Delivered';
      case StoreOrderStatus.cancelled:
        return 'Cancelled';
      case StoreOrderStatus.rejected:
        return 'Rejected';
      default:
        return 'Unknown';
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';

    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
