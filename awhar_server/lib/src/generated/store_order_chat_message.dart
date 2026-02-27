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

abstract class StoreOrderChatMessage
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StoreOrderChatMessage._({
    this.id,
    required this.chatId,
    required this.senderId,
    required this.senderRole,
    required this.senderName,
    String? messageType,
    required this.content,
    this.attachmentUrl,
    this.latitude,
    this.longitude,
    this.readByJson,
    this.firebaseId,
    DateTime? createdAt,
  }) : messageType = messageType ?? 'text',
       createdAt = createdAt ?? DateTime.now();

  factory StoreOrderChatMessage({
    int? id,
    required int chatId,
    required int senderId,
    required String senderRole,
    required String senderName,
    String? messageType,
    required String content,
    String? attachmentUrl,
    double? latitude,
    double? longitude,
    String? readByJson,
    String? firebaseId,
    DateTime? createdAt,
  }) = _StoreOrderChatMessageImpl;

  factory StoreOrderChatMessage.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return StoreOrderChatMessage(
      id: jsonSerialization['id'] as int?,
      chatId: jsonSerialization['chatId'] as int,
      senderId: jsonSerialization['senderId'] as int,
      senderRole: jsonSerialization['senderRole'] as String,
      senderName: jsonSerialization['senderName'] as String,
      messageType: jsonSerialization['messageType'] as String,
      content: jsonSerialization['content'] as String,
      attachmentUrl: jsonSerialization['attachmentUrl'] as String?,
      latitude: (jsonSerialization['latitude'] as num?)?.toDouble(),
      longitude: (jsonSerialization['longitude'] as num?)?.toDouble(),
      readByJson: jsonSerialization['readByJson'] as String?,
      firebaseId: jsonSerialization['firebaseId'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = StoreOrderChatMessageTable();

  static const db = StoreOrderChatMessageRepository._();

  @override
  int? id;

  int chatId;

  int senderId;

  String senderRole;

  String senderName;

  String messageType;

  String content;

  String? attachmentUrl;

  double? latitude;

  double? longitude;

  String? readByJson;

  String? firebaseId;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StoreOrderChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreOrderChatMessage copyWith({
    int? id,
    int? chatId,
    int? senderId,
    String? senderRole,
    String? senderName,
    String? messageType,
    String? content,
    String? attachmentUrl,
    double? latitude,
    double? longitude,
    String? readByJson,
    String? firebaseId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreOrderChatMessage',
      if (id != null) 'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'senderRole': senderRole,
      'senderName': senderName,
      'messageType': messageType,
      'content': content,
      if (attachmentUrl != null) 'attachmentUrl': attachmentUrl,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (readByJson != null) 'readByJson': readByJson,
      if (firebaseId != null) 'firebaseId': firebaseId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StoreOrderChatMessage',
      if (id != null) 'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'senderRole': senderRole,
      'senderName': senderName,
      'messageType': messageType,
      'content': content,
      if (attachmentUrl != null) 'attachmentUrl': attachmentUrl,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (readByJson != null) 'readByJson': readByJson,
      if (firebaseId != null) 'firebaseId': firebaseId,
      'createdAt': createdAt.toJson(),
    };
  }

  static StoreOrderChatMessageInclude include() {
    return StoreOrderChatMessageInclude._();
  }

  static StoreOrderChatMessageIncludeList includeList({
    _i1.WhereExpressionBuilder<StoreOrderChatMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreOrderChatMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreOrderChatMessageTable>? orderByList,
    StoreOrderChatMessageInclude? include,
  }) {
    return StoreOrderChatMessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreOrderChatMessage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StoreOrderChatMessage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreOrderChatMessageImpl extends StoreOrderChatMessage {
  _StoreOrderChatMessageImpl({
    int? id,
    required int chatId,
    required int senderId,
    required String senderRole,
    required String senderName,
    String? messageType,
    required String content,
    String? attachmentUrl,
    double? latitude,
    double? longitude,
    String? readByJson,
    String? firebaseId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         chatId: chatId,
         senderId: senderId,
         senderRole: senderRole,
         senderName: senderName,
         messageType: messageType,
         content: content,
         attachmentUrl: attachmentUrl,
         latitude: latitude,
         longitude: longitude,
         readByJson: readByJson,
         firebaseId: firebaseId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [StoreOrderChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreOrderChatMessage copyWith({
    Object? id = _Undefined,
    int? chatId,
    int? senderId,
    String? senderRole,
    String? senderName,
    String? messageType,
    String? content,
    Object? attachmentUrl = _Undefined,
    Object? latitude = _Undefined,
    Object? longitude = _Undefined,
    Object? readByJson = _Undefined,
    Object? firebaseId = _Undefined,
    DateTime? createdAt,
  }) {
    return StoreOrderChatMessage(
      id: id is int? ? id : this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      senderRole: senderRole ?? this.senderRole,
      senderName: senderName ?? this.senderName,
      messageType: messageType ?? this.messageType,
      content: content ?? this.content,
      attachmentUrl: attachmentUrl is String?
          ? attachmentUrl
          : this.attachmentUrl,
      latitude: latitude is double? ? latitude : this.latitude,
      longitude: longitude is double? ? longitude : this.longitude,
      readByJson: readByJson is String? ? readByJson : this.readByJson,
      firebaseId: firebaseId is String? ? firebaseId : this.firebaseId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class StoreOrderChatMessageUpdateTable
    extends _i1.UpdateTable<StoreOrderChatMessageTable> {
  StoreOrderChatMessageUpdateTable(super.table);

  _i1.ColumnValue<int, int> chatId(int value) => _i1.ColumnValue(
    table.chatId,
    value,
  );

  _i1.ColumnValue<int, int> senderId(int value) => _i1.ColumnValue(
    table.senderId,
    value,
  );

  _i1.ColumnValue<String, String> senderRole(String value) => _i1.ColumnValue(
    table.senderRole,
    value,
  );

  _i1.ColumnValue<String, String> senderName(String value) => _i1.ColumnValue(
    table.senderName,
    value,
  );

  _i1.ColumnValue<String, String> messageType(String value) => _i1.ColumnValue(
    table.messageType,
    value,
  );

  _i1.ColumnValue<String, String> content(String value) => _i1.ColumnValue(
    table.content,
    value,
  );

  _i1.ColumnValue<String, String> attachmentUrl(String? value) =>
      _i1.ColumnValue(
        table.attachmentUrl,
        value,
      );

  _i1.ColumnValue<double, double> latitude(double? value) => _i1.ColumnValue(
    table.latitude,
    value,
  );

  _i1.ColumnValue<double, double> longitude(double? value) => _i1.ColumnValue(
    table.longitude,
    value,
  );

  _i1.ColumnValue<String, String> readByJson(String? value) => _i1.ColumnValue(
    table.readByJson,
    value,
  );

  _i1.ColumnValue<String, String> firebaseId(String? value) => _i1.ColumnValue(
    table.firebaseId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class StoreOrderChatMessageTable extends _i1.Table<int?> {
  StoreOrderChatMessageTable({super.tableRelation})
    : super(tableName: 'store_order_chat_messages') {
    updateTable = StoreOrderChatMessageUpdateTable(this);
    chatId = _i1.ColumnInt(
      'chatId',
      this,
    );
    senderId = _i1.ColumnInt(
      'senderId',
      this,
    );
    senderRole = _i1.ColumnString(
      'senderRole',
      this,
    );
    senderName = _i1.ColumnString(
      'senderName',
      this,
    );
    messageType = _i1.ColumnString(
      'messageType',
      this,
      hasDefault: true,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    attachmentUrl = _i1.ColumnString(
      'attachmentUrl',
      this,
    );
    latitude = _i1.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _i1.ColumnDouble(
      'longitude',
      this,
    );
    readByJson = _i1.ColumnString(
      'readByJson',
      this,
    );
    firebaseId = _i1.ColumnString(
      'firebaseId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final StoreOrderChatMessageUpdateTable updateTable;

  late final _i1.ColumnInt chatId;

  late final _i1.ColumnInt senderId;

  late final _i1.ColumnString senderRole;

  late final _i1.ColumnString senderName;

  late final _i1.ColumnString messageType;

  late final _i1.ColumnString content;

  late final _i1.ColumnString attachmentUrl;

  late final _i1.ColumnDouble latitude;

  late final _i1.ColumnDouble longitude;

  late final _i1.ColumnString readByJson;

  late final _i1.ColumnString firebaseId;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    chatId,
    senderId,
    senderRole,
    senderName,
    messageType,
    content,
    attachmentUrl,
    latitude,
    longitude,
    readByJson,
    firebaseId,
    createdAt,
  ];
}

class StoreOrderChatMessageInclude extends _i1.IncludeObject {
  StoreOrderChatMessageInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StoreOrderChatMessage.t;
}

class StoreOrderChatMessageIncludeList extends _i1.IncludeList {
  StoreOrderChatMessageIncludeList._({
    _i1.WhereExpressionBuilder<StoreOrderChatMessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreOrderChatMessage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StoreOrderChatMessage.t;
}

class StoreOrderChatMessageRepository {
  const StoreOrderChatMessageRepository._();

  /// Returns a list of [StoreOrderChatMessage]s matching the given query parameters.
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
  Future<List<StoreOrderChatMessage>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreOrderChatMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreOrderChatMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreOrderChatMessageTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<StoreOrderChatMessage>(
      where: where?.call(StoreOrderChatMessage.t),
      orderBy: orderBy?.call(StoreOrderChatMessage.t),
      orderByList: orderByList?.call(StoreOrderChatMessage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [StoreOrderChatMessage] matching the given query parameters.
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
  Future<StoreOrderChatMessage?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreOrderChatMessageTable>? where,
    int? offset,
    _i1.OrderByBuilder<StoreOrderChatMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreOrderChatMessageTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<StoreOrderChatMessage>(
      where: where?.call(StoreOrderChatMessage.t),
      orderBy: orderBy?.call(StoreOrderChatMessage.t),
      orderByList: orderByList?.call(StoreOrderChatMessage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [StoreOrderChatMessage] by its [id] or null if no such row exists.
  Future<StoreOrderChatMessage?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<StoreOrderChatMessage>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [StoreOrderChatMessage]s in the list and returns the inserted rows.
  ///
  /// The returned [StoreOrderChatMessage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StoreOrderChatMessage>> insert(
    _i1.Session session,
    List<StoreOrderChatMessage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StoreOrderChatMessage>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StoreOrderChatMessage] and returns the inserted row.
  ///
  /// The returned [StoreOrderChatMessage] will have its `id` field set.
  Future<StoreOrderChatMessage> insertRow(
    _i1.Session session,
    StoreOrderChatMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreOrderChatMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StoreOrderChatMessage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StoreOrderChatMessage>> update(
    _i1.Session session,
    List<StoreOrderChatMessage> rows, {
    _i1.ColumnSelections<StoreOrderChatMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StoreOrderChatMessage>(
      rows,
      columns: columns?.call(StoreOrderChatMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreOrderChatMessage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StoreOrderChatMessage> updateRow(
    _i1.Session session,
    StoreOrderChatMessage row, {
    _i1.ColumnSelections<StoreOrderChatMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoreOrderChatMessage>(
      row,
      columns: columns?.call(StoreOrderChatMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreOrderChatMessage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StoreOrderChatMessage?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<StoreOrderChatMessageUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StoreOrderChatMessage>(
      id,
      columnValues: columnValues(StoreOrderChatMessage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StoreOrderChatMessage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StoreOrderChatMessage>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<StoreOrderChatMessageUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<StoreOrderChatMessageTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreOrderChatMessageTable>? orderBy,
    _i1.OrderByListBuilder<StoreOrderChatMessageTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StoreOrderChatMessage>(
      columnValues: columnValues(StoreOrderChatMessage.t.updateTable),
      where: where(StoreOrderChatMessage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreOrderChatMessage.t),
      orderByList: orderByList?.call(StoreOrderChatMessage.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StoreOrderChatMessage]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StoreOrderChatMessage>> delete(
    _i1.Session session,
    List<StoreOrderChatMessage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StoreOrderChatMessage>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StoreOrderChatMessage].
  Future<StoreOrderChatMessage> deleteRow(
    _i1.Session session,
    StoreOrderChatMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreOrderChatMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StoreOrderChatMessage>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StoreOrderChatMessageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StoreOrderChatMessage>(
      where: where(StoreOrderChatMessage.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreOrderChatMessageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StoreOrderChatMessage>(
      where: where?.call(StoreOrderChatMessage.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
