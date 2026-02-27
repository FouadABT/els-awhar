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

abstract class ReviewWithReviewer
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ReviewWithReviewer._({
    required this.reviewId,
    required this.storeOrderId,
    required this.reviewerId,
    required this.revieweeType,
    required this.revieweeId,
    required this.rating,
    this.comment,
    this.response,
    this.responseAt,
    required this.createdAt,
    required this.reviewerName,
    this.reviewerPhotoUrl,
  });

  factory ReviewWithReviewer({
    required int reviewId,
    required int storeOrderId,
    required int reviewerId,
    required String revieweeType,
    required int revieweeId,
    required int rating,
    String? comment,
    String? response,
    DateTime? responseAt,
    required DateTime createdAt,
    required String reviewerName,
    String? reviewerPhotoUrl,
  }) = _ReviewWithReviewerImpl;

  factory ReviewWithReviewer.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReviewWithReviewer(
      reviewId: jsonSerialization['reviewId'] as int,
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
      reviewerName: jsonSerialization['reviewerName'] as String,
      reviewerPhotoUrl: jsonSerialization['reviewerPhotoUrl'] as String?,
    );
  }

  int reviewId;

  int storeOrderId;

  int reviewerId;

  String revieweeType;

  int revieweeId;

  int rating;

  String? comment;

  String? response;

  DateTime? responseAt;

  DateTime createdAt;

  String reviewerName;

  String? reviewerPhotoUrl;

  /// Returns a shallow copy of this [ReviewWithReviewer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReviewWithReviewer copyWith({
    int? reviewId,
    int? storeOrderId,
    int? reviewerId,
    String? revieweeType,
    int? revieweeId,
    int? rating,
    String? comment,
    String? response,
    DateTime? responseAt,
    DateTime? createdAt,
    String? reviewerName,
    String? reviewerPhotoUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReviewWithReviewer',
      'reviewId': reviewId,
      'storeOrderId': storeOrderId,
      'reviewerId': reviewerId,
      'revieweeType': revieweeType,
      'revieweeId': revieweeId,
      'rating': rating,
      if (comment != null) 'comment': comment,
      if (response != null) 'response': response,
      if (responseAt != null) 'responseAt': responseAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'reviewerName': reviewerName,
      if (reviewerPhotoUrl != null) 'reviewerPhotoUrl': reviewerPhotoUrl,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReviewWithReviewer',
      'reviewId': reviewId,
      'storeOrderId': storeOrderId,
      'reviewerId': reviewerId,
      'revieweeType': revieweeType,
      'revieweeId': revieweeId,
      'rating': rating,
      if (comment != null) 'comment': comment,
      if (response != null) 'response': response,
      if (responseAt != null) 'responseAt': responseAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'reviewerName': reviewerName,
      if (reviewerPhotoUrl != null) 'reviewerPhotoUrl': reviewerPhotoUrl,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReviewWithReviewerImpl extends ReviewWithReviewer {
  _ReviewWithReviewerImpl({
    required int reviewId,
    required int storeOrderId,
    required int reviewerId,
    required String revieweeType,
    required int revieweeId,
    required int rating,
    String? comment,
    String? response,
    DateTime? responseAt,
    required DateTime createdAt,
    required String reviewerName,
    String? reviewerPhotoUrl,
  }) : super._(
         reviewId: reviewId,
         storeOrderId: storeOrderId,
         reviewerId: reviewerId,
         revieweeType: revieweeType,
         revieweeId: revieweeId,
         rating: rating,
         comment: comment,
         response: response,
         responseAt: responseAt,
         createdAt: createdAt,
         reviewerName: reviewerName,
         reviewerPhotoUrl: reviewerPhotoUrl,
       );

  /// Returns a shallow copy of this [ReviewWithReviewer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReviewWithReviewer copyWith({
    int? reviewId,
    int? storeOrderId,
    int? reviewerId,
    String? revieweeType,
    int? revieweeId,
    int? rating,
    Object? comment = _Undefined,
    Object? response = _Undefined,
    Object? responseAt = _Undefined,
    DateTime? createdAt,
    String? reviewerName,
    Object? reviewerPhotoUrl = _Undefined,
  }) {
    return ReviewWithReviewer(
      reviewId: reviewId ?? this.reviewId,
      storeOrderId: storeOrderId ?? this.storeOrderId,
      reviewerId: reviewerId ?? this.reviewerId,
      revieweeType: revieweeType ?? this.revieweeType,
      revieweeId: revieweeId ?? this.revieweeId,
      rating: rating ?? this.rating,
      comment: comment is String? ? comment : this.comment,
      response: response is String? ? response : this.response,
      responseAt: responseAt is DateTime? ? responseAt : this.responseAt,
      createdAt: createdAt ?? this.createdAt,
      reviewerName: reviewerName ?? this.reviewerName,
      reviewerPhotoUrl: reviewerPhotoUrl is String?
          ? reviewerPhotoUrl
          : this.reviewerPhotoUrl,
    );
  }
}
