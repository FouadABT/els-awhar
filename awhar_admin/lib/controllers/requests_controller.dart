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

/// Requests controller - manages service requests with full admin tooling
class RequestsController extends GetxController {
  // Loading state
  final RxBool isLoading = false.obs;
  final RxBool isActionLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Requests list
  final RxList<ServiceRequest> requests = <ServiceRequest>[].obs;

  // Pagination
  final RxInt currentPage = 1.obs;
  final RxInt totalCount = 0.obs;
  final RxInt pageSize = 20.obs;

  // Statistics
  final RxInt pendingCount = 0.obs;
  final RxInt activeCount = 0.obs;
  final RxInt completedCount = 0.obs;
  final RxInt cancelledCount = 0.obs;
  final RxDouble totalValue = 0.0.obs;

  // Filters
  final RxString selectedStatus = 'All Status'.obs;
  final Rx<ServiceType?> selectedServiceType = Rx<ServiceType?>(null);
  final RxString searchQuery = ''.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadRequests();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  List<ServiceRequest> get filteredRequests {
    final query = searchQuery.value.trim().toLowerCase();
    debugPrint(
        '[RequestsController] Filtering ${requests.length} requests with query: "$query", serviceType: ${selectedServiceType.value}');

    final filtered = requests.where((request) {
      final matchesType = selectedServiceType.value == null ||
          request.serviceType == selectedServiceType.value;
      if (!matchesType) return false;

      if (query.isEmpty) return true;

      final requestId = request.id?.toString() ?? '';
      final client = request.clientName.toLowerCase();
      final driver = (request.driverName ?? 'unassigned').toLowerCase();
      final serviceType = request.serviceType.name.toLowerCase();
      final status = request.status.name.toLowerCase();

      return requestId.contains(query) ||
          client.contains(query) ||
          driver.contains(query) ||
          serviceType.contains(query) ||
          status.contains(query);
    }).toList();

    debugPrint('[RequestsController] Filtered to ${filtered.length} requests');
    return filtered;
  }

  /// Load requests from the server
  Future<void> loadRequests() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      if (!ApiService.instance.isInitialized) {
        throw Exception('API not initialized');
      }

      final statusFilter = selectedStatus.value == 'All Status'
          ? null
          : _mapStatusFromString(selectedStatus.value);

      final result = await ApiService.instance.client.admin.listRequests(
        page: currentPage.value,
        limit: pageSize.value,
        statusFilter: statusFilter,
      );

      requests.value = result;
      _updateStatistics();

      // Try to get total count, but don't fail if it errors
      try {
        final totalResult =
            await ApiService.instance.client.admin.getRequestCount(
          statusFilter: statusFilter,
        );
        totalCount.value = totalResult;
      } catch (e) {
        debugPrint('[RequestsController] Could not get total count: $e');
        // Fallback: use loaded requests count
        totalCount.value = result.length;
      }

