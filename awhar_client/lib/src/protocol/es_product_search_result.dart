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
import 'es_product_hit.dart' as _i2;
import 'package:awhar_client/src/protocol/protocol.dart' as _i3;

abstract class EsProductSearchResult implements _i1.SerializableModel {
  EsProductSearchResult._({
    required this.total,
    required this.took,
    required this.hits,
  });

  factory EsProductSearchResult({
    required int total,
    required int took,
    required List<_i2.EsProductHit> hits,
  }) = _EsProductSearchResultImpl;

  factory EsProductSearchResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EsProductSearchResult(
      total: jsonSerialization['total'] as int,
      took: jsonSerialization['took'] as int,
      hits: _i3.Protocol().deserialize<List<_i2.EsProductHit>>(
        jsonSerialization['hits'],
      ),
    );
  }

  int total;

  int took;

  List<_i2.EsProductHit> hits;

  /// Returns a shallow copy of this [EsProductSearchResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EsProductSearchResult copyWith({
    int? total,
    int? took,
    List<_i2.EsProductHit>? hits,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EsProductSearchResult',
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

class _EsProductSearchResultImpl extends EsProductSearchResult {
  _EsProductSearchResultImpl({
    required int total,
    required int took,
    required List<_i2.EsProductHit> hits,
  }) : super._(
         total: total,
         took: took,
         hits: hits,
       );

  /// Returns a shallow copy of this [EsProductSearchResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EsProductSearchResult copyWith({
    int? total,
    int? took,
    List<_i2.EsProductHit>? hits,
  }) {
    return EsProductSearchResult(
      total: total ?? this.total,
      took: took ?? this.took,
      hits: hits ?? this.hits.map((e0) => e0.copyWith()).toList(),
    );
  }
}
