import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/currency_helper.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/service_catalog_controller.dart';
import '../../core/controllers/request_controller.dart';

/// Bottom sheet showing detailed service information
class ServiceDetailSheet extends StatefulWidget {
  final DriverService service;
  final DriverProfile driver;

  const ServiceDetailSheet({
    super.key,
    required this.service,
    required this.driver,
  });

  @override
  State<ServiceDetailSheet> createState() => _ServiceDetailSheetState();
}

class _ServiceDetailSheetState extends State<ServiceDetailSheet> {
  final PageController _pageController = PageController();
  final RxInt _currentPage = 0.obs;
  final RxBool _acceptedTerms = false.obs;

  @override
  void initState() {
    super.initState();
    // Track service view
    final controller = Get.find<ServiceCatalogController>();
    if (widget.service.id != null) {
      controller.trackServiceView(widget.service.id!);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          _buildHandle(colors),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageGallery(colors),
                  _buildServiceInfo(context, colors),
                  _buildPricingDetails(context, colors),
                  _buildDriverInfo(context, colors),
                  _buildTermsCheckbox(context, colors),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
          _buildActionButtons(context, colors),
        ],
      ),
    );
  }

  // ============================================================
  // HANDLE
  // ============================================================

  Widget _buildHandle(AppColorScheme colors) {
    return Container(
      margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
      width: 40.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: colors.border,
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  // ============================================================
  // IMAGE GALLERY
  // ============================================================

  Widget _buildImageGallery(AppColorScheme colors) {
    if (widget.service.imageUrl == null || widget.service.imageUrl!.isEmpty) {
      return _buildPlaceholderImage(colors);
    }

    return Stack(
      children: [
        SizedBox(
          height: 300.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (page) => _currentPage.value = page,
            itemCount: 1, // TODO: Support multiple images from service_images table
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: widget.service.imageUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: colors.surface,
                  child: Center(
                    child: CircularProgressIndicator(color: colors.primary),
                  ),
                ),
                errorWidget: (context, url, error) => _buildPlaceholderImage(colors),
              );
            },
          ),
        ),
        // Page indicator
        Positioned(
          bottom: 16.h,
          right: 16.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Obx(() => Text(
                  '${_currentPage.value + 1}/1',
                  style: AppTypography.bodySmall(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
        ),
        // Close button
        Positioned(
          top: 16.h,
          right: 16.w,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderImage(AppColorScheme colors) {
    return Container(
      height: 300.h,
      color: colors.primary.withOpacity(0.1),
      child: Center(
        child: Icon(
          Iconsax.box,
          size: 80.sp,
          color: colors.primary.withOpacity(0.5),
        ),
      ),
    );
  }

  // ============================================================
  // SERVICE INFO
  // ============================================================

  Widget _buildServiceInfo(BuildContext context, AppColorScheme colors) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.service.title ?? 'Service',
                  style: AppTypography.headlineMedium(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (widget.service.isAvailable)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: colors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: colors.success),
                  ),
                  child: Text(
                    'common.available'.tr,
                    style: AppTypography.bodySmall(context).copyWith(
                      color: colors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          if (widget.service.description != null &&
              widget.service.description!.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Text(
              widget.service.description!,
              style: AppTypography.bodyLarge(context).copyWith(
                color: colors.textSecondary,
                height: 1.6,
              ),
            ),
          ],
          if (widget.service.customDescription != null &&
              widget.service.customDescription!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: colors.border),
              ),
              child: Text(
                widget.service.customDescription!,
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // PRICING DETAILS
  // ============================================================

  Widget _buildPricingDetails(BuildContext context, AppColorScheme colors) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'client.catalog.pricing_details'.tr,
            style: AppTypography.titleMedium(context).copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.border),
            ),
            child: Column(
              children: [
                _buildPriceRow(
                  context,
                  colors,
                  'client.catalog.service_type'.tr,
                  _getPriceTypeLabel(),
                ),
                if (widget.service.basePrice != null) ...[
                  SizedBox(height: 12.h),
                  _buildPriceRow(
                    context,
                    colors,
                    'client.catalog.base_price'.tr,
                    CurrencyHelper.format(widget.service.basePrice!),
                  ),
                ],
                if (widget.service.pricePerKm != null) ...[
                  SizedBox(height: 12.h),
                  _buildPriceRow(
                    context,
                    colors,
                    'client.catalog.per_km'.tr,
                    '${CurrencyHelper.format(widget.service.pricePerKm!)}/km',
                  ),
                ],
                if (widget.service.pricePerHour != null) ...[
                  SizedBox(height: 12.h),
                  _buildPriceRow(
                    context,
                    colors,
                    'client.catalog.per_hour'.tr,
                    '${CurrencyHelper.format(widget.service.pricePerHour!)}/hr',
                  ),
                ],
                if (widget.service.minPrice != null) ...[
                  SizedBox(height: 12.h),
                  _buildPriceRow(
                    context,
                    colors,
                    'client.catalog.minimum'.tr,
                    CurrencyHelper.format(widget.service.minPrice!),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    BuildContext context,
    AppColorScheme colors,
    String label,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodyMedium(context).copyWith(
            color: colors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTypography.bodyLarge(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _getPriceTypeLabel() {
    if (widget.service.priceType == null) {
      return 'client.catalog.contact_for_price'.tr;
    }
    switch (widget.service.priceType!) {
      case PriceType.fixed:
        return 'client.catalog.fixed_price'.tr;
      case PriceType.per_km:
        return 'client.catalog.per_km_pricing'.tr;
      case PriceType.per_hour:
        return 'client.catalog.per_hour_pricing'.tr;
      case PriceType.negotiable:
        return 'client.catalog.negotiable'.tr;
    }
  }

  // ============================================================
  // DRIVER INFO
  // ============================================================

  Widget _buildDriverInfo(BuildContext context, AppColorScheme colors) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'client.catalog.provided_by'.tr,
            style: AppTypography.titleMedium(context).copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.border),
            ),
            child: Row(
              children: [
                // Driver avatar
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.primary.withOpacity(0.1),
                  ),
                  child: widget.driver.profilePhotoUrl != null
                      ? ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: widget.driver.profilePhotoUrl!,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Icon(
                              Iconsax.user,
                              color: colors.primary,
                              size: 24.sp,
                            ),
                          ),
                        )
                      : Icon(
                          Iconsax.user,
                          color: colors.primary,
                          size: 24.sp,
                        ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.driver.displayName,
                        style: AppTypography.titleMedium(context).copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Iconsax.star, size: 14.sp, color: colors.warning),
                          SizedBox(width: 4.w),
                          Text(
                            '${widget.driver.ratingAverage?.toStringAsFixed(1) ?? '0.0'} (${widget.driver.ratingCount ?? 0})',
                            style: AppTypography.bodySmall(context).copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colors.textSecondary,
                  size: 24.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TERMS CHECKBOX
  // ============================================================

  Widget _buildTermsCheckbox(BuildContext context, AppColorScheme colors) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Obx(() => Row(
            children: [
              Checkbox(
                value: _acceptedTerms.value,
                onChanged: (value) => _acceptedTerms.value = value ?? false,
                activeColor: colors.primary,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _acceptedTerms.value = !_acceptedTerms.value,
                  child: RichText(
                    text: TextSpan(
                      style: AppTypography.bodySmall(context).copyWith(
                        color: colors.textSecondary,
                      ),
                      children: [
                        TextSpan(text: 'client.catalog.i_agree_to'.tr + ' '),
                        TextSpan(
                          text: 'client.catalog.terms_conditions'.tr,
                          style: TextStyle(
                            color: colors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  // ============================================================
  // ACTION BUTTONS
  // ============================================================

  Widget _buildActionButtons(BuildContext context, AppColorScheme colors) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _openChat,
                icon: const Icon(Iconsax.message),
                label: Text('chat.title'.tr),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.primary,
                  side: BorderSide(color: colors.primary),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              flex: 2,
              child: Obx(() => ElevatedButton(
                    onPressed: _acceptedTerms.value ? _requestService : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      disabledBackgroundColor: colors.textSecondary.withOpacity(0.3),
                    ),
                    child: Text('client.catalog.request_now'.tr),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ACTIONS
  // ============================================================

  void _openChat() {
    Get.back();
    
    // Open direct chat with driver
    Get.toNamed(
      '/direct-chat',
      arguments: widget.driver,
    );
  }

  void _requestService() {
    final catalogController = Get.find<ServiceCatalogController>();
    if (widget.service.id != null) {
      catalogController.trackServiceInquiry(widget.service.id!);
    }

    // Close the bottom sheet
    Get.back();

    // Initialize request controller with catalog context
    final requestController = Get.find<RequestController>();
    requestController.initializeFromCatalog(
      service: widget.service,
      driver: widget.driver,
    );

    // Navigate to request creation screen
    Get.toNamed('/client/create-request');

    // Show informational message
    Get.snackbar(
      'client.catalog.booking_from_catalog'.tr,
      'client.catalog.service_details_prefilled'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.primary,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}
