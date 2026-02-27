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
import 'order_status_enum.dart' as _i2;

abstract class OrderStatusHistory implements _i1.SerializableModel {
  OrderStatusHistory._({
    this.id,
    required this.orderId,
    this.fromStatus,
    this.toStatus,
    required this.changedByUserId,
    this.notes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory OrderStatusHistory({
    int? id,
    required int orderId,
    _i2.OrderStatus? fromStatus,
    _i2.OrderStatus? toStatus,
    required int changedByUserId,
    String? notes,
    DateTime? createdAt,
  }) = _OrderStatusHistoryImpl;

  factory OrderStatusHistory.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderStatusHistory(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      fromStatus: jsonSerialization['fromStatus'] == null
          ? null
          : _i2.OrderStatus.fromJson((jsonSerialization['fromStatus'] as int)),
      toStatus: jsonSerialization['toStatus'] == null
          ? null
          : _i2.OrderStatus.fromJson((jsonSerialization['toStatus'] as int)),
      changedByUserId: jsonSerialization['changedByUserId'] as int,
      notes: jsonSerialization['notes'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int orderId;

  _i2.OrderStatus? fromStatus;

  _i2.OrderStatus? toStatus;

  int changedByUserId;

  String? notes;

  DateTime createdAt;

  /// Returns a shallow copy of this [OrderStatusHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderStatusHistory copyWith({
    int? id,
    int? orderId,
    _i2.OrderStatus? fromStatus,
    _i2.OrderStatus? toStatus,
    int? changedByUserId,
    String? notes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderStatusHistory',
      if (id != null) 'id': id,
      'orderId': orderId,
      if (fromStatus != null) 'fromStatus': fromStatus?.toJson(),
      if (toStatus != null) 'toStatus': toStatus?.toJson(),
      'changedByUserId': changedByUserId,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderStatusHistoryImpl extends OrderStatusHistory {
  _OrderStatusHistoryImpl({
    int? id,
    required int orderId,
    _i2.OrderStatus? fromStatus,
    _i2.OrderStatus? toStatus,
    required int changedByUserId,
    String? notes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         orderId: orderId,
         fromStatus: fromStatus,
         toStatus: toStatus,
         changedByUserId: changedByUserId,
         notes: notes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [OrderStatusHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderStatusHistory copyWith({
    Object? id = _Undefined,
    int? orderId,
    Object? fromStatus = _Undefined,
    Object? toStatus = _Undefined,
    int? changedByUserId,
    Object? notes = _Undefined,
    DateTime? createdAt,
  }) {
    return OrderStatusHistory(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      fromStatus: fromStatus is _i2.OrderStatus? ? fromStatus : this.fromStatus,
      toStatus: toStatus is _i2.OrderStatus? ? toStatus : this.toStatus,
      changedByUserId: changedByUserId ?? this.changedByUserId,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
