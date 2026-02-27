import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:intl/intl.dart';
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';
import '../core/utils/currency_helper.dart';
import '../controllers/requests_controller.dart';

/// Service requests management screen
class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestsController());

    return DashboardLayout(
      title: 'Service Requests',
      actions: [
        Obx(() => OutlinedButton.icon(
              onPressed: controller.requests.isEmpty
                  ? null
                  : controller.exportRequests,
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
          _buildStatisticsCards(controller),
          const SizedBox(height: 24),
          _buildStatusDistribution(controller),
          const SizedBox(height: 24),
          _buildFiltersRow(controller),
          const SizedBox(height: 24),
          // Debug info
          Obx(() => Text(
                'DEBUG: Total requests: ${controller.requests.length}, Filtered: ${controller.filteredRequests.length}, Error: ${controller.errorMessage.value}',
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              )),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.requests.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.value.isNotEmpty &&
                  controller.requests.isEmpty) {
                return _buildErrorState(controller);
              }

              if (controller.requests.isEmpty) {
                return _buildEmptyState();
              }

              if (controller.filteredRequests.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.filter_alt_off,
                          size: 48, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('No requests match your filters'),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: controller.clearFilters,
                        child: const Text('Clear Filters'),
                      ),
                    ],
                  ),
                );
              }

              return _buildRequestsTable(controller);
            }),
          ),
          const SizedBox(height: 16),
          _buildPagination(controller),
        ],
      ),
    );
  }

  Widget _buildStatisticsCards(RequestsController controller) {
    return Obx(() => Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Total Requests',
                controller.totalCount.value.toString(),
                Icons.assignment,
                AdminColors.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Pending',
                controller.pendingCount.value.toString(),
                Icons.pending,
                AdminColors.warning,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Active',
                controller.activeCount.value.toString(),
                Icons.local_shipping,
                AdminColors.info,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Completed',
                controller.completedCount.value.toString(),
                Icons.check_circle,
                AdminColors.success,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Cancelled',
                controller.cancelledCount.value.toString(),
                Icons.cancel,
                AdminColors.error,
              ),
            ),
          ],
        ));
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AdminColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDistribution(RequestsController controller) {
    return Obx(() {
      if (controller.requests.isEmpty) return const SizedBox.shrink();

      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AdminColors.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status Distribution',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AdminColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: RequestStatus.values.map((status) {
                final count =
                    controller.requests.where((r) => r.status == status).length;
                if (count == 0) return const SizedBox.shrink();

                return Chip(
                  avatar: CircleAvatar(
                    backgroundColor:
                        _statusColors[status]!.withValues(alpha: 0.2),
                    child: Text(
                      count.toString(),
                      style: TextStyle(
                        color: _statusColors[status],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  label: Text(
                    _getStatusLabel(status),
                    style: GoogleFonts.inter(fontSize: 13),
                  ),
                  backgroundColor:
                      _statusColors[status]!.withValues(alpha: 0.1),
                  side: BorderSide(color: _statusColors[status]!, width: 1),
                );
              }).toList(),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildFiltersRow(RequestsController controller) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            controller: controller.searchController,
            onChanged: (value) => controller.searchQuery.value = value,
            decoration: InputDecoration(
              hintText: 'Search by client name, ID, or service...',
              prefixIcon: const Icon(Icons.search, size: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AdminColors.borderLight),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AdminColors.borderLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AdminColors.primary, width: 2),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Obx(() => DropdownButtonFormField<String>(
                value: controller.selectedStatus.value,
                decoration: InputDecoration(
                  labelText: 'Status Filter',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                items: [
                  const DropdownMenuItem(
                      value: 'All Status', child: Text('All Statuses')),
                  ...RequestStatus.values.map((status) => DropdownMenuItem(
                        value: _getStatusLabel(status),
                        child: Text(_getStatusLabel(status)),
                      )),
                ],
                onChanged: (value) =>
                    controller.selectedStatus.value = value ?? 'All Status',
              )),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Obx(() => DropdownButtonFormField<ServiceType?>(
                value: controller.selectedServiceType.value,
                decoration: InputDecoration(
                  labelText: 'Service Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                items: [
                  const DropdownMenuItem(
                      value: null, child: Text('All Services')),
                  ...ServiceType.values.map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(_getServiceTypeLabel(type)),
                      )),
                ],
                onChanged: (value) =>
                    controller.selectedServiceType.value = value,
              )),
        ),
      ],
    );
  }

  Widget _buildRequestsTable(RequestsController controller) {
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
                  0: FixedColumnWidth(80),
                  1: FixedColumnWidth(150),
                  2: FixedColumnWidth(120),
                  3: FixedColumnWidth(150),
                  4: FixedColumnWidth(120),
                  5: FixedColumnWidth(150),
                  6: FixedColumnWidth(150),
                  7: FixedColumnWidth(180),
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
                      _buildTableHeader('ID'),
                      _buildTableHeader('Client'),
                      _buildTableHeader('Service'),
                      _buildTableHeader('Driver'),
                      _buildTableHeader('Amount'),
                      _buildTableHeader('Status'),
                      _buildTableHeader('Created'),
                      _buildTableHeader('Actions'),
                    ],
                  ),
                  ...controller.filteredRequests.map((request) {
                    return TableRow(
                      children: [
                        _buildTableCell('#${request.id}'),
                        _buildTableCell(request.clientName),
                        _buildTableCell(
                            _getServiceTypeLabel(request.serviceType)),
                        _buildTableCell(request.driverName ?? 'Not Assigned'),
                        _buildTableCell(CurrencyHelper.formatWithSymbol(
                            request.agreedPrice ?? 0, request.currencySymbol)),
                        _buildStatusBadge(request.status),
                        _buildTableCell(DateFormat('dd/MM/yyyy HH:mm')
                            .format(request.createdAt)),
                        _buildActionButtons(controller, request),
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

  Widget _buildStatusBadge(RequestStatus status) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _statusColors[status]!.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _statusColors[status]!),
        ),
        child: Text(
          _getStatusLabel(status),
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _statusColors[status],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(
      RequestsController controller, ServiceRequest request) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.visibility_outlined, size: 18),
            tooltip: 'View Details',
            onPressed: () => controller.showRequestDetails(request),
            color: AdminColors.primary,
            style: IconButton.styleFrom(
              backgroundColor: AdminColors.primary.withValues(alpha: 0.1),
              minimumSize: const Size(32, 32),
              padding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.timeline_outlined, size: 18),
            tooltip: 'View Timeline',
            onPressed: () => controller.showRequestTimeline(request),
            color: AdminColors.info,
            style: IconButton.styleFrom(
              backgroundColor: AdminColors.info.withValues(alpha: 0.1),
              minimumSize: const Size(32, 32),
              padding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 18),
            tooltip: 'Update Status',
            onPressed: () => controller.updateRequestStatus(request),
            color: AdminColors.warning,
            style: IconButton.styleFrom(
              backgroundColor: AdminColors.warning.withValues(alpha: 0.1),
              minimumSize: const Size(32, 32),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(RequestsController controller) {
    return Obx(() {
      if (controller.filteredRequests.isEmpty) return const SizedBox.shrink();

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
              'Showing ${controller.filteredRequests.length} of ${controller.totalCount.value} requests',
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
                  'Page ${controller.currentPage.value} of ${(controller.totalCount.value / controller.pageSize.value).ceil()}',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: controller.currentPage.value <
                          (controller.totalCount.value /
                                  controller.pageSize.value)
                              .ceil()
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 64,
            color: AdminColors.textSecondaryLight.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No requests found',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AdminColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters or search query',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AdminColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(RequestsController controller) {
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
            'Error loading requests',
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

  String _getStatusLabel(RequestStatus status) {
    return status.toString().split('.').last.replaceAll('_', ' ').toUpperCase();
  }

  String _getServiceTypeLabel(ServiceType type) {
    return type.toString().split('.').last.replaceAll('_', ' ').toUpperCase();
  }

  static const Map<RequestStatus, Color> _statusColors = {
    RequestStatus.pending: AdminColors.warning,
    RequestStatus.driver_proposed: AdminColors.info,
    RequestStatus.accepted: AdminColors.info,
    RequestStatus.driver_arriving: AdminColors.primary,
    RequestStatus.in_progress: AdminColors.primary,
    RequestStatus.completed: AdminColors.success,
    RequestStatus.cancelled: AdminColors.error,
  };
}
