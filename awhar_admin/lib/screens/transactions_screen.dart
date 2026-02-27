import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:intl/intl.dart';
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';
import '../core/utils/currency_helper.dart';
import '../controllers/transactions_controller.dart';

/// Transactions management screen
class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionsController());

    return DashboardLayout(
      title: 'Transactions',
      actions: [
        Obx(() => OutlinedButton.icon(
              onPressed: controller.transactions.isEmpty
                  ? null
                  : controller.exportTransactions,
              icon: const Icon(Icons.file_download_outlined, size: 18),
              label: const Text('Export CSV'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AdminColors.primary),
                foregroundColor: AdminColors.primary,
              ),
            )),
        const SizedBox(width: 12),
        Obx(() => ElevatedButton.icon(
              onPressed: controller.isLoading.value ? null : controller.refresh,
              icon: controller.isLoading.value
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.refresh, size: 18),
              label: const Text('Refresh'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AdminColors.primary,
                foregroundColor: Colors.white,
              ),
            )),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsRow(controller),
          const SizedBox(height: 24),
          _buildFiltersRow(controller),
          const SizedBox(height: 24),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value &&
                  controller.transactions.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.value.isNotEmpty &&
                  controller.transactions.isEmpty) {
                return _buildErrorState(controller);
              }

              if (controller.transactions.isEmpty) {
                return _buildEmptyState();
              }

              return _buildTransactionsTable(controller);
            }),
          ),
          const SizedBox(height: 16),
          _buildPagination(controller),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AdminColors.surfaceElevatedLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AdminColors.borderSoftLight),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AdminColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(TransactionsController controller) {
    return Obx(() => Row(
          children: [
            _buildStatCard(
                'Total Volume',
                CurrencyHelper.format(controller.totalAmount),
                Icons.account_balance_wallet,
                AdminColors.info),
            const SizedBox(width: 16),
            _buildStatCard('Transactions', '${controller.totalCount.value}',
                Icons.receipt_long, AdminColors.success),
            const SizedBox(width: 16),
            _buildStatCard(
                'Commission Earned',
                CurrencyHelper.format(controller.totalCommission),
                Icons.monetization_on,
                AdminColors.primary),
            const SizedBox(width: 16),
            _buildStatCard('Completed', '${controller.completedCount}',
                Icons.check_circle, AdminColors.warning),
          ],
        ));
  }

  Widget _buildFiltersRow(TransactionsController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderSoftLight),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              onChanged: (value) => controller.searchQuery.value = value,
              decoration: InputDecoration(
                hintText: 'Search by description, user ID, or amount...',
                prefixIcon: const Icon(Icons.search, size: 20),
                filled: true,
                fillColor: AdminColors.backgroundLight,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Obx(() => Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('All'),
                    selected: controller.statusFilter.value == null,
                    onSelected: (_) => controller.setStatusFilter(null),
                  ),
                  ChoiceChip(
                    label: const Text('Pending'),
                    selected: controller.statusFilter.value ==
                        TransactionStatus.pending,
                    onSelected: (_) =>
                        controller.setStatusFilter(TransactionStatus.pending),
                  ),
                  ChoiceChip(
                    label: const Text('Completed'),
                    selected: controller.statusFilter.value ==
                        TransactionStatus.completed,
                    onSelected: (_) =>
                        controller.setStatusFilter(TransactionStatus.completed),
                  ),
                  ChoiceChip(
                    label: const Text('Failed'),
                    selected: controller.statusFilter.value ==
                        TransactionStatus.failed,
                    onSelected: (_) =>
                        controller.setStatusFilter(TransactionStatus.failed),
                  ),
                  ChoiceChip(
                    label: const Text('Refunded'),
                    selected: controller.statusFilter.value ==
                        TransactionStatus.refunded,
                    onSelected: (_) =>
                        controller.setStatusFilter(TransactionStatus.refunded),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildTransactionsTable(TransactionsController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderLight),
      ),
      child: Obx(() => SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Table(
                columnWidths: const {
                  0: FixedColumnWidth(100), // Transaction ID
                  1: FixedColumnWidth(100), // Type
                  2: FixedColumnWidth(100), // User ID
                  3: FixedColumnWidth(250), // Description
                  4: FixedColumnWidth(110), // Amount
                  5: FixedColumnWidth(110), // Commission
                  6: FixedColumnWidth(110), // Driver Earnings
                  7: FixedColumnWidth(120), // Payment Method
                  8: FixedColumnWidth(120), // Status
                  9: FixedColumnWidth(130), // Date
                  10: FixedColumnWidth(150), // Actions
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder(
                  horizontalInside:
                      BorderSide(color: AdminColors.borderLight, width: 1),
                ),
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: AdminColors.backgroundLight,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    children: [
                      _buildTableHeader('TXN ID'),
                      _buildTableHeader('Type'),
                      _buildTableHeader('User ID'),
                      _buildTableHeader('Description'),
                      _buildTableHeader('Amount'),
                      _buildTableHeader('Commission'),
                      _buildTableHeader('Driver Earned'),
                      _buildTableHeader('Payment'),
                      _buildTableHeader('Status'),
                      _buildTableHeader('Date'),
                      _buildTableHeader('Actions'),
                    ],
                  ),
                  ...controller.filteredTransactions.map((transaction) {
                    return TableRow(
                      children: [
                        _buildTableCell('#TXN${transaction.id ?? 0}'),
                        _buildTypeBadge(transaction.type),
                        _buildTableCell('User #${transaction.userId}'),
                        _buildDescriptionCell(transaction.description ?? ''),
                        _buildAmountCell(transaction.amount,
                            currencySymbol: transaction.currencySymbol),
                        _buildAmountCell(transaction.platformCommission,
                            color: AdminColors.primary,
                            currencySymbol: transaction.currencySymbol),
                        _buildAmountCell(transaction.driverEarnings,
                            color: AdminColors.success,
                            currencySymbol: transaction.currencySymbol),
                        _buildPaymentMethodBadge(transaction.paymentMethod),
                        _buildStatusBadge(transaction.status),
                        _buildTableCell(DateFormat('dd/MM/yyyy')
                            .format(transaction.createdAt)),
                        _buildActionButtons(controller, transaction),
                      ],
                    );
                  }),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AdminColors.textPrimaryLight,
        ),
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 13,
          color: AdminColors.textSecondaryLight,
        ),
      ),
    );
  }

  Widget _buildDescriptionCell(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Text(
        description,
        style: GoogleFonts.inter(
          fontSize: 12,
          color: AdminColors.textSecondaryLight,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildAmountCell(double amount,
      {Color? color, String? currencySymbol}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Text(
        CurrencyHelper.formatWithSymbol(
            amount, currencySymbol ?? CurrencyHelper.defaultSymbol),
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: color ?? AdminColors.textPrimaryLight,
        ),
      ),
    );
  }

  Widget _buildTypeBadge(TransactionType type) {
    final typeColors = {
      TransactionType.payment: AdminColors.error,
      TransactionType.earning: AdminColors.success,
      TransactionType.refund: AdminColors.warning,
      TransactionType.commission: AdminColors.primary,
    };

    final typeIcons = {
      TransactionType.payment: Icons.arrow_upward,
      TransactionType.earning: Icons.arrow_downward,
      TransactionType.refund: Icons.refresh,
      TransactionType.commission: Icons.percent,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: typeColors[type]!.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: typeColors[type]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(typeIcons[type], size: 12, color: typeColors[type]),
            const SizedBox(width: 4),
            Text(
              type.name.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: typeColors[type],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodBadge(String? paymentMethod) {
    if (paymentMethod == null || paymentMethod.isEmpty) {
      return _buildTableCell('—');
    }

    final methodColors = {
      'cash': AdminColors.success,
      'card': AdminColors.primary,
      'wallet': AdminColors.info,
    };

    final methodIcons = {
      'cash': Icons.money,
      'card': Icons.credit_card,
      'wallet': Icons.account_balance_wallet,
    };

    final color =
        methodColors[paymentMethod.toLowerCase()] ?? AdminColors.textMutedLight;
    final icon = methodIcons[paymentMethod.toLowerCase()] ?? Icons.payment;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
            Text(
              paymentMethod.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(TransactionStatus status) {
    final statusColors = {
      TransactionStatus.pending: AdminColors.warning,
      TransactionStatus.completed: AdminColors.success,
      TransactionStatus.failed: AdminColors.error,
      TransactionStatus.refunded: AdminColors.textMutedLight,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: statusColors[status]!.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: statusColors[status]!),
        ),
        child: Text(
          status.name.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: statusColors[status],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(
      TransactionsController controller, Transaction transaction) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.visibility_outlined, size: 18),
            tooltip: 'View Details',
            onPressed: () => _showTransactionDetails(transaction),
            color: AdminColors.primary,
            style: IconButton.styleFrom(
              backgroundColor: AdminColors.primary.withValues(alpha: 0.1),
              minimumSize: const Size(32, 32),
              padding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(width: 8),
          if (transaction.status == TransactionStatus.completed)
            IconButton(
              icon: const Icon(Icons.receipt_outlined, size: 18),
              tooltip: 'View Receipt',
              onPressed: () => _showReceipt(transaction),
              color: AdminColors.success,
              style: IconButton.styleFrom(
                backgroundColor: AdminColors.success.withValues(alpha: 0.1),
                minimumSize: const Size(32, 32),
                padding: EdgeInsets.zero,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64,
            color: AdminColors.textSecondaryLight.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No transactions found',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AdminColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Transactions will appear here as users make payments',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AdminColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(TransactionsController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: AdminColors.error.withValues(alpha: 0.7),
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading transactions',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AdminColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            controller.errorMessage.value,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AdminColors.textSecondaryLight,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: controller.refresh,
            icon: const Icon(Icons.refresh, size: 20),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AdminColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(TransactionsController controller) {
    return Obx(() {
      if (controller.transactions.isEmpty) return const SizedBox.shrink();

      final totalPages =
          (controller.totalCount.value / controller.pageSize.value).ceil();

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AdminColors.borderLight),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Showing ${controller.transactions.length} of ${controller.totalCount.value} transactions',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AdminColors.textSecondaryLight,
              ),
            ),
            Row(
              children: [
                TextButton.icon(
                  onPressed: controller.currentPage.value > 1
                      ? () =>
                          controller.goToPage(controller.currentPage.value - 1)
                      : null,
                  icon: const Icon(Icons.chevron_left, size: 20),
                  label: const Text('Previous'),
                ),
                const SizedBox(width: 16),
                Text(
                  'Page ${controller.currentPage.value} of $totalPages',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: controller.currentPage.value < totalPages
                      ? () =>
                          controller.goToPage(controller.currentPage.value + 1)
                      : null,
                  child: Row(
                    children: const [
                      Text('Next'),
                      SizedBox(width: 4),
                      Icon(Icons.chevron_right, size: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  void _showTransactionDetails(Transaction transaction) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 700,
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transaction Details',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AdminColors.textPrimaryLight,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Divider(height: 24),
                _buildDetailRow('Transaction ID', '#TXN${transaction.id ?? 0}'),
                _buildDetailRow('Type', transaction.type.name.toUpperCase()),
                _buildDetailRow(
                    'Status', transaction.status.name.toUpperCase()),
                _buildDetailRow('User ID', 'User #${transaction.userId}'),
                if (transaction.requestId != null)
                  _buildDetailRow(
                      'Request ID', 'Request #${transaction.requestId}'),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  'Financial Details',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                    'Amount',
                    CurrencyHelper.formatWithSymbol(
                        transaction.amount, transaction.currencySymbol)),
                _buildDetailRow(
                    'Platform Commission',
                    CurrencyHelper.formatWithSymbol(
                        transaction.platformCommission,
                        transaction.currencySymbol)),
                _buildDetailRow(
                    'Driver Earnings',
                    CurrencyHelper.formatWithSymbol(transaction.driverEarnings,
                        transaction.currencySymbol)),
                _buildDetailRow('Currency',
                    '${transaction.currency} (${transaction.currencySymbol})'),
                _buildDetailRow('Payment Method', transaction.paymentMethod),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                if (transaction.description != null &&
                    transaction.description!.isNotEmpty) ...[
                  Text(
                    'Description',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AdminColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    transaction.description!,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AdminColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (transaction.notes != null &&
                    transaction.notes!.isNotEmpty) ...[
                  Text(
                    'Notes',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AdminColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    transaction.notes!,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AdminColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (transaction.driverConfirmed ||
                    transaction.clientConfirmed) ...[
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    'Confirmation Status',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AdminColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: transaction.driverConfirmed
                                ? AdminColors.success.withValues(alpha: 0.1)
                                : AdminColors.textMutedLight
                                    .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: transaction.driverConfirmed
                                  ? AdminColors.success
                                  : AdminColors.textMutedLight,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                transaction.driverConfirmed
                                    ? Icons.check_circle
                                    : Icons.pending,
                                color: transaction.driverConfirmed
                                    ? AdminColors.success
                                    : AdminColors.textMutedLight,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Driver',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (transaction.driverConfirmedAt != null)
                                Text(
                                  DateFormat('dd/MM HH:mm')
                                      .format(transaction.driverConfirmedAt!),
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    color: AdminColors.textSecondaryLight,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: transaction.clientConfirmed
                                ? AdminColors.success.withValues(alpha: 0.1)
                                : AdminColors.textMutedLight
                                    .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: transaction.clientConfirmed
                                  ? AdminColors.success
                                  : AdminColors.textMutedLight,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                transaction.clientConfirmed
                                    ? Icons.check_circle
                                    : Icons.pending,
                                color: transaction.clientConfirmed
                                    ? AdminColors.success
                                    : AdminColors.textMutedLight,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Client',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (transaction.clientConfirmedAt != null)
                                Text(
                                  DateFormat('dd/MM HH:mm')
                                      .format(transaction.clientConfirmedAt!),
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    color: AdminColors.textSecondaryLight,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                const Divider(),
                const SizedBox(height: 16),
                _buildDetailRow(
                    'Created',
                    DateFormat('MMM dd, yyyy HH:mm')
                        .format(transaction.createdAt)),
                if (transaction.completedAt != null)
                  _buildDetailRow(
                      'Completed',
                      DateFormat('MMM dd, yyyy HH:mm')
                          .format(transaction.completedAt!)),
                if (transaction.refundedAt != null)
                  _buildDetailRow(
                      'Refunded',
                      DateFormat('MMM dd, yyyy HH:mm')
                          .format(transaction.refundedAt!)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AdminColors.textSecondaryLight,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AdminColors.textPrimaryLight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showReceipt(Transaction transaction) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.receipt_long,
                size: 48,
                color: AdminColors.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Transaction Receipt',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AdminColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '#TXN${transaction.id ?? 0}',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AdminColors.textSecondaryLight,
                ),
              ),
              const Divider(height: 32),
              _buildReceiptRow(
                  'Amount',
                  CurrencyHelper.formatWithSymbol(
                      transaction.amount, transaction.currencySymbol)),
              _buildReceiptRow('Commission',
                  '-${CurrencyHelper.formatWithSymbol(transaction.platformCommission, transaction.currencySymbol)}'),
              _buildReceiptRow(
                  'Driver Earnings',
                  CurrencyHelper.formatWithSymbol(
                      transaction.driverEarnings, transaction.currencySymbol)),
              const Divider(height: 24),
              _buildReceiptRow('Payment Method', transaction.paymentMethod),
              _buildReceiptRow(
                  'Date',
                  DateFormat('MMM dd, yyyy HH:mm')
                      .format(transaction.createdAt)),
              _buildReceiptRow('Status', transaction.status.name.toUpperCase()),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close),
                label: const Text('Close'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AdminColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 44),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AdminColors.textSecondaryLight,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AdminColors.textPrimaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
