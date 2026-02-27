import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/currency_helper.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/store_controller.dart';
import '../../core/controllers/auth_controller.dart';

/// Store Analytics Screen
/// Displays statistics and insights for the store owner
class StoreAnalyticsScreen extends StatefulWidget {
  const StoreAnalyticsScreen({super.key});

  @override
  State<StoreAnalyticsScreen> createState() => _StoreAnalyticsScreenState();
}

class _StoreAnalyticsScreenState extends State<StoreAnalyticsScreen> {
  late final Client _client;
  late final StoreController _storeController;
  late final AuthController _authController;

  final RxBool _isLoading = true.obs;
  final RxString _selectedPeriod = 'week'.obs;

  // Stats
  final RxInt _totalOrders = 0.obs;
  final RxDouble _totalEarnings = 0.0.obs;
  final RxDouble _avgRating = 0.0.obs;
  final RxInt _reviewCount = 0.obs;
  final RxList<Map<String, dynamic>> _recentOrders = <Map<String, dynamic>>[].obs;
  final RxList<double> _dailyEarnings = <double>[].obs;

  @override
  void initState() {
    super.initState();
    _client = Get.find<Client>();
    _storeController = Get.find<StoreController>();
    _authController = Get.find<AuthController>();
    _loadAnalytics();
  }

  int? get _userId => _authController.currentUser.value?.id;

