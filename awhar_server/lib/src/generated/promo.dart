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

abstract class Promo implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Promo._({
    this.id,
    required this.titleEn,
    this.titleAr,
    this.titleFr,
    this.titleEs,
    this.descriptionEn,
    this.descriptionAr,
    this.descriptionFr,
    this.descriptionEs,
    required this.imageUrl,
    required this.targetRoles,
    String? actionType,
    this.actionValue,
    int? priority,
    bool? isActive,
    this.startDate,
    this.endDate,
    int? viewCount,
    int? clickCount,
    required this.createdAt,
    this.updatedAt,
    this.createdBy,
  }) : actionType = actionType ?? 'none',
       priority = priority ?? 0,
       isActive = isActive ?? true,
       viewCount = viewCount ?? 0,
       clickCount = clickCount ?? 0;

  factory Promo({
    int? id,
    required String titleEn,
    String? titleAr,
    String? titleFr,
    String? titleEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    required String imageUrl,
    required String targetRoles,
    String? actionType,
    String? actionValue,
    int? priority,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
    int? viewCount,
    int? clickCount,
    required DateTime createdAt,
    DateTime? updatedAt,
    int? createdBy,
  }) = _PromoImpl;

  factory Promo.fromJson(Map<String, dynamic> jsonSerialization) {
    return Promo(
      id: jsonSerialization['id'] as int?,
      titleEn: jsonSerialization['titleEn'] as String,
      titleAr: jsonSerialization['titleAr'] as String?,
      titleFr: jsonSerialization['titleFr'] as String?,
      titleEs: jsonSerialization['titleEs'] as String?,
      descriptionEn: jsonSerialization['descriptionEn'] as String?,
      descriptionAr: jsonSerialization['descriptionAr'] as String?,
      descriptionFr: jsonSerialization['descriptionFr'] as String?,
      descriptionEs: jsonSerialization['descriptionEs'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String,
      targetRoles: jsonSerialization['targetRoles'] as String,
      actionType: jsonSerialization['actionType'] as String,
      actionValue: jsonSerialization['actionValue'] as String?,
      priority: jsonSerialization['priority'] as int,
      isActive: jsonSerialization['isActive'] as bool,
      startDate: jsonSerialization['startDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startDate']),
      endDate: jsonSerialization['endDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      viewCount: jsonSerialization['viewCount'] as int,
      clickCount: jsonSerialization['clickCount'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      createdBy: jsonSerialization['createdBy'] as int?,
    );
  }

  static final t = PromoTable();

  static const db = PromoRepository._();

  @override
  int? id;

  String titleEn;

  String? titleAr;

  String? titleFr;

  String? titleEs;

  String? descriptionEn;

  String? descriptionAr;

  String? descriptionFr;

  String? descriptionEs;

  String imageUrl;

  String targetRoles;

  String actionType;

  String? actionValue;

  int priority;

  bool isActive;

  DateTime? startDate;

  DateTime? endDate;

  int viewCount;

  int clickCount;

  DateTime createdAt;

  DateTime? updatedAt;

  int? createdBy;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Promo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Promo copyWith({
    int? id,
    String? titleEn,
    String? titleAr,
    String? titleFr,
    String? titleEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    String? imageUrl,
    String? targetRoles,
    String? actionType,
    String? actionValue,
    int? priority,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
    int? viewCount,
    int? clickCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? createdBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Promo',
      if (id != null) 'id': id,
      'titleEn': titleEn,
      if (titleAr != null) 'titleAr': titleAr,
      if (titleFr != null) 'titleFr': titleFr,
      if (titleEs != null) 'titleEs': titleEs,
      if (descriptionEn != null) 'descriptionEn': descriptionEn,
      if (descriptionAr != null) 'descriptionAr': descriptionAr,
      if (descriptionFr != null) 'descriptionFr': descriptionFr,
      if (descriptionEs != null) 'descriptionEs': descriptionEs,
      'imageUrl': imageUrl,
      'targetRoles': targetRoles,
      'actionType': actionType,
      if (actionValue != null) 'actionValue': actionValue,
      'priority': priority,
      'isActive': isActive,
      if (startDate != null) 'startDate': startDate?.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      'viewCount': viewCount,
      'clickCount': clickCount,
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (createdBy != null) 'createdBy': createdBy,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Promo',
      if (id != null) 'id': id,
      'titleEn': titleEn,
      if (titleAr != null) 'titleAr': titleAr,
      if (titleFr != null) 'titleFr': titleFr,
      if (titleEs != null) 'titleEs': titleEs,
      if (descriptionEn != null) 'descriptionEn': descriptionEn,
      if (descriptionAr != null) 'descriptionAr': descriptionAr,
      if (descriptionFr != null) 'descriptionFr': descriptionFr,
      if (descriptionEs != null) 'descriptionEs': descriptionEs,
      'imageUrl': imageUrl,
      'targetRoles': targetRoles,
      'actionType': actionType,
      if (actionValue != null) 'actionValue': actionValue,
      'priority': priority,
      'isActive': isActive,
      if (startDate != null) 'startDate': startDate?.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      'viewCount': viewCount,
      'clickCount': clickCount,
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (createdBy != null) 'createdBy': createdBy,
    };
  }

  static PromoInclude include() {
    return PromoInclude._();
  }

  static PromoIncludeList includeList({
    _i1.WhereExpressionBuilder<PromoTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PromoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PromoTable>? orderByList,
    PromoInclude? include,
  }) {
    return PromoIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Promo.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Promo.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PromoImpl extends Promo {
  _PromoImpl({
    int? id,
    required String titleEn,
    String? titleAr,
    String? titleFr,
    String? titleEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    required String imageUrl,
    required String targetRoles,
    String? actionType,
    String? actionValue,
    int? priority,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
    int? viewCount,
    int? clickCount,
    required DateTime createdAt,
    DateTime? updatedAt,
    int? createdBy,
  }) : super._(
         id: id,
         titleEn: titleEn,
         titleAr: titleAr,
         titleFr: titleFr,
         titleEs: titleEs,
         descriptionEn: descriptionEn,
         descriptionAr: descriptionAr,
         descriptionFr: descriptionFr,
         descriptionEs: descriptionEs,
         imageUrl: imageUrl,
         targetRoles: targetRoles,
         actionType: actionType,
         actionValue: actionValue,
         priority: priority,
         isActive: isActive,
         startDate: startDate,
         endDate: endDate,
         viewCount: viewCount,
         clickCount: clickCount,
         createdAt: createdAt,
         updatedAt: updatedAt,
         createdBy: createdBy,
       );

  /// Returns a shallow copy of this [Promo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Promo copyWith({
    Object? id = _Undefined,
    String? titleEn,
    Object? titleAr = _Undefined,
    Object? titleFr = _Undefined,
    Object? titleEs = _Undefined,
    Object? descriptionEn = _Undefined,
    Object? descriptionAr = _Undefined,
    Object? descriptionFr = _Undefined,
    Object? descriptionEs = _Undefined,
    String? imageUrl,
    String? targetRoles,
    String? actionType,
    Object? actionValue = _Undefined,
    int? priority,
    bool? isActive,
    Object? startDate = _Undefined,
    Object? endDate = _Undefined,
    int? viewCount,
    int? clickCount,
    DateTime? createdAt,
    Object? updatedAt = _Undefined,
    Object? createdBy = _Undefined,
  }) {
    return Promo(
      id: id is int? ? id : this.id,
      titleEn: titleEn ?? this.titleEn,
      titleAr: titleAr is String? ? titleAr : this.titleAr,
      titleFr: titleFr is String? ? titleFr : this.titleFr,
      titleEs: titleEs is String? ? titleEs : this.titleEs,
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
      imageUrl: imageUrl ?? this.imageUrl,
      targetRoles: targetRoles ?? this.targetRoles,
      actionType: actionType ?? this.actionType,
      actionValue: actionValue is String? ? actionValue : this.actionValue,
      priority: priority ?? this.priority,
      isActive: isActive ?? this.isActive,
      startDate: startDate is DateTime? ? startDate : this.startDate,
      endDate: endDate is DateTime? ? endDate : this.endDate,
      viewCount: viewCount ?? this.viewCount,
      clickCount: clickCount ?? this.clickCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      createdBy: createdBy is int? ? createdBy : this.createdBy,
    );
  }
}

class PromoUpdateTable extends _i1.UpdateTable<PromoTable> {
  PromoUpdateTable(super.table);

  _i1.ColumnValue<String, String> titleEn(String value) => _i1.ColumnValue(
    table.titleEn,
    value,
  );

  _i1.ColumnValue<String, String> titleAr(String? value) => _i1.ColumnValue(
    table.titleAr,
    value,
  );

  _i1.ColumnValue<String, String> titleFr(String? value) => _i1.ColumnValue(
    table.titleFr,
    value,
  );

  _i1.ColumnValue<String, String> titleEs(String? value) => _i1.ColumnValue(
    table.titleEs,
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

  _i1.ColumnValue<String, String> imageUrl(String value) => _i1.ColumnValue(
    table.imageUrl,
    value,
  );

  _i1.ColumnValue<String, String> targetRoles(String value) => _i1.ColumnValue(
    table.targetRoles,
    value,
  );

  _i1.ColumnValue<String, String> actionType(String value) => _i1.ColumnValue(
    table.actionType,
    value,
  );

  _i1.ColumnValue<String, String> actionValue(String? value) => _i1.ColumnValue(
    table.actionValue,
    value,
  );

  _i1.ColumnValue<int, int> priority(int value) => _i1.ColumnValue(
    table.priority,
    value,
  );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startDate(DateTime? value) =>
      _i1.ColumnValue(
        table.startDate,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> endDate(DateTime? value) =>
      _i1.ColumnValue(
        table.endDate,
        value,
      );

  _i1.ColumnValue<int, int> viewCount(int value) => _i1.ColumnValue(
    table.viewCount,
    value,
  );

  _i1.ColumnValue<int, int> clickCount(int value) => _i1.ColumnValue(
    table.clickCount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );

  _i1.ColumnValue<int, int> createdBy(int? value) => _i1.ColumnValue(
    table.createdBy,
    value,
  );
}

class PromoTable extends _i1.Table<int?> {
  PromoTable({super.tableRelation}) : super(tableName: 'promos') {
    updateTable = PromoUpdateTable(this);
    titleEn = _i1.ColumnString(
      'titleEn',
      this,
    );
    titleAr = _i1.ColumnString(
      'titleAr',
      this,
    );
    titleFr = _i1.ColumnString(
      'titleFr',
      this,
    );
    titleEs = _i1.ColumnString(
      'titleEs',
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
    imageUrl = _i1.ColumnString(
      'imageUrl',
      this,
    );
    targetRoles = _i1.ColumnString(
      'targetRoles',
      this,
    );
    actionType = _i1.ColumnString(
      'actionType',
      this,
      hasDefault: true,
    );
    actionValue = _i1.ColumnString(
      'actionValue',
      this,
    );
    priority = _i1.ColumnInt(
      'priority',
      this,
      hasDefault: true,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    startDate = _i1.ColumnDateTime(
      'startDate',
      this,
    );
    endDate = _i1.ColumnDateTime(
      'endDate',
      this,
    );
    viewCount = _i1.ColumnInt(
      'viewCount',
      this,
      hasDefault: true,
    );
    clickCount = _i1.ColumnInt(
      'clickCount',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
    createdBy = _i1.ColumnInt(
      'createdBy',
      this,
    );
  }

  late final PromoUpdateTable updateTable;

  late final _i1.ColumnString titleEn;

  late final _i1.ColumnString titleAr;

  late final _i1.ColumnString titleFr;

  late final _i1.ColumnString titleEs;

  late final _i1.ColumnString descriptionEn;

  late final _i1.ColumnString descriptionAr;

  late final _i1.ColumnString descriptionFr;

  late final _i1.ColumnString descriptionEs;

  late final _i1.ColumnString imageUrl;

  late final _i1.ColumnString targetRoles;

  late final _i1.ColumnString actionType;

  late final _i1.ColumnString actionValue;

  late final _i1.ColumnInt priority;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnDateTime startDate;

  late final _i1.ColumnDateTime endDate;

  late final _i1.ColumnInt viewCount;

  late final _i1.ColumnInt clickCount;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnInt createdBy;

  @override
  List<_i1.Column> get columns => [
    id,
    titleEn,
    titleAr,
    titleFr,
    titleEs,
    descriptionEn,
    descriptionAr,
    descriptionFr,
    descriptionEs,
    imageUrl,
    targetRoles,
    actionType,
    actionValue,
    priority,
    isActive,
    startDate,
    endDate,
    viewCount,
    clickCount,
    createdAt,
    updatedAt,
    createdBy,
  ];
}

class PromoInclude extends _i1.IncludeObject {
  PromoInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Promo.t;
}

class PromoIncludeList extends _i1.IncludeList {
  PromoIncludeList._({
    _i1.WhereExpressionBuilder<PromoTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Promo.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Promo.t;
}

class PromoRepository {
  const PromoRepository._();

  /// Returns a list of [Promo]s matching the given query parameters.
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
  Future<List<Promo>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PromoTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PromoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PromoTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Promo>(
      where: where?.call(Promo.t),
      orderBy: orderBy?.call(Promo.t),
      orderByList: orderByList?.call(Promo.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Promo] matching the given query parameters.
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
  Future<Promo?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PromoTable>? where,
    int? offset,
    _i1.OrderByBuilder<PromoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PromoTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Promo>(
      where: where?.call(Promo.t),
      orderBy: orderBy?.call(Promo.t),
      orderByList: orderByList?.call(Promo.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Promo] by its [id] or null if no such row exists.
  Future<Promo?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Promo>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Promo]s in the list and returns the inserted rows.
  ///
  /// The returned [Promo]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Promo>> insert(
    _i1.Session session,
    List<Promo> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Promo>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Promo] and returns the inserted row.
  ///
  /// The returned [Promo] will have its `id` field set.
  Future<Promo> insertRow(
    _i1.Session session,
    Promo row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Promo>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Promo]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Promo>> update(
    _i1.Session session,
    List<Promo> rows, {
    _i1.ColumnSelections<PromoTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Promo>(
      rows,
      columns: columns?.call(Promo.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Promo]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Promo> updateRow(
    _i1.Session session,
    Promo row, {
    _i1.ColumnSelections<PromoTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Promo>(
      row,
      columns: columns?.call(Promo.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Promo] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Promo?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<PromoUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Promo>(
      id,
      columnValues: columnValues(Promo.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Promo]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Promo>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<PromoUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PromoTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PromoTable>? orderBy,
    _i1.OrderByListBuilder<PromoTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Promo>(
      columnValues: columnValues(Promo.t.updateTable),
      where: where(Promo.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Promo.t),
      orderByList: orderByList?.call(Promo.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Promo]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Promo>> delete(
    _i1.Session session,
    List<Promo> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Promo>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Promo].
  Future<Promo> deleteRow(
    _i1.Session session,
    Promo row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Promo>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Promo>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PromoTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Promo>(
      where: where(Promo.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PromoTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Promo>(
      where: where?.call(Promo.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
