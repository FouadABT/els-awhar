/// Elasticsearch Service
///
/// High-level service for Elasticsearch operations.
/// Provides a singleton instance for use across the application.
/// Handles initialization, connection management, and provides
/// convenient methods for common operations.

import 'elasticsearch_client.dart';
import 'elasticsearch_config.dart';
import 'elasticsearch_index_mappings.dart';
import 'elasticsearch_sync_service.dart';
import 'elasticsearch_search_service.dart';

/// Main Elasticsearch service for Awhar
/// 
/// Usage:
/// ```dart
/// // Initialize at server startup
/// await ElasticsearchService.instance.initialize();
/// 
/// // Use in endpoints
/// final esService = ElasticsearchService.instance;
/// await esService.sync.indexDriver(session, driverProfile);
/// 
/// // Search
/// final results = await esService.searchService.searchDriversNearby(...);
/// ```
class ElasticsearchService {
  // Singleton instance
  static ElasticsearchService? _instance;

  static ElasticsearchService get instance {
    _instance ??= ElasticsearchService._();
    return _instance!;
  }

  /// Factory constructor that returns the singleton instance
  factory ElasticsearchService() => instance;

  ElasticsearchService._();

  ElasticsearchClient? _client;
  ElasticsearchConfig? _config;
  ElasticsearchSyncService? _syncService;
  ElasticsearchSearchService? _searchService;

  bool _isInitialized = false;

  /// Check if the service is initialized
  bool get isInitialized => _isInitialized;

  /// Get the Elasticsearch client (throws if not initialized)
  ElasticsearchClient get client {
    if (_client == null) {
      throw StateError(
        'ElasticsearchService not initialized. Call initialize() first.',
      );
    }
    return _client!;
  }

  /// Get the Elasticsearch config (throws if not initialized)
  ElasticsearchConfig get config {
    if (_config == null) {
      throw StateError(
        'ElasticsearchService not initialized. Call initialize() first.',
      );
    }
    return _config!;
  }

  /// Get the sync service for data synchronization
  ElasticsearchSyncService get sync {
    if (_syncService == null) {
      throw StateError(
        'ElasticsearchService not initialized. Call initialize() first.',
      );
    }
    return _syncService!;
  }

  /// Get the search service for queries
  /// Returns null if not initialized (safe for optional use)
  ElasticsearchSearchService? get searchService => _searchService;

  /// Initialize the Elasticsearch service
  /// 
  /// Should be called once at server startup.
  /// Returns true if initialization was successful.
  Future<bool> initialize({bool createIndices = true}) async {
    if (_isInitialized) {
      return true;
    }

    try {
      // Load configuration from environment
      _config = ElasticsearchConfig.fromEnvironment();
      print('[Elasticsearch] Configuration loaded: ${_config!.url}');

      // Create client
      _client = ElasticsearchClient(config: _config!);

      // Test connection
      final info = await _client!.testConnection();
      print('[Elasticsearch] Connected to cluster: ${info['cluster_name']}');
      print('[Elasticsearch] Version: ${info['version']?['number']}');

      // Create sync service
      _syncService = ElasticsearchSyncService(_client!, _config!);

      // Create search service
      _searchService = ElasticsearchSearchService(_client!, _config!, _syncService!);

      // Create indices if requested
      if (createIndices) {
        await _createAllIndices();
      }

      _isInitialized = true;
      print('[Elasticsearch] Service initialized successfully');
      return true;
    } catch (e) {
      print('[Elasticsearch] Failed to initialize: $e');
      _client = null;
      _config = null;
      _syncService = null;
      return false;
    }
  }

  /// Create all Awhar indices with their mappings
  Future<void> _createAllIndices() async {
    final indices = [
      (ElasticsearchConfig.driversIndex, ElasticsearchIndexMappings.drivers),
      (ElasticsearchConfig.servicesIndex, ElasticsearchIndexMappings.services),
      (ElasticsearchConfig.driverServicesIndex, ElasticsearchIndexMappings.driverServices),
      (ElasticsearchConfig.requestsIndex, ElasticsearchIndexMappings.requests),
      (ElasticsearchConfig.storesIndex, ElasticsearchIndexMappings.stores),
      (ElasticsearchConfig.productsIndex, ElasticsearchIndexMappings.products),
      (ElasticsearchConfig.reviewsIndex, ElasticsearchIndexMappings.reviews),
      (ElasticsearchConfig.searchLogsIndex, ElasticsearchIndexMappings.searchLogs),
      (ElasticsearchConfig.analyticsIndex, ElasticsearchIndexMappings.analytics),
      // New indices for comprehensive data sync
      (ElasticsearchConfig.storeOrdersIndex, ElasticsearchIndexMappings.storeOrders),
      (ElasticsearchConfig.transactionsIndex, ElasticsearchIndexMappings.transactions),
      (ElasticsearchConfig.usersIndex, ElasticsearchIndexMappings.users),
      (ElasticsearchConfig.walletsIndex, ElasticsearchIndexMappings.wallets),
      (ElasticsearchConfig.ratingsIndex, ElasticsearchIndexMappings.ratings),
      (ElasticsearchConfig.deviceFingerprintsIndex, ElasticsearchIndexMappings.deviceFingerprints),
      (ElasticsearchConfig.fraudAlertsIndex, ElasticsearchIndexMappings.fraudAlerts),
      (ElasticsearchConfig.knowledgeBaseIndex, ElasticsearchIndexMappings.knowledgeBase),
      (ElasticsearchConfig.notificationsIndex, ElasticsearchIndexMappings.notifications),
    ];

    for (final (indexName, mapping) in indices) {
      try {
        final exists = await _client!.indexExists(indexName);
        if (exists) {
          print('[Elasticsearch] Index already exists: ${_config!.indexPrefix}-$indexName');
        } else {
          await _client!.createIndex(indexName, mapping);
          print('[Elasticsearch] Created index: ${_config!.indexPrefix}-$indexName');
        }
      } catch (e) {
        print('[Elasticsearch] Warning: Could not create index $indexName: $e');
      }
    }
  }

  /// Get cluster health information
  Future<Map<String, dynamic>> getHealth() async {
    return await client.getClusterHealth();
  }

  /// Test the Elasticsearch connection
  Future<Map<String, dynamic>> testConnection() async {
    return await client.testConnection();
  }

  /// Check if the service is healthy
  Future<bool> isHealthy() async {
    try {
      final health = await getHealth();
      final status = health['status'] as String?;
      // green or yellow is acceptable (yellow means replicas not available, ok for serverless)
      return status == 'green' || status == 'yellow';
    } catch (e) {
      return false;
    }
  }

  /// Shutdown the service
  void shutdown() {
    _client?.close();
    _client = null;
    _config = null;
    _syncService = null;
    _searchService = null;
    _isInitialized = false;
    print('[Elasticsearch] Service shut down');
  }
}
