import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_flutter/core/theme/app_colors.dart';
import 'package:awhar_flutter/core/theme/app_typography.dart';
import 'package:awhar_flutter/core/controllers/driver_status_controller.dart';
import 'package:awhar_flutter/core/controllers/driver_dashboard_controller.dart';
import 'package:awhar_flutter/shared/widgets/notification_bell.dart';
import 'package:awhar_flutter/shared/widgets/promo_banner_widget.dart';
import 'package:awhar_flutter/core/utils/currency_helper.dart';
import 'package:intl/intl.dart';

/// Professional Driver Dashboard
/// Shows real-time earnings, statistics, and active requests
class DriverDashboardScreen extends StatelessWidget {
  const DriverDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final dashboardController = Get.put(DriverDashboardController());
    final statusController = Get.find<DriverStatusController>();

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => dashboardController.refresh(),
          child: CustomScrollView(
            slivers: [
              // Header with online status
              SliverToBoxAdapter(
                child: _Header(
                  colors: colors,
                  statusController: statusController,
                ),
              ),

              // Promo Banners
              const SliverToBoxAdapter(
                child: PromoBannerWidget(userRole: 'driver'),
              ),

              // Earnings Card
              SliverToBoxAdapter(
                child: _EarningsCard(
                  colors: colors,
                  controller: dashboardController,
                ),
              ),

              // Pending Requests Alert Card
              SliverToBoxAdapter(
                child: _PendingRequestsCard(
                  colors: colors,
                  controller: dashboardController,
                ),
              ),

              // Primary Actions (Store Deliveries on top)
              SliverToBoxAdapter(
                child: _QuickActions(colors: colors),
              ),

              // Quick Stats
              SliverToBoxAdapter(
                child: _QuickStats(
                  colors: colors,
                  controller: dashboardController,
                ),
              ),

              // Active Requests Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'driver.dashboard.active_requests'.tr,
                          style: AppTypography.headlineMedium(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Obx(
                        () => dashboardController.isLoadingRequests.value
                            ? SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: colors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  '${dashboardController.activeRequests.length + dashboardController.pendingRequests.length}',
                                  style: AppTypography.bodyMedium(context)
                                      .copyWith(
                                        color: colors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),

              // Requests List
              _RequestsList(colors: colors, controller: dashboardController),

              // Bottom spacing
              SliverToBoxAdapter(child: SizedBox(height: 80.h)),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// HEADER
// ============================================================
class _Header extends StatelessWidget {
  final AppColorScheme colors;
  final DriverStatusController statusController;

  const _Header({required this.colors, required this.statusController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'driver.dashboard.title'.tr,
                      style: AppTypography.headlineLarge(context).copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'driver.dashboard.welcome_back'.tr,
                      style: AppTypography.bodyMedium(context).copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const NotificationBell(),
            ],
          ),
          SizedBox(height: 16.h),
          _OnlineStatusToggle(colors: colors, controller: statusController),
        ],
      ),
    );
  }
}

// ============================================================
// ONLINE STATUS TOGGLE
// ============================================================
class _OnlineStatusToggle extends StatelessWidget {
  final AppColorScheme colors;
  final DriverStatusController controller;

