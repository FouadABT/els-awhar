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

abstract class UserClient
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserClient._({
    this.id,
    required this.userId,
    this.defaultAddressId,
    this.defaultCityId,
    int? totalOrders,
    DateTime? createdAt,
  }) : totalOrders = totalOrders ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory UserClient({
    int? id,
    required int userId,
    int? defaultAddressId,
    int? defaultCityId,
    int? totalOrders,
    DateTime? createdAt,
  }) = _UserClientImpl;

  factory UserClient.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserClient(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      defaultAddressId: jsonSerialization['defaultAddressId'] as int?,
      defaultCityId: jsonSerialization['defaultCityId'] as int?,
      totalOrders: jsonSerialization['totalOrders'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = UserClientTable();

  static const db = UserClientRepository._();

  @override
  int? id;

  int userId;

  int? defaultAddressId;

  int? defaultCityId;

  int totalOrders;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserClient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserClient copyWith({
    int? id,
    int? userId,
    int? defaultAddressId,
    int? defaultCityId,
    int? totalOrders,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserClient',
      if (id != null) 'id': id,
      'userId': userId,
      if (defaultAddressId != null) 'defaultAddressId': defaultAddressId,
      if (defaultCityId != null) 'defaultCityId': defaultCityId,
      'totalOrders': totalOrders,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserClient',
      if (id != null) 'id': id,
      'userId': userId,
      if (defaultAddressId != null) 'defaultAddressId': defaultAddressId,
      if (defaultCityId != null) 'defaultCityId': defaultCityId,
      'totalOrders': totalOrders,
      'createdAt': createdAt.toJson(),
    };
  }

  static UserClientInclude include() {
    return UserClientInclude._();
  }

  static UserClientIncludeList includeList({
    _i1.WhereExpressionBuilder<UserClientTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserClientTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserClientTable>? orderByList,
    UserClientInclude? include,
  }) {
    return UserClientIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserClient.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserClient.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserClientImpl extends UserClient {
  _UserClientImpl({
    int? id,
    required int userId,
    int? defaultAddressId,
    int? defaultCityId,
    int? totalOrders,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         defaultAddressId: defaultAddressId,
         defaultCityId: defaultCityId,
         totalOrders: totalOrders,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UserClient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserClient copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? defaultAddressId = _Undefined,
    Object? defaultCityId = _Undefined,
    int? totalOrders,
    DateTime? createdAt,
  }) {
    return UserClient(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      defaultAddressId: defaultAddressId is int?
          ? defaultAddressId
          : this.defaultAddressId,
      defaultCityId: defaultCityId is int? ? defaultCityId : this.defaultCityId,
      totalOrders: totalOrders ?? this.totalOrders,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class UserClientUpdateTable extends _i1.UpdateTable<UserClientTable> {
  UserClientUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> defaultAddressId(int? value) => _i1.ColumnValue(
    table.defaultAddressId,
    value,
  );

  _i1.ColumnValue<int, int> defaultCityId(int? value) => _i1.ColumnValue(
    table.defaultCityId,
    value,
  );

  _i1.ColumnValue<int, int> totalOrders(int value) => _i1.ColumnValue(
    table.totalOrders,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class UserClientTable extends _i1.Table<int?> {
  UserClientTable({super.tableRelation}) : super(tableName: 'user_clients') {
    updateTable = UserClientUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    defaultAddressId = _i1.ColumnInt(
      'defaultAddressId',
      this,
    );
    defaultCityId = _i1.ColumnInt(
      'defaultCityId',
      this,
    );
    totalOrders = _i1.ColumnInt(
      'totalOrders',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final UserClientUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt defaultAddressId;

  late final _i1.ColumnInt defaultCityId;

  late final _i1.ColumnInt totalOrders;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    defaultAddressId,
    defaultCityId,
    totalOrders,
    createdAt,
  ];
}

class UserClientInclude extends _i1.IncludeObject {
  UserClientInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserClient.t;
}

class UserClientIncludeList extends _i1.IncludeList {
  UserClientIncludeList._({
    _i1.WhereExpressionBuilder<UserClientTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserClient.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserClient.t;
}

class UserClientRepository {
  const UserClientRepository._();

  /// Returns a list of [UserClient]s matching the given query parameters.
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
  Future<List<UserClient>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserClientTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserClientTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserClientTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UserClient>(
      where: where?.call(UserClient.t),
      orderBy: orderBy?.call(UserClient.t),
      orderByList: orderByList?.call(UserClient.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [UserClient] matching the given query parameters.
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
  Future<UserClient?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserClientTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserClientTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserClientTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<UserClient>(
      where: where?.call(UserClient.t),
      orderBy: orderBy?.call(UserClient.t),
      orderByList: orderByList?.call(UserClient.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [UserClient] by its [id] or null if no such row exists.
  Future<UserClient?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<UserClient>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [UserClient]s in the list and returns the inserted rows.
  ///
  /// The returned [UserClient]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserClient>> insert(
    _i1.Session session,
    List<UserClient> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserClient>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserClient] and returns the inserted row.
  ///
  /// The returned [UserClient] will have its `id` field set.
  Future<UserClient> insertRow(
    _i1.Session session,
    UserClient row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserClient>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserClient]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserClient>> update(
    _i1.Session session,
    List<UserClient> rows, {
    _i1.ColumnSelections<UserClientTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserClient>(
      rows,
      columns: columns?.call(UserClient.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserClient]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserClient> updateRow(
    _i1.Session session,
    UserClient row, {
    _i1.ColumnSelections<UserClientTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserClient>(
      row,
      columns: columns?.call(UserClient.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserClient] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserClient?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<UserClientUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserClient>(
      id,
      columnValues: columnValues(UserClient.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserClient]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserClient>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<UserClientUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserClientTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserClientTable>? orderBy,
    _i1.OrderByListBuilder<UserClientTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserClient>(
      columnValues: columnValues(UserClient.t.updateTable),
      where: where(UserClient.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserClient.t),
      orderByList: orderByList?.call(UserClient.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserClient]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserClient>> delete(
    _i1.Session session,
    List<UserClient> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserClient>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserClient].
  Future<UserClient> deleteRow(
    _i1.Session session,
    UserClient row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserClient>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserClient>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserClientTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserClient>(
      where: where(UserClient.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserClientTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserClient>(
      where: where?.call(UserClient.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
