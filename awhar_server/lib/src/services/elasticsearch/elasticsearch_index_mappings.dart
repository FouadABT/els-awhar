/// Elasticsearch Index Mappings
///
/// Defines the schema (mappings) for all Awhar indices.
/// These mappings tell Elasticsearch how to interpret and index each field.

/// Index mappings for all Awhar Elasticsearch indices
class ElasticsearchIndexMappings {
  /// Mapping for awhar-drivers index
  /// Contains driver profiles for search and matching
  static const Map<String, dynamic> drivers = {
    'mappings': {
      'properties': {
        // Identifiers
        'userId': {'type': 'integer'},
        'driverId': {'type': 'integer'},
        
        // Profile info
        'displayName': {
          'type': 'text',
          'fields': {
            'keyword': {'type': 'keyword'}  // For exact matching and sorting
          }
        },
        'bio': {'type': 'text'},  // Full-text searchable
        'profilePhotoUrl': {'type': 'keyword', 'index': false},
        
        // Vehicle info
        'vehicleType': {'type': 'keyword'},
        'vehicleMake': {'type': 'keyword'},
        'vehicleModel': {'type': 'keyword'},
        
        // Location (critical for geo queries)
        'location': {'type': 'geo_point'},
        'lastLocationUpdatedAt': {'type': 'date'},
        'baseCityId': {'type': 'integer'},
        'baseCityName': {'type': 'keyword'},
        
        // Availability
        'isOnline': {'type': 'boolean'},
        'availabilityStatus': {'type': 'keyword'},
        
        // Ratings & Stats
        'ratingAverage': {'type': 'float'},
        'ratingCount': {'type': 'integer'},
        'totalCompletedOrders': {'type': 'integer'},
        'totalEarnings': {'type': 'float'},
        'experienceYears': {'type': 'integer'},
        
        // Verification & Premium
        'isVerified': {'type': 'boolean'},
        'isPremium': {'type': 'boolean'},
        'isFeatured': {'type': 'boolean'},
        
        // Services offered (nested for complex queries)
        'services': {
          'type': 'nested',
          'properties': {
            'serviceId': {'type': 'integer'},
            'categoryId': {'type': 'integer'},
            'serviceName': {'type': 'keyword'},
            'categoryName': {'type': 'keyword'},
            'basePrice': {'type': 'float'},
          }
        },
        
        // Timestamps
        'createdAt': {'type': 'date'},
        'updatedAt': {'type': 'date'},
      }
    }
  };

  /// Mapping for awhar-services index
  /// Contains the service catalog with multi-language support
  static const Map<String, dynamic> services = {
    'mappings': {
      'properties': {
        'serviceId': {'type': 'integer'},
        'categoryId': {'type': 'integer'},
        
        // Multi-language names (all searchable)
        'nameEn': {'type': 'text', 'analyzer': 'english'},
        'nameAr': {'type': 'text', 'analyzer': 'arabic'},
        'nameFr': {'type': 'text', 'analyzer': 'french'},
        'nameEs': {'type': 'text', 'analyzer': 'spanish'},
        
        // Combined searchable text
        'searchableText': {'type': 'text'},
        
        // Multi-language descriptions
        'descriptionEn': {'type': 'text', 'analyzer': 'english'},
        'descriptionAr': {'type': 'text', 'analyzer': 'arabic'},
        'descriptionFr': {'type': 'text', 'analyzer': 'french'},
        'descriptionEs': {'type': 'text', 'analyzer': 'spanish'},
        
        // Category info (denormalized)
        'categoryNameEn': {'type': 'keyword'},
        'categoryNameAr': {'type': 'keyword'},
        'categoryNameFr': {'type': 'keyword'},
        'categoryNameEs': {'type': 'keyword'},
        
        // Pricing
        'suggestedPriceMin': {'type': 'float'},
        'suggestedPriceMax': {'type': 'float'},
        
        // Settings
        'isActive': {'type': 'boolean'},
        'isPopular': {'type': 'boolean'},
        'displayOrder': {'type': 'integer'},
        
        // Visual
        'iconName': {'type': 'keyword'},
        'imageUrl': {'type': 'keyword', 'index': false},
        
        // Semantic search (ELSER)
        'semantic_description': {
          'type': 'semantic_text',
          'inference_id': 'awhar-elser',
        },
        
        // Timestamps
        'createdAt': {'type': 'date'},
        'updatedAt': {'type': 'date'},
      }
    }
  };

