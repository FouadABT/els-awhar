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

abstract class EsPopularSearchTerm
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  EsPopularSearchTerm._({
    required this.term,
    required this.count,
  });

  factory EsPopularSearchTerm({
    required String term,
    required int count,
  }) = _EsPopularSearchTermImpl;

  factory EsPopularSearchTerm.fromJson(Map<String, dynamic> jsonSerialization) {
    return EsPopularSearchTerm(
      term: jsonSerialization['term'] as String,
      count: jsonSerialization['count'] as int,
    );
  }

  String term;

  int count;

  /// Returns a shallow copy of this [EsPopularSearchTerm]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EsPopularSearchTerm copyWith({
    String? term,
    int? count,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EsPopularSearchTerm',
      'term': term,
      'count': count,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EsPopularSearchTerm',
      'term': term,
      'count': count,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _EsPopularSearchTermImpl extends EsPopularSearchTerm {
  _EsPopularSearchTermImpl({
    required String term,
    required int count,
  }) : super._(
         term: term,
         count: count,
       );

  /// Returns a shallow copy of this [EsPopularSearchTerm]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EsPopularSearchTerm copyWith({
    String? term,
    int? count,
  }) {
    return EsPopularSearchTerm(
      term: term ?? this.term,
      count: count ?? this.count,
    );
  }
}
