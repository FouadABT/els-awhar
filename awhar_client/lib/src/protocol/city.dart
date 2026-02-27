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

abstract class City implements _i1.SerializableModel {
  City._({
    this.id,
    required this.nameEn,
    this.nameAr,
    this.nameFr,
    this.nameEs,
    String? countryCode,
    required this.latitude,
    required this.longitude,
    bool? isActive,
    bool? isPopular,
    int? displayOrder,
    double? defaultDeliveryRadius,
    DateTime? createdAt,
  }) : countryCode = countryCode ?? 'MA',
       isActive = isActive ?? true,
       isPopular = isPopular ?? false,
       displayOrder = displayOrder ?? 0,
       defaultDeliveryRadius = defaultDeliveryRadius ?? 10.0,
       createdAt = createdAt ?? DateTime.now();

  factory City({
    int? id,
    required String nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? countryCode,
    required double latitude,
    required double longitude,
    bool? isActive,
    bool? isPopular,
    int? displayOrder,
    double? defaultDeliveryRadius,
    DateTime? createdAt,
  }) = _CityImpl;

  factory City.fromJson(Map<String, dynamic> jsonSerialization) {
    return City(
      id: jsonSerialization['id'] as int?,
      nameEn: jsonSerialization['nameEn'] as String,
      nameAr: jsonSerialization['nameAr'] as String?,
      nameFr: jsonSerialization['nameFr'] as String?,
      nameEs: jsonSerialization['nameEs'] as String?,
      countryCode: jsonSerialization['countryCode'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      isActive: jsonSerialization['isActive'] as bool,
      isPopular: jsonSerialization['isPopular'] as bool,
      displayOrder: jsonSerialization['displayOrder'] as int,
      defaultDeliveryRadius: (jsonSerialization['defaultDeliveryRadius'] as num)
          .toDouble(),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String nameEn;

  String? nameAr;

  String? nameFr;

  String? nameEs;

  String countryCode;

  double latitude;

  double longitude;

  bool isActive;

  bool isPopular;

  int displayOrder;

  double defaultDeliveryRadius;

  DateTime createdAt;

  /// Returns a shallow copy of this [City]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  City copyWith({
    int? id,
    String? nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? countryCode,
    double? latitude,
    double? longitude,
    bool? isActive,
    bool? isPopular,
    int? displayOrder,
    double? defaultDeliveryRadius,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'City',
      if (id != null) 'id': id,
      'nameEn': nameEn,
      if (nameAr != null) 'nameAr': nameAr,
      if (nameFr != null) 'nameFr': nameFr,
      if (nameEs != null) 'nameEs': nameEs,
      'countryCode': countryCode,
      'latitude': latitude,
      'longitude': longitude,
      'isActive': isActive,
      'isPopular': isPopular,
      'displayOrder': displayOrder,
      'defaultDeliveryRadius': defaultDeliveryRadius,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CityImpl extends City {
  _CityImpl({
    int? id,
    required String nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? countryCode,
    required double latitude,
    required double longitude,
    bool? isActive,
    bool? isPopular,
    int? displayOrder,
    double? defaultDeliveryRadius,
    DateTime? createdAt,
  }) : super._(
         id: id,
         nameEn: nameEn,
         nameAr: nameAr,
         nameFr: nameFr,
         nameEs: nameEs,
         countryCode: countryCode,
         latitude: latitude,
         longitude: longitude,
         isActive: isActive,
         isPopular: isPopular,
         displayOrder: displayOrder,
         defaultDeliveryRadius: defaultDeliveryRadius,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [City]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  City copyWith({
    Object? id = _Undefined,
    String? nameEn,
    Object? nameAr = _Undefined,
    Object? nameFr = _Undefined,
    Object? nameEs = _Undefined,
    String? countryCode,
    double? latitude,
    double? longitude,
    bool? isActive,
    bool? isPopular,
    int? displayOrder,
    double? defaultDeliveryRadius,
    DateTime? createdAt,
  }) {
    return City(
      id: id is int? ? id : this.id,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr is String? ? nameAr : this.nameAr,
      nameFr: nameFr is String? ? nameFr : this.nameFr,
      nameEs: nameEs is String? ? nameEs : this.nameEs,
      countryCode: countryCode ?? this.countryCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isActive: isActive ?? this.isActive,
      isPopular: isPopular ?? this.isPopular,
      displayOrder: displayOrder ?? this.displayOrder,
      defaultDeliveryRadius:
          defaultDeliveryRadius ?? this.defaultDeliveryRadius,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
