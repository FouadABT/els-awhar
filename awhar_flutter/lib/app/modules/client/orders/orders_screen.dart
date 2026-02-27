import 'package:awhar_client/awhar_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/controllers/request_controller.dart';
import '../../../../core/controllers/auth_controller.dart';
import '../../../../core/controllers/wallet_controller.dart';
import '../../../../core/controllers/client_store_order_controller.dart';
import '../../../../core/utils/currency_helper.dart';

/// Client orders screen showing current and past orders
class ClientOrdersScreen extends StatefulWidget {
  const ClientOrdersScreen({super.key});

  @override
  State<ClientOrdersScreen> createState() => _ClientOrdersScreenState();
}

class _ClientOrdersScreenState extends State<ClientOrdersScreen> {
  @override
  void initState() {
    super.initState();
    // Load request history when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<RequestController>();
      controller.loadRequestHistory();
      controller.loadActiveRequest();
      // Also refresh store orders
      if (Get.isRegistered<ClientStoreOrdersController>()) {
        Get.find<ClientStoreOrdersController>().refresh();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final requestController = Get.find<RequestController>();

    // Get store orders controller
    final storeOrdersController = Get.find<ClientStoreOrdersController>();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: colors.background,
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Row(
                  children: [
                    Text(
                      'client.orders.title'.tr,
                      style: AppTypography.headlineLarge(
                        context,
                      ).copyWith(color: colors.textPrimary),
                    ),
                  ],
                ),
              ),

              // Tabs - Modern animated design with badges
              Obx(
                () => Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: colors.primary.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelColor: Colors.white,
                    unselectedLabelColor: colors.textSecondary,
                    labelStyle: AppTypography.bodyMedium(context).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: AppTypography.bodyMedium(context)
                        .copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    splashBorderRadius: BorderRadius.circular(12.r),
                    labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
                    tabs: [
                      Tab(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.task_square, size: 16.sp),
                              SizedBox(width: 4.w),
                              Text('Active'),
                              if (requestController
                                  .activeRequests
                                  .isNotEmpty) ...[
                                SizedBox(width: 4.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                    vertical: 1.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    '${requestController.activeRequests.length}',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.clock, size: 16.sp),
                              SizedBox(width: 4.w),
                              Text('History'),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.shop, size: 16.sp),
                              SizedBox(width: 4.w),
                              Text('Store'),
                              if (storeOrdersController
                                  .activeOrders
                                  .isNotEmpty) ...[
                                SizedBox(width: 4.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                    vertical: 1.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    '${storeOrdersController.activeOrders.length}',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 8.h),

              // Tab views
              Expanded(
                child: TabBarView(
                  children: [
                    _OrdersList(colors: colors, isActive: true),
                    _OrdersList(colors: colors, isActive: false),
                    _StoreOrdersList(colors: colors),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _createNewOrder(context, colors),
          icon: const Icon(Iconsax.add),
          label: Text('client.orders.new_order'.tr),
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  /// Navigate to map screen to select pickup and destination
  void _createNewOrder(BuildContext context, AppColorScheme colors) async {
    // Navigate to map screen
    final result = await Get.toNamed('/map');

    if (result != null && result is Map) {
      // Extract location data from map result
      final pickupAddress = result['pickupAddress'] as String?;
      final destinationAddress = result['destinationAddress'] as String?;
      final distance = result['distance'] as double?;

      // Show success dialog with order details
      Get.dialog(
        AlertDialog(
          backgroundColor: colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Row(
            children: [
              Icon(Iconsax.tick_circle, color: colors.success, size: 28.sp),
              SizedBox(width: 12.w),
              Text(
                'Order Created',
                style: AppTypography.headlineSmall(context).copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LocationRow(
                colors: colors,
                icon: Iconsax.location,
                location: pickupAddress ?? 'N/A',
                label: 'Pickup',
              ),
              SizedBox(height: 16.h),
              _LocationRow(
                colors: colors,
                icon: Iconsax.location_tick,
                location: destinationAddress ?? 'N/A',
                label: 'Destination',
              ),
              if (distance != null) ...[
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Iconsax.routing, color: colors.primary, size: 20.sp),
                      SizedBox(width: 8.w),
                      Text(
                        'Distance: ${distance.toStringAsFixed(2)} km',
                        style: AppTypography.bodyMedium(context).copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'OK',
                style: AppTypography.labelLarge(context).copyWith(
                  color: colors.primary,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class _OrdersList extends StatelessWidget {
  final AppColorScheme colors;
  final bool isActive;

  const _OrdersList({required this.colors, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final requestController = Get.find<RequestController>();
    final walletController = Get.find<WalletController>();

    return Obx(() {
      List<ServiceRequest> orders = [];

      if (isActive) {
        // Show ALL active requests (multiple orders support)
        orders = requestController.activeRequests.toList();
        // Sort by most recent first
        orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      } else {
        // Show completed/cancelled history
        orders = requestController.requestHistory
            .where(
              (r) =>
                  r.status == RequestStatus.completed ||
                  r.status == RequestStatus.cancelled,
            )
            .toList();
        // Sort by most recent first
        orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }

      if (requestController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(color: colors.primary),
        );
      }

      if (orders.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.box,
                size: 64.sp,
                color: colors.textSecondary.withOpacity(0.5),
              ),
              SizedBox(height: 16.h),
              Text(
                isActive
                    ? 'client.orders.no_active'.tr
                    : 'client.orders.no_history'.tr,
                style: AppTypography.bodyMedium(
                  context,
                ).copyWith(color: colors.textSecondary),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _OrderCard(
            colors: colors,
            request: order,
            isActive: isActive,
            walletController: walletController,
          );
        },
      );
    });
  }
}

class _OrderCard extends StatelessWidget {
  final AppColorScheme colors;
  final ServiceRequest request;
  final bool isActive;
  final WalletController walletController;

  const _OrderCard({
    required this.colors,
    required this.request,
    required this.isActive,
    required this.walletController,
  });

  String _getStatusText() {
    switch (request.status) {
      case RequestStatus.pending:
        return 'Searching for Driver';
      case RequestStatus.driver_proposed:
        return 'Driver Available';
      case RequestStatus.accepted:
        return 'Driver Assigned';
      case RequestStatus.driver_arriving:
        return 'Heading to Collection';
      case RequestStatus.in_progress:
        return 'Out for Delivery';
      case RequestStatus.completed:
        return 'Delivered';
      case RequestStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color _getStatusColor() {
    switch (request.status) {
      case RequestStatus.pending:
        return colors.warning;
      case RequestStatus.driver_proposed:
        return colors.info;
      case RequestStatus.accepted:
      case RequestStatus.driver_arriving:
        return colors.info;
      case RequestStatus.in_progress:
        return colors.primary;
      case RequestStatus.completed:
        return colors.success;
      case RequestStatus.cancelled:
        return colors.error;
    }
  }

  String _formatTimeAgo() {
    final now = DateTime.now();
    final diff = now.difference(request.createdAt);

    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }

  Widget _buildNegotiationBadge() {
    final controller = Get.find<RequestController>();
    final didNegotiate = controller.didNegotiate(request);

    if (request.agreedPrice == null) return const SizedBox.shrink();

    if (didNegotiate) {
      // Price was negotiated
      return Container(
        margin: EdgeInsets.only(top: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: colors.warning.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Iconsax.receipt_edit, size: 12.sp, color: colors.warning),
            SizedBox(width: 4.w),
            Text(
              'history.negotiated'.tr,
              style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(
                color: colors.warning,
                fontWeight: FontWeight.w600,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      );
    } else {
      // Driver accepted client's price
      return Container(
        margin: EdgeInsets.only(top: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: colors.success.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Iconsax.tick_circle, size: 12.sp, color: colors.success),
            SizedBox(width: 4.w),
            Text(
              'history.accepted'.tr,
              style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(
                color: colors.success,
                fontWeight: FontWeight.w600,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isInProgress = request.status == RequestStatus.in_progress;
    final statusText = _getStatusText();
    final statusColor = _getStatusColor();

    // Make active orders tappable
    final canNavigate = isActive && request.status != RequestStatus.cancelled;

    return GestureDetector(
      onTap: canNavigate
          ? () {
              Get.toNamed('/client/active-request', arguments: request);
            }
          : null,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isInProgress ? colors.primary : colors.border,
            width: isInProgress ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ORD-${request.id}',
                  style: AppTypography.bodySmall(
                    context,
                  ).copyWith(color: colors.textSecondary),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      CurrencyHelper.formatWithSymbol(request.agreedPrice ?? request.totalPrice, request.currencySymbol),
                      style: AppTypography.titleLarge(context)
                          .copyWith(color: colors.primary)
                          .copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    // Negotiation badge
                    if (!isActive) _buildNegotiationBadge(),
                  ],
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Driver info (if assigned)
            if (request.driverId != null) ...[
              Row(
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundColor: colors.primary.withOpacity(0.1),
                    child: Icon(
                      Iconsax.user,
                      color: colors.primary,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Driver Assigned',
                          style: AppTypography.bodyLarge(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Iconsax.star,
                              size: 14.sp,
                              color: colors.warning,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '4.8',
                              style: AppTypography.bodySmall(
                                context,
                              ).copyWith(color: colors.textSecondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isActive) ...[
                    IconButton(
                      onPressed: () {
                        // Navigate to active tracking with request data
                        Get.toNamed(
                          '/client/active-request',
                          arguments: request,
                        );
                      },
                      icon: Icon(
                        Iconsax.location,
                        color: colors.primary,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 16.h),
            ],

            // Locations
            _LocationRow(
              colors: colors,
              icon: Iconsax.location,
              location:
                  request.pickupLocation?.address ??
                  request.pickupLocation?.placeName ??
                  'Collection Point',
              label: 'common.pickup'.tr,
            ),
            SizedBox(height: 8.h),
            _LocationRow(
              colors: colors,
              icon: Iconsax.flag,
              location:
                  request.destinationLocation.address ??
                  request.destinationLocation.placeName ??
                  'Delivery Point',
              label: 'common.destination'.tr,
            ),

            SizedBox(height: 16.h),

            // Status and time
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    statusText,
                    style: AppTypography.bodySmall(context)
                        .copyWith(color: statusColor)
                        .copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const Spacer(),
                Text(
                  _formatTimeAgo(),
                  style: AppTypography.bodySmall(
                    context,
                  ).copyWith(color: colors.textSecondary),
                ),
              ],
            ),

            // Action buttons for active orders
            if (isActive && isInProgress) ...[
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to tracking screen with request data
                    Get.toNamed('/client/active-request', arguments: request);
                  },
                  icon: Icon(Iconsax.location, size: 18.sp),
                  label: Text('client.orders.track'.tr),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
            ],

            // Payment confirmation button for completed orders
            if (request.status == RequestStatus.completed &&
                !request.isPaid) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: colors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: colors.warning.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Iconsax.warning_2,
                          size: 20.sp,
                          color: colors.warning,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Payment Confirmation Needed',
                          style: AppTypography.bodyMedium(context).copyWith(
                            color: colors.warning,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Please confirm that you paid ${CurrencyHelper.formatWithSymbol(request.agreedPrice ?? request.totalPrice, request.currencySymbol)} in cash to the driver.',
                      style: AppTypography.bodySmall(context).copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _confirmPayment(request, colors),
                        icon: Icon(Iconsax.tick_circle, size: 18.sp),
                        label: Text('Confirm Cash Payment'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.success,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _confirmPayment(
    ServiceRequest request,
    AppColorScheme colors,
  ) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(Iconsax.money_send, color: colors.success, size: 28.sp),
            SizedBox(width: 12.w),
            Text(
              'Confirm Payment',
              style: AppTypography.headlineSmall(Get.context!).copyWith(
                color: colors.textPrimary,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Did you pay the following amount in cash to the driver?',
              style: AppTypography.bodyMedium(Get.context!).copyWith(
                color: colors.textSecondary,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: colors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: colors.success.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    CurrencyHelper.formatWithSymbol(request.agreedPrice ?? request.totalPrice, request.currencySymbol),
                    style: AppTypography.headlineMedium(Get.context!).copyWith(
                      color: colors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Order: ORD-${request.id}',
              style: AppTypography.bodySmall(Get.context!).copyWith(
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(
              'Not Yet',
              style: AppTypography.labelLarge(Get.context!).copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.success,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            child: Text('Yes, I Paid'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final clientId = Get.find<AuthController>().currentUser.value?.id;
    if (clientId == null) return;

    final success = await walletController.confirmCashPaymentByClient(
      requestId: request.id!,
      clientId: clientId,
      notes: 'Cash payment confirmed by client for order ORD-${request.id}',
    );

    if (success) {
      Get.snackbar(
        'Success',
        'Payment confirmed! Transaction completed.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: colors.success,
        colorText: Colors.white,
        icon: Icon(Iconsax.tick_circle, color: Colors.white),
        duration: const Duration(seconds: 3),
      );

      // Reload orders
      Get.find<RequestController>().loadActiveRequest();
      Get.find<RequestController>().loadRequestHistory();
    }
  }
}

class _LocationRow extends StatelessWidget {
  final AppColorScheme colors;
  final IconData icon;
  final String location;
  final String label;

  const _LocationRow({
    required this.colors,
    required this.icon,
    required this.location,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: colors.primary),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.bodySmall(
                  context,
                ).copyWith(color: colors.textSecondary),
              ),
              Text(
                location,
                style: AppTypography.bodySmall(
                  context,
                ).copyWith(color: colors.textPrimary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Store Orders List widget
class _StoreOrdersList extends StatelessWidget {
  final AppColorScheme colors;

  const _StoreOrdersList({required this.colors});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClientStoreOrdersController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(color: colors.primary),
        );
      }

      final allOrders = controller.orders;

      if (allOrders.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.shop,
                size: 64.sp,
                color: colors.textSecondary.withOpacity(0.5),
              ),
              SizedBox(height: 16.h),
              Text(
                'No store orders',
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Browse stores to place an order',
                style: AppTypography.bodySmall(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: () => Get.toNamed('/client/stores'),
                icon: Icon(Iconsax.shop, size: 18.sp),
                label: const Text('Browse Stores'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async => controller.refresh(),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          itemCount: allOrders.length,
          itemBuilder: (context, index) {
            final order = allOrders[index];
            return _StoreOrderCard(colors: colors, order: order);
          },
        ),
      );
    });
  }
}

/// Store Order Card widget
class _StoreOrderCard extends StatelessWidget {
  final AppColorScheme colors;
  final StoreOrder order;

  const _StoreOrderCard({
    required this.colors,
    required this.order,
  });

  String _getStatusText(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.pending:
        return 'Pending';
      case StoreOrderStatus.confirmed:
        return 'Confirmed';
      case StoreOrderStatus.preparing:
        return 'Preparing';
      case StoreOrderStatus.ready:
        return 'Ready';
      case StoreOrderStatus.driverAssigned:
        return 'Driver Assigned';
      case StoreOrderStatus.pickedUp:
        return 'Picked Up';
      case StoreOrderStatus.inDelivery:
        return 'In Delivery';
      case StoreOrderStatus.delivered:
        return 'Delivered';
      case StoreOrderStatus.cancelled:
        return 'Cancelled';
      case StoreOrderStatus.rejected:
        return 'Rejected';
    }
  }

  Color _getStatusColor(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.pending:
        return Colors.orange;
      case StoreOrderStatus.confirmed:
        return Colors.blue;
      case StoreOrderStatus.preparing:
        return Colors.purple;
      case StoreOrderStatus.ready:
        return Colors.teal;
      case StoreOrderStatus.driverAssigned:
        return Colors.indigo;
      case StoreOrderStatus.pickedUp:
        return Colors.cyan;
      case StoreOrderStatus.inDelivery:
        return Colors.green;
      case StoreOrderStatus.delivered:
        return Colors.green;
      case StoreOrderStatus.cancelled:
        return Colors.red;
      case StoreOrderStatus.rejected:
        return Colors.red;
    }
  }

  IconData _getStatusIcon(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.pending:
        return Iconsax.clock;
      case StoreOrderStatus.confirmed:
        return Iconsax.tick_circle;
      case StoreOrderStatus.preparing:
        return Iconsax.timer_start;
      case StoreOrderStatus.ready:
        return Iconsax.box;
      case StoreOrderStatus.driverAssigned:
        return Iconsax.user;
      case StoreOrderStatus.pickedUp:
        return Iconsax.bag_tick;
      case StoreOrderStatus.inDelivery:
        return Iconsax.truck_fast;
      case StoreOrderStatus.delivered:
        return Iconsax.tick_square;
      case StoreOrderStatus.cancelled:
      case StoreOrderStatus.rejected:
        return Iconsax.close_circle;
    }
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    final isActive =
        order.status != StoreOrderStatus.delivered &&
        order.status != StoreOrderStatus.cancelled &&
        order.status != StoreOrderStatus.rejected;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: isActive
            ? Border.all(color: colors.primary.withOpacity(0.3), width: 1.5)
            : Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.toNamed('/client/store-order', arguments: order.id);
          },
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with order number and status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: colors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Iconsax.shop,
                            color: colors.primary,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderNumber,
                              style: AppTypography.bodyLarge(context).copyWith(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              _formatDate(order.createdAt),
                              style: AppTypography.bodySmall(context).copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(order.status).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getStatusIcon(order.status),
                            size: 14.sp,
                            color: _getStatusColor(order.status),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            _getStatusText(order.status),
                            style: AppTypography.bodySmall(context).copyWith(
                              color: _getStatusColor(order.status),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // Delivery address
                if (order.deliveryAddress.isNotEmpty) ...[
                  Row(
                    children: [
                      Icon(
                        Iconsax.location,
                        size: 16.sp,
                        color: colors.textSecondary,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          order.deliveryAddress,
                          style: AppTypography.bodySmall(context).copyWith(
                            color: colors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                ],
                // Total and action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      CurrencyHelper.formatWithSymbol(order.total, order.currencySymbol),
                      style: AppTypography.titleMedium(context).copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'View Details',
                          style: AppTypography.bodySmall(context).copyWith(
                            color: colors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Iconsax.arrow_right_3,
                          size: 16.sp,
                          color: colors.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
