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

abstract class ClientReview
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ClientReview._({
    this.id,
    required this.orderId,
    required this.driverId,
    required this.clientId,
    required this.rating,
    this.comment,
    this.communicationRating,
    this.respectRating,
    this.paymentPromptness,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ClientReview({
    int? id,
    required int orderId,
    required int driverId,
    required int clientId,
    required int rating,
    String? comment,
    int? communicationRating,
    int? respectRating,
    int? paymentPromptness,
    DateTime? createdAt,
  }) = _ClientReviewImpl;

  factory ClientReview.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClientReview(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      driverId: jsonSerialization['driverId'] as int,
      clientId: jsonSerialization['clientId'] as int,
      rating: jsonSerialization['rating'] as int,
      comment: jsonSerialization['comment'] as String?,
      communicationRating: jsonSerialization['communicationRating'] as int?,
      respectRating: jsonSerialization['respectRating'] as int?,
      paymentPromptness: jsonSerialization['paymentPromptness'] as int?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = ClientReviewTable();

  static const db = ClientReviewRepository._();

  @override
  int? id;

  int orderId;

  int driverId;

  int clientId;

  int rating;

  String? comment;

  int? communicationRating;

  int? respectRating;

  int? paymentPromptness;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ClientReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClientReview copyWith({
    int? id,
    int? orderId,
    int? driverId,
    int? clientId,
    int? rating,
    String? comment,
    int? communicationRating,
    int? respectRating,
    int? paymentPromptness,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClientReview',
      if (id != null) 'id': id,
      'orderId': orderId,
      'driverId': driverId,
      'clientId': clientId,
      'rating': rating,
      if (comment != null) 'comment': comment,
      if (communicationRating != null)
        'communicationRating': communicationRating,
      if (respectRating != null) 'respectRating': respectRating,
      if (paymentPromptness != null) 'paymentPromptness': paymentPromptness,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClientReview',
      if (id != null) 'id': id,
      'orderId': orderId,
      'driverId': driverId,
      'clientId': clientId,
      'rating': rating,
      if (comment != null) 'comment': comment,
      if (communicationRating != null)
        'communicationRating': communicationRating,
      if (respectRating != null) 'respectRating': respectRating,
      if (paymentPromptness != null) 'paymentPromptness': paymentPromptness,
      'createdAt': createdAt.toJson(),
    };
  }

  static ClientReviewInclude include() {
    return ClientReviewInclude._();
  }

  static ClientReviewIncludeList includeList({
    _i1.WhereExpressionBuilder<ClientReviewTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClientReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClientReviewTable>? orderByList,
    ClientReviewInclude? include,
  }) {
    return ClientReviewIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClientReview.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ClientReview.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClientReviewImpl extends ClientReview {
  _ClientReviewImpl({
    int? id,
    required int orderId,
    required int driverId,
    required int clientId,
    required int rating,
    String? comment,
    int? communicationRating,
    int? respectRating,
    int? paymentPromptness,
    DateTime? createdAt,
  }) : super._(
         id: id,
         orderId: orderId,
         driverId: driverId,
         clientId: clientId,
         rating: rating,
         comment: comment,
         communicationRating: communicationRating,
         respectRating: respectRating,
         paymentPromptness: paymentPromptness,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ClientReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClientReview copyWith({
    Object? id = _Undefined,
    int? orderId,
    int? driverId,
    int? clientId,
    int? rating,
    Object? comment = _Undefined,
    Object? communicationRating = _Undefined,
    Object? respectRating = _Undefined,
    Object? paymentPromptness = _Undefined,
    DateTime? createdAt,
  }) {
    return ClientReview(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      driverId: driverId ?? this.driverId,
      clientId: clientId ?? this.clientId,
      rating: rating ?? this.rating,
      comment: comment is String? ? comment : this.comment,
      communicationRating: communicationRating is int?
          ? communicationRating
          : this.communicationRating,
      respectRating: respectRating is int? ? respectRating : this.respectRating,
      paymentPromptness: paymentPromptness is int?
          ? paymentPromptness
          : this.paymentPromptness,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ClientReviewUpdateTable extends _i1.UpdateTable<ClientReviewTable> {
  ClientReviewUpdateTable(super.table);

  _i1.ColumnValue<int, int> orderId(int value) => _i1.ColumnValue(
    table.orderId,
    value,
  );

  _i1.ColumnValue<int, int> driverId(int value) => _i1.ColumnValue(
    table.driverId,
    value,
  );

  _i1.ColumnValue<int, int> clientId(int value) => _i1.ColumnValue(
    table.clientId,
    value,
  );

  _i1.ColumnValue<int, int> rating(int value) => _i1.ColumnValue(
    table.rating,
    value,
  );

  _i1.ColumnValue<String, String> comment(String? value) => _i1.ColumnValue(
    table.comment,
    value,
  );

  _i1.ColumnValue<int, int> communicationRating(int? value) => _i1.ColumnValue(
    table.communicationRating,
    value,
  );

  _i1.ColumnValue<int, int> respectRating(int? value) => _i1.ColumnValue(
    table.respectRating,
    value,
  );

  _i1.ColumnValue<int, int> paymentPromptness(int? value) => _i1.ColumnValue(
    table.paymentPromptness,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class ClientReviewTable extends _i1.Table<int?> {
  ClientReviewTable({super.tableRelation})
    : super(tableName: 'client_reviews') {
    updateTable = ClientReviewUpdateTable(this);
    orderId = _i1.ColumnInt(
      'orderId',
      this,
    );
    driverId = _i1.ColumnInt(
      'driverId',
      this,
    );
    clientId = _i1.ColumnInt(
      'clientId',
      this,
    );
    rating = _i1.ColumnInt(
      'rating',
      this,
    );
    comment = _i1.ColumnString(
      'comment',
      this,
    );
    communicationRating = _i1.ColumnInt(
      'communicationRating',
      this,
    );
    respectRating = _i1.ColumnInt(
      'respectRating',
      this,
    );
    paymentPromptness = _i1.ColumnInt(
      'paymentPromptness',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ClientReviewUpdateTable updateTable;

  late final _i1.ColumnInt orderId;

  late final _i1.ColumnInt driverId;

  late final _i1.ColumnInt clientId;

  late final _i1.ColumnInt rating;

  late final _i1.ColumnString comment;

  late final _i1.ColumnInt communicationRating;

  late final _i1.ColumnInt respectRating;

  late final _i1.ColumnInt paymentPromptness;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    orderId,
    driverId,
    clientId,
    rating,
    comment,
    communicationRating,
    respectRating,
    paymentPromptness,
    createdAt,
  ];
}

class ClientReviewInclude extends _i1.IncludeObject {
  ClientReviewInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ClientReview.t;
}

class ClientReviewIncludeList extends _i1.IncludeList {
  ClientReviewIncludeList._({
    _i1.WhereExpressionBuilder<ClientReviewTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClientReview.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ClientReview.t;
}

class ClientReviewRepository {
  const ClientReviewRepository._();

  /// Returns a list of [ClientReview]s matching the given query parameters.
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
  Future<List<ClientReview>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClientReviewTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClientReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClientReviewTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ClientReview>(
      where: where?.call(ClientReview.t),
      orderBy: orderBy?.call(ClientReview.t),
      orderByList: orderByList?.call(ClientReview.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ClientReview] matching the given query parameters.
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
  Future<ClientReview?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClientReviewTable>? where,
    int? offset,
    _i1.OrderByBuilder<ClientReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ClientReviewTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ClientReview>(
      where: where?.call(ClientReview.t),
      orderBy: orderBy?.call(ClientReview.t),
      orderByList: orderByList?.call(ClientReview.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ClientReview] by its [id] or null if no such row exists.
  Future<ClientReview?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ClientReview>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ClientReview]s in the list and returns the inserted rows.
  ///
  /// The returned [ClientReview]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ClientReview>> insert(
    _i1.Session session,
    List<ClientReview> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ClientReview>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ClientReview] and returns the inserted row.
  ///
  /// The returned [ClientReview] will have its `id` field set.
  Future<ClientReview> insertRow(
    _i1.Session session,
    ClientReview row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClientReview>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ClientReview]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ClientReview>> update(
    _i1.Session session,
    List<ClientReview> rows, {
    _i1.ColumnSelections<ClientReviewTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ClientReview>(
      rows,
      columns: columns?.call(ClientReview.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClientReview]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClientReview> updateRow(
    _i1.Session session,
    ClientReview row, {
    _i1.ColumnSelections<ClientReviewTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClientReview>(
      row,
      columns: columns?.call(ClientReview.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClientReview] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ClientReview?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ClientReviewUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ClientReview>(
      id,
      columnValues: columnValues(ClientReview.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ClientReview]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ClientReview>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ClientReviewUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ClientReviewTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ClientReviewTable>? orderBy,
    _i1.OrderByListBuilder<ClientReviewTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ClientReview>(
      columnValues: columnValues(ClientReview.t.updateTable),
      where: where(ClientReview.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClientReview.t),
      orderByList: orderByList?.call(ClientReview.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ClientReview]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ClientReview>> delete(
    _i1.Session session,
    List<ClientReview> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ClientReview>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ClientReview].
  Future<ClientReview> deleteRow(
    _i1.Session session,
    ClientReview row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClientReview>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ClientReview>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ClientReviewTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ClientReview>(
      where: where(ClientReview.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ClientReviewTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ClientReview>(
      where: where?.call(ClientReview.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
