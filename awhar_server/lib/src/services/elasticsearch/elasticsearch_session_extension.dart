import 'package:serverpod/serverpod.dart' hide Transaction;
import 'package:awhar_server/src/generated/protocol.dart';
import 'elasticsearch_service.dart';

/// Extension on Session to provide easy access to Elasticsearch sync operations
/// 
/// Usage in endpoints:
/// ```dart
/// // After creating/updating a driver
/// final driver = await DriverProfile.db.updateRow(session, driver);
/// await session.esSync.indexDriver(driver);
/// ```
extension ElasticsearchSessionExtension on Session {
  /// Get the Elasticsearch sync service
  ElasticsearchSyncHelper get esSync => ElasticsearchSyncHelper(this);
}

/// Helper class for syncing data to Elasticsearch from endpoints
class ElasticsearchSyncHelper {
  final Session _session;
  
  ElasticsearchSyncHelper(this._session);
  
  /// Check if Elasticsearch is available
  bool get isAvailable => ElasticsearchService.instance.isInitialized;
  
  // ============================================
  // UNIFIED SYNC METHODS
  // ============================================
  
  /// Sync any entity to Elasticsearch (auto-detects type)
  /// 
  /// Supports: DriverProfile, Store, ServiceRequest, StoreProduct, 
  /// Review, DriverService, Service
  /// 
  /// Example:
  /// ```dart
  /// final driver = await DriverProfile.db.updateRow(session, driver);
  /// await session.esSync.sync(driver);  // Automatically indexes driver
  /// ```
  Future<void> sync(dynamic entity) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.sync(_session, entity);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error syncing ${entity.runtimeType}: $e', level: LogLevel.warning);
    }
  }
  
  /// Delete any entity from Elasticsearch (auto-detects type)
  /// 
  /// Supports: DriverProfile, Store, StoreProduct, DriverService
  /// 
  /// Example:
  /// ```dart
  /// await DriverProfile.db.deleteRow(session, driver);
  /// await session.esSync.delete(driver);  // Automatically removes from ES
  /// ```
  Future<void> delete(dynamic entity) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.delete(_session, entity);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error deleting ${entity.runtimeType}: $e', level: LogLevel.warning);
    }
  }
  
  // ============================================
  // TYPE-SPECIFIC METHODS (for explicit control)
  // ============================================
  
  /// Index a driver profile (async, non-blocking)
  Future<void> indexDriver(DriverProfile driver) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.indexDriver(_session, driver);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error indexing driver: $e', level: LogLevel.warning);
    }
  }
  
  /// Delete a driver from ES
  Future<void> deleteDriver(int driverId) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.deleteDriver(_session, driverId);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error deleting driver: $e', level: LogLevel.warning);
    }
  }
  
  /// Index a service
  Future<void> indexService(Service service) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.indexService(_session, service);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error indexing service: $e', level: LogLevel.warning);
    }
  }
  
  /// Index a driver service (catalog item)
  Future<void> indexDriverService(DriverService driverService) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.indexDriverService(_session, driverService);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error indexing driver service: $e', level: LogLevel.warning);
    }
  }
  
  /// Delete a driver service from ES
  Future<void> deleteDriverService(int driverServiceId) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.deleteDriverService(_session, driverServiceId);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error deleting driver service: $e', level: LogLevel.warning);
    }
  }
  
  /// Index a service request
  Future<void> indexRequest(ServiceRequest request) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.indexRequest(_session, request);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error indexing request: $e', level: LogLevel.warning);
    }
  }
  
  /// Index a store
  Future<void> indexStore(Store store) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.indexStore(_session, store);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error indexing store: $e', level: LogLevel.warning);
    }
  }
  
  /// Delete a store from ES
  Future<void> deleteStore(int storeId) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.deleteStore(_session, storeId);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error deleting store: $e', level: LogLevel.warning);
    }
  }
  
  /// Index a product
  Future<void> indexProduct(StoreProduct product) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.indexProduct(_session, product);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error indexing product: $e', level: LogLevel.warning);
    }
  }
  
  /// Delete a product from ES
  Future<void> deleteProduct(int productId) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.deleteProduct(_session, productId);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error deleting product: $e', level: LogLevel.warning);
    }
  }
  
  /// Index a review
  Future<void> indexReview(Review review) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.indexReview(_session, review);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error indexing review: $e', level: LogLevel.warning);
    }
  }
  
  /// Index a store order
  Future<void> indexStoreOrder(StoreOrder order) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.indexStoreOrder(_session, order);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error indexing store order: $e', level: LogLevel.warning);
    }
  }
  
  /// Delete a store order from ES
  Future<void> deleteStoreOrder(int orderId) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.deleteStoreOrder(_session, orderId);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error deleting store order: $e', level: LogLevel.warning);
    }
  }
  
  /// Log a search query for analytics
  Future<void> logSearch({
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
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.logSearch(
        _session,
        query: query,
        searchType: searchType,
        userId: userId,
        filters: filters,
        resultCount: resultCount,
        lat: lat,
        lon: lon,
        sessionId: sessionId,
        deviceType: deviceType,
        language: language,
      );
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error logging search: $e', level: LogLevel.warning);
    }
  }
  
  // ============================================
  // TRANSACTION SYNC
  // ============================================
  
  /// Index a transaction to ES (non-blocking)
  Future<void> indexTransaction(Transaction transaction) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.indexTransaction(_session, transaction);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error indexing transaction: $e', level: LogLevel.warning);
    }
  }
  
  /// Delete a transaction from ES
  Future<void> deleteTransaction(int transactionId) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.deleteTransaction(_session, transactionId);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error deleting transaction: $e', level: LogLevel.warning);
    }
  }
  
  // ============================================
  // USER SYNC
  // ============================================
  
  /// Index a user to ES (non-blocking)
  Future<void> indexUser(User user) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.indexUser(_session, user);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error indexing user: $e', level: LogLevel.warning);
    }
  }
  
  /// Delete a user from ES
  Future<void> deleteUser(int userId) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.deleteUser(_session, userId);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error deleting user: $e', level: LogLevel.warning);
    }
  }
  
  // ============================================
  // WALLET SYNC
  // ============================================
  
  /// Index a wallet to ES (non-blocking)
  Future<void> indexWallet(Wallet wallet) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.indexWallet(_session, wallet);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error indexing wallet: $e', level: LogLevel.warning);
    }
  }
  
  /// Delete a wallet from ES
  Future<void> deleteWallet(int walletId) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.deleteWallet(_session, walletId);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error deleting wallet: $e', level: LogLevel.warning);
    }
  }
  
  // ============================================
  // RATING SYNC
  // ============================================
  
  /// Index a rating (from service request) to ES (non-blocking)
  Future<void> indexRating(Rating rating) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.indexRating(_session, rating);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error indexing rating: $e', level: LogLevel.warning);
    }
  }
  
  /// Index a store review to ES (non-blocking)
  Future<void> indexStoreReview(StoreReview review) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.indexStoreReview(_session, review);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error indexing store review: $e', level: LogLevel.warning);
    }
  }
  
  /// Delete a rating from ES
  Future<void> deleteRating(int ratingId, {bool isStoreReview = false}) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.deleteRating(_session, ratingId, isStoreReview: isStoreReview);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error deleting rating: $e', level: LogLevel.warning);
    }
  }
  
  // ============================================
  // FRAUD DETECTION - DEVICE FINGERPRINTS
  // ============================================
  
  /// Index a device fingerprint for fraud detection
  Future<void> indexDeviceFingerprint(DeviceFingerprintRecord record) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.indexDeviceFingerprint(_session, record);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error indexing device fingerprint: $e', level: LogLevel.warning);
    }
  }
  
  /// Delete a device fingerprint from ES
  Future<void> deleteDeviceFingerprint(String fingerprintHash) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.deleteDeviceFingerprint(_session, fingerprintHash);
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error deleting device fingerprint: $e', level: LogLevel.warning);
    }
  }
  
  /// Index a fraud alert
  Future<void> indexFraudAlert({
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
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.indexFraudAlert(
        _session,
        alertId: alertId,
        alertType: alertType,
        fingerprintHash: fingerprintHash,
        userId: userId,
        userIds: userIds,
        riskScore: riskScore,
        riskFactors: riskFactors,
        description: description,
        evidence: evidence,
      );
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error indexing fraud alert: $e', level: LogLevel.warning);
    }
  }
  
  /// Update fraud alert status
  Future<void> updateFraudAlertStatus({
    required String alertId,
    required String status,
    String? actionTaken,
    String? resolution,
    String? resolvedBy,
  }) async {
    if (!isAvailable) return;
    
    try {
      await ElasticsearchService.instance.sync.updateFraudAlertStatus(
        _session,
        alertId: alertId,
        status: status,
        actionTaken: actionTaken,
        resolution: resolution,
        resolvedBy: resolvedBy,
      );
    } catch (e) {
      _session.log('[ES Sync] Non-blocking error updating fraud alert: $e', level: LogLevel.warning);
    }
  }
}
