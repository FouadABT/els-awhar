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

abstract class OrderTracking implements _i1.SerializableModel {
  OrderTracking._({
    this.id,
    required this.orderId,
    required this.driverId,
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.speed,
    this.heading,
    DateTime? recordedAt,
  }) : recordedAt = recordedAt ?? DateTime.now();

  factory OrderTracking({
    int? id,
    required int orderId,
    required int driverId,
    required double latitude,
    required double longitude,
    double? accuracy,
    double? speed,
    double? heading,
    DateTime? recordedAt,
  }) = _OrderTrackingImpl;

  factory OrderTracking.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderTracking(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      driverId: jsonSerialization['driverId'] as int,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      accuracy: (jsonSerialization['accuracy'] as num?)?.toDouble(),
      speed: (jsonSerialization['speed'] as num?)?.toDouble(),
      heading: (jsonSerialization['heading'] as num?)?.toDouble(),
      recordedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['recordedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int orderId;

  int driverId;

  double latitude;

  double longitude;

  double? accuracy;

  double? speed;

  double? heading;

  DateTime recordedAt;

  /// Returns a shallow copy of this [OrderTracking]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderTracking copyWith({
    int? id,
    int? orderId,
    int? driverId,
    double? latitude,
    double? longitude,
    double? accuracy,
    double? speed,
    double? heading,
    DateTime? recordedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderTracking',
      if (id != null) 'id': id,
      'orderId': orderId,
      'driverId': driverId,
      'latitude': latitude,
      'longitude': longitude,
      if (accuracy != null) 'accuracy': accuracy,
      if (speed != null) 'speed': speed,
      if (heading != null) 'heading': heading,
      'recordedAt': recordedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderTrackingImpl extends OrderTracking {
  _OrderTrackingImpl({
    int? id,
    required int orderId,
    required int driverId,
    required double latitude,
    required double longitude,
    double? accuracy,
    double? speed,
    double? heading,
    DateTime? recordedAt,
  }) : super._(
         id: id,
         orderId: orderId,
         driverId: driverId,
         latitude: latitude,
         longitude: longitude,
         accuracy: accuracy,
         speed: speed,
         heading: heading,
         recordedAt: recordedAt,
       );

  /// Returns a shallow copy of this [OrderTracking]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderTracking copyWith({
    Object? id = _Undefined,
    int? orderId,
    int? driverId,
    double? latitude,
    double? longitude,
    Object? accuracy = _Undefined,
    Object? speed = _Undefined,
    Object? heading = _Undefined,
    DateTime? recordedAt,
  }) {
    return OrderTracking(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      driverId: driverId ?? this.driverId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracy: accuracy is double? ? accuracy : this.accuracy,
      speed: speed is double? ? speed : this.speed,
      heading: heading is double? ? heading : this.heading,
      recordedAt: recordedAt ?? this.recordedAt,
    );
  }
}
