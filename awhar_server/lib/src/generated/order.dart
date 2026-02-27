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
import 'price_negotiation_status_enum.dart' as _i2;
import 'order_status_enum.dart' as _i3;
import 'canceller_type_enum.dart' as _i4;

abstract class Order implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Order._({
    this.id,
    required this.clientId,
    this.driverId,
    required this.serviceId,
    this.pickupAddressId,
    this.dropoffAddressId,
    this.pickupLatitude,
    this.pickupLongitude,
    this.pickupAddress,
    this.dropoffLatitude,
    this.dropoffLongitude,
    this.dropoffAddress,
    this.estimatedDistanceKm,
    this.estimatedPrice,
    this.agreedPrice,
    this.finalPrice,
    String? currency,
    String? currencySymbol,
    this.clientProposedPrice,
    this.driverCounterPrice,
    this.priceNegotiationStatus,
    this.notes,
    this.clientInstructions,
    this.expiresAt,
    this.status,
    DateTime? createdAt,
    this.acceptedAt,
    this.startedAt,
    this.completedAt,
    this.cancelledAt,
    this.cancellationReason,
    this.cancelledByUserId,
    this.cancelledBy,
  }) : currency = currency ?? 'MAD',
       currencySymbol = currencySymbol ?? 'DH',
       createdAt = createdAt ?? DateTime.now();

  factory Order({
    int? id,
    required int clientId,
    int? driverId,
    required int serviceId,
    int? pickupAddressId,
    int? dropoffAddressId,
    double? pickupLatitude,
    double? pickupLongitude,
    String? pickupAddress,
    double? dropoffLatitude,
    double? dropoffLongitude,
    String? dropoffAddress,
    double? estimatedDistanceKm,
    double? estimatedPrice,
    double? agreedPrice,
    double? finalPrice,
    String? currency,
    String? currencySymbol,
    double? clientProposedPrice,
    double? driverCounterPrice,
    _i2.PriceNegotiationStatus? priceNegotiationStatus,
    String? notes,
    String? clientInstructions,
    DateTime? expiresAt,
    _i3.OrderStatus? status,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
    String? cancellationReason,
    int? cancelledByUserId,
    _i4.CancellerType? cancelledBy,
  }) = _OrderImpl;

  factory Order.fromJson(Map<String, dynamic> jsonSerialization) {
    return Order(
      id: jsonSerialization['id'] as int?,
      clientId: jsonSerialization['clientId'] as int,
      driverId: jsonSerialization['driverId'] as int?,
      serviceId: jsonSerialization['serviceId'] as int,
      pickupAddressId: jsonSerialization['pickupAddressId'] as int?,
      dropoffAddressId: jsonSerialization['dropoffAddressId'] as int?,
      pickupLatitude: (jsonSerialization['pickupLatitude'] as num?)?.toDouble(),
      pickupLongitude: (jsonSerialization['pickupLongitude'] as num?)
          ?.toDouble(),
      pickupAddress: jsonSerialization['pickupAddress'] as String?,
      dropoffLatitude: (jsonSerialization['dropoffLatitude'] as num?)
          ?.toDouble(),
      dropoffLongitude: (jsonSerialization['dropoffLongitude'] as num?)
          ?.toDouble(),
      dropoffAddress: jsonSerialization['dropoffAddress'] as String?,
      estimatedDistanceKm: (jsonSerialization['estimatedDistanceKm'] as num?)
          ?.toDouble(),
      estimatedPrice: (jsonSerialization['estimatedPrice'] as num?)?.toDouble(),
      agreedPrice: (jsonSerialization['agreedPrice'] as num?)?.toDouble(),
      finalPrice: (jsonSerialization['finalPrice'] as num?)?.toDouble(),
      currency: jsonSerialization['currency'] as String,
      currencySymbol: jsonSerialization['currencySymbol'] as String,
      clientProposedPrice: (jsonSerialization['clientProposedPrice'] as num?)
          ?.toDouble(),
      driverCounterPrice: (jsonSerialization['driverCounterPrice'] as num?)
          ?.toDouble(),
      priceNegotiationStatus:
          jsonSerialization['priceNegotiationStatus'] == null
          ? null
          : _i2.PriceNegotiationStatus.fromJson(
              (jsonSerialization['priceNegotiationStatus'] as int),
            ),
      notes: jsonSerialization['notes'] as String?,
      clientInstructions: jsonSerialization['clientInstructions'] as String?,
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      status: jsonSerialization['status'] == null
          ? null
          : _i3.OrderStatus.fromJson((jsonSerialization['status'] as int)),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      acceptedAt: jsonSerialization['acceptedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['acceptedAt']),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      cancelledAt: jsonSerialization['cancelledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['cancelledAt'],
            ),
      cancellationReason: jsonSerialization['cancellationReason'] as String?,
      cancelledByUserId: jsonSerialization['cancelledByUserId'] as int?,
      cancelledBy: jsonSerialization['cancelledBy'] == null
          ? null
          : _i4.CancellerType.fromJson(
              (jsonSerialization['cancelledBy'] as int),
            ),
    );
  }

  static final t = OrderTable();

  static const db = OrderRepository._();

  @override
  int? id;

  int clientId;

  int? driverId;

  int serviceId;

  int? pickupAddressId;

  int? dropoffAddressId;

  double? pickupLatitude;

  double? pickupLongitude;

  String? pickupAddress;

  double? dropoffLatitude;

  double? dropoffLongitude;

  String? dropoffAddress;

  double? estimatedDistanceKm;

  double? estimatedPrice;

  double? agreedPrice;

  double? finalPrice;

  String currency;

  String currencySymbol;

  double? clientProposedPrice;

  double? driverCounterPrice;

  _i2.PriceNegotiationStatus? priceNegotiationStatus;

  String? notes;

  String? clientInstructions;

  DateTime? expiresAt;

  _i3.OrderStatus? status;

  DateTime createdAt;

  DateTime? acceptedAt;

  DateTime? startedAt;

  DateTime? completedAt;

  DateTime? cancelledAt;

  String? cancellationReason;

  int? cancelledByUserId;

  _i4.CancellerType? cancelledBy;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Order]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Order copyWith({
    int? id,
    int? clientId,
    int? driverId,
    int? serviceId,
    int? pickupAddressId,
    int? dropoffAddressId,
    double? pickupLatitude,
    double? pickupLongitude,
    String? pickupAddress,
    double? dropoffLatitude,
    double? dropoffLongitude,
    String? dropoffAddress,
    double? estimatedDistanceKm,
    double? estimatedPrice,
    double? agreedPrice,
    double? finalPrice,
    String? currency,
    String? currencySymbol,
    double? clientProposedPrice,
    double? driverCounterPrice,
    _i2.PriceNegotiationStatus? priceNegotiationStatus,
    String? notes,
    String? clientInstructions,
    DateTime? expiresAt,
    _i3.OrderStatus? status,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
    String? cancellationReason,
    int? cancelledByUserId,
    _i4.CancellerType? cancelledBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Order',
      if (id != null) 'id': id,
      'clientId': clientId,
      if (driverId != null) 'driverId': driverId,
      'serviceId': serviceId,
      if (pickupAddressId != null) 'pickupAddressId': pickupAddressId,
      if (dropoffAddressId != null) 'dropoffAddressId': dropoffAddressId,
      if (pickupLatitude != null) 'pickupLatitude': pickupLatitude,
      if (pickupLongitude != null) 'pickupLongitude': pickupLongitude,
      if (pickupAddress != null) 'pickupAddress': pickupAddress,
      if (dropoffLatitude != null) 'dropoffLatitude': dropoffLatitude,
      if (dropoffLongitude != null) 'dropoffLongitude': dropoffLongitude,
      if (dropoffAddress != null) 'dropoffAddress': dropoffAddress,
      if (estimatedDistanceKm != null)
        'estimatedDistanceKm': estimatedDistanceKm,
      if (estimatedPrice != null) 'estimatedPrice': estimatedPrice,
      if (agreedPrice != null) 'agreedPrice': agreedPrice,
      if (finalPrice != null) 'finalPrice': finalPrice,
      'currency': currency,
      'currencySymbol': currencySymbol,
      if (clientProposedPrice != null)
        'clientProposedPrice': clientProposedPrice,
      if (driverCounterPrice != null) 'driverCounterPrice': driverCounterPrice,
      if (priceNegotiationStatus != null)
        'priceNegotiationStatus': priceNegotiationStatus?.toJson(),
      if (notes != null) 'notes': notes,
      if (clientInstructions != null) 'clientInstructions': clientInstructions,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      if (status != null) 'status': status?.toJson(),
      'createdAt': createdAt.toJson(),
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
      if (cancellationReason != null) 'cancellationReason': cancellationReason,
      if (cancelledByUserId != null) 'cancelledByUserId': cancelledByUserId,
      if (cancelledBy != null) 'cancelledBy': cancelledBy?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Order',
      if (id != null) 'id': id,
      'clientId': clientId,
      if (driverId != null) 'driverId': driverId,
      'serviceId': serviceId,
      if (pickupAddressId != null) 'pickupAddressId': pickupAddressId,
      if (dropoffAddressId != null) 'dropoffAddressId': dropoffAddressId,
      if (pickupLatitude != null) 'pickupLatitude': pickupLatitude,
      if (pickupLongitude != null) 'pickupLongitude': pickupLongitude,
      if (pickupAddress != null) 'pickupAddress': pickupAddress,
      if (dropoffLatitude != null) 'dropoffLatitude': dropoffLatitude,
      if (dropoffLongitude != null) 'dropoffLongitude': dropoffLongitude,
      if (dropoffAddress != null) 'dropoffAddress': dropoffAddress,
      if (estimatedDistanceKm != null)
        'estimatedDistanceKm': estimatedDistanceKm,
      if (estimatedPrice != null) 'estimatedPrice': estimatedPrice,
      if (agreedPrice != null) 'agreedPrice': agreedPrice,
      if (finalPrice != null) 'finalPrice': finalPrice,
      'currency': currency,
      'currencySymbol': currencySymbol,
      if (clientProposedPrice != null)
        'clientProposedPrice': clientProposedPrice,
      if (driverCounterPrice != null) 'driverCounterPrice': driverCounterPrice,
      if (priceNegotiationStatus != null)
        'priceNegotiationStatus': priceNegotiationStatus?.toJson(),
      if (notes != null) 'notes': notes,
      if (clientInstructions != null) 'clientInstructions': clientInstructions,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      if (status != null) 'status': status?.toJson(),
      'createdAt': createdAt.toJson(),
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
      if (cancellationReason != null) 'cancellationReason': cancellationReason,
      if (cancelledByUserId != null) 'cancelledByUserId': cancelledByUserId,
      if (cancelledBy != null) 'cancelledBy': cancelledBy?.toJson(),
    };
  }

  static OrderInclude include() {
    return OrderInclude._();
  }

  static OrderIncludeList includeList({
    _i1.WhereExpressionBuilder<OrderTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderTable>? orderByList,
    OrderInclude? include,
  }) {
    return OrderIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Order.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Order.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderImpl extends Order {
  _OrderImpl({
    int? id,
    required int clientId,
    int? driverId,
    required int serviceId,
    int? pickupAddressId,
    int? dropoffAddressId,
    double? pickupLatitude,
    double? pickupLongitude,
    String? pickupAddress,
    double? dropoffLatitude,
    double? dropoffLongitude,
    String? dropoffAddress,
    double? estimatedDistanceKm,
    double? estimatedPrice,
    double? agreedPrice,
    double? finalPrice,
    String? currency,
    String? currencySymbol,
    double? clientProposedPrice,
    double? driverCounterPrice,
    _i2.PriceNegotiationStatus? priceNegotiationStatus,
    String? notes,
    String? clientInstructions,
    DateTime? expiresAt,
    _i3.OrderStatus? status,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
    String? cancellationReason,
    int? cancelledByUserId,
    _i4.CancellerType? cancelledBy,
  }) : super._(
         id: id,
         clientId: clientId,
         driverId: driverId,
         serviceId: serviceId,
         pickupAddressId: pickupAddressId,
         dropoffAddressId: dropoffAddressId,
         pickupLatitude: pickupLatitude,
         pickupLongitude: pickupLongitude,
         pickupAddress: pickupAddress,
         dropoffLatitude: dropoffLatitude,
         dropoffLongitude: dropoffLongitude,
         dropoffAddress: dropoffAddress,
         estimatedDistanceKm: estimatedDistanceKm,
         estimatedPrice: estimatedPrice,
         agreedPrice: agreedPrice,
         finalPrice: finalPrice,
         currency: currency,
         currencySymbol: currencySymbol,
         clientProposedPrice: clientProposedPrice,
         driverCounterPrice: driverCounterPrice,
         priceNegotiationStatus: priceNegotiationStatus,
         notes: notes,
         clientInstructions: clientInstructions,
         expiresAt: expiresAt,
         status: status,
         createdAt: createdAt,
         acceptedAt: acceptedAt,
         startedAt: startedAt,
         completedAt: completedAt,
         cancelledAt: cancelledAt,
         cancellationReason: cancellationReason,
         cancelledByUserId: cancelledByUserId,
         cancelledBy: cancelledBy,
       );

  /// Returns a shallow copy of this [Order]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Order copyWith({
    Object? id = _Undefined,
    int? clientId,
    Object? driverId = _Undefined,
    int? serviceId,
    Object? pickupAddressId = _Undefined,
    Object? dropoffAddressId = _Undefined,
    Object? pickupLatitude = _Undefined,
    Object? pickupLongitude = _Undefined,
    Object? pickupAddress = _Undefined,
    Object? dropoffLatitude = _Undefined,
    Object? dropoffLongitude = _Undefined,
    Object? dropoffAddress = _Undefined,
    Object? estimatedDistanceKm = _Undefined,
    Object? estimatedPrice = _Undefined,
    Object? agreedPrice = _Undefined,
    Object? finalPrice = _Undefined,
    String? currency,
    String? currencySymbol,
    Object? clientProposedPrice = _Undefined,
    Object? driverCounterPrice = _Undefined,
    Object? priceNegotiationStatus = _Undefined,
    Object? notes = _Undefined,
    Object? clientInstructions = _Undefined,
    Object? expiresAt = _Undefined,
    Object? status = _Undefined,
    DateTime? createdAt,
    Object? acceptedAt = _Undefined,
    Object? startedAt = _Undefined,
    Object? completedAt = _Undefined,
    Object? cancelledAt = _Undefined,
    Object? cancellationReason = _Undefined,
    Object? cancelledByUserId = _Undefined,
    Object? cancelledBy = _Undefined,
  }) {
    return Order(
      id: id is int? ? id : this.id,
      clientId: clientId ?? this.clientId,
      driverId: driverId is int? ? driverId : this.driverId,
      serviceId: serviceId ?? this.serviceId,
      pickupAddressId: pickupAddressId is int?
          ? pickupAddressId
          : this.pickupAddressId,
      dropoffAddressId: dropoffAddressId is int?
          ? dropoffAddressId
          : this.dropoffAddressId,
      pickupLatitude: pickupLatitude is double?
          ? pickupLatitude
          : this.pickupLatitude,
      pickupLongitude: pickupLongitude is double?
          ? pickupLongitude
          : this.pickupLongitude,
      pickupAddress: pickupAddress is String?
          ? pickupAddress
          : this.pickupAddress,
      dropoffLatitude: dropoffLatitude is double?
          ? dropoffLatitude
          : this.dropoffLatitude,
      dropoffLongitude: dropoffLongitude is double?
          ? dropoffLongitude
          : this.dropoffLongitude,
      dropoffAddress: dropoffAddress is String?
          ? dropoffAddress
          : this.dropoffAddress,
      estimatedDistanceKm: estimatedDistanceKm is double?
          ? estimatedDistanceKm
          : this.estimatedDistanceKm,
      estimatedPrice: estimatedPrice is double?
          ? estimatedPrice
          : this.estimatedPrice,
      agreedPrice: agreedPrice is double? ? agreedPrice : this.agreedPrice,
      finalPrice: finalPrice is double? ? finalPrice : this.finalPrice,
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      clientProposedPrice: clientProposedPrice is double?
          ? clientProposedPrice
          : this.clientProposedPrice,
      driverCounterPrice: driverCounterPrice is double?
          ? driverCounterPrice
          : this.driverCounterPrice,
      priceNegotiationStatus:
          priceNegotiationStatus is _i2.PriceNegotiationStatus?
          ? priceNegotiationStatus
          : this.priceNegotiationStatus,
      notes: notes is String? ? notes : this.notes,
      clientInstructions: clientInstructions is String?
          ? clientInstructions
          : this.clientInstructions,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      status: status is _i3.OrderStatus? ? status : this.status,
      createdAt: createdAt ?? this.createdAt,
      acceptedAt: acceptedAt is DateTime? ? acceptedAt : this.acceptedAt,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      cancelledAt: cancelledAt is DateTime? ? cancelledAt : this.cancelledAt,
      cancellationReason: cancellationReason is String?
          ? cancellationReason
          : this.cancellationReason,
      cancelledByUserId: cancelledByUserId is int?
          ? cancelledByUserId
          : this.cancelledByUserId,
      cancelledBy: cancelledBy is _i4.CancellerType?
          ? cancelledBy
          : this.cancelledBy,
    );
  }
}

