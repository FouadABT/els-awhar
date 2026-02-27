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
import 'reporter_type_enum.dart' as _i2;
import 'report_reason_enum.dart' as _i3;
import 'report_status_enum.dart' as _i4;
import 'report_resolution_enum.dart' as _i5;
import 'package:awhar_server/src/generated/protocol.dart' as _i6;

abstract class Report implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Report._({
    this.id,
    required this.reportedByUserId,
    this.reporterType,
    this.reportedDriverId,
    this.reportedClientId,
    this.reportedStoreId,
    this.reportedOrderId,
    this.reportedType,
    this.reportReason,
    required this.description,
    this.evidenceUrls,
    this.status,
    this.resolution,
    this.reviewedByAdminId,
    this.reviewNotes,
    this.adminNotes,
    this.reviewedAt,
    this.resolvedAt,
    this.resolvedBy,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Report({
    int? id,
    required int reportedByUserId,
    _i2.ReporterType? reporterType,
    int? reportedDriverId,
    int? reportedClientId,
    int? reportedStoreId,
    int? reportedOrderId,
    _i2.ReporterType? reportedType,
    _i3.ReportReason? reportReason,
    required String description,
    List<String>? evidenceUrls,
    _i4.ReportStatus? status,
    _i5.ReportResolution? resolution,
    int? reviewedByAdminId,
    String? reviewNotes,
    String? adminNotes,
    DateTime? reviewedAt,
    DateTime? resolvedAt,
    int? resolvedBy,
    DateTime? createdAt,
  }) = _ReportImpl;

  factory Report.fromJson(Map<String, dynamic> jsonSerialization) {
    return Report(
      id: jsonSerialization['id'] as int?,
      reportedByUserId: jsonSerialization['reportedByUserId'] as int,
      reporterType: jsonSerialization['reporterType'] == null
          ? null
          : _i2.ReporterType.fromJson(
              (jsonSerialization['reporterType'] as int),
            ),
      reportedDriverId: jsonSerialization['reportedDriverId'] as int?,
      reportedClientId: jsonSerialization['reportedClientId'] as int?,
      reportedStoreId: jsonSerialization['reportedStoreId'] as int?,
      reportedOrderId: jsonSerialization['reportedOrderId'] as int?,
      reportedType: jsonSerialization['reportedType'] == null
          ? null
          : _i2.ReporterType.fromJson(
              (jsonSerialization['reportedType'] as int),
            ),
      reportReason: jsonSerialization['reportReason'] == null
          ? null
          : _i3.ReportReason.fromJson(
              (jsonSerialization['reportReason'] as int),
            ),
      description: jsonSerialization['description'] as String,
      evidenceUrls: jsonSerialization['evidenceUrls'] == null
          ? null
          : _i6.Protocol().deserialize<List<String>>(
              jsonSerialization['evidenceUrls'],
            ),
      status: jsonSerialization['status'] == null
          ? null
          : _i4.ReportStatus.fromJson((jsonSerialization['status'] as int)),
      resolution: jsonSerialization['resolution'] == null
          ? null
          : _i5.ReportResolution.fromJson(
              (jsonSerialization['resolution'] as int),
            ),
      reviewedByAdminId: jsonSerialization['reviewedByAdminId'] as int?,
      reviewNotes: jsonSerialization['reviewNotes'] as String?,
      adminNotes: jsonSerialization['adminNotes'] as String?,
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
      resolvedBy: jsonSerialization['resolvedBy'] as int?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = ReportTable();

  static const db = ReportRepository._();

  @override
  int? id;

  int reportedByUserId;

  _i2.ReporterType? reporterType;

  int? reportedDriverId;

  int? reportedClientId;

  int? reportedStoreId;

  int? reportedOrderId;

  _i2.ReporterType? reportedType;

  _i3.ReportReason? reportReason;

  String description;

  List<String>? evidenceUrls;

  _i4.ReportStatus? status;

  _i5.ReportResolution? resolution;

  int? reviewedByAdminId;

  String? reviewNotes;

  String? adminNotes;

  DateTime? reviewedAt;

  DateTime? resolvedAt;

  int? resolvedBy;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Report]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Report copyWith({
    int? id,
    int? reportedByUserId,
    _i2.ReporterType? reporterType,
    int? reportedDriverId,
    int? reportedClientId,
    int? reportedStoreId,
    int? reportedOrderId,
    _i2.ReporterType? reportedType,
    _i3.ReportReason? reportReason,
    String? description,
    List<String>? evidenceUrls,
    _i4.ReportStatus? status,
    _i5.ReportResolution? resolution,
    int? reviewedByAdminId,
    String? reviewNotes,
    String? adminNotes,
    DateTime? reviewedAt,
    DateTime? resolvedAt,
    int? resolvedBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Report',
      if (id != null) 'id': id,
      'reportedByUserId': reportedByUserId,
      if (reporterType != null) 'reporterType': reporterType?.toJson(),
      if (reportedDriverId != null) 'reportedDriverId': reportedDriverId,
      if (reportedClientId != null) 'reportedClientId': reportedClientId,
      if (reportedStoreId != null) 'reportedStoreId': reportedStoreId,
      if (reportedOrderId != null) 'reportedOrderId': reportedOrderId,
      if (reportedType != null) 'reportedType': reportedType?.toJson(),
      if (reportReason != null) 'reportReason': reportReason?.toJson(),
      'description': description,
      if (evidenceUrls != null) 'evidenceUrls': evidenceUrls?.toJson(),
      if (status != null) 'status': status?.toJson(),
      if (resolution != null) 'resolution': resolution?.toJson(),
      if (reviewedByAdminId != null) 'reviewedByAdminId': reviewedByAdminId,
      if (reviewNotes != null) 'reviewNotes': reviewNotes,
      if (adminNotes != null) 'adminNotes': adminNotes,
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      if (resolvedBy != null) 'resolvedBy': resolvedBy,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Report',
      if (id != null) 'id': id,
      'reportedByUserId': reportedByUserId,
      if (reporterType != null) 'reporterType': reporterType?.toJson(),
      if (reportedDriverId != null) 'reportedDriverId': reportedDriverId,
      if (reportedClientId != null) 'reportedClientId': reportedClientId,
      if (reportedStoreId != null) 'reportedStoreId': reportedStoreId,
      if (reportedOrderId != null) 'reportedOrderId': reportedOrderId,
      if (reportedType != null) 'reportedType': reportedType?.toJson(),
      if (reportReason != null) 'reportReason': reportReason?.toJson(),
      'description': description,
      if (evidenceUrls != null) 'evidenceUrls': evidenceUrls?.toJson(),
      if (status != null) 'status': status?.toJson(),
      if (resolution != null) 'resolution': resolution?.toJson(),
      if (reviewedByAdminId != null) 'reviewedByAdminId': reviewedByAdminId,
      if (reviewNotes != null) 'reviewNotes': reviewNotes,
      if (adminNotes != null) 'adminNotes': adminNotes,
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      if (resolvedBy != null) 'resolvedBy': resolvedBy,
      'createdAt': createdAt.toJson(),
    };
  }

  static ReportInclude include() {
    return ReportInclude._();
  }

  static ReportIncludeList includeList({
    _i1.WhereExpressionBuilder<ReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportTable>? orderByList,
    ReportInclude? include,
  }) {
    return ReportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Report.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Report.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReportImpl extends Report {
  _ReportImpl({
    int? id,
    required int reportedByUserId,
    _i2.ReporterType? reporterType,
    int? reportedDriverId,
    int? reportedClientId,
    int? reportedStoreId,
    int? reportedOrderId,
    _i2.ReporterType? reportedType,
    _i3.ReportReason? reportReason,
    required String description,
    List<String>? evidenceUrls,
    _i4.ReportStatus? status,
    _i5.ReportResolution? resolution,
    int? reviewedByAdminId,
    String? reviewNotes,
    String? adminNotes,
    DateTime? reviewedAt,
    DateTime? resolvedAt,
    int? resolvedBy,
    DateTime? createdAt,
  }) : super._(
         id: id,
         reportedByUserId: reportedByUserId,
         reporterType: reporterType,
         reportedDriverId: reportedDriverId,
         reportedClientId: reportedClientId,
         reportedStoreId: reportedStoreId,
         reportedOrderId: reportedOrderId,
         reportedType: reportedType,
         reportReason: reportReason,
         description: description,
         evidenceUrls: evidenceUrls,
         status: status,
         resolution: resolution,
         reviewedByAdminId: reviewedByAdminId,
         reviewNotes: reviewNotes,
         adminNotes: adminNotes,
         reviewedAt: reviewedAt,
         resolvedAt: resolvedAt,
         resolvedBy: resolvedBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Report]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Report copyWith({
    Object? id = _Undefined,
    int? reportedByUserId,
    Object? reporterType = _Undefined,
    Object? reportedDriverId = _Undefined,
    Object? reportedClientId = _Undefined,
    Object? reportedStoreId = _Undefined,
    Object? reportedOrderId = _Undefined,
    Object? reportedType = _Undefined,
    Object? reportReason = _Undefined,
    String? description,
    Object? evidenceUrls = _Undefined,
    Object? status = _Undefined,
    Object? resolution = _Undefined,
    Object? reviewedByAdminId = _Undefined,
    Object? reviewNotes = _Undefined,
    Object? adminNotes = _Undefined,
    Object? reviewedAt = _Undefined,
    Object? resolvedAt = _Undefined,
    Object? resolvedBy = _Undefined,
    DateTime? createdAt,
  }) {
    return Report(
      id: id is int? ? id : this.id,
      reportedByUserId: reportedByUserId ?? this.reportedByUserId,
      reporterType: reporterType is _i2.ReporterType?
          ? reporterType
          : this.reporterType,
      reportedDriverId: reportedDriverId is int?
          ? reportedDriverId
          : this.reportedDriverId,
      reportedClientId: reportedClientId is int?
          ? reportedClientId
          : this.reportedClientId,
      reportedStoreId: reportedStoreId is int?
          ? reportedStoreId
          : this.reportedStoreId,
      reportedOrderId: reportedOrderId is int?
          ? reportedOrderId
          : this.reportedOrderId,
      reportedType: reportedType is _i2.ReporterType?
          ? reportedType
          : this.reportedType,
      reportReason: reportReason is _i3.ReportReason?
          ? reportReason
          : this.reportReason,
      description: description ?? this.description,
      evidenceUrls: evidenceUrls is List<String>?
          ? evidenceUrls
          : this.evidenceUrls?.map((e0) => e0).toList(),
      status: status is _i4.ReportStatus? ? status : this.status,
      resolution: resolution is _i5.ReportResolution?
          ? resolution
          : this.resolution,
      reviewedByAdminId: reviewedByAdminId is int?
          ? reviewedByAdminId
          : this.reviewedByAdminId,
      reviewNotes: reviewNotes is String? ? reviewNotes : this.reviewNotes,
      adminNotes: adminNotes is String? ? adminNotes : this.adminNotes,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
      resolvedBy: resolvedBy is int? ? resolvedBy : this.resolvedBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ReportUpdateTable extends _i1.UpdateTable<ReportTable> {
  ReportUpdateTable(super.table);

  _i1.ColumnValue<int, int> reportedByUserId(int value) => _i1.ColumnValue(
    table.reportedByUserId,
    value,
  );

  _i1.ColumnValue<_i2.ReporterType, _i2.ReporterType> reporterType(
    _i2.ReporterType? value,
  ) => _i1.ColumnValue(
    table.reporterType,
    value,
  );

  _i1.ColumnValue<int, int> reportedDriverId(int? value) => _i1.ColumnValue(
    table.reportedDriverId,
    value,
  );

  _i1.ColumnValue<int, int> reportedClientId(int? value) => _i1.ColumnValue(
    table.reportedClientId,
    value,
  );

  _i1.ColumnValue<int, int> reportedStoreId(int? value) => _i1.ColumnValue(
    table.reportedStoreId,
    value,
  );

  _i1.ColumnValue<int, int> reportedOrderId(int? value) => _i1.ColumnValue(
    table.reportedOrderId,
    value,
  );

  _i1.ColumnValue<_i2.ReporterType, _i2.ReporterType> reportedType(
    _i2.ReporterType? value,
  ) => _i1.ColumnValue(
    table.reportedType,
    value,
  );

  _i1.ColumnValue<_i3.ReportReason, _i3.ReportReason> reportReason(
    _i3.ReportReason? value,
  ) => _i1.ColumnValue(
    table.reportReason,
    value,
  );

  _i1.ColumnValue<String, String> description(String value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> evidenceUrls(
    List<String>? value,
  ) => _i1.ColumnValue(
    table.evidenceUrls,
    value,
  );

  _i1.ColumnValue<_i4.ReportStatus, _i4.ReportStatus> status(
    _i4.ReportStatus? value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<_i5.ReportResolution, _i5.ReportResolution> resolution(
    _i5.ReportResolution? value,
  ) => _i1.ColumnValue(
    table.resolution,
    value,
  );

  _i1.ColumnValue<int, int> reviewedByAdminId(int? value) => _i1.ColumnValue(
    table.reviewedByAdminId,
    value,
  );

  _i1.ColumnValue<String, String> reviewNotes(String? value) => _i1.ColumnValue(
    table.reviewNotes,
    value,
  );

  _i1.ColumnValue<String, String> adminNotes(String? value) => _i1.ColumnValue(
    table.adminNotes,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> reviewedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.reviewedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> resolvedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.resolvedAt,
        value,
      );

  _i1.ColumnValue<int, int> resolvedBy(int? value) => _i1.ColumnValue(
    table.resolvedBy,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class ReportTable extends _i1.Table<int?> {
  ReportTable({super.tableRelation}) : super(tableName: 'reports') {
    updateTable = ReportUpdateTable(this);
    reportedByUserId = _i1.ColumnInt(
      'reportedByUserId',
      this,
    );
    reporterType = _i1.ColumnEnum(
      'reporterType',
      this,
      _i1.EnumSerialization.byIndex,
    );
    reportedDriverId = _i1.ColumnInt(
      'reportedDriverId',
      this,
    );
    reportedClientId = _i1.ColumnInt(
      'reportedClientId',
      this,
    );
    reportedStoreId = _i1.ColumnInt(
      'reportedStoreId',
      this,
    );
    reportedOrderId = _i1.ColumnInt(
      'reportedOrderId',
      this,
    );
    reportedType = _i1.ColumnEnum(
      'reportedType',
      this,
      _i1.EnumSerialization.byIndex,
    );
    reportReason = _i1.ColumnEnum(
      'reportReason',
      this,
      _i1.EnumSerialization.byIndex,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    evidenceUrls = _i1.ColumnSerializable<List<String>>(
      'evidenceUrls',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byIndex,
    );
    resolution = _i1.ColumnEnum(
      'resolution',
      this,
      _i1.EnumSerialization.byIndex,
    );
    reviewedByAdminId = _i1.ColumnInt(
      'reviewedByAdminId',
      this,
    );
    reviewNotes = _i1.ColumnString(
      'reviewNotes',
      this,
    );
    adminNotes = _i1.ColumnString(
      'adminNotes',
      this,
    );
    reviewedAt = _i1.ColumnDateTime(
      'reviewedAt',
      this,
    );
    resolvedAt = _i1.ColumnDateTime(
      'resolvedAt',
      this,
    );
    resolvedBy = _i1.ColumnInt(
      'resolvedBy',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ReportUpdateTable updateTable;

  late final _i1.ColumnInt reportedByUserId;

  late final _i1.ColumnEnum<_i2.ReporterType> reporterType;

  late final _i1.ColumnInt reportedDriverId;

  late final _i1.ColumnInt reportedClientId;

  late final _i1.ColumnInt reportedStoreId;

  late final _i1.ColumnInt reportedOrderId;

  late final _i1.ColumnEnum<_i2.ReporterType> reportedType;

  late final _i1.ColumnEnum<_i3.ReportReason> reportReason;

  late final _i1.ColumnString description;

  late final _i1.ColumnSerializable<List<String>> evidenceUrls;

  late final _i1.ColumnEnum<_i4.ReportStatus> status;

  late final _i1.ColumnEnum<_i5.ReportResolution> resolution;

  late final _i1.ColumnInt reviewedByAdminId;

  late final _i1.ColumnString reviewNotes;

  late final _i1.ColumnString adminNotes;

  late final _i1.ColumnDateTime reviewedAt;

  late final _i1.ColumnDateTime resolvedAt;

  late final _i1.ColumnInt resolvedBy;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    reportedByUserId,
    reporterType,
    reportedDriverId,
    reportedClientId,
    reportedStoreId,
    reportedOrderId,
    reportedType,
    reportReason,
    description,
    evidenceUrls,
    status,
    resolution,
    reviewedByAdminId,
    reviewNotes,
    adminNotes,
    reviewedAt,
    resolvedAt,
    resolvedBy,
    createdAt,
  ];
}

class ReportInclude extends _i1.IncludeObject {
  ReportInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Report.t;
}

class ReportIncludeList extends _i1.IncludeList {
  ReportIncludeList._({
    _i1.WhereExpressionBuilder<ReportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Report.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Report.t;
}

class ReportRepository {
  const ReportRepository._();

  /// Returns a list of [Report]s matching the given query parameters.
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
  Future<List<Report>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Report>(
      where: where?.call(Report.t),
      orderBy: orderBy?.call(Report.t),
      orderByList: orderByList?.call(Report.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Report] matching the given query parameters.
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
  Future<Report?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReportTable>? where,
    int? offset,
    _i1.OrderByBuilder<ReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReportTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Report>(
      where: where?.call(Report.t),
      orderBy: orderBy?.call(Report.t),
      orderByList: orderByList?.call(Report.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Report] by its [id] or null if no such row exists.
  Future<Report?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Report>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Report]s in the list and returns the inserted rows.
  ///
  /// The returned [Report]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Report>> insert(
    _i1.Session session,
    List<Report> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Report>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Report] and returns the inserted row.
  ///
  /// The returned [Report] will have its `id` field set.
  Future<Report> insertRow(
    _i1.Session session,
    Report row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Report>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Report]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Report>> update(
    _i1.Session session,
    List<Report> rows, {
    _i1.ColumnSelections<ReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Report>(
      rows,
      columns: columns?.call(Report.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Report]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Report> updateRow(
    _i1.Session session,
    Report row, {
    _i1.ColumnSelections<ReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Report>(
      row,
      columns: columns?.call(Report.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Report] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Report?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ReportUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Report>(
      id,
      columnValues: columnValues(Report.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Report]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Report>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ReportUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ReportTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReportTable>? orderBy,
    _i1.OrderByListBuilder<ReportTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Report>(
      columnValues: columnValues(Report.t.updateTable),
      where: where(Report.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Report.t),
      orderByList: orderByList?.call(Report.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Report]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Report>> delete(
    _i1.Session session,
    List<Report> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Report>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Report].
  Future<Report> deleteRow(
    _i1.Session session,
    Report row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Report>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Report>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ReportTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Report>(
      where: where(Report.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReportTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Report>(
      where: where?.call(Report.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
