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
import 'dispute_type_enum.dart' as _i2;
import 'dispute_status_enum.dart' as _i3;
import 'package:awhar_server/src/generated/protocol.dart' as _i4;

abstract class Dispute
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Dispute._({
    this.id,
    required this.orderId,
    required this.openedByUserId,
    required this.clientId,
    required this.driverId,
    this.disputeType,
    required this.title,
    required this.description,
    this.evidenceUrls,
    this.status,
    this.resolution,
    this.resolvedByAdminId,
    this.resolvedAt,
    this.refundAmount,
    bool? refundIssued,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : refundIssued = refundIssued ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Dispute({
    int? id,
    required int orderId,
    required int openedByUserId,
    required int clientId,
    required int driverId,
    _i2.DisputeType? disputeType,
    required String title,
    required String description,
    List<String>? evidenceUrls,
    _i3.DisputeStatus? status,
    String? resolution,
    int? resolvedByAdminId,
    DateTime? resolvedAt,
    double? refundAmount,
    bool? refundIssued,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DisputeImpl;

  factory Dispute.fromJson(Map<String, dynamic> jsonSerialization) {
    return Dispute(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      openedByUserId: jsonSerialization['openedByUserId'] as int,
      clientId: jsonSerialization['clientId'] as int,
      driverId: jsonSerialization['driverId'] as int,
      disputeType: jsonSerialization['disputeType'] == null
          ? null
          : _i2.DisputeType.fromJson((jsonSerialization['disputeType'] as int)),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      evidenceUrls: jsonSerialization['evidenceUrls'] == null
          ? null
          : _i4.Protocol().deserialize<List<String>>(
              jsonSerialization['evidenceUrls'],
            ),
      status: jsonSerialization['status'] == null
          ? null
          : _i3.DisputeStatus.fromJson((jsonSerialization['status'] as int)),
      resolution: jsonSerialization['resolution'] as String?,
      resolvedByAdminId: jsonSerialization['resolvedByAdminId'] as int?,
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
      refundAmount: (jsonSerialization['refundAmount'] as num?)?.toDouble(),
      refundIssued: jsonSerialization['refundIssued'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = DisputeTable();

  static const db = DisputeRepository._();

  @override
  int? id;

  int orderId;

  int openedByUserId;

  int clientId;

  int driverId;

  _i2.DisputeType? disputeType;

  String title;

  String description;

  List<String>? evidenceUrls;

  _i3.DisputeStatus? status;

  String? resolution;

  int? resolvedByAdminId;

  DateTime? resolvedAt;

  double? refundAmount;

  bool refundIssued;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Dispute]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Dispute copyWith({
    int? id,
    int? orderId,
    int? openedByUserId,
    int? clientId,
    int? driverId,
    _i2.DisputeType? disputeType,
    String? title,
    String? description,
    List<String>? evidenceUrls,
    _i3.DisputeStatus? status,
    String? resolution,
    int? resolvedByAdminId,
    DateTime? resolvedAt,
    double? refundAmount,
    bool? refundIssued,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Dispute',
      if (id != null) 'id': id,
      'orderId': orderId,
      'openedByUserId': openedByUserId,
      'clientId': clientId,
      'driverId': driverId,
      if (disputeType != null) 'disputeType': disputeType?.toJson(),
      'title': title,
      'description': description,
      if (evidenceUrls != null) 'evidenceUrls': evidenceUrls?.toJson(),
      if (status != null) 'status': status?.toJson(),
      if (resolution != null) 'resolution': resolution,
      if (resolvedByAdminId != null) 'resolvedByAdminId': resolvedByAdminId,
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      if (refundAmount != null) 'refundAmount': refundAmount,
      'refundIssued': refundIssued,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Dispute',
      if (id != null) 'id': id,
      'orderId': orderId,
      'openedByUserId': openedByUserId,
      'clientId': clientId,
      'driverId': driverId,
      if (disputeType != null) 'disputeType': disputeType?.toJson(),
      'title': title,
      'description': description,
      if (evidenceUrls != null) 'evidenceUrls': evidenceUrls?.toJson(),
      if (status != null) 'status': status?.toJson(),
      if (resolution != null) 'resolution': resolution,
      if (resolvedByAdminId != null) 'resolvedByAdminId': resolvedByAdminId,
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      if (refundAmount != null) 'refundAmount': refundAmount,
      'refundIssued': refundIssued,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DisputeInclude include() {
    return DisputeInclude._();
  }

  static DisputeIncludeList includeList({
    _i1.WhereExpressionBuilder<DisputeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DisputeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DisputeTable>? orderByList,
    DisputeInclude? include,
  }) {
    return DisputeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Dispute.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Dispute.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DisputeImpl extends Dispute {
  _DisputeImpl({
    int? id,
    required int orderId,
    required int openedByUserId,
    required int clientId,
    required int driverId,
    _i2.DisputeType? disputeType,
    required String title,
    required String description,
    List<String>? evidenceUrls,
    _i3.DisputeStatus? status,
    String? resolution,
    int? resolvedByAdminId,
    DateTime? resolvedAt,
    double? refundAmount,
    bool? refundIssued,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         orderId: orderId,
         openedByUserId: openedByUserId,
         clientId: clientId,
         driverId: driverId,
         disputeType: disputeType,
         title: title,
         description: description,
         evidenceUrls: evidenceUrls,
         status: status,
         resolution: resolution,
         resolvedByAdminId: resolvedByAdminId,
         resolvedAt: resolvedAt,
         refundAmount: refundAmount,
         refundIssued: refundIssued,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Dispute]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Dispute copyWith({
    Object? id = _Undefined,
    int? orderId,
    int? openedByUserId,
    int? clientId,
    int? driverId,
    Object? disputeType = _Undefined,
    String? title,
    String? description,
    Object? evidenceUrls = _Undefined,
    Object? status = _Undefined,
    Object? resolution = _Undefined,
    Object? resolvedByAdminId = _Undefined,
    Object? resolvedAt = _Undefined,
    Object? refundAmount = _Undefined,
    bool? refundIssued,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Dispute(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      openedByUserId: openedByUserId ?? this.openedByUserId,
      clientId: clientId ?? this.clientId,
      driverId: driverId ?? this.driverId,
      disputeType: disputeType is _i2.DisputeType?
          ? disputeType
          : this.disputeType,
      title: title ?? this.title,
      description: description ?? this.description,
      evidenceUrls: evidenceUrls is List<String>?
          ? evidenceUrls
          : this.evidenceUrls?.map((e0) => e0).toList(),
      status: status is _i3.DisputeStatus? ? status : this.status,
      resolution: resolution is String? ? resolution : this.resolution,
      resolvedByAdminId: resolvedByAdminId is int?
          ? resolvedByAdminId
          : this.resolvedByAdminId,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
      refundAmount: refundAmount is double? ? refundAmount : this.refundAmount,
      refundIssued: refundIssued ?? this.refundIssued,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DisputeUpdateTable extends _i1.UpdateTable<DisputeTable> {
  DisputeUpdateTable(super.table);

  _i1.ColumnValue<int, int> orderId(int value) => _i1.ColumnValue(
    table.orderId,
    value,
  );

  _i1.ColumnValue<int, int> openedByUserId(int value) => _i1.ColumnValue(
    table.openedByUserId,
    value,
  );

  _i1.ColumnValue<int, int> clientId(int value) => _i1.ColumnValue(
    table.clientId,
    value,
  );

  _i1.ColumnValue<int, int> driverId(int value) => _i1.ColumnValue(
    table.driverId,
    value,
  );

  _i1.ColumnValue<_i2.DisputeType, _i2.DisputeType> disputeType(
    _i2.DisputeType? value,
  ) => _i1.ColumnValue(
    table.disputeType,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
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

  _i1.ColumnValue<_i3.DisputeStatus, _i3.DisputeStatus> status(
    _i3.DisputeStatus? value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> resolution(String? value) => _i1.ColumnValue(
    table.resolution,
    value,
  );

  _i1.ColumnValue<int, int> resolvedByAdminId(int? value) => _i1.ColumnValue(
    table.resolvedByAdminId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> resolvedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.resolvedAt,
        value,
      );

  _i1.ColumnValue<double, double> refundAmount(double? value) =>
      _i1.ColumnValue(
        table.refundAmount,
        value,
      );

  _i1.ColumnValue<bool, bool> refundIssued(bool value) => _i1.ColumnValue(
    table.refundIssued,
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

class DisputeTable extends _i1.Table<int?> {
  DisputeTable({super.tableRelation}) : super(tableName: 'disputes') {
    updateTable = DisputeUpdateTable(this);
    orderId = _i1.ColumnInt(
      'orderId',
      this,
    );
    openedByUserId = _i1.ColumnInt(
      'openedByUserId',
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
    disputeType = _i1.ColumnEnum(
      'disputeType',
      this,
      _i1.EnumSerialization.byIndex,
    );
    title = _i1.ColumnString(
      'title',
      this,
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
    resolution = _i1.ColumnString(
      'resolution',
      this,
    );
    resolvedByAdminId = _i1.ColumnInt(
      'resolvedByAdminId',
      this,
    );
    resolvedAt = _i1.ColumnDateTime(
      'resolvedAt',
      this,
    );
    refundAmount = _i1.ColumnDouble(
      'refundAmount',
      this,
    );
    refundIssued = _i1.ColumnBool(
      'refundIssued',
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

  late final DisputeUpdateTable updateTable;

  late final _i1.ColumnInt orderId;

  late final _i1.ColumnInt openedByUserId;

  late final _i1.ColumnInt clientId;

  late final _i1.ColumnInt driverId;

  late final _i1.ColumnEnum<_i2.DisputeType> disputeType;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnSerializable<List<String>> evidenceUrls;

  late final _i1.ColumnEnum<_i3.DisputeStatus> status;

  late final _i1.ColumnString resolution;

  late final _i1.ColumnInt resolvedByAdminId;

  late final _i1.ColumnDateTime resolvedAt;

  late final _i1.ColumnDouble refundAmount;

  late final _i1.ColumnBool refundIssued;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    orderId,
    openedByUserId,
    clientId,
    driverId,
    disputeType,
    title,
    description,
    evidenceUrls,
    status,
    resolution,
    resolvedByAdminId,
    resolvedAt,
    refundAmount,
    refundIssued,
    createdAt,
    updatedAt,
  ];
}

class DisputeInclude extends _i1.IncludeObject {
  DisputeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Dispute.t;
}

class DisputeIncludeList extends _i1.IncludeList {
  DisputeIncludeList._({
    _i1.WhereExpressionBuilder<DisputeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Dispute.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Dispute.t;
}

class DisputeRepository {
  const DisputeRepository._();

  /// Returns a list of [Dispute]s matching the given query parameters.
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
  Future<List<Dispute>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DisputeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DisputeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DisputeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Dispute>(
      where: where?.call(Dispute.t),
      orderBy: orderBy?.call(Dispute.t),
      orderByList: orderByList?.call(Dispute.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Dispute] matching the given query parameters.
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
  Future<Dispute?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DisputeTable>? where,
    int? offset,
    _i1.OrderByBuilder<DisputeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DisputeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Dispute>(
      where: where?.call(Dispute.t),
      orderBy: orderBy?.call(Dispute.t),
      orderByList: orderByList?.call(Dispute.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Dispute] by its [id] or null if no such row exists.
  Future<Dispute?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Dispute>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Dispute]s in the list and returns the inserted rows.
  ///
  /// The returned [Dispute]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Dispute>> insert(
    _i1.Session session,
    List<Dispute> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Dispute>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Dispute] and returns the inserted row.
  ///
  /// The returned [Dispute] will have its `id` field set.
  Future<Dispute> insertRow(
    _i1.Session session,
    Dispute row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Dispute>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Dispute]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Dispute>> update(
    _i1.Session session,
    List<Dispute> rows, {
    _i1.ColumnSelections<DisputeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Dispute>(
      rows,
      columns: columns?.call(Dispute.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Dispute]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Dispute> updateRow(
    _i1.Session session,
    Dispute row, {
    _i1.ColumnSelections<DisputeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Dispute>(
      row,
      columns: columns?.call(Dispute.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Dispute] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Dispute?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<DisputeUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Dispute>(
      id,
      columnValues: columnValues(Dispute.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Dispute]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Dispute>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DisputeUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DisputeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DisputeTable>? orderBy,
    _i1.OrderByListBuilder<DisputeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Dispute>(
      columnValues: columnValues(Dispute.t.updateTable),
      where: where(Dispute.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Dispute.t),
      orderByList: orderByList?.call(Dispute.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Dispute]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Dispute>> delete(
    _i1.Session session,
    List<Dispute> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Dispute>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Dispute].
  Future<Dispute> deleteRow(
    _i1.Session session,
    Dispute row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Dispute>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Dispute>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DisputeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Dispute>(
      where: where(Dispute.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DisputeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Dispute>(
      where: where?.call(Dispute.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
