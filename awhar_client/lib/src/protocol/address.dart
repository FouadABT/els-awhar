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

abstract class Address implements _i1.SerializableModel {
  Address._({
    this.id,
    required this.userId,
    required this.label,
    required this.fullAddress,
    required this.cityId,
    required this.latitude,
    required this.longitude,
    this.buildingNumber,
    this.floor,
    this.apartmentNumber,
    this.landmark,
    this.instructions,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isDefault = isDefault ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Address({
    int? id,
    required int userId,
    required String label,
    required String fullAddress,
    required int cityId,
    required double latitude,
    required double longitude,
    String? buildingNumber,
    String? floor,
    String? apartmentNumber,
    String? landmark,
    String? instructions,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AddressImpl;

  factory Address.fromJson(Map<String, dynamic> jsonSerialization) {
    return Address(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      label: jsonSerialization['label'] as String,
      fullAddress: jsonSerialization['fullAddress'] as String,
      cityId: jsonSerialization['cityId'] as int,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      buildingNumber: jsonSerialization['buildingNumber'] as String?,
      floor: jsonSerialization['floor'] as String?,
      apartmentNumber: jsonSerialization['apartmentNumber'] as String?,
      landmark: jsonSerialization['landmark'] as String?,
      instructions: jsonSerialization['instructions'] as String?,
      isDefault: jsonSerialization['isDefault'] as bool,
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

  int userId;

  String label;

  String fullAddress;

  int cityId;

  double latitude;

  double longitude;

  String? buildingNumber;

  String? floor;

  String? apartmentNumber;

  String? landmark;

  String? instructions;

  bool isDefault;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Address]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Address copyWith({
    int? id,
    int? userId,
    String? label,
    String? fullAddress,
    int? cityId,
    double? latitude,
    double? longitude,
    String? buildingNumber,
    String? floor,
    String? apartmentNumber,
    String? landmark,
    String? instructions,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Address',
      if (id != null) 'id': id,
      'userId': userId,
      'label': label,
      'fullAddress': fullAddress,
      'cityId': cityId,
      'latitude': latitude,
      'longitude': longitude,
      if (buildingNumber != null) 'buildingNumber': buildingNumber,
      if (floor != null) 'floor': floor,
      if (apartmentNumber != null) 'apartmentNumber': apartmentNumber,
      if (landmark != null) 'landmark': landmark,
      if (instructions != null) 'instructions': instructions,
      'isDefault': isDefault,
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

class _AddressImpl extends Address {
  _AddressImpl({
    int? id,
    required int userId,
    required String label,
    required String fullAddress,
    required int cityId,
    required double latitude,
    required double longitude,
    String? buildingNumber,
    String? floor,
    String? apartmentNumber,
    String? landmark,
    String? instructions,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         label: label,
         fullAddress: fullAddress,
         cityId: cityId,
         latitude: latitude,
         longitude: longitude,
         buildingNumber: buildingNumber,
         floor: floor,
         apartmentNumber: apartmentNumber,
         landmark: landmark,
         instructions: instructions,
         isDefault: isDefault,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Address]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Address copyWith({
    Object? id = _Undefined,
    int? userId,
    String? label,
    String? fullAddress,
    int? cityId,
    double? latitude,
    double? longitude,
    Object? buildingNumber = _Undefined,
    Object? floor = _Undefined,
    Object? apartmentNumber = _Undefined,
    Object? landmark = _Undefined,
    Object? instructions = _Undefined,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Address(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      label: label ?? this.label,
      fullAddress: fullAddress ?? this.fullAddress,
      cityId: cityId ?? this.cityId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      buildingNumber: buildingNumber is String?
          ? buildingNumber
          : this.buildingNumber,
      floor: floor is String? ? floor : this.floor,
      apartmentNumber: apartmentNumber is String?
          ? apartmentNumber
          : this.apartmentNumber,
      landmark: landmark is String? ? landmark : this.landmark,
      instructions: instructions is String? ? instructions : this.instructions,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
