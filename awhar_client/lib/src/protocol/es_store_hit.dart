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

abstract class EsStoreHit implements _i1.SerializableModel {
  EsStoreHit._({
    required this.id,
    this.userId,
    this.storeCategoryId,
    this.categoryName,
    this.name,
    this.description,
    this.logoUrl,
    this.address,
    this.latitude,
    this.longitude,
    this.ratingAverage,
    this.ratingCount,
    required this.isActive,
    required this.isOpen,
    this.deliveryRadiusKm,
    this.distance,
    this.score,
  });

  factory EsStoreHit({
    required int id,
    int? userId,
    int? storeCategoryId,
    String? categoryName,
    String? name,
    String? description,
    String? logoUrl,
    String? address,
    double? latitude,
    double? longitude,
    double? ratingAverage,
    int? ratingCount,
    required bool isActive,
    required bool isOpen,
    double? deliveryRadiusKm,
    double? distance,
    double? score,
  }) = _EsStoreHitImpl;

  factory EsStoreHit.fromJson(Map<String, dynamic> jsonSerialization) {
    return EsStoreHit(
      id: jsonSerialization['id'] as int,
      userId: jsonSerialization['userId'] as int?,
      storeCategoryId: jsonSerialization['storeCategoryId'] as int?,
      categoryName: jsonSerialization['categoryName'] as String?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      logoUrl: jsonSerialization['logoUrl'] as String?,
      address: jsonSerialization['address'] as String?,
      latitude: (jsonSerialization['latitude'] as num?)?.toDouble(),
      longitude: (jsonSerialization['longitude'] as num?)?.toDouble(),
      ratingAverage: (jsonSerialization['ratingAverage'] as num?)?.toDouble(),
      ratingCount: jsonSerialization['ratingCount'] as int?,
      isActive: jsonSerialization['isActive'] as bool,
      isOpen: jsonSerialization['isOpen'] as bool,
      deliveryRadiusKm: (jsonSerialization['deliveryRadiusKm'] as num?)
          ?.toDouble(),
      distance: (jsonSerialization['distance'] as num?)?.toDouble(),
      score: (jsonSerialization['score'] as num?)?.toDouble(),
    );
  }

  int id;

  int? userId;

  int? storeCategoryId;

  String? categoryName;

  String? name;

  String? description;

  String? logoUrl;

  String? address;

  double? latitude;

  double? longitude;

  double? ratingAverage;

  int? ratingCount;

  bool isActive;

  bool isOpen;

  double? deliveryRadiusKm;

  double? distance;

  double? score;

  /// Returns a shallow copy of this [EsStoreHit]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EsStoreHit copyWith({
    int? id,
    int? userId,
    int? storeCategoryId,
    String? categoryName,
    String? name,
    String? description,
    String? logoUrl,
    String? address,
    double? latitude,
    double? longitude,
    double? ratingAverage,
    int? ratingCount,
    bool? isActive,
    bool? isOpen,
    double? deliveryRadiusKm,
    double? distance,
    double? score,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EsStoreHit',
      'id': id,
      if (userId != null) 'userId': userId,
      if (storeCategoryId != null) 'storeCategoryId': storeCategoryId,
      if (categoryName != null) 'categoryName': categoryName,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (logoUrl != null) 'logoUrl': logoUrl,
      if (address != null) 'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (ratingAverage != null) 'ratingAverage': ratingAverage,
      if (ratingCount != null) 'ratingCount': ratingCount,
      'isActive': isActive,
      'isOpen': isOpen,
      if (deliveryRadiusKm != null) 'deliveryRadiusKm': deliveryRadiusKm,
      if (distance != null) 'distance': distance,
      if (score != null) 'score': score,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EsStoreHitImpl extends EsStoreHit {
  _EsStoreHitImpl({
    required int id,
    int? userId,
    int? storeCategoryId,
    String? categoryName,
    String? name,
    String? description,
    String? logoUrl,
    String? address,
    double? latitude,
    double? longitude,
    double? ratingAverage,
    int? ratingCount,
    required bool isActive,
    required bool isOpen,
    double? deliveryRadiusKm,
    double? distance,
    double? score,
  }) : super._(
         id: id,
         userId: userId,
         storeCategoryId: storeCategoryId,
         categoryName: categoryName,
         name: name,
         description: description,
         logoUrl: logoUrl,
         address: address,
         latitude: latitude,
         longitude: longitude,
         ratingAverage: ratingAverage,
         ratingCount: ratingCount,
         isActive: isActive,
         isOpen: isOpen,
         deliveryRadiusKm: deliveryRadiusKm,
         distance: distance,
         score: score,
       );

  /// Returns a shallow copy of this [EsStoreHit]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EsStoreHit copyWith({
    int? id,
    Object? userId = _Undefined,
    Object? storeCategoryId = _Undefined,
    Object? categoryName = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? logoUrl = _Undefined,
    Object? address = _Undefined,
    Object? latitude = _Undefined,
    Object? longitude = _Undefined,
    Object? ratingAverage = _Undefined,
    Object? ratingCount = _Undefined,
    bool? isActive,
    bool? isOpen,
    Object? deliveryRadiusKm = _Undefined,
    Object? distance = _Undefined,
    Object? score = _Undefined,
  }) {
    return EsStoreHit(
      id: id ?? this.id,
      userId: userId is int? ? userId : this.userId,
      storeCategoryId: storeCategoryId is int?
          ? storeCategoryId
          : this.storeCategoryId,
      categoryName: categoryName is String? ? categoryName : this.categoryName,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      logoUrl: logoUrl is String? ? logoUrl : this.logoUrl,
      address: address is String? ? address : this.address,
      latitude: latitude is double? ? latitude : this.latitude,
      longitude: longitude is double? ? longitude : this.longitude,
      ratingAverage: ratingAverage is double?
          ? ratingAverage
          : this.ratingAverage,
      ratingCount: ratingCount is int? ? ratingCount : this.ratingCount,
      isActive: isActive ?? this.isActive,
      isOpen: isOpen ?? this.isOpen,
      deliveryRadiusKm: deliveryRadiusKm is double?
          ? deliveryRadiusKm
          : this.deliveryRadiusKm,
      distance: distance is double? ? distance : this.distance,
      score: score is double? ? score : this.score,
    );
  }
}
