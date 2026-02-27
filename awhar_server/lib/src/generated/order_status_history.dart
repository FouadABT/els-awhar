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
import 'order_status_enum.dart' as _i2;

abstract class OrderStatusHistory
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OrderStatusHistory._({
    this.id,
    required this.orderId,
    this.fromStatus,
    this.toStatus,
    required this.changedByUserId,
    this.notes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory OrderStatusHistory({
    int? id,
    required int orderId,
    _i2.OrderStatus? fromStatus,
    _i2.OrderStatus? toStatus,
    required int changedByUserId,
    String? notes,
    DateTime? createdAt,
  }) = _OrderStatusHistoryImpl;

  factory OrderStatusHistory.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderStatusHistory(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      fromStatus: jsonSerialization['fromStatus'] == null
          ? null
          : _i2.OrderStatus.fromJson((jsonSerialization['fromStatus'] as int)),
      toStatus: jsonSerialization['toStatus'] == null
          ? null
          : _i2.OrderStatus.fromJson((jsonSerialization['toStatus'] as int)),
      changedByUserId: jsonSerialization['changedByUserId'] as int,
      notes: jsonSerialization['notes'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = OrderStatusHistoryTable();

  static const db = OrderStatusHistoryRepository._();

  @override
  int? id;

  int orderId;

  _i2.OrderStatus? fromStatus;

  _i2.OrderStatus? toStatus;

  int changedByUserId;

  String? notes;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OrderStatusHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderStatusHistory copyWith({
    int? id,
    int? orderId,
    _i2.OrderStatus? fromStatus,
    _i2.OrderStatus? toStatus,
    int? changedByUserId,
    String? notes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderStatusHistory',
      if (id != null) 'id': id,
      'orderId': orderId,
      if (fromStatus != null) 'fromStatus': fromStatus?.toJson(),
      if (toStatus != null) 'toStatus': toStatus?.toJson(),
      'changedByUserId': changedByUserId,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderStatusHistory',
      if (id != null) 'id': id,
      'orderId': orderId,
      if (fromStatus != null) 'fromStatus': fromStatus?.toJson(),
      if (toStatus != null) 'toStatus': toStatus?.toJson(),
      'changedByUserId': changedByUserId,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
    };
  }

  static OrderStatusHistoryInclude include() {
    return OrderStatusHistoryInclude._();
  }

  static OrderStatusHistoryIncludeList includeList({
    _i1.WhereExpressionBuilder<OrderStatusHistoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderStatusHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderStatusHistoryTable>? orderByList,
    OrderStatusHistoryInclude? include,
  }) {
    return OrderStatusHistoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderStatusHistory.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OrderStatusHistory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderStatusHistoryImpl extends OrderStatusHistory {
  _OrderStatusHistoryImpl({
    int? id,
    required int orderId,
    _i2.OrderStatus? fromStatus,
    _i2.OrderStatus? toStatus,
    required int changedByUserId,
    String? notes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         orderId: orderId,
         fromStatus: fromStatus,
         toStatus: toStatus,
         changedByUserId: changedByUserId,
         notes: notes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [OrderStatusHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderStatusHistory copyWith({
    Object? id = _Undefined,
    int? orderId,
    Object? fromStatus = _Undefined,
    Object? toStatus = _Undefined,
    int? changedByUserId,
    Object? notes = _Undefined,
    DateTime? createdAt,
  }) {
    return OrderStatusHistory(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      fromStatus: fromStatus is _i2.OrderStatus? ? fromStatus : this.fromStatus,
      toStatus: toStatus is _i2.OrderStatus? ? toStatus : this.toStatus,
      changedByUserId: changedByUserId ?? this.changedByUserId,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class OrderStatusHistoryUpdateTable
    extends _i1.UpdateTable<OrderStatusHistoryTable> {
  OrderStatusHistoryUpdateTable(super.table);

  _i1.ColumnValue<int, int> orderId(int value) => _i1.ColumnValue(
    table.orderId,
    value,
  );

  _i1.ColumnValue<_i2.OrderStatus, _i2.OrderStatus> fromStatus(
    _i2.OrderStatus? value,
  ) => _i1.ColumnValue(
    table.fromStatus,
    value,
  );

  _i1.ColumnValue<_i2.OrderStatus, _i2.OrderStatus> toStatus(
    _i2.OrderStatus? value,
  ) => _i1.ColumnValue(
    table.toStatus,
    value,
  );

  _i1.ColumnValue<int, int> changedByUserId(int value) => _i1.ColumnValue(
    table.changedByUserId,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class OrderStatusHistoryTable extends _i1.Table<int?> {
  OrderStatusHistoryTable({super.tableRelation})
    : super(tableName: 'order_status_history') {
    updateTable = OrderStatusHistoryUpdateTable(this);
    orderId = _i1.ColumnInt(
      'orderId',
      this,
    );
    fromStatus = _i1.ColumnEnum(
      'fromStatus',
      this,
      _i1.EnumSerialization.byIndex,
    );
    toStatus = _i1.ColumnEnum(
      'toStatus',
      this,
      _i1.EnumSerialization.byIndex,
    );
    changedByUserId = _i1.ColumnInt(
      'changedByUserId',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final OrderStatusHistoryUpdateTable updateTable;

  late final _i1.ColumnInt orderId;

  late final _i1.ColumnEnum<_i2.OrderStatus> fromStatus;

  late final _i1.ColumnEnum<_i2.OrderStatus> toStatus;

  late final _i1.ColumnInt changedByUserId;

  late final _i1.ColumnString notes;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    orderId,
    fromStatus,
    toStatus,
    changedByUserId,
    notes,
    createdAt,
  ];
}

class OrderStatusHistoryInclude extends _i1.IncludeObject {
  OrderStatusHistoryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => OrderStatusHistory.t;
}

class OrderStatusHistoryIncludeList extends _i1.IncludeList {
  OrderStatusHistoryIncludeList._({
    _i1.WhereExpressionBuilder<OrderStatusHistoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OrderStatusHistory.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OrderStatusHistory.t;
}

class OrderStatusHistoryRepository {
  const OrderStatusHistoryRepository._();

  /// Returns a list of [OrderStatusHistory]s matching the given query parameters.
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
  Future<List<OrderStatusHistory>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderStatusHistoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderStatusHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderStatusHistoryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<OrderStatusHistory>(
      where: where?.call(OrderStatusHistory.t),
      orderBy: orderBy?.call(OrderStatusHistory.t),
      orderByList: orderByList?.call(OrderStatusHistory.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [OrderStatusHistory] matching the given query parameters.
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
  Future<OrderStatusHistory?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderStatusHistoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrderStatusHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderStatusHistoryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<OrderStatusHistory>(
      where: where?.call(OrderStatusHistory.t),
      orderBy: orderBy?.call(OrderStatusHistory.t),
      orderByList: orderByList?.call(OrderStatusHistory.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [OrderStatusHistory] by its [id] or null if no such row exists.
  Future<OrderStatusHistory?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<OrderStatusHistory>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [OrderStatusHistory]s in the list and returns the inserted rows.
  ///
  /// The returned [OrderStatusHistory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<OrderStatusHistory>> insert(
    _i1.Session session,
    List<OrderStatusHistory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<OrderStatusHistory>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [OrderStatusHistory] and returns the inserted row.
  ///
  /// The returned [OrderStatusHistory] will have its `id` field set.
  Future<OrderStatusHistory> insertRow(
    _i1.Session session,
    OrderStatusHistory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OrderStatusHistory>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OrderStatusHistory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OrderStatusHistory>> update(
    _i1.Session session,
    List<OrderStatusHistory> rows, {
    _i1.ColumnSelections<OrderStatusHistoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OrderStatusHistory>(
      rows,
      columns: columns?.call(OrderStatusHistory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrderStatusHistory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OrderStatusHistory> updateRow(
    _i1.Session session,
    OrderStatusHistory row, {
    _i1.ColumnSelections<OrderStatusHistoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OrderStatusHistory>(
      row,
      columns: columns?.call(OrderStatusHistory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrderStatusHistory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OrderStatusHistory?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<OrderStatusHistoryUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OrderStatusHistory>(
      id,
      columnValues: columnValues(OrderStatusHistory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OrderStatusHistory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OrderStatusHistory>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<OrderStatusHistoryUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<OrderStatusHistoryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderStatusHistoryTable>? orderBy,
    _i1.OrderByListBuilder<OrderStatusHistoryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OrderStatusHistory>(
      columnValues: columnValues(OrderStatusHistory.t.updateTable),
      where: where(OrderStatusHistory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderStatusHistory.t),
      orderByList: orderByList?.call(OrderStatusHistory.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OrderStatusHistory]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OrderStatusHistory>> delete(
    _i1.Session session,
    List<OrderStatusHistory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OrderStatusHistory>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OrderStatusHistory].
  Future<OrderStatusHistory> deleteRow(
    _i1.Session session,
    OrderStatusHistory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OrderStatusHistory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OrderStatusHistory>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OrderStatusHistoryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OrderStatusHistory>(
      where: where(OrderStatusHistory.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrderStatusHistoryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OrderStatusHistory>(
      where: where?.call(OrderStatusHistory.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
