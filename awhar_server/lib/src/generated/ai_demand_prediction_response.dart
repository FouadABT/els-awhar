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
import 'ai_agent_type_enum.dart' as _i2;
import 'ai_response_status_enum.dart' as _i3;
import 'ai_demand_hotspot.dart' as _i4;
import 'package:awhar_server/src/generated/protocol.dart' as _i5;

abstract class AiDemandPredictionResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AiDemandPredictionResponse._({
    required this.agentType,
    required this.status,
    this.errorMessage,
    required this.processingTimeMs,
    required this.timestamp,
    required this.hotspots,
    required this.predictionHorizonHours,
    required this.overallDemandLevel,
    required this.recommendations,
  });

  factory AiDemandPredictionResponse({
    required _i2.AiAgentType agentType,
    required _i3.AiResponseStatus status,
    String? errorMessage,
    required int processingTimeMs,
    required DateTime timestamp,
    required List<_i4.AiDemandHotspot> hotspots,
    required int predictionHorizonHours,
    required String overallDemandLevel,
    required List<String> recommendations,
  }) = _AiDemandPredictionResponseImpl;

  factory AiDemandPredictionResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AiDemandPredictionResponse(
      agentType: _i2.AiAgentType.fromJson(
        (jsonSerialization['agentType'] as String),
      ),
      status: _i3.AiResponseStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      errorMessage: jsonSerialization['errorMessage'] as String?,
      processingTimeMs: jsonSerialization['processingTimeMs'] as int,
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      hotspots: _i5.Protocol().deserialize<List<_i4.AiDemandHotspot>>(
        jsonSerialization['hotspots'],
      ),
      predictionHorizonHours:
          jsonSerialization['predictionHorizonHours'] as int,
      overallDemandLevel: jsonSerialization['overallDemandLevel'] as String,
      recommendations: _i5.Protocol().deserialize<List<String>>(
        jsonSerialization['recommendations'],
      ),
    );
  }

  _i2.AiAgentType agentType;

  _i3.AiResponseStatus status;

  String? errorMessage;

  int processingTimeMs;

  DateTime timestamp;

  List<_i4.AiDemandHotspot> hotspots;

  int predictionHorizonHours;

  String overallDemandLevel;

  List<String> recommendations;

  /// Returns a shallow copy of this [AiDemandPredictionResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiDemandPredictionResponse copyWith({
    _i2.AiAgentType? agentType,
    _i3.AiResponseStatus? status,
    String? errorMessage,
    int? processingTimeMs,
    DateTime? timestamp,
    List<_i4.AiDemandHotspot>? hotspots,
    int? predictionHorizonHours,
    String? overallDemandLevel,
    List<String>? recommendations,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiDemandPredictionResponse',
      'agentType': agentType.toJson(),
      'status': status.toJson(),
      if (errorMessage != null) 'errorMessage': errorMessage,
      'processingTimeMs': processingTimeMs,
      'timestamp': timestamp.toJson(),
      'hotspots': hotspots.toJson(valueToJson: (v) => v.toJson()),
      'predictionHorizonHours': predictionHorizonHours,
      'overallDemandLevel': overallDemandLevel,
      'recommendations': recommendations.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiDemandPredictionResponse',
      'agentType': agentType.toJson(),
      'status': status.toJson(),
      if (errorMessage != null) 'errorMessage': errorMessage,
      'processingTimeMs': processingTimeMs,
      'timestamp': timestamp.toJson(),
      'hotspots': hotspots.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'predictionHorizonHours': predictionHorizonHours,
      'overallDemandLevel': overallDemandLevel,
      'recommendations': recommendations.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiDemandPredictionResponseImpl extends AiDemandPredictionResponse {
  _AiDemandPredictionResponseImpl({
    required _i2.AiAgentType agentType,
    required _i3.AiResponseStatus status,
    String? errorMessage,
    required int processingTimeMs,
    required DateTime timestamp,
    required List<_i4.AiDemandHotspot> hotspots,
    required int predictionHorizonHours,
    required String overallDemandLevel,
    required List<String> recommendations,
  }) : super._(
         agentType: agentType,
         status: status,
         errorMessage: errorMessage,
         processingTimeMs: processingTimeMs,
         timestamp: timestamp,
         hotspots: hotspots,
         predictionHorizonHours: predictionHorizonHours,
         overallDemandLevel: overallDemandLevel,
         recommendations: recommendations,
       );

  /// Returns a shallow copy of this [AiDemandPredictionResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiDemandPredictionResponse copyWith({
    _i2.AiAgentType? agentType,
    _i3.AiResponseStatus? status,
    Object? errorMessage = _Undefined,
    int? processingTimeMs,
    DateTime? timestamp,
    List<_i4.AiDemandHotspot>? hotspots,
    int? predictionHorizonHours,
    String? overallDemandLevel,
    List<String>? recommendations,
  }) {
    return AiDemandPredictionResponse(
      agentType: agentType ?? this.agentType,
      status: status ?? this.status,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      processingTimeMs: processingTimeMs ?? this.processingTimeMs,
      timestamp: timestamp ?? this.timestamp,
      hotspots: hotspots ?? this.hotspots.map((e0) => e0.copyWith()).toList(),
      predictionHorizonHours:
          predictionHorizonHours ?? this.predictionHorizonHours,
      overallDemandLevel: overallDemandLevel ?? this.overallDemandLevel,
      recommendations:
          recommendations ?? this.recommendations.map((e0) => e0).toList(),
    );
  }
}
