import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import '../../core/theme/app_colors.dart';
import '../../core/utils/currency_helper.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/driver_store_delivery_controller.dart';
import 'driver_store_delivery_screen.dart';

/// Driver Store Delivery Requests Screen
/// Shows available store delivery requests and recently accepted deliveries
class DriverStoreRequestsScreen extends StatefulWidget {
  const DriverStoreRequestsScreen({super.key});

  @override
  State<DriverStoreRequestsScreen> createState() =>
      _DriverStoreRequestsScreenState();
}

class _DriverStoreRequestsScreenState extends State<DriverStoreRequestsScreen>
    with SingleTickerProviderStateMixin {
  late final DriverStoreDeliveryController _controller;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<DriverStoreDeliveryController>()) {
      _controller = Get.put(DriverStoreDeliveryController());
    } else {
      _controller = Get.find<DriverStoreDeliveryController>();
    }
    _tabController = TabController(length: 2, vsync: this);
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
          'Store Deliveries',
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
          tabs: const [
            Tab(text: 'Pending Requests'),
            Tab(text: 'Recent Accepted'),
          ],
        ),
      ),
      body: Obx(() {
        return TabBarView(
          controller: _tabController,
          children: [
            // Tab 1: Pending Requests
            _buildPendingRequestsTab(colors),
            // Tab 2: Recent Accepted (also shows active deliveries)
            _buildRecentAcceptedTab(colors),
          ],
        );
      }),
    );
  }

  Widget _buildPendingRequestsTab(dynamic colors) {
    if (_controller.isLoadingRequests.value &&
        _controller.availableRequests.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_controller.availableRequests.isEmpty) {
      return RefreshIndicator(
        onRefresh: _controller.loadAvailableRequests,
        child: ListView(
          children: [
            SizedBox(height: 100.h),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.shopping_bag,
                    size: 64.sp,
                    color: colors.textSecondary.withOpacity(0.5),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No delivery requests',
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'New requests will appear here',
                    style: TextStyle(
                      color: colors.textSecondary.withOpacity(0.7),
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

    return RefreshIndicator(
      onRefresh: _controller.refresh,
      child: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          // Direct requests (priority)
          if (_controller.directRequests.isNotEmpty) ...[
            Row(
              children: [
                Icon(Iconsax.flash, size: 18.sp, color: Colors.orange),
                SizedBox(width: 8.w),
                Text(
                  'Direct Requests',
                  style: AppTypography.labelLarge(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ..._controller.directRequests.map(
              (request) => _RequestCard(
                request: request,
                controller: _controller,
                colors: colors,
                isDirect: true,
              ),
            ),
            SizedBox(height: 16.h),
          ],

          // Public requests
          if (_controller.publicRequests.isNotEmpty) ...[
            Row(
              children: [
                Icon(Iconsax.global, size: 18.sp, color: colors.textSecondary),
                SizedBox(width: 8.w),
                Text(
                  'Available Requests',
                  style: AppTypography.labelLarge(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ..._controller.publicRequests.map(
              (request) => _RequestCard(
                request: request,
                controller: _controller,
                colors: colors,
                isDirect: false,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActiveDeliveryView(dynamic colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.truck_fast,
            size: 64.sp,
            color: colors.primary,
          ),
          SizedBox(height: 16.h),
          Text(
            'You have an active delivery',
            style: AppTypography.titleMedium(context).copyWith(
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Complete your current delivery first',
            style: AppTypography.bodyMedium(context).copyWith(
              color: colors.textSecondary,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: () => Get.to(() => const DriverStoreDeliveryScreen()),
            icon: const Icon(Iconsax.arrow_right),
            label: const Text('Go to Delivery'),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentAcceptedTab(dynamic colors) {
    // Show all active deliveries and last 5 completed
    final activeDeliveries = _controller.activeDeliveries.toList();
    final completed = _controller.completedDeliveries.take(5).toList();

    if (activeDeliveries.isEmpty && completed.isEmpty) {
      return RefreshIndicator(
        onRefresh: _controller.refresh,
        child: ListView(
          children: [
            SizedBox(height: 100.h),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.clock,
                    size: 64.sp,
                    color: colors.textSecondary.withOpacity(0.5),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No recent deliveries',
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Your accepted deliveries will appear here',
                    style: TextStyle(
                      color: colors.textSecondary.withOpacity(0.7),
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

    return RefreshIndicator(
      onRefresh: _controller.refresh,
      child: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          // Active deliveries
          if (activeDeliveries.isNotEmpty) ...[
            Row(
              children: [
                Icon(Iconsax.location_tick, size: 18.sp, color: Colors.blue),
                SizedBox(width: 8.w),
                Text(
                  'In Progress (${activeDeliveries.length})',
                  style: AppTypography.labelLarge(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ...activeDeliveries.map(
              (order) => _AcceptedDeliveryCard(
                order: order,
                colors: colors,
                isCompleted: false,
              ),
            ),
            SizedBox(height: 16.h),
          ],

          // Completed deliveries
          if (completed.isNotEmpty) ...[
            Row(
              children: [
                Icon(Iconsax.tick_circle, size: 18.sp, color: Colors.green),
                SizedBox(width: 8.w),
                Text(
                  'Completed (${completed.length})',
                  style: AppTypography.labelLarge(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ...completed.map(
              (order) => _AcceptedDeliveryCard(
                order: order,
                colors: colors,
                isCompleted: true,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final StoreDeliveryRequest request;
  final DriverStoreDeliveryController controller;
  final dynamic colors;
  final bool isDirect;

  const _RequestCard({
    required this.request,
    required this.controller,
    required this.colors,
    required this.isDirect,
  });

  @override
  Widget build(BuildContext context) {
    final earnings = controller.calculateEarnings(request);
    final expiresIn = request.expiresAt != null
        ? request.expiresAt!.difference(DateTime.now())
        : null;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: isDirect ? Border.all(color: Colors.orange, width: 2) : null,
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
            children: [
              if (isDirect)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Iconsax.flash, size: 12.sp, color: Colors.white),
                      SizedBox(width: 4.w),
                      Text(
                        'Direct',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              const Spacer(),
              // Earnings
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.money, size: 16.sp, color: Colors.green),
                    SizedBox(width: 4.w),
                    Text(
                      CurrencyHelper.format(earnings),
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Pickup location
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Iconsax.shop, size: 14.sp, color: Colors.blue),
              ),
              SizedBox(width: 8.w),
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
                      request.pickupAddress,
                      style: AppTypography.bodyMedium(context).copyWith(
                        color: colors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Delivery location
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Iconsax.location, size: 14.sp, color: Colors.green),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deliver to',
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      request.deliveryAddress,
                      style: AppTypography.bodyMedium(context).copyWith(
                        color: colors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Distance and time
          Row(
            children: [
              Icon(Iconsax.routing_2, size: 14.sp, color: colors.textSecondary),
              SizedBox(width: 4.w),
              Text(
                '${request.distanceKm?.toStringAsFixed(1) ?? "?"} km',
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(width: 16.w),
              if (expiresIn != null && expiresIn.inMinutes > 0) ...[
                Icon(Iconsax.clock, size: 14.sp, color: Colors.orange),
                SizedBox(width: 4.w),
                Text(
                  'Expires in ${expiresIn.inMinutes}m',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 16.h),

          // Action buttons
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.isProcessing.value
                        ? null
                        : () => _declineRequest(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                    child: const Text('Decline'),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: controller.isProcessing.value
                        ? null
                        : () => _acceptRequest(context),
                    icon: controller.isProcessing.value
                        ? SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : const Icon(Iconsax.tick_circle),
                    label: Text(
                      controller.isProcessing.value ? 'Accepting...' : 'Accept',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
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

  void _acceptRequest(BuildContext context) async {
    final success = await controller.acceptRequest(request.id!);
    if (success) {
      Get.snackbar(
        'Accepted',
        'Delivery accepted! Head to the store.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.to(() => const DriverStoreDeliveryScreen());
    } else {
      Get.snackbar(
        'Error',
        controller.errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _declineRequest(BuildContext context) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Decline Request'),
        content: const Text(
          'Are you sure you want to decline this delivery request?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Decline', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await controller.rejectRequest(request.id!);
    }
  }
}

/// Card widget for displaying accepted/completed deliveries
class _AcceptedDeliveryCard extends StatelessWidget {
  final StoreOrder order;
  final dynamic colors;
  final bool isCompleted;

  const _AcceptedDeliveryCard({
    required this.order,
    required this.colors,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = isCompleted ? Colors.green : Colors.blue;
    final statusIcon = isCompleted
        ? Iconsax.tick_circle
        : Iconsax.location_tick;
    final statusText = isCompleted ? 'Completed' : 'In Progress';

    return GestureDetector(
      onTap: () {
        if (!isCompleted) {
          // Navigate to delivery screen for active deliveries
          Get.to(() => DriverStoreDeliveryScreen(order: order));
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: statusColor.withOpacity(0.3), width: 1),
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
            // Status header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 14.sp, color: statusColor),
                      SizedBox(width: 4.w),
                      Text(
                        statusText,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  'Order #${order.id}',
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Store info
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: colors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Icon(
                      Iconsax.shop,
                      size: 20.sp,
                      color: colors.primary,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Store Order',
                        style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 11.sp,
                        ),
                      ),
                      Text(
                        'Items: ${_parseItemCount(order.itemsJson)}',
                        style: AppTypography.labelMedium(context).copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Delivery address
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Iconsax.location, size: 16.sp, color: Colors.green),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deliver to',
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Time and earnings
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Iconsax.clock,
                      size: 14.sp,
                      color: colors.textSecondary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      _formatDate(order.createdAt),
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    CurrencyHelper.formatWithSymbol(order.deliveryFee, order.currencySymbol),
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _parseItemCount(String itemsJson) {
    try {
      final items = jsonDecode(itemsJson) as List;
      return '${items.length}';
    } catch (_) {
      return '?';
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) {
      return 'Just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else {
      return DateFormat('MMM dd').format(date);
    }
  }
}
