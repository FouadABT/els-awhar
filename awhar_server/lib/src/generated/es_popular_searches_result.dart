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
import 'es_popular_search_term.dart' as _i2;
import 'package:awhar_server/src/generated/protocol.dart' as _i3;

abstract class EsPopularSearchesResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  EsPopularSearchesResult._({required this.searches});

  factory EsPopularSearchesResult({
    required List<_i2.EsPopularSearchTerm> searches,
  }) = _EsPopularSearchesResultImpl;

  factory EsPopularSearchesResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EsPopularSearchesResult(
      searches: _i3.Protocol().deserialize<List<_i2.EsPopularSearchTerm>>(
        jsonSerialization['searches'],
      ),
    );
  }

  List<_i2.EsPopularSearchTerm> searches;

  /// Returns a shallow copy of this [EsPopularSearchesResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EsPopularSearchesResult copyWith({List<_i2.EsPopularSearchTerm>? searches});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EsPopularSearchesResult',
      'searches': searches.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EsPopularSearchesResult',
      'searches': searches.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _EsPopularSearchesResultImpl extends EsPopularSearchesResult {
  _EsPopularSearchesResultImpl({
    required List<_i2.EsPopularSearchTerm> searches,
  }) : super._(searches: searches);

  /// Returns a shallow copy of this [EsPopularSearchesResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EsPopularSearchesResult copyWith({List<_i2.EsPopularSearchTerm>? searches}) {
    return EsPopularSearchesResult(
      searches: searches ?? this.searches.map((e0) => e0.copyWith()).toList(),
    );
  }
}
