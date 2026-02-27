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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class EsDriverServiceHit
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  EsDriverServiceHit._({
    required this.id,
    required this.driverId,
    this.driverUserId,
    this.driverName,
    this.driverPhoto,
    this.driverRating,
    required this.driverIsVerified,
    required this.driverIsPremium,
    required this.driverIsOnline,
    this.serviceId,
    this.serviceName,
    this.categoryId,
    this.categoryName,
    this.title,
    this.description,
    this.imageUrl,
    this.priceType,
    this.basePrice,
    this.latitude,
    this.longitude,
    this.distance,
    this.score,
  });

  factory EsDriverServiceHit({
    required int id,
    required int driverId,
    int? driverUserId,
    String? driverName,
    String? driverPhoto,
    double? driverRating,
    required bool driverIsVerified,
    required bool driverIsPremium,
    required bool driverIsOnline,
    int? serviceId,
    String? serviceName,
    int? categoryId,
    String? categoryName,
    String? title,
    String? description,
    String? imageUrl,
    String? priceType,
    double? basePrice,
    double? latitude,
    double? longitude,
    double? distance,
    double? score,
  }) = _EsDriverServiceHitImpl;

  factory EsDriverServiceHit.fromJson(Map<String, dynamic> jsonSerialization) {
    return EsDriverServiceHit(
      id: jsonSerialization['id'] as int,
      driverId: jsonSerialization['driverId'] as int,
      driverUserId: jsonSerialization['driverUserId'] as int?,
      driverName: jsonSerialization['driverName'] as String?,
      driverPhoto: jsonSerialization['driverPhoto'] as String?,
      driverRating: (jsonSerialization['driverRating'] as num?)?.toDouble(),
      driverIsVerified: jsonSerialization['driverIsVerified'] as bool,
      driverIsPremium: jsonSerialization['driverIsPremium'] as bool,
      driverIsOnline: jsonSerialization['driverIsOnline'] as bool,
      serviceId: jsonSerialization['serviceId'] as int?,
      serviceName: jsonSerialization['serviceName'] as String?,
      categoryId: jsonSerialization['categoryId'] as int?,
      categoryName: jsonSerialization['categoryName'] as String?,
      title: jsonSerialization['title'] as String?,
      description: jsonSerialization['description'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      priceType: jsonSerialization['priceType'] as String?,
      basePrice: (jsonSerialization['basePrice'] as num?)?.toDouble(),
      latitude: (jsonSerialization['latitude'] as num?)?.toDouble(),
      longitude: (jsonSerialization['longitude'] as num?)?.toDouble(),
      distance: (jsonSerialization['distance'] as num?)?.toDouble(),
      score: (jsonSerialization['score'] as num?)?.toDouble(),
    );
  }

  int id;

  int driverId;

  int? driverUserId;

  String? driverName;

  String? driverPhoto;

  double? driverRating;

  bool driverIsVerified;

  bool driverIsPremium;

  bool driverIsOnline;

  int? serviceId;

  String? serviceName;

  int? categoryId;

  String? categoryName;

  String? title;

  String? description;

  String? imageUrl;

  String? priceType;

  double? basePrice;

  double? latitude;

  double? longitude;

  double? distance;

  double? score;

  /// Returns a shallow copy of this [EsDriverServiceHit]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EsDriverServiceHit copyWith({
    int? id,
    int? driverId,
    int? driverUserId,
    String? driverName,
    String? driverPhoto,
    double? driverRating,
    bool? driverIsVerified,
    bool? driverIsPremium,
    bool? driverIsOnline,
    int? serviceId,
    String? serviceName,
    int? categoryId,
    String? categoryName,
    String? title,
    String? description,
    String? imageUrl,
    String? priceType,
    double? basePrice,
    double? latitude,
    double? longitude,
    double? distance,
    double? score,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EsDriverServiceHit',
      'id': id,
      'driverId': driverId,
      if (driverUserId != null) 'driverUserId': driverUserId,
      if (driverName != null) 'driverName': driverName,
      if (driverPhoto != null) 'driverPhoto': driverPhoto,
      if (driverRating != null) 'driverRating': driverRating,
      'driverIsVerified': driverIsVerified,
      'driverIsPremium': driverIsPremium,
      'driverIsOnline': driverIsOnline,
      if (serviceId != null) 'serviceId': serviceId,
      if (serviceName != null) 'serviceName': serviceName,
      if (categoryId != null) 'categoryId': categoryId,
      if (categoryName != null) 'categoryName': categoryName,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (priceType != null) 'priceType': priceType,
      if (basePrice != null) 'basePrice': basePrice,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (distance != null) 'distance': distance,
      if (score != null) 'score': score,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EsDriverServiceHit',
      'id': id,
      'driverId': driverId,
      if (driverUserId != null) 'driverUserId': driverUserId,
      if (driverName != null) 'driverName': driverName,
      if (driverPhoto != null) 'driverPhoto': driverPhoto,
      if (driverRating != null) 'driverRating': driverRating,
      'driverIsVerified': driverIsVerified,
      'driverIsPremium': driverIsPremium,
      'driverIsOnline': driverIsOnline,
      if (serviceId != null) 'serviceId': serviceId,
      if (serviceName != null) 'serviceName': serviceName,
      if (categoryId != null) 'categoryId': categoryId,
      if (categoryName != null) 'categoryName': categoryName,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (priceType != null) 'priceType': priceType,
      if (basePrice != null) 'basePrice': basePrice,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
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

class _EsDriverServiceHitImpl extends EsDriverServiceHit {
  _EsDriverServiceHitImpl({
    required int id,
    required int driverId,
    int? driverUserId,
    String? driverName,
    String? driverPhoto,
    double? driverRating,
    required bool driverIsVerified,
    required bool driverIsPremium,
    required bool driverIsOnline,
    int? serviceId,
    String? serviceName,
    int? categoryId,
    String? categoryName,
    String? title,
    String? description,
    String? imageUrl,
    String? priceType,
    double? basePrice,
    double? latitude,
    double? longitude,
    double? distance,
    double? score,
  }) : super._(
         id: id,
         driverId: driverId,
         driverUserId: driverUserId,
         driverName: driverName,
         driverPhoto: driverPhoto,
         driverRating: driverRating,
         driverIsVerified: driverIsVerified,
         driverIsPremium: driverIsPremium,
         driverIsOnline: driverIsOnline,
         serviceId: serviceId,
         serviceName: serviceName,
         categoryId: categoryId,
         categoryName: categoryName,
         title: title,
         description: description,
         imageUrl: imageUrl,
         priceType: priceType,
         basePrice: basePrice,
         latitude: latitude,
         longitude: longitude,
         distance: distance,
         score: score,
       );

  /// Returns a shallow copy of this [EsDriverServiceHit]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EsDriverServiceHit copyWith({
    int? id,
    int? driverId,
    Object? driverUserId = _Undefined,
    Object? driverName = _Undefined,
    Object? driverPhoto = _Undefined,
    Object? driverRating = _Undefined,
    bool? driverIsVerified,
    bool? driverIsPremium,
    bool? driverIsOnline,
    Object? serviceId = _Undefined,
    Object? serviceName = _Undefined,
    Object? categoryId = _Undefined,
    Object? categoryName = _Undefined,
    Object? title = _Undefined,
    Object? description = _Undefined,
    Object? imageUrl = _Undefined,
    Object? priceType = _Undefined,
    Object? basePrice = _Undefined,
    Object? latitude = _Undefined,
    Object? longitude = _Undefined,
    Object? distance = _Undefined,
    Object? score = _Undefined,
  }) {
    return EsDriverServiceHit(
      id: id ?? this.id,
      driverId: driverId ?? this.driverId,
      driverUserId: driverUserId is int? ? driverUserId : this.driverUserId,
      driverName: driverName is String? ? driverName : this.driverName,
      driverPhoto: driverPhoto is String? ? driverPhoto : this.driverPhoto,
      driverRating: driverRating is double? ? driverRating : this.driverRating,
      driverIsVerified: driverIsVerified ?? this.driverIsVerified,
      driverIsPremium: driverIsPremium ?? this.driverIsPremium,
      driverIsOnline: driverIsOnline ?? this.driverIsOnline,
      serviceId: serviceId is int? ? serviceId : this.serviceId,
      serviceName: serviceName is String? ? serviceName : this.serviceName,
      categoryId: categoryId is int? ? categoryId : this.categoryId,
      categoryName: categoryName is String? ? categoryName : this.categoryName,
      title: title is String? ? title : this.title,
      description: description is String? ? description : this.description,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      priceType: priceType is String? ? priceType : this.priceType,
      basePrice: basePrice is double? ? basePrice : this.basePrice,
      latitude: latitude is double? ? latitude : this.latitude,
      longitude: longitude is double? ? longitude : this.longitude,
      distance: distance is double? ? distance : this.distance,
      score: score is double? ? score : this.score,
    );
  }
}
