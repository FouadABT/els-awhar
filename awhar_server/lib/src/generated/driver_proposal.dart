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
import 'proposal_status.dart' as _i2;

abstract class DriverProposal
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DriverProposal._({
    this.id,
    required this.requestId,
    required this.driverId,
    this.proposedPrice,
    required this.estimatedArrival,
    this.message,
    required this.driverName,
    this.driverPhone,
    double? driverRating,
    this.driverVehicleInfo,
    _i2.ProposalStatus? status,
    DateTime? createdAt,
    this.acceptedAt,
    this.rejectedAt,
  }) : driverRating = driverRating ?? 0.0,
       status = status ?? _i2.ProposalStatus.pending,
       createdAt = createdAt ?? DateTime.now();

  factory DriverProposal({
    int? id,
    required int requestId,
    required int driverId,
    double? proposedPrice,
    required int estimatedArrival,
    String? message,
    required String driverName,
    String? driverPhone,
    double? driverRating,
    String? driverVehicleInfo,
    _i2.ProposalStatus? status,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? rejectedAt,
  }) = _DriverProposalImpl;

  factory DriverProposal.fromJson(Map<String, dynamic> jsonSerialization) {
    return DriverProposal(
      id: jsonSerialization['id'] as int?,
      requestId: jsonSerialization['requestId'] as int,
      driverId: jsonSerialization['driverId'] as int,
      proposedPrice: (jsonSerialization['proposedPrice'] as num?)?.toDouble(),
      estimatedArrival: jsonSerialization['estimatedArrival'] as int,
      message: jsonSerialization['message'] as String?,
      driverName: jsonSerialization['driverName'] as String,
      driverPhone: jsonSerialization['driverPhone'] as String?,
      driverRating: (jsonSerialization['driverRating'] as num?)?.toDouble(),
      driverVehicleInfo: jsonSerialization['driverVehicleInfo'] as String?,
      status: _i2.ProposalStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      acceptedAt: jsonSerialization['acceptedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['acceptedAt']),
      rejectedAt: jsonSerialization['rejectedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['rejectedAt']),
    );
  }

  static final t = DriverProposalTable();

  static const db = DriverProposalRepository._();

  @override
  int? id;

  int requestId;

  int driverId;

  double? proposedPrice;

  int estimatedArrival;

  String? message;

  String driverName;

  String? driverPhone;

  double? driverRating;

  String? driverVehicleInfo;

  _i2.ProposalStatus status;

  DateTime createdAt;

  DateTime? acceptedAt;

  DateTime? rejectedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DriverProposal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DriverProposal copyWith({
    int? id,
    int? requestId,
    int? driverId,
    double? proposedPrice,
    int? estimatedArrival,
    String? message,
    String? driverName,
    String? driverPhone,
    double? driverRating,
    String? driverVehicleInfo,
    _i2.ProposalStatus? status,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? rejectedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DriverProposal',
      if (id != null) 'id': id,
      'requestId': requestId,
      'driverId': driverId,
      if (proposedPrice != null) 'proposedPrice': proposedPrice,
      'estimatedArrival': estimatedArrival,
      if (message != null) 'message': message,
      'driverName': driverName,
      if (driverPhone != null) 'driverPhone': driverPhone,
      if (driverRating != null) 'driverRating': driverRating,
      if (driverVehicleInfo != null) 'driverVehicleInfo': driverVehicleInfo,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
      if (rejectedAt != null) 'rejectedAt': rejectedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DriverProposal',
      if (id != null) 'id': id,
      'requestId': requestId,
      'driverId': driverId,
      if (proposedPrice != null) 'proposedPrice': proposedPrice,
      'estimatedArrival': estimatedArrival,
      if (message != null) 'message': message,
      'driverName': driverName,
      if (driverPhone != null) 'driverPhone': driverPhone,
      if (driverRating != null) 'driverRating': driverRating,
      if (driverVehicleInfo != null) 'driverVehicleInfo': driverVehicleInfo,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
      if (rejectedAt != null) 'rejectedAt': rejectedAt?.toJson(),
    };
  }

  static DriverProposalInclude include() {
    return DriverProposalInclude._();
  }

  static DriverProposalIncludeList includeList({
    _i1.WhereExpressionBuilder<DriverProposalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverProposalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverProposalTable>? orderByList,
    DriverProposalInclude? include,
  }) {
    return DriverProposalIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DriverProposal.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DriverProposal.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DriverProposalImpl extends DriverProposal {
  _DriverProposalImpl({
    int? id,
    required int requestId,
    required int driverId,
    double? proposedPrice,
    required int estimatedArrival,
    String? message,
    required String driverName,
    String? driverPhone,
    double? driverRating,
    String? driverVehicleInfo,
    _i2.ProposalStatus? status,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? rejectedAt,
  }) : super._(
         id: id,
         requestId: requestId,
         driverId: driverId,
         proposedPrice: proposedPrice,
         estimatedArrival: estimatedArrival,
         message: message,
         driverName: driverName,
         driverPhone: driverPhone,
         driverRating: driverRating,
         driverVehicleInfo: driverVehicleInfo,
         status: status,
         createdAt: createdAt,
         acceptedAt: acceptedAt,
         rejectedAt: rejectedAt,
       );

  /// Returns a shallow copy of this [DriverProposal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DriverProposal copyWith({
    Object? id = _Undefined,
    int? requestId,
    int? driverId,
    Object? proposedPrice = _Undefined,
    int? estimatedArrival,
    Object? message = _Undefined,
    String? driverName,
    Object? driverPhone = _Undefined,
    Object? driverRating = _Undefined,
    Object? driverVehicleInfo = _Undefined,
    _i2.ProposalStatus? status,
    DateTime? createdAt,
    Object? acceptedAt = _Undefined,
    Object? rejectedAt = _Undefined,
  }) {
    return DriverProposal(
      id: id is int? ? id : this.id,
      requestId: requestId ?? this.requestId,
      driverId: driverId ?? this.driverId,
      proposedPrice: proposedPrice is double?
          ? proposedPrice
          : this.proposedPrice,
      estimatedArrival: estimatedArrival ?? this.estimatedArrival,
      message: message is String? ? message : this.message,
      driverName: driverName ?? this.driverName,
      driverPhone: driverPhone is String? ? driverPhone : this.driverPhone,
      driverRating: driverRating is double? ? driverRating : this.driverRating,
      driverVehicleInfo: driverVehicleInfo is String?
          ? driverVehicleInfo
          : this.driverVehicleInfo,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      acceptedAt: acceptedAt is DateTime? ? acceptedAt : this.acceptedAt,
      rejectedAt: rejectedAt is DateTime? ? rejectedAt : this.rejectedAt,
    );
  }
}

class DriverProposalUpdateTable extends _i1.UpdateTable<DriverProposalTable> {
  DriverProposalUpdateTable(super.table);

  _i1.ColumnValue<int, int> requestId(int value) => _i1.ColumnValue(
    table.requestId,
    value,
  );

  _i1.ColumnValue<int, int> driverId(int value) => _i1.ColumnValue(
    table.driverId,
    value,
  );

  _i1.ColumnValue<double, double> proposedPrice(double? value) =>
      _i1.ColumnValue(
        table.proposedPrice,
        value,
      );

  _i1.ColumnValue<int, int> estimatedArrival(int value) => _i1.ColumnValue(
    table.estimatedArrival,
    value,
  );

  _i1.ColumnValue<String, String> message(String? value) => _i1.ColumnValue(
    table.message,
    value,
  );

  _i1.ColumnValue<String, String> driverName(String value) => _i1.ColumnValue(
    table.driverName,
    value,
  );

  _i1.ColumnValue<String, String> driverPhone(String? value) => _i1.ColumnValue(
    table.driverPhone,
    value,
  );

  _i1.ColumnValue<double, double> driverRating(double? value) =>
      _i1.ColumnValue(
        table.driverRating,
        value,
      );

  _i1.ColumnValue<String, String> driverVehicleInfo(String? value) =>
      _i1.ColumnValue(
        table.driverVehicleInfo,
        value,
      );

  _i1.ColumnValue<_i2.ProposalStatus, _i2.ProposalStatus> status(
    _i2.ProposalStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> acceptedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.acceptedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> rejectedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.rejectedAt,
        value,
      );
}

class DriverProposalTable extends _i1.Table<int?> {
  DriverProposalTable({super.tableRelation})
    : super(tableName: 'driver_proposals') {
    updateTable = DriverProposalUpdateTable(this);
    requestId = _i1.ColumnInt(
      'requestId',
      this,
    );
    driverId = _i1.ColumnInt(
      'driverId',
      this,
    );
    proposedPrice = _i1.ColumnDouble(
      'proposedPrice',
      this,
    );
    estimatedArrival = _i1.ColumnInt(
      'estimatedArrival',
      this,
    );
    message = _i1.ColumnString(
      'message',
      this,
    );
    driverName = _i1.ColumnString(
      'driverName',
      this,
    );
    driverPhone = _i1.ColumnString(
      'driverPhone',
      this,
    );
    driverRating = _i1.ColumnDouble(
      'driverRating',
      this,
      hasDefault: true,
    );
    driverVehicleInfo = _i1.ColumnString(
      'driverVehicleInfo',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    acceptedAt = _i1.ColumnDateTime(
      'acceptedAt',
      this,
    );
    rejectedAt = _i1.ColumnDateTime(
      'rejectedAt',
      this,
    );
  }

  late final DriverProposalUpdateTable updateTable;

  late final _i1.ColumnInt requestId;

  late final _i1.ColumnInt driverId;

  late final _i1.ColumnDouble proposedPrice;

  late final _i1.ColumnInt estimatedArrival;

  late final _i1.ColumnString message;

  late final _i1.ColumnString driverName;

  late final _i1.ColumnString driverPhone;

  late final _i1.ColumnDouble driverRating;

  late final _i1.ColumnString driverVehicleInfo;

  late final _i1.ColumnEnum<_i2.ProposalStatus> status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime acceptedAt;

  late final _i1.ColumnDateTime rejectedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    requestId,
    driverId,
    proposedPrice,
    estimatedArrival,
    message,
    driverName,
    driverPhone,
    driverRating,
    driverVehicleInfo,
    status,
    createdAt,
    acceptedAt,
    rejectedAt,
  ];
}

class DriverProposalInclude extends _i1.IncludeObject {
  DriverProposalInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DriverProposal.t;
}

class DriverProposalIncludeList extends _i1.IncludeList {
  DriverProposalIncludeList._({
    _i1.WhereExpressionBuilder<DriverProposalTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DriverProposal.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DriverProposal.t;
}

class DriverProposalRepository {
  const DriverProposalRepository._();

  /// Returns a list of [DriverProposal]s matching the given query parameters.
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
  Future<List<DriverProposal>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverProposalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverProposalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverProposalTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<DriverProposal>(
      where: where?.call(DriverProposal.t),
      orderBy: orderBy?.call(DriverProposal.t),
      orderByList: orderByList?.call(DriverProposal.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [DriverProposal] matching the given query parameters.
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
  Future<DriverProposal?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverProposalTable>? where,
    int? offset,
    _i1.OrderByBuilder<DriverProposalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverProposalTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<DriverProposal>(
      where: where?.call(DriverProposal.t),
      orderBy: orderBy?.call(DriverProposal.t),
      orderByList: orderByList?.call(DriverProposal.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [DriverProposal] by its [id] or null if no such row exists.
  Future<DriverProposal?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<DriverProposal>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [DriverProposal]s in the list and returns the inserted rows.
  ///
  /// The returned [DriverProposal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<DriverProposal>> insert(
    _i1.Session session,
    List<DriverProposal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<DriverProposal>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [DriverProposal] and returns the inserted row.
  ///
  /// The returned [DriverProposal] will have its `id` field set.
  Future<DriverProposal> insertRow(
    _i1.Session session,
    DriverProposal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DriverProposal>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DriverProposal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DriverProposal>> update(
    _i1.Session session,
    List<DriverProposal> rows, {
    _i1.ColumnSelections<DriverProposalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DriverProposal>(
      rows,
      columns: columns?.call(DriverProposal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DriverProposal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DriverProposal> updateRow(
    _i1.Session session,
    DriverProposal row, {
    _i1.ColumnSelections<DriverProposalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DriverProposal>(
      row,
      columns: columns?.call(DriverProposal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DriverProposal] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DriverProposal?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<DriverProposalUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DriverProposal>(
      id,
      columnValues: columnValues(DriverProposal.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DriverProposal]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DriverProposal>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DriverProposalUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DriverProposalTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverProposalTable>? orderBy,
    _i1.OrderByListBuilder<DriverProposalTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DriverProposal>(
      columnValues: columnValues(DriverProposal.t.updateTable),
      where: where(DriverProposal.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DriverProposal.t),
      orderByList: orderByList?.call(DriverProposal.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DriverProposal]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DriverProposal>> delete(
    _i1.Session session,
    List<DriverProposal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DriverProposal>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DriverProposal].
  Future<DriverProposal> deleteRow(
    _i1.Session session,
    DriverProposal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DriverProposal>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DriverProposal>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DriverProposalTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DriverProposal>(
      where: where(DriverProposal.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverProposalTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DriverProposal>(
      where: where?.call(DriverProposal.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
