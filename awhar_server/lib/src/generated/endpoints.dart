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
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../endpoints/admin_endpoint.dart' as _i4;
import '../endpoints/agent_endpoint.dart' as _i5;
import '../endpoints/analytics_endpoint.dart' as _i6;
import '../endpoints/auth_endpoint.dart' as _i7;
import '../endpoints/blocked_user_endpoint.dart' as _i8;
import '../endpoints/chat_endpoint.dart' as _i9;
import '../endpoints/country_endpoint.dart' as _i10;
import '../endpoints/device_fingerprint_endpoint.dart' as _i11;
import '../endpoints/driver_endpoint.dart' as _i12;
import '../endpoints/driver_status_endpoint.dart' as _i13;
import '../endpoints/elasticsearch_endpoint.dart' as _i14;
import '../endpoints/email_endpoint.dart' as _i15;
import '../endpoints/jwt_refresh_endpoint.dart' as _i16;
import '../endpoints/location_endpoint.dart' as _i17;
import '../endpoints/mcp_proxy_endpoint.dart' as _i18;
import '../endpoints/media_endpoint.dart' as _i19;
import '../endpoints/notification_endpoint.dart' as _i20;
import '../endpoints/notification_planner_endpoint.dart' as _i21;
import '../endpoints/offer_endpoint.dart' as _i22;
import '../endpoints/order_endpoint.dart' as _i23;
import '../endpoints/promo_endpoint.dart' as _i24;
import '../endpoints/proposal_endpoint.dart' as _i25;
import '../endpoints/rating_endpoint.dart' as _i26;
import '../endpoints/report_endpoint.dart' as _i27;
import '../endpoints/request_endpoint.dart' as _i28;
import '../endpoints/review_endpoint.dart' as _i29;
import '../endpoints/search_endpoint.dart' as _i30;
import '../endpoints/service_endpoint.dart' as _i31;
import '../endpoints/settings_endpoint.dart' as _i32;
import '../endpoints/store_delivery_endpoint.dart' as _i33;
import '../endpoints/store_endpoint.dart' as _i34;
import '../endpoints/store_order_endpoint.dart' as _i35;
import '../endpoints/store_product_endpoint.dart' as _i36;
import '../endpoints/store_review_endpoint.dart' as _i37;
import '../endpoints/transaction_endpoint.dart' as _i38;
import '../endpoints/trust_score_endpoint.dart' as _i39;
import '../endpoints/user_endpoint.dart' as _i40;
import '../greetings/greeting_endpoint.dart' as _i41;
import 'package:awhar_server/src/generated/store_order_status_enum.dart'
    as _i42;
import 'package:awhar_server/src/generated/request_status.dart' as _i43;
import 'package:awhar_server/src/generated/transaction_status.dart' as _i44;
import 'package:awhar_server/src/generated/report_status_enum.dart' as _i45;
import 'package:awhar_server/src/generated/report_resolution_enum.dart' as _i46;
import 'package:awhar_server/src/generated/user_role_enum.dart' as _i47;
import 'package:awhar_server/src/generated/message_type_enum.dart' as _i48;
import 'package:awhar_server/src/generated/country.dart' as _i49;
import 'package:awhar_server/src/generated/device_fingerprint_input.dart'
    as _i50;
