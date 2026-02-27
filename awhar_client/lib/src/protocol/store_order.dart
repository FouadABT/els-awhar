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
import 'store_order_status_enum.dart' as _i2;

abstract class StoreOrder implements _i1.SerializableModel {
  StoreOrder._({
    this.id,
    required this.orderNumber,
    required this.storeId,
    required this.clientId,
    this.driverId,
    required this.status,
    required this.itemsJson,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    String? currency,
    String? currencySymbol,
    double? platformCommission,
    double? driverEarnings,
    required this.deliveryAddress,
    required this.deliveryLatitude,
    required this.deliveryLongitude,
    this.deliveryDistance,
    this.clientNotes,
    this.storeNotes,
    this.timelineJson,
    this.chatId,
    this.cancelledBy,
    this.cancellationReason,
    DateTime? createdAt,
    this.confirmedAt,
    this.readyAt,
    this.pickedUpAt,
    this.deliveredAt,
    this.cancelledAt,
  }) : currency = currency ?? 'MAD',
       currencySymbol = currencySymbol ?? 'DH',
       platformCommission = platformCommission ?? 0.0,
       driverEarnings = driverEarnings ?? 0.0,
       createdAt = createdAt ?? DateTime.now();

  factory StoreOrder({
    int? id,
    required String orderNumber,
    required int storeId,
    required int clientId,
    int? driverId,
    required _i2.StoreOrderStatus status,
    required String itemsJson,
    required double subtotal,
    required double deliveryFee,
    required double total,
    String? currency,
    String? currencySymbol,
    double? platformCommission,
    double? driverEarnings,
    required String deliveryAddress,
    required double deliveryLatitude,
    required double deliveryLongitude,
    double? deliveryDistance,
    String? clientNotes,
    String? storeNotes,
    String? timelineJson,
    int? chatId,
    String? cancelledBy,
    String? cancellationReason,
    DateTime? createdAt,
    DateTime? confirmedAt,
    DateTime? readyAt,
    DateTime? pickedUpAt,
    DateTime? deliveredAt,
    DateTime? cancelledAt,
  }) = _StoreOrderImpl;

