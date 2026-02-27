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

abstract class OrderTracking
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OrderTracking._({
    this.id,
    required this.orderId,
    required this.driverId,
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.speed,
    this.heading,
    DateTime? recordedAt,
  }) : recordedAt = recordedAt ?? DateTime.now();

  factory OrderTracking({
    int? id,
    required int orderId,
    required int driverId,
    required double latitude,
    required double longitude,
    double? accuracy,
    double? speed,
    double? heading,
    DateTime? recordedAt,
  }) = _OrderTrackingImpl;

  factory OrderTracking.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderTracking(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      driverId: jsonSerialization['driverId'] as int,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      accuracy: (jsonSerialization['accuracy'] as num?)?.toDouble(),
      speed: (jsonSerialization['speed'] as num?)?.toDouble(),
      heading: (jsonSerialization['heading'] as num?)?.toDouble(),
      recordedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['recordedAt'],
      ),
    );
  }

  static final t = OrderTrackingTable();

  static const db = OrderTrackingRepository._();

  @override
  int? id;

  int orderId;

  int driverId;

  double latitude;

  double longitude;

  double? accuracy;

  double? speed;

  double? heading;

  DateTime recordedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OrderTracking]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderTracking copyWith({
    int? id,
    int? orderId,
    int? driverId,
    double? latitude,
    double? longitude,
    double? accuracy,
    double? speed,
    double? heading,
    DateTime? recordedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderTracking',
      if (id != null) 'id': id,
      'orderId': orderId,
      'driverId': driverId,
      'latitude': latitude,
      'longitude': longitude,
      if (accuracy != null) 'accuracy': accuracy,
      if (speed != null) 'speed': speed,
      if (heading != null) 'heading': heading,
      'recordedAt': recordedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderTracking',
      if (id != null) 'id': id,
      'orderId': orderId,
      'driverId': driverId,
      'latitude': latitude,
      'longitude': longitude,
      if (accuracy != null) 'accuracy': accuracy,
      if (speed != null) 'speed': speed,
      if (heading != null) 'heading': heading,
      'recordedAt': recordedAt.toJson(),
    };
  }

  static OrderTrackingInclude include() {
    return OrderTrackingInclude._();
  }

  static OrderTrackingIncludeList includeList({
    _i1.WhereExpressionBuilder<OrderTrackingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderTrackingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderTrackingTable>? orderByList,
    OrderTrackingInclude? include,
  }) {
    return OrderTrackingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderTracking.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OrderTracking.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderTrackingImpl extends OrderTracking {
  _OrderTrackingImpl({
    int? id,
    required int orderId,
    required int driverId,
    required double latitude,
    required double longitude,
    double? accuracy,
    double? speed,
    double? heading,
    DateTime? recordedAt,
  }) : super._(
         id: id,
         orderId: orderId,
         driverId: driverId,
         latitude: latitude,
         longitude: longitude,
         accuracy: accuracy,
         speed: speed,
         heading: heading,
         recordedAt: recordedAt,
       );

  /// Returns a shallow copy of this [OrderTracking]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderTracking copyWith({
    Object? id = _Undefined,
    int? orderId,
    int? driverId,
    double? latitude,
    double? longitude,
    Object? accuracy = _Undefined,
    Object? speed = _Undefined,
    Object? heading = _Undefined,
    DateTime? recordedAt,
  }) {
    return OrderTracking(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      driverId: driverId ?? this.driverId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracy: accuracy is double? ? accuracy : this.accuracy,
      speed: speed is double? ? speed : this.speed,
      heading: heading is double? ? heading : this.heading,
      recordedAt: recordedAt ?? this.recordedAt,
    );
  }
}

class OrderTrackingUpdateTable extends _i1.UpdateTable<OrderTrackingTable> {
  OrderTrackingUpdateTable(super.table);

  _i1.ColumnValue<int, int> orderId(int value) => _i1.ColumnValue(
    table.orderId,
    value,
  );

  _i1.ColumnValue<int, int> driverId(int value) => _i1.ColumnValue(
    table.driverId,
    value,
  );

  _i1.ColumnValue<double, double> latitude(double value) => _i1.ColumnValue(
    table.latitude,
    value,
  );

  _i1.ColumnValue<double, double> longitude(double value) => _i1.ColumnValue(
    table.longitude,
    value,
  );

  _i1.ColumnValue<double, double> accuracy(double? value) => _i1.ColumnValue(
    table.accuracy,
    value,
  );

  _i1.ColumnValue<double, double> speed(double? value) => _i1.ColumnValue(
    table.speed,
    value,
  );

