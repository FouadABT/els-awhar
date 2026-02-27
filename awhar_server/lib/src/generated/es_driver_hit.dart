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

abstract class EsDriverHit
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  EsDriverHit._({
    required this.id,
    required this.userId,
    this.displayName,
    this.profilePhotoUrl,
    this.vehicleType,
    this.ratingAverage,
    this.ratingCount,
    this.totalCompletedOrders,
    required this.isOnline,
    required this.isVerified,
    required this.isPremium,
    this.latitude,
    this.longitude,
    this.distance,
    this.score,
  });

  factory EsDriverHit({
    required int id,
    required int userId,
    String? displayName,
    String? profilePhotoUrl,
    String? vehicleType,
    double? ratingAverage,
    int? ratingCount,
    int? totalCompletedOrders,
    required bool isOnline,
    required bool isVerified,
    required bool isPremium,
    double? latitude,
    double? longitude,
    double? distance,
    double? score,
  }) = _EsDriverHitImpl;

  factory EsDriverHit.fromJson(Map<String, dynamic> jsonSerialization) {
    return EsDriverHit(
      id: jsonSerialization['id'] as int,
      userId: jsonSerialization['userId'] as int,
      displayName: jsonSerialization['displayName'] as String?,
      profilePhotoUrl: jsonSerialization['profilePhotoUrl'] as String?,
      vehicleType: jsonSerialization['vehicleType'] as String?,
      ratingAverage: (jsonSerialization['ratingAverage'] as num?)?.toDouble(),
      ratingCount: jsonSerialization['ratingCount'] as int?,
      totalCompletedOrders: jsonSerialization['totalCompletedOrders'] as int?,
      isOnline: jsonSerialization['isOnline'] as bool,
      isVerified: jsonSerialization['isVerified'] as bool,
      isPremium: jsonSerialization['isPremium'] as bool,
      latitude: (jsonSerialization['latitude'] as num?)?.toDouble(),
      longitude: (jsonSerialization['longitude'] as num?)?.toDouble(),
      distance: (jsonSerialization['distance'] as num?)?.toDouble(),
      score: (jsonSerialization['score'] as num?)?.toDouble(),
    );
  }

  int id;

  int userId;

  String? displayName;

  String? profilePhotoUrl;

  String? vehicleType;

  double? ratingAverage;

  int? ratingCount;

  int? totalCompletedOrders;

  bool isOnline;

  bool isVerified;

  bool isPremium;

  double? latitude;

  double? longitude;

  double? distance;

  double? score;

  /// Returns a shallow copy of this [EsDriverHit]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EsDriverHit copyWith({
    int? id,
    int? userId,
    String? displayName,
    String? profilePhotoUrl,
    String? vehicleType,
    double? ratingAverage,
    int? ratingCount,
    int? totalCompletedOrders,
    bool? isOnline,
    bool? isVerified,
    bool? isPremium,
    double? latitude,
    double? longitude,
    double? distance,
    double? score,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EsDriverHit',
      'id': id,
      'userId': userId,
      if (displayName != null) 'displayName': displayName,
      if (profilePhotoUrl != null) 'profilePhotoUrl': profilePhotoUrl,
      if (vehicleType != null) 'vehicleType': vehicleType,
      if (ratingAverage != null) 'ratingAverage': ratingAverage,
      if (ratingCount != null) 'ratingCount': ratingCount,
      if (totalCompletedOrders != null)
        'totalCompletedOrders': totalCompletedOrders,
      'isOnline': isOnline,
      'isVerified': isVerified,
      'isPremium': isPremium,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (distance != null) 'distance': distance,
      if (score != null) 'score': score,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EsDriverHit',
      'id': id,
      'userId': userId,
      if (displayName != null) 'displayName': displayName,
      if (profilePhotoUrl != null) 'profilePhotoUrl': profilePhotoUrl,
      if (vehicleType != null) 'vehicleType': vehicleType,
      if (ratingAverage != null) 'ratingAverage': ratingAverage,
      if (ratingCount != null) 'ratingCount': ratingCount,
      if (totalCompletedOrders != null)
        'totalCompletedOrders': totalCompletedOrders,
      'isOnline': isOnline,
      'isVerified': isVerified,
      'isPremium': isPremium,
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

class _EsDriverHitImpl extends EsDriverHit {
  _EsDriverHitImpl({
    required int id,
    required int userId,
    String? displayName,
    String? profilePhotoUrl,
    String? vehicleType,
    double? ratingAverage,
    int? ratingCount,
    int? totalCompletedOrders,
    required bool isOnline,
    required bool isVerified,
    required bool isPremium,
    double? latitude,
    double? longitude,
    double? distance,
    double? score,
  }) : super._(
         id: id,
         userId: userId,
         displayName: displayName,
         profilePhotoUrl: profilePhotoUrl,
         vehicleType: vehicleType,
         ratingAverage: ratingAverage,
         ratingCount: ratingCount,
         totalCompletedOrders: totalCompletedOrders,
         isOnline: isOnline,
         isVerified: isVerified,
         isPremium: isPremium,
         latitude: latitude,
         longitude: longitude,
         distance: distance,
         score: score,
       );

  /// Returns a shallow copy of this [EsDriverHit]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EsDriverHit copyWith({
    int? id,
    int? userId,
    Object? displayName = _Undefined,
    Object? profilePhotoUrl = _Undefined,
    Object? vehicleType = _Undefined,
    Object? ratingAverage = _Undefined,
    Object? ratingCount = _Undefined,
    Object? totalCompletedOrders = _Undefined,
    bool? isOnline,
    bool? isVerified,
    bool? isPremium,
    Object? latitude = _Undefined,
    Object? longitude = _Undefined,
    Object? distance = _Undefined,
    Object? score = _Undefined,
  }) {
    return EsDriverHit(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      displayName: displayName is String? ? displayName : this.displayName,
      profilePhotoUrl: profilePhotoUrl is String?
          ? profilePhotoUrl
          : this.profilePhotoUrl,
      vehicleType: vehicleType is String? ? vehicleType : this.vehicleType,
      ratingAverage: ratingAverage is double?
          ? ratingAverage
          : this.ratingAverage,
      ratingCount: ratingCount is int? ? ratingCount : this.ratingCount,
      totalCompletedOrders: totalCompletedOrders is int?
          ? totalCompletedOrders
          : this.totalCompletedOrders,
      isOnline: isOnline ?? this.isOnline,
      isVerified: isVerified ?? this.isVerified,
      isPremium: isPremium ?? this.isPremium,
      latitude: latitude is double? ? latitude : this.latitude,
      longitude: longitude is double? ? longitude : this.longitude,
      distance: distance is double? ? distance : this.distance,
      score: score is double? ? score : this.score,
    );
  }
}
