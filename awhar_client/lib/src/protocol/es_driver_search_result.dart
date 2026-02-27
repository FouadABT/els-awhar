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
import 'es_driver_hit.dart' as _i2;
import 'package:awhar_client/src/protocol/protocol.dart' as _i3;

abstract class EsDriverSearchResult implements _i1.SerializableModel {
  EsDriverSearchResult._({
    required this.total,
    required this.took,
    required this.hits,
  });

  factory EsDriverSearchResult({
    required int total,
    required int took,
    required List<_i2.EsDriverHit> hits,
  }) = _EsDriverSearchResultImpl;

  factory EsDriverSearchResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EsDriverSearchResult(
      total: jsonSerialization['total'] as int,
      took: jsonSerialization['took'] as int,
      hits: _i3.Protocol().deserialize<List<_i2.EsDriverHit>>(
        jsonSerialization['hits'],
      ),
    );
  }

  int total;

  int took;

  List<_i2.EsDriverHit> hits;

  /// Returns a shallow copy of this [EsDriverSearchResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EsDriverSearchResult copyWith({
    int? total,
    int? took,
    List<_i2.EsDriverHit>? hits,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EsDriverSearchResult',
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

class _EsDriverSearchResultImpl extends EsDriverSearchResult {
  _EsDriverSearchResultImpl({
    required int total,
    required int took,
    required List<_i2.EsDriverHit> hits,
  }) : super._(
         total: total,
         took: took,
         hits: hits,
       );

  /// Returns a shallow copy of this [EsDriverSearchResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EsDriverSearchResult copyWith({
    int? total,
    int? took,
    List<_i2.EsDriverHit>? hits,
  }) {
    return EsDriverSearchResult(
      total: total ?? this.total,
      took: took ?? this.took,
      hits: hits ?? this.hits.map((e0) => e0.copyWith()).toList(),
    );
  }
}
