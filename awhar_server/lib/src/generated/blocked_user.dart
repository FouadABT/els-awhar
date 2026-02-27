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

abstract class BlockedUser
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  BlockedUser._({
    this.id,
    required this.userId,
    required this.blockedUserId,
    this.reason,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory BlockedUser({
    int? id,
    required int userId,
    required int blockedUserId,
    String? reason,
    DateTime? createdAt,
  }) = _BlockedUserImpl;

  factory BlockedUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return BlockedUser(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      blockedUserId: jsonSerialization['blockedUserId'] as int,
      reason: jsonSerialization['reason'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = BlockedUserTable();

  static const db = BlockedUserRepository._();

  @override
  int? id;

  int userId;

  int blockedUserId;

  String? reason;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [BlockedUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BlockedUser copyWith({
    int? id,
    int? userId,
    int? blockedUserId,
    String? reason,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BlockedUser',
      if (id != null) 'id': id,
      'userId': userId,
      'blockedUserId': blockedUserId,
      if (reason != null) 'reason': reason,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BlockedUser',
      if (id != null) 'id': id,
      'userId': userId,
      'blockedUserId': blockedUserId,
      if (reason != null) 'reason': reason,
      'createdAt': createdAt.toJson(),
    };
  }

  static BlockedUserInclude include() {
    return BlockedUserInclude._();
  }

  static BlockedUserIncludeList includeList({
    _i1.WhereExpressionBuilder<BlockedUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BlockedUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BlockedUserTable>? orderByList,
    BlockedUserInclude? include,
  }) {
    return BlockedUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BlockedUser.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BlockedUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BlockedUserImpl extends BlockedUser {
  _BlockedUserImpl({
    int? id,
    required int userId,
    required int blockedUserId,
    String? reason,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         blockedUserId: blockedUserId,
         reason: reason,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [BlockedUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BlockedUser copyWith({
    Object? id = _Undefined,
    int? userId,
    int? blockedUserId,
    Object? reason = _Undefined,
    DateTime? createdAt,
  }) {
    return BlockedUser(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      blockedUserId: blockedUserId ?? this.blockedUserId,
      reason: reason is String? ? reason : this.reason,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class BlockedUserUpdateTable extends _i1.UpdateTable<BlockedUserTable> {
  BlockedUserUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> blockedUserId(int value) => _i1.ColumnValue(
    table.blockedUserId,
    value,
  );

  _i1.ColumnValue<String, String> reason(String? value) => _i1.ColumnValue(
    table.reason,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class BlockedUserTable extends _i1.Table<int?> {
  BlockedUserTable({super.tableRelation}) : super(tableName: 'blocked_users') {
    updateTable = BlockedUserUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    blockedUserId = _i1.ColumnInt(
      'blockedUserId',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final BlockedUserUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt blockedUserId;

  late final _i1.ColumnString reason;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    blockedUserId,
    reason,
    createdAt,
  ];
}

class BlockedUserInclude extends _i1.IncludeObject {
  BlockedUserInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => BlockedUser.t;
}

class BlockedUserIncludeList extends _i1.IncludeList {
  BlockedUserIncludeList._({
    _i1.WhereExpressionBuilder<BlockedUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BlockedUser.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => BlockedUser.t;
}

class BlockedUserRepository {
  const BlockedUserRepository._();

  /// Returns a list of [BlockedUser]s matching the given query parameters.
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
  Future<List<BlockedUser>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BlockedUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BlockedUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BlockedUserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<BlockedUser>(
      where: where?.call(BlockedUser.t),
      orderBy: orderBy?.call(BlockedUser.t),
      orderByList: orderByList?.call(BlockedUser.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [BlockedUser] matching the given query parameters.
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
  Future<BlockedUser?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BlockedUserTable>? where,
    int? offset,
    _i1.OrderByBuilder<BlockedUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BlockedUserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<BlockedUser>(
      where: where?.call(BlockedUser.t),
      orderBy: orderBy?.call(BlockedUser.t),
      orderByList: orderByList?.call(BlockedUser.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [BlockedUser] by its [id] or null if no such row exists.
  Future<BlockedUser?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<BlockedUser>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [BlockedUser]s in the list and returns the inserted rows.
  ///
  /// The returned [BlockedUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<BlockedUser>> insert(
    _i1.Session session,
    List<BlockedUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<BlockedUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [BlockedUser] and returns the inserted row.
  ///
  /// The returned [BlockedUser] will have its `id` field set.
  Future<BlockedUser> insertRow(
    _i1.Session session,
    BlockedUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BlockedUser>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BlockedUser]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BlockedUser>> update(
    _i1.Session session,
    List<BlockedUser> rows, {
    _i1.ColumnSelections<BlockedUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BlockedUser>(
      rows,
      columns: columns?.call(BlockedUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BlockedUser]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BlockedUser> updateRow(
    _i1.Session session,
    BlockedUser row, {
    _i1.ColumnSelections<BlockedUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BlockedUser>(
      row,
      columns: columns?.call(BlockedUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BlockedUser] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BlockedUser?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<BlockedUserUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BlockedUser>(
      id,
      columnValues: columnValues(BlockedUser.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BlockedUser]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<BlockedUser>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<BlockedUserUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<BlockedUserTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BlockedUserTable>? orderBy,
    _i1.OrderByListBuilder<BlockedUserTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<BlockedUser>(
      columnValues: columnValues(BlockedUser.t.updateTable),
      where: where(BlockedUser.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BlockedUser.t),
      orderByList: orderByList?.call(BlockedUser.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [BlockedUser]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BlockedUser>> delete(
    _i1.Session session,
    List<BlockedUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BlockedUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BlockedUser].
  Future<BlockedUser> deleteRow(
    _i1.Session session,
    BlockedUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BlockedUser>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BlockedUser>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BlockedUserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BlockedUser>(
      where: where(BlockedUser.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BlockedUserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BlockedUser>(
      where: where?.call(BlockedUser.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
