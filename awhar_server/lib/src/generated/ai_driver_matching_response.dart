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
import 'ai_driver_recommendation.dart' as _i4;
import 'package:awhar_server/src/generated/protocol.dart' as _i5;

abstract class AiDriverMatchingResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AiDriverMatchingResponse._({
    required this.agentType,
    required this.status,
    this.errorMessage,
    required this.processingTimeMs,
    required this.timestamp,
    required this.recommendations,
    required this.explanation,
    required this.totalCandidatesEvaluated,
  });

  factory AiDriverMatchingResponse({
    required _i2.AiAgentType agentType,
    required _i3.AiResponseStatus status,
    String? errorMessage,
    required int processingTimeMs,
    required DateTime timestamp,
    required List<_i4.AiDriverRecommendation> recommendations,
    required String explanation,
    required int totalCandidatesEvaluated,
  }) = _AiDriverMatchingResponseImpl;

  factory AiDriverMatchingResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AiDriverMatchingResponse(
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
      recommendations: _i5.Protocol()
          .deserialize<List<_i4.AiDriverRecommendation>>(
            jsonSerialization['recommendations'],
          ),
      explanation: jsonSerialization['explanation'] as String,
      totalCandidatesEvaluated:
          jsonSerialization['totalCandidatesEvaluated'] as int,
    );
  }

  _i2.AiAgentType agentType;

  _i3.AiResponseStatus status;

  String? errorMessage;

  int processingTimeMs;

  DateTime timestamp;

  List<_i4.AiDriverRecommendation> recommendations;

  String explanation;

  int totalCandidatesEvaluated;

  /// Returns a shallow copy of this [AiDriverMatchingResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiDriverMatchingResponse copyWith({
    _i2.AiAgentType? agentType,
    _i3.AiResponseStatus? status,
    String? errorMessage,
    int? processingTimeMs,
    DateTime? timestamp,
    List<_i4.AiDriverRecommendation>? recommendations,
    String? explanation,
    int? totalCandidatesEvaluated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiDriverMatchingResponse',
      'agentType': agentType.toJson(),
      'status': status.toJson(),
      if (errorMessage != null) 'errorMessage': errorMessage,
      'processingTimeMs': processingTimeMs,
      'timestamp': timestamp.toJson(),
      'recommendations': recommendations.toJson(valueToJson: (v) => v.toJson()),
      'explanation': explanation,
      'totalCandidatesEvaluated': totalCandidatesEvaluated,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiDriverMatchingResponse',
      'agentType': agentType.toJson(),
      'status': status.toJson(),
      if (errorMessage != null) 'errorMessage': errorMessage,
      'processingTimeMs': processingTimeMs,
      'timestamp': timestamp.toJson(),
      'recommendations': recommendations.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'explanation': explanation,
      'totalCandidatesEvaluated': totalCandidatesEvaluated,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiDriverMatchingResponseImpl extends AiDriverMatchingResponse {
  _AiDriverMatchingResponseImpl({
    required _i2.AiAgentType agentType,
    required _i3.AiResponseStatus status,
    String? errorMessage,
    required int processingTimeMs,
    required DateTime timestamp,
    required List<_i4.AiDriverRecommendation> recommendations,
    required String explanation,
    required int totalCandidatesEvaluated,
  }) : super._(
         agentType: agentType,
         status: status,
         errorMessage: errorMessage,
         processingTimeMs: processingTimeMs,
         timestamp: timestamp,
         recommendations: recommendations,
         explanation: explanation,
         totalCandidatesEvaluated: totalCandidatesEvaluated,
       );

  /// Returns a shallow copy of this [AiDriverMatchingResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiDriverMatchingResponse copyWith({
    _i2.AiAgentType? agentType,
    _i3.AiResponseStatus? status,
    Object? errorMessage = _Undefined,
    int? processingTimeMs,
    DateTime? timestamp,
    List<_i4.AiDriverRecommendation>? recommendations,
    String? explanation,
    int? totalCandidatesEvaluated,
  }) {
    return AiDriverMatchingResponse(
      agentType: agentType ?? this.agentType,
      status: status ?? this.status,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      processingTimeMs: processingTimeMs ?? this.processingTimeMs,
      timestamp: timestamp ?? this.timestamp,
      recommendations:
          recommendations ??
          this.recommendations.map((e0) => e0.copyWith()).toList(),
      explanation: explanation ?? this.explanation,
      totalCandidatesEvaluated:
          totalCandidatesEvaluated ?? this.totalCandidatesEvaluated,
    );
  }
}
