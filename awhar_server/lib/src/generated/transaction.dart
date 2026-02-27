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
import 'transaction_status.dart' as _i2;
import 'transaction_type.dart' as _i3;

abstract class Transaction
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Transaction._({
    this.id,
    required this.userId,
    this.requestId,
    required this.amount,
    required this.type,
    _i2.TransactionStatus? status,
    String? paymentMethod,
    String? currency,
    String? currencySymbol,
    this.baseCurrencyAmount,
    double? exchangeRateToBase,
    double? vatRate,
    double? vatAmount,
    this.description,
    this.notes,
    double? platformCommission,
    double? driverEarnings,
    bool? driverConfirmed,
    bool? clientConfirmed,
    this.driverConfirmedAt,
    this.clientConfirmedAt,
    DateTime? createdAt,
    this.completedAt,
    this.refundedAt,
  }) : status = status ?? _i2.TransactionStatus.completed,
       paymentMethod = paymentMethod ?? 'cash',
       currency = currency ?? 'MAD',
       currencySymbol = currencySymbol ?? 'DH',
       exchangeRateToBase = exchangeRateToBase ?? 1.0,
       vatRate = vatRate ?? 0.0,
       vatAmount = vatAmount ?? 0.0,
       platformCommission = platformCommission ?? 0.0,
       driverEarnings = driverEarnings ?? 0.0,
       driverConfirmed = driverConfirmed ?? false,
       clientConfirmed = clientConfirmed ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory Transaction({
    int? id,
    required int userId,
    int? requestId,
    required double amount,
    required _i3.TransactionType type,
    _i2.TransactionStatus? status,
    String? paymentMethod,
    String? currency,
    String? currencySymbol,
    double? baseCurrencyAmount,
    double? exchangeRateToBase,
    double? vatRate,
    double? vatAmount,
    String? description,
    String? notes,
    double? platformCommission,
    double? driverEarnings,
    bool? driverConfirmed,
    bool? clientConfirmed,
    DateTime? driverConfirmedAt,
    DateTime? clientConfirmedAt,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? refundedAt,
  }) = _TransactionImpl;

  factory Transaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return Transaction(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      requestId: jsonSerialization['requestId'] as int?,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      type: _i3.TransactionType.fromJson((jsonSerialization['type'] as String)),
      status: _i2.TransactionStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      paymentMethod: jsonSerialization['paymentMethod'] as String,
      currency: jsonSerialization['currency'] as String,
      currencySymbol: jsonSerialization['currencySymbol'] as String,
      baseCurrencyAmount: (jsonSerialization['baseCurrencyAmount'] as num?)
          ?.toDouble(),
      exchangeRateToBase: (jsonSerialization['exchangeRateToBase'] as num)
          .toDouble(),
      vatRate: (jsonSerialization['vatRate'] as num).toDouble(),
      vatAmount: (jsonSerialization['vatAmount'] as num).toDouble(),
      description: jsonSerialization['description'] as String?,
      notes: jsonSerialization['notes'] as String?,
      platformCommission: (jsonSerialization['platformCommission'] as num)
          .toDouble(),
      driverEarnings: (jsonSerialization['driverEarnings'] as num).toDouble(),
      driverConfirmed: jsonSerialization['driverConfirmed'] as bool,
      clientConfirmed: jsonSerialization['clientConfirmed'] as bool,
      driverConfirmedAt: jsonSerialization['driverConfirmedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['driverConfirmedAt'],
            ),
      clientConfirmedAt: jsonSerialization['clientConfirmedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['clientConfirmedAt'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      refundedAt: jsonSerialization['refundedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['refundedAt']),
    );
  }

  static final t = TransactionTable();

  static const db = TransactionRepository._();

  @override
  int? id;

  int userId;

  int? requestId;

  double amount;

  _i3.TransactionType type;

  _i2.TransactionStatus status;

  String paymentMethod;

  String currency;

  String currencySymbol;

  double? baseCurrencyAmount;

  double exchangeRateToBase;

  double vatRate;

  double vatAmount;

  String? description;

  String? notes;

  double platformCommission;

  double driverEarnings;

  bool driverConfirmed;

  bool clientConfirmed;

  DateTime? driverConfirmedAt;

  DateTime? clientConfirmedAt;

  DateTime createdAt;

  DateTime? completedAt;

  DateTime? refundedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Transaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Transaction copyWith({
    int? id,
    int? userId,
    int? requestId,
    double? amount,
    _i3.TransactionType? type,
    _i2.TransactionStatus? status,
    String? paymentMethod,
    String? currency,
    String? currencySymbol,
    double? baseCurrencyAmount,
    double? exchangeRateToBase,
    double? vatRate,
    double? vatAmount,
    String? description,
    String? notes,
    double? platformCommission,
    double? driverEarnings,
    bool? driverConfirmed,
    bool? clientConfirmed,
    DateTime? driverConfirmedAt,
    DateTime? clientConfirmedAt,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? refundedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Transaction',
      if (id != null) 'id': id,
      'userId': userId,
      if (requestId != null) 'requestId': requestId,
      'amount': amount,
      'type': type.toJson(),
      'status': status.toJson(),
      'paymentMethod': paymentMethod,
      'currency': currency,
      'currencySymbol': currencySymbol,
      if (baseCurrencyAmount != null) 'baseCurrencyAmount': baseCurrencyAmount,
      'exchangeRateToBase': exchangeRateToBase,
      'vatRate': vatRate,
      'vatAmount': vatAmount,
      if (description != null) 'description': description,
      if (notes != null) 'notes': notes,
      'platformCommission': platformCommission,
      'driverEarnings': driverEarnings,
      'driverConfirmed': driverConfirmed,
      'clientConfirmed': clientConfirmed,
      if (driverConfirmedAt != null)
        'driverConfirmedAt': driverConfirmedAt?.toJson(),
      if (clientConfirmedAt != null)
        'clientConfirmedAt': clientConfirmedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (refundedAt != null) 'refundedAt': refundedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Transaction',
      if (id != null) 'id': id,
      'userId': userId,
      if (requestId != null) 'requestId': requestId,
      'amount': amount,
      'type': type.toJson(),
      'status': status.toJson(),
      'paymentMethod': paymentMethod,
      'currency': currency,
      'currencySymbol': currencySymbol,
      if (baseCurrencyAmount != null) 'baseCurrencyAmount': baseCurrencyAmount,
      'exchangeRateToBase': exchangeRateToBase,
      'vatRate': vatRate,
      'vatAmount': vatAmount,
      if (description != null) 'description': description,
      if (notes != null) 'notes': notes,
      'platformCommission': platformCommission,
      'driverEarnings': driverEarnings,
      'driverConfirmed': driverConfirmed,
      'clientConfirmed': clientConfirmed,
      if (driverConfirmedAt != null)
        'driverConfirmedAt': driverConfirmedAt?.toJson(),
      if (clientConfirmedAt != null)
        'clientConfirmedAt': clientConfirmedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (refundedAt != null) 'refundedAt': refundedAt?.toJson(),
    };
  }

  static TransactionInclude include() {
    return TransactionInclude._();
  }

  static TransactionIncludeList includeList({
    _i1.WhereExpressionBuilder<TransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TransactionTable>? orderByList,
    TransactionInclude? include,
  }) {
    return TransactionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Transaction.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Transaction.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TransactionImpl extends Transaction {
  _TransactionImpl({
    int? id,
    required int userId,
    int? requestId,
    required double amount,
    required _i3.TransactionType type,
    _i2.TransactionStatus? status,
    String? paymentMethod,
    String? currency,
    String? currencySymbol,
    double? baseCurrencyAmount,
    double? exchangeRateToBase,
    double? vatRate,
    double? vatAmount,
    String? description,
    String? notes,
    double? platformCommission,
    double? driverEarnings,
    bool? driverConfirmed,
    bool? clientConfirmed,
    DateTime? driverConfirmedAt,
    DateTime? clientConfirmedAt,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? refundedAt,
  }) : super._(
         id: id,
         userId: userId,
         requestId: requestId,
         amount: amount,
         type: type,
         status: status,
         paymentMethod: paymentMethod,
         currency: currency,
         currencySymbol: currencySymbol,
         baseCurrencyAmount: baseCurrencyAmount,
         exchangeRateToBase: exchangeRateToBase,
         vatRate: vatRate,
         vatAmount: vatAmount,
         description: description,
         notes: notes,
         platformCommission: platformCommission,
         driverEarnings: driverEarnings,
         driverConfirmed: driverConfirmed,
         clientConfirmed: clientConfirmed,
         driverConfirmedAt: driverConfirmedAt,
         clientConfirmedAt: clientConfirmedAt,
         createdAt: createdAt,
         completedAt: completedAt,
         refundedAt: refundedAt,
       );

  /// Returns a shallow copy of this [Transaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Transaction copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? requestId = _Undefined,
    double? amount,
    _i3.TransactionType? type,
    _i2.TransactionStatus? status,
    String? paymentMethod,
    String? currency,
    String? currencySymbol,
    Object? baseCurrencyAmount = _Undefined,
    double? exchangeRateToBase,
    double? vatRate,
    double? vatAmount,
    Object? description = _Undefined,
    Object? notes = _Undefined,
    double? platformCommission,
    double? driverEarnings,
    bool? driverConfirmed,
    bool? clientConfirmed,
    Object? driverConfirmedAt = _Undefined,
    Object? clientConfirmedAt = _Undefined,
    DateTime? createdAt,
    Object? completedAt = _Undefined,
    Object? refundedAt = _Undefined,
  }) {
    return Transaction(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      requestId: requestId is int? ? requestId : this.requestId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      baseCurrencyAmount: baseCurrencyAmount is double?
          ? baseCurrencyAmount
          : this.baseCurrencyAmount,
      exchangeRateToBase: exchangeRateToBase ?? this.exchangeRateToBase,
      vatRate: vatRate ?? this.vatRate,
      vatAmount: vatAmount ?? this.vatAmount,
      description: description is String? ? description : this.description,
      notes: notes is String? ? notes : this.notes,
      platformCommission: platformCommission ?? this.platformCommission,
      driverEarnings: driverEarnings ?? this.driverEarnings,
      driverConfirmed: driverConfirmed ?? this.driverConfirmed,
      clientConfirmed: clientConfirmed ?? this.clientConfirmed,
      driverConfirmedAt: driverConfirmedAt is DateTime?
          ? driverConfirmedAt
          : this.driverConfirmedAt,
      clientConfirmedAt: clientConfirmedAt is DateTime?
          ? clientConfirmedAt
          : this.clientConfirmedAt,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      refundedAt: refundedAt is DateTime? ? refundedAt : this.refundedAt,
    );
  }
}

