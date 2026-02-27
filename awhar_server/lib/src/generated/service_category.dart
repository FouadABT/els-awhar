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

abstract class ServiceCategory
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ServiceCategory._({
    this.id,
    required this.name,
    required this.nameAr,
    required this.nameFr,
    this.nameEs,
    required this.icon,
    this.description,
    int? displayOrder,
    bool? isActive,
    double? defaultRadiusKm,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : displayOrder = displayOrder ?? 0,
       isActive = isActive ?? true,
       defaultRadiusKm = defaultRadiusKm ?? 10.0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory ServiceCategory({
    int? id,
    required String name,
    required String nameAr,
    required String nameFr,
    String? nameEs,
    required String icon,
    String? description,
    int? displayOrder,
    bool? isActive,
    double? defaultRadiusKm,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ServiceCategoryImpl;

  factory ServiceCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return ServiceCategory(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      nameAr: jsonSerialization['nameAr'] as String,
      nameFr: jsonSerialization['nameFr'] as String,
      nameEs: jsonSerialization['nameEs'] as String?,
      icon: jsonSerialization['icon'] as String,
      description: jsonSerialization['description'] as String?,
      displayOrder: jsonSerialization['displayOrder'] as int,
      isActive: jsonSerialization['isActive'] as bool,
      defaultRadiusKm: (jsonSerialization['defaultRadiusKm'] as num).toDouble(),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ServiceCategoryTable();

  static const db = ServiceCategoryRepository._();

  @override
  int? id;

  String name;

  String nameAr;

  String nameFr;

  String? nameEs;

  String icon;

  String? description;

  int displayOrder;

  bool isActive;

  double defaultRadiusKm;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ServiceCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ServiceCategory copyWith({
    int? id,
    String? name,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? icon,
    String? description,
    int? displayOrder,
    bool? isActive,
    double? defaultRadiusKm,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ServiceCategory',
      if (id != null) 'id': id,
      'name': name,
      'nameAr': nameAr,
      'nameFr': nameFr,
      if (nameEs != null) 'nameEs': nameEs,
      'icon': icon,
      if (description != null) 'description': description,
      'displayOrder': displayOrder,
      'isActive': isActive,
      'defaultRadiusKm': defaultRadiusKm,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ServiceCategory',
      if (id != null) 'id': id,
      'name': name,
      'nameAr': nameAr,
      'nameFr': nameFr,
      if (nameEs != null) 'nameEs': nameEs,
      'icon': icon,
      if (description != null) 'description': description,
      'displayOrder': displayOrder,
      'isActive': isActive,
      'defaultRadiusKm': defaultRadiusKm,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ServiceCategoryInclude include() {
    return ServiceCategoryInclude._();
  }

  static ServiceCategoryIncludeList includeList({
    _i1.WhereExpressionBuilder<ServiceCategoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ServiceCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ServiceCategoryTable>? orderByList,
    ServiceCategoryInclude? include,
  }) {
    return ServiceCategoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ServiceCategory.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ServiceCategory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ServiceCategoryImpl extends ServiceCategory {
  _ServiceCategoryImpl({
    int? id,
    required String name,
    required String nameAr,
    required String nameFr,
    String? nameEs,
    required String icon,
    String? description,
    int? displayOrder,
    bool? isActive,
    double? defaultRadiusKm,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         nameAr: nameAr,
         nameFr: nameFr,
         nameEs: nameEs,
         icon: icon,
         description: description,
         displayOrder: displayOrder,
         isActive: isActive,
         defaultRadiusKm: defaultRadiusKm,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ServiceCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ServiceCategory copyWith({
    Object? id = _Undefined,
    String? name,
    String? nameAr,
    String? nameFr,
    Object? nameEs = _Undefined,
    String? icon,
    Object? description = _Undefined,
    int? displayOrder,
    bool? isActive,
    double? defaultRadiusKm,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ServiceCategory(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      nameFr: nameFr ?? this.nameFr,
      nameEs: nameEs is String? ? nameEs : this.nameEs,
      icon: icon ?? this.icon,
      description: description is String? ? description : this.description,
      displayOrder: displayOrder ?? this.displayOrder,
      isActive: isActive ?? this.isActive,
      defaultRadiusKm: defaultRadiusKm ?? this.defaultRadiusKm,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ServiceCategoryUpdateTable extends _i1.UpdateTable<ServiceCategoryTable> {
  ServiceCategoryUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> nameAr(String value) => _i1.ColumnValue(
    table.nameAr,
    value,
  );

  _i1.ColumnValue<String, String> nameFr(String value) => _i1.ColumnValue(
    table.nameFr,
    value,
  );

  _i1.ColumnValue<String, String> nameEs(String? value) => _i1.ColumnValue(
    table.nameEs,
    value,
  );

  _i1.ColumnValue<String, String> icon(String value) => _i1.ColumnValue(
    table.icon,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<int, int> displayOrder(int value) => _i1.ColumnValue(
    table.displayOrder,
    value,
  );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<double, double> defaultRadiusKm(double value) =>
      _i1.ColumnValue(
        table.defaultRadiusKm,
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

class ServiceCategoryTable extends _i1.Table<int?> {
  ServiceCategoryTable({super.tableRelation})
    : super(tableName: 'service_categories') {
    updateTable = ServiceCategoryUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    nameAr = _i1.ColumnString(
      'nameAr',
      this,
    );
    nameFr = _i1.ColumnString(
      'nameFr',
      this,
    );
    nameEs = _i1.ColumnString(
      'nameEs',
      this,
    );
    icon = _i1.ColumnString(
      'icon',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    displayOrder = _i1.ColumnInt(
      'displayOrder',
      this,
      hasDefault: true,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    defaultRadiusKm = _i1.ColumnDouble(
      'defaultRadiusKm',
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

  late final ServiceCategoryUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString nameAr;

  late final _i1.ColumnString nameFr;

  late final _i1.ColumnString nameEs;

  late final _i1.ColumnString icon;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt displayOrder;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnDouble defaultRadiusKm;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    nameAr,
    nameFr,
    nameEs,
    icon,
    description,
    displayOrder,
    isActive,
    defaultRadiusKm,
    createdAt,
    updatedAt,
  ];
}

class ServiceCategoryInclude extends _i1.IncludeObject {
  ServiceCategoryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ServiceCategory.t;
}

class ServiceCategoryIncludeList extends _i1.IncludeList {
  ServiceCategoryIncludeList._({
    _i1.WhereExpressionBuilder<ServiceCategoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ServiceCategory.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ServiceCategory.t;
}

class ServiceCategoryRepository {
  const ServiceCategoryRepository._();

  /// Returns a list of [ServiceCategory]s matching the given query parameters.
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
  Future<List<ServiceCategory>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ServiceCategoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ServiceCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ServiceCategoryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ServiceCategory>(
      where: where?.call(ServiceCategory.t),
      orderBy: orderBy?.call(ServiceCategory.t),
      orderByList: orderByList?.call(ServiceCategory.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ServiceCategory] matching the given query parameters.
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
  Future<ServiceCategory?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ServiceCategoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<ServiceCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ServiceCategoryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ServiceCategory>(
      where: where?.call(ServiceCategory.t),
      orderBy: orderBy?.call(ServiceCategory.t),
      orderByList: orderByList?.call(ServiceCategory.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ServiceCategory] by its [id] or null if no such row exists.
  Future<ServiceCategory?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ServiceCategory>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ServiceCategory]s in the list and returns the inserted rows.
  ///
  /// The returned [ServiceCategory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ServiceCategory>> insert(
    _i1.Session session,
    List<ServiceCategory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ServiceCategory>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ServiceCategory] and returns the inserted row.
  ///
  /// The returned [ServiceCategory] will have its `id` field set.
  Future<ServiceCategory> insertRow(
    _i1.Session session,
    ServiceCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ServiceCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ServiceCategory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ServiceCategory>> update(
    _i1.Session session,
    List<ServiceCategory> rows, {
    _i1.ColumnSelections<ServiceCategoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ServiceCategory>(
      rows,
      columns: columns?.call(ServiceCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ServiceCategory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ServiceCategory> updateRow(
    _i1.Session session,
    ServiceCategory row, {
    _i1.ColumnSelections<ServiceCategoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ServiceCategory>(
      row,
      columns: columns?.call(ServiceCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ServiceCategory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ServiceCategory?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ServiceCategoryUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ServiceCategory>(
      id,
      columnValues: columnValues(ServiceCategory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ServiceCategory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ServiceCategory>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ServiceCategoryUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ServiceCategoryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ServiceCategoryTable>? orderBy,
    _i1.OrderByListBuilder<ServiceCategoryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ServiceCategory>(
      columnValues: columnValues(ServiceCategory.t.updateTable),
      where: where(ServiceCategory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ServiceCategory.t),
      orderByList: orderByList?.call(ServiceCategory.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ServiceCategory]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ServiceCategory>> delete(
    _i1.Session session,
    List<ServiceCategory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ServiceCategory>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ServiceCategory].
  Future<ServiceCategory> deleteRow(
    _i1.Session session,
    ServiceCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ServiceCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ServiceCategory>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ServiceCategoryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ServiceCategory>(
      where: where(ServiceCategory.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ServiceCategoryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ServiceCategory>(
      where: where?.call(ServiceCategory.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
