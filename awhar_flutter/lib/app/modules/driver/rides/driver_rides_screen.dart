import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency_helper.dart';
import '../../../../core/controllers/request_controller.dart';
import '../../../../core/controllers/driver_store_delivery_controller.dart';
import '../../../../screens/driver/driver_store_delivery_screen.dart';

/// Driver rides screen showing history and upcoming rides for both
/// direct client orders and store deliveries
class DriverRidesScreen extends StatefulWidget {
  const DriverRidesScreen({super.key});

  @override
  State<DriverRidesScreen> createState() => _DriverRidesScreenState();
}

class _DriverRidesScreenState extends State<DriverRidesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Ensure store delivery controller is registered BEFORE first build
    if (!Get.isRegistered<DriverStoreDeliveryController>()) {
      Get.put(DriverStoreDeliveryController());
    }

    // Load data when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final requestController = Get.find<RequestController>();
      requestController.loadActiveRequest();
      requestController.loadRequestHistory();

      final storeController = Get.find<DriverStoreDeliveryController>();
      storeController.loadActiveDeliveries();
      storeController.loadCompletedDeliveries();
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
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Icon(Iconsax.box_1, color: colors.primary, size: 28.sp),
                  SizedBox(width: 12.w),
                  Text(
                    'My Orders',
                    style: AppTypography.headlineLarge(
                      context,
                    ).copyWith(color: colors.textPrimary),
                  ),
                  const Spacer(),
                  // Refresh button
                  IconButton(
                    onPressed: _refreshAll,
                    icon: Icon(Iconsax.refresh, color: colors.primary),
                    tooltip: 'Refresh',
                  ),
                ],
              ),
            ),

            // Tabs
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: colors.textSecondary.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(10.r),
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
                    fontSize: 13.sp,
                  ),
                  unselectedLabelStyle: AppTypography.bodyMedium(context)
                      .copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                  tabs: [
                    Tab(
                      height: 40.h,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.activity, size: 14.sp),
                          SizedBox(width: 4.w),
                          Text('Active'),
                        ],
                      ),
                    ),
                    Tab(
                      height: 40.h,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.archive_tick, size: 14.sp),
                          SizedBox(width: 4.w),
                          Text('History'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tab views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _CombinedOrdersList(colors: colors, type: 'active'),
                  _CombinedOrdersList(colors: colors, type: 'history'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _refreshAll() {
    final requestController = Get.find<RequestController>();
    requestController.loadActiveRequest();
    requestController.loadRequestHistory();

    // Always load store deliveries since controller is registered in initState
    final storeController = Get.find<DriverStoreDeliveryController>();
    storeController.loadActiveDeliveries();
    storeController.loadCompletedDeliveries();

    Get.snackbar(
      'Refreshing',
      'Loading latest orders...',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }
}

/// Combined orders list showing both direct orders and store deliveries
class _CombinedOrdersList extends StatelessWidget {
  final AppColorScheme colors;
  final String type;

  const _CombinedOrdersList({required this.colors, required this.type});

  @override
  Widget build(BuildContext context) {
    final requestController = Get.find<RequestController>();
    
    // Ensure controller is registered
    if (!Get.isRegistered<DriverStoreDeliveryController>()) {
      Get.put(DriverStoreDeliveryController());
    }
    final storeController = Get.find<DriverStoreDeliveryController>();

    return Obx(() {
      // Direct client orders
      List<ServiceRequest> directOrders = [];
      if (type == 'active') {
        directOrders = requestController.activeRequests.toList();
      } else if (type == 'history') {
        directOrders = requestController.requestHistory
            .where(
              (r) =>
                  r.status == RequestStatus.completed ||
                  r.status == RequestStatus.cancelled,
            )
            .toList();
      }

      // Store orders
      List<StoreOrder> storeOrders = [];
      if (type == 'active') {
        storeOrders = storeController.activeDeliveries.toList();
      } else if (type == 'history') {
        storeOrders = storeController.completedDeliveries.toList();
      }

      final isLoading = requestController.isLoading.value;
      final totalOrders = directOrders.length + storeOrders.length;

      if (isLoading && totalOrders == 0) {
        return Center(
          child: CircularProgressIndicator(color: colors.primary),
        );
      }

      if (totalOrders == 0) {
        return _buildEmptyState(context);
      }

      return RefreshIndicator(
        onRefresh: () async {
          requestController.loadActiveRequest();
          requestController.loadRequestHistory();
          await storeController.refresh();
        },
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          children: [
            // Store Orders Section (if any)
            if (storeOrders.isNotEmpty) ...[
              _buildSectionHeader(
                context,
                icon: Iconsax.shop,
                title: 'Store Deliveries',
                count: storeOrders.length,
                color: Colors.purple,
              ),
              SizedBox(height: 8.h),
              ...storeOrders.map(
                (order) => _StoreOrderCard(
                  colors: colors,
                  order: order,
                  isActive: type == 'active',
                  isHistory: type == 'history',
                ),
              ),
              SizedBox(height: 16.h),
            ],

            // Direct Orders Section (if any)
            if (directOrders.isNotEmpty) ...[
              _buildSectionHeader(
                context,
                icon: Iconsax.user,
                title: 'Direct Orders',
                count: directOrders.length,
                color: colors.primary,
              ),
              SizedBox(height: 8.h),
              ...directOrders.map(
                (request) => _DirectOrderCard(
                  colors: colors,
                  request: request,
                  isActive: type == 'active',
                  isHistory: type == 'history',
                ),
              ),
            ],

            SizedBox(height: 24.h),
          ],
        ),
      );
    });
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required IconData icon,
    required String title,
    required int count,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: color),
          SizedBox(width: 8.w),
          Text(
            title,
            style: AppTypography.labelLarge(context).copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            type == 'active' ? Iconsax.box_search : Iconsax.archive,
            size: 64.sp,
            color: colors.textSecondary.withValues(alpha: 0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            type == 'active' ? 'No Active Orders' : 'No Order History',
            style: AppTypography.titleMedium(context).copyWith(
              color: colors.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            type == 'active'
                ? 'Accept orders to see them here'
                : 'Your completed orders will appear here',
            style: AppTypography.bodySmall(context).copyWith(
              color: colors.textSecondary.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          if (type == 'active') ...[
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () => Get.toNamed('/driver/available-requests'),
              icon: const Icon(Iconsax.search_normal, color: Colors.white),
              label: Text(
                'Find Requests',
                style: AppTypography.bodyMedium(
                  context,
                ).copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Store Order Card Widget
class _StoreOrderCard extends StatelessWidget {
  final AppColorScheme colors;
  final StoreOrder order;
  final bool isActive;
  final bool isHistory;

  const _StoreOrderCard({
    required this.colors,
    required this.order,
    required this.isActive,
    required this.isHistory,
  });

  Color _getStatusColor() {
    switch (order.status) {
      case StoreOrderStatus.delivered:
        return Colors.green;
      case StoreOrderStatus.pickedUp:
      case StoreOrderStatus.inDelivery:
        return Colors.orange;
      case StoreOrderStatus.driverAssigned:
      case StoreOrderStatus.ready:
        return Colors.blue;
      case StoreOrderStatus.cancelled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText() {
    switch (order.status) {
      case StoreOrderStatus.pending:
        return 'Pending';
      case StoreOrderStatus.confirmed:
        return 'Confirmed';
      case StoreOrderStatus.preparing:
        return 'Preparing';
      case StoreOrderStatus.ready:
        return 'Ready';
      case StoreOrderStatus.driverAssigned:
        return 'Go to Store';
      case StoreOrderStatus.pickedUp:
        return 'Picked Up';
      case StoreOrderStatus.inDelivery:
        return 'At Customer';
      case StoreOrderStatus.delivered:
        return 'Delivered';
      case StoreOrderStatus.cancelled:
        return 'Cancelled';
      case StoreOrderStatus.rejected:
        return 'Rejected';
    }
  }

  IconData _getStatusIcon() {
    switch (order.status) {
      case StoreOrderStatus.driverAssigned:
      case StoreOrderStatus.ready:
        return Iconsax.shop;
      case StoreOrderStatus.pickedUp:
        return Iconsax.truck_fast;
      case StoreOrderStatus.inDelivery:
        return Iconsax.location;
      case StoreOrderStatus.delivered:
        return Iconsax.tick_circle;
      case StoreOrderStatus.cancelled:
        return Iconsax.close_circle;
      default:
        return Iconsax.box;
    }
  }

  String _formatTimeAgo() {
    final now = DateTime.now();
    final diff = now.difference(order.createdAt);

    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();
    final statusText = _getStatusText();
    final statusIcon = _getStatusIcon();

    return GestureDetector(
      onTap: () {
        Get.to(() => DriverStoreDeliveryScreen(order: order));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: isActive
              ? Border.all(color: statusColor, width: 2)
              : Border.all(color: colors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header with status gradient
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    statusColor.withValues(alpha: 0.15),
                    statusColor.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(statusIcon, size: 20.sp, color: statusColor),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Iconsax.shop,
                              size: 14.sp,
                              color: Colors.purple,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Store Delivery',
                              style: TextStyle(
                                color: Colors.purple,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Order #${order.orderNumber}',
                          style: AppTypography.bodyMedium(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        CurrencyHelper.formatWithSymbol(order.driverEarnings, order.currencySymbol),
                        style: AppTypography.titleMedium(context).copyWith(
                          color: isHistory ? Colors.green : statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Delivery details
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                children: [
                  // Pickup location
                  Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Iconsax.shop,
                          size: 16.sp,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pickup',
                              style: TextStyle(
                                color: colors.textSecondary,
                                fontSize: 10.sp,
                              ),
                            ),
                            Text(
                              order.deliveryAddress.split(',').first,
                              style: AppTypography.bodySmall(context).copyWith(
                                color: colors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Connector line
                  Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Row(
                      children: [
                        Container(
                          width: 2,
                          height: 16.h,
                          color: colors.border,
                        ),
                      ],
                    ),
                  ),

                  // Delivery location
                  Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Iconsax.location,
                          size: 16.sp,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delivery',
                              style: TextStyle(
                                color: colors.textSecondary,
                                fontSize: 10.sp,
                              ),
                            ),
                            Text(
                              order.deliveryAddress,
                              style: AppTypography.bodySmall(context).copyWith(
                                color: colors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Footer with distance and time
                  Row(
                    children: [
                      if (order.deliveryDistance != null) ...[
                        Icon(
                          Iconsax.routing_2,
                          size: 14.sp,
                          color: colors.textSecondary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${order.deliveryDistance!.toStringAsFixed(1)} km',
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(width: 16.w),
                      ],
                      Icon(
                        Iconsax.clock,
                        size: 14.sp,
                        color: colors.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _formatTimeAgo(),
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 12.sp,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: isActive ? statusColor : colors.textSecondary,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isActive ? 'View Details' : 'View',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Iconsax.arrow_right_3,
                              size: 14.sp,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Direct Order Card Widget (for direct client orders)
class _DirectOrderCard extends StatelessWidget {
  final AppColorScheme colors;
  final ServiceRequest request;
  final bool isActive;
  final bool isHistory;

  const _DirectOrderCard({
    required this.colors,
    required this.request,
    required this.isActive,
    required this.isHistory,
  });

  String _getStatusText() {
    switch (request.status) {
      case RequestStatus.pending:
        return 'Pending';
      case RequestStatus.driver_proposed:
        return 'Awaiting Client';
      case RequestStatus.accepted:
        return 'Accepted';
      case RequestStatus.driver_arriving:
        return 'Heading to Pickup';
      case RequestStatus.in_progress:
        return 'In Progress';
      case RequestStatus.completed:
        return 'Completed';
      case RequestStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color _getStatusColor() {
    switch (request.status) {
      case RequestStatus.completed:
        return colors.success;
      case RequestStatus.in_progress:
      case RequestStatus.driver_arriving:
        return colors.primary;
      case RequestStatus.accepted:
        return colors.info;
      case RequestStatus.driver_proposed:
        return colors.warning;
      case RequestStatus.pending:
        return colors.warning;
      case RequestStatus.cancelled:
        return colors.error;
    }
  }

  IconData _getStatusIcon() {
    switch (request.status) {
      case RequestStatus.completed:
        return Iconsax.tick_circle;
      case RequestStatus.in_progress:
        return Iconsax.truck_fast;
      case RequestStatus.driver_arriving:
        return Iconsax.routing;
      case RequestStatus.accepted:
        return Iconsax.user_tick;
      case RequestStatus.driver_proposed:
      case RequestStatus.pending:
        return Iconsax.clock;
      case RequestStatus.cancelled:
        return Iconsax.close_circle;
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

  @override
  Widget build(BuildContext context) {
    final statusText = _getStatusText();
    final statusColor = _getStatusColor();
    final statusIcon = _getStatusIcon();
    // Allow navigation for all active requests including driver_proposed
    final canNavigate = isActive || 
        request.status == RequestStatus.in_progress ||
        request.status == RequestStatus.driver_proposed ||
        request.status == RequestStatus.driver_arriving;

    return GestureDetector(
      onTap: canNavigate
          ? () {
              Get.toNamed('/driver/active-request', arguments: request);
            }
          : null,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: isActive
              ? Border.all(color: statusColor, width: 2)
              : Border.all(color: colors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header with status gradient
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    statusColor.withValues(alpha: 0.15),
                    statusColor.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(statusIcon, size: 20.sp, color: statusColor),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Iconsax.user,
                              size: 14.sp,
                              color: colors.primary,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Direct Order',
                              style: TextStyle(
                                color: colors.primary,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'ORD-${request.id}',
                          style: AppTypography.bodyMedium(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        isHistory && request.agreedPrice != null
                            ? CurrencyHelper.formatWithSymbol(Get.find<RequestController>().getFinalEarnings(request), request.currencySymbol)
                            : CurrencyHelper.formatWithSymbol(request.totalPrice, request.currencySymbol),
                        style: AppTypography.titleMedium(context).copyWith(
                          color: isHistory ? Colors.green : statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Locations
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                children: [
                  // Pickup location
                  Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Iconsax.location,
                          size: 16.sp,
                          color: colors.primary,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pickup',
                              style: TextStyle(
                                color: colors.textSecondary,
                                fontSize: 10.sp,
                              ),
                            ),
                            Text(
                              request.pickupLocation?.address ??
                                  request.pickupLocation?.placeName ??
                                  'Flexible Pickup',
                              style: AppTypography.bodySmall(context).copyWith(
                                color: request.pickupLocation == null
                                    ? colors.warning
                                    : colors.textPrimary,
                                fontWeight: request.pickupLocation == null
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Connector line
                  Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Row(
                      children: [
                        Container(
                          width: 2,
                          height: 16.h,
                          color: colors.border,
                        ),
                      ],
                    ),
                  ),

                  // Destination
                  Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Iconsax.location_tick,
                          size: 16.sp,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Destination',
                              style: TextStyle(
                                color: colors.textSecondary,
                                fontSize: 10.sp,
                              ),
                            ),
                            Text(
                              request.destinationLocation.address ??
                                  request.destinationLocation.placeName ??
                                  'Destination',
                              style: AppTypography.bodySmall(context).copyWith(
                                color: colors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Footer
                  Row(
                    children: [
                      // Service type
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          request.serviceType.name.capitalizeFirst ?? 'Service',
                          style: TextStyle(
                            color: colors.primary,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      if (request.distance != null &&
                          request.distance! > 0) ...[
                        Icon(
                          Iconsax.routing_2,
                          size: 14.sp,
                          color: colors.textSecondary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${request.distance!.toStringAsFixed(1)} km',
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                      ],
                      Icon(
                        Iconsax.clock,
                        size: 14.sp,
                        color: colors.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _formatTimeAgo(),
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 12.sp,
                        ),
                      ),
                      const Spacer(),
                      if (isActive)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'View',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                Iconsax.arrow_right_3,
                                size: 14.sp,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
