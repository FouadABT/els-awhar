import 'dart:async';
import 'dart:convert';
import 'package:serverpod/serverpod.dart' hide Transaction;
import 'package:awhar_server/src/generated/protocol.dart';
import 'elasticsearch_client.dart';
import 'elasticsearch_config.dart';
import 'elasticsearch_transformer.dart';
import 'documents/documents.dart';

/// Service for syncing data between PostgreSQL and Elasticsearch
/// Implements both real-time sync and batch migration
class ElasticsearchSyncService {
  final ElasticsearchClient _client;
  final ElasticsearchConfig _config;
  
  // Sync statistics
  int _successCount = 0;
  int _errorCount = 0;
  final List<String> _errors = [];

  ElasticsearchSyncService(this._client, this._config);

  // ============================================
  // DRIVER SYNC
  // ============================================

  /// Index a single driver
  Future<bool> indexDriver(Session session, DriverProfile driver) async {
    try {
      final doc = await ElasticsearchTransformer.transformDriver(session, driver);
      await _client.indexDocument(
        'drivers',
        doc.documentId,
        doc.toJson(),
      );
      session.log('[ES Sync] Indexed driver: ${driver.displayName}');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error indexing driver ${driver.id}: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Update driver in ES (same as index, ES handles upsert)
  Future<bool> updateDriver(Session session, DriverProfile driver) async {
    return indexDriver(session, driver);
  }

  /// Delete driver from ES
  Future<bool> deleteDriver(Session session, int driverId) async {
    try {
      await _client.deleteDocument(
        'drivers',
        'driver_$driverId',
      );
      session.log('[ES Sync] Deleted driver: $driverId');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error deleting driver $driverId: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Batch index all drivers
  Future<Map<String, int>> migrateAllDrivers(Session session) async {
    _resetStats();
    session.log('[ES Sync] Starting driver migration...');
    
    const batchSize = 100;
    var offset = 0;
    var total = 0;
    
    while (true) {
      final drivers = await DriverProfile.db.find(
        session,
        limit: batchSize,
        offset: offset,
      );
      
      if (drivers.isEmpty) break;
      
      final documents = <Map<String, dynamic>>[];
      final documentIds = <String>[];
      
      for (final driver in drivers) {
        try {
          final doc = await ElasticsearchTransformer.transformDriver(session, driver);
          documents.add(doc.toJson());
          documentIds.add(doc.documentId);
          _successCount++;
        } catch (e) {
          _errorCount++;
          _errors.add('Driver ${driver.id}: $e');
        }
      }
      
      if (documents.isNotEmpty) {
        await _client.bulkIndex('drivers', documents, documentIds);
      }
      
      total += drivers.length;
      offset += batchSize;
      session.log('[ES Sync] Migrated $total drivers...');
    }
    
    session.log('[ES Sync] Driver migration complete: $_successCount success, $_errorCount errors');
    return {'success': _successCount, 'errors': _errorCount, 'total': total};
  }

  // ============================================
  // SERVICE SYNC
  // ============================================

  /// Index a single service
  Future<bool> indexService(Session session, Service service) async {
    try {
      final doc = await ElasticsearchTransformer.transformService(session, service);
      await _client.indexDocument(
        'services',
        doc.documentId,
        doc.toJson(),
      );
      session.log('[ES Sync] Indexed service: ${service.nameEn}');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error indexing service ${service.id}: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Batch index all services
  Future<Map<String, int>> migrateAllServices(Session session) async {
    _resetStats();
    session.log('[ES Sync] Starting service migration...');
    
    final services = await Service.db.find(session);
    final documents = <Map<String, dynamic>>[];
    final documentIds = <String>[];
    
    for (final service in services) {
      try {
        final doc = await ElasticsearchTransformer.transformService(session, service);
        documents.add(doc.toJson());
        documentIds.add(doc.documentId);
        _successCount++;
      } catch (e) {
        _errorCount++;
        _errors.add('Service ${service.id}: $e');
      }
    }
    
    if (documents.isNotEmpty) {
      await _client.bulkIndex('services', documents, documentIds);
    }
    
    session.log('[ES Sync] Service migration complete: $_successCount success, $_errorCount errors');
    return {'success': _successCount, 'errors': _errorCount, 'total': services.length};
  }

  // ============================================
  // DRIVER SERVICE SYNC
  // ============================================

  /// Index a single driver service
  Future<bool> indexDriverService(Session session, DriverService driverService) async {
    try {
      final doc = await ElasticsearchTransformer.transformDriverService(session, driverService);
      await _client.indexDocument(
        'driver-services',
        doc.documentId,
        doc.toJson(),
      );
      session.log('[ES Sync] Indexed driver service: ${driverService.id}');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error indexing driver service ${driverService.id}: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Delete driver service from ES
  Future<bool> deleteDriverService(Session session, int driverServiceId) async {
    try {
      await _client.deleteDocument(
        'driver-services',
        'driver_service_$driverServiceId',
      );
      session.log('[ES Sync] Deleted driver service: $driverServiceId');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error deleting driver service $driverServiceId: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Batch index all driver services
  Future<Map<String, int>> migrateAllDriverServices(Session session) async {
    _resetStats();
    session.log('[ES Sync] Starting driver services migration...');
    
    const batchSize = 100;
    var offset = 0;
    var total = 0;
    
    while (true) {
      final driverServices = await DriverService.db.find(
        session,
        where: (t) => t.isActive.equals(true),
        limit: batchSize,
        offset: offset,
      );
      
      if (driverServices.isEmpty) break;
      
      final documents = <Map<String, dynamic>>[];
      final documentIds = <String>[];
      
      for (final ds in driverServices) {
        try {
          final doc = await ElasticsearchTransformer.transformDriverService(session, ds);
          documents.add(doc.toJson());
          documentIds.add(doc.documentId);
          _successCount++;
        } catch (e) {
          _errorCount++;
          _errors.add('DriverService ${ds.id}: $e');
        }
      }
      
      if (documents.isNotEmpty) {
        await _client.bulkIndex('driver-services', documents, documentIds);
      }
      
      total += driverServices.length;
      offset += batchSize;
      session.log('[ES Sync] Migrated $total driver services...');
    }
    
    session.log('[ES Sync] Driver services migration complete: $_successCount success, $_errorCount errors');
    return {'success': _successCount, 'errors': _errorCount, 'total': total};
  }

  // ============================================
  // REQUEST SYNC
  // ============================================

  /// Index a single service request
  Future<bool> indexRequest(Session session, ServiceRequest request) async {
    try {
      final doc = ElasticsearchTransformer.transformRequest(request);
      await _client.indexDocument(
        'requests',
        doc.documentId,
        doc.toJson(),
      );
      session.log('[ES Sync] Indexed request: ${request.id}');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error indexing request ${request.id}: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Batch index all requests
  Future<Map<String, int>> migrateAllRequests(Session session) async {
    _resetStats();
    session.log('[ES Sync] Starting requests migration...');
    
    const batchSize = 200;
    var offset = 0;
    var total = 0;
    
    while (true) {
      final requests = await ServiceRequest.db.find(
        session,
        limit: batchSize,
        offset: offset,
      );
      
      if (requests.isEmpty) break;
      
      final documents = <Map<String, dynamic>>[];
      final documentIds = <String>[];
      
      for (final request in requests) {
        try {
          final doc = ElasticsearchTransformer.transformRequest(request);
          documents.add(doc.toJson());
          documentIds.add(doc.documentId);
          _successCount++;
        } catch (e) {
          _errorCount++;
          _errors.add('Request ${request.id}: $e');
        }
      }
      
      if (documents.isNotEmpty) {
        await _client.bulkIndex('requests', documents, documentIds);
      }
      
      total += requests.length;
      offset += batchSize;
      session.log('[ES Sync] Migrated $total requests...');
    }
    
    session.log('[ES Sync] Requests migration complete: $_successCount success, $_errorCount errors');
    return {'success': _successCount, 'errors': _errorCount, 'total': total};
  }

  // ============================================
  // STORE SYNC
  // ============================================

  /// Index a single store
  Future<bool> indexStore(Session session, Store store) async {
    try {
      final doc = await ElasticsearchTransformer.transformStore(session, store);
      await _client.indexDocument(
        'stores',
        doc.documentId,
        doc.toJson(),
      );
      session.log('[ES Sync] Indexed store: ${store.name}');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error indexing store ${store.id}: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Delete store from ES
  Future<bool> deleteStore(Session session, int storeId) async {
    try {
      await _client.deleteDocument(
        'stores',
        'store_$storeId',
      );
      session.log('[ES Sync] Deleted store: $storeId');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error deleting store $storeId: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Batch index all stores
  Future<Map<String, int>> migrateAllStores(Session session) async {
    _resetStats();
    session.log('[ES Sync] Starting stores migration...');
    
    final stores = await Store.db.find(
      session,
      where: (t) => t.isActive.equals(true),
    );
    
    final documents = <Map<String, dynamic>>[];
    final documentIds = <String>[];
    
    for (final store in stores) {
      try {
        final doc = await ElasticsearchTransformer.transformStore(session, store);
        documents.add(doc.toJson());
        documentIds.add(doc.documentId);
        _successCount++;
      } catch (e) {
        _errorCount++;
        _errors.add('Store ${store.id}: $e');
      }
    }
    
    if (documents.isNotEmpty) {
      await _client.bulkIndex('stores', documents, documentIds);
    }
    
    session.log('[ES Sync] Stores migration complete: $_successCount success, $_errorCount errors');
    return {'success': _successCount, 'errors': _errorCount, 'total': stores.length};
  }

  // ============================================
  // PRODUCT SYNC
  // ============================================

  /// Index a single product
  Future<bool> indexProduct(Session session, StoreProduct product) async {
    try {
      final doc = await ElasticsearchTransformer.transformProduct(session, product);
      await _client.indexDocument(
        'products',
        doc.documentId,
        doc.toJson(),
      );
      session.log('[ES Sync] Indexed product: ${product.name}');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error indexing product ${product.id}: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Delete product from ES
  Future<bool> deleteProduct(Session session, int productId) async {
    try {
      await _client.deleteDocument(
        'products',
        'product_$productId',
      );
      session.log('[ES Sync] Deleted product: $productId');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error deleting product $productId: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Batch index all products
  Future<Map<String, int>> migrateAllProducts(Session session) async {
    _resetStats();
    session.log('[ES Sync] Starting products migration...');
    
    const batchSize = 100;
    var offset = 0;
    var total = 0;
    
    while (true) {
      final products = await StoreProduct.db.find(
        session,
        where: (t) => t.isAvailable.equals(true),
        limit: batchSize,
        offset: offset,
      );
      
      if (products.isEmpty) break;
      
      final documents = <Map<String, dynamic>>[];
      final documentIds = <String>[];
      
      for (final product in products) {
        try {
          final doc = await ElasticsearchTransformer.transformProduct(session, product);
          documents.add(doc.toJson());
          documentIds.add(doc.documentId);
          _successCount++;
        } catch (e) {
          _errorCount++;
          _errors.add('Product ${product.id}: $e');
        }
      }
      
      if (documents.isNotEmpty) {
        await _client.bulkIndex('products', documents, documentIds);
      }
      
      total += products.length;
      offset += batchSize;
      session.log('[ES Sync] Migrated $total products...');
    }
    
    session.log('[ES Sync] Products migration complete: $_successCount success, $_errorCount errors');
    return {'success': _successCount, 'errors': _errorCount, 'total': total};
  }

  // ============================================
  // REVIEW SYNC
  // ============================================

  /// Index a single review
  Future<bool> indexReview(Session session, Review review) async {
    try {
      final doc = await ElasticsearchTransformer.transformReview(session, review);
      await _client.indexDocument(
        'reviews',
        doc.documentId,
        doc.toJson(),
      );
      session.log('[ES Sync] Indexed review: ${review.id}');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error indexing review ${review.id}: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Batch index all reviews
  Future<Map<String, int>> migrateAllReviews(Session session) async {
    _resetStats();
    session.log('[ES Sync] Starting reviews migration...');
    
    const batchSize = 100;
    var offset = 0;
    var total = 0;
    
    while (true) {
      final reviews = await Review.db.find(
        session,
        where: (t) => t.isVisible.equals(true),
        limit: batchSize,
        offset: offset,
      );
      
      if (reviews.isEmpty) break;
      
      final documents = <Map<String, dynamic>>[];
      final documentIds = <String>[];
      
      for (final review in reviews) {
        try {
          final doc = await ElasticsearchTransformer.transformReview(session, review);
          documents.add(doc.toJson());
          documentIds.add(doc.documentId);
          _successCount++;
        } catch (e) {
          _errorCount++;
          _errors.add('Review ${review.id}: $e');
        }
      }
      
      if (documents.isNotEmpty) {
        await _client.bulkIndex('reviews', documents, documentIds);
      }
      
      total += reviews.length;
      offset += batchSize;
      session.log('[ES Sync] Migrated $total reviews...');
    }
    
    session.log('[ES Sync] Reviews migration complete: $_successCount success, $_errorCount errors');
    return {'success': _successCount, 'errors': _errorCount, 'total': total};
  }

  // ============================================
  // STORE ORDER SYNC
  // ============================================

  /// Index a single store order
  Future<bool> indexStoreOrder(Session session, StoreOrder order) async {
    try {
      final doc = await ElasticsearchTransformer.transformStoreOrder(session, order);
      await _client.indexDocument(
        'store-orders',
        order.id.toString(),
        doc.toJson(),
      );
      session.log('[ES Sync] Indexed store order: ${order.orderNumber}');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error indexing store order ${order.id}: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Delete a store order from ES
  Future<bool> deleteStoreOrder(Session session, int orderId) async {
    try {
      await _client.deleteDocument('store-orders', orderId.toString());
      session.log('[ES Sync] Deleted store order: $orderId');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error deleting store order $orderId: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Batch index all store orders
  Future<Map<String, int>> migrateAllStoreOrders(Session session) async {
    _resetStats();
    session.log('[ES Sync] Starting store orders migration...');
    
    const batchSize = 100;
    var offset = 0;
    var total = 0;
    
    while (true) {
      final orders = await StoreOrder.db.find(
        session,
        limit: batchSize,
        offset: offset,
      );
      
      if (orders.isEmpty) break;
      
      final documents = <Map<String, dynamic>>[];
      final documentIds = <String>[];
      
      for (final order in orders) {
        try {
          final doc = await ElasticsearchTransformer.transformStoreOrder(session, order);
          documents.add(doc.toJson());
          documentIds.add(order.id.toString());
          _successCount++;
        } catch (e) {
          _errorCount++;
          _errors.add('StoreOrder ${order.id}: $e');
        }
      }
      
      if (documents.isNotEmpty) {
        await _client.bulkIndex('store-orders', documents, documentIds);
      }
      
      total += orders.length;
      offset += batchSize;
      session.log('[ES Sync] Migrated $total store orders...');
    }
    
    session.log('[ES Sync] Store orders migration complete: $_successCount success, $_errorCount errors');
    return {'success': _successCount, 'errors': _errorCount, 'total': total};
  }

  // ============================================
  // SEARCH LOG
  // ============================================

  /// Log a search query for analytics
  Future<bool> logSearch(
    Session session, {
    required String query,
    required String searchType,
    int? userId,
    Map<String, dynamic>? filters,
    int resultCount = 0,
    double? lat,
    double? lon,
    String? sessionId,
    String? deviceType,
    String? language,
  }) async {
    try {
      final doc = EsSearchLogDocument(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        query: query,
        searchType: searchType,
        filters: filters,
        resultCount: resultCount,
        location: (lat != null && lon != null) ? {'lat': lat, 'lon': lon} : null,
        sessionId: sessionId,
        deviceType: deviceType,
        language: language,
        timestamp: DateTime.now(),
      );
      
      await _client.indexDocument(
        'search-logs',
        doc.documentId,
        doc.toJson(),
      );
      return true;
    } catch (e) {
      session.log('[ES Sync] Error logging search: $e', level: LogLevel.error);
      return false;
    }
  }

  // ============================================
  // TRANSACTION SYNC
  // ============================================

  /// Index a single transaction
  Future<bool> indexTransaction(Session session, Transaction transaction) async {
    try {
      final doc = await ElasticsearchTransformer.transformTransaction(session, transaction);
      await _client.indexDocument(
        'transactions',
        doc.documentId,
        doc.toJson(),
      );
      session.log('[ES Sync] Indexed transaction: ${transaction.id}');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error indexing transaction ${transaction.id}: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Delete transaction from ES
  Future<bool> deleteTransaction(Session session, int transactionId) async {
    try {
      await _client.deleteDocument(
        'transactions',
        'transaction_$transactionId',
      );
      session.log('[ES Sync] Deleted transaction: $transactionId');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error deleting transaction $transactionId: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Batch index all transactions
  Future<Map<String, int>> migrateAllTransactions(Session session) async {
    _resetStats();
    session.log('[ES Sync] Starting transaction migration...');
    
    const batchSize = 100;
    var offset = 0;
    var total = 0;
    
    while (true) {
      final transactions = await Transaction.db.find(
        session,
        limit: batchSize,
        offset: offset,
      );
      
      if (transactions.isEmpty) break;
      
      final documents = <Map<String, dynamic>>[];
      final documentIds = <String>[];
      
      for (final transaction in transactions) {
        try {
          final doc = await ElasticsearchTransformer.transformTransaction(session, transaction);
          documents.add(doc.toJson());
          documentIds.add(doc.documentId);
          _successCount++;
        } catch (e) {
          _errorCount++;
          _errors.add('Transaction ${transaction.id}: $e');
        }
      }
      
      if (documents.isNotEmpty) {
        await _client.bulkIndex('transactions', documents, documentIds);
      }
      
      total += transactions.length;
      offset += batchSize;
      session.log('[ES Sync] Migrated $total transactions...');
    }
    
    session.log('[ES Sync] Transaction migration complete: $_successCount success, $_errorCount errors');
    return {'success': _successCount, 'errors': _errorCount, 'total': total};
  }

  // ============================================
  // USER SYNC
  // ============================================

  /// Index a single user
  Future<bool> indexUser(Session session, User user) async {
    try {
      final doc = await ElasticsearchTransformer.transformUser(session, user);
      await _client.indexDocument(
        'users',
        doc.documentId,
        doc.toJson(),
      );
      session.log('[ES Sync] Indexed user: ${user.fullName}');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error indexing user ${user.id}: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Delete user from ES
  Future<bool> deleteUser(Session session, int userId) async {
    try {
      await _client.deleteDocument(
        'users',
        'user_$userId',
      );
      session.log('[ES Sync] Deleted user: $userId');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error deleting user $userId: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Batch index all users
  Future<Map<String, int>> migrateAllUsers(Session session) async {
    _resetStats();
    session.log('[ES Sync] Starting user migration...');
    
    const batchSize = 100;
    var offset = 0;
    var total = 0;
    
    while (true) {
      final users = await User.db.find(
        session,
        limit: batchSize,
        offset: offset,
      );
      
      if (users.isEmpty) break;
      
      final documents = <Map<String, dynamic>>[];
      final documentIds = <String>[];
      
      for (final user in users) {
        try {
          final doc = await ElasticsearchTransformer.transformUser(session, user);
          documents.add(doc.toJson());
          documentIds.add(doc.documentId);
          _successCount++;
        } catch (e) {
          _errorCount++;
          _errors.add('User ${user.id}: $e');
        }
      }
      
      if (documents.isNotEmpty) {
        await _client.bulkIndex('users', documents, documentIds);
      }
      
      total += users.length;
      offset += batchSize;
      session.log('[ES Sync] Migrated $total users...');
    }
    
    session.log('[ES Sync] User migration complete: $_successCount success, $_errorCount errors');
    return {'success': _successCount, 'errors': _errorCount, 'total': total};
  }

  // ============================================
  // WALLET SYNC
  // ============================================

  /// Index a single wallet
  Future<bool> indexWallet(Session session, Wallet wallet) async {
    try {
      final doc = await ElasticsearchTransformer.transformWallet(session, wallet);
      await _client.indexDocument(
        'wallets',
        doc.documentId,
        doc.toJson(),
      );
      session.log('[ES Sync] Indexed wallet: ${wallet.id}');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error indexing wallet ${wallet.id}: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Delete wallet from ES
  Future<bool> deleteWallet(Session session, int walletId) async {
    try {
      await _client.deleteDocument(
        'wallets',
        'wallet_$walletId',
      );
      session.log('[ES Sync] Deleted wallet: $walletId');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error deleting wallet $walletId: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Batch index all wallets
  Future<Map<String, int>> migrateAllWallets(Session session) async {
    _resetStats();
    session.log('[ES Sync] Starting wallet migration...');
    
    final wallets = await Wallet.db.find(session);
    final documents = <Map<String, dynamic>>[];
    final documentIds = <String>[];
    
    for (final wallet in wallets) {
      try {
        final doc = await ElasticsearchTransformer.transformWallet(session, wallet);
        documents.add(doc.toJson());
        documentIds.add(doc.documentId);
        _successCount++;
      } catch (e) {
        _errorCount++;
        _errors.add('Wallet ${wallet.id}: $e');
      }
    }
    
    if (documents.isNotEmpty) {
      await _client.bulkIndex('wallets', documents, documentIds);
    }
    
    session.log('[ES Sync] Wallet migration complete: $_successCount success, $_errorCount errors');
    return {'success': _successCount, 'errors': _errorCount, 'total': wallets.length};
  }

  // ============================================
  // RATING SYNC (Combined ratings + store_reviews)
  // ============================================

  /// Index a single rating (from service request)
  Future<bool> indexRating(Session session, Rating rating) async {
    try {
      final doc = await ElasticsearchTransformer.transformRating(session, rating);
      await _client.indexDocument(
        'ratings',
        doc.documentId,
        doc.toJson(),
      );
      session.log('[ES Sync] Indexed rating: ${rating.id}');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error indexing rating ${rating.id}: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Index a single store review
  Future<bool> indexStoreReview(Session session, StoreReview review) async {
    try {
      final doc = await ElasticsearchTransformer.transformStoreReview(session, review);
      await _client.indexDocument(
        'ratings',
        doc.documentId,
        doc.toJson(),
      );
      session.log('[ES Sync] Indexed store review: ${review.id}');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error indexing store review ${review.id}: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Delete rating from ES
  Future<bool> deleteRating(Session session, int ratingId, {bool isStoreReview = false}) async {
    try {
      final docId = isStoreReview ? 'store_review_$ratingId' : 'service_request_$ratingId';
      await _client.deleteDocument('ratings', docId);
      session.log('[ES Sync] Deleted rating: $docId');
      return true;
    } catch (e) {
      session.log('[ES Sync] Error deleting rating $ratingId: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Batch index all ratings (from both ratings and store_reviews tables)
  Future<Map<String, int>> migrateAllRatings(Session session) async {
    _resetStats();
    session.log('[ES Sync] Starting ratings migration...');
    
    final documents = <Map<String, dynamic>>[];
    final documentIds = <String>[];
    
    // Migrate service request ratings
    final ratings = await Rating.db.find(session);
    for (final rating in ratings) {
      try {
        final doc = await ElasticsearchTransformer.transformRating(session, rating);
        documents.add(doc.toJson());
        documentIds.add(doc.documentId);
        _successCount++;
      } catch (e) {
        _errorCount++;
        _errors.add('Rating ${rating.id}: $e');
      }
    }
    
    // Migrate store reviews
    final storeReviews = await StoreReview.db.find(session);
    for (final review in storeReviews) {
      try {
        final doc = await ElasticsearchTransformer.transformStoreReview(session, review);
        documents.add(doc.toJson());
        documentIds.add(doc.documentId);
        _successCount++;
      } catch (e) {
        _errorCount++;
        _errors.add('StoreReview ${review.id}: $e');
      }
    }
    
    if (documents.isNotEmpty) {
      await _client.bulkIndex('ratings', documents, documentIds);
    }
    
    final total = ratings.length + storeReviews.length;
    session.log('[ES Sync] Rating migration complete: $_successCount success, $_errorCount errors');
    return {'success': _successCount, 'errors': _errorCount, 'total': total};
  }

  // ============================================
  // FULL MIGRATION
  // ============================================

  /// Migrate all data from PostgreSQL to Elasticsearch
  Future<Map<String, Map<String, int>>> migrateAll(Session session) async {
    session.log('[ES Sync] ========================================');
    session.log('[ES Sync] Starting FULL data migration...');
    session.log('[ES Sync] ========================================');
    
    final results = <String, Map<String, int>>{};
    
    // Migrate in order of dependencies
    results['services'] = await migrateAllServices(session);
    results['drivers'] = await migrateAllDrivers(session);
    results['driverServices'] = await migrateAllDriverServices(session);
    results['requests'] = await migrateAllRequests(session);
    results['stores'] = await migrateAllStores(session);
    results['products'] = await migrateAllProducts(session);
    results['reviews'] = await migrateAllReviews(session);
    results['storeOrders'] = await migrateAllStoreOrders(session);
    results['transactions'] = await migrateAllTransactions(session);
    results['users'] = await migrateAllUsers(session);
    results['wallets'] = await migrateAllWallets(session);
    results['ratings'] = await migrateAllRatings(session);
    
    // Summary
    var totalSuccess = 0;
    var totalErrors = 0;
    var totalDocs = 0;
    
    for (final entry in results.entries) {
      totalSuccess += entry.value['success'] ?? 0;
      totalErrors += entry.value['errors'] ?? 0;
      totalDocs += entry.value['total'] ?? 0;
    }
    
    session.log('[ES Sync] ========================================');
    session.log('[ES Sync] MIGRATION COMPLETE');
    session.log('[ES Sync] Total documents: $totalDocs');
    session.log('[ES Sync] Successful: $totalSuccess');
    session.log('[ES Sync] Errors: $totalErrors');
    session.log('[ES Sync] ========================================');
    
    return results;
  }

  // ============================================
  // UNIFIED SYNC METHOD
  // ============================================

  /// Sync any entity to Elasticsearch
  /// Automatically detects entity type and calls appropriate index method
  /// Returns true if sync was successful, false otherwise
  Future<bool> sync(Session session, dynamic entity) async {
    try {
      if (entity is DriverProfile) {
        return await indexDriver(session, entity);
      } else if (entity is Store) {
        return await indexStore(session, entity);
      } else if (entity is ServiceRequest) {
        return await indexRequest(session, entity);
      } else if (entity is StoreProduct) {
        return await indexProduct(session, entity);
      } else if (entity is Review) {
        return await indexReview(session, entity);
      } else if (entity is DriverService) {
        return await indexDriverService(session, entity);
      } else if (entity is Service) {
        return await indexService(session, entity);
      } else if (entity is StoreOrder) {
        return await indexStoreOrder(session, entity);
      } else if (entity is DeviceFingerprintRecord) {
        return await indexDeviceFingerprint(session, entity);
      } else if (entity is Transaction) {
        return await indexTransaction(session, entity);
      } else if (entity is User) {
        return await indexUser(session, entity);
      } else if (entity is Wallet) {
        return await indexWallet(session, entity);
      } else if (entity is Rating) {
        return await indexRating(session, entity);
      } else if (entity is StoreReview) {
        return await indexStoreReview(session, entity);
      } else {
        session.log('[ES Sync] Unknown entity type: ${entity.runtimeType}', level: LogLevel.warning);
        return false;
      }
    } catch (e) {
      session.log('[ES Sync] Error syncing ${entity.runtimeType}: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Delete any entity from Elasticsearch
  /// Automatically detects entity type and calls appropriate delete method
  Future<bool> delete(Session session, dynamic entity) async {
    try {
      if (entity is DriverProfile) {
        return await deleteDriver(session, entity.id!);
      } else if (entity is Store) {
        return await deleteStore(session, entity.id!);
      } else if (entity is StoreProduct) {
        return await deleteProduct(session, entity.id!);
      } else if (entity is DriverService) {
        return await deleteDriverService(session, entity.id!);
      } else if (entity is StoreOrder) {
        return await deleteStoreOrder(session, entity.id!);
      } else if (entity is DeviceFingerprintRecord) {
        return await deleteDeviceFingerprint(session, entity.fingerprintHash);
      } else if (entity is Transaction) {
        return await deleteTransaction(session, entity.id!);
      } else if (entity is User) {
        return await deleteUser(session, entity.id!);
      } else if (entity is Wallet) {
        return await deleteWallet(session, entity.id!);
      } else if (entity is Rating) {
        return await deleteRating(session, entity.id!, isStoreReview: false);
      } else if (entity is StoreReview) {
        return await deleteRating(session, entity.id!, isStoreReview: true);
      } else {
        session.log('[ES Sync] Delete not implemented for: ${entity.runtimeType}', level: LogLevel.warning);
        return false;
      }
    } catch (e) {
      session.log('[ES Sync] Error deleting ${entity.runtimeType}: $e', level: LogLevel.error);
      return false;
    }
  }

  // ============================================
  // DEVICE FINGERPRINT SYNC (FRAUD DETECTION)
  // ============================================

  /// Index a device fingerprint for fraud detection
  Future<bool> indexDeviceFingerprint(Session session, DeviceFingerprintRecord record) async {
    try {
      // Parse userIds from JSON
      List<int> userIds = [];
      if (record.userIds.isNotEmpty) {
        try {
          final parsed = record.userIds;
          if (parsed.startsWith('[')) {
            userIds = (jsonDecode(parsed) as List).cast<int>();
          }
        } catch (_) {}
      }
      
      final doc = {
        'fingerprintHash': record.fingerprintHash,
        'recordId': record.id,
        'deviceId': record.deviceId,
        'deviceModel': record.deviceModel,
        'deviceBrand': record.deviceBrand,
        'screenWidth': record.screenWidth,
        'screenHeight': record.screenHeight,
        'screenDensity': record.screenDensity,
        'screenResolution': '${record.screenWidth}x${record.screenHeight}',
        'cpuCores': record.cpuCores,
        'isPhysicalDevice': record.isPhysicalDevice,
        'osVersion': record.osVersion,
        'timezone': record.timezone,
        'language': record.language,
        'appVersion': record.appVersion,
        'lastIpAddress': record.lastIpAddress,
        'userIds': userIds,
        'userCount': userIds.length,
        'riskScore': record.riskScore,
        'riskLevel': _getRiskLevel(record.riskScore),
        'riskFactors': (record.riskFactors ?? '').split(',').where((f) => f.isNotEmpty).toList(),
        'isBlocked': record.isBlocked,
        'notes': record.notes,
        'firstSeenAt': record.firstSeenAt.toIso8601String(),
        'lastSeenAt': record.lastSeenAt.toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };
      
      await _client.indexDocument(
        'device-fingerprints',
        record.fingerprintHash,
        doc,
      );
      return true;
    } catch (e) {
      session.log('[ES Sync] Error indexing device fingerprint: $e', level: LogLevel.error);
      return false;
    }
  }
  
  /// Delete a device fingerprint
  Future<bool> deleteDeviceFingerprint(Session session, String fingerprintHash) async {
    try {
      await _client.deleteDocument('device-fingerprints', fingerprintHash);
      return true;
    } catch (e) {
      session.log('[ES Sync] Error deleting device fingerprint: $e', level: LogLevel.error);
      return false;
    }
  }
  
  /// Index a fraud alert
  Future<bool> indexFraudAlert(
    Session session, {
    required String alertId,
    required String alertType,
    required String fingerprintHash,
    int? userId,
    List<int>? userIds,
    required double riskScore,
    required List<String> riskFactors,
    required String description,
    Map<String, dynamic>? evidence,
  }) async {
    try {
      final doc = {
        'alertId': alertId,
        'alertType': alertType,
        'fingerprintHash': fingerprintHash,
        'userId': userId,
        'userIds': userIds ?? [],
        'riskScore': riskScore,
        'riskLevel': _getRiskLevel(riskScore),
        'riskFactors': riskFactors,
        'description': description,
        'evidence': evidence,
        'actionTaken': 'none',
        'status': 'open',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };
      
      await _client.indexDocument('fraud-alerts', alertId, doc);
      return true;
    } catch (e) {
      session.log('[ES Sync] Error indexing fraud alert: $e', level: LogLevel.error);
      return false;
    }
  }
  
  /// Update fraud alert status
  Future<bool> updateFraudAlertStatus(
    Session session, {
    required String alertId,
    required String status,
    String? actionTaken,
    String? resolution,
    String? resolvedBy,
  }) async {
    try {
      final updates = <String, dynamic>{
        'status': status,
        'updatedAt': DateTime.now().toIso8601String(),
      };
      
      if (actionTaken != null) {
        updates['actionTaken'] = actionTaken;
        updates['actionAt'] = DateTime.now().toIso8601String();
      }
      
      if (resolution != null) {
        updates['resolution'] = resolution;
      }
      
      if (resolvedBy != null) {
        updates['resolvedBy'] = resolvedBy;
        updates['resolvedAt'] = DateTime.now().toIso8601String();
      }
      
      // Use indexDocument (ES will upsert/update the document)
      await _client.indexDocument('fraud-alerts', alertId, updates);
      return true;
    } catch (e) {
      session.log('[ES Sync] Error updating fraud alert: $e', level: LogLevel.error);
      return false;
    }
  }
  
  /// Get risk level string from score
  String _getRiskLevel(double score) {
    if (score < 30) return 'low';
    if (score < 50) return 'medium';
    if (score < 70) return 'high';
    return 'critical';
  }

  /// Get sync errors
  List<String> getErrors() => List.unmodifiable(_errors);
  
  void _resetStats() {
    _successCount = 0;
    _errorCount = 0;
    _errors.clear();
  }
}
