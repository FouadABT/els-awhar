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
import 'package:awhar_server/src/generated/protocol.dart' as _i2;

abstract class SubscriptionPlan
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SubscriptionPlan._({
    this.id,
    required this.nameEn,
    this.nameAr,
    this.nameFr,
    this.nameEs,
    this.descriptionEn,
    this.descriptionAr,
    this.descriptionFr,
    this.descriptionEs,
    required this.priceAmount,
    String? currency,
    required this.durationMonths,
    required this.features,
    bool? isActive,
    bool? isFeatured,
    int? displayOrder,
    this.commissionRate,
    bool? priorityListing,
    bool? badgeEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : currency = currency ?? 'MAD',
       isActive = isActive ?? true,
       isFeatured = isFeatured ?? false,
       displayOrder = displayOrder ?? 0,
       priorityListing = priorityListing ?? false,
       badgeEnabled = badgeEnabled ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SubscriptionPlan({
    int? id,
    required String nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    required double priceAmount,
    String? currency,
    required int durationMonths,
    required List<String> features,
    bool? isActive,
    bool? isFeatured,
    int? displayOrder,
    double? commissionRate,
    bool? priorityListing,
    bool? badgeEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubscriptionPlanImpl;

  factory SubscriptionPlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubscriptionPlan(
      id: jsonSerialization['id'] as int?,
      nameEn: jsonSerialization['nameEn'] as String,
      nameAr: jsonSerialization['nameAr'] as String?,
      nameFr: jsonSerialization['nameFr'] as String?,
      nameEs: jsonSerialization['nameEs'] as String?,
      descriptionEn: jsonSerialization['descriptionEn'] as String?,
      descriptionAr: jsonSerialization['descriptionAr'] as String?,
      descriptionFr: jsonSerialization['descriptionFr'] as String?,
      descriptionEs: jsonSerialization['descriptionEs'] as String?,
      priceAmount: (jsonSerialization['priceAmount'] as num).toDouble(),
      currency: jsonSerialization['currency'] as String,
      durationMonths: jsonSerialization['durationMonths'] as int,
      features: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['features'],
      ),
      isActive: jsonSerialization['isActive'] as bool,
      isFeatured: jsonSerialization['isFeatured'] as bool,
      displayOrder: jsonSerialization['displayOrder'] as int,
      commissionRate: (jsonSerialization['commissionRate'] as num?)?.toDouble(),
      priorityListing: jsonSerialization['priorityListing'] as bool,
      badgeEnabled: jsonSerialization['badgeEnabled'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = SubscriptionPlanTable();

  static const db = SubscriptionPlanRepository._();

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

  double priceAmount;

  String currency;

  int durationMonths;

  List<String> features;

  bool isActive;

  bool isFeatured;

  int displayOrder;

  double? commissionRate;

  bool priorityListing;

  bool badgeEnabled;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SubscriptionPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubscriptionPlan copyWith({
    int? id,
    String? nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    double? priceAmount,
    String? currency,
    int? durationMonths,
    List<String>? features,
    bool? isActive,
    bool? isFeatured,
    int? displayOrder,
    double? commissionRate,
    bool? priorityListing,
    bool? badgeEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubscriptionPlan',
      if (id != null) 'id': id,
      'nameEn': nameEn,
      if (nameAr != null) 'nameAr': nameAr,
      if (nameFr != null) 'nameFr': nameFr,
      if (nameEs != null) 'nameEs': nameEs,
      if (descriptionEn != null) 'descriptionEn': descriptionEn,
      if (descriptionAr != null) 'descriptionAr': descriptionAr,
      if (descriptionFr != null) 'descriptionFr': descriptionFr,
      if (descriptionEs != null) 'descriptionEs': descriptionEs,
      'priceAmount': priceAmount,
      'currency': currency,
      'durationMonths': durationMonths,
      'features': features.toJson(),
      'isActive': isActive,
      'isFeatured': isFeatured,
      'displayOrder': displayOrder,
      if (commissionRate != null) 'commissionRate': commissionRate,
      'priorityListing': priorityListing,
      'badgeEnabled': badgeEnabled,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubscriptionPlan',
      if (id != null) 'id': id,
      'nameEn': nameEn,
      if (nameAr != null) 'nameAr': nameAr,
      if (nameFr != null) 'nameFr': nameFr,
      if (nameEs != null) 'nameEs': nameEs,
      if (descriptionEn != null) 'descriptionEn': descriptionEn,
      if (descriptionAr != null) 'descriptionAr': descriptionAr,
      if (descriptionFr != null) 'descriptionFr': descriptionFr,
      if (descriptionEs != null) 'descriptionEs': descriptionEs,
      'priceAmount': priceAmount,
      'currency': currency,
      'durationMonths': durationMonths,
      'features': features.toJson(),
      'isActive': isActive,
      'isFeatured': isFeatured,
      'displayOrder': displayOrder,
      if (commissionRate != null) 'commissionRate': commissionRate,
      'priorityListing': priorityListing,
      'badgeEnabled': badgeEnabled,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SubscriptionPlanInclude include() {
    return SubscriptionPlanInclude._();
  }

  static SubscriptionPlanIncludeList includeList({
    _i1.WhereExpressionBuilder<SubscriptionPlanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubscriptionPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubscriptionPlanTable>? orderByList,
    SubscriptionPlanInclude? include,
  }) {
    return SubscriptionPlanIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubscriptionPlan.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SubscriptionPlan.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubscriptionPlanImpl extends SubscriptionPlan {
  _SubscriptionPlanImpl({
    int? id,
    required String nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    required double priceAmount,
    String? currency,
    required int durationMonths,
    required List<String> features,
    bool? isActive,
    bool? isFeatured,
    int? displayOrder,
    double? commissionRate,
    bool? priorityListing,
    bool? badgeEnabled,
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
         priceAmount: priceAmount,
         currency: currency,
         durationMonths: durationMonths,
         features: features,
         isActive: isActive,
         isFeatured: isFeatured,
         displayOrder: displayOrder,
         commissionRate: commissionRate,
         priorityListing: priorityListing,
         badgeEnabled: badgeEnabled,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SubscriptionPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubscriptionPlan copyWith({
    Object? id = _Undefined,
    String? nameEn,
    Object? nameAr = _Undefined,
    Object? nameFr = _Undefined,
    Object? nameEs = _Undefined,
    Object? descriptionEn = _Undefined,
    Object? descriptionAr = _Undefined,
    Object? descriptionFr = _Undefined,
    Object? descriptionEs = _Undefined,
    double? priceAmount,
    String? currency,
    int? durationMonths,
    List<String>? features,
    bool? isActive,
    bool? isFeatured,
    int? displayOrder,
    Object? commissionRate = _Undefined,
    bool? priorityListing,
    bool? badgeEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubscriptionPlan(
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
      priceAmount: priceAmount ?? this.priceAmount,
      currency: currency ?? this.currency,
      durationMonths: durationMonths ?? this.durationMonths,
      features: features ?? this.features.map((e0) => e0).toList(),
      isActive: isActive ?? this.isActive,
      isFeatured: isFeatured ?? this.isFeatured,
      displayOrder: displayOrder ?? this.displayOrder,
      commissionRate: commissionRate is double?
          ? commissionRate
          : this.commissionRate,
      priorityListing: priorityListing ?? this.priorityListing,
      badgeEnabled: badgeEnabled ?? this.badgeEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SubscriptionPlanUpdateTable
    extends _i1.UpdateTable<SubscriptionPlanTable> {
  SubscriptionPlanUpdateTable(super.table);

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

  _i1.ColumnValue<double, double> priceAmount(double value) => _i1.ColumnValue(
    table.priceAmount,
    value,
  );

  _i1.ColumnValue<String, String> currency(String value) => _i1.ColumnValue(
    table.currency,
    value,
  );

  _i1.ColumnValue<int, int> durationMonths(int value) => _i1.ColumnValue(
    table.durationMonths,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> features(List<String> value) =>
      _i1.ColumnValue(
        table.features,
        value,
      );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<bool, bool> isFeatured(bool value) => _i1.ColumnValue(
    table.isFeatured,
    value,
  );

  _i1.ColumnValue<int, int> displayOrder(int value) => _i1.ColumnValue(
    table.displayOrder,
    value,
  );

  _i1.ColumnValue<double, double> commissionRate(double? value) =>
      _i1.ColumnValue(
        table.commissionRate,
        value,
      );

  _i1.ColumnValue<bool, bool> priorityListing(bool value) => _i1.ColumnValue(
    table.priorityListing,
    value,
  );

  _i1.ColumnValue<bool, bool> badgeEnabled(bool value) => _i1.ColumnValue(
    table.badgeEnabled,
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

class SubscriptionPlanTable extends _i1.Table<int?> {
  SubscriptionPlanTable({super.tableRelation})
    : super(tableName: 'subscription_plans') {
    updateTable = SubscriptionPlanUpdateTable(this);
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
    priceAmount = _i1.ColumnDouble(
      'priceAmount',
      this,
    );
    currency = _i1.ColumnString(
      'currency',
      this,
      hasDefault: true,
    );
    durationMonths = _i1.ColumnInt(
      'durationMonths',
      this,
    );
    features = _i1.ColumnSerializable<List<String>>(
      'features',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    isFeatured = _i1.ColumnBool(
      'isFeatured',
      this,
      hasDefault: true,
    );
    displayOrder = _i1.ColumnInt(
      'displayOrder',
      this,
      hasDefault: true,
    );
    commissionRate = _i1.ColumnDouble(
      'commissionRate',
      this,
    );
    priorityListing = _i1.ColumnBool(
      'priorityListing',
      this,
      hasDefault: true,
    );
    badgeEnabled = _i1.ColumnBool(
      'badgeEnabled',
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

  late final SubscriptionPlanUpdateTable updateTable;

  late final _i1.ColumnString nameEn;

  late final _i1.ColumnString nameAr;

  late final _i1.ColumnString nameFr;

  late final _i1.ColumnString nameEs;

  late final _i1.ColumnString descriptionEn;

  late final _i1.ColumnString descriptionAr;

  late final _i1.ColumnString descriptionFr;

  late final _i1.ColumnString descriptionEs;

  late final _i1.ColumnDouble priceAmount;

  late final _i1.ColumnString currency;

  late final _i1.ColumnInt durationMonths;

  late final _i1.ColumnSerializable<List<String>> features;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnBool isFeatured;

  late final _i1.ColumnInt displayOrder;

  late final _i1.ColumnDouble commissionRate;

  late final _i1.ColumnBool priorityListing;

  late final _i1.ColumnBool badgeEnabled;

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
    priceAmount,
    currency,
    durationMonths,
    features,
    isActive,
    isFeatured,
    displayOrder,
    commissionRate,
    priorityListing,
    badgeEnabled,
    createdAt,
    updatedAt,
  ];
}

class SubscriptionPlanInclude extends _i1.IncludeObject {
  SubscriptionPlanInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SubscriptionPlan.t;
}

class SubscriptionPlanIncludeList extends _i1.IncludeList {
  SubscriptionPlanIncludeList._({
    _i1.WhereExpressionBuilder<SubscriptionPlanTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SubscriptionPlan.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SubscriptionPlan.t;
}

class SubscriptionPlanRepository {
  const SubscriptionPlanRepository._();

  /// Returns a list of [SubscriptionPlan]s matching the given query parameters.
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
  Future<List<SubscriptionPlan>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubscriptionPlanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubscriptionPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubscriptionPlanTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SubscriptionPlan>(
      where: where?.call(SubscriptionPlan.t),
      orderBy: orderBy?.call(SubscriptionPlan.t),
      orderByList: orderByList?.call(SubscriptionPlan.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SubscriptionPlan] matching the given query parameters.
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
  Future<SubscriptionPlan?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubscriptionPlanTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubscriptionPlanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubscriptionPlanTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SubscriptionPlan>(
      where: where?.call(SubscriptionPlan.t),
      orderBy: orderBy?.call(SubscriptionPlan.t),
      orderByList: orderByList?.call(SubscriptionPlan.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SubscriptionPlan] by its [id] or null if no such row exists.
  Future<SubscriptionPlan?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SubscriptionPlan>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SubscriptionPlan]s in the list and returns the inserted rows.
  ///
  /// The returned [SubscriptionPlan]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SubscriptionPlan>> insert(
    _i1.Session session,
    List<SubscriptionPlan> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SubscriptionPlan>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SubscriptionPlan] and returns the inserted row.
  ///
  /// The returned [SubscriptionPlan] will have its `id` field set.
  Future<SubscriptionPlan> insertRow(
    _i1.Session session,
    SubscriptionPlan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SubscriptionPlan>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SubscriptionPlan]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SubscriptionPlan>> update(
    _i1.Session session,
    List<SubscriptionPlan> rows, {
    _i1.ColumnSelections<SubscriptionPlanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SubscriptionPlan>(
      rows,
      columns: columns?.call(SubscriptionPlan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubscriptionPlan]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SubscriptionPlan> updateRow(
    _i1.Session session,
    SubscriptionPlan row, {
    _i1.ColumnSelections<SubscriptionPlanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SubscriptionPlan>(
      row,
      columns: columns?.call(SubscriptionPlan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubscriptionPlan] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SubscriptionPlan?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<SubscriptionPlanUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SubscriptionPlan>(
      id,
      columnValues: columnValues(SubscriptionPlan.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SubscriptionPlan]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SubscriptionPlan>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SubscriptionPlanUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<SubscriptionPlanTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubscriptionPlanTable>? orderBy,
    _i1.OrderByListBuilder<SubscriptionPlanTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SubscriptionPlan>(
      columnValues: columnValues(SubscriptionPlan.t.updateTable),
      where: where(SubscriptionPlan.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubscriptionPlan.t),
      orderByList: orderByList?.call(SubscriptionPlan.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SubscriptionPlan]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SubscriptionPlan>> delete(
    _i1.Session session,
    List<SubscriptionPlan> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SubscriptionPlan>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SubscriptionPlan].
  Future<SubscriptionPlan> deleteRow(
    _i1.Session session,
    SubscriptionPlan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SubscriptionPlan>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SubscriptionPlan>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SubscriptionPlanTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SubscriptionPlan>(
      where: where(SubscriptionPlan.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubscriptionPlanTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SubscriptionPlan>(
      where: where?.call(SubscriptionPlan.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
