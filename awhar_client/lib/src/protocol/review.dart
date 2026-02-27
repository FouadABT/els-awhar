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

abstract class Review implements _i1.SerializableModel {
  Review._({
    this.id,
    required this.orderId,
    required this.driverId,
    required this.clientId,
    required this.rating,
    this.comment,
    bool? isVisible,
    bool? isVerified,
    bool? isFlagged,
    this.flagReason,
    this.flaggedByUserId,
    this.flaggedAt,
    this.driverResponse,
    this.driverRespondedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isVisible = isVisible ?? true,
       isVerified = isVerified ?? true,
       isFlagged = isFlagged ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Review({
    int? id,
    required int orderId,
    required int driverId,
    required int clientId,
    required int rating,
    String? comment,
    bool? isVisible,
    bool? isVerified,
    bool? isFlagged,
    String? flagReason,
    int? flaggedByUserId,
    DateTime? flaggedAt,
    String? driverResponse,
    DateTime? driverRespondedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ReviewImpl;

  factory Review.fromJson(Map<String, dynamic> jsonSerialization) {
    return Review(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      driverId: jsonSerialization['driverId'] as int,
      clientId: jsonSerialization['clientId'] as int,
      rating: jsonSerialization['rating'] as int,
      comment: jsonSerialization['comment'] as String?,
      isVisible: jsonSerialization['isVisible'] as bool,
      isVerified: jsonSerialization['isVerified'] as bool,
      isFlagged: jsonSerialization['isFlagged'] as bool,
      flagReason: jsonSerialization['flagReason'] as String?,
      flaggedByUserId: jsonSerialization['flaggedByUserId'] as int?,
      flaggedAt: jsonSerialization['flaggedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['flaggedAt']),
      driverResponse: jsonSerialization['driverResponse'] as String?,
      driverRespondedAt: jsonSerialization['driverRespondedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['driverRespondedAt'],
            ),
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

  int orderId;

  int driverId;

  int clientId;

  int rating;

  String? comment;

  bool isVisible;

  bool isVerified;

  bool isFlagged;

  String? flagReason;

  int? flaggedByUserId;

  DateTime? flaggedAt;

  String? driverResponse;

  DateTime? driverRespondedAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Review]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Review copyWith({
    int? id,
    int? orderId,
    int? driverId,
    int? clientId,
    int? rating,
    String? comment,
    bool? isVisible,
    bool? isVerified,
    bool? isFlagged,
    String? flagReason,
    int? flaggedByUserId,
    DateTime? flaggedAt,
    String? driverResponse,
    DateTime? driverRespondedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Review',
      if (id != null) 'id': id,
      'orderId': orderId,
      'driverId': driverId,
      'clientId': clientId,
      'rating': rating,
      if (comment != null) 'comment': comment,
      'isVisible': isVisible,
      'isVerified': isVerified,
      'isFlagged': isFlagged,
      if (flagReason != null) 'flagReason': flagReason,
      if (flaggedByUserId != null) 'flaggedByUserId': flaggedByUserId,
      if (flaggedAt != null) 'flaggedAt': flaggedAt?.toJson(),
      if (driverResponse != null) 'driverResponse': driverResponse,
      if (driverRespondedAt != null)
        'driverRespondedAt': driverRespondedAt?.toJson(),
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

class _ReviewImpl extends Review {
  _ReviewImpl({
    int? id,
    required int orderId,
    required int driverId,
    required int clientId,
    required int rating,
    String? comment,
    bool? isVisible,
    bool? isVerified,
    bool? isFlagged,
    String? flagReason,
    int? flaggedByUserId,
    DateTime? flaggedAt,
    String? driverResponse,
    DateTime? driverRespondedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         orderId: orderId,
         driverId: driverId,
         clientId: clientId,
         rating: rating,
         comment: comment,
         isVisible: isVisible,
         isVerified: isVerified,
         isFlagged: isFlagged,
         flagReason: flagReason,
         flaggedByUserId: flaggedByUserId,
         flaggedAt: flaggedAt,
         driverResponse: driverResponse,
         driverRespondedAt: driverRespondedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Review]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Review copyWith({
    Object? id = _Undefined,
    int? orderId,
    int? driverId,
    int? clientId,
    int? rating,
    Object? comment = _Undefined,
    bool? isVisible,
    bool? isVerified,
    bool? isFlagged,
    Object? flagReason = _Undefined,
    Object? flaggedByUserId = _Undefined,
    Object? flaggedAt = _Undefined,
    Object? driverResponse = _Undefined,
    Object? driverRespondedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Review(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      driverId: driverId ?? this.driverId,
      clientId: clientId ?? this.clientId,
      rating: rating ?? this.rating,
      comment: comment is String? ? comment : this.comment,
      isVisible: isVisible ?? this.isVisible,
      isVerified: isVerified ?? this.isVerified,
      isFlagged: isFlagged ?? this.isFlagged,
      flagReason: flagReason is String? ? flagReason : this.flagReason,
      flaggedByUserId: flaggedByUserId is int?
          ? flaggedByUserId
          : this.flaggedByUserId,
      flaggedAt: flaggedAt is DateTime? ? flaggedAt : this.flaggedAt,
      driverResponse: driverResponse is String?
          ? driverResponse
          : this.driverResponse,
      driverRespondedAt: driverRespondedAt is DateTime?
          ? driverRespondedAt
          : this.driverRespondedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
