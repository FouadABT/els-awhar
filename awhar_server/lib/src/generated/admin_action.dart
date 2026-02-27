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
import 'admin_action_type_enum.dart' as _i2;

abstract class AdminAction
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AdminAction._({
    this.id,
    required this.adminUserId,
    this.actionType,
    required this.targetType,
    required this.targetId,
    this.reason,
    this.notes,
    this.metadata,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AdminAction({
    int? id,
    required int adminUserId,
    _i2.AdminActionType? actionType,
    required String targetType,
    required int targetId,
    String? reason,
    String? notes,
    String? metadata,
    DateTime? createdAt,
  }) = _AdminActionImpl;

  factory AdminAction.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminAction(
      id: jsonSerialization['id'] as int?,
      adminUserId: jsonSerialization['adminUserId'] as int,
      actionType: jsonSerialization['actionType'] == null
          ? null
          : _i2.AdminActionType.fromJson(
              (jsonSerialization['actionType'] as int),
            ),
      targetType: jsonSerialization['targetType'] as String,
      targetId: jsonSerialization['targetId'] as int,
      reason: jsonSerialization['reason'] as String?,
      notes: jsonSerialization['notes'] as String?,
      metadata: jsonSerialization['metadata'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = AdminActionTable();

  static const db = AdminActionRepository._();

  @override
  int? id;

  int adminUserId;

  _i2.AdminActionType? actionType;

  String targetType;

  int targetId;

  String? reason;

  String? notes;

  String? metadata;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AdminAction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminAction copyWith({
    int? id,
    int? adminUserId,
    _i2.AdminActionType? actionType,
    String? targetType,
    int? targetId,
    String? reason,
    String? notes,
    String? metadata,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminAction',
      if (id != null) 'id': id,
      'adminUserId': adminUserId,
      if (actionType != null) 'actionType': actionType?.toJson(),
      'targetType': targetType,
      'targetId': targetId,
      if (reason != null) 'reason': reason,
      if (notes != null) 'notes': notes,
      if (metadata != null) 'metadata': metadata,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminAction',
      if (id != null) 'id': id,
      'adminUserId': adminUserId,
      if (actionType != null) 'actionType': actionType?.toJson(),
      'targetType': targetType,
      'targetId': targetId,
      if (reason != null) 'reason': reason,
      if (notes != null) 'notes': notes,
      if (metadata != null) 'metadata': metadata,
      'createdAt': createdAt.toJson(),
    };
  }

  static AdminActionInclude include() {
    return AdminActionInclude._();
  }

  static AdminActionIncludeList includeList({
    _i1.WhereExpressionBuilder<AdminActionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminActionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminActionTable>? orderByList,
    AdminActionInclude? include,
  }) {
    return AdminActionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminAction.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AdminAction.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminActionImpl extends AdminAction {
  _AdminActionImpl({
    int? id,
    required int adminUserId,
    _i2.AdminActionType? actionType,
    required String targetType,
    required int targetId,
    String? reason,
    String? notes,
    String? metadata,
    DateTime? createdAt,
  }) : super._(
         id: id,
         adminUserId: adminUserId,
         actionType: actionType,
         targetType: targetType,
         targetId: targetId,
         reason: reason,
         notes: notes,
         metadata: metadata,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AdminAction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminAction copyWith({
    Object? id = _Undefined,
    int? adminUserId,
    Object? actionType = _Undefined,
    String? targetType,
    int? targetId,
    Object? reason = _Undefined,
    Object? notes = _Undefined,
    Object? metadata = _Undefined,
    DateTime? createdAt,
  }) {
    return AdminAction(
      id: id is int? ? id : this.id,
      adminUserId: adminUserId ?? this.adminUserId,
      actionType: actionType is _i2.AdminActionType?
          ? actionType
          : this.actionType,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      reason: reason is String? ? reason : this.reason,
      notes: notes is String? ? notes : this.notes,
      metadata: metadata is String? ? metadata : this.metadata,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AdminActionUpdateTable extends _i1.UpdateTable<AdminActionTable> {
  AdminActionUpdateTable(super.table);

  _i1.ColumnValue<int, int> adminUserId(int value) => _i1.ColumnValue(
    table.adminUserId,
    value,
  );

  _i1.ColumnValue<_i2.AdminActionType, _i2.AdminActionType> actionType(
    _i2.AdminActionType? value,
  ) => _i1.ColumnValue(
    table.actionType,
    value,
  );

  _i1.ColumnValue<String, String> targetType(String value) => _i1.ColumnValue(
    table.targetType,
    value,
  );

  _i1.ColumnValue<int, int> targetId(int value) => _i1.ColumnValue(
    table.targetId,
    value,
  );

  _i1.ColumnValue<String, String> reason(String? value) => _i1.ColumnValue(
    table.reason,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );

  _i1.ColumnValue<String, String> metadata(String? value) => _i1.ColumnValue(
    table.metadata,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class AdminActionTable extends _i1.Table<int?> {
  AdminActionTable({super.tableRelation}) : super(tableName: 'admin_actions') {
    updateTable = AdminActionUpdateTable(this);
    adminUserId = _i1.ColumnInt(
      'adminUserId',
      this,
    );
    actionType = _i1.ColumnEnum(
      'actionType',
      this,
      _i1.EnumSerialization.byIndex,
    );
    targetType = _i1.ColumnString(
      'targetType',
      this,
    );
    targetId = _i1.ColumnInt(
      'targetId',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    metadata = _i1.ColumnString(
      'metadata',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final AdminActionUpdateTable updateTable;

  late final _i1.ColumnInt adminUserId;

  late final _i1.ColumnEnum<_i2.AdminActionType> actionType;

  late final _i1.ColumnString targetType;

  late final _i1.ColumnInt targetId;

  late final _i1.ColumnString reason;

  late final _i1.ColumnString notes;

  late final _i1.ColumnString metadata;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    adminUserId,
    actionType,
    targetType,
    targetId,
    reason,
    notes,
    metadata,
    createdAt,
  ];
}

class AdminActionInclude extends _i1.IncludeObject {
  AdminActionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AdminAction.t;
}

class AdminActionIncludeList extends _i1.IncludeList {
  AdminActionIncludeList._({
    _i1.WhereExpressionBuilder<AdminActionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AdminAction.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AdminAction.t;
}

class AdminActionRepository {
  const AdminActionRepository._();

  /// Returns a list of [AdminAction]s matching the given query parameters.
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
  Future<List<AdminAction>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AdminActionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminActionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminActionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<AdminAction>(
      where: where?.call(AdminAction.t),
      orderBy: orderBy?.call(AdminAction.t),
      orderByList: orderByList?.call(AdminAction.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [AdminAction] matching the given query parameters.
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
  Future<AdminAction?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AdminActionTable>? where,
    int? offset,
    _i1.OrderByBuilder<AdminActionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminActionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<AdminAction>(
      where: where?.call(AdminAction.t),
      orderBy: orderBy?.call(AdminAction.t),
      orderByList: orderByList?.call(AdminAction.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [AdminAction] by its [id] or null if no such row exists.
  Future<AdminAction?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<AdminAction>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [AdminAction]s in the list and returns the inserted rows.
  ///
  /// The returned [AdminAction]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<AdminAction>> insert(
    _i1.Session session,
    List<AdminAction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<AdminAction>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [AdminAction] and returns the inserted row.
  ///
  /// The returned [AdminAction] will have its `id` field set.
  Future<AdminAction> insertRow(
    _i1.Session session,
    AdminAction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AdminAction>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AdminAction]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AdminAction>> update(
    _i1.Session session,
    List<AdminAction> rows, {
    _i1.ColumnSelections<AdminActionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AdminAction>(
      rows,
      columns: columns?.call(AdminAction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminAction]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AdminAction> updateRow(
    _i1.Session session,
    AdminAction row, {
    _i1.ColumnSelections<AdminActionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AdminAction>(
      row,
      columns: columns?.call(AdminAction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminAction] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AdminAction?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<AdminActionUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AdminAction>(
      id,
      columnValues: columnValues(AdminAction.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AdminAction]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AdminAction>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<AdminActionUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AdminActionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminActionTable>? orderBy,
    _i1.OrderByListBuilder<AdminActionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AdminAction>(
      columnValues: columnValues(AdminAction.t.updateTable),
      where: where(AdminAction.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminAction.t),
      orderByList: orderByList?.call(AdminAction.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AdminAction]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AdminAction>> delete(
    _i1.Session session,
    List<AdminAction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AdminAction>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AdminAction].
  Future<AdminAction> deleteRow(
    _i1.Session session,
    AdminAction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AdminAction>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AdminAction>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AdminActionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AdminAction>(
      where: where(AdminAction.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AdminActionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AdminAction>(
      where: where?.call(AdminAction.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
