/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Store implements _i1.SerializableModel {
  Store._({
    this.id,
    required this.userId,
    required this.storeCategoryId,
    required this.name,
    this.description,
    required this.phone,
    this.email,
    this.whatsappNumber,
    this.websiteUrl,
    this.facebookUrl,
    this.instagramUrl,
    this.aboutText,
    this.tagline,
    this.logoUrl,
    this.coverImageUrl,
    this.galleryImages,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.city,
    double? deliveryRadiusKm,
    double? minimumOrderAmount,
    int? estimatedPrepTimeMinutes,
    bool? acceptsCash,
    bool? acceptsCard,
    bool? hasDelivery,
    bool? hasPickup,
    this.workingHours,
    bool? isActive,
    bool? isOpen,
    int? totalOrders,
    double? rating,
    int? totalRatings,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : deliveryRadiusKm = deliveryRadiusKm ?? 5.0,
       minimumOrderAmount = minimumOrderAmount ?? 0.0,
       estimatedPrepTimeMinutes = estimatedPrepTimeMinutes ?? 30,
       acceptsCash = acceptsCash ?? true,
       acceptsCard = acceptsCard ?? false,
       hasDelivery = hasDelivery ?? true,
       hasPickup = hasPickup ?? false,
       isActive = isActive ?? true,
       isOpen = isOpen ?? false,
       totalOrders = totalOrders ?? 0,
       rating = rating ?? 0.0,
       totalRatings = totalRatings ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Store({
    int? id,
    required int userId,
    required int storeCategoryId,
    required String name,
    String? description,
    required String phone,
    String? email,
    String? whatsappNumber,
    String? websiteUrl,
    String? facebookUrl,
    String? instagramUrl,
    String? aboutText,
    String? tagline,
    String? logoUrl,
    String? coverImageUrl,
    String? galleryImages,
    required String address,
    required double latitude,
    required double longitude,
    String? city,
    double? deliveryRadiusKm,
    double? minimumOrderAmount,
    int? estimatedPrepTimeMinutes,
    bool? acceptsCash,
    bool? acceptsCard,
    bool? hasDelivery,
    bool? hasPickup,
    String? workingHours,
    bool? isActive,
    bool? isOpen,
    int? totalOrders,
    double? rating,
    int? totalRatings,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StoreImpl;

  factory Store.fromJson(Map<String, dynamic> jsonSerialization) {
    return Store(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      storeCategoryId: jsonSerialization['storeCategoryId'] as int,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String?,
      whatsappNumber: jsonSerialization['whatsappNumber'] as String?,
      websiteUrl: jsonSerialization['websiteUrl'] as String?,
      facebookUrl: jsonSerialization['facebookUrl'] as String?,
      instagramUrl: jsonSerialization['instagramUrl'] as String?,
      aboutText: jsonSerialization['aboutText'] as String?,
      tagline: jsonSerialization['tagline'] as String?,
      logoUrl: jsonSerialization['logoUrl'] as String?,
      coverImageUrl: jsonSerialization['coverImageUrl'] as String?,
      galleryImages: jsonSerialization['galleryImages'] as String?,
      address: jsonSerialization['address'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      city: jsonSerialization['city'] as String?,
      deliveryRadiusKm: (jsonSerialization['deliveryRadiusKm'] as num)
          .toDouble(),
      minimumOrderAmount: (jsonSerialization['minimumOrderAmount'] as num?)
          ?.toDouble(),
      estimatedPrepTimeMinutes:
          jsonSerialization['estimatedPrepTimeMinutes'] as int,
      acceptsCash: jsonSerialization['acceptsCash'] as bool,
      acceptsCard: jsonSerialization['acceptsCard'] as bool,
      hasDelivery: jsonSerialization['hasDelivery'] as bool,
      hasPickup: jsonSerialization['hasPickup'] as bool,
      workingHours: jsonSerialization['workingHours'] as String?,
      isActive: jsonSerialization['isActive'] as bool,
      isOpen: jsonSerialization['isOpen'] as bool,
      totalOrders: jsonSerialization['totalOrders'] as int,
      rating: (jsonSerialization['rating'] as num).toDouble(),
      totalRatings: jsonSerialization['totalRatings'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int storeCategoryId;

  String name;

  String? description;

  String phone;

  String? email;

  String? whatsappNumber;

  String? websiteUrl;

  String? facebookUrl;

  String? instagramUrl;

  String? aboutText;

  String? tagline;

  String? logoUrl;

  String? coverImageUrl;

  String? galleryImages;

  String address;

  double latitude;

  double longitude;

  String? city;

  double deliveryRadiusKm;

  double? minimumOrderAmount;

  int estimatedPrepTimeMinutes;

  bool acceptsCash;

  bool acceptsCard;

  bool hasDelivery;

  bool hasPickup;

  String? workingHours;

  bool isActive;

  bool isOpen;

  int totalOrders;

  double rating;

  int totalRatings;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Store]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Store copyWith({
    int? id,
    int? userId,
    int? storeCategoryId,
    String? name,
    String? description,
    String? phone,
    String? email,
    String? whatsappNumber,
    String? websiteUrl,
    String? facebookUrl,
    String? instagramUrl,
    String? aboutText,
    String? tagline,
    String? logoUrl,
    String? coverImageUrl,
    String? galleryImages,
    String? address,
    double? latitude,
    double? longitude,
    String? city,
    double? deliveryRadiusKm,
    double? minimumOrderAmount,
    int? estimatedPrepTimeMinutes,
    bool? acceptsCash,
    bool? acceptsCard,
    bool? hasDelivery,
    bool? hasPickup,
    String? workingHours,
    bool? isActive,
    bool? isOpen,
    int? totalOrders,
    double? rating,
    int? totalRatings,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Store',
      if (id != null) 'id': id,
      'userId': userId,
      'storeCategoryId': storeCategoryId,
      'name': name,
      if (description != null) 'description': description,
      'phone': phone,
      if (email != null) 'email': email,
      if (whatsappNumber != null) 'whatsappNumber': whatsappNumber,
      if (websiteUrl != null) 'websiteUrl': websiteUrl,
      if (facebookUrl != null) 'facebookUrl': facebookUrl,
      if (instagramUrl != null) 'instagramUrl': instagramUrl,
      if (aboutText != null) 'aboutText': aboutText,
      if (tagline != null) 'tagline': tagline,
      if (logoUrl != null) 'logoUrl': logoUrl,
      if (coverImageUrl != null) 'coverImageUrl': coverImageUrl,
      if (galleryImages != null) 'galleryImages': galleryImages,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      if (city != null) 'city': city,
      'deliveryRadiusKm': deliveryRadiusKm,
      if (minimumOrderAmount != null) 'minimumOrderAmount': minimumOrderAmount,
      'estimatedPrepTimeMinutes': estimatedPrepTimeMinutes,
      'acceptsCash': acceptsCash,
      'acceptsCard': acceptsCard,
      'hasDelivery': hasDelivery,
      'hasPickup': hasPickup,
      if (workingHours != null) 'workingHours': workingHours,
      'isActive': isActive,
      'isOpen': isOpen,
      'totalOrders': totalOrders,
      'rating': rating,
      'totalRatings': totalRatings,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreImpl extends Store {
  _StoreImpl({
    int? id,
    required int userId,
    required int storeCategoryId,
    required String name,
    String? description,
    required String phone,
    String? email,
    String? whatsappNumber,
    String? websiteUrl,
    String? facebookUrl,
    String? instagramUrl,
    String? aboutText,
    String? tagline,
    String? logoUrl,
    String? coverImageUrl,
    String? galleryImages,
    required String address,
    required double latitude,
    required double longitude,
    String? city,
    double? deliveryRadiusKm,
    double? minimumOrderAmount,
    int? estimatedPrepTimeMinutes,
    bool? acceptsCash,
    bool? acceptsCard,
    bool? hasDelivery,
    bool? hasPickup,
    String? workingHours,
    bool? isActive,
    bool? isOpen,
    int? totalOrders,
    double? rating,
    int? totalRatings,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         storeCategoryId: storeCategoryId,
         name: name,
         description: description,
         phone: phone,
         email: email,
         whatsappNumber: whatsappNumber,
         websiteUrl: websiteUrl,
         facebookUrl: facebookUrl,
         instagramUrl: instagramUrl,
         aboutText: aboutText,
         tagline: tagline,
         logoUrl: logoUrl,
         coverImageUrl: coverImageUrl,
         galleryImages: galleryImages,
         address: address,
         latitude: latitude,
         longitude: longitude,
         city: city,
         deliveryRadiusKm: deliveryRadiusKm,
         minimumOrderAmount: minimumOrderAmount,
         estimatedPrepTimeMinutes: estimatedPrepTimeMinutes,
         acceptsCash: acceptsCash,
         acceptsCard: acceptsCard,
         hasDelivery: hasDelivery,
         hasPickup: hasPickup,
         workingHours: workingHours,
         isActive: isActive,
         isOpen: isOpen,
         totalOrders: totalOrders,
         rating: rating,
         totalRatings: totalRatings,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Store]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Store copyWith({
    Object? id = _Undefined,
    int? userId,
    int? storeCategoryId,
    String? name,
    Object? description = _Undefined,
    String? phone,
    Object? email = _Undefined,
    Object? whatsappNumber = _Undefined,
    Object? websiteUrl = _Undefined,
    Object? facebookUrl = _Undefined,
    Object? instagramUrl = _Undefined,
    Object? aboutText = _Undefined,
    Object? tagline = _Undefined,
    Object? logoUrl = _Undefined,
    Object? coverImageUrl = _Undefined,
    Object? galleryImages = _Undefined,
    String? address,
    double? latitude,
    double? longitude,
    Object? city = _Undefined,
    double? deliveryRadiusKm,
    Object? minimumOrderAmount = _Undefined,
    int? estimatedPrepTimeMinutes,
    bool? acceptsCash,
    bool? acceptsCard,
    bool? hasDelivery,
    bool? hasPickup,
    Object? workingHours = _Undefined,
    bool? isActive,
    bool? isOpen,
    int? totalOrders,
    double? rating,
    int? totalRatings,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Store(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      storeCategoryId: storeCategoryId ?? this.storeCategoryId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      phone: phone ?? this.phone,
      email: email is String? ? email : this.email,
      whatsappNumber: whatsappNumber is String?
          ? whatsappNumber
          : this.whatsappNumber,
      websiteUrl: websiteUrl is String? ? websiteUrl : this.websiteUrl,
      facebookUrl: facebookUrl is String? ? facebookUrl : this.facebookUrl,
      instagramUrl: instagramUrl is String? ? instagramUrl : this.instagramUrl,
      aboutText: aboutText is String? ? aboutText : this.aboutText,
      tagline: tagline is String? ? tagline : this.tagline,
      logoUrl: logoUrl is String? ? logoUrl : this.logoUrl,
      coverImageUrl: coverImageUrl is String?
          ? coverImageUrl
          : this.coverImageUrl,
      galleryImages: galleryImages is String?
          ? galleryImages
          : this.galleryImages,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      city: city is String? ? city : this.city,
      deliveryRadiusKm: deliveryRadiusKm ?? this.deliveryRadiusKm,
      minimumOrderAmount: minimumOrderAmount is double?
          ? minimumOrderAmount
          : this.minimumOrderAmount,
      estimatedPrepTimeMinutes:
          estimatedPrepTimeMinutes ?? this.estimatedPrepTimeMinutes,
      acceptsCash: acceptsCash ?? this.acceptsCash,
      acceptsCard: acceptsCard ?? this.acceptsCard,
      hasDelivery: hasDelivery ?? this.hasDelivery,
      hasPickup: hasPickup ?? this.hasPickup,
      workingHours: workingHours is String? ? workingHours : this.workingHours,
      isActive: isActive ?? this.isActive,
      isOpen: isOpen ?? this.isOpen,
      totalOrders: totalOrders ?? this.totalOrders,
      rating: rating ?? this.rating,
      totalRatings: totalRatings ?? this.totalRatings,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
