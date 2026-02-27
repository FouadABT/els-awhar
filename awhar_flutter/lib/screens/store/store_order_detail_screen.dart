import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/store_order_controller.dart';
import '../../core/utils/currency_helper.dart';
import 'find_driver_screen.dart';
import '../shared/store_order_chat_screen.dart';

/// Store Order Detail Screen
/// Shows order details and allows store to manage order status
class StoreOrderDetailScreen extends StatefulWidget {
  final int orderId;
  final String? orderNumber;

  const StoreOrderDetailScreen({
    super.key,
    required this.orderId,
    this.orderNumber,
  });

  @override
  State<StoreOrderDetailScreen> createState() => _StoreOrderDetailScreenState();
}

class _StoreOrderDetailScreenState extends State<StoreOrderDetailScreen> {
  late final StoreOrderController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<StoreOrderController>();
    // Delay loading until after build phase completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitial();
    });
  }

  Future<void> _loadInitial() async {
    await _controller.loadOrderDetails(widget.orderId);
    if (_controller.selectedOrder.value == null && widget.orderNumber != null) {
      await _controller.loadOrderDetailsByNumber(widget.orderNumber!);
    }
  }

  void _openChat() {
    Get.to(() => StoreOrderChatScreen(
      orderId: widget.orderId,
      userRole: 'store',
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Obx(() => Text(
          _controller.selectedOrder.value?.orderNumber ?? 'Order',
          style: AppTypography.titleMedium(context).copyWith(
            color: colors.textPrimary,
          ),
        )),
        actions: [
          IconButton(
            icon: Icon(Iconsax.message, color: colors.primary),
            onPressed: () => _openChat(),
          ),
          IconButton(
            icon: Icon(Iconsax.refresh, color: colors.primary),
            onPressed: () => _loadInitial(),
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.isLoading.value && _controller.selectedOrder.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final order = _controller.selectedOrder.value;
        if (order == null) {
          return Center(
            child: Text(
              'Order not found',
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
              ),
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status card
              _StatusCard(order: order, controller: _controller, colors: colors),
              SizedBox(height: 16.h),

              // Order items
              _OrderItemsCard(order: order, controller: _controller, colors: colors),
              SizedBox(height: 16.h),

              // Delivery info
              _DeliveryInfoCard(order: order, colors: colors),
              SizedBox(height: 16.h),

              // Pricing
              _PricingCard(order: order, colors: colors),
              SizedBox(height: 16.h),

              // Driver section (if ready for pickup)
              if (order.status == StoreOrderStatus.ready ||
                  order.status == StoreOrderStatus.driverAssigned ||
                  order.status == StoreOrderStatus.pickedUp ||
                  order.status == StoreOrderStatus.inDelivery)
                _DriverSection(order: order, controller: _controller, colors: colors),
              SizedBox(height: 16.h),

              // Action buttons
              _ActionButtons(order: order, controller: _controller, colors: colors),
              SizedBox(height: 32.h),
            ],
          ),
        );
      }),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final StoreOrder order;
  final StoreOrderController controller;
  final dynamic colors;

  const _StatusCard({
    required this.order,
    required this.controller,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: controller.getStatusColor(order.status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: controller.getStatusColor(order.status).withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: controller.getStatusColor(order.status),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getStatusIcon(order.status),
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.getStatusText(order.status),
                  style: AppTypography.titleMedium(context).copyWith(
                    color: controller.getStatusColor(order.status),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _getStatusDescription(order.status),
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.pending:
        return Iconsax.clock;
      case StoreOrderStatus.confirmed:
        return Iconsax.tick_circle;
      case StoreOrderStatus.preparing:
        return Iconsax.timer;
      case StoreOrderStatus.ready:
        return Iconsax.box;
      case StoreOrderStatus.driverAssigned:
        return Iconsax.user;
      case StoreOrderStatus.pickedUp:
        return Iconsax.truck;
      case StoreOrderStatus.inDelivery:
        return Iconsax.location;
      case StoreOrderStatus.delivered:
        return Iconsax.tick_square;
      case StoreOrderStatus.cancelled:
        return Iconsax.close_circle;
      case StoreOrderStatus.rejected:
        return Iconsax.close_square;
    }
  }

  String _getStatusDescription(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.pending:
        return 'Waiting for your confirmation';
      case StoreOrderStatus.confirmed:
        return 'Start preparing the order';
      case StoreOrderStatus.preparing:
        return 'Order is being prepared';
      case StoreOrderStatus.ready:
        return 'Ready for pickup - find a driver';
      case StoreOrderStatus.driverAssigned:
        return 'Driver is on the way to pick up';
      case StoreOrderStatus.pickedUp:
        return 'Driver picked up the order';
      case StoreOrderStatus.inDelivery:
        return 'Order is being delivered';
      case StoreOrderStatus.delivered:
        return 'Order completed successfully';
      case StoreOrderStatus.cancelled:
        return 'Order was cancelled';
      case StoreOrderStatus.rejected:
        return 'Order was rejected';
    }
  }
}

class _OrderItemsCard extends StatelessWidget {
  final StoreOrder order;
  final StoreOrderController controller;
  final dynamic colors;

  const _OrderItemsCard({
    required this.order,
    required this.controller,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final items = controller.parseOrderItems(order);

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
              Icon(Iconsax.shopping_bag, size: 20.sp, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                'Order Items',
                style: AppTypography.labelLarge(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          const Divider(),
          SizedBox(height: 8.h),
          ...items.map((item) => Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              children: [
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: colors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Center(
                    child: Text(
                      '${item['quantity']}x',
                      style: TextStyle(
                        color: colors.primary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    item['name'] ?? '',
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                ),
                Text(
                  CurrencyHelper.format((item['price'] * item['quantity']).toDouble()),
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          )),
          if (order.clientNotes != null && order.clientNotes!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            const Divider(),
            SizedBox(height: 8.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Iconsax.note, size: 16.sp, color: colors.textSecondary),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    order.clientNotes!,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 12.sp,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _DeliveryInfoCard extends StatelessWidget {
  final StoreOrder order;
  final dynamic colors;

  const _DeliveryInfoCard({
    required this.order,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
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
              Icon(Iconsax.location, size: 20.sp, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                'Delivery Address',
                style: AppTypography.labelLarge(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
              order.deliveryAddress,
            style: AppTypography.bodyMedium(context).copyWith(
              color: colors.textSecondary,
            ),
          ),
          if (order.deliveryDistance != null) ...[
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(Iconsax.routing_2, size: 14.sp, color: colors.textSecondary),
                SizedBox(width: 4.w),
                Text(
                  '${order.deliveryDistance!.toStringAsFixed(1)} km from store',
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Iconsax.clock, size: 14.sp, color: colors.textSecondary),
              SizedBox(width: 4.w),
              Text(
                'Ordered: ${DateFormat('MMM d, h:mm a').format(order.createdAt)}',
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PricingCard extends StatelessWidget {
  final StoreOrder order;
  final dynamic colors;

  const _PricingCard({
    required this.order,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
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
              Icon(Iconsax.money, size: 20.sp, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                'Payment',
                style: AppTypography.labelLarge(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _priceRow('Subtotal', order.subtotal, colors),
          SizedBox(height: 4.h),
          _priceRow('Delivery Fee', order.deliveryFee, colors),
          const Divider(),
          _priceRow('Total', order.total, colors, isBold: true),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Iconsax.money_send, size: 16.sp, color: Colors.orange),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Cash on delivery - You receive ${CurrencyHelper.format(order.subtotal)}',
                      style: TextStyle(
                        color: Colors.orange.shade700,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _priceRow(String label, double value, dynamic colors, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: colors.textSecondary,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          CurrencyHelper.format(value),
          style: TextStyle(
            color: isBold ? colors.textPrimary : colors.textSecondary,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _DriverSection extends StatelessWidget {
  final StoreOrder order;
  final StoreOrderController controller;
  final dynamic colors;

  const _DriverSection({
    required this.order,
    required this.controller,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
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
              Icon(Iconsax.car, size: 20.sp, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                'Driver',
                style: AppTypography.labelLarge(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          
          if (order.driverId == null) ...[
            // No driver assigned yet
            Obx(() {
              final request = controller.currentDeliveryRequest.value;
              if (request != null && request.status == 'pending') {
                return Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.orange),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Waiting for driver',
                              style: TextStyle(
                                color: Colors.orange.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              request.requestType == 'direct' 
                                  ? 'Direct request sent to driver'
                                  : 'Public request posted to nearby drivers',
                              style: TextStyle(
                                color: Colors.orange.shade600,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ElevatedButton.icon(
                onPressed: () => Get.to(() => FindDriverScreen(orderId: order.id!)),
                icon: const Icon(Iconsax.search_normal),
                label: const Text('Find Driver'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48.h),
                ),
              );
            }),
          ] else ...[
            // Driver assigned
            Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: colors.primary.withOpacity(0.1),
                  child: Icon(Iconsax.user, color: colors.primary),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Driver #${order.driverId}',
                        style: AppTypography.labelLarge(context).copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                      Text(
                        _getDriverStatus(order.status),
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Iconsax.message, color: colors.primary),
                  onPressed: () {
                    // Open 3-way chat
                  },
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _getDriverStatus(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.driverAssigned:
        return 'On the way to store';
      case StoreOrderStatus.pickedUp:
        return 'Picked up - delivering';
      case StoreOrderStatus.inDelivery:
        return 'Arriving at customer';
      case StoreOrderStatus.delivered:
        return 'Delivered';
      default:
        return 'Assigned';
    }
  }
}

class _ActionButtons extends StatelessWidget {
  final StoreOrder order;
  final StoreOrderController controller;
  final dynamic colors;

  const _ActionButtons({
    required this.order,
    required this.controller,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isProcessing.value) {
        return const Center(child: CircularProgressIndicator());
      }

      switch (order.status) {
        case StoreOrderStatus.pending:
          return Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showRejectDialog(context),
                  icon: const Icon(Iconsax.close_circle),
                  label: const Text('Reject'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    minimumSize: Size(0, 48.h),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => controller.confirmOrder(order.id!),
                  icon: const Icon(Iconsax.tick_circle),
                  label: const Text('Accept'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize: Size(0, 48.h),
                  ),
                ),
              ),
            ],
          );

        case StoreOrderStatus.confirmed:
          return ElevatedButton.icon(
            onPressed: () => controller.markPreparing(order.id!),
            icon: const Icon(Iconsax.timer),
            label: const Text('Start Preparing'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 48.h),
            ),
          );

        case StoreOrderStatus.preparing:
          return ElevatedButton.icon(
            onPressed: () => controller.markReady(order.id!),
            icon: const Icon(Iconsax.box_tick),
            label: const Text('Mark Ready for Pickup'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 48.h),
            ),
          );

        default:
          return const SizedBox.shrink();
      }
    });
  }

  void _showRejectDialog(BuildContext context) {
    final reasonController = TextEditingController();
    
    Get.dialog(
      AlertDialog(
        title: const Text('Reject Order'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Are you sure you want to reject this order?'),
            SizedBox(height: 16.h),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              await controller.rejectOrder(
                order.id!,
                reasonController.text.isEmpty ? 'Store unavailable' : reasonController.text,
              );
              Get.back(); // Return to orders list
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reject', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