  const _OnlineStatusToggle({required this.colors, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final online = controller.isOnline.value;
      final loading = controller.isLoading.value;

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colors.border),
          boxShadow: [
            BoxShadow(
              color: colors.border.withOpacity(0.12),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: online
                    ? colors.success.withOpacity(0.12)
                    : colors.textSecondary.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                online ? Iconsax.flash_1 : Iconsax.pause_circle,
                color: online ? colors.success : colors.textSecondary,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    online
                        ? 'driver.status.online'.tr
                        : 'driver.status.offline'.tr,
                    style: AppTypography.bodyLarge(context).copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    online
                        ? 'driver.status.receiving_requests'.tr
                        : 'driver.status.not_receiving'.tr,
                    style: AppTypography.bodySmall(context).copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            loading
                ? SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colors.primary,
                    ),
                  )
                : Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => controller.toggleStatus(),
                      borderRadius: BorderRadius.circular(999.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: online
                              ? colors.success.withOpacity(0.12)
                              : colors.primary.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(999.r),
                          border: Border.all(
                            color: online ? colors.success : colors.primary,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              online
                                  ? Iconsax.toggle_on_circle
                                  : Iconsax.toggle_off_circle,
                              color: online ? colors.success : colors.primary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              online
                                  ? 'driver.status.online'.tr
                                  : 'driver.status.offline'.tr,
                              style: AppTypography.bodySmall(context).copyWith(
                                color: online ? colors.success : colors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
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

// ============================================================
// EARNINGS CARD
// ============================================================
class _EarningsCard extends StatelessWidget {
  final AppColorScheme colors;
  final DriverDashboardController controller;

  const _EarningsCard({required this.colors, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingEarnings.value) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          height: 150.h,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      final earnings = controller.earnings.value;
      final todayEarnings = controller.todayEarnings.value;
      final todayTrips = controller.todayTrips.value;
      final formatter = DateFormat('MMM dd');

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: colors.primary,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: colors.primary.withOpacity(0.4),
              blurRadius: 16,
              offset: Offset(0, 8),
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
                  style: AppTypography.bodyLarge(context).copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  child: Text(
                    formatter.format(DateTime.now()),
                    style: AppTypography.bodySmall(context).copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              CurrencyHelper.format(todayEarnings),
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                _EarningsChip(
                  label: 'driver.earnings.total'.tr,
                  value: CurrencyHelper.format(earnings?.totalEarnings ?? 0),
                ),
                _EarningsChip(
                  label: 'driver.stats.trips_today'.tr,
                  value: todayTrips.toString(),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class _EarningsChip extends StatelessWidget {
  final String label;
  final String value;

  const _EarningsChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: Colors.white.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: AppTypography.bodySmall(context).copyWith(
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: AppTypography.bodySmall(context).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PENDING REQUESTS CARD
// ============================================================
class _PendingRequestsCard extends StatelessWidget {
  final AppColorScheme colors;
  final DriverDashboardController controller;

  const _PendingRequestsCard({required this.colors, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final pendingCount = controller.pendingRequests.length;
      final isLoading = controller.isLoadingRequests.value;

      // Don't show if no pending requests and not loading
      if (pendingCount == 0 && !isLoading) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Scroll to requests section or navigate to dedicated screen
              Get.toNamed('/driver/catalog-requests');
            },
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.shade600,
                    Colors.orange.shade800,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Icon with badge
                  Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Iconsax.document_text,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                        if (pendingCount > 0)
                          Positioned(
                            top: 4.h,
                            right: 4.w,
                            child: Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 20.w,
                                minHeight: 20.w,
                              ),
                              child: Center(
                                child: Text(
                                  pendingCount > 99 ? '99+' : '$pendingCount',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  // Text content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isLoading
                              ? 'driver.dashboard.loading_requests'.tr
                              : 'driver.dashboard.pending_requests_available'
                                    .tr,
                          style: AppTypography.titleMedium(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          isLoading
                              ? 'common.please_wait'.tr
                              : pendingCount == 1
                              ? 'driver.dashboard.one_request_waiting'.tr
                              : 'driver.dashboard.requests_waiting'.trParams({
                                  'count': '$pendingCount',
                                }),
                          style: AppTypography.bodySmall(context).copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Arrow
                  Icon(
                    Iconsax.arrow_right_3,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

// ============================================================
// QUICK STATS
// ============================================================
class _QuickStats extends StatelessWidget {
  final AppColorScheme colors;
  final DriverDashboardController controller;

  const _QuickStats({required this.colors, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Obx(
        () => Row(
          children: [
            _StatCard(
              colors: colors,
              icon: Iconsax.car,
              label: 'driver.stats.trips_today'.tr,
              value: controller.todayTrips.value.toString(),
            ),
            SizedBox(width: 12.w),
            _StatCard(
              colors: colors,
              icon: Iconsax.document_text,
              label: 'driver.stats.total_trips'.tr,
              value: controller.totalTrips.value.toString(),
            ),
            SizedBox(width: 12.w),
            _StatCard(
              colors: colors,
              icon: Iconsax.star,
              label: controller.ratingCount.value > 0
                  ? '${'driver.stats.rating'.tr} (${controller.ratingCount.value})'
                  : 'driver.stats.rating'.tr,
              value: controller.averageRating.value > 0
                  ? controller.averageRating.value.toStringAsFixed(1)
                  : '—',
            ),
          ],
        ),
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
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colors.border),
          boxShadow: [
            BoxShadow(
              color: colors.border.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: colors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: colors.primary, size: 16.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              value,
              style: AppTypography.titleLarge(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: AppTypography.bodySmall(context).copyWith(
                color: colors.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// QUICK ACTIONS
// ============================================================
class _QuickActions extends StatelessWidget {
  final AppColorScheme colors;

  const _QuickActions({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Get.toNamed('/driver/store-requests'),
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.warning, colors.warning.withOpacity(0.85)],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: colors.warning.withOpacity(0.35),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Iconsax.box_tick,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Store Deliveries',
                        style: AppTypography.bodyLarge(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Iconsax.arrow_right_3,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  colors: colors,
                  icon: Iconsax.briefcase,
                  label: 'driver.my_services'.tr,
                  onTap: () => Get.toNamed('/driver/services'),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _ActionButton(
                  colors: colors,
                  icon: Iconsax.document_text_1,
                  label: 'driver.catalog_requests'.tr,
                  onTap: () => Get.toNamed('/driver/catalog-requests'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final AppColorScheme colors;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.colors,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: colors.border.withOpacity(0.08),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: colors.primary, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Iconsax.arrow_right_3,
                color: colors.textSecondary,
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// REQUESTS LIST
// ============================================================
class _RequestsList extends StatelessWidget {
  final AppColorScheme colors;
  final DriverDashboardController controller;

  const _RequestsList({required this.colors, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final allRequests = [
        ...controller.activeRequests,
        ...controller.pendingRequests,
      ];

      if (allRequests.isEmpty) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.document_text,
                  size: 64.sp,
                  color: colors.textSecondary.withOpacity(0.3),
                ),
                SizedBox(height: 16.h),
                Text(
                  'driver.dashboard.no_requests'.tr,
                  style: AppTypography.bodyLarge(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'driver.dashboard.check_back_later'.tr,
                  style: AppTypography.bodySmall(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final request = allRequests[index];
            final isPending = controller.pendingRequests.contains(request);

            return _RequestCard(
              colors: colors,
              request: request,
              isPending: isPending,
              onAccept: () {
                if (request.id != null) {
                  controller.acceptRequest(request.id!);
                }
              },
              onReject: () {
                if (request.id != null) {
                  // Note: Direct reject not implemented, driver can just ignore
                  Get.snackbar(
                    'common.info'.tr,
                    'Ignore requests you don\'t want to accept',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              onTap: () {
                if (isPending) {
                  Get.toNamed(
                    '/driver/catalog-request-detail',
                    arguments: request.id,
                  );
                } else {
                  // Navigate to active request detail
                  Get.toNamed('/driver/active-request', arguments: request.id);
                }
              },
            );
          },
          childCount: allRequests.length,
        ),
      );
    });
  }
}

/// Helper function to get service type name from request
String _getServiceTypeName(dynamic request) {
  try {
    final serviceType = request.serviceType;
    if (serviceType == null) return 'N/A';
    if (serviceType is String) return serviceType;
    // If it's an enum, get its name
    return serviceType.name ?? serviceType.toString().split('.').last;
  } catch (e) {
    return 'Service';
  }
}

// ============================================================
// REQUEST CARD
// ============================================================
class _RequestCard extends StatelessWidget {
  final AppColorScheme colors;
  final request;
  final bool isPending;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onTap;

  const _RequestCard({
    required this.colors,
    required this.request,
    required this.isPending,
    required this.onAccept,
    required this.onReject,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('MMM dd, HH:mm');

    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 12.h),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isPending ? colors.primary.withOpacity(0.3) : colors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.border.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _getServiceTypeName(request),
                        style: AppTypography.bodyLarge(context).copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: isPending
                            ? colors.primary.withOpacity(0.1)
                            : colors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        isPending ? 'request.pending'.tr : 'request.active'.tr,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: isPending ? colors.primary : colors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Icon(
                      Iconsax.user,
                      size: 16.sp,
                      color: colors.textSecondary,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      request.clientName ?? 'Unknown',
                      style: AppTypography.bodyMedium(context).copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Iconsax.clock,
                      size: 16.sp,
                      color: colors.textSecondary,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      dateFormatter.format(request.createdAt),
                      style: AppTypography.bodySmall(context).copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                if (isPending) ...[
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onAccept,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.success,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text('request.accept'.tr),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onReject,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: colors.error,
                            side: BorderSide(color: colors.error),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text('request.reject'.tr),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