  /// Mapping for awhar-driver-services index
  /// Contains services offered by individual drivers
  static const Map<String, dynamic> driverServices = {
    'mappings': {
      'properties': {
        'driverServiceId': {'type': 'integer'},
        'driverId': {'type': 'integer'},
        'serviceId': {'type': 'integer'},
        'categoryId': {'type': 'integer'},
        
        // Driver info (denormalized for search)
        'driverName': {'type': 'text', 'fields': {'keyword': {'type': 'keyword'}}},
        'driverRating': {'type': 'float'},
        'driverIsOnline': {'type': 'boolean'},
        'driverIsVerified': {'type': 'boolean'},
        'driverLocation': {'type': 'geo_point'},
        
        // Service info
        'title': {'type': 'text'},
        'description': {'type': 'text'},
        'customDescription': {'type': 'text'},
        'serviceName': {'type': 'keyword'},
        'categoryName': {'type': 'keyword'},
        
        // Pricing
        'priceType': {'type': 'keyword'},
        'basePrice': {'type': 'float'},
        'pricePerKm': {'type': 'float'},
        'pricePerHour': {'type': 'float'},
        'minPrice': {'type': 'float'},
        
        // Analytics
        'viewCount': {'type': 'integer'},
        'inquiryCount': {'type': 'integer'},
        'bookingCount': {'type': 'integer'},
        
        // Availability
        'isActive': {'type': 'boolean'},
        'isAvailable': {'type': 'boolean'},
        
        // Timestamps
        'createdAt': {'type': 'date'},
        'updatedAt': {'type': 'date'},
      }
    }
  };

  /// Mapping for awhar-requests index
  /// Contains service requests for analytics and history
  static const Map<String, dynamic> requests = {
    'mappings': {
      'properties': {
        'requestId': {'type': 'integer'},
        'clientId': {'type': 'integer'},
        'driverId': {'type': 'integer'},
        
        // Client info
        'clientName': {'type': 'keyword'},
        
        // Driver info
        'driverName': {'type': 'keyword'},
        
        // Service info
        'serviceType': {'type': 'keyword'},
        'status': {'type': 'keyword'},
        
        // Locations
        'pickupLocation': {'type': 'geo_point'},
        'destinationLocation': {'type': 'geo_point'},
        
        // Pricing
        'basePrice': {'type': 'float'},
        'totalPrice': {'type': 'float'},
        'agreedPrice': {'type': 'float'},
        'currency': {'type': 'keyword'},
        
        // Distance & Duration
        'distance': {'type': 'float'},  // in km
        'estimatedDuration': {'type': 'integer'},  // in minutes
        
        // Details
        'itemDescription': {'type': 'text'},
        'specialInstructions': {'type': 'text'},
        'packageSize': {'type': 'keyword'},
        
        // Fraud Detection
        'deviceFingerprint': {'type': 'keyword'},  // SHA-256 hash for fraud correlation
        
        // Cancellation info
        'cancelledBy': {'type': 'integer'},
        'cancellationReason': {'type': 'text'},
        
        // Computed fields for analytics
        'isCompleted': {'type': 'boolean'},
        'isCancelled': {'type': 'boolean'},
        'durationMinutes': {'type': 'integer'},  // Actual duration
        
        // Timestamps (critical for time-series)
        'createdAt': {'type': 'date'},
        'acceptedAt': {'type': 'date'},
        'startedAt': {'type': 'date'},
        'completedAt': {'type': 'date'},
        'cancelledAt': {'type': 'date'},
      }
    }
  };

