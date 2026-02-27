import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency_helper.dart';
import 'edit_service_controller.dart';

/// Edit existing service screen
/// Allows driver to modify service details
class EditServiceScreen extends StatelessWidget {
  const EditServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return GetBuilder<EditServiceController>(
      init: EditServiceController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppBar(
            backgroundColor: colors.surface,
            elevation: 0,
            title: Text(
              'driver.services.edit_service'.tr,
              style: AppTypography.headlineMedium(context),
            ),
            leading: IconButton(
              icon: Icon(Icons.close, color: colors.textPrimary),
              onPressed: () => controller.cancelEdit(),
            ),
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(color: colors.primary),
              );
            }

            if (controller.errorMessage.value.isNotEmpty) {
              return _ErrorWidget(
                message: controller.errorMessage.value,
                colors: colors,
                onRetry: () => controller.onInit(),
              );
            }

            if (controller.currentService.value == null) {
              return Center(
                child: Text(
                  'driver.services.service_not_found'.tr,
                  style: AppTypography.bodyMedium(context)
                      .copyWith(color: colors.textPrimary),
                ),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service Info Header
                  _ServiceInfoHeader(
                    service: controller.currentService.value!,
                    colors: colors,
                  ),

                  SizedBox(height: 24.h),

                  // Images Section
                  _ImagesSection(
                    controller: controller,
                    colors: colors,
                  ),

                  SizedBox(height: 24.h),
                  Text(
                    'driver.services.title'.tr,
                    style: AppTypography.bodyLarge(context)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.h),
                  Obx(
                    () => TextField(
                      controller: controller.titleController,
                      decoration: InputDecoration(
                        hintText: 'driver.services.enter_service_title'.tr,
                        filled: true,
                        fillColor: colors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: controller.isTitleValid.value
                                ? colors.border
                                : Colors.red,
                          ),
                        ),
                        errorText: controller.isTitleValid.value
                            ? null
                            : 'At least 3 characters',
                      ),
                      style: AppTypography.bodyMedium(context),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Description
                  Text(
                    'driver.services.description'.tr,
                    style: AppTypography.bodyLarge(context)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.h),
                  Obx(
                    () => TextField(
                      controller: controller.descriptionController,
                      minLines: 4,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText:
                            'driver.services.enter_service_description'.tr,
                        filled: true,
                        fillColor: colors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: controller.isDescriptionValid.value
                                ? colors.border
                                : Colors.red,
                          ),
                        ),
                        errorText: controller.isDescriptionValid.value
                            ? null
                            : 'At least 10 characters',
                      ),
                      style: AppTypography.bodyMedium(context),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Pricing Section
                  Text(
                    'driver.services.pricing'.tr,
                    style: AppTypography.bodyLarge(context)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12.h),

                  // Base Price
                  Text(
                    'driver.services.base_price'.tr,
                    style: AppTypography.bodyMedium(context),
                  ),
                  SizedBox(height: 6.h),
                  Obx(
                    () => TextField(
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: false),
                      onChanged: (val) {
                        controller
                            .setBasePrice(double.tryParse(val));
                      },
                      controller: TextEditingController(
                        text: controller.basePrice.value?.toString() ?? '',
                      )..selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: (controller.basePrice.value?.toString() ??
                                      '')
                                  .length)),
                      decoration: InputDecoration(
                        hintText: 'e.g., 150',
                        filled: true,
                        fillColor: colors.surface,
                        suffixText: CurrencyHelper.symbol,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: colors.border),
                        ),
                      ),
                      style: AppTypography.bodyMedium(context),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Price Per KM
                  Text(
                    'driver.services.price_per_km'.tr,
                    style: AppTypography.bodyMedium(context),
                  ),
                  SizedBox(height: 6.h),
                  Obx(
                    () => TextField(
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      onChanged: (val) {
                        controller.setPricePerKm(
                            double.tryParse(val));
                      },
                      controller: TextEditingController(
                        text: controller.pricePerKm.value?.toString() ?? '',
                      )..selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: (controller.pricePerKm.value?.toString() ??
                                      '')
                                  .length)),
                      decoration: InputDecoration(
                        hintText: 'e.g., 5.50',
                        filled: true,
                        fillColor: colors.surface,
                        suffixText: '${CurrencyHelper.symbol}/km',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: colors.border),
                        ),
                      ),
                      style: AppTypography.bodyMedium(context),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Price Per Hour
                  Text(
                    'driver.services.price_per_hour'.tr,
                    style: AppTypography.bodyMedium(context),
                  ),
                  SizedBox(height: 6.h),
                  Obx(
                    () => TextField(
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      onChanged: (val) {
                        controller
                            .setPricePerHour(double.tryParse(val));
                      },
                      controller: TextEditingController(
                        text: controller.pricePerHour.value?.toString() ?? '',
                      )..selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: (controller.pricePerHour.value
                                      ?.toString() ??
                                      '')
                                  .length)),
                      decoration: InputDecoration(
                        hintText: 'e.g., 100.00',
                        filled: true,
                        fillColor: colors.surface,
                        suffixText: '${CurrencyHelper.symbol}/hr',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: colors.border),
                        ),
                      ),
                      style: AppTypography.bodyMedium(context),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Minimum Price
                  Text(
                    'driver.services.minimum_price'.tr,
                    style: AppTypography.bodyMedium(context),
                  ),
                  SizedBox(height: 6.h),
                  Obx(
                    () => TextField(
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: false),
                      onChanged: (val) {
                        controller.setMinPrice(double.tryParse(val));
                      },
                      controller: TextEditingController(
                        text: controller.minPrice.value?.toString() ?? '',
                      )..selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: (controller.minPrice.value?.toString() ??
                                      '')
                                  .length)),
                      decoration: InputDecoration(
                        hintText: 'e.g., 50',
                        filled: true,
                        fillColor: colors.surface,
                        suffixText: CurrencyHelper.symbol,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: colors.border),
                        ),
                      ),
                      style: AppTypography.bodyMedium(context),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Availability Toggle
                  Text(
                    'driver.services.availability'.tr,
                    style: AppTypography.bodyLarge(context)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12.h),
                  Obx(() => SwitchListTile(
                    value: controller.isAvailable.value,
                    onChanged: (_) => controller.toggleAvailability(),
                    title: Text(
                      controller.isAvailable.value
                          ? 'driver.services.available'.tr
                          : 'driver.services.unavailable'.tr,
                      style: AppTypography.bodyMedium(context)
                          .copyWith(color: colors.textPrimary),
                    ),
                    activeColor: colors.success,
                    inactiveTrackColor: colors.border,
                    contentPadding: EdgeInsets.zero,
                  )),

                  SizedBox(height: 24.h),

                  // Form Changed Indicator
                  Obx(() {
                    if (!controller.isFormChanged.value) {
                      return SizedBox.shrink();
                    }
                    return Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: colors.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                        border:
                            Border.all(color: colors.warning, width: 1),
                      ),
                      child: Row(
                        children: [
                          Icon(Iconsax.info_circle,
                              color: colors.warning, size: 20),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'driver.services.unsaved_changes'.tr,
                              style:
                                  AppTypography.bodyMedium(context)
                                      .copyWith(color: colors.warning),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  SizedBox(height: 24.h),

                  // Action Buttons
                  Obx(() => Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: controller.isSaving.value
                              ? null
                              : () => controller.cancelEdit(),
                          icon: Icon(Iconsax.close_circle),
                          label: Text('common.cancel'.tr),
                          style: OutlinedButton.styleFrom(
                            padding:
                                EdgeInsets.symmetric(vertical: 16.h),
                            side: BorderSide(
                                color: colors.textSecondary),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: (controller.isSaving.value ||
                                  !controller.isFormChanged.value)
                              ? null
                              : () => controller.submitUpdate(),
                          icon: controller.isSaving.value
                              ? SizedBox(
                                  height: 20.h,
                                  width: 20.h,
                                  child:
                                      CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor:
                                        AlwaysStoppedAnimation(
                                            Colors.white),
                                  ),
                                )
                              : Icon(Iconsax.tick_circle),
                          label: Text(
                            controller.isSaving.value
                                ? 'common.updating'.tr
                                : 'driver.services.update'.tr,
                            style: AppTypography.bodyLarge(context)
                                .copyWith(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.primary,
                            foregroundColor: Colors.white,
                            padding:
                                EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12.r),
                            ),
                            disabledBackgroundColor:
                                colors.primary.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  )),

                  SizedBox(height: 40.h),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}

/// Service info header widget
class _ServiceInfoHeader extends StatelessWidget {
  final DriverService service;
  final AppColorScheme colors;

  const _ServiceInfoHeader({
    required this.service,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.border, width: 1),
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
                child: Icon(Iconsax.setting_2,
                    color: colors.primary, size: 24),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.title ?? 'N/A',
                      style: AppTypography.headlineSmall(context)
                          .copyWith(color: colors.textPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      service.description ?? 'N/A',
                      style: AppTypography.bodySmall(context)
                          .copyWith(color: colors.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Error widget
class _ErrorWidget extends StatelessWidget {
  final String message;
  final AppColorScheme colors;
  final VoidCallback onRetry;

  const _ErrorWidget({
    required this.message,
    required this.colors,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.close_circle,
            size: 64.sp,
            color: colors.error,
          ),
          SizedBox(height: 16.h),
          Text(
            'common.error'.tr,
            style: AppTypography.headlineSmall(context)
                .copyWith(color: colors.error),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium(context)
                .copyWith(color: colors.textSecondary),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              padding: EdgeInsets.symmetric(
                  horizontal: 32.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'common.retry'.tr,
              style: AppTypography.labelLarge(context)
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

/// Images section widget
class _ImagesSection extends StatelessWidget {
  final EditServiceController controller;
  final AppColorScheme colors;

  const _ImagesSection({
    required this.controller,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'driver.services.images'.tr,
          style: AppTypography.bodyMedium(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        
        // Existing images
        Obx(() {
          if (controller.existingImageUrls.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'driver.services.current_images'.tr,
                  style: AppTypography.bodySmall(context)
                      .copyWith(color: colors.textSecondary),
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  height: 120.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.existingImageUrls.length,
                    itemBuilder: (context, index) {
                      final imageUrl = controller.existingImageUrls[index];
                      return Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                width: 120.w,
                                height: 120.h,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    Container(
                                  width: 120.w,
                                  height: 120.h,
                                  decoration: BoxDecoration(
                                    color: colors.surface,
                                    borderRadius:
                                        BorderRadius.circular(12.r),
                                  ),
                                  child: Icon(Iconsax.image, size: 32.sp),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4.w,
                              right: 4.w,
                              child: GestureDetector(
                                onTap: () =>
                                    controller.removeExistingImage(imageUrl),
                                child: Container(
                                  padding: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                    color: colors.error,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Iconsax.close_circle,
                                    color: Colors.white,
                                    size: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            );
          }
          return SizedBox.shrink();
        }),

        // New images
        Obx(() {
          if (controller.newImages.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'driver.services.new_images'.tr,
                  style: AppTypography.bodySmall(context)
                      .copyWith(color: colors.textSecondary),
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  height: 120.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.newImages.length,
                    itemBuilder: (context, index) {
                      final imageFile = controller.newImages[index];
                      return Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.file(
                                imageFile,
                                width: 120.w,
                                height: 120.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 4.w,
                              right: 4.w,
                              child: GestureDetector(
                                onTap: () =>
                                    controller.removeNewImage(index),
                                child: Container(
                                  padding: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                    color: colors.error,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Iconsax.close_circle,
                                    color: Colors.white,
                                    size: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 4.w,
                              left: 4.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: colors.primary,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  'driver.services.new'.tr,
                                  style: AppTypography.bodySmall(context)
                                      .copyWith(
                                    color: Colors.white,
                                    fontSize: 9.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            );
          }
          return SizedBox.shrink();
        }),

        // Add image button
        Obx(() => SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: controller.isUploadingImages.value
                ? null
                : () => controller.pickImage(),
            icon: Icon(Iconsax.gallery_add, size: 18.sp),
            label: Text('driver.services.add_image'.tr),
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.primary,
              side: BorderSide(color: colors.primary),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        )),
      ],
    );
  }
}
