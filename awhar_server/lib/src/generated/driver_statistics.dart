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

abstract class DriverStatistics
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DriverStatistics._({
    this.id,
    required this.driverId,
    required this.periodType,
    required this.periodStart,
    required this.periodEnd,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    double? totalRevenue,
    double? platformCommission,
    double? netRevenue,
    double? averageRating,
    int? averageResponseTime,
    int? averageCompletionTime,
    double? hoursOnline,
    double? hoursOffline,
    DateTime? createdAt,
  }) : totalOrders = totalOrders ?? 0,
       completedOrders = completedOrders ?? 0,
       cancelledOrders = cancelledOrders ?? 0,
       totalRevenue = totalRevenue ?? 0.0,
       platformCommission = platformCommission ?? 0.0,
       netRevenue = netRevenue ?? 0.0,
       averageRating = averageRating ?? 0.0,
       averageResponseTime = averageResponseTime ?? 0,
       averageCompletionTime = averageCompletionTime ?? 0,
       hoursOnline = hoursOnline ?? 0.0,
       hoursOffline = hoursOffline ?? 0.0,
       createdAt = createdAt ?? DateTime.now();

  factory DriverStatistics({
    int? id,
    required int driverId,
    required String periodType,
    required DateTime periodStart,
    required DateTime periodEnd,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    double? totalRevenue,
    double? platformCommission,
    double? netRevenue,
    double? averageRating,
    int? averageResponseTime,
    int? averageCompletionTime,
    double? hoursOnline,
    double? hoursOffline,
    DateTime? createdAt,
  }) = _DriverStatisticsImpl;

  factory DriverStatistics.fromJson(Map<String, dynamic> jsonSerialization) {
    return DriverStatistics(
      id: jsonSerialization['id'] as int?,
      driverId: jsonSerialization['driverId'] as int,
      periodType: jsonSerialization['periodType'] as String,
      periodStart: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['periodStart'],
      ),
      periodEnd: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['periodEnd'],
      ),
      totalOrders: jsonSerialization['totalOrders'] as int,
      completedOrders: jsonSerialization['completedOrders'] as int,
      cancelledOrders: jsonSerialization['cancelledOrders'] as int,
      totalRevenue: (jsonSerialization['totalRevenue'] as num).toDouble(),
      platformCommission: (jsonSerialization['platformCommission'] as num)
          .toDouble(),
      netRevenue: (jsonSerialization['netRevenue'] as num).toDouble(),
      averageRating: (jsonSerialization['averageRating'] as num).toDouble(),
      averageResponseTime: jsonSerialization['averageResponseTime'] as int,
      averageCompletionTime: jsonSerialization['averageCompletionTime'] as int,
      hoursOnline: (jsonSerialization['hoursOnline'] as num).toDouble(),
      hoursOffline: (jsonSerialization['hoursOffline'] as num).toDouble(),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = DriverStatisticsTable();

  static const db = DriverStatisticsRepository._();

  @override
  int? id;

  int driverId;

  String periodType;

  DateTime periodStart;

  DateTime periodEnd;

  int totalOrders;

  int completedOrders;

  int cancelledOrders;

  double totalRevenue;

  double platformCommission;

  double netRevenue;

  double averageRating;

  int averageResponseTime;

  int averageCompletionTime;

  double hoursOnline;

  double hoursOffline;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DriverStatistics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DriverStatistics copyWith({
    int? id,
    int? driverId,
    String? periodType,
    DateTime? periodStart,
    DateTime? periodEnd,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    double? totalRevenue,
    double? platformCommission,
    double? netRevenue,
    double? averageRating,
    int? averageResponseTime,
    int? averageCompletionTime,
    double? hoursOnline,
    double? hoursOffline,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DriverStatistics',
      if (id != null) 'id': id,
      'driverId': driverId,
      'periodType': periodType,
      'periodStart': periodStart.toJson(),
      'periodEnd': periodEnd.toJson(),
      'totalOrders': totalOrders,
      'completedOrders': completedOrders,
      'cancelledOrders': cancelledOrders,
      'totalRevenue': totalRevenue,
      'platformCommission': platformCommission,
      'netRevenue': netRevenue,
      'averageRating': averageRating,
      'averageResponseTime': averageResponseTime,
      'averageCompletionTime': averageCompletionTime,
      'hoursOnline': hoursOnline,
      'hoursOffline': hoursOffline,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DriverStatistics',
      if (id != null) 'id': id,
      'driverId': driverId,
      'periodType': periodType,
      'periodStart': periodStart.toJson(),
      'periodEnd': periodEnd.toJson(),
      'totalOrders': totalOrders,
      'completedOrders': completedOrders,
      'cancelledOrders': cancelledOrders,
      'totalRevenue': totalRevenue,
      'platformCommission': platformCommission,
      'netRevenue': netRevenue,
      'averageRating': averageRating,
      'averageResponseTime': averageResponseTime,
      'averageCompletionTime': averageCompletionTime,
      'hoursOnline': hoursOnline,
      'hoursOffline': hoursOffline,
      'createdAt': createdAt.toJson(),
    };
  }

  static DriverStatisticsInclude include() {
    return DriverStatisticsInclude._();
  }

  static DriverStatisticsIncludeList includeList({
    _i1.WhereExpressionBuilder<DriverStatisticsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverStatisticsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverStatisticsTable>? orderByList,
    DriverStatisticsInclude? include,
  }) {
    return DriverStatisticsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DriverStatistics.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DriverStatistics.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DriverStatisticsImpl extends DriverStatistics {
  _DriverStatisticsImpl({
    int? id,
    required int driverId,
    required String periodType,
    required DateTime periodStart,
    required DateTime periodEnd,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    double? totalRevenue,
    double? platformCommission,
    double? netRevenue,
    double? averageRating,
    int? averageResponseTime,
    int? averageCompletionTime,
    double? hoursOnline,
    double? hoursOffline,
    DateTime? createdAt,
  }) : super._(
         id: id,
         driverId: driverId,
         periodType: periodType,
         periodStart: periodStart,
         periodEnd: periodEnd,
         totalOrders: totalOrders,
         completedOrders: completedOrders,
         cancelledOrders: cancelledOrders,
         totalRevenue: totalRevenue,
         platformCommission: platformCommission,
         netRevenue: netRevenue,
         averageRating: averageRating,
         averageResponseTime: averageResponseTime,
         averageCompletionTime: averageCompletionTime,
         hoursOnline: hoursOnline,
         hoursOffline: hoursOffline,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [DriverStatistics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DriverStatistics copyWith({
    Object? id = _Undefined,
    int? driverId,
    String? periodType,
    DateTime? periodStart,
    DateTime? periodEnd,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    double? totalRevenue,
    double? platformCommission,
    double? netRevenue,
    double? averageRating,
    int? averageResponseTime,
    int? averageCompletionTime,
    double? hoursOnline,
    double? hoursOffline,
    DateTime? createdAt,
  }) {
    return DriverStatistics(
      id: id is int? ? id : this.id,
      driverId: driverId ?? this.driverId,
      periodType: periodType ?? this.periodType,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      totalOrders: totalOrders ?? this.totalOrders,
      completedOrders: completedOrders ?? this.completedOrders,
      cancelledOrders: cancelledOrders ?? this.cancelledOrders,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      platformCommission: platformCommission ?? this.platformCommission,
      netRevenue: netRevenue ?? this.netRevenue,
      averageRating: averageRating ?? this.averageRating,
      averageResponseTime: averageResponseTime ?? this.averageResponseTime,
      averageCompletionTime:
          averageCompletionTime ?? this.averageCompletionTime,
      hoursOnline: hoursOnline ?? this.hoursOnline,
      hoursOffline: hoursOffline ?? this.hoursOffline,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class DriverStatisticsUpdateTable
    extends _i1.UpdateTable<DriverStatisticsTable> {
  DriverStatisticsUpdateTable(super.table);

  _i1.ColumnValue<int, int> driverId(int value) => _i1.ColumnValue(
    table.driverId,
    value,
  );

  _i1.ColumnValue<String, String> periodType(String value) => _i1.ColumnValue(
    table.periodType,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> periodStart(DateTime value) =>
      _i1.ColumnValue(
        table.periodStart,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> periodEnd(DateTime value) =>
      _i1.ColumnValue(
        table.periodEnd,
        value,
      );

  _i1.ColumnValue<int, int> totalOrders(int value) => _i1.ColumnValue(
    table.totalOrders,
    value,
  );

  _i1.ColumnValue<int, int> completedOrders(int value) => _i1.ColumnValue(
    table.completedOrders,
    value,
  );

  _i1.ColumnValue<int, int> cancelledOrders(int value) => _i1.ColumnValue(
    table.cancelledOrders,
    value,
  );

  _i1.ColumnValue<double, double> totalRevenue(double value) => _i1.ColumnValue(
    table.totalRevenue,
    value,
  );

  _i1.ColumnValue<double, double> platformCommission(double value) =>
      _i1.ColumnValue(
        table.platformCommission,
        value,
      );

  _i1.ColumnValue<double, double> netRevenue(double value) => _i1.ColumnValue(
    table.netRevenue,
    value,
  );

  _i1.ColumnValue<double, double> averageRating(double value) =>
      _i1.ColumnValue(
        table.averageRating,
        value,
      );

  _i1.ColumnValue<int, int> averageResponseTime(int value) => _i1.ColumnValue(
    table.averageResponseTime,
    value,
  );

  _i1.ColumnValue<int, int> averageCompletionTime(int value) => _i1.ColumnValue(
    table.averageCompletionTime,
    value,
  );

  _i1.ColumnValue<double, double> hoursOnline(double value) => _i1.ColumnValue(
    table.hoursOnline,
    value,
  );

  _i1.ColumnValue<double, double> hoursOffline(double value) => _i1.ColumnValue(
    table.hoursOffline,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class DriverStatisticsTable extends _i1.Table<int?> {
  DriverStatisticsTable({super.tableRelation})
    : super(tableName: 'driver_statistics') {
    updateTable = DriverStatisticsUpdateTable(this);
    driverId = _i1.ColumnInt(
      'driverId',
      this,
    );
    periodType = _i1.ColumnString(
      'periodType',
      this,
    );
    periodStart = _i1.ColumnDateTime(
      'periodStart',
      this,
    );
    periodEnd = _i1.ColumnDateTime(
      'periodEnd',
      this,
    );
    totalOrders = _i1.ColumnInt(
      'totalOrders',
      this,
      hasDefault: true,
    );
    completedOrders = _i1.ColumnInt(
      'completedOrders',
      this,
      hasDefault: true,
    );
    cancelledOrders = _i1.ColumnInt(
      'cancelledOrders',
      this,
      hasDefault: true,
    );
    totalRevenue = _i1.ColumnDouble(
      'totalRevenue',
      this,
      hasDefault: true,
    );
    platformCommission = _i1.ColumnDouble(
      'platformCommission',
      this,
      hasDefault: true,
    );
    netRevenue = _i1.ColumnDouble(
      'netRevenue',
      this,
      hasDefault: true,
    );
    averageRating = _i1.ColumnDouble(
      'averageRating',
      this,
      hasDefault: true,
    );
    averageResponseTime = _i1.ColumnInt(
      'averageResponseTime',
      this,
      hasDefault: true,
    );
    averageCompletionTime = _i1.ColumnInt(
      'averageCompletionTime',
      this,
      hasDefault: true,
    );
    hoursOnline = _i1.ColumnDouble(
      'hoursOnline',
      this,
      hasDefault: true,
    );
    hoursOffline = _i1.ColumnDouble(
      'hoursOffline',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final DriverStatisticsUpdateTable updateTable;

  late final _i1.ColumnInt driverId;

  late final _i1.ColumnString periodType;

  late final _i1.ColumnDateTime periodStart;

  late final _i1.ColumnDateTime periodEnd;

  late final _i1.ColumnInt totalOrders;

  late final _i1.ColumnInt completedOrders;

  late final _i1.ColumnInt cancelledOrders;

  late final _i1.ColumnDouble totalRevenue;

  late final _i1.ColumnDouble platformCommission;

  late final _i1.ColumnDouble netRevenue;

  late final _i1.ColumnDouble averageRating;

  late final _i1.ColumnInt averageResponseTime;

  late final _i1.ColumnInt averageCompletionTime;

  late final _i1.ColumnDouble hoursOnline;

  late final _i1.ColumnDouble hoursOffline;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    driverId,
    periodType,
    periodStart,
    periodEnd,
    totalOrders,
    completedOrders,
    cancelledOrders,
    totalRevenue,
    platformCommission,
    netRevenue,
    averageRating,
    averageResponseTime,
    averageCompletionTime,
    hoursOnline,
    hoursOffline,
    createdAt,
  ];
}

class DriverStatisticsInclude extends _i1.IncludeObject {
  DriverStatisticsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DriverStatistics.t;
}

class DriverStatisticsIncludeList extends _i1.IncludeList {
  DriverStatisticsIncludeList._({
    _i1.WhereExpressionBuilder<DriverStatisticsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DriverStatistics.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DriverStatistics.t;
}

class DriverStatisticsRepository {
  const DriverStatisticsRepository._();

  /// Returns a list of [DriverStatistics]s matching the given query parameters.
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
  Future<List<DriverStatistics>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverStatisticsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverStatisticsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverStatisticsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<DriverStatistics>(
      where: where?.call(DriverStatistics.t),
      orderBy: orderBy?.call(DriverStatistics.t),
      orderByList: orderByList?.call(DriverStatistics.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [DriverStatistics] matching the given query parameters.
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
  Future<DriverStatistics?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverStatisticsTable>? where,
    int? offset,
    _i1.OrderByBuilder<DriverStatisticsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverStatisticsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<DriverStatistics>(
      where: where?.call(DriverStatistics.t),
      orderBy: orderBy?.call(DriverStatistics.t),
      orderByList: orderByList?.call(DriverStatistics.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [DriverStatistics] by its [id] or null if no such row exists.
  Future<DriverStatistics?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<DriverStatistics>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [DriverStatistics]s in the list and returns the inserted rows.
  ///
  /// The returned [DriverStatistics]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<DriverStatistics>> insert(
    _i1.Session session,
    List<DriverStatistics> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<DriverStatistics>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [DriverStatistics] and returns the inserted row.
  ///
  /// The returned [DriverStatistics] will have its `id` field set.
  Future<DriverStatistics> insertRow(
    _i1.Session session,
    DriverStatistics row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DriverStatistics>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DriverStatistics]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DriverStatistics>> update(
    _i1.Session session,
    List<DriverStatistics> rows, {
    _i1.ColumnSelections<DriverStatisticsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DriverStatistics>(
      rows,
      columns: columns?.call(DriverStatistics.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DriverStatistics]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DriverStatistics> updateRow(
    _i1.Session session,
    DriverStatistics row, {
    _i1.ColumnSelections<DriverStatisticsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DriverStatistics>(
      row,
      columns: columns?.call(DriverStatistics.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DriverStatistics] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DriverStatistics?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<DriverStatisticsUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DriverStatistics>(
      id,
      columnValues: columnValues(DriverStatistics.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DriverStatistics]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DriverStatistics>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DriverStatisticsUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DriverStatisticsTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverStatisticsTable>? orderBy,
    _i1.OrderByListBuilder<DriverStatisticsTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DriverStatistics>(
      columnValues: columnValues(DriverStatistics.t.updateTable),
      where: where(DriverStatistics.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DriverStatistics.t),
      orderByList: orderByList?.call(DriverStatistics.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DriverStatistics]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DriverStatistics>> delete(
    _i1.Session session,
    List<DriverStatistics> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DriverStatistics>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DriverStatistics].
  Future<DriverStatistics> deleteRow(
    _i1.Session session,
    DriverStatistics row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DriverStatistics>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DriverStatistics>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DriverStatisticsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DriverStatistics>(
      where: where(DriverStatistics.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverStatisticsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DriverStatistics>(
      where: where?.call(DriverStatistics.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
