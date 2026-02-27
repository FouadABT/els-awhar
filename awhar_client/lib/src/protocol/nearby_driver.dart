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
import 'driver_profile.dart' as _i2;
import 'package:awhar_client/src/protocol/protocol.dart' as _i3;

abstract class NearbyDriver implements _i1.SerializableModel {
  NearbyDriver._({
    required this.driver,
    this.distanceKm,
    required this.hasLiveLocation,
    this.lastLocationAt,
  });

  factory NearbyDriver({
    required _i2.DriverProfile driver,
    double? distanceKm,
    required bool hasLiveLocation,
    DateTime? lastLocationAt,
  }) = _NearbyDriverImpl;

  factory NearbyDriver.fromJson(Map<String, dynamic> jsonSerialization) {
    return NearbyDriver(
      driver: _i3.Protocol().deserialize<_i2.DriverProfile>(
        jsonSerialization['driver'],
      ),
      distanceKm: (jsonSerialization['distanceKm'] as num?)?.toDouble(),
      hasLiveLocation: jsonSerialization['hasLiveLocation'] as bool,
      lastLocationAt: jsonSerialization['lastLocationAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastLocationAt'],
            ),
    );
  }

  /// Driver info
  _i2.DriverProfile driver;

  /// Distance from store in kilometers (null if location unknown)
  double? distanceKm;

  /// Whether driver has valid live location
  bool hasLiveLocation;

  /// Last location update time (null if no location)
  DateTime? lastLocationAt;

  /// Returns a shallow copy of this [NearbyDriver]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  NearbyDriver copyWith({
    _i2.DriverProfile? driver,
    double? distanceKm,
    bool? hasLiveLocation,
    DateTime? lastLocationAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NearbyDriver',
      'driver': driver.toJson(),
      if (distanceKm != null) 'distanceKm': distanceKm,
      'hasLiveLocation': hasLiveLocation,
      if (lastLocationAt != null) 'lastLocationAt': lastLocationAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NearbyDriverImpl extends NearbyDriver {
  _NearbyDriverImpl({
    required _i2.DriverProfile driver,
    double? distanceKm,
    required bool hasLiveLocation,
    DateTime? lastLocationAt,
  }) : super._(
         driver: driver,
         distanceKm: distanceKm,
         hasLiveLocation: hasLiveLocation,
         lastLocationAt: lastLocationAt,
       );

  /// Returns a shallow copy of this [NearbyDriver]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  NearbyDriver copyWith({
    _i2.DriverProfile? driver,
    Object? distanceKm = _Undefined,
    bool? hasLiveLocation,
    Object? lastLocationAt = _Undefined,
  }) {
    return NearbyDriver(
      driver: driver ?? this.driver.copyWith(),
      distanceKm: distanceKm is double? ? distanceKm : this.distanceKm,
      hasLiveLocation: hasLiveLocation ?? this.hasLiveLocation,
      lastLocationAt: lastLocationAt is DateTime?
          ? lastLocationAt
          : this.lastLocationAt,
    );
  }
}
