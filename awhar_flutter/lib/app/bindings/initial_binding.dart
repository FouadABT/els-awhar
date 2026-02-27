import 'package:awhar_client/awhar_client.dart';
import 'package:get/get.dart';

import '../../core/controllers/auth_controller.dart';
import '../../core/services/image_picker_service.dart';
import '../../core/controllers/request_controller.dart';
import '../../core/controllers/notification_controller.dart';
import '../../core/controllers/proposal_controller.dart';
import '../../core/controllers/wallet_controller.dart';
import '../../core/controllers/rating_controller.dart';
import '../../core/controllers/client_store_order_controller.dart';
import '../../core/services/storage_service.dart';
import '../../core/services/location_service.dart';
import '../../core/services/request_service.dart';
import '../../core/services/driver_status_service.dart';
import '../../core/services/driver_location_service.dart';
import '../../core/services/presence_service.dart';
import '../../core/services/directions_service.dart';
import '../../core/services/notification_service.dart';
import '../../core/services/chat_service.dart';
import '../../core/services/audio_recording_service.dart';
import '../../core/services/firebase_storage_service.dart';
import '../../core/services/media_upload_service.dart';
import '../../core/services/global_audio_player_service.dart';
import '../../core/services/live_drivers_service.dart';
import '../../core/services/deep_link_service.dart';
import '../../core/services/app_settings_service.dart';
import '../../core/services/guest_auth_service.dart';
import '../../core/services/analytics_service.dart';
import '../../core/controllers/conversations_controller.dart';
import '../../core/services/proposal_service.dart';
import '../../core/services/transaction_service.dart';
import '../../core/services/rating_service.dart';
import '../../core/services/trust_score_service.dart';
import '../../core/controllers/driver_status_controller.dart';
import '../../core/controllers/driver_dashboard_controller.dart';
import '../../main.dart' show client;
import '../controllers/locale_controller.dart';
import '../controllers/theme_controller.dart';

/// Initial bindings for the app
/// This is where we inject all the dependencies that need to be available
/// throughout the app lifecycle
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Storage Service - already initialized before this is called
    Get.put<StorageService>(Get.find<StorageService>(), permanent: true);

    // Analytics Service - already initialized in main.dart
    // Get.put<AnalyticsService>(Get.find<AnalyticsService>(), permanent: true);

    // Serverpod Client - global client from main.dart
    Get.put<Client>(client, permanent: true);

    // App Settings Service - for dynamic app configuration from server
    // Must be registered early so CurrencyHelper can access it
    Get.put<AppSettingsService>(AppSettingsService(), permanent: true);

    // Auth Controller - MUST be initialized early as other services depend on it
    // This will start async session restoration in onInit()
    Get.put<AuthController>(AuthController(), permanent: true);

    // Guest Auth Service - for lazy authentication (guest mode support)
    Get.put<GuestAuthService>(GuestAuthService(), permanent: true);

    // Theme Controller
    Get.put<ThemeController>(
      ThemeController(Get.find<StorageService>()),
      permanent: true,
    );

    // Locale Controller
    Get.put<LocaleController>(
      LocaleController(Get.find<StorageService>()),
      permanent: true,
    );

    // Location Service - initialize synchronously, permissions requested on first use
    Get.put<LocationService>(LocationService(), permanent: true);

    // Request Service - for managing service requests
    Get.put<RequestService>(RequestService(), permanent: true);

    // Request Controller - for managing request state
    Get.put<RequestController>(RequestController(), permanent: true);

    // Driver Location Service - for tracking driver location (depends on AuthController)
    Get.put<DriverLocationService>(DriverLocationService(), permanent: true);

    // Driver Status Service - for driver online/offline status
    Get.put<DriverStatusService>(DriverStatusService(), permanent: true);

    // Presence Service - realtime online/offline (must be before DriverStatusController)
    Get.put<PresenceService>(PresenceService(), permanent: true);

    // Driver Status Controller - manages driver status, heartbeat, presence (depends on DriverLocationService & PresenceService)
    Get.put<DriverStatusController>(DriverStatusController(), permanent: true);

    // Driver Dashboard Controller - manages dashboard data (lazy load, not permanent)
    Get.lazyPut<DriverDashboardController>(() => DriverDashboardController());

    // Directions Service - for Google Directions API
    Get.put<DirectionsService>(DirectionsService(), permanent: true);

    // Notification Service - for push notifications
    Get.put<NotificationService>(NotificationService(), permanent: true);

    // Notification Controller - for managing notification list
    Get.put<NotificationController>(NotificationController(), permanent: true);

    // Proposal Service - for managing driver proposals
    Get.put<ProposalService>(
      ProposalService(Get.find<Client>()),
      permanent: true,
    );

    // Proposal Controller - for managing proposal state
    Get.put<ProposalController>(ProposalController(), permanent: true);

    // Transaction Service - for payment and wallet management
    Get.put<TransactionService>(TransactionService(), permanent: true);

    // Wallet Controller - for managing transactions and earnings
    Get.put<WalletController>(WalletController(), permanent: true);

    // Rating Service - for managing ratings and reviews
    Get.put<RatingService>(RatingService(), permanent: true);

    // Rating Controller - for rating state management
    Get.put<RatingController>(RatingController(), permanent: true);

    // Client Store Orders Controller - for managing client's store orders (list view)
    Get.put<ClientStoreOrdersController>(ClientStoreOrdersController(), permanent: true);

    // Chat Service - for in-app messaging
    Get.put<ChatService>(ChatService(), permanent: true);

    // Live Drivers Service - for real-time online driver monitoring
    Get.put<LiveDriversService>(LiveDriversService(), permanent: true);

    // Firebase Storage Service - for media uploads
    Get.put<FirebaseStorageService>(FirebaseStorageService(), permanent: true);

    // Media Upload Service - for image/audio/video optimization
    Get.put<MediaUploadService>(MediaUploadService(), permanent: true);

    // Audio Recording Service - for voice messages
    Get.put<AudioRecordingService>(AudioRecordingService(), permanent: true);

    // Global Audio Player Service - manages a single audio player instance
    // Ensures only one audio plays at a time, preventing audio device conflicts
    Get.put<GlobalAudioPlayerService>(
      GlobalAudioPlayerService(),
      permanent: true,
    );

    // Image Picker Service - for camera/gallery image selection
    Get.put<ImagePickerService>(ImagePickerService(), permanent: true);

    // Conversations Controller - global chat list state
    Get.put<ConversationsController>(
      ConversationsController(),
      permanent: true,
    );

    // Trust Score Service - for client trust badges on driver screens
    Get.put<TrustScoreService>(TrustScoreService(), permanent: true);

    // Deep Link Service - handles incoming app links / universal links
    Get.put<DeepLinkService>(DeepLinkService(), permanent: true);
  }
}
