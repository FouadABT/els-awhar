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
import 'message_type_enum.dart' as _i2;

abstract class ChatMessage implements _i1.SerializableModel {
  ChatMessage._({
    this.id,
    required this.orderId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    this.messageType,
    this.attachmentUrl,
    bool? isRead,
    this.readAt,
    this.firebaseId,
    DateTime? createdAt,
  }) : isRead = isRead ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory ChatMessage({
    int? id,
    required int orderId,
    required int senderId,
    required int receiverId,
    required String message,
    _i2.MessageType? messageType,
    String? attachmentUrl,
    bool? isRead,
    DateTime? readAt,
    String? firebaseId,
    DateTime? createdAt,
  }) = _ChatMessageImpl;

  factory ChatMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatMessage(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      senderId: jsonSerialization['senderId'] as int,
      receiverId: jsonSerialization['receiverId'] as int,
      message: jsonSerialization['message'] as String,
      messageType: jsonSerialization['messageType'] == null
          ? null
          : _i2.MessageType.fromJson((jsonSerialization['messageType'] as int)),
      attachmentUrl: jsonSerialization['attachmentUrl'] as String?,
      isRead: jsonSerialization['isRead'] as bool,
      readAt: jsonSerialization['readAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['readAt']),
      firebaseId: jsonSerialization['firebaseId'] as String?,
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

  int senderId;

  int receiverId;

  String message;

  _i2.MessageType? messageType;

  String? attachmentUrl;

  bool isRead;

  DateTime? readAt;

  String? firebaseId;

  DateTime createdAt;

  /// Returns a shallow copy of this [ChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChatMessage copyWith({
    int? id,
    int? orderId,
    int? senderId,
    int? receiverId,
    String? message,
    _i2.MessageType? messageType,
    String? attachmentUrl,
    bool? isRead,
    DateTime? readAt,
    String? firebaseId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatMessage',
      if (id != null) 'id': id,
      'orderId': orderId,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      if (messageType != null) 'messageType': messageType?.toJson(),
      if (attachmentUrl != null) 'attachmentUrl': attachmentUrl,
      'isRead': isRead,
      if (readAt != null) 'readAt': readAt?.toJson(),
      if (firebaseId != null) 'firebaseId': firebaseId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatMessageImpl extends ChatMessage {
  _ChatMessageImpl({
    int? id,
    required int orderId,
    required int senderId,
    required int receiverId,
    required String message,
    _i2.MessageType? messageType,
    String? attachmentUrl,
    bool? isRead,
    DateTime? readAt,
    String? firebaseId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         orderId: orderId,
         senderId: senderId,
         receiverId: receiverId,
         message: message,
         messageType: messageType,
         attachmentUrl: attachmentUrl,
         isRead: isRead,
         readAt: readAt,
         firebaseId: firebaseId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChatMessage copyWith({
    Object? id = _Undefined,
    int? orderId,
    int? senderId,
    int? receiverId,
    String? message,
    Object? messageType = _Undefined,
    Object? attachmentUrl = _Undefined,
    bool? isRead,
    Object? readAt = _Undefined,
    Object? firebaseId = _Undefined,
    DateTime? createdAt,
  }) {
    return ChatMessage(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      message: message ?? this.message,
      messageType: messageType is _i2.MessageType?
          ? messageType
          : this.messageType,
      attachmentUrl: attachmentUrl is String?
          ? attachmentUrl
          : this.attachmentUrl,
      isRead: isRead ?? this.isRead,
      readAt: readAt is DateTime? ? readAt : this.readAt,
      firebaseId: firebaseId is String? ? firebaseId : this.firebaseId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
