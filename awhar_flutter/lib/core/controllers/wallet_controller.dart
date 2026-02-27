import 'package:awhar_client/awhar_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../services/transaction_service.dart';

/// Controller for managing wallet and transaction data
class WalletController extends GetxController {
  final TransactionService _transactionService = Get.find<TransactionService>();

  // Observable state
  final Rx<Wallet?> wallet = Rx<Wallet?>(null);
  final RxList<Transaction> transactions = <Transaction>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Driver earnings state
  final RxDouble totalEarnings = 0.0.obs;
  final RxDouble todayEarnings = 0.0.obs;
  final RxDouble weekEarnings = 0.0.obs;
  final RxDouble monthEarnings = 0.0.obs;
  final RxDouble pendingEarnings = 0.0.obs;
  final RxInt completedRides = 0.obs;
  final RxDouble platformCommission = 0.0.obs;
  final RxDouble commissionRate = 0.05.obs;

  @override
  void onInit() {
    super.onInit();
    loadCommissionRate();
  }

  /// Load platform commission rate
  Future<void> loadCommissionRate() async {
    commissionRate.value = await _transactionService
        .getPlatformCommissionRate();
  }

  /// Load wallet for user
  Future<void> loadWallet(int userId) async {
    try {
      debugPrint('[WalletController] 💼 Loading wallet for userId: $userId');
      isLoading.value = true;
      errorMessage.value = '';

      final walletData = await _transactionService.getWallet(userId: userId);
      debugPrint(
        '[WalletController] 📦 Received wallet data: ${walletData != null ? "SUCCESS" : "NULL"}',
      );

      if (walletData != null) {
        wallet.value = walletData;
        debugPrint(
          '[WalletController] 💰 Wallet - Total Earned: ${walletData.totalEarned}, Total Spent: ${walletData.totalSpent}',
        );
      } else {
        debugPrint('[WalletController] ⚠️ Wallet data is null');
      }
    } catch (e) {
      debugPrint('[WalletController] ❌ Error loading wallet: $e');
      errorMessage.value = 'Failed to load wallet';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
      debugPrint('[WalletController] 🏁 Wallet loading complete');
    }
  }

