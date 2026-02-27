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
import 'ai_confidence_level_enum.dart' as _i2;
import 'package:awhar_server/src/generated/protocol.dart' as _i3;

abstract class AiParsedServiceRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AiParsedServiceRequest._({
    required this.originalText,
    required this.detectedServices,
    required this.suggestedServiceIds,
    this.detectedLocation,
    this.suggestedLatitude,
    this.suggestedLongitude,
    required this.detectedUrgency,
    required this.isUrgent,
    this.detectedScheduledTime,
    this.suggestedScheduledTime,
    required this.parsingConfidence,
    required this.clarificationNeeded,
    required this.clarificationQuestions,
  });

  factory AiParsedServiceRequest({
    required String originalText,
    required List<String> detectedServices,
    required List<int> suggestedServiceIds,
    String? detectedLocation,
    double? suggestedLatitude,
    double? suggestedLongitude,
    required String detectedUrgency,
    required bool isUrgent,
    String? detectedScheduledTime,
    DateTime? suggestedScheduledTime,
    required _i2.AiConfidenceLevel parsingConfidence,
    required bool clarificationNeeded,
    required List<String> clarificationQuestions,
  }) = _AiParsedServiceRequestImpl;

  factory AiParsedServiceRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AiParsedServiceRequest(
      originalText: jsonSerialization['originalText'] as String,
      detectedServices: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['detectedServices'],
      ),
      suggestedServiceIds: _i3.Protocol().deserialize<List<int>>(
        jsonSerialization['suggestedServiceIds'],
      ),
      detectedLocation: jsonSerialization['detectedLocation'] as String?,
      suggestedLatitude: (jsonSerialization['suggestedLatitude'] as num?)
          ?.toDouble(),
      suggestedLongitude: (jsonSerialization['suggestedLongitude'] as num?)
          ?.toDouble(),
      detectedUrgency: jsonSerialization['detectedUrgency'] as String,
      isUrgent: jsonSerialization['isUrgent'] as bool,
      detectedScheduledTime:
          jsonSerialization['detectedScheduledTime'] as String?,
      suggestedScheduledTime:
          jsonSerialization['suggestedScheduledTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['suggestedScheduledTime'],
            ),
      parsingConfidence: _i2.AiConfidenceLevel.fromJson(
        (jsonSerialization['parsingConfidence'] as String),
      ),
      clarificationNeeded: jsonSerialization['clarificationNeeded'] as bool,
      clarificationQuestions: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['clarificationQuestions'],
      ),
    );
  }

  String originalText;

  List<String> detectedServices;

  List<int> suggestedServiceIds;

  String? detectedLocation;

  double? suggestedLatitude;

  double? suggestedLongitude;

  String detectedUrgency;

  bool isUrgent;

  String? detectedScheduledTime;

  DateTime? suggestedScheduledTime;

  _i2.AiConfidenceLevel parsingConfidence;

  bool clarificationNeeded;

  List<String> clarificationQuestions;

  /// Returns a shallow copy of this [AiParsedServiceRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiParsedServiceRequest copyWith({
    String? originalText,
    List<String>? detectedServices,
    List<int>? suggestedServiceIds,
    String? detectedLocation,
    double? suggestedLatitude,
    double? suggestedLongitude,
    String? detectedUrgency,
    bool? isUrgent,
    String? detectedScheduledTime,
    DateTime? suggestedScheduledTime,
    _i2.AiConfidenceLevel? parsingConfidence,
    bool? clarificationNeeded,
    List<String>? clarificationQuestions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiParsedServiceRequest',
      'originalText': originalText,
      'detectedServices': detectedServices.toJson(),
      'suggestedServiceIds': suggestedServiceIds.toJson(),
      if (detectedLocation != null) 'detectedLocation': detectedLocation,
      if (suggestedLatitude != null) 'suggestedLatitude': suggestedLatitude,
      if (suggestedLongitude != null) 'suggestedLongitude': suggestedLongitude,
      'detectedUrgency': detectedUrgency,
      'isUrgent': isUrgent,
      if (detectedScheduledTime != null)
        'detectedScheduledTime': detectedScheduledTime,
      if (suggestedScheduledTime != null)
        'suggestedScheduledTime': suggestedScheduledTime?.toJson(),
      'parsingConfidence': parsingConfidence.toJson(),
      'clarificationNeeded': clarificationNeeded,
      'clarificationQuestions': clarificationQuestions.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiParsedServiceRequest',
      'originalText': originalText,
      'detectedServices': detectedServices.toJson(),
      'suggestedServiceIds': suggestedServiceIds.toJson(),
      if (detectedLocation != null) 'detectedLocation': detectedLocation,
      if (suggestedLatitude != null) 'suggestedLatitude': suggestedLatitude,
      if (suggestedLongitude != null) 'suggestedLongitude': suggestedLongitude,
      'detectedUrgency': detectedUrgency,
      'isUrgent': isUrgent,
      if (detectedScheduledTime != null)
        'detectedScheduledTime': detectedScheduledTime,
      if (suggestedScheduledTime != null)
        'suggestedScheduledTime': suggestedScheduledTime?.toJson(),
      'parsingConfidence': parsingConfidence.toJson(),
      'clarificationNeeded': clarificationNeeded,
      'clarificationQuestions': clarificationQuestions.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiParsedServiceRequestImpl extends AiParsedServiceRequest {
  _AiParsedServiceRequestImpl({
    required String originalText,
    required List<String> detectedServices,
    required List<int> suggestedServiceIds,
    String? detectedLocation,
    double? suggestedLatitude,
    double? suggestedLongitude,
    required String detectedUrgency,
    required bool isUrgent,
    String? detectedScheduledTime,
    DateTime? suggestedScheduledTime,
    required _i2.AiConfidenceLevel parsingConfidence,
    required bool clarificationNeeded,
    required List<String> clarificationQuestions,
  }) : super._(
         originalText: originalText,
         detectedServices: detectedServices,
         suggestedServiceIds: suggestedServiceIds,
         detectedLocation: detectedLocation,
         suggestedLatitude: suggestedLatitude,
         suggestedLongitude: suggestedLongitude,
         detectedUrgency: detectedUrgency,
         isUrgent: isUrgent,
         detectedScheduledTime: detectedScheduledTime,
         suggestedScheduledTime: suggestedScheduledTime,
         parsingConfidence: parsingConfidence,
         clarificationNeeded: clarificationNeeded,
         clarificationQuestions: clarificationQuestions,
       );

  /// Returns a shallow copy of this [AiParsedServiceRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiParsedServiceRequest copyWith({
    String? originalText,
    List<String>? detectedServices,
    List<int>? suggestedServiceIds,
    Object? detectedLocation = _Undefined,
    Object? suggestedLatitude = _Undefined,
    Object? suggestedLongitude = _Undefined,
    String? detectedUrgency,
    bool? isUrgent,
    Object? detectedScheduledTime = _Undefined,
    Object? suggestedScheduledTime = _Undefined,
    _i2.AiConfidenceLevel? parsingConfidence,
    bool? clarificationNeeded,
    List<String>? clarificationQuestions,
  }) {
    return AiParsedServiceRequest(
      originalText: originalText ?? this.originalText,
      detectedServices:
          detectedServices ?? this.detectedServices.map((e0) => e0).toList(),
      suggestedServiceIds:
          suggestedServiceIds ??
          this.suggestedServiceIds.map((e0) => e0).toList(),
      detectedLocation: detectedLocation is String?
          ? detectedLocation
          : this.detectedLocation,
      suggestedLatitude: suggestedLatitude is double?
          ? suggestedLatitude
          : this.suggestedLatitude,
      suggestedLongitude: suggestedLongitude is double?
          ? suggestedLongitude
          : this.suggestedLongitude,
      detectedUrgency: detectedUrgency ?? this.detectedUrgency,
      isUrgent: isUrgent ?? this.isUrgent,
      detectedScheduledTime: detectedScheduledTime is String?
          ? detectedScheduledTime
          : this.detectedScheduledTime,
      suggestedScheduledTime: suggestedScheduledTime is DateTime?
          ? suggestedScheduledTime
          : this.suggestedScheduledTime,
      parsingConfidence: parsingConfidence ?? this.parsingConfidence,
      clarificationNeeded: clarificationNeeded ?? this.clarificationNeeded,
      clarificationQuestions:
          clarificationQuestions ??
          this.clarificationQuestions.map((e0) => e0).toList(),
    );
  }
}
