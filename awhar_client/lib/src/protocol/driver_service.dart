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
import 'price_type_enum.dart' as _i2;

abstract class DriverService implements _i1.SerializableModel {
  DriverService._({
    this.id,
    required this.driverId,
    required this.serviceId,
    this.categoryId,
    this.priceType,
    this.basePrice,
    this.pricePerKm,
    this.pricePerHour,
    this.minPrice,
    this.title,
    this.imageUrl,
    this.description,
    this.customDescription,
    int? viewCount,
    int? inquiryCount,
    int? bookingCount,
    bool? isAvailable,
    this.availableFrom,
    this.availableUntil,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : viewCount = viewCount ?? 0,
       inquiryCount = inquiryCount ?? 0,
       bookingCount = bookingCount ?? 0,
       isAvailable = isAvailable ?? true,
       isActive = isActive ?? true,
       displayOrder = displayOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DriverService({
    int? id,
    required int driverId,
    required int serviceId,
    int? categoryId,
    _i2.PriceType? priceType,
    double? basePrice,
    double? pricePerKm,
    double? pricePerHour,
    double? minPrice,
    String? title,
    String? imageUrl,
    String? description,
    String? customDescription,
    int? viewCount,
    int? inquiryCount,
    int? bookingCount,
    bool? isAvailable,
    DateTime? availableFrom,
    DateTime? availableUntil,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DriverServiceImpl;

  factory DriverService.fromJson(Map<String, dynamic> jsonSerialization) {
    return DriverService(
      id: jsonSerialization['id'] as int?,
      driverId: jsonSerialization['driverId'] as int,
      serviceId: jsonSerialization['serviceId'] as int,
      categoryId: jsonSerialization['categoryId'] as int?,
      priceType: jsonSerialization['priceType'] == null
          ? null
          : _i2.PriceType.fromJson((jsonSerialization['priceType'] as int)),
      basePrice: (jsonSerialization['basePrice'] as num?)?.toDouble(),
      pricePerKm: (jsonSerialization['pricePerKm'] as num?)?.toDouble(),
      pricePerHour: (jsonSerialization['pricePerHour'] as num?)?.toDouble(),
      minPrice: (jsonSerialization['minPrice'] as num?)?.toDouble(),
      title: jsonSerialization['title'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      description: jsonSerialization['description'] as String?,
      customDescription: jsonSerialization['customDescription'] as String?,
      viewCount: jsonSerialization['viewCount'] as int,
      inquiryCount: jsonSerialization['inquiryCount'] as int,
      bookingCount: jsonSerialization['bookingCount'] as int,
      isAvailable: jsonSerialization['isAvailable'] as bool,
      availableFrom: jsonSerialization['availableFrom'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['availableFrom'],
            ),
      availableUntil: jsonSerialization['availableUntil'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['availableUntil'],
            ),
      isActive: jsonSerialization['isActive'] as bool,
      displayOrder: jsonSerialization['displayOrder'] as int,
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

  int driverId;

  int serviceId;

  int? categoryId;

  _i2.PriceType? priceType;

  double? basePrice;

  double? pricePerKm;

  double? pricePerHour;

  double? minPrice;

  String? title;

  String? imageUrl;

  String? description;

  String? customDescription;

  int viewCount;

  int inquiryCount;

  int bookingCount;

  bool isAvailable;

  DateTime? availableFrom;

  DateTime? availableUntil;

  bool isActive;

  int displayOrder;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [DriverService]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DriverService copyWith({
    int? id,
    int? driverId,
    int? serviceId,
    int? categoryId,
    _i2.PriceType? priceType,
    double? basePrice,
    double? pricePerKm,
    double? pricePerHour,
    double? minPrice,
    String? title,
    String? imageUrl,
    String? description,
    String? customDescription,
    int? viewCount,
    int? inquiryCount,
    int? bookingCount,
    bool? isAvailable,
    DateTime? availableFrom,
    DateTime? availableUntil,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DriverService',
      if (id != null) 'id': id,
      'driverId': driverId,
      'serviceId': serviceId,
      if (categoryId != null) 'categoryId': categoryId,
      if (priceType != null) 'priceType': priceType?.toJson(),
      if (basePrice != null) 'basePrice': basePrice,
      if (pricePerKm != null) 'pricePerKm': pricePerKm,
      if (pricePerHour != null) 'pricePerHour': pricePerHour,
      if (minPrice != null) 'minPrice': minPrice,
      if (title != null) 'title': title,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (description != null) 'description': description,
      if (customDescription != null) 'customDescription': customDescription,
      'viewCount': viewCount,
      'inquiryCount': inquiryCount,
      'bookingCount': bookingCount,
      'isAvailable': isAvailable,
      if (availableFrom != null) 'availableFrom': availableFrom?.toJson(),
      if (availableUntil != null) 'availableUntil': availableUntil?.toJson(),
      'isActive': isActive,
      'displayOrder': displayOrder,
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

class _DriverServiceImpl extends DriverService {
  _DriverServiceImpl({
    int? id,
    required int driverId,
    required int serviceId,
    int? categoryId,
    _i2.PriceType? priceType,
    double? basePrice,
    double? pricePerKm,
    double? pricePerHour,
    double? minPrice,
    String? title,
    String? imageUrl,
    String? description,
    String? customDescription,
    int? viewCount,
    int? inquiryCount,
    int? bookingCount,
    bool? isAvailable,
    DateTime? availableFrom,
    DateTime? availableUntil,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         driverId: driverId,
         serviceId: serviceId,
         categoryId: categoryId,
         priceType: priceType,
         basePrice: basePrice,
         pricePerKm: pricePerKm,
         pricePerHour: pricePerHour,
         minPrice: minPrice,
         title: title,
         imageUrl: imageUrl,
         description: description,
         customDescription: customDescription,
         viewCount: viewCount,
         inquiryCount: inquiryCount,
         bookingCount: bookingCount,
         isAvailable: isAvailable,
         availableFrom: availableFrom,
         availableUntil: availableUntil,
         isActive: isActive,
         displayOrder: displayOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DriverService]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DriverService copyWith({
    Object? id = _Undefined,
    int? driverId,
    int? serviceId,
    Object? categoryId = _Undefined,
    Object? priceType = _Undefined,
    Object? basePrice = _Undefined,
    Object? pricePerKm = _Undefined,
    Object? pricePerHour = _Undefined,
    Object? minPrice = _Undefined,
    Object? title = _Undefined,
    Object? imageUrl = _Undefined,
    Object? description = _Undefined,
    Object? customDescription = _Undefined,
    int? viewCount,
    int? inquiryCount,
    int? bookingCount,
    bool? isAvailable,
    Object? availableFrom = _Undefined,
    Object? availableUntil = _Undefined,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DriverService(
      id: id is int? ? id : this.id,
      driverId: driverId ?? this.driverId,
      serviceId: serviceId ?? this.serviceId,
      categoryId: categoryId is int? ? categoryId : this.categoryId,
      priceType: priceType is _i2.PriceType? ? priceType : this.priceType,
      basePrice: basePrice is double? ? basePrice : this.basePrice,
      pricePerKm: pricePerKm is double? ? pricePerKm : this.pricePerKm,
      pricePerHour: pricePerHour is double? ? pricePerHour : this.pricePerHour,
      minPrice: minPrice is double? ? minPrice : this.minPrice,
      title: title is String? ? title : this.title,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      description: description is String? ? description : this.description,
      customDescription: customDescription is String?
          ? customDescription
          : this.customDescription,
      viewCount: viewCount ?? this.viewCount,
      inquiryCount: inquiryCount ?? this.inquiryCount,
      bookingCount: bookingCount ?? this.bookingCount,
      isAvailable: isAvailable ?? this.isAvailable,
      availableFrom: availableFrom is DateTime?
          ? availableFrom
          : this.availableFrom,
      availableUntil: availableUntil is DateTime?
          ? availableUntil
          : this.availableUntil,
      isActive: isActive ?? this.isActive,
      displayOrder: displayOrder ?? this.displayOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
