/// Elasticsearch document for stores index
/// Maps Store data for discovery and search
class EsStoreDocument {
  final int id;
  final int userId;
  final int storeCategoryId;
  final String? categoryName;
  
  // Basic info
  final String name;
  final String? description;
  final String? aboutText;
  final String? tagline;
  final String phone;
  final String? email;
  final String? whatsappNumber;
  
  // Visual
  final String? logoUrl;
  final String? coverImageUrl;
  
  // Location
  final String address;
  final Map<String, double> location; // {"lat": x, "lon": y}
  final String? city;
  
  // Delivery settings
  final double deliveryRadiusKm;
  final double? minimumOrderAmount;
  final int estimatedPrepTimeMinutes;
  
  // Options
  final bool acceptsCash;
  final bool acceptsCard;
  final bool hasDelivery;
  final bool hasPickup;
  
  // Status
  final bool isActive;
  final bool isVerified;
  final bool isFeatured;
  
  // Ratings
  final double ratingAverage;
  final int ratingCount;
  final int productCount;
  
  final DateTime createdAt;
  final DateTime updatedAt;

  EsStoreDocument({
    required this.id,
    required this.userId,
    required this.storeCategoryId,
    this.categoryName,
    required this.name,
    this.description,
    this.aboutText,
    this.tagline,
    required this.phone,
    this.email,
    this.whatsappNumber,
    this.logoUrl,
    this.coverImageUrl,
    required this.address,
    required this.location,
    this.city,
    required this.deliveryRadiusKm,
    this.minimumOrderAmount,
    required this.estimatedPrepTimeMinutes,
    required this.acceptsCash,
    required this.acceptsCard,
    required this.hasDelivery,
    required this.hasPickup,
    required this.isActive,
    required this.isVerified,
    required this.isFeatured,
    required this.ratingAverage,
    required this.ratingCount,
    required this.productCount,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'storeCategoryId': storeCategoryId,
      'categoryName': categoryName,
      'name': name,
      'description': description,
      'aboutText': aboutText,
      'tagline': tagline,
      'phone': phone,
      'email': email,
      'whatsappNumber': whatsappNumber,
      'logoUrl': logoUrl,
      'coverImageUrl': coverImageUrl,
      'address': address,
      'location': location,
      'city': city,
      'deliveryRadiusKm': deliveryRadiusKm,
      'minimumOrderAmount': minimumOrderAmount,
      'estimatedPrepTimeMinutes': estimatedPrepTimeMinutes,
      'acceptsCash': acceptsCash,
      'acceptsCard': acceptsCard,
      'hasDelivery': hasDelivery,
      'hasPickup': hasPickup,
      'isActive': isActive,
      'isVerified': isVerified,
      'isFeatured': isFeatured,
      'ratingAverage': ratingAverage,
      'ratingCount': ratingCount,
      'productCount': productCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'searchableText': _buildSearchableText(),
      // ELSER semantic search field
      'semantic_description': _buildSemanticDescription(),
    };
  }

  String _buildSearchableText() {
    final parts = <String>[
      name,
      if (description != null) description!,
      if (aboutText != null) aboutText!,
      if (tagline != null) tagline!,
      if (categoryName != null) categoryName!,
      if (city != null) city!,
      address,
    ];
    return parts.join(' ');
  }

  /// Build rich semantic description for ELSER inference
  String _buildSemanticDescription() {
    final parts = <String>[
      name,
      if (description != null) description!,
      if (categoryName != null) 'Category: $categoryName',
      if (tagline != null) tagline!,
      if (city != null) 'Located in $city',
      if (hasDelivery) 'Offers delivery',
      if (hasPickup) 'Offers pickup',
      'Address: $address',
    ];
    return parts.join('. ');
  }

  String get documentId => 'store_$id';
}
