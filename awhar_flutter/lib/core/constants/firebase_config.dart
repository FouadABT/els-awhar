/// Firebase Configuration Constants
/// 
/// Centralized Firebase configuration to ensure all services
/// use the same regional database URL and settings.
class FirebaseConfig {
  FirebaseConfig._();

  /// Firebase Realtime Database URL (Europe West 1 region)
  /// 
  /// IMPORTANT: All Firebase RTDB services MUST use this URL to ensure
  /// they connect to the correct regional database instance.
  /// 
  /// Used by:
  /// - ChatService
  /// - PresenceService  
  /// - DriverLocationService
  static const String realtimeDatabaseUrl = 
      'https://awhar-5afc5-default-rtdb.europe-west1.firebasedatabase.app';

  /// Firebase Project ID
  static const String projectId = 'awhar-5afc5';

  /// Enable Firebase Realtime Database persistence
  /// Set to true to cache data locally for offline access
  static const bool enablePersistence = true;
}
