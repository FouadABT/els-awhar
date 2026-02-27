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

/// Chat Participants Info
/// Contains information about all participants in a store order chat
abstract class ChatParticipantsInfo
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ChatParticipantsInfo._({
    required this.clientId,
    required this.clientName,
    required this.storeId,
    required this.storeName,
    this.driverId,
    this.driverName,
  });

  factory ChatParticipantsInfo({
    required int clientId,
    required String clientName,
    required int storeId,
    required String storeName,
    int? driverId,
    String? driverName,
  }) = _ChatParticipantsInfoImpl;

  factory ChatParticipantsInfo.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ChatParticipantsInfo(
      clientId: jsonSerialization['clientId'] as int,
      clientName: jsonSerialization['clientName'] as String,
      storeId: jsonSerialization['storeId'] as int,
      storeName: jsonSerialization['storeName'] as String,
      driverId: jsonSerialization['driverId'] as int?,
      driverName: jsonSerialization['driverName'] as String?,
    );
  }

  /// Client ID
  int clientId;

  /// Client name (user's full name)
  String clientName;

  /// Store ID
  int storeId;

  /// Store name
  String storeName;

  /// Driver ID (null if not assigned)
  int? driverId;

  /// Driver name (null if not assigned)
  String? driverName;

  /// Returns a shallow copy of this [ChatParticipantsInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChatParticipantsInfo copyWith({
    int? clientId,
    String? clientName,
    int? storeId,
    String? storeName,
    int? driverId,
    String? driverName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatParticipantsInfo',
      'clientId': clientId,
      'clientName': clientName,
      'storeId': storeId,
      'storeName': storeName,
      if (driverId != null) 'driverId': driverId,
      if (driverName != null) 'driverName': driverName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatParticipantsInfo',
      'clientId': clientId,
      'clientName': clientName,
      'storeId': storeId,
      'storeName': storeName,
      if (driverId != null) 'driverId': driverId,
      if (driverName != null) 'driverName': driverName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatParticipantsInfoImpl extends ChatParticipantsInfo {
  _ChatParticipantsInfoImpl({
    required int clientId,
    required String clientName,
    required int storeId,
    required String storeName,
    int? driverId,
    String? driverName,
  }) : super._(
         clientId: clientId,
         clientName: clientName,
         storeId: storeId,
         storeName: storeName,
         driverId: driverId,
         driverName: driverName,
       );

  /// Returns a shallow copy of this [ChatParticipantsInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChatParticipantsInfo copyWith({
    int? clientId,
    String? clientName,
    int? storeId,
    String? storeName,
    Object? driverId = _Undefined,
    Object? driverName = _Undefined,
  }) {
    return ChatParticipantsInfo(
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      driverId: driverId is int? ? driverId : this.driverId,
      driverName: driverName is String? ? driverName : this.driverName,
    );
  }
}
