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

abstract class AiAgentStatus
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AiAgentStatus._({
    required this.agentType,
    required this.isOnline,
    this.lastInvocation,
    required this.totalInvocations,
    required this.successRate,
    required this.averageResponseTimeMs,
  });

  factory AiAgentStatus({
    required _i2.AiAgentType agentType,
    required bool isOnline,
    DateTime? lastInvocation,
    required int totalInvocations,
    required double successRate,
    required int averageResponseTimeMs,
  }) = _AiAgentStatusImpl;

  factory AiAgentStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiAgentStatus(
      agentType: _i2.AiAgentType.fromJson(
        (jsonSerialization['agentType'] as String),
      ),
      isOnline: jsonSerialization['isOnline'] as bool,
      lastInvocation: jsonSerialization['lastInvocation'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastInvocation'],
            ),
      totalInvocations: jsonSerialization['totalInvocations'] as int,
      successRate: (jsonSerialization['successRate'] as num).toDouble(),
      averageResponseTimeMs: jsonSerialization['averageResponseTimeMs'] as int,
    );
  }

  _i2.AiAgentType agentType;

  bool isOnline;

  DateTime? lastInvocation;

  int totalInvocations;

  double successRate;

  int averageResponseTimeMs;

  /// Returns a shallow copy of this [AiAgentStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiAgentStatus copyWith({
    _i2.AiAgentType? agentType,
    bool? isOnline,
    DateTime? lastInvocation,
    int? totalInvocations,
    double? successRate,
    int? averageResponseTimeMs,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiAgentStatus',
      'agentType': agentType.toJson(),
      'isOnline': isOnline,
      if (lastInvocation != null) 'lastInvocation': lastInvocation?.toJson(),
      'totalInvocations': totalInvocations,
      'successRate': successRate,
      'averageResponseTimeMs': averageResponseTimeMs,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiAgentStatus',
      'agentType': agentType.toJson(),
      'isOnline': isOnline,
      if (lastInvocation != null) 'lastInvocation': lastInvocation?.toJson(),
      'totalInvocations': totalInvocations,
      'successRate': successRate,
      'averageResponseTimeMs': averageResponseTimeMs,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiAgentStatusImpl extends AiAgentStatus {
  _AiAgentStatusImpl({
    required _i2.AiAgentType agentType,
    required bool isOnline,
    DateTime? lastInvocation,
    required int totalInvocations,
    required double successRate,
    required int averageResponseTimeMs,
  }) : super._(
         agentType: agentType,
         isOnline: isOnline,
         lastInvocation: lastInvocation,
         totalInvocations: totalInvocations,
         successRate: successRate,
         averageResponseTimeMs: averageResponseTimeMs,
       );

  /// Returns a shallow copy of this [AiAgentStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiAgentStatus copyWith({
    _i2.AiAgentType? agentType,
    bool? isOnline,
    Object? lastInvocation = _Undefined,
    int? totalInvocations,
    double? successRate,
    int? averageResponseTimeMs,
  }) {
    return AiAgentStatus(
      agentType: agentType ?? this.agentType,
      isOnline: isOnline ?? this.isOnline,
      lastInvocation: lastInvocation is DateTime?
          ? lastInvocation
          : this.lastInvocation,
      totalInvocations: totalInvocations ?? this.totalInvocations,
      successRate: successRate ?? this.successRate,
      averageResponseTimeMs:
          averageResponseTimeMs ?? this.averageResponseTimeMs,
    );
  }
}
