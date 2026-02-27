/// Elasticsearch document for drivers index
/// Maps DriverProfile + User data to ES document format
class EsDriverDocument {
  final int userId;
  final String? email;
  final String displayName;
  final String? bio;
  final String? profilePhotoUrl;
  final String? vehicleType;
  final String? vehiclePlate;
  final String? vehicleMake;
  final String? vehicleModel;
  final Map<String, double>? location; // {"lat": x, "lon": y}
  final double ratingAverage;
  final int ratingCount;
  final bool isOnline;
  final bool isVerified;
  final bool isPremium;
  final bool isFeatured;
  final int totalCompletedOrders;
  final int experienceYears;
  final List<String> serviceCategories;
  final List<int> serviceCategoryIds;
  final String? baseCityName;
  final int? baseCityId;
  final DateTime createdAt;
  final DateTime updatedAt;

  EsDriverDocument({
    required this.userId,
    this.email,
    required this.displayName,
    this.bio,
    this.profilePhotoUrl,
    this.vehicleType,
    this.vehiclePlate,
    this.vehicleMake,
    this.vehicleModel,
    this.location,
    required this.ratingAverage,
    required this.ratingCount,
    required this.isOnline,
    required this.isVerified,
    required this.isPremium,
    required this.isFeatured,
    required this.totalCompletedOrders,
    required this.experienceYears,
    required this.serviceCategories,
    required this.serviceCategoryIds,
    this.baseCityName,
    this.baseCityId,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Convert to JSON for Elasticsearch
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'displayName': displayName,
      'bio': bio,
      'profilePhotoUrl': profilePhotoUrl,
      'vehicleType': vehicleType,
      'vehiclePlate': vehiclePlate,
      'vehicleMake': vehicleMake,
      'vehicleModel': vehicleModel,
      'location': location,
      'ratingAverage': ratingAverage,
      'ratingCount': ratingCount,
      'isOnline': isOnline,
      'isVerified': isVerified,
      'isPremium': isPremium,
      'isFeatured': isFeatured,
      'totalCompletedOrders': totalCompletedOrders,
      'experienceYears': experienceYears,
      'serviceCategories': serviceCategories,
      'serviceCategoryIds': serviceCategoryIds,
      'baseCityName': baseCityName,
      'baseCityId': baseCityId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      // Computed field for full-text search
      'searchableText': _buildSearchableText(),
    };
  }

  String _buildSearchableText() {
    final parts = <String>[
      displayName,
      if (bio != null) bio!,
      if (vehicleType != null) vehicleType!,
      if (vehicleMake != null) vehicleMake!,
      if (vehicleModel != null) vehicleModel!,
      if (baseCityName != null) baseCityName!,
      ...serviceCategories,
    ];
    return parts.join(' ');
  }

  /// Document ID for Elasticsearch
  String get documentId => 'driver_$userId';
}
