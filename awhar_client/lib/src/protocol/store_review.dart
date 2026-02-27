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

abstract class StoreReview implements _i1.SerializableModel {
  StoreReview._({
    this.id,
    required this.storeOrderId,
    required this.reviewerId,
    required this.revieweeType,
    required this.revieweeId,
    required this.rating,
    this.comment,
    this.response,
    this.responseAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory StoreReview({
    int? id,
    required int storeOrderId,
    required int reviewerId,
    required String revieweeType,
    required int revieweeId,
    required int rating,
    String? comment,
    String? response,
    DateTime? responseAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StoreReviewImpl;

  factory StoreReview.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreReview(
      id: jsonSerialization['id'] as int?,
      storeOrderId: jsonSerialization['storeOrderId'] as int,
      reviewerId: jsonSerialization['reviewerId'] as int,
      revieweeType: jsonSerialization['revieweeType'] as String,
      revieweeId: jsonSerialization['revieweeId'] as int,
      rating: jsonSerialization['rating'] as int,
      comment: jsonSerialization['comment'] as String?,
      response: jsonSerialization['response'] as String?,
      responseAt: jsonSerialization['responseAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['responseAt']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int storeOrderId;

  int reviewerId;

  String revieweeType;

  int revieweeId;

  int rating;

  String? comment;

  String? response;

  DateTime? responseAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [StoreReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreReview copyWith({
    int? id,
    int? storeOrderId,
    int? reviewerId,
    String? revieweeType,
    int? revieweeId,
    int? rating,
    String? comment,
    String? response,
    DateTime? responseAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreReview',
      if (id != null) 'id': id,
      'storeOrderId': storeOrderId,
      'reviewerId': reviewerId,
      'revieweeType': revieweeType,
      'revieweeId': revieweeId,
      'rating': rating,
      if (comment != null) 'comment': comment,
      if (response != null) 'response': response,
      if (responseAt != null) 'responseAt': responseAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreReviewImpl extends StoreReview {
  _StoreReviewImpl({
    int? id,
    required int storeOrderId,
    required int reviewerId,
    required String revieweeType,
    required int revieweeId,
    required int rating,
    String? comment,
    String? response,
    DateTime? responseAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         storeOrderId: storeOrderId,
         reviewerId: reviewerId,
         revieweeType: revieweeType,
         revieweeId: revieweeId,
         rating: rating,
         comment: comment,
         response: response,
         responseAt: responseAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StoreReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreReview copyWith({
    Object? id = _Undefined,
    int? storeOrderId,
    int? reviewerId,
    String? revieweeType,
    int? revieweeId,
    int? rating,
    Object? comment = _Undefined,
    Object? response = _Undefined,
    Object? responseAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StoreReview(
      id: id is int? ? id : this.id,
      storeOrderId: storeOrderId ?? this.storeOrderId,
      reviewerId: reviewerId ?? this.reviewerId,
      revieweeType: revieweeType ?? this.revieweeType,
      revieweeId: revieweeId ?? this.revieweeId,
      rating: rating ?? this.rating,
      comment: comment is String? ? comment : this.comment,
      response: response is String? ? response : this.response,
      responseAt: responseAt is DateTime? ? responseAt : this.responseAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
