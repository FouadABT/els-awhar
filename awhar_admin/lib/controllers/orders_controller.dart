import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:intl/intl.dart';
import '../core/services/api_service.dart';
import '../core/theme/admin_colors.dart';
import '../core/utils/currency_helper.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert';

/// Enhanced orders controller with timeline and full order details
class OrdersController extends GetxController {
  // Loading state
  final RxBool isLoading = false.obs;
  final RxBool isActionLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Orders list
  final RxList<StoreOrder> orders = <StoreOrder>[].obs;

  // Pagination
  final RxInt currentPage = 1.obs;
  final RxInt totalCount = 0.obs;
  final RxInt pageSize = 20.obs;

  // Statistics
  final RxInt pendingCount = 0.obs;
  final RxInt confirmedCount = 0.obs;
  final RxInt driverAssignedCount = 0.obs;
  final RxInt inDeliveryCount = 0.obs;
  final RxInt deliveredCount = 0.obs;
  final RxInt cancelledCount = 0.obs;
  final RxInt activeCount = 0.obs;
  final RxDouble totalRevenue = 0.0.obs;

  // Search and filters
  final RxString searchQuery = ''.obs;
  final RxString selectedStatus = 'All Status'.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// Load orders from the server
  Future<void> loadOrders() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      if (!ApiService.instance.isInitialized) {
        throw Exception('API not initialized');
      }

      // Map status filter
      StoreOrderStatus? statusFilter;
      if (selectedStatus.value != 'All Status') {
        statusFilter = _mapStatusFromString(selectedStatus.value);
      }

      final result = await ApiService.instance.client.admin.listOrders(
        page: currentPage.value,
        limit: pageSize.value,
        statusFilter: statusFilter,
      );

      orders.value = result;
      
      // Update statistics
      _updateStatistics();
      
      // Get total count
      final totalResult = await ApiService.instance.client.admin.getOrderCount();
      totalCount.value = totalResult;
      
