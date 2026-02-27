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

abstract class Address
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Address._({
    this.id,
    required this.userId,
    required this.label,
    required this.fullAddress,
    required this.cityId,
    required this.latitude,
    required this.longitude,
    this.buildingNumber,
    this.floor,
    this.apartmentNumber,
    this.landmark,
    this.instructions,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isDefault = isDefault ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Address({
    int? id,
    required int userId,
    required String label,
    required String fullAddress,
    required int cityId,
    required double latitude,
    required double longitude,
    String? buildingNumber,
    String? floor,
    String? apartmentNumber,
    String? landmark,
    String? instructions,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AddressImpl;

  factory Address.fromJson(Map<String, dynamic> jsonSerialization) {
    return Address(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      label: jsonSerialization['label'] as String,
      fullAddress: jsonSerialization['fullAddress'] as String,
      cityId: jsonSerialization['cityId'] as int,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      buildingNumber: jsonSerialization['buildingNumber'] as String?,
      floor: jsonSerialization['floor'] as String?,
      apartmentNumber: jsonSerialization['apartmentNumber'] as String?,
      landmark: jsonSerialization['landmark'] as String?,
      instructions: jsonSerialization['instructions'] as String?,
      isDefault: jsonSerialization['isDefault'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = AddressTable();

  static const db = AddressRepository._();

  @override
  int? id;

  int userId;

  String label;

  String fullAddress;

  int cityId;

  double latitude;

  double longitude;

  String? buildingNumber;

  String? floor;

  String? apartmentNumber;

  String? landmark;

  String? instructions;

  bool isDefault;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Address]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Address copyWith({
    int? id,
    int? userId,
    String? label,
    String? fullAddress,
    int? cityId,
    double? latitude,
    double? longitude,
    String? buildingNumber,
    String? floor,
    String? apartmentNumber,
    String? landmark,
    String? instructions,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Address',
      if (id != null) 'id': id,
      'userId': userId,
      'label': label,
      'fullAddress': fullAddress,
      'cityId': cityId,
      'latitude': latitude,
      'longitude': longitude,
      if (buildingNumber != null) 'buildingNumber': buildingNumber,
      if (floor != null) 'floor': floor,
      if (apartmentNumber != null) 'apartmentNumber': apartmentNumber,
      if (landmark != null) 'landmark': landmark,
      if (instructions != null) 'instructions': instructions,
      'isDefault': isDefault,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Address',
      if (id != null) 'id': id,
      'userId': userId,
      'label': label,
      'fullAddress': fullAddress,
      'cityId': cityId,
      'latitude': latitude,
      'longitude': longitude,
      if (buildingNumber != null) 'buildingNumber': buildingNumber,
      if (floor != null) 'floor': floor,
      if (apartmentNumber != null) 'apartmentNumber': apartmentNumber,
      if (landmark != null) 'landmark': landmark,
      if (instructions != null) 'instructions': instructions,
      'isDefault': isDefault,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static AddressInclude include() {
    return AddressInclude._();
  }

  static AddressIncludeList includeList({
    _i1.WhereExpressionBuilder<AddressTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AddressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AddressTable>? orderByList,
    AddressInclude? include,
  }) {
    return AddressIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Address.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Address.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AddressImpl extends Address {
  _AddressImpl({
    int? id,
    required int userId,
    required String label,
    required String fullAddress,
    required int cityId,
    required double latitude,
    required double longitude,
    String? buildingNumber,
    String? floor,
    String? apartmentNumber,
    String? landmark,
    String? instructions,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         label: label,
         fullAddress: fullAddress,
         cityId: cityId,
         latitude: latitude,
         longitude: longitude,
         buildingNumber: buildingNumber,
         floor: floor,
         apartmentNumber: apartmentNumber,
         landmark: landmark,
         instructions: instructions,
         isDefault: isDefault,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Address]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Address copyWith({
    Object? id = _Undefined,
    int? userId,
    String? label,
    String? fullAddress,
    int? cityId,
    double? latitude,
    double? longitude,
    Object? buildingNumber = _Undefined,
    Object? floor = _Undefined,
    Object? apartmentNumber = _Undefined,
    Object? landmark = _Undefined,
    Object? instructions = _Undefined,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Address(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      label: label ?? this.label,
      fullAddress: fullAddress ?? this.fullAddress,
      cityId: cityId ?? this.cityId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      buildingNumber: buildingNumber is String?
          ? buildingNumber
          : this.buildingNumber,
      floor: floor is String? ? floor : this.floor,
      apartmentNumber: apartmentNumber is String?
          ? apartmentNumber
          : this.apartmentNumber,
      landmark: landmark is String? ? landmark : this.landmark,
      instructions: instructions is String? ? instructions : this.instructions,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class AddressUpdateTable extends _i1.UpdateTable<AddressTable> {
  AddressUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> label(String value) => _i1.ColumnValue(
    table.label,
    value,
  );

  _i1.ColumnValue<String, String> fullAddress(String value) => _i1.ColumnValue(
    table.fullAddress,
    value,
  );

  _i1.ColumnValue<int, int> cityId(int value) => _i1.ColumnValue(
    table.cityId,
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

  _i1.ColumnValue<String, String> buildingNumber(String? value) =>
      _i1.ColumnValue(
        table.buildingNumber,
        value,
      );

  _i1.ColumnValue<String, String> floor(String? value) => _i1.ColumnValue(
    table.floor,
    value,
  );

  _i1.ColumnValue<String, String> apartmentNumber(String? value) =>
      _i1.ColumnValue(
        table.apartmentNumber,
        value,
      );

  _i1.ColumnValue<String, String> landmark(String? value) => _i1.ColumnValue(
    table.landmark,
    value,
  );

  _i1.ColumnValue<String, String> instructions(String? value) =>
      _i1.ColumnValue(
        table.instructions,
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

class AddressTable extends _i1.Table<int?> {
  AddressTable({super.tableRelation}) : super(tableName: 'addresses') {
    updateTable = AddressUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    label = _i1.ColumnString(
      'label',
      this,
    );
    fullAddress = _i1.ColumnString(
      'fullAddress',
      this,
    );
    cityId = _i1.ColumnInt(
      'cityId',
      this,
    );
    latitude = _i1.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _i1.ColumnDouble(
      'longitude',
      this,
    );
    buildingNumber = _i1.ColumnString(
      'buildingNumber',
      this,
    );
    floor = _i1.ColumnString(
      'floor',
      this,
    );
    apartmentNumber = _i1.ColumnString(
      'apartmentNumber',
      this,
    );
    landmark = _i1.ColumnString(
      'landmark',
      this,
    );
    instructions = _i1.ColumnString(
      'instructions',
      this,
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

  late final AddressUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString label;

  late final _i1.ColumnString fullAddress;

  late final _i1.ColumnInt cityId;

  late final _i1.ColumnDouble latitude;

  late final _i1.ColumnDouble longitude;

  late final _i1.ColumnString buildingNumber;

  late final _i1.ColumnString floor;

  late final _i1.ColumnString apartmentNumber;

  late final _i1.ColumnString landmark;

  late final _i1.ColumnString instructions;

  late final _i1.ColumnBool isDefault;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    label,
    fullAddress,
    cityId,
    latitude,
    longitude,
    buildingNumber,
    floor,
    apartmentNumber,
    landmark,
    instructions,
    isDefault,
    createdAt,
    updatedAt,
  ];
}

class AddressInclude extends _i1.IncludeObject {
  AddressInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Address.t;
}

class AddressIncludeList extends _i1.IncludeList {
  AddressIncludeList._({
    _i1.WhereExpressionBuilder<AddressTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Address.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Address.t;
}

class AddressRepository {
  const AddressRepository._();

  /// Returns a list of [Address]s matching the given query parameters.
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
  Future<List<Address>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AddressTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AddressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AddressTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Address>(
      where: where?.call(Address.t),
      orderBy: orderBy?.call(Address.t),
      orderByList: orderByList?.call(Address.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Address] matching the given query parameters.
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
  Future<Address?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AddressTable>? where,
    int? offset,
    _i1.OrderByBuilder<AddressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AddressTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Address>(
      where: where?.call(Address.t),
      orderBy: orderBy?.call(Address.t),
      orderByList: orderByList?.call(Address.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Address] by its [id] or null if no such row exists.
  Future<Address?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Address>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Address]s in the list and returns the inserted rows.
  ///
  /// The returned [Address]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Address>> insert(
    _i1.Session session,
    List<Address> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Address>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Address] and returns the inserted row.
  ///
  /// The returned [Address] will have its `id` field set.
  Future<Address> insertRow(
    _i1.Session session,
    Address row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Address>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Address]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Address>> update(
    _i1.Session session,
    List<Address> rows, {
    _i1.ColumnSelections<AddressTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Address>(
      rows,
      columns: columns?.call(Address.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Address]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Address> updateRow(
    _i1.Session session,
    Address row, {
    _i1.ColumnSelections<AddressTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Address>(
      row,
      columns: columns?.call(Address.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Address] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Address?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<AddressUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Address>(
      id,
      columnValues: columnValues(Address.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Address]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Address>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<AddressUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AddressTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AddressTable>? orderBy,
    _i1.OrderByListBuilder<AddressTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Address>(
      columnValues: columnValues(Address.t.updateTable),
      where: where(Address.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Address.t),
      orderByList: orderByList?.call(Address.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Address]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Address>> delete(
    _i1.Session session,
    List<Address> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Address>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Address].
  Future<Address> deleteRow(
    _i1.Session session,
    Address row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Address>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Address>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AddressTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Address>(
      where: where(Address.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AddressTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Address>(
      where: where?.call(Address.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
