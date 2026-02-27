import 'package:awhar_client/awhar_client.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// Service for managing app-wide settings fetched from the server
/// Settings are cached locally and refreshed on app start
class AppSettingsService extends GetxService {
  static AppSettingsService get to => Get.find<AppSettingsService>();

  final _storage = GetStorage();
  static const _cacheKey = 'app_configuration';
  static const _cacheTimestampKey = 'app_configuration_timestamp';
  static const _cacheDurationHours = 24; // Refresh cache every 24 hours

  // Reactive configuration
  final Rx<AppConfiguration?> _config = Rx<AppConfiguration?>(null);
  AppConfiguration? get config => _config.value;

  // Loading state
  final RxBool isLoading = false.obs;
  final RxBool isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Auto-initialize settings on service creation
    init();
  }

  // ============= Currency Getters =============

  String get currencyCode => _config.value?.currencyCode ?? 'MAD';
  String get currencySymbol => _config.value?.currencySymbol ?? 'DH';
  String get currencyName => _config.value?.currencyName ?? 'Moroccan Dirham';

  // ============= Pricing Getters =============

  double get minPrice => _config.value?.minPrice ?? 15.0;
  double get commissionRate => _config.value?.commissionRate ?? 0.05;

  // ============= App Info Getters =============

  String get appName => _config.value?.appName ?? 'Awhar';
  String get supportEmail => _config.value?.supportEmail ?? 'support@awhar.com';
  String get supportPhone => _config.value?.supportPhone ?? '+212600000000';
  String get termsUrl => _config.value?.termsUrl ?? 'https://awhar.com/terms';
  String get privacyUrl =>
      _config.value?.privacyUrl ?? 'https://awhar.com/privacy';

  // ============= Upload Settings =============

  double get maxImageSizeMb => _config.value?.maxImageSizeMb ?? 5.0;

  // ============= Localization =============

  String get defaultLanguage => _config.value?.defaultLanguage ?? 'en';

  // ============= Currency Formatting =============

  /// Format a price with currency symbol
  /// Example: formatPrice(150) => "150 DH"
  String formatPrice(double amount) {
    // Remove decimals if whole number
    if (amount == amount.roundToDouble()) {
      return '${amount.toInt()} $currencySymbol';
    }
    return '${amount.toStringAsFixed(2)} $currencySymbol';
  }

  /// Format a price with currency code
  /// Example: formatPriceWithCode(150) => "150 MAD"
  String formatPriceWithCode(double amount) {
    if (amount == amount.roundToDouble()) {
      return '${amount.toInt()} $currencyCode';
    }
    return '${amount.toStringAsFixed(2)} $currencyCode';
  }

  /// Format a price range
  /// Example: formatPriceRange(100, 200) => "100 - 200 DH"
  String formatPriceRange(double min, double max) {
    final minStr = min == min.roundToDouble() ? '${min.toInt()}' : min.toStringAsFixed(2);
    final maxStr = max == max.roundToDouble() ? '${max.toInt()}' : max.toStringAsFixed(2);
    return '$minStr - $maxStr $currencySymbol';
  }

  /// Format commission amount
  /// Example: formatCommission(100) => "5 DH" (if rate is 0.05)
  String formatCommission(double amount) {
    final commission = amount * commissionRate;
    return formatPrice(commission);
  }

  // ============= Initialization =============

  /// Initialize the service - call this on app start
  Future<void> init() async {
    if (isInitialized.value) return;

    isLoading.value = true;

    try {
      // Try to load from cache first
      _loadFromCache();

      // Check if we need to refresh from server
      if (_shouldRefreshCache()) {
        await refreshFromServer();
      }

      isInitialized.value = true;
    } catch (e) {
      print('AppSettingsService: Error initializing: $e');
      // Use cached or default values
    } finally {
      isLoading.value = false;
    }
  }

  /// Load settings from server and update cache
  Future<void> refreshFromServer() async {
    try {
      final client = Get.find<Client>();
      final serverConfig = await client.settings.getAppConfiguration();

      _config.value = serverConfig;
      _saveToCache(serverConfig);

      print('AppSettingsService: Settings refreshed from server');
    } catch (e) {
      print('AppSettingsService: Error refreshing from server: $e');
      rethrow;
    }
  }

  // ============= Cache Management =============

  void _loadFromCache() {
    try {
      final cached = _storage.read<Map<String, dynamic>>(_cacheKey);
      if (cached != null) {
        _config.value = AppConfiguration(
          currencyCode: cached['currencyCode'] ?? 'MAD',
          currencySymbol: cached['currencySymbol'] ?? 'DH',
          currencyName: cached['currencyName'] ?? 'Moroccan Dirham',
          minPrice: (cached['minPrice'] ?? 15.0).toDouble(),
          commissionRate: (cached['commissionRate'] ?? 0.05).toDouble(),
          appName: cached['appName'] ?? 'Awhar',
          supportEmail: cached['supportEmail'] ?? 'support@awhar.com',
          supportPhone: cached['supportPhone'] ?? '+212600000000',
          termsUrl: cached['termsUrl'] ?? 'https://awhar.com/terms',
          privacyUrl: cached['privacyUrl'] ?? 'https://awhar.com/privacy',
          maxImageSizeMb: (cached['maxImageSizeMb'] ?? 5.0).toDouble(),
          defaultLanguage: cached['defaultLanguage'] ?? 'en',
        );
        print('AppSettingsService: Loaded from cache');
      }
    } catch (e) {
      print('AppSettingsService: Error loading from cache: $e');
    }
  }

  void _saveToCache(AppConfiguration config) {
    try {
      _storage.write(_cacheKey, {
        'currencyCode': config.currencyCode,
        'currencySymbol': config.currencySymbol,
        'currencyName': config.currencyName,
        'minPrice': config.minPrice,
        'commissionRate': config.commissionRate,
        'appName': config.appName,
        'supportEmail': config.supportEmail,
        'supportPhone': config.supportPhone,
        'termsUrl': config.termsUrl,
        'privacyUrl': config.privacyUrl,
        'maxImageSizeMb': config.maxImageSizeMb,
        'defaultLanguage': config.defaultLanguage,
      });
      _storage.write(_cacheTimestampKey, DateTime.now().toIso8601String());
    } catch (e) {
      print('AppSettingsService: Error saving to cache: $e');
    }
  }

  bool _shouldRefreshCache() {
    try {
      final timestamp = _storage.read<String>(_cacheTimestampKey);
      if (timestamp == null) return true;

      final cachedAt = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(cachedAt);

      return difference.inHours >= _cacheDurationHours;
    } catch (e) {
      return true;
    }
  }

  /// Clear the cache (for logout or debug)
  void clearCache() {
    _storage.remove(_cacheKey);
    _storage.remove(_cacheTimestampKey);
    _config.value = null;
    isInitialized.value = false;
  }
}
