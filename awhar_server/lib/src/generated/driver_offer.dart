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
import 'offer_status_enum.dart' as _i2;

abstract class DriverOffer
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DriverOffer._({
    this.id,
    required this.orderId,
    required this.driverId,
    required this.offeredPrice,
    this.message,
    this.status,
    DateTime? createdAt,
    this.respondedAt,
    this.expiresAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory DriverOffer({
    int? id,
    required int orderId,
    required int driverId,
    required double offeredPrice,
    String? message,
    _i2.OfferStatus? status,
    DateTime? createdAt,
    DateTime? respondedAt,
    DateTime? expiresAt,
  }) = _DriverOfferImpl;

  factory DriverOffer.fromJson(Map<String, dynamic> jsonSerialization) {
    return DriverOffer(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      driverId: jsonSerialization['driverId'] as int,
      offeredPrice: (jsonSerialization['offeredPrice'] as num).toDouble(),
      message: jsonSerialization['message'] as String?,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.OfferStatus.fromJson((jsonSerialization['status'] as int)),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      respondedAt: jsonSerialization['respondedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['respondedAt'],
            ),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
    );
  }

  static final t = DriverOfferTable();

  static const db = DriverOfferRepository._();

  @override
  int? id;

  int orderId;

  int driverId;

  double offeredPrice;

  String? message;

  _i2.OfferStatus? status;

  DateTime createdAt;

  DateTime? respondedAt;

  DateTime? expiresAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DriverOffer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DriverOffer copyWith({
    int? id,
    int? orderId,
    int? driverId,
    double? offeredPrice,
    String? message,
    _i2.OfferStatus? status,
    DateTime? createdAt,
    DateTime? respondedAt,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DriverOffer',
      if (id != null) 'id': id,
      'orderId': orderId,
      'driverId': driverId,
      'offeredPrice': offeredPrice,
      if (message != null) 'message': message,
      if (status != null) 'status': status?.toJson(),
      'createdAt': createdAt.toJson(),
      if (respondedAt != null) 'respondedAt': respondedAt?.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DriverOffer',
      if (id != null) 'id': id,
      'orderId': orderId,
      'driverId': driverId,
      'offeredPrice': offeredPrice,
      if (message != null) 'message': message,
      if (status != null) 'status': status?.toJson(),
      'createdAt': createdAt.toJson(),
      if (respondedAt != null) 'respondedAt': respondedAt?.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  static DriverOfferInclude include() {
    return DriverOfferInclude._();
  }

  static DriverOfferIncludeList includeList({
    _i1.WhereExpressionBuilder<DriverOfferTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverOfferTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverOfferTable>? orderByList,
    DriverOfferInclude? include,
  }) {
    return DriverOfferIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DriverOffer.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DriverOffer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DriverOfferImpl extends DriverOffer {
  _DriverOfferImpl({
    int? id,
    required int orderId,
    required int driverId,
    required double offeredPrice,
    String? message,
    _i2.OfferStatus? status,
    DateTime? createdAt,
    DateTime? respondedAt,
    DateTime? expiresAt,
  }) : super._(
         id: id,
         orderId: orderId,
         driverId: driverId,
         offeredPrice: offeredPrice,
         message: message,
         status: status,
         createdAt: createdAt,
         respondedAt: respondedAt,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [DriverOffer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DriverOffer copyWith({
    Object? id = _Undefined,
    int? orderId,
    int? driverId,
    double? offeredPrice,
    Object? message = _Undefined,
    Object? status = _Undefined,
    DateTime? createdAt,
    Object? respondedAt = _Undefined,
    Object? expiresAt = _Undefined,
  }) {
    return DriverOffer(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      driverId: driverId ?? this.driverId,
      offeredPrice: offeredPrice ?? this.offeredPrice,
      message: message is String? ? message : this.message,
      status: status is _i2.OfferStatus? ? status : this.status,
      createdAt: createdAt ?? this.createdAt,
      respondedAt: respondedAt is DateTime? ? respondedAt : this.respondedAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
    );
  }
}

class DriverOfferUpdateTable extends _i1.UpdateTable<DriverOfferTable> {
  DriverOfferUpdateTable(super.table);

  _i1.ColumnValue<int, int> orderId(int value) => _i1.ColumnValue(
    table.orderId,
    value,
  );

  _i1.ColumnValue<int, int> driverId(int value) => _i1.ColumnValue(
    table.driverId,
    value,
  );

  _i1.ColumnValue<double, double> offeredPrice(double value) => _i1.ColumnValue(
    table.offeredPrice,
    value,
  );

  _i1.ColumnValue<String, String> message(String? value) => _i1.ColumnValue(
    table.message,
    value,
  );

  _i1.ColumnValue<_i2.OfferStatus, _i2.OfferStatus> status(
    _i2.OfferStatus? value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> respondedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.respondedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime? value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );
}

class DriverOfferTable extends _i1.Table<int?> {
  DriverOfferTable({super.tableRelation}) : super(tableName: 'driver_offers') {
    updateTable = DriverOfferUpdateTable(this);
    orderId = _i1.ColumnInt(
      'orderId',
      this,
    );
    driverId = _i1.ColumnInt(
      'driverId',
      this,
    );
    offeredPrice = _i1.ColumnDouble(
      'offeredPrice',
      this,
    );
    message = _i1.ColumnString(
      'message',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byIndex,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    respondedAt = _i1.ColumnDateTime(
      'respondedAt',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
  }

  late final DriverOfferUpdateTable updateTable;

  late final _i1.ColumnInt orderId;

  late final _i1.ColumnInt driverId;

  late final _i1.ColumnDouble offeredPrice;

  late final _i1.ColumnString message;

  late final _i1.ColumnEnum<_i2.OfferStatus> status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime respondedAt;

  late final _i1.ColumnDateTime expiresAt;

  @override
  List<_i1.Column> get columns => [
    id,
    orderId,
    driverId,
    offeredPrice,
    message,
    status,
    createdAt,
    respondedAt,
    expiresAt,
  ];
}

class DriverOfferInclude extends _i1.IncludeObject {
  DriverOfferInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DriverOffer.t;
}

class DriverOfferIncludeList extends _i1.IncludeList {
  DriverOfferIncludeList._({
    _i1.WhereExpressionBuilder<DriverOfferTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DriverOffer.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DriverOffer.t;
}

class DriverOfferRepository {
  const DriverOfferRepository._();

  /// Returns a list of [DriverOffer]s matching the given query parameters.
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
  Future<List<DriverOffer>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverOfferTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverOfferTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverOfferTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<DriverOffer>(
      where: where?.call(DriverOffer.t),
      orderBy: orderBy?.call(DriverOffer.t),
      orderByList: orderByList?.call(DriverOffer.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [DriverOffer] matching the given query parameters.
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
  Future<DriverOffer?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverOfferTable>? where,
    int? offset,
    _i1.OrderByBuilder<DriverOfferTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverOfferTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<DriverOffer>(
      where: where?.call(DriverOffer.t),
      orderBy: orderBy?.call(DriverOffer.t),
      orderByList: orderByList?.call(DriverOffer.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [DriverOffer] by its [id] or null if no such row exists.
  Future<DriverOffer?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<DriverOffer>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [DriverOffer]s in the list and returns the inserted rows.
  ///
  /// The returned [DriverOffer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<DriverOffer>> insert(
    _i1.Session session,
    List<DriverOffer> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<DriverOffer>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [DriverOffer] and returns the inserted row.
  ///
  /// The returned [DriverOffer] will have its `id` field set.
  Future<DriverOffer> insertRow(
    _i1.Session session,
    DriverOffer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DriverOffer>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DriverOffer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DriverOffer>> update(
    _i1.Session session,
    List<DriverOffer> rows, {
    _i1.ColumnSelections<DriverOfferTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DriverOffer>(
      rows,
      columns: columns?.call(DriverOffer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DriverOffer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DriverOffer> updateRow(
    _i1.Session session,
    DriverOffer row, {
    _i1.ColumnSelections<DriverOfferTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DriverOffer>(
      row,
      columns: columns?.call(DriverOffer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DriverOffer] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DriverOffer?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<DriverOfferUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DriverOffer>(
      id,
      columnValues: columnValues(DriverOffer.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DriverOffer]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DriverOffer>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DriverOfferUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DriverOfferTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverOfferTable>? orderBy,
    _i1.OrderByListBuilder<DriverOfferTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DriverOffer>(
      columnValues: columnValues(DriverOffer.t.updateTable),
      where: where(DriverOffer.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DriverOffer.t),
      orderByList: orderByList?.call(DriverOffer.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DriverOffer]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DriverOffer>> delete(
    _i1.Session session,
    List<DriverOffer> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DriverOffer>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DriverOffer].
  Future<DriverOffer> deleteRow(
    _i1.Session session,
    DriverOffer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DriverOffer>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DriverOffer>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DriverOfferTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DriverOffer>(
      where: where(DriverOffer.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverOfferTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DriverOffer>(
      where: where?.call(DriverOffer.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
