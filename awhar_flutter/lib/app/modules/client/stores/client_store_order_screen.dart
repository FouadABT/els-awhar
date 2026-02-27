import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency_helper.dart';
import '../../../../core/controllers/auth_controller.dart';

/// Controller for order tracking
class ClientStoreOrderController extends GetxController {
  final int orderId;
  final _client = Get.find<Client>();
  final _authController = Get.find<AuthController>();

  ClientStoreOrderController({required this.orderId});

  final Rx<StoreOrder?> order = Rx<StoreOrder?>(null);
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  Timer? _refreshTimer;

  @override
  void onInit() {
    super.onInit();
    loadOrder();
    _startAutoRefresh();
  }

  @override
  void onClose() {
    _refreshTimer?.cancel();
    super.onClose();
  }

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      refreshOrder();
    });
  }

  Future<void> loadOrder() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      order.value = await _client.storeOrder.getOrder(orderId);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshOrder() async {
    try {
      order.value = await _client.storeOrder.getOrder(orderId);
    } catch (e) {
      // Silent refresh failure
    }
  }

  Future<void> cancelOrder() async {
    try {
      final userId = _authController.currentUser.value?.id;
      if (userId == null) return;

      final updatedOrder = await _client.storeOrder.cancelOrder(
        orderId: orderId,
        clientId: userId,
        reason: 'Client cancelled the order',
      );

      if (updatedOrder != null) {
        order.value = updatedOrder;
        await refreshOrder();
        Get.snackbar(
          'order.cancelled'.tr,
          'order.cancel_success'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'order.error'.tr,
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  bool get canCancel {
    final currentOrder = order.value;
    if (currentOrder == null) return false;
    return currentOrder.status == StoreOrderStatus.pending ||
        currentOrder.status == StoreOrderStatus.confirmed;
  }

  String getStatusLabel(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.pending:
        return 'order.status_pending'.tr;
      case StoreOrderStatus.confirmed:
        return 'order.status_confirmed'.tr;
      case StoreOrderStatus.preparing:
        return 'order.status_preparing'.tr;
      case StoreOrderStatus.ready:
        return 'order.status_ready'.tr;
      case StoreOrderStatus.driverAssigned:
        return 'order.status_driver_assigned'.tr;
      case StoreOrderStatus.pickedUp:
        return 'order.status_picked_up'.tr;
      case StoreOrderStatus.inDelivery:
        return 'order.status_in_delivery'.tr;
      case StoreOrderStatus.delivered:
        return 'order.status_delivered'.tr;
      case StoreOrderStatus.cancelled:
        return 'order.status_cancelled'.tr;
      case StoreOrderStatus.rejected:
        return 'order.status_rejected'.tr;
    }
  }

  Color getStatusColor(StoreOrderStatus status) {
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
      case StoreOrderStatus.inDelivery:
        return Colors.deepPurple;
      case StoreOrderStatus.delivered:
        return Colors.green;
      case StoreOrderStatus.cancelled:
      case StoreOrderStatus.rejected:
        return Colors.red;
    }
  }

  IconData getStatusIcon(StoreOrderStatus status) {
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
}

/// Order tracking screen for clients
class ClientStoreOrderScreen extends StatelessWidget {
  final int orderId;

  const ClientStoreOrderScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final controller = Get.put(ClientStoreOrderController(orderId: orderId));

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Obx(
          () => Text(
            controller.order.value?.orderNumber ?? 'order.title'.tr,
            style: AppTypography.headlineSmall(
              context,
            ).copyWith(color: colors.textPrimary),
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Iconsax.arrow_left, color: colors.textPrimary),
        ),
        actions: [
          // Chat button
          IconButton(
            onPressed: () {
              Get.toNamed(
                '/store-order-chat',
                arguments: {
                  'orderId': orderId,
                  'userRole': 'client',
                },
              );
            },
            icon: Icon(Iconsax.message, color: colors.primary),
            tooltip: 'Chat with store',
          ),
          IconButton(
            onPressed: () => controller.refreshOrder(),
            icon: Icon(Iconsax.refresh, color: colors.textPrimary),
          ),
        ],
      ),
      // Floating chat button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(
            '/store-order-chat',
            arguments: {
              'orderId': orderId,
              'userRole': 'client',
            },
          );
        },
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Iconsax.message),
        label: const Text('Chat'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: colors.primary),
          );
        }

        if (controller.errorMessage.isNotEmpty) {
          return _buildErrorState(context, colors, controller);
        }

        final order = controller.order.value;
        if (order == null) {
          return Center(
            child: Text(
              'order.not_found'.tr,
              style: AppTypography.bodyLarge(
                context,
              ).copyWith(color: colors.textSecondary),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshOrder,
          color: colors.primary,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusCard(context, colors, controller, order),
                SizedBox(height: 16.h),
                _buildTimeline(context, colors, controller, order),
                SizedBox(height: 16.h),
                _buildDeliveryInfo(context, colors, order),
                SizedBox(height: 16.h),
                _buildOrderItems(context, colors, order),
                SizedBox(height: 16.h),
                _buildOrderSummary(context, colors, order),
                if (controller.canCancel) ...[
                  SizedBox(height: 24.h),
                  _buildCancelButton(context, colors, controller),
                ],
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    dynamic colors,
    ClientStoreOrderController controller,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.warning_2, size: 64.sp, color: colors.error),
          SizedBox(height: 16.h),
          Text(
            'order.error'.tr,
            style: AppTypography.titleMedium(
              context,
            ).copyWith(color: colors.textPrimary),
          ),
          SizedBox(height: 8.h),
          Text(
            controller.errorMessage.value,
            style: AppTypography.bodySmall(
              context,
            ).copyWith(color: colors.textSecondary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: controller.loadOrder,
            icon: const Icon(Iconsax.refresh),
            label: Text('common.retry'.tr),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(
    BuildContext context,
    dynamic colors,
    ClientStoreOrderController controller,
    StoreOrder order,
  ) {
    final statusColor = controller.getStatusColor(order.status);
    final statusIcon = controller.getStatusIcon(order.status);
    final statusLabel = controller.getStatusLabel(order.status);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(statusIcon, size: 40.sp, color: statusColor),
          ),
          SizedBox(height: 12.h),
          Text(
            statusLabel,
            style: AppTypography.headlineSmall(context).copyWith(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            _getStatusDescription(order.status),
            style: AppTypography.bodyMedium(
              context,
            ).copyWith(color: colors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getStatusDescription(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.pending:
        return 'order.desc_pending'.tr;
      case StoreOrderStatus.confirmed:
        return 'order.desc_confirmed'.tr;
      case StoreOrderStatus.preparing:
        return 'order.desc_preparing'.tr;
      case StoreOrderStatus.ready:
        return 'order.desc_ready'.tr;
      case StoreOrderStatus.driverAssigned:
        return 'order.desc_driver_assigned'.tr;
      case StoreOrderStatus.pickedUp:
        return 'order.desc_picked_up'.tr;
      case StoreOrderStatus.inDelivery:
        return 'order.desc_in_delivery'.tr;
      case StoreOrderStatus.delivered:
        return 'order.desc_delivered'.tr;
      case StoreOrderStatus.cancelled:
        return 'order.desc_cancelled'.tr;
      case StoreOrderStatus.rejected:
        return 'order.desc_rejected'.tr;
    }
  }

  Widget _buildTimeline(
    BuildContext context,
    dynamic colors,
    ClientStoreOrderController controller,
    StoreOrder order,
  ) {
    final steps = [
      StoreOrderStatus.pending,
      StoreOrderStatus.confirmed,
      StoreOrderStatus.preparing,
      StoreOrderStatus.ready,
      StoreOrderStatus.driverAssigned,
      StoreOrderStatus.pickedUp,
      StoreOrderStatus.inDelivery,
      StoreOrderStatus.delivered,
    ];

    final currentIndex = steps.indexOf(order.status);
    final isCancelled = order.status == StoreOrderStatus.cancelled;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.timer_1, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                'order.timeline'.tr,
                style: AppTypography.titleSmall(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (isCancelled)
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Iconsax.close_circle, color: Colors.red),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'order.cancelled_message'.tr,
                      style: AppTypography.bodyMedium(
                        context,
                      ).copyWith(color: Colors.red),
                    ),
                  ),
                ],
              ),
            )
          else
            ...List.generate(steps.length, (index) {
              final step = steps[index];
              final isCompleted = index <= currentIndex;
              final isActive = index == currentIndex;
              final isLast = index == steps.length - 1;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted
                              ? controller.getStatusColor(step)
                              : colors.border,
                        ),
                        child: Icon(
                          isCompleted ? Iconsax.tick_circle : null,
                          size: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 2.w,
                          height: 30.h,
                          color: isCompleted
                              ? controller.getStatusColor(step)
                              : colors.border,
                        ),
                    ],
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.getStatusLabel(step),
                            style: AppTypography.bodyMedium(context).copyWith(
                              color: isActive
                                  ? colors.primary
                                  : (isCompleted
                                        ? colors.textPrimary
                                        : colors.textSecondary),
                              fontWeight: isActive
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          if (isActive)
                            Text(
                              _getStatusDescription(step),
                              style: AppTypography.labelSmall(
                                context,
                              ).copyWith(color: colors.textSecondary),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfo(
    BuildContext context,
    dynamic colors,
    StoreOrder order,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.location, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                'order.delivery_info'.tr,
                style: AppTypography.titleSmall(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            context,
            colors,
            'order.address'.tr,
            order.deliveryAddress,
          ),
          if (order.clientNotes != null && order.clientNotes!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            _buildInfoRow(
              context,
              colors,
              'order.notes'.tr,
              order.clientNotes!,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    dynamic colors,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.w,
          child: Text(
            label,
            style: AppTypography.labelSmall(
              context,
            ).copyWith(color: colors.textSecondary),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTypography.bodyMedium(
              context,
            ).copyWith(color: colors.textPrimary),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItems(
    BuildContext context,
    dynamic colors,
    StoreOrder order,
  ) {
    // Parse items from JSON
    List<Map<String, dynamic>> items = [];
    if (order.itemsJson != null) {
      try {
        items = List<Map<String, dynamic>>.from(
          (order.itemsJson as List).map((e) => Map<String, dynamic>.from(e)),
        );
      } catch (_) {}
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.shopping_bag, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                'order.items'.tr,
                style: AppTypography.titleSmall(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ...items.map((item) {
            final name = item['name'] ?? '';
            final quantity = item['quantity'] ?? 1;
            final price = (item['price'] ?? 0.0).toDouble();

            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      '${quantity}x',
                      style: AppTypography.labelSmall(
                        context,
                      ).copyWith(color: colors.primary),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      name,
                      style: AppTypography.bodyMedium(
                        context,
                      ).copyWith(color: colors.textPrimary),
                    ),
                  ),
                  Text(
                    CurrencyHelper.formatWithSymbol(price * quantity, order.currencySymbol),
                    style: AppTypography.bodyMedium(
                      context,
                    ).copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(
    BuildContext context,
    dynamic colors,
    StoreOrder order,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.receipt_1, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                'order.summary'.tr,
                style: AppTypography.titleSmall(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildSummaryRow(
            context,
            colors,
            'order.subtotal'.tr,
            CurrencyHelper.formatWithSymbol(order.subtotal ?? 0, order.currencySymbol),
          ),
          SizedBox(height: 8.h),
          _buildSummaryRow(
            context,
            colors,
            'order.delivery_fee'.tr,
            CurrencyHelper.formatWithSymbol(order.deliveryFee ?? 0, order.currencySymbol),
          ),
          Divider(height: 24.h, color: colors.border),
          _buildSummaryRow(
            context,
            colors,
            'order.total'.tr,
            CurrencyHelper.formatWithSymbol(order.total, order.currencySymbol),
            isBold: true,
          ),
          if (order.createdAt != null) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Iconsax.calendar,
                  size: 14.sp,
                  color: colors.textSecondary,
                ),
                SizedBox(width: 4.w),
                Text(
                  _formatDateTime(order.createdAt!),
                  style: AppTypography.labelSmall(
                    context,
                  ).copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    dynamic colors,
    String label,
    String value, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isBold
              ? AppTypography.titleSmall(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                )
              : AppTypography.bodyMedium(
                  context,
                ).copyWith(color: colors.textSecondary),
        ),
        Text(
          value,
          style: isBold
              ? AppTypography.titleSmall(
                  context,
                ).copyWith(color: colors.primary, fontWeight: FontWeight.bold)
              : AppTypography.bodyMedium(
                  context,
                ).copyWith(color: colors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildCancelButton(
    BuildContext context,
    dynamic colors,
    ClientStoreOrderController controller,
  ) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _showCancelConfirmation(context, colors, controller),
        icon: const Icon(Iconsax.close_circle),
        label: Text('order.cancel_order'.tr),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }

  void _showCancelConfirmation(
    BuildContext context,
    dynamic colors,
    ClientStoreOrderController controller,
  ) {
    Get.dialog(
      AlertDialog(
        title: Text('order.cancel_order'.tr),
        content: Text('order.cancel_confirmation'.tr),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('common.no'.tr)),
          TextButton(
            onPressed: () {
              Get.back();
              controller.cancelOrder();
            },
            child: Text(
              'common.yes'.tr,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
