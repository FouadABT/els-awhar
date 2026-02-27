/// Elasticsearch document for wallets index
/// Maps wallet/financial data for ops monitoring and growth analytics
class EsWalletDocument {
  final int id;
  final int userId;
  final double totalEarned;
  final double totalSpent;
  final double pendingEarnings;
  final int totalTransactions;
  final int completedRides;
  final double totalCommissionPaid;
  final String currency;
  
  // User info (denormalized)
  final String? userName;
  final String? userRole;
  
  // Timestamps
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastTransactionAt;

  EsWalletDocument({
    required this.id,
    required this.userId,
    required this.totalEarned,
    required this.totalSpent,
    required this.pendingEarnings,
    required this.totalTransactions,
    required this.completedRides,
    required this.totalCommissionPaid,
    required this.currency,
    this.userName,
    this.userRole,
    required this.createdAt,
    required this.updatedAt,
    this.lastTransactionAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'walletId': id,
      'userId': userId,
      'totalEarned': totalEarned,
      'totalSpent': totalSpent,
      'pendingEarnings': pendingEarnings,
      'balance': totalEarned - totalSpent,
      'totalTransactions': totalTransactions,
      'completedRides': completedRides,
      'totalCommissionPaid': totalCommissionPaid,
      'currency': currency,
      'userName': userName,
      'userRole': userRole,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'lastTransactionAt': lastTransactionAt?.toIso8601String(),
    };
  }

  String get documentId => 'wallet_$id';
}
