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

abstract class EsSearchResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  EsSearchResult._({
    required this.total,
    required this.took,
    required this.timedOut,
    required this.hitsJson,
    this.aggregationsJson,
  });

  factory EsSearchResult({
    required int total,
    required int took,
    required bool timedOut,
    required String hitsJson,
    String? aggregationsJson,
  }) = _EsSearchResultImpl;

  factory EsSearchResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return EsSearchResult(
      total: jsonSerialization['total'] as int,
      took: jsonSerialization['took'] as int,
      timedOut: jsonSerialization['timedOut'] as bool,
      hitsJson: jsonSerialization['hitsJson'] as String,
      aggregationsJson: jsonSerialization['aggregationsJson'] as String?,
    );
  }

  int total;

  int took;

  bool timedOut;

  String hitsJson;

  String? aggregationsJson;

  /// Returns a shallow copy of this [EsSearchResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EsSearchResult copyWith({
    int? total,
    int? took,
    bool? timedOut,
    String? hitsJson,
    String? aggregationsJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EsSearchResult',
      'total': total,
      'took': took,
      'timedOut': timedOut,
      'hitsJson': hitsJson,
      if (aggregationsJson != null) 'aggregationsJson': aggregationsJson,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EsSearchResult',
      'total': total,
      'took': took,
      'timedOut': timedOut,
      'hitsJson': hitsJson,
      if (aggregationsJson != null) 'aggregationsJson': aggregationsJson,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EsSearchResultImpl extends EsSearchResult {
  _EsSearchResultImpl({
    required int total,
    required int took,
    required bool timedOut,
    required String hitsJson,
    String? aggregationsJson,
  }) : super._(
         total: total,
         took: took,
         timedOut: timedOut,
         hitsJson: hitsJson,
         aggregationsJson: aggregationsJson,
       );

  /// Returns a shallow copy of this [EsSearchResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EsSearchResult copyWith({
    int? total,
    int? took,
    bool? timedOut,
    String? hitsJson,
    Object? aggregationsJson = _Undefined,
  }) {
    return EsSearchResult(
      total: total ?? this.total,
      took: took ?? this.took,
      timedOut: timedOut ?? this.timedOut,
      hitsJson: hitsJson ?? this.hitsJson,
      aggregationsJson: aggregationsJson is String?
          ? aggregationsJson
          : this.aggregationsJson,
    );
  }
}
