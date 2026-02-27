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
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i1;
import 'package:serverpod_client/serverpod_client.dart' as _i2;
import 'dart:async' as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'package:awhar_client/src/protocol/admin_login_response.dart' as _i5;
import 'package:awhar_client/src/protocol/admin_user.dart' as _i6;
import 'package:awhar_client/src/protocol/dashboard_stats.dart' as _i7;
import 'package:awhar_client/src/protocol/user.dart' as _i8;
import 'package:awhar_client/src/protocol/driver_profile.dart' as _i9;
import 'package:awhar_client/src/protocol/store.dart' as _i10;
import 'package:awhar_client/src/protocol/store_order.dart' as _i11;
import 'package:awhar_client/src/protocol/store_order_status_enum.dart' as _i12;
import 'package:awhar_client/src/protocol/service_request.dart' as _i13;
import 'package:awhar_client/src/protocol/request_status.dart' as _i14;
import 'package:awhar_client/src/protocol/transaction.dart' as _i15;
import 'package:awhar_client/src/protocol/transaction_status.dart' as _i16;
import 'package:awhar_client/src/protocol/report.dart' as _i17;
import 'package:awhar_client/src/protocol/report_status_enum.dart' as _i18;
import 'package:awhar_client/src/protocol/report_resolution_enum.dart' as _i19;
import 'package:awhar_client/src/protocol/recent_activity.dart' as _i20;
import 'package:awhar_client/src/protocol/ai_driver_matching_response.dart'
    as _i21;
import 'package:awhar_client/src/protocol/ai_request_concierge_response.dart'
    as _i22;
import 'package:awhar_client/src/protocol/ai_demand_prediction_response.dart'
    as _i23;
import 'package:awhar_client/src/protocol/ai_help_search_response.dart' as _i24;
import 'package:awhar_client/src/protocol/agent_builder_converse_response.dart'
    as _i25;
import 'package:awhar_client/src/protocol/agent_stream_status.dart' as _i26;
import 'package:awhar_client/src/protocol/ai_agent_status_response.dart'
    as _i27;
import 'package:awhar_client/src/protocol/ai_full_request_response.dart'
    as _i28;
import 'package:awhar_client/src/protocol/auth_response.dart' as _i29;
import 'package:awhar_client/src/protocol/user_role_enum.dart' as _i30;
import 'package:awhar_client/src/protocol/blocked_user.dart' as _i31;
import 'package:awhar_client/src/protocol/chat_message.dart' as _i32;
import 'package:awhar_client/src/protocol/message_type_enum.dart' as _i33;
import 'package:awhar_client/src/protocol/country.dart' as _i34;
import 'package:awhar_client/src/protocol/device_fingerprint_check_result.dart'
    as _i35;
import 'package:awhar_client/src/protocol/device_fingerprint_input.dart'
    as _i36;
import 'package:awhar_client/src/protocol/device_fingerprint_record.dart'
    as _i37;
import 'package:awhar_client/src/protocol/driver_service.dart' as _i38;
import 'dart:typed_data' as _i39;
import 'package:awhar_client/src/protocol/service_image.dart' as _i40;
import 'package:awhar_client/src/protocol/media_metadata.dart' as _i41;
import 'package:awhar_client/src/protocol/user_notification.dart' as _i42;
import 'package:awhar_client/src/protocol/notification_type.dart' as _i43;
import 'package:awhar_client/src/protocol/driver_offer.dart' as _i44;
import 'package:awhar_client/src/protocol/order.dart' as _i45;
import 'package:awhar_client/src/protocol/canceller_type_enum.dart' as _i46;
import 'package:awhar_client/src/protocol/order_status_enum.dart' as _i47;
import 'package:awhar_client/src/protocol/promo.dart' as _i48;
import 'package:awhar_client/src/protocol/driver_proposal.dart' as _i49;
import 'package:awhar_client/src/protocol/rating.dart' as _i50;
import 'package:awhar_client/src/protocol/rating_type_enum.dart' as _i51;
import 'package:awhar_client/src/protocol/rating_stats.dart' as _i52;
import 'package:awhar_client/src/protocol/reporter_type_enum.dart' as _i53;
import 'package:awhar_client/src/protocol/report_reason_enum.dart' as _i54;
import 'package:awhar_client/src/protocol/service_type.dart' as _i55;
import 'package:awhar_client/src/protocol/location.dart' as _i56;
import 'package:awhar_client/src/protocol/shopping_item.dart' as _i57;
import 'package:awhar_client/src/protocol/client_review.dart' as _i58;
import 'package:awhar_client/src/protocol/review.dart' as _i59;
import 'package:awhar_client/src/protocol/service_category.dart' as _i60;
import 'package:awhar_client/src/protocol/service.dart' as _i61;
import 'package:awhar_client/src/protocol/service_analytics.dart' as _i62;
import 'package:awhar_client/src/protocol/app_configuration.dart' as _i63;
import 'package:awhar_client/src/protocol/nearby_driver.dart' as _i64;
import 'package:awhar_client/src/protocol/store_delivery_request.dart' as _i65;
import 'package:awhar_client/src/protocol/store_order_chat.dart' as _i66;
import 'package:awhar_client/src/protocol/store_order_chat_message.dart'
    as _i67;
import 'package:awhar_client/src/protocol/chat_participants_info.dart' as _i68;
import 'package:awhar_client/src/protocol/store_category.dart' as _i69;
import 'package:awhar_client/src/protocol/order_item.dart' as _i70;
import 'package:awhar_client/src/protocol/product_category.dart' as _i71;
import 'package:awhar_client/src/protocol/store_product.dart' as _i72;
import 'package:awhar_client/src/protocol/store_review.dart' as _i73;
import 'package:awhar_client/src/protocol/review_with_reviewer.dart' as _i74;
import 'package:awhar_client/src/protocol/driver_earnings_response.dart'
    as _i75;
