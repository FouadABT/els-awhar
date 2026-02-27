import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../services/elasticsearch/elasticsearch.dart';
import '../services/elasticsearch/elasticsearch_search_service.dart';

/// Search endpoint for Awhar
/// Provides search functionality across all content types using Elasticsearch
/// 
/// Note: All methods return JSON strings to ensure proper serialization.
/// Parse the JSON on the client side.
class SearchEndpoint extends Endpoint {
  
  // ============================================
  // DRIVER SEARCH
  // ============================================

  /// Search for drivers near a location
  /// Returns drivers sorted by distance with optional filters
  /// Returns JSON string - parse on client
  Future<String> searchDriversNearby(
    Session session, {
    required double lat,
    required double lon,
    double? radiusKm,
    bool? isOnline,
    bool? isVerified,
    bool? isPremium,
    int? categoryId,
    double? minRating,
    int? from,
    int? size,
  }) async {
    final es = ElasticsearchService();
    final searchService = es.searchService;
    
    if (searchService == null) {
      throw Exception('Elasticsearch search service not initialized');
    }

    final result = await searchService.searchDriversNearby(
      session,
      lat: lat,
      lon: lon,
      radiusKm: radiusKm ?? 10.0,
      isOnline: isOnline,
      isVerified: isVerified,
      isPremium: isPremium,
      categoryId: categoryId,
      minRating: minRating,
      from: from ?? 0,
      size: size ?? 20,
    );

    return jsonEncode(_formatSearchResult(result));
  }

  /// Search drivers by text query
  Future<String> searchDriversByText(
    Session session, {
    required String query,
    bool? isOnline,
    bool? isVerified,
    String? vehicleType,
    double? minRating,
    int? from,
    int? size,
  }) async {
    final es = ElasticsearchService();
    final searchService = es.searchService;
    
    if (searchService == null) {
      throw Exception('Elasticsearch search service not initialized');
    }

    final result = await searchService.searchDriversByText(
      session,
      query: query,
      isOnline: isOnline,
      isVerified: isVerified,
      vehicleType: vehicleType,
      minRating: minRating,
      from: from ?? 0,
      size: size ?? 20,
    );

    return jsonEncode(_formatSearchResult(result));
  }

  /// Get top rated drivers
  Future<String> getTopRatedDrivers(
    Session session, {
    int? categoryId,
    int? minCompletedOrders,
    int? from,
    int? size,
  }) async {
    final es = ElasticsearchService();
    final searchService = es.searchService;
    
    if (searchService == null) {
      throw Exception('Elasticsearch search service not initialized');
    }

    final result = await searchService.getTopRatedDrivers(
      session,
      categoryId: categoryId,
      minCompletedOrders: minCompletedOrders ?? 5,
      from: from ?? 0,
      size: size ?? 10,
    );

    return jsonEncode(_formatSearchResult(result));
  }

  // ============================================
  // SERVICE SEARCH
  // ============================================

  /// Search services with multi-language support
  Future<String> searchServices(
    Session session, {
    required String query,
    String? language,
    int? categoryId,
    bool? isActive,
    int? from,
    int? size,
  }) async {
    final es = ElasticsearchService();
    final searchService = es.searchService;
    
    if (searchService == null) {
      throw Exception('Elasticsearch search service not initialized');
    }

    final result = await searchService.searchServices(
      session,
      query: query,
      language: language ?? 'en',
      categoryId: categoryId,
      isActive: isActive,
      from: from ?? 0,
      size: size ?? 20,
    );

    return jsonEncode(_formatSearchResult(result));
  }

  /// Get popular services
  Future<String> getPopularServices(
    Session session, {
    int? categoryId,
    int? from,
    int? size,
  }) async {
    final es = ElasticsearchService();
    final searchService = es.searchService;
    
    if (searchService == null) {
      throw Exception('Elasticsearch search service not initialized');
    }

    final result = await searchService.getPopularServices(
      session,
      categoryId: categoryId,
      from: from ?? 0,
      size: size ?? 10,
    );

    return jsonEncode(_formatSearchResult(result));
  }

  // ============================================
  // DRIVER SERVICE SEARCH
  // ============================================

  /// Search driver services with location and filters
  Future<String> searchDriverServices(
    Session session, {
    String? query,
    double? lat,
    double? lon,
    double? radiusKm,
    int? categoryId,
    int? serviceId,
    double? minPrice,
    double? maxPrice,
    bool? isAvailable,
    bool? driverIsOnline,
    String? sortBy, // 'relevance', 'price_low', 'price_high', 'rating', 'distance'
    int? from,
    int? size,
  }) async {
    final es = ElasticsearchService();
    final searchService = es.searchService;
    
    if (searchService == null) {
      throw Exception('Elasticsearch search service not initialized');
    }

    final result = await searchService.searchDriverServices(
      session,
      query: query,
      lat: lat,
      lon: lon,
      radiusKm: radiusKm ?? 20.0,
      categoryId: categoryId,
      serviceId: serviceId,
      minPrice: minPrice,
      maxPrice: maxPrice,
      isAvailable: isAvailable,
      driverIsOnline: driverIsOnline,
      sortBy: sortBy ?? 'relevance',
      from: from ?? 0,
      size: size ?? 20,
    );

    return jsonEncode(_formatSearchResult(result));
  }

