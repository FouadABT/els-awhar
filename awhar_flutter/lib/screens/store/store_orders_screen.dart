import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/currency_helper.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/store_order_controller.dart';
import '../../core/controllers/store_controller.dart';
import 'store_order_detail_screen.dart';

/// Store Orders Screen
/// Shows all incoming orders for the store with tabs for filtering
class StoreOrdersScreen extends StatefulWidget {
  const StoreOrdersScreen({super.key});

  @override
  State<StoreOrdersScreen> createState() => _StoreOrdersScreenState();
}

class _StoreOrdersScreenState extends State<StoreOrdersScreen>
    with SingleTickerProviderStateMixin {
  late final StoreOrderController _controller;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Ensure StoreController is registered first (StoreOrderController depends on it)
    if (!Get.isRegistered<StoreController>()) {
      Get.put(StoreController());
    }
    // Initialize controllers
    if (!Get.isRegistered<StoreOrderController>()) {
      _controller = Get.put(StoreOrderController());
    } else {
      _controller = Get.find<StoreOrderController>();
    }
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      _controller.currentTab.value = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Text(
          'store_orders.title'.tr,
          style: AppTypography.titleMedium(context).copyWith(
            color: colors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Iconsax.refresh, color: colors.primary),
            onPressed: () => _controller.refresh(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: colors.primary,
          unselectedLabelColor: colors.textSecondary,
          indicatorColor: colors.primary,
          tabs: [
            Obx(
              () => Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Pending'),
                    if (_controller.pendingCount > 0) ...[
                      SizedBox(width: 4.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          '${_controller.pendingCount}',
                          style: TextStyle(
                            color: Colors.white,
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
            Obx(
              () => Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Active'),
                    if (_controller.activeCount > 0) ...[
                      SizedBox(width: 4.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: colors.primary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          '${_controller.activeCount}',
                          style: TextStyle(
                            color: Colors.white,
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
            const Tab(text: 'History'),
          ],
        ),
      ),
      body: Obx(() {
        if (_controller.isLoading.value && _controller.orders.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return TabBarView(
          controller: _tabController,
          children: [
            _buildOrdersList(
              _controller.orders
                  .where((o) => o.status == StoreOrderStatus.pending)
                  .toList(),
              'No pending orders',
              colors,
            ),
            _buildOrdersList(
              _controller.activeOrders
                  .where((o) => o.status != StoreOrderStatus.pending)
                  .toList(),
              'No active orders',
              colors,
            ),
            _buildOrdersList(
              _controller.completedOrders.toList(),
              'No order history',
              colors,
            ),
          ],
        );
      }),
    );
  }

  Widget _buildOrdersList(
    List<StoreOrder> orders,
    String emptyMessage,
    dynamic colors,
  ) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.receipt_item,
              size: 64.sp,
              color: colors.textSecondary.withOpacity(0.5),
            ),
            SizedBox(height: 16.h),
            Text(
              emptyMessage,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _controller.refresh,
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _OrderCard(
            order: order,
            controller: _controller,
            colors: colors,
            onTap: () => Get.to(
              () => StoreOrderDetailScreen(
                orderId: order.id ?? 0,
                orderNumber: order.orderNumber,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final StoreOrder order;
  final StoreOrderController controller;
  final dynamic colors;
  final VoidCallback onTap;

  const _OrderCard({
    required this.order,
    required this.controller,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = controller.parseOrderItems(order);
    final timeAgo = _formatTimeAgo(order.createdAt);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Iconsax.receipt_2, size: 20.sp, color: colors.primary),
                    SizedBox(width: 8.w),
                    Text(
                      order.orderNumber,
                      style: AppTypography.labelLarge(context).copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: controller
                        .getStatusColor(order.status)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    controller.getStatusText(order.status),
                    style: TextStyle(
                      color: controller.getStatusColor(order.status),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Items summary
            Text(
              '${items.length} items • ${CurrencyHelper.formatWithSymbol(order.total, order.currencySymbol)}',
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
              ),
            ),
            SizedBox(height: 8.h),

            // Time
            Row(
              children: [
                Icon(Iconsax.clock, size: 14.sp, color: colors.textSecondary),
                SizedBox(width: 4.w),
                Text(
                  timeAgo,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),

            // Quick actions for pending orders
            if (order.status == StoreOrderStatus.pending) ...[
              SizedBox(height: 12.h),
              const Divider(),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showRejectDialog(context),
                      icon: const Icon(Iconsax.close_circle, size: 18),
                      label: const Text('Reject'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _confirmOrder(context),
                      icon: const Icon(Iconsax.tick_circle, size: 18),
                      label: const Text('Accept'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('MMM d').format(dateTime);
  }

  void _confirmOrder(BuildContext context) async {
    final confirmed = await controller.confirmOrder(order.id!);
    if (confirmed) {
      Get.snackbar(
        'Success',
        'Order confirmed',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
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
                labelText: 'Reason (optional)',
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
              final rejected = await controller.rejectOrder(
                order.id!,
                reasonController.text.isEmpty
                    ? 'Store unavailable'
                    : reasonController.text,
              );
              if (rejected) {
                Get.snackbar(
                  'Order Rejected',
                  'The order has been rejected',
                  backgroundColor: Colors.orange,
                  colorText: Colors.white,
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reject', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
