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

abstract class StoreCategory
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StoreCategory._({
    this.id,
    required this.nameEn,
    this.nameAr,
    this.nameFr,
    this.nameEs,
    this.descriptionEn,
    this.descriptionAr,
    this.descriptionFr,
    this.descriptionEs,
    required this.iconName,
    this.iconUrl,
    this.imageUrl,
    this.colorHex,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isActive = isActive ?? true,
       displayOrder = displayOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory StoreCategory({
    int? id,
    required String nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    required String iconName,
    String? iconUrl,
    String? imageUrl,
    String? colorHex,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StoreCategoryImpl;

  factory StoreCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreCategory(
      id: jsonSerialization['id'] as int?,
      nameEn: jsonSerialization['nameEn'] as String,
      nameAr: jsonSerialization['nameAr'] as String?,
      nameFr: jsonSerialization['nameFr'] as String?,
      nameEs: jsonSerialization['nameEs'] as String?,
      descriptionEn: jsonSerialization['descriptionEn'] as String?,
      descriptionAr: jsonSerialization['descriptionAr'] as String?,
      descriptionFr: jsonSerialization['descriptionFr'] as String?,
      descriptionEs: jsonSerialization['descriptionEs'] as String?,
      iconName: jsonSerialization['iconName'] as String,
      iconUrl: jsonSerialization['iconUrl'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      colorHex: jsonSerialization['colorHex'] as String?,
      isActive: jsonSerialization['isActive'] as bool,
      displayOrder: jsonSerialization['displayOrder'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = StoreCategoryTable();

  static const db = StoreCategoryRepository._();

  @override
  int? id;

  String nameEn;

  String? nameAr;

  String? nameFr;

  String? nameEs;

  String? descriptionEn;

  String? descriptionAr;

  String? descriptionFr;

  String? descriptionEs;

  String iconName;

  String? iconUrl;

  String? imageUrl;

  String? colorHex;

  bool isActive;

  int displayOrder;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StoreCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreCategory copyWith({
    int? id,
    String? nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    String? iconName,
    String? iconUrl,
    String? imageUrl,
    String? colorHex,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreCategory',
      if (id != null) 'id': id,
      'nameEn': nameEn,
      if (nameAr != null) 'nameAr': nameAr,
      if (nameFr != null) 'nameFr': nameFr,
      if (nameEs != null) 'nameEs': nameEs,
      if (descriptionEn != null) 'descriptionEn': descriptionEn,
      if (descriptionAr != null) 'descriptionAr': descriptionAr,
      if (descriptionFr != null) 'descriptionFr': descriptionFr,
      if (descriptionEs != null) 'descriptionEs': descriptionEs,
      'iconName': iconName,
      if (iconUrl != null) 'iconUrl': iconUrl,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (colorHex != null) 'colorHex': colorHex,
      'isActive': isActive,
      'displayOrder': displayOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StoreCategory',
      if (id != null) 'id': id,
      'nameEn': nameEn,
      if (nameAr != null) 'nameAr': nameAr,
      if (nameFr != null) 'nameFr': nameFr,
      if (nameEs != null) 'nameEs': nameEs,
      if (descriptionEn != null) 'descriptionEn': descriptionEn,
      if (descriptionAr != null) 'descriptionAr': descriptionAr,
      if (descriptionFr != null) 'descriptionFr': descriptionFr,
      if (descriptionEs != null) 'descriptionEs': descriptionEs,
      'iconName': iconName,
      if (iconUrl != null) 'iconUrl': iconUrl,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (colorHex != null) 'colorHex': colorHex,
      'isActive': isActive,
      'displayOrder': displayOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static StoreCategoryInclude include() {
    return StoreCategoryInclude._();
  }

  static StoreCategoryIncludeList includeList({
    _i1.WhereExpressionBuilder<StoreCategoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreCategoryTable>? orderByList,
    StoreCategoryInclude? include,
  }) {
    return StoreCategoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreCategory.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StoreCategory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreCategoryImpl extends StoreCategory {
  _StoreCategoryImpl({
    int? id,
    required String nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    required String iconName,
    String? iconUrl,
    String? imageUrl,
    String? colorHex,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         nameEn: nameEn,
         nameAr: nameAr,
         nameFr: nameFr,
         nameEs: nameEs,
         descriptionEn: descriptionEn,
         descriptionAr: descriptionAr,
         descriptionFr: descriptionFr,
         descriptionEs: descriptionEs,
         iconName: iconName,
         iconUrl: iconUrl,
         imageUrl: imageUrl,
         colorHex: colorHex,
         isActive: isActive,
         displayOrder: displayOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StoreCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreCategory copyWith({
    Object? id = _Undefined,
    String? nameEn,
    Object? nameAr = _Undefined,
    Object? nameFr = _Undefined,
    Object? nameEs = _Undefined,
    Object? descriptionEn = _Undefined,
    Object? descriptionAr = _Undefined,
    Object? descriptionFr = _Undefined,
    Object? descriptionEs = _Undefined,
    String? iconName,
    Object? iconUrl = _Undefined,
    Object? imageUrl = _Undefined,
    Object? colorHex = _Undefined,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StoreCategory(
      id: id is int? ? id : this.id,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr is String? ? nameAr : this.nameAr,
      nameFr: nameFr is String? ? nameFr : this.nameFr,
      nameEs: nameEs is String? ? nameEs : this.nameEs,
      descriptionEn: descriptionEn is String?
          ? descriptionEn
          : this.descriptionEn,
      descriptionAr: descriptionAr is String?
          ? descriptionAr
          : this.descriptionAr,
      descriptionFr: descriptionFr is String?
          ? descriptionFr
          : this.descriptionFr,
      descriptionEs: descriptionEs is String?
          ? descriptionEs
          : this.descriptionEs,
      iconName: iconName ?? this.iconName,
      iconUrl: iconUrl is String? ? iconUrl : this.iconUrl,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      colorHex: colorHex is String? ? colorHex : this.colorHex,
      isActive: isActive ?? this.isActive,
      displayOrder: displayOrder ?? this.displayOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class StoreCategoryUpdateTable extends _i1.UpdateTable<StoreCategoryTable> {
  StoreCategoryUpdateTable(super.table);

  _i1.ColumnValue<String, String> nameEn(String value) => _i1.ColumnValue(
    table.nameEn,
    value,
  );

  _i1.ColumnValue<String, String> nameAr(String? value) => _i1.ColumnValue(
    table.nameAr,
    value,
  );

  _i1.ColumnValue<String, String> nameFr(String? value) => _i1.ColumnValue(
    table.nameFr,
    value,
  );

  _i1.ColumnValue<String, String> nameEs(String? value) => _i1.ColumnValue(
    table.nameEs,
    value,
  );

  _i1.ColumnValue<String, String> descriptionEn(String? value) =>
      _i1.ColumnValue(
        table.descriptionEn,
        value,
      );

  _i1.ColumnValue<String, String> descriptionAr(String? value) =>
      _i1.ColumnValue(
        table.descriptionAr,
        value,
      );

  _i1.ColumnValue<String, String> descriptionFr(String? value) =>
      _i1.ColumnValue(
        table.descriptionFr,
        value,
      );

  _i1.ColumnValue<String, String> descriptionEs(String? value) =>
      _i1.ColumnValue(
        table.descriptionEs,
        value,
      );

  _i1.ColumnValue<String, String> iconName(String value) => _i1.ColumnValue(
    table.iconName,
    value,
  );

  _i1.ColumnValue<String, String> iconUrl(String? value) => _i1.ColumnValue(
    table.iconUrl,
    value,
  );

  _i1.ColumnValue<String, String> imageUrl(String? value) => _i1.ColumnValue(
    table.imageUrl,
    value,
  );

  _i1.ColumnValue<String, String> colorHex(String? value) => _i1.ColumnValue(
    table.colorHex,
    value,
  );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<int, int> displayOrder(int value) => _i1.ColumnValue(
    table.displayOrder,
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

class StoreCategoryTable extends _i1.Table<int?> {
  StoreCategoryTable({super.tableRelation})
    : super(tableName: 'store_categories') {
    updateTable = StoreCategoryUpdateTable(this);
    nameEn = _i1.ColumnString(
      'nameEn',
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
    descriptionEn = _i1.ColumnString(
      'descriptionEn',
      this,
    );
    descriptionAr = _i1.ColumnString(
      'descriptionAr',
      this,
    );
    descriptionFr = _i1.ColumnString(
      'descriptionFr',
      this,
    );
    descriptionEs = _i1.ColumnString(
      'descriptionEs',
      this,
    );
    iconName = _i1.ColumnString(
      'iconName',
      this,
    );
    iconUrl = _i1.ColumnString(
      'iconUrl',
      this,
    );
    imageUrl = _i1.ColumnString(
      'imageUrl',
      this,
    );
    colorHex = _i1.ColumnString(
      'colorHex',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    displayOrder = _i1.ColumnInt(
      'displayOrder',
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

  late final StoreCategoryUpdateTable updateTable;

  late final _i1.ColumnString nameEn;

  late final _i1.ColumnString nameAr;

  late final _i1.ColumnString nameFr;

  late final _i1.ColumnString nameEs;

  late final _i1.ColumnString descriptionEn;

  late final _i1.ColumnString descriptionAr;

  late final _i1.ColumnString descriptionFr;

  late final _i1.ColumnString descriptionEs;

  late final _i1.ColumnString iconName;

  late final _i1.ColumnString iconUrl;

  late final _i1.ColumnString imageUrl;

  late final _i1.ColumnString colorHex;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnInt displayOrder;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    nameEn,
    nameAr,
    nameFr,
    nameEs,
    descriptionEn,
    descriptionAr,
    descriptionFr,
    descriptionEs,
    iconName,
    iconUrl,
    imageUrl,
    colorHex,
    isActive,
    displayOrder,
    createdAt,
    updatedAt,
  ];
}

class StoreCategoryInclude extends _i1.IncludeObject {
  StoreCategoryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StoreCategory.t;
}

class StoreCategoryIncludeList extends _i1.IncludeList {
  StoreCategoryIncludeList._({
    _i1.WhereExpressionBuilder<StoreCategoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreCategory.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StoreCategory.t;
}

class StoreCategoryRepository {
  const StoreCategoryRepository._();

  /// Returns a list of [StoreCategory]s matching the given query parameters.
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
  Future<List<StoreCategory>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreCategoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreCategoryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<StoreCategory>(
      where: where?.call(StoreCategory.t),
      orderBy: orderBy?.call(StoreCategory.t),
      orderByList: orderByList?.call(StoreCategory.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [StoreCategory] matching the given query parameters.
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
  Future<StoreCategory?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreCategoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<StoreCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreCategoryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<StoreCategory>(
      where: where?.call(StoreCategory.t),
      orderBy: orderBy?.call(StoreCategory.t),
      orderByList: orderByList?.call(StoreCategory.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [StoreCategory] by its [id] or null if no such row exists.
  Future<StoreCategory?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<StoreCategory>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [StoreCategory]s in the list and returns the inserted rows.
  ///
  /// The returned [StoreCategory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StoreCategory>> insert(
    _i1.Session session,
    List<StoreCategory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StoreCategory>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StoreCategory] and returns the inserted row.
  ///
  /// The returned [StoreCategory] will have its `id` field set.
  Future<StoreCategory> insertRow(
    _i1.Session session,
    StoreCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StoreCategory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StoreCategory>> update(
    _i1.Session session,
    List<StoreCategory> rows, {
    _i1.ColumnSelections<StoreCategoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StoreCategory>(
      rows,
      columns: columns?.call(StoreCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreCategory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StoreCategory> updateRow(
    _i1.Session session,
    StoreCategory row, {
    _i1.ColumnSelections<StoreCategoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoreCategory>(
      row,
      columns: columns?.call(StoreCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreCategory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StoreCategory?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<StoreCategoryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StoreCategory>(
      id,
      columnValues: columnValues(StoreCategory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StoreCategory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StoreCategory>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<StoreCategoryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StoreCategoryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreCategoryTable>? orderBy,
    _i1.OrderByListBuilder<StoreCategoryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StoreCategory>(
      columnValues: columnValues(StoreCategory.t.updateTable),
      where: where(StoreCategory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreCategory.t),
      orderByList: orderByList?.call(StoreCategory.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StoreCategory]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StoreCategory>> delete(
    _i1.Session session,
    List<StoreCategory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StoreCategory>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StoreCategory].
  Future<StoreCategory> deleteRow(
    _i1.Session session,
    StoreCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StoreCategory>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StoreCategoryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StoreCategory>(
      where: where(StoreCategory.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreCategoryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StoreCategory>(
      where: where?.call(StoreCategory.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
