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
import 'ai_agent_status.dart' as _i2;
import 'package:awhar_server/src/generated/protocol.dart' as _i3;

abstract class AiAgentStatusResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AiAgentStatusResponse._({
    required this.agents,
    required this.elasticsearchConnected,
    required this.lastHealthCheck,
  });

  factory AiAgentStatusResponse({
    required List<_i2.AiAgentStatus> agents,
    required bool elasticsearchConnected,
    required DateTime lastHealthCheck,
  }) = _AiAgentStatusResponseImpl;

  factory AiAgentStatusResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AiAgentStatusResponse(
      agents: _i3.Protocol().deserialize<List<_i2.AiAgentStatus>>(
        jsonSerialization['agents'],
      ),
      elasticsearchConnected:
          jsonSerialization['elasticsearchConnected'] as bool,
      lastHealthCheck: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastHealthCheck'],
      ),
    );
  }

  List<_i2.AiAgentStatus> agents;

  bool elasticsearchConnected;

  DateTime lastHealthCheck;

  /// Returns a shallow copy of this [AiAgentStatusResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiAgentStatusResponse copyWith({
    List<_i2.AiAgentStatus>? agents,
    bool? elasticsearchConnected,
    DateTime? lastHealthCheck,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiAgentStatusResponse',
      'agents': agents.toJson(valueToJson: (v) => v.toJson()),
      'elasticsearchConnected': elasticsearchConnected,
      'lastHealthCheck': lastHealthCheck.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiAgentStatusResponse',
      'agents': agents.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'elasticsearchConnected': elasticsearchConnected,
      'lastHealthCheck': lastHealthCheck.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AiAgentStatusResponseImpl extends AiAgentStatusResponse {
  _AiAgentStatusResponseImpl({
    required List<_i2.AiAgentStatus> agents,
    required bool elasticsearchConnected,
    required DateTime lastHealthCheck,
  }) : super._(
         agents: agents,
         elasticsearchConnected: elasticsearchConnected,
         lastHealthCheck: lastHealthCheck,
       );

  /// Returns a shallow copy of this [AiAgentStatusResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiAgentStatusResponse copyWith({
    List<_i2.AiAgentStatus>? agents,
    bool? elasticsearchConnected,
    DateTime? lastHealthCheck,
  }) {
    return AiAgentStatusResponse(
      agents: agents ?? this.agents.map((e0) => e0.copyWith()).toList(),
      elasticsearchConnected:
          elasticsearchConnected ?? this.elasticsearchConnected,
      lastHealthCheck: lastHealthCheck ?? this.lastHealthCheck,
    );
  }
}
