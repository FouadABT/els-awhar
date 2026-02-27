import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import '../../main.dart' show client;

/// =============================================================================
/// AWHAR ANALYTICS EVENT TAXONOMY
/// =============================================================================
/// 
/// Event Naming Convention: snake_case
/// Property Naming Convention: snake_case
/// 
/// Event Categories:
/// - app_*        : App lifecycle events
/// - auth_*       : Authentication events  
/// - onboarding_* : Onboarding flow events
/// - search_*     : Search-related events
/// - driver_*     : Driver-specific events
/// - request_*    : Booking/request events
/// - payment_*    : Payment events
/// - review_*     : Review events
/// - chat_*       : Messaging events
/// - notification_*: Push notification events
/// - error_*      : Error events
/// - engagement_* : General engagement events
/// =============================================================================

/// Unified Analytics Service for Awhar
/// 
/// Combines PostHog, Firebase Analytics, and backend ES logging
/// into a single, easy-to-use service.
/// 
/// Usage:
/// ```dart
/// final analytics = Get.find<AnalyticsService>();
/// analytics.trackEvent('button_clicked', properties: {'button': 'book_now'});
/// ```
class AnalyticsService extends GetxService {
  // PostHog instance
  late final Posthog _posthog;
  
  // Firebase Analytics instance
  late final FirebaseAnalytics _firebaseAnalytics;
  
  // Track initialization state
  final RxBool isInitialized = false.obs;
  
  // Current user ID (synced across platforms)
  String? _userId;
  
  // Current user role (client/driver)
  String? _userRole;
  
  // Session start time for duration tracking
  DateTime? _sessionStartTime;
  
  // Anonymous ID for pre-login tracking
  String? _anonymousId;
  
  // Screen timing tracking
  final Map<String, DateTime> _screenEntryTimes = {};
  String? _currentScreen;
  String? _previousScreen;
  
  // Deep link source tracking
  String? _deepLinkSource;
  String? _deepLinkCampaign;
  
  // Error recovery tracking
  final Map<String, int> _errorRecoveryAttempts = {};
  
  // Debug mode event log (for testing)
  final List<AnalyticsDebugEvent> _debugEventLog = [];
  static const int _maxDebugLogSize = 100;
  
  // Session ID for crash correlation
  late final String _sessionId;
  
  // ===========================================================================
  // ELASTICSEARCH SYNC QUEUE
  // ===========================================================================
  
  /// Buffered events waiting to be flushed to ES via Serverpod
  final List<Map<String, dynamic>> _esEventQueue = [];
  
  /// Timer that triggers periodic batch flush
  Timer? _esFlushTimer;
  
  /// Whether an ES flush is currently in progress (prevents overlap)
  bool _esFlushing = false;
  
  /// Max events before an immediate flush is triggered
  static const int _esQueueMaxSize = 20;
  
  /// Periodic flush interval
  static const Duration _esFlushInterval = Duration(seconds: 30);
  
  /// Track consecutive ES failures for back-off
  int _esConsecutiveFailures = 0;
  
  /// Max consecutive failures before pausing ES sync
  static const int _esMaxConsecutiveFailures = 5;
  
  // PostHog configuration
  static const String _posthogApiKey = 'phc_QbdAcO4msteFL69y1vrz4Swq26IQCWTYltRg3BPPAdN';
  static const String _posthogHost = 'https://us.posthog.com';
  
