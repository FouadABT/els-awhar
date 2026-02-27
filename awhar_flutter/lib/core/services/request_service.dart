import 'package:awhar_client/awhar_client.dart';
import 'package:get/get.dart';
import 'device_fingerprint_service.dart';

/// Service for managing service requests (rides, deliveries)
class RequestService extends GetxService {
  final Client _client = Get.find<Client>();

  /// Create a new service request with optional client offered price
  /// Supports both generic requests and catalog-specific requests
  /// Automatically includes device fingerprint for fraud detection
  Future<ServiceRequest?> createRequest({
    required int clientId,
    required ServiceType serviceType,
    Location? pickupLocation,
    required Location destinationLocation,
    String? notes,
    double? clientOfferedPrice,
    bool? isPurchaseRequired,
    double? estimatedPurchaseCost,
    String? itemDescription,
    int? catalogServiceId,      // Reference to catalog service
    int? catalogDriverId,       // Pre-assigned driver from catalog
  }) async {
    try {
      // Get device fingerprint for fraud detection
      String? deviceFingerprint;
      try {
        if (Get.isRegistered<DeviceFingerprintService>()) {
          final fingerprintService = Get.find<DeviceFingerprintService>();
          final fingerprint = await fingerprintService.getFingerprint();
          deviceFingerprint = fingerprint.fingerprintHash;
          print('[RequestService] 🔒 Including device fingerprint for fraud tracking');
        }
      } catch (e) {
        print('[RequestService] ⚠️ Could not get device fingerprint: $e');
        // Continue without fingerprint - not blocking
      }
      
      final request = await _client.request.createRequest(
        clientId,
        serviceType,
        pickupLocation,
        destinationLocation,
        notes,
        clientOfferedPrice: clientOfferedPrice,
        isPurchaseRequired: isPurchaseRequired,
        estimatedPurchaseCost: estimatedPurchaseCost,
        catalogServiceId: catalogServiceId,
        catalogDriverId: catalogDriverId,
        deviceFingerprint: deviceFingerprint,
        // TODO: Add itemDescription to shopping list when supported
      );
      return request;
    } catch (e) {
      print('[RequestService] Error creating request: $e');
      rethrow;
    }
  }

  /// Get price suggestion for a route
  Future<Map<String, dynamic>?> getPriceSuggestion({
    required double pickupLat,
    required double pickupLon,
    required double destLat,
    required double destLon,
    required ServiceType serviceType,
  }) async {
    try {
      // TODO: Uncomment when backend implements getPriceSuggestion endpoint
      // final suggestion = await _client.request.getPriceSuggestion(
      //   pickupLat,
      //   pickupLon,
      //   destLat,
      //   destLon,
      //   serviceType,
      // );
      // return suggestion;

      // For now, return null (price suggestion not implemented)
      return null;
    } catch (e) {
      print('[RequestService] Error getting price suggestion: $e');
      return null;
    }
  }

  /// Get client's pending requests (waiting for driver offers)
  Future<List<ServiceRequest>> getClientPendingRequests(int clientId) async {
    try {
      // Get all requests for client with pending status
      final history = await _client.request.getClientRequestHistory(
        clientId,
        limit: 100,
        offset: 0,
      );
      return history.where((r) => r.status == RequestStatus.pending).toList();
    } catch (e) {
      print('[RequestService] Error fetching pending requests: $e');
      return [];
    }
  }

  /// Accept a driver's proposal (client accepts)
  Future<ServiceRequest?> acceptProposal({
    required int proposalId,
    required int clientId,
  }) async {
    try {
      return await _client.proposal.acceptProposal(
        proposalId: proposalId,
        clientId: clientId,
      );
    } catch (e) {
      print('[RequestService] Error accepting proposal: $e');
      rethrow;
    }
  }

  /// Reject a driver's proposal (client rejects)
  Future<bool> rejectProposal({
    required int proposalId,
    required int clientId,
  }) async {
    try {
      return await _client.proposal.rejectProposal(
        proposalId: proposalId,
        clientId: clientId,
      );
    } catch (e) {
      print('[RequestService] Error rejecting proposal: $e');
      return false;
    }
  }

