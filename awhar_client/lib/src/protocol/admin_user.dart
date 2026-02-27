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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'package:awhar_client/src/protocol/protocol.dart' as _i2;

abstract class AdminUser implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
