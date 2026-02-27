import 'dart:convert';
import 'package:serverpod/serverpod.dart' hide Transaction;
import 'package:awhar_server/src/generated/protocol.dart';
import 'documents/documents.dart';

/// Data transformation layer for converting Serverpod models to ES documents
class ElasticsearchTransformer {
  
  /// Transform DriverProfile to ES document
  static Future<EsDriverDocument> transformDriver(
    Session session,
    DriverProfile driver, {
    User? user,
    List<String>? serviceCategories,
    List<int>? serviceCategoryIds,
    String? cityName,
  }) async {
    // Fetch user if not provided
    User? driverUser = user;
    if (driverUser == null) {
      driverUser = await User.db.findById(session, driver.userId);
    }
    
    // Get city name if base city is set
    String? baseCityName = cityName;
    if (baseCityName == null && driver.baseCityId != null) {
      final city = await City.db.findById(session, driver.baseCityId!);
      baseCityName = city?.nameEn;
    }
    
    // Get service categories if not provided
    List<String> categories = serviceCategories ?? [];
    List<int> categoryIds = serviceCategoryIds ?? [];
    if (categories.isEmpty) {
      final driverServices = await DriverService.db.find(
        session,
        where: (t) => t.driverId.equals(driver.id!) & t.isActive.equals(true),
      );
      
      final catIds = driverServices
          .where((ds) => ds.categoryId != null)
          .map((ds) => ds.categoryId!)
          .toSet()
          .toList();
      
      if (catIds.isNotEmpty) {
        final cats = await ServiceCategory.db.find(
          session,
          where: (t) => t.id.inSet(catIds.toSet()),
        );
        // ServiceCategory has 'name' field, not 'nameEn'
        categories = cats.map((c) => c.name).toList();
        categoryIds = catIds;
      }
    }
    
    return EsDriverDocument(
      userId: driver.userId,
      email: driverUser?.email,
      displayName: driver.displayName,
      bio: driver.bio,
      profilePhotoUrl: driver.profilePhotoUrl,
      vehicleType: driver.vehicleType?.name,
      vehiclePlate: driver.vehiclePlate,
      vehicleMake: driver.vehicleMake,
      vehicleModel: driver.vehicleModel,
      location: _buildLocation(driver.lastLocationLat, driver.lastLocationLng),
      ratingAverage: driver.ratingAverage,
      ratingCount: driver.ratingCount,
      isOnline: driver.isOnline,
      isVerified: driver.isVerified,
      isPremium: driver.isPremium,
      isFeatured: driver.isFeatured,
      totalCompletedOrders: driver.totalCompletedOrders,
      experienceYears: driver.experienceYears,
      serviceCategories: categories,
      serviceCategoryIds: categoryIds,
      baseCityName: baseCityName,
      baseCityId: driver.baseCityId,
      createdAt: driver.createdAt,
      updatedAt: driver.updatedAt,
    );
  }

  /// Transform Service to ES document
  static Future<EsServiceDocument> transformService(
    Session session,
    Service service, {
    String? categoryName,
  }) async {
    String? catName = categoryName;
    if (catName == null) {
      final category = await Category.db.findById(session, service.categoryId);
      catName = category?.nameEn;
    }
    
    return EsServiceDocument(
      id: service.id!,
      categoryId: service.categoryId,
      categoryName: catName,
      nameEn: service.nameEn,
      nameAr: service.nameAr,
      nameFr: service.nameFr,
      nameEs: service.nameEs,
      descriptionEn: service.descriptionEn,
      descriptionAr: service.descriptionAr,
      descriptionFr: service.descriptionFr,
      descriptionEs: service.descriptionEs,
      iconName: service.iconName,
      imageUrl: service.imageUrl,
      suggestedPriceMin: service.suggestedPriceMin,
      suggestedPriceMax: service.suggestedPriceMax,
      isActive: service.isActive,
      isPopular: service.isPopular,
      displayOrder: service.displayOrder,
      createdAt: service.createdAt,
      updatedAt: service.updatedAt,
    );
  }

