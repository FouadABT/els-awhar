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

abstract class Service
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Service._({
    this.id,
    required this.categoryId,
    required this.nameEn,
    this.nameAr,
    this.nameFr,
    this.nameEs,
    this.descriptionEn,
    this.descriptionAr,
    this.descriptionFr,
    this.descriptionEs,
    this.iconName,
    this.imageUrl,
    this.suggestedPriceMin,
    this.suggestedPriceMax,
    bool? isActive,
    int? displayOrder,
    bool? isPopular,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isActive = isActive ?? true,
       displayOrder = displayOrder ?? 0,
       isPopular = isPopular ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Service({
    int? id,
    required int categoryId,
    required String nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    String? iconName,
    String? imageUrl,
    double? suggestedPriceMin,
    double? suggestedPriceMax,
    bool? isActive,
    int? displayOrder,
    bool? isPopular,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ServiceImpl;

  factory Service.fromJson(Map<String, dynamic> jsonSerialization) {
    return Service(
      id: jsonSerialization['id'] as int?,
      categoryId: jsonSerialization['categoryId'] as int,
      nameEn: jsonSerialization['nameEn'] as String,
      nameAr: jsonSerialization['nameAr'] as String?,
      nameFr: jsonSerialization['nameFr'] as String?,
      nameEs: jsonSerialization['nameEs'] as String?,
      descriptionEn: jsonSerialization['descriptionEn'] as String?,
      descriptionAr: jsonSerialization['descriptionAr'] as String?,
      descriptionFr: jsonSerialization['descriptionFr'] as String?,
      descriptionEs: jsonSerialization['descriptionEs'] as String?,
      iconName: jsonSerialization['iconName'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      suggestedPriceMin: (jsonSerialization['suggestedPriceMin'] as num?)
          ?.toDouble(),
      suggestedPriceMax: (jsonSerialization['suggestedPriceMax'] as num?)
          ?.toDouble(),
      isActive: jsonSerialization['isActive'] as bool,
      displayOrder: jsonSerialization['displayOrder'] as int,
      isPopular: jsonSerialization['isPopular'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ServiceTable();

  static const db = ServiceRepository._();

  @override
  int? id;

  int categoryId;

  String nameEn;

  String? nameAr;

  String? nameFr;

  String? nameEs;

  String? descriptionEn;

  String? descriptionAr;

  String? descriptionFr;

  String? descriptionEs;

  String? iconName;

  String? imageUrl;

  double? suggestedPriceMin;

  double? suggestedPriceMax;

  bool isActive;

  int displayOrder;

  bool isPopular;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Service]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Service copyWith({
    int? id,
    int? categoryId,
    String? nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    String? iconName,
    String? imageUrl,
    double? suggestedPriceMin,
    double? suggestedPriceMax,
    bool? isActive,
    int? displayOrder,
    bool? isPopular,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Service',
      if (id != null) 'id': id,
      'categoryId': categoryId,
      'nameEn': nameEn,
      if (nameAr != null) 'nameAr': nameAr,
      if (nameFr != null) 'nameFr': nameFr,
      if (nameEs != null) 'nameEs': nameEs,
      if (descriptionEn != null) 'descriptionEn': descriptionEn,
      if (descriptionAr != null) 'descriptionAr': descriptionAr,
      if (descriptionFr != null) 'descriptionFr': descriptionFr,
      if (descriptionEs != null) 'descriptionEs': descriptionEs,
      if (iconName != null) 'iconName': iconName,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (suggestedPriceMin != null) 'suggestedPriceMin': suggestedPriceMin,
      if (suggestedPriceMax != null) 'suggestedPriceMax': suggestedPriceMax,
      'isActive': isActive,
      'displayOrder': displayOrder,
      'isPopular': isPopular,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Service',
      if (id != null) 'id': id,
      'categoryId': categoryId,
      'nameEn': nameEn,
      if (nameAr != null) 'nameAr': nameAr,
      if (nameFr != null) 'nameFr': nameFr,
      if (nameEs != null) 'nameEs': nameEs,
      if (descriptionEn != null) 'descriptionEn': descriptionEn,
      if (descriptionAr != null) 'descriptionAr': descriptionAr,
      if (descriptionFr != null) 'descriptionFr': descriptionFr,
      if (descriptionEs != null) 'descriptionEs': descriptionEs,
      if (iconName != null) 'iconName': iconName,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (suggestedPriceMin != null) 'suggestedPriceMin': suggestedPriceMin,
      if (suggestedPriceMax != null) 'suggestedPriceMax': suggestedPriceMax,
      'isActive': isActive,
      'displayOrder': displayOrder,
      'isPopular': isPopular,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ServiceInclude include() {
    return ServiceInclude._();
  }

  static ServiceIncludeList includeList({
    _i1.WhereExpressionBuilder<ServiceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ServiceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ServiceTable>? orderByList,
    ServiceInclude? include,
  }) {
    return ServiceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Service.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Service.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ServiceImpl extends Service {
  _ServiceImpl({
    int? id,
    required int categoryId,
    required String nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    String? iconName,
    String? imageUrl,
    double? suggestedPriceMin,
    double? suggestedPriceMax,
    bool? isActive,
    int? displayOrder,
    bool? isPopular,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         categoryId: categoryId,
         nameEn: nameEn,
         nameAr: nameAr,
         nameFr: nameFr,
         nameEs: nameEs,
         descriptionEn: descriptionEn,
         descriptionAr: descriptionAr,
         descriptionFr: descriptionFr,
         descriptionEs: descriptionEs,
         iconName: iconName,
         imageUrl: imageUrl,
         suggestedPriceMin: suggestedPriceMin,
         suggestedPriceMax: suggestedPriceMax,
         isActive: isActive,
         displayOrder: displayOrder,
         isPopular: isPopular,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Service]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Service copyWith({
    Object? id = _Undefined,
    int? categoryId,
    String? nameEn,
    Object? nameAr = _Undefined,
    Object? nameFr = _Undefined,
    Object? nameEs = _Undefined,
    Object? descriptionEn = _Undefined,
    Object? descriptionAr = _Undefined,
    Object? descriptionFr = _Undefined,
    Object? descriptionEs = _Undefined,
    Object? iconName = _Undefined,
    Object? imageUrl = _Undefined,
    Object? suggestedPriceMin = _Undefined,
    Object? suggestedPriceMax = _Undefined,
    bool? isActive,
    int? displayOrder,
    bool? isPopular,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Service(
      id: id is int? ? id : this.id,
      categoryId: categoryId ?? this.categoryId,
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
      iconName: iconName is String? ? iconName : this.iconName,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      suggestedPriceMin: suggestedPriceMin is double?
          ? suggestedPriceMin
          : this.suggestedPriceMin,
      suggestedPriceMax: suggestedPriceMax is double?
          ? suggestedPriceMax
          : this.suggestedPriceMax,
      isActive: isActive ?? this.isActive,
      displayOrder: displayOrder ?? this.displayOrder,
      isPopular: isPopular ?? this.isPopular,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ServiceUpdateTable extends _i1.UpdateTable<ServiceTable> {
  ServiceUpdateTable(super.table);

  _i1.ColumnValue<int, int> categoryId(int value) => _i1.ColumnValue(
    table.categoryId,
    value,
  );

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

  _i1.ColumnValue<String, String> iconName(String? value) => _i1.ColumnValue(
    table.iconName,
    value,
  );

  _i1.ColumnValue<String, String> imageUrl(String? value) => _i1.ColumnValue(
    table.imageUrl,
    value,
  );

  _i1.ColumnValue<double, double> suggestedPriceMin(double? value) =>
      _i1.ColumnValue(
        table.suggestedPriceMin,
        value,
      );

  _i1.ColumnValue<double, double> suggestedPriceMax(double? value) =>
      _i1.ColumnValue(
        table.suggestedPriceMax,
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

  _i1.ColumnValue<bool, bool> isPopular(bool value) => _i1.ColumnValue(
    table.isPopular,
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

class ServiceTable extends _i1.Table<int?> {
  ServiceTable({super.tableRelation}) : super(tableName: 'services') {
    updateTable = ServiceUpdateTable(this);
    categoryId = _i1.ColumnInt(
      'categoryId',
      this,
    );
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
    imageUrl = _i1.ColumnString(
      'imageUrl',
      this,
    );
    suggestedPriceMin = _i1.ColumnDouble(
      'suggestedPriceMin',
      this,
    );
    suggestedPriceMax = _i1.ColumnDouble(
      'suggestedPriceMax',
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
    isPopular = _i1.ColumnBool(
      'isPopular',
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

  late final ServiceUpdateTable updateTable;

  late final _i1.ColumnInt categoryId;

  late final _i1.ColumnString nameEn;

  late final _i1.ColumnString nameAr;

  late final _i1.ColumnString nameFr;

  late final _i1.ColumnString nameEs;

  late final _i1.ColumnString descriptionEn;

  late final _i1.ColumnString descriptionAr;

  late final _i1.ColumnString descriptionFr;

  late final _i1.ColumnString descriptionEs;

  late final _i1.ColumnString iconName;

  late final _i1.ColumnString imageUrl;

  late final _i1.ColumnDouble suggestedPriceMin;

  late final _i1.ColumnDouble suggestedPriceMax;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnInt displayOrder;

  late final _i1.ColumnBool isPopular;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    categoryId,
    nameEn,
    nameAr,
    nameFr,
    nameEs,
    descriptionEn,
    descriptionAr,
    descriptionFr,
    descriptionEs,
    iconName,
    imageUrl,
    suggestedPriceMin,
    suggestedPriceMax,
    isActive,
    displayOrder,
    isPopular,
    createdAt,
    updatedAt,
  ];
}

class ServiceInclude extends _i1.IncludeObject {
  ServiceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Service.t;
}

class ServiceIncludeList extends _i1.IncludeList {
  ServiceIncludeList._({
    _i1.WhereExpressionBuilder<ServiceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Service.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Service.t;
}

class ServiceRepository {
  const ServiceRepository._();

  /// Returns a list of [Service]s matching the given query parameters.
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
  Future<List<Service>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ServiceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ServiceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ServiceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Service>(
      where: where?.call(Service.t),
      orderBy: orderBy?.call(Service.t),
      orderByList: orderByList?.call(Service.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Service] matching the given query parameters.
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
  Future<Service?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ServiceTable>? where,
    int? offset,
    _i1.OrderByBuilder<ServiceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ServiceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Service>(
      where: where?.call(Service.t),
      orderBy: orderBy?.call(Service.t),
      orderByList: orderByList?.call(Service.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Service] by its [id] or null if no such row exists.
  Future<Service?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Service>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Service]s in the list and returns the inserted rows.
  ///
  /// The returned [Service]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Service>> insert(
    _i1.Session session,
    List<Service> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Service>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Service] and returns the inserted row.
  ///
  /// The returned [Service] will have its `id` field set.
  Future<Service> insertRow(
    _i1.Session session,
    Service row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Service>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Service]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Service>> update(
    _i1.Session session,
    List<Service> rows, {
    _i1.ColumnSelections<ServiceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Service>(
      rows,
      columns: columns?.call(Service.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Service]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Service> updateRow(
    _i1.Session session,
    Service row, {
    _i1.ColumnSelections<ServiceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Service>(
      row,
      columns: columns?.call(Service.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Service] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Service?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ServiceUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Service>(
      id,
      columnValues: columnValues(Service.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Service]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Service>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ServiceUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ServiceTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ServiceTable>? orderBy,
    _i1.OrderByListBuilder<ServiceTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Service>(
      columnValues: columnValues(Service.t.updateTable),
      where: where(Service.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Service.t),
      orderByList: orderByList?.call(Service.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Service]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Service>> delete(
    _i1.Session session,
    List<Service> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Service>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Service].
  Future<Service> deleteRow(
    _i1.Session session,
    Service row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Service>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Service>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ServiceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Service>(
      where: where(Service.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ServiceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Service>(
      where: where?.call(Service.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
