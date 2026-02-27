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
import 'user.dart' as _i2;
import 'package:awhar_client/src/protocol/protocol.dart' as _i3;

abstract class AuthResponse implements _i1.SerializableModel {
  AuthResponse._({
    required this.success,
    required this.message,
    this.user,
    this.accessToken,
    this.refreshToken,
    bool? requiresRegistration,
    bool? requiresVerification,
  }) : requiresRegistration = requiresRegistration ?? false,
       requiresVerification = requiresVerification ?? false;

  factory AuthResponse({
    required bool success,
    required String message,
    _i2.User? user,
    String? accessToken,
    String? refreshToken,
    bool? requiresRegistration,
    bool? requiresVerification,
  }) = _AuthResponseImpl;

  factory AuthResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthResponse(
      success: jsonSerialization['success'] as bool,
      message: jsonSerialization['message'] as String,
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.User>(jsonSerialization['user']),
      accessToken: jsonSerialization['accessToken'] as String?,
      refreshToken: jsonSerialization['refreshToken'] as String?,
      requiresRegistration: jsonSerialization['requiresRegistration'] as bool?,
      requiresVerification: jsonSerialization['requiresVerification'] as bool?,
    );
  }

  bool success;

  String message;

  _i2.User? user;

  String? accessToken;

  String? refreshToken;

  bool? requiresRegistration;

  bool? requiresVerification;

  /// Returns a shallow copy of this [AuthResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuthResponse copyWith({
    bool? success,
    String? message,
    _i2.User? user,
    String? accessToken,
    String? refreshToken,
    bool? requiresRegistration,
    bool? requiresVerification,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuthResponse',
      'success': success,
      'message': message,
      if (user != null) 'user': user?.toJson(),
      if (accessToken != null) 'accessToken': accessToken,
      if (refreshToken != null) 'refreshToken': refreshToken,
      if (requiresRegistration != null)
        'requiresRegistration': requiresRegistration,
      if (requiresVerification != null)
        'requiresVerification': requiresVerification,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthResponseImpl extends AuthResponse {
  _AuthResponseImpl({
    required bool success,
    required String message,
    _i2.User? user,
    String? accessToken,
    String? refreshToken,
    bool? requiresRegistration,
    bool? requiresVerification,
  }) : super._(
         success: success,
         message: message,
         user: user,
         accessToken: accessToken,
         refreshToken: refreshToken,
         requiresRegistration: requiresRegistration,
         requiresVerification: requiresVerification,
       );

  /// Returns a shallow copy of this [AuthResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuthResponse copyWith({
    bool? success,
    String? message,
    Object? user = _Undefined,
    Object? accessToken = _Undefined,
    Object? refreshToken = _Undefined,
    Object? requiresRegistration = _Undefined,
    Object? requiresVerification = _Undefined,
  }) {
    return AuthResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      accessToken: accessToken is String? ? accessToken : this.accessToken,
      refreshToken: refreshToken is String? ? refreshToken : this.refreshToken,
      requiresRegistration: requiresRegistration is bool?
          ? requiresRegistration
          : this.requiresRegistration,
      requiresVerification: requiresVerification is bool?
          ? requiresVerification
          : this.requiresVerification,
    );
  }
}
