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
import 'ai_agent_type_enum.dart' as _i2;
import 'ai_response_status_enum.dart' as _i3;
import 'ai_help_article.dart' as _i4;
import 'package:awhar_client/src/protocol/protocol.dart' as _i5;

abstract class AiHelpSearchResponse implements _i1.SerializableModel {
  AiHelpSearchResponse._({
    required this.agentType,
    required this.status,
    this.errorMessage,
    required this.processingTimeMs,
    required this.timestamp,
    required this.question,
    required this.articles,
    required this.summary,
    this.topCategory,
  });

  factory AiHelpSearchResponse({
    required _i2.AiAgentType agentType,
    required _i3.AiResponseStatus status,
    String? errorMessage,
    required int processingTimeMs,
    required DateTime timestamp,
    required String question,
    required List<_i4.AiHelpArticle> articles,
    required String summary,
    String? topCategory,
  }) = _AiHelpSearchResponseImpl;

  factory AiHelpSearchResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AiHelpSearchResponse(
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
      question: jsonSerialization['question'] as String,
      articles: _i5.Protocol().deserialize<List<_i4.AiHelpArticle>>(
        jsonSerialization['articles'],
      ),
      summary: jsonSerialization['summary'] as String,
      topCategory: jsonSerialization['topCategory'] as String?,
    );
  }

  _i2.AiAgentType agentType;

  _i3.AiResponseStatus status;

  String? errorMessage;

  int processingTimeMs;

  DateTime timestamp;

  String question;

  List<_i4.AiHelpArticle> articles;

  String summary;

  String? topCategory;

  /// Returns a shallow copy of this [AiHelpSearchResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiHelpSearchResponse copyWith({
    _i2.AiAgentType? agentType,
    _i3.AiResponseStatus? status,
    String? errorMessage,
    int? processingTimeMs,
    DateTime? timestamp,
    String? question,
    List<_i4.AiHelpArticle>? articles,
    String? summary,
    String? topCategory,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiHelpSearchResponse',
      'agentType': agentType.toJson(),
      'status': status.toJson(),
      if (errorMessage != null) 'errorMessage': errorMessage,
      'processingTimeMs': processingTimeMs,
      'timestamp': timestamp.toJson(),
      'question': question,
      'articles': articles.toJson(valueToJson: (v) => v.toJson()),
      'summary': summary,
      if (topCategory != null) 'topCategory': topCategory,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiHelpSearchResponseImpl extends AiHelpSearchResponse {
  _AiHelpSearchResponseImpl({
    required _i2.AiAgentType agentType,
    required _i3.AiResponseStatus status,
    String? errorMessage,
    required int processingTimeMs,
    required DateTime timestamp,
    required String question,
    required List<_i4.AiHelpArticle> articles,
    required String summary,
    String? topCategory,
  }) : super._(
         agentType: agentType,
         status: status,
         errorMessage: errorMessage,
         processingTimeMs: processingTimeMs,
         timestamp: timestamp,
         question: question,
         articles: articles,
         summary: summary,
         topCategory: topCategory,
       );

  /// Returns a shallow copy of this [AiHelpSearchResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiHelpSearchResponse copyWith({
    _i2.AiAgentType? agentType,
    _i3.AiResponseStatus? status,
    Object? errorMessage = _Undefined,
    int? processingTimeMs,
    DateTime? timestamp,
    String? question,
    List<_i4.AiHelpArticle>? articles,
    String? summary,
    Object? topCategory = _Undefined,
  }) {
    return AiHelpSearchResponse(
      agentType: agentType ?? this.agentType,
      status: status ?? this.status,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      processingTimeMs: processingTimeMs ?? this.processingTimeMs,
      timestamp: timestamp ?? this.timestamp,
      question: question ?? this.question,
      articles: articles ?? this.articles.map((e0) => e0.copyWith()).toList(),
      summary: summary ?? this.summary,
      topCategory: topCategory is String? ? topCategory : this.topCategory,
    );
  }
}
