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

abstract class Country
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Country._({
    this.id,
    required this.code,
    required this.name,
    this.nameAr,
    this.nameFr,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyName,
    this.currencyNameAr,
    double? vatRate,
    String? vatName,
    this.phonePrefix,
    this.phonePlaceholder,
    String? defaultLanguage,
    double? minPrice,
    double? commissionRate,
    double? exchangeRateToMAD,
    this.exchangeRateUpdatedAt,
    bool? isActive,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : vatRate = vatRate ?? 0.0,
       vatName = vatName ?? 'VAT',
       defaultLanguage = defaultLanguage ?? 'en',
       minPrice = minPrice ?? 15.0,
       commissionRate = commissionRate ?? 0.05,
       exchangeRateToMAD = exchangeRateToMAD ?? 1.0,
       isActive = isActive ?? true,
       isDefault = isDefault ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Country({
    int? id,
    required String code,
    required String name,
    String? nameAr,
    String? nameFr,
    required String currencyCode,
    required String currencySymbol,
    required String currencyName,
    String? currencyNameAr,
    double? vatRate,
    String? vatName,
    String? phonePrefix,
    String? phonePlaceholder,
    String? defaultLanguage,
    double? minPrice,
    double? commissionRate,
    double? exchangeRateToMAD,
    DateTime? exchangeRateUpdatedAt,
    bool? isActive,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CountryImpl;

  factory Country.fromJson(Map<String, dynamic> jsonSerialization) {
    return Country(
      id: jsonSerialization['id'] as int?,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      nameAr: jsonSerialization['nameAr'] as String?,
      nameFr: jsonSerialization['nameFr'] as String?,
      currencyCode: jsonSerialization['currencyCode'] as String,
      currencySymbol: jsonSerialization['currencySymbol'] as String,
      currencyName: jsonSerialization['currencyName'] as String,
      currencyNameAr: jsonSerialization['currencyNameAr'] as String?,
      vatRate: (jsonSerialization['vatRate'] as num).toDouble(),
      vatName: jsonSerialization['vatName'] as String,
      phonePrefix: jsonSerialization['phonePrefix'] as String?,
      phonePlaceholder: jsonSerialization['phonePlaceholder'] as String?,
      defaultLanguage: jsonSerialization['defaultLanguage'] as String,
      minPrice: (jsonSerialization['minPrice'] as num).toDouble(),
      commissionRate: (jsonSerialization['commissionRate'] as num).toDouble(),
      exchangeRateToMAD: (jsonSerialization['exchangeRateToMAD'] as num)
          .toDouble(),
      exchangeRateUpdatedAt: jsonSerialization['exchangeRateUpdatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['exchangeRateUpdatedAt'],
            ),
      isActive: jsonSerialization['isActive'] as bool,
      isDefault: jsonSerialization['isDefault'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = CountryTable();

  static const db = CountryRepository._();

  @override
  int? id;

  String code;

  String name;

  String? nameAr;

  String? nameFr;

  String currencyCode;

  String currencySymbol;

  String currencyName;

  String? currencyNameAr;

  double vatRate;

  String vatName;

  String? phonePrefix;

  String? phonePlaceholder;

  String defaultLanguage;

  double minPrice;

  double commissionRate;

  double exchangeRateToMAD;

  DateTime? exchangeRateUpdatedAt;

  bool isActive;

  bool isDefault;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Country]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Country copyWith({
    int? id,
    String? code,
    String? name,
    String? nameAr,
    String? nameFr,
    String? currencyCode,
    String? currencySymbol,
    String? currencyName,
    String? currencyNameAr,
    double? vatRate,
    String? vatName,
    String? phonePrefix,
    String? phonePlaceholder,
    String? defaultLanguage,
    double? minPrice,
    double? commissionRate,
    double? exchangeRateToMAD,
    DateTime? exchangeRateUpdatedAt,
    bool? isActive,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Country',
      if (id != null) 'id': id,
      'code': code,
      'name': name,
      if (nameAr != null) 'nameAr': nameAr,
      if (nameFr != null) 'nameFr': nameFr,
      'currencyCode': currencyCode,
      'currencySymbol': currencySymbol,
      'currencyName': currencyName,
      if (currencyNameAr != null) 'currencyNameAr': currencyNameAr,
      'vatRate': vatRate,
      'vatName': vatName,
      if (phonePrefix != null) 'phonePrefix': phonePrefix,
      if (phonePlaceholder != null) 'phonePlaceholder': phonePlaceholder,
      'defaultLanguage': defaultLanguage,
      'minPrice': minPrice,
      'commissionRate': commissionRate,
      'exchangeRateToMAD': exchangeRateToMAD,
      if (exchangeRateUpdatedAt != null)
        'exchangeRateUpdatedAt': exchangeRateUpdatedAt?.toJson(),
      'isActive': isActive,
      'isDefault': isDefault,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Country',
      if (id != null) 'id': id,
      'code': code,
      'name': name,
      if (nameAr != null) 'nameAr': nameAr,
      if (nameFr != null) 'nameFr': nameFr,
      'currencyCode': currencyCode,
      'currencySymbol': currencySymbol,
      'currencyName': currencyName,
      if (currencyNameAr != null) 'currencyNameAr': currencyNameAr,
      'vatRate': vatRate,
      'vatName': vatName,
      if (phonePrefix != null) 'phonePrefix': phonePrefix,
      if (phonePlaceholder != null) 'phonePlaceholder': phonePlaceholder,
      'defaultLanguage': defaultLanguage,
      'minPrice': minPrice,
      'commissionRate': commissionRate,
      'exchangeRateToMAD': exchangeRateToMAD,
      if (exchangeRateUpdatedAt != null)
        'exchangeRateUpdatedAt': exchangeRateUpdatedAt?.toJson(),
      'isActive': isActive,
      'isDefault': isDefault,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static CountryInclude include() {
    return CountryInclude._();
  }

  static CountryIncludeList includeList({
    _i1.WhereExpressionBuilder<CountryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CountryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CountryTable>? orderByList,
    CountryInclude? include,
  }) {
    return CountryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Country.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Country.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CountryImpl extends Country {
  _CountryImpl({
    int? id,
    required String code,
    required String name,
    String? nameAr,
    String? nameFr,
    required String currencyCode,
    required String currencySymbol,
    required String currencyName,
    String? currencyNameAr,
    double? vatRate,
    String? vatName,
    String? phonePrefix,
    String? phonePlaceholder,
    String? defaultLanguage,
    double? minPrice,
    double? commissionRate,
    double? exchangeRateToMAD,
    DateTime? exchangeRateUpdatedAt,
    bool? isActive,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         code: code,
         name: name,
         nameAr: nameAr,
         nameFr: nameFr,
         currencyCode: currencyCode,
         currencySymbol: currencySymbol,
         currencyName: currencyName,
         currencyNameAr: currencyNameAr,
         vatRate: vatRate,
         vatName: vatName,
         phonePrefix: phonePrefix,
         phonePlaceholder: phonePlaceholder,
         defaultLanguage: defaultLanguage,
         minPrice: minPrice,
         commissionRate: commissionRate,
         exchangeRateToMAD: exchangeRateToMAD,
         exchangeRateUpdatedAt: exchangeRateUpdatedAt,
         isActive: isActive,
         isDefault: isDefault,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Country]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Country copyWith({
    Object? id = _Undefined,
    String? code,
    String? name,
    Object? nameAr = _Undefined,
    Object? nameFr = _Undefined,
    String? currencyCode,
    String? currencySymbol,
    String? currencyName,
    Object? currencyNameAr = _Undefined,
    double? vatRate,
    String? vatName,
    Object? phonePrefix = _Undefined,
    Object? phonePlaceholder = _Undefined,
    String? defaultLanguage,
    double? minPrice,
    double? commissionRate,
    double? exchangeRateToMAD,
    Object? exchangeRateUpdatedAt = _Undefined,
    bool? isActive,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Country(
      id: id is int? ? id : this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      nameAr: nameAr is String? ? nameAr : this.nameAr,
      nameFr: nameFr is String? ? nameFr : this.nameFr,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyName: currencyName ?? this.currencyName,
      currencyNameAr: currencyNameAr is String?
          ? currencyNameAr
          : this.currencyNameAr,
      vatRate: vatRate ?? this.vatRate,
      vatName: vatName ?? this.vatName,
      phonePrefix: phonePrefix is String? ? phonePrefix : this.phonePrefix,
      phonePlaceholder: phonePlaceholder is String?
          ? phonePlaceholder
          : this.phonePlaceholder,
      defaultLanguage: defaultLanguage ?? this.defaultLanguage,
      minPrice: minPrice ?? this.minPrice,
      commissionRate: commissionRate ?? this.commissionRate,
      exchangeRateToMAD: exchangeRateToMAD ?? this.exchangeRateToMAD,
      exchangeRateUpdatedAt: exchangeRateUpdatedAt is DateTime?
          ? exchangeRateUpdatedAt
          : this.exchangeRateUpdatedAt,
      isActive: isActive ?? this.isActive,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CountryUpdateTable extends _i1.UpdateTable<CountryTable> {
  CountryUpdateTable(super.table);

  _i1.ColumnValue<String, String> code(String value) => _i1.ColumnValue(
    table.code,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
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

  _i1.ColumnValue<String, String> currencyCode(String value) => _i1.ColumnValue(
    table.currencyCode,
    value,
  );

  _i1.ColumnValue<String, String> currencySymbol(String value) =>
      _i1.ColumnValue(
        table.currencySymbol,
        value,
      );

  _i1.ColumnValue<String, String> currencyName(String value) => _i1.ColumnValue(
    table.currencyName,
    value,
  );

  _i1.ColumnValue<String, String> currencyNameAr(String? value) =>
      _i1.ColumnValue(
        table.currencyNameAr,
        value,
      );

  _i1.ColumnValue<double, double> vatRate(double value) => _i1.ColumnValue(
    table.vatRate,
    value,
  );

  _i1.ColumnValue<String, String> vatName(String value) => _i1.ColumnValue(
    table.vatName,
    value,
  );

  _i1.ColumnValue<String, String> phonePrefix(String? value) => _i1.ColumnValue(
    table.phonePrefix,
    value,
  );

  _i1.ColumnValue<String, String> phonePlaceholder(String? value) =>
      _i1.ColumnValue(
        table.phonePlaceholder,
        value,
      );

  _i1.ColumnValue<String, String> defaultLanguage(String value) =>
      _i1.ColumnValue(
        table.defaultLanguage,
        value,
      );

  _i1.ColumnValue<double, double> minPrice(double value) => _i1.ColumnValue(
    table.minPrice,
    value,
  );

  _i1.ColumnValue<double, double> commissionRate(double value) =>
      _i1.ColumnValue(
        table.commissionRate,
        value,
      );

  _i1.ColumnValue<double, double> exchangeRateToMAD(double value) =>
      _i1.ColumnValue(
        table.exchangeRateToMAD,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> exchangeRateUpdatedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.exchangeRateUpdatedAt,
        value,
      );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<bool, bool> isDefault(bool value) => _i1.ColumnValue(
    table.isDefault,
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

class CountryTable extends _i1.Table<int?> {
  CountryTable({super.tableRelation}) : super(tableName: 'countries') {
    updateTable = CountryUpdateTable(this);
    code = _i1.ColumnString(
      'code',
      this,
    );
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
    currencyCode = _i1.ColumnString(
      'currencyCode',
      this,
    );
    currencySymbol = _i1.ColumnString(
      'currencySymbol',
      this,
    );
    currencyName = _i1.ColumnString(
      'currencyName',
      this,
    );
    currencyNameAr = _i1.ColumnString(
      'currencyNameAr',
      this,
    );
    vatRate = _i1.ColumnDouble(
      'vatRate',
      this,
      hasDefault: true,
    );
    vatName = _i1.ColumnString(
      'vatName',
      this,
      hasDefault: true,
    );
    phonePrefix = _i1.ColumnString(
      'phonePrefix',
      this,
    );
    phonePlaceholder = _i1.ColumnString(
      'phonePlaceholder',
      this,
    );
    defaultLanguage = _i1.ColumnString(
      'defaultLanguage',
      this,
      hasDefault: true,
    );
    minPrice = _i1.ColumnDouble(
      'minPrice',
      this,
      hasDefault: true,
    );
    commissionRate = _i1.ColumnDouble(
      'commissionRate',
      this,
      hasDefault: true,
    );
    exchangeRateToMAD = _i1.ColumnDouble(
      'exchangeRateToMAD',
      this,
      hasDefault: true,
    );
    exchangeRateUpdatedAt = _i1.ColumnDateTime(
      'exchangeRateUpdatedAt',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    isDefault = _i1.ColumnBool(
      'isDefault',
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

  late final CountryUpdateTable updateTable;

  late final _i1.ColumnString code;

  late final _i1.ColumnString name;

  late final _i1.ColumnString nameAr;

  late final _i1.ColumnString nameFr;

  late final _i1.ColumnString currencyCode;

  late final _i1.ColumnString currencySymbol;

  late final _i1.ColumnString currencyName;

  late final _i1.ColumnString currencyNameAr;

  late final _i1.ColumnDouble vatRate;

  late final _i1.ColumnString vatName;

  late final _i1.ColumnString phonePrefix;

  late final _i1.ColumnString phonePlaceholder;

  late final _i1.ColumnString defaultLanguage;

  late final _i1.ColumnDouble minPrice;

  late final _i1.ColumnDouble commissionRate;

  late final _i1.ColumnDouble exchangeRateToMAD;

  late final _i1.ColumnDateTime exchangeRateUpdatedAt;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnBool isDefault;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    code,
    name,
    nameAr,
    nameFr,
    currencyCode,
    currencySymbol,
    currencyName,
    currencyNameAr,
    vatRate,
    vatName,
    phonePrefix,
    phonePlaceholder,
    defaultLanguage,
    minPrice,
    commissionRate,
    exchangeRateToMAD,
    exchangeRateUpdatedAt,
    isActive,
    isDefault,
    createdAt,
    updatedAt,
  ];
}

class CountryInclude extends _i1.IncludeObject {
  CountryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Country.t;
}

class CountryIncludeList extends _i1.IncludeList {
  CountryIncludeList._({
    _i1.WhereExpressionBuilder<CountryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Country.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Country.t;
}

class CountryRepository {
  const CountryRepository._();

  /// Returns a list of [Country]s matching the given query parameters.
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
  Future<List<Country>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CountryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CountryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CountryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Country>(
      where: where?.call(Country.t),
      orderBy: orderBy?.call(Country.t),
      orderByList: orderByList?.call(Country.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Country] matching the given query parameters.
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
  Future<Country?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CountryTable>? where,
    int? offset,
    _i1.OrderByBuilder<CountryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CountryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Country>(
      where: where?.call(Country.t),
      orderBy: orderBy?.call(Country.t),
      orderByList: orderByList?.call(Country.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Country] by its [id] or null if no such row exists.
  Future<Country?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Country>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Country]s in the list and returns the inserted rows.
  ///
  /// The returned [Country]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Country>> insert(
    _i1.Session session,
    List<Country> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Country>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Country] and returns the inserted row.
  ///
  /// The returned [Country] will have its `id` field set.
  Future<Country> insertRow(
    _i1.Session session,
    Country row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Country>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Country]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Country>> update(
    _i1.Session session,
    List<Country> rows, {
    _i1.ColumnSelections<CountryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Country>(
      rows,
      columns: columns?.call(Country.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Country]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Country> updateRow(
    _i1.Session session,
    Country row, {
    _i1.ColumnSelections<CountryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Country>(
      row,
      columns: columns?.call(Country.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Country] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Country?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<CountryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Country>(
      id,
      columnValues: columnValues(Country.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Country]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Country>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<CountryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CountryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CountryTable>? orderBy,
    _i1.OrderByListBuilder<CountryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Country>(
      columnValues: columnValues(Country.t.updateTable),
      where: where(Country.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Country.t),
      orderByList: orderByList?.call(Country.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Country]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Country>> delete(
    _i1.Session session,
    List<Country> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Country>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Country].
  Future<Country> deleteRow(
    _i1.Session session,
    Country row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Country>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Country>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CountryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Country>(
      where: where(Country.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CountryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Country>(
      where: where?.call(Country.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
