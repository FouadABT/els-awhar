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

abstract class MediaMetadata
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MediaMetadata._({
    this.id,
    required this.messageId,
    required this.userId,
    required this.requestId,
    required this.mediaUrl,
    required this.mediaType,
    required this.fileName,
    required this.fileSizeBytes,
    this.durationMs,
    this.thumbnailUrl,
    int? downloadCount,
    this.lastAccessedAt,
    required this.uploadedAt,
    required this.createdAt,
    required this.updatedAt,
  }) : downloadCount = downloadCount ?? 0;

  factory MediaMetadata({
    int? id,
    required String messageId,
    required int userId,
    required int requestId,
    required String mediaUrl,
    required String mediaType,
    required String fileName,
    required int fileSizeBytes,
    int? durationMs,
    String? thumbnailUrl,
    int? downloadCount,
    DateTime? lastAccessedAt,
    required DateTime uploadedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MediaMetadataImpl;

  factory MediaMetadata.fromJson(Map<String, dynamic> jsonSerialization) {
    return MediaMetadata(
      id: jsonSerialization['id'] as int?,
      messageId: jsonSerialization['messageId'] as String,
      userId: jsonSerialization['userId'] as int,
      requestId: jsonSerialization['requestId'] as int,
      mediaUrl: jsonSerialization['mediaUrl'] as String,
      mediaType: jsonSerialization['mediaType'] as String,
      fileName: jsonSerialization['fileName'] as String,
      fileSizeBytes: jsonSerialization['fileSizeBytes'] as int,
      durationMs: jsonSerialization['durationMs'] as int?,
      thumbnailUrl: jsonSerialization['thumbnailUrl'] as String?,
      downloadCount: jsonSerialization['downloadCount'] as int,
      lastAccessedAt: jsonSerialization['lastAccessedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastAccessedAt'],
            ),
      uploadedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['uploadedAt'],
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = MediaMetadataTable();

  static const db = MediaMetadataRepository._();

  @override
  int? id;

  String messageId;

  int userId;

  int requestId;

  String mediaUrl;

  String mediaType;

  String fileName;

  int fileSizeBytes;

  int? durationMs;

  String? thumbnailUrl;

  int downloadCount;

  DateTime? lastAccessedAt;

  DateTime uploadedAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MediaMetadata]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MediaMetadata copyWith({
    int? id,
    String? messageId,
    int? userId,
    int? requestId,
    String? mediaUrl,
    String? mediaType,
    String? fileName,
    int? fileSizeBytes,
    int? durationMs,
    String? thumbnailUrl,
    int? downloadCount,
    DateTime? lastAccessedAt,
    DateTime? uploadedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MediaMetadata',
      if (id != null) 'id': id,
      'messageId': messageId,
      'userId': userId,
      'requestId': requestId,
      'mediaUrl': mediaUrl,
      'mediaType': mediaType,
      'fileName': fileName,
      'fileSizeBytes': fileSizeBytes,
      if (durationMs != null) 'durationMs': durationMs,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      'downloadCount': downloadCount,
      if (lastAccessedAt != null) 'lastAccessedAt': lastAccessedAt?.toJson(),
      'uploadedAt': uploadedAt.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MediaMetadata',
      if (id != null) 'id': id,
      'messageId': messageId,
      'userId': userId,
      'requestId': requestId,
      'mediaUrl': mediaUrl,
      'mediaType': mediaType,
      'fileName': fileName,
      'fileSizeBytes': fileSizeBytes,
      if (durationMs != null) 'durationMs': durationMs,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      'downloadCount': downloadCount,
      if (lastAccessedAt != null) 'lastAccessedAt': lastAccessedAt?.toJson(),
      'uploadedAt': uploadedAt.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static MediaMetadataInclude include() {
    return MediaMetadataInclude._();
  }

  static MediaMetadataIncludeList includeList({
    _i1.WhereExpressionBuilder<MediaMetadataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MediaMetadataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MediaMetadataTable>? orderByList,
    MediaMetadataInclude? include,
  }) {
    return MediaMetadataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MediaMetadata.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MediaMetadata.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MediaMetadataImpl extends MediaMetadata {
  _MediaMetadataImpl({
    int? id,
    required String messageId,
    required int userId,
    required int requestId,
    required String mediaUrl,
    required String mediaType,
    required String fileName,
    required int fileSizeBytes,
    int? durationMs,
    String? thumbnailUrl,
    int? downloadCount,
    DateTime? lastAccessedAt,
    required DateTime uploadedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         messageId: messageId,
         userId: userId,
         requestId: requestId,
         mediaUrl: mediaUrl,
         mediaType: mediaType,
         fileName: fileName,
         fileSizeBytes: fileSizeBytes,
         durationMs: durationMs,
         thumbnailUrl: thumbnailUrl,
         downloadCount: downloadCount,
         lastAccessedAt: lastAccessedAt,
         uploadedAt: uploadedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [MediaMetadata]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MediaMetadata copyWith({
    Object? id = _Undefined,
    String? messageId,
    int? userId,
    int? requestId,
    String? mediaUrl,
    String? mediaType,
    String? fileName,
    int? fileSizeBytes,
    Object? durationMs = _Undefined,
    Object? thumbnailUrl = _Undefined,
    int? downloadCount,
    Object? lastAccessedAt = _Undefined,
    DateTime? uploadedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MediaMetadata(
      id: id is int? ? id : this.id,
      messageId: messageId ?? this.messageId,
      userId: userId ?? this.userId,
      requestId: requestId ?? this.requestId,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaType: mediaType ?? this.mediaType,
      fileName: fileName ?? this.fileName,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      durationMs: durationMs is int? ? durationMs : this.durationMs,
      thumbnailUrl: thumbnailUrl is String? ? thumbnailUrl : this.thumbnailUrl,
      downloadCount: downloadCount ?? this.downloadCount,
      lastAccessedAt: lastAccessedAt is DateTime?
          ? lastAccessedAt
          : this.lastAccessedAt,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class MediaMetadataUpdateTable extends _i1.UpdateTable<MediaMetadataTable> {
  MediaMetadataUpdateTable(super.table);

  _i1.ColumnValue<String, String> messageId(String value) => _i1.ColumnValue(
    table.messageId,
    value,
  );

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> requestId(int value) => _i1.ColumnValue(
    table.requestId,
    value,
  );

  _i1.ColumnValue<String, String> mediaUrl(String value) => _i1.ColumnValue(
    table.mediaUrl,
    value,
  );

  _i1.ColumnValue<String, String> mediaType(String value) => _i1.ColumnValue(
    table.mediaType,
    value,
  );

  _i1.ColumnValue<String, String> fileName(String value) => _i1.ColumnValue(
    table.fileName,
    value,
  );

  _i1.ColumnValue<int, int> fileSizeBytes(int value) => _i1.ColumnValue(
    table.fileSizeBytes,
    value,
  );

  _i1.ColumnValue<int, int> durationMs(int? value) => _i1.ColumnValue(
    table.durationMs,
    value,
  );

  _i1.ColumnValue<String, String> thumbnailUrl(String? value) =>
      _i1.ColumnValue(
        table.thumbnailUrl,
        value,
      );

  _i1.ColumnValue<int, int> downloadCount(int value) => _i1.ColumnValue(
    table.downloadCount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastAccessedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastAccessedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> uploadedAt(DateTime value) =>
      _i1.ColumnValue(
        table.uploadedAt,
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

class MediaMetadataTable extends _i1.Table<int?> {
  MediaMetadataTable({super.tableRelation})
    : super(tableName: 'media_metadata') {
    updateTable = MediaMetadataUpdateTable(this);
    messageId = _i1.ColumnString(
      'messageId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    requestId = _i1.ColumnInt(
      'requestId',
      this,
    );
    mediaUrl = _i1.ColumnString(
      'mediaUrl',
      this,
    );
    mediaType = _i1.ColumnString(
      'mediaType',
      this,
    );
    fileName = _i1.ColumnString(
      'fileName',
      this,
    );
    fileSizeBytes = _i1.ColumnInt(
      'fileSizeBytes',
      this,
    );
    durationMs = _i1.ColumnInt(
      'durationMs',
      this,
    );
    thumbnailUrl = _i1.ColumnString(
      'thumbnailUrl',
      this,
    );
    downloadCount = _i1.ColumnInt(
      'downloadCount',
      this,
      hasDefault: true,
    );
    lastAccessedAt = _i1.ColumnDateTime(
      'lastAccessedAt',
      this,
    );
    uploadedAt = _i1.ColumnDateTime(
      'uploadedAt',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final MediaMetadataUpdateTable updateTable;

  late final _i1.ColumnString messageId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt requestId;

  late final _i1.ColumnString mediaUrl;

  late final _i1.ColumnString mediaType;

  late final _i1.ColumnString fileName;

  late final _i1.ColumnInt fileSizeBytes;

  late final _i1.ColumnInt durationMs;

  late final _i1.ColumnString thumbnailUrl;

  late final _i1.ColumnInt downloadCount;

  late final _i1.ColumnDateTime lastAccessedAt;

  late final _i1.ColumnDateTime uploadedAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    messageId,
    userId,
    requestId,
    mediaUrl,
    mediaType,
    fileName,
    fileSizeBytes,
    durationMs,
    thumbnailUrl,
    downloadCount,
    lastAccessedAt,
    uploadedAt,
    createdAt,
    updatedAt,
  ];
}

class MediaMetadataInclude extends _i1.IncludeObject {
  MediaMetadataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => MediaMetadata.t;
}

class MediaMetadataIncludeList extends _i1.IncludeList {
  MediaMetadataIncludeList._({
    _i1.WhereExpressionBuilder<MediaMetadataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MediaMetadata.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MediaMetadata.t;
}

class MediaMetadataRepository {
  const MediaMetadataRepository._();

  /// Returns a list of [MediaMetadata]s matching the given query parameters.
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
  Future<List<MediaMetadata>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MediaMetadataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MediaMetadataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MediaMetadataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<MediaMetadata>(
      where: where?.call(MediaMetadata.t),
      orderBy: orderBy?.call(MediaMetadata.t),
      orderByList: orderByList?.call(MediaMetadata.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [MediaMetadata] matching the given query parameters.
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
  Future<MediaMetadata?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MediaMetadataTable>? where,
    int? offset,
    _i1.OrderByBuilder<MediaMetadataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MediaMetadataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<MediaMetadata>(
      where: where?.call(MediaMetadata.t),
      orderBy: orderBy?.call(MediaMetadata.t),
      orderByList: orderByList?.call(MediaMetadata.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [MediaMetadata] by its [id] or null if no such row exists.
  Future<MediaMetadata?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<MediaMetadata>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [MediaMetadata]s in the list and returns the inserted rows.
  ///
  /// The returned [MediaMetadata]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<MediaMetadata>> insert(
    _i1.Session session,
    List<MediaMetadata> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MediaMetadata>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [MediaMetadata] and returns the inserted row.
  ///
  /// The returned [MediaMetadata] will have its `id` field set.
  Future<MediaMetadata> insertRow(
    _i1.Session session,
    MediaMetadata row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MediaMetadata>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MediaMetadata]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MediaMetadata>> update(
    _i1.Session session,
    List<MediaMetadata> rows, {
    _i1.ColumnSelections<MediaMetadataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MediaMetadata>(
      rows,
      columns: columns?.call(MediaMetadata.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MediaMetadata]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MediaMetadata> updateRow(
    _i1.Session session,
    MediaMetadata row, {
    _i1.ColumnSelections<MediaMetadataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MediaMetadata>(
      row,
      columns: columns?.call(MediaMetadata.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MediaMetadata] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MediaMetadata?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<MediaMetadataUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MediaMetadata>(
      id,
      columnValues: columnValues(MediaMetadata.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MediaMetadata]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MediaMetadata>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<MediaMetadataUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MediaMetadataTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MediaMetadataTable>? orderBy,
    _i1.OrderByListBuilder<MediaMetadataTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MediaMetadata>(
      columnValues: columnValues(MediaMetadata.t.updateTable),
      where: where(MediaMetadata.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MediaMetadata.t),
      orderByList: orderByList?.call(MediaMetadata.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MediaMetadata]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MediaMetadata>> delete(
    _i1.Session session,
    List<MediaMetadata> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MediaMetadata>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MediaMetadata].
  Future<MediaMetadata> deleteRow(
    _i1.Session session,
    MediaMetadata row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MediaMetadata>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MediaMetadata>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MediaMetadataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MediaMetadata>(
      where: where(MediaMetadata.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MediaMetadataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MediaMetadata>(
      where: where?.call(MediaMetadata.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