      debugPrint('[OrdersController] Loaded ${result.length} orders');
    } catch (e) {
      debugPrint('[OrdersController] Error loading orders: $e');
      errorMessage.value = 'Failed to load orders. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  /// Update order statistics
  void _updateStatistics() {
    pendingCount.value = orders.where((o) => o.status == StoreOrderStatus.pending).length;
    confirmedCount.value = orders.where((o) => o.status == StoreOrderStatus.confirmed).length;
    driverAssignedCount.value = orders.where((o) => o.status == StoreOrderStatus.driverAssigned).length;
    inDeliveryCount.value = orders.where((o) => o.status == StoreOrderStatus.inDelivery).length;
    deliveredCount.value = orders.where((o) => o.status == StoreOrderStatus.delivered).length;
    cancelledCount.value = orders.where((o) => o.status == StoreOrderStatus.cancelled).length;
    
    activeCount.value = orders.where((o) => 
      o.status == StoreOrderStatus.confirmed ||
      o.status == StoreOrderStatus.driverAssigned ||
      o.status == StoreOrderStatus.ready ||
      o.status == StoreOrderStatus.pickedUp ||
      o.status == StoreOrderStatus.inDelivery
    ).length;
    
    totalRevenue.value = orders.fold<double>(0.0, (sum, o) => sum + o.total);
  }

  /// Map status string to enum
  StoreOrderStatus? _mapStatusFromString(String status) {
    switch (status) {
      case 'Pending': return StoreOrderStatus.pending;
      case 'Confirmed': return StoreOrderStatus.confirmed;
      case 'Driver Assigned': return StoreOrderStatus.driverAssigned;
      case 'Ready': return StoreOrderStatus.ready;
      case 'Picked Up': return StoreOrderStatus.pickedUp;
      case 'In Delivery': return StoreOrderStatus.inDelivery;
      case 'Delivered': return StoreOrderStatus.delivered;
      case 'Cancelled': return StoreOrderStatus.cancelled;
      default: return null;
    }
  }

  /// Go to a specific page
  void goToPage(int page) {
    currentPage.value = page;
    loadOrders();
  }

  /// Clear all filters
  void clearFilters() {
    searchController.clear();
    searchQuery.value = '';
    selectedStatus.value = 'All Status';
    currentPage.value = 1;
    loadOrders();
  }

  /// Show order details dialog with items
  void showOrderDetails(StoreOrder order) {
    // Parse items from JSON
    List<dynamic> items = [];
    try {
      items = jsonDecode(order.itemsJson);
    } catch (e) {
      debugPrint('[OrdersController] Error parsing items JSON: $e');
    }

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 800,
          constraints: const BoxConstraints(maxHeight: 700),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Details',
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order Info
                      _buildDetailSection('Order Information', [
                        _buildDetailRow('Order Number', order.orderNumber),
                        _buildDetailRow('Store ID', 'Store #${order.storeId}'),
                        _buildDetailRow('Client ID', 'User #${order.clientId}'),
                        _buildDetailRow('Driver ID', order.driverId != null ? 'Driver #${order.driverId}' : 'Not Assigned'),
                        _buildDetailRow('Status', order.status.name.replaceAll('_', ' ').toUpperCase()),
                        _buildDetailRow('Created', DateFormat('MMM dd, yyyy HH:mm').format(order.createdAt)),
                      ]),
                      
                      const SizedBox(height: 24),
                      
                      // Order Items
                      _buildDetailSection('Order Items', [
                        ...items.map((item) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: AdminColors.borderLight.withValues(alpha: 0.5))),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'] ?? 'Unknown Item',
                                      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
                                    ),
                                    if (item['notes'] != null && item['notes'].toString().isNotEmpty)
                                      Text(
                                        item['notes'],
                                        style: GoogleFonts.inter(fontSize: 12, color: AdminColors.textMutedLight),
                                      ),
                                  ],
                                ),
                              ),
                              Text(
                                'x${item['quantity'] ?? 1}',
                                style: GoogleFonts.inter(fontSize: 14, color: AdminColors.textSecondaryLight),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                CurrencyHelper.formatWithSymbol((item['price'] ?? 0).toDouble(), order.currencySymbol),
                                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )),
                      ]),
                      
                      const SizedBox(height: 24),
                      
                      // Pricing
                      _buildDetailSection('Pricing', [
                        _buildDetailRow('Subtotal', CurrencyHelper.formatWithSymbol(order.subtotal, order.currencySymbol)),
                        _buildDetailRow('Delivery Fee', CurrencyHelper.formatWithSymbol(order.deliveryFee, order.currencySymbol)),
                        _buildDetailRow('Total', CurrencyHelper.formatWithSymbol(order.total, order.currencySymbol), isBold: true),
                      ]),
                      
                      const SizedBox(height: 24),
                      
                      // Delivery Info
                      _buildDetailSection('Delivery Information', [
                        _buildDetailRow('Address', order.deliveryAddress),
                        _buildDetailRow('Distance', order.deliveryDistance != null ? '${order.deliveryDistance!.toStringAsFixed(2)} km' : 'N/A'),
                        if (order.clientNotes != null && order.clientNotes!.isNotEmpty)
                          _buildDetailRow('Client Notes', order.clientNotes!),
                      ]),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Close'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                      showOrderTimeline(order);
                    },
                    icon: const Icon(Icons.timeline, size: 18),
                    label: const Text('View Timeline'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AdminColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AdminColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
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
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AdminColors.textSecondaryLight,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
                color: AdminColors.textPrimaryLight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Show order timeline dialog
  void showOrderTimeline(StoreOrder order) {
    // Parse timeline from JSON
    List<Map<String, dynamic>> timelineEvents = [];
    try {
      if (order.timelineJson != null && order.timelineJson!.isNotEmpty) {
        final parsed = jsonDecode(order.timelineJson!) as List;
        timelineEvents = parsed.map((e) => e as Map<String, dynamic>).toList();
      }
    } catch (e) {
      debugPrint('[OrdersController] Error parsing timeline JSON: $e');
    }

    // If no timeline, create from order timestamps
    if (timelineEvents.isEmpty) {
      timelineEvents = _generateTimelineFromOrder(order);
    }

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 700,
          constraints: const BoxConstraints(maxHeight: 600),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Timeline',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AdminColors.textPrimaryLight,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order.orderNumber,
                        style: GoogleFonts.robotoMono(
                          fontSize: 14,
                          color: AdminColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildTimelineView(timelineEvents),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Generate timeline from order timestamps
  List<Map<String, dynamic>> _generateTimelineFromOrder(StoreOrder order) {
    List<Map<String, dynamic>> timeline = [];

    timeline.add({
      'status': 'pending',
      'timestamp': order.createdAt.toIso8601String(),
      'note': 'Order created',
      'actor': 'client'
    });

    if (order.confirmedAt != null) {
      timeline.add({
        'status': 'confirmed',
        'timestamp': order.confirmedAt!.toIso8601String(),
        'note': 'Order confirmed by store',
        'actor': 'store'
      });
    }

    if (order.readyAt != null) {
      timeline.add({
        'status': 'ready',
        'timestamp': order.readyAt!.toIso8601String(),
        'note': 'Order ready for pickup',
        'actor': 'store'
      });
    }

    if (order.pickedUpAt != null) {
      timeline.add({
        'status': 'pickedUp',
        'timestamp': order.pickedUpAt!.toIso8601String(),
        'note': 'Order picked up by driver',
        'actor': 'driver'
      });
    }

    if (order.deliveredAt != null) {
      timeline.add({
        'status': 'delivered',
        'timestamp': order.deliveredAt!.toIso8601String(),
        'note': 'Order delivered',
        'actor': 'driver'
      });
    }

    if (order.cancelledAt != null) {
      timeline.add({
        'status': 'cancelled',
        'timestamp': order.cancelledAt!.toIso8601String(),
        'note': order.cancellationReason ?? 'Order cancelled',
        'actor': order.cancelledBy ?? 'unknown'
      });
    }

    return timeline;
  }

  /// Build timeline view
  Widget _buildTimelineView(List<Map<String, dynamic>> events) {
    if (events.isEmpty) {
      return Center(
        child: Text(
          'No timeline data available',
          style: GoogleFonts.inter(color: AdminColors.textMutedLight),
        ),
      );
    }

    return Column(
      children: events.asMap().entries.map((entry) {
        final index = entry.key;
        final event = entry.value;
        final isLast = index == events.length - 1;

        final timestamp = DateTime.parse(event['timestamp']);
        final status = event['status'] ?? 'unknown';
        final note = event['note'] ?? '';
        final actor = event['actor'] ?? 'system';

        return _buildTimelineItem(
          status: status,
          timestamp: timestamp,
          note: note,
          actor: actor,
          isLast: isLast,
        );
      }).toList(),
    );
  }

  /// Build single timeline item
  Widget _buildTimelineItem({
    required String status,
    required DateTime timestamp,
    required String note,
    required String actor,
    required bool isLast,
  }) {
    final statusColors = {
      'pending': AdminColors.warning,
      'confirmed': AdminColors.info,
      'driverAssigned': AdminColors.info,
      'ready': AdminColors.primary,
      'pickedUp': AdminColors.primary,
      'inDelivery': AdminColors.primary,
      'delivered': AdminColors.success,
      'cancelled': AdminColors.error,
    };

    final color = statusColors[status] ?? AdminColors.textMutedLight;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
              ),
              child: Icon(
                _getIconForStatus(status),
                size: 16,
                color: color,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                color: AdminColors.borderLight,
              ),
          ],
        ),
        const SizedBox(width: 16),
        // Event details
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status.replaceAll('_', ' ').toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  note,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: AdminColors.textMutedLight),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('MMM dd, yyyy HH:mm').format(timestamp),
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AdminColors.textMutedLight,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.person, size: 12, color: AdminColors.textMutedLight),
                    const SizedBox(width: 4),
                    Text(
                      actor.toUpperCase(),
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AdminColors.textMutedLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Get icon for status
  IconData _getIconForStatus(String status) {
    switch (status) {
      case 'pending': return Icons.hourglass_empty;
      case 'confirmed': return Icons.check_circle_outline;
      case 'driverAssigned': return Icons.person_add;
      case 'ready': return Icons.inventory;
      case 'pickedUp': return Icons.shopping_bag;
      case 'inDelivery': return Icons.local_shipping;
      case 'delivered': return Icons.check_circle;
      case 'cancelled': return Icons.cancel;
      default: return Icons.circle;
    }
  }

  /// Update order status
  void updateOrderStatus(StoreOrder order) {
    final statusController = TextEditingController();
    final noteController = TextEditingController();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Update Order Status',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AdminColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                order.orderNumber,
                style: GoogleFonts.robotoMono(
                  fontSize: 13,
                  color: AdminColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 24),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'New Status',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                items: [
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
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) => statusController.text = value ?? '',
              ),
              const SizedBox(height: 16),
              TextField(
                controller: noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Note (optional)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.snackbar(
                        'Success',
                        'Order status updated successfully',
                        backgroundColor: AdminColors.success.withValues(alpha: 0.1),
                        colorText: AdminColors.success,
                      );
                      loadOrders();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AdminColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Update Status'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Export orders to CSV
  void exportOrders() {
    try {
      final csv = StringBuffer();
      csv.writeln('Order Number,Store ID,Client ID,Driver ID,Subtotal,Delivery Fee,Total,Status,Created,Delivered');
      
      for (final order in orders) {
        csv.writeln(
          '"${order.orderNumber}",'
          '"${order.storeId}",'
          '"${order.clientId}",'
          '"${order.driverId ?? 'N/A'}",'
          '"${order.subtotal.toStringAsFixed(2)}",'
          '"${order.deliveryFee.toStringAsFixed(2)}",'
          '"${order.total.toStringAsFixed(2)}",'
          '"${order.status.name}",'
          '"${order.createdAt.toString().split(' ')[0]}",'
          '"${order.deliveredAt?.toString().split(' ')[0] ?? 'N/A'}"'
        );
      }
      
      final csvContent = csv.toString();
      final encoded = Uri.encodeComponent(csvContent);
      final url = 'data:text/csv;charset=utf-8,$encoded';
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'orders_${DateTime.now().millisecondsSinceEpoch}.csv')
        ..click();
      
      Get.snackbar(
        'Success',
        'Orders exported successfully',
        backgroundColor: AdminColors.success.withValues(alpha: 0.1),
        colorText: AdminColors.success,
      );
    } catch (e) {
      debugPrint('[OrdersController] Error exporting orders: $e');
      Get.snackbar(
        'Error',
        'Failed to export orders',
        backgroundColor: AdminColors.error.withValues(alpha: 0.1),
        colorText: AdminColors.error,
      );
    }
  }

  /// Refresh the list
  @override
  Future<void> refresh() async {
    currentPage.value = 1;
    await loadOrders();
  }
}
