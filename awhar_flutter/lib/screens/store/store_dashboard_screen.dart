import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/store_controller.dart';
import '../../core/controllers/store_order_controller.dart';
import '../../shared/widgets/promo_banner_widget.dart';
import 'package:awhar_client/awhar_client.dart';
 
import 'store_registration_screen.dart';
import 'store_profile_screen.dart';
import 'store_products_screen.dart';
import 'store_orders_screen.dart';
import 'store_order_detail_screen.dart';
import 'store_analytics_screen.dart';

/// Store dashboard screen
/// Main screen for store owners showing overview and quick actions
class StoreDashboardScreen extends StatefulWidget {
  const StoreDashboardScreen({super.key});

  @override
  State<StoreDashboardScreen> createState() => _StoreDashboardScreenState();
}

class _StoreDashboardScreenState extends State<StoreDashboardScreen> {
  late final StoreController _storeController;

  @override
  void initState() {
    super.initState();
    // Initialize store controller if not already
    if (!Get.isRegistered<StoreController>()) {
      _storeController = Get.put(StoreController());
    } else {
      _storeController = Get.find<StoreController>();
    }
    
    // Initialize store order controller for pending orders badge
    if (!Get.isRegistered<StoreOrderController>()) {
      Get.put(StoreOrderController());
    }

    // Ensure orders are loaded for dashboard recent section
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orderController = Get.find<StoreOrderController>();
      if (orderController.orders.isEmpty && !orderController.isLoading.value) {
        orderController.loadOrders();
      }
    });
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
          'store_management.title'.tr,
          style: AppTypography.titleMedium(context).copyWith(
            color: colors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Iconsax.notification, color: colors.textPrimary),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
          IconButton(
            icon: Icon(Iconsax.setting_2, color: colors.textPrimary),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
      body: Obx(() {
        if (_storeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // If user doesn't have a store, show registration prompt
        if (!_storeController.hasStore) {
          return _buildNoStoreView(colors);
        }

        // Show store dashboard
        return RefreshIndicator(
          onRefresh: _storeController.refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Promo Banners for Store Owners
                const PromoBannerWidget(userRole: 'store'),
                SizedBox(height: 16.h),
                
                // Store header card
                _buildStoreHeader(colors),
                SizedBox(height: 24.h),
                
                // Quick stats
                _buildQuickStats(colors),
                SizedBox(height: 24.h),
                
                // Quick actions
                Text(
                  'Quick Actions',
                  style: AppTypography.titleSmall(context).copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 12.h),
                _buildQuickActions(colors),
                SizedBox(height: 24.h),
                
                // Recent orders placeholder
                _buildRecentOrdersSection(colors),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNoStoreView(dynamic colors) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.shop,
                size: 56.sp,
                color: colors.primary,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'store_management.no_store_yet'.tr,
              style: AppTypography.titleLarge(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              'Register your store to start selling products and reach customers in your area.',
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Get.to(() => const StoreRegistrationScreen()),
                icon: Icon(Iconsax.add, color: Colors.white),
                label: Text(
                  'store_management.register_now'.tr,
                  style: AppTypography.labelLarge(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreHeader(dynamic colors) {
    final store = _storeController.myStore.value!;
    
    return GestureDetector(
      onTap: () => Get.to(() => const StoreProfileScreen()),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            // Store logo
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: store.logoUrl != null
                  ? CachedNetworkImage(
                      imageUrl: store.logoUrl!,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Iconsax.shop,
                      size: 32.sp,
                      color: colors.primary,
                    ),
              ),
            ),
            SizedBox(width: 16.w),
            // Store info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.name,
                    style: AppTypography.titleMedium(context).copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: store.isOpen ? Colors.green : Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        store.isOpen 
                          ? 'store_management.store_open'.tr 
                          : 'store_management.store_closed'.tr,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: store.isOpen ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Toggle switch
            Switch.adaptive(
              value: store.isOpen,
              onChanged: (value) async {
                await _storeController.toggleStoreOpen();
              },
              activeTrackColor: colors.primary.withValues(alpha: 0.4),
              thumbColor: WidgetStateProperty.all(colors.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(dynamic colors) {
    final store = _storeController.myStore.value!;
    final productCount = _storeController.products.length;
    final orderController = Get.find<StoreOrderController>();

    return Obx(() {
      final orderCount = orderController.orders.length;
      return Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'store_management.total_orders'.tr,
              orderCount.toString(),
              Iconsax.shopping_bag,
              colors.primary,
              colors,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildStatCard(
              'store_products.title'.tr,
              productCount.toString(),
              Iconsax.box,
              Colors.orange,
              colors,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildStatCard(
              'store_management.rating'.tr,
              store.rating.toStringAsFixed(1),
              Iconsax.star_1,
              Colors.amber,
              colors,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildStatCard(
    String label, 
    String value, 
    IconData icon, 
    Color iconColor,
    dynamic colors,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppTypography.headlineSmall(context).copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: AppTypography.labelSmall(context).copyWith(
              color: colors.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(dynamic colors) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 10.w,
      childAspectRatio: 1.8,
      children: [
        _buildActionCard(
          title: 'store_products.title'.tr,
          icon: Iconsax.box,
          onTap: () => Get.to(() => const StoreProductsScreen()),
          colors: colors,
        ),
        _buildOrdersActionCard(colors),
        _buildActionCard(
          title: 'store_management.store_profile'.tr,
          icon: Iconsax.edit,
          onTap: () => Get.to(() => const StoreProfileScreen()),
          colors: colors,
        ),
        _buildActionCard(
          title: 'store_management.analytics'.tr,
          icon: Iconsax.chart,
          onTap: () => Get.to(() => const StoreAnalyticsScreen()),
          colors: colors,
        ),
      ],
    );
  }

  /// Build orders action card with pending orders badge
  Widget _buildOrdersActionCard(dynamic colors) {
    return Obx(() {
      final orderController = Get.find<StoreOrderController>();
      final pendingCount = orderController.pendingCount;

      return _buildActionCard(
        title: 'store_orders.title'.tr,
        icon: Iconsax.shopping_bag,
        onTap: () => Get.to(() => const StoreOrdersScreen()),
        colors: colors,
        badge: pendingCount > 0 ? pendingCount : null,
      );
    });
  }

  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required dynamic colors,
    int? badge,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Ink(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: colors.border),
          ),
          child: Stack(
            children: [
              // Content with left-aligned layout
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Row(
                  children: [
                    // Icon container
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: colors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        icon,
                        size: 20.sp,
                        color: colors.primary,
                      ),
                    ),
                    
                    SizedBox(width: 10.w),
                    
                    // Title
                    Expanded(
                      child: Text(
                        title,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Badge
              if (badge != null)
                Positioned(
                  top: 6.h,
                  right: 6.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: colors.error,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      badge.toString(),
                      style: AppTypography.labelSmall(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 9.sp,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentOrdersSection(dynamic colors) {
    final orderController = Get.find<StoreOrderController>();

    Color _statusColor(StoreOrderStatus status) {
      switch (status) {
        case StoreOrderStatus.pending:
          return Colors.orange;
        case StoreOrderStatus.confirmed:
        case StoreOrderStatus.preparing:
          return Colors.blue;
        case StoreOrderStatus.ready:
        case StoreOrderStatus.driverAssigned:
          return Colors.teal;
        case StoreOrderStatus.pickedUp:
        case StoreOrderStatus.inDelivery:
          return Colors.indigo;
        case StoreOrderStatus.delivered:
          return Colors.green;
        case StoreOrderStatus.cancelled:
          return Colors.red;
        case StoreOrderStatus.rejected:
          return Colors.redAccent;
      }
    }

    String _two(int n) => n.toString().padLeft(2, '0');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'store_orders.title'.tr,
              style: AppTypography.titleSmall(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.to(() => const StoreOrdersScreen());
              },
              child: Text(
                'common.view_all'.tr,
                style: AppTypography.labelMedium(context).copyWith(
                  color: colors.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Obx(() {
          if (orderController.isLoading.value) {
            return Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: CircularProgressIndicator(strokeWidth: 2, color: colors.primary),
                ),
              ),
            );
          }

          final orders = orderController.orders;
          if (orders.isEmpty) {
            return Container(
              padding: EdgeInsets.all(32.w),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Iconsax.shopping_bag,
                      size: 48.sp,
                      color: colors.textSecondary,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'store_orders.no_orders'.tr,
                      style: AppTypography.bodyMedium(context).copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final recent = orders.toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
          final top = recent.take(5).toList();

          return Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: top.length,
              separatorBuilder: (_, __) => Divider(height: 1, color: colors.divider.withValues(alpha: 0.2)),
              itemBuilder: (context, index) {
                final o = top[index];
                final t = o.createdAt.toLocal();
                final time = '${_two(t.hour)}:${_two(t.minute)}';
                final clientName = orderController.getClientName(o.clientId);
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  leading: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(Iconsax.shopping_bag, color: colors.primary, size: 22.sp),
                  ),
                  title: Row(
                    children: [
                      Text(
                        '#${o.id}',
                        style: AppTypography.labelLarge(context).copyWith(color: colors.textPrimary, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          '• '+clientName,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.labelMedium(context).copyWith(color: colors.textSecondary, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: _statusColor(o.status).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          o.status.name.tr,
                          style: AppTypography.labelSmall(context).copyWith(color: _statusColor(o.status), fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    time,
                    style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary),
                  ),
                  trailing: Icon(Iconsax.arrow_right_3, color: colors.textSecondary),
                  onTap: () {
                    Get.to(() => StoreOrderDetailScreen(
                      orderId: o.id ?? 0,
                      orderNumber: o.orderNumber,
                    ));
                  },
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