import 'package:awhar_client/src/protocol/wallet.dart' as _i76;
import 'package:awhar_client/src/protocol/trust_score_result.dart' as _i77;
import 'package:awhar_client/src/protocol/user_response.dart' as _i78;
import 'package:awhar_client/src/protocol/language_enum.dart' as _i79;
import 'package:awhar_client/src/protocol/greetings/greeting.dart' as _i80;
import 'protocol.dart' as _i81;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i1.EndpointEmailIdpBase {
  EndpointEmailIdp(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<_i4.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i3.Future<_i2.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i3.Future<String> verifyRegistrationCode({
    required _i2.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i3.Future<_i4.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i3.Future<_i2.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i3.Future<String> verifyPasswordResetCode({
    required _i2.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i4.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i3.Future<_i4.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// Admin authentication and management endpoint
/// Supports standalone admin login with password
/// {@category Endpoint}
class EndpointAdmin extends _i2.EndpointRef {
  EndpointAdmin(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  /// Admin login with email and password
  _i3.Future<_i5.AdminLoginResponse> login({
    required String email,
    required String firebaseUid,
    String? password,
  }) => caller.callServerEndpoint<_i5.AdminLoginResponse>(
    'admin',
    'login',
    {
      'email': email,
      'firebaseUid': firebaseUid,
      'password': password,
    },
  );

  /// Login with password (new method without Firebase dependency)
  _i3.Future<_i5.AdminLoginResponse> loginWithPassword({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i5.AdminLoginResponse>(
    'admin',
    'loginWithPassword',
    {
      'email': email,
      'password': password,
    },
  );

  /// Change admin password
  _i3.Future<bool> changePassword({
    required int adminId,
    required String currentPassword,
    required String newPassword,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'changePassword',
    {
      'adminId': adminId,
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    },
  );

  /// Get all admin users
  _i3.Future<List<_i6.AdminUser>> getAllAdmins() =>
      caller.callServerEndpoint<List<_i6.AdminUser>>(
        'admin',
        'getAllAdmins',
        {},
      );

  /// Get admin by ID
  _i3.Future<_i6.AdminUser?> getAdmin({required int adminId}) =>
      caller.callServerEndpoint<_i6.AdminUser?>(
        'admin',
        'getAdmin',
        {'adminId': adminId},
      );

  /// Create new admin user
  _i3.Future<_i6.AdminUser?> createAdmin({
    required String email,
    required String password,
    required String name,
    String? photoUrl,
    required String role,
    List<String>? permissions,
    int? createdBy,
  }) => caller.callServerEndpoint<_i6.AdminUser?>(
    'admin',
    'createAdmin',
    {
      'email': email,
      'password': password,
      'name': name,
      'photoUrl': photoUrl,
      'role': role,
      'permissions': permissions,
      'createdBy': createdBy,
    },
  );

  /// Update admin user
  _i3.Future<_i6.AdminUser?> updateAdmin({
    required int adminId,
    String? email,
    String? name,
    String? photoUrl,
    String? role,
    List<String>? permissions,
    bool? isActive,
  }) => caller.callServerEndpoint<_i6.AdminUser?>(
    'admin',
    'updateAdmin',
    {
      'adminId': adminId,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'role': role,
      'permissions': permissions,
      'isActive': isActive,
    },
  );

  /// Reset admin password (by another admin)
  _i3.Future<bool> resetAdminPassword({
    required int adminId,
    required String newPassword,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'resetAdminPassword',
    {
      'adminId': adminId,
      'newPassword': newPassword,
    },
  );

  /// Delete admin user
  _i3.Future<bool> deleteAdmin({required int adminId}) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'deleteAdmin',
        {'adminId': adminId},
      );

  /// Toggle admin active status
  _i3.Future<bool> toggleAdminStatus({required int adminId}) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'toggleAdminStatus',
        {'adminId': adminId},
      );

  /// Get current admin profile
  _i3.Future<_i6.AdminUser?> getProfile({required int adminId}) =>
      caller.callServerEndpoint<_i6.AdminUser?>(
        'admin',
        'getProfile',
        {'adminId': adminId},
      );

  /// Update current admin profile
  _i3.Future<_i6.AdminUser?> updateProfile({
    required int adminId,
    String? name,
    String? photoUrl,
  }) => caller.callServerEndpoint<_i6.AdminUser?>(
    'admin',
    'updateProfile',
    {
      'adminId': adminId,
      'name': name,
      'photoUrl': photoUrl,
    },
  );

  /// Get dashboard statistics
  _i3.Future<_i7.DashboardStats> getDashboardStats() =>
      caller.callServerEndpoint<_i7.DashboardStats>(
        'admin',
        'getDashboardStats',
        {},
      );

  /// Get total user count
  _i3.Future<int> getUserCount() => caller.callServerEndpoint<int>(
    'admin',
    'getUserCount',
    {},
  );

  /// List all users with pagination and filters
  _i3.Future<List<_i8.User>> listUsers({
    required int page,
    required int limit,
    String? search,
    String? role,
    String? status,
  }) => caller.callServerEndpoint<List<_i8.User>>(
    'admin',
    'listUsers',
    {
      'page': page,
      'limit': limit,
      'search': search,
      'role': role,
      'status': status,
    },
  );

  /// List all drivers with pagination
  _i3.Future<List<_i9.DriverProfile>> listDrivers({
    required int page,
    required int limit,
    String? search,
    bool? onlineOnly,
    bool? verifiedOnly,
  }) => caller.callServerEndpoint<List<_i9.DriverProfile>>(
    'admin',
    'listDrivers',
    {
      'page': page,
      'limit': limit,
      'search': search,
      'onlineOnly': onlineOnly,
      'verifiedOnly': verifiedOnly,
    },
  );

  /// List all stores with pagination
  _i3.Future<List<_i10.Store>> listStores({
    required int page,
    required int limit,
    String? search,
    bool? activeOnly,
  }) => caller.callServerEndpoint<List<_i10.Store>>(
    'admin',
    'listStores',
    {
      'page': page,
      'limit': limit,
      'search': search,
      'activeOnly': activeOnly,
    },
  );

  /// Get total store count
  _i3.Future<int> getStoreCount() => caller.callServerEndpoint<int>(
    'admin',
    'getStoreCount',
    {},
  );

  /// Activate a store
  _i3.Future<bool> activateStore(int storeId) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'activateStore',
        {'storeId': storeId},
      );

  /// Deactivate a store
  _i3.Future<bool> deactivateStore({
    required int storeId,
    String? reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'deactivateStore',
    {
      'storeId': storeId,
      'reason': reason,
    },
  );

  /// Delete a store permanently
  _i3.Future<bool> deleteStore(int storeId) => caller.callServerEndpoint<bool>(
    'admin',
    'deleteStore',
    {'storeId': storeId},
  );

  /// Suspend a user
  _i3.Future<bool> suspendUser({
    required int userId,
    String? reason,
    DateTime? suspendUntil,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'suspendUser',
    {
      'userId': userId,
      'reason': reason,
      'suspendUntil': suspendUntil,
    },
  );

  /// Unsuspend a user
  _i3.Future<bool> unsuspendUser(int userId) => caller.callServerEndpoint<bool>(
    'admin',
    'unsuspendUser',
    {'userId': userId},
  );

  /// Ban a user (permanent suspension)
  _i3.Future<bool> banUser({
    required int userId,
    String? reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'banUser',
    {
      'userId': userId,
      'reason': reason,
    },
  );

  /// Delete a user
  _i3.Future<bool> deleteUser(int userId) => caller.callServerEndpoint<bool>(
    'admin',
    'deleteUser',
    {'userId': userId},
  );

  /// Verify a driver
  _i3.Future<bool> verifyDriver(int driverId) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'verifyDriver',
        {'driverId': driverId},
      );

  /// Create an admin user
  _i3.Future<_i8.User?> createAdminUser({
    required String firebaseUid,
    required String email,
    required String fullName,
  }) => caller.callServerEndpoint<_i8.User?>(
    'admin',
    'createAdminUser',
    {
      'firebaseUid': firebaseUid,
      'email': email,
      'fullName': fullName,
    },
  );

  /// Get total driver count
  _i3.Future<int> getDriverCount() => caller.callServerEndpoint<int>(
    'admin',
    'getDriverCount',
    {},
  );

  /// Unverify a driver
  _i3.Future<bool> unverifyDriver(int driverId) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'unverifyDriver',
        {'driverId': driverId},
      );

  /// Suspend a driver (Note: DriverProfile doesn't have suspension fields, so we just log it)
  _i3.Future<bool> suspendDriver({
    required int driverId,
    String? reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'suspendDriver',
    {
      'driverId': driverId,
      'reason': reason,
    },
  );

  /// Delete a driver permanently
  _i3.Future<bool> deleteDriver(int driverId) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'deleteDriver',
        {'driverId': driverId},
      );

  /// Get total order count
  _i3.Future<int> getOrderCount() => caller.callServerEndpoint<int>(
    'admin',
    'getOrderCount',
    {},
  );

  /// List all store orders with pagination
  _i3.Future<List<_i11.StoreOrder>> listOrders({
    required int page,
    required int limit,
    _i12.StoreOrderStatus? statusFilter,
  }) => caller.callServerEndpoint<List<_i11.StoreOrder>>(
    'admin',
    'listOrders',
    {
      'page': page,
      'limit': limit,
      'statusFilter': statusFilter,
    },
  );

  /// List all service requests with pagination
  _i3.Future<List<_i13.ServiceRequest>> listRequests({
    required int page,
    required int limit,
    _i14.RequestStatus? statusFilter,
  }) => caller.callServerEndpoint<List<_i13.ServiceRequest>>(
    'admin',
    'listRequests',
    {
      'page': page,
      'limit': limit,
      'statusFilter': statusFilter,
    },
  );

  /// Get total service request count
  _i3.Future<int> getRequestCount({_i14.RequestStatus? statusFilter}) =>
      caller.callServerEndpoint<int>(
        'admin',
        'getRequestCount',
        {'statusFilter': statusFilter},
      );

  /// Update request status
  _i3.Future<_i13.ServiceRequest?> updateRequestStatus(
    int requestId,
    _i14.RequestStatus status, {
    String? note,
  }) => caller.callServerEndpoint<_i13.ServiceRequest?>(
    'admin',
    'updateRequestStatus',
    {
      'requestId': requestId,
      'status': status,
      'note': note,
    },
  );

  /// List all transactions with pagination
  _i3.Future<List<_i15.Transaction>> listTransactions({
    required int page,
    required int limit,
    _i16.TransactionStatus? statusFilter,
  }) => caller.callServerEndpoint<List<_i15.Transaction>>(
    'admin',
    'listTransactions',
    {
      'page': page,
      'limit': limit,
      'statusFilter': statusFilter,
    },
  );

  /// List all reports with pagination
  _i3.Future<List<_i17.Report>> listReports({
    required int page,
    required int limit,
    _i18.ReportStatus? statusFilter,
  }) => caller.callServerEndpoint<List<_i17.Report>>(
    'admin',
    'listReports',
    {
      'page': page,
      'limit': limit,
      'statusFilter': statusFilter,
    },
  );

  /// Resolve a report
  _i3.Future<bool> resolveReport({
    required int reportId,
    required _i19.ReportResolution resolution,
    String? adminNotes,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'resolveReport',
    {
      'reportId': reportId,
      'resolution': resolution,
      'adminNotes': adminNotes,
    },
  );

  /// Get recent platform activities
  _i3.Future<List<_i20.RecentActivity>> getRecentActivities({
    required int limit,
  }) => caller.callServerEndpoint<List<_i20.RecentActivity>>(
    'admin',
    'getRecentActivities',
    {'limit': limit},
  );

  /// Dismiss a report
  _i3.Future<bool> dismissReport({
    required int reportId,
    String? reason,
  }) => caller.callServerEndpoint<bool>(
    'admin',
    'dismissReport',
    {
      'reportId': reportId,
      'reason': reason,
    },
  );
}

/// AI Agent Endpoint
///
/// Provides API access to Awhar's AI agents:
/// - Smart Driver Matching: Find best drivers for a request
/// - Request Concierge: Parse natural language into structured requests
/// - Demand Prediction: Predict demand hotspots
///
/// These agents are powered by Elasticsearch and designed for the
/// Elasticsearch Agent Builder Hackathon.
/// {@category Endpoint}
class EndpointAgent extends _i2.EndpointRef {
  EndpointAgent(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'agent';

  /// Find the best drivers for a service request
  ///
  /// Now routes through the Kibana `awhar-match` Agent Builder agent
  /// which uses multi-factor scoring (distance, rating, workload, etc.)
  /// powered by 9 ES|QL tools running against live Elasticsearch data.
  ///
  /// Falls back to the legacy Dart-based matching if the Kibana agent fails.
  _i3.Future<_i21.AiDriverMatchingResponse> findBestDrivers({
    int? serviceId,
    int? categoryId,
    required double latitude,
    required double longitude,
    double? radiusKm,
    bool? preferVerified,
    bool? preferPremium,
    double? minRating,
    int? maxResults,
  }) => caller.callServerEndpoint<_i21.AiDriverMatchingResponse>(
    'agent',
    'findBestDrivers',
    {
      'serviceId': serviceId,
      'categoryId': categoryId,
      'latitude': latitude,
      'longitude': longitude,
      'radiusKm': radiusKm,
      'preferVerified': preferVerified,
      'preferPremium': preferPremium,
      'minRating': minRating,
      'maxResults': maxResults,
    },
  );

  /// Parse a natural language service request
  ///
  /// Examples:
  /// - "I need someone to pick up groceries from Marjane"
  /// - "Can someone help me move furniture tomorrow?"
  /// - "I need a ride to the airport at 6am"
  ///
  /// Returns:
  /// - Parsed service request with category, locations, estimated price
  /// - Clarifying questions if more info needed
  /// - Similar services for alternatives
  _i3.Future<_i22.AiRequestConciergeResponse> parseServiceRequest({
    required String request,
    String? language,
    double? latitude,
    double? longitude,
    int? userId,
  }) => caller.callServerEndpoint<_i22.AiRequestConciergeResponse>(
    'agent',
    'parseServiceRequest',
    {
      'request': request,
      'language': language,
      'latitude': latitude,
      'longitude': longitude,
      'userId': userId,
    },
  );

  /// Predict demand hotspots for drivers
  ///
  /// Analyzes historical patterns to identify:
  /// - High-demand areas
  /// - Peak time windows
  /// - Service category trends
  /// - Driver positioning recommendations
  _i3.Future<_i23.AiDemandPredictionResponse> predictDemand({
    required double latitude,
    required double longitude,
    double? radiusKm,
    int? hoursAhead,
    int? categoryId,
  }) => caller.callServerEndpoint<_i23.AiDemandPredictionResponse>(
    'agent',
    'predictDemand',
    {
      'latitude': latitude,
      'longitude': longitude,
      'radiusKm': radiusKm,
      'hoursAhead': hoursAhead,
      'categoryId': categoryId,
    },
  );

  /// Search help articles and FAQ using ELSER semantic search
  ///
  /// Uses AI-powered semantic understanding to match questions to answers:
  /// - "how do I get my money back?" → Refund Policy article
  /// - "delete my account" → Account Deletion FAQ
  /// - "how to become a driver?" → Driver Registration Guide
  ///
  /// Powered by Elasticsearch ELSER (Elastic Learned Sparse EncodeR)
  /// for true semantic understanding beyond keyword matching.
  _i3.Future<_i24.AiHelpSearchResponse> searchHelp({
    required String question,
    String? language,
    String? category,
    int? maxResults,
  }) => caller.callServerEndpoint<_i24.AiHelpSearchResponse>(
    'agent',
    'searchHelp',
    {
      'question': question,
      'language': language,
      'category': category,
      'maxResults': maxResults,
    },
  );

  /// Converse with a Kibana Agent Builder agent.
  ///
  /// This is the primary integration with Elasticsearch's Agent Builder.
  /// Instead of running AI logic in Dart, this proxies to Kibana where
  /// agents are configured with:
  /// - LLM connectors (Claude, GPT, Gemini)
  /// - ES|QL tools that query Elasticsearch indices directly
  /// - System instructions and guardrails
  /// - Multi-turn conversation management
  ///
  /// ## Available Agents:
  /// - **Concierge**: Helps clients describe service requests, matches services
  /// - **Shield**: Fraud detection and risk analysis
  /// - **Order Coordinator**: Driver matching and dispatch optimization
  ///
  /// ## Architecture:
  /// ```
  /// Flutter → Serverpod → KibanaAgentClient → Kibana Agent Builder
  ///                                               ↓
  ///                                          LLM + ES|QL Tools
  ///                                               ↓
  ///                                         Elasticsearch Data
  /// ```
  _i3.Future<_i25.AgentBuilderConverseResponse> converseWithAgent({
    required String agentId,
    required String message,
    String? conversationId,
    String? connectorId,
    int? userId,
    double? latitude,
    double? longitude,
  }) => caller.callServerEndpoint<_i25.AgentBuilderConverseResponse>(
    'agent',
    'converseWithAgent',
    {
      'agentId': agentId,
      'message': message,
      'conversationId': conversationId,
      'connectorId': connectorId,
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
    },
  );

  /// Start a streaming conversation with a Kibana Agent Builder agent.
  ///
  /// Returns a session ID immediately. The server consumes the SSE
  /// stream from Kibana in the background, collecting events.
  /// Flutter polls [pollAgentStream] every 500ms to get new events.
  ///
  /// This enables real-time display of:
  /// - Agent reasoning steps ("Let me search for...")
  /// - Tool calls being executed (search_services, get_prices, etc.)
  /// - Tool results arriving
  /// - The answer streaming in chunk by chunk
  _i3.Future<String> startAgentConverse({
    required String agentId,
    required String message,
    String? conversationId,
    String? connectorId,
    int? userId,
    double? latitude,
    double? longitude,
  }) => caller.callServerEndpoint<String>(
    'agent',
    'startAgentConverse',
    {
      'agentId': agentId,
      'message': message,
      'conversationId': conversationId,
      'connectorId': connectorId,
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
    },
  );

  /// Poll for streaming events from an active agent conversation.
  ///
  /// Returns all events collected so far plus the session status.
  /// Flutter calls this every 500ms until status is 'complete' or 'error'.
  ///
  /// The [lastEventIndex] parameter enables incremental fetching:
  /// pass 0 on first call, then the length of events received to
  /// only get new events. If omitted, returns all events.
  _i3.Future<_i26.AgentStreamStatus> pollAgentStream({
    required String streamSessionId,
    int? lastEventIndex,
  }) => caller.callServerEndpoint<_i26.AgentStreamStatus>(
    'agent',
    'pollAgentStream',
    {
      'streamSessionId': streamSessionId,
      'lastEventIndex': lastEventIndex,
    },
  );

  /// Get the status of all AI agents
  _i3.Future<_i27.AiAgentStatusResponse> getAgentStatus() =>
      caller.callServerEndpoint<_i27.AiAgentStatusResponse>(
        'agent',
        'getAgentStatus',
        {},
      );

  /// Full service request flow using multiple agents
  ///
  /// 1. Parse natural language request (Concierge)
  /// 2. Find matching drivers (Matching)
  /// 3. Return combined result
  _i3.Future<_i28.AiFullRequestResponse> processFullRequest({
    required String request,
    required double latitude,
    required double longitude,
    String? language,
  }) => caller.callServerEndpoint<_i28.AiFullRequestResponse>(
    'agent',
    'processFullRequest',
    {
      'request': request,
      'latitude': latitude,
      'longitude': longitude,
      'language': language,
    },
  );
}

/// Analytics Endpoint for Awhar
///
/// Provides server-side analytics logging to Elasticsearch.
/// Used for tracking business events that happen on the backend
/// and optionally syncing events from the mobile app.
/// {@category Endpoint}
class EndpointAnalytics extends _i2.EndpointRef {
  EndpointAnalytics(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'analytics';

  /// Log an analytics event from the mobile app
  ///
  /// This allows the app to log events directly to Elasticsearch
  /// for unified analytics across PostHog, Firebase, and ES.
  ///
  /// [propertiesJson] should be a JSON-encoded string of the event properties.
  _i3.Future<bool> logEvent({
    required String eventName,
    String? eventType,
    String? propertiesJson,
    String? screenName,
    String? platform,
    String? appVersion,
    int? userId,
    String? sessionId,
  }) => caller.callServerEndpoint<bool>(
    'analytics',
    'logEvent',
    {
      'eventName': eventName,
      'eventType': eventType,
      'propertiesJson': propertiesJson,
      'screenName': screenName,
      'platform': platform,
      'appVersion': appVersion,
      'userId': userId,
      'sessionId': sessionId,
    },
  );

  /// Log multiple events in batch
  ///
  /// [eventsJson] should be a JSON-encoded array of event objects.
  _i3.Future<int> logEvents({
    required String eventsJson,
    int? userId,
  }) => caller.callServerEndpoint<int>(
    'analytics',
    'logEvents',
    {
      'eventsJson': eventsJson,
      'userId': userId,
    },
  );

  /// Log a business event (booking, payment, etc.)
  /// Can be called from the app or internally from other endpoints
  _i3.Future<bool> logBusinessEvent({
    required String eventName,
    String? propertiesJson,
    double? revenue,
    double? commission,
    int? userId,
  }) => caller.callServerEndpoint<bool>(
    'analytics',
    'logBusinessEvent',
    {
      'eventName': eventName,
      'propertiesJson': propertiesJson,
      'revenue': revenue,
      'commission': commission,
      'userId': userId,
    },
  );

  /// Get analytics summary for admin dashboard
  _i3.Future<String> getAnalyticsSummary({
    String? startDate,
    String? endDate,
    String? eventType,
  }) => caller.callServerEndpoint<String>(
    'analytics',
    'getAnalyticsSummary',
    {
      'startDate': startDate,
      'endDate': endDate,
      'eventType': eventType,
    },
  );

  /// Get recent events for debugging
  _i3.Future<String> getRecentEvents({
    int? limit,
    String? eventName,
    String? eventType,
  }) => caller.callServerEndpoint<String>(
    'analytics',
    'getRecentEvents',
    {
      'limit': limit,
      'eventName': eventName,
      'eventType': eventType,
    },
  );
}

/// Authentication endpoint for Firebase-based auth
/// Handles registration, login, and token management
/// {@category Endpoint}
class EndpointFirebaseAuth extends _i2.EndpointRef {
  EndpointFirebaseAuth(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'firebaseAuth';

  /// Register a new user with Firebase token
  /// Creates user in database after verifying Firebase token
  _i3.Future<_i29.AuthResponse> registerWithFirebase({
    required String firebaseIdToken,
    required String fullName,
    required _i30.UserRole role,
    String? email,
    String? phoneNumber,
    String? profilePhotoUrl,
  }) => caller.callServerEndpoint<_i29.AuthResponse>(
    'firebaseAuth',
    'registerWithFirebase',
    {
      'firebaseIdToken': firebaseIdToken,
      'fullName': fullName,
      'role': role,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePhotoUrl': profilePhotoUrl,
    },
  );

  /// Login with Firebase token
  /// Verifies token and returns user data with JWT
  _i3.Future<_i29.AuthResponse> loginWithFirebase({
    required String firebaseIdToken,
  }) => caller.callServerEndpoint<_i29.AuthResponse>(
    'firebaseAuth',
    'loginWithFirebase',
    {'firebaseIdToken': firebaseIdToken},
  );

  /// Refresh access token using refresh token
  /// Note: Serverpod JWT has its own refresh mechanism, but we support our custom refresh too
  _i3.Future<_i29.AuthResponse> refreshToken({required String refreshToken}) =>
      caller.callServerEndpoint<_i29.AuthResponse>(
        'firebaseAuth',
        'refreshToken',
        {'refreshToken': refreshToken},
      );

  /// Get current user by token (pass userId from decoded token)
  _i3.Future<_i29.AuthResponse> getCurrentUser({required int userId}) =>
      caller.callServerEndpoint<_i29.AuthResponse>(
        'firebaseAuth',
        'getCurrentUser',
        {'userId': userId},
      );

  /// Logout - client should clear tokens
  _i3.Future<_i29.AuthResponse> logout() =>
      caller.callServerEndpoint<_i29.AuthResponse>(
        'firebaseAuth',
        'logout',
        {},
      );

  /// Check if email exists
  _i3.Future<bool> checkEmailExists(String email) =>
      caller.callServerEndpoint<bool>(
        'firebaseAuth',
        'checkEmailExists',
        {'email': email},
      );

  /// Check if phone exists
  _i3.Future<bool> checkPhoneExists(String phone) =>
      caller.callServerEndpoint<bool>(
        'firebaseAuth',
        'checkPhoneExists',
        {'phone': phone},
      );
}

/// Endpoint for managing blocked users
/// {@category Endpoint}
class EndpointBlockedUser extends _i2.EndpointRef {
  EndpointBlockedUser(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'blockedUser';

  /// Block a user
  _i3.Future<_i31.BlockedUser?> blockUser({
    required int userId,
    required int blockedUserId,
    String? reason,
  }) => caller.callServerEndpoint<_i31.BlockedUser?>(
    'blockedUser',
    'blockUser',
    {
      'userId': userId,
      'blockedUserId': blockedUserId,
      'reason': reason,
    },
  );

  /// Unblock a user
  _i3.Future<bool> unblockUser({
    required int userId,
    required int blockedUserId,
  }) => caller.callServerEndpoint<bool>(
    'blockedUser',
    'unblockUser',
    {
      'userId': userId,
      'blockedUserId': blockedUserId,
    },
  );

  /// Get list of blocked users for a user
  _i3.Future<List<_i31.BlockedUser>> getBlockedUsers({required int userId}) =>
      caller.callServerEndpoint<List<_i31.BlockedUser>>(
        'blockedUser',
        'getBlockedUsers',
        {'userId': userId},
      );

  /// Check if a user is blocked
  _i3.Future<bool> isUserBlocked({
    required int userId,
    required int targetUserId,
  }) => caller.callServerEndpoint<bool>(
    'blockedUser',
    'isUserBlocked',
    {
      'userId': userId,
      'targetUserId': targetUserId,
    },
  );

  /// Check if blocked by another user
  _i3.Future<bool> isBlockedByUser({
    required int userId,
    required int otherUserId,
  }) => caller.callServerEndpoint<bool>(
    'blockedUser',
    'isBlockedByUser',
    {
      'userId': userId,
      'otherUserId': otherUserId,
    },
  );
}

/// Chat management endpoint
/// Handles chat messages, syncing with Firebase, read receipts
/// {@category Endpoint}
class EndpointChat extends _i2.EndpointRef {
  EndpointChat(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'chat';

  /// Send a chat message (also syncs to Firebase)
  _i3.Future<_i32.ChatMessage?> sendMessage({
    required int orderId,
    required int senderId,
    required int receiverId,
    required String message,
    _i33.MessageType? messageType,
    String? attachmentUrl,
    String? firebaseId,
  }) => caller.callServerEndpoint<_i32.ChatMessage?>(
    'chat',
    'sendMessage',
    {
      'orderId': orderId,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'messageType': messageType,
      'attachmentUrl': attachmentUrl,
      'firebaseId': firebaseId,
    },
  );

  /// Get chat messages for an order
  _i3.Future<List<_i32.ChatMessage>> getMessages({
    required int orderId,
    int? limit,
    DateTime? before,
  }) => caller.callServerEndpoint<List<_i32.ChatMessage>>(
    'chat',
    'getMessages',
    {
      'orderId': orderId,
      'limit': limit,
      'before': before,
    },
  );

  /// Get unread message count for a user
  _i3.Future<int> getUnreadCount({required int userId}) =>
      caller.callServerEndpoint<int>(
        'chat',
        'getUnreadCount',
        {'userId': userId},
      );

  /// Mark messages as read
  _i3.Future<int> markAsRead({
    required int orderId,
    required int userId,
  }) => caller.callServerEndpoint<int>(
    'chat',
    'markAsRead',
    {
      'orderId': orderId,
      'userId': userId,
    },
  );

  /// Mark specific message as read
  _i3.Future<_i32.ChatMessage?> markMessageAsRead({required int messageId}) =>
      caller.callServerEndpoint<_i32.ChatMessage?>(
        'chat',
        'markMessageAsRead',
        {'messageId': messageId},
      );

  /// Sync message from Firebase to PostgreSQL
  _i3.Future<_i32.ChatMessage?> syncFromFirebase({
    required String firebaseId,
    required int orderId,
    required int senderId,
    required int receiverId,
    required String message,
    _i33.MessageType? messageType,
    String? attachmentUrl,
    required DateTime createdAt,
  }) => caller.callServerEndpoint<_i32.ChatMessage?>(
    'chat',
    'syncFromFirebase',
    {
      'firebaseId': firebaseId,
      'orderId': orderId,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'messageType': messageType,
      'attachmentUrl': attachmentUrl,
      'createdAt': createdAt,
    },
  );

  /// Get chat history for admin (all messages for an order)
  _i3.Future<List<_i32.ChatMessage>> getAdminChatHistory({
    required int orderId,
  }) => caller.callServerEndpoint<List<_i32.ChatMessage>>(
    'chat',
    'getAdminChatHistory',
    {'orderId': orderId},
  );

  /// Send a notification for a new chat message
  /// Called by client after sending message to Firebase Realtime DB
  _i3.Future<bool> notifyNewMessage({
    required int requestId,
    required int recipientUserId,
    required int senderId,
    required String senderName,
    required String messageText,
  }) => caller.callServerEndpoint<bool>(
    'chat',
    'notifyNewMessage',
    {
      'requestId': requestId,
      'recipientUserId': recipientUserId,
      'senderId': senderId,
      'senderName': senderName,
      'messageText': messageText,
    },
  );
}

/// Endpoint for managing countries and currency information
/// {@category Endpoint}
class EndpointCountry extends _i2.EndpointRef {
  EndpointCountry(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'country';

  /// Get all active countries
  _i3.Future<List<_i34.Country>> getActiveCountries() =>
      caller.callServerEndpoint<List<_i34.Country>>(
        'country',
        'getActiveCountries',
        {},
      );

  /// Get a country by its code (e.g., 'MA', 'US')
  _i3.Future<_i34.Country?> getCountryByCode(String code) =>
      caller.callServerEndpoint<_i34.Country?>(
        'country',
        'getCountryByCode',
        {'code': code},
      );

  /// Get the default country (Morocco)
  _i3.Future<_i34.Country?> getDefaultCountry() =>
      caller.callServerEndpoint<_i34.Country?>(
        'country',
        'getDefaultCountry',
        {},
      );

  /// Get currency info for a specific country code
  _i3.Future<Map<String, dynamic>> getCurrencyInfo(String countryCode) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'country',
        'getCurrencyInfo',
        {'countryCode': countryCode},
      );

  /// Format a price with currency symbol
  _i3.Future<String> formatPrice(
    double amount,
    String countryCode,
  ) => caller.callServerEndpoint<String>(
    'country',
    'formatPrice',
    {
      'amount': amount,
      'countryCode': countryCode,
    },
  );

  /// Initialize default countries (run on first setup)
  _i3.Future<void> initializeDefaultCountries() =>
      caller.callServerEndpoint<void>(
        'country',
        'initializeDefaultCountries',
        {},
      );

  /// Admin: Create or update a country
  _i3.Future<_i34.Country> upsertCountry(_i34.Country country) =>
      caller.callServerEndpoint<_i34.Country>(
        'country',
        'upsertCountry',
        {'country': country},
      );

  /// Admin: Update exchange rate for a country
  _i3.Future<bool> updateExchangeRate(
    String countryCode,
    double rateToMAD,
  ) => caller.callServerEndpoint<bool>(
    'country',
    'updateExchangeRate',
    {
      'countryCode': countryCode,
      'rateToMAD': rateToMAD,
    },
  );

  /// Admin: Toggle country active status
  _i3.Future<bool> toggleCountryStatus(
    String countryCode,
    bool isActive,
  ) => caller.callServerEndpoint<bool>(
    'country',
    'toggleCountryStatus',
    {
      'countryCode': countryCode,
      'isActive': isActive,
    },
  );

  /// Convert amount from one currency to another (via MAD as base)
  _i3.Future<double> convertCurrency(
    double amount,
    String fromCountryCode,
    String toCountryCode,
  ) => caller.callServerEndpoint<double>(
    'country',
    'convertCurrency',
    {
      'amount': amount,
      'fromCountryCode': fromCountryCode,
      'toCountryCode': toCountryCode,
    },
  );
}

/// Device Fingerprint Endpoint
///
/// Handles device fingerprint registration, checking, and fraud detection.
/// Used to detect multi-account fraud by tracking device hardware signatures.
/// {@category Endpoint}
class EndpointDeviceFingerprint extends _i2.EndpointRef {
  EndpointDeviceFingerprint(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'deviceFingerprint';

  /// Check a device fingerprint before signup/login
  /// Returns risk assessment and whether to allow the action
  ///
  /// Call this BEFORE creating a new user account to detect fraud
  _i3.Future<_i35.DeviceFingerprintCheckResult> checkFingerprint(
    _i36.DeviceFingerprintInput input,
  ) => caller.callServerEndpoint<_i35.DeviceFingerprintCheckResult>(
    'deviceFingerprint',
    'checkFingerprint',
    {'input': input},
  );

  /// Register a device fingerprint for a user
  /// Call this AFTER successful signup/login
  _i3.Future<_i35.DeviceFingerprintCheckResult> registerFingerprint(
    int userId,
    _i36.DeviceFingerprintInput input,
  ) => caller.callServerEndpoint<_i35.DeviceFingerprintCheckResult>(
    'deviceFingerprint',
    'registerFingerprint',
    {
      'userId': userId,
      'input': input,
    },
  );

  /// Get fingerprint record by hash (admin only)
  _i3.Future<_i37.DeviceFingerprintRecord?> getFingerprintByHash(
    String fingerprintHash,
  ) => caller.callServerEndpoint<_i37.DeviceFingerprintRecord?>(
    'deviceFingerprint',
    'getFingerprintByHash',
    {'fingerprintHash': fingerprintHash},
  );

  /// Get all fingerprints for a user ID
  _i3.Future<List<_i37.DeviceFingerprintRecord>> getFingerprintsForUser(
    int userId,
  ) => caller.callServerEndpoint<List<_i37.DeviceFingerprintRecord>>(
    'deviceFingerprint',
    'getFingerprintsForUser',
    {'userId': userId},
  );

  /// Block a device fingerprint (admin only)
  _i3.Future<_i37.DeviceFingerprintRecord?> blockFingerprint(
    String fingerprintHash,
    String reason,
  ) => caller.callServerEndpoint<_i37.DeviceFingerprintRecord?>(
    'deviceFingerprint',
    'blockFingerprint',
    {
      'fingerprintHash': fingerprintHash,
      'reason': reason,
    },
  );

  /// Unblock a device fingerprint (admin only)
  _i3.Future<_i37.DeviceFingerprintRecord?> unblockFingerprint(
    String fingerprintHash,
    String reason,
  ) => caller.callServerEndpoint<_i37.DeviceFingerprintRecord?>(
    'deviceFingerprint',
    'unblockFingerprint',
    {
      'fingerprintHash': fingerprintHash,
      'reason': reason,
    },
  );

  /// Get high-risk devices (admin only)
  _i3.Future<List<_i37.DeviceFingerprintRecord>> getHighRiskDevices({
    required double minRiskScore,
    required int limit,
  }) => caller.callServerEndpoint<List<_i37.DeviceFingerprintRecord>>(
    'deviceFingerprint',
    'getHighRiskDevices',
    {
      'minRiskScore': minRiskScore,
      'limit': limit,
    },
  );

  /// Get devices with multiple accounts (admin only)
  _i3.Future<List<_i37.DeviceFingerprintRecord>> getMultiAccountDevices({
    required int minAccounts,
    required int limit,
  }) => caller.callServerEndpoint<List<_i37.DeviceFingerprintRecord>>(
    'deviceFingerprint',
    'getMultiAccountDevices',
    {
      'minAccounts': minAccounts,
      'limit': limit,
    },
  );

  /// Report promo abuse for a fingerprint
  _i3.Future<_i37.DeviceFingerprintRecord?> reportPromoAbuse(
    String fingerprintHash,
    String promoCode,
  ) => caller.callServerEndpoint<_i37.DeviceFingerprintRecord?>(
    'deviceFingerprint',
    'reportPromoAbuse',
    {
      'fingerprintHash': fingerprintHash,
      'promoCode': promoCode,
    },
  );
}

/// Driver management endpoint
/// Handles driver availability, location updates, online drivers
/// {@category Endpoint}
class EndpointDriver extends _i2.EndpointRef {
  EndpointDriver(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'driver';

  /// Toggle driver online/offline status
  _i3.Future<_i9.DriverProfile?> setOnlineStatus({
    required int driverId,
    required bool isOnline,
  }) => caller.callServerEndpoint<_i9.DriverProfile?>(
    'driver',
    'setOnlineStatus',
    {
      'driverId': driverId,
      'isOnline': isOnline,
    },
  );

  /// Update driver location
  _i3.Future<_i9.DriverProfile?> updateLocation({
    required int driverId,
    required double latitude,
    required double longitude,
  }) => caller.callServerEndpoint<_i9.DriverProfile?>(
    'driver',
    'updateLocation',
    {
      'driverId': driverId,
      'latitude': latitude,
      'longitude': longitude,
    },
  );

  /// Get online drivers in an area
  _i3.Future<List<_i9.DriverProfile>> getOnlineDrivers({
    required double centerLat,
    required double centerLng,
    required double radiusKm,
    int? serviceId,
  }) => caller.callServerEndpoint<List<_i9.DriverProfile>>(
    'driver',
    'getOnlineDrivers',
    {
      'centerLat': centerLat,
      'centerLng': centerLng,
      'radiusKm': radiusKm,
      'serviceId': serviceId,
    },
  );

  /// Get driver services (catalog)
  /// driverId parameter is actually userId from frontend
  _i3.Future<List<_i38.DriverService>> getDriverServices({
    required int driverId,
  }) => caller.callServerEndpoint<List<_i38.DriverService>>(
    'driver',
    'getDriverServices',
    {'driverId': driverId},
  );

  /// Get driver profile by userId
  _i3.Future<_i9.DriverProfile?> getDriverProfileByUserId({
    required int userId,
  }) => caller.callServerEndpoint<_i9.DriverProfile?>(
    'driver',
    'getDriverProfileByUserId',
    {'userId': userId},
  );

  /// Add a new driver service
  _i3.Future<_i38.DriverService?> addDriverService({
    required int driverId,
    required int serviceId,
    required int categoryId,
    String? title,
    String? description,
    String? imageUrl,
    double? basePrice,
    double? pricePerKm,
    double? pricePerHour,
    double? minPrice,
  }) => caller.callServerEndpoint<_i38.DriverService?>(
    'driver',
    'addDriverService',
    {
      'driverId': driverId,
      'serviceId': serviceId,
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'basePrice': basePrice,
      'pricePerKm': pricePerKm,
      'pricePerHour': pricePerHour,
      'minPrice': minPrice,
    },
  );

  /// Update driver service
  _i3.Future<_i38.DriverService?> updateDriverService({
    required int serviceId,
    String? title,
    String? description,
    String? imageUrl,
    double? basePrice,
    double? pricePerKm,
    double? pricePerHour,
    double? minPrice,
    bool? isAvailable,
    DateTime? availableFrom,
    DateTime? availableUntil,
  }) => caller.callServerEndpoint<_i38.DriverService?>(
    'driver',
    'updateDriverService',
    {
      'serviceId': serviceId,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'basePrice': basePrice,
      'pricePerKm': pricePerKm,
      'pricePerHour': pricePerHour,
      'minPrice': minPrice,
      'isAvailable': isAvailable,
      'availableFrom': availableFrom,
      'availableUntil': availableUntil,
    },
  );

  /// Delete driver service
  _i3.Future<bool> deleteDriverService({required int serviceId}) =>
      caller.callServerEndpoint<bool>(
        'driver',
        'deleteDriverService',
        {'serviceId': serviceId},
      );

  /// Toggle service availability
  _i3.Future<_i38.DriverService?> toggleServiceAvailability({
    required int serviceId,
    required bool isAvailable,
  }) => caller.callServerEndpoint<_i38.DriverService?>(
    'driver',
    'toggleServiceAvailability',
    {
      'serviceId': serviceId,
      'isAvailable': isAvailable,
    },
  );

  /// Reorder driver services
  _i3.Future<bool> reorderDriverServices({
    required int driverId,
    required List<int> serviceIds,
  }) => caller.callServerEndpoint<bool>(
    'driver',
    'reorderDriverServices',
    {
      'driverId': driverId,
      'serviceIds': serviceIds,
    },
  );

  /// Upload service image file to storage
  _i3.Future<String?> uploadServiceImageFile({
    required int driverServiceId,
    required _i39.ByteData imageData,
    required String fileName,
  }) => caller.callServerEndpoint<String?>(
    'driver',
    'uploadServiceImageFile',
    {
      'driverServiceId': driverServiceId,
      'imageData': imageData,
      'fileName': fileName,
    },
  );

  /// Upload service image
  _i3.Future<_i40.ServiceImage?> uploadServiceImage({
    required int driverServiceId,
    required String imageUrl,
    String? thumbnailUrl,
    String? caption,
    int? fileSize,
    int? width,
    int? height,
  }) => caller.callServerEndpoint<_i40.ServiceImage?>(
    'driver',
    'uploadServiceImage',
    {
      'driverServiceId': driverServiceId,
      'imageUrl': imageUrl,
      'thumbnailUrl': thumbnailUrl,
      'caption': caption,
      'fileSize': fileSize,
      'width': width,
      'height': height,
    },
  );

  /// Get service images
  _i3.Future<List<_i40.ServiceImage>> getServiceImages({
    required int driverServiceId,
  }) => caller.callServerEndpoint<List<_i40.ServiceImage>>(
    'driver',
    'getServiceImages',
    {'driverServiceId': driverServiceId},
  );

  /// Delete service image
  _i3.Future<bool> deleteServiceImage({required int imageId}) =>
      caller.callServerEndpoint<bool>(
        'driver',
        'deleteServiceImage',
        {'imageId': imageId},
      );

  /// Auto-offline check (should be called periodically)
  _i3.Future<int> autoOfflineDrivers() => caller.callServerEndpoint<int>(
    'driver',
    'autoOfflineDrivers',
    {},
  );

  /// Check if driver is truly online based on multiple factors
  /// Returns true only if ALL of these are true:
  /// 1. User.isOnline = true
  /// 2. DriverProfile.isOnline = true
  /// 3. Presence in Firebase with lastSeen < 2 minutes
  /// 4. No errors or warnings
  _i3.Future<bool> isDriverTrulyOnline({required int userId}) =>
      caller.callServerEndpoint<bool>(
        'driver',
        'isDriverTrulyOnline',
        {'userId': userId},
      );
}

/// Endpoint for managing driver online/offline status
/// {@category Endpoint}
class EndpointDriverStatus extends _i2.EndpointRef {
  EndpointDriverStatus(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'driverStatus';

  /// Set driver online/offline status
  _i3.Future<_i8.User?> setDriverStatus(
    int userId,
    bool isOnline,
  ) => caller.callServerEndpoint<_i8.User?>(
    'driverStatus',
    'setDriverStatus',
    {
      'userId': userId,
      'isOnline': isOnline,
    },
  );

  /// Get driver's current status
  _i3.Future<bool> getDriverStatus(int userId) =>
      caller.callServerEndpoint<bool>(
        'driverStatus',
        'getDriverStatus',
        {'userId': userId},
      );

  /// Get count of online drivers
  _i3.Future<int> getOnlineDriversCount() => caller.callServerEndpoint<int>(
    'driverStatus',
    'getOnlineDriversCount',
    {},
  );

  /// Update lastSeenAt timestamp (for heartbeat/ping)
  _i3.Future<bool> updateLastSeen(int userId) =>
      caller.callServerEndpoint<bool>(
        'driverStatus',
        'updateLastSeen',
        {'userId': userId},
      );
}

/// Endpoint for Elasticsearch operations
/// {@category Endpoint}
class EndpointElasticsearch extends _i2.EndpointRef {
  EndpointElasticsearch(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'elasticsearch';

  /// Test Elasticsearch connection
  /// Returns cluster info if connected successfully
  _i3.Future<Map<String, dynamic>> testConnection() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'testConnection',
        {},
      );

  /// Get cluster health status
  _i3.Future<Map<String, dynamic>> getHealth() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'getHealth',
        {},
      );

  /// Check if an index exists
  _i3.Future<Map<String, dynamic>> checkIndex(String indexName) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'checkIndex',
        {'indexName': indexName},
      );

  /// Get all Awhar indices status
  _i3.Future<Map<String, dynamic>> getIndicesStatus() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'getIndicesStatus',
        {},
      );

  /// Index a test document (for testing purposes)
  _i3.Future<Map<String, dynamic>> indexTestDocument() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'indexTestDocument',
        {},
      );

  /// Search test document
  _i3.Future<Map<String, dynamic>> searchTestDocument() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'searchTestDocument',
        {},
      );

  /// Delete test document
  _i3.Future<Map<String, dynamic>> deleteTestDocument() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'deleteTestDocument',
        {},
      );

  /// Get Elasticsearch service status summary
  _i3.Future<Map<String, dynamic>> getStatus() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'getStatus',
        {},
      );

  /// Migrate all data from PostgreSQL to Elasticsearch
  /// WARNING: This can take a long time for large datasets
  _i3.Future<Map<String, dynamic>> migrateAll() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'migrateAll',
        {},
      );

  /// Migrate only drivers
  _i3.Future<Map<String, dynamic>> migrateDrivers() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'migrateDrivers',
        {},
      );

  /// Migrate only services
  _i3.Future<Map<String, dynamic>> migrateServices() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'migrateServices',
        {},
      );

  /// Migrate only driver services (catalog)
  _i3.Future<Map<String, dynamic>> migrateDriverServices() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'migrateDriverServices',
        {},
      );

  /// Migrate only requests
  _i3.Future<Map<String, dynamic>> migrateRequests() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'migrateRequests',
        {},
      );

  /// Migrate only stores
  _i3.Future<Map<String, dynamic>> migrateStores() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'migrateStores',
        {},
      );

  /// Migrate only products
  _i3.Future<Map<String, dynamic>> migrateProducts() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'migrateProducts',
        {},
      );

  /// Migrate only reviews
  _i3.Future<Map<String, dynamic>> migrateReviews() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'migrateReviews',
        {},
      );

  /// Migrate only store orders
  _i3.Future<Map<String, dynamic>> migrateStoreOrders() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'migrateStoreOrders',
        {},
      );

  /// Migrate only transactions
  _i3.Future<Map<String, dynamic>> migrateTransactions() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'migrateTransactions',
        {},
      );

  /// Migrate only users
  _i3.Future<Map<String, dynamic>> migrateUsers() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'migrateUsers',
        {},
      );

  /// Migrate only wallets
  _i3.Future<Map<String, dynamic>> migrateWallets() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'migrateWallets',
        {},
      );

  /// Migrate only ratings (combines service ratings + store reviews)
  _i3.Future<Map<String, dynamic>> migrateRatings() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'elasticsearch',
        'migrateRatings',
        {},
      );

  /// Get document count for each index
  /// Returns a flat map: {"awhar-drivers": 6, "awhar-services": 22, ...}
  _i3.Future<Map<String, int>> getDocumentCounts() =>
      caller.callServerEndpoint<Map<String, int>>(
        'elasticsearch',
        'getDocumentCounts',
        {},
      );
}

