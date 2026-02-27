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

abstract class ClientReview implements _i1.SerializableModel {
  ClientReview._({
    this.id,
    required this.orderId,
    required this.driverId,
    required this.clientId,
    required this.rating,
    this.comment,
    this.communicationRating,
    this.respectRating,
    this.paymentPromptness,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ClientReview({
    int? id,
    required int orderId,
    required int driverId,
    required int clientId,
    required int rating,
    String? comment,
    int? communicationRating,
    int? respectRating,
    int? paymentPromptness,
    DateTime? createdAt,
  }) = _ClientReviewImpl;

  factory ClientReview.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClientReview(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      driverId: jsonSerialization['driverId'] as int,
      clientId: jsonSerialization['clientId'] as int,
      rating: jsonSerialization['rating'] as int,
      comment: jsonSerialization['comment'] as String?,
      communicationRating: jsonSerialization['communicationRating'] as int?,
      respectRating: jsonSerialization['respectRating'] as int?,
      paymentPromptness: jsonSerialization['paymentPromptness'] as int?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int orderId;

  int driverId;

  int clientId;

  int rating;

  String? comment;

  int? communicationRating;

  int? respectRating;

  int? paymentPromptness;

  DateTime createdAt;

  /// Returns a shallow copy of this [ClientReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClientReview copyWith({
    int? id,
    int? orderId,
    int? driverId,
    int? clientId,
    int? rating,
    String? comment,
    int? communicationRating,
    int? respectRating,
    int? paymentPromptness,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClientReview',
      if (id != null) 'id': id,
      'orderId': orderId,
      'driverId': driverId,
      'clientId': clientId,
      'rating': rating,
      if (comment != null) 'comment': comment,
      if (communicationRating != null)
        'communicationRating': communicationRating,
      if (respectRating != null) 'respectRating': respectRating,
      if (paymentPromptness != null) 'paymentPromptness': paymentPromptness,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClientReviewImpl extends ClientReview {
  _ClientReviewImpl({
    int? id,
    required int orderId,
    required int driverId,
    required int clientId,
    required int rating,
    String? comment,
    int? communicationRating,
    int? respectRating,
    int? paymentPromptness,
    DateTime? createdAt,
  }) : super._(
         id: id,
         orderId: orderId,
         driverId: driverId,
         clientId: clientId,
         rating: rating,
         comment: comment,
         communicationRating: communicationRating,
         respectRating: respectRating,
         paymentPromptness: paymentPromptness,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ClientReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClientReview copyWith({
    Object? id = _Undefined,
    int? orderId,
    int? driverId,
    int? clientId,
    int? rating,
    Object? comment = _Undefined,
    Object? communicationRating = _Undefined,
    Object? respectRating = _Undefined,
    Object? paymentPromptness = _Undefined,
    DateTime? createdAt,
  }) {
    return ClientReview(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      driverId: driverId ?? this.driverId,
      clientId: clientId ?? this.clientId,
      rating: rating ?? this.rating,
      comment: comment is String? ? comment : this.comment,
      communicationRating: communicationRating is int?
          ? communicationRating
          : this.communicationRating,
      respectRating: respectRating is int? ? respectRating : this.respectRating,
      paymentPromptness: paymentPromptness is int?
          ? paymentPromptness
          : this.paymentPromptness,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
