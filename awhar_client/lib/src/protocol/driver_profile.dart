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
import 'vehicle_type_enum.dart' as _i2;
import 'driver_availability_status_enum.dart' as _i3;

abstract class DriverProfile implements _i1.SerializableModel {
  DriverProfile._({
    this.id,
    required this.userId,
    required this.displayName,
    this.bio,
    this.profilePhotoUrl,
    this.vehicleType,
    this.vehicleMake,
    this.vehicleModel,
    this.vehiclePlate,
    this.vehicleYear,
    this.vehiclePhotoUrl,
    int? experienceYears,
    this.availabilityStatus,
    this.baseCityId,
    bool? isOnline,
    this.lastLocationLat,
    this.lastLocationLng,
    this.lastLocationUpdatedAt,
    this.autoOfflineAt,
    double? ratingAverage,
    int? ratingCount,
    bool? isVerified,
    bool? isDocumentsSubmitted,
    bool? isFeatured,
    bool? isPremium,
    this.premiumUntil,
    int? totalCompletedOrders,
    double? totalEarnings,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.verifiedAt,
  }) : experienceYears = experienceYears ?? 0,
       isOnline = isOnline ?? false,
       ratingAverage = ratingAverage ?? 0.0,
       ratingCount = ratingCount ?? 0,
       isVerified = isVerified ?? false,
       isDocumentsSubmitted = isDocumentsSubmitted ?? false,
       isFeatured = isFeatured ?? false,
       isPremium = isPremium ?? false,
       totalCompletedOrders = totalCompletedOrders ?? 0,
       totalEarnings = totalEarnings ?? 0.0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DriverProfile({
    int? id,
    required int userId,
    required String displayName,
    String? bio,
    String? profilePhotoUrl,
    _i2.VehicleType? vehicleType,
    String? vehicleMake,
    String? vehicleModel,
    String? vehiclePlate,
    int? vehicleYear,
    String? vehiclePhotoUrl,
    int? experienceYears,
    _i3.DriverAvailabilityStatus? availabilityStatus,
    int? baseCityId,
    bool? isOnline,
    double? lastLocationLat,
    double? lastLocationLng,
    DateTime? lastLocationUpdatedAt,
    DateTime? autoOfflineAt,
    double? ratingAverage,
    int? ratingCount,
    bool? isVerified,
    bool? isDocumentsSubmitted,
    bool? isFeatured,
    bool? isPremium,
    DateTime? premiumUntil,
    int? totalCompletedOrders,
    double? totalEarnings,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? verifiedAt,
  }) = _DriverProfileImpl;