  /// Transform DriverService to ES document
  static Future<EsDriverServiceDocument> transformDriverService(
    Session session,
    DriverService driverService, {
    DriverProfile? driver,
    Service? service,
    ServiceCategory? category,
  }) async {
    // Fetch related data if not provided
    DriverProfile? driverProfile = driver;
    if (driverProfile == null) {
      driverProfile = await DriverProfile.db.findFirstRow(
        session,
        where: (t) => t.id.equals(driverService.driverId),
      );
    }
    
    Service? svc = service;
    if (svc == null) {
      svc = await Service.db.findById(session, driverService.serviceId);
    }
    
    ServiceCategory? cat = category;
    if (cat == null && driverService.categoryId != null) {
      cat = await ServiceCategory.db.findById(session, driverService.categoryId!);
    }
    
    return EsDriverServiceDocument(
      id: driverService.id!,
      driverId: driverService.driverId,
      serviceId: driverService.serviceId,
      categoryId: driverService.categoryId,
      driverName: driverProfile?.displayName,
      driverPhoto: driverProfile?.profilePhotoUrl,
      driverRating: driverProfile?.ratingAverage,
      driverIsVerified: driverProfile?.isVerified,
      driverIsPremium: driverProfile?.isPremium,
      driverIsOnline: driverProfile?.isOnline,
      serviceName: svc?.nameEn,
      // ServiceCategory has 'name' field, not 'nameEn'
      categoryName: cat?.name,
      title: driverService.title,
      description: driverService.description ?? driverService.customDescription,
      imageUrl: driverService.imageUrl,
      priceType: driverService.priceType?.name,
      basePrice: driverService.basePrice,
      pricePerKm: driverService.pricePerKm,
      pricePerHour: driverService.pricePerHour,
      minPrice: driverService.minPrice,
      location: _buildLocation(
        driverProfile?.lastLocationLat,
        driverProfile?.lastLocationLng,
      ),
      viewCount: driverService.viewCount,
      inquiryCount: driverService.inquiryCount,
      bookingCount: driverService.bookingCount,
      isAvailable: driverService.isAvailable,
      isActive: driverService.isActive,
      displayOrder: driverService.displayOrder,
      createdAt: driverService.createdAt,
      updatedAt: driverService.updatedAt,
    );
  }

  /// Transform ServiceRequest to ES document
  static EsRequestDocument transformRequest(ServiceRequest request) {
    return EsRequestDocument(
      id: request.id!,
      clientId: request.clientId,
      driverId: request.driverId,
      serviceType: request.serviceType.name,
      status: request.status.name,
      clientName: request.clientName,
      clientPhone: request.clientPhone,
      driverName: request.driverName,
      driverPhone: request.driverPhone,
      pickupLocation: request.pickupLocation != null
          ? _buildLocation(
              request.pickupLocation!.latitude,
              request.pickupLocation!.longitude,
            )
          : null,
      destinationLocation: _buildLocation(
        request.destinationLocation.latitude,
        request.destinationLocation.longitude,
      ),
      basePrice: request.basePrice,
      totalPrice: request.totalPrice,
      agreedPrice: request.agreedPrice,
      currency: request.currency,
      currencySymbol: request.currencySymbol,
      itemDescription: request.itemDescription,
      specialInstructions: request.specialInstructions,
      isPurchaseRequired: request.isPurchaseRequired,
      isFragile: request.isFragile,
      distance: request.distance,
      estimatedDuration: request.estimatedDuration,
      createdAt: request.createdAt,
      acceptedAt: request.acceptedAt,
      startedAt: request.startedAt,
      completedAt: request.completedAt,
      cancelledAt: request.cancelledAt,
      cancelledBy: request.cancelledBy,
      cancellationReason: request.cancellationReason,
      deviceFingerprint: request.deviceFingerprint,
    );
  }