  /// Initialize the analytics service
  Future<AnalyticsService> init() async {
    try {
      // Generate session ID for crash correlation
      _sessionId = '${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
      _sessionStartTime = DateTime.now();
      
      // Initialize PostHog with comprehensive configuration
      final config = PostHogConfig(_posthogApiKey);
      config.host = _posthogHost;
      config.debug = kDebugMode;
      
      // Lifecycle events
      config.captureApplicationLifecycleEvents = true;
      
      // Session Replay Configuration (Phase 4)
      config.sessionReplay = true;
      config.sessionReplayConfig.maskAllTexts = false;
      config.sessionReplayConfig.maskAllImages = false;
      // Note: Sensitive fields are masked via widget-level masking
      // Use PostHogMaskWidget to wrap sensitive fields like passwords, payment info
      
      // Autocapture for Heatmaps (Phase 4)
      // PostHog Flutter captures gestures automatically when session replay is enabled
      // Heatmaps are generated from these captured gestures
      
      await Posthog().setup(config);
      _posthog = Posthog();
      
      // Reload feature flags on init
      await _posthog.reloadFeatureFlags();
      
      // Initialize Firebase Analytics
      _firebaseAnalytics = FirebaseAnalytics.instance;
      
      // Enable analytics collection
      await _firebaseAnalytics.setAnalyticsCollectionEnabled(true);
      
      // Set session ID for Crashlytics correlation
      await FirebaseCrashlytics.instance.setCustomKey('analytics_session_id', _sessionId);
      await FirebaseCrashlytics.instance.setCustomKey('session_start', _sessionStartTime!.toIso8601String());
      
      isInitialized.value = true;
      
      // Start periodic ES flush timer
      _startEsFlushTimer();
      
      if (kDebugMode) {
        print('[Analytics] ✅ Analytics service initialized');
        print('[Analytics] 📊 PostHog: $_posthogHost');
        print('[Analytics] 🔥 Firebase Analytics: enabled');
        print('[Analytics] 🆔 Session ID: $_sessionId');
        print('[Analytics] 🔄 ES sync: enabled (batch every ${_esFlushInterval.inSeconds}s, max queue $_esQueueMaxSize)');
      }
      
      return this;
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] ❌ Error initializing analytics: $e');
      }
      rethrow;
    }
  }
  
  // ===========================================================================
  // ELASTICSEARCH SYNC QUEUE METHODS
  // ===========================================================================
  
  /// Start the periodic ES flush timer
  void _startEsFlushTimer() {
    _esFlushTimer?.cancel();
    _esFlushTimer = Timer.periodic(_esFlushInterval, (_) => _flushEsQueue());
  }
  
  /// Enqueue an analytics event for ES sync
  /// 
  /// Events are buffered locally and flushed in batches to reduce
  /// network overhead. Flush triggers:
  /// - Every [_esFlushInterval] (30s)
  /// - When queue reaches [_esQueueMaxSize] (20 events)
  /// - On app shutdown (onClose)
  void _enqueueForEs({
    required String eventName,
    String? eventType,
    Map<String, dynamic>? properties,
    String? screenName,
  }) {
    // Skip if too many consecutive failures (back-off)
    if (_esConsecutiveFailures >= _esMaxConsecutiveFailures) {
      // Reset after 5 minutes to retry
      return;
    }
    
    final event = <String, dynamic>{
      'eventName': eventName,
      'eventType': eventType ?? _inferEsEventType(eventName),
      'timestamp': DateTime.now().toUtc().toIso8601String(),
      'userId': _userId != null ? int.tryParse(_userId!) : null,
      'userRole': _userRole,
      'sessionId': _sessionId,
      'screenName': screenName ?? _currentScreen,
      'platform': _getPlatformName(),
      'appVersion': '1.0.0',
      'properties': properties ?? {},
      'source': 'app',
    };
    
    _esEventQueue.add(event);
    
    // Immediate flush if queue is full
    if (_esEventQueue.length >= _esQueueMaxSize) {
      _flushEsQueue();
    }
  }
  
  /// Flush buffered events to Elasticsearch via Serverpod endpoint
  Future<void> _flushEsQueue() async {
    if (_esFlushing || _esEventQueue.isEmpty) return;
    _esFlushing = true;
    
    // Take a snapshot of current queue and clear it
    final batch = List<Map<String, dynamic>>.from(_esEventQueue);
    _esEventQueue.clear();
    
    try {
      final eventsJson = jsonEncode(batch);
      final userId = _userId != null ? int.tryParse(_userId!) : null;
      
      final count = await client.analytics.logEvents(
        eventsJson: eventsJson,
        userId: userId,
      );
      
      _esConsecutiveFailures = 0; // Reset on success
      
      if (kDebugMode) {
        print('[Analytics] 🔄 ES sync: flushed $count/${batch.length} events');
      }
    } catch (e) {
      _esConsecutiveFailures++;
      
      // Put events back in queue for retry (prepend to front)
      _esEventQueue.insertAll(0, batch);
      
      // Trim queue if it gets too large (keep newest)
      if (_esEventQueue.length > _esQueueMaxSize * 3) {
        _esEventQueue.removeRange(0, _esEventQueue.length - _esQueueMaxSize * 2);
      }
      
      if (kDebugMode) {
        print('[Analytics] ❌ ES sync failed (attempt $_esConsecutiveFailures/$_esMaxConsecutiveFailures): $e');
      }
    } finally {
      _esFlushing = false;
    }
  }
  
  /// Infer event type from event name (mirrors server-side logic)
  String _inferEsEventType(String eventName) {
    if (eventName.startsWith('driver_')) return 'driver';
    if (eventName.startsWith('request_') || eventName.startsWith('client_')) return 'client';
    if (eventName.startsWith('error_') || eventName.contains('error')) return 'error';
    if (eventName.startsWith('auth_')) return 'auth';
    if (eventName.startsWith('payment_')) return 'payment';
    if (eventName.startsWith('onboarding_')) return 'onboarding';
    if (eventName.startsWith('search_')) return 'search';
    if (eventName.startsWith('chat_')) return 'chat';
    if (eventName.startsWith('notification_')) return 'notification';
    if (eventName.startsWith('review_')) return 'review';
    if (eventName.startsWith('store_') || eventName.startsWith('product_')) return 'store';
    if (eventName.startsWith('app_')) return 'lifecycle';
    if (eventName == 'screen_time') return 'screen';
    return 'engagement';
  }
  
  /// Get platform name string
  String _getPlatformName() {
    try {
      if (Platform.isAndroid) return 'android';
      if (Platform.isIOS) return 'ios';
      return 'unknown';
    } catch (_) {
      return 'unknown';
    }
  }
  
  /// Force flush ES queue (e.g., before logout)
  Future<void> flushAnalytics() async {
    await _flushEsQueue();
  }
  
  /// Get ES queue status for debugging
  Map<String, dynamic> get esQueueStatus => {
    'queue_size': _esEventQueue.length,
    'is_flushing': _esFlushing,
    'consecutive_failures': _esConsecutiveFailures,
    'max_queue_size': _esQueueMaxSize,
    'flush_interval_seconds': _esFlushInterval.inSeconds,
    'paused': _esConsecutiveFailures >= _esMaxConsecutiveFailures,
  };
  
  /// Reset ES sync failures (re-enable after back-off)
  void resetEsSync() {
    _esConsecutiveFailures = 0;
    if (kDebugMode) {
      print('[Analytics] 🔄 ES sync: reset, re-enabled');
    }
  }
  
  @override
  void onClose() {
    // Flush remaining events before shutdown
    _esFlushTimer?.cancel();
    _flushEsQueue();
    super.onClose();
  }
  
  // ===========================================================================
  // USER IDENTIFICATION
  // ===========================================================================
  
  /// Identify user across all analytics platforms
  /// Call this on login/registration
  /// 
  /// [userId] - Unique user ID from backend
  /// [properties] - User properties like role, city, etc.
  /// [isNewUser] - Whether this is a new registration
  Future<void> identify({
    required String userId,
    Map<String, dynamic>? properties,
    bool isNewUser = false,
  }) async {
    _userId = userId;
    _userRole = properties?['role'] as String?;
    _sessionStartTime = DateTime.now();
    
    try {
      // Merge default properties
      final enrichedProperties = <String, Object>{
        'platform': defaultTargetPlatform.name,
        'app_version': '1.0.0', // TODO: Get from package_info
        if (_anonymousId != null) 'previous_anonymous_id': _anonymousId!,
      };
      
      // Add properties from caller (filter out nulls)
      if (properties != null) {
        for (final entry in properties.entries) {
          if (entry.value != null) {
            enrichedProperties[entry.key] = entry.value;
          }
        }
      }
      
      // PostHog identify
      await _posthog.identify(
        userId: userId,
        userProperties: enrichedProperties,
      );
      
      // Firebase set user ID
      await _firebaseAnalytics.setUserId(id: userId);
      
      // Set Firebase user properties
      for (final entry in enrichedProperties.entries) {
        if (entry.value is String) {
          await _firebaseAnalytics.setUserProperty(
            name: _sanitizePropertyName(entry.key),
            value: entry.value as String,
          );
        }
      }
      
      // Track login/signup event
      if (isNewUser) {
        await trackEvent('auth_signup_completed', properties: {
          'user_id': userId,
          'method': properties?['auth_method'] ?? 'unknown',
        });
        await _firebaseAnalytics.logSignUp(signUpMethod: properties?['auth_method'] ?? 'unknown');
      } else {
        await trackEvent('auth_login_completed', properties: {
          'user_id': userId,
          'method': properties?['auth_method'] ?? 'unknown',
        });
        await _firebaseAnalytics.logLogin(loginMethod: properties?['auth_method'] ?? 'unknown');
      }
      
      if (kDebugMode) {
        print('[Analytics] 👤 User identified: $userId (${isNewUser ? "new" : "returning"})');
      }
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] ❌ Error identifying user: $e');
      }
    }
  }
  
  /// Alias anonymous user to identified user
  /// Call this when a previously anonymous user signs up
  Future<void> alias({required String userId}) async {
    try {
      await _posthog.alias(alias: userId);
      _anonymousId = null;
      
      if (kDebugMode) {
        print('[Analytics] 🔗 User aliased: $userId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] ❌ Error aliasing user: $e');
      }
    }
  }
  
  /// Reset user identity (call on logout)
  Future<void> reset() async {
    // Track logout event before resetting
    if (_userId != null) {
      final sessionDuration = _sessionStartTime != null 
          ? DateTime.now().difference(_sessionStartTime!).inMinutes 
          : null;
      
      await trackEvent('auth_logout', properties: {
        if (sessionDuration != null) 'session_duration_minutes': sessionDuration,
      });
    }
    
    // Flush ES queue before resetting identity
    await _flushEsQueue();
    
    _userId = null;
    _userRole = null;
    _sessionStartTime = null;
    
    try {
      await _posthog.reset();
      await _firebaseAnalytics.setUserId(id: null);
      
      if (kDebugMode) {
        print('[Analytics] 🔄 User identity reset');
      }
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] ❌ Error resetting identity: $e');
      }
    }
  }
  
  /// Track a custom event
  /// 
  /// Events are sent to both PostHog and Firebase Analytics.
  /// 
  /// Example:
  /// ```dart
  /// analytics.trackEvent(
  ///   'booking_created',
  ///   properties: {
  ///     'service_type': 'moving',
  ///     'price': 150.0,
  ///     'city': 'Casablanca',
  ///   },
  /// );
  /// ```
  Future<void> trackEvent(
    String eventName, {
    Map<String, dynamic>? properties,
  }) async {
    // Log to debug console for testing
    _logDebugEvent('event', eventName, properties);
    
    try {
      // Convert to Map<String, Object> for PostHog (filter out nulls)
      Map<String, Object>? posthogProperties;
      if (properties != null) {
        posthogProperties = <String, Object>{};
        for (final entry in properties.entries) {
          if (entry.value != null) {
            posthogProperties[entry.key] = entry.value;
          }
        }
      }
      
      // PostHog event
      await _posthog.capture(
        eventName: eventName,
        properties: posthogProperties,
      );
      
      // Firebase event (with sanitized names)
      await _firebaseAnalytics.logEvent(
        name: _sanitizeEventName(eventName),
        parameters: _sanitizeParameters(properties),
      );
      
      // Enqueue for Elasticsearch sync
      _enqueueForEs(
        eventName: eventName,
        properties: properties,
      );
      
      if (kDebugMode) {
        print('[Analytics] 📊 Event: $eventName (ES queue: ${_esEventQueue.length})');
        if (properties != null) {
          print('[Analytics]    Properties: $properties');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] ❌ Error tracking event: $e');
      }
    }
  }
  
  /// Track screen view
  Future<void> trackScreen(String screenName, {String? screenClass}) async {
    try {
      // PostHog screen
      await _posthog.screen(
        screenName: screenName,
        properties: {
          'screen_class': screenClass ?? screenName,
        },
      );
      
      // Firebase screen
      await _firebaseAnalytics.logScreenView(
        screenName: screenName,
        screenClass: screenClass ?? screenName,
      );
      
      // Enqueue screen view for Elasticsearch sync
      _enqueueForEs(
        eventName: 'screen_view',
        eventType: 'screen',
        properties: {
          'screen_name': screenName,
          'screen_class': screenClass ?? screenName,
        },
        screenName: screenName,
      );
      
      if (kDebugMode) {
        print('[Analytics] 📱 Screen: $screenName (ES queue: ${_esEventQueue.length})');
      }
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] ❌ Error tracking screen: $e');
      }
    }
  }
  
  /// Set a user property
  Future<void> setUserProperty(String name, String value) async {
    try {
      // PostHog
      await _posthog.identify(
        userId: _userId ?? 'anonymous',
        userProperties: {name: value},
        userPropertiesSetOnce: null,
      );
      
      // Firebase
      await _firebaseAnalytics.setUserProperty(
        name: _sanitizePropertyName(name),
        value: value,
      );
      
      if (kDebugMode) {
        print('[Analytics] 👤 User property: $name = $value');
      }
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] ❌ Error setting user property: $e');
      }
    }
  }
  
  /// Check if a feature flag is enabled
  Future<bool> isFeatureEnabled(String flagName) async {
    try {
      return await _posthog.isFeatureEnabled(flagName);
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] ❌ Error checking feature flag: $e');
      }
      return false;
    }
  }
  
  /// Get feature flag value
  Future<dynamic> getFeatureFlag(String flagName) async {
    try {
      return await _posthog.getFeatureFlag(flagName);
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] ❌ Error getting feature flag: $e');
      }
      return null;
    }
  }
  
  /// Reload feature flags
  Future<void> reloadFeatureFlags() async {
    try {
      await _posthog.reloadFeatureFlags();
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] ❌ Error reloading feature flags: $e');
      }
    }
  }
  
  // ===========================================================================
  // PHASE 4: ENHANCED FEATURE FLAGS
  // ===========================================================================
  
  /// Known feature flags for the app
  /// Add new flags here as they are created in PostHog
  static const String flagNewSearchUi = 'new_search_ui';
  static const String flagEnhancedDriverProfile = 'enhanced_driver_profile';
  static const String flagShowRatingsV2 = 'show_ratings_v2';
  static const String flagEnableStoreFeatures = 'enable_store_features';
  static const String flagShowPromotionalBanner = 'show_promotional_banner';
  static const String flagEnableChatMedia = 'enable_chat_media';
  static const String flagNewPaymentFlow = 'new_payment_flow';
  
  /// Check feature flag with tracking
  /// Tracks when a flag is checked and what value was returned
  Future<bool> isFeatureEnabledWithTracking(String flagName) async {
    final isEnabled = await isFeatureEnabled(flagName);
    
    await trackEvent('feature_flag_checked', properties: {
      'flag_name': flagName,
      'flag_value': isEnabled,
      'user_id': _userId,
      'user_role': _userRole,
    });
    
    _logDebugEvent('feature_flag', flagName, {'enabled': isEnabled});
    
    return isEnabled;
  }
  
  /// Get feature flag payload (for multivariate flags)
  Future<T?> getFeatureFlagPayload<T>(String flagName) async {
    try {
      final payload = await _posthog.getFeatureFlagPayload(flagName);
      
      _logDebugEvent('feature_flag_payload', flagName, {
        'payload': payload?.toString(),
      });
      
      return payload as T?;
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] ❌ Error getting feature flag payload: $e');
      }
      return null;
    }
  }
  
  /// Track feature flag exposure (for experiments)
  Future<void> trackFeatureFlagExposure(String flagName, dynamic value) async {
    await trackEvent('\$feature_flag_called', properties: {
      '\$feature_flag': flagName,
      '\$feature_flag_response': value,
    });
  }
  
  // ===========================================================================
  // PHASE 4: FUNNEL TRACKING HELPERS
  // ===========================================================================
  
  /// Client Booking Funnel Steps
  static const List<String> clientBookingFunnelSteps = [
    'search_performed',
    'driver_profile_viewed',
    'request_created',
    'request_accepted',
    'request_completed',
    'review_submitted',
  ];
  
  /// Driver Onboarding Funnel Steps
  static const List<String> driverOnboardingFunnelSteps = [
    'driver_registration_started',
    'driver_profile_created',
    'driver_verification_submitted',
    'driver_verified',
    'driver_went_online',
    'driver_job_completed',
  ];
  
  /// Store Order Funnel Steps
  static const List<String> storeOrderFunnelSteps = [
    'store_browsed',
    'product_viewed',
    'cart_item_added',
    'checkout_started',
    'payment_completed',
    'order_delivered',
  ];
  
  /// Track funnel step with funnel context
  Future<void> trackFunnelStep({
    required String funnelName,
    required String stepName,
    required int stepNumber,
    int? totalSteps,
    Map<String, dynamic>? additionalProperties,
  }) async {
    await trackEvent(stepName, properties: {
      'funnel_name': funnelName,
      'funnel_step': stepNumber,
      'funnel_total_steps': totalSteps,
      'funnel_progress': totalSteps != null ? (stepNumber / totalSteps * 100).round() : null,
      ...?additionalProperties,
    });
    
    _logDebugEvent('funnel_step', '$funnelName:$stepName', {
      'step': stepNumber,
      'total': totalSteps,
    });
  }
  
  /// Track funnel completion
  Future<void> trackFunnelCompleted({
    required String funnelName,
    required int totalSteps,
    int? durationMinutes,
    Map<String, dynamic>? additionalProperties,
  }) async {
    await trackEvent('funnel_completed', properties: {
      'funnel_name': funnelName,
      'total_steps': totalSteps,
      'duration_minutes': durationMinutes,
      ...?additionalProperties,
    });
  }
  
  /// Track funnel abandonment
  Future<void> trackFunnelAbandoned({
    required String funnelName,
    required String lastStep,
    required int stepsCompleted,
    int? totalSteps,
    String? reason,
  }) async {
    await trackEvent('funnel_abandoned', properties: {
      'funnel_name': funnelName,
      'last_step': lastStep,
      'steps_completed': stepsCompleted,
      'total_steps': totalSteps,
      'abandonment_reason': reason,
    });
  }
  
  // ===========================================================================
  // PHASE 4: SESSION RECORDING HELPERS
  // ===========================================================================
  
  /// Mask a screen from session recording
  /// Call this when entering sensitive screens (payments, passwords)
  void maskCurrentScreen() {
    // PostHog will respect the session replay masking configuration
    // This method logs the intent for debugging
    _logDebugEvent('session_recording', 'mask_screen', {
      'screen': _currentScreen,
    });
    
    if (kDebugMode) {
      print('[Analytics] 🔒 Masking current screen from session recording: $_currentScreen');
    }
  }
  
  /// Resume session recording after leaving sensitive screen
  void unmaskCurrentScreen() {
    _logDebugEvent('session_recording', 'unmask_screen', {
      'screen': _currentScreen,
    });
    
    if (kDebugMode) {
      print('[Analytics] 🔓 Resuming session recording for screen: $_currentScreen');
    }
  }
  
  /// Track a notable session event (will appear in session recording timeline)
  Future<void> trackSessionMilestone(String milestone, {Map<String, dynamic>? properties}) async {
    await trackEvent('session_milestone', properties: {
      'milestone': milestone,
      'session_id': _sessionId,
      'session_time_seconds': _sessionStartTime != null 
          ? DateTime.now().difference(_sessionStartTime!).inSeconds 
          : null,
      ...?properties,
    });
    
    _logDebugEvent('session_milestone', milestone, properties);
  }
  
  // ===========================================================================
  // PHASE 4: HEATMAP HELPERS
  // ===========================================================================
  
  /// Track a significant tap for heatmap analysis
  /// Use this for key interactive elements that should appear in heatmaps
  Future<void> trackSignificantTap({
    required String elementName,
    required String screenName,
    double? x,
    double? y,
    Map<String, dynamic>? additionalProperties,
  }) async {
    await trackEvent('significant_tap', properties: {
      'element_name': elementName,
      'screen_name': screenName,
      'tap_x': x,
      'tap_y': y,
      ...?additionalProperties,
    });
  }
  
  /// Track scroll depth on a screen
  Future<void> trackScrollDepth({
    required String screenName,
    required int depthPercent,
    bool isMaxDepth = false,
  }) async {
    await trackEvent('scroll_depth', properties: {
      'screen_name': screenName,
      'depth_percent': depthPercent,
      'is_max_depth': isMaxDepth,
    });
  }
  
  // ===========================================================================
  // PHASE 4: COHORT TRACKING HELPERS
  // ===========================================================================
  
  /// User cohort definitions
  static const String cohortNewUser = 'new_user';        // < 7 days
  static const String cohortActiveUser = 'active_user';  // weekly active
  static const String cohortPowerUser = 'power_user';    // 5+ bookings
  static const String cohortChurnedUser = 'churned_user'; // inactive 30+ days
  
  /// Set user cohort
  Future<void> setUserCohort(String cohort) async {
    await setUserProperty('user_cohort', cohort);
    
    await trackEvent('cohort_assigned', properties: {
      'cohort': cohort,
    });
    
    _logDebugEvent('cohort', cohort, null);
  }
  
  /// Calculate and set user cohort based on data
  Future<void> calculateUserCohort({
    required DateTime registrationDate,
    required int totalBookings,
    DateTime? lastActivityDate,
  }) async {
    final now = DateTime.now();
    final daysSinceRegistration = now.difference(registrationDate).inDays;
    final daysSinceLastActivity = lastActivityDate != null 
        ? now.difference(lastActivityDate).inDays 
        : 0;
    
    String cohort;
    
    if (daysSinceLastActivity > 30) {
      cohort = cohortChurnedUser;
    } else if (totalBookings >= 5) {
      cohort = cohortPowerUser;
    } else if (daysSinceRegistration <= 7) {
      cohort = cohortNewUser;
    } else {
      cohort = cohortActiveUser;
    }
    
    await setUserCohort(cohort);
  }
  
  // ===========================================================================
  // PHASE 4: A/B TEST TRACKING
  // ===========================================================================
  
  /// Track A/B test exposure
  Future<void> trackExperimentExposure({
    required String experimentName,
    required String variant,
    Map<String, dynamic>? properties,
  }) async {
    await trackEvent('experiment_exposure', properties: {
      'experiment_name': experimentName,
      'variant': variant,
      ...?properties,
    });
    
    // Also track as feature flag for PostHog experiments
    await trackFeatureFlagExposure(experimentName, variant);
    
    _logDebugEvent('experiment', experimentName, {'variant': variant});
  }
  
  /// Track A/B test conversion
  Future<void> trackExperimentConversion({
    required String experimentName,
    required String variant,
    required String conversionEvent,
    double? conversionValue,
  }) async {
    await trackEvent('experiment_conversion', properties: {
      'experiment_name': experimentName,
      'variant': variant,
      'conversion_event': conversionEvent,
      'conversion_value': conversionValue,
    });
  }
  
  // ============================================
  // PREDEFINED EVENTS - APP LIFECYCLE
  // ============================================
  
  /// Track app opened
  Future<void> trackAppOpened({
    String? source,
    String? campaign,
    bool fromBackground = false,
  }) async {
    await trackEvent('app_opened', properties: {
      'from_background': fromBackground,
      if (source != null) 'source': source,
      if (campaign != null) 'campaign': campaign,
    });
    await _firebaseAnalytics.logAppOpen();
  }
  
  /// Track app backgrounded
  Future<void> trackAppBackgrounded() async {
    final sessionDuration = _sessionStartTime != null 
        ? DateTime.now().difference(_sessionStartTime!).inSeconds 
        : null;
    
    await trackEvent('app_backgrounded', properties: {
      if (sessionDuration != null) 'session_duration_seconds': sessionDuration,
    });
  }
  
  // ============================================
  // PREDEFINED EVENTS - CLIENT JOURNEY
  // ============================================
  
  /// Track search performed
  Future<void> trackSearch({
    required String query,
    String? category,
    String? city,
    int? resultsCount,
    String? searchType, // 'driver', 'store', 'service'
    Map<String, dynamic>? filters,
  }) async {
    await trackEvent('search_performed', properties: {
      'query': query,
      if (category != null) 'category': category,
      if (city != null) 'city': city,
      if (resultsCount != null) 'results_count': resultsCount,
      if (searchType != null) 'search_type': searchType,
      if (filters != null) 'has_filters': true,
    });
    
    // Firebase standard search event
    await _firebaseAnalytics.logSearch(searchTerm: query);
  }
  
  /// Track search results viewed
  Future<void> trackSearchResultsViewed({
    required String query,
    required int resultsCount,
    String? searchType,
  }) async {
    await trackEvent('search_results_viewed', properties: {
      'query': query,
      'results_count': resultsCount,
      if (searchType != null) 'search_type': searchType,
    });
  }
  
  /// Track driver profile viewed
  Future<void> trackDriverProfileViewed({
    required int driverId,
    required String driverName,
    double? rating,
    String? serviceCategory,
    String? source, // 'search', 'recommendation', 'direct'
  }) async {
    await trackEvent('driver_profile_viewed', properties: {
      'driver_id': driverId,
      'driver_name': driverName,
      if (rating != null) 'rating': rating,
      if (serviceCategory != null) 'service_category': serviceCategory,
      if (source != null) 'source': source,
    });
    
    await _firebaseAnalytics.logViewItem(
      items: [AnalyticsEventItem(
        itemId: driverId.toString(),
        itemName: driverName,
        itemCategory: serviceCategory,
      )],
    );
  }
  
  /// Track store profile viewed
  Future<void> trackStoreProfileViewed({
    required int storeId,
    required String storeName,
    double? rating,
    String? category,
    String? source,
  }) async {
    await trackEvent('store_profile_viewed', properties: {
      'store_id': storeId,
      'store_name': storeName,
      if (rating != null) 'rating': rating,
      if (category != null) 'category': category,
      if (source != null) 'source': source,
    });
  }
  
  /// Track booking request created
  Future<void> trackRequestCreated({
    required int requestId,
    required String serviceType,
    double? estimatedPrice,
    String? city,
    bool fromCatalog = false,
    int? catalogDriverId,
  }) async {
    await trackEvent('request_created', properties: {
      'request_id': requestId,
      'service_type': serviceType,
      if (estimatedPrice != null) 'estimated_price': estimatedPrice,
      if (city != null) 'city': city,
      'from_catalog': fromCatalog,
      if (catalogDriverId != null) 'catalog_driver_id': catalogDriverId,
    });
  }
  
  /// Track request cancelled by client
  Future<void> trackRequestCancelled({
    required int requestId,
    String? reason,
    String? cancelledBy, // 'client', 'driver', 'system'
    int? minutesAfterCreation,
  }) async {
    await trackEvent('request_cancelled', properties: {
      'request_id': requestId,
      if (reason != null) 'reason': reason,
      if (cancelledBy != null) 'cancelled_by': cancelledBy,
      if (minutesAfterCreation != null) 'minutes_after_creation': minutesAfterCreation,
    });
  }
  
  /// Track booking completed
  Future<void> trackRequestCompleted({
    required int requestId,
    required String serviceType,
    required double finalPrice,
    String? currency,
    int? durationMinutes,
    int? driverId,
  }) async {
    await trackEvent('request_completed', properties: {
      'request_id': requestId,
      'service_type': serviceType,
      'final_price': finalPrice,
      'currency': currency ?? 'MAD',
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (driverId != null) 'driver_id': driverId,
    });
    
    // Firebase purchase event
    await _firebaseAnalytics.logPurchase(
      value: finalPrice,
      currency: currency ?? 'MAD',
      items: [
        AnalyticsEventItem(
          itemId: requestId.toString(),
          itemName: serviceType,
          price: finalPrice,
        ),
      ],
    );
  }
  
  /// Track review submitted
  Future<void> trackReviewSubmitted({
    required int requestId,
    required int rating,
    bool hasText = false,
    bool hasPhoto = false,
    int? driverId,
  }) async {
    await trackEvent('review_submitted', properties: {
      'request_id': requestId,
      'rating': rating,
      'has_text': hasText,
      'has_photo': hasPhoto,
      if (driverId != null) 'driver_id': driverId,
    });
  }
  
  // ============================================
  // PREDEFINED EVENTS - PAYMENT
  // ============================================
  
  /// Track payment initiated
  Future<void> trackPaymentInitiated({
    required int requestId,
    required double amount,
    required String paymentMethod,
    String? currency,
  }) async {
    await trackEvent('payment_initiated', properties: {
      'request_id': requestId,
      'amount': amount,
      'payment_method': paymentMethod,
      'currency': currency ?? 'MAD',
    });
    
    await _firebaseAnalytics.logBeginCheckout(
      value: amount,
      currency: currency ?? 'MAD',
    );
  }
  
  /// Track payment completed
  Future<void> trackPaymentCompleted({
    required int requestId,
    required double amount,
    required String paymentMethod,
    String? transactionId,
    String? currency,
  }) async {
    await trackEvent('payment_completed', properties: {
      'request_id': requestId,
      'amount': amount,
      'payment_method': paymentMethod,
      if (transactionId != null) 'transaction_id': transactionId,
      'currency': currency ?? 'MAD',
    });
  }
  
  /// Track payment failed
  Future<void> trackPaymentFailed({
    required int requestId,
    required double amount,
    required String paymentMethod,
    required String errorCode,
    String? errorMessage,
  }) async {
    await trackEvent('payment_failed', properties: {
      'request_id': requestId,
      'amount': amount,
      'payment_method': paymentMethod,
      'error_code': errorCode,
      if (errorMessage != null) 'error_message': errorMessage,
    });
  }
  
  // ============================================
  // PREDEFINED EVENTS - DRIVER JOURNEY
  // ============================================
  
  /// Track driver registration started
  Future<void> trackDriverRegistrationStarted({
    String? referralCode,
    String? source,
  }) async {
    await trackEvent('driver_registration_started', properties: {
      if (referralCode != null) 'referral_code': referralCode,
      if (source != null) 'source': source,
    });
  }
  
  /// Track driver profile created
  Future<void> trackDriverProfileCreated({
    required int driverId,
    required List<String> serviceCategories,
    String? city,
  }) async {
    await trackEvent('driver_profile_created', properties: {
      'driver_id': driverId,
      'service_categories': serviceCategories.join(','),
      'services_count': serviceCategories.length,
      if (city != null) 'city': city,
    });
  }
  
  /// Track driver verification documents submitted
  Future<void> trackDriverVerificationSubmitted({
    required int driverId,
    required List<String> documentTypes,
  }) async {
    await trackEvent('driver_verification_submitted', properties: {
      'driver_id': driverId,
      'document_types': documentTypes.join(','),
      'documents_count': documentTypes.length,
    });
  }
  
  /// Track driver verified
  Future<void> trackDriverVerified({
    required int driverId,
  }) async {
    await trackEvent('driver_verified', properties: {
      'driver_id': driverId,
    });
  }
  
  /// Track driver went online
  Future<void> trackDriverWentOnline({
    required int driverId,
    String? city,
    int? servicesCount,
    double? latitude,
    double? longitude,
  }) async {
    await trackEvent('driver_went_online', properties: {
      'driver_id': driverId,
      if (city != null) 'city': city,
      if (servicesCount != null) 'services_count': servicesCount,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    });
  }
  
  /// Track driver went offline
  Future<void> trackDriverWentOffline({
    required int driverId,
    int? onlineDurationMinutes,
    int? requestsReceived,
    int? requestsAccepted,
  }) async {
    await trackEvent('driver_went_offline', properties: {
      'driver_id': driverId,
      if (onlineDurationMinutes != null) 'online_duration_minutes': onlineDurationMinutes,
      if (requestsReceived != null) 'requests_received': requestsReceived,
      if (requestsAccepted != null) 'requests_accepted': requestsAccepted,
    });
  }
  
  /// Track driver received request notification
  Future<void> trackRequestReceived({
    required int requestId,
    required int driverId,
    required String serviceType,
    double? estimatedPrice,
  }) async {
    await trackEvent('request_received', properties: {
      'request_id': requestId,
      'driver_id': driverId,
      'service_type': serviceType,
      if (estimatedPrice != null) 'estimated_price': estimatedPrice,
    });
  }
  
  /// Track driver accepted request
  Future<void> trackRequestAccepted({
    required int requestId,
    required int driverId,
    int? responseTimeSeconds,
    double? agreedPrice,
  }) async {
    await trackEvent('request_accepted', properties: {
      'request_id': requestId,
      'driver_id': driverId,
      if (responseTimeSeconds != null) 'response_time_seconds': responseTimeSeconds,
      if (agreedPrice != null) 'agreed_price': agreedPrice,
    });
  }
  
  /// Track driver rejected request
  Future<void> trackRequestRejected({
    required int requestId,
    required int driverId,
    String? reason,
    int? responseTimeSeconds,
  }) async {
    await trackEvent('request_rejected', properties: {
      'request_id': requestId,
      'driver_id': driverId,
      if (reason != null) 'reason': reason,
      if (responseTimeSeconds != null) 'response_time_seconds': responseTimeSeconds,
    });
  }
  
  /// Track job started
  Future<void> trackJobStarted({
    required int requestId,
    required int driverId,
  }) async {
    await trackEvent('job_started', properties: {
      'request_id': requestId,
      'driver_id': driverId,
    });
  }
  
  /// Track job completed by driver
  Future<void> trackJobCompleted({
    required int requestId,
    required int driverId,
    required double finalPrice,
    int? durationMinutes,
  }) async {
    await trackEvent('job_completed', properties: {
      'request_id': requestId,
      'driver_id': driverId,
      'final_price': finalPrice,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
    });
  }
  
  /// Track driver viewed earnings
  Future<void> trackEarningsViewed({
    required int driverId,
    double? totalEarnings,
    String? period, // 'today', 'week', 'month'
  }) async {
    await trackEvent('earnings_viewed', properties: {
      'driver_id': driverId,
      if (totalEarnings != null) 'total_earnings': totalEarnings,
      if (period != null) 'period': period,
    });
  }
  
  /// Track driver requested withdrawal
  Future<void> trackWithdrawalRequested({
    required int driverId,
    required double amount,
    required String method,
  }) async {
    await trackEvent('withdrawal_requested', properties: {
      'driver_id': driverId,
      'amount': amount,
      'method': method,
    });
  }
  
  /// Track driver service added
  Future<void> trackDriverServiceAdded({
    required int driverId,
    required int serviceId,
    required String serviceName,
    double? basePrice,
  }) async {
    await trackEvent('driver_service_added', properties: {
      'driver_id': driverId,
      'service_id': serviceId,
      'service_name': serviceName,
      if (basePrice != null) 'base_price': basePrice,
    });
  }
  
  /// Track driver earnings viewed (alias for trackEarningsViewed)
  Future<void> trackDriverEarningsViewed({
    String? period,
    double? amount,
  }) async {
    await trackEvent('driver_earnings_viewed', properties: {
      if (period != null) 'period': period,
      if (amount != null) 'amount': amount,
    });
  }
  
  /// Track driver job accepted
  Future<void> trackDriverJobAccepted({
    required int requestId,
    int? responseTimeSeconds,
  }) async {
    await trackEvent('driver_job_accepted', properties: {
      'request_id': requestId,
      if (responseTimeSeconds != null) 'response_time_seconds': responseTimeSeconds,
    });
  }
  
  // ============================================
  // PREDEFINED EVENTS - ENGAGEMENT
  // ============================================
  
  /// Track onboarding started
  Future<void> trackOnboardingStarted({
    String? userRole,
  }) async {
    await trackEvent('onboarding_started', properties: {
      if (userRole != null) 'user_role': userRole,
    });
    await _firebaseAnalytics.logTutorialBegin();
  }
  
  /// Track onboarding step
  Future<void> trackOnboardingStep({
    required int step,
    required String stepName,
    bool completed = true,
    int? durationSeconds,
  }) async {
    await trackEvent('onboarding_step_completed', properties: {
      'step': step,
      'step_name': stepName,
      'completed': completed,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
    });
  }
  
  /// Track onboarding completed
  Future<void> trackOnboardingCompleted({
    int? totalDurationSeconds,
    String? userRole,
  }) async {
    await trackEvent('onboarding_completed', properties: {
      if (totalDurationSeconds != null) 'total_duration_seconds': totalDurationSeconds,
      if (userRole != null) 'user_role': userRole,
    });
    await _firebaseAnalytics.logTutorialComplete();
  }
  
  /// Track onboarding skipped
  Future<void> trackOnboardingSkipped({
    required int atStep,
  }) async {
    await trackEvent('onboarding_skipped', properties: {
      'at_step': atStep,
    });
  }
  
  /// Track button clicked
  Future<void> trackButtonClicked({
    required String buttonName,
    String? screen,
    Map<String, dynamic>? context,
  }) async {
    await trackEvent('button_clicked', properties: {
      'button_name': buttonName,
      if (screen != null) 'screen': screen,
      ...?context,
    });
  }
  
  /// Track filter applied
  Future<void> trackFilterApplied({
    required String filterType,
    required String filterValue,
    String? screen,
  }) async {
    await trackEvent('filter_applied', properties: {
      'filter_type': filterType,
      'filter_value': filterValue,
      if (screen != null) 'screen': screen,
    });
  }
  
  /// Track sort changed
  Future<void> trackSortChanged({
    required String sortBy,
    required String sortOrder,
    String? screen,
  }) async {
    await trackEvent('sort_changed', properties: {
      'sort_by': sortBy,
      'sort_order': sortOrder,
      if (screen != null) 'screen': screen,
    });
  }
  
  /// Track chat opened
  Future<void> trackChatOpened({
    required int conversationId,
    required String otherUserRole, // 'client' or 'driver'
    int? requestId,
  }) async {
    await trackEvent('chat_opened', properties: {
      'conversation_id': conversationId,
      'other_user_role': otherUserRole,
      if (requestId != null) 'request_id': requestId,
    });
  }
  
  /// Track chat message sent
  Future<void> trackChatMessageSent({
    required int conversationId,
    required String messageType, // 'text', 'image', 'audio', 'location'
    int? requestId,
  }) async {
    await trackEvent('chat_message_sent', properties: {
      'conversation_id': conversationId,
      'message_type': messageType,
      if (requestId != null) 'request_id': requestId,
    });
  }
  
  /// Track notification received
  Future<void> trackNotificationReceived({
    required String notificationType,
    String? title,
    String? source, // 'push', 'in_app'
  }) async {
    await trackEvent('notification_received', properties: {
      'notification_type': notificationType,
      if (title != null) 'title': title,
      if (source != null) 'source': source,
    });
  }
  
  /// Track notification opened
  Future<void> trackNotificationOpened({
    required String notificationType,
    String? action,
    String? targetScreen,
  }) async {
    await trackEvent('notification_opened', properties: {
      'notification_type': notificationType,
      if (action != null) 'action': action,
      if (targetScreen != null) 'target_screen': targetScreen,
    });
  }
  
  /// Track content shared
  Future<void> trackShareTriggered({
    required String contentType,
    required String contentId,
    String? method, // 'whatsapp', 'copy_link', 'system'
  }) async {
    await trackEvent('share_triggered', properties: {
      'content_type': contentType,
      'content_id': contentId,
      if (method != null) 'method': method,
    });
    
    await _firebaseAnalytics.logShare(
      contentType: contentType,
      itemId: contentId,
      method: method ?? 'unknown',
    );
  }
  
  /// Track help/support accessed
  Future<void> trackHelpAccessed({
    String? section, // 'faq', 'contact', 'chat'
    String? query,
  }) async {
    await trackEvent('help_accessed', properties: {
      if (section != null) 'section': section,
      if (query != null) 'query': query,
    });
  }
  
  /// Track language changed
  Future<void> trackLanguageChanged({
    required String fromLanguage,
    required String toLanguage,
  }) async {
    await trackEvent('language_changed', properties: {
      'from_language': fromLanguage,
      'to_language': toLanguage,
    });
  }
  
  /// Track theme changed
  Future<void> trackThemeChanged({
    required String theme, // 'light', 'dark', 'system'
  }) async {
    await trackEvent('theme_changed', properties: {
      'theme': theme,
    });
  }
  
  // ============================================
  // PREDEFINED EVENTS - ERRORS
  // ============================================
  
  /// Track general error
  Future<void> trackError({
    required String errorType,
    required String errorMessage,
    String? screen,
    String? errorCode,
    Map<String, dynamic>? context,
  }) async {
    await trackEvent('error_occurred', properties: {
      'error_type': errorType,
      'error_message': errorMessage,
      if (screen != null) 'screen': screen,
      if (errorCode != null) 'error_code': errorCode,
      ...?context,
    });
    
    // Also log to Crashlytics
    FirebaseCrashlytics.instance.log('[$errorType] $errorMessage');
  }
  
  /// Track network error
  Future<void> trackNetworkError({
    required String endpoint,
    required int statusCode,
    String? errorMessage,
    int? retryCount,
  }) async {
    await trackEvent('network_error', properties: {
      'endpoint': endpoint,
      'status_code': statusCode,
      if (errorMessage != null) 'error_message': errorMessage,
      if (retryCount != null) 'retry_count': retryCount,
    });
  }
  
  /// Track validation error
  Future<void> trackValidationError({
    required String field,
    required String errorType,
    String? screen,
  }) async {
    await trackEvent('validation_error', properties: {
      'field': field,
      'error_type': errorType,
      if (screen != null) 'screen': screen,
    });
  }
  
  /// Track location error
  Future<void> trackLocationError({
    required String errorType,
    String? errorMessage,
  }) async {
    await trackEvent('location_error', properties: {
      'error_type': errorType,
      if (errorMessage != null) 'error_message': errorMessage,
    });
  }
  
  /// Track permission denied
  Future<void> trackPermissionDenied({
    required String permissionType, // 'location', 'camera', 'notifications', 'storage'
    bool permanently = false,
  }) async {
    await trackEvent('permission_denied', properties: {
      'permission_type': permissionType,
      'permanently': permanently,
    });
  }
  
  // ============================================
  // HELPERS
  // ============================================
  
  /// Sanitize event name for Firebase (max 40 chars, alphanumeric + underscore)
  String _sanitizeEventName(String name) {
    return name
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9_]'), '_')
        .substring(0, name.length > 40 ? 40 : name.length);
  }
  
  /// Sanitize property name for Firebase (max 24 chars)
  String _sanitizePropertyName(String name) {
    return name
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9_]'), '_')
        .substring(0, name.length > 24 ? 24 : name.length);
  }
  
  /// Sanitize parameters for Firebase
  Map<String, Object>? _sanitizeParameters(Map<String, dynamic>? params) {
    if (params == null) return null;
    
    final sanitized = <String, Object>{};
    for (final entry in params.entries) {
      final key = _sanitizePropertyName(entry.key);
      final value = entry.value;
      
      // Firebase only accepts String, int, double, bool
      if (value is String || value is int || value is double || value is bool) {
        sanitized[key] = value;
      } else if (value != null) {
        sanitized[key] = value.toString();
      }
    }
    
    return sanitized.isEmpty ? null : sanitized;
  }
  
  // ===========================================================================
  // PHASE 3: ENHANCED SCREEN TRACKING
  // ===========================================================================
  
  /// Get the unified navigator observer for comprehensive screen tracking
  /// This observer tracks screen views, timing, and sends to all platforms
  AnalyticsNavigatorObserver get observer => AnalyticsNavigatorObserver(this);
  
  /// Track screen entry with timestamp
  void _onScreenEnter(String screenName) {
    _previousScreen = _currentScreen;
    _currentScreen = screenName;
    _screenEntryTimes[screenName] = DateTime.now();
    
    _logDebugEvent('screen_enter', screenName, {
      'previous_screen': _previousScreen,
    });
  }
  
  /// Track screen exit and calculate time spent
  void _onScreenExit(String screenName) {
    final entryTime = _screenEntryTimes[screenName];
    if (entryTime != null) {
      final duration = DateTime.now().difference(entryTime);
      
      // Track screen time event
      trackEvent('screen_time', properties: {
        'screen_name': screenName,
        'duration_seconds': duration.inSeconds,
        'duration_ms': duration.inMilliseconds,
      });
      
      _logDebugEvent('screen_exit', screenName, {
        'duration_seconds': duration.inSeconds,
      });
      
      _screenEntryTimes.remove(screenName);
    }
  }
  
  /// Get time spent on current screen (in seconds)
  int? getCurrentScreenTime() {
    if (_currentScreen == null) return null;
    final entryTime = _screenEntryTimes[_currentScreen];
    if (entryTime == null) return null;
    return DateTime.now().difference(entryTime).inSeconds;
  }
  
  /// Get current screen name
  String? get currentScreen => _currentScreen;
  
  /// Get previous screen name
  String? get previousScreen => _previousScreen;
  
  // ===========================================================================
  // PHASE 3: DEEP LINK TRACKING
  // ===========================================================================
  
  /// Track deep link opened
  /// Call this when the app is opened via a deep link
  Future<void> trackDeepLinkOpened({
    required String url,
    String? source,
    String? campaign,
    String? medium,
    Map<String, dynamic>? additionalParams,
  }) async {
    _deepLinkSource = source;
    _deepLinkCampaign = campaign;
    
    // Set Crashlytics keys for correlation
    await FirebaseCrashlytics.instance.setCustomKey('deep_link_source', source ?? 'unknown');
    await FirebaseCrashlytics.instance.setCustomKey('deep_link_campaign', campaign ?? 'none');
    
    await trackEvent('deep_link_opened', properties: {
      'url': url,
      'source': source,
      'campaign': campaign,
      'medium': medium,
      ...?additionalParams,
    });
    
    _logDebugEvent('deep_link_opened', url, {
      'source': source,
      'campaign': campaign,
    });
  }
  
  /// Track deep link navigation (when user navigates to target screen)
  Future<void> trackDeepLinkNavigated({
    required String targetScreen,
    required String deepLinkUrl,
    bool successful = true,
  }) async {
    await trackEvent('deep_link_navigated', properties: {
      'target_screen': targetScreen,
      'deep_link_url': deepLinkUrl,
      'successful': successful,
      'source': _deepLinkSource,
      'campaign': _deepLinkCampaign,
    });
  }
  
  // ===========================================================================
  // PHASE 3: ERROR RECOVERY TRACKING
  // ===========================================================================
  
  /// Track when an error occurs and recovery is attempted
  Future<void> trackErrorRecoveryStarted({
    required String errorType,
    required String recoveryMethod,
    Map<String, dynamic>? errorContext,
  }) async {
    final key = '${errorType}_$recoveryMethod';
    _errorRecoveryAttempts[key] = (_errorRecoveryAttempts[key] ?? 0) + 1;
    
    await trackEvent('error_recovery_started', properties: {
      'error_type': errorType,
      'recovery_method': recoveryMethod,
      'attempt_number': _errorRecoveryAttempts[key],
      ...?errorContext,
    });
    
    _logDebugEvent('error_recovery_started', errorType, {
      'recovery_method': recoveryMethod,
      'attempt': _errorRecoveryAttempts[key],
    });
  }
  
  /// Track when error recovery succeeds
  Future<void> trackErrorRecoverySuccess({
    required String errorType,
    required String recoveryMethod,
    int? attemptsTaken,
  }) async {
    final key = '${errorType}_$recoveryMethod';
    final attempts = attemptsTaken ?? _errorRecoveryAttempts[key] ?? 1;
    
    await trackEvent('error_recovery_success', properties: {
      'error_type': errorType,
      'recovery_method': recoveryMethod,
      'attempts_taken': attempts,
    });
    
    // Reset counter on success
    _errorRecoveryAttempts.remove(key);
    
    _logDebugEvent('error_recovery_success', errorType, {
      'recovery_method': recoveryMethod,
      'attempts': attempts,
    });
  }
  
  /// Track when error recovery fails
  Future<void> trackErrorRecoveryFailed({
    required String errorType,
    required String recoveryMethod,
    String? finalError,
    int? attemptsTaken,
  }) async {
    final key = '${errorType}_$recoveryMethod';
    final attempts = attemptsTaken ?? _errorRecoveryAttempts[key] ?? 1;
    
    await trackEvent('error_recovery_failed', properties: {
      'error_type': errorType,
      'recovery_method': recoveryMethod,
      'attempts_taken': attempts,
      'final_error': finalError,
    });
    
    // Reset counter on failure
    _errorRecoveryAttempts.remove(key);
    
    _logDebugEvent('error_recovery_failed', errorType, {
      'recovery_method': recoveryMethod,
      'attempts': attempts,
      'final_error': finalError,
    });
  }
  
  // ===========================================================================
  // PHASE 3: CRASH-SESSION CORRELATION
  // ===========================================================================
  
  /// Get current session ID (for crash correlation)
  String get sessionId => _sessionId;
  
  /// Update Crashlytics with current analytics context
  /// Call this periodically or on important events
  Future<void> syncCrashlyticsContext() async {
    try {
      await FirebaseCrashlytics.instance.setCustomKey('analytics_session_id', _sessionId);
      await FirebaseCrashlytics.instance.setCustomKey('current_screen', _currentScreen ?? 'unknown');
      await FirebaseCrashlytics.instance.setCustomKey('previous_screen', _previousScreen ?? 'none');
      await FirebaseCrashlytics.instance.setCustomKey('user_role', _userRole ?? 'unknown');
      
      if (_sessionStartTime != null) {
        final sessionDuration = DateTime.now().difference(_sessionStartTime!).inMinutes;
        await FirebaseCrashlytics.instance.setCustomKey('session_duration_minutes', sessionDuration);
      }
      
      if (_deepLinkSource != null) {
        await FirebaseCrashlytics.instance.setCustomKey('deep_link_source', _deepLinkSource!);
      }
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] ⚠️ Error syncing Crashlytics context: $e');
      }
    }
  }
  
  /// Log a breadcrumb for crash analysis
  Future<void> logBreadcrumb(String message, {Map<String, dynamic>? data}) async {
    try {
      final breadcrumb = data != null 
          ? '$message: ${data.entries.map((e) => '${e.key}=${e.value}').join(', ')}'
          : message;
      await FirebaseCrashlytics.instance.log(breadcrumb);
      
      _logDebugEvent('breadcrumb', message, data);
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] ⚠️ Error logging breadcrumb: $e');
      }
    }
  }
  
  // ===========================================================================
  // PHASE 3: DEBUG & TESTING UTILITIES
  // ===========================================================================
  
  /// Log event to debug console (only in debug mode)
  void _logDebugEvent(String type, String name, Map<String, dynamic>? properties) {
    if (!kDebugMode) return;
    
    final event = AnalyticsDebugEvent(
      timestamp: DateTime.now(),
      type: type,
      name: name,
      properties: properties,
    );
    
    _debugEventLog.add(event);
    
    // Keep log size manageable
    if (_debugEventLog.length > _maxDebugLogSize) {
      _debugEventLog.removeAt(0);
    }
  }
  
  /// Get debug event log (for testing UI)
  List<AnalyticsDebugEvent> get debugEventLog => List.unmodifiable(_debugEventLog);
  
  /// Clear debug event log
  void clearDebugLog() {
    _debugEventLog.clear();
  }
  
  /// Print all debug events to console (for testing)
  void printDebugLog() {
    if (!kDebugMode) return;
    
    print('\n========== ANALYTICS DEBUG LOG ==========');
    print('Session ID: $_sessionId');
    print('User ID: ${_userId ?? 'anonymous'}');
    print('User Role: ${_userRole ?? 'unknown'}');
    print('Current Screen: ${_currentScreen ?? 'none'}');
    print('Events logged: ${_debugEventLog.length}');
    print('==========================================\n');
    
    for (final event in _debugEventLog) {
      print('[${event.timestamp.toIso8601String()}] ${event.type.toUpperCase()}: ${event.name}');
      if (event.properties != null && event.properties!.isNotEmpty) {
        print('   Properties: ${event.properties}');
      }
    }
    
    print('\n==========================================\n');
  }
  
  /// Export debug log as JSON (for testing)
  List<Map<String, dynamic>> exportDebugLog() {
    return _debugEventLog.map((e) => e.toJson()).toList();
  }
  
  /// Validate that an event was tracked (for testing)
  bool wasEventTracked(String eventName, {Map<String, dynamic>? withProperties}) {
    for (final event in _debugEventLog) {
      if (event.name == eventName) {
        if (withProperties == null) return true;
        
        // Check if all required properties match
        if (event.properties == null) continue;
        bool allMatch = true;
        for (final entry in withProperties.entries) {
          if (event.properties![entry.key] != entry.value) {
            allMatch = false;
            break;
          }
        }
        if (allMatch) return true;
      }
    }
    return false;
  }
  
  /// Get count of times an event was tracked
  int getEventCount(String eventName) {
    return _debugEventLog.where((e) => e.name == eventName).length;
  }
  
  /// Get analytics health status
  Map<String, dynamic> getHealthStatus() {
    return {
      'initialized': isInitialized.value,
      'session_id': _sessionId,
      'session_start': _sessionStartTime?.toIso8601String(),
      'session_duration_minutes': _sessionStartTime != null 
          ? DateTime.now().difference(_sessionStartTime!).inMinutes 
          : 0,
      'user_id': _userId,
      'user_role': _userRole,
      'current_screen': _currentScreen,
      'screens_visited': _screenEntryTimes.keys.toList(),
      'events_logged': _debugEventLog.length,
      'posthog_host': _posthogHost,
      'deep_link_source': _deepLinkSource,
      'error_recovery_attempts': Map.from(_errorRecoveryAttempts),
      'es_sync': esQueueStatus,
    };
  }
}

