import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:intl/intl.dart';
import '../layouts/dashboard_layout.dart';
import '../core/theme/admin_colors.dart';
import '../core/utils/currency_helper.dart';
import '../controllers/orders_controller.dart';

/// Enhanced orders management screen with dashboard and timeline
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersController());
    
    return DashboardLayout(
      title: 'Orders Dashboard',
      actions: [
        Obx(() => OutlinedButton.icon(
          onPressed: controller.orders.isEmpty ? null : controller.exportOrders,
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
          // Statistics Cards Row
          _buildStatisticsCards(controller),
          
          const SizedBox(height: 24),
          
          // Status Distribution Chart
          _buildStatusDistribution(controller),
          
          const SizedBox(height: 24),
          
          // Filters Row
          _buildFiltersRow(controller),
          
          const SizedBox(height: 24),
          
          // Orders Table
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.orders.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (controller.errorMessage.isNotEmpty && controller.orders.isEmpty) {
                return _buildErrorState(controller);
              }
              
              if (controller.orders.isEmpty) {
                return _buildEmptyState();
              }
              
              return _buildOrdersTable(controller);
            }),
          ),
          
          // Pagination
          const SizedBox(height: 16),
          _buildPagination(controller),
        ],
      ),
    );
  }

  Widget _buildStatisticsCards(OrdersController controller) {
    return Obx(() => Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Total Orders',
            controller.totalCount.value.toString(),
            Icons.shopping_bag,
            AdminColors.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Pending',
            controller.pendingCount.value.toString(),
            Icons.hourglass_empty,
            AdminColors.warning,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'In Progress',
            controller.activeCount.value.toString(),
            Icons.local_shipping,
            AdminColors.info,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Completed',
            controller.deliveredCount.value.toString(),
            Icons.check_circle,
            AdminColors.success,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Total Revenue',
            CurrencyHelper.format(controller.totalRevenue.value),
            Icons.attach_money,
            AdminColors.success,
          ),
        ),
      ],
    ));
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
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
              color: color.withOpacity(0.1),
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

  Widget _buildStatusDistribution(OrdersController controller) {
    return Obx(() => Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Status Distribution',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AdminColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildStatusChip('Pending', controller.pendingCount.value, AdminColors.warning),
              const SizedBox(width: 12),
              _buildStatusChip('Confirmed', controller.confirmedCount.value, AdminColors.info),
              const SizedBox(width: 12),
              _buildStatusChip('Driver Assigned', controller.driverAssignedCount.value, AdminColors.info),
              const SizedBox(width: 12),
              _buildStatusChip('In Delivery', controller.inDeliveryCount.value, AdminColors.primary),
              const SizedBox(width: 12),
              _buildStatusChip('Delivered', controller.deliveredCount.value, AdminColors.success),
              const SizedBox(width: 12),
              _buildStatusChip('Cancelled', controller.cancelledCount.value, AdminColors.error),
            ],
          ),
        ],
      ),
    ));
  }

  Widget _buildStatusChip(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AdminColors.textPrimaryLight,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              count.toString(),
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersRow(OrdersController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderLight),
      ),
      child: Row(
        children: [
          // Search
          Expanded(
            flex: 2,
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Search by order number...',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 20),
                        onPressed: () {
                          controller.searchController.clear();
                          controller.searchQuery.value = '';
                          controller.loadOrders();
                        },
                      )
                    : const SizedBox.shrink()),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AdminColors.borderLight),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onChanged: (value) {
                controller.searchQuery.value = value;
                controller.loadOrders();
              },
            ),
          ),
          const SizedBox(width: 16),
          
          // Status Filter
          Obx(() => SizedBox(
            width: 200,
            child: DropdownButtonFormField<String>(
              value: controller.selectedStatus.value,
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              items: [
                'All Status',
                'Pending',
                'Confirmed',
                'Driver Assigned',
                'Ready',
                'Picked Up',
                'In Delivery',
                'Delivered',
                'Cancelled'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: GoogleFonts.inter(fontSize: 14)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.selectedStatus.value = newValue;
                  controller.loadOrders();
                }
              },
            ),
          )),
          const SizedBox(width: 16),
          
          // Clear Filters Button
          OutlinedButton.icon(
            onPressed: controller.clearFilters,
            icon: const Icon(Icons.filter_alt_off, size: 18),
            label: const Text('Clear Filters'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTable(OrdersController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AdminColors.borderLight),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AdminColors.borderLight)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Orders (${controller.orders.length})',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
                Obx(() => Text(
                  'Page ${controller.currentPage.value} • ${controller.orders.length} results',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AdminColors.textSecondaryLight,
                  ),
                )),
              ],
            ),
          ),
          
          // Table Content
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() => Table(
                columnWidths: const {
                  0: FlexColumnWidth(1.6),  // Order #
                  1: FlexColumnWidth(1.2),  // Store
                  2: FlexColumnWidth(1.2),  // Client
                  3: FlexColumnWidth(1.2),  // Driver
                  4: FlexColumnWidth(1.0),  // Amount
                  5: FlexColumnWidth(1.5),  // Status
                  6: FlexColumnWidth(1.5),  // Date
                  7: FlexColumnWidth(2.0),  // Actions
                },
                children: [
                  // Header Row
                  TableRow(
                    decoration: BoxDecoration(
                      color: AdminColors.backgroundLight,
                      border: Border(bottom: BorderSide(color: AdminColors.borderLight)),
                    ),
                    children: [
                      _buildHeaderCell('Order Number'),
                      _buildHeaderCell('Store'),
                      _buildHeaderCell('Client'),
                      _buildHeaderCell('Driver'),
                      _buildHeaderCell('Amount'),
                      _buildHeaderCell('Status'),
                      _buildHeaderCell('Created'),
                      _buildHeaderCell('Actions'),
                    ],
                  ),
                  // Data Rows
                  ...controller.orders.map((order) {
                    return TableRow(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(bottom: BorderSide(color: AdminColors.borderLight.withOpacity(0.5))),
                      ),
                      children: [
                        _buildOrderNumberCell(order),
                        _buildDataCell('S${order.storeId}'),
                        _buildDataCell('U${order.clientId}'),
                        _buildDataCell(order.driverId != null ? 'D${order.driverId}' : 'Unassigned'),
                        _buildAmountCell(order),
                        _buildStatusBadgeCell(order),
                        _buildDateCell(order),
                        _buildActionsCell(controller, order),
                      ],
                    );
                  }).toList(),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AdminColors.textSecondaryLight,
        ),
      ),
    );
  }

  Widget _buildDataCell(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 14,
          color: AdminColors.textPrimaryLight,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildOrderNumberCell(StoreOrder order) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        order.orderNumber,
        style: GoogleFonts.robotoMono(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AdminColors.primary,
        ),
      ),
    );
  }

  Widget _buildAmountCell(StoreOrder order) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        CurrencyHelper.formatWithSymbol(order.total, order.currencySymbol),
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AdminColors.success,
        ),
      ),
    );
  }

  Widget _buildStatusBadgeCell(StoreOrder order) {
    final statusColors = {
      StoreOrderStatus.pending: AdminColors.warning,
      StoreOrderStatus.confirmed: AdminColors.info,
      StoreOrderStatus.driverAssigned: AdminColors.info,
      StoreOrderStatus.ready: AdminColors.primary,
      StoreOrderStatus.pickedUp: AdminColors.primary,
      StoreOrderStatus.inDelivery: AdminColors.primary,
      StoreOrderStatus.delivered: AdminColors.success,
      StoreOrderStatus.cancelled: AdminColors.error,
    };

    final color = statusColors[order.status] ?? AdminColors.textMutedLight;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Text(
          order.status.name.replaceAll('_', ' ').toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildDateCell(StoreOrder order) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('MMM dd, yyyy').format(order.createdAt),
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AdminColors.textPrimaryLight,
            ),
          ),
          Text(
            DateFormat('HH:mm').format(order.createdAt),
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AdminColors.textMutedLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsCell(OrdersController controller, StoreOrder order) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.visibility, size: 18),
            onPressed: () => controller.showOrderDetails(order),
            tooltip: 'View Details',
            color: AdminColors.primary,
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          ),
          IconButton(
            icon: const Icon(Icons.timeline, size: 18),
            onPressed: () => controller.showOrderTimeline(order),
            tooltip: 'View Timeline',
            color: AdminColors.info,
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 18),
            onPressed: () => controller.updateOrderStatus(order),
            tooltip: 'Update Status',
            color: AdminColors.warning,
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(OrdersController controller) {
    return Obx(() {
      final totalPages = (controller.totalCount.value / controller.pageSize.value).ceil();
      if (totalPages <= 1) return const SizedBox.shrink();

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
            // Page Size Selector
            Row(
              children: [
                Text(
                  'Show:',
                  style: GoogleFonts.inter(fontSize: 14, color: AdminColors.textSecondaryLight),
                ),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: controller.pageSize.value,
                  items: [10, 20, 50, 100].map((size) {
                    return DropdownMenuItem(
                      value: size,
                      child: Text('$size', style: GoogleFonts.inter(fontSize: 14)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.pageSize.value = value;
                      controller.currentPage.value = 1;
                      controller.loadOrders();
                    }
                  },
                  underline: const SizedBox.shrink(),
                ),
              ],
            ),
            
            // Page Navigation
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: controller.currentPage.value > 1
                      ? () => controller.goToPage(controller.currentPage.value - 1)
                      : null,
                ),
                ...List.generate(
                  totalPages > 5 ? 5 : totalPages,
                  (index) {
                    final pageNum = index + 1;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: InkWell(
                        onTap: () => controller.goToPage(pageNum),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: controller.currentPage.value == pageNum
                                ? AdminColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '$pageNum',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: controller.currentPage.value == pageNum
                                  ? Colors.white
                                  : AdminColors.textPrimaryLight,
                              fontWeight: controller.currentPage.value == pageNum
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: controller.currentPage.value < totalPages
                      ? () => controller.goToPage(controller.currentPage.value + 1)
                      : null,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildErrorState(OrdersController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: AdminColors.error),
          const SizedBox(height: 16),
          Text(
            controller.errorMessage.value,
            style: GoogleFonts.inter(fontSize: 16, color: AdminColors.textSecondaryLight),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: controller.refresh,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AdminColors.primary,
              foregroundColor: Colors.white,
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
          Icon(Icons.shopping_bag_outlined, size: 64, color: AdminColors.textMutedLight),
          const SizedBox(height: 16),
          Text(
            'No orders found',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AdminColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Orders will appear here once customers place them',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AdminColors.textMutedLight,
            ),
          ),
        ],
      ),
    );
  }
}
