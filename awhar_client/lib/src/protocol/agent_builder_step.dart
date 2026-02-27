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

abstract class AgentBuilderStep implements _i1.SerializableModel {
  AgentBuilderStep._({
    required this.type,
    this.toolName,
    this.toolInput,
    this.toolOutput,
    this.text,
  });

  factory AgentBuilderStep({
    required String type,
    String? toolName,
    String? toolInput,
    String? toolOutput,
    String? text,
  }) = _AgentBuilderStepImpl;

  factory AgentBuilderStep.fromJson(Map<String, dynamic> jsonSerialization) {
    return AgentBuilderStep(
      type: jsonSerialization['type'] as String,
      toolName: jsonSerialization['toolName'] as String?,
      toolInput: jsonSerialization['toolInput'] as String?,
      toolOutput: jsonSerialization['toolOutput'] as String?,
      text: jsonSerialization['text'] as String?,
    );
  }

  String type;

  String? toolName;

  String? toolInput;

  String? toolOutput;

  String? text;

  /// Returns a shallow copy of this [AgentBuilderStep]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AgentBuilderStep copyWith({
    String? type,
    String? toolName,
    String? toolInput,
    String? toolOutput,
    String? text,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgentBuilderStep',
      'type': type,
      if (toolName != null) 'toolName': toolName,
      if (toolInput != null) 'toolInput': toolInput,
      if (toolOutput != null) 'toolOutput': toolOutput,
      if (text != null) 'text': text,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AgentBuilderStepImpl extends AgentBuilderStep {
  _AgentBuilderStepImpl({
    required String type,
    String? toolName,
    String? toolInput,
    String? toolOutput,
    String? text,
  }) : super._(
         type: type,
         toolName: toolName,
         toolInput: toolInput,
         toolOutput: toolOutput,
         text: text,
       );

  /// Returns a shallow copy of this [AgentBuilderStep]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AgentBuilderStep copyWith({
    String? type,
    Object? toolName = _Undefined,
    Object? toolInput = _Undefined,
    Object? toolOutput = _Undefined,
    Object? text = _Undefined,
  }) {
    return AgentBuilderStep(
      type: type ?? this.type,
      toolName: toolName is String? ? toolName : this.toolName,
      toolInput: toolInput is String? ? toolInput : this.toolInput,
      toolOutput: toolOutput is String? ? toolOutput : this.toolOutput,
      text: text is String? ? text : this.text,
    );
  }
}
