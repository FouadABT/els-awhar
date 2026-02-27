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

abstract class StoreReport
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StoreReport._({
    this.id,
    this.storeOrderId,
    required this.reporterId,
    required this.reporterType,
    required this.reportedType,
    required this.reportedId,
    required this.reason,
    required this.description,
    this.evidenceUrls,
    String? status,
    this.resolution,
    this.resolvedBy,
    this.resolvedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : status = status ?? 'pending',
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory StoreReport({
    int? id,
    int? storeOrderId,
    required int reporterId,
    required String reporterType,
    required String reportedType,
    required int reportedId,
    required String reason,
    required String description,
    String? evidenceUrls,
    String? status,
    String? resolution,
    int? resolvedBy,
    DateTime? resolvedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StoreReportImpl;

  factory StoreReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreReport(
      id: jsonSerialization['id'] as int?,
      storeOrderId: jsonSerialization['storeOrderId'] as int?,
      reporterId: jsonSerialization['reporterId'] as int,
      reporterType: jsonSerialization['reporterType'] as String,
      reportedType: jsonSerialization['reportedType'] as String,
      reportedId: jsonSerialization['reportedId'] as int,
      reason: jsonSerialization['reason'] as String,
      description: jsonSerialization['description'] as String,
      evidenceUrls: jsonSerialization['evidenceUrls'] as String?,
      status: jsonSerialization['status'] as String,
      resolution: jsonSerialization['resolution'] as String?,
      resolvedBy: jsonSerialization['resolvedBy'] as int?,
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = StoreReportTable();

  static const db = StoreReportRepository._();

  @override
  int? id;

  int? storeOrderId;

  int reporterId;

  String reporterType;

  String reportedType;

  int reportedId;

  String reason;

  String description;

  String? evidenceUrls;

  String status;

  String? resolution;

  int? resolvedBy;

  DateTime? resolvedAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StoreReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreReport copyWith({
    int? id,
    int? storeOrderId,
    int? reporterId,
    String? reporterType,
    String? reportedType,
    int? reportedId,
    String? reason,
    String? description,
    String? evidenceUrls,
    String? status,
    String? resolution,
    int? resolvedBy,
    DateTime? resolvedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreReport',
      if (id != null) 'id': id,
      if (storeOrderId != null) 'storeOrderId': storeOrderId,
      'reporterId': reporterId,
      'reporterType': reporterType,
      'reportedType': reportedType,
      'reportedId': reportedId,
      'reason': reason,
      'description': description,
      if (evidenceUrls != null) 'evidenceUrls': evidenceUrls,
      'status': status,
      if (resolution != null) 'resolution': resolution,
      if (resolvedBy != null) 'resolvedBy': resolvedBy,
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StoreReport',
      if (id != null) 'id': id,
      if (storeOrderId != null) 'storeOrderId': storeOrderId,
      'reporterId': reporterId,
      'reporterType': reporterType,
      'reportedType': reportedType,
      'reportedId': reportedId,
      'reason': reason,
      'description': description,
      if (evidenceUrls != null) 'evidenceUrls': evidenceUrls,
      'status': status,
      if (resolution != null) 'resolution': resolution,
      if (resolvedBy != null) 'resolvedBy': resolvedBy,
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static StoreReportInclude include() {
    return StoreReportInclude._();
  }

  static StoreReportIncludeList includeList({
    _i1.WhereExpressionBuilder<StoreReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreReportTable>? orderByList,
    StoreReportInclude? include,
  }) {
    return StoreReportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreReport.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StoreReport.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreReportImpl extends StoreReport {
  _StoreReportImpl({
    int? id,
    int? storeOrderId,
    required int reporterId,
    required String reporterType,
    required String reportedType,
    required int reportedId,
    required String reason,
    required String description,
    String? evidenceUrls,
    String? status,
    String? resolution,
    int? resolvedBy,
    DateTime? resolvedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         storeOrderId: storeOrderId,
         reporterId: reporterId,
         reporterType: reporterType,
         reportedType: reportedType,
         reportedId: reportedId,
         reason: reason,
         description: description,
         evidenceUrls: evidenceUrls,
         status: status,
         resolution: resolution,
         resolvedBy: resolvedBy,
         resolvedAt: resolvedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StoreReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreReport copyWith({
    Object? id = _Undefined,
    Object? storeOrderId = _Undefined,
    int? reporterId,
    String? reporterType,
    String? reportedType,
    int? reportedId,
    String? reason,
    String? description,
    Object? evidenceUrls = _Undefined,
    String? status,
    Object? resolution = _Undefined,
    Object? resolvedBy = _Undefined,
    Object? resolvedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StoreReport(
      id: id is int? ? id : this.id,
      storeOrderId: storeOrderId is int? ? storeOrderId : this.storeOrderId,
      reporterId: reporterId ?? this.reporterId,
      reporterType: reporterType ?? this.reporterType,
      reportedType: reportedType ?? this.reportedType,
      reportedId: reportedId ?? this.reportedId,
      reason: reason ?? this.reason,
      description: description ?? this.description,
      evidenceUrls: evidenceUrls is String? ? evidenceUrls : this.evidenceUrls,
      status: status ?? this.status,
      resolution: resolution is String? ? resolution : this.resolution,
      resolvedBy: resolvedBy is int? ? resolvedBy : this.resolvedBy,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class StoreReportUpdateTable extends _i1.UpdateTable<StoreReportTable> {
  StoreReportUpdateTable(super.table);

  _i1.ColumnValue<int, int> storeOrderId(int? value) => _i1.ColumnValue(
    table.storeOrderId,
    value,
  );

  _i1.ColumnValue<int, int> reporterId(int value) => _i1.ColumnValue(
    table.reporterId,
    value,
  );

  _i1.ColumnValue<String, String> reporterType(String value) => _i1.ColumnValue(
    table.reporterType,
    value,
  );

  _i1.ColumnValue<String, String> reportedType(String value) => _i1.ColumnValue(
    table.reportedType,
    value,
  );

  _i1.ColumnValue<int, int> reportedId(int value) => _i1.ColumnValue(
    table.reportedId,
    value,
  );

  _i1.ColumnValue<String, String> reason(String value) => _i1.ColumnValue(
    table.reason,
    value,
  );

  _i1.ColumnValue<String, String> description(String value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> evidenceUrls(String? value) =>
      _i1.ColumnValue(
        table.evidenceUrls,
        value,
      );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> resolution(String? value) => _i1.ColumnValue(
    table.resolution,
    value,
  );

  _i1.ColumnValue<int, int> resolvedBy(int? value) => _i1.ColumnValue(
    table.resolvedBy,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> resolvedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.resolvedAt,
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

class StoreReportTable extends _i1.Table<int?> {
  StoreReportTable({super.tableRelation}) : super(tableName: 'store_reports') {
    updateTable = StoreReportUpdateTable(this);
    storeOrderId = _i1.ColumnInt(
      'storeOrderId',
      this,
    );
    reporterId = _i1.ColumnInt(
      'reporterId',
      this,
    );
    reporterType = _i1.ColumnString(
      'reporterType',
      this,
    );
    reportedType = _i1.ColumnString(
      'reportedType',
      this,
    );
    reportedId = _i1.ColumnInt(
      'reportedId',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    evidenceUrls = _i1.ColumnString(
      'evidenceUrls',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    resolution = _i1.ColumnString(
      'resolution',
      this,
    );
    resolvedBy = _i1.ColumnInt(
      'resolvedBy',
      this,
    );
    resolvedAt = _i1.ColumnDateTime(
      'resolvedAt',
      this,
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

  late final StoreReportUpdateTable updateTable;

  late final _i1.ColumnInt storeOrderId;

  late final _i1.ColumnInt reporterId;

  late final _i1.ColumnString reporterType;

  late final _i1.ColumnString reportedType;

  late final _i1.ColumnInt reportedId;

  late final _i1.ColumnString reason;

  late final _i1.ColumnString description;

  late final _i1.ColumnString evidenceUrls;

  late final _i1.ColumnString status;

  late final _i1.ColumnString resolution;

  late final _i1.ColumnInt resolvedBy;

  late final _i1.ColumnDateTime resolvedAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    storeOrderId,
    reporterId,
    reporterType,
    reportedType,
    reportedId,
    reason,
    description,
    evidenceUrls,
    status,
    resolution,
    resolvedBy,
    resolvedAt,
    createdAt,
    updatedAt,
  ];
}

class StoreReportInclude extends _i1.IncludeObject {
  StoreReportInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StoreReport.t;
}

class StoreReportIncludeList extends _i1.IncludeList {
  StoreReportIncludeList._({
    _i1.WhereExpressionBuilder<StoreReportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreReport.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StoreReport.t;
}

class StoreReportRepository {
  const StoreReportRepository._();

  /// Returns a list of [StoreReport]s matching the given query parameters.
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
  Future<List<StoreReport>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreReportTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<StoreReport>(
      where: where?.call(StoreReport.t),
      orderBy: orderBy?.call(StoreReport.t),
      orderByList: orderByList?.call(StoreReport.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [StoreReport] matching the given query parameters.
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
  Future<StoreReport?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreReportTable>? where,
    int? offset,
    _i1.OrderByBuilder<StoreReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreReportTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<StoreReport>(
      where: where?.call(StoreReport.t),
      orderBy: orderBy?.call(StoreReport.t),
      orderByList: orderByList?.call(StoreReport.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [StoreReport] by its [id] or null if no such row exists.
  Future<StoreReport?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<StoreReport>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [StoreReport]s in the list and returns the inserted rows.
  ///
  /// The returned [StoreReport]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StoreReport>> insert(
    _i1.Session session,
    List<StoreReport> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StoreReport>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StoreReport] and returns the inserted row.
  ///
  /// The returned [StoreReport] will have its `id` field set.
  Future<StoreReport> insertRow(
    _i1.Session session,
    StoreReport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreReport>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StoreReport]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StoreReport>> update(
    _i1.Session session,
    List<StoreReport> rows, {
    _i1.ColumnSelections<StoreReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StoreReport>(
      rows,
      columns: columns?.call(StoreReport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreReport]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StoreReport> updateRow(
    _i1.Session session,
    StoreReport row, {
    _i1.ColumnSelections<StoreReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoreReport>(
      row,
      columns: columns?.call(StoreReport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreReport] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StoreReport?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<StoreReportUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StoreReport>(
      id,
      columnValues: columnValues(StoreReport.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StoreReport]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StoreReport>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<StoreReportUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StoreReportTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreReportTable>? orderBy,
    _i1.OrderByListBuilder<StoreReportTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StoreReport>(
      columnValues: columnValues(StoreReport.t.updateTable),
      where: where(StoreReport.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreReport.t),
      orderByList: orderByList?.call(StoreReport.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StoreReport]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StoreReport>> delete(
    _i1.Session session,
    List<StoreReport> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StoreReport>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StoreReport].
  Future<StoreReport> deleteRow(
    _i1.Session session,
    StoreReport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreReport>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StoreReport>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StoreReportTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StoreReport>(
      where: where(StoreReport.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreReportTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StoreReport>(
      where: where?.call(StoreReport.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
