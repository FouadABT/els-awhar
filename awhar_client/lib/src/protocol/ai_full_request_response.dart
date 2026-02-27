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
import 'ai_request_concierge_response.dart' as _i2;
import 'ai_driver_matching_response.dart' as _i3;
import 'package:awhar_client/src/protocol/protocol.dart' as _i4;

abstract class AiFullRequestResponse implements _i1.SerializableModel {
  AiFullRequestResponse._({
    this.conciergeResponse,
    this.matchingResponse,
    required this.totalProcessingTimeMs,
    required this.timestamp,
  });

  factory AiFullRequestResponse({
    _i2.AiRequestConciergeResponse? conciergeResponse,
    _i3.AiDriverMatchingResponse? matchingResponse,
    required int totalProcessingTimeMs,
    required DateTime timestamp,
  }) = _AiFullRequestResponseImpl;

  factory AiFullRequestResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AiFullRequestResponse(
      conciergeResponse: jsonSerialization['conciergeResponse'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.AiRequestConciergeResponse>(
              jsonSerialization['conciergeResponse'],
            ),
      matchingResponse: jsonSerialization['matchingResponse'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.AiDriverMatchingResponse>(
              jsonSerialization['matchingResponse'],
            ),
      totalProcessingTimeMs: jsonSerialization['totalProcessingTimeMs'] as int,
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
    );
  }

  _i2.AiRequestConciergeResponse? conciergeResponse;

  _i3.AiDriverMatchingResponse? matchingResponse;

  int totalProcessingTimeMs;

  DateTime timestamp;

  /// Returns a shallow copy of this [AiFullRequestResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiFullRequestResponse copyWith({
    _i2.AiRequestConciergeResponse? conciergeResponse,
    _i3.AiDriverMatchingResponse? matchingResponse,
    int? totalProcessingTimeMs,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiFullRequestResponse',
      if (conciergeResponse != null)
        'conciergeResponse': conciergeResponse?.toJson(),
      if (matchingResponse != null)
        'matchingResponse': matchingResponse?.toJson(),
      'totalProcessingTimeMs': totalProcessingTimeMs,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiFullRequestResponseImpl extends AiFullRequestResponse {
  _AiFullRequestResponseImpl({
    _i2.AiRequestConciergeResponse? conciergeResponse,
    _i3.AiDriverMatchingResponse? matchingResponse,
    required int totalProcessingTimeMs,
    required DateTime timestamp,
  }) : super._(
         conciergeResponse: conciergeResponse,
         matchingResponse: matchingResponse,
         totalProcessingTimeMs: totalProcessingTimeMs,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [AiFullRequestResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiFullRequestResponse copyWith({
    Object? conciergeResponse = _Undefined,
    Object? matchingResponse = _Undefined,
    int? totalProcessingTimeMs,
    DateTime? timestamp,
  }) {
    return AiFullRequestResponse(
      conciergeResponse: conciergeResponse is _i2.AiRequestConciergeResponse?
          ? conciergeResponse
          : this.conciergeResponse?.copyWith(),
      matchingResponse: matchingResponse is _i3.AiDriverMatchingResponse?
          ? matchingResponse
          : this.matchingResponse?.copyWith(),
      totalProcessingTimeMs:
          totalProcessingTimeMs ?? this.totalProcessingTimeMs,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
