/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_local_identifiers

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_test/serverpod_test.dart' as _i1;
import 'package:serverpod/serverpod.dart' as _i2;
import 'dart:async' as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'package:awhar_server/src/generated/admin_login_response.dart' as _i5;
import 'package:awhar_server/src/generated/admin_user.dart' as _i6;
import 'package:awhar_server/src/generated/dashboard_stats.dart' as _i7;
import 'package:awhar_server/src/generated/user.dart' as _i8;
import 'package:awhar_server/src/generated/driver_profile.dart' as _i9;
import 'package:awhar_server/src/generated/store.dart' as _i10;
import 'package:awhar_server/src/generated/store_order.dart' as _i11;
import 'package:awhar_server/src/generated/store_order_status_enum.dart'
    as _i12;
import 'package:awhar_server/src/generated/service_request.dart' as _i13;
import 'package:awhar_server/src/generated/request_status.dart' as _i14;
import 'package:awhar_server/src/generated/transaction.dart' as _i15;
import 'package:awhar_server/src/generated/transaction_status.dart' as _i16;
import 'package:awhar_server/src/generated/report.dart' as _i17;
import 'package:awhar_server/src/generated/report_status_enum.dart' as _i18;
import 'package:awhar_server/src/generated/report_resolution_enum.dart' as _i19;
import 'package:awhar_server/src/generated/recent_activity.dart' as _i20;
import 'package:awhar_server/src/generated/ai_driver_matching_response.dart'
    as _i21;
import 'package:awhar_server/src/generated/ai_request_concierge_response.dart'
    as _i22;
import 'package:awhar_server/src/generated/ai_demand_prediction_response.dart'
    as _i23;
import 'package:awhar_server/src/generated/ai_help_search_response.dart'
    as _i24;
import 'package:awhar_server/src/generated/agent_builder_converse_response.dart'
    as _i25;
import 'package:awhar_server/src/generated/agent_stream_status.dart' as _i26;
import 'package:awhar_server/src/generated/ai_agent_status_response.dart'
    as _i27;
import 'package:awhar_server/src/generated/ai_full_request_response.dart'
    as _i28;
import 'package:awhar_server/src/generated/auth_response.dart' as _i29;
import 'package:awhar_server/src/generated/user_role_enum.dart' as _i30;
import 'package:awhar_server/src/generated/blocked_user.dart' as _i31;
import 'package:awhar_server/src/generated/chat_message.dart' as _i32;
import 'package:awhar_server/src/generated/message_type_enum.dart' as _i33;
import 'package:awhar_server/src/generated/country.dart' as _i34;
import 'package:awhar_server/src/generated/device_fingerprint_check_result.dart'
    as _i35;
import 'package:awhar_server/src/generated/device_fingerprint_input.dart'
    as _i36;
import 'package:awhar_server/src/generated/device_fingerprint_record.dart'
    as _i37;
import 'package:awhar_server/src/generated/driver_service.dart' as _i38;
import 'dart:typed_data' as _i39;
import 'package:awhar_server/src/generated/service_image.dart' as _i40;
import 'package:awhar_server/src/generated/media_metadata.dart' as _i41;
import 'package:awhar_server/src/generated/user_notification.dart' as _i42;
import 'package:awhar_server/src/generated/notification_type.dart' as _i43;
import 'package:awhar_server/src/generated/driver_offer.dart' as _i44;
import 'package:awhar_server/src/generated/order.dart' as _i45;
import 'package:awhar_server/src/generated/canceller_type_enum.dart' as _i46;
import 'package:awhar_server/src/generated/order_status_enum.dart' as _i47;
import 'package:awhar_server/src/generated/promo.dart' as _i48;
import 'package:awhar_server/src/generated/driver_proposal.dart' as _i49;
import 'package:awhar_server/src/generated/rating.dart' as _i50;
import 'package:awhar_server/src/generated/rating_type_enum.dart' as _i51;
import 'package:awhar_server/src/generated/rating_stats.dart' as _i52;
import 'package:awhar_server/src/generated/reporter_type_enum.dart' as _i53;
import 'package:awhar_server/src/generated/report_reason_enum.dart' as _i54;
import 'package:awhar_server/src/generated/service_type.dart' as _i55;
import 'package:awhar_server/src/generated/location.dart' as _i56;
import 'package:awhar_server/src/generated/shopping_item.dart' as _i57;
import 'package:awhar_server/src/generated/client_review.dart' as _i58;
import 'package:awhar_server/src/generated/review.dart' as _i59;
import 'package:awhar_server/src/generated/service_category.dart' as _i60;
import 'package:awhar_server/src/generated/service.dart' as _i61;
import 'package:awhar_server/src/generated/service_analytics.dart' as _i62;
import 'package:awhar_server/src/generated/app_configuration.dart' as _i63;
import 'package:awhar_server/src/generated/nearby_driver.dart' as _i64;
import 'package:awhar_server/src/generated/store_delivery_request.dart' as _i65;
import 'package:awhar_server/src/generated/store_order_chat.dart' as _i66;
import 'package:awhar_server/src/generated/store_order_chat_message.dart'
    as _i67;
import 'package:awhar_server/src/generated/chat_participants_info.dart' as _i68;
import 'package:awhar_server/src/generated/store_category.dart' as _i69;
import 'package:awhar_server/src/generated/order_item.dart' as _i70;
import 'package:awhar_server/src/generated/product_category.dart' as _i71;
import 'package:awhar_server/src/generated/store_product.dart' as _i72;
import 'package:awhar_server/src/generated/store_review.dart' as _i73;
import 'package:awhar_server/src/generated/review_with_reviewer.dart' as _i74;
import 'package:awhar_server/src/generated/driver_earnings_response.dart'
    as _i75;
import 'package:awhar_server/src/generated/wallet.dart' as _i76;
import 'package:awhar_server/src/generated/trust_score_result.dart' as _i77;
import 'package:awhar_server/src/generated/user_response.dart' as _i78;
import 'package:awhar_server/src/generated/language_enum.dart' as _i79;
import 'package:awhar_server/src/generated/greetings/greeting.dart' as _i80;
import 'package:awhar_server/src/generated/protocol.dart';
import 'package:awhar_server/src/generated/endpoints.dart';
export 'package:serverpod_test/serverpod_test_public_exports.dart';

/// Creates a new test group that takes a callback that can be used to write tests.
/// The callback has two parameters: `sessionBuilder` and `endpoints`.
/// `sessionBuilder` is used to build a `Session` object that represents the server state during an endpoint call and is used to set up scenarios.
/// `endpoints` contains all your Serverpod endpoints and lets you call them:
/// ```dart
/// withServerpod('Given Example endpoint', (sessionBuilder, endpoints) {
///   test('when calling `hello` then should return greeting', () async {
///     final greeting = await endpoints.example.hello(sessionBuilder, 'Michael');
///     expect(greeting, 'Hello Michael');
///   });
/// });
/// ```
///
/// **Configuration options**
///
/// [applyMigrations] Whether pending migrations should be applied when starting Serverpod. Defaults to `true`
///
/// [enableSessionLogging] Whether session logging should be enabled. Defaults to `false`
///
/// [rollbackDatabase] Options for when to rollback the database during the test lifecycle.
/// By default `withServerpod` does all database operations inside a transaction that is rolled back after each `test` case.
/// Just like the following enum describes, the behavior of the automatic rollbacks can be configured:
/// ```dart
/// /// Options for when to rollback the database during the test lifecycle.
/// enum RollbackDatabase {
///   /// After each test. This is the default.
///   afterEach,
///
///   /// After all tests.
///   afterAll,
///
///   /// Disable rolling back the database.
///   disabled,
/// }
/// ```
///
/// [runMode] The run mode that Serverpod should be running in. Defaults to `test`.
///
/// [serverpodLoggingMode] The logging mode used when creating Serverpod. Defaults to `ServerpodLoggingMode.normal`
///
/// [serverpodStartTimeout] The timeout to use when starting Serverpod, which connects to the database among other things. Defaults to `Duration(seconds: 30)`.
///
/// [testServerOutputMode] Options for controlling test server output during test execution. Defaults to `TestServerOutputMode.normal`.
/// ```dart
/// /// Options for controlling test server output during test execution.
/// enum TestServerOutputMode {
///   /// Default mode - only stderr is printed (stdout suppressed).
///   /// This hides normal startup/shutdown logs while preserving error messages.
///   normal,
///
///   /// All logging - both stdout and stderr are printed.
///   /// Useful for debugging when you need to see all server output.
///   verbose,
///
///   /// No logging - both stdout and stderr are suppressed.
///   /// Completely silent mode, useful when you don't want any server output.
///   silent,
/// }
/// ```
///
/// [testGroupTagsOverride] By default Serverpod test tools tags the `withServerpod` test group with `"integration"`.
/// This is to provide a simple way to only run unit or integration tests.
/// This property allows this tag to be overridden to something else. Defaults to `['integration']`.
///
/// [experimentalFeatures] Optionally specify experimental features. See [Serverpod] for more information.
@_i1.isTestGroup
void withServerpod(
  String testGroupName,
  _i1.TestClosure<TestEndpoints> testClosure, {
  bool? applyMigrations,
  bool? enableSessionLogging,
  _i2.ExperimentalFeatures? experimentalFeatures,
  _i1.RollbackDatabase? rollbackDatabase,
  String? runMode,
  _i2.RuntimeParametersListBuilder? runtimeParametersBuilder,
  _i2.ServerpodLoggingMode? serverpodLoggingMode,
  Duration? serverpodStartTimeout,
  List<String>? testGroupTagsOverride,
  _i1.TestServerOutputMode? testServerOutputMode,
}) {
  _i1.buildWithServerpod<_InternalTestEndpoints>(
    testGroupName,
    _i1.TestServerpod(
      testEndpoints: _InternalTestEndpoints(),
      endpoints: Endpoints(),
      serializationManager: Protocol(),
      runMode: runMode,
      applyMigrations: applyMigrations,
      isDatabaseEnabled: true,
      serverpodLoggingMode: serverpodLoggingMode,
      testServerOutputMode: testServerOutputMode,
      experimentalFeatures: experimentalFeatures,
      runtimeParametersBuilder: runtimeParametersBuilder,
    ),
    maybeRollbackDatabase: rollbackDatabase,
    maybeEnableSessionLogging: enableSessionLogging,
    maybeTestGroupTagsOverride: testGroupTagsOverride,
    maybeServerpodStartTimeout: serverpodStartTimeout,
    maybeTestServerOutputMode: testServerOutputMode,
  )(testClosure);
}

class TestEndpoints {
  late final _EmailIdpEndpoint emailIdp;

  late final _JwtRefreshEndpoint jwtRefresh;

  late final _AdminEndpoint admin;

  late final _AgentEndpoint agent;

  late final _AnalyticsEndpoint analytics;

  late final _FirebaseAuthEndpoint firebaseAuth;

  late final _BlockedUserEndpoint blockedUser;

  late final _ChatEndpoint chat;

  late final _CountryEndpoint country;

  late final _DeviceFingerprintEndpoint deviceFingerprint;

  late final _DriverEndpoint driver;

  late final _DriverStatusEndpoint driverStatus;

  late final _ElasticsearchEndpoint elasticsearch;

  late final _EmailEndpoint email;

  late final _RefreshJwtTokensEndpoint refreshJwtTokens;

  late final _LocationEndpoint location;

  late final _McpProxyEndpoint mcpProxy;

  late final _MediaEndpoint media;

  late final _NotificationEndpoint notification;

  late final _NotificationPlannerEndpoint notificationPlanner;

  late final _OfferEndpoint offer;

  late final _OrderEndpoint order;

  late final _PromoEndpoint promo;

  late final _ProposalEndpoint proposal;

  late final _RatingEndpoint rating;

  late final _ReportEndpoint report;

  late final _RequestEndpoint request;

  late final _ReviewEndpoint review;

  late final _SearchEndpoint search;

  late final _ServiceEndpoint service;

  late final _SettingsEndpoint settings;

  late final _StoreDeliveryEndpoint storeDelivery;

  late final _StoreEndpoint store;

  late final _StoreOrderEndpoint storeOrder;

  late final _StoreProductEndpoint storeProduct;

  late final _StoreReviewEndpoint storeReview;

  late final _TransactionEndpoint transaction;

  late final _TrustScoreEndpoint trustScore;

  late final _UserEndpoint user;

  late final _GreetingEndpoint greeting;
}

class _InternalTestEndpoints extends TestEndpoints
    implements _i1.InternalTestEndpoints {
  @override
  void initialize(
    _i2.SerializationManager serializationManager,
    _i2.EndpointDispatch endpoints,
  ) {
    emailIdp = _EmailIdpEndpoint(
      endpoints,
      serializationManager,
    );
    jwtRefresh = _JwtRefreshEndpoint(
      endpoints,
      serializationManager,
    );
    admin = _AdminEndpoint(
      endpoints,
      serializationManager,
    );
    agent = _AgentEndpoint(
      endpoints,
      serializationManager,
    );
    analytics = _AnalyticsEndpoint(
      endpoints,
      serializationManager,
    );
    firebaseAuth = _FirebaseAuthEndpoint(
      endpoints,
      serializationManager,
    );
    blockedUser = _BlockedUserEndpoint(
      endpoints,
      serializationManager,
    );
    chat = _ChatEndpoint(
      endpoints,
      serializationManager,
    );
    country = _CountryEndpoint(
      endpoints,
      serializationManager,
    );
    deviceFingerprint = _DeviceFingerprintEndpoint(
      endpoints,
      serializationManager,
    );
    driver = _DriverEndpoint(
      endpoints,
      serializationManager,
    );
    driverStatus = _DriverStatusEndpoint(
      endpoints,
      serializationManager,
    );
    elasticsearch = _ElasticsearchEndpoint(
      endpoints,
      serializationManager,
    );
    email = _EmailEndpoint(
      endpoints,
      serializationManager,
    );
    refreshJwtTokens = _RefreshJwtTokensEndpoint(
      endpoints,
      serializationManager,
    );
    location = _LocationEndpoint(
      endpoints,
      serializationManager,
    );
    mcpProxy = _McpProxyEndpoint(
      endpoints,
      serializationManager,
    );
    media = _MediaEndpoint(
      endpoints,
      serializationManager,
    );
    notification = _NotificationEndpoint(
      endpoints,
      serializationManager,
    );
    notificationPlanner = _NotificationPlannerEndpoint(
      endpoints,
      serializationManager,
    );
    offer = _OfferEndpoint(
      endpoints,
      serializationManager,
    );
    order = _OrderEndpoint(
      endpoints,
      serializationManager,
    );
    promo = _PromoEndpoint(
      endpoints,
      serializationManager,
    );
    proposal = _ProposalEndpoint(
      endpoints,
      serializationManager,
    );
    rating = _RatingEndpoint(
      endpoints,
      serializationManager,
    );
    report = _ReportEndpoint(
      endpoints,
      serializationManager,
    );
    request = _RequestEndpoint(
      endpoints,
      serializationManager,
    );
    review = _ReviewEndpoint(
      endpoints,
      serializationManager,
    );
    search = _SearchEndpoint(
      endpoints,
      serializationManager,
    );
    service = _ServiceEndpoint(
      endpoints,
      serializationManager,
    );
    settings = _SettingsEndpoint(
      endpoints,
      serializationManager,
    );
    storeDelivery = _StoreDeliveryEndpoint(
      endpoints,
      serializationManager,
    );
    store = _StoreEndpoint(
      endpoints,
      serializationManager,
    );
    storeOrder = _StoreOrderEndpoint(
      endpoints,
      serializationManager,
    );
    storeProduct = _StoreProductEndpoint(
      endpoints,
      serializationManager,
    );
    storeReview = _StoreReviewEndpoint(
      endpoints,
      serializationManager,
    );
    transaction = _TransactionEndpoint(
      endpoints,
      serializationManager,
    );
    trustScore = _TrustScoreEndpoint(
      endpoints,
      serializationManager,
    );
    user = _UserEndpoint(
      endpoints,
      serializationManager,
    );
    greeting = _GreetingEndpoint(
      endpoints,
      serializationManager,
    );
  }
}

