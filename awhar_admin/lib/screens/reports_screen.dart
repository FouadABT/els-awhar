import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:intl/intl.dart';
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';
import '../controllers/reports_controller.dart';

/// Reports management screen
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportsController());
    
    return DashboardLayout(
      title: 'Reports & Issues',
      actions: [
        Obx(() => OutlinedButton.icon(
          onPressed: controller.reports.isEmpty ? null : controller.exportReports,
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
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
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
              if (controller.isLoading.value && controller.reports.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (controller.errorMessage.value.isNotEmpty && controller.reports.isEmpty) {
                return _buildErrorState(controller);
              }
              
              if (controller.reports.isEmpty) {
                return _buildEmptyState();
              }
              
              return _buildReportsTable(controller);
            }),
          ),
          
          const SizedBox(height: 16),
          _buildPagination(controller),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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

  Widget _buildStatsRow(ReportsController controller) {
    return Obx(() => Row(
      children: [
        _buildStatCard('Total Reports', '${controller.totalCount.value}', Icons.flag, AdminColors.info),
        const SizedBox(width: 16),
        _buildStatCard('Pending', '${controller.pendingCount}', Icons.pending, AdminColors.warning),
        const SizedBox(width: 16),
        _buildStatCard('Resolved', '${controller.resolvedCount}', Icons.check_circle, AdminColors.success),
        const SizedBox(width: 16),
        _buildStatCard('Dismissed', '${controller.dismissedCount}', Icons.cancel, AdminColors.error),
      ],
    ));
  }

  Widget _buildFiltersRow(ReportsController controller) {
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
                hintText: 'Search reports...',
                prefixIcon: const Icon(Icons.search, size: 20),
                filled: true,
                fillColor: AdminColors.backgroundLight,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                selected: controller.statusFilter.value == ReportStatus.pending,
                onSelected: (_) => controller.setStatusFilter(ReportStatus.pending),
              ),
              ChoiceChip(
                label: const Text('Resolved'),
                selected: controller.statusFilter.value == ReportStatus.resolved,
                onSelected: (_) => controller.setStatusFilter(ReportStatus.resolved),
              ),
              ChoiceChip(
                label: const Text('Dismissed'),
                selected: controller.statusFilter.value == ReportStatus.dismissed,
                onSelected: (_) => controller.setStatusFilter(ReportStatus.dismissed),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildReportsTable(ReportsController controller) {
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
              0: FixedColumnWidth(100),
              1: FixedColumnWidth(120),
              2: FixedColumnWidth(120),
              3: FixedColumnWidth(150),
              4: FixedColumnWidth(120),
              5: FixedColumnWidth(120),
              6: FixedColumnWidth(150),
              7: FixedColumnWidth(200),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder(
              horizontalInside: BorderSide(color: AdminColors.borderLight, width: 1),
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
                  _buildTableHeader('Report ID'),
                  _buildTableHeader('Reporter'),
                  _buildTableHeader('Reported'),
                  _buildTableHeader('Reason'),
                  _buildTableHeader('Status'),
                  _buildTableHeader('Resolution'),
                  _buildTableHeader('Date'),
                  _buildTableHeader('Actions'),
                ],
              ),
              ...controller.reports.map((report) {
                final reportedEntity = _getReportedEntity(report);
                return TableRow(
                  children: [
                    _buildTableCell('#${report.id}'),
                    _buildTableCell('User #${report.reportedByUserId}'),
                    _buildTableCell(reportedEntity),
                    _buildTableCell(_formatReason(report.reportReason)),
                    _buildStatusBadge(report.status ?? ReportStatus.pending),
                    _buildResolutionBadge(report.resolution),
                    _buildTableCell(DateFormat('dd/MM/yyyy').format(report.createdAt)),
                    _buildActionButtons(controller, report),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 13,
          color: AdminColors.textSecondaryLight,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(ReportStatus status) {
    final statusColors = {
      ReportStatus.pending: AdminColors.warning,
      ReportStatus.under_review: AdminColors.info,
      ReportStatus.resolved: AdminColors.success,
      ReportStatus.dismissed: AdminColors.textMutedLight,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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

  Widget _buildResolutionBadge(ReportResolution? resolution) {
    if (resolution == null) {
      return _buildTableCell('—');
    }

    final resolutionColors = {
      ReportResolution.pending: AdminColors.info,
      ReportResolution.warning: AdminColors.warning,
      ReportResolution.suspension: Colors.orange.shade700,
      ReportResolution.ban: AdminColors.error,
      ReportResolution.dismissed: AdminColors.textMutedLight,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: resolutionColors[resolution]!.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: resolutionColors[resolution]!),
        ),
        child: Text(
          resolution.name.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: resolutionColors[resolution],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(ReportsController controller, Report report) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.visibility_outlined, size: 18),
            tooltip: 'View Details',
            onPressed: () => _showReportDetails(report),
            color: AdminColors.primary,
            style: IconButton.styleFrom(
              backgroundColor: AdminColors.primary.withValues(alpha: 0.1),
              minimumSize: const Size(32, 32),
              padding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(width: 8),
          if (report.status == ReportStatus.pending || report.status == ReportStatus.under_review)
            IconButton(
              icon: const Icon(Icons.check_circle_outline, size: 18),
              tooltip: 'Resolve',
              onPressed: () => _showResolveDialog(report, controller),
              color: AdminColors.success,
              style: IconButton.styleFrom(
                backgroundColor: AdminColors.success.withValues(alpha: 0.1),
                minimumSize: const Size(32, 32),
                padding: EdgeInsets.zero,
              ),
            ),
          const SizedBox(width: 8),
          if (report.status == ReportStatus.pending || report.status == ReportStatus.under_review)
            IconButton(
              icon: const Icon(Icons.cancel_outlined, size: 18),
              tooltip: 'Dismiss',
              onPressed: () => _showDismissDialog(report, controller),
              color: AdminColors.textMutedLight,
              style: IconButton.styleFrom(
                backgroundColor: AdminColors.textMutedLight.withValues(alpha: 0.1),
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
            Icons.flag_outlined,
            size: 64,
            color: AdminColors.textSecondaryLight.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No reports found',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AdminColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Reports will appear here when users submit them',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AdminColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(ReportsController controller) {
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
            'Error loading reports',
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

  Widget _buildPagination(ReportsController controller) {
    return Obx(() {
      if (controller.reports.isEmpty) return const SizedBox.shrink();
      
      final totalPages = (controller.totalCount.value / controller.pageSize.value).ceil();
      
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
              'Showing ${controller.reports.length} of ${controller.totalCount.value} reports',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AdminColors.textSecondaryLight,
              ),
            ),
            Row(
              children: [
                TextButton.icon(
                  onPressed: controller.currentPage.value > 1 
                      ? () => controller.goToPage(controller.currentPage.value - 1)
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
                      ? () => controller.goToPage(controller.currentPage.value + 1)
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

  String _formatReason(ReportReason? reason) {
    if (reason == null) return 'Other';
    return reason.name.replaceAll('_', ' ').toUpperCase();
  }

  String _getReportedEntity(Report report) {
    if (report.reportedDriverId != null) return 'Driver #${report.reportedDriverId}';
    if (report.reportedClientId != null) return 'Client #${report.reportedClientId}';
    if (report.reportedStoreId != null) return 'Store #${report.reportedStoreId}';
    if (report.reportedOrderId != null) return 'Order #${report.reportedOrderId}';
    return 'N/A';
  }

  void _showReportDetails(Report report) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Report Details',
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
              _buildDetailRow('Report ID', '#${report.id}'),
              _buildDetailRow('Reporter', 'User #${report.reportedByUserId}'),
              _buildDetailRow('Reported Entity', _getReportedEntity(report)),
              _buildDetailRow('Reason', _formatReason(report.reportReason)),
              _buildDetailRow('Status', (report.status ?? ReportStatus.pending).name.toUpperCase()),
              if (report.resolution != null)
                _buildDetailRow('Resolution', report.resolution!.name.toUpperCase()),
              if (report.description.isNotEmpty)
                _buildDetailRow('Description', report.description),
              if (report.adminNotes != null && report.adminNotes!.isNotEmpty)
                _buildDetailRow('Admin Notes', report.adminNotes!),
              _buildDetailRow('Created', DateFormat('MMM dd, yyyy HH:mm').format(report.createdAt)),
              if (report.resolvedAt != null)
                _buildDetailRow('Resolved', DateFormat('MMM dd, yyyy HH:mm').format(report.resolvedAt!)),
            ],
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
            width: 140,
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
  
  void _showResolveDialog(Report report, ReportsController controller) {
    Get.dialog(
      AlertDialog(
        title: const Text('Resolve Report'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Report #${report.id}'),
            const SizedBox(height: 16),
            const Text('Select resolution action:'),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.info_outline, color: AdminColors.info),
              title: const Text('Pending Review'),
              subtitle: const Text('Keep report in pending status'),
              onTap: () {
                Get.back();
                controller.resolveReport(report.id!, ReportResolution.pending, notes: 'Reviewed - keeping pending');
              },
            ),
            ListTile(
              leading: const Icon(Icons.warning, color: AdminColors.warning),
              title: const Text('Warning'),
              subtitle: const Text('Issue a warning to the user'),
              onTap: () {
                Get.back();
                controller.resolveReport(report.id!, ReportResolution.warning, notes: 'Warning issued to user');
              },
            ),
            ListTile(
              leading: Icon(Icons.block, color: Colors.orange.shade700),
              title: const Text('Suspension'),
              subtitle: const Text('Temporarily suspend the user'),
              onTap: () {
                Get.back();
                controller.resolveReport(report.id!, ReportResolution.suspension, notes: 'User suspended');
              },
            ),
            ListTile(
              leading: const Icon(Icons.gavel, color: AdminColors.error),
              title: const Text('Ban'),
              subtitle: const Text('Permanently ban the user'),
              onTap: () {
                Get.back();
                controller.resolveReport(report.id!, ReportResolution.ban, notes: 'User banned');
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showDismissDialog(Report report, ReportsController controller) {
    final reasonController = TextEditingController();
    
    Get.dialog(
      AlertDialog(
        title: const Text('Dismiss Report'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Report #${report.id}'),
            const SizedBox(height: 16),
            const Text('Provide a reason for dismissing this report:'),
            const SizedBox(height: 12),
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter reason...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: AdminColors.backgroundLight,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final reason = reasonController.text.trim();
              if (reason.isNotEmpty) {
                Get.back();
                controller.dismissReport(report.id!, reason: reason);
              } else {
                Get.snackbar('Error', 'Please provide a reason');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AdminColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Dismiss'),
          ),
        ],
      ),
    );
  }
}

