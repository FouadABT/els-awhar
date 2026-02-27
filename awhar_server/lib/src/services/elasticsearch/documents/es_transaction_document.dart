/// Elasticsearch document for transactions index
/// Maps financial transaction data for revenue analytics and ops monitoring
class EsTransactionDocument {
  final int id;
  final int userId;
  final int? requestId;
  final double amount;
  final String type; // earning, payment, refund, withdrawal
  final String status; // pending, completed, refunded, failed
  final String paymentMethod; // cash, card, wallet
  final String? description;
  final String? notes;
  
  // Financial breakdown
  final double platformCommission;
  final double driverEarnings;
  final bool driverConfirmed;
  final bool clientConfirmed;
  
  // Currency
  final String currency;
  final double? baseCurrencyAmount;
  final double exchangeRateToBase;
  final double vatRate;
  final double vatAmount;
  
  // User info (denormalized)
  final String? userName;
  final String? userRole; // client, driver, store

  // Timestamps
  final DateTime createdAt;
  final DateTime? completedAt;
  final DateTime? refundedAt;
  final DateTime? driverConfirmedAt;
  final DateTime? clientConfirmedAt;

  EsTransactionDocument({
    required this.id,
    required this.userId,
    this.requestId,
    required this.amount,
    required this.type,
    required this.status,
    required this.paymentMethod,
    this.description,
    this.notes,
    required this.platformCommission,
    required this.driverEarnings,
    required this.driverConfirmed,
    required this.clientConfirmed,
    required this.currency,
    this.baseCurrencyAmount,
    required this.exchangeRateToBase,
    required this.vatRate,
    required this.vatAmount,
    this.userName,
    this.userRole,
    required this.createdAt,
    this.completedAt,
    this.refundedAt,
    this.driverConfirmedAt,
    this.clientConfirmedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'transactionId': id,
      'userId': userId,
      'requestId': requestId,
      'amount': amount,
      'type': type,
      'status': status,
      'paymentMethod': paymentMethod,
      'description': description,
      'notes': notes,
      'platformCommission': platformCommission,
      'driverEarnings': driverEarnings,
      'driverConfirmed': driverConfirmed,
      'clientConfirmed': clientConfirmed,
      'currency': currency,
      'baseCurrencyAmount': baseCurrencyAmount,
      'exchangeRateToBase': exchangeRateToBase,
      'vatRate': vatRate,
      'vatAmount': vatAmount,
      'userName': userName,
      'userRole': userRole,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'refundedAt': refundedAt?.toIso8601String(),
      'driverConfirmedAt': driverConfirmedAt?.toIso8601String(),
      'clientConfirmedAt': clientConfirmedAt?.toIso8601String(),
    };
  }

  String get documentId => 'transaction_$id';
}
