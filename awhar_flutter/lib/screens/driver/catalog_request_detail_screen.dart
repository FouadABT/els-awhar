import 'package:awhar_client/awhar_client.dart';
import 'package:awhar_flutter/core/controllers/auth_controller.dart';
import 'package:awhar_flutter/core/controllers/request_controller.dart';
import 'package:awhar_flutter/core/theme/app_colors.dart';
import 'package:awhar_flutter/core/theme/app_typography.dart';
import 'package:awhar_flutter/core/utils/currency_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

/// Detailed view for a catalog request with full information and map
class CatalogRequestDetailScreen extends StatefulWidget {
  final ServiceRequest request;

  const CatalogRequestDetailScreen({
    super.key,
    required this.request,
  });

  @override
  State<CatalogRequestDetailScreen> createState() =>
      _CatalogRequestDetailScreenState();
}

class _CatalogRequestDetailScreenState extends State<CatalogRequestDetailScreen> {
  final RequestController controller = Get.find<RequestController>();
  late GoogleMapController mapController;
  final RxBool isLoading = false.obs;

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    
    final serviceType = widget.request.serviceType.toString().split('.').last;
    final price = widget.request.clientOfferedPrice ?? widget.request.totalPrice;
    final destination = widget.request.destinationLocation;

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
          'driver.services.catalog_request_details'.tr,
          style: AppTypography.headlineMedium(context).copyWith(color: colors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map Section
            if (destination != null)
              Container(
                height: 250.h,
                width: double.infinity,
                margin: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colors.border, width: 1),
                ),
                child: Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          destination.latitude,
                          destination.longitude,
                        ),
                        zoom: 15.0,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId('destination'),
                          position: LatLng(
                            destination.latitude,
                            destination.longitude,
                          ),
                          infoWindow: InfoWindow(
                            title: 'Delivery Location',
                            snippet: destination.address ?? 'Service Destination',
                          ),
                        ),
                      },
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                    ),
                    Positioned(
                      top: 12.w,
                      right: 12.w,
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(Iconsax.maximize_4, color: colors.textPrimary, size: 20.sp),
                          onPressed: () {
                            // Could open full screen map view
                            Get.snackbar(
                              'Map',
                              'Full screen map view',
                              snackPosition: SnackPosition.TOP,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: 8.h),

            // Client Card
            _buildSectionCard(
              colors,
              icon: Iconsax.user,
              title: 'driver.services.client_information'.tr,
              children: [
                _buildInfoRow(
                  context,
                  icon: Iconsax.user_square,
                  label: 'driver.services.name'.tr,
                  value: widget.request.clientName,
                  colors: colors,
                ),
                SizedBox(height: 12.h),
                _buildInfoRow(
                  context,
                  icon: Iconsax.call,
                  label: 'driver.services.phone'.tr,
                  value: widget.request.clientPhone ?? 'Not provided',
                  colors: colors,
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Service Details Card
            _buildSectionCard(
              colors,
              icon: Iconsax.bag_2,
              title: 'driver.services.service_details'.tr,
              children: [
                _buildInfoRow(
                  context,
                  icon: Iconsax.category,
                  label: 'driver.services.service_type'.tr,
                  value: serviceType.toUpperCase(),
                  colors: colors,
                  valueColor: colors.primary,
                ),
                SizedBox(height: 12.h),
                _buildInfoRow(
                  context,
                  icon: Iconsax.money,
                  label: 'driver.services.offered_price'.tr,
                  value: CurrencyHelper.formatWithSymbol(price, widget.request.currencySymbol),
                  colors: colors,
                  valueColor: colors.success,
                ),
                if (widget.request.distance != null) ...[
                  SizedBox(height: 12.h),
                  _buildInfoRow(
                    context,
                    icon: Iconsax.route_square,
                    label: 'driver.services.distance'.tr,
                    value: '${widget.request.distance!.toStringAsFixed(1)} km',
                    colors: colors,
                  ),
                ],
                if (widget.request.estimatedDuration != null) ...[
                  SizedBox(height: 12.h),
                  _buildInfoRow(
                    context,
                    icon: Iconsax.timer_1,
                    label: 'driver.services.est_duration'.tr,
                    value: '${widget.request.estimatedDuration} min',
                    colors: colors,
                  ),
                ],
              ],
            ),

            SizedBox(height: 12.h),

            // Location Card
            _buildSectionCard(
              colors,
              icon: Iconsax.location,
              title: 'driver.services.destination'.tr,
              children: [
                _buildInfoRow(
                  context,
                  icon: Iconsax.map,
                  label: 'driver.services.address'.tr,
                  value: destination?.address ?? 'Location not specified',
                  colors: colors,
                  multiLine: true,
                ),
                if (destination != null) ...[
                  SizedBox(height: 12.h),
                  _buildInfoRow(
                    context,
                    icon: Iconsax.gps,
                    label: 'driver.services.coordinates'.tr,
                    value: '${destination.latitude.toStringAsFixed(4)}, ${destination.longitude.toStringAsFixed(4)}',
                    colors: colors,
                    fontSize: 12.sp,
                  ),
                ],
              ],
            ),

            SizedBox(height: 12.h),

            // Request Info Card
            _buildSectionCard(
              colors,
              icon: Iconsax.document_text_1,
              title: 'driver.services.request_information'.tr,
              children: [
                _buildInfoRow(
                  context,
                  icon: Iconsax.receipt_text,
                  label: 'driver.services.request_id'.tr,
                  value: '#${widget.request.id}',
                  colors: colors,
                  valueColor: colors.primary,
                ),
                SizedBox(height: 12.h),
                _buildInfoRow(
                  context,
                  icon: Iconsax.calendar_1,
                  label: 'driver.services.created'.tr,
                  value: DateFormat('MMM d, h:mm a').format(widget.request.createdAt ?? DateTime.now()),
                  colors: colors,
                ),
                SizedBox(height: 12.h),
                _buildInfoRow(
                  context,
                  icon: Iconsax.status_up,
                  label: 'driver.services.status'.tr,
                  value: widget.request.status.toString().split('.').last.toUpperCase(),
                  colors: colors,
                  valueColor: colors.success,
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Notes Card (if exists)
            if (widget.request.notes != null && widget.request.notes!.isNotEmpty) ...[
              _buildSectionCard(
                colors,
                icon: Iconsax.note,
                title: 'driver.services.notes'.tr,
                children: [
                  Text(
                    widget.request.notes!,
                    style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
            ],

            // Action Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() => ElevatedButton.icon(
                      onPressed: isLoading.value ? null : () => _rejectRequest(),
                      icon: const Icon(Iconsax.close_circle),
                      label: isLoading.value 
                        ? SizedBox(
                            height: 20.h,
                            width: 20.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(colors.error),
                            ),
                          )
                        : Text('driver.services.reject'.tr),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.error.withOpacity(0.1),
                        foregroundColor: colors.error,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        disabledBackgroundColor: colors.error.withOpacity(0.05),
                      ),
                    )),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Obx(() => ElevatedButton.icon(
                      onPressed: isLoading.value ? null : () => _acceptRequest(),
                      icon: const Icon(Iconsax.tick_circle),
                      label: isLoading.value
                        ? SizedBox(
                            height: 20.h,
                            width: 20.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text('driver.services.accept'.tr),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        disabledBackgroundColor: colors.primary.withOpacity(0.5),
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    AppColorScheme colors, {
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: colors.primary, size: 20.sp),
              SizedBox(width: 12.w),
              Text(
                title,
                style: AppTypography.headlineSmall(context).copyWith(color: colors.textPrimary),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required AppColorScheme colors,
    Color? valueColor,
    bool multiLine = false,
    double? fontSize,
  }) {
    return Row(
      crossAxisAlignment: multiLine ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Icon(icon, color: colors.textSecondary, size: 18.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: AppTypography.bodyMedium(context).copyWith(
                  color: valueColor ?? colors.textPrimary,
                  fontSize: fontSize,
                ),
                maxLines: multiLine ? null : 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _acceptRequest() async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: Text('common.confirm_action'.tr),
        content: Text('driver.services.accept_catalog_request_confirm'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('common.cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: Text('driver.services.accept'.tr),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      isLoading.value = true;
      await controller.acceptRequest(widget.request.id!);
      
      Get.snackbar(
        'Success',
        'Request accepted! Navigating to active requests...',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Go back and refresh the list
      Get.back();
      Get.back(); // Go back twice to return to catalog requests list
    } catch (e) {
      print('[CatalogRequestDetail] Error accepting: $e');
      Get.snackbar(
        'Error',
        'Failed to accept request',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _rejectRequest() async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: Text('common.confirm_action'.tr),
        content: Text('driver.services.reject_catalog_request_confirm'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('common.cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('driver.services.reject'.tr, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      isLoading.value = true;
      // TODO: Add reject endpoint in backend
      // For now, just remove from list
      
      Get.snackbar(
        'Success',
        'Request rejected',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );

      Get.back();
    } catch (e) {
      print('[CatalogRequestDetail] Error rejecting: $e');
      Get.snackbar(
        'Error',
        'Failed to reject request',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