  /// Mapping for awhar-stores index
  /// Contains store information for discovery
  static const Map<String, dynamic> stores = {
    'mappings': {
      'properties': {
        'storeId': {'type': 'integer'},
        'userId': {'type': 'integer'},
        'storeCategoryId': {'type': 'integer'},
        
        // Basic info
        'name': {'type': 'text', 'fields': {'keyword': {'type': 'keyword'}}},
        'description': {'type': 'text'},
        'phone': {'type': 'keyword'},
        'email': {'type': 'keyword'},
        
        // Category
        'categoryName': {'type': 'keyword'},
        
        // Location
        'location': {'type': 'geo_point'},
        'address': {'type': 'text'},
        'city': {'type': 'keyword'},
        
        // Delivery settings
        'deliveryRadiusKm': {'type': 'float'},
        'minimumOrderAmount': {'type': 'float'},
        'estimatedPrepTimeMinutes': {'type': 'integer'},
        
        // Status
        'isActive': {'type': 'boolean'},
        'isOpen': {'type': 'boolean'},
        
        // Stats
        'totalOrders': {'type': 'integer'},
        'rating': {'type': 'float'},
        'totalRatings': {'type': 'integer'},
        
        // Product count (for display)
        'productCount': {'type': 'integer'},
        
        // Semantic search (ELSER)
        'semantic_description': {
          'type': 'semantic_text',
          'inference_id': 'awhar-elser',
        },
        
        // Timestamps
        'createdAt': {'type': 'date'},
        'updatedAt': {'type': 'date'},
      }
    }
  };

  /// Mapping for awhar-products index
  /// Contains store products for search
  static const Map<String, dynamic> products = {
    'mappings': {
      'properties': {
        'productId': {'type': 'integer'},
        'storeId': {'type': 'integer'},
        'productCategoryId': {'type': 'integer'},
        
        // Store info (denormalized)
        'storeName': {'type': 'keyword'},
        'storeLocation': {'type': 'geo_point'},
        'storeIsOpen': {'type': 'boolean'},
        
        // Product info
        'name': {'type': 'text', 'fields': {'keyword': {'type': 'keyword'}}},
        'description': {'type': 'text'},
        'categoryName': {'type': 'keyword'},
        
        // Pricing
        'price': {'type': 'float'},
        
        // Status
        'isAvailable': {'type': 'boolean'},
        'displayOrder': {'type': 'integer'},
        
        // Visual
        'imageUrl': {'type': 'keyword', 'index': false},
        
        // Semantic search (ELSER)
        'semantic_description': {
          'type': 'semantic_text',
          'inference_id': 'awhar-elser',
        },
        
        // Timestamps
        'createdAt': {'type': 'date'},
        'updatedAt': {'type': 'date'},
      }
    }
  };

  /// Mapping for awhar-store-orders index
  /// Contains store orders for analytics and tracking
  static const Map<String, dynamic> storeOrders = {
    'mappings': {
      'properties': {
        'id': {'type': 'integer'},
        'orderNumber': {'type': 'keyword'},
        'storeId': {'type': 'integer'},
        'clientId': {'type': 'integer'},
        'driverId': {'type': 'integer'},
        'status': {'type': 'keyword'},
        
        // Store info (denormalized)
        'storeName': {'type': 'keyword'},
        'storeLogoUrl': {'type': 'keyword', 'index': false},
        'storeLocation': {'type': 'geo_point'},
        
        // Client info
        'clientName': {'type': 'keyword'},
        'clientPhone': {'type': 'keyword'},
        
        // Driver info
        'driverName': {'type': 'keyword'},
        'driverPhone': {'type': 'keyword'},
        
        // Delivery location
        'deliveryAddress': {'type': 'text'},
        'deliveryLocation': {'type': 'geo_point'},
        'deliveryDistance': {'type': 'float'},
        
        // Pricing
        'subtotal': {'type': 'float'},
        'deliveryFee': {'type': 'float'},
        'total': {'type': 'float'},
        'currency': {'type': 'keyword'},
        'currencySymbol': {'type': 'keyword'},
        'platformCommission': {'type': 'float'},
        'driverEarnings': {'type': 'float'},
        
        // Order details
        'itemCount': {'type': 'integer'},
        'items': {'type': 'nested', 'properties': {
          'productId': {'type': 'integer'},
          'name': {'type': 'keyword'},
          'quantity': {'type': 'integer'},
          'price': {'type': 'float'},
        }},
        'clientNotes': {'type': 'text'},
        'storeNotes': {'type': 'text'},
        
        // Cancellation info
        'cancelledBy': {'type': 'keyword'},
        'cancellationReason': {'type': 'text'},
        
        // Timestamps for analytics
        'createdAt': {'type': 'date'},
        'confirmedAt': {'type': 'date'},
        'readyAt': {'type': 'date'},
        'pickedUpAt': {'type': 'date'},
        'deliveredAt': {'type': 'date'},
        'cancelledAt': {'type': 'date'},
      }
    }
  };

