import 'package:awhar_client/awhar_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

import 'app/bindings/initial_binding.dart';
import 'app/modules/home/home_binding.dart';
import 'app/modules/home/home_screen.dart';
import 'app/modules/onboarding/onboarding_controller.dart';
import 'app/routes/app_routes.dart';
import 'config/app_config.dart';
import 'config/app_runtime.dart';
import 'core/controllers/store_order_controller.dart';
import 'core/controllers/driver_store_delivery_controller.dart';
import 'core/localization/app_locales.dart';
import 'core/localization/app_translations.dart';
import 'core/services/storage_service.dart';
import 'core/services/notification_service.dart';
import 'core/services/analytics_service.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'screens/greetings_screen.dart';
import 'screens/es_test_screen.dart';
import 'screens/es_test_hub_screen.dart';
import 'shared/widgets/language_switcher.dart';
import 'shared/widgets/theme_mode_switcher.dart';
import 'test_email_screen.dart';

/// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('[FCM] Background message: ${message.notification?.title}');
}

/// Sets up a global client object that can be used to talk to the server from
/// anywhere in our app. The client is generated from your server code
/// and is set up to connect to a Serverpod running on a local server on
/// the default port. You will need to modify this to connect to staging or
/// production servers.
/// In a larger app, you may want to use the dependency injection of your choice
/// instead of using a global client object. This is just a simple example.
late final Client client;

late String serverUrl;

/// Check if onboarding should be shown
late bool _showOnboarding;

