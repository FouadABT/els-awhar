import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:intl/intl.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/controllers/auth_controller.dart';
import '../core/controllers/wallet_controller.dart';
import '../core/utils/currency_helper.dart';

/// Client transaction history screen
class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final WalletController _walletController = Get.find<WalletController>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userId = _authController.currentUser.value?.id;
    if (userId == null) return;

    await _walletController.loadTransactionHistory(userId);
    await _walletController.loadWallet(userId);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Transaction History',
          style: AppTypography.titleLarge(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: Obx(() {
          if (_walletController.isLoading.value && _walletController.transactions.isEmpty) {
            return Center(
              child: CircularProgressIndicator(color: colors.primary),
            );
          }

          return CustomScrollView(
            slivers: [
              // Spending summary card
              SliverToBoxAdapter(
                child: _SpendingSummaryCard(colors: colors),
              ),

              // Transaction list
              _buildTransactionList(colors),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTransactionList(AppColorScheme colors) {
    final transactions = _walletController.transactions;

    if (transactions.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.empty_wallet, size: 64.sp, color: colors.textSecondary),
              SizedBox(height: 16.h),
              Text(
                'No transactions yet',
                style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
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
  }
}

class _SpendingSummaryCard extends StatelessWidget {
  final AppColorScheme colors;

  const _SpendingSummaryCard({required this.colors});

  @override
  Widget build(BuildContext context) {
    final WalletController walletController = Get.find<WalletController>();

    return Obx(() => Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary, colors.primary.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Spent',
                style: AppTypography.bodyMedium(context).copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
              Icon(Iconsax.wallet, color: Colors.white, size: 28.sp),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            CurrencyHelper.format(walletController.wallet.value?.totalSpent ?? 0),
            style: AppTypography.headlineLarge(context).copyWith(
              color: Colors.white,
              fontSize: 36.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '${walletController.wallet.value?.totalTransactions ?? 0} transactions',
            style: AppTypography.bodySmall(context).copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    ));
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
        return Iconsax.wallet_money;
      case TransactionType.refund:
        return Iconsax.refresh;
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

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  _getTransactionIcon(),
                  color: colors.primary,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service Request #${transaction.requestId}',
                      style: AppTypography.bodyLarge(context).copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      dateFormat.format(transaction.createdAt),
                      style: AppTypography.bodySmall(context).copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                CurrencyHelper.format(transaction.amount),
                style: AppTypography.titleMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.wallet_check,
                    size: 14.sp,
                    color: colors.textSecondary,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    transaction.paymentMethod,
                    style: AppTypography.bodySmall(context).copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getStatusColor().withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  transaction.status.name,
                  style: AppTypography.bodySmall(context).copyWith(
                    color: _getStatusColor(),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
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