/// Email endpoint for sending emails from the client
///
/// Provides methods to send various types of emails through the SMTP service.
/// {@category Endpoint}
class EndpointEmail extends _i2.EndpointRef {
  EndpointEmail(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'email';

  /// Check if email service is configured and ready
  _i3.Future<bool> isEmailServiceReady() => caller.callServerEndpoint<bool>(
    'email',
    'isEmailServiceReady',
    {},
  );

  /// Send a test email (for testing purposes)
  _i3.Future<bool> sendTestEmail(String recipientEmail) =>
      caller.callServerEndpoint<bool>(
        'email',
        'sendTestEmail',
        {'recipientEmail': recipientEmail},
      );

  /// Send a welcome email to a user
  _i3.Future<bool> sendWelcomeEmail({
    required String email,
    required String name,
  }) => caller.callServerEndpoint<bool>(
    'email',
    'sendWelcomeEmail',
    {
      'email': email,
      'name': name,
    },
  );

  /// Send an order confirmation email
  _i3.Future<bool> sendOrderConfirmation({
    required String email,
    required String name,
    required String orderId,
    required String serviceName,
    required String date,
    required String total,
  }) => caller.callServerEndpoint<bool>(
    'email',
    'sendOrderConfirmation',
    {
      'email': email,
      'name': name,
      'orderId': orderId,
      'serviceName': serviceName,
      'date': date,
      'total': total,
    },
  );

  /// Send a driver accepted notification email
  _i3.Future<bool> sendDriverAcceptedNotification({
    required String email,
    required String name,
    required String orderId,
    required String driverName,
    required String driverPhone,
    String? vehicleInfo,
  }) => caller.callServerEndpoint<bool>(
    'email',
    'sendDriverAcceptedNotification',
    {
      'email': email,
      'name': name,
      'orderId': orderId,
      'driverName': driverName,
      'driverPhone': driverPhone,
      'vehicleInfo': vehicleInfo,
    },
  );

  /// Send an order completed email
  _i3.Future<bool> sendOrderCompletedEmail({
    required String email,
    required String name,
    required String orderId,
    required String serviceName,
    required String total,
  }) => caller.callServerEndpoint<bool>(
    'email',
    'sendOrderCompletedEmail',
    {
      'email': email,
      'name': name,
      'orderId': orderId,
      'serviceName': serviceName,
      'total': total,
    },
  );

  /// Send a custom email (admin only - requires authentication)
  _i3.Future<bool> sendCustomEmail({
    required String recipientEmail,
    String? recipientName,
    required String subject,
    required String htmlBody,
    String? textBody,
  }) => caller.callServerEndpoint<bool>(
    'email',
    'sendCustomEmail',
    {
      'recipientEmail': recipientEmail,
      'recipientName': recipientName,
      'subject': subject,
      'htmlBody': htmlBody,
      'textBody': textBody,
    },
  );
}

/// JWT token refresh endpoint that extends Serverpod's RefreshJwtTokensEndpoint
/// This enables automatic JWT token refresh on the Flutter client
/// {@category Endpoint}
class EndpointRefreshJwtTokens extends _i4.EndpointRefreshJwtTokens {
  EndpointRefreshJwtTokens(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'refreshJwtTokens';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i3.Future<_i4.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'refreshJwtTokens',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// Endpoint for managing driver location and address
/// {@category Endpoint}
class EndpointLocation extends _i2.EndpointRef {
  EndpointLocation(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'location';

  /// Update driver's current location and address
  /// Also syncs to DriverProfile table for nearby driver searches
  _i3.Future<_i8.User?> updateDriverLocation(
    int userId,
    double latitude,
    double longitude,
  ) => caller.callServerEndpoint<_i8.User?>(
    'location',
    'updateDriverLocation',
    {
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
    },
  );
}

/// Proxy endpoint for MCP (Model Context Protocol) calls.
///
/// Forwards requests from admin dashboard to Kibana Agent Builder MCP endpoint,
/// bypassing CORS restrictions.
/// {@category Endpoint}
class EndpointMcpProxy extends _i2.EndpointRef {
  EndpointMcpProxy(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'mcpProxy';

  /// Forward an MCP JSON-RPC request to Kibana
  _i3.Future<String> proxyMcpRequest(String requestJson) =>
      caller.callServerEndpoint<String>(
        'mcpProxy',
        'proxyMcpRequest',
        {'requestJson': requestJson},
      );
}

/// Media endpoint
/// Records media metadata, lists media by request, and tracks access/downloads.
/// {@category Endpoint}
class EndpointMedia extends _i2.EndpointRef {
  EndpointMedia(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'media';

  _i3.Future<bool> ping() => caller.callServerEndpoint<bool>(
    'media',
    'ping',
    {},
  );

  /// Record a media metadata entry after a successful upload to Firebase Storage.
  _i3.Future<_i41.MediaMetadata?> recordMedia({
    required String messageId,
    required int userId,
    required int requestId,
    required String mediaUrl,
    required String mediaType,
    required String fileName,
    required int fileSizeBytes,
    int? durationMs,
    String? thumbnailUrl,
    DateTime? uploadedAt,
  }) => caller.callServerEndpoint<_i41.MediaMetadata?>(
    'media',
    'recordMedia',
    {
      'messageId': messageId,
      'userId': userId,
      'requestId': requestId,
      'mediaUrl': mediaUrl,
      'mediaType': mediaType,
      'fileName': fileName,
      'fileSizeBytes': fileSizeBytes,
      'durationMs': durationMs,
      'thumbnailUrl': thumbnailUrl,
      'uploadedAt': uploadedAt,
    },
  );

  /// List media entries by `requestId` (e.g. all media for a chat thread/request).
  _i3.Future<List<_i41.MediaMetadata>> listByRequest({
    required int requestId,
  }) => caller.callServerEndpoint<List<_i41.MediaMetadata>>(
    'media',
    'listByRequest',
    {'requestId': requestId},
  );

  /// Increment download count and update last accessed time for a media entry.
  _i3.Future<bool> incrementDownload({required int id}) =>
      caller.callServerEndpoint<bool>(
        'media',
        'incrementDownload',
        {'id': id},
      );
}

/// Notification endpoint
/// Handles in-app notifications and FCM push notifications
/// {@category Endpoint}
class EndpointNotification extends _i2.EndpointRef {
  EndpointNotification(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notification';

  /// Get user notifications
  _i3.Future<List<_i42.UserNotification>> getUserNotifications({
    required int userId,
    bool? unreadOnly,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i42.UserNotification>>(
    'notification',
    'getUserNotifications',
    {
      'userId': userId,
      'unreadOnly': unreadOnly,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Mark notification as read
  _i3.Future<bool> markAsRead(int notificationId) =>
      caller.callServerEndpoint<bool>(
        'notification',
        'markAsRead',
        {'notificationId': notificationId},
      );

  /// Mark all notifications as read for a user
  _i3.Future<bool> markAllAsRead(int userId) => caller.callServerEndpoint<bool>(
    'notification',
    'markAllAsRead',
    {'userId': userId},
  );

  /// Get unread count
  _i3.Future<int> getUnreadCount(int userId) => caller.callServerEndpoint<int>(
    'notification',
    'getUnreadCount',
    {'userId': userId},
  );

  /// Create notification (internal helper) - Also sends FCM push
  _i3.Future<_i42.UserNotification?> createNotification({
    required int userId,
    required String title,
    required String body,
    required _i43.NotificationType type,
    int? relatedEntityId,
    String? relatedEntityType,
    Map<String, dynamic>? data,
  }) => caller.callServerEndpoint<_i42.UserNotification?>(
    'notification',
    'createNotification',
    {
      'userId': userId,
      'title': title,
      'body': body,
      'type': type,
      'relatedEntityId': relatedEntityId,
      'relatedEntityType': relatedEntityType,
      'data': data,
    },
  );
}

/// Notification Planner Endpoint
///
/// Admin endpoint for managing the AI notification planner.
/// Allows manual cycle triggering, dry runs, status checks,
/// notification history, analytics stats, and runtime config.
/// Also provides admin custom notification sending.
/// {@category Endpoint}
class EndpointNotificationPlanner extends _i2.EndpointRef {
  EndpointNotificationPlanner(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notificationPlanner';

  /// Get current notification planner status
  ///
  /// Returns cycle count, last run, totals, dedup/quiet hour stats, and config.
  _i3.Future<String> getStatus() => caller.callServerEndpoint<String>(
    'notificationPlanner',
    'getStatus',
    {},
  );

  /// Manually trigger a notification planning cycle
  ///
  /// [dryRun] if true, generates the plan but doesn't send FCM notifications.
  /// In-app notifications and ES logs are still created for inspection.
  _i3.Future<String> runCycle({required bool dryRun}) =>
      caller.callServerEndpoint<String>(
        'notificationPlanner',
        'runCycle',
        {'dryRun': dryRun},
      );

  /// Dry run — generates notification plan without sending FCM
  ///
  /// Shows what the AI agent would recommend. Logs to ES with status=planned.
  _i3.Future<String> dryRun() => caller.callServerEndpoint<String>(
    'notificationPlanner',
    'dryRun',
    {},
  );

  /// Get notification history from Elasticsearch
  ///
  /// [limit] max results (default 50)
  /// [type] optional filter by notification type (re_engagement, rating_reminder, etc.)
  /// [status] optional filter by status (planned, sent, delivered, opened, clicked, failed)
  _i3.Future<String> getHistory({
    required int limit,
    String? type,
    String? status,
  }) => caller.callServerEndpoint<String>(
    'notificationPlanner',
    'getHistory',
    {
      'limit': limit,
      'type': type,
      'status': status,
    },
  );

  /// Get aggregated notification stats from Elasticsearch
  ///
  /// Returns breakdowns by type, status, priority + totals for 24h/7d.
  _i3.Future<String> getStats() => caller.callServerEndpoint<String>(
    'notificationPlanner',
    'getStats',
    {},
  );

  /// Update runtime configuration
  ///
  /// [maxPerCycle] max notifications per cycle (default 50)
  /// [cycleIntervalHours] hours between cycles (default 6)
  _i3.Future<String> updateConfig({
    int? maxPerCycle,
    int? cycleIntervalHours,
  }) => caller.callServerEndpoint<String>(
    'notificationPlanner',
    'updateConfig',
    {
      'maxPerCycle': maxPerCycle,
      'cycleIntervalHours': cycleIntervalHours,
    },
  );

  /// Send custom notification from admin to specific users
  ///
  /// [userIds] list of target user IDs (comma-separated string for Serverpod compat)
  /// [title] notification title
  /// [body] notification body text
  /// [priority] optional: high, medium, low (default: medium)
  /// [type] optional: custom, promotion, announcement, system (default: custom)
  _i3.Future<String> sendCustomNotification({
    required String userIds,
    required String title,
    required String body,
    String? priority,
    String? type,
  }) => caller.callServerEndpoint<String>(
    'notificationPlanner',
    'sendCustomNotification',
    {
      'userIds': userIds,
      'title': title,
      'body': body,
      'priority': priority,
      'type': type,
    },
  );

  /// Send broadcast notification to all users or filtered group
  ///
  /// [title] notification title
  /// [body] notification body text
  /// [targetGroup] optional: all, clients, drivers (default: all)
  /// [limit] max users to notify (default: 100, safety cap)
  _i3.Future<String> sendBroadcast({
    required String title,
    required String body,
    String? targetGroup,
    int? limit,
  }) => caller.callServerEndpoint<String>(
    'notificationPlanner',
    'sendBroadcast',
    {
      'title': title,
      'body': body,
      'targetGroup': targetGroup,
      'limit': limit,
    },
  );
}

/// Offer management endpoint
/// Handles driver offers, price negotiation, offer acceptance
/// {@category Endpoint}
class EndpointOffer extends _i2.EndpointRef {
  EndpointOffer(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'offer';

  /// Driver sends an offer on an order
  _i3.Future<_i44.DriverOffer?> sendOffer({
    required int orderId,
    required int driverId,
    required double offeredPrice,
    String? message,
  }) => caller.callServerEndpoint<_i44.DriverOffer?>(
    'offer',
    'sendOffer',
    {
      'orderId': orderId,
      'driverId': driverId,
      'offeredPrice': offeredPrice,
      'message': message,
    },
  );

  /// Counter offer (client or driver adjusts price)
  _i3.Future<_i44.DriverOffer?> counterOffer({
    required int offerId,
    required double newPrice,
    required bool isClient,
  }) => caller.callServerEndpoint<_i44.DriverOffer?>(
    'offer',
    'counterOffer',
    {
      'offerId': offerId,
      'newPrice': newPrice,
      'isClient': isClient,
    },
  );

  /// Accept an offer
  _i3.Future<_i45.Order?> acceptOffer({required int offerId}) =>
      caller.callServerEndpoint<_i45.Order?>(
        'offer',
        'acceptOffer',
        {'offerId': offerId},
      );

  /// Get all offers for an order
  _i3.Future<List<_i44.DriverOffer>> getOffersForOrder({
    required int orderId,
  }) => caller.callServerEndpoint<List<_i44.DriverOffer>>(
    'offer',
    'getOffersForOrder',
    {'orderId': orderId},
  );

  /// Withdraw an offer (driver cancels before client accepts)
  _i3.Future<_i44.DriverOffer?> withdrawOffer({required int offerId}) =>
      caller.callServerEndpoint<_i44.DriverOffer?>(
        'offer',
        'withdrawOffer',
        {'offerId': offerId},
      );
}

/// Order management endpoint
/// Handles order creation, status updates, cancellations
/// {@category Endpoint}
class EndpointOrder extends _i2.EndpointRef {
  EndpointOrder(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'order';

  /// Create a new order with expiry time
  _i3.Future<_i45.Order?> createOrder({
    required int clientId,
    required int serviceId,
    int? pickupAddressId,
    int? dropoffAddressId,
    double? pickupLatitude,
    double? pickupLongitude,
    String? pickupAddress,
    double? dropoffLatitude,
    double? dropoffLongitude,
    String? dropoffAddress,
    double? estimatedDistanceKm,
    double? clientProposedPrice,
    String? notes,
    String? clientInstructions,
    required DateTime expiresAt,
  }) => caller.callServerEndpoint<_i45.Order?>(
    'order',
    'createOrder',
    {
      'clientId': clientId,
      'serviceId': serviceId,
      'pickupAddressId': pickupAddressId,
      'dropoffAddressId': dropoffAddressId,
      'pickupLatitude': pickupLatitude,
      'pickupLongitude': pickupLongitude,
      'pickupAddress': pickupAddress,
      'dropoffLatitude': dropoffLatitude,
      'dropoffLongitude': dropoffLongitude,
      'dropoffAddress': dropoffAddress,
      'estimatedDistanceKm': estimatedDistanceKm,
      'clientProposedPrice': clientProposedPrice,
      'notes': notes,
      'clientInstructions': clientInstructions,
      'expiresAt': expiresAt,
    },
  );

  /// Get active orders for a client
  _i3.Future<List<_i45.Order>> getActiveOrders({required int clientId}) =>
      caller.callServerEndpoint<List<_i45.Order>>(
        'order',
        'getActiveOrders',
        {'clientId': clientId},
      );

  /// Get nearby orders for a driver (broadcast orders)
  _i3.Future<List<_i45.Order>> getNearbyOrders({
    required int driverId,
    required double driverLat,
    required double driverLng,
    required double radiusKm,
  }) => caller.callServerEndpoint<List<_i45.Order>>(
    'order',
    'getNearbyOrders',
    {
      'driverId': driverId,
      'driverLat': driverLat,
      'driverLng': driverLng,
      'radiusKm': radiusKm,
    },
  );

  /// Cancel an order with reason
  _i3.Future<_i45.Order?> cancelOrder({
    required int orderId,
    required int userId,
    required _i46.CancellerType cancelledBy,
    required String cancellationReason,
  }) => caller.callServerEndpoint<_i45.Order?>(
    'order',
    'cancelOrder',
    {
      'orderId': orderId,
      'userId': userId,
      'cancelledBy': cancelledBy,
      'cancellationReason': cancellationReason,
    },
  );

  /// Update order status
  _i3.Future<_i45.Order?> updateOrderStatus({
    required int orderId,
    required _i47.OrderStatus status,
  }) => caller.callServerEndpoint<_i45.Order?>(
    'order',
    'updateOrderStatus',
    {
      'orderId': orderId,
      'status': status,
    },
  );
}

/// Promo Banner Endpoint
/// Handles CRUD operations for promotional banners
/// Admin methods require admin authentication
/// {@category Endpoint}
class EndpointPromo extends _i2.EndpointRef {
  EndpointPromo(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'promo';

  /// Get active promos for a specific user role
  /// Filters by: isActive, date range, and target role
  _i3.Future<List<_i48.Promo>> getActivePromos({required String role}) =>
      caller.callServerEndpoint<List<_i48.Promo>>(
        'promo',
        'getActivePromos',
        {'role': role},
      );

  /// Record a promo view (for analytics)
  _i3.Future<bool> recordView({required int promoId}) =>
      caller.callServerEndpoint<bool>(
        'promo',
        'recordView',
        {'promoId': promoId},
      );

  /// Record a promo click (for analytics)
  _i3.Future<bool> recordClick({required int promoId}) =>
      caller.callServerEndpoint<bool>(
        'promo',
        'recordClick',
        {'promoId': promoId},
      );

  /// Get all promos (admin only)
  _i3.Future<List<_i48.Promo>> getAllPromos() =>
      caller.callServerEndpoint<List<_i48.Promo>>(
        'promo',
        'getAllPromos',
        {},
      );

  /// Get a single promo by ID (admin only)
  _i3.Future<_i48.Promo?> getPromo({required int promoId}) =>
      caller.callServerEndpoint<_i48.Promo?>(
        'promo',
        'getPromo',
        {'promoId': promoId},
      );

  /// Create a new promo (admin only)
  _i3.Future<_i48.Promo?> createPromo({
    required String titleEn,
    String? titleAr,
    String? titleFr,
    String? titleEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    required String imageUrl,
    required String targetRoles,
    required String actionType,
    String? actionValue,
    required int priority,
    required bool isActive,
    DateTime? startDate,
    DateTime? endDate,
    int? createdBy,
  }) => caller.callServerEndpoint<_i48.Promo?>(
    'promo',
    'createPromo',
    {
      'titleEn': titleEn,
      'titleAr': titleAr,
      'titleFr': titleFr,
      'titleEs': titleEs,
      'descriptionEn': descriptionEn,
      'descriptionAr': descriptionAr,
      'descriptionFr': descriptionFr,
      'descriptionEs': descriptionEs,
      'imageUrl': imageUrl,
      'targetRoles': targetRoles,
      'actionType': actionType,
      'actionValue': actionValue,
      'priority': priority,
      'isActive': isActive,
      'startDate': startDate,
      'endDate': endDate,
      'createdBy': createdBy,
    },
  );

  /// Update an existing promo (admin only)
  _i3.Future<_i48.Promo?> updatePromo({
    required int promoId,
    String? titleEn,
    String? titleAr,
    String? titleFr,
    String? titleEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    String? imageUrl,
    String? targetRoles,
    String? actionType,
    String? actionValue,
    int? priority,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
  }) => caller.callServerEndpoint<_i48.Promo?>(
    'promo',
    'updatePromo',
    {
      'promoId': promoId,
      'titleEn': titleEn,
      'titleAr': titleAr,
      'titleFr': titleFr,
      'titleEs': titleEs,
      'descriptionEn': descriptionEn,
      'descriptionAr': descriptionAr,
      'descriptionFr': descriptionFr,
      'descriptionEs': descriptionEs,
      'imageUrl': imageUrl,
      'targetRoles': targetRoles,
      'actionType': actionType,
      'actionValue': actionValue,
      'priority': priority,
      'isActive': isActive,
      'startDate': startDate,
      'endDate': endDate,
    },
  );

  /// Toggle promo active status (admin only)
  _i3.Future<bool> togglePromoStatus({required int promoId}) =>
      caller.callServerEndpoint<bool>(
        'promo',
        'togglePromoStatus',
        {'promoId': promoId},
      );

  /// Delete a promo (admin only)
  _i3.Future<bool> deletePromo({required int promoId}) =>
      caller.callServerEndpoint<bool>(
        'promo',
        'deletePromo',
        {'promoId': promoId},
      );

  /// Get promo analytics (admin only)
  _i3.Future<Map<String, dynamic>> getPromoAnalytics({required int promoId}) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'promo',
        'getPromoAnalytics',
        {'promoId': promoId},
      );
}

/// Endpoint for managing driver proposals/bids
/// {@category Endpoint}
class EndpointProposal extends _i2.EndpointRef {
  EndpointProposal(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'proposal';

  /// Driver submits a proposal for a service request
  /// Can either accept client's price (no proposedPrice) or counter-offer (with proposedPrice)
  _i3.Future<_i49.DriverProposal> submitProposal({
    required int requestId,
    required int driverId,
    double? proposedPrice,
    required int estimatedArrival,
    String? message,
  }) => caller.callServerEndpoint<_i49.DriverProposal>(
    'proposal',
    'submitProposal',
    {
      'requestId': requestId,
      'driverId': driverId,
      'proposedPrice': proposedPrice,
      'estimatedArrival': estimatedArrival,
      'message': message,
    },
  );

  /// Get all proposals for a request (client views available drivers)
  _i3.Future<List<_i49.DriverProposal>> getProposalsForRequest(int requestId) =>
      caller.callServerEndpoint<List<_i49.DriverProposal>>(
        'proposal',
        'getProposalsForRequest',
        {'requestId': requestId},
      );

  /// Client accepts a driver's proposal
  _i3.Future<_i13.ServiceRequest> acceptProposal({
    required int proposalId,
    required int clientId,
  }) => caller.callServerEndpoint<_i13.ServiceRequest>(
    'proposal',
    'acceptProposal',
    {
      'proposalId': proposalId,
      'clientId': clientId,
    },
  );

  /// Client rejects a driver's proposal
  _i3.Future<bool> rejectProposal({
    required int proposalId,
    required int clientId,
  }) => caller.callServerEndpoint<bool>(
    'proposal',
    'rejectProposal',
    {
      'proposalId': proposalId,
      'clientId': clientId,
    },
  );

  /// Driver withdraws their proposal
  _i3.Future<bool> withdrawProposal({
    required int proposalId,
    required int driverId,
  }) => caller.callServerEndpoint<bool>(
    'proposal',
    'withdrawProposal',
    {
      'proposalId': proposalId,
      'driverId': driverId,
    },
  );
}

/// Endpoint for managing ratings and reviews
/// {@category Endpoint}
class EndpointRating extends _i2.EndpointRef {
  EndpointRating(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'rating';

  /// Submit a rating for a service request
  _i3.Future<_i50.Rating> submitRating(
    int userId,
    int requestId,
    int ratedUserId,
    int ratingValue,
    _i51.RatingType ratingType, {
    String? reviewText,
    List<String>? quickTags,
  }) => caller.callServerEndpoint<_i50.Rating>(
    'rating',
    'submitRating',
    {
      'userId': userId,
      'requestId': requestId,
      'ratedUserId': ratedUserId,
      'ratingValue': ratingValue,
      'ratingType': ratingType,
      'reviewText': reviewText,
      'quickTags': quickTags,
    },
  );

  /// Get ratings received by a user
  _i3.Future<List<_i50.Rating>> getUserRatings(
    int userId, {
    _i51.RatingType? ratingType,
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<List<_i50.Rating>>(
    'rating',
    'getUserRatings',
    {
      'userId': userId,
      'ratingType': ratingType,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Get rating statistics for a user
  _i3.Future<Map<String, dynamic>> getUserRatingStats(int userId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'rating',
        'getUserRatingStats',
        {'userId': userId},
      );

  /// Get rating statistics for ratings given by a user (as rater)
  _i3.Future<_i52.RatingStats> getRatingsGivenStats(
    int raterId, {
    _i51.RatingType? ratingType,
  }) => caller.callServerEndpoint<_i52.RatingStats>(
    'rating',
    'getRatingsGivenStats',
    {
      'raterId': raterId,
      'ratingType': ratingType,
    },
  );

  /// Check if user has rated a specific request
  _i3.Future<_i50.Rating?> getRatingForRequest(
    int requestId,
    int raterId,
  ) => caller.callServerEndpoint<_i50.Rating?>(
    'rating',
    'getRatingForRequest',
    {
      'requestId': requestId,
      'raterId': raterId,
    },
  );

  /// Check if request has been rated by both parties
  _i3.Future<Map<String, bool>> getRequestRatingStatus(int requestId) =>
      caller.callServerEndpoint<Map<String, bool>>(
        'rating',
        'getRequestRatingStatus',
        {'requestId': requestId},
      );
}

/// Report management endpoint
/// Handles user reports and admin resolution
/// {@category Endpoint}
class EndpointReport extends _i2.EndpointRef {
  EndpointReport(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'report';

  /// Create a report using user IDs (automatically looks up client/driver profile IDs)
  /// This is the preferred method for Flutter apps
  _i3.Future<_i17.Report?> createReportByUserId({
    required int reportedByUserId,
    required _i53.ReporterType reporterType,
    int? reportedUserIdAsDriver,
    int? reportedUserIdAsClient,
    int? reportedStoreId,
    int? reportedOrderId,
    _i53.ReporterType? reportedType,
    required _i54.ReportReason reportReason,
    required String description,
    List<String>? evidenceUrls,
  }) => caller.callServerEndpoint<_i17.Report?>(
    'report',
    'createReportByUserId',
    {
      'reportedByUserId': reportedByUserId,
      'reporterType': reporterType,
      'reportedUserIdAsDriver': reportedUserIdAsDriver,
      'reportedUserIdAsClient': reportedUserIdAsClient,
      'reportedStoreId': reportedStoreId,
      'reportedOrderId': reportedOrderId,
      'reportedType': reportedType,
      'reportReason': reportReason,
      'description': description,
      'evidenceUrls': evidenceUrls,
    },
  );

  /// Create a report (requires actual profile IDs, not user IDs)
  _i3.Future<_i17.Report?> createReport({
    required int reportedByUserId,
    required _i53.ReporterType reporterType,
    int? reportedDriverId,
    int? reportedClientId,
    int? reportedStoreId,
    int? reportedOrderId,
    _i53.ReporterType? reportedType,
    required _i54.ReportReason reportReason,
    required String description,
    List<String>? evidenceUrls,
  }) => caller.callServerEndpoint<_i17.Report?>(
    'report',
    'createReport',
    {
      'reportedByUserId': reportedByUserId,
      'reporterType': reporterType,
      'reportedDriverId': reportedDriverId,
      'reportedClientId': reportedClientId,
      'reportedStoreId': reportedStoreId,
      'reportedOrderId': reportedOrderId,
      'reportedType': reportedType,
      'reportReason': reportReason,
      'description': description,
      'evidenceUrls': evidenceUrls,
    },
  );

  /// Get all pending reports (for admin)
  _i3.Future<List<_i17.Report>> getPendingReports() =>
      caller.callServerEndpoint<List<_i17.Report>>(
        'report',
        'getPendingReports',
        {},
      );

  /// Get reports for a specific user
  _i3.Future<List<_i17.Report>> getReportsForUser({
    int? driverId,
    int? clientId,
  }) => caller.callServerEndpoint<List<_i17.Report>>(
    'report',
    'getReportsForUser',
    {
      'driverId': driverId,
      'clientId': clientId,
    },
  );

  /// Resolve a report (admin action)
  _i3.Future<_i17.Report?> resolveReport({
    required int reportId,
    required int adminId,
    required _i19.ReportResolution resolution,
    String? adminNotes,
    String? reviewNotes,
  }) => caller.callServerEndpoint<_i17.Report?>(
    'report',
    'resolveReport',
    {
      'reportId': reportId,
      'adminId': adminId,
      'resolution': resolution,
      'adminNotes': adminNotes,
      'reviewNotes': reviewNotes,
    },
  );

  /// Dismiss a report (admin decides it's not valid)
  _i3.Future<_i17.Report?> dismissReport({
    required int reportId,
    required int adminId,
    String? reviewNotes,
  }) => caller.callServerEndpoint<_i17.Report?>(
    'report',
    'dismissReport',
    {
      'reportId': reportId,
      'adminId': adminId,
      'reviewNotes': reviewNotes,
    },
  );
}

/// Endpoint for managing service requests (rides, deliveries, etc.)
/// {@category Endpoint}
class EndpointRequest extends _i2.EndpointRef {
  EndpointRequest(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'request';

  /// Create a new service request
  /// Supports both generic requests and catalog-specific requests (with pre-assigned driver)
  _i3.Future<_i13.ServiceRequest> createRequest(
    int clientId,
    _i55.ServiceType serviceType,
    _i56.Location? pickupLocation,
    _i56.Location destinationLocation,
    String? notes, {
    double? clientOfferedPrice,
    double? estimatedPurchaseCost,
    bool? isPurchaseRequired,
    List<_i57.ShoppingItem>? shoppingList,
    List<String>? attachments,
    int? catalogServiceId,
    int? catalogDriverId,
    String? deviceFingerprint,
  }) => caller.callServerEndpoint<_i13.ServiceRequest>(
    'request',
    'createRequest',
    {
      'clientId': clientId,
      'serviceType': serviceType,
      'pickupLocation': pickupLocation,
      'destinationLocation': destinationLocation,
      'notes': notes,
      'clientOfferedPrice': clientOfferedPrice,
      'estimatedPurchaseCost': estimatedPurchaseCost,
      'isPurchaseRequired': isPurchaseRequired,
      'shoppingList': shoppingList,
      'attachments': attachments,
      'catalogServiceId': catalogServiceId,
      'catalogDriverId': catalogDriverId,
      'deviceFingerprint': deviceFingerprint,
    },
  );

  /// Get a service request by ID
  _i3.Future<_i13.ServiceRequest?> getRequestById(int requestId) =>
      caller.callServerEndpoint<_i13.ServiceRequest?>(
        'request',
        'getRequestById',
        {'requestId': requestId},
      );

  /// Get price suggestion for a route
  /// Helps clients and drivers determine fair pricing
  _i3.Future<Map<String, dynamic>> getPriceSuggestion(
    double pickupLat,
    double pickupLon,
    double destLat,
    double destLon,
    _i55.ServiceType serviceType,
  ) => caller.callServerEndpoint<Map<String, dynamic>>(
    'request',
    'getPriceSuggestion',
    {
      'pickupLat': pickupLat,
      'pickupLon': pickupLon,
      'destLat': destLat,
      'destLon': destLon,
      'serviceType': serviceType,
    },
  );

  /// Get ALL active requests for a client (supports multiple orders)
  _i3.Future<List<_i13.ServiceRequest>> getActiveRequestsForClient(
    int clientId,
  ) => caller.callServerEndpoint<List<_i13.ServiceRequest>>(
    'request',
    'getActiveRequestsForClient',
    {'clientId': clientId},
  );

  /// Get active request for a client (DEPRECATED - returns first one for backwards compatibility)
  @Deprecated('Use getActiveRequestsForClient instead')
  _i3.Future<_i13.ServiceRequest?> getActiveRequestForClient(int clientId) =>
      caller.callServerEndpoint<_i13.ServiceRequest?>(
        'request',
        'getActiveRequestForClient',
        {'clientId': clientId},
      );

  /// Get active request for a driver (returns first one - for backwards compatibility)
  _i3.Future<_i13.ServiceRequest?> getActiveRequestForDriver(int driverId) =>
      caller.callServerEndpoint<_i13.ServiceRequest?>(
        'request',
        'getActiveRequestForDriver',
        {'driverId': driverId},
      );

  /// Get ALL active requests for a driver (supports multiple active deliveries)
  /// Includes driver_proposed so drivers can see requests waiting for client confirmation
  _i3.Future<List<_i13.ServiceRequest>> getActiveRequestsForDriver(
    int driverId,
  ) => caller.callServerEndpoint<List<_i13.ServiceRequest>>(
    'request',
    'getActiveRequestsForDriver',
    {'driverId': driverId},
  );

  /// Get nearby pending requests for a driver
  /// Note: This is a simple implementation. For production, use PostGIS for geospatial queries
  _i3.Future<List<_i13.ServiceRequest>> getNearbyRequests(
    int driverId,
    double driverLat,
    double driverLon, {
    required double radiusKm,
  }) => caller.callServerEndpoint<List<_i13.ServiceRequest>>(
    'request',
    'getNearbyRequests',
    {
      'driverId': driverId,
      'driverLat': driverLat,
      'driverLon': driverLon,
      'radiusKm': radiusKm,
    },
  );

  /// Accept a request (driver accepts)
  /// Drivers can have multiple active deliveries (up to maxActiveRequests)
  _i3.Future<_i13.ServiceRequest?> acceptRequest(
    int requestId,
    int driverId,
  ) => caller.callServerEndpoint<_i13.ServiceRequest?>(
    'request',
    'acceptRequest',
    {
      'requestId': requestId,
      'driverId': driverId,
    },
  );

  /// Client approves proposed driver
  _i3.Future<_i13.ServiceRequest?> approveDriver(
    int requestId,
    int clientId,
  ) => caller.callServerEndpoint<_i13.ServiceRequest?>(
    'request',
    'approveDriver',
    {
      'requestId': requestId,
      'clientId': clientId,
    },
  );

  /// Client rejects proposed driver
  _i3.Future<_i13.ServiceRequest?> rejectDriver(
    int requestId,
    int clientId,
  ) => caller.callServerEndpoint<_i13.ServiceRequest?>(
    'request',
    'rejectDriver',
    {
      'requestId': requestId,
      'clientId': clientId,
    },
  );

  /// Update request status (with validation)
  _i3.Future<_i13.ServiceRequest?> updateRequestStatus(
    int requestId,
    _i14.RequestStatus newStatus,
    int userId,
  ) => caller.callServerEndpoint<_i13.ServiceRequest?>(
    'request',
    'updateRequestStatus',
    {
      'requestId': requestId,
      'newStatus': newStatus,
      'userId': userId,
    },
  );

  /// Cancel a request
  _i3.Future<_i13.ServiceRequest?> cancelRequest(
    int requestId,
    int userId,
    String reason,
  ) => caller.callServerEndpoint<_i13.ServiceRequest?>(
    'request',
    'cancelRequest',
    {
      'requestId': requestId,
      'userId': userId,
      'reason': reason,
    },
  );

  /// Get request history for a client
  _i3.Future<List<_i13.ServiceRequest>> getClientRequestHistory(
    int clientId, {
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i13.ServiceRequest>>(
    'request',
    'getClientRequestHistory',
    {
      'clientId': clientId,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Get request history for a driver
  _i3.Future<List<_i13.ServiceRequest>> getDriverRequestHistory(
    int driverId, {
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i13.ServiceRequest>>(
    'request',
    'getDriverRequestHistory',
    {
      'driverId': driverId,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Get ALL pending service requests (no distance filter)
  /// FOR TESTING ONLY - In production, use getNearbyRequests with distance filter
  /// Returns all pending requests that don't have an assigned driver yet
  _i3.Future<List<_i13.ServiceRequest>> getAllPendingRequests() =>
      caller.callServerEndpoint<List<_i13.ServiceRequest>>(
        'request',
        'getAllPendingRequests',
        {},
      );

  /// Get all pending catalog requests assigned to a driver
  /// Catalog requests are requests created specifically for this driver via service catalog
  /// These are NOT filtered by distance - driver should see all requests assigned to them
  ///
  /// NOTE: This accepts USER ID (not driver profile ID) and looks up the driver profile
  _i3.Future<List<_i13.ServiceRequest>> getCatalogRequests(int userId) =>
      caller.callServerEndpoint<List<_i13.ServiceRequest>>(
        'request',
        'getCatalogRequests',
        {'userId': userId},
      );
}

/// Review management endpoint
/// Handles driver reviews of clients (two-way rating)
/// {@category Endpoint}
class EndpointReview extends _i2.EndpointRef {
  EndpointReview(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'review';

  /// Driver rates a client after order completion
  _i3.Future<_i58.ClientReview?> createClientReview({
    required int orderId,
    required int driverId,
    required int clientId,
    required int rating,
    String? comment,
    int? communicationRating,
    int? respectRating,
    int? paymentPromptness,
  }) => caller.callServerEndpoint<_i58.ClientReview?>(
    'review',
    'createClientReview',
    {
      'orderId': orderId,
      'driverId': driverId,
      'clientId': clientId,
      'rating': rating,
      'comment': comment,
      'communicationRating': communicationRating,
      'respectRating': respectRating,
      'paymentPromptness': paymentPromptness,
    },
  );

  /// Get all reviews for a client
  _i3.Future<List<_i58.ClientReview>> getClientReviews({
    required int clientId,
    int? limit,
  }) => caller.callServerEndpoint<List<_i58.ClientReview>>(
    'review',
    'getClientReviews',
    {
      'clientId': clientId,
      'limit': limit,
    },
  );

  /// Get reviews by a driver
  _i3.Future<List<_i58.ClientReview>> getReviewsByDriver({
    required int driverId,
  }) => caller.callServerEndpoint<List<_i58.ClientReview>>(
    'review',
    'getReviewsByDriver',
    {'driverId': driverId},
  );

  /// Create driver review (client rates driver)
  /// This uses the existing Review table
  _i3.Future<_i59.Review?> createDriverReview({
    required int orderId,
    required int clientId,
    required int driverId,
    required int rating,
    String? comment,
  }) => caller.callServerEndpoint<_i59.Review?>(
    'review',
    'createDriverReview',
    {
      'orderId': orderId,
      'clientId': clientId,
      'driverId': driverId,
      'rating': rating,
      'comment': comment,
    },
  );

  /// Get all driver reviews (clients rating drivers)
  _i3.Future<List<_i59.Review>> getDriverReviews({
    required int driverId,
    int? limit,
  }) => caller.callServerEndpoint<List<_i59.Review>>(
    'review',
    'getDriverReviews',
    {
      'driverId': driverId,
      'limit': limit,
    },
  );

  /// Recalculate and persist a driver's rating from reviews
  _i3.Future<bool> recalcDriverRating({required int driverId}) =>
      caller.callServerEndpoint<bool>(
        'review',
        'recalcDriverRating',
        {'driverId': driverId},
      );
}

/// Search endpoint for Awhar
/// Provides search functionality across all content types using Elasticsearch
///
/// Note: All methods return JSON strings to ensure proper serialization.
/// Parse the JSON on the client side.
/// {@category Endpoint}
class EndpointSearch extends _i2.EndpointRef {
  EndpointSearch(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'search';

  /// Search for drivers near a location
  /// Returns drivers sorted by distance with optional filters
  /// Returns JSON string - parse on client
  _i3.Future<String> searchDriversNearby({
    required double lat,
    required double lon,
    double? radiusKm,
    bool? isOnline,
    bool? isVerified,
    bool? isPremium,
    int? categoryId,
    double? minRating,
    int? from,
    int? size,
  }) => caller.callServerEndpoint<String>(
    'search',
    'searchDriversNearby',
    {
      'lat': lat,
      'lon': lon,
      'radiusKm': radiusKm,
      'isOnline': isOnline,
      'isVerified': isVerified,
      'isPremium': isPremium,
      'categoryId': categoryId,
      'minRating': minRating,
      'from': from,
      'size': size,
    },
  );

  /// Search drivers by text query
  _i3.Future<String> searchDriversByText({
    required String query,
    bool? isOnline,
    bool? isVerified,
    String? vehicleType,
    double? minRating,
    int? from,
    int? size,
  }) => caller.callServerEndpoint<String>(
    'search',
    'searchDriversByText',
    {
      'query': query,
      'isOnline': isOnline,
      'isVerified': isVerified,
      'vehicleType': vehicleType,
      'minRating': minRating,
      'from': from,
      'size': size,
    },
  );

  /// Get top rated drivers
  _i3.Future<String> getTopRatedDrivers({
    int? categoryId,
    int? minCompletedOrders,
    int? from,
    int? size,
  }) => caller.callServerEndpoint<String>(
    'search',
    'getTopRatedDrivers',
    {
      'categoryId': categoryId,
      'minCompletedOrders': minCompletedOrders,
      'from': from,
      'size': size,
    },
  );

  /// Search services with multi-language support
  _i3.Future<String> searchServices({
    required String query,
    String? language,
    int? categoryId,
    bool? isActive,
    int? from,
    int? size,
  }) => caller.callServerEndpoint<String>(
    'search',
    'searchServices',
    {
      'query': query,
      'language': language,
      'categoryId': categoryId,
      'isActive': isActive,
      'from': from,
      'size': size,
    },
  );

  /// Get popular services
  _i3.Future<String> getPopularServices({
    int? categoryId,
    int? from,
    int? size,
  }) => caller.callServerEndpoint<String>(
    'search',
    'getPopularServices',
    {
      'categoryId': categoryId,
      'from': from,
      'size': size,
    },
  );

  /// Search driver services with location and filters
  _i3.Future<String> searchDriverServices({
    String? query,
    double? lat,
    double? lon,
    double? radiusKm,
    int? categoryId,
    int? serviceId,
    double? minPrice,
    double? maxPrice,
    bool? isAvailable,
    bool? driverIsOnline,
    String? sortBy,
    int? from,
    int? size,
  }) => caller.callServerEndpoint<String>(
    'search',
    'searchDriverServices',
    {
      'query': query,
      'lat': lat,
      'lon': lon,
      'radiusKm': radiusKm,
      'categoryId': categoryId,
      'serviceId': serviceId,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'isAvailable': isAvailable,
      'driverIsOnline': driverIsOnline,
      'sortBy': sortBy,
      'from': from,
      'size': size,
    },
  );

  /// Get similar driver services
  _i3.Future<String> getSimilarDriverServices({
    required int driverServiceId,
    int? size,
  }) => caller.callServerEndpoint<String>(
    'search',
    'getSimilarDriverServices',
    {
      'driverServiceId': driverServiceId,
      'size': size,
    },
  );

  /// Search stores near a location
  _i3.Future<String> searchStoresNearby({
    required double lat,
    required double lon,
    double? radiusKm,
    String? query,
    int? categoryId,
    bool? isOpen,
    double? minRating,
    int? from,
    int? size,
  }) => caller.callServerEndpoint<String>(
    'search',
    'searchStoresNearby',
    {
      'lat': lat,
      'lon': lon,
      'radiusKm': radiusKm,
      'query': query,
      'categoryId': categoryId,
      'isOpen': isOpen,
      'minRating': minRating,
      'from': from,
      'size': size,
    },
  );

  /// Search products within a store
  _i3.Future<String> searchProductsInStore({
    required int storeId,
    String? query,
    int? categoryId,
    bool? isAvailable,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    int? from,
    int? size,
  }) => caller.callServerEndpoint<String>(
    'search',
    'searchProductsInStore',
    {
      'storeId': storeId,
      'query': query,
      'categoryId': categoryId,
      'isAvailable': isAvailable,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'sortBy': sortBy,
      'from': from,
      'size': size,
    },
  );

  /// Search products across all stores near a location
  _i3.Future<String> searchProductsNearby({
    required String query,
    required double lat,
    required double lon,
    double? radiusKm,
    bool? isAvailable,
    int? from,
    int? size,
  }) => caller.callServerEndpoint<String>(
    'search',
    'searchProductsNearby',
    {
      'query': query,
      'lat': lat,
      'lon': lon,
      'radiusKm': radiusKm,
      'isAvailable': isAvailable,
      'from': from,
      'size': size,
    },
  );

  /// Get search suggestions as user types
  /// Returns JSON string - parse on client
  _i3.Future<String> getSearchSuggestions({
    required String prefix,
    String? type,
    int? size,
  }) => caller.callServerEndpoint<String>(
    'search',
    'getSearchSuggestions',
    {
      'prefix': prefix,
      'type': type,
      'size': size,
    },
  );

  /// Get popular searches
  /// Returns JSON string - parse on client
  _i3.Future<String> getPopularSearches({
    String? searchType,
    int? size,
  }) => caller.callServerEndpoint<String>(
    'search',
    'getPopularSearches',
    {
      'searchType': searchType,
      'size': size,
    },
  );

  /// Get service categories with counts
  /// Returns JSON string - parse on client
  _i3.Future<String> getServiceCategoryCounts() =>
      caller.callServerEndpoint<String>(
        'search',
        'getServiceCategoryCounts',
        {},
      );

  /// Get driver service price statistics
  /// Returns JSON string - parse on client
  _i3.Future<String> getDriverServicePriceStats({int? categoryId}) =>
      caller.callServerEndpoint<String>(
        'search',
        'getDriverServicePriceStats',
        {'categoryId': categoryId},
      );

  /// Unified search across multiple content types
  /// Great for search bar functionality
  _i3.Future<String> unifiedSearch({
    required String query,
    double? lat,
    double? lon,
    double? radiusKm,
    List<String>? types,
    int? size,
  }) => caller.callServerEndpoint<String>(
    'search',
    'unifiedSearch',
    {
      'query': query,
      'lat': lat,
      'lon': lon,
      'radiusKm': radiusKm,
      'types': types,
      'size': size,
    },
  );

  /// Smart semantic search across all content types.
  /// Uses ELSER + BM25 hybrid ranking (RRF) to understand user intent.
  /// Returns grouped results: services, stores, products, knowledge.
  /// Returns JSON string - parse on client.
  _i3.Future<String> smartSearch({
    required String query,
    String? language,
    double? lat,
    double? lon,
    double? radiusKm,
    List<String>? types,
    int? sizePerType,
  }) => caller.callServerEndpoint<String>(
    'search',
    'smartSearch',
    {
      'query': query,
      'language': language,
      'lat': lat,
      'lon': lon,
      'radiusKm': radiusKm,
      'types': types,
      'sizePerType': sizePerType,
    },
  );

  /// Search the knowledge base for FAQ/help content.
  /// Uses pure ELSER semantic search for intent matching.
  /// Returns JSON string - parse on client.
  _i3.Future<String> searchKnowledgeBase({
    required String query,
    String? category,
    String? language,
    int? size,
  }) => caller.callServerEndpoint<String>(
    'search',
    'searchKnowledgeBase',
    {
      'query': query,
      'category': category,
      'language': language,
      'size': size,
    },
  );
}

/// Service management endpoint
/// Handles service categories, driver catalog browsing
/// {@category Endpoint}
class EndpointService extends _i2.EndpointRef {
  EndpointService(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'service';

  /// Get all service categories
  _i3.Future<List<_i60.ServiceCategory>> getCategories({
    required bool activeOnly,
  }) => caller.callServerEndpoint<List<_i60.ServiceCategory>>(
    'service',
    'getCategories',
    {'activeOnly': activeOnly},
  );

  /// Get all services by category
  _i3.Future<List<_i61.Service>> getServicesByCategory({
    required int categoryId,
    required bool activeOnly,
  }) => caller.callServerEndpoint<List<_i61.Service>>(
    'service',
    'getServicesByCategory',
    {
      'categoryId': categoryId,
      'activeOnly': activeOnly,
    },
  );

  /// Get drivers offering a specific service category
  _i3.Future<List<_i9.DriverProfile>> getDriversByCategory({
    required int categoryId,
    double? clientLat,
    double? clientLng,
    double? radiusKm,
    required bool onlineOnly,
  }) => caller.callServerEndpoint<List<_i9.DriverProfile>>(
    'service',
    'getDriversByCategory',
    {
      'categoryId': categoryId,
      'clientLat': clientLat,
      'clientLng': clientLng,
      'radiusKm': radiusKm,
      'onlineOnly': onlineOnly,
    },
  );

  /// Get drivers offering a specific service
  _i3.Future<List<_i9.DriverProfile>> getDriversByService({
    required int serviceId,
    double? clientLat,
    double? clientLng,
    double? radiusKm,
    required bool onlineOnly,
  }) => caller.callServerEndpoint<List<_i9.DriverProfile>>(
    'service',
    'getDriversByService',
    {
      'serviceId': serviceId,
      'clientLat': clientLat,
      'clientLng': clientLng,
      'radiusKm': radiusKm,
      'onlineOnly': onlineOnly,
    },
  );

  /// Create a service category (admin only)
  _i3.Future<_i60.ServiceCategory?> createCategory({
    required String name,
    required String nameAr,
    required String nameFr,
    String? nameEs,
    required String icon,
    String? description,
    required int displayOrder,
    required double defaultRadiusKm,
  }) => caller.callServerEndpoint<_i60.ServiceCategory?>(
    'service',
    'createCategory',
    {
      'name': name,
      'nameAr': nameAr,
      'nameFr': nameFr,
      'nameEs': nameEs,
      'icon': icon,
      'description': description,
      'displayOrder': displayOrder,
      'defaultRadiusKm': defaultRadiusKm,
    },
  );

  /// Update a service category (admin only)
  _i3.Future<_i60.ServiceCategory?> updateCategory({
    required int categoryId,
    String? name,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? icon,
    String? description,
    int? displayOrder,
    double? defaultRadiusKm,
    bool? isActive,
  }) => caller.callServerEndpoint<_i60.ServiceCategory?>(
    'service',
    'updateCategory',
    {
      'categoryId': categoryId,
      'name': name,
      'nameAr': nameAr,
      'nameFr': nameFr,
      'nameEs': nameEs,
      'icon': icon,
      'description': description,
      'displayOrder': displayOrder,
      'defaultRadiusKm': defaultRadiusKm,
      'isActive': isActive,
    },
  );

  /// Advanced search for drivers with services and filters
  _i3.Future<List<_i9.DriverProfile>> searchDriversWithServices({
    int? categoryId,
    int? serviceId,
    required double clientLat,
    required double clientLng,
    required double radiusKm,
    double? priceMin,
    double? priceMax,
    double? minRating,
    required bool onlineOnly,
    required int limit,
  }) => caller.callServerEndpoint<List<_i9.DriverProfile>>(
    'service',
    'searchDriversWithServices',
    {
      'categoryId': categoryId,
      'serviceId': serviceId,
      'clientLat': clientLat,
      'clientLng': clientLng,
      'radiusKm': radiusKm,
      'priceMin': priceMin,
      'priceMax': priceMax,
      'minRating': minRating,
      'onlineOnly': onlineOnly,
      'limit': limit,
    },
  );

  /// Get driver's complete catalog with images
  _i3.Future<List<_i38.DriverService>> getDriverCatalog({
    required int driverId,
    required bool activeOnly,
  }) => caller.callServerEndpoint<List<_i38.DriverService>>(
    'service',
    'getDriverCatalog',
    {
      'driverId': driverId,
      'activeOnly': activeOnly,
    },
  );

  /// Track service view for analytics
  _i3.Future<bool> trackServiceView({required int driverServiceId}) =>
      caller.callServerEndpoint<bool>(
        'service',
        'trackServiceView',
        {'driverServiceId': driverServiceId},
      );

  /// Track service inquiry
  _i3.Future<bool> trackServiceInquiry({required int driverServiceId}) =>
      caller.callServerEndpoint<bool>(
        'service',
        'trackServiceInquiry',
        {'driverServiceId': driverServiceId},
      );

  /// Track service booking
  _i3.Future<bool> trackServiceBooking({required int driverServiceId}) =>
      caller.callServerEndpoint<bool>(
        'service',
        'trackServiceBooking',
        {'driverServiceId': driverServiceId},
      );

  /// Get service analytics
  _i3.Future<_i62.ServiceAnalytics?> getServiceAnalytics({
    required int driverServiceId,
  }) => caller.callServerEndpoint<_i62.ServiceAnalytics?>(
    'service',
    'getServiceAnalytics',
    {'driverServiceId': driverServiceId},
  );

  /// Toggle favorite status for a driver
  /// Returns true if favorited, false if unfavorited
  _i3.Future<bool> toggleFavorite({
    required int clientId,
    required int driverId,
  }) => caller.callServerEndpoint<bool>(
    'service',
    'toggleFavorite',
    {
      'clientId': clientId,
      'driverId': driverId,
    },
  );

  /// Get all favorited drivers for a client
  _i3.Future<List<_i9.DriverProfile>> getFavoriteDrivers({
    required int clientId,
  }) => caller.callServerEndpoint<List<_i9.DriverProfile>>(
    'service',
    'getFavoriteDrivers',
    {'clientId': clientId},
  );

  /// Check if a driver is favorited by client
  _i3.Future<bool> isFavorite({
    required int clientId,
    required int driverId,
  }) => caller.callServerEndpoint<bool>(
    'service',
    'isFavorite',
    {
      'clientId': clientId,
      'driverId': driverId,
    },
  );

  /// Get favorite driver IDs for a client (batch check)
  _i3.Future<List<int>> getFavoriteDriverIds({required int clientId}) =>
      caller.callServerEndpoint<List<int>>(
        'service',
        'getFavoriteDriverIds',
        {'clientId': clientId},
      );
}

/// Endpoint for managing system settings
/// These settings are configurable from the admin dashboard
/// {@category Endpoint}
class EndpointSettings extends _i2.EndpointRef {
  EndpointSettings(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'settings';

  /// Get a single setting by key
  _i3.Future<String?> getSetting(String key) =>
      caller.callServerEndpoint<String?>(
        'settings',
        'getSetting',
        {'key': key},
      );

  /// Get multiple settings by keys
  _i3.Future<Map<String, String>> getSettings(List<String> keys) =>
      caller.callServerEndpoint<Map<String, String>>(
        'settings',
        'getSettings',
        {'keys': keys},
      );

  /// Get all settings (for admin dashboard or app initialization)
  _i3.Future<Map<String, String>> getAllSettings() =>
      caller.callServerEndpoint<Map<String, String>>(
        'settings',
        'getAllSettings',
        {},
      );

  /// Set a setting value (admin only)
  _i3.Future<bool> setSetting({
    required String key,
    required String value,
    String? description,
  }) => caller.callServerEndpoint<bool>(
    'settings',
    'setSetting',
    {
      'key': key,
      'value': value,
      'description': description,
    },
  );

  /// Set multiple settings at once (admin only)
  _i3.Future<bool> setSettings(Map<String, String> settings) =>
      caller.callServerEndpoint<bool>(
        'settings',
        'setSettings',
        {'settings': settings},
      );

  /// Delete a setting (admin only)
  _i3.Future<bool> deleteSetting(String key) => caller.callServerEndpoint<bool>(
    'settings',
    'deleteSetting',
    {'key': key},
  );

  /// Get app configuration (public settings for mobile app)
  /// This returns a structured JSON with all public settings
  _i3.Future<_i63.AppConfiguration> getAppConfiguration() =>
      caller.callServerEndpoint<_i63.AppConfiguration>(
        'settings',
        'getAppConfiguration',
        {},
      );

  /// Initialize default settings if they don't exist
  _i3.Future<void> initializeDefaultSettings() =>
      caller.callServerEndpoint<void>(
        'settings',
        'initializeDefaultSettings',
        {},
      );
}

/// Store Delivery Endpoint
/// Handles driver assignment, delivery flow, and 3-way coordination
/// All methods requiring userId take it as a parameter (decoded from token on client-side)
/// {@category Endpoint}
class EndpointStoreDelivery extends _i2.EndpointRef {
  EndpointStoreDelivery(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'storeDelivery';

  /// Get nearby online drivers for store to request delivery
  /// Returns NearbyDriver list with distance info
  /// MVP Mode: Shows nearby drivers first, then up to 3 additional online drivers
  _i3.Future<List<_i64.NearbyDriver>> getNearbyDrivers({
    required int storeId,
    required int orderId,
    required double radiusKm,
  }) => caller.callServerEndpoint<List<_i64.NearbyDriver>>(
    'storeDelivery',
    'getNearbyDrivers',
    {
      'storeId': storeId,
      'orderId': orderId,
      'radiusKm': radiusKm,
    },
  );

  /// Store requests a specific driver directly
  _i3.Future<_i65.StoreDeliveryRequest?> requestDriver({
    required int storeId,
    required int orderId,
    required int driverId,
  }) => caller.callServerEndpoint<_i65.StoreDeliveryRequest?>(
    'storeDelivery',
    'requestDriver',
    {
      'storeId': storeId,
      'orderId': orderId,
      'driverId': driverId,
    },
  );

  /// Store posts a public delivery request (all nearby drivers can see)
  _i3.Future<_i65.StoreDeliveryRequest?> postDeliveryRequest({
    required int storeId,
    required int orderId,
  }) => caller.callServerEndpoint<_i65.StoreDeliveryRequest?>(
    'storeDelivery',
    'postDeliveryRequest',
    {
      'storeId': storeId,
      'orderId': orderId,
    },
  );

  /// Get available store delivery requests for driver
  _i3.Future<List<_i65.StoreDeliveryRequest>> getStoreDeliveryRequests({
    required int driverId,
    required double latitude,
    required double longitude,
    required double radiusKm,
  }) => caller.callServerEndpoint<List<_i65.StoreDeliveryRequest>>(
    'storeDelivery',
    'getStoreDeliveryRequests',
    {
      'driverId': driverId,
      'latitude': latitude,
      'longitude': longitude,
      'radiusKm': radiusKm,
    },
  );

  /// Driver accepts a store delivery request
  _i3.Future<_i11.StoreOrder?> acceptStoreDelivery({
    required int driverId,
    required int requestId,
  }) => caller.callServerEndpoint<_i11.StoreOrder?>(
    'storeDelivery',
    'acceptStoreDelivery',
    {
      'driverId': driverId,
      'requestId': requestId,
    },
  );

  /// Driver rejects a store delivery request
  _i3.Future<bool> rejectStoreDelivery({
    required int driverId,
    required int requestId,
    String? reason,
  }) => caller.callServerEndpoint<bool>(
    'storeDelivery',
    'rejectStoreDelivery',
    {
      'driverId': driverId,
      'requestId': requestId,
      'reason': reason,
    },
  );

  /// Driver arrived at store for pickup
  _i3.Future<_i11.StoreOrder?> arrivedAtStore({
    required int driverId,
    required int orderId,
  }) => caller.callServerEndpoint<_i11.StoreOrder?>(
    'storeDelivery',
    'arrivedAtStore',
    {
      'driverId': driverId,
      'orderId': orderId,
    },
  );

  /// Driver picked up order from store (and paid store)
  _i3.Future<_i11.StoreOrder?> pickedUp({
    required int driverId,
    required int orderId,
    required double amountPaidToStore,
  }) => caller.callServerEndpoint<_i11.StoreOrder?>(
    'storeDelivery',
    'pickedUp',
    {
      'driverId': driverId,
      'orderId': orderId,
      'amountPaidToStore': amountPaidToStore,
    },
  );

  /// Driver arrived at client location
  _i3.Future<_i11.StoreOrder?> arrivedAtClient({
    required int driverId,
    required int orderId,
  }) => caller.callServerEndpoint<_i11.StoreOrder?>(
    'storeDelivery',
    'arrivedAtClient',
    {
      'driverId': driverId,
      'orderId': orderId,
    },
  );

  /// Driver delivered order and collected cash
  _i3.Future<_i11.StoreOrder?> delivered({
    required int driverId,
    required int orderId,
    required double amountCollected,
  }) => caller.callServerEndpoint<_i11.StoreOrder?>(
    'storeDelivery',
    'delivered',
    {
      'driverId': driverId,
      'orderId': orderId,
      'amountCollected': amountCollected,
    },
  );

  /// Create 3-way chat channel when driver is assigned
  _i3.Future<int?> createOrderChat({
    required int orderId,
    required int clientId,
    required int storeId,
    required int driverId,
  }) => caller.callServerEndpoint<int?>(
    'storeDelivery',
    'createOrderChat',
    {
      'orderId': orderId,
      'clientId': clientId,
      'storeId': storeId,
      'driverId': driverId,
    },
  );

  /// Get or create store order chat (called when any party opens chat)
  _i3.Future<_i66.StoreOrderChat?> getOrCreateOrderChat({
    required int orderId,
  }) => caller.callServerEndpoint<_i66.StoreOrderChat?>(
    'storeDelivery',
    'getOrCreateOrderChat',
    {'orderId': orderId},
  );

  /// Send message to store order chat
  _i3.Future<_i67.StoreOrderChatMessage?> sendChatMessage({
    required int orderId,
    required int senderId,
    required String senderRole,
    required String senderName,
    required String content,
    required String messageType,
    String? attachmentUrl,
    double? latitude,
    double? longitude,
  }) => caller.callServerEndpoint<_i67.StoreOrderChatMessage?>(
    'storeDelivery',
    'sendChatMessage',
    {
      'orderId': orderId,
      'senderId': senderId,
      'senderRole': senderRole,
      'senderName': senderName,
      'content': content,
      'messageType': messageType,
      'attachmentUrl': attachmentUrl,
      'latitude': latitude,
      'longitude': longitude,
    },
  );

  /// Get chat messages for order
  _i3.Future<List<_i67.StoreOrderChatMessage>> getChatMessages({
    required int orderId,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i67.StoreOrderChatMessage>>(
    'storeDelivery',
    'getChatMessages',
    {
      'orderId': orderId,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Get chat participants info (names) for order
  _i3.Future<_i68.ChatParticipantsInfo?> getChatParticipantsInfo({
    required int orderId,
  }) => caller.callServerEndpoint<_i68.ChatParticipantsInfo?>(
    'storeDelivery',
    'getChatParticipantsInfo',
    {'orderId': orderId},
  );

  /// Add driver to existing chat when assigned
  _i3.Future<bool> addDriverToChat({
    required int orderId,
    required int driverId,
  }) => caller.callServerEndpoint<bool>(
    'storeDelivery',
    'addDriverToChat',
    {
      'orderId': orderId,
      'driverId': driverId,
    },
  );

  /// Get driver's active store deliveries
  _i3.Future<List<_i11.StoreOrder>> getDriverStoreOrders({
    required int driverId,
    required bool activeOnly,
  }) => caller.callServerEndpoint<List<_i11.StoreOrder>>(
    'storeDelivery',
    'getDriverStoreOrders',
    {
      'driverId': driverId,
      'activeOnly': activeOnly,
    },
  );

  /// Get request status for an order
  _i3.Future<_i65.StoreDeliveryRequest?> getOrderDeliveryRequest({
    required int orderId,
  }) => caller.callServerEndpoint<_i65.StoreDeliveryRequest?>(
    'storeDelivery',
    'getOrderDeliveryRequest',
    {'orderId': orderId},
  );
}

/// Store management endpoint
/// Handles store registration, profile, and browsing
/// All methods requiring userId take it as a parameter (decoded from token on client-side)
/// {@category Endpoint}
class EndpointStore extends _i2.EndpointRef {
  EndpointStore(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'store';

  /// Get all store categories
  _i3.Future<List<_i69.StoreCategory>> getStoreCategories() =>
      caller.callServerEndpoint<List<_i69.StoreCategory>>(
        'store',
        'getStoreCategories',
        {},
      );

  /// Get store category by ID
  _i3.Future<_i69.StoreCategory?> getStoreCategoryById(int categoryId) =>
      caller.callServerEndpoint<_i69.StoreCategory?>(
        'store',
        'getStoreCategoryById',
        {'categoryId': categoryId},
      );

  /// Create a new store (registration)
  _i3.Future<_i10.Store?> createStore({
    required int userId,
    required int storeCategoryId,
    required String name,
    String? description,
    required String phone,
    String? email,
    required String address,
    required double latitude,
    required double longitude,
    String? city,
    double? deliveryRadiusKm,
  }) => caller.callServerEndpoint<_i10.Store?>(
    'store',
    'createStore',
    {
      'userId': userId,
      'storeCategoryId': storeCategoryId,
      'name': name,
      'description': description,
      'phone': phone,
      'email': email,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      'deliveryRadiusKm': deliveryRadiusKm,
    },
  );

  /// Get the current user's store
  _i3.Future<_i10.Store?> getMyStore({required int userId}) =>
      caller.callServerEndpoint<_i10.Store?>(
        'store',
        'getMyStore',
        {'userId': userId},
      );

  /// Get store by ID
  _i3.Future<_i10.Store?> getStoreById(int storeId) =>
      caller.callServerEndpoint<_i10.Store?>(
        'store',
        'getStoreById',
        {'storeId': storeId},
      );

  /// Get store by user ID
  _i3.Future<_i10.Store?> getStoreByUserId(int userId) =>
      caller.callServerEndpoint<_i10.Store?>(
        'store',
        'getStoreByUserId',
        {'userId': userId},
      );

  /// Update store profile
  _i3.Future<_i10.Store?> updateStore({
    required int userId,
    required int storeId,
    String? name,
    String? description,
    String? phone,
    String? email,
    String? address,
    double? latitude,
    double? longitude,
    String? city,
    double? deliveryRadiusKm,
    double? minimumOrderAmount,
    int? estimatedPrepTimeMinutes,
  }) => caller.callServerEndpoint<_i10.Store?>(
    'store',
    'updateStore',
    {
      'userId': userId,
      'storeId': storeId,
      'name': name,
      'description': description,
      'phone': phone,
      'email': email,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      'deliveryRadiusKm': deliveryRadiusKm,
      'minimumOrderAmount': minimumOrderAmount,
      'estimatedPrepTimeMinutes': estimatedPrepTimeMinutes,
    },
  );

  /// Update store logo
  _i3.Future<_i10.Store?> updateStoreLogo({
    required int userId,
    required int storeId,
    required String logoUrl,
  }) => caller.callServerEndpoint<_i10.Store?>(
    'store',
    'updateStoreLogo',
    {
      'userId': userId,
      'storeId': storeId,
      'logoUrl': logoUrl,
    },
  );

  /// Update store cover image
  _i3.Future<_i10.Store?> updateStoreCoverImage({
    required int userId,
    required int storeId,
    required String coverImageUrl,
  }) => caller.callServerEndpoint<_i10.Store?>(
    'store',
    'updateStoreCoverImage',
    {
      'userId': userId,
      'storeId': storeId,
      'coverImageUrl': coverImageUrl,
    },
  );

  /// Set working hours (JSON format)
  _i3.Future<_i10.Store?> setWorkingHours({
    required int userId,
    required int storeId,
    required String workingHoursJson,
  }) => caller.callServerEndpoint<_i10.Store?>(
    'store',
    'setWorkingHours',
    {
      'userId': userId,
      'storeId': storeId,
      'workingHoursJson': workingHoursJson,
    },
  );

  /// Update store extended profile (about, tagline, social links)
  _i3.Future<_i10.Store?> updateStoreExtendedProfile({
    required int userId,
    required int storeId,
    String? aboutText,
    String? tagline,
    String? whatsappNumber,
    String? websiteUrl,
    String? facebookUrl,
    String? instagramUrl,
    bool? acceptsCash,
    bool? acceptsCard,
    bool? hasDelivery,
    bool? hasPickup,
  }) => caller.callServerEndpoint<_i10.Store?>(
    'store',
    'updateStoreExtendedProfile',
    {
      'userId': userId,
      'storeId': storeId,
      'aboutText': aboutText,
      'tagline': tagline,
      'whatsappNumber': whatsappNumber,
      'websiteUrl': websiteUrl,
      'facebookUrl': facebookUrl,
      'instagramUrl': instagramUrl,
      'acceptsCash': acceptsCash,
      'acceptsCard': acceptsCard,
      'hasDelivery': hasDelivery,
      'hasPickup': hasPickup,
    },
  );

  /// Update store gallery images
  _i3.Future<_i10.Store?> updateStoreGallery({
    required int userId,
    required int storeId,
    required List<String> imageUrls,
  }) => caller.callServerEndpoint<_i10.Store?>(
    'store',
    'updateStoreGallery',
    {
      'userId': userId,
      'storeId': storeId,
      'imageUrls': imageUrls,
    },
  );

  /// Add image to store gallery
  _i3.Future<_i10.Store?> addGalleryImage({
    required int userId,
    required int storeId,
    required String imageUrl,
  }) => caller.callServerEndpoint<_i10.Store?>(
    'store',
    'addGalleryImage',
    {
      'userId': userId,
      'storeId': storeId,
      'imageUrl': imageUrl,
    },
  );

  /// Remove image from store gallery
  _i3.Future<_i10.Store?> removeGalleryImage({
    required int userId,
    required int storeId,
    required String imageUrl,
  }) => caller.callServerEndpoint<_i10.Store?>(
    'store',
    'removeGalleryImage',
    {
      'userId': userId,
      'storeId': storeId,
      'imageUrl': imageUrl,
    },
  );

  /// Toggle store open/closed status
  _i3.Future<_i10.Store?> toggleStoreOpen({
    required int userId,
    required int storeId,
    required bool isOpen,
  }) => caller.callServerEndpoint<_i10.Store?>(
    'store',
    'toggleStoreOpen',
    {
      'userId': userId,
      'storeId': storeId,
      'isOpen': isOpen,
    },
  );

  /// Toggle store active/inactive (for admin or owner)
  _i3.Future<_i10.Store?> toggleStoreActive({
    required int userId,
    required int storeId,
    required bool isActive,
  }) => caller.callServerEndpoint<_i10.Store?>(
    'store',
    'toggleStoreActive',
    {
      'userId': userId,
      'storeId': storeId,
      'isActive': isActive,
    },
  );

  /// Get nearby stores
  _i3.Future<List<_i10.Store>> getNearbyStores({
    required double latitude,
    required double longitude,
    double? radiusKm,
    int? categoryId,
    required bool openOnly,
  }) => caller.callServerEndpoint<List<_i10.Store>>(
    'store',
    'getNearbyStores',
    {
      'latitude': latitude,
      'longitude': longitude,
      'radiusKm': radiusKm,
      'categoryId': categoryId,
      'openOnly': openOnly,
    },
  );

  /// Get stores by category
  _i3.Future<List<_i10.Store>> getStoresByCategory({
    required int categoryId,
    double? latitude,
    double? longitude,
    required bool openOnly,
  }) => caller.callServerEndpoint<List<_i10.Store>>(
    'store',
    'getStoresByCategory',
    {
      'categoryId': categoryId,
      'latitude': latitude,
      'longitude': longitude,
      'openOnly': openOnly,
    },
  );

  /// Search stores by name
  _i3.Future<List<_i10.Store>> searchStores({
    required String query,
    double? latitude,
    double? longitude,
    int? categoryId,
  }) => caller.callServerEndpoint<List<_i10.Store>>(
    'store',
    'searchStores',
    {
      'query': query,
      'latitude': latitude,
      'longitude': longitude,
      'categoryId': categoryId,
    },
  );

  /// Check if client location is within store's delivery zone
  _i3.Future<bool> isWithinDeliveryZone({
    required int storeId,
    required double clientLatitude,
    required double clientLongitude,
  }) => caller.callServerEndpoint<bool>(
    'store',
    'isWithinDeliveryZone',
    {
      'storeId': storeId,
      'clientLatitude': clientLatitude,
      'clientLongitude': clientLongitude,
    },
  );
}

/// Store Order management endpoint
/// Handles order placement, tracking, and management
/// All methods requiring userId take it as a parameter (decoded from token on client-side)
/// {@category Endpoint}
class EndpointStoreOrder extends _i2.EndpointRef {
  EndpointStoreOrder(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'storeOrder';

  /// Create a new order (client places order)
  _i3.Future<_i11.StoreOrder?> createOrder({
    required int clientId,
    required int storeId,
    required List<_i70.OrderItem> items,
    required String deliveryAddress,
    required double deliveryLatitude,
    required double deliveryLongitude,
    String? clientNotes,
  }) => caller.callServerEndpoint<_i11.StoreOrder?>(
    'storeOrder',
    'createOrder',
    {
      'clientId': clientId,
      'storeId': storeId,
      'items': items,
      'deliveryAddress': deliveryAddress,
      'deliveryLatitude': deliveryLatitude,
      'deliveryLongitude': deliveryLongitude,
      'clientNotes': clientNotes,
    },
  );

  /// Get order by ID
  _i3.Future<_i11.StoreOrder?> getOrder(int orderId) =>
      caller.callServerEndpoint<_i11.StoreOrder?>(
        'storeOrder',
        'getOrder',
        {'orderId': orderId},
      );

  /// Get order by order number
  _i3.Future<_i11.StoreOrder?> getOrderByNumber(String orderNumber) =>
      caller.callServerEndpoint<_i11.StoreOrder?>(
        'storeOrder',
        'getOrderByNumber',
        {'orderNumber': orderNumber},
      );

  /// Get client's orders
  _i3.Future<List<_i11.StoreOrder>> getClientOrders({
    required int clientId,
    _i12.StoreOrderStatus? status,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i11.StoreOrder>>(
    'storeOrder',
    'getClientOrders',
    {
      'clientId': clientId,
      'status': status,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Get client's active orders (not delivered or cancelled)
  _i3.Future<List<_i11.StoreOrder>> getClientActiveOrders({
    required int clientId,
  }) => caller.callServerEndpoint<List<_i11.StoreOrder>>(
    'storeOrder',
    'getClientActiveOrders',
    {'clientId': clientId},
  );

  /// Cancel order (client can cancel before store confirms)
  _i3.Future<_i11.StoreOrder?> cancelOrder({
    required int clientId,
    required int orderId,
    required String reason,
  }) => caller.callServerEndpoint<_i11.StoreOrder?>(
    'storeOrder',
    'cancelOrder',
    {
      'clientId': clientId,
      'orderId': orderId,
      'reason': reason,
    },
  );

  /// Get store's orders
  _i3.Future<List<_i11.StoreOrder>> getStoreOrders({
    required int userId,
    required int storeId,
    _i12.StoreOrderStatus? status,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i11.StoreOrder>>(
    'storeOrder',
    'getStoreOrders',
    {
      'userId': userId,
      'storeId': storeId,
      'status': status,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Get store's pending orders
  _i3.Future<List<_i11.StoreOrder>> getStorePendingOrders({
    required int userId,
    required int storeId,
  }) => caller.callServerEndpoint<List<_i11.StoreOrder>>(
    'storeOrder',
    'getStorePendingOrders',
    {
      'userId': userId,
      'storeId': storeId,
    },
  );

  /// Confirm order (store accepts)
  _i3.Future<_i11.StoreOrder?> confirmOrder({
    required int userId,
    required int orderId,
    String? storeNotes,
  }) => caller.callServerEndpoint<_i11.StoreOrder?>(
    'storeOrder',
    'confirmOrder',
    {
      'userId': userId,
      'orderId': orderId,
      'storeNotes': storeNotes,
    },
  );

  /// Reject order (store declines)
  _i3.Future<_i11.StoreOrder?> rejectOrder({
    required int userId,
    required int orderId,
    required String reason,
  }) => caller.callServerEndpoint<_i11.StoreOrder?>(
    'storeOrder',
    'rejectOrder',
    {
      'userId': userId,
      'orderId': orderId,
      'reason': reason,
    },
  );

  /// Mark order as preparing
  _i3.Future<_i11.StoreOrder?> markPreparing({
    required int userId,
    required int orderId,
  }) => caller.callServerEndpoint<_i11.StoreOrder?>(
    'storeOrder',
    'markPreparing',
    {
      'userId': userId,
      'orderId': orderId,
    },
  );

  /// Mark order as ready for pickup
  _i3.Future<_i11.StoreOrder?> markReady({
    required int userId,
    required int orderId,
  }) => caller.callServerEndpoint<_i11.StoreOrder?>(
    'storeOrder',
    'markReady',
    {
      'userId': userId,
      'orderId': orderId,
    },
  );

  /// Assign driver to order
  _i3.Future<_i11.StoreOrder?> assignDriver({
    required int userId,
    required int orderId,
    required int driverId,
  }) => caller.callServerEndpoint<_i11.StoreOrder?>(
    'storeOrder',
    'assignDriver',
    {
      'userId': userId,
      'orderId': orderId,
      'driverId': driverId,
    },
  );

  /// Driver marks arrived at store
  _i3.Future<_i11.StoreOrder?> driverArrivedAtStore({
    required int driverId,
    required int orderId,
  }) => caller.callServerEndpoint<_i11.StoreOrder?>(
    'storeOrder',
    'driverArrivedAtStore',
    {
      'driverId': driverId,
      'orderId': orderId,
    },
  );

  /// Driver picks up order
  _i3.Future<_i11.StoreOrder?> driverPickedUp({
    required int driverId,
    required int orderId,
  }) => caller.callServerEndpoint<_i11.StoreOrder?>(
    'storeOrder',
    'driverPickedUp',
    {
      'driverId': driverId,
      'orderId': orderId,
    },
  );

  /// Driver in delivery
  _i3.Future<_i11.StoreOrder?> driverInDelivery({
    required int driverId,
    required int orderId,
  }) => caller.callServerEndpoint<_i11.StoreOrder?>(
    'storeOrder',
    'driverInDelivery',
    {
      'driverId': driverId,
      'orderId': orderId,
    },
  );

  /// Driver delivers order
  _i3.Future<_i11.StoreOrder?> driverDelivered({
    required int driverId,
    required int orderId,
  }) => caller.callServerEndpoint<_i11.StoreOrder?>(
    'storeOrder',
    'driverDelivered',
    {
      'driverId': driverId,
      'orderId': orderId,
    },
  );

  /// Get driver's store delivery orders
  _i3.Future<List<_i11.StoreOrder>> getDriverStoreOrders({
    required int driverId,
    required bool activeOnly,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i11.StoreOrder>>(
    'storeOrder',
    'getDriverStoreOrders',
    {
      'driverId': driverId,
      'activeOnly': activeOnly,
      'limit': limit,
      'offset': offset,
    },
  );
}

/// Store Product management endpoint
/// Handles products and product categories for stores
/// All methods requiring userId take it as a parameter (decoded from token on client-side)
/// {@category Endpoint}
class EndpointStoreProduct extends _i2.EndpointRef {
  EndpointStoreProduct(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'storeProduct';

  /// Create a product category
  _i3.Future<_i71.ProductCategory?> createProductCategory({
    required int userId,
    required int storeId,
    required String name,
    String? imageUrl,
    int? displayOrder,
  }) => caller.callServerEndpoint<_i71.ProductCategory?>(
    'storeProduct',
    'createProductCategory',
    {
      'userId': userId,
      'storeId': storeId,
      'name': name,
      'imageUrl': imageUrl,
      'displayOrder': displayOrder,
    },
  );

  /// Get product categories for a store
  _i3.Future<List<_i71.ProductCategory>> getProductCategories({
    required int storeId,
    required bool activeOnly,
  }) => caller.callServerEndpoint<List<_i71.ProductCategory>>(
    'storeProduct',
    'getProductCategories',
    {
      'storeId': storeId,
      'activeOnly': activeOnly,
    },
  );

  /// Update a product category
  _i3.Future<_i71.ProductCategory?> updateProductCategory({
    required int userId,
    required int categoryId,
    String? name,
    String? imageUrl,
    int? displayOrder,
  }) => caller.callServerEndpoint<_i71.ProductCategory?>(
    'storeProduct',
    'updateProductCategory',
    {
      'userId': userId,
      'categoryId': categoryId,
      'name': name,
      'imageUrl': imageUrl,
      'displayOrder': displayOrder,
    },
  );

  /// Toggle category active status
  _i3.Future<_i71.ProductCategory?> toggleCategoryActive({
    required int userId,
    required int categoryId,
    required bool isActive,
  }) => caller.callServerEndpoint<_i71.ProductCategory?>(
    'storeProduct',
    'toggleCategoryActive',
    {
      'userId': userId,
      'categoryId': categoryId,
      'isActive': isActive,
    },
  );

  /// Delete a product category (soft delete by setting inactive)
  _i3.Future<bool> deleteProductCategory({
    required int userId,
    required int categoryId,
  }) => caller.callServerEndpoint<bool>(
    'storeProduct',
    'deleteProductCategory',
    {
      'userId': userId,
      'categoryId': categoryId,
    },
  );

  /// Add a new product
  _i3.Future<_i72.StoreProduct?> addProduct({
    required int userId,
    required int storeId,
    int? productCategoryId,
    required String name,
    String? description,
    required double price,
    String? imageUrl,
    int? displayOrder,
  }) => caller.callServerEndpoint<_i72.StoreProduct?>(
    'storeProduct',
    'addProduct',
    {
      'userId': userId,
      'storeId': storeId,
      'productCategoryId': productCategoryId,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'displayOrder': displayOrder,
    },
  );

  /// Get products for a store
  _i3.Future<List<_i72.StoreProduct>> getProducts({
    required int storeId,
    int? categoryId,
    required bool availableOnly,
  }) => caller.callServerEndpoint<List<_i72.StoreProduct>>(
    'storeProduct',
    'getProducts',
    {
      'storeId': storeId,
      'categoryId': categoryId,
      'availableOnly': availableOnly,
    },
  );

  /// Get product by ID
  _i3.Future<_i72.StoreProduct?> getProductById(int productId) =>
      caller.callServerEndpoint<_i72.StoreProduct?>(
        'storeProduct',
        'getProductById',
        {'productId': productId},
      );

  /// Update a product
  _i3.Future<_i72.StoreProduct?> updateProduct({
    required int userId,
    required int productId,
    int? productCategoryId,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    int? displayOrder,
  }) => caller.callServerEndpoint<_i72.StoreProduct?>(
    'storeProduct',
    'updateProduct',
    {
      'userId': userId,
      'productId': productId,
      'productCategoryId': productCategoryId,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'displayOrder': displayOrder,
    },
  );

  /// Toggle product availability
  _i3.Future<_i72.StoreProduct?> toggleProductAvailability({
    required int userId,
    required int productId,
    required bool isAvailable,
  }) => caller.callServerEndpoint<_i72.StoreProduct?>(
    'storeProduct',
    'toggleProductAvailability',
    {
      'userId': userId,
      'productId': productId,
      'isAvailable': isAvailable,
    },
  );

  /// Delete a product (soft delete)
  _i3.Future<bool> deleteProduct({
    required int userId,
    required int productId,
  }) => caller.callServerEndpoint<bool>(
    'storeProduct',
    'deleteProduct',
    {
      'userId': userId,
      'productId': productId,
    },
  );

  /// Reorder products
  _i3.Future<bool> reorderProducts({
    required int userId,
    required int storeId,
    required List<int> productIds,
  }) => caller.callServerEndpoint<bool>(
    'storeProduct',
    'reorderProducts',
    {
      'userId': userId,
      'storeId': storeId,
      'productIds': productIds,
    },
  );

  /// Search products within a store
  _i3.Future<List<_i72.StoreProduct>> searchProducts({
    required int storeId,
    required String query,
  }) => caller.callServerEndpoint<List<_i72.StoreProduct>>(
    'storeProduct',
    'searchProducts',
    {
      'storeId': storeId,
      'query': query,
    },
  );
}

/// Store Review Endpoint
/// Handles reviews for store orders (clients review stores and drivers)
/// {@category Endpoint}
class EndpointStoreReview extends _i2.EndpointRef {
  EndpointStoreReview(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'storeReview';

  /// Create a review for a store order
  /// [revieweeType] should be 'store' or 'driver'
  _i3.Future<_i73.StoreReview?> createStoreReview({
    required int orderId,
    required int storeId,
    required int clientId,
    required int rating,
    String? comment,
    int? foodQualityRating,
    int? packagingRating,
  }) => caller.callServerEndpoint<_i73.StoreReview?>(
    'storeReview',
    'createStoreReview',
    {
      'orderId': orderId,
      'storeId': storeId,
      'clientId': clientId,
      'rating': rating,
      'comment': comment,
      'foodQualityRating': foodQualityRating,
      'packagingRating': packagingRating,
    },
  );

  /// Create a driver review for a store order
  _i3.Future<_i73.StoreReview?> createDriverReviewForStoreOrder({
    required int orderId,
    required int driverId,
    required int clientId,
    required int rating,
    String? comment,
  }) => caller.callServerEndpoint<_i73.StoreReview?>(
    'storeReview',
    'createDriverReviewForStoreOrder',
    {
      'orderId': orderId,
      'driverId': driverId,
      'clientId': clientId,
      'rating': rating,
      'comment': comment,
    },
  );

  /// Get reviews for a store
  _i3.Future<List<_i73.StoreReview>> getStoreReviews({
    required int storeId,
    int? limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i73.StoreReview>>(
    'storeReview',
    'getStoreReviews',
    {
      'storeId': storeId,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Get reviews for a driver on store orders
  _i3.Future<List<_i73.StoreReview>> getDriverStoreReviews({
    required int driverId,
    int? limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i73.StoreReview>>(
    'storeReview',
    'getDriverStoreReviews',
    {
      'driverId': driverId,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Get reviews for any reviewee (store, driver, or client) with reviewer info
  _i3.Future<List<_i74.ReviewWithReviewer>> getReviewsForReviewee({
    required String revieweeType,
    required int revieweeId,
    int? limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i74.ReviewWithReviewer>>(
    'storeReview',
    'getReviewsForReviewee',
    {
      'revieweeType': revieweeType,
      'revieweeId': revieweeId,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Get all reviews by a client
  _i3.Future<List<_i73.StoreReview>> getReviewsByClient({
    required int clientId,
    int? limit,
  }) => caller.callServerEndpoint<List<_i73.StoreReview>>(
    'storeReview',
    'getReviewsByClient',
    {
      'clientId': clientId,
      'limit': limit,
    },
  );

  /// Store owner responds to a review
  _i3.Future<_i73.StoreReview?> respondToReview({
    required int reviewId,
    required int storeId,
    required String response,
  }) => caller.callServerEndpoint<_i73.StoreReview?>(
    'storeReview',
    'respondToReview',
    {
      'reviewId': reviewId,
      'storeId': storeId,
      'response': response,
    },
  );

  /// Get average rating for a store
  _i3.Future<Map<String, dynamic>> getStoreRatingStats({
    required int storeId,
  }) => caller.callServerEndpoint<Map<String, dynamic>>(
    'storeReview',
    'getStoreRatingStats',
    {'storeId': storeId},
  );
}

/// Transaction endpoint for managing payments and earnings (cash only for MVP)
/// {@category Endpoint}
class EndpointTransaction extends _i2.EndpointRef {
  EndpointTransaction(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'transaction';

  /// Get current platform commission rate
  _i3.Future<double> getPlatformCommissionRate() =>
      caller.callServerEndpoint<double>(
        'transaction',
        'getPlatformCommissionRate',
        {},
      );

  /// Set platform commission rate (for admin use)
  _i3.Future<void> setPlatformCommissionRate(double rate) =>
      caller.callServerEndpoint<void>(
        'transaction',
        'setPlatformCommissionRate',
        {'rate': rate},
      );

  /// Create a cash payment transaction when client pays driver
  _i3.Future<_i15.Transaction> recordCashPayment(
    int requestId,
    int clientId,
    int driverId,
    double amount, {
    String? notes,
  }) => caller.callServerEndpoint<_i15.Transaction>(
    'transaction',
    'recordCashPayment',
    {
      'requestId': requestId,
      'clientId': clientId,
      'driverId': driverId,
      'amount': amount,
      'notes': notes,
    },
  );

  /// Get user transaction history
  _i3.Future<List<_i15.Transaction>> getTransactionHistory(
    int userId, {
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<List<_i15.Transaction>>(
    'transaction',
    'getTransactionHistory',
    {
      'userId': userId,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Get driver earnings statistics
  _i3.Future<_i75.DriverEarningsResponse> getDriverEarnings(
    int driverId, {
    DateTime? startDate,
    DateTime? endDate,
  }) => caller.callServerEndpoint<_i75.DriverEarningsResponse>(
    'transaction',
    'getDriverEarnings',
    {
      'driverId': driverId,
      'startDate': startDate,
      'endDate': endDate,
    },
  );

  /// Get wallet for user (creates if doesn't exist)
  _i3.Future<_i76.Wallet> getWallet(int userId) =>
      caller.callServerEndpoint<_i76.Wallet>(
        'transaction',
        'getWallet',
        {'userId': userId},
      );

  /// Confirm cash payment received (called by driver after ride completion)
  /// Confirm cash payment (driver side - creates/updates pending transaction)
  _i3.Future<_i15.Transaction> confirmCashPayment(
    int requestId,
    int driverId, {
    String? notes,
  }) => caller.callServerEndpoint<_i15.Transaction>(
    'transaction',
    'confirmCashPayment',
    {
      'requestId': requestId,
      'driverId': driverId,
      'notes': notes,
    },
  );

  /// Confirm cash payment (client side - creates/updates pending transaction)
  _i3.Future<_i15.Transaction> confirmCashPaymentByClient(
    int requestId,
    int clientId, {
    String? notes,
  }) => caller.callServerEndpoint<_i15.Transaction>(
    'transaction',
    'confirmCashPaymentByClient',
    {
      'requestId': requestId,
      'clientId': clientId,
      'notes': notes,
    },
  );
}

/// Trust Score Endpoint
///
/// Provides API access to the Trust Score system which combines:
/// - Kibana `awhar-fraud` agent (AI-powered analysis)
/// - Server-side computation (PostgreSQL fallback)
///
/// Used by:
/// - Drivers viewing incoming requests (quick badge display)
/// - Client profile screens (detailed trust breakdown)
/// - Admin dashboard (platform-wide trust overview)
/// {@category Endpoint}
class EndpointTrustScore extends _i2.EndpointRef {
  EndpointTrustScore(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'trustScore';

  /// Get the trust score for a client.
  ///
  /// Returns a full [TrustScoreResult] with score, level, metrics.
  /// Uses cached score if fresh (< 6 hours), otherwise recomputes.
  ///
  /// Called by drivers when viewing a request to see client trust badge.
  _i3.Future<_i77.TrustScoreResult> getClientTrustScore(int clientId) =>
      caller.callServerEndpoint<_i77.TrustScoreResult>(
        'trustScore',
        'getClientTrustScore',
        {'clientId': clientId},
      );

  /// Get a quick trust badge for display purposes.
  ///
  /// Returns minimal data (score + level) optimized for fast display.
  /// Never calls the Kibana agent — uses cache or PostgreSQL only.
  _i3.Future<_i77.TrustScoreResult> getQuickTrustBadge(int clientId) =>
      caller.callServerEndpoint<_i77.TrustScoreResult>(
        'trustScore',
        'getQuickTrustBadge',
        {'clientId': clientId},
      );

  /// Force refresh the trust score for a client.
  ///
  /// Calls the Kibana fraud agent for a fresh computation.
  /// Used by admins or after significant events (order completion, cancellation).
  _i3.Future<_i77.TrustScoreResult> refreshTrustScore(int clientId) =>
      caller.callServerEndpoint<_i77.TrustScoreResult>(
        'trustScore',
        'refreshTrustScore',
        {'clientId': clientId},
      );

  /// Batch compute trust scores for multiple clients.
  ///
  /// Used by the admin dashboard and daily fraud scan workflow.
  /// Returns a map of clientId → TrustScoreResult.
  _i3.Future<List<_i77.TrustScoreResult>> batchComputeTrustScores(
    List<int> clientIds,
  ) => caller.callServerEndpoint<List<_i77.TrustScoreResult>>(
    'trustScore',
    'batchComputeTrustScores',
    {'clientIds': clientIds},
  );

  /// Get platform-wide trust statistics.
  ///
  /// Returns aggregated trust data for the admin dashboard.
  _i3.Future<Map<String, dynamic>> getPlatformTrustStats() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'trustScore',
        'getPlatformTrustStats',
        {},
      );
}

/// User management endpoint
/// Handles profile updates, photo uploads, account management
/// All methods require userId to be passed from the decoded token on client-side
/// {@category Endpoint}
class EndpointUser extends _i2.EndpointRef {
  EndpointUser(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  /// Update user profile
  _i3.Future<_i78.UserResponse> updateProfile({
    required int userId,
    String? fullName,
    String? email,
    String? phoneNumber,
    _i79.Language? preferredLanguage,
    bool? notificationsEnabled,
    bool? darkModeEnabled,
  }) => caller.callServerEndpoint<_i78.UserResponse>(
    'user',
    'updateProfile',
    {
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'preferredLanguage': preferredLanguage,
      'notificationsEnabled': notificationsEnabled,
      'darkModeEnabled': darkModeEnabled,
    },
  );

  /// Update FCM token for push notifications
  _i3.Future<bool> updateFCMToken({
    required int userId,
    required String fcmToken,
  }) => caller.callServerEndpoint<bool>(
    'user',
    'updateFCMToken',
    {
      'userId': userId,
      'fcmToken': fcmToken,
    },
  );

  /// Clear FCM token on logout - removes token from user record
  /// This prevents the old user from receiving notifications after logout
  _i3.Future<bool> clearFCMToken({required int userId}) =>
      caller.callServerEndpoint<bool>(
        'user',
        'clearFCMToken',
        {'userId': userId},
      );

  /// Fix photo URLs - replace 0.0.0.0 with proper IP
  _i3.Future<_i78.UserResponse> fixPhotoUrls({required int userId}) =>
      caller.callServerEndpoint<_i78.UserResponse>(
        'user',
        'fixPhotoUrls',
        {'userId': userId},
      );

  /// Upload profile photo
  _i3.Future<_i78.UserResponse> uploadProfilePhoto({
    required int userId,
    required _i39.ByteData photoData,
    required String fileName,
  }) => caller.callServerEndpoint<_i78.UserResponse>(
    'user',
    'uploadProfilePhoto',
    {
      'userId': userId,
      'photoData': photoData,
      'fileName': fileName,
    },
  );

  /// Delete user account permanently
  /// Required for Google Play and Apple App Store compliance
  /// This performs a soft delete (sets deletedAt) and anonymizes personal data
  _i3.Future<_i78.UserResponse> deleteAccount({
    required int userId,
    String? reason,
  }) => caller.callServerEndpoint<_i78.UserResponse>(
    'user',
    'deleteAccount',
    {
      'userId': userId,
      'reason': reason,
    },
  );

  /// Get user by ID
  _i3.Future<_i78.UserResponse> getUserById({required int userId}) =>
      caller.callServerEndpoint<_i78.UserResponse>(
        'user',
        'getUserById',
        {'userId': userId},
      );

  /// Add role to user (e.g., become a driver)
  _i3.Future<_i78.UserResponse> addRole({
    required int userId,
    required _i30.UserRole role,
  }) => caller.callServerEndpoint<_i78.UserResponse>(
    'user',
    'addRole',
    {
      'userId': userId,
      'role': role,
    },
  );

  /// Remove role from user
  _i3.Future<_i78.UserResponse> removeRole({
    required int userId,
    required _i30.UserRole role,
  }) => caller.callServerEndpoint<_i78.UserResponse>(
    'user',
    'removeRole',
    {
      'userId': userId,
      'role': role,
    },
  );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i2.EndpointRef {
  EndpointGreeting(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i3.Future<_i80.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i80.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i1.Caller(client);
    serverpod_auth_core = _i4.Caller(client);
  }

  late final _i1.Caller serverpod_auth_idp;

  late final _i4.Caller serverpod_auth_core;
}

class Client extends _i2.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i2.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i2.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i81.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    admin = EndpointAdmin(this);
    agent = EndpointAgent(this);
    analytics = EndpointAnalytics(this);
    firebaseAuth = EndpointFirebaseAuth(this);
    blockedUser = EndpointBlockedUser(this);
    chat = EndpointChat(this);
    country = EndpointCountry(this);
    deviceFingerprint = EndpointDeviceFingerprint(this);
    driver = EndpointDriver(this);
    driverStatus = EndpointDriverStatus(this);
    elasticsearch = EndpointElasticsearch(this);
    email = EndpointEmail(this);
    refreshJwtTokens = EndpointRefreshJwtTokens(this);
    location = EndpointLocation(this);
    mcpProxy = EndpointMcpProxy(this);
    media = EndpointMedia(this);
    notification = EndpointNotification(this);
    notificationPlanner = EndpointNotificationPlanner(this);
    offer = EndpointOffer(this);
    order = EndpointOrder(this);
    promo = EndpointPromo(this);
    proposal = EndpointProposal(this);
    rating = EndpointRating(this);
    report = EndpointReport(this);
    request = EndpointRequest(this);
    review = EndpointReview(this);
    search = EndpointSearch(this);
    service = EndpointService(this);
    settings = EndpointSettings(this);
    storeDelivery = EndpointStoreDelivery(this);
    store = EndpointStore(this);
    storeOrder = EndpointStoreOrder(this);
    storeProduct = EndpointStoreProduct(this);
    storeReview = EndpointStoreReview(this);
    transaction = EndpointTransaction(this);
    trustScore = EndpointTrustScore(this);
    user = EndpointUser(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointAdmin admin;

  late final EndpointAgent agent;

  late final EndpointAnalytics analytics;

  late final EndpointFirebaseAuth firebaseAuth;

  late final EndpointBlockedUser blockedUser;

  late final EndpointChat chat;

  late final EndpointCountry country;

  late final EndpointDeviceFingerprint deviceFingerprint;

  late final EndpointDriver driver;

  late final EndpointDriverStatus driverStatus;

  late final EndpointElasticsearch elasticsearch;

  late final EndpointEmail email;

  late final EndpointRefreshJwtTokens refreshJwtTokens;

  late final EndpointLocation location;

  late final EndpointMcpProxy mcpProxy;

  late final EndpointMedia media;

  late final EndpointNotification notification;

  late final EndpointNotificationPlanner notificationPlanner;

  late final EndpointOffer offer;

  late final EndpointOrder order;

  late final EndpointPromo promo;

  late final EndpointProposal proposal;

  late final EndpointRating rating;

  late final EndpointReport report;

  late final EndpointRequest request;

  late final EndpointReview review;

  late final EndpointSearch search;

  late final EndpointService service;

  late final EndpointSettings settings;

  late final EndpointStoreDelivery storeDelivery;

  late final EndpointStore store;

  late final EndpointStoreOrder storeOrder;

  late final EndpointStoreProduct storeProduct;

  late final EndpointStoreReview storeReview;

  late final EndpointTransaction transaction;

  late final EndpointTrustScore trustScore;

  late final EndpointUser user;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'admin': admin,
    'agent': agent,
    'analytics': analytics,
    'firebaseAuth': firebaseAuth,
    'blockedUser': blockedUser,
    'chat': chat,
    'country': country,
    'deviceFingerprint': deviceFingerprint,
    'driver': driver,
    'driverStatus': driverStatus,
    'elasticsearch': elasticsearch,
    'email': email,
    'refreshJwtTokens': refreshJwtTokens,
    'location': location,
    'mcpProxy': mcpProxy,
    'media': media,
    'notification': notification,
    'notificationPlanner': notificationPlanner,
    'offer': offer,
    'order': order,
    'promo': promo,
    'proposal': proposal,
    'rating': rating,
    'report': report,
    'request': request,
    'review': review,
    'search': search,
    'service': service,
    'settings': settings,
    'storeDelivery': storeDelivery,
    'store': store,
    'storeOrder': storeOrder,
    'storeProduct': storeProduct,
    'storeReview': storeReview,
    'transaction': transaction,
    'trustScore': trustScore,
    'user': user,
    'greeting': greeting,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
