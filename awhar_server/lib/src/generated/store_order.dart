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
import 'store_order_status_enum.dart' as _i2;

abstract class StoreOrder
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = StoreOrderTable();

  static const db = StoreOrderRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static StoreOrderInclude include() {
    return StoreOrderInclude._();
  }

  static StoreOrderIncludeList includeList({
    _i1.WhereExpressionBuilder<StoreOrderTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreOrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreOrderTable>? orderByList,
    StoreOrderInclude? include,
  }) {
    return StoreOrderIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreOrder.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StoreOrder.t),
      include: include,
    );
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

class StoreOrderUpdateTable extends _i1.UpdateTable<StoreOrderTable> {
  StoreOrderUpdateTable(super.table);

  _i1.ColumnValue<String, String> orderNumber(String value) => _i1.ColumnValue(
    table.orderNumber,
    value,
  );

  _i1.ColumnValue<int, int> storeId(int value) => _i1.ColumnValue(
    table.storeId,
    value,
  );

  _i1.ColumnValue<int, int> clientId(int value) => _i1.ColumnValue(
    table.clientId,
    value,
  );

  _i1.ColumnValue<int, int> driverId(int? value) => _i1.ColumnValue(
    table.driverId,
    value,
  );

  _i1.ColumnValue<_i2.StoreOrderStatus, _i2.StoreOrderStatus> status(
    _i2.StoreOrderStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> itemsJson(String value) => _i1.ColumnValue(
    table.itemsJson,
    value,
  );

  _i1.ColumnValue<double, double> subtotal(double value) => _i1.ColumnValue(
    table.subtotal,
    value,
  );

  _i1.ColumnValue<double, double> deliveryFee(double value) => _i1.ColumnValue(
    table.deliveryFee,
    value,
  );

  _i1.ColumnValue<double, double> total(double value) => _i1.ColumnValue(
    table.total,
    value,
  );

  _i1.ColumnValue<String, String> currency(String value) => _i1.ColumnValue(
    table.currency,
    value,
  );

  _i1.ColumnValue<String, String> currencySymbol(String value) =>
      _i1.ColumnValue(
        table.currencySymbol,
        value,
      );

  _i1.ColumnValue<double, double> platformCommission(double value) =>
      _i1.ColumnValue(
        table.platformCommission,
        value,
      );

  _i1.ColumnValue<double, double> driverEarnings(double value) =>
      _i1.ColumnValue(
        table.driverEarnings,
        value,
      );

  _i1.ColumnValue<String, String> deliveryAddress(String value) =>
      _i1.ColumnValue(
        table.deliveryAddress,
        value,
      );

  _i1.ColumnValue<double, double> deliveryLatitude(double value) =>
      _i1.ColumnValue(
        table.deliveryLatitude,
        value,
      );

  _i1.ColumnValue<double, double> deliveryLongitude(double value) =>
      _i1.ColumnValue(
        table.deliveryLongitude,
        value,
      );

  _i1.ColumnValue<double, double> deliveryDistance(double? value) =>
      _i1.ColumnValue(
        table.deliveryDistance,
        value,
      );

  _i1.ColumnValue<String, String> clientNotes(String? value) => _i1.ColumnValue(
    table.clientNotes,
    value,
  );

  _i1.ColumnValue<String, String> storeNotes(String? value) => _i1.ColumnValue(
    table.storeNotes,
    value,
  );

  _i1.ColumnValue<String, String> timelineJson(String? value) =>
      _i1.ColumnValue(
        table.timelineJson,
        value,
      );

  _i1.ColumnValue<int, int> chatId(int? value) => _i1.ColumnValue(
    table.chatId,
    value,
  );

  _i1.ColumnValue<String, String> cancelledBy(String? value) => _i1.ColumnValue(
    table.cancelledBy,
    value,
  );

  _i1.ColumnValue<String, String> cancellationReason(String? value) =>
      _i1.ColumnValue(
        table.cancellationReason,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> confirmedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.confirmedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> readyAt(DateTime? value) =>
      _i1.ColumnValue(
        table.readyAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> pickedUpAt(DateTime? value) =>
      _i1.ColumnValue(
        table.pickedUpAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> deliveredAt(DateTime? value) =>
      _i1.ColumnValue(
        table.deliveredAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> cancelledAt(DateTime? value) =>
      _i1.ColumnValue(
        table.cancelledAt,
        value,
      );
}

class StoreOrderTable extends _i1.Table<int?> {
  StoreOrderTable({super.tableRelation}) : super(tableName: 'store_orders') {
    updateTable = StoreOrderUpdateTable(this);
    orderNumber = _i1.ColumnString(
      'orderNumber',
      this,
    );
    storeId = _i1.ColumnInt(
      'storeId',
      this,
    );
    clientId = _i1.ColumnInt(
      'clientId',
      this,
    );
    driverId = _i1.ColumnInt(
      'driverId',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byIndex,
    );
    itemsJson = _i1.ColumnString(
      'itemsJson',
      this,
    );
    subtotal = _i1.ColumnDouble(
      'subtotal',
      this,
    );
    deliveryFee = _i1.ColumnDouble(
      'deliveryFee',
      this,
    );
    total = _i1.ColumnDouble(
      'total',
      this,
    );
    currency = _i1.ColumnString(
      'currency',
      this,
      hasDefault: true,
    );
    currencySymbol = _i1.ColumnString(
      'currencySymbol',
      this,
      hasDefault: true,
    );
    platformCommission = _i1.ColumnDouble(
      'platformCommission',
      this,
      hasDefault: true,
    );
    driverEarnings = _i1.ColumnDouble(
      'driverEarnings',
      this,
      hasDefault: true,
    );
    deliveryAddress = _i1.ColumnString(
      'deliveryAddress',
      this,
    );
    deliveryLatitude = _i1.ColumnDouble(
      'deliveryLatitude',
      this,
    );
    deliveryLongitude = _i1.ColumnDouble(
      'deliveryLongitude',
      this,
    );
    deliveryDistance = _i1.ColumnDouble(
      'deliveryDistance',
      this,
    );
    clientNotes = _i1.ColumnString(
      'clientNotes',
      this,
    );
    storeNotes = _i1.ColumnString(
      'storeNotes',
      this,
    );
    timelineJson = _i1.ColumnString(
      'timelineJson',
      this,
    );
    chatId = _i1.ColumnInt(
      'chatId',
      this,
    );
    cancelledBy = _i1.ColumnString(
      'cancelledBy',
      this,
    );
    cancellationReason = _i1.ColumnString(
      'cancellationReason',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    confirmedAt = _i1.ColumnDateTime(
      'confirmedAt',
      this,
    );
    readyAt = _i1.ColumnDateTime(
      'readyAt',
      this,
    );
    pickedUpAt = _i1.ColumnDateTime(
      'pickedUpAt',
      this,
    );
    deliveredAt = _i1.ColumnDateTime(
      'deliveredAt',
      this,
    );
    cancelledAt = _i1.ColumnDateTime(
      'cancelledAt',
      this,
    );
  }

  late final StoreOrderUpdateTable updateTable;

  late final _i1.ColumnString orderNumber;

  late final _i1.ColumnInt storeId;

  late final _i1.ColumnInt clientId;

  late final _i1.ColumnInt driverId;

  late final _i1.ColumnEnum<_i2.StoreOrderStatus> status;

  late final _i1.ColumnString itemsJson;

  late final _i1.ColumnDouble subtotal;

  late final _i1.ColumnDouble deliveryFee;

  late final _i1.ColumnDouble total;

  late final _i1.ColumnString currency;

  late final _i1.ColumnString currencySymbol;

  late final _i1.ColumnDouble platformCommission;

  late final _i1.ColumnDouble driverEarnings;

  late final _i1.ColumnString deliveryAddress;

  late final _i1.ColumnDouble deliveryLatitude;

  late final _i1.ColumnDouble deliveryLongitude;

  late final _i1.ColumnDouble deliveryDistance;

  late final _i1.ColumnString clientNotes;

  late final _i1.ColumnString storeNotes;

  late final _i1.ColumnString timelineJson;

  late final _i1.ColumnInt chatId;

  late final _i1.ColumnString cancelledBy;

  late final _i1.ColumnString cancellationReason;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime confirmedAt;

  late final _i1.ColumnDateTime readyAt;

  late final _i1.ColumnDateTime pickedUpAt;

  late final _i1.ColumnDateTime deliveredAt;

  late final _i1.ColumnDateTime cancelledAt;

  @override
  List<_i1.Column> get columns => [
    id,
    orderNumber,
    storeId,
    clientId,
    driverId,
    status,
    itemsJson,
    subtotal,
    deliveryFee,
    total,
    currency,
    currencySymbol,
    platformCommission,
    driverEarnings,
    deliveryAddress,
    deliveryLatitude,
    deliveryLongitude,
    deliveryDistance,
    clientNotes,
    storeNotes,
    timelineJson,
    chatId,
    cancelledBy,
    cancellationReason,
    createdAt,
    confirmedAt,
    readyAt,
    pickedUpAt,
    deliveredAt,
    cancelledAt,
  ];
}

class StoreOrderInclude extends _i1.IncludeObject {
  StoreOrderInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StoreOrder.t;
}

class StoreOrderIncludeList extends _i1.IncludeList {
  StoreOrderIncludeList._({
    _i1.WhereExpressionBuilder<StoreOrderTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreOrder.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StoreOrder.t;
}

class StoreOrderRepository {
  const StoreOrderRepository._();

  /// Returns a list of [StoreOrder]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<StoreOrder>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreOrderTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreOrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreOrderTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<StoreOrder>(
      where: where?.call(StoreOrder.t),
      orderBy: orderBy?.call(StoreOrder.t),
      orderByList: orderByList?.call(StoreOrder.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [StoreOrder] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<StoreOrder?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreOrderTable>? where,
    int? offset,
    _i1.OrderByBuilder<StoreOrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreOrderTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<StoreOrder>(
      where: where?.call(StoreOrder.t),
      orderBy: orderBy?.call(StoreOrder.t),
      orderByList: orderByList?.call(StoreOrder.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [StoreOrder] by its [id] or null if no such row exists.
  Future<StoreOrder?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<StoreOrder>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [StoreOrder]s in the list and returns the inserted rows.
  ///
  /// The returned [StoreOrder]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StoreOrder>> insert(
    _i1.Session session,
    List<StoreOrder> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StoreOrder>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StoreOrder] and returns the inserted row.
  ///
  /// The returned [StoreOrder] will have its `id` field set.
  Future<StoreOrder> insertRow(
    _i1.Session session,
    StoreOrder row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreOrder>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StoreOrder]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StoreOrder>> update(
    _i1.Session session,
    List<StoreOrder> rows, {
    _i1.ColumnSelections<StoreOrderTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StoreOrder>(
      rows,
      columns: columns?.call(StoreOrder.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreOrder]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StoreOrder> updateRow(
    _i1.Session session,
    StoreOrder row, {
    _i1.ColumnSelections<StoreOrderTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoreOrder>(
      row,
      columns: columns?.call(StoreOrder.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreOrder] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StoreOrder?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<StoreOrderUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StoreOrder>(
      id,
      columnValues: columnValues(StoreOrder.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StoreOrder]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StoreOrder>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<StoreOrderUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StoreOrderTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreOrderTable>? orderBy,
    _i1.OrderByListBuilder<StoreOrderTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StoreOrder>(
      columnValues: columnValues(StoreOrder.t.updateTable),
      where: where(StoreOrder.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreOrder.t),
      orderByList: orderByList?.call(StoreOrder.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StoreOrder]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StoreOrder>> delete(
    _i1.Session session,
    List<StoreOrder> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StoreOrder>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StoreOrder].
  Future<StoreOrder> deleteRow(
    _i1.Session session,
    StoreOrder row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreOrder>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StoreOrder>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StoreOrderTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StoreOrder>(
      where: where(StoreOrder.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreOrderTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StoreOrder>(
      where: where?.call(StoreOrder.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