  /// Transform Store to ES document
  static Future<EsStoreDocument> transformStore(
    Session session,
    Store store, {
    StoreCategory? category,
    int? productCount,
  }) async {
    StoreCategory? cat = category;
    if (cat == null) {
      cat = await StoreCategory.db.findById(session, store.storeCategoryId);
    }
    
    // Get product count if not provided
    int prodCount = productCount ?? 0;
    if (productCount == null) {
      prodCount = await StoreProduct.db.count(
        session,
        where: (t) => t.storeId.equals(store.id!) & t.isAvailable.equals(true),
      );
    }
    
    // Store ratings are directly on the Store model
    return EsStoreDocument(
      id: store.id!,
      userId: store.userId,
      storeCategoryId: store.storeCategoryId,
      categoryName: cat?.nameEn,
      name: store.name,
      description: store.description,
      aboutText: store.aboutText,
      tagline: store.tagline,
      phone: store.phone,
      email: store.email,
      whatsappNumber: store.whatsappNumber,
      logoUrl: store.logoUrl,
      coverImageUrl: store.coverImageUrl,
      address: store.address,
      location: _buildLocation(store.latitude, store.longitude)!,
      city: store.city,
      deliveryRadiusKm: store.deliveryRadiusKm,
      minimumOrderAmount: store.minimumOrderAmount,
      estimatedPrepTimeMinutes: store.estimatedPrepTimeMinutes,
      acceptsCash: store.acceptsCash,
      acceptsCard: store.acceptsCard,
      hasDelivery: store.hasDelivery,
      hasPickup: store.hasPickup,
      isActive: store.isActive,
      // Store model doesn't have isVerified/isFeatured, set to false
      isVerified: false,
      isFeatured: false,
      ratingAverage: store.rating,
      ratingCount: store.totalRatings,
      productCount: prodCount,
      createdAt: store.createdAt,
      updatedAt: store.updatedAt,
    );
  }

  /// Transform StoreProduct to ES document
  static Future<EsProductDocument> transformProduct(
    Session session,
    StoreProduct product, {
    Store? store,
    ProductCategory? category,
  }) async {
    Store? productStore = store;
    if (productStore == null) {
      productStore = await Store.db.findById(session, product.storeId);
    }
    
    ProductCategory? cat = category;
    if (cat == null && product.productCategoryId != null) {
      cat = await ProductCategory.db.findById(session, product.productCategoryId!);
    }
    
    return EsProductDocument(
      id: product.id!,
      storeId: product.storeId,
      productCategoryId: product.productCategoryId,
      storeName: productStore?.name,
      storeLogoUrl: productStore?.logoUrl,
      storeLocation: productStore != null
          ? _buildLocation(productStore.latitude, productStore.longitude)
          : null,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      categoryName: cat?.name,
      isAvailable: product.isAvailable,
      displayOrder: product.displayOrder,
      createdAt: product.createdAt,
      updatedAt: product.updatedAt,
    );
  }

  /// Transform Review to ES document
  static Future<EsReviewDocument> transformReview(
    Session session,
    Review review, {
    DriverProfile? driver,
  }) async {
    DriverProfile? driverProfile = driver;
    if (driverProfile == null) {
      driverProfile = await DriverProfile.db.findById(session, review.driverId);
    }
    
    // Get client name from User table
    String? clientName;
    final clientUser = await User.db.findById(session, review.clientId);
    clientName = clientUser?.fullName;
    
    return EsReviewDocument(
      id: review.id!,
      orderId: review.orderId,
      driverId: review.driverId,
      clientId: review.clientId,
      driverName: driverProfile?.displayName,
      driverPhoto: driverProfile?.profilePhotoUrl,
      clientName: clientName,
      rating: review.rating,
      comment: review.comment,
      driverResponse: review.driverResponse,
      sentiment: null, // Will be computed by AI
      sentimentScore: null,
      isVisible: review.isVisible,
      isVerified: review.isVerified,
      isFlagged: review.isFlagged,
      flagReason: review.flagReason,
      createdAt: review.createdAt,
      updatedAt: review.updatedAt,
      driverRespondedAt: review.driverRespondedAt,
    );
  }

