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
import 'es_service_hit.dart' as _i2;
import 'package:awhar_server/src/generated/protocol.dart' as _i3;

abstract class EsServiceSearchResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  EsServiceSearchResult._({
    required this.total,
    required this.took,
    required this.hits,
  });

  factory EsServiceSearchResult({
    required int total,
    required int took,
    required List<_i2.EsServiceHit> hits,
  }) = _EsServiceSearchResultImpl;

  factory EsServiceSearchResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EsServiceSearchResult(
      total: jsonSerialization['total'] as int,
      took: jsonSerialization['took'] as int,
      hits: _i3.Protocol().deserialize<List<_i2.EsServiceHit>>(
        jsonSerialization['hits'],
      ),
    );
  }

  int total;

  int took;

  List<_i2.EsServiceHit> hits;

  /// Returns a shallow copy of this [EsServiceSearchResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EsServiceSearchResult copyWith({
    int? total,
    int? took,
    List<_i2.EsServiceHit>? hits,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EsServiceSearchResult',
      'total': total,
      'took': took,
      'hits': hits.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EsServiceSearchResult',
      'total': total,
      'took': took,
      'hits': hits.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _EsServiceSearchResultImpl extends EsServiceSearchResult {
  _EsServiceSearchResultImpl({
    required int total,
    required int took,
    required List<_i2.EsServiceHit> hits,
  }) : super._(
         total: total,
         took: took,
         hits: hits,
       );

  /// Returns a shallow copy of this [EsServiceSearchResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EsServiceSearchResult copyWith({
    int? total,
    int? took,
    List<_i2.EsServiceHit>? hits,
  }) {
    return EsServiceSearchResult(
      total: total ?? this.total,
      took: took ?? this.took,
      hits: hits ?? this.hits.map((e0) => e0.copyWith()).toList(),
    );
  }
}
