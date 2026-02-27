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
import 'ai_confidence_level_enum.dart' as _i2;
import 'package:awhar_client/src/protocol/protocol.dart' as _i3;

abstract class AiDriverRecommendation implements _i1.SerializableModel {
  AiDriverRecommendation._({
    required this.driverId,
    required this.userId,
    this.displayName,
    this.profilePhotoUrl,
    this.ratingAverage,
    this.ratingCount,
    required this.distanceKm,
    required this.isOnline,
    required this.isVerified,
    required this.isPremium,
    this.totalCompletedOrders,
    required this.matchScore,
    required this.confidence,
    required this.matchReasons,
  });

  factory AiDriverRecommendation({
    required int driverId,
    required int userId,
    String? displayName,
    String? profilePhotoUrl,
    double? ratingAverage,
    int? ratingCount,
    required double distanceKm,
    required bool isOnline,
    required bool isVerified,
    required bool isPremium,
    int? totalCompletedOrders,
    required double matchScore,
    required _i2.AiConfidenceLevel confidence,
    required List<String> matchReasons,
  }) = _AiDriverRecommendationImpl;

  factory AiDriverRecommendation.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AiDriverRecommendation(
      driverId: jsonSerialization['driverId'] as int,
      userId: jsonSerialization['userId'] as int,
      displayName: jsonSerialization['displayName'] as String?,
      profilePhotoUrl: jsonSerialization['profilePhotoUrl'] as String?,
      ratingAverage: (jsonSerialization['ratingAverage'] as num?)?.toDouble(),
      ratingCount: jsonSerialization['ratingCount'] as int?,
      distanceKm: (jsonSerialization['distanceKm'] as num).toDouble(),
      isOnline: jsonSerialization['isOnline'] as bool,
      isVerified: jsonSerialization['isVerified'] as bool,
      isPremium: jsonSerialization['isPremium'] as bool,
      totalCompletedOrders: jsonSerialization['totalCompletedOrders'] as int?,
      matchScore: (jsonSerialization['matchScore'] as num).toDouble(),
      confidence: _i2.AiConfidenceLevel.fromJson(
        (jsonSerialization['confidence'] as String),
      ),
      matchReasons: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['matchReasons'],
      ),
    );
  }

  int driverId;

  int userId;

  String? displayName;

  String? profilePhotoUrl;

  double? ratingAverage;

  int? ratingCount;

  double distanceKm;

  bool isOnline;

  bool isVerified;

  bool isPremium;

  int? totalCompletedOrders;

  double matchScore;

  _i2.AiConfidenceLevel confidence;

  List<String> matchReasons;

  /// Returns a shallow copy of this [AiDriverRecommendation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiDriverRecommendation copyWith({
    int? driverId,
    int? userId,
    String? displayName,
    String? profilePhotoUrl,
    double? ratingAverage,
    int? ratingCount,
    double? distanceKm,
    bool? isOnline,
    bool? isVerified,
    bool? isPremium,
    int? totalCompletedOrders,
    double? matchScore,
    _i2.AiConfidenceLevel? confidence,
    List<String>? matchReasons,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiDriverRecommendation',
      'driverId': driverId,
      'userId': userId,
      if (displayName != null) 'displayName': displayName,
      if (profilePhotoUrl != null) 'profilePhotoUrl': profilePhotoUrl,
      if (ratingAverage != null) 'ratingAverage': ratingAverage,
      if (ratingCount != null) 'ratingCount': ratingCount,
      'distanceKm': distanceKm,
      'isOnline': isOnline,
      'isVerified': isVerified,
      'isPremium': isPremium,
      if (totalCompletedOrders != null)
        'totalCompletedOrders': totalCompletedOrders,
      'matchScore': matchScore,
      'confidence': confidence.toJson(),
      'matchReasons': matchReasons.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiDriverRecommendationImpl extends AiDriverRecommendation {
  _AiDriverRecommendationImpl({
    required int driverId,
    required int userId,
    String? displayName,
    String? profilePhotoUrl,
    double? ratingAverage,
    int? ratingCount,
    required double distanceKm,
    required bool isOnline,
    required bool isVerified,
    required bool isPremium,
    int? totalCompletedOrders,
    required double matchScore,
    required _i2.AiConfidenceLevel confidence,
    required List<String> matchReasons,
  }) : super._(
         driverId: driverId,
         userId: userId,
         displayName: displayName,
         profilePhotoUrl: profilePhotoUrl,
         ratingAverage: ratingAverage,
         ratingCount: ratingCount,
         distanceKm: distanceKm,
         isOnline: isOnline,
         isVerified: isVerified,
         isPremium: isPremium,
         totalCompletedOrders: totalCompletedOrders,
         matchScore: matchScore,
         confidence: confidence,
         matchReasons: matchReasons,
       );

  /// Returns a shallow copy of this [AiDriverRecommendation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiDriverRecommendation copyWith({
    int? driverId,
    int? userId,
    Object? displayName = _Undefined,
    Object? profilePhotoUrl = _Undefined,
    Object? ratingAverage = _Undefined,
    Object? ratingCount = _Undefined,
    double? distanceKm,
    bool? isOnline,
    bool? isVerified,
    bool? isPremium,
    Object? totalCompletedOrders = _Undefined,
    double? matchScore,
    _i2.AiConfidenceLevel? confidence,
    List<String>? matchReasons,
  }) {
    return AiDriverRecommendation(
      driverId: driverId ?? this.driverId,
      userId: userId ?? this.userId,
      displayName: displayName is String? ? displayName : this.displayName,
      profilePhotoUrl: profilePhotoUrl is String?
          ? profilePhotoUrl
          : this.profilePhotoUrl,
      ratingAverage: ratingAverage is double?
          ? ratingAverage
          : this.ratingAverage,
      ratingCount: ratingCount is int? ? ratingCount : this.ratingCount,
      distanceKm: distanceKm ?? this.distanceKm,
      isOnline: isOnline ?? this.isOnline,
      isVerified: isVerified ?? this.isVerified,
      isPremium: isPremium ?? this.isPremium,
      totalCompletedOrders: totalCompletedOrders is int?
          ? totalCompletedOrders
          : this.totalCompletedOrders,
      matchScore: matchScore ?? this.matchScore,
      confidence: confidence ?? this.confidence,
      matchReasons: matchReasons ?? this.matchReasons.map((e0) => e0).toList(),
    );
  }
}
