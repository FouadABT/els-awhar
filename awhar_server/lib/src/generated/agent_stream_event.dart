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

abstract class AgentStreamEvent
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AgentStreamEvent._({
    required this.type,
    required this.data,
    required this.timestamp,
  });

  factory AgentStreamEvent({
    required String type,
    required String data,
    required DateTime timestamp,
  }) = _AgentStreamEventImpl;

  factory AgentStreamEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return AgentStreamEvent(
      type: jsonSerialization['type'] as String,
      data: jsonSerialization['data'] as String,
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
    );
  }

  String type;

  String data;

  DateTime timestamp;

  /// Returns a shallow copy of this [AgentStreamEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AgentStreamEvent copyWith({
    String? type,
    String? data,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgentStreamEvent',
      'type': type,
      'data': data,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AgentStreamEvent',
      'type': type,
      'data': data,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AgentStreamEventImpl extends AgentStreamEvent {
  _AgentStreamEventImpl({
    required String type,
    required String data,
    required DateTime timestamp,
  }) : super._(
         type: type,
         data: data,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [AgentStreamEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AgentStreamEvent copyWith({
    String? type,
    String? data,
    DateTime? timestamp,
  }) {
    return AgentStreamEvent(
      type: type ?? this.type,
      data: data ?? this.data,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