  /// Mapping for awhar-reviews index
  /// Contains reviews for sentiment analysis
  static const Map<String, dynamic> reviews = {
    'mappings': {
      'properties': {
        'reviewId': {'type': 'integer'},
        'orderId': {'type': 'integer'},
        'driverId': {'type': 'integer'},
        'clientId': {'type': 'integer'},
        
        // Parties
        'driverName': {'type': 'keyword'},
        'clientName': {'type': 'keyword'},
        
        // Rating
        'rating': {'type': 'integer'},
        
        // Comment (full-text searchable)
        'comment': {'type': 'text'},
        
        // Driver response
        'driverResponse': {'type': 'text'},
        
        // Status
        'isVisible': {'type': 'boolean'},
        'isFlagged': {'type': 'boolean'},
        
        // Timestamps
        'createdAt': {'type': 'date'},
      }
    }
  };

  /// Mapping for awhar-search-logs index
  /// Contains search analytics data
  static const Map<String, dynamic> searchLogs = {
    'mappings': {
      'properties': {
        'logId': {'type': 'keyword'},
        'userId': {'type': 'integer'},
        
        // Search info
        'query': {'type': 'text', 'fields': {'keyword': {'type': 'keyword'}}},
        'searchType': {'type': 'keyword'},  // drivers, services, stores, products
        'resultsCount': {'type': 'integer'},
        
        // Location context
        'userLocation': {'type': 'geo_point'},
        
        // Filters used
        'filters': {'type': 'object', 'enabled': false},  // Store as JSON, don't index
        
        // Click-through
        'clickedResultId': {'type': 'integer'},
        'clickedResultType': {'type': 'keyword'},
        
        // Timestamp
        'timestamp': {'type': 'date'},
      }
    }
  };

  /// Mapping for awhar-analytics index
  /// Contains app analytics events from PostHog/Firebase sync and backend events
  static const Map<String, dynamic> analytics = {
    'mappings': {
      'properties': {
        // Event identification
        'eventId': {'type': 'keyword'},
        'eventName': {'type': 'keyword'},
        'eventType': {'type': 'keyword'},  // client, driver, engagement, error, business
        
        // User context
        'userId': {'type': 'integer'},
        'userRole': {'type': 'keyword'},  // client, driver
        'sessionId': {'type': 'keyword'},
        'deviceId': {'type': 'keyword'},
        
        // Location context
        'location': {'type': 'geo_point'},
        'city': {'type': 'keyword'},
        'country': {'type': 'keyword'},
        
        // Screen/UI context
        'screenName': {'type': 'keyword'},
        'previousScreen': {'type': 'keyword'},
        
        // Event properties (flexible)
        'properties': {
          'type': 'object',
          'enabled': true,
          'properties': {
            // Common properties
            'query': {'type': 'text'},
            'category': {'type': 'keyword'},
            'serviceType': {'type': 'keyword'},
            'driverId': {'type': 'integer'},
            'requestId': {'type': 'integer'},
            'orderId': {'type': 'integer'},
            'storeId': {'type': 'integer'},
            'productId': {'type': 'integer'},
            
            // Numeric properties
            'price': {'type': 'float'},
            'amount': {'type': 'float'},
            'rating': {'type': 'float'},
            'duration': {'type': 'integer'},
            'count': {'type': 'integer'},
            'resultsCount': {'type': 'integer'},
            'responseTime': {'type': 'integer'},
            
            // Boolean properties
            'success': {'type': 'boolean'},
            'hasText': {'type': 'boolean'},
            'hasPhoto': {'type': 'boolean'},
            'hasAudio': {'type': 'boolean'},
            
            // String properties
            'errorType': {'type': 'keyword'},
            'errorMessage': {'type': 'text'},
            'buttonName': {'type': 'keyword'},
            'action': {'type': 'keyword'},
            'reason': {'type': 'keyword'},
            'step': {'type': 'keyword'},
            'variant': {'type': 'keyword'},  // A/B test variant
          }
        },
        
        // Business metrics (for aggregations)
        'revenue': {'type': 'float'},
        'commission': {'type': 'float'},
        
        // Device & App context
        'platform': {'type': 'keyword'},  // android, ios, web
        'appVersion': {'type': 'keyword'},
        'osVersion': {'type': 'keyword'},
        'deviceModel': {'type': 'keyword'},
        
        // Source tracking
        'source': {'type': 'keyword'},  // app, backend, posthog, firebase
        'campaign': {'type': 'keyword'},
        'referrer': {'type': 'keyword'},
        
        // Timestamps
        'timestamp': {'type': 'date'},
        'serverTimestamp': {'type': 'date'},
      }
    }
  };
  
