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

abstract class StoreOrderItem
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StoreOrderItem._({
    this.id,
    required this.storeOrderId,
    this.productId,
    required this.productName,
    required this.productPrice,
    this.productImageUrl,
    required this.quantity,
    required this.itemTotal,
    this.notes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory StoreOrderItem({
    int? id,
    required int storeOrderId,
    int? productId,
    required String productName,
    required double productPrice,
    String? productImageUrl,
    required int quantity,
    required double itemTotal,
    String? notes,
    DateTime? createdAt,
  }) = _StoreOrderItemImpl;

  factory StoreOrderItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreOrderItem(
      id: jsonSerialization['id'] as int?,
      storeOrderId: jsonSerialization['storeOrderId'] as int,
      productId: jsonSerialization['productId'] as int?,
      productName: jsonSerialization['productName'] as String,
      productPrice: (jsonSerialization['productPrice'] as num).toDouble(),
      productImageUrl: jsonSerialization['productImageUrl'] as String?,
      quantity: jsonSerialization['quantity'] as int,
      itemTotal: (jsonSerialization['itemTotal'] as num).toDouble(),
      notes: jsonSerialization['notes'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = StoreOrderItemTable();

  static const db = StoreOrderItemRepository._();

  @override
  int? id;

  int storeOrderId;

  int? productId;

  String productName;

  double productPrice;

  String? productImageUrl;

  int quantity;

  double itemTotal;

  String? notes;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StoreOrderItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreOrderItem copyWith({
    int? id,
    int? storeOrderId,
    int? productId,
    String? productName,
    double? productPrice,
    String? productImageUrl,
    int? quantity,
    double? itemTotal,
    String? notes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreOrderItem',
      if (id != null) 'id': id,
      'storeOrderId': storeOrderId,
      if (productId != null) 'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      if (productImageUrl != null) 'productImageUrl': productImageUrl,
      'quantity': quantity,
      'itemTotal': itemTotal,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StoreOrderItem',
      if (id != null) 'id': id,
      'storeOrderId': storeOrderId,
      if (productId != null) 'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      if (productImageUrl != null) 'productImageUrl': productImageUrl,
      'quantity': quantity,
      'itemTotal': itemTotal,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
    };
  }

  static StoreOrderItemInclude include() {
    return StoreOrderItemInclude._();
  }

  static StoreOrderItemIncludeList includeList({
    _i1.WhereExpressionBuilder<StoreOrderItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreOrderItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreOrderItemTable>? orderByList,
    StoreOrderItemInclude? include,
  }) {
    return StoreOrderItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreOrderItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StoreOrderItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreOrderItemImpl extends StoreOrderItem {
  _StoreOrderItemImpl({
    int? id,
    required int storeOrderId,
    int? productId,
    required String productName,
    required double productPrice,
    String? productImageUrl,
    required int quantity,
    required double itemTotal,
    String? notes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         storeOrderId: storeOrderId,
         productId: productId,
         productName: productName,
         productPrice: productPrice,
         productImageUrl: productImageUrl,
         quantity: quantity,
         itemTotal: itemTotal,
         notes: notes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [StoreOrderItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreOrderItem copyWith({
    Object? id = _Undefined,
    int? storeOrderId,
    Object? productId = _Undefined,
    String? productName,
    double? productPrice,
    Object? productImageUrl = _Undefined,
    int? quantity,
    double? itemTotal,
    Object? notes = _Undefined,
    DateTime? createdAt,
  }) {
    return StoreOrderItem(
      id: id is int? ? id : this.id,
      storeOrderId: storeOrderId ?? this.storeOrderId,
      productId: productId is int? ? productId : this.productId,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      productImageUrl: productImageUrl is String?
          ? productImageUrl
          : this.productImageUrl,
      quantity: quantity ?? this.quantity,
      itemTotal: itemTotal ?? this.itemTotal,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class StoreOrderItemUpdateTable extends _i1.UpdateTable<StoreOrderItemTable> {
  StoreOrderItemUpdateTable(super.table);

  _i1.ColumnValue<int, int> storeOrderId(int value) => _i1.ColumnValue(
    table.storeOrderId,
    value,
  );

  _i1.ColumnValue<int, int> productId(int? value) => _i1.ColumnValue(
    table.productId,
    value,
  );

  _i1.ColumnValue<String, String> productName(String value) => _i1.ColumnValue(
    table.productName,
    value,
  );

  _i1.ColumnValue<double, double> productPrice(double value) => _i1.ColumnValue(
    table.productPrice,
    value,
  );

  _i1.ColumnValue<String, String> productImageUrl(String? value) =>
      _i1.ColumnValue(
        table.productImageUrl,
        value,
      );

  _i1.ColumnValue<int, int> quantity(int value) => _i1.ColumnValue(
    table.quantity,
    value,
  );

  _i1.ColumnValue<double, double> itemTotal(double value) => _i1.ColumnValue(
    table.itemTotal,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class StoreOrderItemTable extends _i1.Table<int?> {
  StoreOrderItemTable({super.tableRelation})
    : super(tableName: 'store_order_items') {
    updateTable = StoreOrderItemUpdateTable(this);
    storeOrderId = _i1.ColumnInt(
      'storeOrderId',
      this,
    );
    productId = _i1.ColumnInt(
      'productId',
      this,
    );
    productName = _i1.ColumnString(
      'productName',
      this,
    );
    productPrice = _i1.ColumnDouble(
      'productPrice',
      this,
    );
    productImageUrl = _i1.ColumnString(
      'productImageUrl',
      this,
    );
    quantity = _i1.ColumnInt(
      'quantity',
      this,
    );
    itemTotal = _i1.ColumnDouble(
      'itemTotal',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final StoreOrderItemUpdateTable updateTable;

  late final _i1.ColumnInt storeOrderId;

  late final _i1.ColumnInt productId;

  late final _i1.ColumnString productName;

  late final _i1.ColumnDouble productPrice;

  late final _i1.ColumnString productImageUrl;

  late final _i1.ColumnInt quantity;

  late final _i1.ColumnDouble itemTotal;

  late final _i1.ColumnString notes;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    storeOrderId,
    productId,
    productName,
    productPrice,
    productImageUrl,
    quantity,
    itemTotal,
    notes,
    createdAt,
  ];
}

class StoreOrderItemInclude extends _i1.IncludeObject {
  StoreOrderItemInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StoreOrderItem.t;
}

class StoreOrderItemIncludeList extends _i1.IncludeList {
  StoreOrderItemIncludeList._({
    _i1.WhereExpressionBuilder<StoreOrderItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreOrderItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StoreOrderItem.t;
}

class StoreOrderItemRepository {
  const StoreOrderItemRepository._();

  /// Returns a list of [StoreOrderItem]s matching the given query parameters.
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
  Future<List<StoreOrderItem>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreOrderItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreOrderItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreOrderItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<StoreOrderItem>(
      where: where?.call(StoreOrderItem.t),
      orderBy: orderBy?.call(StoreOrderItem.t),
      orderByList: orderByList?.call(StoreOrderItem.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [StoreOrderItem] matching the given query parameters.
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
  Future<StoreOrderItem?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreOrderItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<StoreOrderItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreOrderItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<StoreOrderItem>(
      where: where?.call(StoreOrderItem.t),
      orderBy: orderBy?.call(StoreOrderItem.t),
      orderByList: orderByList?.call(StoreOrderItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [StoreOrderItem] by its [id] or null if no such row exists.
  Future<StoreOrderItem?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<StoreOrderItem>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [StoreOrderItem]s in the list and returns the inserted rows.
  ///
  /// The returned [StoreOrderItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StoreOrderItem>> insert(
    _i1.Session session,
    List<StoreOrderItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StoreOrderItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StoreOrderItem] and returns the inserted row.
  ///
  /// The returned [StoreOrderItem] will have its `id` field set.
  Future<StoreOrderItem> insertRow(
    _i1.Session session,
    StoreOrderItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreOrderItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StoreOrderItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StoreOrderItem>> update(
    _i1.Session session,
    List<StoreOrderItem> rows, {
    _i1.ColumnSelections<StoreOrderItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StoreOrderItem>(
      rows,
      columns: columns?.call(StoreOrderItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreOrderItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StoreOrderItem> updateRow(
    _i1.Session session,
    StoreOrderItem row, {
    _i1.ColumnSelections<StoreOrderItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoreOrderItem>(
      row,
      columns: columns?.call(StoreOrderItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreOrderItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StoreOrderItem?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<StoreOrderItemUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StoreOrderItem>(
      id,
      columnValues: columnValues(StoreOrderItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StoreOrderItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StoreOrderItem>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<StoreOrderItemUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StoreOrderItemTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreOrderItemTable>? orderBy,
    _i1.OrderByListBuilder<StoreOrderItemTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StoreOrderItem>(
      columnValues: columnValues(StoreOrderItem.t.updateTable),
      where: where(StoreOrderItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreOrderItem.t),
      orderByList: orderByList?.call(StoreOrderItem.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StoreOrderItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StoreOrderItem>> delete(
    _i1.Session session,
    List<StoreOrderItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StoreOrderItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StoreOrderItem].
  Future<StoreOrderItem> deleteRow(
    _i1.Session session,
    StoreOrderItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreOrderItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StoreOrderItem>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StoreOrderItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StoreOrderItem>(
      where: where(StoreOrderItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreOrderItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StoreOrderItem>(
      where: where?.call(StoreOrderItem.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
