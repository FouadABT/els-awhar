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
import 'payment_method_enum.dart' as _i2;
import 'payment_status_enum.dart' as _i3;

abstract class Payment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Payment._({
    this.id,
    this.subscriptionId,
    this.orderId,
    required this.userId,
    required this.amount,
    String? currency,
    this.paymentMethod,
    this.status,
    this.externalTransactionId,
    this.metadata,
    this.failureReason,
    DateTime? createdAt,
    this.paidAt,
    this.refundedAt,
  }) : currency = currency ?? 'MAD',
       createdAt = createdAt ?? DateTime.now();

  factory Payment({
    int? id,
    int? subscriptionId,
    int? orderId,
    required int userId,
    required double amount,
    String? currency,
    _i2.PaymentMethod? paymentMethod,
    _i3.PaymentStatus? status,
    String? externalTransactionId,
    String? metadata,
    String? failureReason,
    DateTime? createdAt,
    DateTime? paidAt,
    DateTime? refundedAt,
  }) = _PaymentImpl;

  factory Payment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Payment(
      id: jsonSerialization['id'] as int?,
      subscriptionId: jsonSerialization['subscriptionId'] as int?,
      orderId: jsonSerialization['orderId'] as int?,
      userId: jsonSerialization['userId'] as int,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      currency: jsonSerialization['currency'] as String,
      paymentMethod: jsonSerialization['paymentMethod'] == null
          ? null
          : _i2.PaymentMethod.fromJson(
              (jsonSerialization['paymentMethod'] as int),
            ),
      status: jsonSerialization['status'] == null
          ? null
          : _i3.PaymentStatus.fromJson((jsonSerialization['status'] as int)),
      externalTransactionId:
          jsonSerialization['externalTransactionId'] as String?,
      metadata: jsonSerialization['metadata'] as String?,
      failureReason: jsonSerialization['failureReason'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      paidAt: jsonSerialization['paidAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
      refundedAt: jsonSerialization['refundedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['refundedAt']),
    );
  }

  static final t = PaymentTable();

  static const db = PaymentRepository._();

  @override
  int? id;

  int? subscriptionId;

  int? orderId;

  int userId;

  double amount;

  String currency;

  _i2.PaymentMethod? paymentMethod;

  _i3.PaymentStatus? status;

  String? externalTransactionId;

  String? metadata;

  String? failureReason;

  DateTime createdAt;

  DateTime? paidAt;

  DateTime? refundedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Payment copyWith({
    int? id,
    int? subscriptionId,
    int? orderId,
    int? userId,
    double? amount,
    String? currency,
    _i2.PaymentMethod? paymentMethod,
    _i3.PaymentStatus? status,
    String? externalTransactionId,
    String? metadata,
    String? failureReason,
    DateTime? createdAt,
    DateTime? paidAt,
    DateTime? refundedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Payment',
      if (id != null) 'id': id,
      if (subscriptionId != null) 'subscriptionId': subscriptionId,
      if (orderId != null) 'orderId': orderId,
      'userId': userId,
      'amount': amount,
      'currency': currency,
      if (paymentMethod != null) 'paymentMethod': paymentMethod?.toJson(),
      if (status != null) 'status': status?.toJson(),
      if (externalTransactionId != null)
        'externalTransactionId': externalTransactionId,
      if (metadata != null) 'metadata': metadata,
      if (failureReason != null) 'failureReason': failureReason,
      'createdAt': createdAt.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (refundedAt != null) 'refundedAt': refundedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Payment',
      if (id != null) 'id': id,
      if (subscriptionId != null) 'subscriptionId': subscriptionId,
      if (orderId != null) 'orderId': orderId,
      'userId': userId,
      'amount': amount,
      'currency': currency,
      if (paymentMethod != null) 'paymentMethod': paymentMethod?.toJson(),
      if (status != null) 'status': status?.toJson(),
      if (externalTransactionId != null)
        'externalTransactionId': externalTransactionId,
      if (metadata != null) 'metadata': metadata,
      if (failureReason != null) 'failureReason': failureReason,
      'createdAt': createdAt.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (refundedAt != null) 'refundedAt': refundedAt?.toJson(),
    };
  }

  static PaymentInclude include() {
    return PaymentInclude._();
  }

  static PaymentIncludeList includeList({
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PaymentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PaymentTable>? orderByList,
    PaymentInclude? include,
  }) {
    return PaymentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Payment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Payment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PaymentImpl extends Payment {
  _PaymentImpl({
    int? id,
    int? subscriptionId,
    int? orderId,
    required int userId,
    required double amount,
    String? currency,
    _i2.PaymentMethod? paymentMethod,
    _i3.PaymentStatus? status,
    String? externalTransactionId,
    String? metadata,
    String? failureReason,
    DateTime? createdAt,
    DateTime? paidAt,
    DateTime? refundedAt,
  }) : super._(
         id: id,
         subscriptionId: subscriptionId,
         orderId: orderId,
         userId: userId,
         amount: amount,
         currency: currency,
         paymentMethod: paymentMethod,
         status: status,
         externalTransactionId: externalTransactionId,
         metadata: metadata,
         failureReason: failureReason,
         createdAt: createdAt,
         paidAt: paidAt,
         refundedAt: refundedAt,
       );

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Payment copyWith({
    Object? id = _Undefined,
    Object? subscriptionId = _Undefined,
    Object? orderId = _Undefined,
    int? userId,
    double? amount,
    String? currency,
    Object? paymentMethod = _Undefined,
    Object? status = _Undefined,
    Object? externalTransactionId = _Undefined,
    Object? metadata = _Undefined,
    Object? failureReason = _Undefined,
    DateTime? createdAt,
    Object? paidAt = _Undefined,
    Object? refundedAt = _Undefined,
  }) {
    return Payment(
      id: id is int? ? id : this.id,
      subscriptionId: subscriptionId is int?
          ? subscriptionId
          : this.subscriptionId,
      orderId: orderId is int? ? orderId : this.orderId,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      paymentMethod: paymentMethod is _i2.PaymentMethod?
          ? paymentMethod
          : this.paymentMethod,
      status: status is _i3.PaymentStatus? ? status : this.status,
      externalTransactionId: externalTransactionId is String?
          ? externalTransactionId
          : this.externalTransactionId,
      metadata: metadata is String? ? metadata : this.metadata,
      failureReason: failureReason is String?
          ? failureReason
          : this.failureReason,
      createdAt: createdAt ?? this.createdAt,
      paidAt: paidAt is DateTime? ? paidAt : this.paidAt,
      refundedAt: refundedAt is DateTime? ? refundedAt : this.refundedAt,
    );
  }
}

class PaymentUpdateTable extends _i1.UpdateTable<PaymentTable> {
  PaymentUpdateTable(super.table);

  _i1.ColumnValue<int, int> subscriptionId(int? value) => _i1.ColumnValue(
    table.subscriptionId,
    value,
  );

  _i1.ColumnValue<int, int> orderId(int? value) => _i1.ColumnValue(
    table.orderId,
    value,
  );

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<double, double> amount(double value) => _i1.ColumnValue(
    table.amount,
    value,
  );

  _i1.ColumnValue<String, String> currency(String value) => _i1.ColumnValue(
    table.currency,
    value,
  );

  _i1.ColumnValue<_i2.PaymentMethod, _i2.PaymentMethod> paymentMethod(
    _i2.PaymentMethod? value,
  ) => _i1.ColumnValue(
    table.paymentMethod,
    value,
  );

  _i1.ColumnValue<_i3.PaymentStatus, _i3.PaymentStatus> status(
    _i3.PaymentStatus? value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> externalTransactionId(String? value) =>
      _i1.ColumnValue(
        table.externalTransactionId,
        value,
      );

  _i1.ColumnValue<String, String> metadata(String? value) => _i1.ColumnValue(
    table.metadata,
    value,
  );

  _i1.ColumnValue<String, String> failureReason(String? value) =>
      _i1.ColumnValue(
        table.failureReason,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> paidAt(DateTime? value) =>
      _i1.ColumnValue(
        table.paidAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> refundedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.refundedAt,
        value,
      );
}

class PaymentTable extends _i1.Table<int?> {
  PaymentTable({super.tableRelation}) : super(tableName: 'payments') {
    updateTable = PaymentUpdateTable(this);
    subscriptionId = _i1.ColumnInt(
      'subscriptionId',
      this,
    );
    orderId = _i1.ColumnInt(
      'orderId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    amount = _i1.ColumnDouble(
      'amount',
      this,
    );
    currency = _i1.ColumnString(
      'currency',
      this,
      hasDefault: true,
    );
    paymentMethod = _i1.ColumnEnum(
      'paymentMethod',
      this,
      _i1.EnumSerialization.byIndex,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byIndex,
    );
    externalTransactionId = _i1.ColumnString(
      'externalTransactionId',
      this,
    );
    metadata = _i1.ColumnString(
      'metadata',
      this,
    );
    failureReason = _i1.ColumnString(
      'failureReason',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    paidAt = _i1.ColumnDateTime(
      'paidAt',
      this,
    );
    refundedAt = _i1.ColumnDateTime(
      'refundedAt',
      this,
    );
  }

  late final PaymentUpdateTable updateTable;

  late final _i1.ColumnInt subscriptionId;

  late final _i1.ColumnInt orderId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnDouble amount;

  late final _i1.ColumnString currency;

  late final _i1.ColumnEnum<_i2.PaymentMethod> paymentMethod;

  late final _i1.ColumnEnum<_i3.PaymentStatus> status;

  late final _i1.ColumnString externalTransactionId;

  late final _i1.ColumnString metadata;

  late final _i1.ColumnString failureReason;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime paidAt;

  late final _i1.ColumnDateTime refundedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    subscriptionId,
    orderId,
    userId,
    amount,
    currency,
    paymentMethod,
    status,
    externalTransactionId,
    metadata,
    failureReason,
    createdAt,
    paidAt,
    refundedAt,
  ];
}

class PaymentInclude extends _i1.IncludeObject {
  PaymentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Payment.t;
}

class PaymentIncludeList extends _i1.IncludeList {
  PaymentIncludeList._({
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Payment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Payment.t;
}

class PaymentRepository {
  const PaymentRepository._();

  /// Returns a list of [Payment]s matching the given query parameters.
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
  Future<List<Payment>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PaymentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PaymentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Payment>(
      where: where?.call(Payment.t),
      orderBy: orderBy?.call(Payment.t),
      orderByList: orderByList?.call(Payment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Payment] matching the given query parameters.
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
  Future<Payment?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    int? offset,
    _i1.OrderByBuilder<PaymentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PaymentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Payment>(
      where: where?.call(Payment.t),
      orderBy: orderBy?.call(Payment.t),
      orderByList: orderByList?.call(Payment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Payment] by its [id] or null if no such row exists.
  Future<Payment?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Payment>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Payment]s in the list and returns the inserted rows.
  ///
  /// The returned [Payment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Payment>> insert(
    _i1.Session session,
    List<Payment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Payment>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Payment] and returns the inserted row.
  ///
  /// The returned [Payment] will have its `id` field set.
  Future<Payment> insertRow(
    _i1.Session session,
    Payment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Payment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Payment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Payment>> update(
    _i1.Session session,
    List<Payment> rows, {
    _i1.ColumnSelections<PaymentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Payment>(
      rows,
      columns: columns?.call(Payment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Payment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Payment> updateRow(
    _i1.Session session,
    Payment row, {
    _i1.ColumnSelections<PaymentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Payment>(
      row,
      columns: columns?.call(Payment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Payment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Payment?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<PaymentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Payment>(
      id,
      columnValues: columnValues(Payment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Payment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Payment>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<PaymentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PaymentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PaymentTable>? orderBy,
    _i1.OrderByListBuilder<PaymentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Payment>(
      columnValues: columnValues(Payment.t.updateTable),
      where: where(Payment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Payment.t),
      orderByList: orderByList?.call(Payment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Payment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Payment>> delete(
    _i1.Session session,
    List<Payment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Payment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Payment].
  Future<Payment> deleteRow(
    _i1.Session session,
    Payment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Payment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Payment>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PaymentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Payment>(
      where: where(Payment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PaymentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Payment>(
      where: where?.call(Payment.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