  /// Mapping for awhar-device-fingerprints index
  /// Used for fraud detection - tracks device hardware signatures linked to users
  static const Map<String, dynamic> deviceFingerprints = {
    'mappings': {
      'properties': {
        // Fingerprint identification
        'fingerprintHash': {'type': 'keyword'},
        'recordId': {'type': 'integer'},
        
        // Device identifiers
        'deviceId': {'type': 'keyword'},
        'deviceModel': {
          'type': 'text',
          'fields': {
            'keyword': {'type': 'keyword'}
          }
        },
        'deviceBrand': {'type': 'keyword'},
        
        // Screen info
        'screenWidth': {'type': 'integer'},
        'screenHeight': {'type': 'integer'},
        'screenDensity': {'type': 'float'},
        'screenResolution': {'type': 'keyword'},  // e.g., "1080x2400"
        
        // Hardware specs
        'cpuCores': {'type': 'integer'},
        'isPhysicalDevice': {'type': 'boolean'},
        
        // OS info
        'osVersion': {'type': 'keyword'},
        
        // Locale info
        'timezone': {'type': 'keyword'},
        'language': {'type': 'keyword'},
        
        // App info
        'appVersion': {'type': 'keyword'},
        
        // Network info
        'lastIpAddress': {'type': 'ip'},
        
        // User associations (array of user IDs)
        'userIds': {'type': 'integer'},  // Multi-value field
        'userCount': {'type': 'integer'},  // Number of users on this device
        
        // Risk assessment
        'riskScore': {'type': 'float'},
        'riskLevel': {'type': 'keyword'},  // low, medium, high, critical
        'riskFactors': {'type': 'keyword'},  // Multi-value field
        'isBlocked': {'type': 'boolean'},
        
        // Admin notes
        'notes': {'type': 'text'},
        
        // Timestamps
        'firstSeenAt': {'type': 'date'},
        'lastSeenAt': {'type': 'date'},
        'updatedAt': {'type': 'date'},
      }
    }
  };
  
  /// Mapping for awhar-fraud-alerts index
  /// Stores alerts when suspicious activity is detected
  static const Map<String, dynamic> fraudAlerts = {
    'mappings': {
      'properties': {
        // Alert identification
        'alertId': {'type': 'keyword'},
        'alertType': {'type': 'keyword'},  // multi_account, promo_abuse, gps_spoofing, etc.
        
        // Associated entities
        'fingerprintHash': {'type': 'keyword'},
        'userId': {'type': 'integer'},
        'userIds': {'type': 'integer'},  // All users involved
        
        // Risk info
        'riskScore': {'type': 'float'},
        'riskLevel': {'type': 'keyword'},
        'riskFactors': {'type': 'keyword'},
        
        // Alert details
        'description': {'type': 'text'},
        'evidence': {'type': 'object', 'enabled': false},  // Store raw evidence as object
        
        // Action taken
        'actionTaken': {'type': 'keyword'},  // none, warned, blocked, refund_revoked
        'actionBy': {'type': 'keyword'},  // system, admin_<id>
        'actionAt': {'type': 'date'},
        
        // Resolution
        'status': {'type': 'keyword'},  // open, investigating, resolved, false_positive
        'resolution': {'type': 'text'},
        'resolvedBy': {'type': 'keyword'},
        'resolvedAt': {'type': 'date'},
        
        // Timestamps
        'createdAt': {'type': 'date'},
        'updatedAt': {'type': 'date'},
      }
    }
  };