// =============================================================================
// ANALYTICS DEBUG EVENT
// =============================================================================

/// Debug event for analytics testing
class AnalyticsDebugEvent {
  final DateTime timestamp;
  final String type;
  final String name;
  final Map<String, dynamic>? properties;
  
  AnalyticsDebugEvent({
    required this.timestamp,
    required this.type,
    required this.name,
    this.properties,
  });
  
  Map<String, dynamic> toJson() => {
    'timestamp': timestamp.toIso8601String(),
    'type': type,
    'name': name,
    'properties': properties,
  };
  
  @override
  String toString() => 'AnalyticsDebugEvent($type: $name at $timestamp)';
}

// =============================================================================
// ANALYTICS NAVIGATOR OBSERVER
// =============================================================================

/// Custom navigator observer that tracks screen views with timing
/// across all analytics platforms (PostHog, Firebase, ES)
class AnalyticsNavigatorObserver extends NavigatorObserver {
  final AnalyticsService _analytics;
  
  AnalyticsNavigatorObserver(this._analytics);
  
  String? _extractScreenName(Route<dynamic>? route) {
    if (route == null) return null;
    
    // Try to get the route name
    String? screenName = route.settings.name;
    
    // If no name, try to extract from route type
    if (screenName == null || screenName.isEmpty) {
      final routeType = route.runtimeType.toString();
      screenName = routeType.replaceAll('Route', '').replaceAll('_', '');
    }
    
    // Clean up the screen name
    if (screenName.startsWith('/')) {
      screenName = screenName.substring(1);
    }
    
    // Convert to readable format
    return screenName.isEmpty ? 'unknown' : screenName;
  }
  
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    
    final screenName = _extractScreenName(route);
    final previousScreenName = _extractScreenName(previousRoute);
    