  /// Transform StoreOrder to ES document
  static Future<EsStoreOrderDocument> transformStoreOrder(
    Session session,
    StoreOrder order, {
    Store? store,
    User? client,
    DriverProfile? driver,
  }) async {
    // Fetch store if not provided
    Store? orderStore = store;
    if (orderStore == null) {
      orderStore = await Store.db.findById(session, order.storeId);
    }
    
    // Fetch client info
    User? clientUser = client;
    if (clientUser == null) {
      clientUser = await User.db.findById(session, order.clientId);
    }
    
    // Fetch driver info if assigned
    DriverProfile? driverProfile = driver;
    User? driverUser;
    if (order.driverId != null) {
      if (driverProfile == null) {
        driverProfile = await DriverProfile.db.findFirstRow(
          session,
          where: (t) => t.userId.equals(order.driverId!),
        );
      }
      // Also fetch driver's user for phone number
      driverUser = await User.db.findById(session, order.driverId!);
    }
    
    // Parse items from JSON
    List<Map<String, dynamic>>? items;
    int itemCount = 0;
    try {
      if (order.itemsJson.isNotEmpty) {
        final decoded = _parseItemsJson(order.itemsJson);
        items = decoded;
        itemCount = decoded.length;
      }
    } catch (e) {
      // Ignore JSON parsing errors
    }
    
    return EsStoreOrderDocument(
      id: order.id!,
      orderNumber: order.orderNumber,
      storeId: order.storeId,
      clientId: order.clientId,
      driverId: order.driverId,
      status: order.status.name,
      storeName: orderStore?.name,
      storeLogoUrl: orderStore?.logoUrl,
      storeLocation: orderStore != null
          ? _buildLocation(orderStore.latitude, orderStore.longitude)
          : null,
      clientName: clientUser?.fullName,
      clientPhone: clientUser?.phoneNumber,
      driverName: driverProfile?.displayName,
      driverPhone: driverUser?.phoneNumber,
      deliveryAddress: order.deliveryAddress,
      deliveryLocation: _buildLocation(
        order.deliveryLatitude,
        order.deliveryLongitude,
      )!,
      deliveryDistance: order.deliveryDistance,
      subtotal: order.subtotal,
      deliveryFee: order.deliveryFee,
      total: order.total,
      currency: order.currency,
      currencySymbol: order.currencySymbol,
      platformCommission: order.platformCommission,
      driverEarnings: order.driverEarnings,
      itemCount: itemCount,
      items: items,
      clientNotes: order.clientNotes,
      storeNotes: order.storeNotes,
      cancelledBy: order.cancelledBy,
      cancellationReason: order.cancellationReason,
      createdAt: order.createdAt,
      confirmedAt: order.confirmedAt,
      readyAt: order.readyAt,
      pickedUpAt: order.pickedUpAt,
      deliveredAt: order.deliveredAt,
      cancelledAt: order.cancelledAt,
    );
  }

  /// Helper to build geo_point location
  static Map<String, double>? _buildLocation(double? lat, double? lon) {
    if (lat == null || lon == null) return null;
    return {'lat': lat, 'lon': lon};
  }

  /// Helper to parse items JSON
  static List<Map<String, dynamic>> _parseItemsJson(String jsonString) {
    try {
      final decoded = jsonDecode(jsonString);
      if (decoded is List) {
        return decoded.map((e) => e as Map<String, dynamic>).toList();
      }
    } catch (e) {
      // Ignore parsing errors
    }
    return [];
  }

