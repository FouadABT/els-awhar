import 'package:awhar_client/awhar_client.dart';
import 'package:awhar_flutter/core/controllers/auth_controller.dart';
import 'package:awhar_flutter/core/services/request_service.dart';
import 'package:awhar_flutter/core/theme/app_colors.dart';
import 'package:awhar_flutter/core/theme/app_typography.dart';
import 'package:awhar_flutter/core/utils/currency_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

/// Screen for client to review and approve/reject proposed driver
class DriverReviewScreen extends StatefulWidget {
  final ServiceRequest request;

  const DriverReviewScreen({super.key, required this.request});

  @override
  State<DriverReviewScreen> createState() => _DriverReviewScreenState();
}

class _DriverReviewScreenState extends State<DriverReviewScreen> {
  final RequestService _requestService = Get.find<RequestService>();
  final AuthController _authController = Get.find<AuthController>();
  final RxBool isProcessing = false.obs;

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
          'Driver Review',
          style: AppTypography.titleLarge(context).copyWith(color: colors.textPrimary),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Success message
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: colors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colors.success),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.tick_circle, color: colors.success, size: 24.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'A driver wants to take your request!',
                        style: AppTypography.bodyMedium(context).copyWith(
                          color: colors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Driver Info Card
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: colors.border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Driver avatar
                    CircleAvatar(
                      radius: 40.r,
                      backgroundColor: colors.primary.withValues(alpha: 0.1),
                      child: Icon(
                        Iconsax.user,
                        size: 40.sp,
                        color: colors.primary,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Driver name
                    Text(
                      widget.request.proposedDriverName ?? 'Driver',
                      style: AppTypography.headlineSmall(context).copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Driver phone
                    if (widget.request.proposedDriverPhone != null) ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: colors.info.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Iconsax.call, color: colors.info, size: 16.sp),
                            SizedBox(width: 6.w),
                            Text(
                              widget.request.proposedDriverPhone!,
                              style: AppTypography.bodyMedium(context).copyWith(
                                color: colors.info,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: 24.h),

                    // Stats (placeholder for future rating/trips)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(colors, Iconsax.star, '4.8', 'Rating'),
                        Container(width: 1, height: 40.h, color: colors.border),
                        _buildStatItem(colors, Iconsax.routing, '120+', 'Trips'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Request details
              Text(
                'Request Details',
                style: AppTypography.titleMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),

              _buildDetailRow(colors, Iconsax.box, 'Service', 
                widget.request.serviceType.name.capitalizeFirst ?? ''),
              SizedBox(height: 12.h),
              _buildDetailRow(colors, Iconsax.location, 'Pickup', 
                widget.request.pickupLocation?.placeName ?? widget.request.pickupLocation?.address ?? 'Location'),
              SizedBox(height: 12.h),
              _buildDetailRow(colors, Iconsax.location_tick, 'Destination', 
                widget.request.destinationLocation.placeName ?? widget.request.destinationLocation.address ?? 'Location'),
              SizedBox(height: 12.h),
              _buildDetailRow(colors, Iconsax.wallet, 'Price', 
                CurrencyHelper.formatWithSymbol(widget.request.clientOfferedPrice ?? widget.request.totalPrice, widget.request.currencySymbol)),
              
              SizedBox(height: 32.h),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56.h,
                      child: OutlinedButton(
                        onPressed: isProcessing.value ? null : () => _rejectDriver(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: colors.error, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Reject',
                          style: AppTypography.titleMedium(context).copyWith(
                            color: colors.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: isProcessing.value ? null : () => _approveDriver(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.success,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: isProcessing.value
                            ? SizedBox(
                                height: 24.h,
                                width: 24.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Iconsax.tick_circle, color: Colors.white, size: 20.sp),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Accept Driver',
                                    style: AppTypography.titleMedium(context).copyWith(
                                      color: Colors.white,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(AppColorScheme colors, IconData icon, String value, String label) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: colors.warning, size: 20.sp),
            SizedBox(width: 6.w),
            Text(
              value,
              style: AppTypography.titleLarge(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: AppTypography.bodySmall(context).copyWith(
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(AppColorScheme colors, IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: colors.primary, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.bodySmall(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
              Text(
                value,
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _approveDriver() async {
    try {
      isProcessing.value = true;
      
      final clientId = _authController.currentUser.value?.id;
      if (clientId == null) {
        throw Exception('Not authenticated');
      }

      await _requestService.approveDriver(
        requestId: widget.request.id!,
        clientId: clientId,
      );

      Get.back(result: true); // Go back and refresh
      Get.snackbar(
        'Success',
        'Driver approved! They will start the service soon.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Colors.white,
        icon: const Icon(Iconsax.tick_circle, color: Colors.white),
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to approve driver: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isProcessing.value = false;
    }
  }

  Future<void> _rejectDriver() async {
    try {
      isProcessing.value = true;
      
      final clientId = _authController.currentUser.value?.id;
      if (clientId == null) {
        throw Exception('Not authenticated');
      }

      await _requestService.rejectDriver(
        requestId: widget.request.id!,
        clientId: clientId,
      );

      Get.back(result: false); // Go back
      Get.snackbar(
        'Driver Rejected',
        'Your request is available for other drivers.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.colorScheme.surface,
        colorText: Get.theme.colorScheme.onSurface,
        icon: const Icon(Iconsax.info_circle),
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to reject driver: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isProcessing.value = false;
    }
  }
}
