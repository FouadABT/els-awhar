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

abstract class City implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  City._({
    this.id,
    required this.nameEn,
    this.nameAr,
    this.nameFr,
    this.nameEs,
    String? countryCode,
    required this.latitude,
    required this.longitude,
    bool? isActive,
    bool? isPopular,
    int? displayOrder,
    double? defaultDeliveryRadius,
    DateTime? createdAt,
  }) : countryCode = countryCode ?? 'MA',
       isActive = isActive ?? true,
       isPopular = isPopular ?? false,
       displayOrder = displayOrder ?? 0,
       defaultDeliveryRadius = defaultDeliveryRadius ?? 10.0,
       createdAt = createdAt ?? DateTime.now();

  factory City({
    int? id,
    required String nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? countryCode,
    required double latitude,
    required double longitude,
    bool? isActive,
    bool? isPopular,
    int? displayOrder,
    double? defaultDeliveryRadius,
    DateTime? createdAt,
  }) = _CityImpl;

  factory City.fromJson(Map<String, dynamic> jsonSerialization) {
    return City(
      id: jsonSerialization['id'] as int?,
      nameEn: jsonSerialization['nameEn'] as String,
      nameAr: jsonSerialization['nameAr'] as String?,
      nameFr: jsonSerialization['nameFr'] as String?,
      nameEs: jsonSerialization['nameEs'] as String?,
      countryCode: jsonSerialization['countryCode'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      isActive: jsonSerialization['isActive'] as bool,
      isPopular: jsonSerialization['isPopular'] as bool,
      displayOrder: jsonSerialization['displayOrder'] as int,
      defaultDeliveryRadius: (jsonSerialization['defaultDeliveryRadius'] as num)
          .toDouble(),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = CityTable();

  static const db = CityRepository._();

  @override
  int? id;

  String nameEn;

  String? nameAr;

  String? nameFr;

  String? nameEs;

  String countryCode;

  double latitude;

  double longitude;

  bool isActive;

  bool isPopular;

  int displayOrder;

  double defaultDeliveryRadius;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [City]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  City copyWith({
    int? id,
    String? nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? countryCode,
    double? latitude,
    double? longitude,
    bool? isActive,
    bool? isPopular,
    int? displayOrder,
    double? defaultDeliveryRadius,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'City',
      if (id != null) 'id': id,
      'nameEn': nameEn,
      if (nameAr != null) 'nameAr': nameAr,
      if (nameFr != null) 'nameFr': nameFr,
      if (nameEs != null) 'nameEs': nameEs,
      'countryCode': countryCode,
      'latitude': latitude,
      'longitude': longitude,
      'isActive': isActive,
      'isPopular': isPopular,
      'displayOrder': displayOrder,
      'defaultDeliveryRadius': defaultDeliveryRadius,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'City',
      if (id != null) 'id': id,
      'nameEn': nameEn,
      if (nameAr != null) 'nameAr': nameAr,
      if (nameFr != null) 'nameFr': nameFr,
      if (nameEs != null) 'nameEs': nameEs,
      'countryCode': countryCode,
      'latitude': latitude,
      'longitude': longitude,
      'isActive': isActive,
      'isPopular': isPopular,
      'displayOrder': displayOrder,
      'defaultDeliveryRadius': defaultDeliveryRadius,
      'createdAt': createdAt.toJson(),
    };
  }

  static CityInclude include() {
    return CityInclude._();
  }

  static CityIncludeList includeList({
    _i1.WhereExpressionBuilder<CityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CityTable>? orderByList,
    CityInclude? include,
  }) {
    return CityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(City.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(City.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CityImpl extends City {
  _CityImpl({
    int? id,
    required String nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? countryCode,
    required double latitude,
    required double longitude,
    bool? isActive,
    bool? isPopular,
    int? displayOrder,
    double? defaultDeliveryRadius,
    DateTime? createdAt,
  }) : super._(
         id: id,
         nameEn: nameEn,
         nameAr: nameAr,
         nameFr: nameFr,
         nameEs: nameEs,
         countryCode: countryCode,
         latitude: latitude,
         longitude: longitude,
         isActive: isActive,
         isPopular: isPopular,
         displayOrder: displayOrder,
         defaultDeliveryRadius: defaultDeliveryRadius,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [City]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  City copyWith({
    Object? id = _Undefined,
    String? nameEn,
    Object? nameAr = _Undefined,
    Object? nameFr = _Undefined,
    Object? nameEs = _Undefined,
    String? countryCode,
    double? latitude,
    double? longitude,
    bool? isActive,
    bool? isPopular,
    int? displayOrder,
    double? defaultDeliveryRadius,
    DateTime? createdAt,
  }) {
    return City(
      id: id is int? ? id : this.id,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr is String? ? nameAr : this.nameAr,
      nameFr: nameFr is String? ? nameFr : this.nameFr,
      nameEs: nameEs is String? ? nameEs : this.nameEs,
      countryCode: countryCode ?? this.countryCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isActive: isActive ?? this.isActive,
      isPopular: isPopular ?? this.isPopular,
      displayOrder: displayOrder ?? this.displayOrder,
      defaultDeliveryRadius:
          defaultDeliveryRadius ?? this.defaultDeliveryRadius,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CityUpdateTable extends _i1.UpdateTable<CityTable> {
  CityUpdateTable(super.table);

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

  _i1.ColumnValue<String, String> countryCode(String value) => _i1.ColumnValue(
    table.countryCode,
    value,
  );

  _i1.ColumnValue<double, double> latitude(double value) => _i1.ColumnValue(
    table.latitude,
    value,
  );

  _i1.ColumnValue<double, double> longitude(double value) => _i1.ColumnValue(
    table.longitude,
    value,
  );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<bool, bool> isPopular(bool value) => _i1.ColumnValue(
    table.isPopular,
    value,
  );

  _i1.ColumnValue<int, int> displayOrder(int value) => _i1.ColumnValue(
    table.displayOrder,
    value,
  );

  _i1.ColumnValue<double, double> defaultDeliveryRadius(double value) =>
      _i1.ColumnValue(
        table.defaultDeliveryRadius,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class CityTable extends _i1.Table<int?> {
  CityTable({super.tableRelation}) : super(tableName: 'cities') {
    updateTable = CityUpdateTable(this);
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
    countryCode = _i1.ColumnString(
      'countryCode',
      this,
      hasDefault: true,
    );
    latitude = _i1.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _i1.ColumnDouble(
      'longitude',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    isPopular = _i1.ColumnBool(
      'isPopular',
      this,
      hasDefault: true,
    );
    displayOrder = _i1.ColumnInt(
      'displayOrder',
      this,
      hasDefault: true,
    );
    defaultDeliveryRadius = _i1.ColumnDouble(
      'defaultDeliveryRadius',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final CityUpdateTable updateTable;

  late final _i1.ColumnString nameEn;

  late final _i1.ColumnString nameAr;

  late final _i1.ColumnString nameFr;

  late final _i1.ColumnString nameEs;

  late final _i1.ColumnString countryCode;

  late final _i1.ColumnDouble latitude;

  late final _i1.ColumnDouble longitude;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnBool isPopular;

  late final _i1.ColumnInt displayOrder;

  late final _i1.ColumnDouble defaultDeliveryRadius;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    nameEn,
    nameAr,
    nameFr,
    nameEs,
    countryCode,
    latitude,
    longitude,
    isActive,
    isPopular,
    displayOrder,
    defaultDeliveryRadius,
    createdAt,
  ];
}

class CityInclude extends _i1.IncludeObject {
  CityInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => City.t;
}

class CityIncludeList extends _i1.IncludeList {
  CityIncludeList._({
    _i1.WhereExpressionBuilder<CityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(City.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => City.t;
}

class CityRepository {
  const CityRepository._();

  /// Returns a list of [City]s matching the given query parameters.
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
  Future<List<City>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CityTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<City>(
      where: where?.call(City.t),
      orderBy: orderBy?.call(City.t),
      orderByList: orderByList?.call(City.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [City] matching the given query parameters.
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
  Future<City?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CityTable>? where,
    int? offset,
    _i1.OrderByBuilder<CityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CityTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<City>(
      where: where?.call(City.t),
      orderBy: orderBy?.call(City.t),
      orderByList: orderByList?.call(City.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [City] by its [id] or null if no such row exists.
  Future<City?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<City>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [City]s in the list and returns the inserted rows.
  ///
  /// The returned [City]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<City>> insert(
    _i1.Session session,
    List<City> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<City>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [City] and returns the inserted row.
  ///
  /// The returned [City] will have its `id` field set.
  Future<City> insertRow(
    _i1.Session session,
    City row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<City>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [City]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<City>> update(
    _i1.Session session,
    List<City> rows, {
    _i1.ColumnSelections<CityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<City>(
      rows,
      columns: columns?.call(City.t),
      transaction: transaction,
    );
  }

  /// Updates a single [City]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<City> updateRow(
    _i1.Session session,
    City row, {
    _i1.ColumnSelections<CityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<City>(
      row,
      columns: columns?.call(City.t),
      transaction: transaction,
    );
  }

  /// Updates a single [City] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<City?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<CityUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<City>(
      id,
      columnValues: columnValues(City.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [City]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<City>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<CityUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CityTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CityTable>? orderBy,
    _i1.OrderByListBuilder<CityTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<City>(
      columnValues: columnValues(City.t.updateTable),
      where: where(City.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(City.t),
      orderByList: orderByList?.call(City.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [City]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<City>> delete(
    _i1.Session session,
    List<City> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<City>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [City].
  Future<City> deleteRow(
    _i1.Session session,
    City row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<City>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<City>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CityTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<City>(
      where: where(City.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CityTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<City>(
      where: where?.call(City.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