class OrderUpdateTable extends _i1.UpdateTable<OrderTable> {
  OrderUpdateTable(super.table);

  _i1.ColumnValue<int, int> clientId(int value) => _i1.ColumnValue(
    table.clientId,
    value,
  );

  _i1.ColumnValue<int, int> driverId(int? value) => _i1.ColumnValue(
    table.driverId,
    value,
  );

  _i1.ColumnValue<int, int> serviceId(int value) => _i1.ColumnValue(
    table.serviceId,
    value,
  );

  _i1.ColumnValue<int, int> pickupAddressId(int? value) => _i1.ColumnValue(
    table.pickupAddressId,
    value,
  );

  _i1.ColumnValue<int, int> dropoffAddressId(int? value) => _i1.ColumnValue(
    table.dropoffAddressId,
    value,
  );

  _i1.ColumnValue<double, double> pickupLatitude(double? value) =>
      _i1.ColumnValue(
        table.pickupLatitude,
        value,
      );

  _i1.ColumnValue<double, double> pickupLongitude(double? value) =>
      _i1.ColumnValue(
        table.pickupLongitude,
        value,
      );

  _i1.ColumnValue<String, String> pickupAddress(String? value) =>
      _i1.ColumnValue(
        table.pickupAddress,
        value,
      );