  /// Get similar driver services
  Future<String> getSimilarDriverServices(
    Session session, {
    required int driverServiceId,
    int? size,
  }) async {
    final es = ElasticsearchService();
    final searchService = es.searchService;
    
    if (searchService == null) {
      throw Exception('Elasticsearch search service not initialized');
    }

    final result = await searchService.getSimilarDriverServices(
      session,
      driverServiceId: driverServiceId,
      size: size ?? 5,
    );

    return jsonEncode(_formatSearchResult(result));
  }

  // ============================================
  // STORE SEARCH
  // ============================================

  /// Search stores near a location
  Future<String> searchStoresNearby(
    Session session, {
    required double lat,
    required double lon,
    double? radiusKm,
    String? query,
    int? categoryId,
    bool? isOpen,
    double? minRating,
    int? from,
    int? size,
  }) async {
    final es = ElasticsearchService();
    final searchService = es.searchService;
    
    if (searchService == null) {
      throw Exception('Elasticsearch search service not initialized');
    }

    final result = await searchService.searchStoresNearby(
      session,
      lat: lat,
      lon: lon,
      radiusKm: radiusKm ?? 10.0,
      query: query,
      categoryId: categoryId,
      isOpen: isOpen,
      minRating: minRating,
      from: from ?? 0,
      size: size ?? 20,
    );

    return jsonEncode(_formatSearchResult(result));
  }

  // ============================================
  // PRODUCT SEARCH
  // ============================================

  /// Search products within a store
  Future<String> searchProductsInStore(
    Session session, {
    required int storeId,
    String? query,
    int? categoryId,
    bool? isAvailable,
    double? minPrice,
    double? maxPrice,
    String? sortBy, // 'relevance', 'price_low', 'price_high', 'name'
    int? from,
    int? size,
  }) async {
    final es = ElasticsearchService();
    final searchService = es.searchService;
    
    if (searchService == null) {
      throw Exception('Elasticsearch search service not initialized');
    }

    final result = await searchService.searchProductsInStore(
      session,
      storeId: storeId,
      query: query,
      categoryId: categoryId,
      isAvailable: isAvailable,
      minPrice: minPrice,
      maxPrice: maxPrice,
      sortBy: sortBy ?? 'relevance',
      from: from ?? 0,
      size: size ?? 20,
    );

    return jsonEncode(_formatSearchResult(result));
  }

  /// Search products across all stores near a location
  Future<String> searchProductsNearby(
    Session session, {
    required String query,
    required double lat,
    required double lon,
    double? radiusKm,
    bool? isAvailable,
    int? from,
    int? size,
  }) async {
    final es = ElasticsearchService();
    final searchService = es.searchService;
    
    if (searchService == null) {
      throw Exception('Elasticsearch search service not initialized');
    }

    final result = await searchService.searchProductsNearby(
      session,
      query: query,
      lat: lat,
      lon: lon,
      radiusKm: radiusKm ?? 10.0,
      isAvailable: isAvailable,
      from: from ?? 0,
      size: size ?? 20,
    );

    return jsonEncode(_formatSearchResult(result));
  }

  // ============================================
  // AUTOCOMPLETE & SUGGESTIONS
  // ============================================

  /// Get search suggestions as user types
  /// Returns JSON string - parse on client
  Future<String> getSearchSuggestions(
    Session session, {
    required String prefix,
    String? type, // 'all', 'drivers', 'services', 'stores', 'products'
    int? size,
  }) async {
    final es = ElasticsearchService();
    final searchService = es.searchService;
    
    if (searchService == null) {
      throw Exception('Elasticsearch search service not initialized');
    }

    final suggestions = await searchService.getSearchSuggestions(
      session,
      prefix: prefix,
      type: type ?? 'all',
      size: size ?? 10,
    );

    return jsonEncode(suggestions.map((s) => <String, dynamic>{
      'text': s.text,
      'type': s.type,
      'score': s.score,
      'metadata': s.metadata,
    }).toList());
  }

  /// Get popular searches
  /// Returns JSON string - parse on client
  Future<String> getPopularSearches(
    Session session, {
    String? searchType,
    int? size,
  }) async {
    final es = ElasticsearchService();
    final searchService = es.searchService;
    
    if (searchService == null) {
      throw Exception('Elasticsearch search service not initialized');
    }

    final result = await searchService.getPopularSearches(
      session,
      searchType: searchType ?? 'all',
      size: size ?? 10,
    );
    return jsonEncode(result);
  }

