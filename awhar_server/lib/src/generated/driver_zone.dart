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

abstract class DriverZone
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DriverZone._({
    this.id,
    required this.driverId,
    required this.zoneName,
    required this.cityId,
    this.geoBoundary,
    required this.centerLatitude,
    required this.centerLongitude,
    double? radiusKm,
    double? extraFeeOutsideZone,
    bool? isPrimary,
    bool? isActive,
    DateTime? createdAt,
  }) : radiusKm = radiusKm ?? 5.0,
       extraFeeOutsideZone = extraFeeOutsideZone ?? 0.0,
       isPrimary = isPrimary ?? false,
       isActive = isActive ?? true,
       createdAt = createdAt ?? DateTime.now();

  factory DriverZone({
    int? id,
    required int driverId,
    required String zoneName,
    required int cityId,
    String? geoBoundary,
    required double centerLatitude,
    required double centerLongitude,
    double? radiusKm,
    double? extraFeeOutsideZone,
    bool? isPrimary,
    bool? isActive,
    DateTime? createdAt,
  }) = _DriverZoneImpl;

  factory DriverZone.fromJson(Map<String, dynamic> jsonSerialization) {
    return DriverZone(
      id: jsonSerialization['id'] as int?,
      driverId: jsonSerialization['driverId'] as int,
      zoneName: jsonSerialization['zoneName'] as String,
      cityId: jsonSerialization['cityId'] as int,
      geoBoundary: jsonSerialization['geoBoundary'] as String?,
      centerLatitude: (jsonSerialization['centerLatitude'] as num).toDouble(),
      centerLongitude: (jsonSerialization['centerLongitude'] as num).toDouble(),
      radiusKm: (jsonSerialization['radiusKm'] as num).toDouble(),
      extraFeeOutsideZone: (jsonSerialization['extraFeeOutsideZone'] as num)
          .toDouble(),
      isPrimary: jsonSerialization['isPrimary'] as bool,
      isActive: jsonSerialization['isActive'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = DriverZoneTable();

  static const db = DriverZoneRepository._();

  @override
  int? id;

  int driverId;

  String zoneName;

  int cityId;

  String? geoBoundary;

  double centerLatitude;

  double centerLongitude;

  double radiusKm;

  double extraFeeOutsideZone;

  bool isPrimary;

  bool isActive;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DriverZone]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DriverZone copyWith({
    int? id,
    int? driverId,
    String? zoneName,
    int? cityId,
    String? geoBoundary,
    double? centerLatitude,
    double? centerLongitude,
    double? radiusKm,
    double? extraFeeOutsideZone,
    bool? isPrimary,
    bool? isActive,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DriverZone',
      if (id != null) 'id': id,
      'driverId': driverId,
      'zoneName': zoneName,
      'cityId': cityId,
      if (geoBoundary != null) 'geoBoundary': geoBoundary,
      'centerLatitude': centerLatitude,
      'centerLongitude': centerLongitude,
      'radiusKm': radiusKm,
      'extraFeeOutsideZone': extraFeeOutsideZone,
      'isPrimary': isPrimary,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DriverZone',
      if (id != null) 'id': id,
      'driverId': driverId,
      'zoneName': zoneName,
      'cityId': cityId,
      if (geoBoundary != null) 'geoBoundary': geoBoundary,
      'centerLatitude': centerLatitude,
      'centerLongitude': centerLongitude,
      'radiusKm': radiusKm,
      'extraFeeOutsideZone': extraFeeOutsideZone,
      'isPrimary': isPrimary,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  static DriverZoneInclude include() {
    return DriverZoneInclude._();
  }

  static DriverZoneIncludeList includeList({
    _i1.WhereExpressionBuilder<DriverZoneTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverZoneTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverZoneTable>? orderByList,
    DriverZoneInclude? include,
  }) {
    return DriverZoneIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DriverZone.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DriverZone.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DriverZoneImpl extends DriverZone {
  _DriverZoneImpl({
    int? id,
    required int driverId,
    required String zoneName,
    required int cityId,
    String? geoBoundary,
    required double centerLatitude,
    required double centerLongitude,
    double? radiusKm,
    double? extraFeeOutsideZone,
    bool? isPrimary,
    bool? isActive,
    DateTime? createdAt,
  }) : super._(
         id: id,
         driverId: driverId,
         zoneName: zoneName,
         cityId: cityId,
         geoBoundary: geoBoundary,
         centerLatitude: centerLatitude,
         centerLongitude: centerLongitude,
         radiusKm: radiusKm,
         extraFeeOutsideZone: extraFeeOutsideZone,
         isPrimary: isPrimary,
         isActive: isActive,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [DriverZone]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DriverZone copyWith({
    Object? id = _Undefined,
    int? driverId,
    String? zoneName,
    int? cityId,
    Object? geoBoundary = _Undefined,
    double? centerLatitude,
    double? centerLongitude,
    double? radiusKm,
    double? extraFeeOutsideZone,
    bool? isPrimary,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return DriverZone(
      id: id is int? ? id : this.id,
      driverId: driverId ?? this.driverId,
      zoneName: zoneName ?? this.zoneName,
      cityId: cityId ?? this.cityId,
      geoBoundary: geoBoundary is String? ? geoBoundary : this.geoBoundary,
      centerLatitude: centerLatitude ?? this.centerLatitude,
      centerLongitude: centerLongitude ?? this.centerLongitude,
      radiusKm: radiusKm ?? this.radiusKm,
      extraFeeOutsideZone: extraFeeOutsideZone ?? this.extraFeeOutsideZone,
      isPrimary: isPrimary ?? this.isPrimary,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class DriverZoneUpdateTable extends _i1.UpdateTable<DriverZoneTable> {
  DriverZoneUpdateTable(super.table);

  _i1.ColumnValue<int, int> driverId(int value) => _i1.ColumnValue(
    table.driverId,
    value,
  );

  _i1.ColumnValue<String, String> zoneName(String value) => _i1.ColumnValue(
    table.zoneName,
    value,
  );

  _i1.ColumnValue<int, int> cityId(int value) => _i1.ColumnValue(
    table.cityId,
    value,
  );

  _i1.ColumnValue<String, String> geoBoundary(String? value) => _i1.ColumnValue(
    table.geoBoundary,
    value,
  );

  _i1.ColumnValue<double, double> centerLatitude(double value) =>
      _i1.ColumnValue(
        table.centerLatitude,
        value,
      );

  _i1.ColumnValue<double, double> centerLongitude(double value) =>
      _i1.ColumnValue(
        table.centerLongitude,
        value,
      );

  _i1.ColumnValue<double, double> radiusKm(double value) => _i1.ColumnValue(
    table.radiusKm,
    value,
  );

  _i1.ColumnValue<double, double> extraFeeOutsideZone(double value) =>
      _i1.ColumnValue(
        table.extraFeeOutsideZone,
        value,
      );

  _i1.ColumnValue<bool, bool> isPrimary(bool value) => _i1.ColumnValue(
    table.isPrimary,
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
}

class DriverZoneTable extends _i1.Table<int?> {
  DriverZoneTable({super.tableRelation}) : super(tableName: 'driver_zones') {
    updateTable = DriverZoneUpdateTable(this);
    driverId = _i1.ColumnInt(
      'driverId',
      this,
    );
    zoneName = _i1.ColumnString(
      'zoneName',
      this,
    );
    cityId = _i1.ColumnInt(
      'cityId',
      this,
    );
    geoBoundary = _i1.ColumnString(
      'geoBoundary',
      this,
    );
    centerLatitude = _i1.ColumnDouble(
      'centerLatitude',
      this,
    );
    centerLongitude = _i1.ColumnDouble(
      'centerLongitude',
      this,
    );
    radiusKm = _i1.ColumnDouble(
      'radiusKm',
      this,
      hasDefault: true,
    );
    extraFeeOutsideZone = _i1.ColumnDouble(
      'extraFeeOutsideZone',
      this,
      hasDefault: true,
    );
    isPrimary = _i1.ColumnBool(
      'isPrimary',
      this,
      hasDefault: true,
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
  }

  late final DriverZoneUpdateTable updateTable;

  late final _i1.ColumnInt driverId;

  late final _i1.ColumnString zoneName;

  late final _i1.ColumnInt cityId;

  late final _i1.ColumnString geoBoundary;

  late final _i1.ColumnDouble centerLatitude;

  late final _i1.ColumnDouble centerLongitude;

  late final _i1.ColumnDouble radiusKm;

  late final _i1.ColumnDouble extraFeeOutsideZone;

  late final _i1.ColumnBool isPrimary;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    driverId,
    zoneName,
    cityId,
    geoBoundary,
    centerLatitude,
    centerLongitude,
    radiusKm,
    extraFeeOutsideZone,
    isPrimary,
    isActive,
    createdAt,
  ];
}

class DriverZoneInclude extends _i1.IncludeObject {
  DriverZoneInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DriverZone.t;
}

class DriverZoneIncludeList extends _i1.IncludeList {
  DriverZoneIncludeList._({
    _i1.WhereExpressionBuilder<DriverZoneTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DriverZone.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DriverZone.t;
}

class DriverZoneRepository {
  const DriverZoneRepository._();

  /// Returns a list of [DriverZone]s matching the given query parameters.
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
  Future<List<DriverZone>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverZoneTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverZoneTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverZoneTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<DriverZone>(
      where: where?.call(DriverZone.t),
      orderBy: orderBy?.call(DriverZone.t),
      orderByList: orderByList?.call(DriverZone.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [DriverZone] matching the given query parameters.
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
  Future<DriverZone?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverZoneTable>? where,
    int? offset,
    _i1.OrderByBuilder<DriverZoneTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverZoneTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<DriverZone>(
      where: where?.call(DriverZone.t),
      orderBy: orderBy?.call(DriverZone.t),
      orderByList: orderByList?.call(DriverZone.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [DriverZone] by its [id] or null if no such row exists.
  Future<DriverZone?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<DriverZone>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [DriverZone]s in the list and returns the inserted rows.
  ///
  /// The returned [DriverZone]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<DriverZone>> insert(
    _i1.Session session,
    List<DriverZone> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<DriverZone>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [DriverZone] and returns the inserted row.
  ///
  /// The returned [DriverZone] will have its `id` field set.
  Future<DriverZone> insertRow(
    _i1.Session session,
    DriverZone row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DriverZone>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DriverZone]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DriverZone>> update(
    _i1.Session session,
    List<DriverZone> rows, {
    _i1.ColumnSelections<DriverZoneTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DriverZone>(
      rows,
      columns: columns?.call(DriverZone.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DriverZone]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DriverZone> updateRow(
    _i1.Session session,
    DriverZone row, {
    _i1.ColumnSelections<DriverZoneTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DriverZone>(
      row,
      columns: columns?.call(DriverZone.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DriverZone] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DriverZone?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<DriverZoneUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DriverZone>(
      id,
      columnValues: columnValues(DriverZone.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DriverZone]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DriverZone>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DriverZoneUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DriverZoneTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverZoneTable>? orderBy,
    _i1.OrderByListBuilder<DriverZoneTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DriverZone>(
      columnValues: columnValues(DriverZone.t.updateTable),
      where: where(DriverZone.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DriverZone.t),
      orderByList: orderByList?.call(DriverZone.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DriverZone]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DriverZone>> delete(
    _i1.Session session,
    List<DriverZone> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DriverZone>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DriverZone].
  Future<DriverZone> deleteRow(
    _i1.Session session,
    DriverZone row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DriverZone>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DriverZone>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DriverZoneTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DriverZone>(
      where: where(DriverZone.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverZoneTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DriverZone>(
      where: where?.call(DriverZone.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
