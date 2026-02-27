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

abstract class ServiceImage
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ServiceImage._({
    this.id,
    required this.driverServiceId,
    required this.imageUrl,
    this.thumbnailUrl,
    int? displayOrder,
    this.caption,
    this.fileSize,
    this.width,
    this.height,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : displayOrder = displayOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory ServiceImage({
    int? id,
    required int driverServiceId,
    required String imageUrl,
    String? thumbnailUrl,
    int? displayOrder,
    String? caption,
    int? fileSize,
    int? width,
    int? height,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ServiceImageImpl;

  factory ServiceImage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ServiceImage(
      id: jsonSerialization['id'] as int?,
      driverServiceId: jsonSerialization['driverServiceId'] as int,
      imageUrl: jsonSerialization['imageUrl'] as String,
      thumbnailUrl: jsonSerialization['thumbnailUrl'] as String?,
      displayOrder: jsonSerialization['displayOrder'] as int,
      caption: jsonSerialization['caption'] as String?,
      fileSize: jsonSerialization['fileSize'] as int?,
      width: jsonSerialization['width'] as int?,
      height: jsonSerialization['height'] as int?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ServiceImageTable();

  static const db = ServiceImageRepository._();

  @override
  int? id;

  int driverServiceId;

  String imageUrl;

  String? thumbnailUrl;

  int displayOrder;

  String? caption;

  int? fileSize;

  int? width;

  int? height;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ServiceImage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ServiceImage copyWith({
    int? id,
    int? driverServiceId,
    String? imageUrl,
    String? thumbnailUrl,
    int? displayOrder,
    String? caption,
    int? fileSize,
    int? width,
    int? height,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ServiceImage',
      if (id != null) 'id': id,
      'driverServiceId': driverServiceId,
      'imageUrl': imageUrl,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      'displayOrder': displayOrder,
      if (caption != null) 'caption': caption,
      if (fileSize != null) 'fileSize': fileSize,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ServiceImage',
      if (id != null) 'id': id,
      'driverServiceId': driverServiceId,
      'imageUrl': imageUrl,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      'displayOrder': displayOrder,
      if (caption != null) 'caption': caption,
      if (fileSize != null) 'fileSize': fileSize,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ServiceImageInclude include() {
    return ServiceImageInclude._();
  }

  static ServiceImageIncludeList includeList({
    _i1.WhereExpressionBuilder<ServiceImageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ServiceImageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ServiceImageTable>? orderByList,
    ServiceImageInclude? include,
  }) {
    return ServiceImageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ServiceImage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ServiceImage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ServiceImageImpl extends ServiceImage {
  _ServiceImageImpl({
    int? id,
    required int driverServiceId,
    required String imageUrl,
    String? thumbnailUrl,
    int? displayOrder,
    String? caption,
    int? fileSize,
    int? width,
    int? height,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         driverServiceId: driverServiceId,
         imageUrl: imageUrl,
         thumbnailUrl: thumbnailUrl,
         displayOrder: displayOrder,
         caption: caption,
         fileSize: fileSize,
         width: width,
         height: height,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ServiceImage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ServiceImage copyWith({
    Object? id = _Undefined,
    int? driverServiceId,
    String? imageUrl,
    Object? thumbnailUrl = _Undefined,
    int? displayOrder,
    Object? caption = _Undefined,
    Object? fileSize = _Undefined,
    Object? width = _Undefined,
    Object? height = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ServiceImage(
      id: id is int? ? id : this.id,
      driverServiceId: driverServiceId ?? this.driverServiceId,
      imageUrl: imageUrl ?? this.imageUrl,
      thumbnailUrl: thumbnailUrl is String? ? thumbnailUrl : this.thumbnailUrl,
      displayOrder: displayOrder ?? this.displayOrder,
      caption: caption is String? ? caption : this.caption,
      fileSize: fileSize is int? ? fileSize : this.fileSize,
      width: width is int? ? width : this.width,
      height: height is int? ? height : this.height,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ServiceImageUpdateTable extends _i1.UpdateTable<ServiceImageTable> {
  ServiceImageUpdateTable(super.table);

  _i1.ColumnValue<int, int> driverServiceId(int value) => _i1.ColumnValue(
    table.driverServiceId,
    value,
  );

  _i1.ColumnValue<String, String> imageUrl(String value) => _i1.ColumnValue(
    table.imageUrl,
    value,
  );

  _i1.ColumnValue<String, String> thumbnailUrl(String? value) =>
      _i1.ColumnValue(
        table.thumbnailUrl,
        value,
      );

  _i1.ColumnValue<int, int> displayOrder(int value) => _i1.ColumnValue(
    table.displayOrder,
    value,
  );

  _i1.ColumnValue<String, String> caption(String? value) => _i1.ColumnValue(
    table.caption,
    value,
  );

  _i1.ColumnValue<int, int> fileSize(int? value) => _i1.ColumnValue(
    table.fileSize,
    value,
  );

  _i1.ColumnValue<int, int> width(int? value) => _i1.ColumnValue(
    table.width,
    value,
  );

  _i1.ColumnValue<int, int> height(int? value) => _i1.ColumnValue(
    table.height,
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

class ServiceImageTable extends _i1.Table<int?> {
  ServiceImageTable({super.tableRelation})
    : super(tableName: 'service_images') {
    updateTable = ServiceImageUpdateTable(this);
    driverServiceId = _i1.ColumnInt(
      'driverServiceId',
      this,
    );
    imageUrl = _i1.ColumnString(
      'imageUrl',
      this,
    );
    thumbnailUrl = _i1.ColumnString(
      'thumbnailUrl',
      this,
    );
    displayOrder = _i1.ColumnInt(
      'displayOrder',
      this,
      hasDefault: true,
    );
    caption = _i1.ColumnString(
      'caption',
      this,
    );
    fileSize = _i1.ColumnInt(
      'fileSize',
      this,
    );
    width = _i1.ColumnInt(
      'width',
      this,
    );
    height = _i1.ColumnInt(
      'height',
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

  late final ServiceImageUpdateTable updateTable;

  late final _i1.ColumnInt driverServiceId;

  late final _i1.ColumnString imageUrl;

  late final _i1.ColumnString thumbnailUrl;

  late final _i1.ColumnInt displayOrder;

  late final _i1.ColumnString caption;

  late final _i1.ColumnInt fileSize;

  late final _i1.ColumnInt width;

  late final _i1.ColumnInt height;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    driverServiceId,
    imageUrl,
    thumbnailUrl,
    displayOrder,
    caption,
    fileSize,
    width,
    height,
    createdAt,
    updatedAt,
  ];
}

class ServiceImageInclude extends _i1.IncludeObject {
  ServiceImageInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ServiceImage.t;
}

class ServiceImageIncludeList extends _i1.IncludeList {
  ServiceImageIncludeList._({
    _i1.WhereExpressionBuilder<ServiceImageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ServiceImage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ServiceImage.t;
}

class ServiceImageRepository {
  const ServiceImageRepository._();

  /// Returns a list of [ServiceImage]s matching the given query parameters.
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
  Future<List<ServiceImage>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ServiceImageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ServiceImageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ServiceImageTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ServiceImage>(
      where: where?.call(ServiceImage.t),
      orderBy: orderBy?.call(ServiceImage.t),
      orderByList: orderByList?.call(ServiceImage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ServiceImage] matching the given query parameters.
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
  Future<ServiceImage?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ServiceImageTable>? where,
    int? offset,
    _i1.OrderByBuilder<ServiceImageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ServiceImageTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ServiceImage>(
      where: where?.call(ServiceImage.t),
      orderBy: orderBy?.call(ServiceImage.t),
      orderByList: orderByList?.call(ServiceImage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ServiceImage] by its [id] or null if no such row exists.
  Future<ServiceImage?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ServiceImage>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ServiceImage]s in the list and returns the inserted rows.
  ///
  /// The returned [ServiceImage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ServiceImage>> insert(
    _i1.Session session,
    List<ServiceImage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ServiceImage>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ServiceImage] and returns the inserted row.
  ///
  /// The returned [ServiceImage] will have its `id` field set.
  Future<ServiceImage> insertRow(
    _i1.Session session,
    ServiceImage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ServiceImage>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ServiceImage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ServiceImage>> update(
    _i1.Session session,
    List<ServiceImage> rows, {
    _i1.ColumnSelections<ServiceImageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ServiceImage>(
      rows,
      columns: columns?.call(ServiceImage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ServiceImage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ServiceImage> updateRow(
    _i1.Session session,
    ServiceImage row, {
    _i1.ColumnSelections<ServiceImageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ServiceImage>(
      row,
      columns: columns?.call(ServiceImage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ServiceImage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ServiceImage?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ServiceImageUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ServiceImage>(
      id,
      columnValues: columnValues(ServiceImage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ServiceImage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ServiceImage>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ServiceImageUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ServiceImageTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ServiceImageTable>? orderBy,
    _i1.OrderByListBuilder<ServiceImageTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ServiceImage>(
      columnValues: columnValues(ServiceImage.t.updateTable),
      where: where(ServiceImage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ServiceImage.t),
      orderByList: orderByList?.call(ServiceImage.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ServiceImage]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ServiceImage>> delete(
    _i1.Session session,
    List<ServiceImage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ServiceImage>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ServiceImage].
  Future<ServiceImage> deleteRow(
    _i1.Session session,
    ServiceImage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ServiceImage>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ServiceImage>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ServiceImageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ServiceImage>(
      where: where(ServiceImage.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ServiceImageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ServiceImage>(
      where: where?.call(ServiceImage.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
