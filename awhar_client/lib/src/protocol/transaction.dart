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
import 'transaction_status.dart' as _i2;
import 'transaction_type.dart' as _i3;

abstract class Transaction implements _i1.SerializableModel {
  Transaction._({
    this.id,
    required this.userId,
    this.requestId,
    required this.amount,
    required this.type,
    _i2.TransactionStatus? status,
    String? paymentMethod,
    String? currency,
    String? currencySymbol,
    this.baseCurrencyAmount,
    double? exchangeRateToBase,
    double? vatRate,
    double? vatAmount,
    this.description,
    this.notes,
    double? platformCommission,
    double? driverEarnings,
    bool? driverConfirmed,
    bool? clientConfirmed,
    this.driverConfirmedAt,
    this.clientConfirmedAt,
    DateTime? createdAt,
    this.completedAt,
    this.refundedAt,
  }) : status = status ?? _i2.TransactionStatus.completed,
       paymentMethod = paymentMethod ?? 'cash',
       currency = currency ?? 'MAD',
       currencySymbol = currencySymbol ?? 'DH',
       exchangeRateToBase = exchangeRateToBase ?? 1.0,
       vatRate = vatRate ?? 0.0,
       vatAmount = vatAmount ?? 0.0,
       platformCommission = platformCommission ?? 0.0,
       driverEarnings = driverEarnings ?? 0.0,
       driverConfirmed = driverConfirmed ?? false,
       clientConfirmed = clientConfirmed ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory Transaction({
    int? id,
    required int userId,
    int? requestId,
    required double amount,
    required _i3.TransactionType type,
    _i2.TransactionStatus? status,
    String? paymentMethod,
    String? currency,
    String? currencySymbol,
    double? baseCurrencyAmount,
    double? exchangeRateToBase,
    double? vatRate,
    double? vatAmount,
    String? description,
    String? notes,
    double? platformCommission,
    double? driverEarnings,
    bool? driverConfirmed,
    bool? clientConfirmed,
    DateTime? driverConfirmedAt,
    DateTime? clientConfirmedAt,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? refundedAt,
  }) = _TransactionImpl;

