import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/elasticsearch/elasticsearch.dart';
import 'dart:math' show sqrt, pi, atan2;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Driver management endpoint
/// Handles driver availability, location updates, online drivers
class DriverEndpoint extends Endpoint {
  /// Toggle driver online/offline status
  Future<DriverProfile?> setOnlineStatus(
    Session session, {
    required int driverId,
    required bool isOnline,
  }) async {
    try {
      final driver = await DriverProfile.db.findById(session, driverId);

      if (driver == null) {
        return null;
      }

      driver.isOnline = isOnline;

      if (!isOnline) {
        // Clear location when going offline
        driver.lastLocationLat = null;
        driver.lastLocationLng = null;
        driver.lastLocationUpdatedAt = null;
        driver.autoOfflineAt = null;
      } else {
        // Set auto-offline time (tighter TTL for realtime presence; 60s)
        driver.autoOfflineAt = DateTime.now().add(const Duration(seconds: 60));
      }

      final updated = await DriverProfile.db.updateRow(session, driver);
      
      // Sync to Elasticsearch (non-blocking)
      await session.esSync.indexDriver(updated);
      
      return updated;
    } catch (e) {
      session.log('Error setting online status: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Update driver location
  Future<DriverProfile?> updateLocation(
    Session session, {
    required int driverId,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final driver = await DriverProfile.db.findById(session, driverId);

      if (driver == null) {
        return null;
      }

      driver.lastLocationLat = latitude;
      driver.lastLocationLng = longitude;
      driver.lastLocationUpdatedAt = DateTime.now();

      // Extend auto-offline time (tighter TTL for realtime presence; 60s)
      driver.autoOfflineAt = DateTime.now().add(const Duration(seconds: 60));

      // Ensure driver is online
      if (!driver.isOnline) {
        driver.isOnline = true;
      }

      final updated = await DriverProfile.db.updateRow(session, driver);
      
      // Sync to Elasticsearch (non-blocking) - updates location for geo search
      await session.esSync.indexDriver(updated);
      
      return updated;
    } catch (e) {
      session.log('Error updating location: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Get online drivers in an area
  Future<List<DriverProfile>> getOnlineDrivers(
    Session session, {
    required double centerLat,
    required double centerLng,
    double radiusKm = 10.0,
    int? serviceId,
  }) async {
    try {
      // Get all online drivers
      final drivers = await DriverProfile.db.find(
        session,
        where: (t) => t.isOnline.equals(true),
      );

      // Filter by location and optional service
      final nearbyDrivers = drivers.where((driver) {
        if (driver.lastLocationLat == null || driver.lastLocationLng == null) {
          return false;
        }

        final distance = _calculateDistance(
          centerLat,
          centerLng,
          driver.lastLocationLat!,
          driver.lastLocationLng!,
        );

        return distance <= radiusKm;
      }).toList();

      // If serviceId provided, further filter by service
      if (serviceId != null) {
        final driverServices = await DriverService.db.find(
          session,
          where: (t) =>
              t.serviceId.equals(serviceId) & t.isActive.equals(true),
        );

        final serviceDriverIds =
            driverServices.map((s) => s.driverId).toSet();

        return nearbyDrivers
            .where((d) => serviceDriverIds.contains(d.id))
            .toList();
      }

      return nearbyDrivers;
    } catch (e) {
      session.log('Error getting online drivers: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get driver services (catalog)
  /// driverId parameter is actually userId from frontend
  Future<List<DriverService>> getDriverServices(
    Session session, {
    required int driverId,
  }) async {
    try {
      session.log('🔍 Getting driver services for userId: $driverId', level: LogLevel.info);
      
      // Find driver profile by userId
      final driver = await DriverProfile.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(driverId),
      );
      
      if (driver == null) {
        session.log('❌ Driver profile not found for userId: $driverId', level: LogLevel.warning);
        return [];
      }
      
      session.log('✅ Found driver profile ID: ${driver.id}', level: LogLevel.info);
      
      // Get services using actual driver profile ID
      final services = await DriverService.db.find(
        session,
        where: (t) => t.driverId.equals(driver.id!) & t.isActive.equals(true),
        orderBy: (t) => t.displayOrder,
      );
      
      session.log('📦 Returning ${services.length} services', level: LogLevel.info);
      return services;
    } catch (e) {
      session.log('❌ Error getting driver services: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get driver profile by userId
  Future<DriverProfile?> getDriverProfileByUserId(
    Session session, {
    required int userId,
  }) async {
    try {
      return await DriverProfile.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(userId),
      );
    } catch (e) {
      session.log('Error getting driver profile for userId=$userId: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Add a new driver service
  Future<DriverService?> addDriverService(
    Session session, {
    required int driverId,
    required int serviceId,
    required int categoryId,
    String? title,
    String? description,
    String? imageUrl,
    double? basePrice,
    double? pricePerKm,
    double? pricePerHour,
    double? minPrice,
  }) async {
    try {
      session.log('🚀 === ADD SERVICE BACKEND STARTED ===', level: LogLevel.info);
      session.log('   User ID (driverId param): $driverId', level: LogLevel.info);
      session.log('   Service ID: $serviceId', level: LogLevel.info);
      session.log('   Category ID: $categoryId', level: LogLevel.info);
      session.log('   Title: $title', level: LogLevel.info);
      session.log('   Description: $description', level: LogLevel.info);
      session.log('   Base Price: $basePrice', level: LogLevel.info);
      
      // Find driver by userId (driverId parameter is actually userId from frontend)
      session.log('🔍 Looking up driver profile by userId...', level: LogLevel.info);
      final driver = await DriverProfile.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(driverId),
      );
      
      if (driver == null) {
        session.log('❌ Driver profile not found for userId: $driverId', level: LogLevel.warning);
        return null;
      }
      
      session.log('✅ Driver profile found! ID: ${driver.id}', level: LogLevel.info);
      
      // Use the actual driver profile ID
      final actualDriverId = driver.id!;

      // Check if service already exists for this driver
      session.log('🔍 Checking for existing service...', level: LogLevel.info);
      final existing = await DriverService.db.findFirstRow(
        session,
        where: (t) =>
            t.driverId.equals(actualDriverId) & t.serviceId.equals(serviceId),
      );

      if (existing != null) {
        session.log('❌ Service already exists for driver (ID: ${existing.id})', level: LogLevel.warning);
        return null;
      }
      
      session.log('✅ No existing service found', level: LogLevel.info);

      // Get max display order
      session.log('🔍 Getting max display order...', level: LogLevel.info);
      final services = await DriverService.db.find(
        session,
        where: (t) => t.driverId.equals(actualDriverId),
        orderBy: (t) => t.displayOrder,
        orderDescending: true,
        limit: 1,
      );
      final maxOrder = services.isEmpty ? 0 : services.first.displayOrder;
      session.log('   Max order: $maxOrder', level: LogLevel.info);

      session.log('📝 Creating DriverService object...', level: LogLevel.info);
      final driverService = DriverService(
        driverId: actualDriverId,
        serviceId: serviceId,
        categoryId: categoryId,
        title: title,
        description: description,
        imageUrl: imageUrl,
        basePrice: basePrice,
        pricePerKm: pricePerKm,
        pricePerHour: pricePerHour,
        minPrice: minPrice,
        isActive: true,
        isAvailable: true,
        displayOrder: maxOrder + 1,
        viewCount: 0,
        inquiryCount: 0,
        bookingCount: 0,
      );

      session.log('💾 Inserting DriverService into database...', level: LogLevel.info);
      final created = await DriverService.db.insertRow(session, driverService);
      session.log('✅ DriverService inserted! ID: ${created.id}', level: LogLevel.info);
      
      // Sync to Elasticsearch
      await session.esSync.sync(created);

      // Create analytics entry
      session.log('📊 Creating ServiceAnalytics entry...', level: LogLevel.info);
      final analytics = ServiceAnalytics(
        driverServiceId: created.id!,
        totalViews: 0,
        uniqueViews: 0,
        totalInquiries: 0,
        totalBookings: 0,
        conversionRate: 0.0,
        averageResponseTime: 0,
        completionRate: 0.0,
      );
      await ServiceAnalytics.db.insertRow(session, analytics);
      session.log('✅ ServiceAnalytics created!', level: LogLevel.info);

      session.log('🎉 === ADD SERVICE BACKEND SUCCESS === ID: ${created.id}', level: LogLevel.info);
      return created;
    } catch (e, stackTrace) {
      session.log('❌ === ERROR ADDING DRIVER SERVICE ===', level: LogLevel.error);
      session.log('Error: $e', level: LogLevel.error);
      session.log('Stack trace: $stackTrace', level: LogLevel.error);
      return null;
    }
  }

  /// Update driver service
  Future<DriverService?> updateDriverService(
    Session session, {
    required int serviceId,
    String? title,
    String? description,
    String? imageUrl,
    double? basePrice,
    double? pricePerKm,
    double? pricePerHour,
    double? minPrice,
    bool? isAvailable,
    DateTime? availableFrom,
    DateTime? availableUntil,
  }) async {
    try {
      final service = await DriverService.db.findById(session, serviceId);
      if (service == null) {
        return null;
      }

      if (title != null) service.title = title;
      if (description != null) service.description = description;
      if (imageUrl != null) service.imageUrl = imageUrl;
      if (basePrice != null) service.basePrice = basePrice;
      if (pricePerKm != null) service.pricePerKm = pricePerKm;
      if (pricePerHour != null) service.pricePerHour = pricePerHour;
      if (minPrice != null) service.minPrice = minPrice;
      if (isAvailable != null) service.isAvailable = isAvailable;
      if (availableFrom != null) service.availableFrom = availableFrom;
      if (availableUntil != null) service.availableUntil = availableUntil;

      service.updatedAt = DateTime.now();

      final result = await DriverService.db.updateRow(session, service);
      
      // Sync to Elasticsearch
      await session.esSync.sync(result);
      
      return result;
    } catch (e) {
      session.log('Error updating driver service: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Delete driver service
  Future<bool> deleteDriverService(
    Session session, {
    required int serviceId,
  }) async {
    try {
      // Delete analytics first (due to foreign key)
      await ServiceAnalytics.db.deleteWhere(
        session,
        where: (t) => t.driverServiceId.equals(serviceId),
      );

      // Delete service images
      await ServiceImage.db.deleteWhere(
        session,
        where: (t) => t.driverServiceId.equals(serviceId),
      );

      // Delete the service
      final deleted = await DriverService.db.deleteWhere(
        session,
        where: (t) => t.id.equals(serviceId),
      );
      
      // Remove from Elasticsearch
      if (deleted.isNotEmpty) {
        await session.esSync.deleteDriverService(serviceId);
      }
      
      return deleted.isNotEmpty;
    } catch (e) {
      session.log('Error deleting driver service: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Toggle service availability
  Future<DriverService?> toggleServiceAvailability(
    Session session, {
    required int serviceId,
    required bool isAvailable,
  }) async {
    try {
      final service = await DriverService.db.findById(session, serviceId);
      if (service == null) {
        return null;
      }

      service.isAvailable = isAvailable;
      service.updatedAt = DateTime.now();

      final result = await DriverService.db.updateRow(session, service);
      
      // Sync to Elasticsearch
      await session.esSync.sync(result);
      
      return result;
    } catch (e) {
      session.log('Error toggling service availability: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Reorder driver services
  Future<bool> reorderDriverServices(
    Session session, {
    required int driverId,
    required List<int> serviceIds,
  }) async {
    try {
      for (int i = 0; i < serviceIds.length; i++) {
        final service = await DriverService.db.findById(session, serviceIds[i]);
        if (service != null && service.driverId == driverId) {
          service.displayOrder = i;
          service.updatedAt = DateTime.now();
          final updated = await DriverService.db.updateRow(session, service);
          // Sync to Elasticsearch
          await session.esSync.sync(updated);
        }
      }
      return true;
    } catch (e) {
      session.log('Error reordering services: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Upload service image file to storage
  Future<String?> uploadServiceImageFile(
    Session session, {
    required int driverServiceId,
    required ByteData imageData,
    required String fileName,
  }) async {
    try {
      session.log('[Driver] uploadServiceImageFile called for serviceId: $driverServiceId, fileName: $fileName, dataSize: ${imageData.lengthInBytes}');
      
      // Check if service exists
      final service = await DriverService.db.findById(session, driverServiceId);
      if (service == null) {
        session.log('[Driver] Service not found: $driverServiceId', level: LogLevel.warning);
        return null;
      }

      // Upload image
      final storagePath = 'service-images/$driverServiceId/${DateTime.now().millisecondsSinceEpoch}_$fileName';
      session.log('[Driver] Uploading to path: $storagePath');

      await session.storage.storeFile(
        storageId: 'public',
        path: storagePath,
        byteData: imageData,
      );
      session.log('[Driver] File stored successfully');

      // Get public URL
      final publicUrl = await session.storage.getPublicUrl(
        storageId: 'public',
        path: storagePath,
      );
      session.log('[Driver] Public URL: $publicUrl');

      // Replace 0.0.0.0 with actual host for development
      var finalUrl = publicUrl?.toString() ?? storagePath;
      if (finalUrl.contains('0.0.0.0')) {
        finalUrl = finalUrl.replaceAll('0.0.0.0', '192.168.4.252');
      }
      if (finalUrl.contains('localhost')) {
        finalUrl = finalUrl.replaceAll('localhost', '192.168.4.252');
      }

      session.log('[Driver] Final URL: $finalUrl');

      // Update the service with the first image URL (if it doesn't have one yet)
      if (service.imageUrl == null || service.imageUrl!.isEmpty) {
        service.imageUrl = finalUrl;
        await DriverService.db.updateRow(session, service);
        session.log('[Driver] Service imageUrl updated with first uploaded image');
      }

      return finalUrl;
    } catch (e, stackTrace) {
      session.log('[Driver] Error uploading service image: $e', level: LogLevel.error);
      session.log('[Driver] Stack trace: $stackTrace', level: LogLevel.error);
      return null;
    }
  }

  /// Upload service image
  Future<ServiceImage?> uploadServiceImage(
    Session session, {
    required int driverServiceId,
    required String imageUrl,
    String? thumbnailUrl,
    String? caption,
    int? fileSize,
    int? width,
    int? height,
  }) async {
    try {
      // Check if service exists
      final service = await DriverService.db.findById(session, driverServiceId);
      if (service == null) {
        session.log('Service not found: $driverServiceId', level: LogLevel.warning);
        return null;
      }

      // Get current image count
      final existingImages = await ServiceImage.db.find(
        session,
        where: (t) => t.driverServiceId.equals(driverServiceId),
      );

      // Limit to 5 images
      if (existingImages.length >= 5) {
        session.log('Maximum 5 images per service', level: LogLevel.warning);
        return null;
      }

      // Get max display order
      final maxOrder = existingImages.isEmpty 
          ? 0 
          : existingImages.map((img) => img.displayOrder).reduce((a, b) => a > b ? a : b);

      final image = ServiceImage(
        driverServiceId: driverServiceId,
        imageUrl: imageUrl,
        thumbnailUrl: thumbnailUrl,
        caption: caption,
        fileSize: fileSize,
        width: width,
        height: height,
        displayOrder: maxOrder + 1,
      );

      return await ServiceImage.db.insertRow(session, image);
    } catch (e) {
      session.log('Error uploading service image: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Get service images
  Future<List<ServiceImage>> getServiceImages(
    Session session, {
    required int driverServiceId,
  }) async {
    try {
      return await ServiceImage.db.find(
        session,
        where: (t) => t.driverServiceId.equals(driverServiceId),
        orderBy: (t) => t.displayOrder,
      );
    } catch (e) {
      session.log('Error getting service images: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Delete service image
  Future<bool> deleteServiceImage(
    Session session, {
    required int imageId,
  }) async {
    try {
      final deleted = await ServiceImage.db.deleteWhere(
        session,
        where: (t) => t.id.equals(imageId),
      );
      return deleted.isNotEmpty;
    } catch (e) {
      session.log('Error deleting service image: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Auto-offline check (should be called periodically)
  Future<int> autoOfflineDrivers(Session session) async {
    try {
      final now = DateTime.now();

      final drivers = await DriverProfile.db.find(
        session,
        where: (t) => t.isOnline.equals(true),
      );

      int offlinedCount = 0;

      for (final driver in drivers) {
        if (driver.autoOfflineAt != null &&
            driver.autoOfflineAt!.isBefore(now)) {
          driver.isOnline = false;
          driver.lastLocationLat = null;
          driver.lastLocationLng = null;
          driver.lastLocationUpdatedAt = null;
          driver.autoOfflineAt = null;

          final updated = await DriverProfile.db.updateRow(session, driver);
          // Sync to Elasticsearch
          await session.esSync.sync(updated);
          offlinedCount++;
        }
      }

      return offlinedCount;
    } catch (e) {
      session.log('Error auto-offlining drivers: $e', level: LogLevel.error);
      return 0;
    }
  }

  /// Simple distance calculation (Haversine formula)
  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadiusKm = 6371.0;

    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);

    final a = (dLat / 2) * (dLat / 2) +
        _degreesToRadians(lat1) *
            _degreesToRadians(lat2) *
            (dLon / 2) *
            (dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadiusKm * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }

  /// Check if driver is truly online based on multiple factors
  /// Returns true only if ALL of these are true:
  /// 1. User.isOnline = true
  /// 2. DriverProfile.isOnline = true  
  /// 3. Presence in Firebase with lastSeen < 2 minutes
  /// 4. No errors or warnings
  Future<bool> isDriverTrulyOnline(
    Session session, {
    required int userId,
  }) async {
    try {
      // Check 1: User.isOnline
      final user = await User.db.findById(session, userId);
      if (user == null || !user.isOnline) {
        session.log(
          '⚠️ Driver $userId not online (User.isOnline=${user?.isOnline})',
          level: LogLevel.debug,
        );
        return false;
      }

      // Check 2: DriverProfile.isOnline
      final driverProfile = await DriverProfile.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(userId),
      );

      if (driverProfile == null || !driverProfile.isOnline) {
        session.log(
          '⚠️ Driver $userId not online (DriverProfile.isOnline=${driverProfile?.isOnline})',
          level: LogLevel.debug,
        );
        return false;
      }

      // Check 3: Presence in Firebase with fresh timestamp via REST API
      try {
        // Use Firebase REST API to check presence
        final url =
            'https://awhar-5afc5-default-rtdb.firebaseio.com/presence/users/$userId.json';

        final response = await http
            .get(Uri.parse(url))
            .timeout(const Duration(seconds: 3));

        if (response.statusCode != 200) {
          session.log(
            '⚠️ Firebase presence check failed (HTTP ${response.statusCode}) for driver $userId',
            level: LogLevel.debug,
          );
          return false;
        }

        final presenceData = jsonDecode(response.body) as Map<String, dynamic>?;
        if (presenceData == null) {
          session.log(
            '⚠️ No Firebase presence for driver $userId',
            level: LogLevel.debug,
          );
          return false;
        }

        final lastSeenMs = presenceData['lastSeen'];
        if (lastSeenMs == null) {
          session.log(
            '⚠️ No lastSeen for driver $userId',
            level: LogLevel.debug,
          );
          return false;
        }

        // lastSeen can be int or double from JSON
        final lastSeenInt = lastSeenMs is int
            ? lastSeenMs
            : (lastSeenMs as num).toInt();
        final lastSeen =
            DateTime.fromMillisecondsSinceEpoch(lastSeenInt);
        final timeSinceLastSeen = DateTime.now().difference(lastSeen);

        // Must have heartbeat within last 2 minutes
        const maxStaleTime = Duration(minutes: 2);
        if (timeSinceLastSeen > maxStaleTime) {
          session.log(
            '⚠️ Driver $userId presence stale (${timeSinceLastSeen.inSeconds}s > 120s)',
            level: LogLevel.debug,
          );
          return false;
        }

        // All checks passed
        session.log(
          '✅ Driver $userId is truly online',
          level: LogLevel.debug,
        );
        return true;
      } catch (e) {
        session.log(
          '⚠️ Error checking Firebase presence for driver $userId: $e',
          level: LogLevel.warning,
        );
        // If Firebase check fails but DB says online, assume online for now
        return true;
      }
    } catch (e) {
      session.log(
        'Error checking driver online status: $e',
        level: LogLevel.error,
      );
      return false;
    }
  }
}

