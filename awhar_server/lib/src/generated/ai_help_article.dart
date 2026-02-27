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

abstract class AiHelpArticle
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AiHelpArticle._({
    required this.title,
    required this.content,
    required this.category,
    required this.relevanceScore,
  });

  factory AiHelpArticle({
    required String title,
    required String content,
    required String category,
    required double relevanceScore,
  }) = _AiHelpArticleImpl;

  factory AiHelpArticle.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiHelpArticle(
      title: jsonSerialization['title'] as String,
      content: jsonSerialization['content'] as String,
      category: jsonSerialization['category'] as String,
      relevanceScore: (jsonSerialization['relevanceScore'] as num).toDouble(),
    );
  }

  String title;

  String content;

  String category;

  double relevanceScore;

  /// Returns a shallow copy of this [AiHelpArticle]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiHelpArticle copyWith({
    String? title,
    String? content,
    String? category,
    double? relevanceScore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiHelpArticle',
      'title': title,
      'content': content,
      'category': category,
      'relevanceScore': relevanceScore,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiHelpArticle',
      'title': title,
      'content': content,
      'category': category,
      'relevanceScore': relevanceScore,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AiHelpArticleImpl extends AiHelpArticle {
  _AiHelpArticleImpl({
    required String title,
    required String content,
    required String category,
    required double relevanceScore,
  }) : super._(
         title: title,
         content: content,
         category: category,
         relevanceScore: relevanceScore,
       );

  /// Returns a shallow copy of this [AiHelpArticle]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiHelpArticle copyWith({
    String? title,
    String? content,
    String? category,
    double? relevanceScore,
  }) {
    return AiHelpArticle(
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      relevanceScore: relevanceScore ?? this.relevanceScore,
    );
  }
}
