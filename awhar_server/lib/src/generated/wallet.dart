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

abstract class Wallet implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Wallet._({
    this.id,
    required this.userId,
    double? totalEarned,
    double? totalSpent,
    double? pendingEarnings,
    int? totalTransactions,
    int? completedRides,
    double? totalCommissionPaid,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.lastTransactionAt,
  }) : totalEarned = totalEarned ?? 0.0,
       totalSpent = totalSpent ?? 0.0,
       pendingEarnings = pendingEarnings ?? 0.0,
       totalTransactions = totalTransactions ?? 0,
       completedRides = completedRides ?? 0,
       totalCommissionPaid = totalCommissionPaid ?? 0.0,
       currency = currency ?? 'MAD',
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Wallet({
    int? id,
    required int userId,
    double? totalEarned,
    double? totalSpent,
    double? pendingEarnings,
    int? totalTransactions,
    int? completedRides,
    double? totalCommissionPaid,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastTransactionAt,
  }) = _WalletImpl;

  factory Wallet.fromJson(Map<String, dynamic> jsonSerialization) {
    return Wallet(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      totalEarned: (jsonSerialization['totalEarned'] as num).toDouble(),
      totalSpent: (jsonSerialization['totalSpent'] as num).toDouble(),
      pendingEarnings: (jsonSerialization['pendingEarnings'] as num).toDouble(),
      totalTransactions: jsonSerialization['totalTransactions'] as int,
      completedRides: jsonSerialization['completedRides'] as int,
      totalCommissionPaid: (jsonSerialization['totalCommissionPaid'] as num)
          .toDouble(),
      currency: jsonSerialization['currency'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      lastTransactionAt: jsonSerialization['lastTransactionAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastTransactionAt'],
            ),
    );
  }

  static final t = WalletTable();

  static const db = WalletRepository._();

  @override
  int? id;

  int userId;

  double totalEarned;

  double totalSpent;

  double pendingEarnings;

  int totalTransactions;

  int completedRides;

  double totalCommissionPaid;

  String currency;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? lastTransactionAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Wallet]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Wallet copyWith({
    int? id,
    int? userId,
    double? totalEarned,
    double? totalSpent,
    double? pendingEarnings,
    int? totalTransactions,
    int? completedRides,
    double? totalCommissionPaid,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastTransactionAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Wallet',
      if (id != null) 'id': id,
      'userId': userId,
      'totalEarned': totalEarned,
      'totalSpent': totalSpent,
      'pendingEarnings': pendingEarnings,
      'totalTransactions': totalTransactions,
      'completedRides': completedRides,
      'totalCommissionPaid': totalCommissionPaid,
      'currency': currency,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (lastTransactionAt != null)
        'lastTransactionAt': lastTransactionAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Wallet',
      if (id != null) 'id': id,
      'userId': userId,
      'totalEarned': totalEarned,
      'totalSpent': totalSpent,
      'pendingEarnings': pendingEarnings,
      'totalTransactions': totalTransactions,
      'completedRides': completedRides,
      'totalCommissionPaid': totalCommissionPaid,
      'currency': currency,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (lastTransactionAt != null)
        'lastTransactionAt': lastTransactionAt?.toJson(),
    };
  }

  static WalletInclude include() {
    return WalletInclude._();
  }

  static WalletIncludeList includeList({
    _i1.WhereExpressionBuilder<WalletTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WalletTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WalletTable>? orderByList,
    WalletInclude? include,
  }) {
    return WalletIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Wallet.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Wallet.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WalletImpl extends Wallet {
  _WalletImpl({
    int? id,
    required int userId,
    double? totalEarned,
    double? totalSpent,
    double? pendingEarnings,
    int? totalTransactions,
    int? completedRides,
    double? totalCommissionPaid,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastTransactionAt,
  }) : super._(
         id: id,
         userId: userId,
         totalEarned: totalEarned,
         totalSpent: totalSpent,
         pendingEarnings: pendingEarnings,
         totalTransactions: totalTransactions,
         completedRides: completedRides,
         totalCommissionPaid: totalCommissionPaid,
         currency: currency,
         createdAt: createdAt,
         updatedAt: updatedAt,
         lastTransactionAt: lastTransactionAt,
       );

  /// Returns a shallow copy of this [Wallet]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Wallet copyWith({
    Object? id = _Undefined,
    int? userId,
    double? totalEarned,
    double? totalSpent,
    double? pendingEarnings,
    int? totalTransactions,
    int? completedRides,
    double? totalCommissionPaid,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? lastTransactionAt = _Undefined,
  }) {
    return Wallet(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      totalEarned: totalEarned ?? this.totalEarned,
      totalSpent: totalSpent ?? this.totalSpent,
      pendingEarnings: pendingEarnings ?? this.pendingEarnings,
      totalTransactions: totalTransactions ?? this.totalTransactions,
      completedRides: completedRides ?? this.completedRides,
      totalCommissionPaid: totalCommissionPaid ?? this.totalCommissionPaid,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastTransactionAt: lastTransactionAt is DateTime?
          ? lastTransactionAt
          : this.lastTransactionAt,
    );
  }
}

class WalletUpdateTable extends _i1.UpdateTable<WalletTable> {
  WalletUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<double, double> totalEarned(double value) => _i1.ColumnValue(
    table.totalEarned,
    value,
  );

