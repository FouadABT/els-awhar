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

abstract class EsPriceStats
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  EsPriceStats._({
    this.categoryId,
    this.categoryName,
    required this.minPrice,
    required this.maxPrice,
    required this.avgPrice,
    required this.count,
  });

  factory EsPriceStats({
    int? categoryId,
    String? categoryName,
    required double minPrice,
    required double maxPrice,
    required double avgPrice,
    required int count,
  }) = _EsPriceStatsImpl;

  factory EsPriceStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return EsPriceStats(
      categoryId: jsonSerialization['categoryId'] as int?,
      categoryName: jsonSerialization['categoryName'] as String?,
      minPrice: (jsonSerialization['minPrice'] as num).toDouble(),
      maxPrice: (jsonSerialization['maxPrice'] as num).toDouble(),
      avgPrice: (jsonSerialization['avgPrice'] as num).toDouble(),
      count: jsonSerialization['count'] as int,
    );
  }

  int? categoryId;

  String? categoryName;

  double minPrice;

  double maxPrice;

  double avgPrice;

  int count;

  /// Returns a shallow copy of this [EsPriceStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EsPriceStats copyWith({
    int? categoryId,
    String? categoryName,
    double? minPrice,
    double? maxPrice,
    double? avgPrice,
    int? count,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EsPriceStats',
      if (categoryId != null) 'categoryId': categoryId,
      if (categoryName != null) 'categoryName': categoryName,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'avgPrice': avgPrice,
      'count': count,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EsPriceStats',
      if (categoryId != null) 'categoryId': categoryId,
      if (categoryName != null) 'categoryName': categoryName,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'avgPrice': avgPrice,
      'count': count,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EsPriceStatsImpl extends EsPriceStats {
  _EsPriceStatsImpl({
    int? categoryId,
    String? categoryName,
    required double minPrice,
    required double maxPrice,
    required double avgPrice,
    required int count,
  }) : super._(
         categoryId: categoryId,
         categoryName: categoryName,
         minPrice: minPrice,
         maxPrice: maxPrice,
         avgPrice: avgPrice,
         count: count,
       );

  /// Returns a shallow copy of this [EsPriceStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EsPriceStats copyWith({
    Object? categoryId = _Undefined,
    Object? categoryName = _Undefined,
    double? minPrice,
    double? maxPrice,
    double? avgPrice,
    int? count,
  }) {
    return EsPriceStats(
      categoryId: categoryId is int? ? categoryId : this.categoryId,
      categoryName: categoryName is String? ? categoryName : this.categoryName,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      avgPrice: avgPrice ?? this.avgPrice,
      count: count ?? this.count,
    );
  }
}