  factory StoreOrder.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreOrder(
      id: jsonSerialization['id'] as int?,
      orderNumber: jsonSerialization['orderNumber'] as String,
      storeId: jsonSerialization['storeId'] as int,
      clientId: jsonSerialization['clientId'] as int,
      driverId: jsonSerialization['driverId'] as int?,
      status: _i2.StoreOrderStatus.fromJson(
        (jsonSerialization['status'] as int),
      ),
      itemsJson: jsonSerialization['itemsJson'] as String,
      subtotal: (jsonSerialization['subtotal'] as num).toDouble(),
      deliveryFee: (jsonSerialization['deliveryFee'] as num).toDouble(),
      total: (jsonSerialization['total'] as num).toDouble(),
      currency: jsonSerialization['currency'] as String,
      currencySymbol: jsonSerialization['currencySymbol'] as String,
      platformCommission: (jsonSerialization['platformCommission'] as num)
          .toDouble(),
      driverEarnings: (jsonSerialization['driverEarnings'] as num).toDouble(),
      deliveryAddress: jsonSerialization['deliveryAddress'] as String,
      deliveryLatitude: (jsonSerialization['deliveryLatitude'] as num)
          .toDouble(),
      deliveryLongitude: (jsonSerialization['deliveryLongitude'] as num)
          .toDouble(),
      deliveryDistance: (jsonSerialization['deliveryDistance'] as num?)
          ?.toDouble(),
      clientNotes: jsonSerialization['clientNotes'] as String?,
      storeNotes: jsonSerialization['storeNotes'] as String?,
      timelineJson: jsonSerialization['timelineJson'] as String?,
      chatId: jsonSerialization['chatId'] as int?,
      cancelledBy: jsonSerialization['cancelledBy'] as String?,
      cancellationReason: jsonSerialization['cancellationReason'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      confirmedAt: jsonSerialization['confirmedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['confirmedAt'],
            ),
      readyAt: jsonSerialization['readyAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['readyAt']),
      pickedUpAt: jsonSerialization['pickedUpAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['pickedUpAt']),
      deliveredAt: jsonSerialization['deliveredAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['deliveredAt'],
            ),
      cancelledAt: jsonSerialization['cancelledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['cancelledAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String orderNumber;

  int storeId;

  int clientId;

  int? driverId;

  _i2.StoreOrderStatus status;

  String itemsJson;

  double subtotal;

  double deliveryFee;

  double total;

  String currency;

  String currencySymbol;

  double platformCommission;

  double driverEarnings;

  String deliveryAddress;

  double deliveryLatitude;

  double deliveryLongitude;

  double? deliveryDistance;

  String? clientNotes;

  String? storeNotes;

  String? timelineJson;

  int? chatId;

  String? cancelledBy;

  String? cancellationReason;

  DateTime createdAt;

  DateTime? confirmedAt;

  DateTime? readyAt;

  DateTime? pickedUpAt;

  DateTime? deliveredAt;

  DateTime? cancelledAt;

  /// Returns a shallow copy of this [StoreOrder]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreOrder copyWith({
    int? id,
    String? orderNumber,
    int? storeId,
    int? clientId,
    int? driverId,
    _i2.StoreOrderStatus? status,
    String? itemsJson,
    double? subtotal,
    double? deliveryFee,
    double? total,
    String? currency,
    String? currencySymbol,
    double? platformCommission,
    double? driverEarnings,
    String? deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
    double? deliveryDistance,
    String? clientNotes,
    String? storeNotes,
    String? timelineJson,
    int? chatId,
    String? cancelledBy,
    String? cancellationReason,
    DateTime? createdAt,
    DateTime? confirmedAt,
    DateTime? readyAt,
    DateTime? pickedUpAt,
    DateTime? deliveredAt,
    DateTime? cancelledAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreOrder',
      if (id != null) 'id': id,
      'orderNumber': orderNumber,
      'storeId': storeId,
      'clientId': clientId,
      if (driverId != null) 'driverId': driverId,
      'status': status.toJson(),
      'itemsJson': itemsJson,
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'total': total,
      'currency': currency,
      'currencySymbol': currencySymbol,
      'platformCommission': platformCommission,
      'driverEarnings': driverEarnings,
      'deliveryAddress': deliveryAddress,
      'deliveryLatitude': deliveryLatitude,
      'deliveryLongitude': deliveryLongitude,
      if (deliveryDistance != null) 'deliveryDistance': deliveryDistance,
      if (clientNotes != null) 'clientNotes': clientNotes,
      if (storeNotes != null) 'storeNotes': storeNotes,
      if (timelineJson != null) 'timelineJson': timelineJson,
      if (chatId != null) 'chatId': chatId,
      if (cancelledBy != null) 'cancelledBy': cancelledBy,
      if (cancellationReason != null) 'cancellationReason': cancellationReason,
      'createdAt': createdAt.toJson(),
      if (confirmedAt != null) 'confirmedAt': confirmedAt?.toJson(),
      if (readyAt != null) 'readyAt': readyAt?.toJson(),
      if (pickedUpAt != null) 'pickedUpAt': pickedUpAt?.toJson(),
      if (deliveredAt != null) 'deliveredAt': deliveredAt?.toJson(),
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreOrderImpl extends StoreOrder {
  _StoreOrderImpl({
    int? id,
    required String orderNumber,
    required int storeId,
    required int clientId,
    int? driverId,
    required _i2.StoreOrderStatus status,
    required String itemsJson,
    required double subtotal,
    required double deliveryFee,
    required double total,
    String? currency,
    String? currencySymbol,
    double? platformCommission,
    double? driverEarnings,
    required String deliveryAddress,
    required double deliveryLatitude,
    required double deliveryLongitude,
    double? deliveryDistance,
    String? clientNotes,
    String? storeNotes,
    String? timelineJson,
    int? chatId,
    String? cancelledBy,
    String? cancellationReason,
    DateTime? createdAt,
    DateTime? confirmedAt,
    DateTime? readyAt,
    DateTime? pickedUpAt,
    DateTime? deliveredAt,
    DateTime? cancelledAt,
  }) : super._(
         id: id,
         orderNumber: orderNumber,
         storeId: storeId,
         clientId: clientId,
         driverId: driverId,
         status: status,
         itemsJson: itemsJson,
         subtotal: subtotal,
         deliveryFee: deliveryFee,
         total: total,
         currency: currency,
         currencySymbol: currencySymbol,
         platformCommission: platformCommission,
         driverEarnings: driverEarnings,
         deliveryAddress: deliveryAddress,
         deliveryLatitude: deliveryLatitude,
         deliveryLongitude: deliveryLongitude,
         deliveryDistance: deliveryDistance,
         clientNotes: clientNotes,
         storeNotes: storeNotes,
         timelineJson: timelineJson,
         chatId: chatId,
         cancelledBy: cancelledBy,
         cancellationReason: cancellationReason,
         createdAt: createdAt,
         confirmedAt: confirmedAt,
         readyAt: readyAt,
         pickedUpAt: pickedUpAt,
         deliveredAt: deliveredAt,
         cancelledAt: cancelledAt,
       );

  /// Returns a shallow copy of this [StoreOrder]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreOrder copyWith({
    Object? id = _Undefined,
    String? orderNumber,
    int? storeId,
    int? clientId,
    Object? driverId = _Undefined,
    _i2.StoreOrderStatus? status,
    String? itemsJson,
    double? subtotal,
    double? deliveryFee,
    double? total,
    String? currency,
    String? currencySymbol,
    double? platformCommission,
    double? driverEarnings,
    String? deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
    Object? deliveryDistance = _Undefined,
    Object? clientNotes = _Undefined,
    Object? storeNotes = _Undefined,
    Object? timelineJson = _Undefined,
    Object? chatId = _Undefined,
    Object? cancelledBy = _Undefined,
    Object? cancellationReason = _Undefined,
    DateTime? createdAt,
    Object? confirmedAt = _Undefined,
    Object? readyAt = _Undefined,
    Object? pickedUpAt = _Undefined,
    Object? deliveredAt = _Undefined,
    Object? cancelledAt = _Undefined,
  }) {
    return StoreOrder(
      id: id is int? ? id : this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      storeId: storeId ?? this.storeId,
      clientId: clientId ?? this.clientId,
      driverId: driverId is int? ? driverId : this.driverId,
      status: status ?? this.status,
      itemsJson: itemsJson ?? this.itemsJson,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      total: total ?? this.total,
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      platformCommission: platformCommission ?? this.platformCommission,
      driverEarnings: driverEarnings ?? this.driverEarnings,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryLatitude: deliveryLatitude ?? this.deliveryLatitude,
      deliveryLongitude: deliveryLongitude ?? this.deliveryLongitude,
      deliveryDistance: deliveryDistance is double?
          ? deliveryDistance
          : this.deliveryDistance,
      clientNotes: clientNotes is String? ? clientNotes : this.clientNotes,
      storeNotes: storeNotes is String? ? storeNotes : this.storeNotes,
      timelineJson: timelineJson is String? ? timelineJson : this.timelineJson,
      chatId: chatId is int? ? chatId : this.chatId,
      cancelledBy: cancelledBy is String? ? cancelledBy : this.cancelledBy,
      cancellationReason: cancellationReason is String?
          ? cancellationReason
          : this.cancellationReason,
      createdAt: createdAt ?? this.createdAt,
      confirmedAt: confirmedAt is DateTime? ? confirmedAt : this.confirmedAt,
      readyAt: readyAt is DateTime? ? readyAt : this.readyAt,
      pickedUpAt: pickedUpAt is DateTime? ? pickedUpAt : this.pickedUpAt,
      deliveredAt: deliveredAt is DateTime? ? deliveredAt : this.deliveredAt,
      cancelledAt: cancelledAt is DateTime? ? cancelledAt : this.cancelledAt,
    );
  }
}