  // ============================================
  // AGGREGATIONS
  // ============================================

  /// Get service categories with counts
  /// Returns JSON string - parse on client
  Future<String> getServiceCategoryCounts(Session session) async {
    final es = ElasticsearchService();
    final searchService = es.searchService;
    
    if (searchService == null) {
      throw Exception('Elasticsearch search service not initialized');
    }

    final result = await searchService.getServiceCategoryCounts(session);
    return jsonEncode(result);
  }

  /// Get driver service price statistics
  /// Returns JSON string - parse on client
  Future<String> getDriverServicePriceStats(
    Session session, {
    int? categoryId,
  }) async {
    final es = ElasticsearchService();
    final searchService = es.searchService;
    
    if (searchService == null) {
      throw Exception('Elasticsearch search service not initialized');
    }

    final result = await searchService.getDriverServicePriceStats(
      session,
      categoryId: categoryId,
    );
    return jsonEncode(result);
  }

  // ============================================
  // UNIFIED SEARCH
  // ============================================

  /// Unified search across multiple content types
  /// Great for search bar functionality
  Future<String> unifiedSearch(
    Session session, {
    required String query,
    double? lat,
    double? lon,
    double? radiusKm,
    List<String>? types, // ['drivers', 'services', 'stores', 'products']
    int? size,
  }) async {
    final es = ElasticsearchService();
    final searchService = es.searchService;
    
    if (searchService == null) {
      throw Exception('Elasticsearch search service not initialized');
    }

    final searchTypes = types ?? ['drivers', 'services', 'stores'];
    final results = <String, dynamic>{};
    final sizePerType = (size ?? 10) ~/ searchTypes.length;

    // Search drivers
    if (searchTypes.contains('drivers')) {
      try {
        if (lat != null && lon != null) {
          final driverResult = await searchService.searchDriversNearby(
            session,
            lat: lat,
            lon: lon,
            radiusKm: radiusKm ?? 20.0,
            size: sizePerType,
          );
          results['drivers'] = _formatSearchResult(driverResult);
        } else {
          final driverResult = await searchService.searchDriversByText(
            session,
            query: query,
            size: sizePerType,
          );
          results['drivers'] = _formatSearchResult(driverResult);
        }
      } catch (e) {
        results['drivers'] = {'error': e.toString(), 'hits': [], 'total': 0};
      }
    }

    // Search services
    if (searchTypes.contains('services')) {
      try {
        final serviceResult = await searchService.searchServices(
          session,
          query: query,
          size: sizePerType,
        );
        results['services'] = _formatSearchResult(serviceResult);
      } catch (e) {
        results['services'] = {'error': e.toString(), 'hits': [], 'total': 0};
      }
    }

    // Search stores
    if (searchTypes.contains('stores') && lat != null && lon != null) {
      try {
        final storeResult = await searchService.searchStoresNearby(
          session,
          lat: lat,
          lon: lon,
          query: query,
          radiusKm: radiusKm ?? 20.0,
          size: sizePerType,
        );
        results['stores'] = _formatSearchResult(storeResult);
      } catch (e) {
        results['stores'] = {'error': e.toString(), 'hits': [], 'total': 0};
      }
    }

    // Search driver services
    if (searchTypes.contains('driver_services')) {
      try {
        final driverServiceResult = await searchService.searchDriverServices(
          session,
          query: query,
          lat: lat,
          lon: lon,
          radiusKm: radiusKm ?? 20.0,
          size: sizePerType,
        );
        results['driver_services'] = _formatSearchResult(driverServiceResult);
      } catch (e) {
        results['driver_services'] = {'error': e.toString(), 'hits': [], 'total': 0};
      }
    }

    return jsonEncode({
      'query': query,
      'results': results,
    });
  }

  // ============================================
  // HELPERS
  // ============================================

  Map<String, dynamic> _formatSearchResult<T>(EsSearchResult<T> result) {
    return {
      'hits': result.hits.map((h) => _hitToMap(h)).toList(),
      'total': result.total,
      'maxScore': result.maxScore,
      'took': result.took,
      'aggregations': result.aggregations,
    };
  }

