import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import '../core/controllers/request_controller.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/currency_helper.dart';
import 'driver_offer_review_screen.dart';

class PendingRequestsScreen extends StatefulWidget {
  const PendingRequestsScreen({super.key});

  @override
  State<PendingRequestsScreen> createState() => _PendingRequestsScreenState();
}

class _PendingRequestsScreenState extends State<PendingRequestsScreen> {
  final RequestController _requestController = Get.find<RequestController>();

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    await _requestController.loadPendingRequests();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_copy, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'negotiation.pending_requests'.tr,
          style: AppTypography.titleLarge(context).copyWith(color: colors.textPrimary),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadRequests,
        color: colors.primary,
        child: Obx(() {
          if (_requestController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: colors.primary),
            );
          }

          if (_requestController.errorMessage.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.warning_2_copy,
                    size: 48.sp,
                    color: colors.error,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    _requestController.errorMessage.value,
                    style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: _loadRequests,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('common.retry'.tr),
                  ),
                ],
              ),
            );
          }

          final pendingRequests = _requestController.pendingRequests;

          if (pendingRequests.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.document_copy,
                    size: 80.sp,
                    color: colors.textMuted,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'negotiation.no_pending_requests'.tr,
                    style: AppTypography.titleMedium(
                      context,
                    ).copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: pendingRequests.length,
            itemBuilder: (context, index) {
              final request = pendingRequests[index];
              return _buildRequestCard(request, colors);
            },
          );
        }),
      ),
    );
  }

  Widget _buildRequestCard(dynamic request, AppColorScheme colors) {
    final hasOffer =
        request.driverCounterPrice != null && request.driverCounterPrice! > 0;
    final serviceTypeKey =
        'service_type.${request.serviceType.toString().split('.').last}';

    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      color: colors.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: InkWell(
        onTap: hasOffer ? () => _viewOffer(request) : null,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Service Type & Status
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      serviceTypeKey.tr,
                      style: AppTypography.labelSmall(context).copyWith(color: colors.primary),
                    ),
                  ),
                  const Spacer(),
                  _buildStatusBadge(hasOffer, colors),
                ],
              ),
              SizedBox(height: 12.h),

              // Pickup Location
              _buildLocationRow(
                Iconsax.location_copy,
                'request.pickup_location'.tr,
                request.pickupAddress ?? 'N/A',
                colors,
              ),
              SizedBox(height: 8.h),

              // Destination
              _buildLocationRow(
                Iconsax.location_tick_copy,
                'request.destination'.tr,
                request.destinationAddress ?? 'N/A',
                colors,
              ),
              SizedBox(height: 12.h),

              // Price & Timestamp
              Row(
                children: [
                  Icon(
                    Iconsax.money_3_copy,
                    size: 18.sp,
                    color: colors.success,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    CurrencyHelper.formatWithSymbol(request.clientOfferedPrice ?? 0, request.currencySymbol),
                    style: AppTypography.titleMedium(context).copyWith(color: colors.success),
                  ),
                  const Spacer(),
                  Text(
                    _formatTimestamp(request.createdAt),
                    style: AppTypography.labelSmall(context).copyWith(color: colors.textMuted),
                  ),
                ],
              ),

              // Action Button
              if (hasOffer) ...[
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _viewOffer(request),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'negotiation.view_offer'.tr,
                          style: AppTypography.labelLarge(
                            context,
                          ).copyWith(color: Colors.white),
                        ),
                        SizedBox(width: 8.w),
                        Icon(Iconsax.arrow_right_3_copy, size: 18.sp),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _cancelRequest(request),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colors.error),
                      foregroundColor: colors.error,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'negotiation.cancel_request'.tr,
                      style: AppTypography.labelLarge(context).copyWith(color: colors.error),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(bool hasOffer, AppColorScheme colors) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: hasOffer
            ? colors.success.withOpacity(0.1)
            : colors.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: hasOffer ? colors.success : colors.warning,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            hasOffer ? Iconsax.tick_circle_copy : Iconsax.clock_copy,
            size: 14.sp,
            color: hasOffer ? colors.success : colors.warning,
          ),
          SizedBox(width: 4.w),
          Text(
            hasOffer
                ? 'negotiation.offer_received'.tr
                : 'negotiation.waiting_for_offers'.tr,
            style: AppTypography.labelSmall(
              context,
            ).copyWith(color: hasOffer ? colors.success : colors.warning),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow(
    IconData icon,
    String label,
    String address,
    AppColorScheme colors,
  ) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: colors.textSecondary),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.labelSmall(context).copyWith(color: colors.textMuted),
              ),
              Text(
                address,
                style: AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatTimestamp(DateTime? timestamp) {
    if (timestamp == null) return '';
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'profile.just_now'.tr;
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      return DateFormat('MMM dd').format(timestamp);
    }
  }

  void _viewOffer(dynamic request) {
    Get.to(
      () => DriverOfferReviewScreen(request: request),
      transition: Transition.rightToLeft,
    );
  }

  void _cancelRequest(dynamic request) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.of(context).surface,
        title: Text(
          'negotiation.cancel_request'.tr,
          style: AppTypography.titleMedium(
            context,
          ).copyWith(color: AppColors.of(context).textPrimary),
        ),
        content: Text(
          'Are you sure you want to cancel this request?',
          style: AppTypography.bodyMedium(
            context,
          ).copyWith(color: AppColors.of(context).textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('common.cancel'.tr),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              // TODO: Implement cancel request
              Get.snackbar(
                'common.success'.tr,
                'Request cancelled',
                backgroundColor: AppColors.of(context).success,
                colorText: Colors.white,
              );
            },
            child: Text(
              'common.confirm'.tr,
              style: TextStyle(color: AppColors.of(context).error),
            ),
          ),
        ],
      ),
    );
  }
}
