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

abstract class ServiceAnalytics
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ServiceAnalytics._({
    this.id,
    required this.driverServiceId,
    int? totalViews,
    int? uniqueViews,
    this.lastViewedAt,
    int? totalInquiries,
    int? totalBookings,
    double? conversionRate,
    int? averageResponseTime,
    double? completionRate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : totalViews = totalViews ?? 0,
       uniqueViews = uniqueViews ?? 0,
       totalInquiries = totalInquiries ?? 0,
       totalBookings = totalBookings ?? 0,
       conversionRate = conversionRate ?? 0.0,
       averageResponseTime = averageResponseTime ?? 0,
       completionRate = completionRate ?? 0.0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory ServiceAnalytics({
    int? id,
    required int driverServiceId,
    int? totalViews,
    int? uniqueViews,
    DateTime? lastViewedAt,
    int? totalInquiries,
    int? totalBookings,
    double? conversionRate,
    int? averageResponseTime,
    double? completionRate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ServiceAnalyticsImpl;

  factory ServiceAnalytics.fromJson(Map<String, dynamic> jsonSerialization) {
    return ServiceAnalytics(
      id: jsonSerialization['id'] as int?,
      driverServiceId: jsonSerialization['driverServiceId'] as int,
      totalViews: jsonSerialization['totalViews'] as int,
      uniqueViews: jsonSerialization['uniqueViews'] as int,
      lastViewedAt: jsonSerialization['lastViewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastViewedAt'],
            ),
      totalInquiries: jsonSerialization['totalInquiries'] as int,
      totalBookings: jsonSerialization['totalBookings'] as int,
      conversionRate: (jsonSerialization['conversionRate'] as num).toDouble(),
      averageResponseTime: jsonSerialization['averageResponseTime'] as int,
      completionRate: (jsonSerialization['completionRate'] as num).toDouble(),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ServiceAnalyticsTable();

  static const db = ServiceAnalyticsRepository._();

  @override
  int? id;

  int driverServiceId;

  int totalViews;

  int uniqueViews;

  DateTime? lastViewedAt;

  int totalInquiries;

  int totalBookings;

  double conversionRate;

  int averageResponseTime;

  double completionRate;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ServiceAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ServiceAnalytics copyWith({
    int? id,
    int? driverServiceId,
    int? totalViews,
    int? uniqueViews,
    DateTime? lastViewedAt,
    int? totalInquiries,
    int? totalBookings,
    double? conversionRate,
    int? averageResponseTime,
    double? completionRate,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ServiceAnalytics',
      if (id != null) 'id': id,
      'driverServiceId': driverServiceId,
      'totalViews': totalViews,
      'uniqueViews': uniqueViews,
      if (lastViewedAt != null) 'lastViewedAt': lastViewedAt?.toJson(),
      'totalInquiries': totalInquiries,
      'totalBookings': totalBookings,
      'conversionRate': conversionRate,
      'averageResponseTime': averageResponseTime,
      'completionRate': completionRate,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ServiceAnalytics',
      if (id != null) 'id': id,
      'driverServiceId': driverServiceId,
      'totalViews': totalViews,
      'uniqueViews': uniqueViews,
      if (lastViewedAt != null) 'lastViewedAt': lastViewedAt?.toJson(),
      'totalInquiries': totalInquiries,
      'totalBookings': totalBookings,
      'conversionRate': conversionRate,
      'averageResponseTime': averageResponseTime,
      'completionRate': completionRate,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ServiceAnalyticsInclude include() {
    return ServiceAnalyticsInclude._();
  }

  static ServiceAnalyticsIncludeList includeList({
    _i1.WhereExpressionBuilder<ServiceAnalyticsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ServiceAnalyticsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ServiceAnalyticsTable>? orderByList,
    ServiceAnalyticsInclude? include,
  }) {
    return ServiceAnalyticsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ServiceAnalytics.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ServiceAnalytics.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ServiceAnalyticsImpl extends ServiceAnalytics {
  _ServiceAnalyticsImpl({
    int? id,
    required int driverServiceId,
    int? totalViews,
    int? uniqueViews,
    DateTime? lastViewedAt,
    int? totalInquiries,
    int? totalBookings,
    double? conversionRate,
    int? averageResponseTime,
    double? completionRate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         driverServiceId: driverServiceId,
         totalViews: totalViews,
         uniqueViews: uniqueViews,
         lastViewedAt: lastViewedAt,
         totalInquiries: totalInquiries,
         totalBookings: totalBookings,
         conversionRate: conversionRate,
         averageResponseTime: averageResponseTime,
         completionRate: completionRate,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ServiceAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ServiceAnalytics copyWith({
    Object? id = _Undefined,
    int? driverServiceId,
    int? totalViews,
    int? uniqueViews,
    Object? lastViewedAt = _Undefined,
    int? totalInquiries,
    int? totalBookings,
    double? conversionRate,
    int? averageResponseTime,
    double? completionRate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ServiceAnalytics(
      id: id is int? ? id : this.id,
      driverServiceId: driverServiceId ?? this.driverServiceId,
      totalViews: totalViews ?? this.totalViews,
      uniqueViews: uniqueViews ?? this.uniqueViews,
      lastViewedAt: lastViewedAt is DateTime?
          ? lastViewedAt
          : this.lastViewedAt,
      totalInquiries: totalInquiries ?? this.totalInquiries,
      totalBookings: totalBookings ?? this.totalBookings,
      conversionRate: conversionRate ?? this.conversionRate,
      averageResponseTime: averageResponseTime ?? this.averageResponseTime,
      completionRate: completionRate ?? this.completionRate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ServiceAnalyticsUpdateTable
    extends _i1.UpdateTable<ServiceAnalyticsTable> {
  ServiceAnalyticsUpdateTable(super.table);

  _i1.ColumnValue<int, int> driverServiceId(int value) => _i1.ColumnValue(
    table.driverServiceId,
    value,
  );

  _i1.ColumnValue<int, int> totalViews(int value) => _i1.ColumnValue(
    table.totalViews,
    value,
  );

  _i1.ColumnValue<int, int> uniqueViews(int value) => _i1.ColumnValue(
    table.uniqueViews,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastViewedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastViewedAt,
        value,
      );

  _i1.ColumnValue<int, int> totalInquiries(int value) => _i1.ColumnValue(
    table.totalInquiries,
    value,
  );

  _i1.ColumnValue<int, int> totalBookings(int value) => _i1.ColumnValue(
    table.totalBookings,
    value,
  );

  _i1.ColumnValue<double, double> conversionRate(double value) =>
      _i1.ColumnValue(
        table.conversionRate,
        value,
      );

  _i1.ColumnValue<int, int> averageResponseTime(int value) => _i1.ColumnValue(
    table.averageResponseTime,
    value,
  );

  _i1.ColumnValue<double, double> completionRate(double value) =>
      _i1.ColumnValue(
        table.completionRate,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ServiceAnalyticsTable extends _i1.Table<int?> {
  ServiceAnalyticsTable({super.tableRelation})
    : super(tableName: 'service_analytics') {
    updateTable = ServiceAnalyticsUpdateTable(this);
    driverServiceId = _i1.ColumnInt(
      'driverServiceId',
      this,
    );
    totalViews = _i1.ColumnInt(
      'totalViews',
      this,
      hasDefault: true,
    );
    uniqueViews = _i1.ColumnInt(
      'uniqueViews',
      this,
      hasDefault: true,
    );
    lastViewedAt = _i1.ColumnDateTime(
      'lastViewedAt',
      this,
    );
    totalInquiries = _i1.ColumnInt(
      'totalInquiries',
      this,
      hasDefault: true,
    );
    totalBookings = _i1.ColumnInt(
      'totalBookings',
      this,
      hasDefault: true,
    );
    conversionRate = _i1.ColumnDouble(
      'conversionRate',
      this,
      hasDefault: true,
    );
    averageResponseTime = _i1.ColumnInt(
      'averageResponseTime',
      this,
      hasDefault: true,
    );
    completionRate = _i1.ColumnDouble(
      'completionRate',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final ServiceAnalyticsUpdateTable updateTable;

  late final _i1.ColumnInt driverServiceId;

  late final _i1.ColumnInt totalViews;

  late final _i1.ColumnInt uniqueViews;

  late final _i1.ColumnDateTime lastViewedAt;

  late final _i1.ColumnInt totalInquiries;

  late final _i1.ColumnInt totalBookings;

  late final _i1.ColumnDouble conversionRate;

  late final _i1.ColumnInt averageResponseTime;

  late final _i1.ColumnDouble completionRate;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    driverServiceId,
    totalViews,
    uniqueViews,
    lastViewedAt,
    totalInquiries,
    totalBookings,
    conversionRate,
    averageResponseTime,
    completionRate,
    createdAt,
    updatedAt,
  ];
}

class ServiceAnalyticsInclude extends _i1.IncludeObject {
  ServiceAnalyticsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ServiceAnalytics.t;
}

class ServiceAnalyticsIncludeList extends _i1.IncludeList {
  ServiceAnalyticsIncludeList._({
    _i1.WhereExpressionBuilder<ServiceAnalyticsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ServiceAnalytics.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ServiceAnalytics.t;
}

class ServiceAnalyticsRepository {
  const ServiceAnalyticsRepository._();

  /// Returns a list of [ServiceAnalytics]s matching the given query parameters.
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
  Future<List<ServiceAnalytics>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ServiceAnalyticsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ServiceAnalyticsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ServiceAnalyticsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ServiceAnalytics>(
      where: where?.call(ServiceAnalytics.t),
      orderBy: orderBy?.call(ServiceAnalytics.t),
      orderByList: orderByList?.call(ServiceAnalytics.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ServiceAnalytics] matching the given query parameters.
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
  Future<ServiceAnalytics?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ServiceAnalyticsTable>? where,
    int? offset,
    _i1.OrderByBuilder<ServiceAnalyticsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ServiceAnalyticsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ServiceAnalytics>(
      where: where?.call(ServiceAnalytics.t),
      orderBy: orderBy?.call(ServiceAnalytics.t),
      orderByList: orderByList?.call(ServiceAnalytics.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ServiceAnalytics] by its [id] or null if no such row exists.
  Future<ServiceAnalytics?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ServiceAnalytics>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ServiceAnalytics]s in the list and returns the inserted rows.
  ///
  /// The returned [ServiceAnalytics]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ServiceAnalytics>> insert(
    _i1.Session session,
    List<ServiceAnalytics> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ServiceAnalytics>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ServiceAnalytics] and returns the inserted row.
  ///
  /// The returned [ServiceAnalytics] will have its `id` field set.
  Future<ServiceAnalytics> insertRow(
    _i1.Session session,
    ServiceAnalytics row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ServiceAnalytics>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ServiceAnalytics]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ServiceAnalytics>> update(
    _i1.Session session,
    List<ServiceAnalytics> rows, {
    _i1.ColumnSelections<ServiceAnalyticsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ServiceAnalytics>(
      rows,
      columns: columns?.call(ServiceAnalytics.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ServiceAnalytics]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ServiceAnalytics> updateRow(
    _i1.Session session,
    ServiceAnalytics row, {
    _i1.ColumnSelections<ServiceAnalyticsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ServiceAnalytics>(
      row,
      columns: columns?.call(ServiceAnalytics.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ServiceAnalytics] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ServiceAnalytics?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ServiceAnalyticsUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ServiceAnalytics>(
      id,
      columnValues: columnValues(ServiceAnalytics.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ServiceAnalytics]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ServiceAnalytics>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ServiceAnalyticsUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ServiceAnalyticsTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ServiceAnalyticsTable>? orderBy,
    _i1.OrderByListBuilder<ServiceAnalyticsTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ServiceAnalytics>(
      columnValues: columnValues(ServiceAnalytics.t.updateTable),
      where: where(ServiceAnalytics.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ServiceAnalytics.t),
      orderByList: orderByList?.call(ServiceAnalytics.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ServiceAnalytics]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ServiceAnalytics>> delete(
    _i1.Session session,
    List<ServiceAnalytics> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ServiceAnalytics>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ServiceAnalytics].
  Future<ServiceAnalytics> deleteRow(
    _i1.Session session,
    ServiceAnalytics row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ServiceAnalytics>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ServiceAnalytics>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ServiceAnalyticsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ServiceAnalytics>(
      where: where(ServiceAnalytics.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ServiceAnalyticsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ServiceAnalytics>(
      where: where?.call(ServiceAnalytics.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
