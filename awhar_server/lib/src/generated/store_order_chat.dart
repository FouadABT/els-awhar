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

abstract class StoreOrderChat
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StoreOrderChat._({
    this.id,
    required this.storeOrderId,
    required this.clientId,
    required this.storeId,
    this.driverId,
    this.firebaseChannelId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isActive = isActive ?? true,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory StoreOrderChat({
    int? id,
    required int storeOrderId,
    required int clientId,
    required int storeId,
    int? driverId,
    String? firebaseChannelId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StoreOrderChatImpl;

  factory StoreOrderChat.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreOrderChat(
      id: jsonSerialization['id'] as int?,
      storeOrderId: jsonSerialization['storeOrderId'] as int,
      clientId: jsonSerialization['clientId'] as int,
      storeId: jsonSerialization['storeId'] as int,
      driverId: jsonSerialization['driverId'] as int?,
      firebaseChannelId: jsonSerialization['firebaseChannelId'] as String?,
      isActive: jsonSerialization['isActive'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = StoreOrderChatTable();

  static const db = StoreOrderChatRepository._();

  @override
  int? id;

  int storeOrderId;

  int clientId;

  int storeId;

  int? driverId;

  String? firebaseChannelId;

  bool isActive;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StoreOrderChat]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreOrderChat copyWith({
    int? id,
    int? storeOrderId,
    int? clientId,
    int? storeId,
    int? driverId,
    String? firebaseChannelId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreOrderChat',
      if (id != null) 'id': id,
      'storeOrderId': storeOrderId,
      'clientId': clientId,
      'storeId': storeId,
      if (driverId != null) 'driverId': driverId,
      if (firebaseChannelId != null) 'firebaseChannelId': firebaseChannelId,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StoreOrderChat',
      if (id != null) 'id': id,
      'storeOrderId': storeOrderId,
      'clientId': clientId,
      'storeId': storeId,
      if (driverId != null) 'driverId': driverId,
      if (firebaseChannelId != null) 'firebaseChannelId': firebaseChannelId,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static StoreOrderChatInclude include() {
    return StoreOrderChatInclude._();
  }

  static StoreOrderChatIncludeList includeList({
    _i1.WhereExpressionBuilder<StoreOrderChatTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreOrderChatTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreOrderChatTable>? orderByList,
    StoreOrderChatInclude? include,
  }) {
    return StoreOrderChatIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreOrderChat.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StoreOrderChat.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreOrderChatImpl extends StoreOrderChat {
  _StoreOrderChatImpl({
    int? id,
    required int storeOrderId,
    required int clientId,
    required int storeId,
    int? driverId,
    String? firebaseChannelId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         storeOrderId: storeOrderId,
         clientId: clientId,
         storeId: storeId,
         driverId: driverId,
         firebaseChannelId: firebaseChannelId,
         isActive: isActive,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StoreOrderChat]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreOrderChat copyWith({
    Object? id = _Undefined,
    int? storeOrderId,
    int? clientId,
    int? storeId,
    Object? driverId = _Undefined,
    Object? firebaseChannelId = _Undefined,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StoreOrderChat(
      id: id is int? ? id : this.id,
      storeOrderId: storeOrderId ?? this.storeOrderId,
      clientId: clientId ?? this.clientId,
      storeId: storeId ?? this.storeId,
      driverId: driverId is int? ? driverId : this.driverId,
      firebaseChannelId: firebaseChannelId is String?
          ? firebaseChannelId
          : this.firebaseChannelId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class StoreOrderChatUpdateTable extends _i1.UpdateTable<StoreOrderChatTable> {
  StoreOrderChatUpdateTable(super.table);

  _i1.ColumnValue<int, int> storeOrderId(int value) => _i1.ColumnValue(
    table.storeOrderId,
    value,
  );

  _i1.ColumnValue<int, int> clientId(int value) => _i1.ColumnValue(
    table.clientId,
    value,
  );

  _i1.ColumnValue<int, int> storeId(int value) => _i1.ColumnValue(
    table.storeId,
    value,
  );

  _i1.ColumnValue<int, int> driverId(int? value) => _i1.ColumnValue(
    table.driverId,
    value,
  );

  _i1.ColumnValue<String, String> firebaseChannelId(String? value) =>
      _i1.ColumnValue(
        table.firebaseChannelId,
        value,
      );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
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

class StoreOrderChatTable extends _i1.Table<int?> {
  StoreOrderChatTable({super.tableRelation})
    : super(tableName: 'store_order_chats') {
    updateTable = StoreOrderChatUpdateTable(this);
    storeOrderId = _i1.ColumnInt(
      'storeOrderId',
      this,
    );
    clientId = _i1.ColumnInt(
      'clientId',
      this,
    );
    storeId = _i1.ColumnInt(
      'storeId',
      this,
    );
    driverId = _i1.ColumnInt(
      'driverId',
      this,
    );
    firebaseChannelId = _i1.ColumnString(
      'firebaseChannelId',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
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

  late final StoreOrderChatUpdateTable updateTable;

  late final _i1.ColumnInt storeOrderId;

  late final _i1.ColumnInt clientId;

  late final _i1.ColumnInt storeId;

  late final _i1.ColumnInt driverId;

  late final _i1.ColumnString firebaseChannelId;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    storeOrderId,
    clientId,
    storeId,
    driverId,
    firebaseChannelId,
    isActive,
    createdAt,
    updatedAt,
  ];
}

class StoreOrderChatInclude extends _i1.IncludeObject {
  StoreOrderChatInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StoreOrderChat.t;
}

class StoreOrderChatIncludeList extends _i1.IncludeList {
  StoreOrderChatIncludeList._({
    _i1.WhereExpressionBuilder<StoreOrderChatTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreOrderChat.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StoreOrderChat.t;
}

class StoreOrderChatRepository {
  const StoreOrderChatRepository._();

  /// Returns a list of [StoreOrderChat]s matching the given query parameters.
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
  Future<List<StoreOrderChat>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreOrderChatTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreOrderChatTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreOrderChatTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<StoreOrderChat>(
      where: where?.call(StoreOrderChat.t),
      orderBy: orderBy?.call(StoreOrderChat.t),
      orderByList: orderByList?.call(StoreOrderChat.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [StoreOrderChat] matching the given query parameters.
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
  Future<StoreOrderChat?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreOrderChatTable>? where,
    int? offset,
    _i1.OrderByBuilder<StoreOrderChatTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreOrderChatTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<StoreOrderChat>(
      where: where?.call(StoreOrderChat.t),
      orderBy: orderBy?.call(StoreOrderChat.t),
      orderByList: orderByList?.call(StoreOrderChat.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [StoreOrderChat] by its [id] or null if no such row exists.
  Future<StoreOrderChat?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<StoreOrderChat>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [StoreOrderChat]s in the list and returns the inserted rows.
  ///
  /// The returned [StoreOrderChat]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StoreOrderChat>> insert(
    _i1.Session session,
    List<StoreOrderChat> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StoreOrderChat>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StoreOrderChat] and returns the inserted row.
  ///
  /// The returned [StoreOrderChat] will have its `id` field set.
  Future<StoreOrderChat> insertRow(
    _i1.Session session,
    StoreOrderChat row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreOrderChat>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StoreOrderChat]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StoreOrderChat>> update(
    _i1.Session session,
    List<StoreOrderChat> rows, {
    _i1.ColumnSelections<StoreOrderChatTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StoreOrderChat>(
      rows,
      columns: columns?.call(StoreOrderChat.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreOrderChat]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StoreOrderChat> updateRow(
    _i1.Session session,
    StoreOrderChat row, {
    _i1.ColumnSelections<StoreOrderChatTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoreOrderChat>(
      row,
      columns: columns?.call(StoreOrderChat.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreOrderChat] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StoreOrderChat?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<StoreOrderChatUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StoreOrderChat>(
      id,
      columnValues: columnValues(StoreOrderChat.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StoreOrderChat]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StoreOrderChat>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<StoreOrderChatUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StoreOrderChatTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreOrderChatTable>? orderBy,
    _i1.OrderByListBuilder<StoreOrderChatTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StoreOrderChat>(
      columnValues: columnValues(StoreOrderChat.t.updateTable),
      where: where(StoreOrderChat.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreOrderChat.t),
      orderByList: orderByList?.call(StoreOrderChat.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StoreOrderChat]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StoreOrderChat>> delete(
    _i1.Session session,
    List<StoreOrderChat> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StoreOrderChat>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StoreOrderChat].
  Future<StoreOrderChat> deleteRow(
    _i1.Session session,
    StoreOrderChat row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreOrderChat>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StoreOrderChat>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StoreOrderChatTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StoreOrderChat>(
      where: where(StoreOrderChat.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreOrderChatTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StoreOrderChat>(
      where: where?.call(StoreOrderChat.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
