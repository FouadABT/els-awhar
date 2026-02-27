import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency_helper.dart';
import '../../../../core/controllers/service_catalog_controller.dart';
import '../../../../shared/widgets/service_detail_sheet.dart';

/// Screen displaying full driver catalog with services - Modern redesign
class DriverCatalogScreen extends StatefulWidget {
  final DriverProfile driver;

  const DriverCatalogScreen({
    super.key,
    required this.driver,
  });

  @override
  State<DriverCatalogScreen> createState() => _DriverCatalogScreenState();
}

class _DriverCatalogScreenState extends State<DriverCatalogScreen> with SingleTickerProviderStateMixin {
  final ServiceCatalogController _controller = Get.find();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _controller.getDriverCatalog(widget.driver.id!);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _buildAppBar(context, colors, innerBoxIsScrolled),
        ],
        body: Column(
          children: [
            _buildDriverInfo(context, colors),
            _buildTabBar(context, colors),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildServicesTab(context, colors),
                  _buildAboutTab(context, colors),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActions(context, colors),
    );
  }


  // ============================================================
  // APP BAR
  // ============================================================

  Widget _buildAppBar(BuildContext context, AppColorScheme colors, bool innerBoxIsScrolled) {
    return SliverAppBar(
      expandedHeight: 280.h,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: colors.surface,
      leading: Container(
        margin: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: colors.surface.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary, size: 20.sp),
          onPressed: () => Get.back(),
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: colors.surface.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.share, color: colors.textPrimary, size: 20.sp),
            onPressed: () {},
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: _buildHeroHeader(colors),
      ),
    );
  }

  Widget _buildHeroHeader(AppColorScheme colors) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colors.primary.withOpacity(0.7),
                colors.primary,
              ],
            ),
          ),
        ),
        // Pattern overlay
        Opacity(
          opacity: 0.1,
          child: Image.asset(
            'assets/images/pattern.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const SizedBox(),
          ),
        ),
        // Content
        SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Profile photo with status badge
                Stack(
                  children: [
                    Hero(
                      tag: 'driver_${widget.driver.id}',
                      child: Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: _buildDriverAvatar(colors),
                        ),
                      ),
                    ),
                    if (widget.driver.isOnline)
                      Positioned(
                        right: 4,
                        bottom: 4,
                        child: Container(
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                            color: colors.success,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  widget.driver.displayName,
                  style: AppTypography.headlineMedium(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDriverAvatar(AppColorScheme colors) {
    if (widget.driver.profilePhotoUrl != null &&
        widget.driver.profilePhotoUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: widget.driver.profilePhotoUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: colors.primary.withOpacity(0.2),
          child: Icon(Iconsax.user, color: Colors.white, size: 40.sp),
        ),
        errorWidget: (context, url, error) => Container(
          color: colors.primary.withOpacity(0.2),
          child: Icon(Iconsax.user, color: Colors.white, size: 40.sp),
        ),
      );
    }

    return Container(
      color: colors.primary.withOpacity(0.2),
      child: Icon(Iconsax.user, color: Colors.white, size: 40.sp),
    );
  }

  // ============================================================
  // DRIVER INFO CARD
  // ============================================================

  Widget _buildDriverInfo(BuildContext context, AppColorScheme colors) {
    final distance = _controller.getDistanceToDriver(widget.driver);

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (widget.driver.ratingCount ?? 0) > 0
                  ? () {
                      Get.toNamed('/reviews', arguments: {
                        'revieweeType': 'driver',
                        'revieweeId': widget.driver.userId,
                        'revieweeName': widget.driver.displayName,
                        'initialRating': widget.driver.ratingAverage ?? 0.0,
                      });
                    }
                  : null,
              child: _InfoTile(
                icon: Iconsax.star_1,
                iconColor: colors.warning,
                label: (widget.driver.ratingAverage ?? 0.0).toStringAsFixed(1),
                sublabel: '${widget.driver.ratingCount ?? 0} ${'common.reviews'.tr}',
                colors: colors,
              ),
            ),
          ),
          Container(width: 1, height: 50.h, color: colors.border),
          Expanded(
            child: _InfoTile(
              icon: Iconsax.routing_2,
              iconColor: colors.primary,
              label: '${widget.driver.totalCompletedOrders ?? 0}',
              sublabel: 'client.explore.trips'.tr,
              colors: colors,
            ),
          ),
          if (distance != null) ...[
            Container(width: 1, height: 50.h, color: colors.border),
            Expanded(
              child: _InfoTile(
                icon: Iconsax.location,
                iconColor: colors.info,
                label: '${distance.toStringAsFixed(1)} km',
                sublabel: 'client.catalog.away'.tr,
                colors: colors,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // TAB BAR
  // ============================================================

  Widget _buildTabBar(BuildContext context, AppColorScheme colors) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: colors.surfaceElevated,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: colors.primary,
          borderRadius: BorderRadius.circular(10.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: colors.textSecondary,
        labelStyle: AppTypography.labelLarge(context).copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTypography.labelLarge(context),
        dividerColor: Colors.transparent,
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.box, size: 18.sp),
                SizedBox(width: 8.w),
                Text('client.catalog.services'.tr),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.info_circle, size: 18.sp),
                SizedBox(width: 8.w),
                Text('common.about'.tr),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // ============================================================
  // SERVICES TAB
  // ============================================================

  Widget _buildServicesTab(BuildContext context, AppColorScheme colors) {
    return Obx(() {
      if (_controller.isLoadingServices.value) {
        return _buildServicesShimmer(colors);
      }

      if (_controller.driverServices.isEmpty) {
        return _buildEmptyState(
          icon: Iconsax.box,
          title: 'client.catalog.no_services_yet'.tr,
          colors: colors,
        );
      }

      return ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: _controller.driverServices.length,
        itemBuilder: (context, index) {
          final service = _controller.driverServices[index];
          return _ModernServiceCard(
            service: service,
            colors: colors,
            onTap: () => _showServiceDetail(service),
          );
        },
      );
    });
  }

  Widget _buildServicesShimmer(AppColorScheme colors) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          height: 140.h,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16.r),
          ),
        );
      },
    );
  }

  // ============================================================
  // ABOUT TAB
  // ============================================================

  Widget _buildAboutTab(BuildContext context, AppColorScheme colors) {
    // Check if driver has meaningful stats
    final hasRating = (widget.driver.ratingAverage ?? 0) > 0;
    final hasOrders = (widget.driver.totalCompletedOrders ?? 0) > 0;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Driver Status Card - only show if verified or premium
          if (widget.driver.isVerified || widget.driver.isPremium)
            _buildAboutCard(
              icon: Iconsax.user_octagon,
              title: 'driver_catalog.driver_profile'.tr,
              children: [
                if (widget.driver.isVerified)
                  _buildInfoRow(Iconsax.verify, 'driver_catalog.verified'.tr, 'common.yes'.tr, colors),
                if (widget.driver.isPremium)
                  _buildInfoRow(Iconsax.medal_star, 'driver_catalog.premium'.tr, 'common.yes'.tr, colors),
              ],
              colors: colors,
            ),
          if (widget.driver.isVerified || widget.driver.isPremium)
            SizedBox(height: 16.h),

          // Performance Card - only show if has rating or orders
          if (hasRating || hasOrders)
            _buildAboutCard(
              icon: Iconsax.chart_success,
              title: 'driver_catalog.performance'.tr,
              children: [
                if (hasRating)
                  _buildInfoRow(Iconsax.star_1, 'driver_catalog.average_rating'.tr, '${widget.driver.ratingAverage?.toStringAsFixed(1)}', colors),
                if (hasOrders)
                  _buildInfoRow(Iconsax.task_square, 'driver_catalog.total_orders'.tr, '${widget.driver.totalCompletedOrders}', colors),
            ],
            colors: colors,
          ),

          // Empty state if no data to show
          if (!(widget.driver.isVerified || widget.driver.isPremium) && !(hasRating || hasOrders))
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Column(
                  children: [
                    Icon(Iconsax.info_circle, size: 48.sp, color: colors.textSecondary),
                    SizedBox(height: 16.h),
                    Text(
                      'driver_catalog.no_info_available'.tr,
                      style: AppTypography.bodyMedium(context).copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAboutCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
    required AppColorScheme colors,
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: colors.primary, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Text(
                title,
                style: AppTypography.titleMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, AppColorScheme colors) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: colors.textSecondary),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              label,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: AppTypography.bodyMedium(context).copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FLOATING ACTIONS
  // ============================================================

  Widget _buildFloatingActions(BuildContext context, AppColorScheme colors) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Obx(() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'chat',
            onPressed: _openChat,
            backgroundColor: colors.primary,
            child: const Icon(Iconsax.message, color: Colors.white),
          ),
          SizedBox(height: 12.h),
          FloatingActionButton(
            heroTag: 'favorite',
            onPressed: _toggleFavorite,
            backgroundColor: colors.surface,
            child: Icon(
              _controller.isFavorite(widget.driver.id!)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: _controller.isFavorite(widget.driver.id!)
                  ? colors.error
                  : colors.textSecondary,
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required AppColorScheme colors,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80.sp, color: colors.textSecondary.withOpacity(0.3)),
          SizedBox(height: 16.h),
          Text(
            title,
            style: AppTypography.titleMedium(context).copyWith(
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }


  // ============================================================
  // ACTIONS
  // ============================================================

  void _openChat() {
    // Open direct chat with driver
    Get.toNamed(
      '/direct-chat',
      arguments: widget.driver,
    );
  }

  void _toggleFavorite() {
    _controller.toggleFavorite(widget.driver.id!);
  }

  void _showServiceDetail(DriverService service) {
    Get.bottomSheet(
      ServiceDetailSheet(
        service: service,
        driver: widget.driver,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}

// ============================================================
// INFO TILE WIDGET
// ============================================================

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String sublabel;
  final AppColorScheme colors;

  const _InfoTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.sublabel,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 20.sp),
        SizedBox(height: 8.h),
        Text(
          label,
          style: AppTypography.titleMedium(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          sublabel,
          style: AppTypography.bodySmall(context).copyWith(
            color: colors.textSecondary,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

// ============================================================
// MODERN SERVICE CARD WIDGET
// ============================================================

class _ModernServiceCard extends StatelessWidget {
  final DriverService service;
  final AppColorScheme colors;
  final VoidCallback onTap;

  const _ModernServiceCard({
    required this.service,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(16.r)),
              child: _buildServiceImage(),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            service.title ?? 'Service',
                            style: AppTypography.titleMedium(context).copyWith(
                              color: colors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        _buildAvailabilityBadge(context),
                      ],
                    ),
                    if (service.description != null && service.description!.isNotEmpty) ...[
                      SizedBox(height: 6.h),
                      Text(
                        service.description!,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: colors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _getPriceText(),
                            style: AppTypography.titleMedium(context).copyWith(
                              color: colors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16.sp,
                          color: colors.textSecondary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceImage() {
    if (service.imageUrl != null && service.imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: service.imageUrl!,
        width: 100.w,
        height: 120.h,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: 100.w,
          height: 120.h,
          color: colors.primary.withOpacity(0.1),
          child: Icon(Iconsax.box, color: colors.primary.withOpacity(0.3), size: 32.sp),
        ),
        errorWidget: (context, url, error) => _buildPlaceholderImage(),
      );
    }
    return _buildPlaceholderImage();
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: 100.w,
      height: 120.h,
      color: colors.primary.withOpacity(0.1),
      child: Icon(
        Iconsax.box,
        size: 32.sp,
        color: colors.primary.withOpacity(0.3),
      ),
    );
  }

  Widget _buildAvailabilityBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: service.isAvailable
            ? colors.success.withOpacity(0.1)
            : colors.textSecondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              color: service.isAvailable ? colors.success : colors.textSecondary,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            service.isAvailable ? 'common.available'.tr : 'common.unavailable'.tr,
            style: AppTypography.bodySmall(context).copyWith(
              color: service.isAvailable ? colors.success : colors.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  String _getPriceText() {
    if (service.priceType == null) {
      return 'client.catalog.contact_for_price'.tr;
    }

    switch (service.priceType!) {
      case PriceType.fixed:
        return CurrencyHelper.format(service.basePrice ?? 0);
      case PriceType.per_km:
        return '${CurrencyHelper.format(service.pricePerKm ?? 0)}/km';
      case PriceType.per_hour:
        return '${CurrencyHelper.format(service.pricePerHour ?? 0)}/hr';
      case PriceType.negotiable:
        return 'client.catalog.negotiable'.tr;
    }
  }
}
