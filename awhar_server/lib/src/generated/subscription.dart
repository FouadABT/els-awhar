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
import 'subscription_status_enum.dart' as _i2;

abstract class Subscription
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Subscription._({
    this.id,
    required this.driverId,
    required this.planId,
    required this.startDate,
    required this.endDate,
    this.status,
    bool? autoRenew,
    this.cancelledAt,
    this.cancellationReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : autoRenew = autoRenew ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Subscription({
    int? id,
    required int driverId,
    required int planId,
    required DateTime startDate,
    required DateTime endDate,
    _i2.SubscriptionStatus? status,
    bool? autoRenew,
    DateTime? cancelledAt,
    String? cancellationReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubscriptionImpl;

  factory Subscription.fromJson(Map<String, dynamic> jsonSerialization) {
    return Subscription(
      id: jsonSerialization['id'] as int?,
      driverId: jsonSerialization['driverId'] as int,
      planId: jsonSerialization['planId'] as int,
      startDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDate'],
      ),
      endDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      status: jsonSerialization['status'] == null
          ? null
          : _i2.SubscriptionStatus.fromJson(
              (jsonSerialization['status'] as int),
            ),
      autoRenew: jsonSerialization['autoRenew'] as bool,
      cancelledAt: jsonSerialization['cancelledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['cancelledAt'],
            ),
      cancellationReason: jsonSerialization['cancellationReason'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = SubscriptionTable();

  static const db = SubscriptionRepository._();

  @override
  int? id;

  int driverId;

  int planId;

  DateTime startDate;

  DateTime endDate;

  _i2.SubscriptionStatus? status;

  bool autoRenew;

  DateTime? cancelledAt;

  String? cancellationReason;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Subscription]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Subscription copyWith({
    int? id,
    int? driverId,
    int? planId,
    DateTime? startDate,
    DateTime? endDate,
    _i2.SubscriptionStatus? status,
    bool? autoRenew,
    DateTime? cancelledAt,
    String? cancellationReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Subscription',
      if (id != null) 'id': id,
      'driverId': driverId,
      'planId': planId,
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      if (status != null) 'status': status?.toJson(),
      'autoRenew': autoRenew,
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
      if (cancellationReason != null) 'cancellationReason': cancellationReason,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Subscription',
      if (id != null) 'id': id,
      'driverId': driverId,
      'planId': planId,
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      if (status != null) 'status': status?.toJson(),
      'autoRenew': autoRenew,
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
      if (cancellationReason != null) 'cancellationReason': cancellationReason,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SubscriptionInclude include() {
    return SubscriptionInclude._();
  }

  static SubscriptionIncludeList includeList({
    _i1.WhereExpressionBuilder<SubscriptionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubscriptionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubscriptionTable>? orderByList,
    SubscriptionInclude? include,
  }) {
    return SubscriptionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Subscription.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Subscription.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubscriptionImpl extends Subscription {
  _SubscriptionImpl({
    int? id,
    required int driverId,
    required int planId,
    required DateTime startDate,
    required DateTime endDate,
    _i2.SubscriptionStatus? status,
    bool? autoRenew,
    DateTime? cancelledAt,
    String? cancellationReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         driverId: driverId,
         planId: planId,
         startDate: startDate,
         endDate: endDate,
         status: status,
         autoRenew: autoRenew,
         cancelledAt: cancelledAt,
         cancellationReason: cancellationReason,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Subscription]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Subscription copyWith({
    Object? id = _Undefined,
    int? driverId,
    int? planId,
    DateTime? startDate,
    DateTime? endDate,
    Object? status = _Undefined,
    bool? autoRenew,
    Object? cancelledAt = _Undefined,
    Object? cancellationReason = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Subscription(
      id: id is int? ? id : this.id,
      driverId: driverId ?? this.driverId,
      planId: planId ?? this.planId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status is _i2.SubscriptionStatus? ? status : this.status,
      autoRenew: autoRenew ?? this.autoRenew,
      cancelledAt: cancelledAt is DateTime? ? cancelledAt : this.cancelledAt,
      cancellationReason: cancellationReason is String?
          ? cancellationReason
          : this.cancellationReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SubscriptionUpdateTable extends _i1.UpdateTable<SubscriptionTable> {
  SubscriptionUpdateTable(super.table);

  _i1.ColumnValue<int, int> driverId(int value) => _i1.ColumnValue(
    table.driverId,
    value,
  );

  _i1.ColumnValue<int, int> planId(int value) => _i1.ColumnValue(
    table.planId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startDate(DateTime value) =>
      _i1.ColumnValue(
        table.startDate,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> endDate(DateTime value) =>
      _i1.ColumnValue(
        table.endDate,
        value,
      );

  _i1.ColumnValue<_i2.SubscriptionStatus, _i2.SubscriptionStatus> status(
    _i2.SubscriptionStatus? value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<bool, bool> autoRenew(bool value) => _i1.ColumnValue(
    table.autoRenew,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> cancelledAt(DateTime? value) =>
      _i1.ColumnValue(
        table.cancelledAt,
        value,
      );

  _i1.ColumnValue<String, String> cancellationReason(String? value) =>
      _i1.ColumnValue(
        table.cancellationReason,
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

class SubscriptionTable extends _i1.Table<int?> {
  SubscriptionTable({super.tableRelation}) : super(tableName: 'subscriptions') {
    updateTable = SubscriptionUpdateTable(this);
    driverId = _i1.ColumnInt(
      'driverId',
      this,
    );
    planId = _i1.ColumnInt(
      'planId',
      this,
    );
    startDate = _i1.ColumnDateTime(
      'startDate',
      this,
    );
    endDate = _i1.ColumnDateTime(
      'endDate',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byIndex,
    );
    autoRenew = _i1.ColumnBool(
      'autoRenew',
      this,
      hasDefault: true,
    );
    cancelledAt = _i1.ColumnDateTime(
      'cancelledAt',
      this,
    );
    cancellationReason = _i1.ColumnString(
      'cancellationReason',
      this,
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

  late final SubscriptionUpdateTable updateTable;

  late final _i1.ColumnInt driverId;

  late final _i1.ColumnInt planId;

  late final _i1.ColumnDateTime startDate;

  late final _i1.ColumnDateTime endDate;

  late final _i1.ColumnEnum<_i2.SubscriptionStatus> status;

  late final _i1.ColumnBool autoRenew;

  late final _i1.ColumnDateTime cancelledAt;

  late final _i1.ColumnString cancellationReason;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    driverId,
    planId,
    startDate,
    endDate,
    status,
    autoRenew,
    cancelledAt,
    cancellationReason,
    createdAt,
    updatedAt,
  ];
}

class SubscriptionInclude extends _i1.IncludeObject {
  SubscriptionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Subscription.t;
}

class SubscriptionIncludeList extends _i1.IncludeList {
  SubscriptionIncludeList._({
    _i1.WhereExpressionBuilder<SubscriptionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Subscription.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Subscription.t;
}

class SubscriptionRepository {
  const SubscriptionRepository._();

  /// Returns a list of [Subscription]s matching the given query parameters.
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
  Future<List<Subscription>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubscriptionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubscriptionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubscriptionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Subscription>(
      where: where?.call(Subscription.t),
      orderBy: orderBy?.call(Subscription.t),
      orderByList: orderByList?.call(Subscription.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Subscription] matching the given query parameters.
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
  Future<Subscription?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubscriptionTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubscriptionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubscriptionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Subscription>(
      where: where?.call(Subscription.t),
      orderBy: orderBy?.call(Subscription.t),
      orderByList: orderByList?.call(Subscription.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Subscription] by its [id] or null if no such row exists.
  Future<Subscription?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Subscription>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Subscription]s in the list and returns the inserted rows.
  ///
  /// The returned [Subscription]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Subscription>> insert(
    _i1.Session session,
    List<Subscription> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Subscription>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Subscription] and returns the inserted row.
  ///
  /// The returned [Subscription] will have its `id` field set.
  Future<Subscription> insertRow(
    _i1.Session session,
    Subscription row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Subscription>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Subscription]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Subscription>> update(
    _i1.Session session,
    List<Subscription> rows, {
    _i1.ColumnSelections<SubscriptionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Subscription>(
      rows,
      columns: columns?.call(Subscription.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Subscription]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Subscription> updateRow(
    _i1.Session session,
    Subscription row, {
    _i1.ColumnSelections<SubscriptionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Subscription>(
      row,
      columns: columns?.call(Subscription.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Subscription] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Subscription?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<SubscriptionUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Subscription>(
      id,
      columnValues: columnValues(Subscription.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Subscription]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Subscription>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SubscriptionUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SubscriptionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubscriptionTable>? orderBy,
    _i1.OrderByListBuilder<SubscriptionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Subscription>(
      columnValues: columnValues(Subscription.t.updateTable),
      where: where(Subscription.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Subscription.t),
      orderByList: orderByList?.call(Subscription.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Subscription]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Subscription>> delete(
    _i1.Session session,
    List<Subscription> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Subscription>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Subscription].
  Future<Subscription> deleteRow(
    _i1.Session session,
    Subscription row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Subscription>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Subscription>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SubscriptionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Subscription>(
      where: where(Subscription.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SubscriptionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Subscription>(
      where: where?.call(Subscription.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
