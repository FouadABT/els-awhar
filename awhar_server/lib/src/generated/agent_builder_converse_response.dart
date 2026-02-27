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
import 'agent_builder_step.dart' as _i2;
import 'package:awhar_server/src/generated/protocol.dart' as _i3;

abstract class AgentBuilderConverseResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AgentBuilderConverseResponse._({
    required this.conversationId,
    this.roundId,
    required this.message,
    required this.steps,
    required this.processingTimeMs,
    required this.success,
    this.errorMessage,
    this.agentId,
    this.model,
    this.llmCalls,
    this.inputTokens,
    this.outputTokens,
    this.estimatedCostUsd,
  });

  factory AgentBuilderConverseResponse({
    required String conversationId,
    String? roundId,
    required String message,
    required List<_i2.AgentBuilderStep> steps,
    required int processingTimeMs,
    required bool success,
    String? errorMessage,
    String? agentId,
    String? model,
    int? llmCalls,
    int? inputTokens,
    int? outputTokens,
    double? estimatedCostUsd,
  }) = _AgentBuilderConverseResponseImpl;

  factory AgentBuilderConverseResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AgentBuilderConverseResponse(
      conversationId: jsonSerialization['conversationId'] as String,
      roundId: jsonSerialization['roundId'] as String?,
      message: jsonSerialization['message'] as String,
      steps: _i3.Protocol().deserialize<List<_i2.AgentBuilderStep>>(
        jsonSerialization['steps'],
      ),
      processingTimeMs: jsonSerialization['processingTimeMs'] as int,
      success: jsonSerialization['success'] as bool,
      errorMessage: jsonSerialization['errorMessage'] as String?,
      agentId: jsonSerialization['agentId'] as String?,
      model: jsonSerialization['model'] as String?,
      llmCalls: jsonSerialization['llmCalls'] as int?,
      inputTokens: jsonSerialization['inputTokens'] as int?,
      outputTokens: jsonSerialization['outputTokens'] as int?,
      estimatedCostUsd: (jsonSerialization['estimatedCostUsd'] as num?)
          ?.toDouble(),
    );
  }

  String conversationId;

  String? roundId;

  String message;

  List<_i2.AgentBuilderStep> steps;

  int processingTimeMs;

  bool success;

  String? errorMessage;

  String? agentId;

  String? model;

  int? llmCalls;

  int? inputTokens;

  int? outputTokens;

  double? estimatedCostUsd;

  /// Returns a shallow copy of this [AgentBuilderConverseResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AgentBuilderConverseResponse copyWith({
    String? conversationId,
    String? roundId,
    String? message,
    List<_i2.AgentBuilderStep>? steps,
    int? processingTimeMs,
    bool? success,
    String? errorMessage,
    String? agentId,
    String? model,
    int? llmCalls,
    int? inputTokens,
    int? outputTokens,
    double? estimatedCostUsd,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgentBuilderConverseResponse',
      'conversationId': conversationId,
      if (roundId != null) 'roundId': roundId,
      'message': message,
      'steps': steps.toJson(valueToJson: (v) => v.toJson()),
      'processingTimeMs': processingTimeMs,
      'success': success,
      if (errorMessage != null) 'errorMessage': errorMessage,
      if (agentId != null) 'agentId': agentId,
      if (model != null) 'model': model,
      if (llmCalls != null) 'llmCalls': llmCalls,
      if (inputTokens != null) 'inputTokens': inputTokens,
      if (outputTokens != null) 'outputTokens': outputTokens,
      if (estimatedCostUsd != null) 'estimatedCostUsd': estimatedCostUsd,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AgentBuilderConverseResponse',
      'conversationId': conversationId,
      if (roundId != null) 'roundId': roundId,
      'message': message,
      'steps': steps.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'processingTimeMs': processingTimeMs,
      'success': success,
      if (errorMessage != null) 'errorMessage': errorMessage,
      if (agentId != null) 'agentId': agentId,
      if (model != null) 'model': model,
      if (llmCalls != null) 'llmCalls': llmCalls,
      if (inputTokens != null) 'inputTokens': inputTokens,
      if (outputTokens != null) 'outputTokens': outputTokens,
      if (estimatedCostUsd != null) 'estimatedCostUsd': estimatedCostUsd,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AgentBuilderConverseResponseImpl extends AgentBuilderConverseResponse {
  _AgentBuilderConverseResponseImpl({
    required String conversationId,
    String? roundId,
    required String message,
    required List<_i2.AgentBuilderStep> steps,
    required int processingTimeMs,
    required bool success,
    String? errorMessage,
    String? agentId,
    String? model,
    int? llmCalls,
    int? inputTokens,
    int? outputTokens,
    double? estimatedCostUsd,
  }) : super._(
         conversationId: conversationId,
         roundId: roundId,
         message: message,
         steps: steps,
         processingTimeMs: processingTimeMs,
         success: success,
         errorMessage: errorMessage,
         agentId: agentId,
         model: model,
         llmCalls: llmCalls,
         inputTokens: inputTokens,
         outputTokens: outputTokens,
         estimatedCostUsd: estimatedCostUsd,
       );

  /// Returns a shallow copy of this [AgentBuilderConverseResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AgentBuilderConverseResponse copyWith({
    String? conversationId,
    Object? roundId = _Undefined,
    String? message,
    List<_i2.AgentBuilderStep>? steps,
    int? processingTimeMs,
    bool? success,
    Object? errorMessage = _Undefined,
    Object? agentId = _Undefined,
    Object? model = _Undefined,
    Object? llmCalls = _Undefined,
    Object? inputTokens = _Undefined,
    Object? outputTokens = _Undefined,
    Object? estimatedCostUsd = _Undefined,
  }) {
    return AgentBuilderConverseResponse(
      conversationId: conversationId ?? this.conversationId,
      roundId: roundId is String? ? roundId : this.roundId,
      message: message ?? this.message,
      steps: steps ?? this.steps.map((e0) => e0.copyWith()).toList(),
      processingTimeMs: processingTimeMs ?? this.processingTimeMs,
      success: success ?? this.success,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      agentId: agentId is String? ? agentId : this.agentId,
      model: model is String? ? model : this.model,
      llmCalls: llmCalls is int? ? llmCalls : this.llmCalls,
      inputTokens: inputTokens is int? ? inputTokens : this.inputTokens,
      outputTokens: outputTokens is int? ? outputTokens : this.outputTokens,
      estimatedCostUsd: estimatedCostUsd is double?
          ? estimatedCostUsd
          : this.estimatedCostUsd,
    );
  }
}