class _EmailIdpEndpoint {
  _EmailIdpEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i4.AuthSuccess> login(
    _i1.TestSessionBuilder sessionBuilder, {
    required String email,
    required String password,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'login',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'login',
          parameters: _i1.testObjectToJson({
            'email': email,
            'password': password,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i4.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i2.UuidValue> startRegistration(
    _i1.TestSessionBuilder sessionBuilder, {
    required String email,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'startRegistration',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'startRegistration',
          parameters: _i1.testObjectToJson({'email': email}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i2.UuidValue>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> verifyRegistrationCode(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i2.UuidValue accountRequestId,
    required String verificationCode,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'verifyRegistrationCode',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'verifyRegistrationCode',
          parameters: _i1.testObjectToJson({
            'accountRequestId': accountRequestId,
            'verificationCode': verificationCode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i4.AuthSuccess> finishRegistration(
    _i1.TestSessionBuilder sessionBuilder, {
    required String registrationToken,
    required String password,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'finishRegistration',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'finishRegistration',
          parameters: _i1.testObjectToJson({
            'registrationToken': registrationToken,
            'password': password,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i4.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i2.UuidValue> startPasswordReset(
    _i1.TestSessionBuilder sessionBuilder, {
    required String email,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'startPasswordReset',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'startPasswordReset',
          parameters: _i1.testObjectToJson({'email': email}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i2.UuidValue>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> verifyPasswordResetCode(
    _i1.TestSessionBuilder sessionBuilder, {
    required _i2.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'verifyPasswordResetCode',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'verifyPasswordResetCode',
          parameters: _i1.testObjectToJson({
            'passwordResetRequestId': passwordResetRequestId,
            'verificationCode': verificationCode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> finishPasswordReset(
    _i1.TestSessionBuilder sessionBuilder, {
    required String finishPasswordResetToken,
    required String newPassword,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'finishPasswordReset',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'finishPasswordReset',
          parameters: _i1.testObjectToJson({
            'finishPasswordResetToken': finishPasswordResetToken,
            'newPassword': newPassword,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _JwtRefreshEndpoint {
  _JwtRefreshEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i4.AuthSuccess> refreshAccessToken(
    _i1.TestSessionBuilder sessionBuilder, {
    required String refreshToken,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'jwtRefresh',
            method: 'refreshAccessToken',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'jwtRefresh',
          methodName: 'refreshAccessToken',
          parameters: _i1.testObjectToJson({'refreshToken': refreshToken}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i4.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AdminEndpoint {
  _AdminEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i5.AdminLoginResponse> login(
    _i1.TestSessionBuilder sessionBuilder, {
    required String email,
    required String firebaseUid,
    String? password,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'login',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'login',
          parameters: _i1.testObjectToJson({
            'email': email,
            'firebaseUid': firebaseUid,
            'password': password,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i5.AdminLoginResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i5.AdminLoginResponse> loginWithPassword(
    _i1.TestSessionBuilder sessionBuilder, {
    required String email,
    required String password,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'loginWithPassword',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'loginWithPassword',
          parameters: _i1.testObjectToJson({
            'email': email,
            'password': password,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i5.AdminLoginResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> changePassword(
    _i1.TestSessionBuilder sessionBuilder, {
    required int adminId,
    required String currentPassword,
    required String newPassword,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'changePassword',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'changePassword',
          parameters: _i1.testObjectToJson({
            'adminId': adminId,
            'currentPassword': currentPassword,
            'newPassword': newPassword,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i6.AdminUser>> getAllAdmins(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'getAllAdmins',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getAllAdmins',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i6.AdminUser>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.AdminUser?> getAdmin(
    _i1.TestSessionBuilder sessionBuilder, {
    required int adminId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'getAdmin',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getAdmin',
          parameters: _i1.testObjectToJson({'adminId': adminId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i6.AdminUser?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.AdminUser?> createAdmin(
    _i1.TestSessionBuilder sessionBuilder, {
    required String email,
    required String password,
    required String name,
    String? photoUrl,
    required String role,
    List<String>? permissions,
    int? createdBy,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'createAdmin',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'createAdmin',
          parameters: _i1.testObjectToJson({
            'email': email,
            'password': password,
            'name': name,
            'photoUrl': photoUrl,
            'role': role,
            'permissions': permissions,
            'createdBy': createdBy,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i6.AdminUser?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.AdminUser?> updateAdmin(
    _i1.TestSessionBuilder sessionBuilder, {
    required int adminId,
    String? email,
    String? name,
    String? photoUrl,
    String? role,
    List<String>? permissions,
    bool? isActive,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'updateAdmin',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'updateAdmin',
          parameters: _i1.testObjectToJson({
            'adminId': adminId,
            'email': email,
            'name': name,
            'photoUrl': photoUrl,
            'role': role,
            'permissions': permissions,
            'isActive': isActive,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i6.AdminUser?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> resetAdminPassword(
    _i1.TestSessionBuilder sessionBuilder, {
    required int adminId,
    required String newPassword,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'resetAdminPassword',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'resetAdminPassword',
          parameters: _i1.testObjectToJson({
            'adminId': adminId,
            'newPassword': newPassword,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteAdmin(
    _i1.TestSessionBuilder sessionBuilder, {
    required int adminId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'deleteAdmin',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'deleteAdmin',
          parameters: _i1.testObjectToJson({'adminId': adminId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> toggleAdminStatus(
    _i1.TestSessionBuilder sessionBuilder, {
    required int adminId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'toggleAdminStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'toggleAdminStatus',
          parameters: _i1.testObjectToJson({'adminId': adminId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.AdminUser?> getProfile(
    _i1.TestSessionBuilder sessionBuilder, {
    required int adminId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'getProfile',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getProfile',
          parameters: _i1.testObjectToJson({'adminId': adminId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i6.AdminUser?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.AdminUser?> updateProfile(
    _i1.TestSessionBuilder sessionBuilder, {
    required int adminId,
    String? name,
    String? photoUrl,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'updateProfile',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'updateProfile',
          parameters: _i1.testObjectToJson({
            'adminId': adminId,
            'name': name,
            'photoUrl': photoUrl,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i6.AdminUser?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i7.DashboardStats> getDashboardStats(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'getDashboardStats',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getDashboardStats',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i7.DashboardStats>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getUserCount(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'getUserCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getUserCount',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i8.User>> listUsers(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int limit,
    String? search,
    String? role,
    String? status,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'listUsers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'listUsers',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
            'search': search,
            'role': role,
            'status': status,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i8.User>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i9.DriverProfile>> listDrivers(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int limit,
    String? search,
    bool? onlineOnly,
    bool? verifiedOnly,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'listDrivers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'listDrivers',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
            'search': search,
            'onlineOnly': onlineOnly,
            'verifiedOnly': verifiedOnly,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i9.DriverProfile>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i10.Store>> listStores(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int limit,
    String? search,
    bool? activeOnly,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'listStores',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'listStores',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
            'search': search,
            'activeOnly': activeOnly,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i10.Store>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getStoreCount(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'getStoreCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getStoreCount',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> activateStore(
    _i1.TestSessionBuilder sessionBuilder,
    int storeId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'activateStore',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'activateStore',
          parameters: _i1.testObjectToJson({'storeId': storeId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deactivateStore(
    _i1.TestSessionBuilder sessionBuilder, {
    required int storeId,
    String? reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'deactivateStore',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'deactivateStore',
          parameters: _i1.testObjectToJson({
            'storeId': storeId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteStore(
    _i1.TestSessionBuilder sessionBuilder,
    int storeId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'deleteStore',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'deleteStore',
          parameters: _i1.testObjectToJson({'storeId': storeId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> suspendUser(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    String? reason,
    DateTime? suspendUntil,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'suspendUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'suspendUser',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'reason': reason,
            'suspendUntil': suspendUntil,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> unsuspendUser(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'unsuspendUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'unsuspendUser',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> banUser(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    String? reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'banUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'banUser',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteUser(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'deleteUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'deleteUser',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> verifyDriver(
    _i1.TestSessionBuilder sessionBuilder,
    int driverId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'verifyDriver',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'verifyDriver',
          parameters: _i1.testObjectToJson({'driverId': driverId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i8.User?> createAdminUser(
    _i1.TestSessionBuilder sessionBuilder, {
    required String firebaseUid,
    required String email,
    required String fullName,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'createAdminUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'createAdminUser',
          parameters: _i1.testObjectToJson({
            'firebaseUid': firebaseUid,
            'email': email,
            'fullName': fullName,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i8.User?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getDriverCount(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'getDriverCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getDriverCount',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> unverifyDriver(
    _i1.TestSessionBuilder sessionBuilder,
    int driverId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'unverifyDriver',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'unverifyDriver',
          parameters: _i1.testObjectToJson({'driverId': driverId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> suspendDriver(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    String? reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'suspendDriver',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'suspendDriver',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteDriver(
    _i1.TestSessionBuilder sessionBuilder,
    int driverId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'deleteDriver',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'deleteDriver',
          parameters: _i1.testObjectToJson({'driverId': driverId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getOrderCount(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'getOrderCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getOrderCount',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i11.StoreOrder>> listOrders(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int limit,
    _i12.StoreOrderStatus? statusFilter,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'listOrders',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'listOrders',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
            'statusFilter': statusFilter,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i11.StoreOrder>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i13.ServiceRequest>> listRequests(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int limit,
    _i14.RequestStatus? statusFilter,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'listRequests',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'listRequests',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
            'statusFilter': statusFilter,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i13.ServiceRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getRequestCount(
    _i1.TestSessionBuilder sessionBuilder, {
    _i14.RequestStatus? statusFilter,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'getRequestCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getRequestCount',
          parameters: _i1.testObjectToJson({'statusFilter': statusFilter}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.ServiceRequest?> updateRequestStatus(
    _i1.TestSessionBuilder sessionBuilder,
    int requestId,
    _i14.RequestStatus status, {
    String? note,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'updateRequestStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'updateRequestStatus',
          parameters: _i1.testObjectToJson({
            'requestId': requestId,
            'status': status,
            'note': note,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i13.ServiceRequest?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i15.Transaction>> listTransactions(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int limit,
    _i16.TransactionStatus? statusFilter,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'listTransactions',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'listTransactions',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
            'statusFilter': statusFilter,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i15.Transaction>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i17.Report>> listReports(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int limit,
    _i18.ReportStatus? statusFilter,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'listReports',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'listReports',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
            'statusFilter': statusFilter,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i17.Report>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> resolveReport(
    _i1.TestSessionBuilder sessionBuilder, {
    required int reportId,
    required _i19.ReportResolution resolution,
    String? adminNotes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'resolveReport',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'resolveReport',
          parameters: _i1.testObjectToJson({
            'reportId': reportId,
            'resolution': resolution,
            'adminNotes': adminNotes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i20.RecentActivity>> getRecentActivities(
    _i1.TestSessionBuilder sessionBuilder, {
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'getRecentActivities',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'getRecentActivities',
          parameters: _i1.testObjectToJson({'limit': limit}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i20.RecentActivity>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> dismissReport(
    _i1.TestSessionBuilder sessionBuilder, {
    required int reportId,
    String? reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'admin',
            method: 'dismissReport',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'admin',
          methodName: 'dismissReport',
          parameters: _i1.testObjectToJson({
            'reportId': reportId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AgentEndpoint {
  _AgentEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i21.AiDriverMatchingResponse> findBestDrivers(
    _i1.TestSessionBuilder sessionBuilder, {
    int? serviceId,
    int? categoryId,
    required double latitude,
    required double longitude,
    double? radiusKm,
    bool? preferVerified,
    bool? preferPremium,
    double? minRating,
    int? maxResults,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'agent',
            method: 'findBestDrivers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'agent',
          methodName: 'findBestDrivers',
          parameters: _i1.testObjectToJson({
            'serviceId': serviceId,
            'categoryId': categoryId,
            'latitude': latitude,
            'longitude': longitude,
            'radiusKm': radiusKm,
            'preferVerified': preferVerified,
            'preferPremium': preferPremium,
            'minRating': minRating,
            'maxResults': maxResults,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i21.AiDriverMatchingResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i22.AiRequestConciergeResponse> parseServiceRequest(
    _i1.TestSessionBuilder sessionBuilder, {
    required String request,
    String? language,
    double? latitude,
    double? longitude,
    int? userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'agent',
            method: 'parseServiceRequest',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'agent',
          methodName: 'parseServiceRequest',
          parameters: _i1.testObjectToJson({
            'request': request,
            'language': language,
            'latitude': latitude,
            'longitude': longitude,
            'userId': userId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i22.AiRequestConciergeResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i23.AiDemandPredictionResponse> predictDemand(
    _i1.TestSessionBuilder sessionBuilder, {
    required double latitude,
    required double longitude,
    double? radiusKm,
    int? hoursAhead,
    int? categoryId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'agent',
            method: 'predictDemand',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'agent',
          methodName: 'predictDemand',
          parameters: _i1.testObjectToJson({
            'latitude': latitude,
            'longitude': longitude,
            'radiusKm': radiusKm,
            'hoursAhead': hoursAhead,
            'categoryId': categoryId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i23.AiDemandPredictionResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i24.AiHelpSearchResponse> searchHelp(
    _i1.TestSessionBuilder sessionBuilder, {
    required String question,
    String? language,
    String? category,
    int? maxResults,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'agent',
            method: 'searchHelp',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'agent',
          methodName: 'searchHelp',
          parameters: _i1.testObjectToJson({
            'question': question,
            'language': language,
            'category': category,
            'maxResults': maxResults,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i24.AiHelpSearchResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i25.AgentBuilderConverseResponse> converseWithAgent(
    _i1.TestSessionBuilder sessionBuilder, {
    required String agentId,
    required String message,
    String? conversationId,
    String? connectorId,
    int? userId,
    double? latitude,
    double? longitude,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'agent',
            method: 'converseWithAgent',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'agent',
          methodName: 'converseWithAgent',
          parameters: _i1.testObjectToJson({
            'agentId': agentId,
            'message': message,
            'conversationId': conversationId,
            'connectorId': connectorId,
            'userId': userId,
            'latitude': latitude,
            'longitude': longitude,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i25.AgentBuilderConverseResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> startAgentConverse(
    _i1.TestSessionBuilder sessionBuilder, {
    required String agentId,
    required String message,
    String? conversationId,
    String? connectorId,
    int? userId,
    double? latitude,
    double? longitude,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'agent',
            method: 'startAgentConverse',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'agent',
          methodName: 'startAgentConverse',
          parameters: _i1.testObjectToJson({
            'agentId': agentId,
            'message': message,
            'conversationId': conversationId,
            'connectorId': connectorId,
            'userId': userId,
            'latitude': latitude,
            'longitude': longitude,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i26.AgentStreamStatus> pollAgentStream(
    _i1.TestSessionBuilder sessionBuilder, {
    required String streamSessionId,
    int? lastEventIndex,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'agent',
            method: 'pollAgentStream',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'agent',
          methodName: 'pollAgentStream',
          parameters: _i1.testObjectToJson({
            'streamSessionId': streamSessionId,
            'lastEventIndex': lastEventIndex,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i26.AgentStreamStatus>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i27.AiAgentStatusResponse> getAgentStatus(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'agent',
            method: 'getAgentStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'agent',
          methodName: 'getAgentStatus',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i27.AiAgentStatusResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i28.AiFullRequestResponse> processFullRequest(
    _i1.TestSessionBuilder sessionBuilder, {
    required String request,
    required double latitude,
    required double longitude,
    String? language,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'agent',
            method: 'processFullRequest',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'agent',
          methodName: 'processFullRequest',
          parameters: _i1.testObjectToJson({
            'request': request,
            'latitude': latitude,
            'longitude': longitude,
            'language': language,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i28.AiFullRequestResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AnalyticsEndpoint {
  _AnalyticsEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<bool> logEvent(
    _i1.TestSessionBuilder sessionBuilder, {
    required String eventName,
    String? eventType,
    String? propertiesJson,
    String? screenName,
    String? platform,
    String? appVersion,
    int? userId,
    String? sessionId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'logEvent',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'logEvent',
          parameters: _i1.testObjectToJson({
            'eventName': eventName,
            'eventType': eventType,
            'propertiesJson': propertiesJson,
            'screenName': screenName,
            'platform': platform,
            'appVersion': appVersion,
            'userId': userId,
            'sessionId': sessionId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> logEvents(
    _i1.TestSessionBuilder sessionBuilder, {
    required String eventsJson,
    int? userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'logEvents',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'logEvents',
          parameters: _i1.testObjectToJson({
            'eventsJson': eventsJson,
            'userId': userId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> logBusinessEvent(
    _i1.TestSessionBuilder sessionBuilder, {
    required String eventName,
    String? propertiesJson,
    double? revenue,
    double? commission,
    int? userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'logBusinessEvent',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'logBusinessEvent',
          parameters: _i1.testObjectToJson({
            'eventName': eventName,
            'propertiesJson': propertiesJson,
            'revenue': revenue,
            'commission': commission,
            'userId': userId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> getAnalyticsSummary(
    _i1.TestSessionBuilder sessionBuilder, {
    String? startDate,
    String? endDate,
    String? eventType,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getAnalyticsSummary',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getAnalyticsSummary',
          parameters: _i1.testObjectToJson({
            'startDate': startDate,
            'endDate': endDate,
            'eventType': eventType,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> getRecentEvents(
    _i1.TestSessionBuilder sessionBuilder, {
    int? limit,
    String? eventName,
    String? eventType,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getRecentEvents',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getRecentEvents',
          parameters: _i1.testObjectToJson({
            'limit': limit,
            'eventName': eventName,
            'eventType': eventType,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _FirebaseAuthEndpoint {
  _FirebaseAuthEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i29.AuthResponse> registerWithFirebase(
    _i1.TestSessionBuilder sessionBuilder, {
    required String firebaseIdToken,
    required String fullName,
    required _i30.UserRole role,
    String? email,
    String? phoneNumber,
    String? profilePhotoUrl,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'firebaseAuth',
            method: 'registerWithFirebase',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'firebaseAuth',
          methodName: 'registerWithFirebase',
          parameters: _i1.testObjectToJson({
            'firebaseIdToken': firebaseIdToken,
            'fullName': fullName,
            'role': role,
            'email': email,
            'phoneNumber': phoneNumber,
            'profilePhotoUrl': profilePhotoUrl,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i29.AuthResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i29.AuthResponse> loginWithFirebase(
    _i1.TestSessionBuilder sessionBuilder, {
    required String firebaseIdToken,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'firebaseAuth',
            method: 'loginWithFirebase',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'firebaseAuth',
          methodName: 'loginWithFirebase',
          parameters: _i1.testObjectToJson({
            'firebaseIdToken': firebaseIdToken,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i29.AuthResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i29.AuthResponse> refreshToken(
    _i1.TestSessionBuilder sessionBuilder, {
    required String refreshToken,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'firebaseAuth',
            method: 'refreshToken',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'firebaseAuth',
          methodName: 'refreshToken',
          parameters: _i1.testObjectToJson({'refreshToken': refreshToken}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i29.AuthResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i29.AuthResponse> getCurrentUser(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'firebaseAuth',
            method: 'getCurrentUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'firebaseAuth',
          methodName: 'getCurrentUser',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i29.AuthResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i29.AuthResponse> logout(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'firebaseAuth',
            method: 'logout',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'firebaseAuth',
          methodName: 'logout',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i29.AuthResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> checkEmailExists(
    _i1.TestSessionBuilder sessionBuilder,
    String email,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'firebaseAuth',
            method: 'checkEmailExists',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'firebaseAuth',
          methodName: 'checkEmailExists',
          parameters: _i1.testObjectToJson({'email': email}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> checkPhoneExists(
    _i1.TestSessionBuilder sessionBuilder,
    String phone,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'firebaseAuth',
            method: 'checkPhoneExists',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'firebaseAuth',
          methodName: 'checkPhoneExists',
          parameters: _i1.testObjectToJson({'phone': phone}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _BlockedUserEndpoint {
  _BlockedUserEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i31.BlockedUser?> blockUser(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int blockedUserId,
    String? reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'blockedUser',
            method: 'blockUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'blockedUser',
          methodName: 'blockUser',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'blockedUserId': blockedUserId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i31.BlockedUser?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> unblockUser(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int blockedUserId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'blockedUser',
            method: 'unblockUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'blockedUser',
          methodName: 'unblockUser',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'blockedUserId': blockedUserId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i31.BlockedUser>> getBlockedUsers(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'blockedUser',
            method: 'getBlockedUsers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'blockedUser',
          methodName: 'getBlockedUsers',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i31.BlockedUser>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> isUserBlocked(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int targetUserId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'blockedUser',
            method: 'isUserBlocked',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'blockedUser',
          methodName: 'isUserBlocked',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'targetUserId': targetUserId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> isBlockedByUser(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int otherUserId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'blockedUser',
            method: 'isBlockedByUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'blockedUser',
          methodName: 'isBlockedByUser',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'otherUserId': otherUserId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ChatEndpoint {
  _ChatEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i32.ChatMessage?> sendMessage(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
    required int senderId,
    required int receiverId,
    required String message,
    _i33.MessageType? messageType,
    String? attachmentUrl,
    String? firebaseId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'sendMessage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'sendMessage',
          parameters: _i1.testObjectToJson({
            'orderId': orderId,
            'senderId': senderId,
            'receiverId': receiverId,
            'message': message,
            'messageType': messageType,
            'attachmentUrl': attachmentUrl,
            'firebaseId': firebaseId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i32.ChatMessage?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i32.ChatMessage>> getMessages(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
    int? limit,
    DateTime? before,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'getMessages',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'getMessages',
          parameters: _i1.testObjectToJson({
            'orderId': orderId,
            'limit': limit,
            'before': before,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i32.ChatMessage>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getUnreadCount(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'getUnreadCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'getUnreadCount',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> markAsRead(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
    required int userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'markAsRead',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'markAsRead',
          parameters: _i1.testObjectToJson({
            'orderId': orderId,
            'userId': userId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i32.ChatMessage?> markMessageAsRead(
    _i1.TestSessionBuilder sessionBuilder, {
    required int messageId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'markMessageAsRead',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'markMessageAsRead',
          parameters: _i1.testObjectToJson({'messageId': messageId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i32.ChatMessage?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i32.ChatMessage?> syncFromFirebase(
    _i1.TestSessionBuilder sessionBuilder, {
    required String firebaseId,
    required int orderId,
    required int senderId,
    required int receiverId,
    required String message,
    _i33.MessageType? messageType,
    String? attachmentUrl,
    required DateTime createdAt,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'syncFromFirebase',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'syncFromFirebase',
          parameters: _i1.testObjectToJson({
            'firebaseId': firebaseId,
            'orderId': orderId,
            'senderId': senderId,
            'receiverId': receiverId,
            'message': message,
            'messageType': messageType,
            'attachmentUrl': attachmentUrl,
            'createdAt': createdAt,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i32.ChatMessage?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i32.ChatMessage>> getAdminChatHistory(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'getAdminChatHistory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'getAdminChatHistory',
          parameters: _i1.testObjectToJson({'orderId': orderId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i32.ChatMessage>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> notifyNewMessage(
    _i1.TestSessionBuilder sessionBuilder, {
    required int requestId,
    required int recipientUserId,
    required int senderId,
    required String senderName,
    required String messageText,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'chat',
            method: 'notifyNewMessage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'chat',
          methodName: 'notifyNewMessage',
          parameters: _i1.testObjectToJson({
            'requestId': requestId,
            'recipientUserId': recipientUserId,
            'senderId': senderId,
            'senderName': senderName,
            'messageText': messageText,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _CountryEndpoint {
  _CountryEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i34.Country>> getActiveCountries(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'country',
            method: 'getActiveCountries',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'country',
          methodName: 'getActiveCountries',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i34.Country>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i34.Country?> getCountryByCode(
    _i1.TestSessionBuilder sessionBuilder,
    String code,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'country',
            method: 'getCountryByCode',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'country',
          methodName: 'getCountryByCode',
          parameters: _i1.testObjectToJson({'code': code}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i34.Country?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i34.Country?> getDefaultCountry(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'country',
            method: 'getDefaultCountry',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'country',
          methodName: 'getDefaultCountry',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i34.Country?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> getCurrencyInfo(
    _i1.TestSessionBuilder sessionBuilder,
    String countryCode,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'country',
            method: 'getCurrencyInfo',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'country',
          methodName: 'getCurrencyInfo',
          parameters: _i1.testObjectToJson({'countryCode': countryCode}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> formatPrice(
    _i1.TestSessionBuilder sessionBuilder,
    double amount,
    String countryCode,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'country',
            method: 'formatPrice',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'country',
          methodName: 'formatPrice',
          parameters: _i1.testObjectToJson({
            'amount': amount,
            'countryCode': countryCode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> initializeDefaultCountries(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'country',
            method: 'initializeDefaultCountries',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'country',
          methodName: 'initializeDefaultCountries',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i34.Country> upsertCountry(
    _i1.TestSessionBuilder sessionBuilder,
    _i34.Country country,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'country',
            method: 'upsertCountry',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'country',
          methodName: 'upsertCountry',
          parameters: _i1.testObjectToJson({'country': country}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i34.Country>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> updateExchangeRate(
    _i1.TestSessionBuilder sessionBuilder,
    String countryCode,
    double rateToMAD,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'country',
            method: 'updateExchangeRate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'country',
          methodName: 'updateExchangeRate',
          parameters: _i1.testObjectToJson({
            'countryCode': countryCode,
            'rateToMAD': rateToMAD,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> toggleCountryStatus(
    _i1.TestSessionBuilder sessionBuilder,
    String countryCode,
    bool isActive,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'country',
            method: 'toggleCountryStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'country',
          methodName: 'toggleCountryStatus',
          parameters: _i1.testObjectToJson({
            'countryCode': countryCode,
            'isActive': isActive,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<double> convertCurrency(
    _i1.TestSessionBuilder sessionBuilder,
    double amount,
    String fromCountryCode,
    String toCountryCode,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'country',
            method: 'convertCurrency',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'country',
          methodName: 'convertCurrency',
          parameters: _i1.testObjectToJson({
            'amount': amount,
            'fromCountryCode': fromCountryCode,
            'toCountryCode': toCountryCode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<double>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _DeviceFingerprintEndpoint {
  _DeviceFingerprintEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i35.DeviceFingerprintCheckResult> checkFingerprint(
    _i1.TestSessionBuilder sessionBuilder,
    _i36.DeviceFingerprintInput input,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'deviceFingerprint',
            method: 'checkFingerprint',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'deviceFingerprint',
          methodName: 'checkFingerprint',
          parameters: _i1.testObjectToJson({'input': input}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i35.DeviceFingerprintCheckResult>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i35.DeviceFingerprintCheckResult> registerFingerprint(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
    _i36.DeviceFingerprintInput input,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'deviceFingerprint',
            method: 'registerFingerprint',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'deviceFingerprint',
          methodName: 'registerFingerprint',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'input': input,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i35.DeviceFingerprintCheckResult>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i37.DeviceFingerprintRecord?> getFingerprintByHash(
    _i1.TestSessionBuilder sessionBuilder,
    String fingerprintHash,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'deviceFingerprint',
            method: 'getFingerprintByHash',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'deviceFingerprint',
          methodName: 'getFingerprintByHash',
          parameters: _i1.testObjectToJson({
            'fingerprintHash': fingerprintHash,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i37.DeviceFingerprintRecord?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i37.DeviceFingerprintRecord>> getFingerprintsForUser(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'deviceFingerprint',
            method: 'getFingerprintsForUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'deviceFingerprint',
          methodName: 'getFingerprintsForUser',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i37.DeviceFingerprintRecord>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i37.DeviceFingerprintRecord?> blockFingerprint(
    _i1.TestSessionBuilder sessionBuilder,
    String fingerprintHash,
    String reason,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'deviceFingerprint',
            method: 'blockFingerprint',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'deviceFingerprint',
          methodName: 'blockFingerprint',
          parameters: _i1.testObjectToJson({
            'fingerprintHash': fingerprintHash,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i37.DeviceFingerprintRecord?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i37.DeviceFingerprintRecord?> unblockFingerprint(
    _i1.TestSessionBuilder sessionBuilder,
    String fingerprintHash,
    String reason,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'deviceFingerprint',
            method: 'unblockFingerprint',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'deviceFingerprint',
          methodName: 'unblockFingerprint',
          parameters: _i1.testObjectToJson({
            'fingerprintHash': fingerprintHash,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i37.DeviceFingerprintRecord?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i37.DeviceFingerprintRecord>> getHighRiskDevices(
    _i1.TestSessionBuilder sessionBuilder, {
    required double minRiskScore,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'deviceFingerprint',
            method: 'getHighRiskDevices',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'deviceFingerprint',
          methodName: 'getHighRiskDevices',
          parameters: _i1.testObjectToJson({
            'minRiskScore': minRiskScore,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i37.DeviceFingerprintRecord>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i37.DeviceFingerprintRecord>> getMultiAccountDevices(
    _i1.TestSessionBuilder sessionBuilder, {
    required int minAccounts,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'deviceFingerprint',
            method: 'getMultiAccountDevices',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'deviceFingerprint',
          methodName: 'getMultiAccountDevices',
          parameters: _i1.testObjectToJson({
            'minAccounts': minAccounts,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i37.DeviceFingerprintRecord>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i37.DeviceFingerprintRecord?> reportPromoAbuse(
    _i1.TestSessionBuilder sessionBuilder,
    String fingerprintHash,
    String promoCode,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'deviceFingerprint',
            method: 'reportPromoAbuse',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'deviceFingerprint',
          methodName: 'reportPromoAbuse',
          parameters: _i1.testObjectToJson({
            'fingerprintHash': fingerprintHash,
            'promoCode': promoCode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i37.DeviceFingerprintRecord?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _DriverEndpoint {
  _DriverEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i9.DriverProfile?> setOnlineStatus(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required bool isOnline,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driver',
            method: 'setOnlineStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driver',
          methodName: 'setOnlineStatus',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'isOnline': isOnline,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i9.DriverProfile?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i9.DriverProfile?> updateLocation(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required double latitude,
    required double longitude,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driver',
            method: 'updateLocation',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driver',
          methodName: 'updateLocation',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'latitude': latitude,
            'longitude': longitude,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i9.DriverProfile?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i9.DriverProfile>> getOnlineDrivers(
    _i1.TestSessionBuilder sessionBuilder, {
    required double centerLat,
    required double centerLng,
    required double radiusKm,
    int? serviceId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driver',
            method: 'getOnlineDrivers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driver',
          methodName: 'getOnlineDrivers',
          parameters: _i1.testObjectToJson({
            'centerLat': centerLat,
            'centerLng': centerLng,
            'radiusKm': radiusKm,
            'serviceId': serviceId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i9.DriverProfile>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i38.DriverService>> getDriverServices(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driver',
            method: 'getDriverServices',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driver',
          methodName: 'getDriverServices',
          parameters: _i1.testObjectToJson({'driverId': driverId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i38.DriverService>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i9.DriverProfile?> getDriverProfileByUserId(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driver',
            method: 'getDriverProfileByUserId',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driver',
          methodName: 'getDriverProfileByUserId',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i9.DriverProfile?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i38.DriverService?> addDriverService(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driver',
            method: 'addDriverService',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driver',
          methodName: 'addDriverService',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i38.DriverService?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i38.DriverService?> updateDriverService(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driver',
            method: 'updateDriverService',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driver',
          methodName: 'updateDriverService',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i38.DriverService?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteDriverService(
    _i1.TestSessionBuilder sessionBuilder, {
    required int serviceId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driver',
            method: 'deleteDriverService',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driver',
          methodName: 'deleteDriverService',
          parameters: _i1.testObjectToJson({'serviceId': serviceId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i38.DriverService?> toggleServiceAvailability(
    _i1.TestSessionBuilder sessionBuilder, {
    required int serviceId,
    required bool isAvailable,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driver',
            method: 'toggleServiceAvailability',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driver',
          methodName: 'toggleServiceAvailability',
          parameters: _i1.testObjectToJson({
            'serviceId': serviceId,
            'isAvailable': isAvailable,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i38.DriverService?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> reorderDriverServices(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required List<int> serviceIds,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driver',
            method: 'reorderDriverServices',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driver',
          methodName: 'reorderDriverServices',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'serviceIds': serviceIds,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String?> uploadServiceImageFile(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverServiceId,
    required _i39.ByteData imageData,
    required String fileName,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driver',
            method: 'uploadServiceImageFile',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driver',
          methodName: 'uploadServiceImageFile',
          parameters: _i1.testObjectToJson({
            'driverServiceId': driverServiceId,
            'imageData': imageData,
            'fileName': fileName,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i40.ServiceImage?> uploadServiceImage(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverServiceId,
    required String imageUrl,
    String? thumbnailUrl,
    String? caption,
    int? fileSize,
    int? width,
    int? height,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driver',
            method: 'uploadServiceImage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driver',
          methodName: 'uploadServiceImage',
          parameters: _i1.testObjectToJson({
            'driverServiceId': driverServiceId,
            'imageUrl': imageUrl,
            'thumbnailUrl': thumbnailUrl,
            'caption': caption,
            'fileSize': fileSize,
            'width': width,
            'height': height,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i40.ServiceImage?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i40.ServiceImage>> getServiceImages(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverServiceId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driver',
            method: 'getServiceImages',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driver',
          methodName: 'getServiceImages',
          parameters: _i1.testObjectToJson({
            'driverServiceId': driverServiceId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i40.ServiceImage>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteServiceImage(
    _i1.TestSessionBuilder sessionBuilder, {
    required int imageId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driver',
            method: 'deleteServiceImage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driver',
          methodName: 'deleteServiceImage',
          parameters: _i1.testObjectToJson({'imageId': imageId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> autoOfflineDrivers(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driver',
            method: 'autoOfflineDrivers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driver',
          methodName: 'autoOfflineDrivers',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> isDriverTrulyOnline(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driver',
            method: 'isDriverTrulyOnline',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driver',
          methodName: 'isDriverTrulyOnline',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _DriverStatusEndpoint {
  _DriverStatusEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i8.User?> setDriverStatus(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
    bool isOnline,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driverStatus',
            method: 'setDriverStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driverStatus',
          methodName: 'setDriverStatus',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'isOnline': isOnline,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i8.User?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> getDriverStatus(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driverStatus',
            method: 'getDriverStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driverStatus',
          methodName: 'getDriverStatus',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getOnlineDriversCount(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driverStatus',
            method: 'getOnlineDriversCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driverStatus',
          methodName: 'getOnlineDriversCount',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> updateLastSeen(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'driverStatus',
            method: 'updateLastSeen',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'driverStatus',
          methodName: 'updateLastSeen',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ElasticsearchEndpoint {
  _ElasticsearchEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<Map<String, dynamic>> testConnection(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'testConnection',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'testConnection',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> getHealth(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'getHealth',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'getHealth',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> checkIndex(
    _i1.TestSessionBuilder sessionBuilder,
    String indexName,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'checkIndex',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'checkIndex',
          parameters: _i1.testObjectToJson({'indexName': indexName}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> getIndicesStatus(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'getIndicesStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'getIndicesStatus',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> indexTestDocument(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'indexTestDocument',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'indexTestDocument',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> searchTestDocument(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'searchTestDocument',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'searchTestDocument',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> deleteTestDocument(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'deleteTestDocument',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'deleteTestDocument',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> getStatus(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'getStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'getStatus',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> migrateAll(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'migrateAll',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'migrateAll',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> migrateDrivers(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'migrateDrivers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'migrateDrivers',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> migrateServices(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'migrateServices',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'migrateServices',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> migrateDriverServices(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'migrateDriverServices',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'migrateDriverServices',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> migrateRequests(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'migrateRequests',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'migrateRequests',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> migrateStores(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'migrateStores',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'migrateStores',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> migrateProducts(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'migrateProducts',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'migrateProducts',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> migrateReviews(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'migrateReviews',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'migrateReviews',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> migrateStoreOrders(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'migrateStoreOrders',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'migrateStoreOrders',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> migrateTransactions(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'migrateTransactions',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'migrateTransactions',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> migrateUsers(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'migrateUsers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'migrateUsers',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> migrateWallets(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'migrateWallets',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'migrateWallets',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> migrateRatings(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'migrateRatings',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'migrateRatings',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, int>> getDocumentCounts(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'elasticsearch',
            method: 'getDocumentCounts',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'elasticsearch',
          methodName: 'getDocumentCounts',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, int>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _EmailEndpoint {
  _EmailEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<bool> isEmailServiceReady(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'email',
            method: 'isEmailServiceReady',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'email',
          methodName: 'isEmailServiceReady',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> sendTestEmail(
    _i1.TestSessionBuilder sessionBuilder,
    String recipientEmail,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'email',
            method: 'sendTestEmail',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'email',
          methodName: 'sendTestEmail',
          parameters: _i1.testObjectToJson({'recipientEmail': recipientEmail}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> sendWelcomeEmail(
    _i1.TestSessionBuilder sessionBuilder, {
    required String email,
    required String name,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'email',
            method: 'sendWelcomeEmail',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'email',
          methodName: 'sendWelcomeEmail',
          parameters: _i1.testObjectToJson({
            'email': email,
            'name': name,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> sendOrderConfirmation(
    _i1.TestSessionBuilder sessionBuilder, {
    required String email,
    required String name,
    required String orderId,
    required String serviceName,
    required String date,
    required String total,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'email',
            method: 'sendOrderConfirmation',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'email',
          methodName: 'sendOrderConfirmation',
          parameters: _i1.testObjectToJson({
            'email': email,
            'name': name,
            'orderId': orderId,
            'serviceName': serviceName,
            'date': date,
            'total': total,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> sendDriverAcceptedNotification(
    _i1.TestSessionBuilder sessionBuilder, {
    required String email,
    required String name,
    required String orderId,
    required String driverName,
    required String driverPhone,
    String? vehicleInfo,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'email',
            method: 'sendDriverAcceptedNotification',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'email',
          methodName: 'sendDriverAcceptedNotification',
          parameters: _i1.testObjectToJson({
            'email': email,
            'name': name,
            'orderId': orderId,
            'driverName': driverName,
            'driverPhone': driverPhone,
            'vehicleInfo': vehicleInfo,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> sendOrderCompletedEmail(
    _i1.TestSessionBuilder sessionBuilder, {
    required String email,
    required String name,
    required String orderId,
    required String serviceName,
    required String total,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'email',
            method: 'sendOrderCompletedEmail',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'email',
          methodName: 'sendOrderCompletedEmail',
          parameters: _i1.testObjectToJson({
            'email': email,
            'name': name,
            'orderId': orderId,
            'serviceName': serviceName,
            'total': total,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> sendCustomEmail(
    _i1.TestSessionBuilder sessionBuilder, {
    required String recipientEmail,
    String? recipientName,
    required String subject,
    required String htmlBody,
    String? textBody,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'email',
            method: 'sendCustomEmail',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'email',
          methodName: 'sendCustomEmail',
          parameters: _i1.testObjectToJson({
            'recipientEmail': recipientEmail,
            'recipientName': recipientName,
            'subject': subject,
            'htmlBody': htmlBody,
            'textBody': textBody,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _RefreshJwtTokensEndpoint {
  _RefreshJwtTokensEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i4.AuthSuccess> refreshAccessToken(
    _i1.TestSessionBuilder sessionBuilder, {
    required String refreshToken,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'refreshJwtTokens',
            method: 'refreshAccessToken',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'refreshJwtTokens',
          methodName: 'refreshAccessToken',
          parameters: _i1.testObjectToJson({'refreshToken': refreshToken}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i4.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _LocationEndpoint {
  _LocationEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i8.User?> updateDriverLocation(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
    double latitude,
    double longitude,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'location',
            method: 'updateDriverLocation',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'location',
          methodName: 'updateDriverLocation',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'latitude': latitude,
            'longitude': longitude,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i8.User?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _McpProxyEndpoint {
  _McpProxyEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<String> proxyMcpRequest(
    _i1.TestSessionBuilder sessionBuilder,
    String requestJson,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'mcpProxy',
            method: 'proxyMcpRequest',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'mcpProxy',
          methodName: 'proxyMcpRequest',
          parameters: _i1.testObjectToJson({'requestJson': requestJson}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _MediaEndpoint {
  _MediaEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<bool> ping(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'media',
            method: 'ping',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'media',
          methodName: 'ping',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i41.MediaMetadata?> recordMedia(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'media',
            method: 'recordMedia',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'media',
          methodName: 'recordMedia',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i41.MediaMetadata?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i41.MediaMetadata>> listByRequest(
    _i1.TestSessionBuilder sessionBuilder, {
    required int requestId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'media',
            method: 'listByRequest',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'media',
          methodName: 'listByRequest',
          parameters: _i1.testObjectToJson({'requestId': requestId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i41.MediaMetadata>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> incrementDownload(
    _i1.TestSessionBuilder sessionBuilder, {
    required int id,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'media',
            method: 'incrementDownload',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'media',
          methodName: 'incrementDownload',
          parameters: _i1.testObjectToJson({'id': id}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _NotificationEndpoint {
  _NotificationEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i42.UserNotification>> getUserNotifications(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    bool? unreadOnly,
    required int limit,
    required int offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'getUserNotifications',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'getUserNotifications',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'unreadOnly': unreadOnly,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i42.UserNotification>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> markAsRead(
    _i1.TestSessionBuilder sessionBuilder,
    int notificationId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'markAsRead',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'markAsRead',
          parameters: _i1.testObjectToJson({'notificationId': notificationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> markAllAsRead(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'markAllAsRead',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'markAllAsRead',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> getUnreadCount(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'getUnreadCount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'getUnreadCount',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i42.UserNotification?> createNotification(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required String title,
    required String body,
    required _i43.NotificationType type,
    int? relatedEntityId,
    String? relatedEntityType,
    Map<String, dynamic>? data,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'createNotification',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'createNotification',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'title': title,
            'body': body,
            'type': type,
            'relatedEntityId': relatedEntityId,
            'relatedEntityType': relatedEntityType,
            'data': data,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i42.UserNotification?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _NotificationPlannerEndpoint {
  _NotificationPlannerEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<String> getStatus(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notificationPlanner',
            method: 'getStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notificationPlanner',
          methodName: 'getStatus',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> runCycle(
    _i1.TestSessionBuilder sessionBuilder, {
    required bool dryRun,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notificationPlanner',
            method: 'runCycle',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notificationPlanner',
          methodName: 'runCycle',
          parameters: _i1.testObjectToJson({'dryRun': dryRun}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> dryRun(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notificationPlanner',
            method: 'dryRun',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notificationPlanner',
          methodName: 'dryRun',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> getHistory(
    _i1.TestSessionBuilder sessionBuilder, {
    required int limit,
    String? type,
    String? status,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notificationPlanner',
            method: 'getHistory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notificationPlanner',
          methodName: 'getHistory',
          parameters: _i1.testObjectToJson({
            'limit': limit,
            'type': type,
            'status': status,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> getStats(_i1.TestSessionBuilder sessionBuilder) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notificationPlanner',
            method: 'getStats',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notificationPlanner',
          methodName: 'getStats',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> updateConfig(
    _i1.TestSessionBuilder sessionBuilder, {
    int? maxPerCycle,
    int? cycleIntervalHours,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notificationPlanner',
            method: 'updateConfig',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notificationPlanner',
          methodName: 'updateConfig',
          parameters: _i1.testObjectToJson({
            'maxPerCycle': maxPerCycle,
            'cycleIntervalHours': cycleIntervalHours,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> sendCustomNotification(
    _i1.TestSessionBuilder sessionBuilder, {
    required String userIds,
    required String title,
    required String body,
    String? priority,
    String? type,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notificationPlanner',
            method: 'sendCustomNotification',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notificationPlanner',
          methodName: 'sendCustomNotification',
          parameters: _i1.testObjectToJson({
            'userIds': userIds,
            'title': title,
            'body': body,
            'priority': priority,
            'type': type,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> sendBroadcast(
    _i1.TestSessionBuilder sessionBuilder, {
    required String title,
    required String body,
    String? targetGroup,
    int? limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notificationPlanner',
            method: 'sendBroadcast',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notificationPlanner',
          methodName: 'sendBroadcast',
          parameters: _i1.testObjectToJson({
            'title': title,
            'body': body,
            'targetGroup': targetGroup,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _OfferEndpoint {
  _OfferEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i44.DriverOffer?> sendOffer(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
    required int driverId,
    required double offeredPrice,
    String? message,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'offer',
            method: 'sendOffer',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'offer',
          methodName: 'sendOffer',
          parameters: _i1.testObjectToJson({
            'orderId': orderId,
            'driverId': driverId,
            'offeredPrice': offeredPrice,
            'message': message,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i44.DriverOffer?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i44.DriverOffer?> counterOffer(
    _i1.TestSessionBuilder sessionBuilder, {
    required int offerId,
    required double newPrice,
    required bool isClient,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'offer',
            method: 'counterOffer',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'offer',
          methodName: 'counterOffer',
          parameters: _i1.testObjectToJson({
            'offerId': offerId,
            'newPrice': newPrice,
            'isClient': isClient,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i44.DriverOffer?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i45.Order?> acceptOffer(
    _i1.TestSessionBuilder sessionBuilder, {
    required int offerId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'offer',
            method: 'acceptOffer',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'offer',
          methodName: 'acceptOffer',
          parameters: _i1.testObjectToJson({'offerId': offerId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i45.Order?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i44.DriverOffer>> getOffersForOrder(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'offer',
            method: 'getOffersForOrder',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'offer',
          methodName: 'getOffersForOrder',
          parameters: _i1.testObjectToJson({'orderId': orderId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i44.DriverOffer>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i44.DriverOffer?> withdrawOffer(
    _i1.TestSessionBuilder sessionBuilder, {
    required int offerId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'offer',
            method: 'withdrawOffer',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'offer',
          methodName: 'withdrawOffer',
          parameters: _i1.testObjectToJson({'offerId': offerId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i44.DriverOffer?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _OrderEndpoint {
  _OrderEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i45.Order?> createOrder(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'order',
            method: 'createOrder',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'order',
          methodName: 'createOrder',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i45.Order?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i45.Order>> getActiveOrders(
    _i1.TestSessionBuilder sessionBuilder, {
    required int clientId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'order',
            method: 'getActiveOrders',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'order',
          methodName: 'getActiveOrders',
          parameters: _i1.testObjectToJson({'clientId': clientId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i45.Order>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i45.Order>> getNearbyOrders(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required double driverLat,
    required double driverLng,
    required double radiusKm,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'order',
            method: 'getNearbyOrders',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'order',
          methodName: 'getNearbyOrders',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'driverLat': driverLat,
            'driverLng': driverLng,
            'radiusKm': radiusKm,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i45.Order>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i45.Order?> cancelOrder(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
    required int userId,
    required _i46.CancellerType cancelledBy,
    required String cancellationReason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'order',
            method: 'cancelOrder',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'order',
          methodName: 'cancelOrder',
          parameters: _i1.testObjectToJson({
            'orderId': orderId,
            'userId': userId,
            'cancelledBy': cancelledBy,
            'cancellationReason': cancellationReason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i45.Order?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i45.Order?> updateOrderStatus(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
    required _i47.OrderStatus status,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'order',
            method: 'updateOrderStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'order',
          methodName: 'updateOrderStatus',
          parameters: _i1.testObjectToJson({
            'orderId': orderId,
            'status': status,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i45.Order?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _PromoEndpoint {
  _PromoEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i48.Promo>> getActivePromos(
    _i1.TestSessionBuilder sessionBuilder, {
    required String role,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'promo',
            method: 'getActivePromos',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'promo',
          methodName: 'getActivePromos',
          parameters: _i1.testObjectToJson({'role': role}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i48.Promo>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> recordView(
    _i1.TestSessionBuilder sessionBuilder, {
    required int promoId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'promo',
            method: 'recordView',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'promo',
          methodName: 'recordView',
          parameters: _i1.testObjectToJson({'promoId': promoId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> recordClick(
    _i1.TestSessionBuilder sessionBuilder, {
    required int promoId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'promo',
            method: 'recordClick',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'promo',
          methodName: 'recordClick',
          parameters: _i1.testObjectToJson({'promoId': promoId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i48.Promo>> getAllPromos(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'promo',
            method: 'getAllPromos',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'promo',
          methodName: 'getAllPromos',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i48.Promo>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i48.Promo?> getPromo(
    _i1.TestSessionBuilder sessionBuilder, {
    required int promoId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'promo',
            method: 'getPromo',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'promo',
          methodName: 'getPromo',
          parameters: _i1.testObjectToJson({'promoId': promoId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i48.Promo?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i48.Promo?> createPromo(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'promo',
            method: 'createPromo',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'promo',
          methodName: 'createPromo',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i48.Promo?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i48.Promo?> updatePromo(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'promo',
            method: 'updatePromo',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'promo',
          methodName: 'updatePromo',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i48.Promo?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> togglePromoStatus(
    _i1.TestSessionBuilder sessionBuilder, {
    required int promoId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'promo',
            method: 'togglePromoStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'promo',
          methodName: 'togglePromoStatus',
          parameters: _i1.testObjectToJson({'promoId': promoId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deletePromo(
    _i1.TestSessionBuilder sessionBuilder, {
    required int promoId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'promo',
            method: 'deletePromo',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'promo',
          methodName: 'deletePromo',
          parameters: _i1.testObjectToJson({'promoId': promoId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> getPromoAnalytics(
    _i1.TestSessionBuilder sessionBuilder, {
    required int promoId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'promo',
            method: 'getPromoAnalytics',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'promo',
          methodName: 'getPromoAnalytics',
          parameters: _i1.testObjectToJson({'promoId': promoId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ProposalEndpoint {
  _ProposalEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i49.DriverProposal> submitProposal(
    _i1.TestSessionBuilder sessionBuilder, {
    required int requestId,
    required int driverId,
    double? proposedPrice,
    required int estimatedArrival,
    String? message,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'proposal',
            method: 'submitProposal',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'proposal',
          methodName: 'submitProposal',
          parameters: _i1.testObjectToJson({
            'requestId': requestId,
            'driverId': driverId,
            'proposedPrice': proposedPrice,
            'estimatedArrival': estimatedArrival,
            'message': message,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i49.DriverProposal>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i49.DriverProposal>> getProposalsForRequest(
    _i1.TestSessionBuilder sessionBuilder,
    int requestId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'proposal',
            method: 'getProposalsForRequest',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'proposal',
          methodName: 'getProposalsForRequest',
          parameters: _i1.testObjectToJson({'requestId': requestId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i49.DriverProposal>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.ServiceRequest> acceptProposal(
    _i1.TestSessionBuilder sessionBuilder, {
    required int proposalId,
    required int clientId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'proposal',
            method: 'acceptProposal',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'proposal',
          methodName: 'acceptProposal',
          parameters: _i1.testObjectToJson({
            'proposalId': proposalId,
            'clientId': clientId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i13.ServiceRequest>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> rejectProposal(
    _i1.TestSessionBuilder sessionBuilder, {
    required int proposalId,
    required int clientId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'proposal',
            method: 'rejectProposal',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'proposal',
          methodName: 'rejectProposal',
          parameters: _i1.testObjectToJson({
            'proposalId': proposalId,
            'clientId': clientId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> withdrawProposal(
    _i1.TestSessionBuilder sessionBuilder, {
    required int proposalId,
    required int driverId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'proposal',
            method: 'withdrawProposal',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'proposal',
          methodName: 'withdrawProposal',
          parameters: _i1.testObjectToJson({
            'proposalId': proposalId,
            'driverId': driverId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _RatingEndpoint {
  _RatingEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i50.Rating> submitRating(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
    int requestId,
    int ratedUserId,
    int ratingValue,
    _i51.RatingType ratingType, {
    String? reviewText,
    List<String>? quickTags,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'rating',
            method: 'submitRating',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'rating',
          methodName: 'submitRating',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'requestId': requestId,
            'ratedUserId': ratedUserId,
            'ratingValue': ratingValue,
            'ratingType': ratingType,
            'reviewText': reviewText,
            'quickTags': quickTags,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i50.Rating>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i50.Rating>> getUserRatings(
    _i1.TestSessionBuilder sessionBuilder,
    int userId, {
    _i51.RatingType? ratingType,
    int? limit,
    int? offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'rating',
            method: 'getUserRatings',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'rating',
          methodName: 'getUserRatings',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'ratingType': ratingType,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i50.Rating>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> getUserRatingStats(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'rating',
            method: 'getUserRatingStats',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'rating',
          methodName: 'getUserRatingStats',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i52.RatingStats> getRatingsGivenStats(
    _i1.TestSessionBuilder sessionBuilder,
    int raterId, {
    _i51.RatingType? ratingType,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'rating',
            method: 'getRatingsGivenStats',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'rating',
          methodName: 'getRatingsGivenStats',
          parameters: _i1.testObjectToJson({
            'raterId': raterId,
            'ratingType': ratingType,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i52.RatingStats>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i50.Rating?> getRatingForRequest(
    _i1.TestSessionBuilder sessionBuilder,
    int requestId,
    int raterId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'rating',
            method: 'getRatingForRequest',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'rating',
          methodName: 'getRatingForRequest',
          parameters: _i1.testObjectToJson({
            'requestId': requestId,
            'raterId': raterId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i50.Rating?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, bool>> getRequestRatingStatus(
    _i1.TestSessionBuilder sessionBuilder,
    int requestId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'rating',
            method: 'getRequestRatingStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'rating',
          methodName: 'getRequestRatingStatus',
          parameters: _i1.testObjectToJson({'requestId': requestId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, bool>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ReportEndpoint {
  _ReportEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i17.Report?> createReportByUserId(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'report',
            method: 'createReportByUserId',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'report',
          methodName: 'createReportByUserId',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i17.Report?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i17.Report?> createReport(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'report',
            method: 'createReport',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'report',
          methodName: 'createReport',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i17.Report?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i17.Report>> getPendingReports(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'report',
            method: 'getPendingReports',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'report',
          methodName: 'getPendingReports',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i17.Report>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i17.Report>> getReportsForUser(
    _i1.TestSessionBuilder sessionBuilder, {
    int? driverId,
    int? clientId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'report',
            method: 'getReportsForUser',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'report',
          methodName: 'getReportsForUser',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'clientId': clientId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i17.Report>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i17.Report?> resolveReport(
    _i1.TestSessionBuilder sessionBuilder, {
    required int reportId,
    required int adminId,
    required _i19.ReportResolution resolution,
    String? adminNotes,
    String? reviewNotes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'report',
            method: 'resolveReport',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'report',
          methodName: 'resolveReport',
          parameters: _i1.testObjectToJson({
            'reportId': reportId,
            'adminId': adminId,
            'resolution': resolution,
            'adminNotes': adminNotes,
            'reviewNotes': reviewNotes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i17.Report?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i17.Report?> dismissReport(
    _i1.TestSessionBuilder sessionBuilder, {
    required int reportId,
    required int adminId,
    String? reviewNotes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'report',
            method: 'dismissReport',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'report',
          methodName: 'dismissReport',
          parameters: _i1.testObjectToJson({
            'reportId': reportId,
            'adminId': adminId,
            'reviewNotes': reviewNotes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i17.Report?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _RequestEndpoint {
  _RequestEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i13.ServiceRequest> createRequest(
    _i1.TestSessionBuilder sessionBuilder,
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'request',
            method: 'createRequest',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'request',
          methodName: 'createRequest',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i13.ServiceRequest>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.ServiceRequest?> getRequestById(
    _i1.TestSessionBuilder sessionBuilder,
    int requestId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'request',
            method: 'getRequestById',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'request',
          methodName: 'getRequestById',
          parameters: _i1.testObjectToJson({'requestId': requestId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i13.ServiceRequest?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> getPriceSuggestion(
    _i1.TestSessionBuilder sessionBuilder,
    double pickupLat,
    double pickupLon,
    double destLat,
    double destLon,
    _i55.ServiceType serviceType,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'request',
            method: 'getPriceSuggestion',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'request',
          methodName: 'getPriceSuggestion',
          parameters: _i1.testObjectToJson({
            'pickupLat': pickupLat,
            'pickupLon': pickupLon,
            'destLat': destLat,
            'destLon': destLon,
            'serviceType': serviceType,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i13.ServiceRequest>> getActiveRequestsForClient(
    _i1.TestSessionBuilder sessionBuilder,
    int clientId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'request',
            method: 'getActiveRequestsForClient',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'request',
          methodName: 'getActiveRequestsForClient',
          parameters: _i1.testObjectToJson({'clientId': clientId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i13.ServiceRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  @Deprecated('Use getActiveRequestsForClient instead')
  _i3.Future<_i13.ServiceRequest?> getActiveRequestForClient(
    _i1.TestSessionBuilder sessionBuilder,
    int clientId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'request',
            method: 'getActiveRequestForClient',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'request',
          methodName: 'getActiveRequestForClient',
          parameters: _i1.testObjectToJson({'clientId': clientId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i13.ServiceRequest?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.ServiceRequest?> getActiveRequestForDriver(
    _i1.TestSessionBuilder sessionBuilder,
    int driverId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'request',
            method: 'getActiveRequestForDriver',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'request',
          methodName: 'getActiveRequestForDriver',
          parameters: _i1.testObjectToJson({'driverId': driverId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i13.ServiceRequest?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i13.ServiceRequest>> getActiveRequestsForDriver(
    _i1.TestSessionBuilder sessionBuilder,
    int driverId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'request',
            method: 'getActiveRequestsForDriver',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'request',
          methodName: 'getActiveRequestsForDriver',
          parameters: _i1.testObjectToJson({'driverId': driverId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i13.ServiceRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i13.ServiceRequest>> getNearbyRequests(
    _i1.TestSessionBuilder sessionBuilder,
    int driverId,
    double driverLat,
    double driverLon, {
    required double radiusKm,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'request',
            method: 'getNearbyRequests',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'request',
          methodName: 'getNearbyRequests',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'driverLat': driverLat,
            'driverLon': driverLon,
            'radiusKm': radiusKm,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i13.ServiceRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.ServiceRequest?> acceptRequest(
    _i1.TestSessionBuilder sessionBuilder,
    int requestId,
    int driverId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'request',
            method: 'acceptRequest',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'request',
          methodName: 'acceptRequest',
          parameters: _i1.testObjectToJson({
            'requestId': requestId,
            'driverId': driverId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i13.ServiceRequest?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.ServiceRequest?> approveDriver(
    _i1.TestSessionBuilder sessionBuilder,
    int requestId,
    int clientId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'request',
            method: 'approveDriver',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'request',
          methodName: 'approveDriver',
          parameters: _i1.testObjectToJson({
            'requestId': requestId,
            'clientId': clientId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i13.ServiceRequest?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.ServiceRequest?> rejectDriver(
    _i1.TestSessionBuilder sessionBuilder,
    int requestId,
    int clientId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'request',
            method: 'rejectDriver',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'request',
          methodName: 'rejectDriver',
          parameters: _i1.testObjectToJson({
            'requestId': requestId,
            'clientId': clientId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i13.ServiceRequest?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.ServiceRequest?> updateRequestStatus(
    _i1.TestSessionBuilder sessionBuilder,
    int requestId,
    _i14.RequestStatus newStatus,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'request',
            method: 'updateRequestStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'request',
          methodName: 'updateRequestStatus',
          parameters: _i1.testObjectToJson({
            'requestId': requestId,
            'newStatus': newStatus,
            'userId': userId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i13.ServiceRequest?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.ServiceRequest?> cancelRequest(
    _i1.TestSessionBuilder sessionBuilder,
    int requestId,
    int userId,
    String reason,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'request',
            method: 'cancelRequest',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'request',
          methodName: 'cancelRequest',
          parameters: _i1.testObjectToJson({
            'requestId': requestId,
            'userId': userId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i13.ServiceRequest?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i13.ServiceRequest>> getClientRequestHistory(
    _i1.TestSessionBuilder sessionBuilder,
    int clientId, {
    required int limit,
    required int offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'request',
            method: 'getClientRequestHistory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'request',
          methodName: 'getClientRequestHistory',
          parameters: _i1.testObjectToJson({
            'clientId': clientId,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i13.ServiceRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i13.ServiceRequest>> getDriverRequestHistory(
    _i1.TestSessionBuilder sessionBuilder,
    int driverId, {
    required int limit,
    required int offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'request',
            method: 'getDriverRequestHistory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'request',
          methodName: 'getDriverRequestHistory',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i13.ServiceRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i13.ServiceRequest>> getAllPendingRequests(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'request',
            method: 'getAllPendingRequests',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'request',
          methodName: 'getAllPendingRequests',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i13.ServiceRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i13.ServiceRequest>> getCatalogRequests(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'request',
            method: 'getCatalogRequests',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'request',
          methodName: 'getCatalogRequests',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i13.ServiceRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ReviewEndpoint {
  _ReviewEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i58.ClientReview?> createClientReview(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
    required int driverId,
    required int clientId,
    required int rating,
    String? comment,
    int? communicationRating,
    int? respectRating,
    int? paymentPromptness,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'review',
            method: 'createClientReview',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'review',
          methodName: 'createClientReview',
          parameters: _i1.testObjectToJson({
            'orderId': orderId,
            'driverId': driverId,
            'clientId': clientId,
            'rating': rating,
            'comment': comment,
            'communicationRating': communicationRating,
            'respectRating': respectRating,
            'paymentPromptness': paymentPromptness,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i58.ClientReview?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i58.ClientReview>> getClientReviews(
    _i1.TestSessionBuilder sessionBuilder, {
    required int clientId,
    int? limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'review',
            method: 'getClientReviews',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'review',
          methodName: 'getClientReviews',
          parameters: _i1.testObjectToJson({
            'clientId': clientId,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i58.ClientReview>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i58.ClientReview>> getReviewsByDriver(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'review',
            method: 'getReviewsByDriver',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'review',
          methodName: 'getReviewsByDriver',
          parameters: _i1.testObjectToJson({'driverId': driverId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i58.ClientReview>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i59.Review?> createDriverReview(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
    required int clientId,
    required int driverId,
    required int rating,
    String? comment,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'review',
            method: 'createDriverReview',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'review',
          methodName: 'createDriverReview',
          parameters: _i1.testObjectToJson({
            'orderId': orderId,
            'clientId': clientId,
            'driverId': driverId,
            'rating': rating,
            'comment': comment,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i59.Review?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i59.Review>> getDriverReviews(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    int? limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'review',
            method: 'getDriverReviews',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'review',
          methodName: 'getDriverReviews',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i59.Review>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> recalcDriverRating(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'review',
            method: 'recalcDriverRating',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'review',
          methodName: 'recalcDriverRating',
          parameters: _i1.testObjectToJson({'driverId': driverId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _SearchEndpoint {
  _SearchEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<String> searchDriversNearby(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'searchDriversNearby',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'searchDriversNearby',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> searchDriversByText(
    _i1.TestSessionBuilder sessionBuilder, {
    required String query,
    bool? isOnline,
    bool? isVerified,
    String? vehicleType,
    double? minRating,
    int? from,
    int? size,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'searchDriversByText',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'searchDriversByText',
          parameters: _i1.testObjectToJson({
            'query': query,
            'isOnline': isOnline,
            'isVerified': isVerified,
            'vehicleType': vehicleType,
            'minRating': minRating,
            'from': from,
            'size': size,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> getTopRatedDrivers(
    _i1.TestSessionBuilder sessionBuilder, {
    int? categoryId,
    int? minCompletedOrders,
    int? from,
    int? size,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'getTopRatedDrivers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'getTopRatedDrivers',
          parameters: _i1.testObjectToJson({
            'categoryId': categoryId,
            'minCompletedOrders': minCompletedOrders,
            'from': from,
            'size': size,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> searchServices(
    _i1.TestSessionBuilder sessionBuilder, {
    required String query,
    String? language,
    int? categoryId,
    bool? isActive,
    int? from,
    int? size,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'searchServices',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'searchServices',
          parameters: _i1.testObjectToJson({
            'query': query,
            'language': language,
            'categoryId': categoryId,
            'isActive': isActive,
            'from': from,
            'size': size,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> getPopularServices(
    _i1.TestSessionBuilder sessionBuilder, {
    int? categoryId,
    int? from,
    int? size,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'getPopularServices',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'getPopularServices',
          parameters: _i1.testObjectToJson({
            'categoryId': categoryId,
            'from': from,
            'size': size,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> searchDriverServices(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'searchDriverServices',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'searchDriverServices',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> getSimilarDriverServices(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverServiceId,
    int? size,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'getSimilarDriverServices',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'getSimilarDriverServices',
          parameters: _i1.testObjectToJson({
            'driverServiceId': driverServiceId,
            'size': size,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> searchStoresNearby(
    _i1.TestSessionBuilder sessionBuilder, {
    required double lat,
    required double lon,
    double? radiusKm,
    String? query,
    int? categoryId,
    bool? isOpen,
    double? minRating,
    int? from,
    int? size,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'searchStoresNearby',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'searchStoresNearby',
          parameters: _i1.testObjectToJson({
            'lat': lat,
            'lon': lon,
            'radiusKm': radiusKm,
            'query': query,
            'categoryId': categoryId,
            'isOpen': isOpen,
            'minRating': minRating,
            'from': from,
            'size': size,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> searchProductsInStore(
    _i1.TestSessionBuilder sessionBuilder, {
    required int storeId,
    String? query,
    int? categoryId,
    bool? isAvailable,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    int? from,
    int? size,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'searchProductsInStore',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'searchProductsInStore',
          parameters: _i1.testObjectToJson({
            'storeId': storeId,
            'query': query,
            'categoryId': categoryId,
            'isAvailable': isAvailable,
            'minPrice': minPrice,
            'maxPrice': maxPrice,
            'sortBy': sortBy,
            'from': from,
            'size': size,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> searchProductsNearby(
    _i1.TestSessionBuilder sessionBuilder, {
    required String query,
    required double lat,
    required double lon,
    double? radiusKm,
    bool? isAvailable,
    int? from,
    int? size,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'searchProductsNearby',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'searchProductsNearby',
          parameters: _i1.testObjectToJson({
            'query': query,
            'lat': lat,
            'lon': lon,
            'radiusKm': radiusKm,
            'isAvailable': isAvailable,
            'from': from,
            'size': size,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> getSearchSuggestions(
    _i1.TestSessionBuilder sessionBuilder, {
    required String prefix,
    String? type,
    int? size,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'getSearchSuggestions',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'getSearchSuggestions',
          parameters: _i1.testObjectToJson({
            'prefix': prefix,
            'type': type,
            'size': size,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> getPopularSearches(
    _i1.TestSessionBuilder sessionBuilder, {
    String? searchType,
    int? size,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'getPopularSearches',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'getPopularSearches',
          parameters: _i1.testObjectToJson({
            'searchType': searchType,
            'size': size,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> getServiceCategoryCounts(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'getServiceCategoryCounts',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'getServiceCategoryCounts',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> getDriverServicePriceStats(
    _i1.TestSessionBuilder sessionBuilder, {
    int? categoryId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'getDriverServicePriceStats',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'getDriverServicePriceStats',
          parameters: _i1.testObjectToJson({'categoryId': categoryId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> unifiedSearch(
    _i1.TestSessionBuilder sessionBuilder, {
    required String query,
    double? lat,
    double? lon,
    double? radiusKm,
    List<String>? types,
    int? size,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'unifiedSearch',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'unifiedSearch',
          parameters: _i1.testObjectToJson({
            'query': query,
            'lat': lat,
            'lon': lon,
            'radiusKm': radiusKm,
            'types': types,
            'size': size,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> smartSearch(
    _i1.TestSessionBuilder sessionBuilder, {
    required String query,
    String? language,
    double? lat,
    double? lon,
    double? radiusKm,
    List<String>? types,
    int? sizePerType,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'smartSearch',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'smartSearch',
          parameters: _i1.testObjectToJson({
            'query': query,
            'language': language,
            'lat': lat,
            'lon': lon,
            'radiusKm': radiusKm,
            'types': types,
            'sizePerType': sizePerType,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> searchKnowledgeBase(
    _i1.TestSessionBuilder sessionBuilder, {
    required String query,
    String? category,
    String? language,
    int? size,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'search',
            method: 'searchKnowledgeBase',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'search',
          methodName: 'searchKnowledgeBase',
          parameters: _i1.testObjectToJson({
            'query': query,
            'category': category,
            'language': language,
            'size': size,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ServiceEndpoint {
  _ServiceEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i60.ServiceCategory>> getCategories(
    _i1.TestSessionBuilder sessionBuilder, {
    required bool activeOnly,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'service',
            method: 'getCategories',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'service',
          methodName: 'getCategories',
          parameters: _i1.testObjectToJson({'activeOnly': activeOnly}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i60.ServiceCategory>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i61.Service>> getServicesByCategory(
    _i1.TestSessionBuilder sessionBuilder, {
    required int categoryId,
    required bool activeOnly,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'service',
            method: 'getServicesByCategory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'service',
          methodName: 'getServicesByCategory',
          parameters: _i1.testObjectToJson({
            'categoryId': categoryId,
            'activeOnly': activeOnly,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i61.Service>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i9.DriverProfile>> getDriversByCategory(
    _i1.TestSessionBuilder sessionBuilder, {
    required int categoryId,
    double? clientLat,
    double? clientLng,
    double? radiusKm,
    required bool onlineOnly,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'service',
            method: 'getDriversByCategory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'service',
          methodName: 'getDriversByCategory',
          parameters: _i1.testObjectToJson({
            'categoryId': categoryId,
            'clientLat': clientLat,
            'clientLng': clientLng,
            'radiusKm': radiusKm,
            'onlineOnly': onlineOnly,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i9.DriverProfile>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i9.DriverProfile>> getDriversByService(
    _i1.TestSessionBuilder sessionBuilder, {
    required int serviceId,
    double? clientLat,
    double? clientLng,
    double? radiusKm,
    required bool onlineOnly,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'service',
            method: 'getDriversByService',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'service',
          methodName: 'getDriversByService',
          parameters: _i1.testObjectToJson({
            'serviceId': serviceId,
            'clientLat': clientLat,
            'clientLng': clientLng,
            'radiusKm': radiusKm,
            'onlineOnly': onlineOnly,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i9.DriverProfile>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i60.ServiceCategory?> createCategory(
    _i1.TestSessionBuilder sessionBuilder, {
    required String name,
    required String nameAr,
    required String nameFr,
    String? nameEs,
    required String icon,
    String? description,
    required int displayOrder,
    required double defaultRadiusKm,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'service',
            method: 'createCategory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'service',
          methodName: 'createCategory',
          parameters: _i1.testObjectToJson({
            'name': name,
            'nameAr': nameAr,
            'nameFr': nameFr,
            'nameEs': nameEs,
            'icon': icon,
            'description': description,
            'displayOrder': displayOrder,
            'defaultRadiusKm': defaultRadiusKm,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i60.ServiceCategory?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i60.ServiceCategory?> updateCategory(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'service',
            method: 'updateCategory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'service',
          methodName: 'updateCategory',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i60.ServiceCategory?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i9.DriverProfile>> searchDriversWithServices(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'service',
            method: 'searchDriversWithServices',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'service',
          methodName: 'searchDriversWithServices',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i9.DriverProfile>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i38.DriverService>> getDriverCatalog(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required bool activeOnly,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'service',
            method: 'getDriverCatalog',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'service',
          methodName: 'getDriverCatalog',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'activeOnly': activeOnly,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i38.DriverService>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> trackServiceView(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverServiceId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'service',
            method: 'trackServiceView',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'service',
          methodName: 'trackServiceView',
          parameters: _i1.testObjectToJson({
            'driverServiceId': driverServiceId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> trackServiceInquiry(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverServiceId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'service',
            method: 'trackServiceInquiry',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'service',
          methodName: 'trackServiceInquiry',
          parameters: _i1.testObjectToJson({
            'driverServiceId': driverServiceId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> trackServiceBooking(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverServiceId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'service',
            method: 'trackServiceBooking',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'service',
          methodName: 'trackServiceBooking',
          parameters: _i1.testObjectToJson({
            'driverServiceId': driverServiceId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i62.ServiceAnalytics?> getServiceAnalytics(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverServiceId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'service',
            method: 'getServiceAnalytics',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'service',
          methodName: 'getServiceAnalytics',
          parameters: _i1.testObjectToJson({
            'driverServiceId': driverServiceId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i62.ServiceAnalytics?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> toggleFavorite(
    _i1.TestSessionBuilder sessionBuilder, {
    required int clientId,
    required int driverId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'service',
            method: 'toggleFavorite',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'service',
          methodName: 'toggleFavorite',
          parameters: _i1.testObjectToJson({
            'clientId': clientId,
            'driverId': driverId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i9.DriverProfile>> getFavoriteDrivers(
    _i1.TestSessionBuilder sessionBuilder, {
    required int clientId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'service',
            method: 'getFavoriteDrivers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'service',
          methodName: 'getFavoriteDrivers',
          parameters: _i1.testObjectToJson({'clientId': clientId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i9.DriverProfile>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> isFavorite(
    _i1.TestSessionBuilder sessionBuilder, {
    required int clientId,
    required int driverId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'service',
            method: 'isFavorite',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'service',
          methodName: 'isFavorite',
          parameters: _i1.testObjectToJson({
            'clientId': clientId,
            'driverId': driverId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<int>> getFavoriteDriverIds(
    _i1.TestSessionBuilder sessionBuilder, {
    required int clientId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'service',
            method: 'getFavoriteDriverIds',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'service',
          methodName: 'getFavoriteDriverIds',
          parameters: _i1.testObjectToJson({'clientId': clientId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<int>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _SettingsEndpoint {
  _SettingsEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<String?> getSetting(
    _i1.TestSessionBuilder sessionBuilder,
    String key,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'settings',
            method: 'getSetting',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'settings',
          methodName: 'getSetting',
          parameters: _i1.testObjectToJson({'key': key}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> getSettings(
    _i1.TestSessionBuilder sessionBuilder,
    List<String> keys,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'settings',
            method: 'getSettings',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'settings',
          methodName: 'getSettings',
          parameters: _i1.testObjectToJson({'keys': keys}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, String>> getAllSettings(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'settings',
            method: 'getAllSettings',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'settings',
          methodName: 'getAllSettings',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, String>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> setSetting(
    _i1.TestSessionBuilder sessionBuilder, {
    required String key,
    required String value,
    String? description,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'settings',
            method: 'setSetting',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'settings',
          methodName: 'setSetting',
          parameters: _i1.testObjectToJson({
            'key': key,
            'value': value,
            'description': description,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> setSettings(
    _i1.TestSessionBuilder sessionBuilder,
    Map<String, String> settings,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'settings',
            method: 'setSettings',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'settings',
          methodName: 'setSettings',
          parameters: _i1.testObjectToJson({'settings': settings}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteSetting(
    _i1.TestSessionBuilder sessionBuilder,
    String key,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'settings',
            method: 'deleteSetting',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'settings',
          methodName: 'deleteSetting',
          parameters: _i1.testObjectToJson({'key': key}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i63.AppConfiguration> getAppConfiguration(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'settings',
            method: 'getAppConfiguration',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'settings',
          methodName: 'getAppConfiguration',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i63.AppConfiguration>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> initializeDefaultSettings(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'settings',
            method: 'initializeDefaultSettings',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'settings',
          methodName: 'initializeDefaultSettings',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _StoreDeliveryEndpoint {
  _StoreDeliveryEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i64.NearbyDriver>> getNearbyDrivers(
    _i1.TestSessionBuilder sessionBuilder, {
    required int storeId,
    required int orderId,
    required double radiusKm,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'getNearbyDrivers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'getNearbyDrivers',
          parameters: _i1.testObjectToJson({
            'storeId': storeId,
            'orderId': orderId,
            'radiusKm': radiusKm,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i64.NearbyDriver>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i65.StoreDeliveryRequest?> requestDriver(
    _i1.TestSessionBuilder sessionBuilder, {
    required int storeId,
    required int orderId,
    required int driverId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'requestDriver',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'requestDriver',
          parameters: _i1.testObjectToJson({
            'storeId': storeId,
            'orderId': orderId,
            'driverId': driverId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i65.StoreDeliveryRequest?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i65.StoreDeliveryRequest?> postDeliveryRequest(
    _i1.TestSessionBuilder sessionBuilder, {
    required int storeId,
    required int orderId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'postDeliveryRequest',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'postDeliveryRequest',
          parameters: _i1.testObjectToJson({
            'storeId': storeId,
            'orderId': orderId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i65.StoreDeliveryRequest?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i65.StoreDeliveryRequest>> getStoreDeliveryRequests(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required double latitude,
    required double longitude,
    required double radiusKm,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'getStoreDeliveryRequests',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'getStoreDeliveryRequests',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'latitude': latitude,
            'longitude': longitude,
            'radiusKm': radiusKm,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i65.StoreDeliveryRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StoreOrder?> acceptStoreDelivery(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required int requestId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'acceptStoreDelivery',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'acceptStoreDelivery',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'requestId': requestId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> rejectStoreDelivery(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required int requestId,
    String? reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'rejectStoreDelivery',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'rejectStoreDelivery',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'requestId': requestId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StoreOrder?> arrivedAtStore(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required int orderId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'arrivedAtStore',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'arrivedAtStore',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'orderId': orderId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StoreOrder?> pickedUp(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required int orderId,
    required double amountPaidToStore,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'pickedUp',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'pickedUp',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'orderId': orderId,
            'amountPaidToStore': amountPaidToStore,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StoreOrder?> arrivedAtClient(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required int orderId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'arrivedAtClient',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'arrivedAtClient',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'orderId': orderId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StoreOrder?> delivered(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required int orderId,
    required double amountCollected,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'delivered',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'delivered',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'orderId': orderId,
            'amountCollected': amountCollected,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int?> createOrderChat(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
    required int clientId,
    required int storeId,
    required int driverId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'createOrderChat',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'createOrderChat',
          parameters: _i1.testObjectToJson({
            'orderId': orderId,
            'clientId': clientId,
            'storeId': storeId,
            'driverId': driverId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i66.StoreOrderChat?> getOrCreateOrderChat(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'getOrCreateOrderChat',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'getOrCreateOrderChat',
          parameters: _i1.testObjectToJson({'orderId': orderId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i66.StoreOrderChat?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i67.StoreOrderChatMessage?> sendChatMessage(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
    required int senderId,
    required String senderRole,
    required String senderName,
    required String content,
    required String messageType,
    String? attachmentUrl,
    double? latitude,
    double? longitude,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'sendChatMessage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'sendChatMessage',
          parameters: _i1.testObjectToJson({
            'orderId': orderId,
            'senderId': senderId,
            'senderRole': senderRole,
            'senderName': senderName,
            'content': content,
            'messageType': messageType,
            'attachmentUrl': attachmentUrl,
            'latitude': latitude,
            'longitude': longitude,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i67.StoreOrderChatMessage?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i67.StoreOrderChatMessage>> getChatMessages(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
    required int limit,
    required int offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'getChatMessages',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'getChatMessages',
          parameters: _i1.testObjectToJson({
            'orderId': orderId,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i67.StoreOrderChatMessage>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i68.ChatParticipantsInfo?> getChatParticipantsInfo(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'getChatParticipantsInfo',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'getChatParticipantsInfo',
          parameters: _i1.testObjectToJson({'orderId': orderId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i68.ChatParticipantsInfo?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> addDriverToChat(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
    required int driverId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'addDriverToChat',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'addDriverToChat',
          parameters: _i1.testObjectToJson({
            'orderId': orderId,
            'driverId': driverId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i11.StoreOrder>> getDriverStoreOrders(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required bool activeOnly,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'getDriverStoreOrders',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'getDriverStoreOrders',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'activeOnly': activeOnly,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i11.StoreOrder>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i65.StoreDeliveryRequest?> getOrderDeliveryRequest(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeDelivery',
            method: 'getOrderDeliveryRequest',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeDelivery',
          methodName: 'getOrderDeliveryRequest',
          parameters: _i1.testObjectToJson({'orderId': orderId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i65.StoreDeliveryRequest?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _StoreEndpoint {
  _StoreEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i69.StoreCategory>> getStoreCategories(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'getStoreCategories',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'getStoreCategories',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i69.StoreCategory>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i69.StoreCategory?> getStoreCategoryById(
    _i1.TestSessionBuilder sessionBuilder,
    int categoryId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'getStoreCategoryById',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'getStoreCategoryById',
          parameters: _i1.testObjectToJson({'categoryId': categoryId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i69.StoreCategory?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.Store?> createStore(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'createStore',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'createStore',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.Store?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.Store?> getMyStore(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'getMyStore',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'getMyStore',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.Store?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.Store?> getStoreById(
    _i1.TestSessionBuilder sessionBuilder,
    int storeId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'getStoreById',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'getStoreById',
          parameters: _i1.testObjectToJson({'storeId': storeId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.Store?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.Store?> getStoreByUserId(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'getStoreByUserId',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'getStoreByUserId',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.Store?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.Store?> updateStore(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'updateStore',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'updateStore',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.Store?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.Store?> updateStoreLogo(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int storeId,
    required String logoUrl,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'updateStoreLogo',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'updateStoreLogo',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'storeId': storeId,
            'logoUrl': logoUrl,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.Store?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.Store?> updateStoreCoverImage(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int storeId,
    required String coverImageUrl,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'updateStoreCoverImage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'updateStoreCoverImage',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'storeId': storeId,
            'coverImageUrl': coverImageUrl,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.Store?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.Store?> setWorkingHours(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int storeId,
    required String workingHoursJson,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'setWorkingHours',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'setWorkingHours',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'storeId': storeId,
            'workingHoursJson': workingHoursJson,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.Store?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.Store?> updateStoreExtendedProfile(
    _i1.TestSessionBuilder sessionBuilder, {
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
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'updateStoreExtendedProfile',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'updateStoreExtendedProfile',
          parameters: _i1.testObjectToJson({
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
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.Store?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.Store?> updateStoreGallery(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int storeId,
    required List<String> imageUrls,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'updateStoreGallery',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'updateStoreGallery',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'storeId': storeId,
            'imageUrls': imageUrls,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.Store?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.Store?> addGalleryImage(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int storeId,
    required String imageUrl,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'addGalleryImage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'addGalleryImage',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'storeId': storeId,
            'imageUrl': imageUrl,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.Store?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.Store?> removeGalleryImage(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int storeId,
    required String imageUrl,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'removeGalleryImage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'removeGalleryImage',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'storeId': storeId,
            'imageUrl': imageUrl,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.Store?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.Store?> toggleStoreOpen(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int storeId,
    required bool isOpen,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'toggleStoreOpen',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'toggleStoreOpen',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'storeId': storeId,
            'isOpen': isOpen,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.Store?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i10.Store?> toggleStoreActive(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int storeId,
    required bool isActive,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'toggleStoreActive',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'toggleStoreActive',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'storeId': storeId,
            'isActive': isActive,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.Store?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i10.Store>> getNearbyStores(
    _i1.TestSessionBuilder sessionBuilder, {
    required double latitude,
    required double longitude,
    double? radiusKm,
    int? categoryId,
    required bool openOnly,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'getNearbyStores',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'getNearbyStores',
          parameters: _i1.testObjectToJson({
            'latitude': latitude,
            'longitude': longitude,
            'radiusKm': radiusKm,
            'categoryId': categoryId,
            'openOnly': openOnly,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i10.Store>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i10.Store>> getStoresByCategory(
    _i1.TestSessionBuilder sessionBuilder, {
    required int categoryId,
    double? latitude,
    double? longitude,
    required bool openOnly,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'getStoresByCategory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'getStoresByCategory',
          parameters: _i1.testObjectToJson({
            'categoryId': categoryId,
            'latitude': latitude,
            'longitude': longitude,
            'openOnly': openOnly,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i10.Store>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i10.Store>> searchStores(
    _i1.TestSessionBuilder sessionBuilder, {
    required String query,
    double? latitude,
    double? longitude,
    int? categoryId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'searchStores',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'searchStores',
          parameters: _i1.testObjectToJson({
            'query': query,
            'latitude': latitude,
            'longitude': longitude,
            'categoryId': categoryId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i10.Store>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> isWithinDeliveryZone(
    _i1.TestSessionBuilder sessionBuilder, {
    required int storeId,
    required double clientLatitude,
    required double clientLongitude,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'store',
            method: 'isWithinDeliveryZone',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'store',
          methodName: 'isWithinDeliveryZone',
          parameters: _i1.testObjectToJson({
            'storeId': storeId,
            'clientLatitude': clientLatitude,
            'clientLongitude': clientLongitude,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _StoreOrderEndpoint {
  _StoreOrderEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i11.StoreOrder?> createOrder(
    _i1.TestSessionBuilder sessionBuilder, {
    required int clientId,
    required int storeId,
    required List<_i70.OrderItem> items,
    required String deliveryAddress,
    required double deliveryLatitude,
    required double deliveryLongitude,
    String? clientNotes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'createOrder',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'createOrder',
          parameters: _i1.testObjectToJson({
            'clientId': clientId,
            'storeId': storeId,
            'items': items,
            'deliveryAddress': deliveryAddress,
            'deliveryLatitude': deliveryLatitude,
            'deliveryLongitude': deliveryLongitude,
            'clientNotes': clientNotes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StoreOrder?> getOrder(
    _i1.TestSessionBuilder sessionBuilder,
    int orderId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'getOrder',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'getOrder',
          parameters: _i1.testObjectToJson({'orderId': orderId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StoreOrder?> getOrderByNumber(
    _i1.TestSessionBuilder sessionBuilder,
    String orderNumber,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'getOrderByNumber',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'getOrderByNumber',
          parameters: _i1.testObjectToJson({'orderNumber': orderNumber}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i11.StoreOrder>> getClientOrders(
    _i1.TestSessionBuilder sessionBuilder, {
    required int clientId,
    _i12.StoreOrderStatus? status,
    required int limit,
    required int offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'getClientOrders',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'getClientOrders',
          parameters: _i1.testObjectToJson({
            'clientId': clientId,
            'status': status,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i11.StoreOrder>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i11.StoreOrder>> getClientActiveOrders(
    _i1.TestSessionBuilder sessionBuilder, {
    required int clientId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'getClientActiveOrders',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'getClientActiveOrders',
          parameters: _i1.testObjectToJson({'clientId': clientId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i11.StoreOrder>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StoreOrder?> cancelOrder(
    _i1.TestSessionBuilder sessionBuilder, {
    required int clientId,
    required int orderId,
    required String reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'cancelOrder',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'cancelOrder',
          parameters: _i1.testObjectToJson({
            'clientId': clientId,
            'orderId': orderId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i11.StoreOrder>> getStoreOrders(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int storeId,
    _i12.StoreOrderStatus? status,
    required int limit,
    required int offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'getStoreOrders',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'getStoreOrders',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'storeId': storeId,
            'status': status,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i11.StoreOrder>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i11.StoreOrder>> getStorePendingOrders(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int storeId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'getStorePendingOrders',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'getStorePendingOrders',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'storeId': storeId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i11.StoreOrder>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StoreOrder?> confirmOrder(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int orderId,
    String? storeNotes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'confirmOrder',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'confirmOrder',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'orderId': orderId,
            'storeNotes': storeNotes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StoreOrder?> rejectOrder(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int orderId,
    required String reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'rejectOrder',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'rejectOrder',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'orderId': orderId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StoreOrder?> markPreparing(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int orderId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'markPreparing',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'markPreparing',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'orderId': orderId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StoreOrder?> markReady(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int orderId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'markReady',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'markReady',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'orderId': orderId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StoreOrder?> assignDriver(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int orderId,
    required int driverId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'assignDriver',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'assignDriver',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'orderId': orderId,
            'driverId': driverId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StoreOrder?> driverArrivedAtStore(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required int orderId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'driverArrivedAtStore',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'driverArrivedAtStore',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'orderId': orderId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StoreOrder?> driverPickedUp(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required int orderId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'driverPickedUp',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'driverPickedUp',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'orderId': orderId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StoreOrder?> driverInDelivery(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required int orderId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'driverInDelivery',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'driverInDelivery',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'orderId': orderId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.StoreOrder?> driverDelivered(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required int orderId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'driverDelivered',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'driverDelivered',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'orderId': orderId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.StoreOrder?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i11.StoreOrder>> getDriverStoreOrders(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    required bool activeOnly,
    required int limit,
    required int offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeOrder',
            method: 'getDriverStoreOrders',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeOrder',
          methodName: 'getDriverStoreOrders',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'activeOnly': activeOnly,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i11.StoreOrder>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _StoreProductEndpoint {
  _StoreProductEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i71.ProductCategory?> createProductCategory(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int storeId,
    required String name,
    String? imageUrl,
    int? displayOrder,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeProduct',
            method: 'createProductCategory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeProduct',
          methodName: 'createProductCategory',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'storeId': storeId,
            'name': name,
            'imageUrl': imageUrl,
            'displayOrder': displayOrder,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i71.ProductCategory?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i71.ProductCategory>> getProductCategories(
    _i1.TestSessionBuilder sessionBuilder, {
    required int storeId,
    required bool activeOnly,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeProduct',
            method: 'getProductCategories',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeProduct',
          methodName: 'getProductCategories',
          parameters: _i1.testObjectToJson({
            'storeId': storeId,
            'activeOnly': activeOnly,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i71.ProductCategory>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i71.ProductCategory?> updateProductCategory(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int categoryId,
    String? name,
    String? imageUrl,
    int? displayOrder,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeProduct',
            method: 'updateProductCategory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeProduct',
          methodName: 'updateProductCategory',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'categoryId': categoryId,
            'name': name,
            'imageUrl': imageUrl,
            'displayOrder': displayOrder,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i71.ProductCategory?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i71.ProductCategory?> toggleCategoryActive(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int categoryId,
    required bool isActive,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeProduct',
            method: 'toggleCategoryActive',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeProduct',
          methodName: 'toggleCategoryActive',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'categoryId': categoryId,
            'isActive': isActive,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i71.ProductCategory?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteProductCategory(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int categoryId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeProduct',
            method: 'deleteProductCategory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeProduct',
          methodName: 'deleteProductCategory',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'categoryId': categoryId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i72.StoreProduct?> addProduct(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int storeId,
    int? productCategoryId,
    required String name,
    String? description,
    required double price,
    String? imageUrl,
    int? displayOrder,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeProduct',
            method: 'addProduct',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeProduct',
          methodName: 'addProduct',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'storeId': storeId,
            'productCategoryId': productCategoryId,
            'name': name,
            'description': description,
            'price': price,
            'imageUrl': imageUrl,
            'displayOrder': displayOrder,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i72.StoreProduct?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i72.StoreProduct>> getProducts(
    _i1.TestSessionBuilder sessionBuilder, {
    required int storeId,
    int? categoryId,
    required bool availableOnly,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeProduct',
            method: 'getProducts',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeProduct',
          methodName: 'getProducts',
          parameters: _i1.testObjectToJson({
            'storeId': storeId,
            'categoryId': categoryId,
            'availableOnly': availableOnly,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i72.StoreProduct>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i72.StoreProduct?> getProductById(
    _i1.TestSessionBuilder sessionBuilder,
    int productId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeProduct',
            method: 'getProductById',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeProduct',
          methodName: 'getProductById',
          parameters: _i1.testObjectToJson({'productId': productId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i72.StoreProduct?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i72.StoreProduct?> updateProduct(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int productId,
    int? productCategoryId,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    int? displayOrder,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeProduct',
            method: 'updateProduct',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeProduct',
          methodName: 'updateProduct',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'productId': productId,
            'productCategoryId': productCategoryId,
            'name': name,
            'description': description,
            'price': price,
            'imageUrl': imageUrl,
            'displayOrder': displayOrder,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i72.StoreProduct?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i72.StoreProduct?> toggleProductAvailability(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int productId,
    required bool isAvailable,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeProduct',
            method: 'toggleProductAvailability',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeProduct',
          methodName: 'toggleProductAvailability',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'productId': productId,
            'isAvailable': isAvailable,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i72.StoreProduct?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteProduct(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int productId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeProduct',
            method: 'deleteProduct',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeProduct',
          methodName: 'deleteProduct',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'productId': productId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> reorderProducts(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required int storeId,
    required List<int> productIds,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeProduct',
            method: 'reorderProducts',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeProduct',
          methodName: 'reorderProducts',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'storeId': storeId,
            'productIds': productIds,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i72.StoreProduct>> searchProducts(
    _i1.TestSessionBuilder sessionBuilder, {
    required int storeId,
    required String query,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeProduct',
            method: 'searchProducts',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeProduct',
          methodName: 'searchProducts',
          parameters: _i1.testObjectToJson({
            'storeId': storeId,
            'query': query,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i72.StoreProduct>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _StoreReviewEndpoint {
  _StoreReviewEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i73.StoreReview?> createStoreReview(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
    required int storeId,
    required int clientId,
    required int rating,
    String? comment,
    int? foodQualityRating,
    int? packagingRating,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeReview',
            method: 'createStoreReview',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeReview',
          methodName: 'createStoreReview',
          parameters: _i1.testObjectToJson({
            'orderId': orderId,
            'storeId': storeId,
            'clientId': clientId,
            'rating': rating,
            'comment': comment,
            'foodQualityRating': foodQualityRating,
            'packagingRating': packagingRating,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i73.StoreReview?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i73.StoreReview?> createDriverReviewForStoreOrder(
    _i1.TestSessionBuilder sessionBuilder, {
    required int orderId,
    required int driverId,
    required int clientId,
    required int rating,
    String? comment,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeReview',
            method: 'createDriverReviewForStoreOrder',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeReview',
          methodName: 'createDriverReviewForStoreOrder',
          parameters: _i1.testObjectToJson({
            'orderId': orderId,
            'driverId': driverId,
            'clientId': clientId,
            'rating': rating,
            'comment': comment,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i73.StoreReview?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i73.StoreReview>> getStoreReviews(
    _i1.TestSessionBuilder sessionBuilder, {
    required int storeId,
    int? limit,
    required int offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeReview',
            method: 'getStoreReviews',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeReview',
          methodName: 'getStoreReviews',
          parameters: _i1.testObjectToJson({
            'storeId': storeId,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i73.StoreReview>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i73.StoreReview>> getDriverStoreReviews(
    _i1.TestSessionBuilder sessionBuilder, {
    required int driverId,
    int? limit,
    required int offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeReview',
            method: 'getDriverStoreReviews',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeReview',
          methodName: 'getDriverStoreReviews',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i73.StoreReview>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i74.ReviewWithReviewer>> getReviewsForReviewee(
    _i1.TestSessionBuilder sessionBuilder, {
    required String revieweeType,
    required int revieweeId,
    int? limit,
    required int offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeReview',
            method: 'getReviewsForReviewee',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeReview',
          methodName: 'getReviewsForReviewee',
          parameters: _i1.testObjectToJson({
            'revieweeType': revieweeType,
            'revieweeId': revieweeId,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i74.ReviewWithReviewer>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i73.StoreReview>> getReviewsByClient(
    _i1.TestSessionBuilder sessionBuilder, {
    required int clientId,
    int? limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeReview',
            method: 'getReviewsByClient',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeReview',
          methodName: 'getReviewsByClient',
          parameters: _i1.testObjectToJson({
            'clientId': clientId,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i73.StoreReview>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i73.StoreReview?> respondToReview(
    _i1.TestSessionBuilder sessionBuilder, {
    required int reviewId,
    required int storeId,
    required String response,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeReview',
            method: 'respondToReview',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeReview',
          methodName: 'respondToReview',
          parameters: _i1.testObjectToJson({
            'reviewId': reviewId,
            'storeId': storeId,
            'response': response,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i73.StoreReview?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> getStoreRatingStats(
    _i1.TestSessionBuilder sessionBuilder, {
    required int storeId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'storeReview',
            method: 'getStoreRatingStats',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'storeReview',
          methodName: 'getStoreRatingStats',
          parameters: _i1.testObjectToJson({'storeId': storeId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _TransactionEndpoint {
  _TransactionEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<double> getPlatformCommissionRate(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'transaction',
            method: 'getPlatformCommissionRate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'transaction',
          methodName: 'getPlatformCommissionRate',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<double>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> setPlatformCommissionRate(
    _i1.TestSessionBuilder sessionBuilder,
    double rate,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'transaction',
            method: 'setPlatformCommissionRate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'transaction',
          methodName: 'setPlatformCommissionRate',
          parameters: _i1.testObjectToJson({'rate': rate}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i15.Transaction> recordCashPayment(
    _i1.TestSessionBuilder sessionBuilder,
    int requestId,
    int clientId,
    int driverId,
    double amount, {
    String? notes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'transaction',
            method: 'recordCashPayment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'transaction',
          methodName: 'recordCashPayment',
          parameters: _i1.testObjectToJson({
            'requestId': requestId,
            'clientId': clientId,
            'driverId': driverId,
            'amount': amount,
            'notes': notes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i15.Transaction>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i15.Transaction>> getTransactionHistory(
    _i1.TestSessionBuilder sessionBuilder,
    int userId, {
    int? limit,
    int? offset,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'transaction',
            method: 'getTransactionHistory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'transaction',
          methodName: 'getTransactionHistory',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i15.Transaction>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i75.DriverEarningsResponse> getDriverEarnings(
    _i1.TestSessionBuilder sessionBuilder,
    int driverId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'transaction',
            method: 'getDriverEarnings',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'transaction',
          methodName: 'getDriverEarnings',
          parameters: _i1.testObjectToJson({
            'driverId': driverId,
            'startDate': startDate,
            'endDate': endDate,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i75.DriverEarningsResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i76.Wallet> getWallet(
    _i1.TestSessionBuilder sessionBuilder,
    int userId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'transaction',
            method: 'getWallet',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'transaction',
          methodName: 'getWallet',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i76.Wallet>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i15.Transaction> confirmCashPayment(
    _i1.TestSessionBuilder sessionBuilder,
    int requestId,
    int driverId, {
    String? notes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'transaction',
            method: 'confirmCashPayment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'transaction',
          methodName: 'confirmCashPayment',
          parameters: _i1.testObjectToJson({
            'requestId': requestId,
            'driverId': driverId,
            'notes': notes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i15.Transaction>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i15.Transaction> confirmCashPaymentByClient(
    _i1.TestSessionBuilder sessionBuilder,
    int requestId,
    int clientId, {
    String? notes,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'transaction',
            method: 'confirmCashPaymentByClient',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'transaction',
          methodName: 'confirmCashPaymentByClient',
          parameters: _i1.testObjectToJson({
            'requestId': requestId,
            'clientId': clientId,
            'notes': notes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i15.Transaction>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _TrustScoreEndpoint {
  _TrustScoreEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i77.TrustScoreResult> getClientTrustScore(
    _i1.TestSessionBuilder sessionBuilder,
    int clientId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trustScore',
            method: 'getClientTrustScore',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trustScore',
          methodName: 'getClientTrustScore',
          parameters: _i1.testObjectToJson({'clientId': clientId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i77.TrustScoreResult>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i77.TrustScoreResult> getQuickTrustBadge(
    _i1.TestSessionBuilder sessionBuilder,
    int clientId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trustScore',
            method: 'getQuickTrustBadge',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trustScore',
          methodName: 'getQuickTrustBadge',
          parameters: _i1.testObjectToJson({'clientId': clientId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i77.TrustScoreResult>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i77.TrustScoreResult> refreshTrustScore(
    _i1.TestSessionBuilder sessionBuilder,
    int clientId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trustScore',
            method: 'refreshTrustScore',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trustScore',
          methodName: 'refreshTrustScore',
          parameters: _i1.testObjectToJson({'clientId': clientId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i77.TrustScoreResult>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i77.TrustScoreResult>> batchComputeTrustScores(
    _i1.TestSessionBuilder sessionBuilder,
    List<int> clientIds,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trustScore',
            method: 'batchComputeTrustScores',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trustScore',
          methodName: 'batchComputeTrustScores',
          parameters: _i1.testObjectToJson({'clientIds': clientIds}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i77.TrustScoreResult>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> getPlatformTrustStats(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'trustScore',
            method: 'getPlatformTrustStats',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'trustScore',
          methodName: 'getPlatformTrustStats',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _UserEndpoint {
  _UserEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i78.UserResponse> updateProfile(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    String? fullName,
    String? email,
    String? phoneNumber,
    _i79.Language? preferredLanguage,
    bool? notificationsEnabled,
    bool? darkModeEnabled,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'updateProfile',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'updateProfile',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'fullName': fullName,
            'email': email,
            'phoneNumber': phoneNumber,
            'preferredLanguage': preferredLanguage,
            'notificationsEnabled': notificationsEnabled,
            'darkModeEnabled': darkModeEnabled,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i78.UserResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> updateFCMToken(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required String fcmToken,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'updateFCMToken',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'updateFCMToken',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'fcmToken': fcmToken,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> clearFCMToken(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'clearFCMToken',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'clearFCMToken',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i78.UserResponse> fixPhotoUrls(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'fixPhotoUrls',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'fixPhotoUrls',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i78.UserResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i78.UserResponse> uploadProfilePhoto(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required _i39.ByteData photoData,
    required String fileName,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'uploadProfilePhoto',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'uploadProfilePhoto',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'photoData': photoData,
            'fileName': fileName,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i78.UserResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i78.UserResponse> deleteAccount(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    String? reason,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'deleteAccount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'deleteAccount',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i78.UserResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i78.UserResponse> getUserById(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'getUserById',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'getUserById',
          parameters: _i1.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i78.UserResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i78.UserResponse> addRole(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required _i30.UserRole role,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'addRole',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'addRole',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'role': role,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i78.UserResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i78.UserResponse> removeRole(
    _i1.TestSessionBuilder sessionBuilder, {
    required int userId,
    required _i30.UserRole role,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'removeRole',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'removeRole',
          parameters: _i1.testObjectToJson({
            'userId': userId,
            'role': role,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i78.UserResponse>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _GreetingEndpoint {
  _GreetingEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i80.Greeting> hello(
    _i1.TestSessionBuilder sessionBuilder,
    String name,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'greeting',
            method: 'hello',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'greeting',
          methodName: 'hello',
          parameters: _i1.testObjectToJson({'name': name}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i80.Greeting>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}