  /// Get request by ID
  Future<ServiceRequest?> getRequestById(int requestId) async {
    try {
      return await _client.request.getRequestById(requestId);
    } catch (e) {
      print('[RequestService] Error fetching request $requestId: $e');
      return null;
    }
  }

  /// Get ALL active requests for current client
  Future<List<ServiceRequest>> getActiveRequestsForClient(int clientId) async {
    try {
      return await _client.request.getActiveRequestsForClient(clientId);
    } catch (e) {
      print('[RequestService] Error fetching active client requests: $e');
      return [];
    }
  }

  /// Get active request for current client (DEPRECATED - returns first one)
  @Deprecated('Use getActiveRequestsForClient instead')
  Future<ServiceRequest?> getActiveRequestForClient(int clientId) async {
    try {
      return await _client.request.getActiveRequestForClient(clientId);
    } catch (e) {
      print('[RequestService] Error fetching active client request: $e');
      return null;
    }
  }

  /// Get active request for current driver (returns first one)
  Future<ServiceRequest?> getActiveRequestForDriver(int driverId) async {
    try {
      return await _client.request.getActiveRequestForDriver(driverId);
    } catch (e) {
      print('[RequestService] Error fetching active driver request: $e');
      return null;
    }
  }

  /// Get ALL active requests for driver (supports multiple deliveries)
  Future<List<ServiceRequest>> getActiveRequestsForDriver(int driverId) async {
    try {
      return await _client.request.getActiveRequestsForDriver(driverId);
    } catch (e) {
      print('[RequestService] Error fetching active driver requests: $e');
      return [];
    }
  }

  /// Get nearby pending requests for a driver
  Future<List<ServiceRequest>> getNearbyRequests({
    required int driverId,
    required double driverLat,
    required double driverLon,
    double radiusKm = 10.0,
  }) async {
    try {
      return await _client.request.getNearbyRequests(
        driverId,
        driverLat,
        driverLon,
        radiusKm: radiusKm,
      );
    } catch (e) {
      print('[RequestService] Error fetching nearby requests: $e');
      return [];
    }
  }

  /// Accept a request (driver accepts - creates proposal)
  Future<ServiceRequest?> acceptRequest({
    required int requestId,
    required int driverId,
  }) async {
    try {
      return await _client.request.acceptRequest(requestId, driverId);
    } catch (e) {
      print('[RequestService] Error accepting request: $e');
      rethrow;
    }
  }

  /// Approve a proposed driver (client accepts driver proposal)
  Future<ServiceRequest?> approveDriver({
    required int requestId,
    required int clientId,
  }) async {
    try {
      return await _client.request.approveDriver(requestId, clientId);
    } catch (e) {
      print('[RequestService] Error approving driver: $e');
      rethrow;
    }
  }

  /// Reject a proposed driver (client rejects driver proposal)
  Future<ServiceRequest?> rejectDriver({
    required int requestId,
    required int clientId,
  }) async {
    try {
      return await _client.request.rejectDriver(requestId, clientId);
    } catch (e) {
      print('[RequestService] Error rejecting driver: $e');
      rethrow;
    }
  }

  /// Update request status
  Future<ServiceRequest?> updateRequestStatus({
    required int requestId,
    required RequestStatus newStatus,
    required int userId,
  }) async {
    try {
      return await _client.request.updateRequestStatus(
        requestId,
        newStatus,
        userId,
      );
    } catch (e) {
      print('[RequestService] Error updating request status: $e');
      rethrow;
    }
  }

  /// Cancel a request
  Future<ServiceRequest?> cancelRequest({
    required int requestId,
    required int userId,
    required String reason,
  }) async {
    try {
      return await _client.request.cancelRequest(requestId, userId, reason);
    } catch (e) {
      print('[RequestService] Error cancelling request: $e');
      rethrow;
    }
  }

  /// Get request history for client
  Future<List<ServiceRequest>> getClientRequestHistory({
    required int clientId,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      return await _client.request.getClientRequestHistory(
        clientId,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      print('[RequestService] Error fetching client history: $e');
      return [];
    }
  }

  /// Get request history for driver
  Future<List<ServiceRequest>> getDriverRequestHistory({
    required int driverId,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      return await _client.request.getDriverRequestHistory(
        driverId,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      print('[RequestService] Error fetching driver history: $e');
      return [];
    }
  }
}
