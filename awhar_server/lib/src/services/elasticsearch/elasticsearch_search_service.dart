import 'package:serverpod/serverpod.dart';
import 'elasticsearch_client.dart';
import 'elasticsearch_config.dart';
import 'elasticsearch_sync_service.dart';

/// Unified smart search hit — works across services, stores, products
class SmartSearchHit {
  final String type; // 'service', 'store', 'product', 'knowledge'
  final int id;
  final String title;
  final String? description;
  final String? imageUrl;
  final String? category;
  final double? price;
  final double? priceMax;
  final double? rating;
  final int? ratingCount;
  final String? location; // city or address
  final double score;
  final Map<String, dynamic> raw; // Full source for client-side flexibility

  SmartSearchHit({
    required this.type,
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
    this.category,
    this.price,
    this.priceMax,
    this.rating,
    this.ratingCount,
    this.location,
    required this.score,
    required this.raw,
  });

  Map<String, dynamic> toJson() => {
    'type': type,
    'id': id,
    'title': title,
    'description': description,
    'imageUrl': imageUrl,
    'category': category,
    'price': price,
    'priceMax': priceMax,
    'rating': rating,
    'ratingCount': ratingCount,
    'location': location,
    'score': score,
  };

  factory SmartSearchHit.fromServiceHit(Map<String, dynamic> hit) {
    final source = hit['_source'] as Map<String, dynamic>;
    return SmartSearchHit(
      type: 'service',
      id: source['id'] as int? ?? 0,
      title: source['nameEn'] as String? ?? '',
      description: source['descriptionEn'] as String?,
      imageUrl: source['imageUrl'] as String?,
      category: source['categoryName'] as String?,
      price: (source['suggestedPriceMin'] as num?)?.toDouble(),
      priceMax: (source['suggestedPriceMax'] as num?)?.toDouble(),
      score: (hit['_score'] as num?)?.toDouble() ?? 0.0,
      raw: source,
    );
  }

  factory SmartSearchHit.fromStoreHit(Map<String, dynamic> hit) {
    final source = hit['_source'] as Map<String, dynamic>;
    return SmartSearchHit(
      type: 'store',
      id: source['id'] as int? ?? 0,
      title: source['name'] as String? ?? '',
      description: source['description'] as String?,
      imageUrl: source['logoUrl'] as String?,
      category: source['categoryName'] as String?,
      rating: (source['ratingAverage'] as num?)?.toDouble(),
      ratingCount: source['ratingCount'] as int?,
      location: source['city'] as String?,
      score: (hit['_score'] as num?)?.toDouble() ?? 0.0,
      raw: source,
    );
  }

  factory SmartSearchHit.fromProductHit(Map<String, dynamic> hit) {
    final source = hit['_source'] as Map<String, dynamic>;
    return SmartSearchHit(
      type: 'product',
      id: source['id'] as int? ?? 0,
      title: source['name'] as String? ?? '',
      description: source['description'] as String?,
      imageUrl: source['imageUrl'] as String?,
      category: source['categoryName'] as String?,
      price: (source['price'] as num?)?.toDouble(),
      location: source['storeName'] as String?,
      score: (hit['_score'] as num?)?.toDouble() ?? 0.0,
      raw: source,
    );
  }

  factory SmartSearchHit.fromKnowledgeHit(Map<String, dynamic> hit) {
    final source = hit['_source'] as Map<String, dynamic>;
    return SmartSearchHit(
      type: 'knowledge',
      id: 0,
      title: source['title'] as String? ?? '',
      description: (source['content'] is Map)
          ? (source['content'] as Map<String, dynamic>)['text'] as String? ?? ''
          : source['content'] as String? ?? '',
      category: source['category'] as String?,
      score: (hit['_score'] as num?)?.toDouble() ?? 0.0,
      raw: source,
    );
  }
}

/// Smart search result with grouped results
class SmartSearchResult {
  final String query;
  final List<SmartSearchHit> services;
  final List<SmartSearchHit> stores;
  final List<SmartSearchHit> products;
  final List<SmartSearchHit> knowledge;
  final List<SmartSearchHit> all; // Merged and ranked
  final int totalHits;
  final int took; // ms

  SmartSearchResult({
    required this.query,
    required this.services,
    required this.stores,
    required this.products,
    required this.knowledge,
    required this.all,
    required this.totalHits,
    required this.took,
  });

  Map<String, dynamic> toJson() => {
    'query': query,
    'totalHits': totalHits,
    'took': took,
    'services': services.map((h) => h.toJson()).toList(),
    'stores': stores.map((h) => h.toJson()).toList(),
    'products': products.map((h) => h.toJson()).toList(),
    'knowledge': knowledge.map((h) => h.toJson()).toList(),
    'all': all.map((h) => h.toJson()).toList(),
  };
}

/// Search result wrapper
class EsSearchResult<T> {
  final List<T> hits;
  final int total;
  final double? maxScore;
  final Map<String, dynamic>? aggregations;
  final int took; // Time in milliseconds

  EsSearchResult({
    required this.hits,
    required this.total,
    this.maxScore,
    this.aggregations,
    required this.took,
  });
}

/// Driver search result with score
class DriverSearchHit {
  final int userId;
  final String? displayName;
  final String? bio;
  final String? profilePhotoUrl;
  final String? vehicleType;
  final double? ratingAverage;
  final int? ratingCount;
  final bool isOnline;
  final bool isVerified;
  final bool isPremium;
  final bool isFeatured;
  final int? totalCompletedOrders;
  final List<String>? serviceCategories;
  final double? distance; // in km
  final double score;

  DriverSearchHit({
    required this.userId,
    this.displayName,
    this.bio,
    this.profilePhotoUrl,
    this.vehicleType,
    this.ratingAverage,
    this.ratingCount,
    this.isOnline = false,
    this.isVerified = false,
    this.isPremium = false,
    this.isFeatured = false,
    this.totalCompletedOrders,
    this.serviceCategories,
    this.distance,
    required this.score,
  });

