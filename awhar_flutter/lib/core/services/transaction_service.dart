import 'package:awhar_client/awhar_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Service for managing cash transactions and earnings
class TransactionService extends GetxService {
  final Client _client = Get.find<Client>();

  /// Confirm cash payment received (driver side)
  Future<Transaction?> confirmCashPayment({
    required int requestId,
    required int driverId,
    String? notes,
  }) async {
    try {
      debugPrint('[TransactionService] Confirming cash payment for request: $requestId');
      final transaction = await _client.transaction.confirmCashPayment(
        requestId,
        driverId,
        notes: notes,
      );
      debugPrint('[TransactionService] ✅ Cash payment confirmed');
      return transaction;
    } catch (e) {
      debugPrint('[TransactionService] ❌ Error confirming payment: $e');
      return null;
    }
  }

  /// Confirm cash payment made (client side)
  Future<Transaction?> confirmCashPaymentByClient({
    required int requestId,
    required int clientId,
    String? notes,
  }) async {
    try {
      debugPrint('[TransactionService] Client confirming cash payment for request: $requestId');
      final transaction = await _client.transaction.confirmCashPaymentByClient(
        requestId,
        clientId,
        notes: notes,
      );
      debugPrint('[TransactionService] ✅ Client payment confirmed');
      return transaction;
    } catch (e) {
      debugPrint('[TransactionService] ❌ Error confirming payment by client: $e');
      return null;
    }
  }

  /// Get transaction history for user
  Future<List<Transaction>> getTransactionHistory({
    required int userId,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      debugPrint('[TransactionService] Fetching transaction history for user $userId');
      final transactions = await _client.transaction.getTransactionHistory(
        userId,
        limit: limit,
        offset: offset,
      );
      debugPrint('[TransactionService] Found ${transactions.length} transactions');
      return transactions;
    } catch (e) {
      debugPrint('[TransactionService] Error fetching transactions: $e');
      return [];
    }
  }

  /// Get driver earnings statistics
  Future<DriverEarningsResponse?> getDriverEarnings({
    required int driverId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      debugPrint('[TransactionService] Fetching driver earnings for driver $driverId');
      final earnings = await _client.transaction.getDriverEarnings(
        driverId,
        startDate: startDate,
        endDate: endDate,
      );
      debugPrint('[TransactionService] Driver earnings: ${earnings.totalEarnings}');
      return earnings;
    } catch (e) {
      debugPrint('[TransactionService] Error fetching earnings: $e');
      return null;
    }
  }

  /// Get wallet for user
  Future<Wallet?> getWallet({required int userId}) async {
    try {
      debugPrint('[TransactionService] Fetching wallet for user: $userId');
      final wallet = await _client.transaction.getWallet(userId);
      debugPrint('[TransactionService] ✅ Wallet fetched');
      return wallet;
    } catch (e) {
      debugPrint('[TransactionService] ❌ Error fetching wallet: $e');
      return null;
    }
  }

  /// Get platform commission rate
  Future<double> getPlatformCommissionRate() async {
    try {
      final rate = await _client.transaction.getPlatformCommissionRate();
      return rate;
    } catch (e) {
      debugPrint('[TransactionService] ❌ Error fetching commission rate: $e');
      return 0.05; // Default 5%
    }
  }
}
