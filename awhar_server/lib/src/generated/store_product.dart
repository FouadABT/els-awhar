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

abstract class StoreProduct
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StoreProduct._({
    this.id,
    required this.storeId,
    this.productCategoryId,
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
    bool? isAvailable,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isAvailable = isAvailable ?? true,
       displayOrder = displayOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory StoreProduct({
    int? id,
    required int storeId,
    int? productCategoryId,
    required String name,
    String? description,
    required double price,
    String? imageUrl,
    bool? isAvailable,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StoreProductImpl;

  factory StoreProduct.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreProduct(
      id: jsonSerialization['id'] as int?,
      storeId: jsonSerialization['storeId'] as int,
      productCategoryId: jsonSerialization['productCategoryId'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      price: (jsonSerialization['price'] as num).toDouble(),
      imageUrl: jsonSerialization['imageUrl'] as String?,
      isAvailable: jsonSerialization['isAvailable'] as bool,
      displayOrder: jsonSerialization['displayOrder'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = StoreProductTable();

  static const db = StoreProductRepository._();

  @override
  int? id;

  int storeId;

  int? productCategoryId;

  String name;

  String? description;

  double price;

  String? imageUrl;

  bool isAvailable;

  int displayOrder;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StoreProduct]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreProduct copyWith({
    int? id,
    int? storeId,
    int? productCategoryId,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    bool? isAvailable,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreProduct',
      if (id != null) 'id': id,
      'storeId': storeId,
      if (productCategoryId != null) 'productCategoryId': productCategoryId,
      'name': name,
      if (description != null) 'description': description,
      'price': price,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      'displayOrder': displayOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StoreProduct',
      if (id != null) 'id': id,
      'storeId': storeId,
      if (productCategoryId != null) 'productCategoryId': productCategoryId,
      'name': name,
      if (description != null) 'description': description,
      'price': price,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      'displayOrder': displayOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static StoreProductInclude include() {
    return StoreProductInclude._();
  }

  static StoreProductIncludeList includeList({
    _i1.WhereExpressionBuilder<StoreProductTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreProductTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreProductTable>? orderByList,
    StoreProductInclude? include,
  }) {
    return StoreProductIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreProduct.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StoreProduct.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreProductImpl extends StoreProduct {
  _StoreProductImpl({
    int? id,
    required int storeId,
    int? productCategoryId,
    required String name,
    String? description,
    required double price,
    String? imageUrl,
    bool? isAvailable,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         storeId: storeId,
         productCategoryId: productCategoryId,
         name: name,
         description: description,
         price: price,
         imageUrl: imageUrl,
         isAvailable: isAvailable,
         displayOrder: displayOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StoreProduct]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreProduct copyWith({
    Object? id = _Undefined,
    int? storeId,
    Object? productCategoryId = _Undefined,
    String? name,
    Object? description = _Undefined,
    double? price,
    Object? imageUrl = _Undefined,
    bool? isAvailable,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StoreProduct(
      id: id is int? ? id : this.id,
      storeId: storeId ?? this.storeId,
      productCategoryId: productCategoryId is int?
          ? productCategoryId
          : this.productCategoryId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      price: price ?? this.price,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      isAvailable: isAvailable ?? this.isAvailable,
      displayOrder: displayOrder ?? this.displayOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class StoreProductUpdateTable extends _i1.UpdateTable<StoreProductTable> {
  StoreProductUpdateTable(super.table);

  _i1.ColumnValue<int, int> storeId(int value) => _i1.ColumnValue(
    table.storeId,
    value,
  );

  _i1.ColumnValue<int, int> productCategoryId(int? value) => _i1.ColumnValue(
    table.productCategoryId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<double, double> price(double value) => _i1.ColumnValue(
    table.price,
    value,
  );

  _i1.ColumnValue<String, String> imageUrl(String? value) => _i1.ColumnValue(
    table.imageUrl,
    value,
  );

  _i1.ColumnValue<bool, bool> isAvailable(bool value) => _i1.ColumnValue(
    table.isAvailable,
    value,
  );

  _i1.ColumnValue<int, int> displayOrder(int value) => _i1.ColumnValue(
    table.displayOrder,
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

class StoreProductTable extends _i1.Table<int?> {
  StoreProductTable({super.tableRelation})
    : super(tableName: 'store_products') {
    updateTable = StoreProductUpdateTable(this);
    storeId = _i1.ColumnInt(
      'storeId',
      this,
    );
    productCategoryId = _i1.ColumnInt(
      'productCategoryId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    price = _i1.ColumnDouble(
      'price',
      this,
    );
    imageUrl = _i1.ColumnString(
      'imageUrl',
      this,
    );
    isAvailable = _i1.ColumnBool(
      'isAvailable',
      this,
      hasDefault: true,
    );
    displayOrder = _i1.ColumnInt(
      'displayOrder',
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
  }

  late final StoreProductUpdateTable updateTable;

  late final _i1.ColumnInt storeId;

  late final _i1.ColumnInt productCategoryId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnDouble price;

  late final _i1.ColumnString imageUrl;

  late final _i1.ColumnBool isAvailable;

  late final _i1.ColumnInt displayOrder;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    storeId,
    productCategoryId,
    name,
    description,
    price,
    imageUrl,
    isAvailable,
    displayOrder,
    createdAt,
    updatedAt,
  ];
}

class StoreProductInclude extends _i1.IncludeObject {
  StoreProductInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StoreProduct.t;
}

class StoreProductIncludeList extends _i1.IncludeList {
  StoreProductIncludeList._({
    _i1.WhereExpressionBuilder<StoreProductTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreProduct.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StoreProduct.t;
}

class StoreProductRepository {
  const StoreProductRepository._();

  /// Returns a list of [StoreProduct]s matching the given query parameters.
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
  Future<List<StoreProduct>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreProductTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreProductTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreProductTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<StoreProduct>(
      where: where?.call(StoreProduct.t),
      orderBy: orderBy?.call(StoreProduct.t),
      orderByList: orderByList?.call(StoreProduct.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [StoreProduct] matching the given query parameters.
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
  Future<StoreProduct?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreProductTable>? where,
    int? offset,
    _i1.OrderByBuilder<StoreProductTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreProductTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<StoreProduct>(
      where: where?.call(StoreProduct.t),
      orderBy: orderBy?.call(StoreProduct.t),
      orderByList: orderByList?.call(StoreProduct.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [StoreProduct] by its [id] or null if no such row exists.
  Future<StoreProduct?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<StoreProduct>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [StoreProduct]s in the list and returns the inserted rows.
  ///
  /// The returned [StoreProduct]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StoreProduct>> insert(
    _i1.Session session,
    List<StoreProduct> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StoreProduct>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StoreProduct] and returns the inserted row.
  ///
  /// The returned [StoreProduct] will have its `id` field set.
  Future<StoreProduct> insertRow(
    _i1.Session session,
    StoreProduct row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreProduct>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StoreProduct]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StoreProduct>> update(
    _i1.Session session,
    List<StoreProduct> rows, {
    _i1.ColumnSelections<StoreProductTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StoreProduct>(
      rows,
      columns: columns?.call(StoreProduct.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreProduct]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StoreProduct> updateRow(
    _i1.Session session,
    StoreProduct row, {
    _i1.ColumnSelections<StoreProductTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoreProduct>(
      row,
      columns: columns?.call(StoreProduct.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreProduct] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StoreProduct?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<StoreProductUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StoreProduct>(
      id,
      columnValues: columnValues(StoreProduct.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StoreProduct]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StoreProduct>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<StoreProductUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StoreProductTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreProductTable>? orderBy,
    _i1.OrderByListBuilder<StoreProductTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StoreProduct>(
      columnValues: columnValues(StoreProduct.t.updateTable),
      where: where(StoreProduct.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreProduct.t),
      orderByList: orderByList?.call(StoreProduct.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StoreProduct]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StoreProduct>> delete(
    _i1.Session session,
    List<StoreProduct> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StoreProduct>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StoreProduct].
  Future<StoreProduct> deleteRow(
    _i1.Session session,
    StoreProduct row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreProduct>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StoreProduct>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StoreProductTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StoreProduct>(
      where: where(StoreProduct.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreProductTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StoreProduct>(
      where: where?.call(StoreProduct.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
