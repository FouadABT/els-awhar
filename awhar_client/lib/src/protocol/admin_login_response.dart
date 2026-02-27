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

abstract class AdminLoginResponse implements _i1.SerializableModel {
  AdminLoginResponse._({
    required this.success,
    required this.message,
    this.token,
    this.expiresAt,
    this.adminId,
    this.adminEmail,
    this.adminName,
    this.adminPhotoUrl,
    this.adminRole,
    this.adminPermissions,
  });

  factory AdminLoginResponse({
    required bool success,
    required String message,
    String? token,
    DateTime? expiresAt,
    int? adminId,
    String? adminEmail,
    String? adminName,
    String? adminPhotoUrl,
    String? adminRole,
    List<String>? adminPermissions,
  }) = _AdminLoginResponseImpl;

  factory AdminLoginResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminLoginResponse(
      success: jsonSerialization['success'] as bool,
      message: jsonSerialization['message'] as String,
      token: jsonSerialization['token'] as String?,
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      adminId: jsonSerialization['adminId'] as int?,
      adminEmail: jsonSerialization['adminEmail'] as String?,
      adminName: jsonSerialization['adminName'] as String?,
      adminPhotoUrl: jsonSerialization['adminPhotoUrl'] as String?,
      adminRole: jsonSerialization['adminRole'] as String?,
      adminPermissions: jsonSerialization['adminPermissions'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(
              jsonSerialization['adminPermissions'],
            ),
    );
  }

  bool success;

  String message;

  String? token;

  DateTime? expiresAt;

  int? adminId;

  String? adminEmail;

  String? adminName;

  String? adminPhotoUrl;

  String? adminRole;

  List<String>? adminPermissions;

  /// Returns a shallow copy of this [AdminLoginResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminLoginResponse copyWith({
    bool? success,
    String? message,
    String? token,
    DateTime? expiresAt,
    int? adminId,
    String? adminEmail,
    String? adminName,
    String? adminPhotoUrl,
    String? adminRole,
    List<String>? adminPermissions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminLoginResponse',
      'success': success,
      'message': message,
      if (token != null) 'token': token,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      if (adminId != null) 'adminId': adminId,
      if (adminEmail != null) 'adminEmail': adminEmail,
      if (adminName != null) 'adminName': adminName,
      if (adminPhotoUrl != null) 'adminPhotoUrl': adminPhotoUrl,
      if (adminRole != null) 'adminRole': adminRole,
      if (adminPermissions != null)
        'adminPermissions': adminPermissions?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminLoginResponseImpl extends AdminLoginResponse {
  _AdminLoginResponseImpl({
    required bool success,
    required String message,
    String? token,
    DateTime? expiresAt,
    int? adminId,
    String? adminEmail,
    String? adminName,
    String? adminPhotoUrl,
    String? adminRole,
    List<String>? adminPermissions,
  }) : super._(
         success: success,
         message: message,
         token: token,
         expiresAt: expiresAt,
         adminId: adminId,
         adminEmail: adminEmail,
         adminName: adminName,
         adminPhotoUrl: adminPhotoUrl,
         adminRole: adminRole,
         adminPermissions: adminPermissions,
       );

  /// Returns a shallow copy of this [AdminLoginResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminLoginResponse copyWith({
    bool? success,
    String? message,
    Object? token = _Undefined,
    Object? expiresAt = _Undefined,
    Object? adminId = _Undefined,
    Object? adminEmail = _Undefined,
    Object? adminName = _Undefined,
    Object? adminPhotoUrl = _Undefined,
    Object? adminRole = _Undefined,
    Object? adminPermissions = _Undefined,
  }) {
    return AdminLoginResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      token: token is String? ? token : this.token,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      adminId: adminId is int? ? adminId : this.adminId,
      adminEmail: adminEmail is String? ? adminEmail : this.adminEmail,
      adminName: adminName is String? ? adminName : this.adminName,
      adminPhotoUrl: adminPhotoUrl is String?
          ? adminPhotoUrl
          : this.adminPhotoUrl,
      adminRole: adminRole is String? ? adminRole : this.adminRole,
      adminPermissions: adminPermissions is List<String>?
          ? adminPermissions
          : this.adminPermissions?.map((e0) => e0).toList(),
    );
  }
}