  _i1.ColumnValue<double, double> heading(double? value) => _i1.ColumnValue(
    table.heading,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> recordedAt(DateTime value) =>
      _i1.ColumnValue(
        table.recordedAt,
        value,
      );
}

class OrderTrackingTable extends _i1.Table<int?> {
  OrderTrackingTable({super.tableRelation})
    : super(tableName: 'order_tracking') {
    updateTable = OrderTrackingUpdateTable(this);
    orderId = _i1.ColumnInt(
      'orderId',
      this,
    );
    driverId = _i1.ColumnInt(
      'driverId',
      this,
    );
    latitude = _i1.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _i1.ColumnDouble(
      'longitude',
      this,
    );
    accuracy = _i1.ColumnDouble(
      'accuracy',
      this,
    );
    speed = _i1.ColumnDouble(
      'speed',
      this,
    );
    heading = _i1.ColumnDouble(
      'heading',
      this,
    );
    recordedAt = _i1.ColumnDateTime(
      'recordedAt',
      this,
      hasDefault: true,
    );
  }

  late final OrderTrackingUpdateTable updateTable;

  late final _i1.ColumnInt orderId;

  late final _i1.ColumnInt driverId;

  late final _i1.ColumnDouble latitude;

  late final _i1.ColumnDouble longitude;

  late final _i1.ColumnDouble accuracy;

  late final _i1.ColumnDouble speed;

  late final _i1.ColumnDouble heading;

  late final _i1.ColumnDateTime recordedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    orderId,
    driverId,
    latitude,
    longitude,
    accuracy,
    speed,
    heading,
    recordedAt,
  ];
}

class OrderTrackingInclude extends _i1.IncludeObject {
  OrderTrackingInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => OrderTracking.t;
}

class OrderTrackingIncludeList extends _i1.IncludeList {
  OrderTrackingIncludeList._({
    _i1.WhereExpressionBuilder<OrderTrackingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OrderTracking.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OrderTracking.t;
}

class OrderTrackingRepository {
  const OrderTrackingRepository._();

  /// Returns a list of [OrderTracking]s matching the given query parameters.
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
  Future<List<OrderTracking>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderTrackingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderTrackingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderTrackingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<OrderTracking>(
      where: where?.call(OrderTracking.t),
      orderBy: orderBy?.call(OrderTracking.t),
      orderByList: orderByList?.call(OrderTracking.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [OrderTracking] matching the given query parameters.
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
  Future<OrderTracking?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderTrackingTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrderTrackingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderTrackingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<OrderTracking>(
      where: where?.call(OrderTracking.t),
      orderBy: orderBy?.call(OrderTracking.t),
      orderByList: orderByList?.call(OrderTracking.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [OrderTracking] by its [id] or null if no such row exists.
  Future<OrderTracking?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<OrderTracking>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [OrderTracking]s in the list and returns the inserted rows.
  ///
  /// The returned [OrderTracking]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<OrderTracking>> insert(
    _i1.Session session,
    List<OrderTracking> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<OrderTracking>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [OrderTracking] and returns the inserted row.
  ///
  /// The returned [OrderTracking] will have its `id` field set.
  Future<OrderTracking> insertRow(
    _i1.Session session,
    OrderTracking row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OrderTracking>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OrderTracking]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OrderTracking>> update(
    _i1.Session session,
    List<OrderTracking> rows, {
    _i1.ColumnSelections<OrderTrackingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OrderTracking>(
      rows,
      columns: columns?.call(OrderTracking.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrderTracking]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OrderTracking> updateRow(
    _i1.Session session,
    OrderTracking row, {
    _i1.ColumnSelections<OrderTrackingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OrderTracking>(
      row,
      columns: columns?.call(OrderTracking.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrderTracking] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OrderTracking?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<OrderTrackingUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OrderTracking>(
      id,
      columnValues: columnValues(OrderTracking.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OrderTracking]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OrderTracking>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<OrderTrackingUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<OrderTrackingTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderTrackingTable>? orderBy,
    _i1.OrderByListBuilder<OrderTrackingTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OrderTracking>(
      columnValues: columnValues(OrderTracking.t.updateTable),
      where: where(OrderTracking.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderTracking.t),
      orderByList: orderByList?.call(OrderTracking.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OrderTracking]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OrderTracking>> delete(
    _i1.Session session,
    List<OrderTracking> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OrderTracking>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OrderTracking].
  Future<OrderTracking> deleteRow(
    _i1.Session session,
    OrderTracking row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OrderTracking>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OrderTracking>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OrderTrackingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OrderTracking>(
      where: where(OrderTracking.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderTrackingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OrderTracking>(
      where: where?.call(OrderTracking.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
