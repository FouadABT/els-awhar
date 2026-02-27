/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Wallet implements _i1.SerializableModel {
  Wallet._({
    this.id,
    required this.userId,
    double? totalEarned,
    double? totalSpent,
    double? pendingEarnings,
    int? totalTransactions,
    int? completedRides,
    double? totalCommissionPaid,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.lastTransactionAt,
  }) : totalEarned = totalEarned ?? 0.0,
       totalSpent = totalSpent ?? 0.0,
       pendingEarnings = pendingEarnings ?? 0.0,
       totalTransactions = totalTransactions ?? 0,
       completedRides = completedRides ?? 0,
       totalCommissionPaid = totalCommissionPaid ?? 0.0,
       currency = currency ?? 'MAD',
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Wallet({
    int? id,
    required int userId,
    double? totalEarned,
    double? totalSpent,
    double? pendingEarnings,
    int? totalTransactions,
    int? completedRides,
    double? totalCommissionPaid,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastTransactionAt,
  }) = _WalletImpl;

  factory Wallet.fromJson(Map<String, dynamic> jsonSerialization) {
    return Wallet(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      totalEarned: (jsonSerialization['totalEarned'] as num).toDouble(),
      totalSpent: (jsonSerialization['totalSpent'] as num).toDouble(),
      pendingEarnings: (jsonSerialization['pendingEarnings'] as num).toDouble(),
      totalTransactions: jsonSerialization['totalTransactions'] as int,
      completedRides: jsonSerialization['completedRides'] as int,
      totalCommissionPaid: (jsonSerialization['totalCommissionPaid'] as num)
          .toDouble(),
      currency: jsonSerialization['currency'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      lastTransactionAt: jsonSerialization['lastTransactionAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastTransactionAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  double totalEarned;

  double totalSpent;

  double pendingEarnings;

  int totalTransactions;

  int completedRides;

  double totalCommissionPaid;

  String currency;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? lastTransactionAt;

  /// Returns a shallow copy of this [Wallet]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Wallet copyWith({
    int? id,
    int? userId,
    double? totalEarned,
    double? totalSpent,
    double? pendingEarnings,
    int? totalTransactions,
    int? completedRides,
    double? totalCommissionPaid,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastTransactionAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Wallet',
      if (id != null) 'id': id,
      'userId': userId,
      'totalEarned': totalEarned,
      'totalSpent': totalSpent,
      'pendingEarnings': pendingEarnings,
      'totalTransactions': totalTransactions,
      'completedRides': completedRides,
      'totalCommissionPaid': totalCommissionPaid,
      'currency': currency,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (lastTransactionAt != null)
        'lastTransactionAt': lastTransactionAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WalletImpl extends Wallet {
  _WalletImpl({
    int? id,
    required int userId,
    double? totalEarned,
    double? totalSpent,
    double? pendingEarnings,
    int? totalTransactions,
    int? completedRides,
    double? totalCommissionPaid,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastTransactionAt,
  }) : super._(
         id: id,
         userId: userId,
         totalEarned: totalEarned,
         totalSpent: totalSpent,
         pendingEarnings: pendingEarnings,
         totalTransactions: totalTransactions,
         completedRides: completedRides,
         totalCommissionPaid: totalCommissionPaid,
         currency: currency,
         createdAt: createdAt,
         updatedAt: updatedAt,
         lastTransactionAt: lastTransactionAt,
       );

  /// Returns a shallow copy of this [Wallet]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Wallet copyWith({
    Object? id = _Undefined,
    int? userId,
    double? totalEarned,
    double? totalSpent,
    double? pendingEarnings,
    int? totalTransactions,
    int? completedRides,
    double? totalCommissionPaid,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? lastTransactionAt = _Undefined,
  }) {
    return Wallet(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      totalEarned: totalEarned ?? this.totalEarned,
      totalSpent: totalSpent ?? this.totalSpent,
      pendingEarnings: pendingEarnings ?? this.pendingEarnings,
      totalTransactions: totalTransactions ?? this.totalTransactions,
      completedRides: completedRides ?? this.completedRides,
      totalCommissionPaid: totalCommissionPaid ?? this.totalCommissionPaid,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastTransactionAt: lastTransactionAt is DateTime?
          ? lastTransactionAt
          : this.lastTransactionAt,
    );
  }
}