    if (screenName != null) {
      // Track screen exit for previous screen
      if (previousScreenName != null) {
        _analytics._onScreenExit(previousScreenName);
      }
      
      // Track screen entry for new screen
      _analytics._onScreenEnter(screenName);
      
      // Track screen view to all platforms
      _analytics.trackScreen(screenName, screenClass: route.runtimeType.toString());
      
      // Sync Crashlytics context
      _analytics.syncCrashlyticsContext();
      
      if (kDebugMode) {
        print('[Analytics] 📱 Screen pushed: $screenName (from: $previousScreenName)');
      }
    }
  }
  
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    
    final screenName = _extractScreenName(route);
    final returningToScreen = _extractScreenName(previousRoute);
    
    if (screenName != null) {
      // Track screen exit for popped screen
      _analytics._onScreenExit(screenName);
      
      // Track return to previous screen
      if (returningToScreen != null) {
        _analytics._onScreenEnter(returningToScreen);
        _analytics.trackScreen(returningToScreen, screenClass: previousRoute?.runtimeType.toString());
        
        // Sync Crashlytics context
        _analytics.syncCrashlyticsContext();
      }
      
      if (kDebugMode) {
        print('[Analytics] 📱 Screen popped: $screenName (returning to: $returningToScreen)');
      }
    }
  }
  
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    
    final oldScreenName = _extractScreenName(oldRoute);
    final newScreenName = _extractScreenName(newRoute);
    
    // Track exit for old screen
    if (oldScreenName != null) {
      _analytics._onScreenExit(oldScreenName);
    }
    
    // Track entry for new screen
    if (newScreenName != null) {
      _analytics._onScreenEnter(newScreenName);
      _analytics.trackScreen(newScreenName, screenClass: newRoute?.runtimeType.toString());
      
      // Sync Crashlytics context
      _analytics.syncCrashlyticsContext();
      
      if (kDebugMode) {
        print('[Analytics] 📱 Screen replaced: $oldScreenName → $newScreenName');
      }
    }
  }
  
  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    
    final screenName = _extractScreenName(route);
    
    if (screenName != null) {
      _analytics._onScreenExit(screenName);
      
      if (kDebugMode) {
        print('[Analytics] 📱 Screen removed: $screenName');
      }
    }
  }
}