  Map<String, dynamic> _hitToMap(dynamic hit) {
    if (hit is DriverSearchHit) {
      return {
        'userId': hit.userId,
        'displayName': hit.displayName,
        'bio': hit.bio,
        'profilePhotoUrl': hit.profilePhotoUrl,
        'vehicleType': hit.vehicleType,
        'ratingAverage': hit.ratingAverage,
        'ratingCount': hit.ratingCount,
        'isOnline': hit.isOnline,
        'isVerified': hit.isVerified,
        'isPremium': hit.isPremium,
        'isFeatured': hit.isFeatured,
        'totalCompletedOrders': hit.totalCompletedOrders,
        'serviceCategories': hit.serviceCategories,
        'distance': hit.distance,
        'score': hit.score,
      };
    } else if (hit is ServiceSearchHit) {
      return {
        'id': hit.id,
        'categoryId': hit.categoryId,
        'categoryName': hit.categoryName,
        'nameEn': hit.nameEn,
        'nameAr': hit.nameAr,
        'nameFr': hit.nameFr,
        'nameEs': hit.nameEs,
        'descriptionEn': hit.descriptionEn,
        'iconName': hit.iconName,
        'imageUrl': hit.imageUrl,
        'suggestedPriceMin': hit.suggestedPriceMin,
        'suggestedPriceMax': hit.suggestedPriceMax,
        'isActive': hit.isActive,
        'isPopular': hit.isPopular,
        'score': hit.score,
      };
    } else if (hit is DriverServiceSearchHit) {
      return {
        'id': hit.id,
        'driverId': hit.driverId,
        'serviceId': hit.serviceId,
        'categoryId': hit.categoryId,
        'driverName': hit.driverName,
        'driverPhoto': hit.driverPhoto,
        'driverRating': hit.driverRating,
        'driverIsVerified': hit.driverIsVerified,
        'driverIsPremium': hit.driverIsPremium,
        'driverIsOnline': hit.driverIsOnline,
        'serviceName': hit.serviceName,
        'categoryName': hit.categoryName,
        'title': hit.title,
        'description': hit.description,
        'imageUrl': hit.imageUrl,
        'priceType': hit.priceType,
        'basePrice': hit.basePrice,
        'distance': hit.distance,
        'score': hit.score,
      };
    } else if (hit is StoreSearchHit) {
      return {
        'id': hit.id,
        'userId': hit.userId,
        'storeCategoryId': hit.storeCategoryId,
        'categoryName': hit.categoryName,
        'name': hit.name,
        'description': hit.description,
        'logoUrl': hit.logoUrl,
        'address': hit.address,
        'latitude': hit.latitude,
        'longitude': hit.longitude,
        'ratingAverage': hit.ratingAverage,
        'ratingCount': hit.ratingCount,
        'isActive': hit.isActive,
        'isOpen': hit.isOpen,
        'deliveryRadiusKm': hit.deliveryRadiusKm,
        'distance': hit.distance,
        'score': hit.score,
      };
    } else if (hit is ProductSearchHit) {
      return {
        'id': hit.id,
        'storeId': hit.storeId,
        'storeName': hit.storeName,
        'storeLogoUrl': hit.storeLogoUrl,
        'name': hit.name,
        'description': hit.description,
        'price': hit.price,
        'imageUrl': hit.imageUrl,
        'categoryName': hit.categoryName,
        'isAvailable': hit.isAvailable,
        'score': hit.score,
      };
    }
    
    return {};
  }

  // ============================================
  // SMART SEMANTIC SEARCH (ELSER Hybrid)
  // ============================================

  /// Smart semantic search across all content types.
  /// Uses ELSER + BM25 hybrid ranking (RRF) to understand user intent.
  /// Returns grouped results: services, stores, products, knowledge.
  /// Returns JSON string - parse on client.
  Future<String> smartSearch(
    Session session, {
    required String query,
    String? language,
    double? lat,
    double? lon,
    double? radiusKm,
    List<String>? types,
    int? sizePerType,
  }) async {
    final es = ElasticsearchService();
    final searchService = es.searchService;
    
    if (searchService == null) {
      throw Exception('Elasticsearch search service not initialized');
    }

    final result = await searchService.smartSearch(
      session,
      query: query,
      language: language ?? 'en',
      lat: lat,
      lon: lon,
      radiusKm: radiusKm,
      types: types,
      sizePerType: sizePerType ?? 5,
    );

    return jsonEncode(result.toJson());
  }

  /// Search the knowledge base for FAQ/help content.
  /// Uses pure ELSER semantic search for intent matching.
  /// Returns JSON string - parse on client.
  Future<String> searchKnowledgeBase(
    Session session, {
    required String query,
    String? category,
    String? language,
    int? size,
  }) async {
    final es = ElasticsearchService();
    final searchService = es.searchService;
    
    if (searchService == null) {
      throw Exception('Elasticsearch search service not initialized');
    }

    final results = await searchService.searchKnowledgeBase(
      session,
      query: query,
      category: category,
      language: language,
      size: size ?? 5,
    );

    return jsonEncode({
      'query': query,
      'total': results.length,
      'hits': results.map((h) => h.toJson()).toList(),
    });
  }
}
