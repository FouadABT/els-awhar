import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:awhar_client/awhar_client.dart' show DriverService;

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/controllers/driver_services_controller.dart';
import '../../../../core/utils/currency_helper.dart';

/// Driver services management screen
/// Modern minimal design with professional UI/UX
class DriverServicesScreen extends StatelessWidget {
  const DriverServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final controller = Get.put(DriverServicesController());

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: colors.border),
          ),
          child: IconButton(
            icon: Icon(Iconsax.arrow_left, color: colors.textPrimary),
            onPressed: () => Get.back(),
            padding: EdgeInsets.zero,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'driver.services.title'.tr,
              style: AppTypography.titleLarge(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'driver.services.subtitle'.tr,
              style: AppTypography.bodySmall(context).copyWith(
                color: colors.textSecondary,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: colors.primary,
              strokeWidth: 2.5,
            ),
          );
        }

        if (controller.myServices.isEmpty) {
          return _EmptyState(colors: colors);
        }

        return RefreshIndicator(
                  onRefresh: () => controller.loadMyServices(),
                  color: colors.primary,
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      // Stats Header
                      SliverToBoxAdapter(
                        child: _buildStatsHeader(context, colors, controller),
                      ),

                      // Category Filter
                      if (controller.categories.isNotEmpty)
                        SliverToBoxAdapter(
                          child: _buildCategoryFilter(context, colors, controller),
                        ),

                      // Services List
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 100.h),
                        sliver: Obx(() {
                          final services =
                              controller.selectedCategory.value == null
                                  ? controller.myServices
                                  : controller.getServicesByCategory(
                                      controller.selectedCategory.value!.id,
                                    );

                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  child: _ServiceCard(
                                    service: services[index],
                                    colors: colors,
                                    controller: controller,
                                  ),
                                );
                              },
                              childCount: services.length,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                );
      }),
      floatingActionButton: _buildFAB(context, colors),
    );
  }

  Widget _buildStatsHeader(
    BuildContext context,
    AppColorScheme colors,
    DriverServicesController controller,
  ) {
    return Obx(() {
      final activeCount =
          controller.myServices.where((s) => s.isAvailable).length;
      final pausedCount =
          controller.myServices.where((s) => !s.isAvailable).length;

      return Container(
        margin: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colors.borderSoft),
        ),
        child: Row(
          children: [
            _StatItem(
              icon: Iconsax.box_1,
              label: 'common.total'.tr,
              value: '${controller.myServices.length}',
              color: colors.primary,
              colors: colors,
            ),
            _buildDivider(colors),
            _StatItem(
              icon: Iconsax.tick_circle,
              label: 'common.active'.tr,
              value: '$activeCount',
              color: colors.success,
              colors: colors,
            ),
            _buildDivider(colors),
            _StatItem(
              icon: Iconsax.pause_circle,
              label: 'common.paused'.tr,
              value: '$pausedCount',
              color: colors.warning,
              colors: colors,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDivider(AppColorScheme colors) {
    return Container(
      width: 1,
      height: 40.h,
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      color: colors.border,
    );
  }

  Widget _buildCategoryFilter(
    BuildContext context,
    AppColorScheme colors,
    DriverServicesController controller,
  ) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
      child: Obx(() {
        final selectedCategory = controller.selectedCategory.value;
        final hasFilter = selectedCategory != null;
        
        return Row(
          children: [
            // Filter Button
            Expanded(
              child: InkWell(
                onTap: () => _showFilterBottomSheet(context, colors, controller),
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: hasFilter ? colors.primary : colors.border,
                      width: hasFilter ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: (hasFilter ? colors.primary : colors.textMuted)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Iconsax.filter,
                          size: 16.sp,
                          color: hasFilter ? colors.primary : colors.textMuted,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hasFilter ? selectedCategory.name : 'common.filter'.tr,
                              style: AppTypography.labelMedium(context).copyWith(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (hasFilter)
                              Text(
                                '${controller.getServicesByCategory(selectedCategory.id).length} ${'driver.services.services'.tr}',
                                style: AppTypography.labelSmall(context).copyWith(
                                  color: colors.textMuted,
                                  fontSize: 11.sp,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Icon(
                        Iconsax.arrow_down_1,
                        size: 18.sp,
                        color: colors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Clear Filter Button
            if (hasFilter)
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Material(
                  color: colors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  child: InkWell(
                    onTap: () => controller.selectedCategory.value = null,
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      child: Icon(
                        Iconsax.close_circle,
                        size: 20.sp,
                        color: colors.error,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }

  void _showFilterBottomSheet(
    BuildContext context,
    AppColorScheme colors,
    DriverServicesController controller,
  ) {
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(maxHeight: Get.height * 0.7),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle Bar
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: colors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Iconsax.filter,
                      size: 20.sp,
                      color: colors.primary,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'common.filter'.tr,
                          style: AppTypography.headlineSmall(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '${controller.categories.length + 1} ${'driver.services.categories'.tr}',
                          style: AppTypography.labelSmall(context).copyWith(
                            color: colors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Iconsax.close_circle,
                      color: colors.textMuted,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
            ),

            Divider(color: colors.borderSoft, height: 1),

            // Categories List
            Flexible(
              child: Obx(() {
                return ListView(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  shrinkWrap: true,
                  children: [
                    // All Categories
                    _buildFilterOption(
                      context,
                      colors,
                      label: 'common.all'.tr,
                      count: controller.myServices.length,
                      icon: Iconsax.category,
                      isSelected: controller.selectedCategory.value == null,
                      onTap: () {
                        controller.selectedCategory.value = null;
                        Get.back();
                      },
                    ),
                    
                    // Individual Categories
                    ...controller.categories.map((category) {
                      final categoryServices = controller.getServicesByCategory(category.id);
                      return _buildFilterOption(
                        context,
                        colors,
                        label: category.name,
                        count: categoryServices.length,
                        icon: Iconsax.box_1,
                        isSelected: controller.selectedCategory.value?.id == category.id,
                        onTap: () {
                          controller.selectedCategory.value = category;
                          Get.back();
                        },
                      );
                    }).toList(),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
    );
  }

  Widget _buildFilterOption(
    BuildContext context,
    AppColorScheme colors, {
    required String label,
    required int count,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: isSelected ? colors.primary.withOpacity(0.05) : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: isSelected ? colors.primary : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? colors.primary.withOpacity(0.1)
                      : colors.surface,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isSelected ? colors.primary.withOpacity(0.3) : colors.border,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 18.sp,
                  color: isSelected ? colors.primary : colors.textSecondary,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTypography.bodyMedium(context).copyWith(
                        color: colors.textPrimary,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '$count ${'driver.services.services'.tr}',
                      style: AppTypography.labelSmall(context).copyWith(
                        color: colors.textMuted,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: colors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.tick_circle,
                    size: 16.sp,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAB(BuildContext context, AppColorScheme colors) {
    return FloatingActionButton(
      onPressed: () => Get.toNamed('/driver/services/add'),
      backgroundColor: colors.primary,
      elevation: 4,
      child: Icon(Iconsax.add, color: Colors.white, size: 24.sp),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// STAT ITEM
// ═══════════════════════════════════════════════════════════════════════════

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final AppColorScheme colors;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: color, size: 18.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppTypography.headlineSmall(context).copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: AppTypography.labelSmall(context).copyWith(
              color: colors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SERVICE CARD - MODERN MINIMAL DESIGN
// ═══════════════════════════════════════════════════════════════════════════

class _ServiceCard extends StatelessWidget {
  final DriverService service;
  final AppColorScheme colors;
  final DriverServicesController controller;

  const _ServiceCard({
    required this.service,
    required this.colors,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(16.r),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showServiceDetails(context),
        child: Container(
          constraints: BoxConstraints(minHeight: 100.h),
          decoration: BoxDecoration(
            border: Border.all(color: colors.borderSoft),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image Section
                _buildImageSection(),

                // Content Section
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Title & Status
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                service.title ?? 'Untitled',
                                style:
                                    AppTypography.bodyLarge(context).copyWith(
                                  color: colors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            _buildStatusBadge(context),
                          ],
                        ),

                        // Description
                        if (service.description != null &&
                            service.description!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Text(
                              service.description!,
                              style: AppTypography.bodySmall(context).copyWith(
                                color: colors.textMuted,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                        // Bottom Row: Price & Actions
                        Row(
                          children: [
                            // Price
                            if (service.basePrice != null)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: colors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  CurrencyHelper.format(service.basePrice!),
                                  style:
                                      AppTypography.labelSmall(context).copyWith(
                                    color: colors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),

                            const Spacer(),

                            // Toggle Button
                            _buildToggleButton(context),

                            SizedBox(width: 8.w),

                            // Edit Button
                            _buildEditButton(context),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Obx(() {
      final images = controller.serviceImageMap[service.id] ?? [];
      final imageUrl = images.isNotEmpty
          ? images[0].imageUrl
          : (service.imageUrl?.isNotEmpty == true ? service.imageUrl : null);

      return Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: colors.primary.withOpacity(0.08),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            bottomLeft: Radius.circular(16.r),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            bottomLeft: Radius.circular(16.r),
          ),
          child: imageUrl != null
              ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => _buildImagePlaceholder(),
                  errorWidget: (context, url, error) => _buildImagePlaceholder(),
                )
              : _buildImagePlaceholder(),
        ),
      );
    });
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: colors.primary.withOpacity(0.08),
      child: Center(
        child: Icon(
          Iconsax.box_1,
          size: 28.sp,
          color: colors.primary.withOpacity(0.4),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final isActive = service.isAvailable;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: (isActive ? colors.success : colors.warning).withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              color: isActive ? colors.success : colors.warning,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            isActive ? 'Active' : 'Paused',
            style: AppTypography.labelSmall(context).copyWith(
              color: isActive ? colors.success : colors.warning,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(BuildContext context) {
    return Obx(() {
      final isToggling = controller.serviceToggleLoading[service.id] ?? false;
      final isActive = service.isAvailable;

      return SizedBox(
        width: 32.w,
        height: 32.w,
        child: Material(
          color: (isActive ? colors.warning : colors.success).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
          child: InkWell(
            onTap: isToggling
                ? null
                : () => controller.toggleServiceAvailability(
                      service.id!,
                      !isActive,
                    ),
            borderRadius: BorderRadius.circular(8.r),
            child: Center(
              child: isToggling
                  ? SizedBox(
                      width: 14.sp,
                      height: 14.sp,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colors.primary,
                      ),
                    )
                  : Icon(
                      isActive ? Iconsax.pause : Iconsax.play,
                      size: 16.sp,
                      color: isActive ? colors.warning : colors.success,
                    ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildEditButton(BuildContext context) {
    return SizedBox(
      width: 32.w,
      height: 32.w,
      child: Material(
        color: colors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        child: InkWell(
          onTap: () => Get.toNamed('/driver/services/edit/${service.id}'),
          borderRadius: BorderRadius.circular(8.r),
          child: Center(
            child: Icon(
              Iconsax.edit_2,
              size: 16.sp,
              color: colors.primary,
            ),
          ),
        ),
      ),
    );
  }

  void _showServiceDetails(BuildContext context) {
    final colors = AppColors.of(context);
    final serviceId = service.id!;

    Get.bottomSheet(
      Obx(() {
        final currentService = controller.myServices.firstWhere(
          (s) => s.id == serviceId,
          orElse: () => service,
        );

        return Container(
          constraints: BoxConstraints(maxHeight: Get.height * 0.8),
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle Bar
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: colors.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              // Header
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'driver.services.service_details'.tr,
                        style: AppTypography.headlineSmall(context).copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Iconsax.close_circle,
                        color: colors.textMuted,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),

              Divider(color: colors.borderSoft, height: 24.h),

              // Content
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Gallery
                      _buildDetailImage(currentService),
                      SizedBox(height: 20.h),

                      // Title
                      Text(
                        currentService.title ?? 'Service',
                        style: AppTypography.headlineMedium(context).copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Status Chip
                      _buildDetailStatusChip(context, currentService),
                      SizedBox(height: 16.h),

                      // Description
                      if (currentService.description != null &&
                          currentService.description!.isNotEmpty) ...[
                        Text(
                          'common.description'.tr,
                          style: AppTypography.labelMedium(context).copyWith(
                            color: colors.textMuted,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          currentService.description!,
                          style: AppTypography.bodyMedium(context).copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],

                      // Price Info
                      _buildPriceInfo(context, currentService),
                    ],
                  ),
                ),
              ),

              // Action Buttons
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: colors.surface,
                  border: Border(top: BorderSide(color: colors.borderSoft)),
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      // Toggle Button
                      Expanded(
                        child: _buildDetailToggleButton(context, currentService),
                      ),
                      SizedBox(width: 12.w),
                      // Edit Button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Get.back();
                            Get.toNamed('/driver/services/edit/${currentService.id}');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.primary,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          icon: Icon(Iconsax.edit_2, size: 18.sp),
                          label: Text(
                            'common.edit'.tr,
                            style: AppTypography.labelLarge(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildDetailImage(DriverService currentService) {
    return Obx(() {
      final images = controller.serviceImageMap[currentService.id] ?? [];
      final imageUrl = images.isNotEmpty
          ? images[0].imageUrl
          : (currentService.imageUrl?.isNotEmpty == true
              ? currentService.imageUrl
              : null);

      return Container(
        height: 180.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: imageUrl != null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildDetailImagePlaceholder(),
                      errorWidget: (context, url, error) =>
                          _buildDetailImagePlaceholder(),
                    ),
                    if (images.length > 1)
                      Positioned(
                        bottom: 12.h,
                        right: 12.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Iconsax.image,
                                color: Colors.white,
                                size: 14.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${images.length}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                )
              : _buildDetailImagePlaceholder(),
        ),
      );
    });
  }

  Widget _buildDetailImagePlaceholder() {
    return Container(
      color: colors.primary.withOpacity(0.08),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.image,
              size: 40.sp,
              color: colors.primary.withOpacity(0.3),
            ),
            SizedBox(height: 8.h),
            Text(
              'No Image',
              style: TextStyle(
                color: colors.textMuted,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailStatusChip(BuildContext context, DriverService service) {
    final isActive = service.isAvailable;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: (isActive ? colors.success : colors.warning).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: (isActive ? colors.success : colors.warning).withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? Iconsax.tick_circle : Iconsax.pause_circle,
            color: isActive ? colors.success : colors.warning,
            size: 18.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            isActive
                ? 'driver.services.active_visible'.tr
                : 'driver.services.paused_hidden'.tr,
            style: AppTypography.labelMedium(context).copyWith(
              color: isActive ? colors.success : colors.warning,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInfo(BuildContext context, DriverService service) {
    if (service.basePrice == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.borderSoft),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: colors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Iconsax.money_4,
              color: colors.primary,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'driver.services.base_price'.tr,
                  style: AppTypography.labelSmall(context).copyWith(
                    color: colors.textMuted,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  CurrencyHelper.format(service.basePrice!),
                  style: AppTypography.headlineSmall(context).copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailToggleButton(
      BuildContext context, DriverService currentService) {
    return Obx(() {
      final isToggling =
          controller.serviceToggleLoading[currentService.id] ?? false;
      final isActive = currentService.isAvailable;

      return OutlinedButton.icon(
        onPressed: isToggling
            ? null
            : () async {
                await controller.toggleServiceAvailability(
                  currentService.id!,
                  !isActive,
                );
              },
        style: OutlinedButton.styleFrom(
          foregroundColor: isActive ? colors.warning : colors.success,
          side: BorderSide(
            color: isActive ? colors.warning : colors.success,
          ),
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        icon: isToggling
            ? SizedBox(
                width: 18.sp,
                height: 18.sp,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: isActive ? colors.warning : colors.success,
                ),
              )
            : Icon(isActive ? Iconsax.pause : Iconsax.play, size: 18.sp),
        label: Text(
          isToggling
              ? 'common.loading'.tr
              : isActive
                  ? 'driver.services.pause_service'.tr
                  : 'driver.services.activate_service'.tr,
          style: AppTypography.labelLarge(context).copyWith(
            color: isActive ? colors.warning : colors.success,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    });
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// EMPTY STATE
// ═══════════════════════════════════════════════════════════════════════════

class _EmptyState extends StatelessWidget {
  final AppColorScheme colors;

  const _EmptyState({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: colors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Iconsax.box_1,
                  size: 56.sp,
                  color: colors.primary.withOpacity(0.6),
                ),
              ),
            ),
            SizedBox(height: 32.h),

            // Title
            Text(
              'driver.services.empty_title'.tr,
              style: AppTypography.headlineMedium(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),

            // Subtitle
            Text(
              'driver.services.empty_subtitle'.tr,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textMuted,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.h),

            // CTA Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Get.toNamed('/driver/services/add'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 0,
                ),
                icon: Icon(Iconsax.add, size: 22.sp),
                label: Text(
                  'driver.services.add_first_service'.tr,
                  style: AppTypography.labelLarge(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
