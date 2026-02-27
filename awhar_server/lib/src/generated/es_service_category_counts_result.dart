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
import 'es_category_count.dart' as _i2;
import 'package:awhar_server/src/generated/protocol.dart' as _i3;

abstract class EsServiceCategoryCountsResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  EsServiceCategoryCountsResult._({
    required this.categories,
    required this.total,
  });

  factory EsServiceCategoryCountsResult({
    required List<_i2.EsCategoryCount> categories,
    required int total,
  }) = _EsServiceCategoryCountsResultImpl;

  factory EsServiceCategoryCountsResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EsServiceCategoryCountsResult(
      categories: _i3.Protocol().deserialize<List<_i2.EsCategoryCount>>(
        jsonSerialization['categories'],
      ),
      total: jsonSerialization['total'] as int,
    );
  }

  List<_i2.EsCategoryCount> categories;

  int total;

  /// Returns a shallow copy of this [EsServiceCategoryCountsResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EsServiceCategoryCountsResult copyWith({
    List<_i2.EsCategoryCount>? categories,
    int? total,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EsServiceCategoryCountsResult',
      'categories': categories.toJson(valueToJson: (v) => v.toJson()),
      'total': total,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EsServiceCategoryCountsResult',
      'categories': categories.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'total': total,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _EsServiceCategoryCountsResultImpl extends EsServiceCategoryCountsResult {
  _EsServiceCategoryCountsResultImpl({
    required List<_i2.EsCategoryCount> categories,
    required int total,
  }) : super._(
         categories: categories,
         total: total,
       );

  /// Returns a shallow copy of this [EsServiceCategoryCountsResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EsServiceCategoryCountsResult copyWith({
    List<_i2.EsCategoryCount>? categories,
    int? total,
  }) {
    return EsServiceCategoryCountsResult(
      categories:
          categories ?? this.categories.map((e0) => e0.copyWith()).toList(),
      total: total ?? this.total,
    );
  }
}
