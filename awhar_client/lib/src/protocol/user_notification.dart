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
import 'notification_type.dart' as _i2;

abstract class UserNotification implements _i1.SerializableModel {
  UserNotification._({
    this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    this.relatedEntityId,
    this.relatedEntityType,
    this.dataJson,
    bool? isRead,
    this.readAt,
  }) : isRead = isRead ?? false;

  factory UserNotification({
    int? id,
    required int userId,
    required String title,
    required String body,
    required _i2.NotificationType type,
    int? relatedEntityId,
    String? relatedEntityType,
    String? dataJson,
    bool? isRead,
    DateTime? readAt,
  }) = _UserNotificationImpl;

  factory UserNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserNotification(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      type: _i2.NotificationType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      relatedEntityId: jsonSerialization['relatedEntityId'] as int?,
      relatedEntityType: jsonSerialization['relatedEntityType'] as String?,
      dataJson: jsonSerialization['dataJson'] as String?,
      isRead: jsonSerialization['isRead'] as bool,
      readAt: jsonSerialization['readAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['readAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String title;

  String body;

  _i2.NotificationType type;

  int? relatedEntityId;

  String? relatedEntityType;

  String? dataJson;

  bool isRead;

  DateTime? readAt;

  /// Returns a shallow copy of this [UserNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserNotification copyWith({
    int? id,
    int? userId,
    String? title,
    String? body,
    _i2.NotificationType? type,
    int? relatedEntityId,
    String? relatedEntityType,
    String? dataJson,
    bool? isRead,
    DateTime? readAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserNotification',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'type': type.toJson(),
      if (relatedEntityId != null) 'relatedEntityId': relatedEntityId,
      if (relatedEntityType != null) 'relatedEntityType': relatedEntityType,
      if (dataJson != null) 'dataJson': dataJson,
      'isRead': isRead,
      if (readAt != null) 'readAt': readAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserNotificationImpl extends UserNotification {
  _UserNotificationImpl({
    int? id,
    required int userId,
    required String title,
    required String body,
    required _i2.NotificationType type,
    int? relatedEntityId,
    String? relatedEntityType,
    String? dataJson,
    bool? isRead,
    DateTime? readAt,
  }) : super._(
         id: id,
         userId: userId,
         title: title,
         body: body,
         type: type,
         relatedEntityId: relatedEntityId,
         relatedEntityType: relatedEntityType,
         dataJson: dataJson,
         isRead: isRead,
         readAt: readAt,
       );

  /// Returns a shallow copy of this [UserNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserNotification copyWith({
    Object? id = _Undefined,
    int? userId,
    String? title,
    String? body,
    _i2.NotificationType? type,
    Object? relatedEntityId = _Undefined,
    Object? relatedEntityType = _Undefined,
    Object? dataJson = _Undefined,
    bool? isRead,
    Object? readAt = _Undefined,
  }) {
    return UserNotification(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      relatedEntityId: relatedEntityId is int?
          ? relatedEntityId
          : this.relatedEntityId,
      relatedEntityType: relatedEntityType is String?
          ? relatedEntityType
          : this.relatedEntityType,
      dataJson: dataJson is String? ? dataJson : this.dataJson,
      isRead: isRead ?? this.isRead,
      readAt: readAt is DateTime? ? readAt : this.readAt,
    );
  }
}
