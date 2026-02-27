import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/controllers/auth_controller.dart';
import '../../../../core/controllers/wallet_controller.dart';
import '../../../../core/utils/currency_helper.dart';

/// Driver earnings screen with modern UI/UX design
class DriverEarningsScreen extends StatefulWidget {
  const DriverEarningsScreen({super.key});

  @override
  State<DriverEarningsScreen> createState() => _DriverEarningsScreenState();
}

class _DriverEarningsScreenState extends State<DriverEarningsScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final WalletController _walletController = Get.find<WalletController>();

  @override
  void initState() {
    super.initState();
    debugPrint('[DriverEarningsScreen] 🎯 initState - Scheduling data load');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint(
        '[DriverEarningsScreen] 📊 Post-frame callback - Starting data load',
      );
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final userId = _authController.currentUser.value?.id;
    debugPrint('[DriverEarningsScreen] 👤 Loading data for userId: $userId');

    if (userId == null) {
      debugPrint('[DriverEarningsScreen] ❌ No userId found, aborting');
      return;
    }

    try {
      debugPrint('[DriverEarningsScreen] 📥 Loading driver earnings...');
      await _walletController.loadDriverEarnings(userId);
      debugPrint(
        '[DriverEarningsScreen] ✅ Earnings loaded - Total: ${_walletController.totalEarnings.value} MAD',
      );

      debugPrint('[DriverEarningsScreen] 💰 Loading wallet...');
      await _walletController.loadWallet(userId);
      debugPrint('[DriverEarningsScreen] ✅ Wallet loaded');
    } catch (e) {
      debugPrint('[DriverEarningsScreen] ❌ Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData,
          color: colors.primary,
          backgroundColor: colors.surface,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Custom App Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'driver.earnings.title'.tr,
                        style: AppTypography.headlineMedium(
                          context,
                        ).copyWith(color: colors.textPrimary),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Track your income',
                        style: AppTypography.bodySmall(
                          context,
                        ).copyWith(color: colors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),

              // Loading state
              Obx(() {
                if (_walletController.isLoading.value &&
                    _walletController.totalEarnings.value == 0) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: colors.primary),
                          SizedBox(height: 16.h),
                          Text(
                            'common.loading'.tr,
                            style: AppTypography.bodyMedium(
                              context,
                            ).copyWith(color: colors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildListDelegate([
                    // Hero Earnings Card
                    _HeroEarningsCard(colors: colors),

                    // Period Breakdown
                    _PeriodBreakdown(colors: colors),

                    // Commission Breakdown Card
                    _CommissionBreakdownCard(colors: colors),

                    // Stats Grid
                    _StatsGrid(colors: colors),

                    SizedBox(height: 8.h),

                    // Transaction History Section
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transaction History',
                            style: AppTypography.titleLarge(
                              context,
                            ).copyWith(color: colors.textPrimary),
                          ),
                          Icon(
                            Iconsax.receipt_text,
                            color: colors.textSecondary,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ]),
                );
              }),

              // Transaction List
              _TransactionList(colors: colors),

              // Bottom Padding
              SliverToBoxAdapter(
                child: SizedBox(height: 24.h),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Hero Earnings Card - Main focal point
class _HeroEarningsCard extends StatelessWidget {
  final AppColorScheme colors;

  const _HeroEarningsCard({required this.colors});

  @override
  Widget build(BuildContext context) {
    final WalletController walletController = Get.find<WalletController>();

    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        padding: EdgeInsets.all(28.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colors.success,
              colors.success.withValues(alpha: 0.85),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: colors.success.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Iconsax.wallet_money,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Total Earnings',
                        style: AppTypography.bodySmall(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Iconsax.chart_success,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Text(
              CurrencyHelper.format(walletController.totalEarnings.value),
              style: AppTypography.displayLarge(context).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 42.sp,
                height: 1.1,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Iconsax.driving,
                        color: Colors.white,
                        size: 14.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '${walletController.completedRides.value} rides',
                        style: AppTypography.bodySmall(context).copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Iconsax.verify,
                  color: Colors.white.withValues(alpha: 0.8),
                  size: 16.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Verified earnings',
                  style: AppTypography.bodySmall(context).copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Period Breakdown - Today, Week, Month
class _PeriodBreakdown extends StatelessWidget {
  final AppColorScheme colors;

  const _PeriodBreakdown({required this.colors});

  @override
  Widget build(BuildContext context) {
    final WalletController walletController = Get.find<WalletController>();

    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colors.border, width: 1),
          boxShadow: [
            BoxShadow(
              color: colors.textPrimary.withValues(alpha: 0.03),
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
                Icon(
                  Iconsax.calendar,
                  color: colors.primary,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Period Breakdown',
                  style: AppTypography.titleMedium(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: _PeriodCard(
                    colors: colors,
                    icon: Iconsax.sun_1,
                    label: 'Today',
                    amount: walletController.todayEarnings.value,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _PeriodCard(
                    colors: colors,
                    icon: Iconsax.calendar_2,
                    label: 'This Week',
                    amount: walletController.weekEarnings.value,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _PeriodCard(
                    colors: colors,
                    icon: Iconsax.calendar_1,
                    label: 'This Month',
                    amount: walletController.monthEarnings.value,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PeriodCard extends StatelessWidget {
  final AppColorScheme colors;
  final IconData icon;
  final String label;
  final double amount;

  const _PeriodCard({
    required this.colors,
    required this.icon,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colors.primarySoft,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: colors.primary,
            size: 24.sp,
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: AppTypography.bodySmall(context).copyWith(
              color: colors.textSecondary,
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '${amount.toStringAsFixed(2)}',
            style: AppTypography.titleMedium(context).copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),
          Text(
            CurrencyHelper.code,
            style: AppTypography.bodySmall(context).copyWith(
              color: colors.textSecondary,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}

// Stats Grid - Additional metrics
class _StatsGrid extends StatelessWidget {
  final AppColorScheme colors;

  const _StatsGrid({required this.colors});

  @override
  Widget build(BuildContext context) {
    final WalletController walletController = Get.find<WalletController>();

    return Obx(() {
      final avgPerTrip = walletController.completedRides.value > 0
          ? walletController.totalEarnings.value /
                walletController.completedRides.value
          : 0.0;

      final commissionRate = (walletController.commissionRate.value * 100)
          .toStringAsFixed(0);

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Row(
          children: [
            Expanded(
              child: _StatCard(
                colors: colors,
                icon: Iconsax.money_4,
                label: 'Avg per Ride',
                value: avgPerTrip.toStringAsFixed(2),
                unit: CurrencyHelper.code,
                accentColor: colors.info,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _StatCard(
                colors: colors,
                icon: Iconsax.percentage_circle,
                label: 'Commission',
                value: commissionRate,
                unit: '%',
                accentColor: colors.warning,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _StatCard extends StatelessWidget {
  final AppColorScheme colors;
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final Color accentColor;

  const _StatCard({
    required this.colors,
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: colors.textPrimary.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: accentColor,
              size: 20.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            label,
            style: AppTypography.bodySmall(context).copyWith(
              color: colors.textSecondary,
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: AppTypography.titleLarge(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 4.w),
              Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: Text(
                  unit,
                  style: AppTypography.bodySmall(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Transaction List with modern cards
class _TransactionList extends StatelessWidget {
  final AppColorScheme colors;

  const _TransactionList({required this.colors});

  @override
  Widget build(BuildContext context) {
    final WalletController walletController = Get.find<WalletController>();

    return Obx(() {
      final transactions = walletController.transactions;

      if (transactions.isEmpty) {
        return SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            padding: EdgeInsets.all(40.w),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: colors.border),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: colors.primarySoft,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.receipt_minus,
                    size: 48.sp,
                    color: colors.primary,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'No transactions yet',
                  style: AppTypography.titleMedium(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Your earnings history will appear here',
                  style: AppTypography.bodySmall(context).copyWith(
                    color: colors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }

      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final transaction = transactions[index];
            return _TransactionCard(
              colors: colors,
              transaction: transaction,
            );
          },
          childCount: transactions.length,
        ),
      );
    });
  }
}

class _TransactionCard extends StatelessWidget {
  final AppColorScheme colors;
  final Transaction transaction;

  const _TransactionCard({
    required this.colors,
    required this.transaction,
  });

  IconData _getTransactionIcon() {
    switch (transaction.type) {
      case TransactionType.payment:
        return Iconsax.wallet_check;
      case TransactionType.refund:
        return Iconsax.refresh_circle;
      case TransactionType.bonus:
        return Iconsax.gift;
      default:
        return Iconsax.wallet;
    }
  }

  Color _getStatusColor() {
    switch (transaction.status) {
      case TransactionStatus.completed:
        return colors.success;
      case TransactionStatus.failed:
        return colors.error;
      case TransactionStatus.pending:
        return colors.warning;
      default:
        return colors.textSecondary;
    }
  }

  String _getStatusLabel() {
    switch (transaction.status) {
      case TransactionStatus.completed:
        return 'Completed';
      case TransactionStatus.failed:
        return 'Failed';
      case TransactionStatus.pending:
        return 'Pending';
      default:
        return transaction.status.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('HH:mm');
    final statusColor = _getStatusColor();
    final isCompleted = transaction.status == TransactionStatus.completed;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isCompleted
              ? colors.success.withValues(alpha: 0.2)
              : colors.border,
          width: isCompleted ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.textPrimary.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            // Future: Navigate to transaction details
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Icon container
                Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colors.success,
                        colors.success.withValues(alpha: 0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: [
                      BoxShadow(
                        color: colors.success.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    _getTransactionIcon(),
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                // Transaction details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Request #${transaction.requestId}',
                              style: AppTypography.bodyLarge(context).copyWith(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              _getStatusLabel(),
                              style: AppTypography.bodySmall(context).copyWith(
                                color: statusColor,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(
                            Iconsax.calendar_1,
                            size: 12.sp,
                            color: colors.textSecondary,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            dateFormat.format(transaction.createdAt),
                            style: AppTypography.bodySmall(context).copyWith(
                              color: colors.textSecondary,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Icon(
                            Iconsax.clock,
                            size: 12.sp,
                            color: colors.textSecondary,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            timeFormat.format(transaction.createdAt),
                            style: AppTypography.bodySmall(context).copyWith(
                              color: colors.textSecondary,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: colors.warningSoft,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Iconsax.percentage_circle,
                              size: 12.sp,
                              color: colors.warning,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Commission: ${CurrencyHelper.formatWithSymbol(transaction.platformCommission, transaction.currencySymbol)}',
                              style: AppTypography.bodySmall(context).copyWith(
                                color: colors.warning,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                // Amount
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '+${transaction.driverEarnings.toStringAsFixed(2)}',
                      style: AppTypography.titleLarge(context).copyWith(
                        color: colors.success,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                    Text(
                      CurrencyHelper.code,
                      style: AppTypography.bodySmall(context).copyWith(
                        color: colors.textSecondary,
                        fontSize: 11.sp,
                      ),
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

// ═══════════════════════════════════════════════════════════════════════════
// COMMISSION BREAKDOWN CARD - Shows platform commission details
// ═══════════════════════════════════════════════════════════════════════════

class _CommissionBreakdownCard extends StatelessWidget {
  final AppColorScheme colors;

  const _CommissionBreakdownCard({required this.colors});

  @override
  Widget build(BuildContext context) {
    final WalletController walletController = Get.find<WalletController>();

    return Obx(() {
      final commission = walletController.platformCommission.value;
      final rate = walletController.commissionRate.value;
      final totalEarnings = walletController.totalEarnings.value;
      
      // Calculate gross earnings (total + commission)
      final grossEarnings = totalEarnings + commission;
      
      // For demo: assume pending if commission > 0, otherwise paid
      final isPending = commission > 0;

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colors.border, width: 1),
          boxShadow: [
            BoxShadow(
              color: colors.textPrimary.withValues(alpha: 0.03),
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
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: colors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Iconsax.percentage_circle,
                    color: colors.warning,
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'driver.earnings.platform_commission'.tr,
                        style: AppTypography.titleMedium(context).copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'driver.earnings.commission_info'.tr,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: colors.textMuted,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: (isPending ? colors.warning : colors.success).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: (isPending ? colors.warning : colors.success).withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(
                          color: isPending ? colors.warning : colors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        isPending 
                            ? 'driver.earnings.pending'.tr 
                            : 'driver.earnings.paid'.tr,
                        style: AppTypography.labelSmall(context).copyWith(
                          color: isPending ? colors.warning : colors.success,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 20.h),
            
            // Breakdown Lines
            _BreakdownLine(
              colors: colors,
              label: 'driver.earnings.gross_earnings'.tr,
              value: grossEarnings,
              icon: Iconsax.money_4,
              valueColor: colors.textPrimary,
            ),
            
            SizedBox(height: 12.h),
            
            _BreakdownLine(
              colors: colors,
              label: 'driver.earnings.commission_fee'.tr,
              value: commission,
              icon: Iconsax.minus_cirlce,
              valueColor: colors.error,
              isNegative: true,
              subtitle: 'driver.earnings.commission_rate'.tr + ' ${(rate * 100).toStringAsFixed(0)}%',
            ),
            
            SizedBox(height: 12.h),
            
            // Divider
            Container(
              height: 1,
              color: colors.border,
              margin: EdgeInsets.symmetric(vertical: 12.h),
            ),
            
            // Net Earnings
            _BreakdownLine(
              colors: colors,
              label: 'driver.earnings.net_earnings'.tr,
              value: totalEarnings,
              icon: Iconsax.wallet_money,
              valueColor: colors.success,
              isHighlighted: true,
            ),
          ],
        ),
      );
    });
  }
}

// Breakdown Line Widget
class _BreakdownLine extends StatelessWidget {
  final AppColorScheme colors;
  final String label;
  final double value;
  final IconData icon;
  final Color valueColor;
  final bool isNegative;
  final bool isHighlighted;
  final String? subtitle;

  const _BreakdownLine({
    required this.colors,
    required this.label,
    required this.value,
    required this.icon,
    required this.valueColor,
    this.isNegative = false,
    this.isHighlighted = false,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isHighlighted 
          ? EdgeInsets.all(12.w) 
          : EdgeInsets.symmetric(vertical: 8.h),
      decoration: isHighlighted
          ? BoxDecoration(
              color: colors.success.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: colors.success.withOpacity(0.2),
              ),
            )
          : null,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: valueColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: valueColor,
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: isHighlighted ? colors.textPrimary : colors.textSecondary,
                    fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    subtitle!,
                    style: AppTypography.labelSmall(context).copyWith(
                      color: colors.textMuted,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Text(
            '${isNegative ? "-" : ""}${CurrencyHelper.format(value)}',
            style: AppTypography.titleMedium(context).copyWith(
              color: valueColor,
              fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w600,
              fontSize: isHighlighted ? 18.sp : 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
