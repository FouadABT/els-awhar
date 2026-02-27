import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_flutter/core/theme/app_colors.dart';
import 'package:awhar_flutter/core/theme/app_typography.dart';
import 'package:awhar_flutter/core/controllers/driver_status_controller.dart';
import 'package:awhar_flutter/core/controllers/driver_services_controller.dart';
import 'package:awhar_flutter/shared/widgets/notification_bell.dart';

/// Driver dashboard screen showing ride requests, earnings, and status
class DriverDashboardScreen extends StatefulWidget {
  const DriverDashboardScreen({super.key});

  @override
  State<DriverDashboardScreen> createState() => _DriverDashboardScreenState();
}

class _DriverDashboardScreenState extends State<DriverDashboardScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('\n🚗 === DRIVER DASHBOARD INITIALIZED ===');
    
    // Ensure services are loaded when dashboard is shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final servicesController = Get.find<DriverServicesController>();
      debugPrint('📊 Post-frame callback - Loading services...');
      servicesController.loadMyServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header with online status toggle
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and notification bell
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'driver.dashboard.title'.tr,
                          style: AppTypography.headlineLarge(context).copyWith(color: colors.textPrimary),
                        ),
                        const NotificationBell(),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    // Subtitle and online toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'driver.dashboard.subtitle'.tr,
                          style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary),
                        ),
                        _OnlineStatusToggle(colors: colors),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Today's earnings summary
            SliverToBoxAdapter(
              child: _EarningsCard(colors: colors),
            ),

            // Quick stats
            SliverToBoxAdapter(
              child: _QuickStats(colors: colors),
            ),

            // My Services Card
            SliverToBoxAdapter(
              child: _MyServicesCard(colors: colors),
            ),

            // Catalog Requests Button (NEW)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: _CatalogRequestsButton(colors: colors),
              ),
            ),

            // Action Buttons Row (Store Deliveries + Find Available)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Row(
                  children: [
                    // Store Deliveries Button
                    Expanded(
                      child: SizedBox(
                        height: 56.h,
                        child: ElevatedButton.icon(
                          onPressed: () => Get.toNamed('/driver/store-requests'),
                          icon: Icon(Iconsax.box_tick, color: Colors.white, size: 20.sp),
                          label: Text(
                            'Store Deliveries',
                            style: AppTypography.bodyMedium(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.info,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 3,
                            shadowColor: colors.info.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Find Available Deliveries Button
                    Expanded(
                      child: SizedBox(
                        height: 56.h,
                        child: ElevatedButton.icon(
                          onPressed: () => Get.toNamed('/driver/available-requests'),
                          icon: Icon(Iconsax.search_normal, color: Colors.white, size: 20.sp),
                          label: Text(
                            'Find Requests',
                            style: AppTypography.bodyMedium(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 3,
                            shadowColor: colors.primary.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Active/Pending rides section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Text(
                  'driver.dashboard.active_rides'.tr,
                  style: AppTypography.headlineMedium(context).copyWith(color: colors.textPrimary),
                ),
              ),
            ),

            // Ride requests list
            _RideRequestsList(colors: colors),
          ],
        ),
      ),
    );
  }
}

class _OnlineStatusToggle extends StatelessWidget {
  final AppColorScheme colors;

  const _OnlineStatusToggle({required this.colors});

  @override
  Widget build(BuildContext context) {
    final statusController = Get.find<DriverStatusController>();
    return Obx(() {
      final online = statusController.isOnline.value;
      final loading = statusController.isLoading.value;

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: online ? colors.success.withOpacity(0.1) : colors.error.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: online ? colors.success : colors.error,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: online ? colors.success : colors.error,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              online ? 'driver.status.online'.tr : 'driver.status.offline'.tr,
              style: AppTypography.bodySmall(context).copyWith(
                color: online ? colors.success : colors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8.w),
            loading
                ? SizedBox(
                    width: 18.w,
                    height: 18.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: online ? colors.success : colors.error,
                    ),
                  )
                : GestureDetector(
                    onTap: () async {
                      await statusController.toggleStatus();
                    },
                    child: Icon(
                      online ? Iconsax.toggle_on_circle : Iconsax.toggle_off_circle,
                      color: online ? colors.success : colors.error,
                      size: 24.sp,
                    ),
                  ),
          ],
        ),
      );
    });
  }
}

class _EarningsCard extends StatelessWidget {
  final AppColorScheme colors;

