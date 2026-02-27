import 'package:serverpod/serverpod.dart';

import '../services/elasticsearch/elasticsearch.dart';

/// Endpoint for Elasticsearch operations
class ElasticsearchEndpoint extends Endpoint {
  /// Test Elasticsearch connection
  /// Returns cluster info if connected successfully
  Future<Map<String, dynamic>> testConnection(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {
          'success': false,
          'error': 'Elasticsearch service not initialized',
        };
      }

      final info = await ElasticsearchService.instance.testConnection();
      return {
        'success': true,
        'cluster_name': info['cluster_name'],
        'cluster_uuid': info['cluster_uuid'],
        'version': info['version']?['number'],
        'tagline': info['tagline'],
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Get cluster health status
  Future<Map<String, dynamic>> getHealth(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {
          'success': false,
          'error': 'Elasticsearch service not initialized',
        };
      }

      final health = await ElasticsearchService.instance.getHealth();
      return {
        'success': true,
        'status': health['status'],
        'cluster_name': health['cluster_name'],
        'number_of_nodes': health['number_of_nodes'],
        'number_of_data_nodes': health['number_of_data_nodes'],
        'active_primary_shards': health['active_primary_shards'],
        'active_shards': health['active_shards'],
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Check if an index exists
  Future<Map<String, dynamic>> checkIndex(
    Session session,
    String indexName,
  ) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {
          'success': false,
          'error': 'Elasticsearch service not initialized',
        };
      }

      final exists = await ElasticsearchService.instance.client.indexExists(indexName);
      final fullIndexName = '${ElasticsearchService.instance.config.indexPrefix}-$indexName';
      
      return {
        'success': true,
        'indexName': fullIndexName,
        'exists': exists,
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Get all Awhar indices status
  Future<Map<String, dynamic>> getIndicesStatus(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {
          'success': false,
          'error': 'Elasticsearch service not initialized',
        };
      }

      final indices = [
        ElasticsearchConfig.driversIndex,
        ElasticsearchConfig.servicesIndex,
        ElasticsearchConfig.driverServicesIndex,
        ElasticsearchConfig.requestsIndex,
        ElasticsearchConfig.storesIndex,
        ElasticsearchConfig.productsIndex,
        ElasticsearchConfig.reviewsIndex,
        ElasticsearchConfig.searchLogsIndex,
        ElasticsearchConfig.storeOrdersIndex,
        ElasticsearchConfig.transactionsIndex,
        ElasticsearchConfig.usersIndex,
        ElasticsearchConfig.walletsIndex,
        ElasticsearchConfig.ratingsIndex,
        ElasticsearchConfig.deviceFingerprintsIndex,
        ElasticsearchConfig.fraudAlertsIndex,
      ];

      final status = <String, bool>{};
      for (final index in indices) {
        final exists = await ElasticsearchService.instance.client.indexExists(index);
        final fullName = '${ElasticsearchService.instance.config.indexPrefix}-$index';
        status[fullName] = exists;
      }

      return {
        'success': true,
        'indices': status,
        'prefix': ElasticsearchService.instance.config.indexPrefix,
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Index a test document (for testing purposes)
  Future<Map<String, dynamic>> indexTestDocument(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {
          'success': false,
          'error': 'Elasticsearch service not initialized',
        };
      }

      final testDoc = {
        'displayName': 'Test Driver',
        'bio': 'This is a test driver for Elasticsearch integration',
        'vehicleType': 'car',
        'ratingAverage': 4.5,
        'isOnline': true,
        'isVerified': true,
        'location': {
          'lat': 33.5731,
          'lon': -7.5898,
        },
        'createdAt': DateTime.now().toIso8601String(),
      };

      final result = await ElasticsearchService.instance.client.indexDocument(
        ElasticsearchConfig.driversIndex,
        'test-driver-001',
        testDoc,
      );

      return {
        'success': true,
        'result': result['result'],
        'index': result['_index'],
        'id': result['_id'],
        'version': result['_version'],
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Search test document
  Future<Map<String, dynamic>> searchTestDocument(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {
          'success': false,
          'error': 'Elasticsearch service not initialized',
        };
      }

      final result = await ElasticsearchService.instance.client.search(
        ElasticsearchConfig.driversIndex,
        {
          'query': {
            'match': {
              'bio': 'test',
            }
          }
        },
      );

      final hits = result['hits']?['hits'] as List? ?? [];
      
      final hitsList = hits.map((h) {
        final hit = h as Map<String, dynamic>;
        return <String, dynamic>{
          'id': hit['_id'],
          'score': hit['_score'],
          'source': hit['_source'],
        };
      }).toList();
      
      return {
        'success': true,
        'total': result['hits']?['total']?['value'] ?? 0,
        'hits': hitsList,
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Delete test document
  Future<Map<String, dynamic>> deleteTestDocument(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {
          'success': false,
          'error': 'Elasticsearch service not initialized',
        };
      }

      final result = await ElasticsearchService.instance.client.deleteDocument(
        ElasticsearchConfig.driversIndex,
        'test-driver-001',
      );

      return {
        'success': true,
        'result': result['result'],
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Get Elasticsearch service status summary
  Future<Map<String, dynamic>> getStatus(Session session) async {
    try {
      final isInitialized = ElasticsearchService.instance.isInitialized;
      
      if (!isInitialized) {
        return {
          'success': true,
          'initialized': false,
          'message': 'Elasticsearch service not initialized',
        };
      }

      final isHealthy = await ElasticsearchService.instance.isHealthy();
      final health = await ElasticsearchService.instance.getHealth();

      return {
        'success': true,
        'initialized': true,
        'healthy': isHealthy,
        'clusterStatus': health['status'],
        'clusterName': health['cluster_name'],
        'url': ElasticsearchService.instance.config.url,
        'indexPrefix': ElasticsearchService.instance.config.indexPrefix,
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  // ============================================
  // DATA MIGRATION ENDPOINTS
  // ============================================

  /// Migrate all data from PostgreSQL to Elasticsearch
  /// WARNING: This can take a long time for large datasets
  Future<Map<String, dynamic>> migrateAll(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {
          'success': false,
          'error': 'Elasticsearch service not initialized',
        };
      }

      session.log('[ES Migration] Starting full migration...');
      final startTime = DateTime.now();
      
      final results = await ElasticsearchService.instance.sync.migrateAll(session);
      
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      return {
        'success': true,
        'duration': '${duration.inSeconds} seconds',
        'results': results.map((key, value) => MapEntry(key, {
          'success': value['success'],
          'errors': value['errors'],
          'total': value['total'],
        })),
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Migrate only drivers
  Future<Map<String, dynamic>> migrateDrivers(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {'success': false, 'error': 'Elasticsearch service not initialized'};
      }

      final result = await ElasticsearchService.instance.sync.migrateAllDrivers(session);
      return {'success': true, ...result};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Migrate only services
  Future<Map<String, dynamic>> migrateServices(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {'success': false, 'error': 'Elasticsearch service not initialized'};
      }

      final result = await ElasticsearchService.instance.sync.migrateAllServices(session);
      return {'success': true, ...result};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Migrate only driver services (catalog)
  Future<Map<String, dynamic>> migrateDriverServices(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {'success': false, 'error': 'Elasticsearch service not initialized'};
      }

      final result = await ElasticsearchService.instance.sync.migrateAllDriverServices(session);
      return {'success': true, ...result};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Migrate only requests
  Future<Map<String, dynamic>> migrateRequests(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {'success': false, 'error': 'Elasticsearch service not initialized'};
      }

      final result = await ElasticsearchService.instance.sync.migrateAllRequests(session);
      return {'success': true, ...result};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Migrate only stores
  Future<Map<String, dynamic>> migrateStores(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {'success': false, 'error': 'Elasticsearch service not initialized'};
      }

      final result = await ElasticsearchService.instance.sync.migrateAllStores(session);
      return {'success': true, ...result};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Migrate only products
  Future<Map<String, dynamic>> migrateProducts(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {'success': false, 'error': 'Elasticsearch service not initialized'};
      }

      final result = await ElasticsearchService.instance.sync.migrateAllProducts(session);
      return {'success': true, ...result};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Migrate only reviews
  Future<Map<String, dynamic>> migrateReviews(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {'success': false, 'error': 'Elasticsearch service not initialized'};
      }

      final result = await ElasticsearchService.instance.sync.migrateAllReviews(session);
      return {'success': true, ...result};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Migrate only store orders
  Future<Map<String, dynamic>> migrateStoreOrders(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {'success': false, 'error': 'Elasticsearch service not initialized'};
      }

      final result = await ElasticsearchService.instance.sync.migrateAllStoreOrders(session);
      return {'success': true, ...result};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Migrate only transactions
  Future<Map<String, dynamic>> migrateTransactions(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {'success': false, 'error': 'Elasticsearch service not initialized'};
      }

      final result = await ElasticsearchService.instance.sync.migrateAllTransactions(session);
      return {'success': true, ...result};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Migrate only users
  Future<Map<String, dynamic>> migrateUsers(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {'success': false, 'error': 'Elasticsearch service not initialized'};
      }

      final result = await ElasticsearchService.instance.sync.migrateAllUsers(session);
      return {'success': true, ...result};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Migrate only wallets
  Future<Map<String, dynamic>> migrateWallets(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {'success': false, 'error': 'Elasticsearch service not initialized'};
      }

      final result = await ElasticsearchService.instance.sync.migrateAllWallets(session);
      return {'success': true, ...result};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Migrate only ratings (combines service ratings + store reviews)
  Future<Map<String, dynamic>> migrateRatings(Session session) async {
    try {
      if (!ElasticsearchService.instance.isInitialized) {
        return {'success': false, 'error': 'Elasticsearch service not initialized'};
      }

      final result = await ElasticsearchService.instance.sync.migrateAllRatings(session);
      return {'success': true, ...result};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Get document count for each index
  /// Returns a flat map: {"awhar-drivers": 6, "awhar-services": 22, ...}
  Future<Map<String, int>> getDocumentCounts(Session session) async {
    if (!ElasticsearchService.instance.isInitialized) {
      throw Exception('Elasticsearch service not initialized');
    }

    final indices = [
      ElasticsearchConfig.driversIndex,
      ElasticsearchConfig.servicesIndex,
      ElasticsearchConfig.driverServicesIndex,
      ElasticsearchConfig.requestsIndex,
      ElasticsearchConfig.storesIndex,
      ElasticsearchConfig.productsIndex,
      ElasticsearchConfig.reviewsIndex,
      ElasticsearchConfig.searchLogsIndex,
      ElasticsearchConfig.storeOrdersIndex,
      ElasticsearchConfig.transactionsIndex,
      ElasticsearchConfig.usersIndex,
      ElasticsearchConfig.walletsIndex,
      ElasticsearchConfig.ratingsIndex,
      ElasticsearchConfig.deviceFingerprintsIndex,
      ElasticsearchConfig.fraudAlertsIndex,
    ];

    final counts = <String, int>{};
    for (final index in indices) {
      try {
        final result = await ElasticsearchService.instance.client.search(
          index,
          {'query': {'match_all': {}}, 'size': 0},
        );
        final total = result['hits']?['total']?['value'] ?? 0;
        counts['${ElasticsearchService.instance.config.indexPrefix}-$index'] = total as int;
      } catch (e) {
        counts['${ElasticsearchService.instance.config.indexPrefix}-$index'] = -1;
      }
    }

    return counts;
  }
}
