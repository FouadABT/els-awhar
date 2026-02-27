import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/elasticsearch/elasticsearch.dart';
import 'dart:math' show sqrt, pi, atan2, cos, sin;

/// Store management endpoint
/// Handles store registration, profile, and browsing
/// All methods requiring userId take it as a parameter (decoded from token on client-side)
class StoreEndpoint extends Endpoint {
  // ==================== STORE CATEGORIES ====================

  /// Get all store categories
  Future<List<StoreCategory>> getStoreCategories(Session session) async {
    try {
      return await StoreCategory.db.find(
        session,
        where: (t) => t.isActive.equals(true),
        orderBy: (t) => t.displayOrder,
      );
    } catch (e) {
      session.log('Error getting store categories: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get store category by ID
  Future<StoreCategory?> getStoreCategoryById(
    Session session,
    int categoryId,
  ) async {
    try {
      return await StoreCategory.db.findById(session, categoryId);
    } catch (e) {
      session.log('Error getting store category: $e', level: LogLevel.error);
      return null;
    }
  }

  // ==================== STORE REGISTRATION ====================

  /// Create a new store (registration)
  Future<Store?> createStore(
    Session session, {
    required int userId,
    required int storeCategoryId,
    required String name,
    String? description,
    required String phone,
    String? email,
    required String address,
    required double latitude,
    required double longitude,
    String? city,
    double? deliveryRadiusKm,
  }) async {
    try {
      // Check if user already has a store
      final existingStore = await Store.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(userId),
      );

      if (existingStore != null) {
        throw Exception('User already has a store registered');
      }

      // Check if user exists
      final user = await User.db.findById(session, userId);
      if (user == null) {
        throw Exception('User not found');
      }

      // Verify category exists
      final category = await StoreCategory.db.findById(session, storeCategoryId);
      if (category == null) {
        throw Exception('Store category not found');
      }

      // Create the store
      final store = Store(
        userId: userId,
        storeCategoryId: storeCategoryId,
        name: name,
        description: description,
        phone: phone,
        email: email,
        address: address,
        latitude: latitude,
        longitude: longitude,
        city: city,
        deliveryRadiusKm: deliveryRadiusKm ?? 5.0,
        isActive: true,
        isOpen: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final createdStore = await Store.db.insertRow(session, store);
      
      // Sync to Elasticsearch
      await session.esSync.indexStore(createdStore);
      
      session.log('Store created: ${createdStore.id} for user $userId');
      return createdStore;
    } catch (e) {
      session.log('Error creating store: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Get the current user's store
  Future<Store?> getMyStore(Session session, {required int userId}) async {
    try {
      return await Store.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(userId),
      );
    } catch (e) {
      session.log('Error getting my store: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Get store by ID
  Future<Store?> getStoreById(Session session, int storeId) async {
    try {
      return await Store.db.findById(session, storeId);
    } catch (e) {
      session.log('Error getting store: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Get store by user ID
  Future<Store?> getStoreByUserId(Session session, int userId) async {
    try {
      return await Store.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(userId),
      );
    } catch (e) {
      session.log('Error getting store by user: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Update store profile
  Future<Store?> updateStore(
    Session session, {
    required int userId,
    required int storeId,
    String? name,
    String? description,
    String? phone,
    String? email,
    String? address,
    double? latitude,
    double? longitude,
    String? city,
    double? deliveryRadiusKm,
    double? minimumOrderAmount,
    int? estimatedPrepTimeMinutes,
  }) async {
    try {
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        throw Exception('Store not found');
      }

      // Verify ownership
      if (store.userId != userId) {
        throw Exception('Not authorized to update this store');
      }

      // Update fields
      final updatedStore = store.copyWith(
        name: name ?? store.name,
        description: description ?? store.description,
        phone: phone ?? store.phone,
        email: email ?? store.email,
        address: address ?? store.address,
        latitude: latitude ?? store.latitude,
        longitude: longitude ?? store.longitude,
        city: city ?? store.city,
        deliveryRadiusKm: deliveryRadiusKm ?? store.deliveryRadiusKm,
        minimumOrderAmount: minimumOrderAmount ?? store.minimumOrderAmount,
        estimatedPrepTimeMinutes: estimatedPrepTimeMinutes ?? store.estimatedPrepTimeMinutes,
        updatedAt: DateTime.now(),
      );

      final result = await Store.db.updateRow(session, updatedStore);
      
      // Sync to Elasticsearch
      await session.esSync.sync(result);
      
      return result;
    } catch (e) {
      session.log('Error updating store: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Update store logo
  Future<Store?> updateStoreLogo(
    Session session, {
    required int userId,
    required int storeId,
    required String logoUrl,
  }) async {
    try {
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        throw Exception('Store not found');
      }

      if (store.userId != userId) {
        throw Exception('Not authorized');
      }

      final updatedStore = store.copyWith(
        logoUrl: logoUrl,
        updatedAt: DateTime.now(),
      );

      final result = await Store.db.updateRow(session, updatedStore);
      
      // Sync to Elasticsearch
      await session.esSync.sync(result);
      
      return result;
    } catch (e) {
      session.log('Error updating store logo: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Update store cover image
  Future<Store?> updateStoreCoverImage(
    Session session, {
    required int userId,
    required int storeId,
    required String coverImageUrl,
  }) async {
    try {
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        throw Exception('Store not found');
      }

      if (store.userId != userId) {
        throw Exception('Not authorized');
      }

      final updatedStore = store.copyWith(
        coverImageUrl: coverImageUrl,
        updatedAt: DateTime.now(),
      );

      final result = await Store.db.updateRow(session, updatedStore);
      
      // Sync to Elasticsearch
      await session.esSync.sync(result);
      
      return result;
    } catch (e) {
      session.log('Error updating store cover: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Set working hours (JSON format)
  Future<Store?> setWorkingHours(
    Session session, {
    required int userId,
    required int storeId,
    required String workingHoursJson,
  }) async {
    try {
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        throw Exception('Store not found');
      }

      if (store.userId != userId) {
        throw Exception('Not authorized');
      }

      final updatedStore = store.copyWith(
        workingHours: workingHoursJson,
        updatedAt: DateTime.now(),
      );

      final result = await Store.db.updateRow(session, updatedStore);
      
      // Sync to Elasticsearch
      await session.esSync.sync(result);
      
      return result;
    } catch (e) {
      session.log('Error setting working hours: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Update store extended profile (about, tagline, social links)
  Future<Store?> updateStoreExtendedProfile(
    Session session, {
    required int userId,
    required int storeId,
    String? aboutText,
    String? tagline,
    String? whatsappNumber,
    String? websiteUrl,
    String? facebookUrl,
    String? instagramUrl,
    bool? acceptsCash,
    bool? acceptsCard,
    bool? hasDelivery,
    bool? hasPickup,
  }) async {
    try {
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        throw Exception('Store not found');
      }

      if (store.userId != userId) {
        throw Exception('Not authorized');
      }

      final updatedStore = store.copyWith(
        aboutText: aboutText ?? store.aboutText,
        tagline: tagline ?? store.tagline,
        whatsappNumber: whatsappNumber ?? store.whatsappNumber,
        websiteUrl: websiteUrl ?? store.websiteUrl,
        facebookUrl: facebookUrl ?? store.facebookUrl,
        instagramUrl: instagramUrl ?? store.instagramUrl,
        acceptsCash: acceptsCash ?? store.acceptsCash,
        acceptsCard: acceptsCard ?? store.acceptsCard,
        hasDelivery: hasDelivery ?? store.hasDelivery,
        hasPickup: hasPickup ?? store.hasPickup,
        updatedAt: DateTime.now(),
      );

      final result = await Store.db.updateRow(session, updatedStore);
      
      // Sync to Elasticsearch
      await session.esSync.sync(result);
      
      return result;
    } catch (e) {
      session.log('Error updating store extended profile: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Update store gallery images
  Future<Store?> updateStoreGallery(
    Session session, {
    required int userId,
    required int storeId,
    required List<String> imageUrls,
  }) async {
    try {
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        throw Exception('Store not found');
      }

      if (store.userId != userId) {
        throw Exception('Not authorized');
      }

      // Convert list to JSON string
      final galleryJson = jsonEncode(imageUrls);

      final updatedStore = store.copyWith(
        galleryImages: galleryJson,
        updatedAt: DateTime.now(),
      );

      final result = await Store.db.updateRow(session, updatedStore);
      
      // Sync to Elasticsearch
      await session.esSync.sync(result);
      
      return result;
    } catch (e) {
      session.log('Error updating store gallery: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Add image to store gallery
  Future<Store?> addGalleryImage(
    Session session, {
    required int userId,
    required int storeId,
    required String imageUrl,
  }) async {
    try {
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        throw Exception('Store not found');
      }

      if (store.userId != userId) {
        throw Exception('Not authorized');
      }

      // Parse existing gallery or create new list
      List<String> images = [];
      if (store.galleryImages != null && store.galleryImages!.isNotEmpty) {
        try {
          images = List<String>.from(jsonDecode(store.galleryImages!));
        } catch (_) {
          images = [];
        }
      }

      // Add new image (max 10 images)
      if (images.length >= 10) {
        throw Exception('Maximum 10 gallery images allowed');
      }
      images.add(imageUrl);

      final updatedStore = store.copyWith(
        galleryImages: jsonEncode(images),
        updatedAt: DateTime.now(),
      );

      final result = await Store.db.updateRow(session, updatedStore);
      
      // Sync to Elasticsearch
      await session.esSync.sync(result);
      
      return result;
    } catch (e) {
      session.log('Error adding gallery image: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Remove image from store gallery
  Future<Store?> removeGalleryImage(
    Session session, {
    required int userId,
    required int storeId,
    required String imageUrl,
  }) async {
    try {
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        throw Exception('Store not found');
      }

      if (store.userId != userId) {
        throw Exception('Not authorized');
      }

      // Parse existing gallery
      List<String> images = [];
      if (store.galleryImages != null && store.galleryImages!.isNotEmpty) {
        try {
          images = List<String>.from(jsonDecode(store.galleryImages!));
        } catch (_) {
          images = [];
        }
      }

      // Remove image
      images.remove(imageUrl);

      final updatedStore = store.copyWith(
        galleryImages: jsonEncode(images),
        updatedAt: DateTime.now(),
      );

      final result = await Store.db.updateRow(session, updatedStore);
      
      // Sync to Elasticsearch
      await session.esSync.sync(result);
      
      return result;
    } catch (e) {
      session.log('Error removing gallery image: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Toggle store open/closed status
  Future<Store?> toggleStoreOpen(
    Session session, {
    required int userId,
    required int storeId,
    required bool isOpen,
  }) async {
    try {
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        throw Exception('Store not found');
      }

      if (store.userId != userId) {
        throw Exception('Not authorized');
      }

      final updatedStore = store.copyWith(
        isOpen: isOpen,
        updatedAt: DateTime.now(),
      );

      final result = await Store.db.updateRow(session, updatedStore);
      
      // Sync to Elasticsearch
      await session.esSync.sync(result);
      
      return result;
    } catch (e) {
      session.log('Error toggling store status: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Toggle store active/inactive (for admin or owner)
  Future<Store?> toggleStoreActive(
    Session session, {
    required int userId,
    required int storeId,
    required bool isActive,
  }) async {
    try {
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        throw Exception('Store not found');
      }

      if (store.userId != userId) {
        throw Exception('Not authorized');
      }

      final updatedStore = store.copyWith(
        isActive: isActive,
        isOpen: isActive ? store.isOpen : false, // Close if deactivating
        updatedAt: DateTime.now(),
      );

      final result = await Store.db.updateRow(session, updatedStore);
      
      // Sync to Elasticsearch
      await session.esSync.sync(result);
      
      return result;
    } catch (e) {
      session.log('Error toggling store active: $e', level: LogLevel.error);
      rethrow;
    }
  }

  // ==================== STORE BROWSING (FOR CLIENTS) ====================

  /// Get nearby stores
  Future<List<Store>> getNearbyStores(
    Session session, {
    required double latitude,
    required double longitude,
    double? radiusKm,
    int? categoryId,
    bool openOnly = false,
  }) async {
    try {
      final maxRadius = radiusKm ?? 10.0;

      // Get all active stores
      List<Store> stores;
      if (categoryId != null) {
        stores = await Store.db.find(
          session,
          where: (t) => t.isActive.equals(true) & t.storeCategoryId.equals(categoryId),
        );
      } else {
        stores = await Store.db.find(
          session,
          where: (t) => t.isActive.equals(true),
        );
      }

      session.log('Found ${stores.length} active stores, categoryId=$categoryId', level: LogLevel.debug);

      // Filter by open status if requested
      if (openOnly) {
        stores = stores.where((s) => s.isOpen).toList();
      }

      // Filter by distance and calculate distance for sorting
      final List<MapEntry<Store, double>> storesWithDistance = [];

      for (final store in stores) {
        // Skip stores with invalid coordinates
        if (store.latitude == 0 || store.longitude == 0) {
          session.log('Skipping store ${store.id} with invalid coordinates', level: LogLevel.debug);
          continue;
        }

        final distance = _calculateDistance(
          latitude,
          longitude,
          store.latitude,
          store.longitude,
        );

        session.log('Store ${store.id} distance: ${distance.toStringAsFixed(2)}km, delivery radius: ${store.deliveryRadiusKm}km', level: LogLevel.debug);

        // Check if client is within search radius OR within store's delivery radius
        if (distance <= maxRadius || distance <= store.deliveryRadiusKm) {
          storesWithDistance.add(MapEntry(store, distance));
        }
      }

      session.log('Returning ${storesWithDistance.length} stores after distance filtering', level: LogLevel.debug);

      // Sort by distance (nearest first)
      storesWithDistance.sort((a, b) => a.value.compareTo(b.value));

      return storesWithDistance.map((e) => e.key).toList();
    } catch (e) {
      session.log('Error getting nearby stores: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get stores by category
  Future<List<Store>> getStoresByCategory(
    Session session, {
    required int categoryId,
    double? latitude,
    double? longitude,
    bool openOnly = false,
  }) async {
    try {
      var stores = await Store.db.find(
        session,
        where: (t) => t.isActive.equals(true) & t.storeCategoryId.equals(categoryId),
      );

      if (openOnly) {
        stores = stores.where((s) => s.isOpen).toList();
      }

      // Sort by rating (highest first)
      stores.sort((a, b) => b.rating.compareTo(a.rating));

      return stores;
    } catch (e) {
      session.log('Error getting stores by category: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Search stores by name
  Future<List<Store>> searchStores(
    Session session, {
    required String query,
    double? latitude,
    double? longitude,
    int? categoryId,
  }) async {
    try {
      final queryLower = query.toLowerCase();

      var stores = await Store.db.find(
        session,
        where: (t) => t.isActive.equals(true),
      );

      // Filter by name match
      stores = stores.where((s) => 
        s.name.toLowerCase().contains(queryLower) ||
        (s.description?.toLowerCase().contains(queryLower) ?? false)
      ).toList();

      // Filter by category if specified
      if (categoryId != null) {
        stores = stores.where((s) => s.storeCategoryId == categoryId).toList();
      }

      return stores;
    } catch (e) {
      session.log('Error searching stores: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Check if client location is within store's delivery zone
  Future<bool> isWithinDeliveryZone(
    Session session, {
    required int storeId,
    required double clientLatitude,
    required double clientLongitude,
  }) async {
    try {
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        session.log('Store $storeId not found', level: LogLevel.error);
        return false;
      }

      // Skip validation if store has invalid coordinates
      if (store.latitude == 0 || store.longitude == 0) {
        session.log('Store $storeId has invalid coordinates, allowing delivery', level: LogLevel.warning);
        return true;
      }

      final distance = _calculateDistance(
        store.latitude,
        store.longitude,
        clientLatitude,
        clientLongitude,
      );

      final isInZone = distance <= store.deliveryRadiusKm;
      session.log('Store $storeId: distance=${distance.toStringAsFixed(2)}km, radius=${store.deliveryRadiusKm}km, inZone=$isInZone', level: LogLevel.debug);

      return isInZone;
    } catch (e) {
      session.log('Error checking delivery zone: $e', level: LogLevel.error);
      return false;
    }
  }

  // ==================== HELPER METHODS ====================

  /// Calculate distance between two coordinates (Haversine formula)
  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const earthRadius = 6371.0; // km

    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
        sin(dLon / 2) * sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double _toRadians(double degrees) {
    return degrees * pi / 180;
  }
}
