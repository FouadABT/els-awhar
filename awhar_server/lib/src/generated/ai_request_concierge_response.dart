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
import 'ai_parsed_service_request.dart' as _i4;
import 'package:awhar_server/src/generated/protocol.dart' as _i5;

abstract class AiRequestConciergeResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AiRequestConciergeResponse._({
    required this.agentType,
    required this.status,
    this.errorMessage,
    required this.processingTimeMs,
    required this.timestamp,
    this.parsedRequest,
    required this.humanReadableSummary,
  });

  factory AiRequestConciergeResponse({
    required _i2.AiAgentType agentType,
    required _i3.AiResponseStatus status,
    String? errorMessage,
    required int processingTimeMs,
    required DateTime timestamp,
    _i4.AiParsedServiceRequest? parsedRequest,
    required String humanReadableSummary,
  }) = _AiRequestConciergeResponseImpl;

  factory AiRequestConciergeResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AiRequestConciergeResponse(
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
      parsedRequest: jsonSerialization['parsedRequest'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.AiParsedServiceRequest>(
              jsonSerialization['parsedRequest'],
            ),
      humanReadableSummary: jsonSerialization['humanReadableSummary'] as String,
    );
  }

  _i2.AiAgentType agentType;

  _i3.AiResponseStatus status;

  String? errorMessage;

  int processingTimeMs;

  DateTime timestamp;

  _i4.AiParsedServiceRequest? parsedRequest;

  String humanReadableSummary;

  /// Returns a shallow copy of this [AiRequestConciergeResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiRequestConciergeResponse copyWith({
    _i2.AiAgentType? agentType,
    _i3.AiResponseStatus? status,
    String? errorMessage,
    int? processingTimeMs,
    DateTime? timestamp,
    _i4.AiParsedServiceRequest? parsedRequest,
    String? humanReadableSummary,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiRequestConciergeResponse',
      'agentType': agentType.toJson(),
      'status': status.toJson(),
      if (errorMessage != null) 'errorMessage': errorMessage,
      'processingTimeMs': processingTimeMs,
      'timestamp': timestamp.toJson(),
      if (parsedRequest != null) 'parsedRequest': parsedRequest?.toJson(),
      'humanReadableSummary': humanReadableSummary,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiRequestConciergeResponse',
      'agentType': agentType.toJson(),
      'status': status.toJson(),
      if (errorMessage != null) 'errorMessage': errorMessage,
      'processingTimeMs': processingTimeMs,
      'timestamp': timestamp.toJson(),
      if (parsedRequest != null)
        'parsedRequest': parsedRequest?.toJsonForProtocol(),
      'humanReadableSummary': humanReadableSummary,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiRequestConciergeResponseImpl extends AiRequestConciergeResponse {
  _AiRequestConciergeResponseImpl({
    required _i2.AiAgentType agentType,
    required _i3.AiResponseStatus status,
    String? errorMessage,
    required int processingTimeMs,
    required DateTime timestamp,
    _i4.AiParsedServiceRequest? parsedRequest,
    required String humanReadableSummary,
  }) : super._(
         agentType: agentType,
         status: status,
         errorMessage: errorMessage,
         processingTimeMs: processingTimeMs,
         timestamp: timestamp,
         parsedRequest: parsedRequest,
         humanReadableSummary: humanReadableSummary,
       );

  /// Returns a shallow copy of this [AiRequestConciergeResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiRequestConciergeResponse copyWith({
    _i2.AiAgentType? agentType,
    _i3.AiResponseStatus? status,
    Object? errorMessage = _Undefined,
    int? processingTimeMs,
    DateTime? timestamp,
    Object? parsedRequest = _Undefined,
    String? humanReadableSummary,
  }) {
    return AiRequestConciergeResponse(
      agentType: agentType ?? this.agentType,
      status: status ?? this.status,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      processingTimeMs: processingTimeMs ?? this.processingTimeMs,
      timestamp: timestamp ?? this.timestamp,
      parsedRequest: parsedRequest is _i4.AiParsedServiceRequest?
          ? parsedRequest
          : this.parsedRequest?.copyWith(),
      humanReadableSummary: humanReadableSummary ?? this.humanReadableSummary,
    );
  }
}