  factory DriverSearchHit.fromEsHit(Map<String, dynamic> hit) {
    final source = hit['_source'] as Map<String, dynamic>;
    final sort = hit['sort'] as List<dynamic>?;
    
    return DriverSearchHit(
      userId: source['userId'] as int,
      displayName: source['displayName'] as String?,
      bio: source['bio'] as String?,
      profilePhotoUrl: source['profilePhotoUrl'] as String?,
      vehicleType: source['vehicleType'] as String?,
      ratingAverage: (source['ratingAverage'] as num?)?.toDouble(),
      ratingCount: source['ratingCount'] as int?,
      isOnline: source['isOnline'] as bool? ?? false,
      isVerified: source['isVerified'] as bool? ?? false,
      isPremium: source['isPremium'] as bool? ?? false,
      isFeatured: source['isFeatured'] as bool? ?? false,
      totalCompletedOrders: source['totalCompletedOrders'] as int?,
      serviceCategories: (source['serviceCategories'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      distance: sort != null && sort.isNotEmpty ? (sort[0] as num?)?.toDouble() : null,
      score: (hit['_score'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

/// Service search result
class ServiceSearchHit {
  final int id;
  final int categoryId;
  final String? categoryName;
  final String nameEn;
  final String? nameAr;
  final String? nameFr;
  final String? nameEs;
  final String? descriptionEn;
  final String? iconName;
  final String? imageUrl;
  final double? suggestedPriceMin;
  final double? suggestedPriceMax;
  final bool isActive;
  final bool isPopular;
  final double score;

  ServiceSearchHit({
    required this.id,
    required this.categoryId,
    this.categoryName,
    required this.nameEn,
    this.nameAr,
    this.nameFr,
    this.nameEs,
    this.descriptionEn,
    this.iconName,
    this.imageUrl,
    this.suggestedPriceMin,
    this.suggestedPriceMax,
    this.isActive = true,
    this.isPopular = false,
    required this.score,
  });

  factory ServiceSearchHit.fromEsHit(Map<String, dynamic> hit) {
    final source = hit['_source'] as Map<String, dynamic>;
    return ServiceSearchHit(
      id: source['id'] as int,
      categoryId: source['categoryId'] as int,
      categoryName: source['categoryName'] as String?,
      nameEn: source['nameEn'] as String? ?? '',
      nameAr: source['nameAr'] as String?,
      nameFr: source['nameFr'] as String?,
      nameEs: source['nameEs'] as String?,
      descriptionEn: source['descriptionEn'] as String?,
      iconName: source['iconName'] as String?,
      imageUrl: source['imageUrl'] as String?,
      suggestedPriceMin: (source['suggestedPriceMin'] as num?)?.toDouble(),
      suggestedPriceMax: (source['suggestedPriceMax'] as num?)?.toDouble(),
      isActive: source['isActive'] as bool? ?? true,
      isPopular: source['isPopular'] as bool? ?? false,
      score: (hit['_score'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

/// Driver service search result
class DriverServiceSearchHit {
  final int id;
  final int driverId;
  final int serviceId;
  final int? categoryId;
  final String? driverName;
  final String? driverPhoto;
  final double? driverRating;
  final bool? driverIsVerified;
  final bool? driverIsPremium;
  final bool? driverIsOnline;
  final String? serviceName;
  final String? categoryName;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? priceType;
  final double? basePrice;
  final double? distance;
  final double score;

  DriverServiceSearchHit({
    required this.id,
    required this.driverId,
    required this.serviceId,
    this.categoryId,
    this.driverName,
    this.driverPhoto,
    this.driverRating,
    this.driverIsVerified,
    this.driverIsPremium,
    this.driverIsOnline,
    this.serviceName,
    this.categoryName,
    this.title,
    this.description,
    this.imageUrl,
    this.priceType,
    this.basePrice,
    this.distance,
    required this.score,
  });

  factory DriverServiceSearchHit.fromEsHit(Map<String, dynamic> hit) {
    final source = hit['_source'] as Map<String, dynamic>;
    final sort = hit['sort'] as List<dynamic>?;
    
    return DriverServiceSearchHit(
      id: source['id'] as int,
      driverId: source['driverId'] as int,
      serviceId: source['serviceId'] as int,
      categoryId: source['categoryId'] as int?,
      driverName: source['driverName'] as String?,
      driverPhoto: source['driverPhoto'] as String?,
      driverRating: (source['driverRating'] as num?)?.toDouble(),
      driverIsVerified: source['driverIsVerified'] as bool?,
      driverIsPremium: source['driverIsPremium'] as bool?,
      driverIsOnline: source['driverIsOnline'] as bool?,
      serviceName: source['serviceName'] as String?,
      categoryName: source['categoryName'] as String?,
      title: source['title'] as String?,
      description: source['description'] as String?,
      imageUrl: source['imageUrl'] as String?,
      priceType: source['priceType'] as String?,
      basePrice: (source['basePrice'] as num?)?.toDouble(),
      distance: sort != null && sort.isNotEmpty ? (sort[0] as num?)?.toDouble() : null,
      score: (hit['_score'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

/// Store search result
class StoreSearchHit {
  final int id;
  final int userId;
  final int storeCategoryId;
  final String? categoryName;
  final String name;
  final String? description;
  final String? logoUrl;
  final String? address;
  final double latitude;
  final double longitude;
  final double? ratingAverage;
  final int? ratingCount;
  final bool isActive;
  final bool isOpen;
  final double? deliveryRadiusKm;
  final double? distance;
  final double score;

  StoreSearchHit({
    required this.id,
    required this.userId,
    required this.storeCategoryId,
    this.categoryName,
    required this.name,
    this.description,
    this.logoUrl,
    this.address,
    required this.latitude,
    required this.longitude,
    this.ratingAverage,
    this.ratingCount,
    this.isActive = true,
    this.isOpen = false,
    this.deliveryRadiusKm,
    this.distance,
    required this.score,
  });

  factory StoreSearchHit.fromEsHit(Map<String, dynamic> hit) {
    final source = hit['_source'] as Map<String, dynamic>;
    final sort = hit['sort'] as List<dynamic>?;
    final location = source['location'] as Map<String, dynamic>?;
    
    return StoreSearchHit(
      id: source['id'] as int,
      userId: source['userId'] as int,
      storeCategoryId: source['storeCategoryId'] as int,
      categoryName: source['categoryName'] as String?,
      name: source['name'] as String? ?? '',
      description: source['description'] as String?,
      logoUrl: source['logoUrl'] as String?,
      address: source['address'] as String?,
      latitude: (location?['lat'] as num?)?.toDouble() ?? 0.0,
      longitude: (location?['lon'] as num?)?.toDouble() ?? 0.0,
      ratingAverage: (source['ratingAverage'] as num?)?.toDouble(),
      ratingCount: source['ratingCount'] as int?,
      isActive: source['isActive'] as bool? ?? true,
      isOpen: source['isOpen'] as bool? ?? false,
      deliveryRadiusKm: (source['deliveryRadiusKm'] as num?)?.toDouble(),
      distance: sort != null && sort.isNotEmpty ? (sort[0] as num?)?.toDouble() : null,
      score: (hit['_score'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

/// Product search result
class ProductSearchHit {
  final int id;
  final int storeId;
  final String? storeName;
  final String? storeLogoUrl;
  final String name;
  final String? description;
  final double price;
  final String? imageUrl;
  final String? categoryName;
  final bool isAvailable;
  final double score;

  ProductSearchHit({
    required this.id,
    required this.storeId,
    this.storeName,
    this.storeLogoUrl,
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
    this.categoryName,
    this.isAvailable = true,
    required this.score,
  });

  factory ProductSearchHit.fromEsHit(Map<String, dynamic> hit) {
    final source = hit['_source'] as Map<String, dynamic>;
    return ProductSearchHit(
      id: source['id'] as int,
      storeId: source['storeId'] as int,
      storeName: source['storeName'] as String?,
      storeLogoUrl: source['storeLogoUrl'] as String?,
      name: source['name'] as String? ?? '',
      description: source['description'] as String?,
      price: (source['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: source['imageUrl'] as String?,
      categoryName: source['categoryName'] as String?,
      isAvailable: source['isAvailable'] as bool? ?? true,
      score: (hit['_score'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

/// Search suggestion
class SearchSuggestion {
  final String text;
  final String type; // 'service', 'driver', 'store', 'product', 'recent'
  final double score;
  final Map<String, dynamic>? metadata;

  SearchSuggestion({
    required this.text,
    required this.type,
    required this.score,
    this.metadata,
  });
}

/// Elasticsearch Search Service
/// Provides high-level search functionality for Awhar
class ElasticsearchSearchService {
  final ElasticsearchClient _client;
  final ElasticsearchConfig _config;
  final ElasticsearchSyncService _syncService;

  ElasticsearchSearchService(this._client, this._config, this._syncService);

  // ============================================
  // SMART SEMANTIC SEARCH (ELSER + BM25 Hybrid)
  // ============================================

  /// Hybrid semantic search across services, stores, products, and knowledge base.
  /// Uses RRF (Reciprocal Rank Fusion) to combine BM25 keyword + ELSER semantic results.
  /// This is the flagship search method — understands intent, not just keywords.
  Future<SmartSearchResult> smartSearch(
    Session session, {
    required String query,
    String language = 'en',
    double? lat,
    double? lon,
    double? radiusKm,
    List<String>? types, // ['services', 'stores', 'products', 'knowledge']
    int sizePerType = 5,
  }) async {
    final searchTypes = types ?? ['services', 'stores', 'products', 'knowledge'];
    final stopwatch = Stopwatch()..start();
    
    final services = <SmartSearchHit>[];
    final stores = <SmartSearchHit>[];
    final products = <SmartSearchHit>[];
    final knowledge = <SmartSearchHit>[];

    // Build hybrid RRF query body
    Map<String, dynamic> buildHybridQuery(
      String textField,
      String semanticField,
      List<Map<String, dynamic>> extraFilters,
    ) {
      return {
        'retriever': {
          'rrf': {
            'retrievers': [
              // BM25 keyword retriever
              {
                'standard': {
                  'query': {
                    'bool': {
                      'must': [
                        {
                          'multi_match': {
                            'query': query,
                            'fields': _getFieldsForLanguage(textField, language),
                            'type': 'best_fields',
                            'fuzziness': 'AUTO',
                          }
                        }
                      ],
                      'filter': extraFilters,
                    }
                  }
                }
              },
              // ELSER semantic retriever
              {
                'standard': {
                  'query': {
                    'bool': {
                      'must': [
                        {
                          'semantic': {
                            'field': semanticField,
                            'query': query,
                          }
                        }
                      ],
                      'filter': extraFilters,
                    }
                  }
                }
              },
            ],
          }
        },
        'size': sizePerType,
      };
    }

    // Search services
    if (searchTypes.contains('services')) {
      try {
        final body = buildHybridQuery(
          'services',
          'semantic_description',
          [{'term': {'isActive': true}}],
        );
        final result = await _client.search('services', body);
        final hits = (result['hits']?['hits'] as List<dynamic>?) ?? [];
        services.addAll(hits.map((h) => SmartSearchHit.fromServiceHit(h as Map<String, dynamic>)));
      } catch (e) {
        print('[SmartSearch] Services search error: $e');
      }
    }

    // Search stores
    if (searchTypes.contains('stores')) {
      try {
        final filters = <Map<String, dynamic>>[
          {'term': {'isActive': true}},
        ];
        if (lat != null && lon != null) {
          filters.add({
            'geo_distance': {
              'distance': '${radiusKm ?? 50}km',
              'location': {'lat': lat, 'lon': lon},
            }
          });
        }
        final body = buildHybridQuery('stores', 'semantic_description', filters);
        final result = await _client.search('stores', body);
        final hits = (result['hits']?['hits'] as List<dynamic>?) ?? [];
        stores.addAll(hits.map((h) => SmartSearchHit.fromStoreHit(h as Map<String, dynamic>)));
      } catch (e) {
        print('[SmartSearch] Stores search error: $e');
      }
    }

    // Search products
    if (searchTypes.contains('products')) {
      try {
        final filters = <Map<String, dynamic>>[
          {'term': {'isAvailable': true}},
        ];
        final body = buildHybridQuery('products', 'semantic_description', filters);
        final result = await _client.search('products', body);
        final hits = (result['hits']?['hits'] as List<dynamic>?) ?? [];
        products.addAll(hits.map((h) => SmartSearchHit.fromProductHit(h as Map<String, dynamic>)));
      } catch (e) {
        print('[SmartSearch] Products search error: $e');
      }
    }

    // Search knowledge base
    if (searchTypes.contains('knowledge')) {
      try {
        // Knowledge base uses pure semantic search (content field)
        final body = {
          'query': {
            'semantic': {
              'field': 'content',
              'query': query,
            }
          },
          'size': sizePerType,
        };
        final result = await _client.search('knowledge-base', body);
        final hits = (result['hits']?['hits'] as List<dynamic>?) ?? [];
        knowledge.addAll(hits.map((h) => SmartSearchHit.fromKnowledgeHit(h as Map<String, dynamic>)));
      } catch (e) {
        print('[SmartSearch] Knowledge search error: $e');
      }
    }

    stopwatch.stop();

    // Merge all results, sorted by score descending
    final all = [...services, ...stores, ...products, ...knowledge]
      ..sort((a, b) => b.score.compareTo(a.score));

    // Log the search
    await _syncService.logSearch(
      session,
      query: query,
      searchType: 'smart',
      language: language,
      filters: {
        'types': searchTypes,
        if (lat != null) 'lat': lat,
        if (lon != null) 'lon': lon,
        if (radiusKm != null) 'radiusKm': radiusKm,
      },
      resultCount: all.length,
    );

    return SmartSearchResult(
      query: query,
      services: services,
      stores: stores,
      products: products,
      knowledge: knowledge,
      all: all,
      totalHits: all.length,
      took: stopwatch.elapsedMilliseconds,
    );
  }

  /// Get text fields for multi-language search based on index type
  List<String> _getFieldsForLanguage(String indexType, String language) {
    switch (indexType) {
      case 'services':
        switch (language) {
          case 'ar': return ['nameAr^3', 'descriptionAr^2', 'nameEn', 'searchableText'];
          case 'fr': return ['nameFr^3', 'descriptionFr^2', 'nameEn', 'searchableText'];
          case 'es': return ['nameEs^3', 'descriptionEs^2', 'nameEn', 'searchableText'];
          default:  return ['nameEn^3', 'descriptionEn^2', 'nameAr', 'nameFr', 'searchableText'];
        }
      case 'stores':
        return ['name^3', 'description^2', 'tagline', 'categoryName', 'searchableText'];
      case 'products':
        return ['name^3', 'description^2', 'categoryName', 'storeName', 'searchableText'];
      default:
        return ['searchableText'];
    }
  }

  // ============================================
  // KNOWLEDGE BASE SEARCH
  // ============================================

  /// Search the knowledge base using pure ELSER semantic search.
  /// Used by the Concierge agent for RAG (Retrieval-Augmented Generation).
  Future<List<SmartSearchHit>> searchKnowledgeBase(
    Session session, {
    required String query,
    String? category,
    String? language,
    int size = 5,
  }) async {
    final filters = <Map<String, dynamic>>[];
    if (category != null) {
      filters.add({'term': {'category': category}});
    }
    if (language != null) {
      filters.add({'term': {'language': language}});
    }

    final body = {
      'query': {
        'bool': {
          'must': [
            {
              'semantic': {
                'field': 'content',
                'query': query,
              }
            }
          ],
          if (filters.isNotEmpty) 'filter': filters,
        }
      },
      'size': size,
    };

    try {
      final result = await _client.search('knowledge-base', body);
      final hits = (result['hits']?['hits'] as List<dynamic>?) ?? [];
      return hits.map((h) => SmartSearchHit.fromKnowledgeHit(h as Map<String, dynamic>)).toList();
    } catch (e) {
      print('[KnowledgeBase] Search error: $e');
      return [];
    }
  }

  // ============================================
  // DRIVER SEARCH
  // ============================================

  /// Search for drivers near a location
  /// Returns drivers sorted by distance, with optional filters
  Future<EsSearchResult<DriverSearchHit>> searchDriversNearby(
    Session session, {
    required double lat,
    required double lon,
    double radiusKm = 10.0,
    bool? isOnline,
    bool? isVerified,
    bool? isPremium,
    int? categoryId,
    double? minRating,
    int from = 0,
    int size = 20,
  }) async {
    final must = <Map<String, dynamic>>[];
    final filter = <Map<String, dynamic>>[];

    // Geo distance filter
    filter.add({
      'geo_distance': {
        'distance': '${radiusKm}km',
        'location': {'lat': lat, 'lon': lon},
      }
    });

    // Online filter
    if (isOnline != null) {
      filter.add({'term': {'isOnline': isOnline}});
    }

    // Verified filter
    if (isVerified != null) {
      filter.add({'term': {'isVerified': isVerified}});
    }

    // Premium filter
    if (isPremium != null) {
      filter.add({'term': {'isPremium': isPremium}});
    }

    // Category filter
    if (categoryId != null) {
      filter.add({'term': {'serviceCategoryIds': categoryId}});
    }

    // Minimum rating filter
    if (minRating != null) {
      filter.add({'range': {'ratingAverage': {'gte': minRating}}});
    }

    final query = {
      'bool': {
        'must': must.isEmpty ? [{'match_all': {}}] : must,
        'filter': filter,
      }
    };

    final body = {
      'query': query,
      'sort': [
        {
          '_geo_distance': {
            'location': {'lat': lat, 'lon': lon},
            'order': 'asc',
            'unit': 'km',
          }
        },
        {'ratingAverage': {'order': 'desc'}},
        {'isPremium': {'order': 'desc'}},
      ],
      'from': from,
      'size': size,
    };

    final result = await _client.search('drivers', body);
    
    // Log search
    await _syncService.logSearch(
      session,
      query: 'geo:$lat,$lon',
      searchType: 'drivers_nearby',
      filters: {
        'radius': radiusKm,
        'isOnline': isOnline,
        'categoryId': categoryId,
      },
      resultCount: result['hits']['total']['value'] as int? ?? 0,
      lat: lat,
      lon: lon,
    );

    return _parseDriverResults(result);
  }

  /// Search drivers by text query (name, bio, etc.)
  Future<EsSearchResult<DriverSearchHit>> searchDriversByText(
    Session session, {
    required String query,
    bool? isOnline,
    bool? isVerified,
    String? vehicleType,
    double? minRating,
    int from = 0,
    int size = 20,
  }) async {
    final must = <Map<String, dynamic>>[];
    final filter = <Map<String, dynamic>>[];

    // Text search on multiple fields
    must.add({
      'multi_match': {
        'query': query,
        'fields': ['displayName^3', 'bio^2', 'serviceCategories'],
        'type': 'best_fields',
        'fuzziness': 'AUTO',
      }
    });

    if (isOnline != null) {
      filter.add({'term': {'isOnline': isOnline}});
    }
    if (isVerified != null) {
      filter.add({'term': {'isVerified': isVerified}});
    }
    if (vehicleType != null) {
      filter.add({'term': {'vehicleType': vehicleType}});
    }
    if (minRating != null) {
      filter.add({'range': {'ratingAverage': {'gte': minRating}}});
    }

    final queryBody = {
      'bool': {
        'must': must,
        'filter': filter,
      }
    };

    final body = {
      'query': queryBody,
      'sort': [
        '_score',
        {'ratingAverage': {'order': 'desc'}},
      ],
      'from': from,
      'size': size,
    };

    final result = await _client.search('drivers', body);
    
    await _syncService.logSearch(
      session,
      query: query,
      searchType: 'drivers_text',
      resultCount: result['hits']['total']['value'] as int? ?? 0,
    );

    return _parseDriverResults(result);
  }

  /// Get top rated drivers
  Future<EsSearchResult<DriverSearchHit>> getTopRatedDrivers(
    Session session, {
    int? categoryId,
    int minCompletedOrders = 5,
    int from = 0,
    int size = 10,
  }) async {
    final filter = <Map<String, dynamic>>[];

    filter.add({'term': {'isVerified': true}});
    filter.add({'range': {'totalCompletedOrders': {'gte': minCompletedOrders}}});
    
    if (categoryId != null) {
      filter.add({'term': {'serviceCategoryIds': categoryId}});
    }

    final body = {
      'query': {
        'bool': {'filter': filter}
      },
      'sort': [
        {'ratingAverage': {'order': 'desc'}},
        {'totalCompletedOrders': {'order': 'desc'}},
      ],
      'from': from,
      'size': size,
    };

    final result = await _client.search('drivers', body);
    return _parseDriverResults(result);
  }

  EsSearchResult<DriverSearchHit> _parseDriverResults(Map<String, dynamic> result) {
    final hits = result['hits'] as Map<String, dynamic>;
    final hitsList = hits['hits'] as List<dynamic>;
    final total = hits['total'] as Map<String, dynamic>;

    return EsSearchResult<DriverSearchHit>(
      hits: hitsList.map((h) => DriverSearchHit.fromEsHit(h as Map<String, dynamic>)).toList(),
      total: total['value'] as int? ?? 0,
      maxScore: (hits['max_score'] as num?)?.toDouble(),
      aggregations: result['aggregations'] as Map<String, dynamic>?,
      took: result['took'] as int? ?? 0,
    );
  }

  // ============================================
  // SERVICE CATALOG SEARCH
  // ============================================

  /// Search services with multi-language support
  Future<EsSearchResult<ServiceSearchHit>> searchServices(
    Session session, {
    required String query,
    String language = 'en',
    int? categoryId,
    bool? isActive,
    int from = 0,
    int size = 20,
  }) async {
    final must = <Map<String, dynamic>>[];
    final filter = <Map<String, dynamic>>[];

    // Multi-language search
    final fields = <String>[];
    switch (language) {
      case 'ar':
        fields.addAll(['nameAr^3', 'descriptionAr^2', 'nameEn', 'descriptionEn']);
        break;
      case 'fr':
        fields.addAll(['nameFr^3', 'descriptionFr^2', 'nameEn', 'descriptionEn']);
        break;
      case 'es':
        fields.addAll(['nameEs^3', 'descriptionEs^2', 'nameEn', 'descriptionEn']);
        break;
      default:
        fields.addAll(['nameEn^3', 'descriptionEn^2', 'nameAr', 'nameFr', 'nameEs']);
    }

    must.add({
      'multi_match': {
        'query': query,
        'fields': fields,
        'type': 'best_fields',
        'fuzziness': 'AUTO',
      }
    });

    if (categoryId != null) {
      filter.add({'term': {'categoryId': categoryId}});
    }

    if (isActive != null) {
      filter.add({'term': {'isActive': isActive}});
    } else {
      filter.add({'term': {'isActive': true}});
    }

    final body = {
      'query': {
        'bool': {
          'must': must,
          'filter': filter,
        }
      },
      'sort': [
        '_score',
        {'isPopular': {'order': 'desc'}},
        {'displayOrder': {'order': 'asc'}},
      ],
      'from': from,
      'size': size,
    };

    final result = await _client.search('services', body);
    
    await _syncService.logSearch(
      session,
      query: query,
      searchType: 'services',
      language: language,
      filters: {'categoryId': categoryId},
      resultCount: result['hits']['total']['value'] as int? ?? 0,
    );

    return _parseServiceResults(result);
  }

  /// Get popular services
  Future<EsSearchResult<ServiceSearchHit>> getPopularServices(
    Session session, {
    int? categoryId,
    int from = 0,
    int size = 10,
  }) async {
    final filter = <Map<String, dynamic>>[];
    filter.add({'term': {'isActive': true}});
    filter.add({'term': {'isPopular': true}});
    
    if (categoryId != null) {
      filter.add({'term': {'categoryId': categoryId}});
    }

    final body = {
      'query': {
        'bool': {'filter': filter}
      },
      'sort': [
        {'displayOrder': {'order': 'asc'}},
      ],
      'from': from,
      'size': size,
    };

    final result = await _client.search('services', body);
    return _parseServiceResults(result);
  }

  EsSearchResult<ServiceSearchHit> _parseServiceResults(Map<String, dynamic> result) {
    final hits = result['hits'] as Map<String, dynamic>;
    final hitsList = hits['hits'] as List<dynamic>;
    final total = hits['total'] as Map<String, dynamic>;

    return EsSearchResult<ServiceSearchHit>(
      hits: hitsList.map((h) => ServiceSearchHit.fromEsHit(h as Map<String, dynamic>)).toList(),
      total: total['value'] as int? ?? 0,
      maxScore: (hits['max_score'] as num?)?.toDouble(),
      aggregations: result['aggregations'] as Map<String, dynamic>?,
      took: result['took'] as int? ?? 0,
    );
  }

  // ============================================
  // DRIVER SERVICE SEARCH
  // ============================================

  /// Search driver services with location and filters
  Future<EsSearchResult<DriverServiceSearchHit>> searchDriverServices(
    Session session, {
    String? query,
    double? lat,
    double? lon,
    double radiusKm = 20.0,
    int? categoryId,
    int? serviceId,
    double? minPrice,
    double? maxPrice,
    bool? isAvailable,
    bool? driverIsOnline,
    String sortBy = 'relevance', // 'relevance', 'price_low', 'price_high', 'rating', 'distance'
    int from = 0,
    int size = 20,
  }) async {
    final must = <Map<String, dynamic>>[];
    final filter = <Map<String, dynamic>>[];

    // Text search
    if (query != null && query.isNotEmpty) {
      must.add({
        'multi_match': {
          'query': query,
          'fields': ['title^3', 'description^2', 'serviceName', 'categoryName', 'driverName'],
          'type': 'best_fields',
          'fuzziness': 'AUTO',
        }
      });
    }

    // Geo filter
    if (lat != null && lon != null) {
      filter.add({
        'geo_distance': {
          'distance': '${radiusKm}km',
          'location': {'lat': lat, 'lon': lon},
        }
      });
    }

    // Category filter
    if (categoryId != null) {
      filter.add({'term': {'categoryId': categoryId}});
    }

    // Service filter
    if (serviceId != null) {
      filter.add({'term': {'serviceId': serviceId}});
    }

    // Price range
    if (minPrice != null || maxPrice != null) {
      final range = <String, dynamic>{};
      if (minPrice != null) range['gte'] = minPrice;
      if (maxPrice != null) range['lte'] = maxPrice;
      filter.add({'range': {'basePrice': range}});
    }

    // Availability
    if (isAvailable != null) {
      filter.add({'term': {'isAvailable': isAvailable}});
    }

    // Driver online status
    if (driverIsOnline != null) {
      filter.add({'term': {'driverIsOnline': driverIsOnline}});
    }

    // Active filter (always true)
    filter.add({'term': {'isActive': true}});

    final queryBody = must.isEmpty
        ? {'bool': {'filter': filter}}
        : {'bool': {'must': must, 'filter': filter}};

    // Sorting
    final sort = <Map<String, dynamic>>[];
    switch (sortBy) {
      case 'price_low':
        sort.add({'basePrice': {'order': 'asc'}});
        break;
      case 'price_high':
        sort.add({'basePrice': {'order': 'desc'}});
        break;
      case 'rating':
        sort.add({'driverRating': {'order': 'desc'}});
        break;
      case 'distance':
        if (lat != null && lon != null) {
          sort.add({
            '_geo_distance': {
              'location': {'lat': lat, 'lon': lon},
              'order': 'asc',
              'unit': 'km',
            }
          });
        }
        break;
      default: // relevance
        sort.add({'_score': {'order': 'desc'}});
        sort.add({'driverRating': {'order': 'desc'}});
    }

    final body = {
      'query': queryBody,
      'sort': sort,
      'from': from,
      'size': size,
    };

    final result = await _client.search('driver-services', body);
    
    await _syncService.logSearch(
      session,
      query: query ?? 'browse',
      searchType: 'driver_services',
      filters: {
        'categoryId': categoryId,
        'serviceId': serviceId,
        'minPrice': minPrice,
        'maxPrice': maxPrice,
      },
      resultCount: result['hits']['total']['value'] as int? ?? 0,
      lat: lat,
      lon: lon,
    );

    return _parseDriverServiceResults(result);
  }

  /// Get similar driver services (more like this)
  Future<EsSearchResult<DriverServiceSearchHit>> getSimilarDriverServices(
    Session session, {
    required int driverServiceId,
    int size = 5,
  }) async {
    final body = {
      'query': {
        'more_like_this': {
          'fields': ['title', 'description', 'categoryName'],
          'like': [
            {
              '_index': '${_config.indexPrefix}-driver-services',
              '_id': 'driver_service_$driverServiceId',
            }
          ],
          'min_term_freq': 1,
          'min_doc_freq': 1,
        }
      },
      'size': size,
    };

    final result = await _client.search('driver-services', body);
    return _parseDriverServiceResults(result);
  }

  EsSearchResult<DriverServiceSearchHit> _parseDriverServiceResults(Map<String, dynamic> result) {
    final hits = result['hits'] as Map<String, dynamic>;
    final hitsList = hits['hits'] as List<dynamic>;
    final total = hits['total'] as Map<String, dynamic>;

    return EsSearchResult<DriverServiceSearchHit>(
      hits: hitsList.map((h) => DriverServiceSearchHit.fromEsHit(h as Map<String, dynamic>)).toList(),
      total: total['value'] as int? ?? 0,
      maxScore: (hits['max_score'] as num?)?.toDouble(),
      aggregations: result['aggregations'] as Map<String, dynamic>?,
      took: result['took'] as int? ?? 0,
    );
  }

  // ============================================
  // STORE SEARCH
  // ============================================

  /// Search stores near a location
  Future<EsSearchResult<StoreSearchHit>> searchStoresNearby(
    Session session, {
    required double lat,
    required double lon,
    double radiusKm = 10.0,
    String? query,
    int? categoryId,
    bool? isOpen,
    double? minRating,
    int from = 0,
    int size = 20,
  }) async {
    final must = <Map<String, dynamic>>[];
    final filter = <Map<String, dynamic>>[];

    // Geo filter
    filter.add({
      'geo_distance': {
        'distance': '${radiusKm}km',
        'location': {'lat': lat, 'lon': lon},
      }
    });

    // Text search
    if (query != null && query.isNotEmpty) {
      must.add({
        'multi_match': {
          'query': query,
          'fields': ['name^3', 'description^2', 'categoryName', 'address'],
          'type': 'best_fields',
          'fuzziness': 'AUTO',
        }
      });
    }

    // Category filter
    if (categoryId != null) {
      filter.add({'term': {'storeCategoryId': categoryId}});
    }

    // Open status
    if (isOpen != null) {
      filter.add({'term': {'isOpen': isOpen}});
    }

    // Minimum rating
    if (minRating != null) {
      filter.add({'range': {'ratingAverage': {'gte': minRating}}});
    }

    // Active filter
    filter.add({'term': {'isActive': true}});

    final queryBody = must.isEmpty
        ? {'bool': {'filter': filter}}
        : {'bool': {'must': must, 'filter': filter}};

    final body = {
      'query': queryBody,
      'sort': [
        {
          '_geo_distance': {
            'location': {'lat': lat, 'lon': lon},
            'order': 'asc',
            'unit': 'km',
          }
        },
        {'ratingAverage': {'order': 'desc'}},
      ],
      'from': from,
      'size': size,
    };

    final result = await _client.search('stores', body);
    
    await _syncService.logSearch(
      session,
      query: query ?? 'geo:$lat,$lon',
      searchType: 'stores_nearby',
      filters: {'categoryId': categoryId, 'isOpen': isOpen},
      resultCount: result['hits']['total']['value'] as int? ?? 0,
      lat: lat,
      lon: lon,
    );

    return _parseStoreResults(result);
  }

  EsSearchResult<StoreSearchHit> _parseStoreResults(Map<String, dynamic> result) {
    final hits = result['hits'] as Map<String, dynamic>;
    final hitsList = hits['hits'] as List<dynamic>;
    final total = hits['total'] as Map<String, dynamic>;

    return EsSearchResult<StoreSearchHit>(
      hits: hitsList.map((h) => StoreSearchHit.fromEsHit(h as Map<String, dynamic>)).toList(),
      total: total['value'] as int? ?? 0,
      maxScore: (hits['max_score'] as num?)?.toDouble(),
      aggregations: result['aggregations'] as Map<String, dynamic>?,
      took: result['took'] as int? ?? 0,
    );
  }

  // ============================================
  // PRODUCT SEARCH
  // ============================================

  /// Search products within a store
  Future<EsSearchResult<ProductSearchHit>> searchProductsInStore(
    Session session, {
    required int storeId,
    String? query,
    int? categoryId,
    bool? isAvailable,
    double? minPrice,
    double? maxPrice,
    String sortBy = 'relevance', // 'relevance', 'price_low', 'price_high', 'name'
    int from = 0,
    int size = 20,
  }) async {
    final must = <Map<String, dynamic>>[];
    final filter = <Map<String, dynamic>>[];

    // Store filter
    filter.add({'term': {'storeId': storeId}});

    // Text search
    if (query != null && query.isNotEmpty) {
      must.add({
        'multi_match': {
          'query': query,
          'fields': ['name^3', 'description^2', 'categoryName'],
          'type': 'best_fields',
          'fuzziness': 'AUTO',
        }
      });
    }

    // Category filter
    if (categoryId != null) {
      filter.add({'term': {'productCategoryId': categoryId}});
    }

    // Availability
    if (isAvailable != null) {
      filter.add({'term': {'isAvailable': isAvailable}});
    }

    // Price range
    if (minPrice != null || maxPrice != null) {
      final range = <String, dynamic>{};
      if (minPrice != null) range['gte'] = minPrice;
      if (maxPrice != null) range['lte'] = maxPrice;
      filter.add({'range': {'price': range}});
    }

    final queryBody = must.isEmpty
        ? {'bool': {'filter': filter}}
        : {'bool': {'must': must, 'filter': filter}};

    // Sorting
    final sort = <Map<String, dynamic>>[];
    switch (sortBy) {
      case 'price_low':
        sort.add({'price': {'order': 'asc'}});
        break;
      case 'price_high':
        sort.add({'price': {'order': 'desc'}});
        break;
      case 'name':
        sort.add({'name.keyword': {'order': 'asc'}});
        break;
      default:
        sort.add({'_score': {'order': 'desc'}});
        sort.add({'displayOrder': {'order': 'asc'}});
    }

    final body = {
      'query': queryBody,
      'sort': sort,
      'from': from,
      'size': size,
    };

    final result = await _client.search('products', body);
    return _parseProductResults(result);
  }

  /// Search products across all stores near a location
  Future<EsSearchResult<ProductSearchHit>> searchProductsNearby(
    Session session, {
    required String query,
    required double lat,
    required double lon,
    double radiusKm = 10.0,
    bool? isAvailable,
    int from = 0,
    int size = 20,
  }) async {
    final must = <Map<String, dynamic>>[];
    final filter = <Map<String, dynamic>>[];

    // Text search
    must.add({
      'multi_match': {
        'query': query,
        'fields': ['name^3', 'description^2'],
        'type': 'best_fields',
        'fuzziness': 'AUTO',
      }
    });

    // Geo filter on store location
    filter.add({
      'geo_distance': {
        'distance': '${radiusKm}km',
        'storeLocation': {'lat': lat, 'lon': lon},
      }
    });

    if (isAvailable != null) {
      filter.add({'term': {'isAvailable': isAvailable}});
    }

    final body = {
      'query': {
        'bool': {
          'must': must,
          'filter': filter,
        }
      },
      'sort': [
        '_score',
        {'price': {'order': 'asc'}},
      ],
      'from': from,
      'size': size,
    };

    final result = await _client.search('products', body);
    
    await _syncService.logSearch(
      session,
      query: query,
      searchType: 'products_nearby',
      resultCount: result['hits']['total']['value'] as int? ?? 0,
      lat: lat,
      lon: lon,
    );

    return _parseProductResults(result);
  }

  EsSearchResult<ProductSearchHit> _parseProductResults(Map<String, dynamic> result) {
    final hits = result['hits'] as Map<String, dynamic>;
    final hitsList = hits['hits'] as List<dynamic>;
    final total = hits['total'] as Map<String, dynamic>;

    return EsSearchResult<ProductSearchHit>(
      hits: hitsList.map((h) => ProductSearchHit.fromEsHit(h as Map<String, dynamic>)).toList(),
      total: total['value'] as int? ?? 0,
      maxScore: (hits['max_score'] as num?)?.toDouble(),
      aggregations: result['aggregations'] as Map<String, dynamic>?,
      took: result['took'] as int? ?? 0,
    );
  }

  // ============================================
  // AUTOCOMPLETE & SUGGESTIONS
  // ============================================

  /// Get search suggestions as user types
  Future<List<SearchSuggestion>> getSearchSuggestions(
    Session session, {
    required String prefix,
    String type = 'all', // 'all', 'drivers', 'services', 'stores', 'products'
    int size = 10,
  }) async {
    final suggestions = <SearchSuggestion>[];

    // Search services
    if (type == 'all' || type == 'services') {
      final serviceBody = {
        'query': {
          'bool': {
            'should': [
              {'prefix': {'nameEn': {'value': prefix.toLowerCase(), 'boost': 2.0}}},
              {'match': {'nameEn': {'query': prefix, 'fuzziness': 'AUTO'}}},
            ],
            'filter': [{'term': {'isActive': true}}],
          }
        },
        'size': type == 'services' ? size : 3,
        '_source': ['nameEn', 'categoryName'],
      };

      try {
        final result = await _client.search('services', serviceBody);
        final hits = (result['hits']['hits'] as List<dynamic>?) ?? [];
        
        for (final hit in hits) {
          final source = hit['_source'] as Map<String, dynamic>;
          suggestions.add(SearchSuggestion(
            text: source['nameEn'] as String? ?? '',
            type: 'service',
            score: (hit['_score'] as num?)?.toDouble() ?? 0.0,
            metadata: {'categoryName': source['categoryName']},
          ));
        }
      } catch (e) {
        // Ignore errors for suggestions
      }
    }

    // Search drivers
    if (type == 'all' || type == 'drivers') {
      final driverBody = {
        'query': {
          'bool': {
            'should': [
              {'prefix': {'displayName': {'value': prefix.toLowerCase(), 'boost': 2.0}}},
              {'match': {'displayName': {'query': prefix, 'fuzziness': 'AUTO'}}},
            ],
          }
        },
        'size': type == 'drivers' ? size : 3,
        '_source': ['displayName', 'vehicleType', 'ratingAverage'],
      };

      try {
        final result = await _client.search('drivers', driverBody);
        final hits = (result['hits']['hits'] as List<dynamic>?) ?? [];
        
        for (final hit in hits) {
          final source = hit['_source'] as Map<String, dynamic>;
          suggestions.add(SearchSuggestion(
            text: source['displayName'] as String? ?? '',
            type: 'driver',
            score: (hit['_score'] as num?)?.toDouble() ?? 0.0,
            metadata: {
              'vehicleType': source['vehicleType'],
              'rating': source['ratingAverage'],
            },
          ));
        }
      } catch (e) {
        // Ignore errors for suggestions
      }
    }

    // Search stores
    if (type == 'all' || type == 'stores') {
      final storeBody = {
        'query': {
          'bool': {
            'should': [
              {'prefix': {'name': {'value': prefix.toLowerCase(), 'boost': 2.0}}},
              {'match': {'name': {'query': prefix, 'fuzziness': 'AUTO'}}},
            ],
            'filter': [{'term': {'isActive': true}}],
          }
        },
        'size': type == 'stores' ? size : 3,
        '_source': ['name', 'categoryName', 'ratingAverage'],
      };

      try {
        final result = await _client.search('stores', storeBody);
        final hits = (result['hits']['hits'] as List<dynamic>?) ?? [];
        
        for (final hit in hits) {
          final source = hit['_source'] as Map<String, dynamic>;
          suggestions.add(SearchSuggestion(
            text: source['name'] as String? ?? '',
            type: 'store',
            score: (hit['_score'] as num?)?.toDouble() ?? 0.0,
            metadata: {
              'categoryName': source['categoryName'],
              'rating': source['ratingAverage'],
            },
          ));
        }
      } catch (e) {
        // Ignore errors for suggestions
      }
    }

    // Sort by score and limit
    suggestions.sort((a, b) => b.score.compareTo(a.score));
    return suggestions.take(size).toList();
  }

  /// Get popular searches
  Future<List<String>> getPopularSearches(
    Session session, {
    String searchType = 'all',
    int size = 10,
  }) async {
    final filter = <Map<String, dynamic>>[];
    
    if (searchType != 'all') {
      filter.add({'term': {'searchType': searchType}});
    }
    
    // Only consider searches from last 7 days
    filter.add({
      'range': {
        'timestamp': {
          'gte': 'now-7d',
        }
      }
    });

    final body = {
      'query': {
        'bool': {'filter': filter}
      },
      'size': 0,
      'aggs': {
        'popular_queries': {
          'terms': {
            'field': 'query.keyword',
            'size': size,
            'min_doc_count': 2,
          }
        }
      }
    };

    try {
      final result = await _client.search('search-logs', body);
      final aggs = result['aggregations'] as Map<String, dynamic>?;
      if (aggs == null) return [];
      
      final buckets = aggs['popular_queries']?['buckets'] as List<dynamic>?;
      if (buckets == null) return [];
      
      return buckets
          .map((b) => (b as Map<String, dynamic>)['key'] as String)
          .toList();
    } catch (e) {
      return [];
    }
  }

  // ============================================
  // AGGREGATIONS
  // ============================================

  /// Get service categories with counts
  Future<Map<String, int>> getServiceCategoryCounts(Session session) async {
    final body = {
      'query': {'term': {'isActive': true}},
      'size': 0,
      'aggs': {
        'categories': {
          'terms': {
            'field': 'categoryName.keyword',
            'size': 50,
          }
        }
      }
    };

    try {
      final result = await _client.search('services', body);
      final buckets = result['aggregations']?['categories']?['buckets'] as List<dynamic>?;
      if (buckets == null) return {};
      
      return Map.fromEntries(
        buckets.map((b) {
          final bucket = b as Map<String, dynamic>;
          return MapEntry(bucket['key'] as String, bucket['doc_count'] as int);
        }),
      );
    } catch (e) {
      return {};
    }
  }

  /// Get driver service price ranges for a category
  Future<Map<String, dynamic>> getDriverServicePriceStats(
    Session session, {
    int? categoryId,
  }) async {
    final filter = <Map<String, dynamic>>[
      {'term': {'isActive': true}},
    ];
    
    if (categoryId != null) {
      filter.add({'term': {'categoryId': categoryId}});
    }

    final body = {
      'query': {'bool': {'filter': filter}},
      'size': 0,
      'aggs': {
        'price_stats': {
          'stats': {'field': 'basePrice'}
        },
        'price_ranges': {
          'range': {
            'field': 'basePrice',
            'ranges': [
              {'key': 'budget', 'to': 50},
              {'key': 'mid', 'from': 50, 'to': 200},
              {'key': 'premium', 'from': 200},
            ]
          }
        }
      }
    };

    try {
      final result = await _client.search('driver-services', body);
      return result['aggregations'] as Map<String, dynamic>? ?? {};
    } catch (e) {
      return {};
    }
  }
}
