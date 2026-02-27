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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Store implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = StoreTable();

  static const db = StoreRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static StoreInclude include() {
    return StoreInclude._();
  }

  static StoreIncludeList includeList({
    _i1.WhereExpressionBuilder<StoreTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreTable>? orderByList,
    StoreInclude? include,
  }) {
    return StoreIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Store.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Store.t),
      include: include,
    );
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

class StoreUpdateTable extends _i1.UpdateTable<StoreTable> {
  StoreUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> storeCategoryId(int value) => _i1.ColumnValue(
    table.storeCategoryId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> phone(String value) => _i1.ColumnValue(
    table.phone,
    value,
  );

  _i1.ColumnValue<String, String> email(String? value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<String, String> whatsappNumber(String? value) =>
      _i1.ColumnValue(
        table.whatsappNumber,
        value,
      );

  _i1.ColumnValue<String, String> websiteUrl(String? value) => _i1.ColumnValue(
    table.websiteUrl,
    value,
  );

  _i1.ColumnValue<String, String> facebookUrl(String? value) => _i1.ColumnValue(
    table.facebookUrl,
    value,
  );

  _i1.ColumnValue<String, String> instagramUrl(String? value) =>
      _i1.ColumnValue(
        table.instagramUrl,
        value,
      );

  _i1.ColumnValue<String, String> aboutText(String? value) => _i1.ColumnValue(
    table.aboutText,
    value,
  );

  _i1.ColumnValue<String, String> tagline(String? value) => _i1.ColumnValue(
    table.tagline,
    value,
  );

  _i1.ColumnValue<String, String> logoUrl(String? value) => _i1.ColumnValue(
    table.logoUrl,
    value,
  );

  _i1.ColumnValue<String, String> coverImageUrl(String? value) =>
      _i1.ColumnValue(
        table.coverImageUrl,
        value,
      );

  _i1.ColumnValue<String, String> galleryImages(String? value) =>
      _i1.ColumnValue(
        table.galleryImages,
        value,
      );

  _i1.ColumnValue<String, String> address(String value) => _i1.ColumnValue(
    table.address,
    value,
  );

  _i1.ColumnValue<double, double> latitude(double value) => _i1.ColumnValue(
    table.latitude,
    value,
  );

  _i1.ColumnValue<double, double> longitude(double value) => _i1.ColumnValue(
    table.longitude,
    value,
  );

  _i1.ColumnValue<String, String> city(String? value) => _i1.ColumnValue(
    table.city,
    value,
  );

  _i1.ColumnValue<double, double> deliveryRadiusKm(double value) =>
      _i1.ColumnValue(
        table.deliveryRadiusKm,
        value,
      );

  _i1.ColumnValue<double, double> minimumOrderAmount(double? value) =>
      _i1.ColumnValue(
        table.minimumOrderAmount,
        value,
      );

  _i1.ColumnValue<int, int> estimatedPrepTimeMinutes(int value) =>
      _i1.ColumnValue(
        table.estimatedPrepTimeMinutes,
        value,
      );

  _i1.ColumnValue<bool, bool> acceptsCash(bool value) => _i1.ColumnValue(
    table.acceptsCash,
    value,
  );

  _i1.ColumnValue<bool, bool> acceptsCard(bool value) => _i1.ColumnValue(
    table.acceptsCard,
    value,
  );

  _i1.ColumnValue<bool, bool> hasDelivery(bool value) => _i1.ColumnValue(
    table.hasDelivery,
    value,
  );

  _i1.ColumnValue<bool, bool> hasPickup(bool value) => _i1.ColumnValue(
    table.hasPickup,
    value,
  );

  _i1.ColumnValue<String, String> workingHours(String? value) =>
      _i1.ColumnValue(
        table.workingHours,
        value,
      );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<bool, bool> isOpen(bool value) => _i1.ColumnValue(
    table.isOpen,
    value,
  );

  _i1.ColumnValue<int, int> totalOrders(int value) => _i1.ColumnValue(
    table.totalOrders,
    value,
  );

  _i1.ColumnValue<double, double> rating(double value) => _i1.ColumnValue(
    table.rating,
    value,
  );

  _i1.ColumnValue<int, int> totalRatings(int value) => _i1.ColumnValue(
    table.totalRatings,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class StoreTable extends _i1.Table<int?> {
  StoreTable({super.tableRelation}) : super(tableName: 'stores') {
    updateTable = StoreUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    storeCategoryId = _i1.ColumnInt(
      'storeCategoryId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    whatsappNumber = _i1.ColumnString(
      'whatsappNumber',
      this,
    );
    websiteUrl = _i1.ColumnString(
      'websiteUrl',
      this,
    );
    facebookUrl = _i1.ColumnString(
      'facebookUrl',
      this,
    );
    instagramUrl = _i1.ColumnString(
      'instagramUrl',
      this,
    );
    aboutText = _i1.ColumnString(
      'aboutText',
      this,
    );
    tagline = _i1.ColumnString(
      'tagline',
      this,
    );
    logoUrl = _i1.ColumnString(
      'logoUrl',
      this,
    );
    coverImageUrl = _i1.ColumnString(
      'coverImageUrl',
      this,
    );
    galleryImages = _i1.ColumnString(
      'galleryImages',
      this,
    );
    address = _i1.ColumnString(
      'address',
      this,
    );
    latitude = _i1.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _i1.ColumnDouble(
      'longitude',
      this,
    );
    city = _i1.ColumnString(
      'city',
      this,
    );
    deliveryRadiusKm = _i1.ColumnDouble(
      'deliveryRadiusKm',
      this,
      hasDefault: true,
    );
    minimumOrderAmount = _i1.ColumnDouble(
      'minimumOrderAmount',
      this,
      hasDefault: true,
    );
    estimatedPrepTimeMinutes = _i1.ColumnInt(
      'estimatedPrepTimeMinutes',
      this,
      hasDefault: true,
    );
    acceptsCash = _i1.ColumnBool(
      'acceptsCash',
      this,
      hasDefault: true,
    );
    acceptsCard = _i1.ColumnBool(
      'acceptsCard',
      this,
      hasDefault: true,
    );
    hasDelivery = _i1.ColumnBool(
      'hasDelivery',
      this,
      hasDefault: true,
    );
    hasPickup = _i1.ColumnBool(
      'hasPickup',
      this,
      hasDefault: true,
    );
    workingHours = _i1.ColumnString(
      'workingHours',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    isOpen = _i1.ColumnBool(
      'isOpen',
      this,
      hasDefault: true,
    );
    totalOrders = _i1.ColumnInt(
      'totalOrders',
      this,
      hasDefault: true,
    );
    rating = _i1.ColumnDouble(
      'rating',
      this,
      hasDefault: true,
    );
    totalRatings = _i1.ColumnInt(
      'totalRatings',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final StoreUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt storeCategoryId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString phone;

  late final _i1.ColumnString email;

  late final _i1.ColumnString whatsappNumber;

  late final _i1.ColumnString websiteUrl;

  late final _i1.ColumnString facebookUrl;

  late final _i1.ColumnString instagramUrl;

  late final _i1.ColumnString aboutText;

  late final _i1.ColumnString tagline;

  late final _i1.ColumnString logoUrl;

  late final _i1.ColumnString coverImageUrl;

  late final _i1.ColumnString galleryImages;

  late final _i1.ColumnString address;

  late final _i1.ColumnDouble latitude;

  late final _i1.ColumnDouble longitude;

  late final _i1.ColumnString city;

  late final _i1.ColumnDouble deliveryRadiusKm;

  late final _i1.ColumnDouble minimumOrderAmount;

  late final _i1.ColumnInt estimatedPrepTimeMinutes;

  late final _i1.ColumnBool acceptsCash;

  late final _i1.ColumnBool acceptsCard;

  late final _i1.ColumnBool hasDelivery;

  late final _i1.ColumnBool hasPickup;

  late final _i1.ColumnString workingHours;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnBool isOpen;

  late final _i1.ColumnInt totalOrders;

  late final _i1.ColumnDouble rating;

  late final _i1.ColumnInt totalRatings;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    storeCategoryId,
    name,
    description,
    phone,
    email,
    whatsappNumber,
    websiteUrl,
    facebookUrl,
    instagramUrl,
    aboutText,
    tagline,
    logoUrl,
    coverImageUrl,
    galleryImages,
    address,
    latitude,
    longitude,
    city,
    deliveryRadiusKm,
    minimumOrderAmount,
    estimatedPrepTimeMinutes,
    acceptsCash,
    acceptsCard,
    hasDelivery,
    hasPickup,
    workingHours,
    isActive,
    isOpen,
    totalOrders,
    rating,
    totalRatings,
    createdAt,
    updatedAt,
  ];
}

class StoreInclude extends _i1.IncludeObject {
  StoreInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Store.t;
}

class StoreIncludeList extends _i1.IncludeList {
  StoreIncludeList._({
    _i1.WhereExpressionBuilder<StoreTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Store.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Store.t;
}

class StoreRepository {
  const StoreRepository._();

  /// Returns a list of [Store]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Store>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Store>(
      where: where?.call(Store.t),
      orderBy: orderBy?.call(Store.t),
      orderByList: orderByList?.call(Store.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Store] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Store?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreTable>? where,
    int? offset,
    _i1.OrderByBuilder<StoreTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Store>(
      where: where?.call(Store.t),
      orderBy: orderBy?.call(Store.t),
      orderByList: orderByList?.call(Store.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Store] by its [id] or null if no such row exists.
  Future<Store?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Store>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Store]s in the list and returns the inserted rows.
  ///
  /// The returned [Store]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Store>> insert(
    _i1.Session session,
    List<Store> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Store>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Store] and returns the inserted row.
  ///
  /// The returned [Store] will have its `id` field set.
  Future<Store> insertRow(
    _i1.Session session,
    Store row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Store>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Store]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Store>> update(
    _i1.Session session,
    List<Store> rows, {
    _i1.ColumnSelections<StoreTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Store>(
      rows,
      columns: columns?.call(Store.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Store]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Store> updateRow(
    _i1.Session session,
    Store row, {
    _i1.ColumnSelections<StoreTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Store>(
      row,
      columns: columns?.call(Store.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Store] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Store?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<StoreUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Store>(
      id,
      columnValues: columnValues(Store.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Store]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Store>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<StoreUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StoreTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreTable>? orderBy,
    _i1.OrderByListBuilder<StoreTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Store>(
      columnValues: columnValues(Store.t.updateTable),
      where: where(Store.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Store.t),
      orderByList: orderByList?.call(Store.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Store]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Store>> delete(
    _i1.Session session,
    List<Store> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Store>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Store].
  Future<Store> deleteRow(
    _i1.Session session,
    Store row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Store>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Store>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StoreTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Store>(
      where: where(Store.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Store>(
      where: where?.call(Store.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
