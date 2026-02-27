import 'package:awhar_client/awhar_client.dart';
import 'package:awhar_flutter/core/controllers/request_controller.dart';
import 'package:awhar_flutter/core/services/location_service.dart';
import 'package:awhar_flutter/core/services/guest_auth_service.dart';
import 'package:awhar_flutter/core/theme/app_colors.dart';
import 'package:awhar_flutter/core/theme/app_typography.dart';
import 'package:awhar_flutter/core/utils/translation_debug.dart';
import 'package:awhar_flutter/core/utils/currency_helper.dart';
import 'package:awhar_flutter/shared/widgets/concierge_input_widget.dart';
import 'package:awhar_flutter/app/routes/app_routes.dart';
import 'package:awhar_flutter/shared/widgets/location_mode_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../core/services/presence_service.dart';

/// Redesigned Create Request Screen with Concierge-first UX
class CreateRequestScreen extends StatefulWidget {
  const CreateRequestScreen({super.key});

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  final RequestController controller = Get.put(RequestController());
  final TextEditingController itemDescriptionController =
      TextEditingController();
  final TextEditingController itemCostController = TextEditingController();
  final TextEditingController deliveryFeeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Debug: Check translations on screen load
    TranslationDebug.printLoadedKeys();

    _initializeDestination();