  /// Transform Transaction to ES document
  static Future<EsTransactionDocument> transformTransaction(
    Session session,
    Transaction transaction, {
    User? user,
  }) async {
    // Fetch user if not provided
    User? txUser = user;
    if (txUser == null) {
      txUser = await User.db.findById(session, transaction.userId);
    }
    
    // Determine user role from roles list
    String? userRole;
    if (txUser != null) {
      if (txUser.roles.contains(UserRole.driver)) {
        userRole = 'driver';
      } else if (txUser.roles.contains(UserRole.store)) {
        userRole = 'store';
      } else {
        userRole = 'client';
      }
    }
    
    return EsTransactionDocument(
      id: transaction.id!,
      userId: transaction.userId,
      requestId: transaction.requestId,
      amount: transaction.amount,
      type: transaction.type.name,
      status: transaction.status.name,
      paymentMethod: transaction.paymentMethod,
      description: transaction.description,
      notes: transaction.notes,
      platformCommission: transaction.platformCommission,
      driverEarnings: transaction.driverEarnings,
      driverConfirmed: transaction.driverConfirmed,
      clientConfirmed: transaction.clientConfirmed,
      currency: transaction.currency,
      baseCurrencyAmount: transaction.baseCurrencyAmount,
      exchangeRateToBase: transaction.exchangeRateToBase,
      vatRate: transaction.vatRate,
      vatAmount: transaction.vatAmount,
      userName: txUser?.fullName,
      userRole: userRole,
      createdAt: transaction.createdAt,
      completedAt: transaction.completedAt,
      refundedAt: transaction.refundedAt,
      driverConfirmedAt: transaction.driverConfirmedAt,
      clientConfirmedAt: transaction.clientConfirmedAt,
    );
  }

  /// Transform User to ES document
  static Future<EsUserDocument> transformUser(
    Session session,
    User user,
  ) async {
    // Build roles list from UserRole enum
    final List<String> roles = user.roles.map((r) => r.name).toList();
    
    // Lookup city name and default address from user_clients
    String? cityName;
    int? cityId;
    String? defaultAddress;
    
    final userClients = await UserClient.db.find(
      session,
      where: (t) => t.userId.equals(user.id!),
      limit: 1,
    );
    
    if (userClients.isNotEmpty) {
      final uc = userClients.first;
      cityId = uc.defaultCityId;
      
      if (cityId != null) {
        final city = await City.db.findById(session, cityId);
        cityName = city?.nameEn;
      }
      
      if (uc.defaultAddressId != null) {
        final address = await Address.db.findById(session, uc.defaultAddressId!);
        defaultAddress = address?.label ?? address?.fullAddress;
      }
    }
    
    return EsUserDocument(
      id: user.id!,
      fullName: user.fullName,
      phoneNumber: user.phoneNumber,
      email: user.email,
      roles: roles,
      isOnline: user.isOnline,
      isPhoneVerified: user.isPhoneVerified,
      isEmailVerified: user.isEmailVerified,
      rating: user.rating ?? 0.0,
      totalRatings: user.totalRatings,
      ratingAsClient: user.ratingAsClient ?? 0.0,
      totalRatingsAsClient: user.totalRatingsAsClient,
      totalTrips: user.totalTrips,
      location: _buildLocation(user.currentLatitude, user.currentLongitude),
      cityName: cityName,
      cityId: cityId,
      defaultAddress: defaultAddress,
      preferredLanguage: user.preferredLanguage?.name,
      notificationsEnabled: user.notificationsEnabled,
      isSuspended: user.isSuspended,
      suspensionReason: user.suspensionReason,
      totalReportsReceived: user.totalReportsReceived,
      totalReportsMade: user.totalReportsMade,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
      lastSeenAt: user.lastSeenAt,
    );
  }

  /// Transform Wallet to ES document
  static Future<EsWalletDocument> transformWallet(
    Session session,
    Wallet wallet, {
    User? user,
  }) async {
    // Fetch user if not provided
    User? walletUser = user;
    if (walletUser == null) {
      walletUser = await User.db.findById(session, wallet.userId);
    }
    
    String? userRole;
    if (walletUser != null) {
      if (walletUser.roles.contains(UserRole.driver)) {
        userRole = 'driver';
      } else if (walletUser.roles.contains(UserRole.store)) {
        userRole = 'store';
      } else {
        userRole = 'client';
      }
    }
    
    return EsWalletDocument(
      id: wallet.id!,
      userId: wallet.userId,
      totalEarned: wallet.totalEarned,
      totalSpent: wallet.totalSpent,
      pendingEarnings: wallet.pendingEarnings,
      totalTransactions: wallet.totalTransactions,
      completedRides: wallet.completedRides,
      totalCommissionPaid: wallet.totalCommissionPaid,
      currency: wallet.currency,
      userName: walletUser?.fullName,
      userRole: userRole,
      createdAt: wallet.createdAt,
      updatedAt: wallet.updatedAt,
      lastTransactionAt: wallet.lastTransactionAt,
    );
  }

