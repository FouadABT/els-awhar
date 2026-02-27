import 'package:serverpod/serverpod.dart' hide Transaction;
import '../generated/protocol.dart';

/// Transaction endpoint for managing payments and earnings (cash only for MVP)
class TransactionEndpoint extends Endpoint {
  /// Platform commission rate (adjustable for admin dashboard)
  /// Default: 5% - can be changed via admin settings in future
  static double platformCommissionRate = 0.05;
  
  /// Get current platform commission rate
  Future<double> getPlatformCommissionRate(Session session) async {
    return platformCommissionRate;
  }
  
  /// Set platform commission rate (for admin use)
  Future<void> setPlatformCommissionRate(Session session, double rate) async {
    if (rate < 0 || rate > 1) {
      throw Exception('Commission rate must be between 0 and 1 (0% - 100%)');
    }
    platformCommissionRate = rate;
    session.log('[Transaction] Platform commission rate updated to: ${rate * 100}%');
  }

  /// Create a cash payment transaction when client pays driver
  Future<Transaction> recordCashPayment(
    Session session,
    int requestId,
    int clientId,
    int driverId,
    double amount, {
    String? notes,
  }) async {
    session.log('[Transaction] Recording cash payment: Request $requestId, Amount: $amount MAD');

    // Validate request exists and belongs to client
    final request = await ServiceRequest.db.findById(session, requestId);
    if (request == null) {
      throw Exception('Service request not found');
    }
    if (request.clientId != clientId) {
      throw Exception('Request does not belong to client');
    }
    if (request.driverId != driverId) {
      throw Exception('Request is not assigned to this driver');
    }

    // Calculate platform commission (adjustable via admin dashboard)
    final commissionRate = platformCommissionRate;
    final platformCommission = amount * commissionRate;
    final driverEarnings = amount - platformCommission;

    // Create payment transaction (client pays driver)
    final paymentTransaction = Transaction(
      userId: clientId,
      requestId: requestId,
      amount: amount,
      type: TransactionType.payment,
      status: TransactionStatus.completed,
      paymentMethod: 'cash',
      description: 'Payment for service request #$requestId',
      notes: notes,
      platformCommission: platformCommission,
      driverEarnings: driverEarnings,
      completedAt: DateTime.now(),
    );

    final savedPayment = await Transaction.db.insertRow(session, paymentTransaction);
    session.log('[Transaction] ✅ Payment transaction created: ID ${savedPayment.id}');

    // Create earning transaction for driver
    final earningTransaction = Transaction(
      userId: driverId,
      requestId: requestId,
      amount: driverEarnings,
      type: TransactionType.earning,
      status: TransactionStatus.completed,
      paymentMethod: 'cash',
      description: 'Earnings from service request #$requestId',
      platformCommission: platformCommission,
      driverEarnings: driverEarnings,
      completedAt: DateTime.now(),
    );

    await Transaction.db.insertRow(session, earningTransaction);
    session.log('[Transaction] ✅ Earning transaction created for driver $driverId');

    // Update wallet for client
    await _updateClientWallet(session, clientId, amount);

    // Update wallet for driver
    await _updateDriverWallet(session, driverId, driverEarnings, platformCommission);

    // Mark request as paid
    request.isPaid = true;
    await ServiceRequest.db.updateRow(session, request);
    session.log('[Transaction] ✅ Request marked as paid');

    return savedPayment;
  }

  /// Get user transaction history
  Future<List<Transaction>> getTransactionHistory(
    Session session,
    int userId, {
    int? limit,
    int? offset,
  }) async {
    final transactions = await Transaction.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit ?? 50,
      offset: offset ?? 0,
    );

