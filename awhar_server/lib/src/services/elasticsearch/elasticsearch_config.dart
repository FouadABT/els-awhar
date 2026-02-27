/// Elasticsearch Configuration
///
/// Loads and manages Elasticsearch connection settings from environment variables.
/// This class provides a centralized way to access ES configuration across the app.

import 'dart:io';

import 'package:dotenv/dotenv.dart' as dotenv;

/// Global dotenv instance for environment variable access
dotenv.DotEnv? _envInstance;

/// Get the dotenv instance (for use by other modules like KibanaAgentClient)
dotenv.DotEnv? getDotEnvInstance() {
  initializeElasticsearchEnv();
  return _envInstance;
}

/// Initialize the dotenv environment
void initializeElasticsearchEnv() {
  if (_envInstance != null) return;
  
  try {
    final parentEnvFile = File('../.env');
    final currentEnvFile = File('.env');
    
    if (parentEnvFile.existsSync()) {
      _envInstance = dotenv.DotEnv(includePlatformEnvironment: true)..load(['../.env']);
    } else if (currentEnvFile.existsSync()) {
      _envInstance = dotenv.DotEnv(includePlatformEnvironment: true)..load(['.env']);
    }
  } catch (e) {
    print('[ElasticsearchConfig] Warning: Could not load .env file: $e');
  }
}

/// Get environment variable from dotenv or platform
String? _getEnv(String key) {
  initializeElasticsearchEnv();
  return _envInstance?[key] ?? Platform.environment[key];
}

/// Configuration class for Elasticsearch connection
class ElasticsearchConfig {
  /// Elasticsearch Cloud URL
  final String url;

  /// API Key for authentication (Base64 encoded)
  final String apiKey;

  /// Cloud ID (optional, for some client libraries)
  final String? cloudId;

  /// Index prefix for all Awhar indices
  final String indexPrefix;

  ElasticsearchConfig({
    required this.url,
    required this.apiKey,
    this.cloudId,
    this.indexPrefix = 'awhar',
  });

  /// Create config from environment variables
  factory ElasticsearchConfig.fromEnvironment() {
    final url = _getEnv('ELASTICSEARCH_URL');
    final apiKey = _getEnv('ELASTICSEARCH_API_KEY');
    final cloudId = _getEnv('ELASTICSEARCH_CLOUD_ID');

    if (url == null || url.isEmpty) {
      throw Exception(
        'ELASTICSEARCH_URL environment variable is not set. '
        'Please add it to your .env file.',
      );
    }

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception(
        'ELASTICSEARCH_API_KEY environment variable is not set. '
        'Please add it to your .env file.',
      );
    }

    return ElasticsearchConfig(
      url: url,
      apiKey: apiKey,
      cloudId: cloudId,
    );
  }

  /// Get the Authorization header value
  String get authorizationHeader => 'ApiKey $apiKey';

  /// Get common headers for ES requests
  Map<String, String> get headers => {
        'Authorization': authorizationHeader,
        'Content-Type': 'application/json',
      };

  /// Get full URL for an index
  String indexUrl(String indexName) => '$url/$indexPrefix-$indexName';

  /// Get full URL for search on an index
  String searchUrl(String indexName) => '$url/$indexPrefix-$indexName/_search';

  /// Get full URL for bulk operations
  String get bulkUrl => '$url/_bulk';

  /// Get cluster health URL
  String get healthUrl => '$url/_cluster/health';

  /// Get info URL (for connection test)
  String get infoUrl => url;

  /// Index names used in Awhar
  static const String driversIndex = 'drivers';
  static const String servicesIndex = 'services';
  static const String driverServicesIndex = 'driver-services';
  static const String requestsIndex = 'requests';
  static const String storesIndex = 'stores';
  static const String productsIndex = 'products';
  static const String reviewsIndex = 'reviews';
  static const String locationsIndex = 'locations';
  static const String searchLogsIndex = 'search-logs';
  static const String analyticsIndex = 'analytics';
  
  // New indices for comprehensive data sync
  static const String storeOrdersIndex = 'store-orders';
  static const String transactionsIndex = 'transactions';
  static const String usersIndex = 'users';
  static const String walletsIndex = 'wallets';
  static const String ratingsIndex = 'ratings';
  static const String deviceFingerprintsIndex = 'device-fingerprints';
  static const String fraudAlertsIndex = 'fraud-alerts';
  static const String knowledgeBaseIndex = 'knowledge-base';
  static const String notificationsIndex = 'notifications';

  /// ELSER inference endpoint ID
  static const String elserInferenceId = 'awhar-elser';

  @override
  String toString() {
    return 'ElasticsearchConfig(url: $url, cloudId: $cloudId, indexPrefix: $indexPrefix)';
  }
}
