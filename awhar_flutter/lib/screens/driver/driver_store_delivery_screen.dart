import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import '../../core/theme/app_colors.dart';
import '../../core/utils/currency_helper.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/driver_store_delivery_controller.dart';
import '../shared/store_order_chat_screen.dart';

/// Driver Store Delivery Screen
/// Shows the active store delivery with full order details and progress actions
class DriverStoreDeliveryScreen extends StatefulWidget {
  final StoreOrder? order;

  const DriverStoreDeliveryScreen({super.key, this.order});

  @override
  State<DriverStoreDeliveryScreen> createState() =>
      _DriverStoreDeliveryScreenState();
}

class _DriverStoreDeliveryScreenState extends State<DriverStoreDeliveryScreen> {
  late final DriverStoreDeliveryController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<DriverStoreDeliveryController>();

    // If an order was passed, set it as current
    if (widget.order != null) {
      _controller.currentDelivery.value = widget.order;
      _controller.loadStoreDetails(widget.order!.storeId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      body: Obx(() {
        final order = _controller.currentDelivery.value;
        final store = _controller.currentStore.value;

        if (order == null) {
          return _buildEmptyState(colors);
        }

        return CustomScrollView(
          slivers: [
            // Custom App Bar with order info
            _buildAppBar(context, order, colors),

            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress stepper
                    _buildProgressStepper(order, colors),
                    SizedBox(height: 20.h),

                    // Current action card - MAIN ACTION
                    _buildCurrentActionCard(context, order, colors),
                    SizedBox(height: 20.h),

                    // Quick actions row
                    _buildQuickActions(order, store, colors),
                    SizedBox(height: 20.h),

                    // Store info card
                    if (store != null)
                      _buildLocationCard(
                        context,
                        title: 'Pickup Location',
                        icon: Iconsax.shop,
                        iconColor: Colors.blue,
                        name: store.name,
                        address: store.address,
                        phone: store.phone,
                        latitude: store.latitude,
                        longitude: store.longitude,
                        colors: colors,
                        isActive:
                            order.status == StoreOrderStatus.driverAssigned ||
                            order.status == StoreOrderStatus.ready,
                      ),
                    SizedBox(height: 16.h),

                    // Delivery destination card
                    _buildLocationCard(
                      context,
                      title: 'Delivery Destination',
                      icon: Iconsax.location,
                      iconColor: Colors.green,
                      name: 'Customer',
                      address: order.deliveryAddress,
                      phone: null,
                      latitude: order.deliveryLatitude,
                      longitude: order.deliveryLongitude,
                      colors: colors,
                      isActive:
                          order.status == StoreOrderStatus.pickedUp ||
                          order.status == StoreOrderStatus.inDelivery,
                      distance: order.deliveryDistance,
                    ),
                    SizedBox(height: 20.h),

                    // Order items section
                    _buildOrderItemsSection(context, order, colors),
                    SizedBox(height: 20.h),

                    // Payment breakdown
                    _buildPaymentBreakdown(context, order, colors),
                    SizedBox(height: 20.h),

                    // Order notes if any
                    if (order.clientNotes != null &&
                        order.clientNotes!.isNotEmpty)
                      _buildNotesSection(context, order, colors),

                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildEmptyState(dynamic colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.box_search,
            size: 80.sp,
            color: colors.textSecondary.withOpacity(0.3),
          ),
          SizedBox(height: 24.h),
          Text(
            'No Active Delivery',
            style: AppTypography.titleLarge(context).copyWith(
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Accept a delivery request to get started',
            style: AppTypography.bodyMedium(context).copyWith(
              color: colors.textSecondary,
            ),
          ),
          SizedBox(height: 32.h),
          ElevatedButton.icon(
            onPressed: () => Get.back(),
            icon: const Icon(Iconsax.arrow_left),
            label: const Text('Go Back'),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(
    BuildContext context,
    StoreOrder order,
    dynamic colors,
  ) {
    return SliverAppBar(
      expandedHeight: 140.h,
      pinned: true,
      backgroundColor: _getStatusColor(order.status),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Iconsax.message, color: Colors.white),
          onPressed: () => _openChat(),
          tooltip: 'Chat',
        ),
        IconButton(
          icon: const Icon(Iconsax.refresh, color: Colors.white),
          onPressed: () => _controller.loadActiveDeliveries(),
          tooltip: 'Refresh',
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _getStatusColor(order.status),
                _getStatusColor(order.status).withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 56.h, 16.w, 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getStatusIcon(order.status),
                        color: Colors.white,
                        size: 28.sp,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getStatusTitle(order.status),
                              style: AppTypography.titleMedium(context)
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              'Order ${order.orderNumber}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          CurrencyHelper.formatWithSymbol(
                            order.driverEarnings,
                            order.currencySymbol,
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressStepper(StoreOrder order, dynamic colors) {
    final steps = [
      {'key': 'assigned', 'label': 'Assigned', 'icon': Iconsax.user_tick},
      {'key': 'at_store', 'label': 'At Store', 'icon': Iconsax.shop},
      {'key': 'picked_up', 'label': 'Picked Up', 'icon': Iconsax.box_tick},
      {'key': 'at_client', 'label': 'At Client', 'icon': Iconsax.location_tick},
      {'key': 'delivered', 'label': 'Delivered', 'icon': Iconsax.tick_circle},
    ];

    int currentStepIndex = _getCurrentStepIndex(order.status);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
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
          Text(
            'Delivery Progress',
            style: AppTypography.labelLarge(context).copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: List.generate(steps.length, (index) {
              final step = steps[index];
              final isCompleted = index < currentStepIndex;
              final isCurrent = index == currentStepIndex;
              final isLast = index == steps.length - 1;

              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 36.w,
                            height: 36.w,
                            decoration: BoxDecoration(
                              color: isCompleted || isCurrent
                                  ? _getStatusColor(order.status)
                                  : colors.background,
                              shape: BoxShape.circle,
                              border: isCurrent
                                  ? Border.all(
                                      color: _getStatusColor(order.status),
                                      width: 3,
                                    )
                                  : isCompleted
                                  ? null
                                  : Border.all(
                                      color: colors.textSecondary.withOpacity(
                                        0.3,
                                      ),
                                      width: 1,
                                    ),
                            ),
                            child: Icon(
                              isCompleted
                                  ? Iconsax.tick_circle
                                  : step['icon'] as IconData,
                              color: isCompleted || isCurrent
                                  ? Colors.white
                                  : colors.textSecondary.withOpacity(0.5),
                              size: 16.sp,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            step['label'] as String,
                            style: TextStyle(
                              color: isCompleted || isCurrent
                                  ? colors.textPrimary
                                  : colors.textSecondary.withOpacity(0.5),
                              fontSize: 9.sp,
                              fontWeight: isCurrent
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: isCompleted
                              ? _getStatusColor(order.status)
                              : colors.textSecondary.withOpacity(0.2),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentActionCard(
    BuildContext context,
    StoreOrder order,
    dynamic colors,
  ) {
    if (order.status == StoreOrderStatus.delivered) {
      return _buildCompletedCard(order, colors);
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getStatusColor(order.status),
            _getStatusColor(order.status).withOpacity(0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: _getStatusColor(order.status).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  _getActionIcon(order.status),
                  color: Colors.white,
                  size: 28.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getActionTitle(order.status),
                      style: AppTypography.titleMedium(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _getActionDescription(order.status),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Obx(
            () => SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: _controller.isProcessing.value
                    ? null
                    : () => _performAction(context, order),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: _getStatusColor(order.status),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: _controller.isProcessing.value
                    ? SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(
                            _getStatusColor(order.status),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_getActionButtonIcon(order.status)),
                          SizedBox(width: 8.w),
                          Text(
                            _getActionButtonText(order.status),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedCard(StoreOrder order, dynamic colors) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green, Colors.green.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(
            Iconsax.tick_circle,
            color: Colors.white,
            size: 64.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'Delivery Completed!',
            style: AppTypography.titleLarge(context).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'You earned ${CurrencyHelper.formatWithSymbol(order.driverEarnings, order.currencySymbol)}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
              ),
              child: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(StoreOrder order, Store? store, dynamic colors) {
    return Row(
      children: [
        if (store != null)
          Expanded(
            child: _QuickActionButton(
              icon: Iconsax.routing,
              label: 'Navigate',
              color: Colors.blue,
              onTap: () => _openNavigation(
                order.status == StoreOrderStatus.driverAssigned ||
                        order.status == StoreOrderStatus.ready
                    ? store.latitude
                    : order.deliveryLatitude,
                order.status == StoreOrderStatus.driverAssigned ||
                        order.status == StoreOrderStatus.ready
                    ? store.longitude
                    : order.deliveryLongitude,
              ),
            ),
          ),
        SizedBox(width: 12.w),
        if (store?.phone != null)
          Expanded(
            child: _QuickActionButton(
              icon: Iconsax.call,
              label: 'Call Store',
              color: Colors.green,
              onTap: () => _callPhone(store!.phone!),
            ),
          ),
        SizedBox(width: 12.w),
        Expanded(
          child: _QuickActionButton(
            icon: Iconsax.message,
            label: 'Chat',
            color: colors.primary,
            onTap: _openChat,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color iconColor,
    required String name,
    required String address,
    String? phone,
    required double latitude,
    required double longitude,
    required dynamic colors,
    bool isActive = false,
    double? distance,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: isActive
            ? Border.all(color: iconColor.withOpacity(0.5), width: 2)
            : null,
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, size: 20.sp, color: iconColor),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      name,
                      style: AppTypography.bodyMedium(context).copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              if (isActive)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'NEXT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            address,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 13.sp,
            ),
          ),
          if (distance != null) ...[
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(
                  Iconsax.routing_2,
                  size: 14.sp,
                  color: colors.textSecondary,
                ),
                SizedBox(width: 4.w),
                Text(
                  '${distance.toStringAsFixed(1)} km',
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _openNavigation(latitude, longitude),
                  icon: Icon(Iconsax.routing, size: 18.sp),
                  label: const Text('Navigate'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: iconColor,
                    side: BorderSide(color: iconColor),
                  ),
                ),
              ),
              if (phone != null) ...[
                SizedBox(width: 12.w),
                IconButton(
                  onPressed: () => _callPhone(phone),
                  icon: const Icon(Iconsax.call, color: Colors.green),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.green.withOpacity(0.1),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItemsSection(
    BuildContext context,
    StoreOrder order,
    dynamic colors,
  ) {
    List<Map<String, dynamic>> items = [];
    try {
      items = List<Map<String, dynamic>>.from(jsonDecode(order.itemsJson));
    } catch (_) {}

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
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
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '${items.length} items',
                  style: TextStyle(
                    color: colors.primary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: colors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text(
                        '${item['quantity']}x',
                        style: TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'] ?? 'Unknown Item',
                          style: AppTypography.bodyMedium(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (item['notes'] != null && item['notes'].isNotEmpty)
                          Text(
                            item['notes'],
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 12.sp,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Text(
                    CurrencyHelper.formatWithSymbol(
                      ((item['price'] ?? 0) * (item['quantity'] ?? 1))
                          .toDouble(),
                      order.currencySymbol,
                    ),
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentBreakdown(
    BuildContext context,
    StoreOrder order,
    dynamic colors,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade600, Colors.green.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.money, size: 20.sp, color: Colors.white),
              SizedBox(width: 8.w),
              Text(
                'Payment Summary',
                style: AppTypography.labelLarge(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Pay to store
          _buildPaymentRow(
            'Pay to Store',
            CurrencyHelper.formatWithSymbol(
              order.subtotal,
              order.currencySymbol,
            ),
            Colors.white.withOpacity(0.9),
          ),
          SizedBox(height: 8.h),

          // Collect from customer
          _buildPaymentRow(
            'Collect from Customer',
            CurrencyHelper.formatWithSymbol(order.total, order.currencySymbol),
            Colors.white,
            isBold: true,
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(color: Colors.white.withOpacity(0.3)),
          ),

          // Your earnings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Earnings',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    CurrencyHelper.formatWithSymbol(
                      order.driverEarnings,
                      order.currencySymbol,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Iconsax.wallet_1,
                  color: Colors.white,
                  size: 32.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(Iconsax.info_circle, size: 16.sp, color: Colors.white),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Keep ${CurrencyHelper.formatWithSymbol(order.driverEarnings, order.currencySymbol)} from the ${CurrencyHelper.formatWithSymbol(order.total, order.currencySymbol)} collected',
                    style: TextStyle(
                      color: Colors.white,
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

  Widget _buildPaymentRow(
    String label,
    String amount,
    Color color, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 14.sp,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            color: color,
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildNotesSection(
    BuildContext context,
    StoreOrder order,
    dynamic colors,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.note_1, size: 20.sp, color: Colors.amber.shade700),
              SizedBox(width: 8.w),
              Text(
                'Customer Notes',
                style: AppTypography.labelLarge(context).copyWith(
                  color: Colors.amber.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            order.clientNotes!,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods
  int _getCurrentStepIndex(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.driverAssigned:
      case StoreOrderStatus.ready:
        return 0;
      case StoreOrderStatus.pickedUp:
        return 2;
      case StoreOrderStatus.inDelivery:
        return 3;
      case StoreOrderStatus.delivered:
        return 4;
      default:
        return 0;
    }
  }

  Color _getStatusColor(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.driverAssigned:
      case StoreOrderStatus.ready:
        return Colors.blue;
      case StoreOrderStatus.pickedUp:
        return Colors.purple;
      case StoreOrderStatus.inDelivery:
        return Colors.orange;
      case StoreOrderStatus.delivered:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.driverAssigned:
      case StoreOrderStatus.ready:
        return Iconsax.shop;
      case StoreOrderStatus.pickedUp:
        return Iconsax.truck_fast;
      case StoreOrderStatus.inDelivery:
        return Iconsax.location;
      case StoreOrderStatus.delivered:
        return Iconsax.tick_circle;
      default:
        return Iconsax.box;
    }
  }

  String _getStatusTitle(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.driverAssigned:
      case StoreOrderStatus.ready:
        return 'Head to Store';
      case StoreOrderStatus.pickedUp:
        return 'Delivering';
      case StoreOrderStatus.inDelivery:
        return 'At Customer';
      case StoreOrderStatus.delivered:
        return 'Completed';
      default:
        return 'In Progress';
    }
  }

  IconData _getActionIcon(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.driverAssigned:
      case StoreOrderStatus.ready:
        return Iconsax.shop;
      case StoreOrderStatus.pickedUp:
        return Iconsax.truck_fast;
      case StoreOrderStatus.inDelivery:
        return Iconsax.box_tick;
      default:
        return Iconsax.tick_circle;
    }
  }

  String _getActionTitle(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.driverAssigned:
      case StoreOrderStatus.ready:
        return 'Go to Store';
      case StoreOrderStatus.pickedUp:
        return 'Heading to Customer';
      case StoreOrderStatus.inDelivery:
        return 'Complete Delivery';
      default:
        return 'Delivery Complete';
    }
  }

  String _getActionDescription(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.driverAssigned:
      case StoreOrderStatus.ready:
        return 'Navigate to the store and pick up the order';
      case StoreOrderStatus.pickedUp:
        return 'On your way to deliver the order';
      case StoreOrderStatus.inDelivery:
        return 'Hand over the order and collect payment';
      default:
        return 'Great job!';
    }
  }

  IconData _getActionButtonIcon(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.driverAssigned:
      case StoreOrderStatus.ready:
        return Iconsax.box_tick;
      case StoreOrderStatus.pickedUp:
        return Iconsax.location_tick;
      case StoreOrderStatus.inDelivery:
        return Iconsax.tick_circle;
      default:
        return Iconsax.tick_circle;
    }
  }

  String _getActionButtonText(StoreOrderStatus status) {
    switch (status) {
      case StoreOrderStatus.driverAssigned:
      case StoreOrderStatus.ready:
        return 'Arrived & Pick Up';
      case StoreOrderStatus.pickedUp:
        return 'Arrived at Customer';
      case StoreOrderStatus.inDelivery:
        return 'Complete Delivery';
      default:
        return 'Done';
    }
  }

  void _performAction(BuildContext context, StoreOrder order) {
    switch (order.status) {
      case StoreOrderStatus.driverAssigned:
      case StoreOrderStatus.ready:
        _showPickupDialog(context, order);
        break;
      case StoreOrderStatus.pickedUp:
        _confirmArrivedAtClient();
        break;
      case StoreOrderStatus.inDelivery:
        _showDeliveryDialog(context, order);
        break;
      default:
        break;
    }
  }

  void _showPickupDialog(BuildContext context, StoreOrder order) {
    final amountController = TextEditingController(
      text: order.subtotal.toStringAsFixed(2),
    );
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    Get.dialog(
      AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            const Icon(Iconsax.box_tick, color: Colors.blue),
            SizedBox(width: 12.w),
            Text('Confirm Pickup', style: TextStyle(color: colors.textPrimary)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please confirm:',
              style: TextStyle(color: colors.textPrimary),
            ),
            SizedBox(height: 12.h),
            _buildCheckItem('Arrived at the store', colors),
            _buildCheckItem('Received all items', colors),
            _buildCheckItem('Paid the store', colors),
            SizedBox(height: 20.h),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount paid to store',
                suffixText: CurrencyHelper.symbol,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                helperText:
                    'Expected: ${CurrencyHelper.formatWithSymbol(order.subtotal, order.currencySymbol)}',
                filled: true,
                fillColor: colors.background,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: TextStyle(color: colors.textPrimary),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: colors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              final amount =
                  double.tryParse(amountController.text) ?? order.subtotal;
              await _controller.pickedUp(amount);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: const Text(
              'Confirm Pickup',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text, dynamic colors) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(Iconsax.tick_circle, size: 18.sp, color: Colors.green),
          SizedBox(width: 8.w),
          Text(text, style: TextStyle(color: colors.textPrimary)),
        ],
      ),
    );
  }

  void _confirmArrivedAtClient() async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Row(
          children: [
            Icon(Iconsax.location_tick, color: Colors.orange),
            SizedBox(width: 12),
            Text('Arrived at Customer?'),
          ],
        ),
        content: const Text(
          'Confirm that you have arrived at the customer\'s location.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Not Yet'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text(
              'Yes, I\'m Here',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _controller.arrivedAtClient();
    }
  }

  void _showDeliveryDialog(BuildContext context, StoreOrder order) {
    final amountController = TextEditingController(
      text: order.total.toStringAsFixed(2),
    );
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    Get.dialog(
      AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            const Icon(Iconsax.tick_circle, color: Colors.green),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Complete Delivery',
                style: TextStyle(color: colors.textPrimary),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please confirm:',
                style: TextStyle(color: colors.textPrimary),
              ),
              SizedBox(height: 12.h),
              _buildCheckItem('Handed over all items', colors),
              _buildCheckItem('Collected payment', colors),
              SizedBox(height: 20.h),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Amount collected from customer',
                  suffixText: CurrencyHelper.symbol,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  helperText:
                      'Expected: ${CurrencyHelper.formatWithSymbol(order.total, order.currencySymbol)}',
                  filled: true,
                  fillColor: colors.background,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                style: TextStyle(color: colors.textPrimary),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.money, size: 20.sp, color: Colors.green),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'Your earnings: ${CurrencyHelper.formatWithSymbol(order.driverEarnings, order.currencySymbol)}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: colors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              final amount =
                  double.tryParse(amountController.text) ?? order.total;
              final success = await _controller.delivered(amount);
              if (success) {
                Get.snackbar(
                  '🎉 Delivery Complete!',
                  'You earned ${CurrencyHelper.formatWithSymbol(order.driverEarnings, order.currencySymbol)}',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                  duration: const Duration(seconds: 4),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: const Text(
              'Complete Delivery',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _openChat() {
    final order = _controller.currentDelivery.value;
    if (order != null) {
      Get.to(
        () => StoreOrderChatScreen(
          orderId: order.id!,
          userRole: 'driver',
        ),
      );
    }
  }

  void _openNavigation(double lat, double lng) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _callPhone(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24.sp),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