    session.log('[Transaction] Found ${transactions.length} transactions for user $userId');
    return transactions;
  }

  /// Get driver earnings statistics
  Future<DriverEarningsResponse> getDriverEarnings(
    Session session,
    int driverId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    session.log('[Transaction] getDriverEarnings called for driverId: $driverId');
    
    try {
      final start = startDate ?? DateTime.now().subtract(Duration(days: 30));
      final end = endDate ?? DateTime.now();
      
      session.log('[Transaction] Date range: $start to $end');

      // Get all earning transactions for driver
      session.log('[Transaction] Querying transactions...');
      final allEarnings = await Transaction.db.find(
        session,
        where: (t) =>
            t.userId.equals(driverId) &
            t.type.equals(TransactionType.earning) &
            t.status.equals(TransactionStatus.completed),
      );
      session.log('[Transaction] Found ${allEarnings.length} earning transactions');

    // Filter by date range in Dart
    final earnings = allEarnings.where((t) {
      final created = t.createdAt;
      return created.isAfter(start.subtract(Duration(seconds: 1))) && 
             created.isBefore(end.add(Duration(seconds: 1)));
    }).toList();

    // Calculate totals
    double totalEarnings = 0;
    double totalCommission = 0;
    double totalGross = 0;

    for (final transaction in earnings) {
      totalEarnings += transaction.driverEarnings;
      totalCommission += transaction.platformCommission;
      totalGross += transaction.driverEarnings + transaction.platformCommission;
    }

    // Get today's earnings
    final todayStart = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final todayEarnings = earnings.where((t) => t.createdAt.isAfter(todayStart)).toList();
    double todayTotal = 0;
    for (final t in todayEarnings) {
      todayTotal += t.driverEarnings;
    }

    // Get this week's earnings
    final weekStart = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    final weekEarnings = earnings.where((t) => t.createdAt.isAfter(weekStart)).toList();
    double weekTotal = 0;
    for (final t in weekEarnings) {
      weekTotal += t.driverEarnings;
    }

    // Get pending earnings from active/completed rides
    final activeRequests = await ServiceRequest.db.find(
      session,
      where: (r) =>
          r.driverId.equals(driverId) &
          (r.status.equals(RequestStatus.driver_arriving) |
              r.status.equals(RequestStatus.in_progress) |
              r.status.equals(RequestStatus.completed)) &
          r.isPaid.equals(false),
    );

    double pendingEarnings = 0;
    for (final request in activeRequests) {
      if (request.agreedPrice != null) {
        final gross = request.agreedPrice!;
        final commission = gross * platformCommissionRate;
        pendingEarnings += gross - commission;
      }
    }

    session.log('[Transaction] Driver $driverId earnings: Total=$totalEarnings MAD, Today=$todayTotal MAD, Pending=$pendingEarnings MAD');

    return DriverEarningsResponse(
      totalEarnings: totalEarnings,
      totalCommission: totalCommission,
      totalGross: totalGross,
      todayEarnings: todayTotal,
      weekEarnings: weekTotal,
      pendingEarnings: pendingEarnings,
      completedRides: earnings.length,
      activeRides: activeRequests.length,
      transactions: earnings,
    );
    } catch (e, stackTrace) {
      session.log('[Transaction] ❌ ERROR in getDriverEarnings: $e');
      session.log('[Transaction] Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Get wallet for user (creates if doesn't exist)
  Future<Wallet> getWallet(Session session, int userId) async {
    // Try to find existing wallet
    final wallets = await Wallet.db.find(
      session,
      where: (w) => w.userId.equals(userId),
      limit: 1,
    );

    if (wallets.isNotEmpty) {
      return wallets.first;
    }

    // Create new wallet
    final wallet = Wallet(
      userId: userId,
    );

    final savedWallet = await Wallet.db.insertRow(session, wallet);
    session.log('[Transaction] ✅ Wallet created for user $userId');

    return savedWallet;
  }

  /// Update client wallet after payment
  Future<void> _updateClientWallet(Session session, int clientId, double amount) async {
    final wallet = await getWallet(session, clientId);

    wallet.totalSpent = wallet.totalSpent + amount;
    wallet.totalTransactions = wallet.totalTransactions + 1;
    wallet.updatedAt = DateTime.now();
    wallet.lastTransactionAt = DateTime.now();

    await Wallet.db.updateRow(session, wallet);
    session.log('[Transaction] ✅ Client wallet updated: User $clientId, Total spent: ${wallet.totalSpent} MAD');
  }

  /// Update driver wallet after earning
  Future<void> _updateDriverWallet(
    Session session,
    int driverId,
    double earnings,
    double commission,
  ) async {
    final wallet = await getWallet(session, driverId);

    wallet.totalEarned = wallet.totalEarned + earnings;
    wallet.totalCommissionPaid = wallet.totalCommissionPaid + commission;
    wallet.totalTransactions = wallet.totalTransactions + 1;
    wallet.completedRides = wallet.completedRides + 1;
    wallet.updatedAt = DateTime.now();
    wallet.lastTransactionAt = DateTime.now();

    await Wallet.db.updateRow(session, wallet);
    session.log('[Transaction] ✅ Driver wallet updated: User $driverId, Total earned: ${wallet.totalEarned} MAD');
  }

  /// Confirm cash payment received (called by driver after ride completion)
  /// Confirm cash payment (driver side - creates/updates pending transaction)
  Future<Transaction> confirmCashPayment(
    Session session,
    int requestId,
    int driverId, {
    String? notes,
  }) async {
    session.log('[Transaction] Driver $driverId confirming cash payment for request $requestId');

    // Get request
    final request = await ServiceRequest.db.findById(session, requestId);
    if (request == null) {
      throw Exception('Service request not found');
    }
    if (request.driverId != driverId) {
      throw Exception('You are not assigned to this request');
    }
    if (request.status != RequestStatus.completed) {
      throw Exception('Request is not completed yet');
    }
    
    // Use agreedPrice if available (after proposal), otherwise use totalPrice
    final amount = request.agreedPrice ?? request.totalPrice;
    if (amount <= 0) {
      throw Exception('Invalid price for this request');
    }

    // Check if transaction already exists
    final existingTransactions = await Transaction.db.find(
      session,
      where: (t) => t.requestId.equals(requestId),
    );

    Transaction transaction;
    if (existingTransactions.isNotEmpty) {
      // Update existing transaction
      transaction = existingTransactions.first;
      transaction.driverConfirmed = true;
      transaction.driverConfirmedAt = DateTime.now();
      if (notes != null) transaction.notes = notes;
      
      // If both confirmed, complete the payment
      if (transaction.clientConfirmed) {
        transaction.status = TransactionStatus.completed;
        transaction.completedAt = DateTime.now();
        
        // Record the full payment
        final fullTransaction = await recordCashPayment(
          session,
          requestId,
          request.clientId,
          driverId,
          amount,
          notes: notes ?? 'Cash payment confirmed by both parties',
        );
        return fullTransaction;
      }
      
      transaction = await Transaction.db.updateRow(session, transaction);
      session.log('[Transaction] Driver confirmed - waiting for client');
    } else {
      // Create pending transaction
      final commissionRate = await getPlatformCommissionRate(session);
      final commission = amount * commissionRate;
      final earnings = amount - commission;

      transaction = Transaction(
        userId: driverId,
        requestId: requestId,
        amount: amount,
        type: TransactionType.earning,
        status: TransactionStatus.pending,
        paymentMethod: 'cash',
        description: 'Pending cash payment for service request #$requestId',
        notes: notes,
        platformCommission: commission,
        driverEarnings: earnings,
        driverConfirmed: true,
        driverConfirmedAt: DateTime.now(),
      );

      transaction = await Transaction.db.insertRow(session, transaction);
      session.log('[Transaction] Created pending transaction - waiting for client');
    }

    return transaction;
  }

  /// Confirm cash payment (client side - creates/updates pending transaction)
  Future<Transaction> confirmCashPaymentByClient(
    Session session,
    int requestId,
    int clientId, {
    String? notes,
  }) async {
    session.log('[Transaction] Client $clientId confirming cash payment for request $requestId');

    // Get request
    final request = await ServiceRequest.db.findById(session, requestId);
    if (request == null) {
      throw Exception('Service request not found');
    }
    if (request.clientId != clientId) {
      throw Exception('You did not create this request');
    }
    if (request.status != RequestStatus.completed) {
      throw Exception('Request is not completed yet');
    }
    
    // Use agreedPrice if available (after proposal), otherwise use totalPrice
    final amount = request.agreedPrice ?? request.totalPrice;
    if (amount <= 0) {
      throw Exception('Invalid price for this request');
    }

    // Check if transaction already exists
    final existingTransactions = await Transaction.db.find(
      session,
      where: (t) => t.requestId.equals(requestId),
    );

    Transaction transaction;
    if (existingTransactions.isNotEmpty) {
      // Update existing transaction
      transaction = existingTransactions.first;
      transaction.clientConfirmed = true;
      transaction.clientConfirmedAt = DateTime.now();
      if (notes != null) transaction.notes = notes;
      
      // If both confirmed, complete the payment
      if (transaction.driverConfirmed) {
        transaction.status = TransactionStatus.completed;
        transaction.completedAt = DateTime.now();
        
        // Record the full payment
        final fullTransaction = await recordCashPayment(
          session,
          requestId,
          clientId,
          request.driverId!,
          amount,
          notes: notes ?? 'Cash payment confirmed by both parties',
        );
        return fullTransaction;
      }
      
      transaction = await Transaction.db.updateRow(session, transaction);
      session.log('[Transaction] Client confirmed - waiting for driver');
    } else {
      // Create pending transaction
      final commissionRate = await getPlatformCommissionRate(session);
      final commission = amount * commissionRate;
      final earnings = amount - commission;

      transaction = Transaction(
        userId: request.driverId!,
        requestId: requestId,
        amount: amount,
        type: TransactionType.earning,
        status: TransactionStatus.pending,
        paymentMethod: 'cash',
        description: 'Pending cash payment for service request #$requestId',
        notes: notes,
        platformCommission: commission,
        driverEarnings: earnings,
        clientConfirmed: true,
        clientConfirmedAt: DateTime.now(),
      );

      transaction = await Transaction.db.insertRow(session, transaction);
      session.log('[Transaction] Created pending transaction - waiting for driver');
    }

    return transaction;
  }
}