import 'dart:typed_data' as _i51;
import 'package:awhar_server/src/generated/notification_type.dart' as _i52;
import 'package:awhar_server/src/generated/canceller_type_enum.dart' as _i53;
import 'package:awhar_server/src/generated/order_status_enum.dart' as _i54;
import 'package:awhar_server/src/generated/rating_type_enum.dart' as _i55;
import 'package:awhar_server/src/generated/reporter_type_enum.dart' as _i56;
import 'package:awhar_server/src/generated/report_reason_enum.dart' as _i57;
import 'package:awhar_server/src/generated/service_type.dart' as _i58;
import 'package:awhar_server/src/generated/location.dart' as _i59;
import 'package:awhar_server/src/generated/shopping_item.dart' as _i60;
import 'package:awhar_server/src/generated/order_item.dart' as _i61;
import 'package:awhar_server/src/generated/language_enum.dart' as _i62;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i63;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i64;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'admin': _i4.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'agent': _i5.AgentEndpoint()
        ..initialize(
          server,
          'agent',
          null,
        ),
      'analytics': _i6.AnalyticsEndpoint()
        ..initialize(
          server,
          'analytics',
          null,
        ),
      'firebaseAuth': _i7.FirebaseAuthEndpoint()
        ..initialize(
          server,
          'firebaseAuth',
          null,
        ),
      'blockedUser': _i8.BlockedUserEndpoint()
        ..initialize(
          server,
          'blockedUser',
          null,
        ),
      'chat': _i9.ChatEndpoint()
        ..initialize(
          server,
          'chat',
          null,
        ),
      'country': _i10.CountryEndpoint()
        ..initialize(
          server,
          'country',
          null,
        ),
      'deviceFingerprint': _i11.DeviceFingerprintEndpoint()
        ..initialize(
          server,
          'deviceFingerprint',
          null,
        ),
      'driver': _i12.DriverEndpoint()
        ..initialize(
          server,
          'driver',
          null,
        ),
      'driverStatus': _i13.DriverStatusEndpoint()
        ..initialize(
          server,
          'driverStatus',
          null,
        ),
      'elasticsearch': _i14.ElasticsearchEndpoint()
        ..initialize(
          server,
          'elasticsearch',
          null,
        ),
      'email': _i15.EmailEndpoint()
        ..initialize(
          server,
          'email',
          null,
        ),
      'refreshJwtTokens': _i16.RefreshJwtTokensEndpoint()
        ..initialize(
          server,
          'refreshJwtTokens',
          null,
        ),
      'location': _i17.LocationEndpoint()
        ..initialize(
          server,
          'location',
          null,
        ),
      'mcpProxy': _i18.McpProxyEndpoint()
        ..initialize(
          server,
          'mcpProxy',
          null,
        ),
      'media': _i19.MediaEndpoint()
        ..initialize(
          server,
          'media',
          null,
        ),
      'notification': _i20.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'notificationPlanner': _i21.NotificationPlannerEndpoint()
        ..initialize(
          server,
          'notificationPlanner',
          null,
        ),
      'offer': _i22.OfferEndpoint()
        ..initialize(
          server,
          'offer',
          null,
        ),
      'order': _i23.OrderEndpoint()
        ..initialize(
          server,
          'order',
          null,
        ),
      'promo': _i24.PromoEndpoint()
        ..initialize(
          server,
          'promo',
          null,
        ),
      'proposal': _i25.ProposalEndpoint()
        ..initialize(
          server,
          'proposal',
          null,
        ),
      'rating': _i26.RatingEndpoint()
        ..initialize(
          server,
          'rating',
          null,
        ),
      'report': _i27.ReportEndpoint()
        ..initialize(
          server,
          'report',
          null,
        ),
      'request': _i28.RequestEndpoint()
        ..initialize(
          server,
          'request',
          null,
        ),
      'review': _i29.ReviewEndpoint()
        ..initialize(
          server,
          'review',
          null,
        ),
      'search': _i30.SearchEndpoint()
        ..initialize(
          server,
          'search',
          null,
        ),
      'service': _i31.ServiceEndpoint()
        ..initialize(
          server,
          'service',
          null,
        ),
      'settings': _i32.SettingsEndpoint()
        ..initialize(
          server,
          'settings',
          null,
        ),
      'storeDelivery': _i33.StoreDeliveryEndpoint()
        ..initialize(
          server,
          'storeDelivery',
          null,
        ),
      'store': _i34.StoreEndpoint()
        ..initialize(
          server,
          'store',
          null,
        ),
      'storeOrder': _i35.StoreOrderEndpoint()
        ..initialize(
          server,
          'storeOrder',
          null,
        ),
      'storeProduct': _i36.StoreProductEndpoint()
        ..initialize(
          server,
          'storeProduct',
          null,
        ),
      'storeReview': _i37.StoreReviewEndpoint()
        ..initialize(
          server,
          'storeReview',
          null,
        ),
      'transaction': _i38.TransactionEndpoint()
        ..initialize(
          server,
          'transaction',
          null,
        ),
      'trustScore': _i39.TrustScoreEndpoint()
        ..initialize(
          server,
          'trustScore',
          null,
        ),
      'user': _i40.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
      'greeting': _i41.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['admin'] = _i1.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'firebaseUid': _i1.ParameterDescription(
              name: 'firebaseUid',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).login(
                session,
                email: params['email'],
                firebaseUid: params['firebaseUid'],
                password: params['password'],
              ),
        ),
        'loginWithPassword': _i1.MethodConnector(
          name: 'loginWithPassword',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).loginWithPassword(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'changePassword': _i1.MethodConnector(
          name: 'changePassword',
          params: {
            'adminId': _i1.ParameterDescription(
              name: 'adminId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'currentPassword': _i1.ParameterDescription(
              name: 'currentPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).changePassword(
                    session,
                    adminId: params['adminId'],
                    currentPassword: params['currentPassword'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'getAllAdmins': _i1.MethodConnector(
          name: 'getAllAdmins',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).getAllAdmins(
                session,
              ),
        ),
        'getAdmin': _i1.MethodConnector(
          name: 'getAdmin',
          params: {
            'adminId': _i1.ParameterDescription(
              name: 'adminId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).getAdmin(
                session,
                adminId: params['adminId'],
              ),
        ),
        'createAdmin': _i1.MethodConnector(
          name: 'createAdmin',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'photoUrl': _i1.ParameterDescription(
              name: 'photoUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'permissions': _i1.ParameterDescription(
              name: 'permissions',
              type: _i1.getType<List<String>?>(),
              nullable: true,
            ),
            'createdBy': _i1.ParameterDescription(
              name: 'createdBy',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).createAdmin(
                session,
                email: params['email'],
                password: params['password'],
                name: params['name'],
                photoUrl: params['photoUrl'],
                role: params['role'],
                permissions: params['permissions'],
                createdBy: params['createdBy'],
              ),
        ),
        'updateAdmin': _i1.MethodConnector(
          name: 'updateAdmin',
          params: {
            'adminId': _i1.ParameterDescription(
              name: 'adminId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'photoUrl': _i1.ParameterDescription(
              name: 'photoUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'permissions': _i1.ParameterDescription(
              name: 'permissions',
              type: _i1.getType<List<String>?>(),
              nullable: true,
            ),
            'isActive': _i1.ParameterDescription(
              name: 'isActive',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).updateAdmin(
                session,
                adminId: params['adminId'],
                email: params['email'],
                name: params['name'],
                photoUrl: params['photoUrl'],
                role: params['role'],
                permissions: params['permissions'],
                isActive: params['isActive'],
              ),
        ),
        'resetAdminPassword': _i1.MethodConnector(
          name: 'resetAdminPassword',
          params: {
            'adminId': _i1.ParameterDescription(
              name: 'adminId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).resetAdminPassword(
                    session,
                    adminId: params['adminId'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'deleteAdmin': _i1.MethodConnector(
          name: 'deleteAdmin',
          params: {
            'adminId': _i1.ParameterDescription(
              name: 'adminId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).deleteAdmin(
                session,
                adminId: params['adminId'],
              ),
        ),
        'toggleAdminStatus': _i1.MethodConnector(
          name: 'toggleAdminStatus',
          params: {
            'adminId': _i1.ParameterDescription(
              name: 'adminId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).toggleAdminStatus(
                    session,
                    adminId: params['adminId'],
                  ),
        ),
        'getProfile': _i1.MethodConnector(
          name: 'getProfile',
          params: {
            'adminId': _i1.ParameterDescription(
              name: 'adminId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).getProfile(
                session,
                adminId: params['adminId'],
              ),
        ),
        'updateProfile': _i1.MethodConnector(
          name: 'updateProfile',
          params: {
            'adminId': _i1.ParameterDescription(
              name: 'adminId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'photoUrl': _i1.ParameterDescription(
              name: 'photoUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).updateProfile(
                    session,
                    adminId: params['adminId'],
                    name: params['name'],
                    photoUrl: params['photoUrl'],
                  ),
        ),
        'getDashboardStats': _i1.MethodConnector(
          name: 'getDashboardStats',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint)
                  .getDashboardStats(session),
        ),
        'getUserCount': _i1.MethodConnector(
          name: 'getUserCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).getUserCount(
                session,
              ),
        ),
        'listUsers': _i1.MethodConnector(
          name: 'listUsers',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'search': _i1.ParameterDescription(
              name: 'search',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).listUsers(
                session,
                page: params['page'],
                limit: params['limit'],
                search: params['search'],
                role: params['role'],
                status: params['status'],
              ),
        ),
        'listDrivers': _i1.MethodConnector(
          name: 'listDrivers',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'search': _i1.ParameterDescription(
              name: 'search',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'onlineOnly': _i1.ParameterDescription(
              name: 'onlineOnly',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'verifiedOnly': _i1.ParameterDescription(
              name: 'verifiedOnly',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).listDrivers(
                session,
                page: params['page'],
                limit: params['limit'],
                search: params['search'],
                onlineOnly: params['onlineOnly'],
                verifiedOnly: params['verifiedOnly'],
              ),
        ),
        'listStores': _i1.MethodConnector(
          name: 'listStores',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'search': _i1.ParameterDescription(
              name: 'search',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'activeOnly': _i1.ParameterDescription(
              name: 'activeOnly',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).listStores(
                session,
                page: params['page'],
                limit: params['limit'],
                search: params['search'],
                activeOnly: params['activeOnly'],
              ),
        ),
        'getStoreCount': _i1.MethodConnector(
          name: 'getStoreCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint)
                  .getStoreCount(session),
        ),
        'activateStore': _i1.MethodConnector(
          name: 'activateStore',
          params: {
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).activateStore(
                    session,
                    params['storeId'],
                  ),
        ),
        'deactivateStore': _i1.MethodConnector(
          name: 'deactivateStore',
          params: {
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).deactivateStore(
                    session,
                    storeId: params['storeId'],
                    reason: params['reason'],
                  ),
        ),
        'deleteStore': _i1.MethodConnector(
          name: 'deleteStore',
          params: {
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).deleteStore(
                session,
                params['storeId'],
              ),
        ),
        'suspendUser': _i1.MethodConnector(
          name: 'suspendUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'suspendUntil': _i1.ParameterDescription(
              name: 'suspendUntil',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).suspendUser(
                session,
                userId: params['userId'],
                reason: params['reason'],
                suspendUntil: params['suspendUntil'],
              ),
        ),
        'unsuspendUser': _i1.MethodConnector(
          name: 'unsuspendUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).unsuspendUser(
                    session,
                    params['userId'],
                  ),
        ),
        'banUser': _i1.MethodConnector(
          name: 'banUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).banUser(
                session,
                userId: params['userId'],
                reason: params['reason'],
              ),
        ),
        'deleteUser': _i1.MethodConnector(
          name: 'deleteUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).deleteUser(
                session,
                params['userId'],
              ),
        ),
        'verifyDriver': _i1.MethodConnector(
          name: 'verifyDriver',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).verifyDriver(
                session,
                params['driverId'],
              ),
        ),
        'createAdminUser': _i1.MethodConnector(
          name: 'createAdminUser',
          params: {
            'firebaseUid': _i1.ParameterDescription(
              name: 'firebaseUid',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'fullName': _i1.ParameterDescription(
              name: 'fullName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).createAdminUser(
                    session,
                    firebaseUid: params['firebaseUid'],
                    email: params['email'],
                    fullName: params['fullName'],
                  ),
        ),
        'getDriverCount': _i1.MethodConnector(
          name: 'getDriverCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint)
                  .getDriverCount(session),
        ),
        'unverifyDriver': _i1.MethodConnector(
          name: 'unverifyDriver',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).unverifyDriver(
                    session,
                    params['driverId'],
                  ),
        ),
        'suspendDriver': _i1.MethodConnector(
          name: 'suspendDriver',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).suspendDriver(
                    session,
                    driverId: params['driverId'],
                    reason: params['reason'],
                  ),
        ),
        'deleteDriver': _i1.MethodConnector(
          name: 'deleteDriver',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).deleteDriver(
                session,
                params['driverId'],
              ),
        ),
        'getOrderCount': _i1.MethodConnector(
          name: 'getOrderCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint)
                  .getOrderCount(session),
        ),
        'listOrders': _i1.MethodConnector(
          name: 'listOrders',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'statusFilter': _i1.ParameterDescription(
              name: 'statusFilter',
              type: _i1.getType<_i42.StoreOrderStatus?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).listOrders(
                session,
                page: params['page'],
                limit: params['limit'],
                statusFilter: params['statusFilter'],
              ),
        ),
        'listRequests': _i1.MethodConnector(
          name: 'listRequests',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'statusFilter': _i1.ParameterDescription(
              name: 'statusFilter',
              type: _i1.getType<_i43.RequestStatus?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).listRequests(
                session,
                page: params['page'],
                limit: params['limit'],
                statusFilter: params['statusFilter'],
              ),
        ),
        'getRequestCount': _i1.MethodConnector(
          name: 'getRequestCount',
          params: {
            'statusFilter': _i1.ParameterDescription(
              name: 'statusFilter',
              type: _i1.getType<_i43.RequestStatus?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).getRequestCount(
                    session,
                    statusFilter: params['statusFilter'],
                  ),
        ),
        'updateRequestStatus': _i1.MethodConnector(
          name: 'updateRequestStatus',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i43.RequestStatus>(),
              nullable: false,
            ),
            'note': _i1.ParameterDescription(
              name: 'note',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).updateRequestStatus(
                    session,
                    params['requestId'],
                    params['status'],
                    note: params['note'],
                  ),
        ),
        'listTransactions': _i1.MethodConnector(
          name: 'listTransactions',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'statusFilter': _i1.ParameterDescription(
              name: 'statusFilter',
              type: _i1.getType<_i44.TransactionStatus?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).listTransactions(
                    session,
                    page: params['page'],
                    limit: params['limit'],
                    statusFilter: params['statusFilter'],
                  ),
        ),
        'listReports': _i1.MethodConnector(
          name: 'listReports',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'statusFilter': _i1.ParameterDescription(
              name: 'statusFilter',
              type: _i1.getType<_i45.ReportStatus?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).listReports(
                session,
                page: params['page'],
                limit: params['limit'],
                statusFilter: params['statusFilter'],
              ),
        ),
        'resolveReport': _i1.MethodConnector(
          name: 'resolveReport',
          params: {
            'reportId': _i1.ParameterDescription(
              name: 'reportId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'resolution': _i1.ParameterDescription(
              name: 'resolution',
              type: _i1.getType<_i46.ReportResolution>(),
              nullable: false,
            ),
            'adminNotes': _i1.ParameterDescription(
              name: 'adminNotes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).resolveReport(
                    session,
                    reportId: params['reportId'],
                    resolution: params['resolution'],
                    adminNotes: params['adminNotes'],
                  ),
        ),
        'getRecentActivities': _i1.MethodConnector(
          name: 'getRecentActivities',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).getRecentActivities(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'dismissReport': _i1.MethodConnector(
          name: 'dismissReport',
          params: {
            'reportId': _i1.ParameterDescription(
              name: 'reportId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).dismissReport(
                    session,
                    reportId: params['reportId'],
                    reason: params['reason'],
                  ),
        ),
      },
    );
    connectors['agent'] = _i1.EndpointConnector(
      name: 'agent',
      endpoint: endpoints['agent']!,
      methodConnectors: {
        'findBestDrivers': _i1.MethodConnector(
          name: 'findBestDrivers',
          params: {
            'serviceId': _i1.ParameterDescription(
              name: 'serviceId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'preferVerified': _i1.ParameterDescription(
              name: 'preferVerified',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'preferPremium': _i1.ParameterDescription(
              name: 'preferPremium',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'minRating': _i1.ParameterDescription(
              name: 'minRating',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'maxResults': _i1.ParameterDescription(
              name: 'maxResults',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['agent'] as _i5.AgentEndpoint).findBestDrivers(
                    session,
                    serviceId: params['serviceId'],
                    categoryId: params['categoryId'],
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    radiusKm: params['radiusKm'],
                    preferVerified: params['preferVerified'],
                    preferPremium: params['preferPremium'],
                    minRating: params['minRating'],
                    maxResults: params['maxResults'],
                  ),
        ),
        'parseServiceRequest': _i1.MethodConnector(
          name: 'parseServiceRequest',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'language': _i1.ParameterDescription(
              name: 'language',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['agent'] as _i5.AgentEndpoint).parseServiceRequest(
                    session,
                    request: params['request'],
                    language: params['language'],
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    userId: params['userId'],
                  ),
        ),
        'predictDemand': _i1.MethodConnector(
          name: 'predictDemand',
          params: {
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'hoursAhead': _i1.ParameterDescription(
              name: 'hoursAhead',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['agent'] as _i5.AgentEndpoint).predictDemand(
                    session,
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    radiusKm: params['radiusKm'],
                    hoursAhead: params['hoursAhead'],
                    categoryId: params['categoryId'],
                  ),
        ),
        'searchHelp': _i1.MethodConnector(
          name: 'searchHelp',
          params: {
            'question': _i1.ParameterDescription(
              name: 'question',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'language': _i1.ParameterDescription(
              name: 'language',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'maxResults': _i1.ParameterDescription(
              name: 'maxResults',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['agent'] as _i5.AgentEndpoint).searchHelp(
                session,
                question: params['question'],
                language: params['language'],
                category: params['category'],
                maxResults: params['maxResults'],
              ),
        ),
        'converseWithAgent': _i1.MethodConnector(
          name: 'converseWithAgent',
          params: {
            'agentId': _i1.ParameterDescription(
              name: 'agentId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'message': _i1.ParameterDescription(
              name: 'message',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'conversationId': _i1.ParameterDescription(
              name: 'conversationId',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'connectorId': _i1.ParameterDescription(
              name: 'connectorId',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['agent'] as _i5.AgentEndpoint).converseWithAgent(
                    session,
                    agentId: params['agentId'],
                    message: params['message'],
                    conversationId: params['conversationId'],
                    connectorId: params['connectorId'],
                    userId: params['userId'],
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                  ),
        ),
        'startAgentConverse': _i1.MethodConnector(
          name: 'startAgentConverse',
          params: {
            'agentId': _i1.ParameterDescription(
              name: 'agentId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'message': _i1.ParameterDescription(
              name: 'message',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'conversationId': _i1.ParameterDescription(
              name: 'conversationId',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'connectorId': _i1.ParameterDescription(
              name: 'connectorId',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['agent'] as _i5.AgentEndpoint).startAgentConverse(
                    session,
                    agentId: params['agentId'],
                    message: params['message'],
                    conversationId: params['conversationId'],
                    connectorId: params['connectorId'],
                    userId: params['userId'],
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                  ),
        ),
        'pollAgentStream': _i1.MethodConnector(
          name: 'pollAgentStream',
          params: {
            'streamSessionId': _i1.ParameterDescription(
              name: 'streamSessionId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'lastEventIndex': _i1.ParameterDescription(
              name: 'lastEventIndex',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['agent'] as _i5.AgentEndpoint).pollAgentStream(
                    session,
                    streamSessionId: params['streamSessionId'],
                    lastEventIndex: params['lastEventIndex'],
                  ),
        ),
        'getAgentStatus': _i1.MethodConnector(
          name: 'getAgentStatus',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['agent'] as _i5.AgentEndpoint)
                  .getAgentStatus(session),
        ),
        'processFullRequest': _i1.MethodConnector(
          name: 'processFullRequest',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'language': _i1.ParameterDescription(
              name: 'language',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['agent'] as _i5.AgentEndpoint).processFullRequest(
                    session,
                    request: params['request'],
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    language: params['language'],
                  ),
        ),
      },
    );
    connectors['analytics'] = _i1.EndpointConnector(
      name: 'analytics',
      endpoint: endpoints['analytics']!,
      methodConnectors: {
        'logEvent': _i1.MethodConnector(
          name: 'logEvent',
          params: {
            'eventName': _i1.ParameterDescription(
              name: 'eventName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'eventType': _i1.ParameterDescription(
              name: 'eventType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'propertiesJson': _i1.ParameterDescription(
              name: 'propertiesJson',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'screenName': _i1.ParameterDescription(
              name: 'screenName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'platform': _i1.ParameterDescription(
              name: 'platform',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'appVersion': _i1.ParameterDescription(
              name: 'appVersion',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'sessionId': _i1.ParameterDescription(
              name: 'sessionId',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['analytics'] as _i6.AnalyticsEndpoint).logEvent(
                    session,
                    eventName: params['eventName'],
                    eventType: params['eventType'],
                    propertiesJson: params['propertiesJson'],
                    screenName: params['screenName'],
                    platform: params['platform'],
                    appVersion: params['appVersion'],
                    userId: params['userId'],
                    sessionId: params['sessionId'],
                  ),
        ),
        'logEvents': _i1.MethodConnector(
          name: 'logEvents',
          params: {
            'eventsJson': _i1.ParameterDescription(
              name: 'eventsJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['analytics'] as _i6.AnalyticsEndpoint).logEvents(
                    session,
                    eventsJson: params['eventsJson'],
                    userId: params['userId'],
                  ),
        ),
        'logBusinessEvent': _i1.MethodConnector(
          name: 'logBusinessEvent',
          params: {
            'eventName': _i1.ParameterDescription(
              name: 'eventName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'propertiesJson': _i1.ParameterDescription(
              name: 'propertiesJson',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'revenue': _i1.ParameterDescription(
              name: 'revenue',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'commission': _i1.ParameterDescription(
              name: 'commission',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .logBusinessEvent(
                    session,
                    eventName: params['eventName'],
                    propertiesJson: params['propertiesJson'],
                    revenue: params['revenue'],
                    commission: params['commission'],
                    userId: params['userId'],
                  ),
        ),
        'getAnalyticsSummary': _i1.MethodConnector(
          name: 'getAnalyticsSummary',
          params: {
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'eventType': _i1.ParameterDescription(
              name: 'eventType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .getAnalyticsSummary(
                    session,
                    startDate: params['startDate'],
                    endDate: params['endDate'],
                    eventType: params['eventType'],
                  ),
        ),
        'getRecentEvents': _i1.MethodConnector(
          name: 'getRecentEvents',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'eventName': _i1.ParameterDescription(
              name: 'eventName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'eventType': _i1.ParameterDescription(
              name: 'eventType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i6.AnalyticsEndpoint)
                  .getRecentEvents(
                    session,
                    limit: params['limit'],
                    eventName: params['eventName'],
                    eventType: params['eventType'],
                  ),
        ),
      },
    );
    connectors['firebaseAuth'] = _i1.EndpointConnector(
      name: 'firebaseAuth',
      endpoint: endpoints['firebaseAuth']!,
      methodConnectors: {
        'registerWithFirebase': _i1.MethodConnector(
          name: 'registerWithFirebase',
          params: {
            'firebaseIdToken': _i1.ParameterDescription(
              name: 'firebaseIdToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'fullName': _i1.ParameterDescription(
              name: 'fullName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<_i47.UserRole>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'phoneNumber': _i1.ParameterDescription(
              name: 'phoneNumber',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'profilePhotoUrl': _i1.ParameterDescription(
              name: 'profilePhotoUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['firebaseAuth'] as _i7.FirebaseAuthEndpoint)
                  .registerWithFirebase(
                    session,
                    firebaseIdToken: params['firebaseIdToken'],
                    fullName: params['fullName'],
                    role: params['role'],
                    email: params['email'],
                    phoneNumber: params['phoneNumber'],
                    profilePhotoUrl: params['profilePhotoUrl'],
                  ),
        ),
        'loginWithFirebase': _i1.MethodConnector(
          name: 'loginWithFirebase',
          params: {
            'firebaseIdToken': _i1.ParameterDescription(
              name: 'firebaseIdToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['firebaseAuth'] as _i7.FirebaseAuthEndpoint)
                  .loginWithFirebase(
                    session,
                    firebaseIdToken: params['firebaseIdToken'],
                  ),
        ),
        'refreshToken': _i1.MethodConnector(
          name: 'refreshToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['firebaseAuth'] as _i7.FirebaseAuthEndpoint)
                  .refreshToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
        'getCurrentUser': _i1.MethodConnector(
          name: 'getCurrentUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['firebaseAuth'] as _i7.FirebaseAuthEndpoint)
                  .getCurrentUser(
                    session,
                    userId: params['userId'],
                  ),
        ),
        'logout': _i1.MethodConnector(
          name: 'logout',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['firebaseAuth'] as _i7.FirebaseAuthEndpoint)
                  .logout(session),
        ),
        'checkEmailExists': _i1.MethodConnector(
          name: 'checkEmailExists',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['firebaseAuth'] as _i7.FirebaseAuthEndpoint)
                  .checkEmailExists(
                    session,
                    params['email'],
                  ),
        ),
        'checkPhoneExists': _i1.MethodConnector(
          name: 'checkPhoneExists',
          params: {
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['firebaseAuth'] as _i7.FirebaseAuthEndpoint)
                  .checkPhoneExists(
                    session,
                    params['phone'],
                  ),
        ),
      },
    );
    connectors['blockedUser'] = _i1.EndpointConnector(
      name: 'blockedUser',
      endpoint: endpoints['blockedUser']!,
      methodConnectors: {
        'blockUser': _i1.MethodConnector(
          name: 'blockUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'blockedUserId': _i1.ParameterDescription(
              name: 'blockedUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['blockedUser'] as _i8.BlockedUserEndpoint)
                  .blockUser(
                    session,
                    userId: params['userId'],
                    blockedUserId: params['blockedUserId'],
                    reason: params['reason'],
                  ),
        ),
        'unblockUser': _i1.MethodConnector(
          name: 'unblockUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'blockedUserId': _i1.ParameterDescription(
              name: 'blockedUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['blockedUser'] as _i8.BlockedUserEndpoint)
                  .unblockUser(
                    session,
                    userId: params['userId'],
                    blockedUserId: params['blockedUserId'],
                  ),
        ),
        'getBlockedUsers': _i1.MethodConnector(
          name: 'getBlockedUsers',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['blockedUser'] as _i8.BlockedUserEndpoint)
                  .getBlockedUsers(
                    session,
                    userId: params['userId'],
                  ),
        ),
        'isUserBlocked': _i1.MethodConnector(
          name: 'isUserBlocked',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'targetUserId': _i1.ParameterDescription(
              name: 'targetUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['blockedUser'] as _i8.BlockedUserEndpoint)
                  .isUserBlocked(
                    session,
                    userId: params['userId'],
                    targetUserId: params['targetUserId'],
                  ),
        ),
        'isBlockedByUser': _i1.MethodConnector(
          name: 'isBlockedByUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'otherUserId': _i1.ParameterDescription(
              name: 'otherUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['blockedUser'] as _i8.BlockedUserEndpoint)
                  .isBlockedByUser(
                    session,
                    userId: params['userId'],
                    otherUserId: params['otherUserId'],
                  ),
        ),
      },
    );
    connectors['chat'] = _i1.EndpointConnector(
      name: 'chat',
      endpoint: endpoints['chat']!,
      methodConnectors: {
        'sendMessage': _i1.MethodConnector(
          name: 'sendMessage',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'senderId': _i1.ParameterDescription(
              name: 'senderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'receiverId': _i1.ParameterDescription(
              name: 'receiverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'message': _i1.ParameterDescription(
              name: 'message',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'messageType': _i1.ParameterDescription(
              name: 'messageType',
              type: _i1.getType<_i48.MessageType?>(),
              nullable: true,
            ),
            'attachmentUrl': _i1.ParameterDescription(
              name: 'attachmentUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'firebaseId': _i1.ParameterDescription(
              name: 'firebaseId',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _i9.ChatEndpoint).sendMessage(
                session,
                orderId: params['orderId'],
                senderId: params['senderId'],
                receiverId: params['receiverId'],
                message: params['message'],
                messageType: params['messageType'],
                attachmentUrl: params['attachmentUrl'],
                firebaseId: params['firebaseId'],
              ),
        ),
        'getMessages': _i1.MethodConnector(
          name: 'getMessages',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'before': _i1.ParameterDescription(
              name: 'before',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _i9.ChatEndpoint).getMessages(
                session,
                orderId: params['orderId'],
                limit: params['limit'],
                before: params['before'],
              ),
        ),
        'getUnreadCount': _i1.MethodConnector(
          name: 'getUnreadCount',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _i9.ChatEndpoint).getUnreadCount(
                session,
                userId: params['userId'],
              ),
        ),
        'markAsRead': _i1.MethodConnector(
          name: 'markAsRead',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _i9.ChatEndpoint).markAsRead(
                session,
                orderId: params['orderId'],
                userId: params['userId'],
              ),
        ),
        'markMessageAsRead': _i1.MethodConnector(
          name: 'markMessageAsRead',
          params: {
            'messageId': _i1.ParameterDescription(
              name: 'messageId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chat'] as _i9.ChatEndpoint).markMessageAsRead(
                    session,
                    messageId: params['messageId'],
                  ),
        ),
        'syncFromFirebase': _i1.MethodConnector(
          name: 'syncFromFirebase',
          params: {
            'firebaseId': _i1.ParameterDescription(
              name: 'firebaseId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'senderId': _i1.ParameterDescription(
              name: 'senderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'receiverId': _i1.ParameterDescription(
              name: 'receiverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'message': _i1.ParameterDescription(
              name: 'message',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'messageType': _i1.ParameterDescription(
              name: 'messageType',
              type: _i1.getType<_i48.MessageType?>(),
              nullable: true,
            ),
            'attachmentUrl': _i1.ParameterDescription(
              name: 'attachmentUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'createdAt': _i1.ParameterDescription(
              name: 'createdAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chat'] as _i9.ChatEndpoint).syncFromFirebase(
                    session,
                    firebaseId: params['firebaseId'],
                    orderId: params['orderId'],
                    senderId: params['senderId'],
                    receiverId: params['receiverId'],
                    message: params['message'],
                    messageType: params['messageType'],
                    attachmentUrl: params['attachmentUrl'],
                    createdAt: params['createdAt'],
                  ),
        ),
        'getAdminChatHistory': _i1.MethodConnector(
          name: 'getAdminChatHistory',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chat'] as _i9.ChatEndpoint).getAdminChatHistory(
                    session,
                    orderId: params['orderId'],
                  ),
        ),
        'notifyNewMessage': _i1.MethodConnector(
          name: 'notifyNewMessage',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'recipientUserId': _i1.ParameterDescription(
              name: 'recipientUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'senderId': _i1.ParameterDescription(
              name: 'senderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'senderName': _i1.ParameterDescription(
              name: 'senderName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'messageText': _i1.ParameterDescription(
              name: 'messageText',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chat'] as _i9.ChatEndpoint).notifyNewMessage(
                    session,
                    requestId: params['requestId'],
                    recipientUserId: params['recipientUserId'],
                    senderId: params['senderId'],
                    senderName: params['senderName'],
                    messageText: params['messageText'],
                  ),
        ),
      },
    );
    connectors['country'] = _i1.EndpointConnector(
      name: 'country',
      endpoint: endpoints['country']!,
      methodConnectors: {
        'getActiveCountries': _i1.MethodConnector(
          name: 'getActiveCountries',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['country'] as _i10.CountryEndpoint)
                  .getActiveCountries(session),
        ),
        'getCountryByCode': _i1.MethodConnector(
          name: 'getCountryByCode',
          params: {
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['country'] as _i10.CountryEndpoint)
                  .getCountryByCode(
                    session,
                    params['code'],
                  ),
        ),
        'getDefaultCountry': _i1.MethodConnector(
          name: 'getDefaultCountry',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['country'] as _i10.CountryEndpoint)
                  .getDefaultCountry(session),
        ),
        'getCurrencyInfo': _i1.MethodConnector(
          name: 'getCurrencyInfo',
          params: {
            'countryCode': _i1.ParameterDescription(
              name: 'countryCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['country'] as _i10.CountryEndpoint)
                  .getCurrencyInfo(
                    session,
                    params['countryCode'],
                  ),
        ),
        'formatPrice': _i1.MethodConnector(
          name: 'formatPrice',
          params: {
            'amount': _i1.ParameterDescription(
              name: 'amount',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'countryCode': _i1.ParameterDescription(
              name: 'countryCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['country'] as _i10.CountryEndpoint).formatPrice(
                    session,
                    params['amount'],
                    params['countryCode'],
                  ),
        ),
        'initializeDefaultCountries': _i1.MethodConnector(
          name: 'initializeDefaultCountries',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['country'] as _i10.CountryEndpoint)
                  .initializeDefaultCountries(session),
        ),
        'upsertCountry': _i1.MethodConnector(
          name: 'upsertCountry',
          params: {
            'country': _i1.ParameterDescription(
              name: 'country',
              type: _i1.getType<_i49.Country>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['country'] as _i10.CountryEndpoint).upsertCountry(
                    session,
                    params['country'],
                  ),
        ),
        'updateExchangeRate': _i1.MethodConnector(
          name: 'updateExchangeRate',
          params: {
            'countryCode': _i1.ParameterDescription(
              name: 'countryCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'rateToMAD': _i1.ParameterDescription(
              name: 'rateToMAD',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['country'] as _i10.CountryEndpoint)
                  .updateExchangeRate(
                    session,
                    params['countryCode'],
                    params['rateToMAD'],
                  ),
        ),
        'toggleCountryStatus': _i1.MethodConnector(
          name: 'toggleCountryStatus',
          params: {
            'countryCode': _i1.ParameterDescription(
              name: 'countryCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'isActive': _i1.ParameterDescription(
              name: 'isActive',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['country'] as _i10.CountryEndpoint)
                  .toggleCountryStatus(
                    session,
                    params['countryCode'],
                    params['isActive'],
                  ),
        ),
        'convertCurrency': _i1.MethodConnector(
          name: 'convertCurrency',
          params: {
            'amount': _i1.ParameterDescription(
              name: 'amount',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'fromCountryCode': _i1.ParameterDescription(
              name: 'fromCountryCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'toCountryCode': _i1.ParameterDescription(
              name: 'toCountryCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['country'] as _i10.CountryEndpoint)
                  .convertCurrency(
                    session,
                    params['amount'],
                    params['fromCountryCode'],
                    params['toCountryCode'],
                  ),
        ),
      },
    );
    connectors['deviceFingerprint'] = _i1.EndpointConnector(
      name: 'deviceFingerprint',
      endpoint: endpoints['deviceFingerprint']!,
      methodConnectors: {
        'checkFingerprint': _i1.MethodConnector(
          name: 'checkFingerprint',
          params: {
            'input': _i1.ParameterDescription(
              name: 'input',
              type: _i1.getType<_i50.DeviceFingerprintInput>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deviceFingerprint']
                          as _i11.DeviceFingerprintEndpoint)
                      .checkFingerprint(
                        session,
                        params['input'],
                      ),
        ),
        'registerFingerprint': _i1.MethodConnector(
          name: 'registerFingerprint',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'input': _i1.ParameterDescription(
              name: 'input',
              type: _i1.getType<_i50.DeviceFingerprintInput>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deviceFingerprint']
                          as _i11.DeviceFingerprintEndpoint)
                      .registerFingerprint(
                        session,
                        params['userId'],
                        params['input'],
                      ),
        ),
        'getFingerprintByHash': _i1.MethodConnector(
          name: 'getFingerprintByHash',
          params: {
            'fingerprintHash': _i1.ParameterDescription(
              name: 'fingerprintHash',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deviceFingerprint']
                          as _i11.DeviceFingerprintEndpoint)
                      .getFingerprintByHash(
                        session,
                        params['fingerprintHash'],
                      ),
        ),
        'getFingerprintsForUser': _i1.MethodConnector(
          name: 'getFingerprintsForUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deviceFingerprint']
                          as _i11.DeviceFingerprintEndpoint)
                      .getFingerprintsForUser(
                        session,
                        params['userId'],
                      ),
        ),
        'blockFingerprint': _i1.MethodConnector(
          name: 'blockFingerprint',
          params: {
            'fingerprintHash': _i1.ParameterDescription(
              name: 'fingerprintHash',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deviceFingerprint']
                          as _i11.DeviceFingerprintEndpoint)
                      .blockFingerprint(
                        session,
                        params['fingerprintHash'],
                        params['reason'],
                      ),
        ),
        'unblockFingerprint': _i1.MethodConnector(
          name: 'unblockFingerprint',
          params: {
            'fingerprintHash': _i1.ParameterDescription(
              name: 'fingerprintHash',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deviceFingerprint']
                          as _i11.DeviceFingerprintEndpoint)
                      .unblockFingerprint(
                        session,
                        params['fingerprintHash'],
                        params['reason'],
                      ),
        ),
        'getHighRiskDevices': _i1.MethodConnector(
          name: 'getHighRiskDevices',
          params: {
            'minRiskScore': _i1.ParameterDescription(
              name: 'minRiskScore',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deviceFingerprint']
                          as _i11.DeviceFingerprintEndpoint)
                      .getHighRiskDevices(
                        session,
                        minRiskScore: params['minRiskScore'],
                        limit: params['limit'],
                      ),
        ),
        'getMultiAccountDevices': _i1.MethodConnector(
          name: 'getMultiAccountDevices',
          params: {
            'minAccounts': _i1.ParameterDescription(
              name: 'minAccounts',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deviceFingerprint']
                          as _i11.DeviceFingerprintEndpoint)
                      .getMultiAccountDevices(
                        session,
                        minAccounts: params['minAccounts'],
                        limit: params['limit'],
                      ),
        ),
        'reportPromoAbuse': _i1.MethodConnector(
          name: 'reportPromoAbuse',
          params: {
            'fingerprintHash': _i1.ParameterDescription(
              name: 'fingerprintHash',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'promoCode': _i1.ParameterDescription(
              name: 'promoCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['deviceFingerprint']
                          as _i11.DeviceFingerprintEndpoint)
                      .reportPromoAbuse(
                        session,
                        params['fingerprintHash'],
                        params['promoCode'],
                      ),
        ),
      },
    );
    connectors['driver'] = _i1.EndpointConnector(
      name: 'driver',
      endpoint: endpoints['driver']!,
      methodConnectors: {
        'setOnlineStatus': _i1.MethodConnector(
          name: 'setOnlineStatus',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isOnline': _i1.ParameterDescription(
              name: 'isOnline',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['driver'] as _i12.DriverEndpoint).setOnlineStatus(
                    session,
                    driverId: params['driverId'],
                    isOnline: params['isOnline'],
                  ),
        ),
        'updateLocation': _i1.MethodConnector(
          name: 'updateLocation',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['driver'] as _i12.DriverEndpoint).updateLocation(
                    session,
                    driverId: params['driverId'],
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                  ),
        ),
        'getOnlineDrivers': _i1.MethodConnector(
          name: 'getOnlineDrivers',
          params: {
            'centerLat': _i1.ParameterDescription(
              name: 'centerLat',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'centerLng': _i1.ParameterDescription(
              name: 'centerLng',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'serviceId': _i1.ParameterDescription(
              name: 'serviceId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['driver'] as _i12.DriverEndpoint).getOnlineDrivers(
                    session,
                    centerLat: params['centerLat'],
                    centerLng: params['centerLng'],
                    radiusKm: params['radiusKm'],
                    serviceId: params['serviceId'],
                  ),
        ),
        'getDriverServices': _i1.MethodConnector(
          name: 'getDriverServices',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['driver'] as _i12.DriverEndpoint)
                  .getDriverServices(
                    session,
                    driverId: params['driverId'],
                  ),
        ),
        'getDriverProfileByUserId': _i1.MethodConnector(
          name: 'getDriverProfileByUserId',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['driver'] as _i12.DriverEndpoint)
                  .getDriverProfileByUserId(
                    session,
                    userId: params['userId'],
                  ),
        ),
        'addDriverService': _i1.MethodConnector(
          name: 'addDriverService',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'serviceId': _i1.ParameterDescription(
              name: 'serviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'basePrice': _i1.ParameterDescription(
              name: 'basePrice',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'pricePerKm': _i1.ParameterDescription(
              name: 'pricePerKm',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'pricePerHour': _i1.ParameterDescription(
              name: 'pricePerHour',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'minPrice': _i1.ParameterDescription(
              name: 'minPrice',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['driver'] as _i12.DriverEndpoint).addDriverService(
                    session,
                    driverId: params['driverId'],
                    serviceId: params['serviceId'],
                    categoryId: params['categoryId'],
                    title: params['title'],
                    description: params['description'],
                    imageUrl: params['imageUrl'],
                    basePrice: params['basePrice'],
                    pricePerKm: params['pricePerKm'],
                    pricePerHour: params['pricePerHour'],
                    minPrice: params['minPrice'],
                  ),
        ),
        'updateDriverService': _i1.MethodConnector(
          name: 'updateDriverService',
          params: {
            'serviceId': _i1.ParameterDescription(
              name: 'serviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'basePrice': _i1.ParameterDescription(
              name: 'basePrice',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'pricePerKm': _i1.ParameterDescription(
              name: 'pricePerKm',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'pricePerHour': _i1.ParameterDescription(
              name: 'pricePerHour',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'minPrice': _i1.ParameterDescription(
              name: 'minPrice',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'isAvailable': _i1.ParameterDescription(
              name: 'isAvailable',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'availableFrom': _i1.ParameterDescription(
              name: 'availableFrom',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'availableUntil': _i1.ParameterDescription(
              name: 'availableUntil',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['driver'] as _i12.DriverEndpoint)
                  .updateDriverService(
                    session,
                    serviceId: params['serviceId'],
                    title: params['title'],
                    description: params['description'],
                    imageUrl: params['imageUrl'],
                    basePrice: params['basePrice'],
                    pricePerKm: params['pricePerKm'],
                    pricePerHour: params['pricePerHour'],
                    minPrice: params['minPrice'],
                    isAvailable: params['isAvailable'],
                    availableFrom: params['availableFrom'],
                    availableUntil: params['availableUntil'],
                  ),
        ),
        'deleteDriverService': _i1.MethodConnector(
          name: 'deleteDriverService',
          params: {
            'serviceId': _i1.ParameterDescription(
              name: 'serviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['driver'] as _i12.DriverEndpoint)
                  .deleteDriverService(
                    session,
                    serviceId: params['serviceId'],
                  ),
        ),
        'toggleServiceAvailability': _i1.MethodConnector(
          name: 'toggleServiceAvailability',
          params: {
            'serviceId': _i1.ParameterDescription(
              name: 'serviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isAvailable': _i1.ParameterDescription(
              name: 'isAvailable',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['driver'] as _i12.DriverEndpoint)
                  .toggleServiceAvailability(
                    session,
                    serviceId: params['serviceId'],
                    isAvailable: params['isAvailable'],
                  ),
        ),
        'reorderDriverServices': _i1.MethodConnector(
          name: 'reorderDriverServices',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'serviceIds': _i1.ParameterDescription(
              name: 'serviceIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['driver'] as _i12.DriverEndpoint)
                  .reorderDriverServices(
                    session,
                    driverId: params['driverId'],
                    serviceIds: params['serviceIds'],
                  ),
        ),
        'uploadServiceImageFile': _i1.MethodConnector(
          name: 'uploadServiceImageFile',
          params: {
            'driverServiceId': _i1.ParameterDescription(
              name: 'driverServiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'imageData': _i1.ParameterDescription(
              name: 'imageData',
              type: _i1.getType<_i51.ByteData>(),
              nullable: false,
            ),
            'fileName': _i1.ParameterDescription(
              name: 'fileName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['driver'] as _i12.DriverEndpoint)
                  .uploadServiceImageFile(
                    session,
                    driverServiceId: params['driverServiceId'],
                    imageData: params['imageData'],
                    fileName: params['fileName'],
                  ),
        ),
        'uploadServiceImage': _i1.MethodConnector(
          name: 'uploadServiceImage',
          params: {
            'driverServiceId': _i1.ParameterDescription(
              name: 'driverServiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'thumbnailUrl': _i1.ParameterDescription(
              name: 'thumbnailUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'caption': _i1.ParameterDescription(
              name: 'caption',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'fileSize': _i1.ParameterDescription(
              name: 'fileSize',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'width': _i1.ParameterDescription(
              name: 'width',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'height': _i1.ParameterDescription(
              name: 'height',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['driver'] as _i12.DriverEndpoint)
                  .uploadServiceImage(
                    session,
                    driverServiceId: params['driverServiceId'],
                    imageUrl: params['imageUrl'],
                    thumbnailUrl: params['thumbnailUrl'],
                    caption: params['caption'],
                    fileSize: params['fileSize'],
                    width: params['width'],
                    height: params['height'],
                  ),
        ),
        'getServiceImages': _i1.MethodConnector(
          name: 'getServiceImages',
          params: {
            'driverServiceId': _i1.ParameterDescription(
              name: 'driverServiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['driver'] as _i12.DriverEndpoint).getServiceImages(
                    session,
                    driverServiceId: params['driverServiceId'],
                  ),
        ),
        'deleteServiceImage': _i1.MethodConnector(
          name: 'deleteServiceImage',
          params: {
            'imageId': _i1.ParameterDescription(
              name: 'imageId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['driver'] as _i12.DriverEndpoint)
                  .deleteServiceImage(
                    session,
                    imageId: params['imageId'],
                  ),
        ),
        'autoOfflineDrivers': _i1.MethodConnector(
          name: 'autoOfflineDrivers',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['driver'] as _i12.DriverEndpoint)
                  .autoOfflineDrivers(session),
        ),
        'isDriverTrulyOnline': _i1.MethodConnector(
          name: 'isDriverTrulyOnline',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['driver'] as _i12.DriverEndpoint)
                  .isDriverTrulyOnline(
                    session,
                    userId: params['userId'],
                  ),
        ),
      },
    );
    connectors['driverStatus'] = _i1.EndpointConnector(
      name: 'driverStatus',
      endpoint: endpoints['driverStatus']!,
      methodConnectors: {
        'setDriverStatus': _i1.MethodConnector(
          name: 'setDriverStatus',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isOnline': _i1.ParameterDescription(
              name: 'isOnline',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['driverStatus'] as _i13.DriverStatusEndpoint)
                      .setDriverStatus(
                        session,
                        params['userId'],
                        params['isOnline'],
                      ),
        ),
        'getDriverStatus': _i1.MethodConnector(
          name: 'getDriverStatus',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['driverStatus'] as _i13.DriverStatusEndpoint)
                      .getDriverStatus(
                        session,
                        params['userId'],
                      ),
        ),
        'getOnlineDriversCount': _i1.MethodConnector(
          name: 'getOnlineDriversCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['driverStatus'] as _i13.DriverStatusEndpoint)
                      .getOnlineDriversCount(session),
        ),
        'updateLastSeen': _i1.MethodConnector(
          name: 'updateLastSeen',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['driverStatus'] as _i13.DriverStatusEndpoint)
                      .updateLastSeen(
                        session,
                        params['userId'],
                      ),
        ),
      },
    );
    connectors['elasticsearch'] = _i1.EndpointConnector(
      name: 'elasticsearch',
      endpoint: endpoints['elasticsearch']!,
      methodConnectors: {
        'testConnection': _i1.MethodConnector(
          name: 'testConnection',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .testConnection(session),
        ),
        'getHealth': _i1.MethodConnector(
          name: 'getHealth',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .getHealth(session),
        ),
        'checkIndex': _i1.MethodConnector(
          name: 'checkIndex',
          params: {
            'indexName': _i1.ParameterDescription(
              name: 'indexName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .checkIndex(
                        session,
                        params['indexName'],
                      ),
        ),
        'getIndicesStatus': _i1.MethodConnector(
          name: 'getIndicesStatus',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .getIndicesStatus(session),
        ),
        'indexTestDocument': _i1.MethodConnector(
          name: 'indexTestDocument',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .indexTestDocument(session),
        ),
        'searchTestDocument': _i1.MethodConnector(
          name: 'searchTestDocument',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .searchTestDocument(session),
        ),
        'deleteTestDocument': _i1.MethodConnector(
          name: 'deleteTestDocument',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .deleteTestDocument(session),
        ),
        'getStatus': _i1.MethodConnector(
          name: 'getStatus',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .getStatus(session),
        ),
        'migrateAll': _i1.MethodConnector(
          name: 'migrateAll',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .migrateAll(session),
        ),
        'migrateDrivers': _i1.MethodConnector(
          name: 'migrateDrivers',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .migrateDrivers(session),
        ),
        'migrateServices': _i1.MethodConnector(
          name: 'migrateServices',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .migrateServices(session),
        ),
        'migrateDriverServices': _i1.MethodConnector(
          name: 'migrateDriverServices',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .migrateDriverServices(session),
        ),
        'migrateRequests': _i1.MethodConnector(
          name: 'migrateRequests',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .migrateRequests(session),
        ),
        'migrateStores': _i1.MethodConnector(
          name: 'migrateStores',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .migrateStores(session),
        ),
        'migrateProducts': _i1.MethodConnector(
          name: 'migrateProducts',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .migrateProducts(session),
        ),
        'migrateReviews': _i1.MethodConnector(
          name: 'migrateReviews',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .migrateReviews(session),
        ),
        'migrateStoreOrders': _i1.MethodConnector(
          name: 'migrateStoreOrders',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .migrateStoreOrders(session),
        ),
        'migrateTransactions': _i1.MethodConnector(
          name: 'migrateTransactions',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .migrateTransactions(session),
        ),
        'migrateUsers': _i1.MethodConnector(
          name: 'migrateUsers',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .migrateUsers(session),
        ),
        'migrateWallets': _i1.MethodConnector(
          name: 'migrateWallets',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .migrateWallets(session),
        ),
        'migrateRatings': _i1.MethodConnector(
          name: 'migrateRatings',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .migrateRatings(session),
        ),
        'getDocumentCounts': _i1.MethodConnector(
          name: 'getDocumentCounts',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['elasticsearch'] as _i14.ElasticsearchEndpoint)
                      .getDocumentCounts(session),
        ),
      },
    );
    connectors['email'] = _i1.EndpointConnector(
      name: 'email',
      endpoint: endpoints['email']!,
      methodConnectors: {
        'isEmailServiceReady': _i1.MethodConnector(
          name: 'isEmailServiceReady',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['email'] as _i15.EmailEndpoint)
                  .isEmailServiceReady(session),
        ),
        'sendTestEmail': _i1.MethodConnector(
          name: 'sendTestEmail',
          params: {
            'recipientEmail': _i1.ParameterDescription(
              name: 'recipientEmail',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['email'] as _i15.EmailEndpoint).sendTestEmail(
                    session,
                    params['recipientEmail'],
                  ),
        ),
        'sendWelcomeEmail': _i1.MethodConnector(
          name: 'sendWelcomeEmail',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['email'] as _i15.EmailEndpoint).sendWelcomeEmail(
                    session,
                    email: params['email'],
                    name: params['name'],
                  ),
        ),
        'sendOrderConfirmation': _i1.MethodConnector(
          name: 'sendOrderConfirmation',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'serviceName': _i1.ParameterDescription(
              name: 'serviceName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'total': _i1.ParameterDescription(
              name: 'total',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['email'] as _i15.EmailEndpoint)
                  .sendOrderConfirmation(
                    session,
                    email: params['email'],
                    name: params['name'],
                    orderId: params['orderId'],
                    serviceName: params['serviceName'],
                    date: params['date'],
                    total: params['total'],
                  ),
        ),
        'sendDriverAcceptedNotification': _i1.MethodConnector(
          name: 'sendDriverAcceptedNotification',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'driverName': _i1.ParameterDescription(
              name: 'driverName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'driverPhone': _i1.ParameterDescription(
              name: 'driverPhone',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'vehicleInfo': _i1.ParameterDescription(
              name: 'vehicleInfo',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['email'] as _i15.EmailEndpoint)
                  .sendDriverAcceptedNotification(
                    session,
                    email: params['email'],
                    name: params['name'],
                    orderId: params['orderId'],
                    driverName: params['driverName'],
                    driverPhone: params['driverPhone'],
                    vehicleInfo: params['vehicleInfo'],
                  ),
        ),
        'sendOrderCompletedEmail': _i1.MethodConnector(
          name: 'sendOrderCompletedEmail',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'serviceName': _i1.ParameterDescription(
              name: 'serviceName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'total': _i1.ParameterDescription(
              name: 'total',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['email'] as _i15.EmailEndpoint)
                  .sendOrderCompletedEmail(
                    session,
                    email: params['email'],
                    name: params['name'],
                    orderId: params['orderId'],
                    serviceName: params['serviceName'],
                    total: params['total'],
                  ),
        ),
        'sendCustomEmail': _i1.MethodConnector(
          name: 'sendCustomEmail',
          params: {
            'recipientEmail': _i1.ParameterDescription(
              name: 'recipientEmail',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'recipientName': _i1.ParameterDescription(
              name: 'recipientName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'subject': _i1.ParameterDescription(
              name: 'subject',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'htmlBody': _i1.ParameterDescription(
              name: 'htmlBody',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'textBody': _i1.ParameterDescription(
              name: 'textBody',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['email'] as _i15.EmailEndpoint).sendCustomEmail(
                    session,
                    recipientEmail: params['recipientEmail'],
                    recipientName: params['recipientName'],
                    subject: params['subject'],
                    htmlBody: params['htmlBody'],
                    textBody: params['textBody'],
                  ),
        ),
      },
    );
    connectors['refreshJwtTokens'] = _i1.EndpointConnector(
      name: 'refreshJwtTokens',
      endpoint: endpoints['refreshJwtTokens']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['refreshJwtTokens']
                          as _i16.RefreshJwtTokensEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['location'] = _i1.EndpointConnector(
      name: 'location',
      endpoint: endpoints['location']!,
      methodConnectors: {
        'updateDriverLocation': _i1.MethodConnector(
          name: 'updateDriverLocation',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['location'] as _i17.LocationEndpoint)
                  .updateDriverLocation(
                    session,
                    params['userId'],
                    params['latitude'],
                    params['longitude'],
                  ),
        ),
      },
    );
    connectors['mcpProxy'] = _i1.EndpointConnector(
      name: 'mcpProxy',
      endpoint: endpoints['mcpProxy']!,
      methodConnectors: {
        'proxyMcpRequest': _i1.MethodConnector(
          name: 'proxyMcpRequest',
          params: {
            'requestJson': _i1.ParameterDescription(
              name: 'requestJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['mcpProxy'] as _i18.McpProxyEndpoint)
                  .proxyMcpRequest(
                    session,
                    params['requestJson'],
                  ),
        ),
      },
    );
    connectors['media'] = _i1.EndpointConnector(
      name: 'media',
      endpoint: endpoints['media']!,
      methodConnectors: {
        'ping': _i1.MethodConnector(
          name: 'ping',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['media'] as _i19.MediaEndpoint).ping(session),
        ),
        'recordMedia': _i1.MethodConnector(
          name: 'recordMedia',
          params: {
            'messageId': _i1.ParameterDescription(
              name: 'messageId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'mediaUrl': _i1.ParameterDescription(
              name: 'mediaUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'mediaType': _i1.ParameterDescription(
              name: 'mediaType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'fileName': _i1.ParameterDescription(
              name: 'fileName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'fileSizeBytes': _i1.ParameterDescription(
              name: 'fileSizeBytes',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'durationMs': _i1.ParameterDescription(
              name: 'durationMs',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'thumbnailUrl': _i1.ParameterDescription(
              name: 'thumbnailUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'uploadedAt': _i1.ParameterDescription(
              name: 'uploadedAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['media'] as _i19.MediaEndpoint).recordMedia(
                session,
                messageId: params['messageId'],
                userId: params['userId'],
                requestId: params['requestId'],
                mediaUrl: params['mediaUrl'],
                mediaType: params['mediaType'],
                fileName: params['fileName'],
                fileSizeBytes: params['fileSizeBytes'],
                durationMs: params['durationMs'],
                thumbnailUrl: params['thumbnailUrl'],
                uploadedAt: params['uploadedAt'],
              ),
        ),
        'listByRequest': _i1.MethodConnector(
          name: 'listByRequest',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['media'] as _i19.MediaEndpoint).listByRequest(
                    session,
                    requestId: params['requestId'],
                  ),
        ),
        'incrementDownload': _i1.MethodConnector(
          name: 'incrementDownload',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['media'] as _i19.MediaEndpoint).incrementDownload(
                    session,
                    id: params['id'],
                  ),
        ),
      },
    );
    connectors['notification'] = _i1.EndpointConnector(
      name: 'notification',
      endpoint: endpoints['notification']!,
      methodConnectors: {
        'getUserNotifications': _i1.MethodConnector(
          name: 'getUserNotifications',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'unreadOnly': _i1.ParameterDescription(
              name: 'unreadOnly',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i20.NotificationEndpoint)
                      .getUserNotifications(
                        session,
                        userId: params['userId'],
                        unreadOnly: params['unreadOnly'],
                        limit: params['limit'],
                        offset: params['offset'],
                      ),
        ),
        'markAsRead': _i1.MethodConnector(
          name: 'markAsRead',
          params: {
            'notificationId': _i1.ParameterDescription(
              name: 'notificationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i20.NotificationEndpoint)
                      .markAsRead(
                        session,
                        params['notificationId'],
                      ),
        ),
        'markAllAsRead': _i1.MethodConnector(
          name: 'markAllAsRead',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i20.NotificationEndpoint)
                      .markAllAsRead(
                        session,
                        params['userId'],
                      ),
        ),
        'getUnreadCount': _i1.MethodConnector(
          name: 'getUnreadCount',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i20.NotificationEndpoint)
                      .getUnreadCount(
                        session,
                        params['userId'],
                      ),
        ),
        'createNotification': _i1.MethodConnector(
          name: 'createNotification',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'body': _i1.ParameterDescription(
              name: 'body',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<_i52.NotificationType>(),
              nullable: false,
            ),
            'relatedEntityId': _i1.ParameterDescription(
              name: 'relatedEntityId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'relatedEntityType': _i1.ParameterDescription(
              name: 'relatedEntityType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'data': _i1.ParameterDescription(
              name: 'data',
              type: _i1.getType<Map<String, dynamic>?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i20.NotificationEndpoint)
                      .createNotification(
                        session,
                        userId: params['userId'],
                        title: params['title'],
                        body: params['body'],
                        type: params['type'],
                        relatedEntityId: params['relatedEntityId'],
                        relatedEntityType: params['relatedEntityType'],
                        data: params['data'],
                      ),
        ),
      },
    );
    connectors['notificationPlanner'] = _i1.EndpointConnector(
      name: 'notificationPlanner',
      endpoint: endpoints['notificationPlanner']!,
      methodConnectors: {
        'getStatus': _i1.MethodConnector(
          name: 'getStatus',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationPlanner']
                          as _i21.NotificationPlannerEndpoint)
                      .getStatus(session),
        ),
        'runCycle': _i1.MethodConnector(
          name: 'runCycle',
          params: {
            'dryRun': _i1.ParameterDescription(
              name: 'dryRun',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationPlanner']
                          as _i21.NotificationPlannerEndpoint)
                      .runCycle(
                        session,
                        dryRun: params['dryRun'],
                      ),
        ),
        'dryRun': _i1.MethodConnector(
          name: 'dryRun',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationPlanner']
                          as _i21.NotificationPlannerEndpoint)
                      .dryRun(session),
        ),
        'getHistory': _i1.MethodConnector(
          name: 'getHistory',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationPlanner']
                          as _i21.NotificationPlannerEndpoint)
                      .getHistory(
                        session,
                        limit: params['limit'],
                        type: params['type'],
                        status: params['status'],
                      ),
        ),
        'getStats': _i1.MethodConnector(
          name: 'getStats',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationPlanner']
                          as _i21.NotificationPlannerEndpoint)
                      .getStats(session),
        ),
        'updateConfig': _i1.MethodConnector(
          name: 'updateConfig',
          params: {
            'maxPerCycle': _i1.ParameterDescription(
              name: 'maxPerCycle',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'cycleIntervalHours': _i1.ParameterDescription(
              name: 'cycleIntervalHours',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationPlanner']
                          as _i21.NotificationPlannerEndpoint)
                      .updateConfig(
                        session,
                        maxPerCycle: params['maxPerCycle'],
                        cycleIntervalHours: params['cycleIntervalHours'],
                      ),
        ),
        'sendCustomNotification': _i1.MethodConnector(
          name: 'sendCustomNotification',
          params: {
            'userIds': _i1.ParameterDescription(
              name: 'userIds',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'body': _i1.ParameterDescription(
              name: 'body',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'priority': _i1.ParameterDescription(
              name: 'priority',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationPlanner']
                          as _i21.NotificationPlannerEndpoint)
                      .sendCustomNotification(
                        session,
                        userIds: params['userIds'],
                        title: params['title'],
                        body: params['body'],
                        priority: params['priority'],
                        type: params['type'],
                      ),
        ),
        'sendBroadcast': _i1.MethodConnector(
          name: 'sendBroadcast',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'body': _i1.ParameterDescription(
              name: 'body',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'targetGroup': _i1.ParameterDescription(
              name: 'targetGroup',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationPlanner']
                          as _i21.NotificationPlannerEndpoint)
                      .sendBroadcast(
                        session,
                        title: params['title'],
                        body: params['body'],
                        targetGroup: params['targetGroup'],
                        limit: params['limit'],
                      ),
        ),
      },
    );
    connectors['offer'] = _i1.EndpointConnector(
      name: 'offer',
      endpoint: endpoints['offer']!,
      methodConnectors: {
        'sendOffer': _i1.MethodConnector(
          name: 'sendOffer',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offeredPrice': _i1.ParameterDescription(
              name: 'offeredPrice',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'message': _i1.ParameterDescription(
              name: 'message',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['offer'] as _i22.OfferEndpoint).sendOffer(
                session,
                orderId: params['orderId'],
                driverId: params['driverId'],
                offeredPrice: params['offeredPrice'],
                message: params['message'],
              ),
        ),
        'counterOffer': _i1.MethodConnector(
          name: 'counterOffer',
          params: {
            'offerId': _i1.ParameterDescription(
              name: 'offerId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newPrice': _i1.ParameterDescription(
              name: 'newPrice',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'isClient': _i1.ParameterDescription(
              name: 'isClient',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['offer'] as _i22.OfferEndpoint).counterOffer(
                    session,
                    offerId: params['offerId'],
                    newPrice: params['newPrice'],
                    isClient: params['isClient'],
                  ),
        ),
        'acceptOffer': _i1.MethodConnector(
          name: 'acceptOffer',
          params: {
            'offerId': _i1.ParameterDescription(
              name: 'offerId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['offer'] as _i22.OfferEndpoint).acceptOffer(
                session,
                offerId: params['offerId'],
              ),
        ),
        'getOffersForOrder': _i1.MethodConnector(
          name: 'getOffersForOrder',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['offer'] as _i22.OfferEndpoint).getOffersForOrder(
                    session,
                    orderId: params['orderId'],
                  ),
        ),
        'withdrawOffer': _i1.MethodConnector(
          name: 'withdrawOffer',
          params: {
            'offerId': _i1.ParameterDescription(
              name: 'offerId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['offer'] as _i22.OfferEndpoint).withdrawOffer(
                    session,
                    offerId: params['offerId'],
                  ),
        ),
      },
    );
    connectors['order'] = _i1.EndpointConnector(
      name: 'order',
      endpoint: endpoints['order']!,
      methodConnectors: {
        'createOrder': _i1.MethodConnector(
          name: 'createOrder',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'serviceId': _i1.ParameterDescription(
              name: 'serviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pickupAddressId': _i1.ParameterDescription(
              name: 'pickupAddressId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'dropoffAddressId': _i1.ParameterDescription(
              name: 'dropoffAddressId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'pickupLatitude': _i1.ParameterDescription(
              name: 'pickupLatitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'pickupLongitude': _i1.ParameterDescription(
              name: 'pickupLongitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'pickupAddress': _i1.ParameterDescription(
              name: 'pickupAddress',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'dropoffLatitude': _i1.ParameterDescription(
              name: 'dropoffLatitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'dropoffLongitude': _i1.ParameterDescription(
              name: 'dropoffLongitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'dropoffAddress': _i1.ParameterDescription(
              name: 'dropoffAddress',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'estimatedDistanceKm': _i1.ParameterDescription(
              name: 'estimatedDistanceKm',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'clientProposedPrice': _i1.ParameterDescription(
              name: 'clientProposedPrice',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'clientInstructions': _i1.ParameterDescription(
              name: 'clientInstructions',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'expiresAt': _i1.ParameterDescription(
              name: 'expiresAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i23.OrderEndpoint).createOrder(
                session,
                clientId: params['clientId'],
                serviceId: params['serviceId'],
                pickupAddressId: params['pickupAddressId'],
                dropoffAddressId: params['dropoffAddressId'],
                pickupLatitude: params['pickupLatitude'],
                pickupLongitude: params['pickupLongitude'],
                pickupAddress: params['pickupAddress'],
                dropoffLatitude: params['dropoffLatitude'],
                dropoffLongitude: params['dropoffLongitude'],
                dropoffAddress: params['dropoffAddress'],
                estimatedDistanceKm: params['estimatedDistanceKm'],
                clientProposedPrice: params['clientProposedPrice'],
                notes: params['notes'],
                clientInstructions: params['clientInstructions'],
                expiresAt: params['expiresAt'],
              ),
        ),
        'getActiveOrders': _i1.MethodConnector(
          name: 'getActiveOrders',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _i23.OrderEndpoint).getActiveOrders(
                    session,
                    clientId: params['clientId'],
                  ),
        ),
        'getNearbyOrders': _i1.MethodConnector(
          name: 'getNearbyOrders',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'driverLat': _i1.ParameterDescription(
              name: 'driverLat',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'driverLng': _i1.ParameterDescription(
              name: 'driverLng',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _i23.OrderEndpoint).getNearbyOrders(
                    session,
                    driverId: params['driverId'],
                    driverLat: params['driverLat'],
                    driverLng: params['driverLng'],
                    radiusKm: params['radiusKm'],
                  ),
        ),
        'cancelOrder': _i1.MethodConnector(
          name: 'cancelOrder',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'cancelledBy': _i1.ParameterDescription(
              name: 'cancelledBy',
              type: _i1.getType<_i53.CancellerType>(),
              nullable: false,
            ),
            'cancellationReason': _i1.ParameterDescription(
              name: 'cancellationReason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _i23.OrderEndpoint).cancelOrder(
                session,
                orderId: params['orderId'],
                userId: params['userId'],
                cancelledBy: params['cancelledBy'],
                cancellationReason: params['cancellationReason'],
              ),
        ),
        'updateOrderStatus': _i1.MethodConnector(
          name: 'updateOrderStatus',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i54.OrderStatus>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _i23.OrderEndpoint).updateOrderStatus(
                    session,
                    orderId: params['orderId'],
                    status: params['status'],
                  ),
        ),
      },
    );
    connectors['promo'] = _i1.EndpointConnector(
      name: 'promo',
      endpoint: endpoints['promo']!,
      methodConnectors: {
        'getActivePromos': _i1.MethodConnector(
          name: 'getActivePromos',
          params: {
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['promo'] as _i24.PromoEndpoint).getActivePromos(
                    session,
                    role: params['role'],
                  ),
        ),
        'recordView': _i1.MethodConnector(
          name: 'recordView',
          params: {
            'promoId': _i1.ParameterDescription(
              name: 'promoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['promo'] as _i24.PromoEndpoint).recordView(
                session,
                promoId: params['promoId'],
              ),
        ),
        'recordClick': _i1.MethodConnector(
          name: 'recordClick',
          params: {
            'promoId': _i1.ParameterDescription(
              name: 'promoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['promo'] as _i24.PromoEndpoint).recordClick(
                session,
                promoId: params['promoId'],
              ),
        ),
        'getAllPromos': _i1.MethodConnector(
          name: 'getAllPromos',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['promo'] as _i24.PromoEndpoint)
                  .getAllPromos(session),
        ),
        'getPromo': _i1.MethodConnector(
          name: 'getPromo',
          params: {
            'promoId': _i1.ParameterDescription(
              name: 'promoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['promo'] as _i24.PromoEndpoint).getPromo(
                session,
                promoId: params['promoId'],
              ),
        ),
        'createPromo': _i1.MethodConnector(
          name: 'createPromo',
          params: {
            'titleEn': _i1.ParameterDescription(
              name: 'titleEn',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'titleAr': _i1.ParameterDescription(
              name: 'titleAr',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'titleFr': _i1.ParameterDescription(
              name: 'titleFr',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'titleEs': _i1.ParameterDescription(
              name: 'titleEs',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'descriptionEn': _i1.ParameterDescription(
              name: 'descriptionEn',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'descriptionAr': _i1.ParameterDescription(
              name: 'descriptionAr',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'descriptionFr': _i1.ParameterDescription(
              name: 'descriptionFr',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'descriptionEs': _i1.ParameterDescription(
              name: 'descriptionEs',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'targetRoles': _i1.ParameterDescription(
              name: 'targetRoles',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'actionType': _i1.ParameterDescription(
              name: 'actionType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'actionValue': _i1.ParameterDescription(
              name: 'actionValue',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'priority': _i1.ParameterDescription(
              name: 'priority',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isActive': _i1.ParameterDescription(
              name: 'isActive',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'createdBy': _i1.ParameterDescription(
              name: 'createdBy',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['promo'] as _i24.PromoEndpoint).createPromo(
                session,
                titleEn: params['titleEn'],
                titleAr: params['titleAr'],
                titleFr: params['titleFr'],
                titleEs: params['titleEs'],
                descriptionEn: params['descriptionEn'],
                descriptionAr: params['descriptionAr'],
                descriptionFr: params['descriptionFr'],
                descriptionEs: params['descriptionEs'],
                imageUrl: params['imageUrl'],
                targetRoles: params['targetRoles'],
                actionType: params['actionType'],
                actionValue: params['actionValue'],
                priority: params['priority'],
                isActive: params['isActive'],
                startDate: params['startDate'],
                endDate: params['endDate'],
                createdBy: params['createdBy'],
              ),
        ),
        'updatePromo': _i1.MethodConnector(
          name: 'updatePromo',
          params: {
            'promoId': _i1.ParameterDescription(
              name: 'promoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'titleEn': _i1.ParameterDescription(
              name: 'titleEn',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'titleAr': _i1.ParameterDescription(
              name: 'titleAr',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'titleFr': _i1.ParameterDescription(
              name: 'titleFr',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'titleEs': _i1.ParameterDescription(
              name: 'titleEs',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'descriptionEn': _i1.ParameterDescription(
              name: 'descriptionEn',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'descriptionAr': _i1.ParameterDescription(
              name: 'descriptionAr',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'descriptionFr': _i1.ParameterDescription(
              name: 'descriptionFr',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'descriptionEs': _i1.ParameterDescription(
              name: 'descriptionEs',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'targetRoles': _i1.ParameterDescription(
              name: 'targetRoles',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'actionType': _i1.ParameterDescription(
              name: 'actionType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'actionValue': _i1.ParameterDescription(
              name: 'actionValue',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'priority': _i1.ParameterDescription(
              name: 'priority',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'isActive': _i1.ParameterDescription(
              name: 'isActive',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['promo'] as _i24.PromoEndpoint).updatePromo(
                session,
                promoId: params['promoId'],
                titleEn: params['titleEn'],
                titleAr: params['titleAr'],
                titleFr: params['titleFr'],
                titleEs: params['titleEs'],
                descriptionEn: params['descriptionEn'],
                descriptionAr: params['descriptionAr'],
                descriptionFr: params['descriptionFr'],
                descriptionEs: params['descriptionEs'],
                imageUrl: params['imageUrl'],
                targetRoles: params['targetRoles'],
                actionType: params['actionType'],
                actionValue: params['actionValue'],
                priority: params['priority'],
                isActive: params['isActive'],
                startDate: params['startDate'],
                endDate: params['endDate'],
              ),
        ),
        'togglePromoStatus': _i1.MethodConnector(
          name: 'togglePromoStatus',
          params: {
            'promoId': _i1.ParameterDescription(
              name: 'promoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['promo'] as _i24.PromoEndpoint).togglePromoStatus(
                    session,
                    promoId: params['promoId'],
                  ),
        ),
        'deletePromo': _i1.MethodConnector(
          name: 'deletePromo',
          params: {
            'promoId': _i1.ParameterDescription(
              name: 'promoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['promo'] as _i24.PromoEndpoint).deletePromo(
                session,
                promoId: params['promoId'],
              ),
        ),
        'getPromoAnalytics': _i1.MethodConnector(
          name: 'getPromoAnalytics',
          params: {
            'promoId': _i1.ParameterDescription(
              name: 'promoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['promo'] as _i24.PromoEndpoint).getPromoAnalytics(
                    session,
                    promoId: params['promoId'],
                  ),
        ),
      },
    );
    connectors['proposal'] = _i1.EndpointConnector(
      name: 'proposal',
      endpoint: endpoints['proposal']!,
      methodConnectors: {
        'submitProposal': _i1.MethodConnector(
          name: 'submitProposal',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'proposedPrice': _i1.ParameterDescription(
              name: 'proposedPrice',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'estimatedArrival': _i1.ParameterDescription(
              name: 'estimatedArrival',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'message': _i1.ParameterDescription(
              name: 'message',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['proposal'] as _i25.ProposalEndpoint)
                  .submitProposal(
                    session,
                    requestId: params['requestId'],
                    driverId: params['driverId'],
                    proposedPrice: params['proposedPrice'],
                    estimatedArrival: params['estimatedArrival'],
                    message: params['message'],
                  ),
        ),
        'getProposalsForRequest': _i1.MethodConnector(
          name: 'getProposalsForRequest',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['proposal'] as _i25.ProposalEndpoint)
                  .getProposalsForRequest(
                    session,
                    params['requestId'],
                  ),
        ),
        'acceptProposal': _i1.MethodConnector(
          name: 'acceptProposal',
          params: {
            'proposalId': _i1.ParameterDescription(
              name: 'proposalId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['proposal'] as _i25.ProposalEndpoint)
                  .acceptProposal(
                    session,
                    proposalId: params['proposalId'],
                    clientId: params['clientId'],
                  ),
        ),
        'rejectProposal': _i1.MethodConnector(
          name: 'rejectProposal',
          params: {
            'proposalId': _i1.ParameterDescription(
              name: 'proposalId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['proposal'] as _i25.ProposalEndpoint)
                  .rejectProposal(
                    session,
                    proposalId: params['proposalId'],
                    clientId: params['clientId'],
                  ),
        ),
        'withdrawProposal': _i1.MethodConnector(
          name: 'withdrawProposal',
          params: {
            'proposalId': _i1.ParameterDescription(
              name: 'proposalId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['proposal'] as _i25.ProposalEndpoint)
                  .withdrawProposal(
                    session,
                    proposalId: params['proposalId'],
                    driverId: params['driverId'],
                  ),
        ),
      },
    );
    connectors['rating'] = _i1.EndpointConnector(
      name: 'rating',
      endpoint: endpoints['rating']!,
      methodConnectors: {
        'submitRating': _i1.MethodConnector(
          name: 'submitRating',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'ratedUserId': _i1.ParameterDescription(
              name: 'ratedUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'ratingValue': _i1.ParameterDescription(
              name: 'ratingValue',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'ratingType': _i1.ParameterDescription(
              name: 'ratingType',
              type: _i1.getType<_i55.RatingType>(),
              nullable: false,
            ),
            'reviewText': _i1.ParameterDescription(
              name: 'reviewText',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'quickTags': _i1.ParameterDescription(
              name: 'quickTags',
              type: _i1.getType<List<String>?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['rating'] as _i26.RatingEndpoint).submitRating(
                    session,
                    params['userId'],
                    params['requestId'],
                    params['ratedUserId'],
                    params['ratingValue'],
                    params['ratingType'],
                    reviewText: params['reviewText'],
                    quickTags: params['quickTags'],
                  ),
        ),
        'getUserRatings': _i1.MethodConnector(
          name: 'getUserRatings',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'ratingType': _i1.ParameterDescription(
              name: 'ratingType',
              type: _i1.getType<_i55.RatingType?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['rating'] as _i26.RatingEndpoint).getUserRatings(
                    session,
                    params['userId'],
                    ratingType: params['ratingType'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getUserRatingStats': _i1.MethodConnector(
          name: 'getUserRatingStats',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rating'] as _i26.RatingEndpoint)
                  .getUserRatingStats(
                    session,
                    params['userId'],
                  ),
        ),
        'getRatingsGivenStats': _i1.MethodConnector(
          name: 'getRatingsGivenStats',
          params: {
            'raterId': _i1.ParameterDescription(
              name: 'raterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'ratingType': _i1.ParameterDescription(
              name: 'ratingType',
              type: _i1.getType<_i55.RatingType?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rating'] as _i26.RatingEndpoint)
                  .getRatingsGivenStats(
                    session,
                    params['raterId'],
                    ratingType: params['ratingType'],
                  ),
        ),
        'getRatingForRequest': _i1.MethodConnector(
          name: 'getRatingForRequest',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'raterId': _i1.ParameterDescription(
              name: 'raterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rating'] as _i26.RatingEndpoint)
                  .getRatingForRequest(
                    session,
                    params['requestId'],
                    params['raterId'],
                  ),
        ),
        'getRequestRatingStatus': _i1.MethodConnector(
          name: 'getRequestRatingStatus',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rating'] as _i26.RatingEndpoint)
                  .getRequestRatingStatus(
                    session,
                    params['requestId'],
                  ),
        ),
      },
    );
    connectors['report'] = _i1.EndpointConnector(
      name: 'report',
      endpoint: endpoints['report']!,
      methodConnectors: {
        'createReportByUserId': _i1.MethodConnector(
          name: 'createReportByUserId',
          params: {
            'reportedByUserId': _i1.ParameterDescription(
              name: 'reportedByUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reporterType': _i1.ParameterDescription(
              name: 'reporterType',
              type: _i1.getType<_i56.ReporterType>(),
              nullable: false,
            ),
            'reportedUserIdAsDriver': _i1.ParameterDescription(
              name: 'reportedUserIdAsDriver',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'reportedUserIdAsClient': _i1.ParameterDescription(
              name: 'reportedUserIdAsClient',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'reportedStoreId': _i1.ParameterDescription(
              name: 'reportedStoreId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'reportedOrderId': _i1.ParameterDescription(
              name: 'reportedOrderId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'reportedType': _i1.ParameterDescription(
              name: 'reportedType',
              type: _i1.getType<_i56.ReporterType?>(),
              nullable: true,
            ),
            'reportReason': _i1.ParameterDescription(
              name: 'reportReason',
              type: _i1.getType<_i57.ReportReason>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'evidenceUrls': _i1.ParameterDescription(
              name: 'evidenceUrls',
              type: _i1.getType<List<String>?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['report'] as _i27.ReportEndpoint)
                  .createReportByUserId(
                    session,
                    reportedByUserId: params['reportedByUserId'],
                    reporterType: params['reporterType'],
                    reportedUserIdAsDriver: params['reportedUserIdAsDriver'],
                    reportedUserIdAsClient: params['reportedUserIdAsClient'],
                    reportedStoreId: params['reportedStoreId'],
                    reportedOrderId: params['reportedOrderId'],
                    reportedType: params['reportedType'],
                    reportReason: params['reportReason'],
                    description: params['description'],
                    evidenceUrls: params['evidenceUrls'],
                  ),
        ),
        'createReport': _i1.MethodConnector(
          name: 'createReport',
          params: {
            'reportedByUserId': _i1.ParameterDescription(
              name: 'reportedByUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reporterType': _i1.ParameterDescription(
              name: 'reporterType',
              type: _i1.getType<_i56.ReporterType>(),
              nullable: false,
            ),
            'reportedDriverId': _i1.ParameterDescription(
              name: 'reportedDriverId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'reportedClientId': _i1.ParameterDescription(
              name: 'reportedClientId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'reportedStoreId': _i1.ParameterDescription(
              name: 'reportedStoreId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'reportedOrderId': _i1.ParameterDescription(
              name: 'reportedOrderId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'reportedType': _i1.ParameterDescription(
              name: 'reportedType',
              type: _i1.getType<_i56.ReporterType?>(),
              nullable: true,
            ),
            'reportReason': _i1.ParameterDescription(
              name: 'reportReason',
              type: _i1.getType<_i57.ReportReason>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'evidenceUrls': _i1.ParameterDescription(
              name: 'evidenceUrls',
              type: _i1.getType<List<String>?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['report'] as _i27.ReportEndpoint).createReport(
                    session,
                    reportedByUserId: params['reportedByUserId'],
                    reporterType: params['reporterType'],
                    reportedDriverId: params['reportedDriverId'],
                    reportedClientId: params['reportedClientId'],
                    reportedStoreId: params['reportedStoreId'],
                    reportedOrderId: params['reportedOrderId'],
                    reportedType: params['reportedType'],
                    reportReason: params['reportReason'],
                    description: params['description'],
                    evidenceUrls: params['evidenceUrls'],
                  ),
        ),
        'getPendingReports': _i1.MethodConnector(
          name: 'getPendingReports',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['report'] as _i27.ReportEndpoint)
                  .getPendingReports(session),
        ),
        'getReportsForUser': _i1.MethodConnector(
          name: 'getReportsForUser',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['report'] as _i27.ReportEndpoint)
                  .getReportsForUser(
                    session,
                    driverId: params['driverId'],
                    clientId: params['clientId'],
                  ),
        ),
        'resolveReport': _i1.MethodConnector(
          name: 'resolveReport',
          params: {
            'reportId': _i1.ParameterDescription(
              name: 'reportId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'adminId': _i1.ParameterDescription(
              name: 'adminId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'resolution': _i1.ParameterDescription(
              name: 'resolution',
              type: _i1.getType<_i46.ReportResolution>(),
              nullable: false,
            ),
            'adminNotes': _i1.ParameterDescription(
              name: 'adminNotes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'reviewNotes': _i1.ParameterDescription(
              name: 'reviewNotes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['report'] as _i27.ReportEndpoint).resolveReport(
                    session,
                    reportId: params['reportId'],
                    adminId: params['adminId'],
                    resolution: params['resolution'],
                    adminNotes: params['adminNotes'],
                    reviewNotes: params['reviewNotes'],
                  ),
        ),
        'dismissReport': _i1.MethodConnector(
          name: 'dismissReport',
          params: {
            'reportId': _i1.ParameterDescription(
              name: 'reportId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'adminId': _i1.ParameterDescription(
              name: 'adminId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reviewNotes': _i1.ParameterDescription(
              name: 'reviewNotes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['report'] as _i27.ReportEndpoint).dismissReport(
                    session,
                    reportId: params['reportId'],
                    adminId: params['adminId'],
                    reviewNotes: params['reviewNotes'],
                  ),
        ),
      },
    );
    connectors['request'] = _i1.EndpointConnector(
      name: 'request',
      endpoint: endpoints['request']!,
      methodConnectors: {
        'createRequest': _i1.MethodConnector(
          name: 'createRequest',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'serviceType': _i1.ParameterDescription(
              name: 'serviceType',
              type: _i1.getType<_i58.ServiceType>(),
              nullable: false,
            ),
            'pickupLocation': _i1.ParameterDescription(
              name: 'pickupLocation',
              type: _i1.getType<_i59.Location?>(),
              nullable: true,
            ),
            'destinationLocation': _i1.ParameterDescription(
              name: 'destinationLocation',
              type: _i1.getType<_i59.Location>(),
              nullable: false,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'clientOfferedPrice': _i1.ParameterDescription(
              name: 'clientOfferedPrice',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'estimatedPurchaseCost': _i1.ParameterDescription(
              name: 'estimatedPurchaseCost',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'isPurchaseRequired': _i1.ParameterDescription(
              name: 'isPurchaseRequired',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'shoppingList': _i1.ParameterDescription(
              name: 'shoppingList',
              type: _i1.getType<List<_i60.ShoppingItem>?>(),
              nullable: true,
            ),
            'attachments': _i1.ParameterDescription(
              name: 'attachments',
              type: _i1.getType<List<String>?>(),
              nullable: true,
            ),
            'catalogServiceId': _i1.ParameterDescription(
              name: 'catalogServiceId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'catalogDriverId': _i1.ParameterDescription(
              name: 'catalogDriverId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'deviceFingerprint': _i1.ParameterDescription(
              name: 'deviceFingerprint',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['request'] as _i28.RequestEndpoint).createRequest(
                    session,
                    params['clientId'],
                    params['serviceType'],
                    params['pickupLocation'],
                    params['destinationLocation'],
                    params['notes'],
                    clientOfferedPrice: params['clientOfferedPrice'],
                    estimatedPurchaseCost: params['estimatedPurchaseCost'],
                    isPurchaseRequired: params['isPurchaseRequired'],
                    shoppingList: params['shoppingList'],
                    attachments: params['attachments'],
                    catalogServiceId: params['catalogServiceId'],
                    catalogDriverId: params['catalogDriverId'],
                    deviceFingerprint: params['deviceFingerprint'],
                  ),
        ),
        'getRequestById': _i1.MethodConnector(
          name: 'getRequestById',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['request'] as _i28.RequestEndpoint).getRequestById(
                    session,
                    params['requestId'],
                  ),
        ),
        'getPriceSuggestion': _i1.MethodConnector(
          name: 'getPriceSuggestion',
          params: {
            'pickupLat': _i1.ParameterDescription(
              name: 'pickupLat',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'pickupLon': _i1.ParameterDescription(
              name: 'pickupLon',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'destLat': _i1.ParameterDescription(
              name: 'destLat',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'destLon': _i1.ParameterDescription(
              name: 'destLon',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'serviceType': _i1.ParameterDescription(
              name: 'serviceType',
              type: _i1.getType<_i58.ServiceType>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['request'] as _i28.RequestEndpoint)
                  .getPriceSuggestion(
                    session,
                    params['pickupLat'],
                    params['pickupLon'],
                    params['destLat'],
                    params['destLon'],
                    params['serviceType'],
                  ),
        ),
        'getActiveRequestsForClient': _i1.MethodConnector(
          name: 'getActiveRequestsForClient',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['request'] as _i28.RequestEndpoint)
                  .getActiveRequestsForClient(
                    session,
                    params['clientId'],
                  ),
        ),
        'getActiveRequestForClient': _i1.MethodConnector(
          name: 'getActiveRequestForClient',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['request'] as _i28.RequestEndpoint).
                  // ignore: deprecated_member_use_from_same_package
                  getActiveRequestForClient(
                    session,
                    params['clientId'],
                  ),
        ),
        'getActiveRequestForDriver': _i1.MethodConnector(
          name: 'getActiveRequestForDriver',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['request'] as _i28.RequestEndpoint)
                  .getActiveRequestForDriver(
                    session,
                    params['driverId'],
                  ),
        ),
        'getActiveRequestsForDriver': _i1.MethodConnector(
          name: 'getActiveRequestsForDriver',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['request'] as _i28.RequestEndpoint)
                  .getActiveRequestsForDriver(
                    session,
                    params['driverId'],
                  ),
        ),
        'getNearbyRequests': _i1.MethodConnector(
          name: 'getNearbyRequests',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'driverLat': _i1.ParameterDescription(
              name: 'driverLat',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'driverLon': _i1.ParameterDescription(
              name: 'driverLon',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['request'] as _i28.RequestEndpoint)
                  .getNearbyRequests(
                    session,
                    params['driverId'],
                    params['driverLat'],
                    params['driverLon'],
                    radiusKm: params['radiusKm'],
                  ),
        ),
        'acceptRequest': _i1.MethodConnector(
          name: 'acceptRequest',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['request'] as _i28.RequestEndpoint).acceptRequest(
                    session,
                    params['requestId'],
                    params['driverId'],
                  ),
        ),
        'approveDriver': _i1.MethodConnector(
          name: 'approveDriver',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['request'] as _i28.RequestEndpoint).approveDriver(
                    session,
                    params['requestId'],
                    params['clientId'],
                  ),
        ),
        'rejectDriver': _i1.MethodConnector(
          name: 'rejectDriver',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['request'] as _i28.RequestEndpoint).rejectDriver(
                    session,
                    params['requestId'],
                    params['clientId'],
                  ),
        ),
        'updateRequestStatus': _i1.MethodConnector(
          name: 'updateRequestStatus',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newStatus': _i1.ParameterDescription(
              name: 'newStatus',
              type: _i1.getType<_i43.RequestStatus>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['request'] as _i28.RequestEndpoint)
                  .updateRequestStatus(
                    session,
                    params['requestId'],
                    params['newStatus'],
                    params['userId'],
                  ),
        ),
        'cancelRequest': _i1.MethodConnector(
          name: 'cancelRequest',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['request'] as _i28.RequestEndpoint).cancelRequest(
                    session,
                    params['requestId'],
                    params['userId'],
                    params['reason'],
                  ),
        ),
        'getClientRequestHistory': _i1.MethodConnector(
          name: 'getClientRequestHistory',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['request'] as _i28.RequestEndpoint)
                  .getClientRequestHistory(
                    session,
                    params['clientId'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getDriverRequestHistory': _i1.MethodConnector(
          name: 'getDriverRequestHistory',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['request'] as _i28.RequestEndpoint)
                  .getDriverRequestHistory(
                    session,
                    params['driverId'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getAllPendingRequests': _i1.MethodConnector(
          name: 'getAllPendingRequests',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['request'] as _i28.RequestEndpoint)
                  .getAllPendingRequests(session),
        ),
        'getCatalogRequests': _i1.MethodConnector(
          name: 'getCatalogRequests',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['request'] as _i28.RequestEndpoint)
                  .getCatalogRequests(
                    session,
                    params['userId'],
                  ),
        ),
      },
    );
    connectors['review'] = _i1.EndpointConnector(
      name: 'review',
      endpoint: endpoints['review']!,
      methodConnectors: {
        'createClientReview': _i1.MethodConnector(
          name: 'createClientReview',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'rating': _i1.ParameterDescription(
              name: 'rating',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'comment': _i1.ParameterDescription(
              name: 'comment',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'communicationRating': _i1.ParameterDescription(
              name: 'communicationRating',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'respectRating': _i1.ParameterDescription(
              name: 'respectRating',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'paymentPromptness': _i1.ParameterDescription(
              name: 'paymentPromptness',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['review'] as _i29.ReviewEndpoint)
                  .createClientReview(
                    session,
                    orderId: params['orderId'],
                    driverId: params['driverId'],
                    clientId: params['clientId'],
                    rating: params['rating'],
                    comment: params['comment'],
                    communicationRating: params['communicationRating'],
                    respectRating: params['respectRating'],
                    paymentPromptness: params['paymentPromptness'],
                  ),
        ),
        'getClientReviews': _i1.MethodConnector(
          name: 'getClientReviews',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['review'] as _i29.ReviewEndpoint).getClientReviews(
                    session,
                    clientId: params['clientId'],
                    limit: params['limit'],
                  ),
        ),
        'getReviewsByDriver': _i1.MethodConnector(
          name: 'getReviewsByDriver',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['review'] as _i29.ReviewEndpoint)
                  .getReviewsByDriver(
                    session,
                    driverId: params['driverId'],
                  ),
        ),
        'createDriverReview': _i1.MethodConnector(
          name: 'createDriverReview',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'rating': _i1.ParameterDescription(
              name: 'rating',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'comment': _i1.ParameterDescription(
              name: 'comment',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['review'] as _i29.ReviewEndpoint)
                  .createDriverReview(
                    session,
                    orderId: params['orderId'],
                    clientId: params['clientId'],
                    driverId: params['driverId'],
                    rating: params['rating'],
                    comment: params['comment'],
                  ),
        ),
        'getDriverReviews': _i1.MethodConnector(
          name: 'getDriverReviews',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['review'] as _i29.ReviewEndpoint).getDriverReviews(
                    session,
                    driverId: params['driverId'],
                    limit: params['limit'],
                  ),
        ),
        'recalcDriverRating': _i1.MethodConnector(
          name: 'recalcDriverRating',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['review'] as _i29.ReviewEndpoint)
                  .recalcDriverRating(
                    session,
                    driverId: params['driverId'],
                  ),
        ),
      },
    );
    connectors['search'] = _i1.EndpointConnector(
      name: 'search',
      endpoint: endpoints['search']!,
      methodConnectors: {
        'searchDriversNearby': _i1.MethodConnector(
          name: 'searchDriversNearby',
          params: {
            'lat': _i1.ParameterDescription(
              name: 'lat',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'lon': _i1.ParameterDescription(
              name: 'lon',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'isOnline': _i1.ParameterDescription(
              name: 'isOnline',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'isVerified': _i1.ParameterDescription(
              name: 'isVerified',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'isPremium': _i1.ParameterDescription(
              name: 'isPremium',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'minRating': _i1.ParameterDescription(
              name: 'minRating',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'size': _i1.ParameterDescription(
              name: 'size',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['search'] as _i30.SearchEndpoint)
                  .searchDriversNearby(
                    session,
                    lat: params['lat'],
                    lon: params['lon'],
                    radiusKm: params['radiusKm'],
                    isOnline: params['isOnline'],
                    isVerified: params['isVerified'],
                    isPremium: params['isPremium'],
                    categoryId: params['categoryId'],
                    minRating: params['minRating'],
                    from: params['from'],
                    size: params['size'],
                  ),
        ),
        'searchDriversByText': _i1.MethodConnector(
          name: 'searchDriversByText',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'isOnline': _i1.ParameterDescription(
              name: 'isOnline',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'isVerified': _i1.ParameterDescription(
              name: 'isVerified',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'vehicleType': _i1.ParameterDescription(
              name: 'vehicleType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'minRating': _i1.ParameterDescription(
              name: 'minRating',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'size': _i1.ParameterDescription(
              name: 'size',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['search'] as _i30.SearchEndpoint)
                  .searchDriversByText(
                    session,
                    query: params['query'],
                    isOnline: params['isOnline'],
                    isVerified: params['isVerified'],
                    vehicleType: params['vehicleType'],
                    minRating: params['minRating'],
                    from: params['from'],
                    size: params['size'],
                  ),
        ),
        'getTopRatedDrivers': _i1.MethodConnector(
          name: 'getTopRatedDrivers',
          params: {
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'minCompletedOrders': _i1.ParameterDescription(
              name: 'minCompletedOrders',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'size': _i1.ParameterDescription(
              name: 'size',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['search'] as _i30.SearchEndpoint)
                  .getTopRatedDrivers(
                    session,
                    categoryId: params['categoryId'],
                    minCompletedOrders: params['minCompletedOrders'],
                    from: params['from'],
                    size: params['size'],
                  ),
        ),
        'searchServices': _i1.MethodConnector(
          name: 'searchServices',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'language': _i1.ParameterDescription(
              name: 'language',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'isActive': _i1.ParameterDescription(
              name: 'isActive',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'size': _i1.ParameterDescription(
              name: 'size',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['search'] as _i30.SearchEndpoint).searchServices(
                    session,
                    query: params['query'],
                    language: params['language'],
                    categoryId: params['categoryId'],
                    isActive: params['isActive'],
                    from: params['from'],
                    size: params['size'],
                  ),
        ),
        'getPopularServices': _i1.MethodConnector(
          name: 'getPopularServices',
          params: {
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'size': _i1.ParameterDescription(
              name: 'size',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['search'] as _i30.SearchEndpoint)
                  .getPopularServices(
                    session,
                    categoryId: params['categoryId'],
                    from: params['from'],
                    size: params['size'],
                  ),
        ),
        'searchDriverServices': _i1.MethodConnector(
          name: 'searchDriverServices',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'lat': _i1.ParameterDescription(
              name: 'lat',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'lon': _i1.ParameterDescription(
              name: 'lon',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'serviceId': _i1.ParameterDescription(
              name: 'serviceId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'minPrice': _i1.ParameterDescription(
              name: 'minPrice',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'maxPrice': _i1.ParameterDescription(
              name: 'maxPrice',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'isAvailable': _i1.ParameterDescription(
              name: 'isAvailable',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'driverIsOnline': _i1.ParameterDescription(
              name: 'driverIsOnline',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'sortBy': _i1.ParameterDescription(
              name: 'sortBy',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'size': _i1.ParameterDescription(
              name: 'size',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['search'] as _i30.SearchEndpoint)
                  .searchDriverServices(
                    session,
                    query: params['query'],
                    lat: params['lat'],
                    lon: params['lon'],
                    radiusKm: params['radiusKm'],
                    categoryId: params['categoryId'],
                    serviceId: params['serviceId'],
                    minPrice: params['minPrice'],
                    maxPrice: params['maxPrice'],
                    isAvailable: params['isAvailable'],
                    driverIsOnline: params['driverIsOnline'],
                    sortBy: params['sortBy'],
                    from: params['from'],
                    size: params['size'],
                  ),
        ),
        'getSimilarDriverServices': _i1.MethodConnector(
          name: 'getSimilarDriverServices',
          params: {
            'driverServiceId': _i1.ParameterDescription(
              name: 'driverServiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'size': _i1.ParameterDescription(
              name: 'size',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['search'] as _i30.SearchEndpoint)
                  .getSimilarDriverServices(
                    session,
                    driverServiceId: params['driverServiceId'],
                    size: params['size'],
                  ),
        ),
        'searchStoresNearby': _i1.MethodConnector(
          name: 'searchStoresNearby',
          params: {
            'lat': _i1.ParameterDescription(
              name: 'lat',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'lon': _i1.ParameterDescription(
              name: 'lon',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'isOpen': _i1.ParameterDescription(
              name: 'isOpen',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'minRating': _i1.ParameterDescription(
              name: 'minRating',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'size': _i1.ParameterDescription(
              name: 'size',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['search'] as _i30.SearchEndpoint)
                  .searchStoresNearby(
                    session,
                    lat: params['lat'],
                    lon: params['lon'],
                    radiusKm: params['radiusKm'],
                    query: params['query'],
                    categoryId: params['categoryId'],
                    isOpen: params['isOpen'],
                    minRating: params['minRating'],
                    from: params['from'],
                    size: params['size'],
                  ),
        ),
        'searchProductsInStore': _i1.MethodConnector(
          name: 'searchProductsInStore',
          params: {
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'isAvailable': _i1.ParameterDescription(
              name: 'isAvailable',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'minPrice': _i1.ParameterDescription(
              name: 'minPrice',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'maxPrice': _i1.ParameterDescription(
              name: 'maxPrice',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'sortBy': _i1.ParameterDescription(
              name: 'sortBy',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'size': _i1.ParameterDescription(
              name: 'size',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['search'] as _i30.SearchEndpoint)
                  .searchProductsInStore(
                    session,
                    storeId: params['storeId'],
                    query: params['query'],
                    categoryId: params['categoryId'],
                    isAvailable: params['isAvailable'],
                    minPrice: params['minPrice'],
                    maxPrice: params['maxPrice'],
                    sortBy: params['sortBy'],
                    from: params['from'],
                    size: params['size'],
                  ),
        ),
        'searchProductsNearby': _i1.MethodConnector(
          name: 'searchProductsNearby',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'lat': _i1.ParameterDescription(
              name: 'lat',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'lon': _i1.ParameterDescription(
              name: 'lon',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'isAvailable': _i1.ParameterDescription(
              name: 'isAvailable',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'size': _i1.ParameterDescription(
              name: 'size',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['search'] as _i30.SearchEndpoint)
                  .searchProductsNearby(
                    session,
                    query: params['query'],
                    lat: params['lat'],
                    lon: params['lon'],
                    radiusKm: params['radiusKm'],
                    isAvailable: params['isAvailable'],
                    from: params['from'],
                    size: params['size'],
                  ),
        ),
        'getSearchSuggestions': _i1.MethodConnector(
          name: 'getSearchSuggestions',
          params: {
            'prefix': _i1.ParameterDescription(
              name: 'prefix',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'size': _i1.ParameterDescription(
              name: 'size',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['search'] as _i30.SearchEndpoint)
                  .getSearchSuggestions(
                    session,
                    prefix: params['prefix'],
                    type: params['type'],
                    size: params['size'],
                  ),
        ),
        'getPopularSearches': _i1.MethodConnector(
          name: 'getPopularSearches',
          params: {
            'searchType': _i1.ParameterDescription(
              name: 'searchType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'size': _i1.ParameterDescription(
              name: 'size',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['search'] as _i30.SearchEndpoint)
                  .getPopularSearches(
                    session,
                    searchType: params['searchType'],
                    size: params['size'],
                  ),
        ),
        'getServiceCategoryCounts': _i1.MethodConnector(
          name: 'getServiceCategoryCounts',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['search'] as _i30.SearchEndpoint)
                  .getServiceCategoryCounts(session),
        ),
        'getDriverServicePriceStats': _i1.MethodConnector(
          name: 'getDriverServicePriceStats',
          params: {
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['search'] as _i30.SearchEndpoint)
                  .getDriverServicePriceStats(
                    session,
                    categoryId: params['categoryId'],
                  ),
        ),
        'unifiedSearch': _i1.MethodConnector(
          name: 'unifiedSearch',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'lat': _i1.ParameterDescription(
              name: 'lat',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'lon': _i1.ParameterDescription(
              name: 'lon',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'types': _i1.ParameterDescription(
              name: 'types',
              type: _i1.getType<List<String>?>(),
              nullable: true,
            ),
            'size': _i1.ParameterDescription(
              name: 'size',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['search'] as _i30.SearchEndpoint).unifiedSearch(
                    session,
                    query: params['query'],
                    lat: params['lat'],
                    lon: params['lon'],
                    radiusKm: params['radiusKm'],
                    types: params['types'],
                    size: params['size'],
                  ),
        ),
        'smartSearch': _i1.MethodConnector(
          name: 'smartSearch',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'language': _i1.ParameterDescription(
              name: 'language',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'lat': _i1.ParameterDescription(
              name: 'lat',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'lon': _i1.ParameterDescription(
              name: 'lon',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'types': _i1.ParameterDescription(
              name: 'types',
              type: _i1.getType<List<String>?>(),
              nullable: true,
            ),
            'sizePerType': _i1.ParameterDescription(
              name: 'sizePerType',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['search'] as _i30.SearchEndpoint).smartSearch(
                    session,
                    query: params['query'],
                    language: params['language'],
                    lat: params['lat'],
                    lon: params['lon'],
                    radiusKm: params['radiusKm'],
                    types: params['types'],
                    sizePerType: params['sizePerType'],
                  ),
        ),
        'searchKnowledgeBase': _i1.MethodConnector(
          name: 'searchKnowledgeBase',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'language': _i1.ParameterDescription(
              name: 'language',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'size': _i1.ParameterDescription(
              name: 'size',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['search'] as _i30.SearchEndpoint)
                  .searchKnowledgeBase(
                    session,
                    query: params['query'],
                    category: params['category'],
                    language: params['language'],
                    size: params['size'],
                  ),
        ),
      },
    );
    connectors['service'] = _i1.EndpointConnector(
      name: 'service',
      endpoint: endpoints['service']!,
      methodConnectors: {
        'getCategories': _i1.MethodConnector(
          name: 'getCategories',
          params: {
            'activeOnly': _i1.ParameterDescription(
              name: 'activeOnly',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['service'] as _i31.ServiceEndpoint).getCategories(
                    session,
                    activeOnly: params['activeOnly'],
                  ),
        ),
        'getServicesByCategory': _i1.MethodConnector(
          name: 'getServicesByCategory',
          params: {
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'activeOnly': _i1.ParameterDescription(
              name: 'activeOnly',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['service'] as _i31.ServiceEndpoint)
                  .getServicesByCategory(
                    session,
                    categoryId: params['categoryId'],
                    activeOnly: params['activeOnly'],
                  ),
        ),
        'getDriversByCategory': _i1.MethodConnector(
          name: 'getDriversByCategory',
          params: {
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'clientLat': _i1.ParameterDescription(
              name: 'clientLat',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'clientLng': _i1.ParameterDescription(
              name: 'clientLng',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'onlineOnly': _i1.ParameterDescription(
              name: 'onlineOnly',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['service'] as _i31.ServiceEndpoint)
                  .getDriversByCategory(
                    session,
                    categoryId: params['categoryId'],
                    clientLat: params['clientLat'],
                    clientLng: params['clientLng'],
                    radiusKm: params['radiusKm'],
                    onlineOnly: params['onlineOnly'],
                  ),
        ),
        'getDriversByService': _i1.MethodConnector(
          name: 'getDriversByService',
          params: {
            'serviceId': _i1.ParameterDescription(
              name: 'serviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'clientLat': _i1.ParameterDescription(
              name: 'clientLat',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'clientLng': _i1.ParameterDescription(
              name: 'clientLng',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'onlineOnly': _i1.ParameterDescription(
              name: 'onlineOnly',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['service'] as _i31.ServiceEndpoint)
                  .getDriversByService(
                    session,
                    serviceId: params['serviceId'],
                    clientLat: params['clientLat'],
                    clientLng: params['clientLng'],
                    radiusKm: params['radiusKm'],
                    onlineOnly: params['onlineOnly'],
                  ),
        ),
        'createCategory': _i1.MethodConnector(
          name: 'createCategory',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'nameAr': _i1.ParameterDescription(
              name: 'nameAr',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'nameFr': _i1.ParameterDescription(
              name: 'nameFr',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'nameEs': _i1.ParameterDescription(
              name: 'nameEs',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'icon': _i1.ParameterDescription(
              name: 'icon',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'displayOrder': _i1.ParameterDescription(
              name: 'displayOrder',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'defaultRadiusKm': _i1.ParameterDescription(
              name: 'defaultRadiusKm',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['service'] as _i31.ServiceEndpoint).createCategory(
                    session,
                    name: params['name'],
                    nameAr: params['nameAr'],
                    nameFr: params['nameFr'],
                    nameEs: params['nameEs'],
                    icon: params['icon'],
                    description: params['description'],
                    displayOrder: params['displayOrder'],
                    defaultRadiusKm: params['defaultRadiusKm'],
                  ),
        ),
        'updateCategory': _i1.MethodConnector(
          name: 'updateCategory',
          params: {
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'nameAr': _i1.ParameterDescription(
              name: 'nameAr',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'nameFr': _i1.ParameterDescription(
              name: 'nameFr',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'nameEs': _i1.ParameterDescription(
              name: 'nameEs',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'icon': _i1.ParameterDescription(
              name: 'icon',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'displayOrder': _i1.ParameterDescription(
              name: 'displayOrder',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'defaultRadiusKm': _i1.ParameterDescription(
              name: 'defaultRadiusKm',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'isActive': _i1.ParameterDescription(
              name: 'isActive',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['service'] as _i31.ServiceEndpoint).updateCategory(
                    session,
                    categoryId: params['categoryId'],
                    name: params['name'],
                    nameAr: params['nameAr'],
                    nameFr: params['nameFr'],
                    nameEs: params['nameEs'],
                    icon: params['icon'],
                    description: params['description'],
                    displayOrder: params['displayOrder'],
                    defaultRadiusKm: params['defaultRadiusKm'],
                    isActive: params['isActive'],
                  ),
        ),
        'searchDriversWithServices': _i1.MethodConnector(
          name: 'searchDriversWithServices',
          params: {
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'serviceId': _i1.ParameterDescription(
              name: 'serviceId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'clientLat': _i1.ParameterDescription(
              name: 'clientLat',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'clientLng': _i1.ParameterDescription(
              name: 'clientLng',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'priceMin': _i1.ParameterDescription(
              name: 'priceMin',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'priceMax': _i1.ParameterDescription(
              name: 'priceMax',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'minRating': _i1.ParameterDescription(
              name: 'minRating',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'onlineOnly': _i1.ParameterDescription(
              name: 'onlineOnly',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['service'] as _i31.ServiceEndpoint)
                  .searchDriversWithServices(
                    session,
                    categoryId: params['categoryId'],
                    serviceId: params['serviceId'],
                    clientLat: params['clientLat'],
                    clientLng: params['clientLng'],
                    radiusKm: params['radiusKm'],
                    priceMin: params['priceMin'],
                    priceMax: params['priceMax'],
                    minRating: params['minRating'],
                    onlineOnly: params['onlineOnly'],
                    limit: params['limit'],
                  ),
        ),
        'getDriverCatalog': _i1.MethodConnector(
          name: 'getDriverCatalog',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'activeOnly': _i1.ParameterDescription(
              name: 'activeOnly',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['service'] as _i31.ServiceEndpoint)
                  .getDriverCatalog(
                    session,
                    driverId: params['driverId'],
                    activeOnly: params['activeOnly'],
                  ),
        ),
        'trackServiceView': _i1.MethodConnector(
          name: 'trackServiceView',
          params: {
            'driverServiceId': _i1.ParameterDescription(
              name: 'driverServiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['service'] as _i31.ServiceEndpoint)
                  .trackServiceView(
                    session,
                    driverServiceId: params['driverServiceId'],
                  ),
        ),
        'trackServiceInquiry': _i1.MethodConnector(
          name: 'trackServiceInquiry',
          params: {
            'driverServiceId': _i1.ParameterDescription(
              name: 'driverServiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['service'] as _i31.ServiceEndpoint)
                  .trackServiceInquiry(
                    session,
                    driverServiceId: params['driverServiceId'],
                  ),
        ),
        'trackServiceBooking': _i1.MethodConnector(
          name: 'trackServiceBooking',
          params: {
            'driverServiceId': _i1.ParameterDescription(
              name: 'driverServiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['service'] as _i31.ServiceEndpoint)
                  .trackServiceBooking(
                    session,
                    driverServiceId: params['driverServiceId'],
                  ),
        ),
        'getServiceAnalytics': _i1.MethodConnector(
          name: 'getServiceAnalytics',
          params: {
            'driverServiceId': _i1.ParameterDescription(
              name: 'driverServiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['service'] as _i31.ServiceEndpoint)
                  .getServiceAnalytics(
                    session,
                    driverServiceId: params['driverServiceId'],
                  ),
        ),
        'toggleFavorite': _i1.MethodConnector(
          name: 'toggleFavorite',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['service'] as _i31.ServiceEndpoint).toggleFavorite(
                    session,
                    clientId: params['clientId'],
                    driverId: params['driverId'],
                  ),
        ),
        'getFavoriteDrivers': _i1.MethodConnector(
          name: 'getFavoriteDrivers',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['service'] as _i31.ServiceEndpoint)
                  .getFavoriteDrivers(
                    session,
                    clientId: params['clientId'],
                  ),
        ),
        'isFavorite': _i1.MethodConnector(
          name: 'isFavorite',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['service'] as _i31.ServiceEndpoint).isFavorite(
                    session,
                    clientId: params['clientId'],
                    driverId: params['driverId'],
                  ),
        ),
        'getFavoriteDriverIds': _i1.MethodConnector(
          name: 'getFavoriteDriverIds',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['service'] as _i31.ServiceEndpoint)
                  .getFavoriteDriverIds(
                    session,
                    clientId: params['clientId'],
                  ),
        ),
      },
    );
    connectors['settings'] = _i1.EndpointConnector(
      name: 'settings',
      endpoint: endpoints['settings']!,
      methodConnectors: {
        'getSetting': _i1.MethodConnector(
          name: 'getSetting',
          params: {
            'key': _i1.ParameterDescription(
              name: 'key',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['settings'] as _i32.SettingsEndpoint).getSetting(
                    session,
                    params['key'],
                  ),
        ),
        'getSettings': _i1.MethodConnector(
          name: 'getSettings',
          params: {
            'keys': _i1.ParameterDescription(
              name: 'keys',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['settings'] as _i32.SettingsEndpoint).getSettings(
                    session,
                    params['keys'],
                  ),
        ),
        'getAllSettings': _i1.MethodConnector(
          name: 'getAllSettings',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['settings'] as _i32.SettingsEndpoint)
                  .getAllSettings(session),
        ),
        'setSetting': _i1.MethodConnector(
          name: 'setSetting',
          params: {
            'key': _i1.ParameterDescription(
              name: 'key',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'value': _i1.ParameterDescription(
              name: 'value',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['settings'] as _i32.SettingsEndpoint).setSetting(
                    session,
                    key: params['key'],
                    value: params['value'],
                    description: params['description'],
                  ),
        ),
        'setSettings': _i1.MethodConnector(
          name: 'setSettings',
          params: {
            'settings': _i1.ParameterDescription(
              name: 'settings',
              type: _i1.getType<Map<String, String>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['settings'] as _i32.SettingsEndpoint).setSettings(
                    session,
                    params['settings'],
                  ),
        ),
        'deleteSetting': _i1.MethodConnector(
          name: 'deleteSetting',
          params: {
            'key': _i1.ParameterDescription(
              name: 'key',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['settings'] as _i32.SettingsEndpoint)
                  .deleteSetting(
                    session,
                    params['key'],
                  ),
        ),
        'getAppConfiguration': _i1.MethodConnector(
          name: 'getAppConfiguration',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['settings'] as _i32.SettingsEndpoint)
                  .getAppConfiguration(session),
        ),
        'initializeDefaultSettings': _i1.MethodConnector(
          name: 'initializeDefaultSettings',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['settings'] as _i32.SettingsEndpoint)
                  .initializeDefaultSettings(session),
        ),
      },
    );
    connectors['storeDelivery'] = _i1.EndpointConnector(
      name: 'storeDelivery',
      endpoint: endpoints['storeDelivery']!,
      methodConnectors: {
        'getNearbyDrivers': _i1.MethodConnector(
          name: 'getNearbyDrivers',
          params: {
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .getNearbyDrivers(
                        session,
                        storeId: params['storeId'],
                        orderId: params['orderId'],
                        radiusKm: params['radiusKm'],
                      ),
        ),
        'requestDriver': _i1.MethodConnector(
          name: 'requestDriver',
          params: {
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .requestDriver(
                        session,
                        storeId: params['storeId'],
                        orderId: params['orderId'],
                        driverId: params['driverId'],
                      ),
        ),
        'postDeliveryRequest': _i1.MethodConnector(
          name: 'postDeliveryRequest',
          params: {
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .postDeliveryRequest(
                        session,
                        storeId: params['storeId'],
                        orderId: params['orderId'],
                      ),
        ),
        'getStoreDeliveryRequests': _i1.MethodConnector(
          name: 'getStoreDeliveryRequests',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .getStoreDeliveryRequests(
                        session,
                        driverId: params['driverId'],
                        latitude: params['latitude'],
                        longitude: params['longitude'],
                        radiusKm: params['radiusKm'],
                      ),
        ),
        'acceptStoreDelivery': _i1.MethodConnector(
          name: 'acceptStoreDelivery',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .acceptStoreDelivery(
                        session,
                        driverId: params['driverId'],
                        requestId: params['requestId'],
                      ),
        ),
        'rejectStoreDelivery': _i1.MethodConnector(
          name: 'rejectStoreDelivery',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .rejectStoreDelivery(
                        session,
                        driverId: params['driverId'],
                        requestId: params['requestId'],
                        reason: params['reason'],
                      ),
        ),
        'arrivedAtStore': _i1.MethodConnector(
          name: 'arrivedAtStore',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .arrivedAtStore(
                        session,
                        driverId: params['driverId'],
                        orderId: params['orderId'],
                      ),
        ),
        'pickedUp': _i1.MethodConnector(
          name: 'pickedUp',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'amountPaidToStore': _i1.ParameterDescription(
              name: 'amountPaidToStore',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .pickedUp(
                        session,
                        driverId: params['driverId'],
                        orderId: params['orderId'],
                        amountPaidToStore: params['amountPaidToStore'],
                      ),
        ),
        'arrivedAtClient': _i1.MethodConnector(
          name: 'arrivedAtClient',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .arrivedAtClient(
                        session,
                        driverId: params['driverId'],
                        orderId: params['orderId'],
                      ),
        ),
        'delivered': _i1.MethodConnector(
          name: 'delivered',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'amountCollected': _i1.ParameterDescription(
              name: 'amountCollected',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .delivered(
                        session,
                        driverId: params['driverId'],
                        orderId: params['orderId'],
                        amountCollected: params['amountCollected'],
                      ),
        ),
        'createOrderChat': _i1.MethodConnector(
          name: 'createOrderChat',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .createOrderChat(
                        session,
                        orderId: params['orderId'],
                        clientId: params['clientId'],
                        storeId: params['storeId'],
                        driverId: params['driverId'],
                      ),
        ),
        'getOrCreateOrderChat': _i1.MethodConnector(
          name: 'getOrCreateOrderChat',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .getOrCreateOrderChat(
                        session,
                        orderId: params['orderId'],
                      ),
        ),
        'sendChatMessage': _i1.MethodConnector(
          name: 'sendChatMessage',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'senderId': _i1.ParameterDescription(
              name: 'senderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'senderRole': _i1.ParameterDescription(
              name: 'senderRole',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'senderName': _i1.ParameterDescription(
              name: 'senderName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'content': _i1.ParameterDescription(
              name: 'content',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'messageType': _i1.ParameterDescription(
              name: 'messageType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'attachmentUrl': _i1.ParameterDescription(
              name: 'attachmentUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .sendChatMessage(
                        session,
                        orderId: params['orderId'],
                        senderId: params['senderId'],
                        senderRole: params['senderRole'],
                        senderName: params['senderName'],
                        content: params['content'],
                        messageType: params['messageType'],
                        attachmentUrl: params['attachmentUrl'],
                        latitude: params['latitude'],
                        longitude: params['longitude'],
                      ),
        ),
        'getChatMessages': _i1.MethodConnector(
          name: 'getChatMessages',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .getChatMessages(
                        session,
                        orderId: params['orderId'],
                        limit: params['limit'],
                        offset: params['offset'],
                      ),
        ),
        'getChatParticipantsInfo': _i1.MethodConnector(
          name: 'getChatParticipantsInfo',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .getChatParticipantsInfo(
                        session,
                        orderId: params['orderId'],
                      ),
        ),
        'addDriverToChat': _i1.MethodConnector(
          name: 'addDriverToChat',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .addDriverToChat(
                        session,
                        orderId: params['orderId'],
                        driverId: params['driverId'],
                      ),
        ),
        'getDriverStoreOrders': _i1.MethodConnector(
          name: 'getDriverStoreOrders',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'activeOnly': _i1.ParameterDescription(
              name: 'activeOnly',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .getDriverStoreOrders(
                        session,
                        driverId: params['driverId'],
                        activeOnly: params['activeOnly'],
                      ),
        ),
        'getOrderDeliveryRequest': _i1.MethodConnector(
          name: 'getOrderDeliveryRequest',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeDelivery'] as _i33.StoreDeliveryEndpoint)
                      .getOrderDeliveryRequest(
                        session,
                        orderId: params['orderId'],
                      ),
        ),
      },
    );
    connectors['store'] = _i1.EndpointConnector(
      name: 'store',
      endpoint: endpoints['store']!,
      methodConnectors: {
        'getStoreCategories': _i1.MethodConnector(
          name: 'getStoreCategories',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['store'] as _i34.StoreEndpoint)
                  .getStoreCategories(session),
        ),
        'getStoreCategoryById': _i1.MethodConnector(
          name: 'getStoreCategoryById',
          params: {
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['store'] as _i34.StoreEndpoint)
                  .getStoreCategoryById(
                    session,
                    params['categoryId'],
                  ),
        ),
        'createStore': _i1.MethodConnector(
          name: 'createStore',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeCategoryId': _i1.ParameterDescription(
              name: 'storeCategoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'address': _i1.ParameterDescription(
              name: 'address',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'city': _i1.ParameterDescription(
              name: 'city',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'deliveryRadiusKm': _i1.ParameterDescription(
              name: 'deliveryRadiusKm',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['store'] as _i34.StoreEndpoint).createStore(
                session,
                userId: params['userId'],
                storeCategoryId: params['storeCategoryId'],
                name: params['name'],
                description: params['description'],
                phone: params['phone'],
                email: params['email'],
                address: params['address'],
                latitude: params['latitude'],
                longitude: params['longitude'],
                city: params['city'],
                deliveryRadiusKm: params['deliveryRadiusKm'],
              ),
        ),
        'getMyStore': _i1.MethodConnector(
          name: 'getMyStore',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['store'] as _i34.StoreEndpoint).getMyStore(
                session,
                userId: params['userId'],
              ),
        ),
        'getStoreById': _i1.MethodConnector(
          name: 'getStoreById',
          params: {
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['store'] as _i34.StoreEndpoint).getStoreById(
                    session,
                    params['storeId'],
                  ),
        ),
        'getStoreByUserId': _i1.MethodConnector(
          name: 'getStoreByUserId',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['store'] as _i34.StoreEndpoint).getStoreByUserId(
                    session,
                    params['userId'],
                  ),
        ),
        'updateStore': _i1.MethodConnector(
          name: 'updateStore',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'address': _i1.ParameterDescription(
              name: 'address',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'city': _i1.ParameterDescription(
              name: 'city',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'deliveryRadiusKm': _i1.ParameterDescription(
              name: 'deliveryRadiusKm',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'minimumOrderAmount': _i1.ParameterDescription(
              name: 'minimumOrderAmount',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'estimatedPrepTimeMinutes': _i1.ParameterDescription(
              name: 'estimatedPrepTimeMinutes',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['store'] as _i34.StoreEndpoint).updateStore(
                session,
                userId: params['userId'],
                storeId: params['storeId'],
                name: params['name'],
                description: params['description'],
                phone: params['phone'],
                email: params['email'],
                address: params['address'],
                latitude: params['latitude'],
                longitude: params['longitude'],
                city: params['city'],
                deliveryRadiusKm: params['deliveryRadiusKm'],
                minimumOrderAmount: params['minimumOrderAmount'],
                estimatedPrepTimeMinutes: params['estimatedPrepTimeMinutes'],
              ),
        ),
        'updateStoreLogo': _i1.MethodConnector(
          name: 'updateStoreLogo',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'logoUrl': _i1.ParameterDescription(
              name: 'logoUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['store'] as _i34.StoreEndpoint).updateStoreLogo(
                    session,
                    userId: params['userId'],
                    storeId: params['storeId'],
                    logoUrl: params['logoUrl'],
                  ),
        ),
        'updateStoreCoverImage': _i1.MethodConnector(
          name: 'updateStoreCoverImage',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'coverImageUrl': _i1.ParameterDescription(
              name: 'coverImageUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['store'] as _i34.StoreEndpoint)
                  .updateStoreCoverImage(
                    session,
                    userId: params['userId'],
                    storeId: params['storeId'],
                    coverImageUrl: params['coverImageUrl'],
                  ),
        ),
        'setWorkingHours': _i1.MethodConnector(
          name: 'setWorkingHours',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'workingHoursJson': _i1.ParameterDescription(
              name: 'workingHoursJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['store'] as _i34.StoreEndpoint).setWorkingHours(
                    session,
                    userId: params['userId'],
                    storeId: params['storeId'],
                    workingHoursJson: params['workingHoursJson'],
                  ),
        ),
        'updateStoreExtendedProfile': _i1.MethodConnector(
          name: 'updateStoreExtendedProfile',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'aboutText': _i1.ParameterDescription(
              name: 'aboutText',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'tagline': _i1.ParameterDescription(
              name: 'tagline',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'whatsappNumber': _i1.ParameterDescription(
              name: 'whatsappNumber',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'websiteUrl': _i1.ParameterDescription(
              name: 'websiteUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'facebookUrl': _i1.ParameterDescription(
              name: 'facebookUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'instagramUrl': _i1.ParameterDescription(
              name: 'instagramUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'acceptsCash': _i1.ParameterDescription(
              name: 'acceptsCash',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'acceptsCard': _i1.ParameterDescription(
              name: 'acceptsCard',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'hasDelivery': _i1.ParameterDescription(
              name: 'hasDelivery',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'hasPickup': _i1.ParameterDescription(
              name: 'hasPickup',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['store'] as _i34.StoreEndpoint)
                  .updateStoreExtendedProfile(
                    session,
                    userId: params['userId'],
                    storeId: params['storeId'],
                    aboutText: params['aboutText'],
                    tagline: params['tagline'],
                    whatsappNumber: params['whatsappNumber'],
                    websiteUrl: params['websiteUrl'],
                    facebookUrl: params['facebookUrl'],
                    instagramUrl: params['instagramUrl'],
                    acceptsCash: params['acceptsCash'],
                    acceptsCard: params['acceptsCard'],
                    hasDelivery: params['hasDelivery'],
                    hasPickup: params['hasPickup'],
                  ),
        ),
        'updateStoreGallery': _i1.MethodConnector(
          name: 'updateStoreGallery',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'imageUrls': _i1.ParameterDescription(
              name: 'imageUrls',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['store'] as _i34.StoreEndpoint).updateStoreGallery(
                    session,
                    userId: params['userId'],
                    storeId: params['storeId'],
                    imageUrls: params['imageUrls'],
                  ),
        ),
        'addGalleryImage': _i1.MethodConnector(
          name: 'addGalleryImage',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['store'] as _i34.StoreEndpoint).addGalleryImage(
                    session,
                    userId: params['userId'],
                    storeId: params['storeId'],
                    imageUrl: params['imageUrl'],
                  ),
        ),
        'removeGalleryImage': _i1.MethodConnector(
          name: 'removeGalleryImage',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['store'] as _i34.StoreEndpoint).removeGalleryImage(
                    session,
                    userId: params['userId'],
                    storeId: params['storeId'],
                    imageUrl: params['imageUrl'],
                  ),
        ),
        'toggleStoreOpen': _i1.MethodConnector(
          name: 'toggleStoreOpen',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isOpen': _i1.ParameterDescription(
              name: 'isOpen',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['store'] as _i34.StoreEndpoint).toggleStoreOpen(
                    session,
                    userId: params['userId'],
                    storeId: params['storeId'],
                    isOpen: params['isOpen'],
                  ),
        ),
        'toggleStoreActive': _i1.MethodConnector(
          name: 'toggleStoreActive',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isActive': _i1.ParameterDescription(
              name: 'isActive',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['store'] as _i34.StoreEndpoint).toggleStoreActive(
                    session,
                    userId: params['userId'],
                    storeId: params['storeId'],
                    isActive: params['isActive'],
                  ),
        ),
        'getNearbyStores': _i1.MethodConnector(
          name: 'getNearbyStores',
          params: {
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'openOnly': _i1.ParameterDescription(
              name: 'openOnly',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['store'] as _i34.StoreEndpoint).getNearbyStores(
                    session,
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    radiusKm: params['radiusKm'],
                    categoryId: params['categoryId'],
                    openOnly: params['openOnly'],
                  ),
        ),
        'getStoresByCategory': _i1.MethodConnector(
          name: 'getStoresByCategory',
          params: {
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'openOnly': _i1.ParameterDescription(
              name: 'openOnly',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['store'] as _i34.StoreEndpoint)
                  .getStoresByCategory(
                    session,
                    categoryId: params['categoryId'],
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    openOnly: params['openOnly'],
                  ),
        ),
        'searchStores': _i1.MethodConnector(
          name: 'searchStores',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['store'] as _i34.StoreEndpoint).searchStores(
                    session,
                    query: params['query'],
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    categoryId: params['categoryId'],
                  ),
        ),
        'isWithinDeliveryZone': _i1.MethodConnector(
          name: 'isWithinDeliveryZone',
          params: {
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'clientLatitude': _i1.ParameterDescription(
              name: 'clientLatitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'clientLongitude': _i1.ParameterDescription(
              name: 'clientLongitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['store'] as _i34.StoreEndpoint)
                  .isWithinDeliveryZone(
                    session,
                    storeId: params['storeId'],
                    clientLatitude: params['clientLatitude'],
                    clientLongitude: params['clientLongitude'],
                  ),
        ),
      },
    );
    connectors['storeOrder'] = _i1.EndpointConnector(
      name: 'storeOrder',
      endpoint: endpoints['storeOrder']!,
      methodConnectors: {
        'createOrder': _i1.MethodConnector(
          name: 'createOrder',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'items': _i1.ParameterDescription(
              name: 'items',
              type: _i1.getType<List<_i61.OrderItem>>(),
              nullable: false,
            ),
            'deliveryAddress': _i1.ParameterDescription(
              name: 'deliveryAddress',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'deliveryLatitude': _i1.ParameterDescription(
              name: 'deliveryLatitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'deliveryLongitude': _i1.ParameterDescription(
              name: 'deliveryLongitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'clientNotes': _i1.ParameterDescription(
              name: 'clientNotes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeOrder'] as _i35.StoreOrderEndpoint)
                  .createOrder(
                    session,
                    clientId: params['clientId'],
                    storeId: params['storeId'],
                    items: params['items'],
                    deliveryAddress: params['deliveryAddress'],
                    deliveryLatitude: params['deliveryLatitude'],
                    deliveryLongitude: params['deliveryLongitude'],
                    clientNotes: params['clientNotes'],
                  ),
        ),
        'getOrder': _i1.MethodConnector(
          name: 'getOrder',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeOrder'] as _i35.StoreOrderEndpoint).getOrder(
                    session,
                    params['orderId'],
                  ),
        ),
        'getOrderByNumber': _i1.MethodConnector(
          name: 'getOrderByNumber',
          params: {
            'orderNumber': _i1.ParameterDescription(
              name: 'orderNumber',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeOrder'] as _i35.StoreOrderEndpoint)
                  .getOrderByNumber(
                    session,
                    params['orderNumber'],
                  ),
        ),
        'getClientOrders': _i1.MethodConnector(
          name: 'getClientOrders',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i42.StoreOrderStatus?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeOrder'] as _i35.StoreOrderEndpoint)
                  .getClientOrders(
                    session,
                    clientId: params['clientId'],
                    status: params['status'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getClientActiveOrders': _i1.MethodConnector(
          name: 'getClientActiveOrders',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeOrder'] as _i35.StoreOrderEndpoint)
                  .getClientActiveOrders(
                    session,
                    clientId: params['clientId'],
                  ),
        ),
        'cancelOrder': _i1.MethodConnector(
          name: 'cancelOrder',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeOrder'] as _i35.StoreOrderEndpoint)
                  .cancelOrder(
                    session,
                    clientId: params['clientId'],
                    orderId: params['orderId'],
                    reason: params['reason'],
                  ),
        ),
        'getStoreOrders': _i1.MethodConnector(
          name: 'getStoreOrders',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i42.StoreOrderStatus?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeOrder'] as _i35.StoreOrderEndpoint)
                  .getStoreOrders(
                    session,
                    userId: params['userId'],
                    storeId: params['storeId'],
                    status: params['status'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getStorePendingOrders': _i1.MethodConnector(
          name: 'getStorePendingOrders',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeOrder'] as _i35.StoreOrderEndpoint)
                  .getStorePendingOrders(
                    session,
                    userId: params['userId'],
                    storeId: params['storeId'],
                  ),
        ),
        'confirmOrder': _i1.MethodConnector(
          name: 'confirmOrder',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeNotes': _i1.ParameterDescription(
              name: 'storeNotes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeOrder'] as _i35.StoreOrderEndpoint)
                  .confirmOrder(
                    session,
                    userId: params['userId'],
                    orderId: params['orderId'],
                    storeNotes: params['storeNotes'],
                  ),
        ),
        'rejectOrder': _i1.MethodConnector(
          name: 'rejectOrder',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeOrder'] as _i35.StoreOrderEndpoint)
                  .rejectOrder(
                    session,
                    userId: params['userId'],
                    orderId: params['orderId'],
                    reason: params['reason'],
                  ),
        ),
        'markPreparing': _i1.MethodConnector(
          name: 'markPreparing',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeOrder'] as _i35.StoreOrderEndpoint)
                  .markPreparing(
                    session,
                    userId: params['userId'],
                    orderId: params['orderId'],
                  ),
        ),
        'markReady': _i1.MethodConnector(
          name: 'markReady',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeOrder'] as _i35.StoreOrderEndpoint)
                  .markReady(
                    session,
                    userId: params['userId'],
                    orderId: params['orderId'],
                  ),
        ),
        'assignDriver': _i1.MethodConnector(
          name: 'assignDriver',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeOrder'] as _i35.StoreOrderEndpoint)
                  .assignDriver(
                    session,
                    userId: params['userId'],
                    orderId: params['orderId'],
                    driverId: params['driverId'],
                  ),
        ),
        'driverArrivedAtStore': _i1.MethodConnector(
          name: 'driverArrivedAtStore',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeOrder'] as _i35.StoreOrderEndpoint)
                  .driverArrivedAtStore(
                    session,
                    driverId: params['driverId'],
                    orderId: params['orderId'],
                  ),
        ),
        'driverPickedUp': _i1.MethodConnector(
          name: 'driverPickedUp',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeOrder'] as _i35.StoreOrderEndpoint)
                  .driverPickedUp(
                    session,
                    driverId: params['driverId'],
                    orderId: params['orderId'],
                  ),
        ),
        'driverInDelivery': _i1.MethodConnector(
          name: 'driverInDelivery',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeOrder'] as _i35.StoreOrderEndpoint)
                  .driverInDelivery(
                    session,
                    driverId: params['driverId'],
                    orderId: params['orderId'],
                  ),
        ),
        'driverDelivered': _i1.MethodConnector(
          name: 'driverDelivered',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeOrder'] as _i35.StoreOrderEndpoint)
                  .driverDelivered(
                    session,
                    driverId: params['driverId'],
                    orderId: params['orderId'],
                  ),
        ),
        'getDriverStoreOrders': _i1.MethodConnector(
          name: 'getDriverStoreOrders',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'activeOnly': _i1.ParameterDescription(
              name: 'activeOnly',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeOrder'] as _i35.StoreOrderEndpoint)
                  .getDriverStoreOrders(
                    session,
                    driverId: params['driverId'],
                    activeOnly: params['activeOnly'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
      },
    );
    connectors['storeProduct'] = _i1.EndpointConnector(
      name: 'storeProduct',
      endpoint: endpoints['storeProduct']!,
      methodConnectors: {
        'createProductCategory': _i1.MethodConnector(
          name: 'createProductCategory',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'displayOrder': _i1.ParameterDescription(
              name: 'displayOrder',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeProduct'] as _i36.StoreProductEndpoint)
                      .createProductCategory(
                        session,
                        userId: params['userId'],
                        storeId: params['storeId'],
                        name: params['name'],
                        imageUrl: params['imageUrl'],
                        displayOrder: params['displayOrder'],
                      ),
        ),
        'getProductCategories': _i1.MethodConnector(
          name: 'getProductCategories',
          params: {
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'activeOnly': _i1.ParameterDescription(
              name: 'activeOnly',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeProduct'] as _i36.StoreProductEndpoint)
                      .getProductCategories(
                        session,
                        storeId: params['storeId'],
                        activeOnly: params['activeOnly'],
                      ),
        ),
        'updateProductCategory': _i1.MethodConnector(
          name: 'updateProductCategory',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'displayOrder': _i1.ParameterDescription(
              name: 'displayOrder',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeProduct'] as _i36.StoreProductEndpoint)
                      .updateProductCategory(
                        session,
                        userId: params['userId'],
                        categoryId: params['categoryId'],
                        name: params['name'],
                        imageUrl: params['imageUrl'],
                        displayOrder: params['displayOrder'],
                      ),
        ),
        'toggleCategoryActive': _i1.MethodConnector(
          name: 'toggleCategoryActive',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isActive': _i1.ParameterDescription(
              name: 'isActive',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeProduct'] as _i36.StoreProductEndpoint)
                      .toggleCategoryActive(
                        session,
                        userId: params['userId'],
                        categoryId: params['categoryId'],
                        isActive: params['isActive'],
                      ),
        ),
        'deleteProductCategory': _i1.MethodConnector(
          name: 'deleteProductCategory',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeProduct'] as _i36.StoreProductEndpoint)
                      .deleteProductCategory(
                        session,
                        userId: params['userId'],
                        categoryId: params['categoryId'],
                      ),
        ),
        'addProduct': _i1.MethodConnector(
          name: 'addProduct',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'productCategoryId': _i1.ParameterDescription(
              name: 'productCategoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'price': _i1.ParameterDescription(
              name: 'price',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'displayOrder': _i1.ParameterDescription(
              name: 'displayOrder',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeProduct'] as _i36.StoreProductEndpoint)
                      .addProduct(
                        session,
                        userId: params['userId'],
                        storeId: params['storeId'],
                        productCategoryId: params['productCategoryId'],
                        name: params['name'],
                        description: params['description'],
                        price: params['price'],
                        imageUrl: params['imageUrl'],
                        displayOrder: params['displayOrder'],
                      ),
        ),
        'getProducts': _i1.MethodConnector(
          name: 'getProducts',
          params: {
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'availableOnly': _i1.ParameterDescription(
              name: 'availableOnly',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeProduct'] as _i36.StoreProductEndpoint)
                      .getProducts(
                        session,
                        storeId: params['storeId'],
                        categoryId: params['categoryId'],
                        availableOnly: params['availableOnly'],
                      ),
        ),
        'getProductById': _i1.MethodConnector(
          name: 'getProductById',
          params: {
            'productId': _i1.ParameterDescription(
              name: 'productId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeProduct'] as _i36.StoreProductEndpoint)
                      .getProductById(
                        session,
                        params['productId'],
                      ),
        ),
        'updateProduct': _i1.MethodConnector(
          name: 'updateProduct',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'productId': _i1.ParameterDescription(
              name: 'productId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'productCategoryId': _i1.ParameterDescription(
              name: 'productCategoryId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'price': _i1.ParameterDescription(
              name: 'price',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'displayOrder': _i1.ParameterDescription(
              name: 'displayOrder',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeProduct'] as _i36.StoreProductEndpoint)
                      .updateProduct(
                        session,
                        userId: params['userId'],
                        productId: params['productId'],
                        productCategoryId: params['productCategoryId'],
                        name: params['name'],
                        description: params['description'],
                        price: params['price'],
                        imageUrl: params['imageUrl'],
                        displayOrder: params['displayOrder'],
                      ),
        ),
        'toggleProductAvailability': _i1.MethodConnector(
          name: 'toggleProductAvailability',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'productId': _i1.ParameterDescription(
              name: 'productId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isAvailable': _i1.ParameterDescription(
              name: 'isAvailable',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeProduct'] as _i36.StoreProductEndpoint)
                      .toggleProductAvailability(
                        session,
                        userId: params['userId'],
                        productId: params['productId'],
                        isAvailable: params['isAvailable'],
                      ),
        ),
        'deleteProduct': _i1.MethodConnector(
          name: 'deleteProduct',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'productId': _i1.ParameterDescription(
              name: 'productId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeProduct'] as _i36.StoreProductEndpoint)
                      .deleteProduct(
                        session,
                        userId: params['userId'],
                        productId: params['productId'],
                      ),
        ),
        'reorderProducts': _i1.MethodConnector(
          name: 'reorderProducts',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'productIds': _i1.ParameterDescription(
              name: 'productIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeProduct'] as _i36.StoreProductEndpoint)
                      .reorderProducts(
                        session,
                        userId: params['userId'],
                        storeId: params['storeId'],
                        productIds: params['productIds'],
                      ),
        ),
        'searchProducts': _i1.MethodConnector(
          name: 'searchProducts',
          params: {
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['storeProduct'] as _i36.StoreProductEndpoint)
                      .searchProducts(
                        session,
                        storeId: params['storeId'],
                        query: params['query'],
                      ),
        ),
      },
    );
    connectors['storeReview'] = _i1.EndpointConnector(
      name: 'storeReview',
      endpoint: endpoints['storeReview']!,
      methodConnectors: {
        'createStoreReview': _i1.MethodConnector(
          name: 'createStoreReview',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'rating': _i1.ParameterDescription(
              name: 'rating',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'comment': _i1.ParameterDescription(
              name: 'comment',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'foodQualityRating': _i1.ParameterDescription(
              name: 'foodQualityRating',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'packagingRating': _i1.ParameterDescription(
              name: 'packagingRating',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeReview'] as _i37.StoreReviewEndpoint)
                  .createStoreReview(
                    session,
                    orderId: params['orderId'],
                    storeId: params['storeId'],
                    clientId: params['clientId'],
                    rating: params['rating'],
                    comment: params['comment'],
                    foodQualityRating: params['foodQualityRating'],
                    packagingRating: params['packagingRating'],
                  ),
        ),
        'createDriverReviewForStoreOrder': _i1.MethodConnector(
          name: 'createDriverReviewForStoreOrder',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'rating': _i1.ParameterDescription(
              name: 'rating',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'comment': _i1.ParameterDescription(
              name: 'comment',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeReview'] as _i37.StoreReviewEndpoint)
                  .createDriverReviewForStoreOrder(
                    session,
                    orderId: params['orderId'],
                    driverId: params['driverId'],
                    clientId: params['clientId'],
                    rating: params['rating'],
                    comment: params['comment'],
                  ),
        ),
        'getStoreReviews': _i1.MethodConnector(
          name: 'getStoreReviews',
          params: {
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeReview'] as _i37.StoreReviewEndpoint)
                  .getStoreReviews(
                    session,
                    storeId: params['storeId'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getDriverStoreReviews': _i1.MethodConnector(
          name: 'getDriverStoreReviews',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeReview'] as _i37.StoreReviewEndpoint)
                  .getDriverStoreReviews(
                    session,
                    driverId: params['driverId'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getReviewsForReviewee': _i1.MethodConnector(
          name: 'getReviewsForReviewee',
          params: {
            'revieweeType': _i1.ParameterDescription(
              name: 'revieweeType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'revieweeId': _i1.ParameterDescription(
              name: 'revieweeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeReview'] as _i37.StoreReviewEndpoint)
                  .getReviewsForReviewee(
                    session,
                    revieweeType: params['revieweeType'],
                    revieweeId: params['revieweeId'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getReviewsByClient': _i1.MethodConnector(
          name: 'getReviewsByClient',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeReview'] as _i37.StoreReviewEndpoint)
                  .getReviewsByClient(
                    session,
                    clientId: params['clientId'],
                    limit: params['limit'],
                  ),
        ),
        'respondToReview': _i1.MethodConnector(
          name: 'respondToReview',
          params: {
            'reviewId': _i1.ParameterDescription(
              name: 'reviewId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'response': _i1.ParameterDescription(
              name: 'response',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeReview'] as _i37.StoreReviewEndpoint)
                  .respondToReview(
                    session,
                    reviewId: params['reviewId'],
                    storeId: params['storeId'],
                    response: params['response'],
                  ),
        ),
        'getStoreRatingStats': _i1.MethodConnector(
          name: 'getStoreRatingStats',
          params: {
            'storeId': _i1.ParameterDescription(
              name: 'storeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['storeReview'] as _i37.StoreReviewEndpoint)
                  .getStoreRatingStats(
                    session,
                    storeId: params['storeId'],
                  ),
        ),
      },
    );
    connectors['transaction'] = _i1.EndpointConnector(
      name: 'transaction',
      endpoint: endpoints['transaction']!,
      methodConnectors: {
        'getPlatformCommissionRate': _i1.MethodConnector(
          name: 'getPlatformCommissionRate',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['transaction'] as _i38.TransactionEndpoint)
                  .getPlatformCommissionRate(session),
        ),
        'setPlatformCommissionRate': _i1.MethodConnector(
          name: 'setPlatformCommissionRate',
          params: {
            'rate': _i1.ParameterDescription(
              name: 'rate',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['transaction'] as _i38.TransactionEndpoint)
                  .setPlatformCommissionRate(
                    session,
                    params['rate'],
                  ),
        ),
        'recordCashPayment': _i1.MethodConnector(
          name: 'recordCashPayment',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'amount': _i1.ParameterDescription(
              name: 'amount',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['transaction'] as _i38.TransactionEndpoint)
                  .recordCashPayment(
                    session,
                    params['requestId'],
                    params['clientId'],
                    params['driverId'],
                    params['amount'],
                    notes: params['notes'],
                  ),
        ),
        'getTransactionHistory': _i1.MethodConnector(
          name: 'getTransactionHistory',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['transaction'] as _i38.TransactionEndpoint)
                  .getTransactionHistory(
                    session,
                    params['userId'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getDriverEarnings': _i1.MethodConnector(
          name: 'getDriverEarnings',
          params: {
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['transaction'] as _i38.TransactionEndpoint)
                  .getDriverEarnings(
                    session,
                    params['driverId'],
                    startDate: params['startDate'],
                    endDate: params['endDate'],
                  ),
        ),
        'getWallet': _i1.MethodConnector(
          name: 'getWallet',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['transaction'] as _i38.TransactionEndpoint)
                  .getWallet(
                    session,
                    params['userId'],
                  ),
        ),
        'confirmCashPayment': _i1.MethodConnector(
          name: 'confirmCashPayment',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'driverId': _i1.ParameterDescription(
              name: 'driverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['transaction'] as _i38.TransactionEndpoint)
                  .confirmCashPayment(
                    session,
                    params['requestId'],
                    params['driverId'],
                    notes: params['notes'],
                  ),
        ),
        'confirmCashPaymentByClient': _i1.MethodConnector(
          name: 'confirmCashPaymentByClient',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['transaction'] as _i38.TransactionEndpoint)
                  .confirmCashPaymentByClient(
                    session,
                    params['requestId'],
                    params['clientId'],
                    notes: params['notes'],
                  ),
        ),
      },
    );
    connectors['trustScore'] = _i1.EndpointConnector(
      name: 'trustScore',
      endpoint: endpoints['trustScore']!,
      methodConnectors: {
        'getClientTrustScore': _i1.MethodConnector(
          name: 'getClientTrustScore',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['trustScore'] as _i39.TrustScoreEndpoint)
                  .getClientTrustScore(
                    session,
                    params['clientId'],
                  ),
        ),
        'getQuickTrustBadge': _i1.MethodConnector(
          name: 'getQuickTrustBadge',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['trustScore'] as _i39.TrustScoreEndpoint)
                  .getQuickTrustBadge(
                    session,
                    params['clientId'],
                  ),
        ),
        'refreshTrustScore': _i1.MethodConnector(
          name: 'refreshTrustScore',
          params: {
            'clientId': _i1.ParameterDescription(
              name: 'clientId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['trustScore'] as _i39.TrustScoreEndpoint)
                  .refreshTrustScore(
                    session,
                    params['clientId'],
                  ),
        ),
        'batchComputeTrustScores': _i1.MethodConnector(
          name: 'batchComputeTrustScores',
          params: {
            'clientIds': _i1.ParameterDescription(
              name: 'clientIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['trustScore'] as _i39.TrustScoreEndpoint)
                  .batchComputeTrustScores(
                    session,
                    params['clientIds'],
                  ),
        ),
        'getPlatformTrustStats': _i1.MethodConnector(
          name: 'getPlatformTrustStats',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['trustScore'] as _i39.TrustScoreEndpoint)
                  .getPlatformTrustStats(session),
        ),
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'updateProfile': _i1.MethodConnector(
          name: 'updateProfile',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'fullName': _i1.ParameterDescription(
              name: 'fullName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'phoneNumber': _i1.ParameterDescription(
              name: 'phoneNumber',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'preferredLanguage': _i1.ParameterDescription(
              name: 'preferredLanguage',
              type: _i1.getType<_i62.Language?>(),
              nullable: true,
            ),
            'notificationsEnabled': _i1.ParameterDescription(
              name: 'notificationsEnabled',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'darkModeEnabled': _i1.ParameterDescription(
              name: 'darkModeEnabled',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i40.UserEndpoint).updateProfile(
                session,
                userId: params['userId'],
                fullName: params['fullName'],
                email: params['email'],
                phoneNumber: params['phoneNumber'],
                preferredLanguage: params['preferredLanguage'],
                notificationsEnabled: params['notificationsEnabled'],
                darkModeEnabled: params['darkModeEnabled'],
              ),
        ),
        'updateFCMToken': _i1.MethodConnector(
          name: 'updateFCMToken',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'fcmToken': _i1.ParameterDescription(
              name: 'fcmToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i40.UserEndpoint).updateFCMToken(
                    session,
                    userId: params['userId'],
                    fcmToken: params['fcmToken'],
                  ),
        ),
        'clearFCMToken': _i1.MethodConnector(
          name: 'clearFCMToken',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i40.UserEndpoint).clearFCMToken(
                session,
                userId: params['userId'],
              ),
        ),
        'fixPhotoUrls': _i1.MethodConnector(
          name: 'fixPhotoUrls',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i40.UserEndpoint).fixPhotoUrls(
                session,
                userId: params['userId'],
              ),
        ),
        'uploadProfilePhoto': _i1.MethodConnector(
          name: 'uploadProfilePhoto',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'photoData': _i1.ParameterDescription(
              name: 'photoData',
              type: _i1.getType<_i51.ByteData>(),
              nullable: false,
            ),
            'fileName': _i1.ParameterDescription(
              name: 'fileName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i40.UserEndpoint).uploadProfilePhoto(
                    session,
                    userId: params['userId'],
                    photoData: params['photoData'],
                    fileName: params['fileName'],
                  ),
        ),
        'deleteAccount': _i1.MethodConnector(
          name: 'deleteAccount',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i40.UserEndpoint).deleteAccount(
                session,
                userId: params['userId'],
                reason: params['reason'],
              ),
        ),
        'getUserById': _i1.MethodConnector(
          name: 'getUserById',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i40.UserEndpoint).getUserById(
                session,
                userId: params['userId'],
              ),
        ),
        'addRole': _i1.MethodConnector(
          name: 'addRole',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<_i47.UserRole>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i40.UserEndpoint).addRole(
                session,
                userId: params['userId'],
                role: params['role'],
              ),
        ),
        'removeRole': _i1.MethodConnector(
          name: 'removeRole',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<_i47.UserRole>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i40.UserEndpoint).removeRole(
                session,
                userId: params['userId'],
                role: params['role'],
              ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i41.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i63.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i64.Endpoints()
      ..initializeEndpoints(server);
  }
}
