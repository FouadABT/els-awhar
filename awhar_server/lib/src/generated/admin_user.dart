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
import 'package:awhar_server/src/generated/protocol.dart' as _i2;

abstract class AdminUser
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AdminUser._({
    this.id,
    this.userId,
    required this.email,
    required this.passwordHash,
    required this.name,
    this.photoUrl,
    String? role,
    this.permissions,
    bool? isActive,
    this.lastLoginAt,
    this.lastLoginIp,
    int? failedLoginAttempts,
    this.lockedUntil,
    this.passwordResetToken,
    this.passwordResetExpiry,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.createdBy,
  }) : role = role ?? 'admin',
       isActive = isActive ?? true,
       failedLoginAttempts = failedLoginAttempts ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory AdminUser({
    int? id,
    int? userId,
    required String email,
    required String passwordHash,
    required String name,
    String? photoUrl,
    String? role,
    List<String>? permissions,
    bool? isActive,
    DateTime? lastLoginAt,
    String? lastLoginIp,
    int? failedLoginAttempts,
    DateTime? lockedUntil,
    String? passwordResetToken,
    DateTime? passwordResetExpiry,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? createdBy,
  }) = _AdminUserImpl;

  factory AdminUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminUser(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int?,
      email: jsonSerialization['email'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String,
      name: jsonSerialization['name'] as String,
      photoUrl: jsonSerialization['photoUrl'] as String?,
      role: jsonSerialization['role'] as String,
      permissions: jsonSerialization['permissions'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(
              jsonSerialization['permissions'],
            ),
      isActive: jsonSerialization['isActive'] as bool,
      lastLoginAt: jsonSerialization['lastLoginAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastLoginAt'],
            ),
      lastLoginIp: jsonSerialization['lastLoginIp'] as String?,
      failedLoginAttempts: jsonSerialization['failedLoginAttempts'] as int,
      lockedUntil: jsonSerialization['lockedUntil'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lockedUntil'],
            ),
      passwordResetToken: jsonSerialization['passwordResetToken'] as String?,
      passwordResetExpiry: jsonSerialization['passwordResetExpiry'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['passwordResetExpiry'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      createdBy: jsonSerialization['createdBy'] as int?,
    );
  }

  static final t = AdminUserTable();

  static const db = AdminUserRepository._();

  @override
  int? id;

  int? userId;

  String email;

  String passwordHash;

  String name;

  String? photoUrl;

  String role;

  List<String>? permissions;

  bool isActive;

  DateTime? lastLoginAt;

  String? lastLoginIp;

  int failedLoginAttempts;

  DateTime? lockedUntil;

  String? passwordResetToken;

  DateTime? passwordResetExpiry;

  DateTime createdAt;

  DateTime updatedAt;

  int? createdBy;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AdminUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminUser copyWith({
    int? id,
    int? userId,
    String? email,
    String? passwordHash,
    String? name,
    String? photoUrl,
    String? role,
    List<String>? permissions,
    bool? isActive,
    DateTime? lastLoginAt,
    String? lastLoginIp,
    int? failedLoginAttempts,
    DateTime? lockedUntil,
    String? passwordResetToken,
    DateTime? passwordResetExpiry,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? createdBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminUser',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      'email': email,
      'passwordHash': passwordHash,
      'name': name,
      if (photoUrl != null) 'photoUrl': photoUrl,
      'role': role,
      if (permissions != null) 'permissions': permissions?.toJson(),
      'isActive': isActive,
      if (lastLoginAt != null) 'lastLoginAt': lastLoginAt?.toJson(),
      if (lastLoginIp != null) 'lastLoginIp': lastLoginIp,
      'failedLoginAttempts': failedLoginAttempts,
      if (lockedUntil != null) 'lockedUntil': lockedUntil?.toJson(),
      if (passwordResetToken != null) 'passwordResetToken': passwordResetToken,
      if (passwordResetExpiry != null)
        'passwordResetExpiry': passwordResetExpiry?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (createdBy != null) 'createdBy': createdBy,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminUser',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      'email': email,
      'passwordHash': passwordHash,
      'name': name,
      if (photoUrl != null) 'photoUrl': photoUrl,
      'role': role,
      if (permissions != null) 'permissions': permissions?.toJson(),
      'isActive': isActive,
      if (lastLoginAt != null) 'lastLoginAt': lastLoginAt?.toJson(),
      if (lastLoginIp != null) 'lastLoginIp': lastLoginIp,
      'failedLoginAttempts': failedLoginAttempts,
      if (lockedUntil != null) 'lockedUntil': lockedUntil?.toJson(),
      if (passwordResetToken != null) 'passwordResetToken': passwordResetToken,
      if (passwordResetExpiry != null)
        'passwordResetExpiry': passwordResetExpiry?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (createdBy != null) 'createdBy': createdBy,
    };
  }

  static AdminUserInclude include() {
    return AdminUserInclude._();
  }

  static AdminUserIncludeList includeList({
    _i1.WhereExpressionBuilder<AdminUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminUserTable>? orderByList,
    AdminUserInclude? include,
  }) {
    return AdminUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminUser.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AdminUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminUserImpl extends AdminUser {
  _AdminUserImpl({
    int? id,
    int? userId,
    required String email,
    required String passwordHash,
    required String name,
    String? photoUrl,
    String? role,
    List<String>? permissions,
    bool? isActive,
    DateTime? lastLoginAt,
    String? lastLoginIp,
    int? failedLoginAttempts,
    DateTime? lockedUntil,
    String? passwordResetToken,
    DateTime? passwordResetExpiry,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? createdBy,
  }) : super._(
         id: id,
         userId: userId,
         email: email,
         passwordHash: passwordHash,
         name: name,
         photoUrl: photoUrl,
         role: role,
         permissions: permissions,
         isActive: isActive,
         lastLoginAt: lastLoginAt,
         lastLoginIp: lastLoginIp,
         failedLoginAttempts: failedLoginAttempts,
         lockedUntil: lockedUntil,
         passwordResetToken: passwordResetToken,
         passwordResetExpiry: passwordResetExpiry,
         createdAt: createdAt,
         updatedAt: updatedAt,
         createdBy: createdBy,
       );

  /// Returns a shallow copy of this [AdminUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminUser copyWith({
    Object? id = _Undefined,
    Object? userId = _Undefined,
    String? email,
    String? passwordHash,
    String? name,
    Object? photoUrl = _Undefined,
    String? role,
    Object? permissions = _Undefined,
    bool? isActive,
    Object? lastLoginAt = _Undefined,
    Object? lastLoginIp = _Undefined,
    int? failedLoginAttempts,
    Object? lockedUntil = _Undefined,
    Object? passwordResetToken = _Undefined,
    Object? passwordResetExpiry = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? createdBy = _Undefined,
  }) {
    return AdminUser(
      id: id is int? ? id : this.id,
      userId: userId is int? ? userId : this.userId,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      name: name ?? this.name,
      photoUrl: photoUrl is String? ? photoUrl : this.photoUrl,
      role: role ?? this.role,
      permissions: permissions is List<String>?
          ? permissions
          : this.permissions?.map((e0) => e0).toList(),
      isActive: isActive ?? this.isActive,
      lastLoginAt: lastLoginAt is DateTime? ? lastLoginAt : this.lastLoginAt,
      lastLoginIp: lastLoginIp is String? ? lastLoginIp : this.lastLoginIp,
      failedLoginAttempts: failedLoginAttempts ?? this.failedLoginAttempts,
      lockedUntil: lockedUntil is DateTime? ? lockedUntil : this.lockedUntil,
      passwordResetToken: passwordResetToken is String?
          ? passwordResetToken
          : this.passwordResetToken,
      passwordResetExpiry: passwordResetExpiry is DateTime?
          ? passwordResetExpiry
          : this.passwordResetExpiry,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy is int? ? createdBy : this.createdBy,
    );
  }
}

class AdminUserUpdateTable extends _i1.UpdateTable<AdminUserTable> {
  AdminUserUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int? value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> email(String value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<String, String> passwordHash(String value) => _i1.ColumnValue(
    table.passwordHash,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> photoUrl(String? value) => _i1.ColumnValue(
    table.photoUrl,
    value,
  );

  _i1.ColumnValue<String, String> role(String value) => _i1.ColumnValue(
    table.role,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> permissions(
    List<String>? value,
  ) => _i1.ColumnValue(
    table.permissions,
    value,
  );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastLoginAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastLoginAt,
        value,
      );

  _i1.ColumnValue<String, String> lastLoginIp(String? value) => _i1.ColumnValue(
    table.lastLoginIp,
    value,
  );

  _i1.ColumnValue<int, int> failedLoginAttempts(int value) => _i1.ColumnValue(
    table.failedLoginAttempts,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lockedUntil(DateTime? value) =>
      _i1.ColumnValue(
        table.lockedUntil,
        value,
      );

  _i1.ColumnValue<String, String> passwordResetToken(String? value) =>
      _i1.ColumnValue(
        table.passwordResetToken,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> passwordResetExpiry(DateTime? value) =>
      _i1.ColumnValue(
        table.passwordResetExpiry,
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

  _i1.ColumnValue<int, int> createdBy(int? value) => _i1.ColumnValue(
    table.createdBy,
    value,
  );
}

class AdminUserTable extends _i1.Table<int?> {
  AdminUserTable({super.tableRelation}) : super(tableName: 'admin_users') {
    updateTable = AdminUserUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    passwordHash = _i1.ColumnString(
      'passwordHash',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    photoUrl = _i1.ColumnString(
      'photoUrl',
      this,
    );
    role = _i1.ColumnString(
      'role',
      this,
      hasDefault: true,
    );
    permissions = _i1.ColumnSerializable<List<String>>(
      'permissions',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    lastLoginAt = _i1.ColumnDateTime(
      'lastLoginAt',
      this,
    );
    lastLoginIp = _i1.ColumnString(
      'lastLoginIp',
      this,
    );
    failedLoginAttempts = _i1.ColumnInt(
      'failedLoginAttempts',
      this,
      hasDefault: true,
    );
    lockedUntil = _i1.ColumnDateTime(
      'lockedUntil',
      this,
    );
    passwordResetToken = _i1.ColumnString(
      'passwordResetToken',
      this,
    );
    passwordResetExpiry = _i1.ColumnDateTime(
      'passwordResetExpiry',
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
    createdBy = _i1.ColumnInt(
      'createdBy',
      this,
    );
  }

  late final AdminUserUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString email;

  late final _i1.ColumnString passwordHash;

  late final _i1.ColumnString name;

  late final _i1.ColumnString photoUrl;

  late final _i1.ColumnString role;

  late final _i1.ColumnSerializable<List<String>> permissions;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnDateTime lastLoginAt;

  late final _i1.ColumnString lastLoginIp;

  late final _i1.ColumnInt failedLoginAttempts;

  late final _i1.ColumnDateTime lockedUntil;

  late final _i1.ColumnString passwordResetToken;

  late final _i1.ColumnDateTime passwordResetExpiry;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnInt createdBy;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    email,
    passwordHash,
    name,
    photoUrl,
    role,
    permissions,
    isActive,
    lastLoginAt,
    lastLoginIp,
    failedLoginAttempts,
    lockedUntil,
    passwordResetToken,
    passwordResetExpiry,
    createdAt,
    updatedAt,
    createdBy,
  ];
}

class AdminUserInclude extends _i1.IncludeObject {
  AdminUserInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AdminUser.t;
}

class AdminUserIncludeList extends _i1.IncludeList {
  AdminUserIncludeList._({
    _i1.WhereExpressionBuilder<AdminUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AdminUser.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AdminUser.t;
}

class AdminUserRepository {
  const AdminUserRepository._();

  /// Returns a list of [AdminUser]s matching the given query parameters.
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
  Future<List<AdminUser>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AdminUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminUserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<AdminUser>(
      where: where?.call(AdminUser.t),
      orderBy: orderBy?.call(AdminUser.t),
      orderByList: orderByList?.call(AdminUser.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [AdminUser] matching the given query parameters.
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
  Future<AdminUser?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AdminUserTable>? where,
    int? offset,
    _i1.OrderByBuilder<AdminUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminUserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<AdminUser>(
      where: where?.call(AdminUser.t),
      orderBy: orderBy?.call(AdminUser.t),
      orderByList: orderByList?.call(AdminUser.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [AdminUser] by its [id] or null if no such row exists.
  Future<AdminUser?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<AdminUser>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [AdminUser]s in the list and returns the inserted rows.
  ///
  /// The returned [AdminUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<AdminUser>> insert(
    _i1.Session session,
    List<AdminUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<AdminUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [AdminUser] and returns the inserted row.
  ///
  /// The returned [AdminUser] will have its `id` field set.
  Future<AdminUser> insertRow(
    _i1.Session session,
    AdminUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AdminUser>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AdminUser]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AdminUser>> update(
    _i1.Session session,
    List<AdminUser> rows, {
    _i1.ColumnSelections<AdminUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AdminUser>(
      rows,
      columns: columns?.call(AdminUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminUser]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AdminUser> updateRow(
    _i1.Session session,
    AdminUser row, {
    _i1.ColumnSelections<AdminUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AdminUser>(
      row,
      columns: columns?.call(AdminUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminUser] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AdminUser?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<AdminUserUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AdminUser>(
      id,
      columnValues: columnValues(AdminUser.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AdminUser]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AdminUser>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<AdminUserUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AdminUserTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminUserTable>? orderBy,
    _i1.OrderByListBuilder<AdminUserTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AdminUser>(
      columnValues: columnValues(AdminUser.t.updateTable),
      where: where(AdminUser.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminUser.t),
      orderByList: orderByList?.call(AdminUser.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AdminUser]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AdminUser>> delete(
    _i1.Session session,
    List<AdminUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AdminUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AdminUser].
  Future<AdminUser> deleteRow(
    _i1.Session session,
    AdminUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AdminUser>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AdminUser>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AdminUserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AdminUser>(
      where: where(AdminUser.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AdminUserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AdminUser>(
      where: where?.call(AdminUser.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
