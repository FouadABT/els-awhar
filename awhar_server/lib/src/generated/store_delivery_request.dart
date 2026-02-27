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

abstract class StoreDeliveryRequest
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StoreDeliveryRequest._({
    this.id,
    required this.storeOrderId,
    required this.storeId,
    required this.requestType,
    this.targetDriverId,
    required this.pickupAddress,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.deliveryAddress,
    required this.deliveryLatitude,
    required this.deliveryLongitude,
    this.distanceKm,
    required this.deliveryFee,
    required this.driverEarnings,
    String? status,
    this.assignedDriverId,
    this.expiresAt,
    DateTime? createdAt,
    this.acceptedAt,
    this.rejectedAt,
  }) : status = status ?? 'pending',
       createdAt = createdAt ?? DateTime.now();

  factory StoreDeliveryRequest({
    int? id,
    required int storeOrderId,
    required int storeId,
    required String requestType,
    int? targetDriverId,
    required String pickupAddress,
    required double pickupLatitude,
    required double pickupLongitude,
    required String deliveryAddress,
    required double deliveryLatitude,
    required double deliveryLongitude,
    double? distanceKm,
    required double deliveryFee,
    required double driverEarnings,
    String? status,
    int? assignedDriverId,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? rejectedAt,
  }) = _StoreDeliveryRequestImpl;

  factory StoreDeliveryRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return StoreDeliveryRequest(
      id: jsonSerialization['id'] as int?,
      storeOrderId: jsonSerialization['storeOrderId'] as int,
      storeId: jsonSerialization['storeId'] as int,
      requestType: jsonSerialization['requestType'] as String,
      targetDriverId: jsonSerialization['targetDriverId'] as int?,
      pickupAddress: jsonSerialization['pickupAddress'] as String,
      pickupLatitude: (jsonSerialization['pickupLatitude'] as num).toDouble(),
      pickupLongitude: (jsonSerialization['pickupLongitude'] as num).toDouble(),
      deliveryAddress: jsonSerialization['deliveryAddress'] as String,
      deliveryLatitude: (jsonSerialization['deliveryLatitude'] as num)
          .toDouble(),
      deliveryLongitude: (jsonSerialization['deliveryLongitude'] as num)
          .toDouble(),
      distanceKm: (jsonSerialization['distanceKm'] as num?)?.toDouble(),
      deliveryFee: (jsonSerialization['deliveryFee'] as num).toDouble(),
      driverEarnings: (jsonSerialization['driverEarnings'] as num).toDouble(),
      status: jsonSerialization['status'] as String,
      assignedDriverId: jsonSerialization['assignedDriverId'] as int?,
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      acceptedAt: jsonSerialization['acceptedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['acceptedAt']),
      rejectedAt: jsonSerialization['rejectedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['rejectedAt']),
    );
  }

  static final t = StoreDeliveryRequestTable();

  static const db = StoreDeliveryRequestRepository._();

  @override
  int? id;

  int storeOrderId;

  int storeId;

  String requestType;

  int? targetDriverId;

  String pickupAddress;

  double pickupLatitude;

  double pickupLongitude;

  String deliveryAddress;

  double deliveryLatitude;

  double deliveryLongitude;

  double? distanceKm;

  double deliveryFee;

  double driverEarnings;

  String status;

  int? assignedDriverId;

  DateTime? expiresAt;

  DateTime createdAt;

  DateTime? acceptedAt;

  DateTime? rejectedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StoreDeliveryRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreDeliveryRequest copyWith({
    int? id,
    int? storeOrderId,
    int? storeId,
    String? requestType,
    int? targetDriverId,
    String? pickupAddress,
    double? pickupLatitude,
    double? pickupLongitude,
    String? deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
    double? distanceKm,
    double? deliveryFee,
    double? driverEarnings,
    String? status,
    int? assignedDriverId,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? rejectedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreDeliveryRequest',
      if (id != null) 'id': id,
      'storeOrderId': storeOrderId,
      'storeId': storeId,
      'requestType': requestType,
      if (targetDriverId != null) 'targetDriverId': targetDriverId,
      'pickupAddress': pickupAddress,
      'pickupLatitude': pickupLatitude,
      'pickupLongitude': pickupLongitude,
      'deliveryAddress': deliveryAddress,
      'deliveryLatitude': deliveryLatitude,
      'deliveryLongitude': deliveryLongitude,
      if (distanceKm != null) 'distanceKm': distanceKm,
      'deliveryFee': deliveryFee,
      'driverEarnings': driverEarnings,
      'status': status,
      if (assignedDriverId != null) 'assignedDriverId': assignedDriverId,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      'createdAt': createdAt.toJson(),
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
      if (rejectedAt != null) 'rejectedAt': rejectedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StoreDeliveryRequest',
      if (id != null) 'id': id,
      'storeOrderId': storeOrderId,
      'storeId': storeId,
      'requestType': requestType,
      if (targetDriverId != null) 'targetDriverId': targetDriverId,
      'pickupAddress': pickupAddress,
      'pickupLatitude': pickupLatitude,
      'pickupLongitude': pickupLongitude,
      'deliveryAddress': deliveryAddress,
      'deliveryLatitude': deliveryLatitude,
      'deliveryLongitude': deliveryLongitude,
      if (distanceKm != null) 'distanceKm': distanceKm,
      'deliveryFee': deliveryFee,
      'driverEarnings': driverEarnings,
      'status': status,
      if (assignedDriverId != null) 'assignedDriverId': assignedDriverId,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      'createdAt': createdAt.toJson(),
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
      if (rejectedAt != null) 'rejectedAt': rejectedAt?.toJson(),
    };
  }

  static StoreDeliveryRequestInclude include() {
    return StoreDeliveryRequestInclude._();
  }

  static StoreDeliveryRequestIncludeList includeList({
    _i1.WhereExpressionBuilder<StoreDeliveryRequestTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreDeliveryRequestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreDeliveryRequestTable>? orderByList,
    StoreDeliveryRequestInclude? include,
  }) {
    return StoreDeliveryRequestIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreDeliveryRequest.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StoreDeliveryRequest.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreDeliveryRequestImpl extends StoreDeliveryRequest {
  _StoreDeliveryRequestImpl({
    int? id,
    required int storeOrderId,
    required int storeId,
    required String requestType,
    int? targetDriverId,
    required String pickupAddress,
    required double pickupLatitude,
    required double pickupLongitude,
    required String deliveryAddress,
    required double deliveryLatitude,
    required double deliveryLongitude,
    double? distanceKm,
    required double deliveryFee,
    required double driverEarnings,
    String? status,
    int? assignedDriverId,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? rejectedAt,
  }) : super._(
         id: id,
         storeOrderId: storeOrderId,
         storeId: storeId,
         requestType: requestType,
         targetDriverId: targetDriverId,
         pickupAddress: pickupAddress,
         pickupLatitude: pickupLatitude,
         pickupLongitude: pickupLongitude,
         deliveryAddress: deliveryAddress,
         deliveryLatitude: deliveryLatitude,
         deliveryLongitude: deliveryLongitude,
         distanceKm: distanceKm,
         deliveryFee: deliveryFee,
         driverEarnings: driverEarnings,
         status: status,
         assignedDriverId: assignedDriverId,
         expiresAt: expiresAt,
         createdAt: createdAt,
         acceptedAt: acceptedAt,
         rejectedAt: rejectedAt,
       );

  /// Returns a shallow copy of this [StoreDeliveryRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreDeliveryRequest copyWith({
    Object? id = _Undefined,
    int? storeOrderId,
    int? storeId,
    String? requestType,
    Object? targetDriverId = _Undefined,
    String? pickupAddress,
    double? pickupLatitude,
    double? pickupLongitude,
    String? deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
    Object? distanceKm = _Undefined,
    double? deliveryFee,
    double? driverEarnings,
    String? status,
    Object? assignedDriverId = _Undefined,
    Object? expiresAt = _Undefined,
    DateTime? createdAt,
    Object? acceptedAt = _Undefined,
    Object? rejectedAt = _Undefined,
  }) {
    return StoreDeliveryRequest(
      id: id is int? ? id : this.id,
      storeOrderId: storeOrderId ?? this.storeOrderId,
      storeId: storeId ?? this.storeId,
      requestType: requestType ?? this.requestType,
      targetDriverId: targetDriverId is int?
          ? targetDriverId
          : this.targetDriverId,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      pickupLatitude: pickupLatitude ?? this.pickupLatitude,
      pickupLongitude: pickupLongitude ?? this.pickupLongitude,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryLatitude: deliveryLatitude ?? this.deliveryLatitude,
      deliveryLongitude: deliveryLongitude ?? this.deliveryLongitude,
      distanceKm: distanceKm is double? ? distanceKm : this.distanceKm,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      driverEarnings: driverEarnings ?? this.driverEarnings,
      status: status ?? this.status,
      assignedDriverId: assignedDriverId is int?
          ? assignedDriverId
          : this.assignedDriverId,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      acceptedAt: acceptedAt is DateTime? ? acceptedAt : this.acceptedAt,
      rejectedAt: rejectedAt is DateTime? ? rejectedAt : this.rejectedAt,
    );
  }
}

