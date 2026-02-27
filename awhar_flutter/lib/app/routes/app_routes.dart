import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awhar_client/awhar_client.dart';

import '../middleware/auth_middleware.dart';
import '../modules/auth/auth_binding.dart';
import '../modules/auth/views/forgot_password_screen.dart';
import '../modules/auth/views/login_screen.dart';
import '../modules/auth/views/otp_screen.dart';
import '../modules/auth/views/register_screen.dart';
import '../modules/client/explore/explore_screen.dart' show ClientExploreScreen;
import '../modules/client/orders/orders_screen.dart' show ClientOrdersScreen;
import '../modules/driver/dashboard/driver_dashboard_screen.dart';
import '../modules/driver/earnings/driver_earnings_screen.dart';
import '../modules/driver/rides/driver_rides_screen.dart';
import '../modules/driver/messages/driver_messages_screen.dart';
import '../modules/driver/settings/driver_settings_screen.dart';
import '../modules/driver/services/driver_services_screen.dart';
import '../modules/driver/services/add_service_screen.dart';
import '../modules/driver/services/edit_service_screen.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_screen.dart';
import '../modules/messages/messages_screen.dart';
import '../modules/onboarding/onboarding_binding.dart';
import '../modules/onboarding/onboarding_screen.dart';
import '../modules/splash/splash_screen.dart';
import '../../screens/awhar_map_screen.dart';
import '../../screens/create_request_screen.dart';
import '../../screens/available_requests_screen.dart';
import '../../screens/location_picker_screen.dart';
import '../../screens/chat_screen.dart';
import '../../screens/direct_chat_screen.dart';
import '../../screens/driver/driver_catalog_requests_screen.dart';
import '../../screens/driver/driver_location_screen.dart';
import '../../screens/notifications/notifications_screen.dart';
import '../../screens/client/client_active_request_screen.dart';
import '../../screens/driver/driver_active_request_screen.dart';
import '../../screens/proposals_screen.dart';
import '../../screens/reviews_screen.dart';
import '../../core/controllers/store_controller.dart';
import '../../screens/store/store_dashboard_screen.dart';
import '../../screens/store/store_registration_screen.dart';
import '../../screens/store/store_profile_screen.dart';
import '../../screens/store/store_products_screen.dart';
import '../../screens/store/add_product_screen.dart';
import '../../screens/store/store_orders_screen.dart';
import '../../screens/store/store_order_detail_screen.dart';
import '../../screens/store/find_driver_screen.dart';
import '../../screens/driver/driver_store_requests_screen.dart';
import '../../screens/driver/driver_store_delivery_screen.dart';
import '../../screens/shared/store_order_chat_screen.dart';
import '../modules/client/stores/client_stores_screen.dart';
import '../../test_email_screen.dart';
import '../modules/client/stores/store_detail_screen.dart';
import '../modules/client/stores/cart_screen.dart';
import '../modules/client/stores/checkout_screen.dart';
import '../modules/client/stores/client_store_order_screen.dart';
import '../../screens/legal/legal_screens.dart';
import '../../screens/analytics_debug_screen.dart';
import '../../screens/smart_search_screen.dart';
import '../../elasticsearch/screens/concierge_request_screen.dart';
import '../../elasticsearch/screens/conversation_history_screen.dart';
import '../../elasticsearch/screens/ai_matching_screen.dart';

/// App routes configuration
abstract class AppRoutes {
  static const String splash = '/splash';
  // Core routes
  static const String onboarding = '/onboarding';
  static const String home = '/home';

  // Auth routes
  static const String authLogin = '/auth/login';
  static const String authRegister = '/auth/register';
  static const String authOtp = '/auth/otp';
  static const String authForgotPassword = '/auth/forgot-password';

  // Driver routes
  static const String driverDashboard = '/driver/dashboard';
  static const String driverRides = '/driver/rides';
  static const String driverEarnings = '/driver/earnings';
  static const String driverMessages = '/driver/messages';
  static const String driverSettings = '/driver/settings';
  static const String driverServices = '/driver/services';
  static const String driverServicesAdd = '/driver/services/add';
  static const String driverServicesEdit = '/driver/services/edit/:serviceId';
  static const String driverLocation = '/driver/location';

  // Client routes
  static const String clientExplore = '/client/explore';
  static const String clientOrders = '/client/orders';
  static const String createRequest = '/client/create-request';
  static const String clientActiveRequest = '/client/active-request';

  // Driver routes - available requests
  static const String availableRequests = '/driver/available-requests';
  static const String driverActiveRequest = '/driver/active-request';
  static const String driverCatalogRequests = '/driver/catalog-requests';

