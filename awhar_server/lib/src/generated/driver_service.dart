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
import 'price_type_enum.dart' as _i2;

abstract class DriverService
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DriverService._({
    this.id,
    required this.driverId,
    required this.serviceId,
    this.categoryId,
    this.priceType,
    this.basePrice,
    this.pricePerKm,
    this.pricePerHour,
    this.minPrice,
    this.title,
    this.imageUrl,
    this.description,
    this.customDescription,
    int? viewCount,
    int? inquiryCount,
    int? bookingCount,
    bool? isAvailable,
    this.availableFrom,
    this.availableUntil,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : viewCount = viewCount ?? 0,
       inquiryCount = inquiryCount ?? 0,
       bookingCount = bookingCount ?? 0,
       isAvailable = isAvailable ?? true,
       isActive = isActive ?? true,
       displayOrder = displayOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DriverService({
    int? id,
    required int driverId,
    required int serviceId,
    int? categoryId,
    _i2.PriceType? priceType,
    double? basePrice,
    double? pricePerKm,
    double? pricePerHour,
    double? minPrice,
    String? title,
    String? imageUrl,
    String? description,
    String? customDescription,
    int? viewCount,
    int? inquiryCount,
    int? bookingCount,
    bool? isAvailable,
    DateTime? availableFrom,
    DateTime? availableUntil,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DriverServiceImpl;

  factory DriverService.fromJson(Map<String, dynamic> jsonSerialization) {
    return DriverService(
      id: jsonSerialization['id'] as int?,
      driverId: jsonSerialization['driverId'] as int,
      serviceId: jsonSerialization['serviceId'] as int,
      categoryId: jsonSerialization['categoryId'] as int?,
      priceType: jsonSerialization['priceType'] == null
          ? null
          : _i2.PriceType.fromJson((jsonSerialization['priceType'] as int)),
      basePrice: (jsonSerialization['basePrice'] as num?)?.toDouble(),
      pricePerKm: (jsonSerialization['pricePerKm'] as num?)?.toDouble(),
      pricePerHour: (jsonSerialization['pricePerHour'] as num?)?.toDouble(),
      minPrice: (jsonSerialization['minPrice'] as num?)?.toDouble(),
      title: jsonSerialization['title'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      description: jsonSerialization['description'] as String?,
      customDescription: jsonSerialization['customDescription'] as String?,
      viewCount: jsonSerialization['viewCount'] as int,
      inquiryCount: jsonSerialization['inquiryCount'] as int,
      bookingCount: jsonSerialization['bookingCount'] as int,
      isAvailable: jsonSerialization['isAvailable'] as bool,
      availableFrom: jsonSerialization['availableFrom'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['availableFrom'],
            ),
      availableUntil: jsonSerialization['availableUntil'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['availableUntil'],
            ),
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

  static final t = DriverServiceTable();

  static const db = DriverServiceRepository._();

  @override
  int? id;

  int driverId;

  int serviceId;

  int? categoryId;

  _i2.PriceType? priceType;

  double? basePrice;

  double? pricePerKm;

  double? pricePerHour;

  double? minPrice;

  String? title;

  String? imageUrl;

  String? description;

  String? customDescription;

  int viewCount;

  int inquiryCount;

  int bookingCount;

  bool isAvailable;

  DateTime? availableFrom;

  DateTime? availableUntil;

  bool isActive;

  int displayOrder;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DriverService]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DriverService copyWith({
    int? id,
    int? driverId,
    int? serviceId,
    int? categoryId,
    _i2.PriceType? priceType,
    double? basePrice,
    double? pricePerKm,
    double? pricePerHour,
    double? minPrice,
    String? title,
    String? imageUrl,
    String? description,
    String? customDescription,
    int? viewCount,
    int? inquiryCount,
    int? bookingCount,
    bool? isAvailable,
    DateTime? availableFrom,
    DateTime? availableUntil,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DriverService',
      if (id != null) 'id': id,
      'driverId': driverId,
      'serviceId': serviceId,
      if (categoryId != null) 'categoryId': categoryId,
      if (priceType != null) 'priceType': priceType?.toJson(),
      if (basePrice != null) 'basePrice': basePrice,
      if (pricePerKm != null) 'pricePerKm': pricePerKm,
      if (pricePerHour != null) 'pricePerHour': pricePerHour,
      if (minPrice != null) 'minPrice': minPrice,
      if (title != null) 'title': title,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (description != null) 'description': description,
      if (customDescription != null) 'customDescription': customDescription,
      'viewCount': viewCount,
      'inquiryCount': inquiryCount,
      'bookingCount': bookingCount,
      'isAvailable': isAvailable,
      if (availableFrom != null) 'availableFrom': availableFrom?.toJson(),
      if (availableUntil != null) 'availableUntil': availableUntil?.toJson(),
      'isActive': isActive,
      'displayOrder': displayOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DriverService',
      if (id != null) 'id': id,
      'driverId': driverId,
      'serviceId': serviceId,
      if (categoryId != null) 'categoryId': categoryId,
      if (priceType != null) 'priceType': priceType?.toJson(),
      if (basePrice != null) 'basePrice': basePrice,
      if (pricePerKm != null) 'pricePerKm': pricePerKm,
      if (pricePerHour != null) 'pricePerHour': pricePerHour,
      if (minPrice != null) 'minPrice': minPrice,
      if (title != null) 'title': title,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (description != null) 'description': description,
      if (customDescription != null) 'customDescription': customDescription,
      'viewCount': viewCount,
      'inquiryCount': inquiryCount,
      'bookingCount': bookingCount,
      'isAvailable': isAvailable,
      if (availableFrom != null) 'availableFrom': availableFrom?.toJson(),
      if (availableUntil != null) 'availableUntil': availableUntil?.toJson(),
      'isActive': isActive,
      'displayOrder': displayOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DriverServiceInclude include() {
    return DriverServiceInclude._();
  }

  static DriverServiceIncludeList includeList({
    _i1.WhereExpressionBuilder<DriverServiceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverServiceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverServiceTable>? orderByList,
    DriverServiceInclude? include,
  }) {
    return DriverServiceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DriverService.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DriverService.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DriverServiceImpl extends DriverService {
  _DriverServiceImpl({
    int? id,
    required int driverId,
    required int serviceId,
    int? categoryId,
    _i2.PriceType? priceType,
    double? basePrice,
    double? pricePerKm,
    double? pricePerHour,
    double? minPrice,
    String? title,
    String? imageUrl,
    String? description,
    String? customDescription,
    int? viewCount,
    int? inquiryCount,
    int? bookingCount,
    bool? isAvailable,
    DateTime? availableFrom,
    DateTime? availableUntil,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         driverId: driverId,
         serviceId: serviceId,
         categoryId: categoryId,
         priceType: priceType,
         basePrice: basePrice,
         pricePerKm: pricePerKm,
         pricePerHour: pricePerHour,
         minPrice: minPrice,
         title: title,
         imageUrl: imageUrl,
         description: description,
         customDescription: customDescription,
         viewCount: viewCount,
         inquiryCount: inquiryCount,
         bookingCount: bookingCount,
         isAvailable: isAvailable,
         availableFrom: availableFrom,
         availableUntil: availableUntil,
         isActive: isActive,
         displayOrder: displayOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DriverService]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DriverService copyWith({
    Object? id = _Undefined,
    int? driverId,
    int? serviceId,
    Object? categoryId = _Undefined,
    Object? priceType = _Undefined,
    Object? basePrice = _Undefined,
    Object? pricePerKm = _Undefined,
    Object? pricePerHour = _Undefined,
    Object? minPrice = _Undefined,
    Object? title = _Undefined,
    Object? imageUrl = _Undefined,
    Object? description = _Undefined,
    Object? customDescription = _Undefined,
    int? viewCount,
    int? inquiryCount,
    int? bookingCount,
    bool? isAvailable,
    Object? availableFrom = _Undefined,
    Object? availableUntil = _Undefined,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DriverService(
      id: id is int? ? id : this.id,
      driverId: driverId ?? this.driverId,
      serviceId: serviceId ?? this.serviceId,
      categoryId: categoryId is int? ? categoryId : this.categoryId,
      priceType: priceType is _i2.PriceType? ? priceType : this.priceType,
      basePrice: basePrice is double? ? basePrice : this.basePrice,
      pricePerKm: pricePerKm is double? ? pricePerKm : this.pricePerKm,
      pricePerHour: pricePerHour is double? ? pricePerHour : this.pricePerHour,
      minPrice: minPrice is double? ? minPrice : this.minPrice,
      title: title is String? ? title : this.title,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      description: description is String? ? description : this.description,
      customDescription: customDescription is String?
          ? customDescription
          : this.customDescription,
      viewCount: viewCount ?? this.viewCount,
      inquiryCount: inquiryCount ?? this.inquiryCount,
      bookingCount: bookingCount ?? this.bookingCount,
      isAvailable: isAvailable ?? this.isAvailable,
      availableFrom: availableFrom is DateTime?
          ? availableFrom
          : this.availableFrom,
      availableUntil: availableUntil is DateTime?
          ? availableUntil
          : this.availableUntil,
      isActive: isActive ?? this.isActive,
      displayOrder: displayOrder ?? this.displayOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DriverServiceUpdateTable extends _i1.UpdateTable<DriverServiceTable> {
  DriverServiceUpdateTable(super.table);

  _i1.ColumnValue<int, int> driverId(int value) => _i1.ColumnValue(
    table.driverId,
    value,
  );

  _i1.ColumnValue<int, int> serviceId(int value) => _i1.ColumnValue(
    table.serviceId,
    value,
  );

  _i1.ColumnValue<int, int> categoryId(int? value) => _i1.ColumnValue(
    table.categoryId,
    value,
  );

  _i1.ColumnValue<_i2.PriceType, _i2.PriceType> priceType(
    _i2.PriceType? value,
  ) => _i1.ColumnValue(
    table.priceType,
    value,
  );

  _i1.ColumnValue<double, double> basePrice(double? value) => _i1.ColumnValue(
    table.basePrice,
    value,
  );

  _i1.ColumnValue<double, double> pricePerKm(double? value) => _i1.ColumnValue(
    table.pricePerKm,
    value,
  );

  _i1.ColumnValue<double, double> pricePerHour(double? value) =>
      _i1.ColumnValue(
        table.pricePerHour,
        value,
      );

  _i1.ColumnValue<double, double> minPrice(double? value) => _i1.ColumnValue(
    table.minPrice,
    value,
  );

  _i1.ColumnValue<String, String> title(String? value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> imageUrl(String? value) => _i1.ColumnValue(
    table.imageUrl,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> customDescription(String? value) =>
      _i1.ColumnValue(
        table.customDescription,
        value,
      );

  _i1.ColumnValue<int, int> viewCount(int value) => _i1.ColumnValue(
    table.viewCount,
    value,
  );

  _i1.ColumnValue<int, int> inquiryCount(int value) => _i1.ColumnValue(
    table.inquiryCount,
    value,
  );

  _i1.ColumnValue<int, int> bookingCount(int value) => _i1.ColumnValue(
    table.bookingCount,
    value,
  );

  _i1.ColumnValue<bool, bool> isAvailable(bool value) => _i1.ColumnValue(
    table.isAvailable,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> availableFrom(DateTime? value) =>
      _i1.ColumnValue(
        table.availableFrom,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> availableUntil(DateTime? value) =>
      _i1.ColumnValue(
        table.availableUntil,
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

class DriverServiceTable extends _i1.Table<int?> {
  DriverServiceTable({super.tableRelation})
    : super(tableName: 'driver_services') {
    updateTable = DriverServiceUpdateTable(this);
    driverId = _i1.ColumnInt(
      'driverId',
      this,
    );
    serviceId = _i1.ColumnInt(
      'serviceId',
      this,
    );
    categoryId = _i1.ColumnInt(
      'categoryId',
      this,
    );
    priceType = _i1.ColumnEnum(
      'priceType',
      this,
      _i1.EnumSerialization.byIndex,
    );
    basePrice = _i1.ColumnDouble(
      'basePrice',
      this,
    );
    pricePerKm = _i1.ColumnDouble(
      'pricePerKm',
      this,
    );
    pricePerHour = _i1.ColumnDouble(
      'pricePerHour',
      this,
    );
    minPrice = _i1.ColumnDouble(
      'minPrice',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    imageUrl = _i1.ColumnString(
      'imageUrl',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    customDescription = _i1.ColumnString(
      'customDescription',
      this,
    );
    viewCount = _i1.ColumnInt(
      'viewCount',
      this,
      hasDefault: true,
    );
    inquiryCount = _i1.ColumnInt(
      'inquiryCount',
      this,
      hasDefault: true,
    );
    bookingCount = _i1.ColumnInt(
      'bookingCount',
      this,
      hasDefault: true,
    );
    isAvailable = _i1.ColumnBool(
      'isAvailable',
      this,
      hasDefault: true,
    );
    availableFrom = _i1.ColumnDateTime(
      'availableFrom',
      this,
    );
    availableUntil = _i1.ColumnDateTime(
      'availableUntil',
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

  late final DriverServiceUpdateTable updateTable;

  late final _i1.ColumnInt driverId;

  late final _i1.ColumnInt serviceId;

  late final _i1.ColumnInt categoryId;

  late final _i1.ColumnEnum<_i2.PriceType> priceType;

  late final _i1.ColumnDouble basePrice;

  late final _i1.ColumnDouble pricePerKm;

  late final _i1.ColumnDouble pricePerHour;

  late final _i1.ColumnDouble minPrice;

  late final _i1.ColumnString title;

  late final _i1.ColumnString imageUrl;

  late final _i1.ColumnString description;

  late final _i1.ColumnString customDescription;

  late final _i1.ColumnInt viewCount;

  late final _i1.ColumnInt inquiryCount;

  late final _i1.ColumnInt bookingCount;

  late final _i1.ColumnBool isAvailable;

  late final _i1.ColumnDateTime availableFrom;

  late final _i1.ColumnDateTime availableUntil;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnInt displayOrder;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    driverId,
    serviceId,
    categoryId,
    priceType,
    basePrice,
    pricePerKm,
    pricePerHour,
    minPrice,
    title,
    imageUrl,
    description,
    customDescription,
    viewCount,
    inquiryCount,
    bookingCount,
    isAvailable,
    availableFrom,
    availableUntil,
    isActive,
    displayOrder,
    createdAt,
    updatedAt,
  ];
}

class DriverServiceInclude extends _i1.IncludeObject {
  DriverServiceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DriverService.t;
}

class DriverServiceIncludeList extends _i1.IncludeList {
  DriverServiceIncludeList._({
    _i1.WhereExpressionBuilder<DriverServiceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DriverService.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DriverService.t;
}

class DriverServiceRepository {
  const DriverServiceRepository._();

  /// Returns a list of [DriverService]s matching the given query parameters.
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
  Future<List<DriverService>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverServiceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverServiceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverServiceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<DriverService>(
      where: where?.call(DriverService.t),
      orderBy: orderBy?.call(DriverService.t),
      orderByList: orderByList?.call(DriverService.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [DriverService] matching the given query parameters.
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
  Future<DriverService?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverServiceTable>? where,
    int? offset,
    _i1.OrderByBuilder<DriverServiceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverServiceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<DriverService>(
      where: where?.call(DriverService.t),
      orderBy: orderBy?.call(DriverService.t),
      orderByList: orderByList?.call(DriverService.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [DriverService] by its [id] or null if no such row exists.
  Future<DriverService?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<DriverService>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [DriverService]s in the list and returns the inserted rows.
  ///
  /// The returned [DriverService]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<DriverService>> insert(
    _i1.Session session,
    List<DriverService> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<DriverService>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [DriverService] and returns the inserted row.
  ///
  /// The returned [DriverService] will have its `id` field set.
  Future<DriverService> insertRow(
    _i1.Session session,
    DriverService row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DriverService>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DriverService]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DriverService>> update(
    _i1.Session session,
    List<DriverService> rows, {
    _i1.ColumnSelections<DriverServiceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DriverService>(
      rows,
      columns: columns?.call(DriverService.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DriverService]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DriverService> updateRow(
    _i1.Session session,
    DriverService row, {
    _i1.ColumnSelections<DriverServiceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DriverService>(
      row,
      columns: columns?.call(DriverService.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DriverService] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DriverService?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<DriverServiceUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DriverService>(
      id,
      columnValues: columnValues(DriverService.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DriverService]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DriverService>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DriverServiceUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DriverServiceTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverServiceTable>? orderBy,
    _i1.OrderByListBuilder<DriverServiceTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DriverService>(
      columnValues: columnValues(DriverService.t.updateTable),
      where: where(DriverService.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DriverService.t),
      orderByList: orderByList?.call(DriverService.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DriverService]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DriverService>> delete(
    _i1.Session session,
    List<DriverService> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DriverService>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DriverService].
  Future<DriverService> deleteRow(
    _i1.Session session,
    DriverService row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DriverService>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DriverService>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DriverServiceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DriverService>(
      where: where(DriverService.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverServiceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DriverService>(
      where: where?.call(DriverService.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
