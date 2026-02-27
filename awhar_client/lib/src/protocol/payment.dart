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
import 'payment_method_enum.dart' as _i2;
import 'payment_status_enum.dart' as _i3;

abstract class Payment implements _i1.SerializableModel {
  Payment._({
    this.id,
    this.subscriptionId,
    this.orderId,
    required this.userId,
    required this.amount,
    String? currency,
    this.paymentMethod,
    this.status,
    this.externalTransactionId,
    this.metadata,
    this.failureReason,
    DateTime? createdAt,
    this.paidAt,
    this.refundedAt,
  }) : currency = currency ?? 'MAD',
       createdAt = createdAt ?? DateTime.now();

  factory Payment({
    int? id,
    int? subscriptionId,
    int? orderId,
    required int userId,
    required double amount,
    String? currency,
    _i2.PaymentMethod? paymentMethod,
    _i3.PaymentStatus? status,
    String? externalTransactionId,
    String? metadata,
    String? failureReason,
    DateTime? createdAt,
    DateTime? paidAt,
    DateTime? refundedAt,
  }) = _PaymentImpl;

  factory Payment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Payment(
      id: jsonSerialization['id'] as int?,
      subscriptionId: jsonSerialization['subscriptionId'] as int?,
      orderId: jsonSerialization['orderId'] as int?,
      userId: jsonSerialization['userId'] as int,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      currency: jsonSerialization['currency'] as String,
      paymentMethod: jsonSerialization['paymentMethod'] == null
          ? null
          : _i2.PaymentMethod.fromJson(
              (jsonSerialization['paymentMethod'] as int),
            ),
      status: jsonSerialization['status'] == null
          ? null
          : _i3.PaymentStatus.fromJson((jsonSerialization['status'] as int)),
      externalTransactionId:
          jsonSerialization['externalTransactionId'] as String?,
      metadata: jsonSerialization['metadata'] as String?,
      failureReason: jsonSerialization['failureReason'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      paidAt: jsonSerialization['paidAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
      refundedAt: jsonSerialization['refundedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['refundedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? subscriptionId;

  int? orderId;

  int userId;

  double amount;

  String currency;

  _i2.PaymentMethod? paymentMethod;

  _i3.PaymentStatus? status;

  String? externalTransactionId;

  String? metadata;

  String? failureReason;

  DateTime createdAt;

  DateTime? paidAt;

  DateTime? refundedAt;

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Payment copyWith({
    int? id,
    int? subscriptionId,
    int? orderId,
    int? userId,
    double? amount,
    String? currency,
    _i2.PaymentMethod? paymentMethod,
    _i3.PaymentStatus? status,
    String? externalTransactionId,
    String? metadata,
    String? failureReason,
    DateTime? createdAt,
    DateTime? paidAt,
    DateTime? refundedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Payment',
      if (id != null) 'id': id,
      if (subscriptionId != null) 'subscriptionId': subscriptionId,
      if (orderId != null) 'orderId': orderId,
      'userId': userId,
      'amount': amount,
      'currency': currency,
      if (paymentMethod != null) 'paymentMethod': paymentMethod?.toJson(),
      if (status != null) 'status': status?.toJson(),
      if (externalTransactionId != null)
        'externalTransactionId': externalTransactionId,
      if (metadata != null) 'metadata': metadata,
      if (failureReason != null) 'failureReason': failureReason,
      'createdAt': createdAt.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (refundedAt != null) 'refundedAt': refundedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PaymentImpl extends Payment {
  _PaymentImpl({
    int? id,
    int? subscriptionId,
    int? orderId,
    required int userId,
    required double amount,
    String? currency,
    _i2.PaymentMethod? paymentMethod,
    _i3.PaymentStatus? status,
    String? externalTransactionId,
    String? metadata,
    String? failureReason,
    DateTime? createdAt,
    DateTime? paidAt,
    DateTime? refundedAt,
  }) : super._(
         id: id,
         subscriptionId: subscriptionId,
         orderId: orderId,
         userId: userId,
         amount: amount,
         currency: currency,
         paymentMethod: paymentMethod,
         status: status,
         externalTransactionId: externalTransactionId,
         metadata: metadata,
         failureReason: failureReason,
         createdAt: createdAt,
         paidAt: paidAt,
         refundedAt: refundedAt,
       );

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Payment copyWith({
    Object? id = _Undefined,
    Object? subscriptionId = _Undefined,
    Object? orderId = _Undefined,
    int? userId,
    double? amount,
    String? currency,
    Object? paymentMethod = _Undefined,
    Object? status = _Undefined,
    Object? externalTransactionId = _Undefined,
    Object? metadata = _Undefined,
    Object? failureReason = _Undefined,
    DateTime? createdAt,
    Object? paidAt = _Undefined,
    Object? refundedAt = _Undefined,
  }) {
    return Payment(
      id: id is int? ? id : this.id,
      subscriptionId: subscriptionId is int?
          ? subscriptionId
          : this.subscriptionId,
      orderId: orderId is int? ? orderId : this.orderId,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      paymentMethod: paymentMethod is _i2.PaymentMethod?
          ? paymentMethod
          : this.paymentMethod,
      status: status is _i3.PaymentStatus? ? status : this.status,
      externalTransactionId: externalTransactionId is String?
          ? externalTransactionId
          : this.externalTransactionId,
      metadata: metadata is String? ? metadata : this.metadata,
      failureReason: failureReason is String?
          ? failureReason
          : this.failureReason,
      createdAt: createdAt ?? this.createdAt,
      paidAt: paidAt is DateTime? ? paidAt : this.paidAt,
      refundedAt: refundedAt is DateTime? ? refundedAt : this.refundedAt,
    );
  }
}
