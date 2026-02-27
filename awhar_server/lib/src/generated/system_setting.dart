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

abstract class SystemSetting
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SystemSetting._({
    this.id,
    required this.key,
    required this.value,
    this.description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SystemSetting({
    int? id,
    required String key,
    required String value,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SystemSettingImpl;

  factory SystemSetting.fromJson(Map<String, dynamic> jsonSerialization) {
    return SystemSetting(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      value: jsonSerialization['value'] as String,
      description: jsonSerialization['description'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = SystemSettingTable();

  static const db = SystemSettingRepository._();

  @override
  int? id;

  String key;

  String value;

  String? description;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SystemSetting]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SystemSetting copyWith({
    int? id,
    String? key,
    String? value,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SystemSetting',
      if (id != null) 'id': id,
      'key': key,
      'value': value,
      if (description != null) 'description': description,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SystemSetting',
      if (id != null) 'id': id,
      'key': key,
      'value': value,
      if (description != null) 'description': description,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SystemSettingInclude include() {
    return SystemSettingInclude._();
  }

  static SystemSettingIncludeList includeList({
    _i1.WhereExpressionBuilder<SystemSettingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SystemSettingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemSettingTable>? orderByList,
    SystemSettingInclude? include,
  }) {
    return SystemSettingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SystemSetting.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SystemSetting.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SystemSettingImpl extends SystemSetting {
  _SystemSettingImpl({
    int? id,
    required String key,
    required String value,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         key: key,
         value: value,
         description: description,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SystemSetting]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SystemSetting copyWith({
    Object? id = _Undefined,
    String? key,
    String? value,
    Object? description = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SystemSetting(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      value: value ?? this.value,
      description: description is String? ? description : this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SystemSettingUpdateTable extends _i1.UpdateTable<SystemSettingTable> {
  SystemSettingUpdateTable(super.table);

  _i1.ColumnValue<String, String> key(String value) => _i1.ColumnValue(
    table.key,
    value,
  );

  _i1.ColumnValue<String, String> value(String value) => _i1.ColumnValue(
    table.value,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
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

class SystemSettingTable extends _i1.Table<int?> {
  SystemSettingTable({super.tableRelation})
    : super(tableName: 'system_settings') {
    updateTable = SystemSettingUpdateTable(this);
    key = _i1.ColumnString(
      'key',
      this,
    );
    value = _i1.ColumnString(
      'value',
      this,
    );
    description = _i1.ColumnString(
      'description',
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

  late final SystemSettingUpdateTable updateTable;

  late final _i1.ColumnString key;

  late final _i1.ColumnString value;

  late final _i1.ColumnString description;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    key,
    value,
    description,
    createdAt,
    updatedAt,
  ];
}

class SystemSettingInclude extends _i1.IncludeObject {
  SystemSettingInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SystemSetting.t;
}

class SystemSettingIncludeList extends _i1.IncludeList {
  SystemSettingIncludeList._({
    _i1.WhereExpressionBuilder<SystemSettingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SystemSetting.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SystemSetting.t;
}

class SystemSettingRepository {
  const SystemSettingRepository._();

  /// Returns a list of [SystemSetting]s matching the given query parameters.
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
  Future<List<SystemSetting>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SystemSettingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SystemSettingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemSettingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SystemSetting>(
      where: where?.call(SystemSetting.t),
      orderBy: orderBy?.call(SystemSetting.t),
      orderByList: orderByList?.call(SystemSetting.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SystemSetting] matching the given query parameters.
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
  Future<SystemSetting?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SystemSettingTable>? where,
    int? offset,
    _i1.OrderByBuilder<SystemSettingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemSettingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SystemSetting>(
      where: where?.call(SystemSetting.t),
      orderBy: orderBy?.call(SystemSetting.t),
      orderByList: orderByList?.call(SystemSetting.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SystemSetting] by its [id] or null if no such row exists.
  Future<SystemSetting?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SystemSetting>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SystemSetting]s in the list and returns the inserted rows.
  ///
  /// The returned [SystemSetting]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SystemSetting>> insert(
    _i1.Session session,
    List<SystemSetting> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SystemSetting>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SystemSetting] and returns the inserted row.
  ///
  /// The returned [SystemSetting] will have its `id` field set.
  Future<SystemSetting> insertRow(
    _i1.Session session,
    SystemSetting row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SystemSetting>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SystemSetting]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SystemSetting>> update(
    _i1.Session session,
    List<SystemSetting> rows, {
    _i1.ColumnSelections<SystemSettingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SystemSetting>(
      rows,
      columns: columns?.call(SystemSetting.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SystemSetting]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SystemSetting> updateRow(
    _i1.Session session,
    SystemSetting row, {
    _i1.ColumnSelections<SystemSettingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SystemSetting>(
      row,
      columns: columns?.call(SystemSetting.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SystemSetting] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SystemSetting?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<SystemSettingUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SystemSetting>(
      id,
      columnValues: columnValues(SystemSetting.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SystemSetting]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SystemSetting>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SystemSettingUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SystemSettingTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SystemSettingTable>? orderBy,
    _i1.OrderByListBuilder<SystemSettingTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SystemSetting>(
      columnValues: columnValues(SystemSetting.t.updateTable),
      where: where(SystemSetting.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SystemSetting.t),
      orderByList: orderByList?.call(SystemSetting.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SystemSetting]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SystemSetting>> delete(
    _i1.Session session,
    List<SystemSetting> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SystemSetting>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SystemSetting].
  Future<SystemSetting> deleteRow(
    _i1.Session session,
    SystemSetting row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SystemSetting>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SystemSetting>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SystemSettingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SystemSetting>(
      where: where(SystemSetting.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SystemSettingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SystemSetting>(
      where: where?.call(SystemSetting.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