class TransactionUpdateTable extends _i1.UpdateTable<TransactionTable> {
  TransactionUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> requestId(int? value) => _i1.ColumnValue(
    table.requestId,
    value,
  );

  _i1.ColumnValue<double, double> amount(double value) => _i1.ColumnValue(
    table.amount,
    value,
  );

  _i1.ColumnValue<_i3.TransactionType, _i3.TransactionType> type(
    _i3.TransactionType value,
  ) => _i1.ColumnValue(
    table.type,
    value,
  );

  _i1.ColumnValue<_i2.TransactionStatus, _i2.TransactionStatus> status(
    _i2.TransactionStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> paymentMethod(String value) =>
      _i1.ColumnValue(
        table.paymentMethod,
        value,
      );

  _i1.ColumnValue<String, String> currency(String value) => _i1.ColumnValue(
    table.currency,
    value,
  );

  _i1.ColumnValue<String, String> currencySymbol(String value) =>
      _i1.ColumnValue(
        table.currencySymbol,
        value,
      );

  _i1.ColumnValue<double, double> baseCurrencyAmount(double? value) =>
      _i1.ColumnValue(
        table.baseCurrencyAmount,
        value,
      );

  _i1.ColumnValue<double, double> exchangeRateToBase(double value) =>
      _i1.ColumnValue(
        table.exchangeRateToBase,
        value,
      );

  _i1.ColumnValue<double, double> vatRate(double value) => _i1.ColumnValue(
    table.vatRate,
    value,
  );

  _i1.ColumnValue<double, double> vatAmount(double value) => _i1.ColumnValue(
    table.vatAmount,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );

  _i1.ColumnValue<double, double> platformCommission(double value) =>
      _i1.ColumnValue(
        table.platformCommission,
        value,
      );

  _i1.ColumnValue<double, double> driverEarnings(double value) =>
      _i1.ColumnValue(
        table.driverEarnings,
        value,
      );

  _i1.ColumnValue<bool, bool> driverConfirmed(bool value) => _i1.ColumnValue(
    table.driverConfirmed,
    value,
  );

  _i1.ColumnValue<bool, bool> clientConfirmed(bool value) => _i1.ColumnValue(
    table.clientConfirmed,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> driverConfirmedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.driverConfirmedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> clientConfirmedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.clientConfirmedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> refundedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.refundedAt,
        value,
      );
}

class TransactionTable extends _i1.Table<int?> {
  TransactionTable({super.tableRelation}) : super(tableName: 'transactions') {
    updateTable = TransactionUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    requestId = _i1.ColumnInt(
      'requestId',
      this,
    );
    amount = _i1.ColumnDouble(
      'amount',
      this,
    );
    type = _i1.ColumnEnum(
      'type',
      this,
      _i1.EnumSerialization.byName,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    paymentMethod = _i1.ColumnString(
      'paymentMethod',
      this,
      hasDefault: true,
    );
    currency = _i1.ColumnString(
      'currency',
      this,
      hasDefault: true,
    );
    currencySymbol = _i1.ColumnString(
      'currencySymbol',
      this,
      hasDefault: true,
    );
    baseCurrencyAmount = _i1.ColumnDouble(
      'baseCurrencyAmount',
      this,
    );
    exchangeRateToBase = _i1.ColumnDouble(
      'exchangeRateToBase',
      this,
      hasDefault: true,
    );
    vatRate = _i1.ColumnDouble(
      'vatRate',
      this,
      hasDefault: true,
    );
    vatAmount = _i1.ColumnDouble(
      'vatAmount',
      this,
      hasDefault: true,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    platformCommission = _i1.ColumnDouble(
      'platformCommission',
      this,
      hasDefault: true,
    );
    driverEarnings = _i1.ColumnDouble(
      'driverEarnings',
      this,
      hasDefault: true,
    );
    driverConfirmed = _i1.ColumnBool(
      'driverConfirmed',
      this,
      hasDefault: true,
    );
    clientConfirmed = _i1.ColumnBool(
      'clientConfirmed',
      this,
      hasDefault: true,
    );
    driverConfirmedAt = _i1.ColumnDateTime(
      'driverConfirmedAt',
      this,
    );
    clientConfirmedAt = _i1.ColumnDateTime(
      'clientConfirmedAt',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
    refundedAt = _i1.ColumnDateTime(
      'refundedAt',
      this,
    );
  }

  late final TransactionUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt requestId;

  late final _i1.ColumnDouble amount;

  late final _i1.ColumnEnum<_i3.TransactionType> type;

  late final _i1.ColumnEnum<_i2.TransactionStatus> status;

  late final _i1.ColumnString paymentMethod;

  late final _i1.ColumnString currency;

  late final _i1.ColumnString currencySymbol;

  late final _i1.ColumnDouble baseCurrencyAmount;

  late final _i1.ColumnDouble exchangeRateToBase;

  late final _i1.ColumnDouble vatRate;

  late final _i1.ColumnDouble vatAmount;

  late final _i1.ColumnString description;

  late final _i1.ColumnString notes;

  late final _i1.ColumnDouble platformCommission;

  late final _i1.ColumnDouble driverEarnings;

  late final _i1.ColumnBool driverConfirmed;

  late final _i1.ColumnBool clientConfirmed;

  late final _i1.ColumnDateTime driverConfirmedAt;

  late final _i1.ColumnDateTime clientConfirmedAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime completedAt;

  late final _i1.ColumnDateTime refundedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    requestId,
    amount,
    type,
    status,
    paymentMethod,
    currency,
    currencySymbol,
    baseCurrencyAmount,
    exchangeRateToBase,
    vatRate,
    vatAmount,
    description,
    notes,
    platformCommission,
    driverEarnings,
    driverConfirmed,
    clientConfirmed,
    driverConfirmedAt,
    clientConfirmedAt,
    createdAt,
    completedAt,
    refundedAt,
  ];
}

class TransactionInclude extends _i1.IncludeObject {
  TransactionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Transaction.t;
}

class TransactionIncludeList extends _i1.IncludeList {
  TransactionIncludeList._({
    _i1.WhereExpressionBuilder<TransactionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Transaction.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Transaction.t;
}

class TransactionRepository {
  const TransactionRepository._();

  /// Returns a list of [Transaction]s matching the given query parameters.
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
  Future<List<Transaction>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TransactionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Transaction>(
      where: where?.call(Transaction.t),
      orderBy: orderBy?.call(Transaction.t),
      orderByList: orderByList?.call(Transaction.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Transaction] matching the given query parameters.
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
  Future<Transaction?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TransactionTable>? where,
    int? offset,
    _i1.OrderByBuilder<TransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TransactionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Transaction>(
      where: where?.call(Transaction.t),
      orderBy: orderBy?.call(Transaction.t),
      orderByList: orderByList?.call(Transaction.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Transaction] by its [id] or null if no such row exists.
  Future<Transaction?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Transaction>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Transaction]s in the list and returns the inserted rows.
  ///
  /// The returned [Transaction]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Transaction>> insert(
    _i1.Session session,
    List<Transaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Transaction>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Transaction] and returns the inserted row.
  ///
  /// The returned [Transaction] will have its `id` field set.
  Future<Transaction> insertRow(
    _i1.Session session,
    Transaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Transaction>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Transaction]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Transaction>> update(
    _i1.Session session,
    List<Transaction> rows, {
    _i1.ColumnSelections<TransactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Transaction>(
      rows,
      columns: columns?.call(Transaction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Transaction]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Transaction> updateRow(
    _i1.Session session,
    Transaction row, {
    _i1.ColumnSelections<TransactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Transaction>(
      row,
      columns: columns?.call(Transaction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Transaction] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Transaction?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<TransactionUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Transaction>(
      id,
      columnValues: columnValues(Transaction.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Transaction]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Transaction>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<TransactionUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TransactionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TransactionTable>? orderBy,
    _i1.OrderByListBuilder<TransactionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Transaction>(
      columnValues: columnValues(Transaction.t.updateTable),
      where: where(Transaction.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Transaction.t),
      orderByList: orderByList?.call(Transaction.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Transaction]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Transaction>> delete(
    _i1.Session session,
    List<Transaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Transaction>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Transaction].
  Future<Transaction> deleteRow(
    _i1.Session session,
    Transaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Transaction>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Transaction>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TransactionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Transaction>(
      where: where(Transaction.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TransactionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Transaction>(
      where: where?.call(Transaction.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
