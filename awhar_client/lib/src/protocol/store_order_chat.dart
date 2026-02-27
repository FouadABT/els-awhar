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

abstract class StoreOrderChat implements _i1.SerializableModel {
  StoreOrderChat._({
    this.id,
    required this.storeOrderId,
    required this.clientId,
    required this.storeId,
    this.driverId,
    this.firebaseChannelId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isActive = isActive ?? true,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory StoreOrderChat({
    int? id,
    required int storeOrderId,
    required int clientId,
    required int storeId,
    int? driverId,
    String? firebaseChannelId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StoreOrderChatImpl;

  factory StoreOrderChat.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreOrderChat(
      id: jsonSerialization['id'] as int?,
      storeOrderId: jsonSerialization['storeOrderId'] as int,
      clientId: jsonSerialization['clientId'] as int,
      storeId: jsonSerialization['storeId'] as int,
      driverId: jsonSerialization['driverId'] as int?,
      firebaseChannelId: jsonSerialization['firebaseChannelId'] as String?,
      isActive: jsonSerialization['isActive'] as bool,
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

  int clientId;

  int storeId;

  int? driverId;

  String? firebaseChannelId;

  bool isActive;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [StoreOrderChat]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreOrderChat copyWith({
    int? id,
    int? storeOrderId,
    int? clientId,
    int? storeId,
    int? driverId,
    String? firebaseChannelId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreOrderChat',
      if (id != null) 'id': id,
      'storeOrderId': storeOrderId,
      'clientId': clientId,
      'storeId': storeId,
      if (driverId != null) 'driverId': driverId,
      if (firebaseChannelId != null) 'firebaseChannelId': firebaseChannelId,
      'isActive': isActive,
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

class _StoreOrderChatImpl extends StoreOrderChat {
  _StoreOrderChatImpl({
    int? id,
    required int storeOrderId,
    required int clientId,
    required int storeId,
    int? driverId,
    String? firebaseChannelId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         storeOrderId: storeOrderId,
         clientId: clientId,
         storeId: storeId,
         driverId: driverId,
         firebaseChannelId: firebaseChannelId,
         isActive: isActive,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StoreOrderChat]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreOrderChat copyWith({
    Object? id = _Undefined,
    int? storeOrderId,
    int? clientId,
    int? storeId,
    Object? driverId = _Undefined,
    Object? firebaseChannelId = _Undefined,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StoreOrderChat(
      id: id is int? ? id : this.id,
      storeOrderId: storeOrderId ?? this.storeOrderId,
      clientId: clientId ?? this.clientId,
      storeId: storeId ?? this.storeId,
      driverId: driverId is int? ? driverId : this.driverId,
      firebaseChannelId: firebaseChannelId is String?
          ? firebaseChannelId
          : this.firebaseChannelId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
