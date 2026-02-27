/// Elasticsearch document for driver-services index
/// Maps DriverService data with driver info for search
class EsDriverServiceDocument {
  final int id;
  final int driverId;
  final int serviceId;
  final int? categoryId;
  
  // Driver info (denormalized for search)
  final String? driverName;
  final String? driverPhoto;
  final double? driverRating;
  final bool? driverIsVerified;
  final bool? driverIsPremium;
  final bool? driverIsOnline;
  
  // Service info
  final String? serviceName;
  final String? categoryName;
  
  // Driver's custom offering
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? priceType;
  final double? basePrice;
  final double? pricePerKm;
  final double? pricePerHour;
  final double? minPrice;
  
  // Location (driver's location)
  final Map<String, double>? location;
  
  // Analytics
  final int viewCount;
  final int inquiryCount;
  final int bookingCount;
  
  // Status
  final bool isAvailable;
  final bool isActive;
  final int displayOrder;
  
  final DateTime createdAt;
  final DateTime updatedAt;

  EsDriverServiceDocument({
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
    this.pricePerKm,
    this.pricePerHour,
    this.minPrice,
    this.location,
    required this.viewCount,
    required this.inquiryCount,
    required this.bookingCount,
    required this.isAvailable,
    required this.isActive,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driverId': driverId,
      'serviceId': serviceId,
      'categoryId': categoryId,
      'driverName': driverName,
      'driverPhoto': driverPhoto,
      'driverRating': driverRating,
      'driverIsVerified': driverIsVerified,
      'driverIsPremium': driverIsPremium,
      'driverIsOnline': driverIsOnline,
      'serviceName': serviceName,
      'categoryName': categoryName,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'priceType': priceType,
      'basePrice': basePrice,
      'pricePerKm': pricePerKm,
      'pricePerHour': pricePerHour,
      'minPrice': minPrice,
      'location': location,
      'viewCount': viewCount,
      'inquiryCount': inquiryCount,
      'bookingCount': bookingCount,
      'isAvailable': isAvailable,
      'isActive': isActive,
      'displayOrder': displayOrder,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'searchableText': _buildSearchableText(),
    };
  }

  String _buildSearchableText() {
    final parts = <String>[
      if (title != null) title!,
      if (description != null) description!,
      if (serviceName != null) serviceName!,
      if (categoryName != null) categoryName!,
      if (driverName != null) driverName!,
    ];
    return parts.join(' ');
  }

  String get documentId => 'driver_service_$id';
}