  Future<void> _loadAnalytics() async {
    try {
      _isLoading.value = true;
      final storeId = _storeController.storeId;
      final userId = _userId;
      if (storeId == null || userId == null) return;

      // Load store stats
      final store = await _client.store.getStoreById(storeId);
      if (store != null) {
        _avgRating.value = store.rating;
        _reviewCount.value = store.totalRatings;
      }

      // Load orders for period
      final now = DateTime.now();
      DateTime startDate;
      switch (_selectedPeriod.value) {
        case 'today':
          startDate = DateTime(now.year, now.month, now.day);
          break;
        case 'week':
          startDate = now.subtract(const Duration(days: 7));
          break;
        case 'month':
          startDate = now.subtract(const Duration(days: 30));
          break;
        default:
          startDate = now.subtract(const Duration(days: 7));
      }

      final orders = await _client.storeOrder.getStoreOrders(
        userId: userId,
        storeId: storeId,
        limit: 500,
        offset: 0,
      );

      // Filter by period
      final periodOrders = orders.where((o) => o.createdAt.isAfter(startDate)).toList();

      _totalOrders.value = periodOrders.length;
      _totalEarnings.value = periodOrders
          .where((o) => o.status == StoreOrderStatus.delivered)
          .fold(0.0, (sum, o) => sum + o.total);

      // Calculate daily earnings for chart (last 7 days)
      final dailyData = <double>[];
      for (int i = 6; i >= 0; i--) {
        final day = now.subtract(Duration(days: i));
        final dayStart = DateTime(day.year, day.month, day.day);
        final dayEnd = dayStart.add(const Duration(days: 1));
        final dayTotal = orders
            .where((o) =>
                o.status == StoreOrderStatus.delivered &&
                o.createdAt.isAfter(dayStart) &&
                o.createdAt.isBefore(dayEnd))
            .fold(0.0, (sum, o) => sum + o.total);
        dailyData.add(dayTotal);
      }
      _dailyEarnings.assignAll(dailyData);

      // Recent orders
      _recentOrders.assignAll(periodOrders.take(5).map((o) => {
            'id': o.id,
            'total': o.total,
            'status': o.status.name,
            'date': o.createdAt,
          }).toList());
    } catch (e) {
      debugPrint('[StoreAnalytics] Error: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(
          'analytics.title'.tr,
          style: AppTypography.titleMedium(context)
              .copyWith(color: colors.textPrimary),
        ),
        backgroundColor: colors.surface,
        actions: [
          IconButton(
            icon: Icon(Iconsax.refresh, color: colors.primary),
            onPressed: _loadAnalytics,
          ),
        ],
      ),
      body: Obx(() {
        if (_isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: _loadAnalytics,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Period selector
                _buildPeriodSelector(colors),
                SizedBox(height: 16.h),

                // Stats cards
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        colors,
                        Iconsax.shopping_bag,
                        'analytics.orders'.tr,
                        _totalOrders.value.toString(),
                        colors.primary,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildStatCard(
                        colors,
                        Iconsax.money_4,
                        'analytics.earnings'.tr,
                        CurrencyHelper.format(_totalEarnings.value),
                        Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        colors,
                        Iconsax.star_1,
                        'analytics.rating'.tr,
                        _avgRating.value.toStringAsFixed(1),
                        Colors.amber,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildStatCard(
                        colors,
                        Iconsax.message_text,
                        'analytics.reviews'.tr,
                        _reviewCount.value.toString(),
                        Colors.purple,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Earnings chart
                Text(
                  'analytics.earnings_chart'.tr,
                  style: AppTypography.titleMedium(context)
                      .copyWith(color: colors.textPrimary),
                ),
                SizedBox(height: 12.h),
                Container(
                  height: 200.h,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: _buildSimpleBarChart(colors),
                ),
                SizedBox(height: 24.h),

                // Recent orders
                Text(
                  'analytics.recent_orders'.tr,
                  style: AppTypography.titleMedium(context)
                      .copyWith(color: colors.textPrimary),
                ),
                SizedBox(height: 12.h),
                ..._recentOrders.map((order) => _buildOrderItem(colors, order)),

                if (_recentOrders.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.w),
                      child: Text(
                        'analytics.no_orders'.tr,
                        style: AppTypography.bodyMedium(context)
                            .copyWith(color: colors.textSecondary),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPeriodSelector(dynamic colors) {
    return Obx(() => Row(
          children: [
            _buildPeriodChip(colors, 'today', 'analytics.today'.tr),
            SizedBox(width: 8.w),
            _buildPeriodChip(colors, 'week', 'analytics.week'.tr),
            SizedBox(width: 8.w),
            _buildPeriodChip(colors, 'month', 'analytics.month'.tr),
          ],
        ));
  }

  Widget _buildPeriodChip(dynamic colors, String value, String label) {
    final isSelected = _selectedPeriod.value == value;
    return GestureDetector(
      onTap: () {
        _selectedPeriod.value = value;
        _loadAnalytics();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary : colors.surface,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? colors.primary : colors.textSecondary.withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : colors.textPrimary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    dynamic colors,
    IconData icon,
    String label,
    String value,
    Color iconColor,
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
          Icon(icon, color: iconColor, size: 24.sp),
          SizedBox(height: 12.h),
          Text(
            value,
            style: AppTypography.headlineMedium(Get.context!)
                .copyWith(color: colors.textPrimary, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: AppTypography.bodyMedium(Get.context!)
                .copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }

  /// Simple bar chart using basic Flutter widgets (no fl_chart dependency)
  Widget _buildSimpleBarChart(dynamic colors) {
    if (_dailyEarnings.isEmpty) {
      return Center(
        child: Text(
          'analytics.no_data'.tr,
          style: TextStyle(color: colors.textSecondary),
        ),
      );
    }

    final maxY = _dailyEarnings.reduce((a, b) => a > b ? a : b);
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final now = DateTime.now();
    final startDay = now.subtract(const Duration(days: 6)).weekday - 1;

    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(_dailyEarnings.length, (i) {
              final value = _dailyEarnings[i];
              final heightFraction = maxY > 0 ? value / maxY : 0.0;

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (value > 0)
                        Text(
                          '${value.toInt()}',
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: colors.textSecondary,
                          ),
                        ),
                      SizedBox(height: 4.h),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: (heightFraction * 100).clamp(4.0, 100.0),
                        decoration: BoxDecoration(
                          color: colors.primary,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(4.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: List.generate(_dailyEarnings.length, (i) {
            final dayIndex = (startDay + i) % 7;
            return Expanded(
              child: Text(
                days[dayIndex],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 10.sp,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildOrderItem(dynamic colors, Map<String, dynamic> order) {
    final date = order['date'] as DateTime;
    final formattedDate = '${date.day}/${date.month} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(Iconsax.receipt, color: colors.primary, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #${order['id']}',
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  formattedDate,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                CurrencyHelper.format(order['total'] as double),
                style: TextStyle(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(order['status']).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  order['status'],
                  style: TextStyle(
                    color: _getStatusColor(order['status']),
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'delivered':
        return Colors.green;
      case 'cancelled':
      case 'rejected':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }
}
