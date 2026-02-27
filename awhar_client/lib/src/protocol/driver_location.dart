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

abstract class DriverLocation implements _i1.SerializableModel {
  DriverLocation._({
    required this.driverId,
    required this.latitude,
    required this.longitude,
    this.speed,
    this.heading,
    this.accuracy,
    this.altitude,
    DateTime? timestamp,
    bool? isMoving,
    this.batteryLevel,
  }) : timestamp = timestamp ?? DateTime.now(),
       isMoving = isMoving ?? false;

  factory DriverLocation({
    required int driverId,
    required double latitude,
    required double longitude,
    double? speed,
    double? heading,
    double? accuracy,
    double? altitude,
    DateTime? timestamp,
    bool? isMoving,
    int? batteryLevel,
  }) = _DriverLocationImpl;

  factory DriverLocation.fromJson(Map<String, dynamic> jsonSerialization) {
    return DriverLocation(
      driverId: jsonSerialization['driverId'] as int,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      speed: (jsonSerialization['speed'] as num?)?.toDouble(),
      heading: (jsonSerialization['heading'] as num?)?.toDouble(),
      accuracy: (jsonSerialization['accuracy'] as num?)?.toDouble(),
      altitude: (jsonSerialization['altitude'] as num?)?.toDouble(),
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      isMoving: jsonSerialization['isMoving'] as bool,
      batteryLevel: jsonSerialization['batteryLevel'] as int?,
    );
  }

  int driverId;

  double latitude;

  double longitude;

  double? speed;

  double? heading;

  double? accuracy;

  double? altitude;

  DateTime timestamp;

  bool isMoving;

  int? batteryLevel;

  /// Returns a shallow copy of this [DriverLocation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DriverLocation copyWith({
    int? driverId,
    double? latitude,
    double? longitude,
    double? speed,
    double? heading,
    double? accuracy,
    double? altitude,
    DateTime? timestamp,
    bool? isMoving,
    int? batteryLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DriverLocation',
      'driverId': driverId,
      'latitude': latitude,
      'longitude': longitude,
      if (speed != null) 'speed': speed,
      if (heading != null) 'heading': heading,
      if (accuracy != null) 'accuracy': accuracy,
      if (altitude != null) 'altitude': altitude,
      'timestamp': timestamp.toJson(),
      'isMoving': isMoving,
      if (batteryLevel != null) 'batteryLevel': batteryLevel,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DriverLocationImpl extends DriverLocation {
  _DriverLocationImpl({
    required int driverId,
    required double latitude,
    required double longitude,
    double? speed,
    double? heading,
    double? accuracy,
    double? altitude,
    DateTime? timestamp,
    bool? isMoving,
    int? batteryLevel,
  }) : super._(
         driverId: driverId,
         latitude: latitude,
         longitude: longitude,
         speed: speed,
         heading: heading,
         accuracy: accuracy,
         altitude: altitude,
         timestamp: timestamp,
         isMoving: isMoving,
         batteryLevel: batteryLevel,
       );

  /// Returns a shallow copy of this [DriverLocation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DriverLocation copyWith({
    int? driverId,
    double? latitude,
    double? longitude,
    Object? speed = _Undefined,
    Object? heading = _Undefined,
    Object? accuracy = _Undefined,
    Object? altitude = _Undefined,
    DateTime? timestamp,
    bool? isMoving,
    Object? batteryLevel = _Undefined,
  }) {
    return DriverLocation(
      driverId: driverId ?? this.driverId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      speed: speed is double? ? speed : this.speed,
      heading: heading is double? ? heading : this.heading,
      accuracy: accuracy is double? ? accuracy : this.accuracy,
      altitude: altitude is double? ? altitude : this.altitude,
      timestamp: timestamp ?? this.timestamp,
      isMoving: isMoving ?? this.isMoving,
      batteryLevel: batteryLevel is int? ? batteryLevel : this.batteryLevel,
    );
  }
}