/// Initialize Firebase Cloud Messaging and get FCM token
Future<void> _initializeFCM() async {
  try {
    final messaging = FirebaseMessaging.instance;

    // Request permission for notifications (iOS)
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (kDebugMode) {
      print('🔔 FCM Permission Status: ${settings.authorizationStatus}');
    }

    // Get FCM token
    final fcmToken = await messaging.getToken();

    if (kDebugMode) {
      print('🔑 FCM Token: $fcmToken');
      print('📱 Save this token for testing push notifications');
    }

    // Listen to token refresh
    messaging.onTokenRefresh.listen((newToken) {
      if (kDebugMode) {
        print('🔄 FCM Token Refreshed: $newToken');
      }
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('📬 Foreground message received:');
      print('  Title: ${message.notification?.title}');
      print('  Body: ${message.notification?.body}');
      print('  Data: ${message.data}');

      // Show snackbar notification
      Get.snackbar(
        message.notification?.title ?? 'New Notification',
        message.notification?.body ?? '',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
        mainButton: TextButton(
          onPressed: Get.back,
          child: const Text('Dismiss', style: TextStyle(color: Colors.white)),
        ),
      );

      // Auto-refresh orders if this is an order notification
      if (message.data['type'] == 'order') {
        print('🔄 Order notification received, auto-refreshing orders...');
        try {
          if (Get.isRegistered<StoreOrderController>()) {
            final storeOrderController = Get.find<StoreOrderController>();
            storeOrderController.refresh();
          }
        } catch (e) {
          print('⚠️ Could not refresh orders: $e');
        }
      } 

      // Auto-refresh delivery requests if this is a delivery notification
      if (message.data['type'] == 'delivery' || message.data['match_type'] == 'smart_match') {
        print('🔄 Delivery/SmartMatch notification received, auto-refreshing...');
        try {
          // Register controller if not already registered
          if (!Get.isRegistered<DriverStoreDeliveryController>()) {
            Get.put(DriverStoreDeliveryController());
          }
          final deliveryController = Get.find<DriverStoreDeliveryController>();
          await deliveryController.loadAvailableRequests();
          print('✅ Delivery requests refreshed');
        } catch (e) {
          print('⚠️ Could not refresh delivery requests: $e');
        }
      }
    });

    // Handle notification taps when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('📲 Notification tapped (background):');
      print('  Data: ${message.data}');

      // Auto-refresh orders
      if (message.data['type'] == 'order') {
        print('🔄 Order notification tapped, auto-refreshing orders...');
        try {
          if (Get.isRegistered<StoreOrderController>()) {
            final storeOrderController = Get.find<StoreOrderController>();
            storeOrderController.refresh();
          }
        } catch (e) {
          print('⚠️ Could not refresh orders: $e');
        }
      }

      // Auto-refresh delivery requests and navigate to requests screen
      if (message.data['type'] == 'delivery') {
        print('🔄 Delivery notification tapped, navigating...');
        try {
          // Register controller if not already registered
          if (!Get.isRegistered<DriverStoreDeliveryController>()) {
            Get.put(DriverStoreDeliveryController());
          }
          final deliveryController = Get.find<DriverStoreDeliveryController>();
          await deliveryController.loadAvailableRequests();
          print('✅ Delivery requests refreshed');
          // Navigate to store delivery requests screen
          Get.toNamed('/driver/store-requests');
        } catch (e) {
          print('⚠️ Could not refresh delivery requests: $e');
        }
      }
    });
  } catch (e) {
    if (kDebugMode) {
      print('❌ Error initializing FCM: $e');
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Firebase Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Set background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize FCM and get token
  await _initializeFCM();

  // Initialize storage service first
  final storageService = StorageService();
  await storageService.init();
  Get.put<StorageService>(storageService);

  // Initialize Analytics Service (PostHog + Firebase Analytics)
  final analyticsService = AnalyticsService();
  await analyticsService.init();
  Get.put<AnalyticsService>(analyticsService, permanent: true);

  // Reset onboarding for testing (comment out in production)
  // storageService.remove('onboarding_completed');

  // Check if onboarding was completed
  _showOnboarding = !OnboardingController.isOnboardingCompleted(storageService);

  // Load translations
  await AppTranslations.loadTranslations();

  // Server URL configuration:
  // - For debug builds: Uses config.json (local IP) or SERVER_URL env variable
  // - For release builds: Uses production URL (https://api.awhar.com)
  // 
  // You can override with: flutter run --dart-define=SERVER_URL=https://api.example.com/
  const serverUrlFromEnv = String.fromEnvironment('SERVER_URL');
  
  String normalizeServerUrl(String url) {
    final trimmed = url.trim();
    if (trimmed.isEmpty) return trimmed;
    return trimmed.endsWith('/') ? trimmed : '$trimmed/';
  }

  String serverUrl;
  
  if (serverUrlFromEnv.isNotEmpty) {
    // Use environment variable if provided (highest priority)
    serverUrl = normalizeServerUrl(serverUrlFromEnv);
  } else if (kReleaseMode) {
    // Production build - use production API
    serverUrl = 'https://api.awhar.com/';
  } else {
    // Debug build - use config.json (local development)
    final config = await AppConfig.loadConfig();
    serverUrl = normalizeServerUrl(config.apiUrl ?? 'http://$localhost:8080/');
  }

  debugPrint('[Main] 🔧 ========================================');
  debugPrint('[Main] 🔧 INITIALIZING SERVERPOD CLIENT');
  debugPrint('[Main] 🔧 Server URL: $serverUrl');
  debugPrint('[Main] 🔧 ========================================');

  // Initialize client without auth provider first
  // Timeout increased to 120s for Agent Builder calls (LLM + multi-tool chains can take 60s+)
  client = Client(
    serverUrl,
    connectionTimeout: const Duration(seconds: 120),
  )
    ..connectivityMonitor = FlutterConnectivityMonitor();

  // Store API base for URL normalization (images, etc.)
  AppRuntime.init(serverUrl);

  debugPrint('[Main] ✅ Serverpod client initialized');
  debugPrint('[Main] 🔧 Auth provider will be set by AuthController');
  debugPrint('[Main] 🔧 ========================================');

  // JWT auth with automatic refresh is configured by AuthController
  // See lib/core/controllers/auth_controller.dart

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get analytics service for navigation observer
    final analyticsService = Get.find<AnalyticsService>();
    
    return ScreenUtilInit(
      // Design size based on standard mobile design (e.g., iPhone 14)
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Awhar',
          debugShowCheckedModeBanner: false,

          // Theme configuration
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,

          // Localization configuration
          translations: AppTranslations(),
          locale: AppLocales.defaultLocale,
          fallbackLocale: AppLocales.fallbackLocale,
          supportedLocales: AppLocales.supportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          // Initial binding for dependency injection
          initialBinding: InitialBinding(),

          // Navigation observers for analytics
          navigatorObservers: [
            analyticsService.observer,
          ],

          // Routes
          getPages: AppPages.pages,

          // ============================================
          // APP ENTRY POINT
          // - Normal app: Use initialRoute for splash/auth flow
          // - ES Testing: Set home to EsTestHubScreen()
          // ============================================
          // home: const EsTestHubScreen(),  // ES & Kibana Agent testing
          initialRoute: AppRoutes.splash,  // Normal app flow
          // ============================================

          // Fallback to home page for unknown routes
          unknownRoute: GetPage(
            name: '/notfound',
            page: () => const HomeScreen(),
            binding: HomeBinding(),
            transition: Transition.fadeIn,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: const [
          // Language switcher
          LanguageSwitcher(),
          // Theme mode switcher in app bar
          ThemeModeSwitcher(),
          SizedBox(width: 8),
        ],
      ),
      body: const GreetingsScreen(),
      // To test authentication in this example app, uncomment the line below
      // and comment out the line above. This wraps the GreetingsScreen with a
      // SignInScreen, which automatically shows a sign-in UI when the user is
      // not authenticated and displays the GreetingsScreen once they sign in.
      //
      // body: SignInScreen(
      //   child: GreetingsScreen(
      //     onSignOut: () async {
      //       await client.auth.signOutDevice();
      //     },
      //   ),
      // ),
    );
  }
}