    // Watch for offline driver warnings
    ever(controller.catalogDriver, (driver) {
      if (driver != null && !driver.isOnline) {
        Get.snackbar(
          'common.warning'.tr,
          'request.driver_offline_warning'.tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFF5A623), // Warning orange color
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
          margin: EdgeInsets.all(16.w),
          icon: const Icon(Iconsax.warning_2, color: Colors.white),
        );
      }
    });

    // Bind text controllers to reactive variables
    itemDescriptionController.addListener(() {
      controller.itemDescriptionText.value = itemDescriptionController.text;
    });

    itemCostController.addListener(() {
      controller.estimatedPurchaseCost.value =
          double.tryParse(itemCostController.text) ?? 0.0;
    });

    deliveryFeeController.addListener(() {
      controller.clientOfferedPrice.value =
          double.tryParse(deliveryFeeController.text) ?? 0.0;
    });

    // Error handling
    ever(controller.errorMessage, (String message) {
      if (message.isNotEmpty) {
        Get.snackbar(
          'common.error'.tr,
          message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          margin: EdgeInsets.all(16.w),
        );
        controller.clearError();
      }
    });
  }

  @override
  void dispose() {
    itemDescriptionController.dispose();
    itemCostController.dispose();
    deliveryFeeController.dispose();
    super.dispose();
  }

  Future<void> _initializeDestination() async {
    try {
      final locationService = Get.find<LocationService>();
      final position = await locationService.getCurrentPosition();
      if (position != null && controller.destinationLocation.value == null) {
        controller.destinationLocation.value = Location(
          latitude: position.latitude,
          longitude: position.longitude,
          address: 'Current Location',
          placeName: 'Your current location',
          city: null,
          country: 'Morocco',
        );
      }
    } catch (e) {
      debugPrint('[CreateRequest] Could not auto-populate destination: $e');
    }
  }

  bool _canSubmit() {
    // For concierge: Destination + Description + Fee are required
    // Pickup is optional if flexible mode
    return controller.destinationLocation.value != null &&
        controller.itemDescriptionText.value.isNotEmpty &&
        controller.clientOfferedPrice.value >= 15 &&
        (!controller.isPurchaseRequired.value ||
            controller.estimatedPurchaseCost.value > 0);
  }

  Widget _buildDriverAssignmentDisplay(
    BuildContext context,
    AppColorScheme colors,
  ) {
    return Obx(() {
      if (!controller.fromCatalog.value ||
          controller.catalogDriver.value == null) {
        return const SizedBox.shrink();
      }

      final driver = controller.catalogDriver.value!;
      // Presence overlay: prefer realtime presence; fallback to server field
      final presenceService = Get.find<PresenceService>();
      final isOnline =
          driver.isOnline; // default; will be overridden by StreamBuilder below

      return Container(
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colors.success.withOpacity(0.1),
              colors.success.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: colors.success.withOpacity(0.35),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.success.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Checkmark icon with enhanced styling
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colors.success, colors.success.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colors.success.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Iconsax.shield_tick,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'request.assigned_driver'.tr,
                    style: AppTypography.bodySmall(context).copyWith(
                      color: colors.textSecondary,
                      fontWeight: FontWeight.w500,
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    driver.displayName,
                    style: AppTypography.labelLarge(context).copyWith(
                      color: colors.success,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
            // Status badge with realtime presence
            StreamBuilder<bool>(
              stream: presenceService.watchUserOnline(driver.userId),
              builder: (context, snapshot) {
                final online = snapshot.data ?? isOnline;
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: online
                        ? colors.success.withOpacity(0.15)
                        : colors.warning.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: online
                          ? colors.success.withOpacity(0.3)
                          : colors.warning.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7.w,
                        height: 7.w,
                        decoration: BoxDecoration(
                          color: online ? colors.success : colors.warning,
                          shape: BoxShape.circle,
                          boxShadow: online
                              ? [
                                  BoxShadow(
                                    color: colors.success.withOpacity(0.4),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        online ? 'common.online'.tr : 'common.offline'.tr,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: online ? colors.success : colors.warning,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildCatalogIndicator(AppColorScheme colors) {
    return Obx(() {
      if (!controller.fromCatalog.value ||
          controller.catalogService.value == null) {
        return const SizedBox.shrink();
      }

      final service = controller.catalogService.value!;
      final driver = controller.catalogDriver.value;
      final isOnline = driver?.isOnline ?? false;

      return Container(
        margin: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          bottom: 24.h,
          top: 12.h,
        ),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colors.primary.withOpacity(0.12),
              colors.primary.withOpacity(0.06),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: colors.primary.withOpacity(0.35),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.primary.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colors.primary,
                        colors.primary.withOpacity(0.85),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: colors.primary.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Iconsax.document,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'request.booking_from_catalog'.tr,
                        style: AppTypography.labelLarge(context).copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        service.title ?? 'Service',
                        style: AppTypography.bodyMedium(context).copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    size: 20.sp,
                    color: colors.textSecondary,
                  ),
                  onPressed: () {
                    controller.fromCatalog.value = false;
                    controller.catalogService.value = null;
                    controller.catalogDriver.value = null;
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),

            // Driver info + availability
            if (driver != null) ...[
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: colors.border.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    // Driver avatar with gradient border
                    Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colors.primary,
                            colors.primary.withOpacity(0.7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child:
                          driver.profilePhotoUrl != null &&
                              driver.profilePhotoUrl!.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.network(
                                driver.profilePhotoUrl!,
                                width: 44.w,
                                height: 44.h,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      width: 44.w,
                                      height: 44.h,
                                      decoration: BoxDecoration(
                                        color: colors.primary.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Icon(
                                        Iconsax.user,
                                        color: colors.primary,
                                        size: 18.sp,
                                      ),
                                    ),
                              ),
                            )
                          : Container(
                              width: 44.w,
                              height: 44.h,
                              decoration: BoxDecoration(
                                color: colors.primary.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Iconsax.user,
                                color: colors.primary,
                                size: 20.sp,
                              ),
                            ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            driver.displayName,
                            style: AppTypography.labelLarge(context).copyWith(
                              color: colors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Iconsax.star,
                                size: 12.sp,
                                color: colors.warning,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${driver.ratingAverage?.toStringAsFixed(1) ?? '0.0'} (${driver.ratingCount ?? 0})',
                                style: AppTypography.bodySmall(context)
                                    .copyWith(
                                      color: colors.textSecondary,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Online status badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: isOnline
                            ? colors.success.withOpacity(0.1)
                            : colors.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6.w,
                            height: 6.w,
                            decoration: BoxDecoration(
                              color: isOnline ? colors.success : colors.warning,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            isOnline ? 'common.online'.tr : 'common.offline'.tr,
                            style: AppTypography.bodySmall(context).copyWith(
                              color: isOnline ? colors.success : colors.warning,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'request.create_title'.tr,
          style: AppTypography.titleLarge(
            context,
          ).copyWith(color: colors.textPrimary),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Catalog Indicator (if request is from catalog)
              _buildCatalogIndicator(colors),

              // Driver Assignment Display (read-only for catalog requests)
              _buildDriverAssignmentDisplay(context, colors),

              // Step 1: Service Type Selection
              Text(
                'request.select_service_type'.tr,
                style: AppTypography.titleMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),
              _buildServiceTypeSelector(colors),
              SizedBox(height: 32.h),

              // Step 2: "What do you need?" - PRIORITY INPUT
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'concierge.what_do_you_need'.tr,
                      style: AppTypography.titleMedium(context).copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // AI Concierge button
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.aiConcierge),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [colors.primary, colors.primaryHover],
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: colors.primary.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'concierge_chat.ai_button'.tr,
                            style: AppTypography.labelSmall(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              ConciergeInputWidget(
                controller: itemDescriptionController,
                onAttachPhoto: _handleAttachPhoto,
                attachments: controller.attachments,
                onRemoveAttachment: () {
                  if (controller.attachments.isNotEmpty) {
                    controller.attachments.removeLast();
                  }
                },
              ),
              SizedBox(height: 32.h),

              // Step 3: Location Mode Toggle (only for Purchase/Task)
              if (controller.selectedServiceType.value ==
                      ServiceType.purchase ||
                  controller.selectedServiceType.value == ServiceType.task) ...[
                LocationModeToggle(
                  isFlexible: controller.isFlexiblePickup.value,
                  onChanged: (isFlexible) {
                    controller.isFlexiblePickup.value = isFlexible;
                    if (!isFlexible &&
                        controller.pickupLocation.value == null) {
                      _selectLocation(isPickup: true);
                    }
                  },
                  onPickSpecific: () => _selectLocation(isPickup: true),
                ),
                SizedBox(height: 32.h),
              ],

              // Step 4: Delivery Destination
              Text(
                'request.destination'.tr,
                style: AppTypography.titleMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),
              _buildLocationCard(
                colors,
                icon: Iconsax.location_tick,
                label:
                    controller.destinationLocation.value?.placeName ??
                    controller.destinationLocation.value?.address ??
                    'request.select_destination'.tr,
                onTap: () => _selectLocation(isPickup: false),
              ),
              SizedBox(height: 32.h),

              // Step 5: Cost Breakdown (for Purchase)
              if (controller.selectedServiceType.value ==
                  ServiceType.purchase) ...[
                _buildPurchaseCostSection(colors),
                SizedBox(height: 32.h),
              ],

              // Step 6: Delivery Fee Offer
              Text(
                'concierge.delivery_fee_offer'.tr,
                style: AppTypography.titleMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),

              // Show price breakdown if from catalog
              if (controller.fromCatalog.value &&
                  controller.catalogService.value != null)
                _buildPriceBreakdown(context, colors),

              Container(
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colors.border),
                ),
                child: TextField(
                  controller: deliveryFeeController,
                  keyboardType: TextInputType.number,
                  style: AppTypography.bodyLarge(
                    context,
                  ).copyWith(color: colors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'concierge.delivery_fee_hint'.tr,
                    hintStyle: AppTypography.bodyMedium(
                      context,
                    ).copyWith(color: colors.textSecondary),
                    prefixText: '${CurrencyHelper.symbol} ',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.w),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // Payment Notice
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: colors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: colors.warning.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.info_circle,
                      color: colors.warning,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'concierge.payment_notice_text'.tr,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),

              // Submit Button
              Obx(() {
                final canSubmit = _canSubmit();
                final isLoading = controller.isLoading.value;

                return Container(
                  width: double.infinity,
                  height: 60.h,
                  decoration: BoxDecoration(
                    gradient: canSubmit && !isLoading
                        ? LinearGradient(
                            colors: [
                              colors.primary,
                              colors.primary.withOpacity(0.85),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          )
                        : null,
                    color: !canSubmit || isLoading
                        ? colors.border.withOpacity(0.3)
                        : null,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: canSubmit && !isLoading
                        ? [
                            BoxShadow(
                              color: colors.primary.withOpacity(0.3),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ]
                        : null,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: canSubmit && !isLoading
                          ? () => _handleSubmitWithAuth(context, colors)
                          : null,
                      borderRadius: BorderRadius.circular(16.r),
                      child: Container(
                        alignment: Alignment.center,
                        child: isLoading
                            ? SizedBox(
                                height: 26.h,
                                width: 26.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Iconsax.tick_circle,
                                    color: Colors.white,
                                    size: 24.sp,
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    'request.post_request'.tr,
                                    style: AppTypography.titleMedium(context)
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.5,
                                        ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceTypeSelector(AppColorScheme colors) {
    return Row(
      children: [
        Expanded(
          child: _buildServiceTypeChip(
            colors,
            ServiceType.purchase,
            Iconsax.bag_2,
            'service_type.purchase'.tr,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: _buildServiceTypeChip(
            colors,
            ServiceType.delivery,
            Iconsax.box,
            'service_type.delivery'.tr,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: _buildServiceTypeChip(
            colors,
            ServiceType.task,
            Iconsax.task,
            'service_type.task'.tr,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceTypeChip(
    AppColorScheme colors,
    ServiceType type,
    IconData icon,
    String label,
  ) {
    final isSelected = controller.selectedServiceType.value == type;
    return GestureDetector(
      onTap: () {
        controller.selectedServiceType.value = type;
        controller.isPurchaseRequired.value = (type == ServiceType.purchase);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [colors.primary, colors.primary.withOpacity(0.85)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? colors.primary : colors.border.withOpacity(0.5),
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colors.primary.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : colors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : colors.primary,
                size: 20.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Flexible(
              child: Text(
                label,
                style: AppTypography.labelSmall(context).copyWith(
                  color: isSelected ? Colors.white : colors.textPrimary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                  fontSize: 11.sp,
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

  Widget _buildLocationCard(
    AppColorScheme colors, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final hasLocation = !label.contains('select') && !label.contains('Select');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: hasLocation
                ? colors.primary.withOpacity(0.4)
                : colors.border.withOpacity(0.6),
            width: hasLocation ? 1.5 : 1,
          ),
          boxShadow: hasLocation
              ? [
                  BoxShadow(
                    color: colors.primary.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                gradient: hasLocation
                    ? LinearGradient(
                        colors: [
                          colors.primary.withOpacity(0.15),
                          colors.primary.withOpacity(0.08),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: hasLocation ? null : colors.border.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: hasLocation ? colors.primary : colors.textSecondary,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hasLocation ? label : 'request.tap_to_select'.tr,
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: hasLocation
                          ? colors.textPrimary
                          : colors.textSecondary,
                      fontWeight: hasLocation
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (!hasLocation)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        label,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: colors.textSecondary.withOpacity(0.7),
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              hasLocation ? Iconsax.edit : Iconsax.arrow_right_3,
              color: colors.textSecondary,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseCostSection(AppColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'concierge.item_cost_estimate'.tr,
          style: AppTypography.titleMedium(
            context,
          ).copyWith(color: colors.textPrimary),
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: colors.border),
          ),
          child: TextField(
            controller: itemCostController,
            keyboardType: TextInputType.number,
            style: AppTypography.bodyLarge(
              context,
            ).copyWith(color: colors.textPrimary),
            decoration: InputDecoration(
              hintText: 'concierge.item_cost_hint'.tr,
              hintStyle: AppTypography.bodyMedium(
                context,
              ).copyWith(color: colors.textSecondary),
              prefixText: '${CurrencyHelper.symbol} ',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16.w),
            ),
          ),
        ),
      ],
    );
  }

  void _handleAttachPhoto() {
    // TODO: Implement image picker
    Get.snackbar(
      'Coming Soon',
      'Photo attachment feature will be added soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Widget _buildPriceBreakdown(BuildContext context, AppColorScheme colors) {
    final service = controller.catalogService.value;
    if (service == null) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.success.withOpacity(0.08),
            colors.success.withOpacity(0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: colors.success.withOpacity(0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.success.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: colors.success.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.receipt_item,
                  size: 18.sp,
                  color: colors.success,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'request.service_price_breakdown'.tr,
                style: AppTypography.labelLarge(context).copyWith(
                  color: colors.success,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Service name
          _buildPriceRow(
            context,
            colors,
            'request.service_name'.tr,
            service.title ?? 'Service',
          ),

          if (service.basePrice != null && service.basePrice! > 0) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Divider(
                color: colors.success.withOpacity(0.2),
                thickness: 1,
              ),
            ),
            _buildPriceRow(
              context,
              colors,
              'request.suggested_price'.tr,
              CurrencyHelper.format(service.basePrice!),
              isBold: true,
              isHighlight: true,
            ),
          ],

          if (service.minPrice != null && service.minPrice! > 0) ...[
            SizedBox(height: 10.h),
            _buildPriceRow(
              context,
              colors,
              'request.minimum_price'.tr,
              CurrencyHelper.format(service.minPrice!),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    BuildContext context,
    AppColorScheme colors,
    String label,
    String value, {
    bool isBold = false,
    bool isHighlight = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: AppTypography.bodyMedium(context).copyWith(
              color: isHighlight ? colors.success : colors.textSecondary,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          value,
          style: AppTypography.bodyMedium(context).copyWith(
            color: isHighlight ? colors.success : colors.textPrimary,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            fontSize: isBold ? 15.sp : 14.sp,
          ),
        ),
      ],
    );
  }

  /// Handle submit with authentication check
  /// If guest, show login prompt. If authenticated, proceed to confirmation.
  void _handleSubmitWithAuth(BuildContext context, AppColorScheme colors) {
    final guestAuthService = Get.find<GuestAuthService>();

    // Check if user is authenticated
    if (!guestAuthService.requireAuth(
      context: context,
      action: 'guest.action_create_request',
      returnRoute: '/client/create-request',
    )) {
      return; // User will be prompted to login
    }

    // User is authenticated, show confirmation dialog
    _showConfirmationDialog(context, colors);
  }

  Future<void> _showConfirmationDialog(
    BuildContext context,
    AppColorScheme colors,
  ) async {
    final confirmed = await Get.defaultDialog(
      title: 'request.confirm_request'.tr,
      titleStyle: AppTypography.titleLarge(context).copyWith(
        color: colors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.fromCatalog.value) ...[
            // Catalog request confirmation
            Text(
              'request.confirm_catalog_request'.tr,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
              ),
            ),
            SizedBox(height: 16.h),
            _buildConfirmationRow(
              context,
              colors,
              'request.service'.tr,
              controller.catalogService.value?.title ?? 'Service',
            ),
            _buildConfirmationRow(
              context,
              colors,
              'request.driver'.tr,
              controller.catalogDriver.value?.displayName ?? 'Unknown',
            ),
            _buildConfirmationRow(
              context,
              colors,
              'request.your_offer'.tr,
              CurrencyHelper.format(controller.clientOfferedPrice.value),
              isHighlight: true,
            ),
          ] else ...[
            Text(
              'request.confirm_generic_request'.tr,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
              ),
            ),
            SizedBox(height: 16.h),
            _buildConfirmationRow(
              context,
              colors,
              'request.your_offer'.tr,
              CurrencyHelper.format(controller.clientOfferedPrice.value),
              isHighlight: true,
            ),
          ],
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: colors.info.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              'request.negotiable_notice'.tr,
              style: AppTypography.bodySmall(context).copyWith(
                color: colors.info,
              ),
            ),
          ),
        ],
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(result: false),
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.textSecondary,
          side: BorderSide(color: colors.border),
        ),
        child: Text('common.cancel'.tr),
      ),
      confirm: ElevatedButton(
        onPressed: () => Get.back(result: true),
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
        ),
        child: Text('request.confirm_and_post'.tr),
      ),
      backgroundColor: colors.background,
      radius: 16.r,
    );

    if (confirmed == true) {
      await _handleSubmit();
    }
  }

  Widget _buildConfirmationRow(
    BuildContext context,
    AppColorScheme colors,
    String label,
    String value, {
    bool isHighlight = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
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
            style: AppTypography.bodyMedium(context).copyWith(
              color: isHighlight ? colors.primary : colors.textPrimary,
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectLocation({required bool isPickup}) async {
    final result = await Get.toNamed(
      '/location-picker',
      arguments: {'isPickup': isPickup},
    );

    if (result != null && result is Map<String, dynamic>) {
      final location = Location(
        latitude: result['lat'] as double,
        longitude: result['lng'] as double,
        address: result['address'] as String?,
        placeName: result['address'] as String?,
        city: null,
        country: 'Morocco',
      );

      if (isPickup) {
        controller.pickupLocation.value = location;
      } else {
        controller.destinationLocation.value = location;
      }
    }
  }

  Future<void> _handleSubmit() async {
    final success = await controller.createRequest();
    if (success) {
      final catalogDriver = controller.catalogDriver.value;
      final request = controller.activeRequest.value;

      // Navigate to AI Matching screen instead of just going back
      // This shows the beautiful real-time matching visualization
      Get.back(); // pop CreateRequestScreen

      Get.toNamed(
        AppRoutes.aiMatching,
        arguments: {
          'requestId': request?.id,
          'serviceType': controller.selectedServiceType.value,
          'latitude': controller.pickupLocation.value?.latitude ??
              controller.destinationLocation.value?.latitude,
          'longitude': controller.pickupLocation.value?.longitude ??
              controller.destinationLocation.value?.longitude,
        },
      );

      // If from catalog, offer to open direct chat with driver after matching
      if (controller.fromCatalog.value && catalogDriver != null) {
        await Future.delayed(const Duration(seconds: 1));

        Get.defaultDialog(
          title: 'request.start_chat_title'.tr,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Iconsax.message,
                size: 40.sp,
                color: const Color(0xFFFF7A2F), // Primary orange
              ),
              SizedBox(height: 12.h),
              Text(
                'request.start_chat_description'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              SizedBox(height: 8.h),
              Text(
                catalogDriver.displayName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFF7A2F), // Primary orange
                ),
              ),
            ],
          ),
          cancel: TextButton(
            onPressed: () => Get.back(),
            child: Text('common.later'.tr),
          ),
          confirm: ElevatedButton(
            onPressed: () {
              Get.back();
              // Navigate to direct chat with driver
              Get.toNamed(
                '/direct-chat',
                arguments: {
                  'userId': catalogDriver.id,
                  'userName': catalogDriver.displayName,
                  'userAvatar': catalogDriver.profilePhotoUrl,
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF7A2F), // Primary orange
            ),
            child: Text('request.open_chat'.tr),
          ),
          backgroundColor: const Color(0xFFFFF1DF), // Light background
          radius: 16.r,
          barrierDismissible: true,
        );
      }
    }
  }
}