class StoreDeliveryRequestUpdateTable
    extends _i1.UpdateTable<StoreDeliveryRequestTable> {
  StoreDeliveryRequestUpdateTable(super.table);

  _i1.ColumnValue<int, int> storeOrderId(int value) => _i1.ColumnValue(
    table.storeOrderId,
    value,
  );

  _i1.ColumnValue<int, int> storeId(int value) => _i1.ColumnValue(
    table.storeId,
    value,
  );

  _i1.ColumnValue<String, String> requestType(String value) => _i1.ColumnValue(
    table.requestType,
    value,
  );

  _i1.ColumnValue<int, int> targetDriverId(int? value) => _i1.ColumnValue(
    table.targetDriverId,
    value,
  );

  _i1.ColumnValue<String, String> pickupAddress(String value) =>
      _i1.ColumnValue(
        table.pickupAddress,
        value,
      );

  _i1.ColumnValue<double, double> pickupLatitude(double value) =>
      _i1.ColumnValue(
        table.pickupLatitude,
        value,
      );

  _i1.ColumnValue<double, double> pickupLongitude(double value) =>
      _i1.ColumnValue(
        table.pickupLongitude,
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

  _i1.ColumnValue<double, double> distanceKm(double? value) => _i1.ColumnValue(
    table.distanceKm,
    value,
  );

  _i1.ColumnValue<double, double> deliveryFee(double value) => _i1.ColumnValue(
    table.deliveryFee,
    value,
  );

  _i1.ColumnValue<double, double> driverEarnings(double value) =>
      _i1.ColumnValue(
        table.driverEarnings,
        value,
      );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> assignedDriverId(int? value) => _i1.ColumnValue(
    table.assignedDriverId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime? value) =>
      _i1.ColumnValue(
        table.expiresAt,
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

  _i1.ColumnValue<DateTime, DateTime> rejectedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.rejectedAt,
        value,
      );
}

class StoreDeliveryRequestTable extends _i1.Table<int?> {
  StoreDeliveryRequestTable({super.tableRelation})
    : super(tableName: 'store_delivery_requests') {
    updateTable = StoreDeliveryRequestUpdateTable(this);
    storeOrderId = _i1.ColumnInt(
      'storeOrderId',
      this,
    );
    storeId = _i1.ColumnInt(
      'storeId',
      this,
    );
    requestType = _i1.ColumnString(
      'requestType',
      this,
    );
    targetDriverId = _i1.ColumnInt(
      'targetDriverId',
      this,
    );
    pickupAddress = _i1.ColumnString(
      'pickupAddress',
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
    distanceKm = _i1.ColumnDouble(
      'distanceKm',
      this,
    );
    deliveryFee = _i1.ColumnDouble(
      'deliveryFee',
      this,
    );
    driverEarnings = _i1.ColumnDouble(
      'driverEarnings',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    assignedDriverId = _i1.ColumnInt(
      'assignedDriverId',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
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
    rejectedAt = _i1.ColumnDateTime(
      'rejectedAt',
      this,
    );
  }

  late final StoreDeliveryRequestUpdateTable updateTable;

  late final _i1.ColumnInt storeOrderId;

  late final _i1.ColumnInt storeId;

  late final _i1.ColumnString requestType;

  late final _i1.ColumnInt targetDriverId;

  late final _i1.ColumnString pickupAddress;

  late final _i1.ColumnDouble pickupLatitude;

  late final _i1.ColumnDouble pickupLongitude;

  late final _i1.ColumnString deliveryAddress;

  late final _i1.ColumnDouble deliveryLatitude;

  late final _i1.ColumnDouble deliveryLongitude;

  late final _i1.ColumnDouble distanceKm;

  late final _i1.ColumnDouble deliveryFee;

  late final _i1.ColumnDouble driverEarnings;

  late final _i1.ColumnString status;

  late final _i1.ColumnInt assignedDriverId;

  late final _i1.ColumnDateTime expiresAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime acceptedAt;

  late final _i1.ColumnDateTime rejectedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    storeOrderId,
    storeId,
    requestType,
    targetDriverId,
    pickupAddress,
    pickupLatitude,
    pickupLongitude,
    deliveryAddress,
    deliveryLatitude,
    deliveryLongitude,
    distanceKm,
    deliveryFee,
    driverEarnings,
    status,
    assignedDriverId,
    expiresAt,
    createdAt,
    acceptedAt,
    rejectedAt,
  ];
}

class StoreDeliveryRequestInclude extends _i1.IncludeObject {
  StoreDeliveryRequestInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StoreDeliveryRequest.t;
}

class StoreDeliveryRequestIncludeList extends _i1.IncludeList {
  StoreDeliveryRequestIncludeList._({
    _i1.WhereExpressionBuilder<StoreDeliveryRequestTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreDeliveryRequest.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StoreDeliveryRequest.t;
}

class StoreDeliveryRequestRepository {
  const StoreDeliveryRequestRepository._();

  /// Returns a list of [StoreDeliveryRequest]s matching the given query parameters.
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
  Future<List<StoreDeliveryRequest>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreDeliveryRequestTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreDeliveryRequestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreDeliveryRequestTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<StoreDeliveryRequest>(
      where: where?.call(StoreDeliveryRequest.t),
      orderBy: orderBy?.call(StoreDeliveryRequest.t),
      orderByList: orderByList?.call(StoreDeliveryRequest.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [StoreDeliveryRequest] matching the given query parameters.
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
  Future<StoreDeliveryRequest?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreDeliveryRequestTable>? where,
    int? offset,
    _i1.OrderByBuilder<StoreDeliveryRequestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreDeliveryRequestTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<StoreDeliveryRequest>(
      where: where?.call(StoreDeliveryRequest.t),
      orderBy: orderBy?.call(StoreDeliveryRequest.t),
      orderByList: orderByList?.call(StoreDeliveryRequest.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [StoreDeliveryRequest] by its [id] or null if no such row exists.
  Future<StoreDeliveryRequest?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<StoreDeliveryRequest>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [StoreDeliveryRequest]s in the list and returns the inserted rows.
  ///
  /// The returned [StoreDeliveryRequest]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StoreDeliveryRequest>> insert(
    _i1.Session session,
    List<StoreDeliveryRequest> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StoreDeliveryRequest>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StoreDeliveryRequest] and returns the inserted row.
  ///
  /// The returned [StoreDeliveryRequest] will have its `id` field set.
  Future<StoreDeliveryRequest> insertRow(
    _i1.Session session,
    StoreDeliveryRequest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreDeliveryRequest>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StoreDeliveryRequest]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StoreDeliveryRequest>> update(
    _i1.Session session,
    List<StoreDeliveryRequest> rows, {
    _i1.ColumnSelections<StoreDeliveryRequestTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StoreDeliveryRequest>(
      rows,
      columns: columns?.call(StoreDeliveryRequest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreDeliveryRequest]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StoreDeliveryRequest> updateRow(
    _i1.Session session,
    StoreDeliveryRequest row, {
    _i1.ColumnSelections<StoreDeliveryRequestTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoreDeliveryRequest>(
      row,
      columns: columns?.call(StoreDeliveryRequest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreDeliveryRequest] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StoreDeliveryRequest?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<StoreDeliveryRequestUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StoreDeliveryRequest>(
      id,
      columnValues: columnValues(StoreDeliveryRequest.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StoreDeliveryRequest]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StoreDeliveryRequest>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<StoreDeliveryRequestUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<StoreDeliveryRequestTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreDeliveryRequestTable>? orderBy,
    _i1.OrderByListBuilder<StoreDeliveryRequestTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StoreDeliveryRequest>(
      columnValues: columnValues(StoreDeliveryRequest.t.updateTable),
      where: where(StoreDeliveryRequest.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreDeliveryRequest.t),
      orderByList: orderByList?.call(StoreDeliveryRequest.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StoreDeliveryRequest]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StoreDeliveryRequest>> delete(
    _i1.Session session,
    List<StoreDeliveryRequest> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StoreDeliveryRequest>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StoreDeliveryRequest].
  Future<StoreDeliveryRequest> deleteRow(
    _i1.Session session,
    StoreDeliveryRequest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreDeliveryRequest>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StoreDeliveryRequest>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StoreDeliveryRequestTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StoreDeliveryRequest>(
      where: where(StoreDeliveryRequest.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreDeliveryRequestTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StoreDeliveryRequest>(
      where: where?.call(StoreDeliveryRequest.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
