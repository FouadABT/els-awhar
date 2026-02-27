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
import 'subscription_status_enum.dart' as _i2;

abstract class Subscription implements _i1.SerializableModel {
  Subscription._({
    this.id,
    required this.driverId,
    required this.planId,
    required this.startDate,
    required this.endDate,
    this.status,
    bool? autoRenew,
    this.cancelledAt,
    this.cancellationReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : autoRenew = autoRenew ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Subscription({
    int? id,
    required int driverId,
    required int planId,
    required DateTime startDate,
    required DateTime endDate,
    _i2.SubscriptionStatus? status,
    bool? autoRenew,
    DateTime? cancelledAt,
    String? cancellationReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubscriptionImpl;

  factory Subscription.fromJson(Map<String, dynamic> jsonSerialization) {
    return Subscription(
      id: jsonSerialization['id'] as int?,
      driverId: jsonSerialization['driverId'] as int,
      planId: jsonSerialization['planId'] as int,
      startDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDate'],
      ),
      endDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      status: jsonSerialization['status'] == null
          ? null
          : _i2.SubscriptionStatus.fromJson(
              (jsonSerialization['status'] as int),
            ),
      autoRenew: jsonSerialization['autoRenew'] as bool,
      cancelledAt: jsonSerialization['cancelledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['cancelledAt'],
            ),
      cancellationReason: jsonSerialization['cancellationReason'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int driverId;

  int planId;

  DateTime startDate;

  DateTime endDate;

  _i2.SubscriptionStatus? status;

  bool autoRenew;

  DateTime? cancelledAt;

  String? cancellationReason;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Subscription]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Subscription copyWith({
    int? id,
    int? driverId,
    int? planId,
    DateTime? startDate,
    DateTime? endDate,
    _i2.SubscriptionStatus? status,
    bool? autoRenew,
    DateTime? cancelledAt,
    String? cancellationReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Subscription',
      if (id != null) 'id': id,
      'driverId': driverId,
      'planId': planId,
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      if (status != null) 'status': status?.toJson(),
      'autoRenew': autoRenew,
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
      if (cancellationReason != null) 'cancellationReason': cancellationReason,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubscriptionImpl extends Subscription {
  _SubscriptionImpl({
    int? id,
    required int driverId,
    required int planId,
    required DateTime startDate,
    required DateTime endDate,
    _i2.SubscriptionStatus? status,
    bool? autoRenew,
    DateTime? cancelledAt,
    String? cancellationReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         driverId: driverId,
         planId: planId,
         startDate: startDate,
         endDate: endDate,
         status: status,
         autoRenew: autoRenew,
         cancelledAt: cancelledAt,
         cancellationReason: cancellationReason,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Subscription]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Subscription copyWith({
    Object? id = _Undefined,
    int? driverId,
    int? planId,
    DateTime? startDate,
    DateTime? endDate,
    Object? status = _Undefined,
    bool? autoRenew,
    Object? cancelledAt = _Undefined,
    Object? cancellationReason = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Subscription(
      id: id is int? ? id : this.id,
      driverId: driverId ?? this.driverId,
      planId: planId ?? this.planId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status is _i2.SubscriptionStatus? ? status : this.status,
      autoRenew: autoRenew ?? this.autoRenew,
      cancelledAt: cancelledAt is DateTime? ? cancelledAt : this.cancelledAt,
      cancellationReason: cancellationReason is String?
          ? cancellationReason
          : this.cancellationReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
