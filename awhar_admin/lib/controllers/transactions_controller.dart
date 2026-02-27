import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:intl/intl.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import '../core/services/api_service.dart';

/// Transactions controller - manages transactions with real data
class TransactionsController extends GetxController {
  // Loading state
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Transactions list
  final RxList<Transaction> transactions = <Transaction>[].obs;

  // Pagination
  final RxInt currentPage = 1.obs;
  final RxInt totalCount = 0.obs;
  final RxInt pageSize = 20.obs;

  // Filters
  final Rx<TransactionStatus?> statusFilter = Rx<TransactionStatus?>(null);
  
  // Search
  final RxString searchQuery = ''.obs;

  // Computed totals
  double get totalAmount => transactions.fold(0, (sum, t) => sum + t.amount);
  double get totalCommission => transactions.fold(0, (sum, t) => sum + t.platformCommission);
  int get completedCount => transactions.where((t) => t.status == TransactionStatus.completed).length;

  // Filtered transactions based on search query
  List<Transaction> get filteredTransactions {
    if (searchQuery.value.isEmpty) {
      return transactions;
    }
    
    final query = searchQuery.value.toLowerCase();
    return transactions.where((transaction) {
      final id = 'txn${transaction.id ?? 0}'.toLowerCase();
      final userId = 'user${transaction.userId}'.toLowerCase();
      final description = (transaction.description ?? '').toLowerCase();
      final amount = transaction.amount.toString();
      
      return id.contains(query) || 
             userId.contains(query) || 
             description.contains(query) ||
             amount.contains(query);
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
  }

  /// Load transactions from the server
  Future<void> loadTransactions() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      if (!ApiService.instance.isInitialized) {
        throw Exception('API not initialized');
      }

      final result = await ApiService.instance.client.admin.listTransactions(
        page: currentPage.value,
        limit: pageSize.value,
        statusFilter: statusFilter.value,
      );

      transactions.value = result;
      totalCount.value = result.length;
      debugPrint('[TransactionsController] Loaded ${result.length} transactions');
    } catch (e) {
      debugPrint('[TransactionsController] Error loading transactions: $e');
      errorMessage.value = 'Failed to load transactions';
    } finally {
      isLoading.value = false;
    }
  }

  /// Go to a specific page
  void goToPage(int page) {
    currentPage.value = page;
    loadTransactions();
  }

  /// Set status filter
  void setStatusFilter(TransactionStatus? status) {
    statusFilter.value = status;
    loadTransactions();
  }

  /// Refresh the list
  @override
  Future<void> refresh() async {
    currentPage.value = 1;
    await loadTransactions();
  }

  /// Export transactions to CSV
  void exportTransactions() {
    try {
      // CSV header
      final csv = StringBuffer();
      csv.writeln('Transaction ID,Type,User ID,Request ID,Amount,Commission,Driver Earnings,Payment Method,Status,Description,Created At,Completed At');
      
      // CSV rows
      for (final transaction in transactions) {
        final row = [
          'TXN${transaction.id ?? 0}',
          transaction.type.name,
          'User ${transaction.userId}',
          transaction.requestId != null ? 'Request ${transaction.requestId}' : '',
          transaction.amount.toStringAsFixed(2),
          transaction.platformCommission.toStringAsFixed(2),
          transaction.driverEarnings.toStringAsFixed(2),
          transaction.paymentMethod ?? '',
          transaction.status.name,
          '"${(transaction.description ?? '').replaceAll('"', '""')}"',
          DateFormat('yyyy-MM-dd HH:mm').format(transaction.createdAt),
          transaction.completedAt != null ? DateFormat('yyyy-MM-dd HH:mm').format(transaction.completedAt!) : '',
        ].join(',');
        csv.writeln(row);
      }

      // Create blob and download
      final bytes = csv.toString().codeUnits;
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'transactions_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.csv')
        ..click();
      html.Url.revokeObjectUrl(url);

      debugPrint('[TransactionsController] Exported ${transactions.length} transactions to CSV');
      Get.snackbar('Success', 'Transactions exported successfully');
    } catch (e) {
      debugPrint('[TransactionsController] Error exporting transactions: $e');
      Get.snackbar('Error', 'Failed to export transactions');
    }
  }
}
