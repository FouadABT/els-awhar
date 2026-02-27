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

abstract class AiDemandHotspot implements _i1.SerializableModel {
  AiDemandHotspot._({
    required this.latitude,
    required this.longitude,
    required this.radiusKm,
    required this.demandScore,
    required this.predictedRequests,
    required this.peakHours,
    required this.topServices,
    required this.confidence,
    this.locationName,
  });

  factory AiDemandHotspot({
    required double latitude,
    required double longitude,
    required double radiusKm,
    required double demandScore,
    required int predictedRequests,
    required List<int> peakHours,
    required List<String> topServices,
    required _i2.AiConfidenceLevel confidence,
    String? locationName,
  }) = _AiDemandHotspotImpl;

  factory AiDemandHotspot.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiDemandHotspot(
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      radiusKm: (jsonSerialization['radiusKm'] as num).toDouble(),
      demandScore: (jsonSerialization['demandScore'] as num).toDouble(),
      predictedRequests: jsonSerialization['predictedRequests'] as int,
      peakHours: _i3.Protocol().deserialize<List<int>>(
        jsonSerialization['peakHours'],
      ),
      topServices: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['topServices'],
      ),
      confidence: _i2.AiConfidenceLevel.fromJson(
        (jsonSerialization['confidence'] as String),
      ),
      locationName: jsonSerialization['locationName'] as String?,
    );
  }

  double latitude;

  double longitude;

  double radiusKm;

  double demandScore;

  int predictedRequests;

  List<int> peakHours;

  List<String> topServices;

  _i2.AiConfidenceLevel confidence;

  String? locationName;

  /// Returns a shallow copy of this [AiDemandHotspot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiDemandHotspot copyWith({
    double? latitude,
    double? longitude,
    double? radiusKm,
    double? demandScore,
    int? predictedRequests,
    List<int>? peakHours,
    List<String>? topServices,
    _i2.AiConfidenceLevel? confidence,
    String? locationName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiDemandHotspot',
      'latitude': latitude,
      'longitude': longitude,
      'radiusKm': radiusKm,
      'demandScore': demandScore,
      'predictedRequests': predictedRequests,
      'peakHours': peakHours.toJson(),
      'topServices': topServices.toJson(),
      'confidence': confidence.toJson(),
      if (locationName != null) 'locationName': locationName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiDemandHotspotImpl extends AiDemandHotspot {
  _AiDemandHotspotImpl({
    required double latitude,
    required double longitude,
    required double radiusKm,
    required double demandScore,
    required int predictedRequests,
    required List<int> peakHours,
    required List<String> topServices,
    required _i2.AiConfidenceLevel confidence,
    String? locationName,
  }) : super._(
         latitude: latitude,
         longitude: longitude,
         radiusKm: radiusKm,
         demandScore: demandScore,
         predictedRequests: predictedRequests,
         peakHours: peakHours,
         topServices: topServices,
         confidence: confidence,
         locationName: locationName,
       );

  /// Returns a shallow copy of this [AiDemandHotspot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiDemandHotspot copyWith({
    double? latitude,
    double? longitude,
    double? radiusKm,
    double? demandScore,
    int? predictedRequests,
    List<int>? peakHours,
    List<String>? topServices,
    _i2.AiConfidenceLevel? confidence,
    Object? locationName = _Undefined,
  }) {
    return AiDemandHotspot(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radiusKm: radiusKm ?? this.radiusKm,
      demandScore: demandScore ?? this.demandScore,
      predictedRequests: predictedRequests ?? this.predictedRequests,
      peakHours: peakHours ?? this.peakHours.map((e0) => e0).toList(),
      topServices: topServices ?? this.topServices.map((e0) => e0).toList(),
      confidence: confidence ?? this.confidence,
      locationName: locationName is String? ? locationName : this.locationName,
    );
  }
}
