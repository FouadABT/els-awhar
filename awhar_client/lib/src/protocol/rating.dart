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
import 'rating_type_enum.dart' as _i2;
import 'package:awhar_client/src/protocol/protocol.dart' as _i3;

abstract class Rating implements _i1.SerializableModel {
  Rating._({
    this.id,
    required this.requestId,
    required this.raterId,
    required this.ratedUserId,
    required this.ratingValue,
    required this.ratingType,
    this.reviewText,
    this.quickTags,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Rating({
    int? id,
    required int requestId,
    required int raterId,
    required int ratedUserId,
    required int ratingValue,
    required _i2.RatingType ratingType,
    String? reviewText,
    List<String>? quickTags,
    DateTime? createdAt,
  }) = _RatingImpl;

  factory Rating.fromJson(Map<String, dynamic> jsonSerialization) {
    return Rating(
      id: jsonSerialization['id'] as int?,
      requestId: jsonSerialization['requestId'] as int,
      raterId: jsonSerialization['raterId'] as int,
      ratedUserId: jsonSerialization['ratedUserId'] as int,
      ratingValue: jsonSerialization['ratingValue'] as int,
      ratingType: _i2.RatingType.fromJson(
        (jsonSerialization['ratingType'] as String),
      ),
      reviewText: jsonSerialization['reviewText'] as String?,
      quickTags: jsonSerialization['quickTags'] == null
          ? null
          : _i3.Protocol().deserialize<List<String>>(
              jsonSerialization['quickTags'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int requestId;

  int raterId;

  int ratedUserId;

  int ratingValue;

  _i2.RatingType ratingType;

  String? reviewText;

  List<String>? quickTags;

  DateTime createdAt;

  /// Returns a shallow copy of this [Rating]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Rating copyWith({
    int? id,
    int? requestId,
    int? raterId,
    int? ratedUserId,
    int? ratingValue,
    _i2.RatingType? ratingType,
    String? reviewText,
    List<String>? quickTags,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Rating',
      if (id != null) 'id': id,
      'requestId': requestId,
      'raterId': raterId,
      'ratedUserId': ratedUserId,
      'ratingValue': ratingValue,
      'ratingType': ratingType.toJson(),
      if (reviewText != null) 'reviewText': reviewText,
      if (quickTags != null) 'quickTags': quickTags?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RatingImpl extends Rating {
  _RatingImpl({
    int? id,
    required int requestId,
    required int raterId,
    required int ratedUserId,
    required int ratingValue,
    required _i2.RatingType ratingType,
    String? reviewText,
    List<String>? quickTags,
    DateTime? createdAt,
  }) : super._(
         id: id,
         requestId: requestId,
         raterId: raterId,
         ratedUserId: ratedUserId,
         ratingValue: ratingValue,
         ratingType: ratingType,
         reviewText: reviewText,
         quickTags: quickTags,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Rating]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Rating copyWith({
    Object? id = _Undefined,
    int? requestId,
    int? raterId,
    int? ratedUserId,
    int? ratingValue,
    _i2.RatingType? ratingType,
    Object? reviewText = _Undefined,
    Object? quickTags = _Undefined,
    DateTime? createdAt,
  }) {
    return Rating(
      id: id is int? ? id : this.id,
      requestId: requestId ?? this.requestId,
      raterId: raterId ?? this.raterId,
      ratedUserId: ratedUserId ?? this.ratedUserId,
      ratingValue: ratingValue ?? this.ratingValue,
      ratingType: ratingType ?? this.ratingType,
      reviewText: reviewText is String? ? reviewText : this.reviewText,
      quickTags: quickTags is List<String>?
          ? quickTags
          : this.quickTags?.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
