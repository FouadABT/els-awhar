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

abstract class DriverZone implements _i1.SerializableModel {
  DriverZone._({
    this.id,
    required this.driverId,
    required this.zoneName,
    required this.cityId,
    this.geoBoundary,
    required this.centerLatitude,
    required this.centerLongitude,
    double? radiusKm,
    double? extraFeeOutsideZone,
    bool? isPrimary,
    bool? isActive,
    DateTime? createdAt,
  }) : radiusKm = radiusKm ?? 5.0,
       extraFeeOutsideZone = extraFeeOutsideZone ?? 0.0,
       isPrimary = isPrimary ?? false,
       isActive = isActive ?? true,
       createdAt = createdAt ?? DateTime.now();

  factory DriverZone({
    int? id,
    required int driverId,
    required String zoneName,
    required int cityId,
    String? geoBoundary,
    required double centerLatitude,
    required double centerLongitude,
    double? radiusKm,
    double? extraFeeOutsideZone,
    bool? isPrimary,
    bool? isActive,
    DateTime? createdAt,
  }) = _DriverZoneImpl;

  factory DriverZone.fromJson(Map<String, dynamic> jsonSerialization) {
    return DriverZone(
      id: jsonSerialization['id'] as int?,
      driverId: jsonSerialization['driverId'] as int,
      zoneName: jsonSerialization['zoneName'] as String,
      cityId: jsonSerialization['cityId'] as int,
      geoBoundary: jsonSerialization['geoBoundary'] as String?,
      centerLatitude: (jsonSerialization['centerLatitude'] as num).toDouble(),
      centerLongitude: (jsonSerialization['centerLongitude'] as num).toDouble(),
      radiusKm: (jsonSerialization['radiusKm'] as num).toDouble(),
      extraFeeOutsideZone: (jsonSerialization['extraFeeOutsideZone'] as num)
          .toDouble(),
      isPrimary: jsonSerialization['isPrimary'] as bool,
      isActive: jsonSerialization['isActive'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int driverId;

  String zoneName;

  int cityId;

  String? geoBoundary;

  double centerLatitude;

  double centerLongitude;

  double radiusKm;

  double extraFeeOutsideZone;

  bool isPrimary;

  bool isActive;

  DateTime createdAt;

  /// Returns a shallow copy of this [DriverZone]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DriverZone copyWith({
    int? id,
    int? driverId,
    String? zoneName,
    int? cityId,
    String? geoBoundary,
    double? centerLatitude,
    double? centerLongitude,
    double? radiusKm,
    double? extraFeeOutsideZone,
    bool? isPrimary,
    bool? isActive,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DriverZone',
      if (id != null) 'id': id,
      'driverId': driverId,
      'zoneName': zoneName,
      'cityId': cityId,
      if (geoBoundary != null) 'geoBoundary': geoBoundary,
      'centerLatitude': centerLatitude,
      'centerLongitude': centerLongitude,
      'radiusKm': radiusKm,
      'extraFeeOutsideZone': extraFeeOutsideZone,
      'isPrimary': isPrimary,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DriverZoneImpl extends DriverZone {
  _DriverZoneImpl({
    int? id,
    required int driverId,
    required String zoneName,
    required int cityId,
    String? geoBoundary,
    required double centerLatitude,
    required double centerLongitude,
    double? radiusKm,
    double? extraFeeOutsideZone,
    bool? isPrimary,
    bool? isActive,
    DateTime? createdAt,
  }) : super._(
         id: id,
         driverId: driverId,
         zoneName: zoneName,
         cityId: cityId,
         geoBoundary: geoBoundary,
         centerLatitude: centerLatitude,
         centerLongitude: centerLongitude,
         radiusKm: radiusKm,
         extraFeeOutsideZone: extraFeeOutsideZone,
         isPrimary: isPrimary,
         isActive: isActive,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [DriverZone]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DriverZone copyWith({
    Object? id = _Undefined,
    int? driverId,
    String? zoneName,
    int? cityId,
    Object? geoBoundary = _Undefined,
    double? centerLatitude,
    double? centerLongitude,
    double? radiusKm,
    double? extraFeeOutsideZone,
    bool? isPrimary,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return DriverZone(
      id: id is int? ? id : this.id,
      driverId: driverId ?? this.driverId,
      zoneName: zoneName ?? this.zoneName,
      cityId: cityId ?? this.cityId,
      geoBoundary: geoBoundary is String? ? geoBoundary : this.geoBoundary,
      centerLatitude: centerLatitude ?? this.centerLatitude,
      centerLongitude: centerLongitude ?? this.centerLongitude,
      radiusKm: radiusKm ?? this.radiusKm,
      extraFeeOutsideZone: extraFeeOutsideZone ?? this.extraFeeOutsideZone,
      isPrimary: isPrimary ?? this.isPrimary,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
