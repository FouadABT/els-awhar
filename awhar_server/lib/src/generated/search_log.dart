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

abstract class SearchLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SearchLog._({
    this.id,
    this.userId,
    required this.searchText,
    this.cityId,
    this.categoryId,
    int? resultsCount,
    this.clickedDriverId,
    this.sessionId,
    this.deviceType,
    DateTime? createdAt,
  }) : resultsCount = resultsCount ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory SearchLog({
    int? id,
    int? userId,
    required String searchText,
    int? cityId,
    int? categoryId,
    int? resultsCount,
    int? clickedDriverId,
    String? sessionId,
    String? deviceType,
    DateTime? createdAt,
  }) = _SearchLogImpl;

  factory SearchLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return SearchLog(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int?,
      searchText: jsonSerialization['searchText'] as String,
      cityId: jsonSerialization['cityId'] as int?,
      categoryId: jsonSerialization['categoryId'] as int?,
      resultsCount: jsonSerialization['resultsCount'] as int,
      clickedDriverId: jsonSerialization['clickedDriverId'] as int?,
      sessionId: jsonSerialization['sessionId'] as String?,
      deviceType: jsonSerialization['deviceType'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = SearchLogTable();

  static const db = SearchLogRepository._();

  @override
  int? id;

  int? userId;

  String searchText;

  int? cityId;

  int? categoryId;

  int resultsCount;

  int? clickedDriverId;

  String? sessionId;

  String? deviceType;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SearchLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SearchLog copyWith({
    int? id,
    int? userId,
    String? searchText,
    int? cityId,
    int? categoryId,
    int? resultsCount,
    int? clickedDriverId,
    String? sessionId,
    String? deviceType,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SearchLog',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      'searchText': searchText,
      if (cityId != null) 'cityId': cityId,
      if (categoryId != null) 'categoryId': categoryId,
      'resultsCount': resultsCount,
      if (clickedDriverId != null) 'clickedDriverId': clickedDriverId,
      if (sessionId != null) 'sessionId': sessionId,
      if (deviceType != null) 'deviceType': deviceType,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SearchLog',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      'searchText': searchText,
      if (cityId != null) 'cityId': cityId,
      if (categoryId != null) 'categoryId': categoryId,
      'resultsCount': resultsCount,
      if (clickedDriverId != null) 'clickedDriverId': clickedDriverId,
      if (sessionId != null) 'sessionId': sessionId,
      if (deviceType != null) 'deviceType': deviceType,
      'createdAt': createdAt.toJson(),
    };
  }

  static SearchLogInclude include() {
    return SearchLogInclude._();
  }

  static SearchLogIncludeList includeList({
    _i1.WhereExpressionBuilder<SearchLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SearchLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SearchLogTable>? orderByList,
    SearchLogInclude? include,
  }) {
    return SearchLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SearchLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SearchLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SearchLogImpl extends SearchLog {
  _SearchLogImpl({
    int? id,
    int? userId,
    required String searchText,
    int? cityId,
    int? categoryId,
    int? resultsCount,
    int? clickedDriverId,
    String? sessionId,
    String? deviceType,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         searchText: searchText,
         cityId: cityId,
         categoryId: categoryId,
         resultsCount: resultsCount,
         clickedDriverId: clickedDriverId,
         sessionId: sessionId,
         deviceType: deviceType,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SearchLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SearchLog copyWith({
    Object? id = _Undefined,
    Object? userId = _Undefined,
    String? searchText,
    Object? cityId = _Undefined,
    Object? categoryId = _Undefined,
    int? resultsCount,
    Object? clickedDriverId = _Undefined,
    Object? sessionId = _Undefined,
    Object? deviceType = _Undefined,
    DateTime? createdAt,
  }) {
    return SearchLog(
      id: id is int? ? id : this.id,
      userId: userId is int? ? userId : this.userId,
      searchText: searchText ?? this.searchText,
      cityId: cityId is int? ? cityId : this.cityId,
      categoryId: categoryId is int? ? categoryId : this.categoryId,
      resultsCount: resultsCount ?? this.resultsCount,
      clickedDriverId: clickedDriverId is int?
          ? clickedDriverId
          : this.clickedDriverId,
      sessionId: sessionId is String? ? sessionId : this.sessionId,
      deviceType: deviceType is String? ? deviceType : this.deviceType,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class SearchLogUpdateTable extends _i1.UpdateTable<SearchLogTable> {
  SearchLogUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int? value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> searchText(String value) => _i1.ColumnValue(
    table.searchText,
    value,
  );

  _i1.ColumnValue<int, int> cityId(int? value) => _i1.ColumnValue(
    table.cityId,
    value,
  );

  _i1.ColumnValue<int, int> categoryId(int? value) => _i1.ColumnValue(
    table.categoryId,
    value,
  );

  _i1.ColumnValue<int, int> resultsCount(int value) => _i1.ColumnValue(
    table.resultsCount,
    value,
  );

  _i1.ColumnValue<int, int> clickedDriverId(int? value) => _i1.ColumnValue(
    table.clickedDriverId,
    value,
  );

  _i1.ColumnValue<String, String> sessionId(String? value) => _i1.ColumnValue(
    table.sessionId,
    value,
  );

  _i1.ColumnValue<String, String> deviceType(String? value) => _i1.ColumnValue(
    table.deviceType,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class SearchLogTable extends _i1.Table<int?> {
  SearchLogTable({super.tableRelation}) : super(tableName: 'search_logs') {
    updateTable = SearchLogUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    searchText = _i1.ColumnString(
      'searchText',
      this,
    );
    cityId = _i1.ColumnInt(
      'cityId',
      this,
    );
    categoryId = _i1.ColumnInt(
      'categoryId',
      this,
    );
    resultsCount = _i1.ColumnInt(
      'resultsCount',
      this,
      hasDefault: true,
    );
    clickedDriverId = _i1.ColumnInt(
      'clickedDriverId',
      this,
    );
    sessionId = _i1.ColumnString(
      'sessionId',
      this,
    );
    deviceType = _i1.ColumnString(
      'deviceType',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final SearchLogUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString searchText;

  late final _i1.ColumnInt cityId;

  late final _i1.ColumnInt categoryId;

  late final _i1.ColumnInt resultsCount;

  late final _i1.ColumnInt clickedDriverId;

  late final _i1.ColumnString sessionId;

  late final _i1.ColumnString deviceType;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    searchText,
    cityId,
    categoryId,
    resultsCount,
    clickedDriverId,
    sessionId,
    deviceType,
    createdAt,
  ];
}

class SearchLogInclude extends _i1.IncludeObject {
  SearchLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SearchLog.t;
}

class SearchLogIncludeList extends _i1.IncludeList {
  SearchLogIncludeList._({
    _i1.WhereExpressionBuilder<SearchLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SearchLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SearchLog.t;
}

class SearchLogRepository {
  const SearchLogRepository._();

  /// Returns a list of [SearchLog]s matching the given query parameters.
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
  Future<List<SearchLog>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SearchLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SearchLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SearchLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SearchLog>(
      where: where?.call(SearchLog.t),
      orderBy: orderBy?.call(SearchLog.t),
      orderByList: orderByList?.call(SearchLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SearchLog] matching the given query parameters.
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
  Future<SearchLog?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SearchLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<SearchLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SearchLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SearchLog>(
      where: where?.call(SearchLog.t),
      orderBy: orderBy?.call(SearchLog.t),
      orderByList: orderByList?.call(SearchLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SearchLog] by its [id] or null if no such row exists.
  Future<SearchLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SearchLog>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SearchLog]s in the list and returns the inserted rows.
  ///
  /// The returned [SearchLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SearchLog>> insert(
    _i1.Session session,
    List<SearchLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SearchLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SearchLog] and returns the inserted row.
  ///
  /// The returned [SearchLog] will have its `id` field set.
  Future<SearchLog> insertRow(
    _i1.Session session,
    SearchLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SearchLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SearchLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SearchLog>> update(
    _i1.Session session,
    List<SearchLog> rows, {
    _i1.ColumnSelections<SearchLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SearchLog>(
      rows,
      columns: columns?.call(SearchLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SearchLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SearchLog> updateRow(
    _i1.Session session,
    SearchLog row, {
    _i1.ColumnSelections<SearchLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SearchLog>(
      row,
      columns: columns?.call(SearchLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SearchLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SearchLog?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<SearchLogUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SearchLog>(
      id,
      columnValues: columnValues(SearchLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SearchLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SearchLog>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SearchLogUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SearchLogTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SearchLogTable>? orderBy,
    _i1.OrderByListBuilder<SearchLogTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SearchLog>(
      columnValues: columnValues(SearchLog.t.updateTable),
      where: where(SearchLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SearchLog.t),
      orderByList: orderByList?.call(SearchLog.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SearchLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SearchLog>> delete(
    _i1.Session session,
    List<SearchLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SearchLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SearchLog].
  Future<SearchLog> deleteRow(
    _i1.Session session,
    SearchLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SearchLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SearchLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SearchLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SearchLog>(
      where: where(SearchLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SearchLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SearchLog>(
      where: where?.call(SearchLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
