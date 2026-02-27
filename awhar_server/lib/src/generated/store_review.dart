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

abstract class StoreReview
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StoreReview._({
    this.id,
    required this.storeOrderId,
    required this.reviewerId,
    required this.revieweeType,
    required this.revieweeId,
    required this.rating,
    this.comment,
    this.response,
    this.responseAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory StoreReview({
    int? id,
    required int storeOrderId,
    required int reviewerId,
    required String revieweeType,
    required int revieweeId,
    required int rating,
    String? comment,
    String? response,
    DateTime? responseAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StoreReviewImpl;

  factory StoreReview.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreReview(
      id: jsonSerialization['id'] as int?,
      storeOrderId: jsonSerialization['storeOrderId'] as int,
      reviewerId: jsonSerialization['reviewerId'] as int,
      revieweeType: jsonSerialization['revieweeType'] as String,
      revieweeId: jsonSerialization['revieweeId'] as int,
      rating: jsonSerialization['rating'] as int,
      comment: jsonSerialization['comment'] as String?,
      response: jsonSerialization['response'] as String?,
      responseAt: jsonSerialization['responseAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['responseAt']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = StoreReviewTable();

  static const db = StoreReviewRepository._();

  @override
  int? id;

  int storeOrderId;

  int reviewerId;

  String revieweeType;

  int revieweeId;

  int rating;

  String? comment;

  String? response;

  DateTime? responseAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StoreReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreReview copyWith({
    int? id,
    int? storeOrderId,
    int? reviewerId,
    String? revieweeType,
    int? revieweeId,
    int? rating,
    String? comment,
    String? response,
    DateTime? responseAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreReview',
      if (id != null) 'id': id,
      'storeOrderId': storeOrderId,
      'reviewerId': reviewerId,
      'revieweeType': revieweeType,
      'revieweeId': revieweeId,
      'rating': rating,
      if (comment != null) 'comment': comment,
      if (response != null) 'response': response,
      if (responseAt != null) 'responseAt': responseAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StoreReview',
      if (id != null) 'id': id,
      'storeOrderId': storeOrderId,
      'reviewerId': reviewerId,
      'revieweeType': revieweeType,
      'revieweeId': revieweeId,
      'rating': rating,
      if (comment != null) 'comment': comment,
      if (response != null) 'response': response,
      if (responseAt != null) 'responseAt': responseAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static StoreReviewInclude include() {
    return StoreReviewInclude._();
  }

  static StoreReviewIncludeList includeList({
    _i1.WhereExpressionBuilder<StoreReviewTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreReviewTable>? orderByList,
    StoreReviewInclude? include,
  }) {
    return StoreReviewIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreReview.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StoreReview.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreReviewImpl extends StoreReview {
  _StoreReviewImpl({
    int? id,
    required int storeOrderId,
    required int reviewerId,
    required String revieweeType,
    required int revieweeId,
    required int rating,
    String? comment,
    String? response,
    DateTime? responseAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         storeOrderId: storeOrderId,
         reviewerId: reviewerId,
         revieweeType: revieweeType,
         revieweeId: revieweeId,
         rating: rating,
         comment: comment,
         response: response,
         responseAt: responseAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StoreReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreReview copyWith({
    Object? id = _Undefined,
    int? storeOrderId,
    int? reviewerId,
    String? revieweeType,
    int? revieweeId,
    int? rating,
    Object? comment = _Undefined,
    Object? response = _Undefined,
    Object? responseAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StoreReview(
      id: id is int? ? id : this.id,
      storeOrderId: storeOrderId ?? this.storeOrderId,
      reviewerId: reviewerId ?? this.reviewerId,
      revieweeType: revieweeType ?? this.revieweeType,
      revieweeId: revieweeId ?? this.revieweeId,
      rating: rating ?? this.rating,
      comment: comment is String? ? comment : this.comment,
      response: response is String? ? response : this.response,
      responseAt: responseAt is DateTime? ? responseAt : this.responseAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class StoreReviewUpdateTable extends _i1.UpdateTable<StoreReviewTable> {
  StoreReviewUpdateTable(super.table);

  _i1.ColumnValue<int, int> storeOrderId(int value) => _i1.ColumnValue(
    table.storeOrderId,
    value,
  );

  _i1.ColumnValue<int, int> reviewerId(int value) => _i1.ColumnValue(
    table.reviewerId,
    value,
  );

  _i1.ColumnValue<String, String> revieweeType(String value) => _i1.ColumnValue(
    table.revieweeType,
    value,
  );

  _i1.ColumnValue<int, int> revieweeId(int value) => _i1.ColumnValue(
    table.revieweeId,
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

  _i1.ColumnValue<String, String> response(String? value) => _i1.ColumnValue(
    table.response,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> responseAt(DateTime? value) =>
      _i1.ColumnValue(
        table.responseAt,
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

class StoreReviewTable extends _i1.Table<int?> {
  StoreReviewTable({super.tableRelation}) : super(tableName: 'store_reviews') {
    updateTable = StoreReviewUpdateTable(this);
    storeOrderId = _i1.ColumnInt(
      'storeOrderId',
      this,
    );
    reviewerId = _i1.ColumnInt(
      'reviewerId',
      this,
    );
    revieweeType = _i1.ColumnString(
      'revieweeType',
      this,
    );
    revieweeId = _i1.ColumnInt(
      'revieweeId',
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
    response = _i1.ColumnString(
      'response',
      this,
    );
    responseAt = _i1.ColumnDateTime(
      'responseAt',
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

  late final StoreReviewUpdateTable updateTable;

  late final _i1.ColumnInt storeOrderId;

  late final _i1.ColumnInt reviewerId;

  late final _i1.ColumnString revieweeType;

  late final _i1.ColumnInt revieweeId;

  late final _i1.ColumnInt rating;

  late final _i1.ColumnString comment;

  late final _i1.ColumnString response;

  late final _i1.ColumnDateTime responseAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    storeOrderId,
    reviewerId,
    revieweeType,
    revieweeId,
    rating,
    comment,
    response,
    responseAt,
    createdAt,
    updatedAt,
  ];
}

class StoreReviewInclude extends _i1.IncludeObject {
  StoreReviewInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StoreReview.t;
}

class StoreReviewIncludeList extends _i1.IncludeList {
  StoreReviewIncludeList._({
    _i1.WhereExpressionBuilder<StoreReviewTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreReview.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StoreReview.t;
}

class StoreReviewRepository {
  const StoreReviewRepository._();

  /// Returns a list of [StoreReview]s matching the given query parameters.
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
  Future<List<StoreReview>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreReviewTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreReviewTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<StoreReview>(
      where: where?.call(StoreReview.t),
      orderBy: orderBy?.call(StoreReview.t),
      orderByList: orderByList?.call(StoreReview.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [StoreReview] matching the given query parameters.
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
  Future<StoreReview?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreReviewTable>? where,
    int? offset,
    _i1.OrderByBuilder<StoreReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreReviewTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<StoreReview>(
      where: where?.call(StoreReview.t),
      orderBy: orderBy?.call(StoreReview.t),
      orderByList: orderByList?.call(StoreReview.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [StoreReview] by its [id] or null if no such row exists.
  Future<StoreReview?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<StoreReview>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [StoreReview]s in the list and returns the inserted rows.
  ///
  /// The returned [StoreReview]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StoreReview>> insert(
    _i1.Session session,
    List<StoreReview> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StoreReview>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StoreReview] and returns the inserted row.
  ///
  /// The returned [StoreReview] will have its `id` field set.
  Future<StoreReview> insertRow(
    _i1.Session session,
    StoreReview row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreReview>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StoreReview]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StoreReview>> update(
    _i1.Session session,
    List<StoreReview> rows, {
    _i1.ColumnSelections<StoreReviewTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StoreReview>(
      rows,
      columns: columns?.call(StoreReview.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreReview]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StoreReview> updateRow(
    _i1.Session session,
    StoreReview row, {
    _i1.ColumnSelections<StoreReviewTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoreReview>(
      row,
      columns: columns?.call(StoreReview.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreReview] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StoreReview?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<StoreReviewUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StoreReview>(
      id,
      columnValues: columnValues(StoreReview.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StoreReview]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StoreReview>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<StoreReviewUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StoreReviewTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreReviewTable>? orderBy,
    _i1.OrderByListBuilder<StoreReviewTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StoreReview>(
      columnValues: columnValues(StoreReview.t.updateTable),
      where: where(StoreReview.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreReview.t),
      orderByList: orderByList?.call(StoreReview.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StoreReview]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StoreReview>> delete(
    _i1.Session session,
    List<StoreReview> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StoreReview>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StoreReview].
  Future<StoreReview> deleteRow(
    _i1.Session session,
    StoreReview row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreReview>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StoreReview>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StoreReviewTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StoreReview>(
      where: where(StoreReview.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreReviewTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StoreReview>(
      where: where?.call(StoreReview.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
