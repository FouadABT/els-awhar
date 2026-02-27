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

abstract class EsCategoryCount implements _i1.SerializableModel {
  EsCategoryCount._({
    required this.categoryId,
    required this.categoryName,
    required this.count,
  });

  factory EsCategoryCount({
    required int categoryId,
    required String categoryName,
    required int count,
  }) = _EsCategoryCountImpl;

  factory EsCategoryCount.fromJson(Map<String, dynamic> jsonSerialization) {
    return EsCategoryCount(
      categoryId: jsonSerialization['categoryId'] as int,
      categoryName: jsonSerialization['categoryName'] as String,
      count: jsonSerialization['count'] as int,
    );
  }

  int categoryId;

  String categoryName;

  int count;

  /// Returns a shallow copy of this [EsCategoryCount]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EsCategoryCount copyWith({
    int? categoryId,
    String? categoryName,
    int? count,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EsCategoryCount',
      'categoryId': categoryId,
      'categoryName': categoryName,
      'count': count,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _EsCategoryCountImpl extends EsCategoryCount {
  _EsCategoryCountImpl({
    required int categoryId,
    required String categoryName,
    required int count,
  }) : super._(
         categoryId: categoryId,
         categoryName: categoryName,
         count: count,
       );

  /// Returns a shallow copy of this [EsCategoryCount]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EsCategoryCount copyWith({
    int? categoryId,
    String? categoryName,
    int? count,
  }) {
    return EsCategoryCount(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      count: count ?? this.count,
    );
  }
}