  // Shared routes
  static const String messages = '/messages';
  static const String notifications = '/notifications';
  static const String proposals = '/proposals';
  static const String chat = '/chat/:requestId';
  static const String directChat = '/direct-chat';
  static const String locationPicker = '/location-picker';
  static const String reviews = '/reviews';
  
  // Map routes
  static const String map = '/map';

  // Store routes
  static const String storeDashboard = '/store/dashboard';
  static const String storeRegistration = '/store/registration';
  static const String storeProfile = '/store/profile';
  static const String storeProducts = '/store/products';
  static const String storeAddProduct = '/store/products/add';
  static const String storeOrders = '/store/orders';
  static const String storeOrderDetail = '/store/orders/detail';
  static const String storeFindDriver = '/store/find-driver';

  // Driver store delivery routes
  static const String driverStoreRequests = '/driver/store-requests';
  static const String driverStoreDelivery = '/driver/store-delivery';

  // Store order chat route
  static const String storeOrderChat = '/store-order-chat';

  // Client store browsing routes
  static const String clientStores = '/client/stores';
  static const String clientStoreDetail = '/client/stores/detail';
  static const String clientCart = '/client/cart';
  static const String clientCheckout = '/client/checkout';
  static const String clientStoreOrder = '/client/store-order';

  // Smart Search
  static const String smartSearch = '/search';

  // AI Concierge (Elasticsearch-powered)
  static const String aiConcierge = '/ai/concierge';
  static const String aiConciergeHistory = '/ai/concierge/history';

  // AI Driver Matching
  static const String aiMatching = '/ai/matching';

  // Debug routes (only in debug mode)
  static const String analyticsDebug = '/debug/analytics';

  // Test routes
  static const String testEmail = '/test/email';

  // Legal routes (App Store compliance)
  static const String legalTerms = '/legal/terms';
  static const String legalPrivacy = '/legal/privacy';
  static const String legalGuidelines = '/legal/guidelines';
  static const String accountDelete = '/account/delete';

  // Legacy aliases
  static const String login = authLogin;
  static const String register = authRegister;
}

/// App pages with bindings
abstract class AppPages {
  static final pages = [
    // Splash
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    // Onboarding
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
      transition: Transition.fadeIn,
    ),

