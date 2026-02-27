import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:intl/intl.dart';
import '../core/services/api_service.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// Reports controller - manages user reports with real data
class ReportsController extends GetxController {
  // Loading state
  final RxBool isLoading = false.obs;
  final RxBool isActionLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Reports list
  final RxList<Report> reports = <Report>[].obs;

  // Pagination
  final RxInt currentPage = 1.obs;
  final RxInt totalCount = 0.obs;
  final RxInt pageSize = 20.obs;

  // Filters
  final Rx<ReportStatus?> statusFilter = Rx<ReportStatus?>(null);

  // Search
  final RxString searchQuery = ''.obs;

  // Computed counts
  int get pendingCount => reports.where((r) => r.status == ReportStatus.pending).length;
  int get resolvedCount => reports.where((r) => r.status == ReportStatus.resolved).length;
  int get dismissedCount => reports.where((r) => r.status == ReportStatus.dismissed).length;

  @override
  void onInit() {
    super.onInit();
    loadReports();
  }

  /// Load reports from the server
  Future<void> loadReports() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      if (!ApiService.instance.isInitialized) {
        throw Exception('API not initialized');
      }

      final result = await ApiService.instance.client.admin.listReports(
        page: currentPage.value,
        limit: pageSize.value,
        statusFilter: statusFilter.value,
      );

      reports.value = result;
      totalCount.value = result.length;
      debugPrint('[ReportsController] Loaded ${result.length} reports');
    } catch (e) {
      debugPrint('[ReportsController] Error loading reports: $e');
      errorMessage.value = 'Failed to load reports';
    } finally {
      isLoading.value = false;
    }
  }

  /// Go to a specific page
  void goToPage(int page) {
    currentPage.value = page;
    loadReports();
  }

  /// Set status filter
  void setStatusFilter(ReportStatus? status) {
    statusFilter.value = status;
    loadReports();
  }

  /// Resolve a report
  Future<bool> resolveReport(int reportId, ReportResolution resolution, {String? notes}) async {
    isActionLoading.value = true;

    try {
      final success = await ApiService.instance.client.admin.resolveReport(
        reportId: reportId,
        resolution: resolution,
        adminNotes: notes,
      );

      if (success) {
        await loadReports();
        Get.snackbar('Success', 'Report resolved successfully');
      }
      return success;
    } catch (e) {
      debugPrint('[ReportsController] Error resolving report: $e');
      Get.snackbar('Error', 'Failed to resolve report');
      return false;
    } finally {
      isActionLoading.value = false;
    }
  }

  /// Dismiss a report
  Future<bool> dismissReport(int reportId, {String? reason}) async {
    isActionLoading.value = true;

    try {
      final success = await ApiService.instance.client.admin.dismissReport(
        reportId: reportId,
        reason: reason,
      );

      if (success) {
        await loadReports();
        Get.snackbar('Success', 'Report dismissed');
      }
      return success;
    } catch (e) {
      debugPrint('[ReportsController] Error dismissing report: $e');
      Get.snackbar('Error', 'Failed to dismiss report');
      return false;
    } finally {
      isActionLoading.value = false;
    }
  }

  /// Refresh the list
  Future<void> refresh() async {
    currentPage.value = 1;
    await loadReports();
  }

  /// Export reports to CSV
  void exportReports() {
    if (reports.isEmpty) return;

    final csv = StringBuffer();
    csv.writeln('Report ID,Reporter ID,Reported Entity,Reason,Status,Resolution,Description,Admin Notes,Created,Resolved');

    for (final report in reports) {
      final reportedEntity = _getReportedEntity(report);
      csv.writeln([
        report.id,
        report.reportedByUserId,
        reportedEntity,
        report.reportReason?.name ?? 'other',
        report.status?.name ?? 'pending',
        report.resolution?.name ?? '',
        _escapeCsv(report.description ?? ''),
        _escapeCsv(report.adminNotes ?? ''),
        DateFormat('yyyy-MM-dd HH:mm').format(report.createdAt),
        report.resolvedAt != null ? DateFormat('yyyy-MM-dd HH:mm').format(report.resolvedAt!) : '',
      ].join(','));
    }

    final blob = html.Blob([csv.toString()], 'text/csv');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'reports_${DateFormat('yyyy-MM-dd').format(DateTime.now())}.csv')
      ..click();
    html.Url.revokeObjectUrl(url);

    Get.snackbar('Success', 'Reports exported successfully');
  }

  String _getReportedEntity(Report report) {
    if (report.reportedDriverId != null) return 'Driver #${report.reportedDriverId}';
    if (report.reportedClientId != null) return 'Client #${report.reportedClientId}';
    if (report.reportedStoreId != null) return 'Store #${report.reportedStoreId}';
    if (report.reportedOrderId != null) return 'Order #${report.reportedOrderId}';
    return 'N/A';
  }

  String _escapeCsv(String text) {
    if (text.contains(',') || text.contains('"') || text.contains('\n')) {
      return '"${text.replaceAll('"', '""')}"';
    }
    return text;
  }
}