  /// Mapping for awhar-transactions index
  /// Financial transaction data for revenue analytics and ops monitoring
  static const Map<String, dynamic> transactions = {
    'mappings': {
      'properties': {
        // Identifiers
        'transactionId': {'type': 'integer'},
        'userId': {'type': 'integer'},
        'requestId': {'type': 'integer'},
        
        // Transaction details
        'amount': {'type': 'float'},
        'type': {'type': 'keyword'},  // earning, payment, refund, withdrawal
        'status': {'type': 'keyword'},  // pending, completed, refunded, failed
        'paymentMethod': {'type': 'keyword'},  // cash, card, wallet
        'description': {'type': 'text'},
        'notes': {'type': 'text'},
        
        // Financial breakdown
        'platformCommission': {'type': 'float'},
        'driverEarnings': {'type': 'float'},
        'driverConfirmed': {'type': 'boolean'},
        'clientConfirmed': {'type': 'boolean'},
        
        // Currency
        'currency': {'type': 'keyword'},
        'baseCurrencyAmount': {'type': 'float'},
        'exchangeRateToBase': {'type': 'float'},
        'vatRate': {'type': 'float'},
        'vatAmount': {'type': 'float'},
        
        // Denormalized user info
        'userName': {'type': 'keyword'},
        'userRole': {'type': 'keyword'},
        
        // Timestamps
        'createdAt': {'type': 'date'},
        'completedAt': {'type': 'date'},
        'refundedAt': {'type': 'date'},
        'driverConfirmedAt': {'type': 'date'},
        'clientConfirmedAt': {'type': 'date'},
      }
    }
  };

  /// Mapping for awhar-users index
  /// User profiles for segmentation, analytics, and concierge personalization
  static const Map<String, dynamic> users = {
    'mappings': {
      'properties': {
        // Identifiers
        'userId': {'type': 'integer'},
        'fullName': {
          'type': 'text',
          'fields': {
            'keyword': {'type': 'keyword'}
          }
        },
        'phoneNumber': {'type': 'keyword'},
        'email': {'type': 'keyword'},
        
        // Roles and status
        'roles': {'type': 'keyword'},  // Multi-value: client, driver, store
        'isOnline': {'type': 'boolean'},
        'isPhoneVerified': {'type': 'boolean'},
        'isEmailVerified': {'type': 'boolean'},
        
        // Ratings
        'rating': {'type': 'float'},
        'totalRatings': {'type': 'integer'},
        'ratingAsClient': {'type': 'float'},
        'totalRatingsAsClient': {'type': 'integer'},
        
        // Activity
        'totalTrips': {'type': 'integer'},
        
        // Location
        'location': {'type': 'geo_point'},
        'cityName': {'type': 'keyword'},
        'cityId': {'type': 'integer'},
        'defaultAddress': {
          'type': 'text',
          'fields': {
            'keyword': {'type': 'keyword'}
          }
        },
        
        // Preferences
        'preferredLanguage': {'type': 'keyword'},
        'notificationsEnabled': {'type': 'boolean'},
        
        // Status
        'isSuspended': {'type': 'boolean'},
        'suspensionReason': {'type': 'text'},
        'totalReportsReceived': {'type': 'integer'},
        'totalReportsMade': {'type': 'integer'},
        
        // Timestamps
        'createdAt': {'type': 'date'},
        'updatedAt': {'type': 'date'},
        'lastSeenAt': {'type': 'date'},
      }
    }
  };

  /// Mapping for awhar-wallets index
  /// Wallet/financial data for ops monitoring and growth analytics
  static const Map<String, dynamic> wallets = {
    'mappings': {
      'properties': {
        // Identifiers
        'walletId': {'type': 'integer'},
        'userId': {'type': 'integer'},
        
        // Financial data
        'totalEarned': {'type': 'float'},
        'totalSpent': {'type': 'float'},
        'pendingEarnings': {'type': 'float'},
        'balance': {'type': 'float'},  // computed: totalEarned - totalSpent
        'totalTransactions': {'type': 'integer'},
        'completedRides': {'type': 'integer'},
        'totalCommissionPaid': {'type': 'float'},
        'currency': {'type': 'keyword'},
        
        // Denormalized user info
        'userName': {'type': 'keyword'},
        'userRole': {'type': 'keyword'},
        
        // Timestamps
        'createdAt': {'type': 'date'},
        'updatedAt': {'type': 'date'},
        'lastTransactionAt': {'type': 'date'},
      }
    }
  };