    // Home - No AuthMiddleware since HomeScreen supports guest mode
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),

    // Auth - Login
    GetPage(
      name: AppRoutes.authLogin,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
      middlewares: [GuestMiddleware()],
    ),

    // Auth - Register
    GetPage(
      name: AppRoutes.authRegister,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
      middlewares: [GuestMiddleware()],
    ),

    // Auth - OTP Verification
    GetPage(
      name: AppRoutes.authOtp,
      page: () => const OtpScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),

    // Auth - Forgot Password
    GetPage(
      name: AppRoutes.authForgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),

    // ═════════════════════════════════════════════════════════════════════════
    // Driver Routes - Protected by DriverMiddleware
    // ═════════════════════════════════════════════════════════════════════════

    GetPage(
      name: AppRoutes.driverDashboard,
      page: () => const DriverDashboardScreen(),
      transition: Transition.fadeIn,
      middlewares: [DriverMiddleware()],
    ),

    GetPage(
      name: AppRoutes.driverRides,
      page: () => const DriverRidesScreen(),
      transition: Transition.rightToLeft,
      middlewares: [DriverMiddleware()],
    ),

    GetPage(
      name: AppRoutes.driverEarnings,
      page: () => const DriverEarningsScreen(),
      transition: Transition.rightToLeft,
      middlewares: [DriverMiddleware()],
    ),

    GetPage(
      name: AppRoutes.driverLocation,
      page: () => const DriverLocationScreen(),
      transition: Transition.rightToLeft,
      middlewares: [DriverMiddleware()],
    ),

    GetPage(
      name: AppRoutes.driverMessages,
      page: () => const DriverMessagesScreen(),
      transition: Transition.rightToLeft,
      middlewares: [DriverMiddleware()],
    ),

    GetPage(
      name: AppRoutes.driverSettings,
      page: () => const DriverSettingsScreen(),
      transition: Transition.rightToLeft,
      middlewares: [DriverMiddleware()],
    ),

    GetPage(
      name: AppRoutes.driverServices,
      page: () => const DriverServicesScreen(),
      transition: Transition.rightToLeft,
      middlewares: [DriverMiddleware()],
    ),

    GetPage(
      name: AppRoutes.driverServicesAdd,
      page: () => const AddServiceScreen(),
      transition: Transition.rightToLeft,
      middlewares: [DriverMiddleware()],
    ),

    GetPage(
      name: AppRoutes.driverServicesEdit,
      page: () => const EditServiceScreen(),
      transition: Transition.rightToLeft,
      middlewares: [DriverMiddleware()],
    ),

    // ═════════════════════════════════════════════════════════════════════════
    // Client Routes - Protected by ClientMiddleware
    // ═════════════════════════════════════════════════════════════════════════

    GetPage(
      name: AppRoutes.clientExplore,
      page: () => const ClientExploreScreen(),
      transition: Transition.fadeIn,
      middlewares: [ClientMiddleware()],
    ),

    GetPage(
      name: AppRoutes.clientOrders,
      page: () => const ClientOrdersScreen(),
      transition: Transition.rightToLeft,
      middlewares: [ClientMiddleware()],
    ),

    GetPage(
      name: AppRoutes.createRequest,
      page: () => const CreateRequestScreen(),
      transition: Transition.rightToLeft,
      middlewares: [ClientMiddleware()],
    ),

    // Client Active Request Screen
    GetPage(
      name: AppRoutes.clientActiveRequest,
      page: () {
        final args = Get.arguments;
        print('[Route] ClientActiveRequest - Arguments: $args (type: ${args.runtimeType})');
        
        // Handle when just an int ID is passed directly
        if (args is int) {
          print('[Route] ClientActiveRequest - Detected int ID: $args, fetching from server...');
          return FutureBuilder<ServiceRequest?>(
            future: Get.find<Client>().request.getRequestById(args),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('[Route] ClientActiveRequest - Loading request $args...');
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              
              if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
                print('[Route] ClientActiveRequest - Error loading request: ${snapshot.error}');
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Get.snackbar('Error', 'Request not found');
                  Get.back();
                });
                return const Scaffold(
                  body: Center(child: Text('Request not found')),
                );
              }
              
              print('[Route] ClientActiveRequest - Successfully loaded request ${snapshot.data!.id}');
              return ClientActiveRequestScreen(request: snapshot.data!);
            },
          );
        }
        
        // Handle deep link case where requestId is in a Map
        if (args is Map && args.containsKey('requestId')) {
          print('[Route] ClientActiveRequest - Detected Map with requestId: ${args['requestId']}, fetching...');
          return FutureBuilder<ServiceRequest?>(
            future: Get.find<Client>().request.getRequestById(args['requestId'] as int),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('[Route] ClientActiveRequest - Loading request ${args['requestId']}...');
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              
              if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
                print('[Route] ClientActiveRequest - Error loading request from Map: ${snapshot.error}');
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Get.snackbar('Error', 'Request not found');
                  Get.back();
                });
                return const Scaffold(
                  body: Center(child: Text('Request not found')),
                );
              }
              
              print('[Route] ClientActiveRequest - Successfully loaded request from Map: ${snapshot.data!.id}');
              return ClientActiveRequestScreen(request: snapshot.data!);
            },
          );
        }
        
        // Normal navigation case where full request object is passed
        print('[Route] ClientActiveRequest - Using direct ServiceRequest object');
        return ClientActiveRequestScreen(
          request: args as ServiceRequest,
        );
      },
      transition: Transition.rightToLeft,
      middlewares: [ClientMiddleware()],
    ),

    // ═════════════════════════════════════════════════════════════════════════
    // Driver Routes Continued
    // ═════════════════════════════════════════════════════════════════════════

    GetPage(
      name: AppRoutes.availableRequests,
      page: () => const AvailableRequestsScreen(),
      transition: Transition.rightToLeft,
      middlewares: [DriverMiddleware()],
    ),

    // Driver Active Request Screen
    GetPage(
      name: AppRoutes.driverActiveRequest,
      page: () {
        final args = Get.arguments;
        print('[Route] DriverActiveRequest - Arguments: $args (type: ${args.runtimeType})');
        
        // Handle when just an int ID is passed directly
        if (args is int) {
          print('[Route] DriverActiveRequest - Detected int ID: $args, fetching from server...');
          return FutureBuilder<ServiceRequest?>(
            future: Get.find<Client>().request.getRequestById(args),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('[Route] DriverActiveRequest - Loading request $args...');
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              
              if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
                print('[Route] DriverActiveRequest - Error loading request: ${snapshot.error}');
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Get.snackbar('Error', 'Request not found');
                  Get.back();
                });
                return const Scaffold(
                  body: Center(child: Text('Request not found')),
                );
              }
              
              print('[Route] DriverActiveRequest - Successfully loaded request ${snapshot.data!.id}');
              return DriverActiveRequestScreen(request: snapshot.data!);
            },
          );
        }
        
        // Handle deep link case where requestId is in a Map
        if (args is Map && args.containsKey('requestId')) {
          print('[Route] DriverActiveRequest - Detected Map with requestId: ${args['requestId']}, fetching...');
          return FutureBuilder<ServiceRequest?>(
            future: Get.find<Client>().request.getRequestById(args['requestId'] as int),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('[Route] DriverActiveRequest - Loading request ${args['requestId']}...');
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              
              if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
                print('[Route] DriverActiveRequest - Error loading request from Map: ${snapshot.error}');
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Get.snackbar('Error', 'Request not found');
                  Get.back();
                });
                return const Scaffold(
                  body: Center(child: Text('Request not found')),
                );
              }
              
              print('[Route] DriverActiveRequest - Successfully loaded request from Map: ${snapshot.data!.id}');
              return DriverActiveRequestScreen(request: snapshot.data!);
            },
          );
        }
        
        // Normal navigation case where full request object is passed
        print('[Route] DriverActiveRequest - Using direct ServiceRequest object');
        return DriverActiveRequestScreen(
          request: args as ServiceRequest,
        );
      },
      transition: Transition.rightToLeft,
      middlewares: [DriverMiddleware()],
    ),

    // Driver Catalog Requests Screen
    GetPage(
      name: AppRoutes.driverCatalogRequests,
      page: () => const DriverCatalogRequestsScreen(),
      transition: Transition.rightToLeft,
      middlewares: [DriverMiddleware()],
    ),

    // ═════════════════════════════════════════════════════════════════════════
    // Shared Routes - Require authentication
    // ═════════════════════════════════════════════════════════════════════════

    GetPage(
      name: AppRoutes.messages,
      page: () => const MessagesScreen(),
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),

    // Notifications Screen
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsScreen(),
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),

    // Proposals Screen (Client views driver proposals)
    GetPage(
      name: AppRoutes.proposals,
      page: () => const ProposalsScreen(),
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),

    // Chat Screen
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatScreen(),
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),

    // Direct Chat Screen (Client <-> Driver)
    GetPage(
      name: AppRoutes.directChat,
      page: () => const DirectChatScreen(),
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),
    
    // Map Screen
    GetPage(
      name: AppRoutes.map,
      page: () => const AwharMapScreen(),
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),

    // Location Picker
    GetPage(
      name: AppRoutes.locationPicker,
      page: () => const LocationPickerScreen(),
      transition: Transition.downToUp,
    ),

    // Reviews Screen
    GetPage(
      name: AppRoutes.reviews,
      page: () => const ReviewsScreen(),
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),

    // Store Dashboard
    GetPage(
      name: AppRoutes.storeDashboard,
      page: () => const StoreDashboardScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<StoreController>()) {
          Get.put(StoreController());
        }
      }),
      middlewares: [AuthMiddleware()],
    ),

    // Store Registration
    GetPage(
      name: AppRoutes.storeRegistration,
      page: () => const StoreRegistrationScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<StoreController>()) {
          Get.put(StoreController());
        }
      }),
      middlewares: [AuthMiddleware()],
    ),

    // Store Profile
    GetPage(
      name: AppRoutes.storeProfile,
      page: () => const StoreProfileScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<StoreController>()) {
          Get.put(StoreController());
        }
      }),
      middlewares: [AuthMiddleware()],
    ),

    // Store Products
    GetPage(
      name: AppRoutes.storeProducts,
      page: () => const StoreProductsScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<StoreController>()) {
          Get.put(StoreController());
        }
      }),
      middlewares: [AuthMiddleware()],
    ),

    // Store Add Product
    GetPage(
      name: AppRoutes.storeAddProduct,
      page: () => const AddProductScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<StoreController>()) {
          Get.put(StoreController());
        }
      }),
      middlewares: [AuthMiddleware()],
    ),

    // Store Orders
    GetPage(
      name: AppRoutes.storeOrders,
      page: () => const StoreOrdersScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<StoreController>()) {
          Get.put(StoreController());
        }
      }),
      middlewares: [AuthMiddleware()],
    ),

    // Store Order Detail
    GetPage(
      name: AppRoutes.storeOrderDetail,
      page: () => StoreOrderDetailScreen(orderId: Get.arguments as int),
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),

    // Store Find Driver
    GetPage(
      name: AppRoutes.storeFindDriver,
      page: () => FindDriverScreen(orderId: Get.arguments as int),
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),

    // ═════════════════════════════════════════════════════════════════════════
    // Driver Store Delivery Routes
    // ═════════════════════════════════════════════════════════════════════════

    // Driver Store Requests
    GetPage(
      name: AppRoutes.driverStoreRequests,
      page: () => const DriverStoreRequestsScreen(),
      transition: Transition.rightToLeft,
      middlewares: [DriverMiddleware()],
    ),

    // Driver Store Delivery
    GetPage(
      name: AppRoutes.driverStoreDelivery,
      page: () => const DriverStoreDeliveryScreen(),
      transition: Transition.rightToLeft,
      middlewares: [DriverMiddleware()],
    ),

    // Store Order Chat (3-way)
    GetPage(
      name: AppRoutes.storeOrderChat,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return StoreOrderChatScreen(
          orderId: args['orderId'] as int,
          userRole: args['userRole'] as String,
        );
      },
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),

    // ═════════════════════════════════════════════════════════════════════════
    // Client Store Browsing Routes
    // ═════════════════════════════════════════════════════════════════════════

    // Client Stores List
    GetPage(
      name: AppRoutes.clientStores,
      page: () => const ClientStoresScreen(),
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),

    // Client Store Detail
    GetPage(
      name: AppRoutes.clientStoreDetail,
      page: () => const StoreDetailScreen(storeId: 0), // storeId passed via arguments
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),

    // Client Cart
    GetPage(
      name: AppRoutes.clientCart,
      page: () => const CartScreen(),
      transition: Transition.downToUp,
      middlewares: [AuthMiddleware()],
    ),

    // Client Checkout
    GetPage(
      name: AppRoutes.clientCheckout,
      page: () => const CheckoutScreen(),
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),

    // Client Store Order Tracking
    GetPage(
      name: AppRoutes.clientStoreOrder,
      page: () {
        final orderId = Get.arguments as int? ?? 0;
        return ClientStoreOrderScreen(orderId: orderId);
      },
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),

    // Test Email Screen
    GetPage(
      name: AppRoutes.testEmail,
      page: () => const TestEmailScreen(),
      transition: Transition.fadeIn,
    ),

    // ═════════════════════════════════════════════════════════════════════════
    // Legal Routes - App Store Compliance
    // ═════════════════════════════════════════════════════════════════════════

    // Terms and Conditions
    GetPage(
      name: AppRoutes.legalTerms,
      page: () => const TermsScreen(),
      transition: Transition.rightToLeft,
    ),

    // Privacy Policy
    GetPage(
      name: AppRoutes.legalPrivacy,
      page: () => const PrivacyPolicyScreen(),
      transition: Transition.rightToLeft,
    ),

    // Community Guidelines
    GetPage(
      name: AppRoutes.legalGuidelines,
      page: () => const CommunityGuidelinesScreen(),
      transition: Transition.rightToLeft,
    ),

    // Delete Account
    GetPage(
      name: AppRoutes.accountDelete,
      page: () => const DeleteAccountScreen(),
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),

    // ═════════════════════════════════════════════════════════════════════════
    // Debug Routes (only available in debug mode)
    // ═════════════════════════════════════════════════════════════════════════

    // Smart Search
    GetPage(
      name: AppRoutes.smartSearch,
      page: () => const SmartSearchScreen(),
      transition: Transition.fadeIn,
      middlewares: [AuthMiddleware()],
    ),

    // AI Concierge — Elasticsearch ELSER-powered conversational request creation
    GetPage(
      name: AppRoutes.aiConcierge,
      page: () => const ConciergeRequestScreen(),
      transition: Transition.downToUp,
      middlewares: [AuthMiddleware()],
    ),

    // AI Concierge History — past conversations
    GetPage(
      name: AppRoutes.aiConciergeHistory,
      page: () => const ConversationHistoryScreen(),
      transition: Transition.rightToLeft,
      middlewares: [AuthMiddleware()],
    ),

    // AI Driver Matching — real-time matching visualization
    GetPage(
      name: AppRoutes.aiMatching,
      page: () => const AiMatchingScreen(),
      transition: Transition.downToUp,
      opaque: false,
      middlewares: [AuthMiddleware()],
    ),

    // Analytics Debug Screen
    GetPage(
      name: AppRoutes.analyticsDebug,
      page: () => const AnalyticsDebugScreen(),
      transition: Transition.rightToLeft,
    ),
  ];
}
