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

abstract class BlockedUser implements _i1.SerializableModel {
  BlockedUser._({
    this.id,
    required this.userId,
    required this.blockedUserId,
    this.reason,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory BlockedUser({
    int? id,
    required int userId,
    required int blockedUserId,
    String? reason,
    DateTime? createdAt,
  }) = _BlockedUserImpl;

  factory BlockedUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return BlockedUser(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      blockedUserId: jsonSerialization['blockedUserId'] as int,
      reason: jsonSerialization['reason'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int blockedUserId;

  String? reason;

  DateTime createdAt;

  /// Returns a shallow copy of this [BlockedUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BlockedUser copyWith({
    int? id,
    int? userId,
    int? blockedUserId,
    String? reason,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BlockedUser',
      if (id != null) 'id': id,
      'userId': userId,
      'blockedUserId': blockedUserId,
      if (reason != null) 'reason': reason,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BlockedUserImpl extends BlockedUser {
  _BlockedUserImpl({
    int? id,
    required int userId,
    required int blockedUserId,
    String? reason,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         blockedUserId: blockedUserId,
         reason: reason,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [BlockedUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BlockedUser copyWith({
    Object? id = _Undefined,
    int? userId,
    int? blockedUserId,
    Object? reason = _Undefined,
    DateTime? createdAt,
  }) {
    return BlockedUser(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      blockedUserId: blockedUserId ?? this.blockedUserId,
      reason: reason is String? ? reason : this.reason,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
