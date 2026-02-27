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

abstract class PlatformStatistics
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PlatformStatistics._({
    this.id,
    required this.periodType,
    required this.periodStart,
    required this.periodEnd,
    int? totalUsers,
    int? newUsers,
    int? activeUsers,
    int? totalDrivers,
    int? newDrivers,
    int? activeDrivers,
    int? verifiedDrivers,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    int? disputedOrders,
    double? totalRevenue,
    double? platformRevenue,
    double? subscriptionRevenue,
    double? averageOrdersPerUser,
    double? averageOrderValue,
    DateTime? createdAt,
  }) : totalUsers = totalUsers ?? 0,
       newUsers = newUsers ?? 0,
       activeUsers = activeUsers ?? 0,
       totalDrivers = totalDrivers ?? 0,
       newDrivers = newDrivers ?? 0,
       activeDrivers = activeDrivers ?? 0,
       verifiedDrivers = verifiedDrivers ?? 0,
       totalOrders = totalOrders ?? 0,
       completedOrders = completedOrders ?? 0,
       cancelledOrders = cancelledOrders ?? 0,
       disputedOrders = disputedOrders ?? 0,
       totalRevenue = totalRevenue ?? 0.0,
       platformRevenue = platformRevenue ?? 0.0,
       subscriptionRevenue = subscriptionRevenue ?? 0.0,
       averageOrdersPerUser = averageOrdersPerUser ?? 0.0,
       averageOrderValue = averageOrderValue ?? 0.0,
       createdAt = createdAt ?? DateTime.now();

  factory PlatformStatistics({
    int? id,
    required String periodType,
    required DateTime periodStart,
    required DateTime periodEnd,
    int? totalUsers,
    int? newUsers,
    int? activeUsers,
    int? totalDrivers,
    int? newDrivers,
    int? activeDrivers,
    int? verifiedDrivers,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    int? disputedOrders,
    double? totalRevenue,
    double? platformRevenue,
    double? subscriptionRevenue,
    double? averageOrdersPerUser,
    double? averageOrderValue,
    DateTime? createdAt,
  }) = _PlatformStatisticsImpl;

  factory PlatformStatistics.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlatformStatistics(
      id: jsonSerialization['id'] as int?,
      periodType: jsonSerialization['periodType'] as String,
      periodStart: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['periodStart'],
      ),
      periodEnd: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['periodEnd'],
      ),
      totalUsers: jsonSerialization['totalUsers'] as int,
      newUsers: jsonSerialization['newUsers'] as int,
      activeUsers: jsonSerialization['activeUsers'] as int,
      totalDrivers: jsonSerialization['totalDrivers'] as int,
      newDrivers: jsonSerialization['newDrivers'] as int,
      activeDrivers: jsonSerialization['activeDrivers'] as int,
      verifiedDrivers: jsonSerialization['verifiedDrivers'] as int,
      totalOrders: jsonSerialization['totalOrders'] as int,
      completedOrders: jsonSerialization['completedOrders'] as int,
      cancelledOrders: jsonSerialization['cancelledOrders'] as int,
      disputedOrders: jsonSerialization['disputedOrders'] as int,
      totalRevenue: (jsonSerialization['totalRevenue'] as num).toDouble(),
      platformRevenue: (jsonSerialization['platformRevenue'] as num).toDouble(),
      subscriptionRevenue: (jsonSerialization['subscriptionRevenue'] as num)
          .toDouble(),
      averageOrdersPerUser: (jsonSerialization['averageOrdersPerUser'] as num)
          .toDouble(),
      averageOrderValue: (jsonSerialization['averageOrderValue'] as num)
          .toDouble(),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = PlatformStatisticsTable();

  static const db = PlatformStatisticsRepository._();

  @override
  int? id;

  String periodType;

  DateTime periodStart;

  DateTime periodEnd;

  int totalUsers;

  int newUsers;

  int activeUsers;

  int totalDrivers;

  int newDrivers;

  int activeDrivers;

  int verifiedDrivers;

  int totalOrders;

  int completedOrders;

  int cancelledOrders;

  int disputedOrders;

  double totalRevenue;

  double platformRevenue;

  double subscriptionRevenue;

  double averageOrdersPerUser;

  double averageOrderValue;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PlatformStatistics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlatformStatistics copyWith({
    int? id,
    String? periodType,
    DateTime? periodStart,
    DateTime? periodEnd,
    int? totalUsers,
    int? newUsers,
    int? activeUsers,
    int? totalDrivers,
    int? newDrivers,
    int? activeDrivers,
    int? verifiedDrivers,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    int? disputedOrders,
    double? totalRevenue,
    double? platformRevenue,
    double? subscriptionRevenue,
    double? averageOrdersPerUser,
    double? averageOrderValue,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlatformStatistics',
      if (id != null) 'id': id,
      'periodType': periodType,
      'periodStart': periodStart.toJson(),
      'periodEnd': periodEnd.toJson(),
      'totalUsers': totalUsers,
      'newUsers': newUsers,
      'activeUsers': activeUsers,
      'totalDrivers': totalDrivers,
      'newDrivers': newDrivers,
      'activeDrivers': activeDrivers,
      'verifiedDrivers': verifiedDrivers,
      'totalOrders': totalOrders,
      'completedOrders': completedOrders,
      'cancelledOrders': cancelledOrders,
      'disputedOrders': disputedOrders,
      'totalRevenue': totalRevenue,
      'platformRevenue': platformRevenue,
      'subscriptionRevenue': subscriptionRevenue,
      'averageOrdersPerUser': averageOrdersPerUser,
      'averageOrderValue': averageOrderValue,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlatformStatistics',
      if (id != null) 'id': id,
      'periodType': periodType,
      'periodStart': periodStart.toJson(),
      'periodEnd': periodEnd.toJson(),
      'totalUsers': totalUsers,
      'newUsers': newUsers,
      'activeUsers': activeUsers,
      'totalDrivers': totalDrivers,
      'newDrivers': newDrivers,
      'activeDrivers': activeDrivers,
      'verifiedDrivers': verifiedDrivers,
      'totalOrders': totalOrders,
      'completedOrders': completedOrders,
      'cancelledOrders': cancelledOrders,
      'disputedOrders': disputedOrders,
      'totalRevenue': totalRevenue,
      'platformRevenue': platformRevenue,
      'subscriptionRevenue': subscriptionRevenue,
      'averageOrdersPerUser': averageOrdersPerUser,
      'averageOrderValue': averageOrderValue,
      'createdAt': createdAt.toJson(),
    };
  }

  static PlatformStatisticsInclude include() {
    return PlatformStatisticsInclude._();
  }

  static PlatformStatisticsIncludeList includeList({
    _i1.WhereExpressionBuilder<PlatformStatisticsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlatformStatisticsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlatformStatisticsTable>? orderByList,
    PlatformStatisticsInclude? include,
  }) {
    return PlatformStatisticsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlatformStatistics.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PlatformStatistics.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlatformStatisticsImpl extends PlatformStatistics {
  _PlatformStatisticsImpl({
    int? id,
    required String periodType,
    required DateTime periodStart,
    required DateTime periodEnd,
    int? totalUsers,
    int? newUsers,
    int? activeUsers,
    int? totalDrivers,
    int? newDrivers,
    int? activeDrivers,
    int? verifiedDrivers,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    int? disputedOrders,
    double? totalRevenue,
    double? platformRevenue,
    double? subscriptionRevenue,
    double? averageOrdersPerUser,
    double? averageOrderValue,
    DateTime? createdAt,
  }) : super._(
         id: id,
         periodType: periodType,
         periodStart: periodStart,
         periodEnd: periodEnd,
         totalUsers: totalUsers,
         newUsers: newUsers,
         activeUsers: activeUsers,
         totalDrivers: totalDrivers,
         newDrivers: newDrivers,
         activeDrivers: activeDrivers,
         verifiedDrivers: verifiedDrivers,
         totalOrders: totalOrders,
         completedOrders: completedOrders,
         cancelledOrders: cancelledOrders,
         disputedOrders: disputedOrders,
         totalRevenue: totalRevenue,
         platformRevenue: platformRevenue,
         subscriptionRevenue: subscriptionRevenue,
         averageOrdersPerUser: averageOrdersPerUser,
         averageOrderValue: averageOrderValue,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PlatformStatistics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlatformStatistics copyWith({
    Object? id = _Undefined,
    String? periodType,
    DateTime? periodStart,
    DateTime? periodEnd,
    int? totalUsers,
    int? newUsers,
    int? activeUsers,
    int? totalDrivers,
    int? newDrivers,
    int? activeDrivers,
    int? verifiedDrivers,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    int? disputedOrders,
    double? totalRevenue,
    double? platformRevenue,
    double? subscriptionRevenue,
    double? averageOrdersPerUser,
    double? averageOrderValue,
    DateTime? createdAt,
  }) {
    return PlatformStatistics(
      id: id is int? ? id : this.id,
      periodType: periodType ?? this.periodType,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      totalUsers: totalUsers ?? this.totalUsers,
      newUsers: newUsers ?? this.newUsers,
      activeUsers: activeUsers ?? this.activeUsers,
      totalDrivers: totalDrivers ?? this.totalDrivers,
      newDrivers: newDrivers ?? this.newDrivers,
      activeDrivers: activeDrivers ?? this.activeDrivers,
      verifiedDrivers: verifiedDrivers ?? this.verifiedDrivers,
      totalOrders: totalOrders ?? this.totalOrders,
      completedOrders: completedOrders ?? this.completedOrders,
      cancelledOrders: cancelledOrders ?? this.cancelledOrders,
      disputedOrders: disputedOrders ?? this.disputedOrders,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      platformRevenue: platformRevenue ?? this.platformRevenue,
      subscriptionRevenue: subscriptionRevenue ?? this.subscriptionRevenue,
      averageOrdersPerUser: averageOrdersPerUser ?? this.averageOrdersPerUser,
      averageOrderValue: averageOrderValue ?? this.averageOrderValue,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PlatformStatisticsUpdateTable
    extends _i1.UpdateTable<PlatformStatisticsTable> {
  PlatformStatisticsUpdateTable(super.table);

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

  _i1.ColumnValue<int, int> totalUsers(int value) => _i1.ColumnValue(
    table.totalUsers,
    value,
  );

  _i1.ColumnValue<int, int> newUsers(int value) => _i1.ColumnValue(
    table.newUsers,
    value,
  );

  _i1.ColumnValue<int, int> activeUsers(int value) => _i1.ColumnValue(
    table.activeUsers,
    value,
  );

  _i1.ColumnValue<int, int> totalDrivers(int value) => _i1.ColumnValue(
    table.totalDrivers,
    value,
  );

  _i1.ColumnValue<int, int> newDrivers(int value) => _i1.ColumnValue(
    table.newDrivers,
    value,
  );

  _i1.ColumnValue<int, int> activeDrivers(int value) => _i1.ColumnValue(
    table.activeDrivers,
    value,
  );

  _i1.ColumnValue<int, int> verifiedDrivers(int value) => _i1.ColumnValue(
    table.verifiedDrivers,
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

  _i1.ColumnValue<int, int> disputedOrders(int value) => _i1.ColumnValue(
    table.disputedOrders,
    value,
  );

  _i1.ColumnValue<double, double> totalRevenue(double value) => _i1.ColumnValue(
    table.totalRevenue,
    value,
  );

  _i1.ColumnValue<double, double> platformRevenue(double value) =>
      _i1.ColumnValue(
        table.platformRevenue,
        value,
      );

  _i1.ColumnValue<double, double> subscriptionRevenue(double value) =>
      _i1.ColumnValue(
        table.subscriptionRevenue,
        value,
      );

  _i1.ColumnValue<double, double> averageOrdersPerUser(double value) =>
      _i1.ColumnValue(
        table.averageOrdersPerUser,
        value,
      );

  _i1.ColumnValue<double, double> averageOrderValue(double value) =>
      _i1.ColumnValue(
        table.averageOrderValue,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class PlatformStatisticsTable extends _i1.Table<int?> {
  PlatformStatisticsTable({super.tableRelation})
    : super(tableName: 'platform_statistics') {
    updateTable = PlatformStatisticsUpdateTable(this);
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
    totalUsers = _i1.ColumnInt(
      'totalUsers',
      this,
      hasDefault: true,
    );
    newUsers = _i1.ColumnInt(
      'newUsers',
      this,
      hasDefault: true,
    );
    activeUsers = _i1.ColumnInt(
      'activeUsers',
      this,
      hasDefault: true,
    );
    totalDrivers = _i1.ColumnInt(
      'totalDrivers',
      this,
      hasDefault: true,
    );
    newDrivers = _i1.ColumnInt(
      'newDrivers',
      this,
      hasDefault: true,
    );
    activeDrivers = _i1.ColumnInt(
      'activeDrivers',
      this,
      hasDefault: true,
    );
    verifiedDrivers = _i1.ColumnInt(
      'verifiedDrivers',
      this,
      hasDefault: true,
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
    disputedOrders = _i1.ColumnInt(
      'disputedOrders',
      this,
      hasDefault: true,
    );
    totalRevenue = _i1.ColumnDouble(
      'totalRevenue',
      this,
      hasDefault: true,
    );
    platformRevenue = _i1.ColumnDouble(
      'platformRevenue',
      this,
      hasDefault: true,
    );
    subscriptionRevenue = _i1.ColumnDouble(
      'subscriptionRevenue',
      this,
      hasDefault: true,
    );
    averageOrdersPerUser = _i1.ColumnDouble(
      'averageOrdersPerUser',
      this,
      hasDefault: true,
    );
    averageOrderValue = _i1.ColumnDouble(
      'averageOrderValue',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final PlatformStatisticsUpdateTable updateTable;

  late final _i1.ColumnString periodType;

  late final _i1.ColumnDateTime periodStart;

  late final _i1.ColumnDateTime periodEnd;

  late final _i1.ColumnInt totalUsers;

  late final _i1.ColumnInt newUsers;

  late final _i1.ColumnInt activeUsers;

  late final _i1.ColumnInt totalDrivers;

  late final _i1.ColumnInt newDrivers;

  late final _i1.ColumnInt activeDrivers;

  late final _i1.ColumnInt verifiedDrivers;

  late final _i1.ColumnInt totalOrders;

  late final _i1.ColumnInt completedOrders;

  late final _i1.ColumnInt cancelledOrders;

  late final _i1.ColumnInt disputedOrders;

  late final _i1.ColumnDouble totalRevenue;

  late final _i1.ColumnDouble platformRevenue;

  late final _i1.ColumnDouble subscriptionRevenue;

  late final _i1.ColumnDouble averageOrdersPerUser;

  late final _i1.ColumnDouble averageOrderValue;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    periodType,
    periodStart,
    periodEnd,
    totalUsers,
    newUsers,
    activeUsers,
    totalDrivers,
    newDrivers,
    activeDrivers,
    verifiedDrivers,
    totalOrders,
    completedOrders,
    cancelledOrders,
    disputedOrders,
    totalRevenue,
    platformRevenue,
    subscriptionRevenue,
    averageOrdersPerUser,
    averageOrderValue,
    createdAt,
  ];
}

class PlatformStatisticsInclude extends _i1.IncludeObject {
  PlatformStatisticsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => PlatformStatistics.t;
}

class PlatformStatisticsIncludeList extends _i1.IncludeList {
  PlatformStatisticsIncludeList._({
    _i1.WhereExpressionBuilder<PlatformStatisticsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PlatformStatistics.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PlatformStatistics.t;
}

class PlatformStatisticsRepository {
  const PlatformStatisticsRepository._();

  /// Returns a list of [PlatformStatistics]s matching the given query parameters.
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
  Future<List<PlatformStatistics>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlatformStatisticsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlatformStatisticsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlatformStatisticsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<PlatformStatistics>(
      where: where?.call(PlatformStatistics.t),
      orderBy: orderBy?.call(PlatformStatistics.t),
      orderByList: orderByList?.call(PlatformStatistics.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [PlatformStatistics] matching the given query parameters.
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
  Future<PlatformStatistics?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlatformStatisticsTable>? where,
    int? offset,
    _i1.OrderByBuilder<PlatformStatisticsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlatformStatisticsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<PlatformStatistics>(
      where: where?.call(PlatformStatistics.t),
      orderBy: orderBy?.call(PlatformStatistics.t),
      orderByList: orderByList?.call(PlatformStatistics.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [PlatformStatistics] by its [id] or null if no such row exists.
  Future<PlatformStatistics?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<PlatformStatistics>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [PlatformStatistics]s in the list and returns the inserted rows.
  ///
  /// The returned [PlatformStatistics]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PlatformStatistics>> insert(
    _i1.Session session,
    List<PlatformStatistics> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PlatformStatistics>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PlatformStatistics] and returns the inserted row.
  ///
  /// The returned [PlatformStatistics] will have its `id` field set.
  Future<PlatformStatistics> insertRow(
    _i1.Session session,
    PlatformStatistics row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PlatformStatistics>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PlatformStatistics]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PlatformStatistics>> update(
    _i1.Session session,
    List<PlatformStatistics> rows, {
    _i1.ColumnSelections<PlatformStatisticsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PlatformStatistics>(
      rows,
      columns: columns?.call(PlatformStatistics.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlatformStatistics]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PlatformStatistics> updateRow(
    _i1.Session session,
    PlatformStatistics row, {
    _i1.ColumnSelections<PlatformStatisticsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PlatformStatistics>(
      row,
      columns: columns?.call(PlatformStatistics.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlatformStatistics] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PlatformStatistics?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<PlatformStatisticsUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PlatformStatistics>(
      id,
      columnValues: columnValues(PlatformStatistics.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PlatformStatistics]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PlatformStatistics>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<PlatformStatisticsUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<PlatformStatisticsTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlatformStatisticsTable>? orderBy,
    _i1.OrderByListBuilder<PlatformStatisticsTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PlatformStatistics>(
      columnValues: columnValues(PlatformStatistics.t.updateTable),
      where: where(PlatformStatistics.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlatformStatistics.t),
      orderByList: orderByList?.call(PlatformStatistics.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PlatformStatistics]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PlatformStatistics>> delete(
    _i1.Session session,
    List<PlatformStatistics> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PlatformStatistics>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PlatformStatistics].
  Future<PlatformStatistics> deleteRow(
    _i1.Session session,
    PlatformStatistics row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PlatformStatistics>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PlatformStatistics>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PlatformStatisticsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PlatformStatistics>(
      where: where(PlatformStatistics.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlatformStatisticsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PlatformStatistics>(
      where: where?.call(PlatformStatistics.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