  /// Mapping for awhar-ratings index
  /// Combined ratings from service requests and store orders
  static const Map<String, dynamic> ratings = {
    'mappings': {
      'properties': {
        // Identifiers
        'ratingId': {'type': 'integer'},
        'ratingSource': {'type': 'keyword'},  // service_request, store_order
        'requestId': {'type': 'integer'},
        'storeOrderId': {'type': 'integer'},
        
        // Entities
        'raterId': {'type': 'integer'},
        'ratedEntityId': {'type': 'integer'},
        'ratedEntityType': {'type': 'keyword'},  // driver, client, store
        
        // Rating data
        'ratingValue': {'type': 'integer'},
        'comment': {'type': 'text'},
        'response': {'type': 'text'},
        
        // Denormalized names
        'raterName': {'type': 'keyword'},
        'ratedEntityName': {'type': 'keyword'},
        
        // Computed/derived
        'sentiment': {'type': 'keyword'},  // positive, neutral, negative
        'sentimentScore': {'type': 'float'},  // -1.0 to 1.0
        'hasComment': {'type': 'boolean'},
        'hasResponse': {'type': 'boolean'},
        
        // Timestamps
        'createdAt': {'type': 'date'},
        'responseAt': {'type': 'date'},
      }
    }
  };

  /// Mapping for awhar-knowledge-base index
  /// FAQ, policies, and guides for RAG retrieval by the Concierge agent
  static const Map<String, dynamic> knowledgeBase = {
    'mappings': {
      'properties': {
        // Document identification
        'docId': {'type': 'keyword'},
        'title': {'type': 'text', 'fields': {'keyword': {'type': 'keyword'}}},
        
        // Semantic content (ELSER-powered)
        'content': {
          'type': 'semantic_text',
          'inference_id': 'awhar-elser',
        },
        
        // Classification
        'category': {'type': 'keyword'},  // payments, orders, drivers, stores, account, services, cities
        'language': {'type': 'keyword'},  // en, ar, fr, es
        'tags': {'type': 'keyword'},  // Multi-value field
        
        // Timestamps
        'createdAt': {'type': 'date'},
        'updatedAt': {'type': 'date'},
      }
    }
  };

  /// Mapping for awhar-notifications index
  /// AI-powered notification planner logs — tracks what was sent,
  /// delivery status, open/click rates, and agent reasoning.
  static const Map<String, dynamic> notifications = {
    'mappings': {
      'properties': {
        'notificationId': {'type': 'keyword'},
        'userId': {'type': 'integer'},
        'userRole': {'type': 'keyword'},
        'userName': {
          'type': 'text',
          'fields': {'keyword': {'type': 'keyword'}}
        },

        // Notification content
        'type': {'type': 'keyword'},       // re_engagement, abandoned_funnel, rating_reminder,
                                            // driver_demand, milestone, churn_prevention, onboarding
        'title': {'type': 'text', 'fields': {'keyword': {'type': 'keyword'}}},
        'body': {'type': 'text'},
        'channel': {'type': 'keyword'},     // push, in_app, sms
        'priority': {'type': 'keyword'},    // high, medium, low

        // Agent reasoning
        'triggerReason': {'type': 'text'},  // "No activity for 3 days"
        'agentCycleId': {'type': 'keyword'},// Links to agent conversation_id

        // Delivery tracking
        'status': {'type': 'keyword'},      // planned, sent, delivered, opened, clicked, failed
        'fcmSuccess': {'type': 'boolean'},

        // Engagement tracking
        'actionTaken': {'type': 'keyword'}, // opened_app, created_request, went_online, rated, none

        // Timestamps
        'plannedAt': {'type': 'date'},
        'sentAt': {'type': 'date'},
        'deliveredAt': {'type': 'date'},
        'openedAt': {'type': 'date'},
        'clickedAt': {'type': 'date'},
        'createdAt': {'type': 'date'},
      }
    }
  };
}
