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
import 'rating_type_enum.dart' as _i2;
import 'package:awhar_server/src/generated/protocol.dart' as _i3;

abstract class Rating implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Rating._({
    this.id,
    required this.requestId,
    required this.raterId,
    required this.ratedUserId,
    required this.ratingValue,
    required this.ratingType,
    this.reviewText,
    this.quickTags,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Rating({
    int? id,
    required int requestId,
    required int raterId,
    required int ratedUserId,
    required int ratingValue,
    required _i2.RatingType ratingType,
    String? reviewText,
    List<String>? quickTags,
    DateTime? createdAt,
  }) = _RatingImpl;

  factory Rating.fromJson(Map<String, dynamic> jsonSerialization) {
    return Rating(
      id: jsonSerialization['id'] as int?,
      requestId: jsonSerialization['requestId'] as int,
      raterId: jsonSerialization['raterId'] as int,
      ratedUserId: jsonSerialization['ratedUserId'] as int,
      ratingValue: jsonSerialization['ratingValue'] as int,
      ratingType: _i2.RatingType.fromJson(
        (jsonSerialization['ratingType'] as String),
      ),
      reviewText: jsonSerialization['reviewText'] as String?,
      quickTags: jsonSerialization['quickTags'] == null
          ? null
          : _i3.Protocol().deserialize<List<String>>(
              jsonSerialization['quickTags'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = RatingTable();

  static const db = RatingRepository._();

  @override
  int? id;

  int requestId;

  int raterId;

  int ratedUserId;

  int ratingValue;

  _i2.RatingType ratingType;

  String? reviewText;

  List<String>? quickTags;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Rating]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Rating copyWith({
    int? id,
    int? requestId,
    int? raterId,
    int? ratedUserId,
    int? ratingValue,
    _i2.RatingType? ratingType,
    String? reviewText,
    List<String>? quickTags,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Rating',
      if (id != null) 'id': id,
      'requestId': requestId,
      'raterId': raterId,
      'ratedUserId': ratedUserId,
      'ratingValue': ratingValue,
      'ratingType': ratingType.toJson(),
      if (reviewText != null) 'reviewText': reviewText,
      if (quickTags != null) 'quickTags': quickTags?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Rating',
      if (id != null) 'id': id,
      'requestId': requestId,
      'raterId': raterId,
      'ratedUserId': ratedUserId,
      'ratingValue': ratingValue,
      'ratingType': ratingType.toJson(),
      if (reviewText != null) 'reviewText': reviewText,
      if (quickTags != null) 'quickTags': quickTags?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static RatingInclude include() {
    return RatingInclude._();
  }

  static RatingIncludeList includeList({
    _i1.WhereExpressionBuilder<RatingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RatingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RatingTable>? orderByList,
    RatingInclude? include,
  }) {
    return RatingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Rating.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Rating.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RatingImpl extends Rating {
  _RatingImpl({
    int? id,
    required int requestId,
    required int raterId,
    required int ratedUserId,
    required int ratingValue,
    required _i2.RatingType ratingType,
    String? reviewText,
    List<String>? quickTags,
    DateTime? createdAt,
  }) : super._(
         id: id,
         requestId: requestId,
         raterId: raterId,
         ratedUserId: ratedUserId,
         ratingValue: ratingValue,
         ratingType: ratingType,
         reviewText: reviewText,
         quickTags: quickTags,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Rating]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Rating copyWith({
    Object? id = _Undefined,
    int? requestId,
    int? raterId,
    int? ratedUserId,
    int? ratingValue,
    _i2.RatingType? ratingType,
    Object? reviewText = _Undefined,
    Object? quickTags = _Undefined,
    DateTime? createdAt,
  }) {
    return Rating(
      id: id is int? ? id : this.id,
      requestId: requestId ?? this.requestId,
      raterId: raterId ?? this.raterId,
      ratedUserId: ratedUserId ?? this.ratedUserId,
      ratingValue: ratingValue ?? this.ratingValue,
      ratingType: ratingType ?? this.ratingType,
      reviewText: reviewText is String? ? reviewText : this.reviewText,
      quickTags: quickTags is List<String>?
          ? quickTags
          : this.quickTags?.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class RatingUpdateTable extends _i1.UpdateTable<RatingTable> {
  RatingUpdateTable(super.table);

  _i1.ColumnValue<int, int> requestId(int value) => _i1.ColumnValue(
    table.requestId,
    value,
  );

  _i1.ColumnValue<int, int> raterId(int value) => _i1.ColumnValue(
    table.raterId,
    value,
  );

  _i1.ColumnValue<int, int> ratedUserId(int value) => _i1.ColumnValue(
    table.ratedUserId,
    value,
  );

  _i1.ColumnValue<int, int> ratingValue(int value) => _i1.ColumnValue(
    table.ratingValue,
    value,
  );

  _i1.ColumnValue<_i2.RatingType, _i2.RatingType> ratingType(
    _i2.RatingType value,
  ) => _i1.ColumnValue(
    table.ratingType,
    value,
  );

  _i1.ColumnValue<String, String> reviewText(String? value) => _i1.ColumnValue(
    table.reviewText,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> quickTags(List<String>? value) =>
      _i1.ColumnValue(
        table.quickTags,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class RatingTable extends _i1.Table<int?> {
  RatingTable({super.tableRelation}) : super(tableName: 'ratings') {
    updateTable = RatingUpdateTable(this);
    requestId = _i1.ColumnInt(
      'requestId',
      this,
    );
    raterId = _i1.ColumnInt(
      'raterId',
      this,
    );
    ratedUserId = _i1.ColumnInt(
      'ratedUserId',
      this,
    );
    ratingValue = _i1.ColumnInt(
      'ratingValue',
      this,
    );
    ratingType = _i1.ColumnEnum(
      'ratingType',
      this,
      _i1.EnumSerialization.byName,
    );
    reviewText = _i1.ColumnString(
      'reviewText',
      this,
    );
    quickTags = _i1.ColumnSerializable<List<String>>(
      'quickTags',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final RatingUpdateTable updateTable;

  late final _i1.ColumnInt requestId;

  late final _i1.ColumnInt raterId;

  late final _i1.ColumnInt ratedUserId;

  late final _i1.ColumnInt ratingValue;

  late final _i1.ColumnEnum<_i2.RatingType> ratingType;

  late final _i1.ColumnString reviewText;

  late final _i1.ColumnSerializable<List<String>> quickTags;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    requestId,
    raterId,
    ratedUserId,
    ratingValue,
    ratingType,
    reviewText,
    quickTags,
    createdAt,
  ];
}

class RatingInclude extends _i1.IncludeObject {
  RatingInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Rating.t;
}

class RatingIncludeList extends _i1.IncludeList {
  RatingIncludeList._({
    _i1.WhereExpressionBuilder<RatingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Rating.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Rating.t;
}

class RatingRepository {
  const RatingRepository._();

  /// Returns a list of [Rating]s matching the given query parameters.
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
  Future<List<Rating>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RatingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RatingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RatingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Rating>(
      where: where?.call(Rating.t),
      orderBy: orderBy?.call(Rating.t),
      orderByList: orderByList?.call(Rating.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Rating] matching the given query parameters.
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
  Future<Rating?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RatingTable>? where,
    int? offset,
    _i1.OrderByBuilder<RatingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RatingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Rating>(
      where: where?.call(Rating.t),
      orderBy: orderBy?.call(Rating.t),
      orderByList: orderByList?.call(Rating.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Rating] by its [id] or null if no such row exists.
  Future<Rating?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Rating>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Rating]s in the list and returns the inserted rows.
  ///
  /// The returned [Rating]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Rating>> insert(
    _i1.Session session,
    List<Rating> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Rating>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Rating] and returns the inserted row.
  ///
  /// The returned [Rating] will have its `id` field set.
  Future<Rating> insertRow(
    _i1.Session session,
    Rating row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Rating>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Rating]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Rating>> update(
    _i1.Session session,
    List<Rating> rows, {
    _i1.ColumnSelections<RatingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Rating>(
      rows,
      columns: columns?.call(Rating.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Rating]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Rating> updateRow(
    _i1.Session session,
    Rating row, {
    _i1.ColumnSelections<RatingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Rating>(
      row,
      columns: columns?.call(Rating.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Rating] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Rating?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<RatingUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Rating>(
      id,
      columnValues: columnValues(Rating.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Rating]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Rating>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<RatingUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<RatingTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RatingTable>? orderBy,
    _i1.OrderByListBuilder<RatingTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Rating>(
      columnValues: columnValues(Rating.t.updateTable),
      where: where(Rating.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Rating.t),
      orderByList: orderByList?.call(Rating.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Rating]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Rating>> delete(
    _i1.Session session,
    List<Rating> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Rating>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Rating].
  Future<Rating> deleteRow(
    _i1.Session session,
    Rating row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Rating>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Rating>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RatingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Rating>(
      where: where(Rating.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RatingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Rating>(
      where: where?.call(Rating.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