  _i1.ColumnValue<double, double> totalSpent(double value) => _i1.ColumnValue(
    table.totalSpent,
    value,
  );

  _i1.ColumnValue<double, double> pendingEarnings(double value) =>
      _i1.ColumnValue(
        table.pendingEarnings,
        value,
      );

  _i1.ColumnValue<int, int> totalTransactions(int value) => _i1.ColumnValue(
    table.totalTransactions,
    value,
  );

  _i1.ColumnValue<int, int> completedRides(int value) => _i1.ColumnValue(
    table.completedRides,
    value,
  );

  _i1.ColumnValue<double, double> totalCommissionPaid(double value) =>
      _i1.ColumnValue(
        table.totalCommissionPaid,
        value,
      );

  _i1.ColumnValue<String, String> currency(String value) => _i1.ColumnValue(
    table.currency,
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

  _i1.ColumnValue<DateTime, DateTime> lastTransactionAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastTransactionAt,
        value,
      );
}

class WalletTable extends _i1.Table<int?> {
  WalletTable({super.tableRelation}) : super(tableName: 'wallets') {
    updateTable = WalletUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    totalEarned = _i1.ColumnDouble(
      'totalEarned',
      this,
      hasDefault: true,
    );
    totalSpent = _i1.ColumnDouble(
      'totalSpent',
      this,
      hasDefault: true,
    );
    pendingEarnings = _i1.ColumnDouble(
      'pendingEarnings',
      this,
      hasDefault: true,
    );
    totalTransactions = _i1.ColumnInt(
      'totalTransactions',
      this,
      hasDefault: true,
    );
    completedRides = _i1.ColumnInt(
      'completedRides',
      this,
      hasDefault: true,
    );
    totalCommissionPaid = _i1.ColumnDouble(
      'totalCommissionPaid',
      this,
      hasDefault: true,
    );
    currency = _i1.ColumnString(
      'currency',
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
    lastTransactionAt = _i1.ColumnDateTime(
      'lastTransactionAt',
      this,
    );
  }

  late final WalletUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnDouble totalEarned;

  late final _i1.ColumnDouble totalSpent;

  late final _i1.ColumnDouble pendingEarnings;

  late final _i1.ColumnInt totalTransactions;

  late final _i1.ColumnInt completedRides;

  late final _i1.ColumnDouble totalCommissionPaid;

  late final _i1.ColumnString currency;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime lastTransactionAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    totalEarned,
    totalSpent,
    pendingEarnings,
    totalTransactions,
    completedRides,
    totalCommissionPaid,
    currency,
    createdAt,
    updatedAt,
    lastTransactionAt,
  ];
}

class WalletInclude extends _i1.IncludeObject {
  WalletInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Wallet.t;
}

class WalletIncludeList extends _i1.IncludeList {
  WalletIncludeList._({
    _i1.WhereExpressionBuilder<WalletTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Wallet.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Wallet.t;
}

class WalletRepository {
  const WalletRepository._();

  /// Returns a list of [Wallet]s matching the given query parameters.
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
  Future<List<Wallet>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WalletTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WalletTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WalletTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Wallet>(
      where: where?.call(Wallet.t),
      orderBy: orderBy?.call(Wallet.t),
      orderByList: orderByList?.call(Wallet.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Wallet] matching the given query parameters.
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
  Future<Wallet?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WalletTable>? where,
    int? offset,
    _i1.OrderByBuilder<WalletTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WalletTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Wallet>(
      where: where?.call(Wallet.t),
      orderBy: orderBy?.call(Wallet.t),
      orderByList: orderByList?.call(Wallet.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Wallet] by its [id] or null if no such row exists.
  Future<Wallet?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Wallet>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Wallet]s in the list and returns the inserted rows.
  ///
  /// The returned [Wallet]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Wallet>> insert(
    _i1.Session session,
    List<Wallet> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Wallet>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Wallet] and returns the inserted row.
  ///
  /// The returned [Wallet] will have its `id` field set.
  Future<Wallet> insertRow(
    _i1.Session session,
    Wallet row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Wallet>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Wallet]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Wallet>> update(
    _i1.Session session,
    List<Wallet> rows, {
    _i1.ColumnSelections<WalletTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Wallet>(
      rows,
      columns: columns?.call(Wallet.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Wallet]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Wallet> updateRow(
    _i1.Session session,
    Wallet row, {
    _i1.ColumnSelections<WalletTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Wallet>(
      row,
      columns: columns?.call(Wallet.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Wallet] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Wallet?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<WalletUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Wallet>(
      id,
      columnValues: columnValues(Wallet.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Wallet]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Wallet>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<WalletUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<WalletTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WalletTable>? orderBy,
    _i1.OrderByListBuilder<WalletTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Wallet>(
      columnValues: columnValues(Wallet.t.updateTable),
      where: where(Wallet.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Wallet.t),
      orderByList: orderByList?.call(Wallet.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Wallet]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Wallet>> delete(
    _i1.Session session,
    List<Wallet> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Wallet>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Wallet].
  Future<Wallet> deleteRow(
    _i1.Session session,
    Wallet row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Wallet>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Wallet>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<WalletTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Wallet>(
      where: where(Wallet.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WalletTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Wallet>(
      where: where?.call(Wallet.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
