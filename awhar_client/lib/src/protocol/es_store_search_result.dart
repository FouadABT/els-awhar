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
import 'es_store_hit.dart' as _i2;
import 'package:awhar_client/src/protocol/protocol.dart' as _i3;

abstract class EsStoreSearchResult implements _i1.SerializableModel {
  EsStoreSearchResult._({
    required this.total,
    required this.took,
    required this.hits,
  });

  factory EsStoreSearchResult({
    required int total,
    required int took,
    required List<_i2.EsStoreHit> hits,
  }) = _EsStoreSearchResultImpl;

  factory EsStoreSearchResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return EsStoreSearchResult(
      total: jsonSerialization['total'] as int,
      took: jsonSerialization['took'] as int,
      hits: _i3.Protocol().deserialize<List<_i2.EsStoreHit>>(
        jsonSerialization['hits'],
      ),
    );
  }

  int total;

  int took;

  List<_i2.EsStoreHit> hits;

  /// Returns a shallow copy of this [EsStoreSearchResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EsStoreSearchResult copyWith({
    int? total,
    int? took,
    List<_i2.EsStoreHit>? hits,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EsStoreSearchResult',
      'total': total,
      'took': took,
      'hits': hits.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _EsStoreSearchResultImpl extends EsStoreSearchResult {
  _EsStoreSearchResultImpl({
    required int total,
    required int took,
    required List<_i2.EsStoreHit> hits,
  }) : super._(
         total: total,
         took: took,
         hits: hits,
       );

  /// Returns a shallow copy of this [EsStoreSearchResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EsStoreSearchResult copyWith({
    int? total,
    int? took,
    List<_i2.EsStoreHit>? hits,
  }) {
    return EsStoreSearchResult(
      total: total ?? this.total,
      took: took ?? this.took,
      hits: hits ?? this.hits.map((e0) => e0.copyWith()).toList(),
    );
  }
}