  factory Transaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return Transaction(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      requestId: jsonSerialization['requestId'] as int?,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      type: _i3.TransactionType.fromJson((jsonSerialization['type'] as String)),
      status: _i2.TransactionStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      paymentMethod: jsonSerialization['paymentMethod'] as String,
      currency: jsonSerialization['currency'] as String,
      currencySymbol: jsonSerialization['currencySymbol'] as String,
      baseCurrencyAmount: (jsonSerialization['baseCurrencyAmount'] as num?)
          ?.toDouble(),
      exchangeRateToBase: (jsonSerialization['exchangeRateToBase'] as num)
          .toDouble(),
      vatRate: (jsonSerialization['vatRate'] as num).toDouble(),
      vatAmount: (jsonSerialization['vatAmount'] as num).toDouble(),
      description: jsonSerialization['description'] as String?,
      notes: jsonSerialization['notes'] as String?,
      platformCommission: (jsonSerialization['platformCommission'] as num)
          .toDouble(),
      driverEarnings: (jsonSerialization['driverEarnings'] as num).toDouble(),
      driverConfirmed: jsonSerialization['driverConfirmed'] as bool,
      clientConfirmed: jsonSerialization['clientConfirmed'] as bool,
      driverConfirmedAt: jsonSerialization['driverConfirmedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['driverConfirmedAt'],
            ),
      clientConfirmedAt: jsonSerialization['clientConfirmedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['clientConfirmedAt'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      refundedAt: jsonSerialization['refundedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['refundedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int? requestId;

  double amount;

  _i3.TransactionType type;

  _i2.TransactionStatus status;

  String paymentMethod;

  String currency;

  String currencySymbol;

  double? baseCurrencyAmount;

  double exchangeRateToBase;

  double vatRate;

  double vatAmount;

  String? description;

  String? notes;

  double platformCommission;

  double driverEarnings;

  bool driverConfirmed;

  bool clientConfirmed;

  DateTime? driverConfirmedAt;

  DateTime? clientConfirmedAt;

  DateTime createdAt;

  DateTime? completedAt;

  DateTime? refundedAt;

  /// Returns a shallow copy of this [Transaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Transaction copyWith({
    int? id,
    int? userId,
    int? requestId,
    double? amount,
    _i3.TransactionType? type,
    _i2.TransactionStatus? status,
    String? paymentMethod,
    String? currency,
    String? currencySymbol,
    double? baseCurrencyAmount,
    double? exchangeRateToBase,
    double? vatRate,
    double? vatAmount,
    String? description,
    String? notes,
    double? platformCommission,
    double? driverEarnings,
    bool? driverConfirmed,
    bool? clientConfirmed,
    DateTime? driverConfirmedAt,
    DateTime? clientConfirmedAt,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? refundedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Transaction',
      if (id != null) 'id': id,
      'userId': userId,
      if (requestId != null) 'requestId': requestId,
      'amount': amount,
      'type': type.toJson(),
      'status': status.toJson(),
      'paymentMethod': paymentMethod,
      'currency': currency,
      'currencySymbol': currencySymbol,
      if (baseCurrencyAmount != null) 'baseCurrencyAmount': baseCurrencyAmount,
      'exchangeRateToBase': exchangeRateToBase,
      'vatRate': vatRate,
      'vatAmount': vatAmount,
      if (description != null) 'description': description,
      if (notes != null) 'notes': notes,
      'platformCommission': platformCommission,
      'driverEarnings': driverEarnings,
      'driverConfirmed': driverConfirmed,
      'clientConfirmed': clientConfirmed,
      if (driverConfirmedAt != null)
        'driverConfirmedAt': driverConfirmedAt?.toJson(),
      if (clientConfirmedAt != null)
        'clientConfirmedAt': clientConfirmedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (refundedAt != null) 'refundedAt': refundedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TransactionImpl extends Transaction {
  _TransactionImpl({
    int? id,
    required int userId,
    int? requestId,
    required double amount,
    required _i3.TransactionType type,
    _i2.TransactionStatus? status,
    String? paymentMethod,
    String? currency,
    String? currencySymbol,
    double? baseCurrencyAmount,
    double? exchangeRateToBase,
    double? vatRate,
    double? vatAmount,
    String? description,
    String? notes,
    double? platformCommission,
    double? driverEarnings,
    bool? driverConfirmed,
    bool? clientConfirmed,
    DateTime? driverConfirmedAt,
    DateTime? clientConfirmedAt,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? refundedAt,
  }) : super._(
         id: id,
         userId: userId,
         requestId: requestId,
         amount: amount,
         type: type,
         status: status,
         paymentMethod: paymentMethod,
         currency: currency,
         currencySymbol: currencySymbol,
         baseCurrencyAmount: baseCurrencyAmount,
         exchangeRateToBase: exchangeRateToBase,
         vatRate: vatRate,
         vatAmount: vatAmount,
         description: description,
         notes: notes,
         platformCommission: platformCommission,
         driverEarnings: driverEarnings,
         driverConfirmed: driverConfirmed,
         clientConfirmed: clientConfirmed,
         driverConfirmedAt: driverConfirmedAt,
         clientConfirmedAt: clientConfirmedAt,
         createdAt: createdAt,
         completedAt: completedAt,
         refundedAt: refundedAt,
       );

  /// Returns a shallow copy of this [Transaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Transaction copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? requestId = _Undefined,
    double? amount,
    _i3.TransactionType? type,
    _i2.TransactionStatus? status,
    String? paymentMethod,
    String? currency,
    String? currencySymbol,
    Object? baseCurrencyAmount = _Undefined,
    double? exchangeRateToBase,
    double? vatRate,
    double? vatAmount,
    Object? description = _Undefined,
    Object? notes = _Undefined,
    double? platformCommission,
    double? driverEarnings,
    bool? driverConfirmed,
    bool? clientConfirmed,
    Object? driverConfirmedAt = _Undefined,
    Object? clientConfirmedAt = _Undefined,
    DateTime? createdAt,
    Object? completedAt = _Undefined,
    Object? refundedAt = _Undefined,
  }) {
    return Transaction(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      requestId: requestId is int? ? requestId : this.requestId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      baseCurrencyAmount: baseCurrencyAmount is double?
          ? baseCurrencyAmount
          : this.baseCurrencyAmount,
      exchangeRateToBase: exchangeRateToBase ?? this.exchangeRateToBase,
      vatRate: vatRate ?? this.vatRate,
      vatAmount: vatAmount ?? this.vatAmount,
      description: description is String? ? description : this.description,
      notes: notes is String? ? notes : this.notes,
      platformCommission: platformCommission ?? this.platformCommission,
      driverEarnings: driverEarnings ?? this.driverEarnings,
      driverConfirmed: driverConfirmed ?? this.driverConfirmed,
      clientConfirmed: clientConfirmed ?? this.clientConfirmed,
      driverConfirmedAt: driverConfirmedAt is DateTime?
          ? driverConfirmedAt
          : this.driverConfirmedAt,
      clientConfirmedAt: clientConfirmedAt is DateTime?
          ? clientConfirmedAt
          : this.clientConfirmedAt,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      refundedAt: refundedAt is DateTime? ? refundedAt : this.refundedAt,
    );
  }
}
