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

abstract class Favorite
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Favorite._({
    this.id,
    required this.clientId,
    required this.driverId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Favorite({
    int? id,
    required int clientId,
    required int driverId,
    DateTime? createdAt,
  }) = _FavoriteImpl;

  factory Favorite.fromJson(Map<String, dynamic> jsonSerialization) {
    return Favorite(
      id: jsonSerialization['id'] as int?,
      clientId: jsonSerialization['clientId'] as int,
      driverId: jsonSerialization['driverId'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = FavoriteTable();

  static const db = FavoriteRepository._();

  @override
  int? id;

  int clientId;

  int driverId;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Favorite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Favorite copyWith({
    int? id,
    int? clientId,
    int? driverId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Favorite',
      if (id != null) 'id': id,
      'clientId': clientId,
      'driverId': driverId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Favorite',
      if (id != null) 'id': id,
      'clientId': clientId,
      'driverId': driverId,
      'createdAt': createdAt.toJson(),
    };
  }

  static FavoriteInclude include() {
    return FavoriteInclude._();
  }

  static FavoriteIncludeList includeList({
    _i1.WhereExpressionBuilder<FavoriteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FavoriteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FavoriteTable>? orderByList,
    FavoriteInclude? include,
  }) {
    return FavoriteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Favorite.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Favorite.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FavoriteImpl extends Favorite {
  _FavoriteImpl({
    int? id,
    required int clientId,
    required int driverId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         clientId: clientId,
         driverId: driverId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Favorite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Favorite copyWith({
    Object? id = _Undefined,
    int? clientId,
    int? driverId,
    DateTime? createdAt,
  }) {
    return Favorite(
      id: id is int? ? id : this.id,
      clientId: clientId ?? this.clientId,
      driverId: driverId ?? this.driverId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class FavoriteUpdateTable extends _i1.UpdateTable<FavoriteTable> {
  FavoriteUpdateTable(super.table);

  _i1.ColumnValue<int, int> clientId(int value) => _i1.ColumnValue(
    table.clientId,
    value,
  );

  _i1.ColumnValue<int, int> driverId(int value) => _i1.ColumnValue(
    table.driverId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class FavoriteTable extends _i1.Table<int?> {
  FavoriteTable({super.tableRelation}) : super(tableName: 'favorites') {
    updateTable = FavoriteUpdateTable(this);
    clientId = _i1.ColumnInt(
      'clientId',
      this,
    );
    driverId = _i1.ColumnInt(
      'driverId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final FavoriteUpdateTable updateTable;

  late final _i1.ColumnInt clientId;

  late final _i1.ColumnInt driverId;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    clientId,
    driverId,
    createdAt,
  ];
}

class FavoriteInclude extends _i1.IncludeObject {
  FavoriteInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Favorite.t;
}

class FavoriteIncludeList extends _i1.IncludeList {
  FavoriteIncludeList._({
    _i1.WhereExpressionBuilder<FavoriteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Favorite.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Favorite.t;
}

class FavoriteRepository {
  const FavoriteRepository._();

  /// Returns a list of [Favorite]s matching the given query parameters.
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
  Future<List<Favorite>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FavoriteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FavoriteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FavoriteTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Favorite>(
      where: where?.call(Favorite.t),
      orderBy: orderBy?.call(Favorite.t),
      orderByList: orderByList?.call(Favorite.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Favorite] matching the given query parameters.
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
  Future<Favorite?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FavoriteTable>? where,
    int? offset,
    _i1.OrderByBuilder<FavoriteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FavoriteTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Favorite>(
      where: where?.call(Favorite.t),
      orderBy: orderBy?.call(Favorite.t),
      orderByList: orderByList?.call(Favorite.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Favorite] by its [id] or null if no such row exists.
  Future<Favorite?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Favorite>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Favorite]s in the list and returns the inserted rows.
  ///
  /// The returned [Favorite]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Favorite>> insert(
    _i1.Session session,
    List<Favorite> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Favorite>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Favorite] and returns the inserted row.
  ///
  /// The returned [Favorite] will have its `id` field set.
  Future<Favorite> insertRow(
    _i1.Session session,
    Favorite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Favorite>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Favorite]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Favorite>> update(
    _i1.Session session,
    List<Favorite> rows, {
    _i1.ColumnSelections<FavoriteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Favorite>(
      rows,
      columns: columns?.call(Favorite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Favorite]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Favorite> updateRow(
    _i1.Session session,
    Favorite row, {
    _i1.ColumnSelections<FavoriteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Favorite>(
      row,
      columns: columns?.call(Favorite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Favorite] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Favorite?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<FavoriteUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Favorite>(
      id,
      columnValues: columnValues(Favorite.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Favorite]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Favorite>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<FavoriteUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FavoriteTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FavoriteTable>? orderBy,
    _i1.OrderByListBuilder<FavoriteTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Favorite>(
      columnValues: columnValues(Favorite.t.updateTable),
      where: where(Favorite.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Favorite.t),
      orderByList: orderByList?.call(Favorite.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Favorite]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Favorite>> delete(
    _i1.Session session,
    List<Favorite> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Favorite>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Favorite].
  Future<Favorite> deleteRow(
    _i1.Session session,
    Favorite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Favorite>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Favorite>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FavoriteTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Favorite>(
      where: where(Favorite.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FavoriteTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Favorite>(
      where: where?.call(Favorite.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
