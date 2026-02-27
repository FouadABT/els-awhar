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

abstract class Location implements _i1.SerializableModel {
  Location._({
    required this.latitude,
    required this.longitude,
    this.address,
    this.placeName,
    this.city,
    String? country,
  }) : country = country ?? 'Morocco';

  factory Location({
    required double latitude,
    required double longitude,
    String? address,
    String? placeName,
    String? city,
    String? country,
  }) = _LocationImpl;

  factory Location.fromJson(Map<String, dynamic> jsonSerialization) {
    return Location(
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      address: jsonSerialization['address'] as String?,
      placeName: jsonSerialization['placeName'] as String?,
      city: jsonSerialization['city'] as String?,
      country: jsonSerialization['country'] as String?,
    );
  }

  double latitude;

  double longitude;

  String? address;

  String? placeName;

  String? city;

  String? country;

  /// Returns a shallow copy of this [Location]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Location copyWith({
    double? latitude,
    double? longitude,
    String? address,
    String? placeName,
    String? city,
    String? country,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Location',
      'latitude': latitude,
      'longitude': longitude,
      if (address != null) 'address': address,
      if (placeName != null) 'placeName': placeName,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocationImpl extends Location {
  _LocationImpl({
    required double latitude,
    required double longitude,
    String? address,
    String? placeName,
    String? city,
    String? country,
  }) : super._(
         latitude: latitude,
         longitude: longitude,
         address: address,
         placeName: placeName,
         city: city,
         country: country,
       );

  /// Returns a shallow copy of this [Location]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Location copyWith({
    double? latitude,
    double? longitude,
    Object? address = _Undefined,
    Object? placeName = _Undefined,
    Object? city = _Undefined,
    Object? country = _Undefined,
  }) {
    return Location(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address is String? ? address : this.address,
      placeName: placeName is String? ? placeName : this.placeName,
      city: city is String? ? city : this.city,
      country: country is String? ? country : this.country,
    );
  }
}