  /// Transform Rating to ES document
  /// This handles ratings from service requests (Serverpod Rating model)
  static Future<EsRatingDocument> transformRating(
    Session session,
    Rating rating, {
    User? rater,
    User? ratedUser,
    DriverProfile? ratedDriver,
  }) async {
    // Fetch rater if not provided
    User? raterUser = rater;
    if (raterUser == null) {
      raterUser = await User.db.findById(session, rating.raterId);
    }
    
    // Determine rated entity info
    String? ratedEntityName;
    if (rating.ratingType == RatingType.client_to_driver) {
      // Rating is for a driver
      DriverProfile? driver = ratedDriver;
      if (driver == null) {
        driver = await DriverProfile.db.findFirstRow(
          session,
          where: (t) => t.userId.equals(rating.ratedUserId),
        );
      }
      ratedEntityName = driver?.displayName;
    } else {
      // Rating is for a client (driver_to_client)
      User? rated = ratedUser;
      if (rated == null) {
        rated = await User.db.findById(session, rating.ratedUserId);
      }
      ratedEntityName = rated?.fullName;
    }
    
    final sentiment = EsRatingDocument.computeSentiment(rating.ratingValue);
    final sentimentScore = EsRatingDocument.computeSentimentScore(rating.ratingValue);
    
    return EsRatingDocument(
      id: rating.id!,
      ratingSource: 'service_request',
      requestId: rating.requestId,
      storeOrderId: null,
      raterId: rating.raterId,
      ratedEntityId: rating.ratedUserId,
      ratedEntityType: rating.ratingType.name,
      ratingValue: rating.ratingValue,
      comment: rating.reviewText,
      response: null, // Ratings don't have responses in the model
      raterName: raterUser?.fullName,
      ratedEntityName: ratedEntityName,
      sentiment: sentiment,
      sentimentScore: sentimentScore,
      createdAt: rating.createdAt,
      responseAt: null,
    );
  }

  /// Transform StoreReview to ES document
  static Future<EsRatingDocument> transformStoreReview(
    Session session,
    StoreReview review, {
    User? reviewer,
  }) async {
    // Fetch reviewer if not provided
    User? reviewerUser = reviewer;
    if (reviewerUser == null) {
      reviewerUser = await User.db.findById(session, review.reviewerId);
    }
    
    // Fetch the reviewee name (store or driver)
    String? ratedEntityName;
    if (review.revieweeType == 'store') {
      final store = await Store.db.findById(session, review.revieweeId);
      ratedEntityName = store?.name;
    } else if (review.revieweeType == 'driver') {
      final driver = await DriverProfile.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(review.revieweeId),
      );
      ratedEntityName = driver?.displayName;
    }
    
    final sentiment = EsRatingDocument.computeSentiment(review.rating);
    final sentimentScore = EsRatingDocument.computeSentimentScore(review.rating);
    
    return EsRatingDocument(
      id: review.id!,
      ratingSource: 'store_review',
      requestId: null,
      storeOrderId: review.storeOrderId,
      raterId: review.reviewerId,
      ratedEntityId: review.revieweeId,
      ratedEntityType: review.revieweeType,
      ratingValue: review.rating,
      comment: review.comment,
      response: review.response,
      raterName: reviewerUser?.fullName,
      ratedEntityName: ratedEntityName,
      sentiment: sentiment,
      sentimentScore: sentimentScore,
      createdAt: review.createdAt,
      responseAt: review.responseAt,
    );
  }
}