  /// Load transaction history
  Future<void> loadTransactionHistory(
    int userId, {
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final txList = await _transactionService.getTransactionHistory(
        userId: userId,
        limit: limit,
        offset: offset,
      );
      transactions.value = txList;
    } catch (e) {
      errorMessage.value = 'Failed to load transactions';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  /// Load driver earnings
  Future<void> loadDriverEarnings(
    int driverId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      debugPrint(
        '[WalletController] 📊 Loading driver earnings for driverId: $driverId',
      );
      isLoading.value = true;
      errorMessage.value = '';

      final earnings = await _transactionService.getDriverEarnings(
        driverId: driverId,
        startDate: startDate,
        endDate: endDate,
      );

      debugPrint(
        '[WalletController] 📦 Received earnings data: ${earnings != null ? "SUCCESS" : "NULL"}',
      );

      if (earnings != null) {
        debugPrint(
          '[WalletController] 💰 Total Earnings: ${earnings.totalEarnings}',
        );
        debugPrint(
          '[WalletController] 📅 Today: ${earnings.todayEarnings}, Week: ${earnings.weekEarnings}',
        );
        debugPrint(
          '[WalletController] 🚗 Completed Rides: ${earnings.completedRides}',
        );
        debugPrint(
          '[WalletController] 💸 Commission: ${earnings.totalCommission}',
        );

        totalEarnings.value = earnings.totalEarnings;
        todayEarnings.value = earnings.todayEarnings;
        weekEarnings.value = earnings.weekEarnings;
        monthEarnings.value =
            earnings.totalEarnings; // Use total for month if not provided
        pendingEarnings.value = earnings.pendingEarnings;
        completedRides.value = earnings.completedRides;
        platformCommission.value = earnings.totalCommission;

        // Load transactions from earnings
        if (earnings.transactions != null) {
          debugPrint(
            '[WalletController] 📜 Loading ${earnings.transactions!.length} transactions',
          );
          transactions.value = earnings.transactions!;
        } else {
          debugPrint('[WalletController] ⚠️ No transactions in earnings data');
          transactions.value = [];
        }

        debugPrint('[WalletController] ✅ Earnings data loaded successfully');
      } else {
        debugPrint('[WalletController] ⚠️ Earnings data is null');
      }
    } catch (e) {
      debugPrint('[WalletController] ❌ Error loading earnings: $e');
      errorMessage.value = 'Failed to load earnings';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
      debugPrint('[WalletController] 🏁 Loading complete. isLoading: false');
    }
  }

  /// Confirm cash payment (driver side)
  Future<bool> confirmCashPayment({
    required int requestId,
    required int driverId,
    String? notes,
  }) async {
    try {
      debugPrint(
        '[WalletController] 💵 Driver confirming cash payment for request $requestId',
      );
      isLoading.value = true;
      errorMessage.value = '';

      final transaction = await _transactionService.confirmCashPayment(
        requestId: requestId,
        driverId: driverId,
        notes: notes,
      );

      if (transaction != null) {
        debugPrint('[WalletController] ✅ Payment confirmed by driver');
        debugPrint(
          '[WalletController] ⚠️ Transaction status: ${transaction.status.name}',
        );
        debugPrint(
          '[WalletController] ⏳ Waiting for CLIENT to also confirm payment for transaction to complete',
        );

        Get.snackbar(
          'Success',
          'Payment confirmed! Waiting for client confirmation.',
          snackPosition: SnackPosition.BOTTOM,
        );

        // Reload earnings
        await loadDriverEarnings(driverId);
        return true;
      } else {
        errorMessage.value = 'Failed to confirm payment';
        Get.snackbar('Error', errorMessage.value);
        return false;
      }
    } catch (e) {
      debugPrint('[WalletController] ❌ Error confirming payment: $e');
      errorMessage.value = 'Failed to confirm payment: $e';
      Get.snackbar('Error', errorMessage.value);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Confirm cash payment (client side)
  Future<bool> confirmCashPaymentByClient({
    required int requestId,
    required int clientId,
    String? notes,
  }) async {
    try {
      debugPrint(
        '[WalletController] 💵 Client confirming cash payment for request $requestId',
      );
      isLoading.value = true;
      errorMessage.value = '';

      final transaction = await _transactionService.confirmCashPaymentByClient(
        requestId: requestId,
        clientId: clientId,
        notes: notes,
      );

      if (transaction != null) {
        debugPrint('[WalletController] ✅ Payment confirmed by client');
        debugPrint(
          '[WalletController] 💰 Transaction completed! Status: ${transaction.status.name}',
        );
        debugPrint(
          '[WalletController] 💵 Amount: ${transaction.amount}, Driver Earnings: ${transaction.driverEarnings}',
        );

        Get.snackbar(
          'Success',
          'Payment confirmed! Transaction completed.',
          snackPosition: SnackPosition.BOTTOM,
        );

        // Reload transaction history
        await loadTransactionHistory(clientId);
        return true;
      } else {
        errorMessage.value = 'Failed to confirm payment';
        Get.snackbar('Error', errorMessage.value);
        return false;
      }
    } catch (e) {
      debugPrint('[WalletController] ❌ Error confirming payment: $e');
      errorMessage.value = 'Failed to confirm payment: $e';
      Get.snackbar('Error', errorMessage.value);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh all wallet data
  Future<void> refreshData(int userId, {bool isDriver = false}) async {
    await loadWallet(userId);
    if (isDriver) {
      await loadDriverEarnings(userId);
    } else {
      await loadTransactionHistory(userId);
    }
  }
}