  _i1.ColumnValue<double, double> dropoffLatitude(double? value) =>
      _i1.ColumnValue(
        table.dropoffLatitude,
        value,
      );

  _i1.ColumnValue<double, double> dropoffLongitude(double? value) =>
      _i1.ColumnValue(
        table.dropoffLongitude,
        value,
      );

  _i1.ColumnValue<String, String> dropoffAddress(String? value) =>
      _i1.ColumnValue(
        table.dropoffAddress,
        value,
      );

  _i1.ColumnValue<double, double> estimatedDistanceKm(double? value) =>
      _i1.ColumnValue(
        table.estimatedDistanceKm,
        value,
      );

  _i1.ColumnValue<double, double> estimatedPrice(double? value) =>
      _i1.ColumnValue(
        table.estimatedPrice,
        value,
      );

  _i1.ColumnValue<double, double> agreedPrice(double? value) => _i1.ColumnValue(
    table.agreedPrice,
    value,
  );

  _i1.ColumnValue<double, double> finalPrice(double? value) => _i1.ColumnValue(
    table.finalPrice,
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

  _i1.ColumnValue<double, double> clientProposedPrice(double? value) =>
      _i1.ColumnValue(
        table.clientProposedPrice,
        value,
      );

  _i1.ColumnValue<double, double> driverCounterPrice(double? value) =>
      _i1.ColumnValue(
        table.driverCounterPrice,
        value,
      );

  _i1.ColumnValue<_i2.PriceNegotiationStatus, _i2.PriceNegotiationStatus>
  priceNegotiationStatus(_i2.PriceNegotiationStatus? value) => _i1.ColumnValue(
    table.priceNegotiationStatus,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );

  _i1.ColumnValue<String, String> clientInstructions(String? value) =>
      _i1.ColumnValue(
        table.clientInstructions,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime? value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );

  _i1.ColumnValue<_i3.OrderStatus, _i3.OrderStatus> status(
    _i3.OrderStatus? value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> acceptedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.acceptedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> startedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.startedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> cancelledAt(DateTime? value) =>
      _i1.ColumnValue(
        table.cancelledAt,
        value,
      );

  _i1.ColumnValue<String, String> cancellationReason(String? value) =>
      _i1.ColumnValue(
        table.cancellationReason,
        value,
      );

  _i1.ColumnValue<int, int> cancelledByUserId(int? value) => _i1.ColumnValue(
    table.cancelledByUserId,
    value,
  );

  _i1.ColumnValue<_i4.CancellerType, _i4.CancellerType> cancelledBy(
    _i4.CancellerType? value,
  ) => _i1.ColumnValue(
    table.cancelledBy,
    value,
  );
}

class OrderTable extends _i1.Table<int?> {
  OrderTable({super.tableRelation}) : super(tableName: 'orders') {
    updateTable = OrderUpdateTable(this);
    clientId = _i1.ColumnInt(
      'clientId',
      this,
    );
    driverId = _i1.ColumnInt(
      'driverId',
      this,
    );
    serviceId = _i1.ColumnInt(
      'serviceId',
      this,
    );
    pickupAddressId = _i1.ColumnInt(
      'pickupAddressId',
      this,
    );
    dropoffAddressId = _i1.ColumnInt(
      'dropoffAddressId',
      this,
    );
    pickupLatitude = _i1.ColumnDouble(
      'pickupLatitude',
      this,
    );
    pickupLongitude = _i1.ColumnDouble(
      'pickupLongitude',
      this,
    );
    pickupAddress = _i1.ColumnString(
      'pickupAddress',
      this,
    );
    dropoffLatitude = _i1.ColumnDouble(
      'dropoffLatitude',
      this,
    );
    dropoffLongitude = _i1.ColumnDouble(
      'dropoffLongitude',
      this,
    );
    dropoffAddress = _i1.ColumnString(
      'dropoffAddress',
      this,
    );
    estimatedDistanceKm = _i1.ColumnDouble(
      'estimatedDistanceKm',
      this,
    );
    estimatedPrice = _i1.ColumnDouble(
      'estimatedPrice',
      this,
    );
    agreedPrice = _i1.ColumnDouble(
      'agreedPrice',
      this,
    );
    finalPrice = _i1.ColumnDouble(
      'finalPrice',
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
    clientProposedPrice = _i1.ColumnDouble(
      'clientProposedPrice',
      this,
    );
    driverCounterPrice = _i1.ColumnDouble(
      'driverCounterPrice',
      this,
    );
    priceNegotiationStatus = _i1.ColumnEnum(
      'priceNegotiationStatus',
      this,
      _i1.EnumSerialization.byIndex,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    clientInstructions = _i1.ColumnString(
      'clientInstructions',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byIndex,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    acceptedAt = _i1.ColumnDateTime(
      'acceptedAt',
      this,
    );
    startedAt = _i1.ColumnDateTime(
      'startedAt',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
    cancelledAt = _i1.ColumnDateTime(
      'cancelledAt',
      this,
    );
    cancellationReason = _i1.ColumnString(
      'cancellationReason',
      this,
    );
    cancelledByUserId = _i1.ColumnInt(
      'cancelledByUserId',
      this,
    );
    cancelledBy = _i1.ColumnEnum(
      'cancelledBy',
      this,
      _i1.EnumSerialization.byIndex,
    );
  }

  late final OrderUpdateTable updateTable;

  late final _i1.ColumnInt clientId;

  late final _i1.ColumnInt driverId;

  late final _i1.ColumnInt serviceId;

  late final _i1.ColumnInt pickupAddressId;

  late final _i1.ColumnInt dropoffAddressId;

  late final _i1.ColumnDouble pickupLatitude;

  late final _i1.ColumnDouble pickupLongitude;

  late final _i1.ColumnString pickupAddress;

  late final _i1.ColumnDouble dropoffLatitude;

  late final _i1.ColumnDouble dropoffLongitude;

  late final _i1.ColumnString dropoffAddress;

  late final _i1.ColumnDouble estimatedDistanceKm;

  late final _i1.ColumnDouble estimatedPrice;

  late final _i1.ColumnDouble agreedPrice;

  late final _i1.ColumnDouble finalPrice;

  late final _i1.ColumnString currency;

  late final _i1.ColumnString currencySymbol;

  late final _i1.ColumnDouble clientProposedPrice;

  late final _i1.ColumnDouble driverCounterPrice;

  late final _i1.ColumnEnum<_i2.PriceNegotiationStatus> priceNegotiationStatus;

  late final _i1.ColumnString notes;

  late final _i1.ColumnString clientInstructions;

  late final _i1.ColumnDateTime expiresAt;

  late final _i1.ColumnEnum<_i3.OrderStatus> status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime acceptedAt;

  late final _i1.ColumnDateTime startedAt;

  late final _i1.ColumnDateTime completedAt;

  late final _i1.ColumnDateTime cancelledAt;

  late final _i1.ColumnString cancellationReason;

  late final _i1.ColumnInt cancelledByUserId;

  late final _i1.ColumnEnum<_i4.CancellerType> cancelledBy;

  @override
  List<_i1.Column> get columns => [
    id,
    clientId,
    driverId,
    serviceId,
    pickupAddressId,
    dropoffAddressId,
    pickupLatitude,
    pickupLongitude,
    pickupAddress,
    dropoffLatitude,
    dropoffLongitude,
    dropoffAddress,
    estimatedDistanceKm,
    estimatedPrice,
    agreedPrice,
    finalPrice,
    currency,
    currencySymbol,
    clientProposedPrice,
    driverCounterPrice,
    priceNegotiationStatus,
    notes,
    clientInstructions,
    expiresAt,
    status,
    createdAt,
    acceptedAt,
    startedAt,
    completedAt,
    cancelledAt,
    cancellationReason,
    cancelledByUserId,
    cancelledBy,
  ];
}

class OrderInclude extends _i1.IncludeObject {
  OrderInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Order.t;
}

class OrderIncludeList extends _i1.IncludeList {
  OrderIncludeList._({
    _i1.WhereExpressionBuilder<OrderTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Order.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Order.t;
}

class OrderRepository {
  const OrderRepository._();

  /// Returns a list of [Order]s matching the given query parameters.
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
  Future<List<Order>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Order>(
      where: where?.call(Order.t),
      orderBy: orderBy?.call(Order.t),
      orderByList: orderByList?.call(Order.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Order] matching the given query parameters.
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
  Future<Order?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Order>(
      where: where?.call(Order.t),
      orderBy: orderBy?.call(Order.t),
      orderByList: orderByList?.call(Order.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Order] by its [id] or null if no such row exists.
  Future<Order?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Order>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Order]s in the list and returns the inserted rows.
  ///
  /// The returned [Order]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Order>> insert(
    _i1.Session session,
    List<Order> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Order>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Order] and returns the inserted row.
  ///
  /// The returned [Order] will have its `id` field set.
  Future<Order> insertRow(
    _i1.Session session,
    Order row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Order>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Order]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Order>> update(
    _i1.Session session,
    List<Order> rows, {
    _i1.ColumnSelections<OrderTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Order>(
      rows,
      columns: columns?.call(Order.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Order]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Order> updateRow(
    _i1.Session session,
    Order row, {
    _i1.ColumnSelections<OrderTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Order>(
      row,
      columns: columns?.call(Order.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Order] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Order?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<OrderUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Order>(
      id,
      columnValues: columnValues(Order.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Order]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Order>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<OrderUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<OrderTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderTable>? orderBy,
    _i1.OrderByListBuilder<OrderTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Order>(
      columnValues: columnValues(Order.t.updateTable),
      where: where(Order.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Order.t),
      orderByList: orderByList?.call(Order.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Order]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Order>> delete(
    _i1.Session session,
    List<Order> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Order>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Order].
  Future<Order> deleteRow(
    _i1.Session session,
    Order row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Order>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Order>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OrderTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Order>(
      where: where(Order.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Order>(
      where: where?.call(Order.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