      debugPrint(
          '[RequestsController] Loaded ${result.length} requests, total: ${totalCount.value}');
    } catch (e) {
      debugPrint('[RequestsController] Error loading requests: $e');
      errorMessage.value = 'Failed to load requests. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void _updateStatistics() {
    pendingCount.value =
        requests.where((r) => r.status == RequestStatus.pending).length;
    activeCount.value = requests
        .where((r) =>
            r.status == RequestStatus.driver_proposed ||
            r.status == RequestStatus.accepted ||
            r.status == RequestStatus.driver_arriving ||
            r.status == RequestStatus.in_progress)
        .length;
    completedCount.value =
        requests.where((r) => r.status == RequestStatus.completed).length;
    cancelledCount.value =
        requests.where((r) => r.status == RequestStatus.cancelled).length;
    totalValue.value =
        requests.fold<double>(0.0, (sum, r) => sum + r.totalPrice);
  }

  /// Go to a specific page
  void goToPage(int page) {
    currentPage.value = page;
    loadRequests();
  }

  /// Clear filters
  void clearFilters() {
    searchController.clear();
    searchQuery.value = '';
    selectedStatus.value = 'All Status';
    selectedServiceType.value = null;
    currentPage.value = 1;
    loadRequests();
  }

  /// Refresh the list
  @override
  Future<void> refresh() async {
    currentPage.value = 1;
    await loadRequests();
  }

  /// Show request details dialog
  void showRequestDetails(ServiceRequest request) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 850,
          constraints: const BoxConstraints(maxHeight: 720),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Request Details',
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
                      _buildDetailSection('Request Information', [
                        _buildDetailRow('Request ID', '#REQ${request.id ?? 0}'),
                        _buildDetailRow('Service Type',
                            _formatTitle(request.serviceType.name)),
                        _buildDetailRow(
                            'Status', _formatTitle(request.status.name)),
                        _buildDetailRow(
                            'Created',
                            DateFormat('MMM dd, yyyy HH:mm')
                                .format(request.createdAt)),
                      ]),
                      const SizedBox(height: 24),
                      _buildDetailSection('Client & Driver', [
                        _buildDetailRow('Client', request.clientName),
                        if (request.clientPhone != null &&
                            request.clientPhone!.isNotEmpty)
                          _buildDetailRow('Client Phone', request.clientPhone!),
                        _buildDetailRow(
                            'Driver', request.driverName ?? 'Unassigned'),
                        if (request.driverPhone != null &&
                            request.driverPhone!.isNotEmpty)
                          _buildDetailRow('Driver Phone', request.driverPhone!),
                        if (request.proposedDriverName != null &&
                            request.proposedDriverName!.isNotEmpty)
                          _buildDetailRow(
                              'Proposed Driver', request.proposedDriverName!),
                      ]),
                      const SizedBox(height: 24),
                      _buildDetailSection('Locations', [
                        _buildDetailRow(
                            'Pickup', _formatLocation(request.pickupLocation)),
                        _buildDetailRow('Destination',
                            _formatLocation(request.destinationLocation)),
                        if (request.distance != null)
                          _buildDetailRow('Distance',
                              '${request.distance!.toStringAsFixed(2)} km'),
                        if (request.estimatedDuration != null)
                          _buildDetailRow('Estimated Duration',
                              '${request.estimatedDuration} min'),
                      ]),
                      const SizedBox(height: 24),
                      _buildDetailSection('Pricing', [
                        _buildDetailRow(
                            'Base Price',
                            CurrencyHelper.formatWithSymbol(
                                request.basePrice, request.currencySymbol)),
                        _buildDetailRow(
                            'Distance Price',
                            CurrencyHelper.formatWithSymbol(
                                request.distancePrice, request.currencySymbol)),
                        if (request.deliveryFee != null)
                          _buildDetailRow(
                              'Delivery Fee',
                              CurrencyHelper.formatWithSymbol(
                                  request.deliveryFee!,
                                  request.currencySymbol)),
                        if (request.estimatedPurchaseCost != null)
                          _buildDetailRow(
                              'Estimated Purchase',
                              CurrencyHelper.formatWithSymbol(
                                  request.estimatedPurchaseCost!,
                                  request.currencySymbol)),
                        _buildDetailRow(
                            'Total',
                            CurrencyHelper.formatWithSymbol(
                                request.totalPrice, request.currencySymbol),
                            isBold: true),
                        _buildDetailRow('Currency',
                            '${request.currency} (${request.currencySymbol})'),
                      ]),
                      const SizedBox(height: 24),
                      _buildDetailSection('Additional Details', [
                        if (request.itemDescription != null &&
                            request.itemDescription!.isNotEmpty)
                          _buildDetailRow(
                              'Item Description', request.itemDescription!),
                        if (request.specialInstructions != null &&
                            request.specialInstructions!.isNotEmpty)
                          _buildDetailRow(
                              'Instructions', request.specialInstructions!),
                        if (request.notes != null && request.notes!.isNotEmpty)
                          _buildDetailRow('Notes', request.notes!),
                        if (request.cancellationReason != null &&
                            request.cancellationReason!.isNotEmpty)
                          _buildDetailRow('Cancellation Reason',
                              request.cancellationReason!),
                      ]),
                      if (request.shoppingList != null &&
                          request.shoppingList!.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        _buildDetailSection(
                            'Shopping List',
                            request.shoppingList!.map((item) {
                              return _buildDetailRow(
                                '${item.item} (x${item.quantity})',
                                item.notes ?? 'No notes',
                              );
                            }).toList()),
                      ],
                      if (request.attachments != null &&
                          request.attachments!.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        _buildDetailSection(
                            'Attachments',
                            request.attachments!.map((file) {
                              return _buildDetailRow('File', file);
                            }).toList()),
                      ],
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
                      showRequestTimeline(request);
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

  void showRequestTimeline(ServiceRequest request) {
    final timelineEvents = _generateTimelineFromRequest(request);

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
                        'Request Timeline',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AdminColors.textPrimaryLight,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '#REQ${request.id ?? 0}',
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

  void updateRequestStatus(ServiceRequest request) {
    final statusController =
        TextEditingController(text: _formatTitle(request.status.name));
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
                'Update Request Status',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AdminColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '#REQ${request.id ?? 0}',
                style: GoogleFonts.robotoMono(
                  fontSize: 13,
                  color: AdminColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 24),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'New Status',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                value: statusController.text,
                items: _statusOptions.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) =>
                    statusController.text = value ?? statusController.text,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Note (optional)',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
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
                    onPressed: () async {
                      Get.back();
                      await _performStatusUpdate(
                          request, statusController.text, noteController.text);
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

  Future<void> _performStatusUpdate(
      ServiceRequest request, String statusText, String note) async {
    try {
      final status = _mapStatusFromString(statusText);
      if (status == null || request.id == null) return;

      final updated =
          await ApiService.instance.client.admin.updateRequestStatus(
        request.id!,
        status,
        note: note.trim().isEmpty ? null : note.trim(),
      );

      if (updated != null) {
        final index = requests.indexWhere((r) => r.id == updated.id);
        if (index != -1) {
          requests[index] = updated;
        }
        _updateStatistics();
      }

      Get.snackbar(
        'Success',
        'Request status updated successfully',
        backgroundColor: AdminColors.success.withValues(alpha: 0.1),
        colorText: AdminColors.success,
      );
    } catch (e) {
      debugPrint('[RequestsController] Error updating request: $e');
      Get.snackbar(
        'Error',
        'Failed to update request',
        backgroundColor: AdminColors.error.withValues(alpha: 0.1),
        colorText: AdminColors.error,
      );
    }
  }

  void exportRequests() {
    try {
      final csv = StringBuffer();
      csv.writeln('Request ID,Client,Driver,Service Type,Status,Total,Created');

      for (final request in requests) {
        final line = '"${request.id ?? ''}",'
            '"${request.clientName}",'
            '"${request.driverName ?? 'Unassigned'}",'
            '"${request.serviceType.name}",'
            '"${request.status.name}",'
            '"${request.totalPrice.toStringAsFixed(2)}",'
            '"${request.createdAt.toString().split(' ')[0]}"';
        csv.writeln(line);
      }

      final csvContent = csv.toString();
      final encoded = Uri.encodeComponent(csvContent);
      final url = 'data:text/csv;charset=utf-8,$encoded';
      html.AnchorElement(href: url)
        ..setAttribute(
            'download', 'requests_${DateTime.now().millisecondsSinceEpoch}.csv')
        ..click();

      Get.snackbar(
        'Success',
        'Requests exported successfully',
        backgroundColor: AdminColors.success.withValues(alpha: 0.1),
        colorText: AdminColors.success,
      );
    } catch (e) {
      debugPrint('[RequestsController] Error exporting requests: $e');
      Get.snackbar(
        'Error',
        'Failed to export requests',
        backgroundColor: AdminColors.error.withValues(alpha: 0.1),
        colorText: AdminColors.error,
      );
    }
  }

  List<Map<String, dynamic>> _generateTimelineFromRequest(
      ServiceRequest request) {
    final timeline = <Map<String, dynamic>>[];

    timeline.add({
      'status': 'pending',
      'timestamp': request.createdAt,
      'note': 'Request created',
      'actor': 'client',
    });

    if (request.status == RequestStatus.driver_proposed ||
        request.proposedDriverId != null) {
      timeline.add({
        'status': 'driver_proposed',
        'timestamp': request.createdAt,
        'note': 'Driver proposed',
        'actor': 'system',
      });
    }

    if (request.acceptedAt != null) {
      timeline.add({
        'status': 'accepted',
        'timestamp': request.acceptedAt!,
        'note': 'Request accepted',
        'actor': 'driver',
      });
    }

    if (request.driverArrivingAt != null) {
      timeline.add({
        'status': 'driver_arriving',
        'timestamp': request.driverArrivingAt!,
        'note': 'Driver arriving',
        'actor': 'driver',
      });
    }

    if (request.startedAt != null) {
      timeline.add({
        'status': 'in_progress',
        'timestamp': request.startedAt!,
        'note': 'Service in progress',
        'actor': 'driver',
      });
    }

    if (request.completedAt != null) {
      timeline.add({
        'status': 'completed',
        'timestamp': request.completedAt!,
        'note': 'Service completed',
        'actor': 'driver',
      });
    }

    if (request.cancelledAt != null) {
      timeline.add({
        'status': 'cancelled',
        'timestamp': request.cancelledAt!,
        'note': request.cancellationReason ?? 'Request cancelled',
        'actor': request.cancelledBy?.toString() ?? 'system',
      });
    }

    return timeline;
  }

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

        final timestamp = event['timestamp'] as DateTime;
        final status = event['status'] as String;
        final note = event['note'] as String;
        final actor = event['actor'] as String;

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

  Widget _buildTimelineItem({
    required String status,
    required DateTime timestamp,
    required String note,
    required String actor,
    required bool isLast,
  }) {
    final color = _getColorForStatus(
        _mapStatusFromString(_formatTitle(status)) ?? RequestStatus.pending);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatTitle(status),
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
                    Icon(Icons.access_time,
                        size: 12, color: AdminColors.textMutedLight),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('MMM dd, yyyy HH:mm').format(timestamp),
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AdminColors.textMutedLight,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.person,
                        size: 12, color: AdminColors.textMutedLight),
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

  IconData _getIconForStatus(String status) {
    switch (status) {
      case 'pending':
        return Icons.hourglass_empty;
      case 'driver_proposed':
        return Icons.person_add_alt;
      case 'accepted':
        return Icons.check_circle_outline;
      case 'driver_arriving':
        return Icons.directions_car;
      case 'in_progress':
        return Icons.local_shipping;
      case 'completed':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.circle;
    }
  }

  Color _getColorForStatus(RequestStatus status) {
    switch (status) {
      case RequestStatus.pending:
        return AdminColors.warning;
      case RequestStatus.driver_proposed:
        return AdminColors.info;
      case RequestStatus.accepted:
        return AdminColors.info;
      case RequestStatus.driver_arriving:
        return AdminColors.primary;
      case RequestStatus.in_progress:
        return AdminColors.primary;
      case RequestStatus.completed:
        return AdminColors.success;
      case RequestStatus.cancelled:
        return AdminColors.error;
    }
  }

  RequestStatus? _mapStatusFromString(String status) {
    switch (status) {
      case 'Pending':
        return RequestStatus.pending;
      case 'Driver Proposed':
        return RequestStatus.driver_proposed;
      case 'Accepted':
        return RequestStatus.accepted;
      case 'Driver Arriving':
        return RequestStatus.driver_arriving;
      case 'In Progress':
        return RequestStatus.in_progress;
      case 'Completed':
        return RequestStatus.completed;
      case 'Cancelled':
        return RequestStatus.cancelled;
      default:
        return null;
    }
  }

  String _formatTitle(String value) {
    return value
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) =>
            word.isEmpty ? word : word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String _formatLocation(Location? location) {
    if (location == null) return 'N/A';
    if (location.address != null && location.address!.isNotEmpty)
      return location.address!;
    if (location.placeName != null && location.placeName!.isNotEmpty)
      return location.placeName!;
    if (location.city != null && location.city!.isNotEmpty)
      return location.city!;
    return '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}';
  }

  List<String> get _statusOptions => [
        'Pending',
        'Driver Proposed',
        'Accepted',
        'Driver Arriving',
        'In Progress',
        'Completed',
        'Cancelled',
      ];

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
            width: 160,
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
}
