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

abstract class StoreOrderChatMessage implements _i1.SerializableModel {
  StoreOrderChatMessage._({
    this.id,
    required this.chatId,
    required this.senderId,
    required this.senderRole,
    required this.senderName,
    String? messageType,
    required this.content,
    this.attachmentUrl,
    this.latitude,
    this.longitude,
    this.readByJson,
    this.firebaseId,
    DateTime? createdAt,
  }) : messageType = messageType ?? 'text',
       createdAt = createdAt ?? DateTime.now();

  factory StoreOrderChatMessage({
    int? id,
    required int chatId,
    required int senderId,
    required String senderRole,
    required String senderName,
    String? messageType,
    required String content,
    String? attachmentUrl,
    double? latitude,
    double? longitude,
    String? readByJson,
    String? firebaseId,
    DateTime? createdAt,
  }) = _StoreOrderChatMessageImpl;

  factory StoreOrderChatMessage.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return StoreOrderChatMessage(
      id: jsonSerialization['id'] as int?,
      chatId: jsonSerialization['chatId'] as int,
      senderId: jsonSerialization['senderId'] as int,
      senderRole: jsonSerialization['senderRole'] as String,
      senderName: jsonSerialization['senderName'] as String,
      messageType: jsonSerialization['messageType'] as String,
      content: jsonSerialization['content'] as String,
      attachmentUrl: jsonSerialization['attachmentUrl'] as String?,
      latitude: (jsonSerialization['latitude'] as num?)?.toDouble(),
      longitude: (jsonSerialization['longitude'] as num?)?.toDouble(),
      readByJson: jsonSerialization['readByJson'] as String?,
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

  int chatId;

  int senderId;

  String senderRole;

  String senderName;

  String messageType;

  String content;

  String? attachmentUrl;

  double? latitude;

  double? longitude;

  String? readByJson;

  String? firebaseId;

  DateTime createdAt;

  /// Returns a shallow copy of this [StoreOrderChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreOrderChatMessage copyWith({
    int? id,
    int? chatId,
    int? senderId,
    String? senderRole,
    String? senderName,
    String? messageType,
    String? content,
    String? attachmentUrl,
    double? latitude,
    double? longitude,
    String? readByJson,
    String? firebaseId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreOrderChatMessage',
      if (id != null) 'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'senderRole': senderRole,
      'senderName': senderName,
      'messageType': messageType,
      'content': content,
      if (attachmentUrl != null) 'attachmentUrl': attachmentUrl,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (readByJson != null) 'readByJson': readByJson,
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

class _StoreOrderChatMessageImpl extends StoreOrderChatMessage {
  _StoreOrderChatMessageImpl({
    int? id,
    required int chatId,
    required int senderId,
    required String senderRole,
    required String senderName,
    String? messageType,
    required String content,
    String? attachmentUrl,
    double? latitude,
    double? longitude,
    String? readByJson,
    String? firebaseId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         chatId: chatId,
         senderId: senderId,
         senderRole: senderRole,
         senderName: senderName,
         messageType: messageType,
         content: content,
         attachmentUrl: attachmentUrl,
         latitude: latitude,
         longitude: longitude,
         readByJson: readByJson,
         firebaseId: firebaseId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [StoreOrderChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreOrderChatMessage copyWith({
    Object? id = _Undefined,
    int? chatId,
    int? senderId,
    String? senderRole,
    String? senderName,
    String? messageType,
    String? content,
    Object? attachmentUrl = _Undefined,
    Object? latitude = _Undefined,
    Object? longitude = _Undefined,
    Object? readByJson = _Undefined,
    Object? firebaseId = _Undefined,
    DateTime? createdAt,
  }) {
    return StoreOrderChatMessage(
      id: id is int? ? id : this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      senderRole: senderRole ?? this.senderRole,
      senderName: senderName ?? this.senderName,
      messageType: messageType ?? this.messageType,
      content: content ?? this.content,
      attachmentUrl: attachmentUrl is String?
          ? attachmentUrl
          : this.attachmentUrl,
      latitude: latitude is double? ? latitude : this.latitude,
      longitude: longitude is double? ? longitude : this.longitude,
      readByJson: readByJson is String? ? readByJson : this.readByJson,
      firebaseId: firebaseId is String? ? firebaseId : this.firebaseId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
