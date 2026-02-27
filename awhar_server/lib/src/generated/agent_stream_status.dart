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
import 'agent_stream_event.dart' as _i2;
import 'agent_builder_step.dart' as _i3;
import 'package:awhar_server/src/generated/protocol.dart' as _i4;

abstract class AgentStreamStatus
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AgentStreamStatus._({
    required this.sessionId,
    required this.status,
    required this.events,
    this.conversationId,
    this.finalMessage,
    this.steps,
    this.errorMessage,
    this.processingTimeMs,
    this.agentId,
  });

  factory AgentStreamStatus({
    required String sessionId,
    required String status,
    required List<_i2.AgentStreamEvent> events,
    String? conversationId,
    String? finalMessage,
    List<_i3.AgentBuilderStep>? steps,
    String? errorMessage,
    int? processingTimeMs,
    String? agentId,
  }) = _AgentStreamStatusImpl;

  factory AgentStreamStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return AgentStreamStatus(
      sessionId: jsonSerialization['sessionId'] as String,
      status: jsonSerialization['status'] as String,
      events: _i4.Protocol().deserialize<List<_i2.AgentStreamEvent>>(
        jsonSerialization['events'],
      ),
      conversationId: jsonSerialization['conversationId'] as String?,
      finalMessage: jsonSerialization['finalMessage'] as String?,
      steps: jsonSerialization['steps'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.AgentBuilderStep>>(
              jsonSerialization['steps'],
            ),
      errorMessage: jsonSerialization['errorMessage'] as String?,
      processingTimeMs: jsonSerialization['processingTimeMs'] as int?,
      agentId: jsonSerialization['agentId'] as String?,
    );
  }

  String sessionId;

  String status;

  List<_i2.AgentStreamEvent> events;

  String? conversationId;

  String? finalMessage;

  List<_i3.AgentBuilderStep>? steps;

  String? errorMessage;

  int? processingTimeMs;

  String? agentId;

  /// Returns a shallow copy of this [AgentStreamStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AgentStreamStatus copyWith({
    String? sessionId,
    String? status,
    List<_i2.AgentStreamEvent>? events,
    String? conversationId,
    String? finalMessage,
    List<_i3.AgentBuilderStep>? steps,
    String? errorMessage,
    int? processingTimeMs,
    String? agentId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgentStreamStatus',
      'sessionId': sessionId,
      'status': status,
      'events': events.toJson(valueToJson: (v) => v.toJson()),
      if (conversationId != null) 'conversationId': conversationId,
      if (finalMessage != null) 'finalMessage': finalMessage,
      if (steps != null) 'steps': steps?.toJson(valueToJson: (v) => v.toJson()),
      if (errorMessage != null) 'errorMessage': errorMessage,
      if (processingTimeMs != null) 'processingTimeMs': processingTimeMs,
      if (agentId != null) 'agentId': agentId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AgentStreamStatus',
      'sessionId': sessionId,
      'status': status,
      'events': events.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (conversationId != null) 'conversationId': conversationId,
      if (finalMessage != null) 'finalMessage': finalMessage,
      if (steps != null)
        'steps': steps?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (errorMessage != null) 'errorMessage': errorMessage,
      if (processingTimeMs != null) 'processingTimeMs': processingTimeMs,
      if (agentId != null) 'agentId': agentId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AgentStreamStatusImpl extends AgentStreamStatus {
  _AgentStreamStatusImpl({
    required String sessionId,
    required String status,
    required List<_i2.AgentStreamEvent> events,
    String? conversationId,
    String? finalMessage,
    List<_i3.AgentBuilderStep>? steps,
    String? errorMessage,
    int? processingTimeMs,
    String? agentId,
  }) : super._(
         sessionId: sessionId,
         status: status,
         events: events,
         conversationId: conversationId,
         finalMessage: finalMessage,
         steps: steps,
         errorMessage: errorMessage,
         processingTimeMs: processingTimeMs,
         agentId: agentId,
       );

  /// Returns a shallow copy of this [AgentStreamStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AgentStreamStatus copyWith({
    String? sessionId,
    String? status,
    List<_i2.AgentStreamEvent>? events,
    Object? conversationId = _Undefined,
    Object? finalMessage = _Undefined,
    Object? steps = _Undefined,
    Object? errorMessage = _Undefined,
    Object? processingTimeMs = _Undefined,
    Object? agentId = _Undefined,
  }) {
    return AgentStreamStatus(
      sessionId: sessionId ?? this.sessionId,
      status: status ?? this.status,
      events: events ?? this.events.map((e0) => e0.copyWith()).toList(),
      conversationId: conversationId is String?
          ? conversationId
          : this.conversationId,
      finalMessage: finalMessage is String? ? finalMessage : this.finalMessage,
      steps: steps is List<_i3.AgentBuilderStep>?
          ? steps
          : this.steps?.map((e0) => e0.copyWith()).toList(),
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      processingTimeMs: processingTimeMs is int?
          ? processingTimeMs
          : this.processingTimeMs,
      agentId: agentId is String? ? agentId : this.agentId,
    );
  }
}
