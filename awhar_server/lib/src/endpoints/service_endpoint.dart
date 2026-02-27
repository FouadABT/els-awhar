import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'dart:math' show sqrt, pi, atan2;

/// Service management endpoint
/// Handles service categories, driver catalog browsing
class ServiceEndpoint extends Endpoint {
  /// Get all service categories
  Future<List<ServiceCategory>> getCategories(
    Session session, {
    bool activeOnly = true,
  }) async {
    try {
      if (activeOnly) {
        return await ServiceCategory.db.find(
          session,
          where: (t) => t.isActive.equals(true),
          orderBy: (t) => t.displayOrder,
        );
      }

      return await ServiceCategory.db.find(
        session,
        orderBy: (t) => t.displayOrder,
      );
    } catch (e) {
      session.log('Error getting categories: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get all services by category
  Future<List<Service>> getServicesByCategory(
    Session session, {
    required int categoryId,
    bool activeOnly = true,
  }) async {
    try {
      if (activeOnly) {
        return await Service.db.find(
          session,
          where: (t) => t.categoryId.equals(categoryId) & t.isActive.equals(true),
          orderBy: (t) => t.displayOrder,
        );
      }

      return await Service.db.find(
        session,
        where: (t) => t.categoryId.equals(categoryId),
        orderBy: (t) => t.displayOrder,
      );
    } catch (e) {
      session.log('Error getting services by category: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get drivers offering a specific service category
  Future<List<DriverProfile>> getDriversByCategory(
    Session session, {
    required int categoryId,
    double? clientLat,
    double? clientLng,
    double? radiusKm,
    bool onlineOnly = false,
  }) async {
    try {
      // Get all driver services for this category
      final driverServices = await DriverService.db.find(
        session,
        where: (t) => t.categoryId.equals(categoryId) & t.isActive.equals(true),
        orderBy: (t) => t.displayOrder,
      );

      final driverIds = driverServices.map((s) => s.driverId).toSet().toList();

      if (driverIds.isEmpty) {
        return [];
      }

      // Get driver profiles
      List<DriverProfile> drivers = [];

      for (final driverId in driverIds) {
        final driver = await DriverProfile.db.findById(session, driverId);
        if (driver != null) {
          // Filter by online status if requested
          if (onlineOnly && !driver.isOnline) {
            continue;
          }

          drivers.add(driver);
        }
      }

      // Filter by distance if coordinates provided
      if (clientLat != null && clientLng != null && radiusKm != null) {
        drivers = drivers.where((driver) {
          if (driver.lastLocationLat == null ||
              driver.lastLocationLng == null) {
            return false;
          }

          final distance = _calculateDistance(
            clientLat,
            clientLng,
            driver.lastLocationLat!,
            driver.lastLocationLng!,
          );

          return distance <= radiusKm;
        }).toList();
      }

      // Sort by rating
      drivers.sort((a, b) => b.ratingAverage.compareTo(a.ratingAverage));

      return drivers;
    } catch (e) {
      session.log('Error getting drivers by category: $e',
          level: LogLevel.error);
      return [];
    }
  }

  /// Get drivers offering a specific service
  Future<List<DriverProfile>> getDriversByService(
    Session session, {
    required int serviceId,
    double? clientLat,
    double? clientLng,
    double? radiusKm,
    bool onlineOnly = false,
  }) async {
    try {
      // Get all driver services for this service
      final driverServices = await DriverService.db.find(
        session,
        where: (t) => t.serviceId.equals(serviceId) & t.isActive.equals(true),
        orderBy: (t) => t.displayOrder,
      );

      final driverIds = driverServices.map((s) => s.driverId).toSet().toList();

      if (driverIds.isEmpty) {
        return [];
      }

      // Get driver profiles
      List<DriverProfile> drivers = [];

      for (final driverId in driverIds) {
        final driver = await DriverProfile.db.findById(session, driverId);
        if (driver != null) {
          // Filter by online status if requested
          if (onlineOnly && !driver.isOnline) {
            continue;
          }

          drivers.add(driver);
        }
      }

      // Filter by distance if coordinates provided
      if (clientLat != null && clientLng != null && radiusKm != null) {
        drivers = drivers.where((driver) {
          if (driver.lastLocationLat == null ||
              driver.lastLocationLng == null) {
            return false;
          }

          final distance = _calculateDistance(
            clientLat,
            clientLng,
            driver.lastLocationLat!,
            driver.lastLocationLng!,
          );

          return distance <= radiusKm;
        }).toList();
      }

      // Sort by rating
      drivers.sort((a, b) => b.ratingAverage.compareTo(a.ratingAverage));

      return drivers;
    } catch (e) {
      session.log('Error getting drivers by service: $e',
          level: LogLevel.error);
      return [];
    }
  }

  /// Create a service category (admin only)
  Future<ServiceCategory?> createCategory(
    Session session, {
    required String name,
    required String nameAr,
    required String nameFr,
    String? nameEs,
    required String icon,
    String? description,
    int displayOrder = 0,
    double defaultRadiusKm = 10.0,
  }) async {
    try {
      final category = ServiceCategory(
        name: name,
        nameAr: nameAr,
        nameFr: nameFr,
        nameEs: nameEs,
        icon: icon,
        description: description,
        displayOrder: displayOrder,
        defaultRadiusKm: defaultRadiusKm,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      return await ServiceCategory.db.insertRow(session, category);
    } catch (e) {
      session.log('Error creating category: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Update a service category (admin only)
  Future<ServiceCategory?> updateCategory(
    Session session, {
    required int categoryId,
    String? name,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? icon,
    String? description,
    int? displayOrder,
    double? defaultRadiusKm,
    bool? isActive,
  }) async {
    try {
      final category = await ServiceCategory.db.findById(session, categoryId);

      if (category == null) {
        return null;
      }

      if (name != null) category.name = name;
      if (nameAr != null) category.nameAr = nameAr;
      if (nameFr != null) category.nameFr = nameFr;
      if (nameEs != null) category.nameEs = nameEs;
      if (icon != null) category.icon = icon;
      if (description != null) category.description = description;
      if (displayOrder != null) category.displayOrder = displayOrder;
      if (defaultRadiusKm != null) category.defaultRadiusKm = defaultRadiusKm;
      if (isActive != null) category.isActive = isActive;

      category.updatedAt = DateTime.now();

      return await ServiceCategory.db.updateRow(session, category);
    } catch (e) {
      session.log('Error updating category: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Advanced search for drivers with services and filters
  Future<List<DriverProfile>> searchDriversWithServices(
    Session session, {
    int? categoryId,
    int? serviceId,
    required double clientLat,
    required double clientLng,
    double radiusKm = 10.0,
    double? priceMin,
    double? priceMax,
    double? minRating,
    bool onlineOnly = false,
    int limit = 50,
  }) async {
    try {
      session.log('SearchDrivers start: categoryId=$categoryId, serviceId=$serviceId, client=($clientLat,$clientLng), radiusKm=$radiusKm, priceMin=$priceMin, priceMax=$priceMax, minRating=$minRating, onlineOnly=$onlineOnly, limit=$limit');
      // Build query for driver services
      var query = DriverService.db.find(
        session,
        where: (t) => t.isActive.equals(true) & t.isAvailable.equals(true),
      );

      final driverServices = await query;

      // Filter by category or service
      var filteredServices = driverServices;
      if (categoryId != null) {
        filteredServices = filteredServices
            .where((s) => s.categoryId == categoryId)
            .toList();
      }
      if (serviceId != null) {
        filteredServices = filteredServices
            .where((s) => s.serviceId == serviceId)
            .toList();
      }

      // Filter by price range
      if (priceMin != null || priceMax != null) {
        filteredServices = filteredServices.where((s) {
          final price = s.basePrice ?? s.minPrice ?? 0.0;
          if (priceMin != null && price < priceMin) return false;
          if (priceMax != null && price > priceMax) return false;
          return true;
        }).toList();
      }

      final driverIds = filteredServices.map((s) => s.driverId).toSet().toList();

      if (driverIds.isEmpty) {
        return [];
      }

      // Get driver profiles
      List<DriverProfile> drivers = [];

      for (final driverId in driverIds) {
        final driver = await DriverProfile.db.findById(session, driverId);
        if (driver == null) continue;

        // Enrich driver profile with User data (always prefer real user name; fallback photo)
        try {
          final user = await User.db.findById(session, driver.userId);
          if (user != null) {
            final originalName = driver.displayName;
            if (user.fullName.isNotEmpty) {
              driver.displayName = user.fullName;
              if (originalName != driver.displayName) {
                session.log('Enriched name for driverId=$driverId: "$originalName" -> "${driver.displayName}"');
              }
            }
            if ((driver.profilePhotoUrl == null || driver.profilePhotoUrl!.isEmpty) &&
                (user.profilePhotoUrl != null && user.profilePhotoUrl!.isNotEmpty)) {
              driver.profilePhotoUrl = user.profilePhotoUrl;
              session.log('Applied photo fallback from User for driverId=$driverId');
            }
          } else {
            session.log('No User found for driver.userId=${driver.userId}');
          }
        } catch (e) {
          session.log('Warning: unable to enrich driver profile $driverId with user data: $e');
        }

        // Populate rating from reviews if values are zero
        try {
          if (driver.ratingCount == 0 || (driver.ratingAverage == 0.0)) {
            final reviews = await Review.db.find(
              session,
              where: (t) => t.driverId.equals(driverId) & t.isVisible.equals(true),
            );
            if (reviews.isNotEmpty) {
              final total = reviews.fold<int>(0, (sum, r) => sum + r.rating);
              driver.ratingCount = reviews.length;
              driver.ratingAverage = total / reviews.length;
              session.log('Computed ratings for driverId=$driverId: count=${driver.ratingCount}, avg=${driver.ratingAverage.toStringAsFixed(2)}');
            } else {
              session.log('No reviews found for driverId=$driverId; ratings remain at 0');
            }
          }
        } catch (e) {
          session.log('Warning: unable to compute ratings for driver $driverId: $e');
        }

        // Filter by online status
        if (onlineOnly && !driver.isOnline) continue;

        // Filter by rating
        if (minRating != null && driver.ratingAverage < minRating) continue;

        // Filter by distance
        if (driver.lastLocationLat != null && driver.lastLocationLng != null) {
          final distance = _calculateDistance(
            clientLat,
            clientLng,
            driver.lastLocationLat!,
            driver.lastLocationLng!,
          );

          if (distance <= radiusKm) {
            drivers.add(driver);
            session.log('DriverId=$driverId within radius (${distance.toStringAsFixed(2)} km)');
          }
        } else if (!onlineOnly) {
          // Include offline drivers without location
          drivers.add(driver);
          session.log('DriverId=$driverId added without location (onlineOnly=$onlineOnly)');
        }
      }

      // Sort by rating (highest first)
      drivers.sort((a, b) => b.ratingAverage.compareTo(a.ratingAverage));

      // Apply limit
      if (drivers.length > limit) {
        drivers = drivers.sublist(0, limit);
      }

      session.log('SearchDrivers completed: matchedDrivers=${drivers.length}');
      return drivers;
    } catch (e) {
      session.log('Error searching drivers with services: $e',
          level: LogLevel.error);
      return [];
    }
  }

  /// Get driver's complete catalog with images
  Future<List<DriverService>> getDriverCatalog(
    Session session, {
    required int driverId,
    bool activeOnly = true,
  }) async {
    try {
      if (activeOnly) {
        return await DriverService.db.find(
          session,
          where: (t) => t.driverId.equals(driverId) & t.isActive.equals(true),
          orderBy: (t) => t.displayOrder,
        );
      }

      return await DriverService.db.find(
        session,
        where: (t) => t.driverId.equals(driverId),
        orderBy: (t) => t.displayOrder,
      );
    } catch (e) {
      session.log('Error getting driver catalog: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Track service view for analytics
  Future<bool> trackServiceView(
    Session session, {
    required int driverServiceId,
  }) async {
    try {
      // Update view count in driver service
      final service = await DriverService.db.findById(session, driverServiceId);
      if (service == null) {
        return false;
      }

      service.viewCount += 1;
      service.updatedAt = DateTime.now();
      await DriverService.db.updateRow(session, service);

      // Update analytics
      final analytics = await ServiceAnalytics.db.findFirstRow(
        session,
        where: (t) => t.driverServiceId.equals(driverServiceId),
      );

      if (analytics != null) {
        analytics.totalViews += 1;
        analytics.lastViewedAt = DateTime.now();
        analytics.updatedAt = DateTime.now();
        await ServiceAnalytics.db.updateRow(session, analytics);
      }

      return true;
    } catch (e) {
      session.log('Error tracking service view: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Track service inquiry
  Future<bool> trackServiceInquiry(
    Session session, {
    required int driverServiceId,
  }) async {
    try {
      // Update inquiry count
      final service = await DriverService.db.findById(session, driverServiceId);
      if (service == null) {
        return false;
      }

      service.inquiryCount += 1;
      service.updatedAt = DateTime.now();
      await DriverService.db.updateRow(session, service);

      // Update analytics
      final analytics = await ServiceAnalytics.db.findFirstRow(
        session,
        where: (t) => t.driverServiceId.equals(driverServiceId),
      );

      if (analytics != null) {
        analytics.totalInquiries += 1;
        analytics.updatedAt = DateTime.now();

        // Update conversion rate
        if (analytics.totalViews > 0) {
          analytics.conversionRate = 
              (analytics.totalInquiries / analytics.totalViews) * 100;
        }

        await ServiceAnalytics.db.updateRow(session, analytics);
      }

      return true;
    } catch (e) {
      session.log('Error tracking service inquiry: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Track service booking
  Future<bool> trackServiceBooking(
    Session session, {
    required int driverServiceId,
  }) async {
    try {
      // Update booking count
      final service = await DriverService.db.findById(session, driverServiceId);
      if (service == null) {
        return false;
      }

      service.bookingCount += 1;
      service.updatedAt = DateTime.now();
      await DriverService.db.updateRow(session, service);

      // Update analytics
      final analytics = await ServiceAnalytics.db.findFirstRow(
        session,
        where: (t) => t.driverServiceId.equals(driverServiceId),
      );

      if (analytics != null) {
        analytics.totalBookings += 1;
        analytics.updatedAt = DateTime.now();

        // Update conversion rate
        if (analytics.totalViews > 0) {
          analytics.conversionRate = 
              (analytics.totalBookings / analytics.totalViews) * 100;
        }

        await ServiceAnalytics.db.updateRow(session, analytics);
      }

      return true;
    } catch (e) {
      session.log('Error tracking service booking: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Get service analytics
  Future<ServiceAnalytics?> getServiceAnalytics(
    Session session, {
    required int driverServiceId,
  }) async {
    try {
      return await ServiceAnalytics.db.findFirstRow(
        session,
        where: (t) => t.driverServiceId.equals(driverServiceId),
      );
    } catch (e) {
      session.log('Error getting service analytics: $e', level: LogLevel.error);
      return null;
    }
  }

  // ============================================================
  // FAVORITES MANAGEMENT
  // ============================================================

  /// Toggle favorite status for a driver
  /// Returns true if favorited, false if unfavorited
  Future<bool> toggleFavorite(
    Session session, {
    required int clientId,
    required int driverId,
  }) async {
    try {
      // Resolve provided clientId (Users.id) to UserClient.id
      final userClient = await UserClient.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(clientId),
      );

      int resolvedClientId;
      if (userClient == null) {
        // Auto-create UserClient if missing
        final created = await UserClient.db.insertRow(
          session,
          UserClient(
            userId: clientId,
            createdAt: DateTime.now(),
          ),
        );
        resolvedClientId = created.id!;
      } else {
        resolvedClientId = userClient.id!;
      }

      // Check if already favorited
      final existing = await Favorite.db.findFirstRow(
        session,
        where: (t) =>
            t.clientId.equals(resolvedClientId) & t.driverId.equals(driverId),
      );

      if (existing != null) {
        // Remove favorite
        await Favorite.db.deleteRow(session, existing);
        return false;
      } else {
        // Add favorite
        final favorite = Favorite(
          clientId: resolvedClientId,
          driverId: driverId,
          createdAt: DateTime.now(),
        );
        await Favorite.db.insertRow(session, favorite);
        return true;
      }
    } catch (e) {
      session.log('Error toggling favorite: $e', level: LogLevel.error);
      throw Exception('Failed to update favorite');
    }
  }

  /// Get all favorited drivers for a client
  Future<List<DriverProfile>> getFavoriteDrivers(
    Session session, {
    required int clientId,
  }) async {
    try {
      // Resolve Users.id to UserClient.id
      final userClient = await UserClient.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(clientId),
      );
      if (userClient == null) return [];

      final favorites = await Favorite.db.find(
        session,
        where: (t) => t.clientId.equals(userClient.id!),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
      );

      if (favorites.isEmpty) return [];

      final driverIds = favorites.map((f) => f.driverId).toSet();
      final drivers = await DriverProfile.db.find(
        session,
        where: (t) => t.id.inSet(driverIds),
      );

      return drivers;
    } catch (e) {
      session.log('Error getting favorite drivers: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Check if a driver is favorited by client
  Future<bool> isFavorite(
    Session session, {
    required int clientId,
    required int driverId,
  }) async {
    try {
      // Resolve Users.id to UserClient.id
      final userClient = await UserClient.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(clientId),
      );
      if (userClient == null) return false;

      final favorite = await Favorite.db.findFirstRow(
        session,
        where: (t) =>
            t.clientId.equals(userClient.id!) & t.driverId.equals(driverId),
      );
      return favorite != null;
    } catch (e) {
      session.log('Error checking favorite: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Get favorite driver IDs for a client (batch check)
  Future<List<int>> getFavoriteDriverIds(
    Session session, {
    required int clientId,
  }) async {
    try {
      // Resolve Users.id to UserClient.id
      final userClient = await UserClient.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(clientId),
      );
      if (userClient == null) return [];

      final favorites = await Favorite.db.find(
        session,
        where: (t) => t.clientId.equals(userClient.id!),
      );
      return favorites.map((f) => f.driverId).toList();
    } catch (e) {
      session.log('Error getting favorite IDs: $e', level: LogLevel.error);
      return [];
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
}