  factory DriverProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return DriverProfile(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      displayName: jsonSerialization['displayName'] as String,
      bio: jsonSerialization['bio'] as String?,
      profilePhotoUrl: jsonSerialization['profilePhotoUrl'] as String?,
      vehicleType: jsonSerialization['vehicleType'] == null
          ? null
          : _i2.VehicleType.fromJson((jsonSerialization['vehicleType'] as int)),
      vehicleMake: jsonSerialization['vehicleMake'] as String?,
      vehicleModel: jsonSerialization['vehicleModel'] as String?,
      vehiclePlate: jsonSerialization['vehiclePlate'] as String?,
      vehicleYear: jsonSerialization['vehicleYear'] as int?,
      vehiclePhotoUrl: jsonSerialization['vehiclePhotoUrl'] as String?,
      experienceYears: jsonSerialization['experienceYears'] as int,
      availabilityStatus: jsonSerialization['availabilityStatus'] == null
          ? null
          : _i3.DriverAvailabilityStatus.fromJson(
              (jsonSerialization['availabilityStatus'] as int),
            ),
      baseCityId: jsonSerialization['baseCityId'] as int?,
      isOnline: jsonSerialization['isOnline'] as bool,
      lastLocationLat: (jsonSerialization['lastLocationLat'] as num?)
          ?.toDouble(),
      lastLocationLng: (jsonSerialization['lastLocationLng'] as num?)
          ?.toDouble(),
      lastLocationUpdatedAt: jsonSerialization['lastLocationUpdatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastLocationUpdatedAt'],
            ),
      autoOfflineAt: jsonSerialization['autoOfflineAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['autoOfflineAt'],
            ),
      ratingAverage: (jsonSerialization['ratingAverage'] as num).toDouble(),
      ratingCount: jsonSerialization['ratingCount'] as int,
      isVerified: jsonSerialization['isVerified'] as bool,
      isDocumentsSubmitted: jsonSerialization['isDocumentsSubmitted'] as bool,
      isFeatured: jsonSerialization['isFeatured'] as bool,
      isPremium: jsonSerialization['isPremium'] as bool,
      premiumUntil: jsonSerialization['premiumUntil'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['premiumUntil'],
            ),
      totalCompletedOrders: jsonSerialization['totalCompletedOrders'] as int,
      totalEarnings: (jsonSerialization['totalEarnings'] as num).toDouble(),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      verifiedAt: jsonSerialization['verifiedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['verifiedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String displayName;

  String? bio;

  String? profilePhotoUrl;

  _i2.VehicleType? vehicleType;

  String? vehicleMake;

  String? vehicleModel;

  String? vehiclePlate;

  int? vehicleYear;

  String? vehiclePhotoUrl;

  int experienceYears;

  _i3.DriverAvailabilityStatus? availabilityStatus;

  int? baseCityId;

  bool isOnline;

  double? lastLocationLat;

  double? lastLocationLng;

  DateTime? lastLocationUpdatedAt;

  DateTime? autoOfflineAt;

  double ratingAverage;

  int ratingCount;

  bool isVerified;

  bool isDocumentsSubmitted;

  bool isFeatured;

  bool isPremium;

  DateTime? premiumUntil;

  int totalCompletedOrders;

  double totalEarnings;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? verifiedAt;

  /// Returns a shallow copy of this [DriverProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DriverProfile copyWith({
    int? id,
    int? userId,
    String? displayName,
    String? bio,
    String? profilePhotoUrl,
    _i2.VehicleType? vehicleType,
    String? vehicleMake,
    String? vehicleModel,
    String? vehiclePlate,
    int? vehicleYear,
    String? vehiclePhotoUrl,
    int? experienceYears,
    _i3.DriverAvailabilityStatus? availabilityStatus,
    int? baseCityId,
    bool? isOnline,
    double? lastLocationLat,
    double? lastLocationLng,
    DateTime? lastLocationUpdatedAt,
    DateTime? autoOfflineAt,
    double? ratingAverage,
    int? ratingCount,
    bool? isVerified,
    bool? isDocumentsSubmitted,
    bool? isFeatured,
    bool? isPremium,
    DateTime? premiumUntil,
    int? totalCompletedOrders,
    double? totalEarnings,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? verifiedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DriverProfile',
      if (id != null) 'id': id,
      'userId': userId,
      'displayName': displayName,
      if (bio != null) 'bio': bio,
      if (profilePhotoUrl != null) 'profilePhotoUrl': profilePhotoUrl,
      if (vehicleType != null) 'vehicleType': vehicleType?.toJson(),
      if (vehicleMake != null) 'vehicleMake': vehicleMake,
      if (vehicleModel != null) 'vehicleModel': vehicleModel,
      if (vehiclePlate != null) 'vehiclePlate': vehiclePlate,
      if (vehicleYear != null) 'vehicleYear': vehicleYear,
      if (vehiclePhotoUrl != null) 'vehiclePhotoUrl': vehiclePhotoUrl,
      'experienceYears': experienceYears,
      if (availabilityStatus != null)
        'availabilityStatus': availabilityStatus?.toJson(),
      if (baseCityId != null) 'baseCityId': baseCityId,
      'isOnline': isOnline,
      if (lastLocationLat != null) 'lastLocationLat': lastLocationLat,
      if (lastLocationLng != null) 'lastLocationLng': lastLocationLng,
      if (lastLocationUpdatedAt != null)
        'lastLocationUpdatedAt': lastLocationUpdatedAt?.toJson(),
      if (autoOfflineAt != null) 'autoOfflineAt': autoOfflineAt?.toJson(),
      'ratingAverage': ratingAverage,
      'ratingCount': ratingCount,
      'isVerified': isVerified,
      'isDocumentsSubmitted': isDocumentsSubmitted,
      'isFeatured': isFeatured,
      'isPremium': isPremium,
      if (premiumUntil != null) 'premiumUntil': premiumUntil?.toJson(),
      'totalCompletedOrders': totalCompletedOrders,
      'totalEarnings': totalEarnings,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (verifiedAt != null) 'verifiedAt': verifiedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DriverProfileImpl extends DriverProfile {
  _DriverProfileImpl({
    int? id,
    required int userId,
    required String displayName,
    String? bio,
    String? profilePhotoUrl,
    _i2.VehicleType? vehicleType,
    String? vehicleMake,
    String? vehicleModel,
    String? vehiclePlate,
    int? vehicleYear,
    String? vehiclePhotoUrl,
    int? experienceYears,
    _i3.DriverAvailabilityStatus? availabilityStatus,
    int? baseCityId,
    bool? isOnline,
    double? lastLocationLat,
    double? lastLocationLng,
    DateTime? lastLocationUpdatedAt,
    DateTime? autoOfflineAt,
    double? ratingAverage,
    int? ratingCount,
    bool? isVerified,
    bool? isDocumentsSubmitted,
    bool? isFeatured,
    bool? isPremium,
    DateTime? premiumUntil,
    int? totalCompletedOrders,
    double? totalEarnings,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? verifiedAt,
  }) : super._(
         id: id,
         userId: userId,
         displayName: displayName,
         bio: bio,
         profilePhotoUrl: profilePhotoUrl,
         vehicleType: vehicleType,
         vehicleMake: vehicleMake,
         vehicleModel: vehicleModel,
         vehiclePlate: vehiclePlate,
         vehicleYear: vehicleYear,
         vehiclePhotoUrl: vehiclePhotoUrl,
         experienceYears: experienceYears,
         availabilityStatus: availabilityStatus,
         baseCityId: baseCityId,
         isOnline: isOnline,
         lastLocationLat: lastLocationLat,
         lastLocationLng: lastLocationLng,
         lastLocationUpdatedAt: lastLocationUpdatedAt,
         autoOfflineAt: autoOfflineAt,
         ratingAverage: ratingAverage,
         ratingCount: ratingCount,
         isVerified: isVerified,
         isDocumentsSubmitted: isDocumentsSubmitted,
         isFeatured: isFeatured,
         isPremium: isPremium,
         premiumUntil: premiumUntil,
         totalCompletedOrders: totalCompletedOrders,
         totalEarnings: totalEarnings,
         createdAt: createdAt,
         updatedAt: updatedAt,
         verifiedAt: verifiedAt,
       );

  /// Returns a shallow copy of this [DriverProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DriverProfile copyWith({
    Object? id = _Undefined,
    int? userId,
    String? displayName,
    Object? bio = _Undefined,
    Object? profilePhotoUrl = _Undefined,
    Object? vehicleType = _Undefined,
    Object? vehicleMake = _Undefined,
    Object? vehicleModel = _Undefined,
    Object? vehiclePlate = _Undefined,
    Object? vehicleYear = _Undefined,
    Object? vehiclePhotoUrl = _Undefined,
    int? experienceYears,
    Object? availabilityStatus = _Undefined,
    Object? baseCityId = _Undefined,
    bool? isOnline,
    Object? lastLocationLat = _Undefined,
    Object? lastLocationLng = _Undefined,
    Object? lastLocationUpdatedAt = _Undefined,
    Object? autoOfflineAt = _Undefined,
    double? ratingAverage,
    int? ratingCount,
    bool? isVerified,
    bool? isDocumentsSubmitted,
    bool? isFeatured,
    bool? isPremium,
    Object? premiumUntil = _Undefined,
    int? totalCompletedOrders,
    double? totalEarnings,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? verifiedAt = _Undefined,
  }) {
    return DriverProfile(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      bio: bio is String? ? bio : this.bio,
      profilePhotoUrl: profilePhotoUrl is String?
          ? profilePhotoUrl
          : this.profilePhotoUrl,
      vehicleType: vehicleType is _i2.VehicleType?
          ? vehicleType
          : this.vehicleType,
      vehicleMake: vehicleMake is String? ? vehicleMake : this.vehicleMake,
      vehicleModel: vehicleModel is String? ? vehicleModel : this.vehicleModel,
      vehiclePlate: vehiclePlate is String? ? vehiclePlate : this.vehiclePlate,
      vehicleYear: vehicleYear is int? ? vehicleYear : this.vehicleYear,
      vehiclePhotoUrl: vehiclePhotoUrl is String?
          ? vehiclePhotoUrl
          : this.vehiclePhotoUrl,
      experienceYears: experienceYears ?? this.experienceYears,
      availabilityStatus: availabilityStatus is _i3.DriverAvailabilityStatus?
          ? availabilityStatus
          : this.availabilityStatus,
      baseCityId: baseCityId is int? ? baseCityId : this.baseCityId,
      isOnline: isOnline ?? this.isOnline,
      lastLocationLat: lastLocationLat is double?
          ? lastLocationLat
          : this.lastLocationLat,
      lastLocationLng: lastLocationLng is double?
          ? lastLocationLng
          : this.lastLocationLng,
      lastLocationUpdatedAt: lastLocationUpdatedAt is DateTime?
          ? lastLocationUpdatedAt
          : this.lastLocationUpdatedAt,
      autoOfflineAt: autoOfflineAt is DateTime?
          ? autoOfflineAt
          : this.autoOfflineAt,
      ratingAverage: ratingAverage ?? this.ratingAverage,
      ratingCount: ratingCount ?? this.ratingCount,
      isVerified: isVerified ?? this.isVerified,
      isDocumentsSubmitted: isDocumentsSubmitted ?? this.isDocumentsSubmitted,
      isFeatured: isFeatured ?? this.isFeatured,
      isPremium: isPremium ?? this.isPremium,
      premiumUntil: premiumUntil is DateTime?
          ? premiumUntil
          : this.premiumUntil,
      totalCompletedOrders: totalCompletedOrders ?? this.totalCompletedOrders,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      verifiedAt: verifiedAt is DateTime? ? verifiedAt : this.verifiedAt,
    );
  }
}
