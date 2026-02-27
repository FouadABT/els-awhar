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

abstract class RatingStats implements _i1.SerializableModel {
  RatingStats._({
    required this.averageRating,
    required this.totalRatings,
  });

  factory RatingStats({
    required double averageRating,
    required int totalRatings,
  }) = _RatingStatsImpl;

  factory RatingStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return RatingStats(
      averageRating: (jsonSerialization['averageRating'] as num).toDouble(),
      totalRatings: jsonSerialization['totalRatings'] as int,
    );
  }

  double averageRating;

  int totalRatings;

  /// Returns a shallow copy of this [RatingStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RatingStats copyWith({
    double? averageRating,
    int? totalRatings,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RatingStats',
      'averageRating': averageRating,
      'totalRatings': totalRatings,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _RatingStatsImpl extends RatingStats {
  _RatingStatsImpl({
    required double averageRating,
    required int totalRatings,
  }) : super._(
         averageRating: averageRating,
         totalRatings: totalRatings,
       );

  /// Returns a shallow copy of this [RatingStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RatingStats copyWith({
    double? averageRating,
    int? totalRatings,
  }) {
    return RatingStats(
      averageRating: averageRating ?? this.averageRating,
      totalRatings: totalRatings ?? this.totalRatings,
    );
  }
}