  const _EarningsCard({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary, colors.primary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'driver.earnings.today'.tr,
                style: AppTypography.bodyMedium(context).copyWith(color: Colors.white.withOpacity(0.9)),
              ),
              Icon(Iconsax.wallet, color: Colors.white, size: 24.sp),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            '\$124.50',
            style: AppTypography.headlineLarge(context).copyWith(color: Colors.white).copyWith(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Iconsax.arrow_up_3, color: colors.success, size: 16.sp),
              SizedBox(width: 4.w),
              Text(
                '+15% ${'common.from_yesterday'.tr}',
                style: AppTypography.bodySmall(context).copyWith(color: Colors.white.withOpacity(0.8)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
/// Catalog Requests Button Widget
class _CatalogRequestsButton extends StatelessWidget {
  final AppColorScheme colors;

  const _CatalogRequestsButton({required this.colors});

  @override
  Widget build(BuildContext context) {
    // TODO: Add badge count for pending catalog requests
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary.withOpacity(0.8), colors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.toNamed('/driver/catalog-requests'),
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Iconsax.document_text_1,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'driver.catalog_requests'.tr,
                        style: AppTypography.bodyLarge(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'driver.catalog_requests_hint'.tr,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Iconsax.arrow_right_3,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class _QuickStats extends StatelessWidget {
  final AppColorScheme colors;

  const _QuickStats({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          _StatCard(
            colors: colors,
            icon: Iconsax.car,
            label: 'driver.stats.trips_today'.tr,
            value: '8',
          ),
          SizedBox(width: 12.w),
          _StatCard(
            colors: colors,
            icon: Iconsax.star,
            label: 'driver.stats.rating'.tr,
            value: '4.8',
          ),
          SizedBox(width: 12.w),
          _StatCard(
            colors: colors,
            icon: Iconsax.clock,
            label: 'driver.stats.hours_online'.tr,
            value: '5.2',
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final AppColorScheme colors;
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({
    required this.colors,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: colors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colors.primary, size: 20.sp),
            SizedBox(height: 12.h),
            Text(
              value,
              style: AppTypography.headlineMedium(context).copyWith(color: colors.textPrimary).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _RideRequestsList extends StatelessWidget {
  final AppColorScheme colors;

  const _RideRequestsList({required this.colors});

  @override
  Widget build(BuildContext context) {
    // Sample data - replace with actual ride requests
    final requests = [
      {
        'pickup': 'Casablanca Train Station',
        'destination': 'Mohammed V Airport',
        'distance': '18 km',
        'fare': '\$25.00',
        'time': '2 min ago',
      },
      {
        'pickup': 'Twin Center',
        'destination': 'Corniche Ain Diab',
        'distance': '12 km',
        'fare': '\$18.50',
        'time': '5 min ago',
      },
    ];

    if (requests.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.car,
                size: 64.sp,
                color: colors.textSecondary.withOpacity(0.5),
              ),
              SizedBox(height: 16.h),
              Text(
                'driver.dashboard.no_rides'.tr,
                style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
              ),
            ],
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final request = requests[index];
          return _RideRequestCard(
            colors: colors,
            pickup: request['pickup']!,
            destination: request['destination']!,
            distance: request['distance']!,
            fare: request['fare']!,
            time: request['time']!,
          );
        },
        childCount: requests.length,
      ),
    );
  }
}

class _RideRequestCard extends StatelessWidget {
  final AppColorScheme colors;
  final String pickup;
  final String destination;
  final String distance;
  final String fare;
  final String time;

  const _RideRequestCard({
    required this.colors,
    required this.pickup,
    required this.destination,
    required this.distance,
    required this.fare,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                fare,
                style: AppTypography.headlineMedium(context).copyWith(color: colors.primary).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                time,
                style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _LocationRow(
            colors: colors,
            icon: Iconsax.location,
            location: pickup,
            isPickup: true,
          ),
          SizedBox(height: 8.h),
          _LocationRow(
            colors: colors,
            icon: Iconsax.location_tick,
            location: destination,
            isPickup: false,
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Iconsax.routing, size: 16.sp, color: colors.textSecondary),
              SizedBox(width: 6.w),
              Text(
                distance,
                style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Accept ride logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.success,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text('driver.ride.accept'.tr),
              ),
              SizedBox(width: 8.w),
              OutlinedButton(
                onPressed: () {
                  // Decline ride logic
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.error,
                  side: BorderSide(color: colors.error),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text('driver.ride.decline'.tr),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  final AppColorScheme colors;
  final IconData icon;
  final String location;
  final bool isPickup;

  const _LocationRow({
    required this.colors,
    required this.icon,
    required this.location,
    required this.isPickup,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: (isPickup ? colors.success : colors.primary).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 16.sp,
            color: isPickup ? colors.success : colors.primary,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            location,
            style: AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// MY SERVICES CARD
// ============================================================

class _MyServicesCard extends StatelessWidget {
  final AppColorScheme colors;

  const _MyServicesCard({required this.colors});

  @override
  Widget build(BuildContext context) {
    final servicesController = Get.put(DriverServicesController());

    return Obx(() {
      final hasServices = servicesController.hasServices;
      final activeCount = servicesController.activeServicesCount;
      
      debugPrint('\n🏠 === DASHBOARD MY SERVICES CARD ===');
      debugPrint('   myServices.length: ${servicesController.myServices.length}');
      debugPrint('   hasServices: $hasServices');
      debugPrint('   activeCount: $activeCount');
      debugPrint('   isLoading: ${servicesController.isLoading.value}');

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: colors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Iconsax.box,
                    color: colors.primary,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'driver.services.my_services'.tr,
                        style: AppTypography.bodyLarge(context).copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        hasServices
                            ? 'driver.services.active_services'
                                .trParams({'count': '$activeCount'})
                            : 'driver.services.no_services'.tr,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: colors.textSecondary,
                ),
              ],
            ),
            if (!hasServices) ...[
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: colors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.info_circle,
                      size: 20.sp,
                      color: colors.warning,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'driver.services.add_services_tip'.tr,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              height: 44.h,
              child: ElevatedButton.icon(
                onPressed: () => Get.toNamed('/driver/services'),
                icon: Icon(
                  hasServices ? Iconsax.edit : Iconsax.add,
                  color: Colors.white,
                  size: 20.sp,
                ),
                label: Text(
                  hasServices
                      ? 'driver.services.manage_services'.tr
                      : 'driver.services.add_first_service'.tr,
                  style: AppTypography.bodyLarge(context).copyWith(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
