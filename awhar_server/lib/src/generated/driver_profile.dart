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
import 'vehicle_type_enum.dart' as _i2;
import 'driver_availability_status_enum.dart' as _i3;

abstract class DriverProfile
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = DriverProfileTable();

  static const db = DriverProfileRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static DriverProfileInclude include() {
    return DriverProfileInclude._();
  }

  static DriverProfileIncludeList includeList({
    _i1.WhereExpressionBuilder<DriverProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverProfileTable>? orderByList,
    DriverProfileInclude? include,
  }) {
    return DriverProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DriverProfile.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DriverProfile.t),
      include: include,
    );
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

class DriverProfileUpdateTable extends _i1.UpdateTable<DriverProfileTable> {
  DriverProfileUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> displayName(String value) => _i1.ColumnValue(
    table.displayName,
    value,
  );

  _i1.ColumnValue<String, String> bio(String? value) => _i1.ColumnValue(
    table.bio,
    value,
  );

  _i1.ColumnValue<String, String> profilePhotoUrl(String? value) =>
      _i1.ColumnValue(
        table.profilePhotoUrl,
        value,
      );

  _i1.ColumnValue<_i2.VehicleType, _i2.VehicleType> vehicleType(
    _i2.VehicleType? value,
  ) => _i1.ColumnValue(
    table.vehicleType,
    value,
  );

  _i1.ColumnValue<String, String> vehicleMake(String? value) => _i1.ColumnValue(
    table.vehicleMake,
    value,
  );

  _i1.ColumnValue<String, String> vehicleModel(String? value) =>
      _i1.ColumnValue(
        table.vehicleModel,
        value,
      );

  _i1.ColumnValue<String, String> vehiclePlate(String? value) =>
      _i1.ColumnValue(
        table.vehiclePlate,
        value,
      );

  _i1.ColumnValue<int, int> vehicleYear(int? value) => _i1.ColumnValue(
    table.vehicleYear,
    value,
  );

  _i1.ColumnValue<String, String> vehiclePhotoUrl(String? value) =>
      _i1.ColumnValue(
        table.vehiclePhotoUrl,
        value,
      );

  _i1.ColumnValue<int, int> experienceYears(int value) => _i1.ColumnValue(
    table.experienceYears,
    value,
  );

  _i1.ColumnValue<_i3.DriverAvailabilityStatus, _i3.DriverAvailabilityStatus>
  availabilityStatus(_i3.DriverAvailabilityStatus? value) => _i1.ColumnValue(
    table.availabilityStatus,
    value,
  );

  _i1.ColumnValue<int, int> baseCityId(int? value) => _i1.ColumnValue(
    table.baseCityId,
    value,
  );

  _i1.ColumnValue<bool, bool> isOnline(bool value) => _i1.ColumnValue(
    table.isOnline,
    value,
  );

  _i1.ColumnValue<double, double> lastLocationLat(double? value) =>
      _i1.ColumnValue(
        table.lastLocationLat,
        value,
      );

  _i1.ColumnValue<double, double> lastLocationLng(double? value) =>
      _i1.ColumnValue(
        table.lastLocationLng,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lastLocationUpdatedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastLocationUpdatedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> autoOfflineAt(DateTime? value) =>
      _i1.ColumnValue(
        table.autoOfflineAt,
        value,
      );

  _i1.ColumnValue<double, double> ratingAverage(double value) =>
      _i1.ColumnValue(
        table.ratingAverage,
        value,
      );

  _i1.ColumnValue<int, int> ratingCount(int value) => _i1.ColumnValue(
    table.ratingCount,
    value,
  );

  _i1.ColumnValue<bool, bool> isVerified(bool value) => _i1.ColumnValue(
    table.isVerified,
    value,
  );

  _i1.ColumnValue<bool, bool> isDocumentsSubmitted(bool value) =>
      _i1.ColumnValue(
        table.isDocumentsSubmitted,
        value,
      );

  _i1.ColumnValue<bool, bool> isFeatured(bool value) => _i1.ColumnValue(
    table.isFeatured,
    value,
  );

  _i1.ColumnValue<bool, bool> isPremium(bool value) => _i1.ColumnValue(
    table.isPremium,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> premiumUntil(DateTime? value) =>
      _i1.ColumnValue(
        table.premiumUntil,
        value,
      );

  _i1.ColumnValue<int, int> totalCompletedOrders(int value) => _i1.ColumnValue(
    table.totalCompletedOrders,
    value,
  );

  _i1.ColumnValue<double, double> totalEarnings(double value) =>
      _i1.ColumnValue(
        table.totalEarnings,
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

  _i1.ColumnValue<DateTime, DateTime> verifiedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.verifiedAt,
        value,
      );
}

class DriverProfileTable extends _i1.Table<int?> {
  DriverProfileTable({super.tableRelation})
    : super(tableName: 'driver_profiles') {
    updateTable = DriverProfileUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    displayName = _i1.ColumnString(
      'displayName',
      this,
    );
    bio = _i1.ColumnString(
      'bio',
      this,
    );
    profilePhotoUrl = _i1.ColumnString(
      'profilePhotoUrl',
      this,
    );
    vehicleType = _i1.ColumnEnum(
      'vehicleType',
      this,
      _i1.EnumSerialization.byIndex,
    );
    vehicleMake = _i1.ColumnString(
      'vehicleMake',
      this,
    );
    vehicleModel = _i1.ColumnString(
      'vehicleModel',
      this,
    );
    vehiclePlate = _i1.ColumnString(
      'vehiclePlate',
      this,
    );
    vehicleYear = _i1.ColumnInt(
      'vehicleYear',
      this,
    );
    vehiclePhotoUrl = _i1.ColumnString(
      'vehiclePhotoUrl',
      this,
    );
    experienceYears = _i1.ColumnInt(
      'experienceYears',
      this,
      hasDefault: true,
    );
    availabilityStatus = _i1.ColumnEnum(
      'availabilityStatus',
      this,
      _i1.EnumSerialization.byIndex,
    );
    baseCityId = _i1.ColumnInt(
      'baseCityId',
      this,
    );
    isOnline = _i1.ColumnBool(
      'isOnline',
      this,
      hasDefault: true,
    );
    lastLocationLat = _i1.ColumnDouble(
      'lastLocationLat',
      this,
    );
    lastLocationLng = _i1.ColumnDouble(
      'lastLocationLng',
      this,
    );
    lastLocationUpdatedAt = _i1.ColumnDateTime(
      'lastLocationUpdatedAt',
      this,
    );
    autoOfflineAt = _i1.ColumnDateTime(
      'autoOfflineAt',
      this,
    );
    ratingAverage = _i1.ColumnDouble(
      'ratingAverage',
      this,
      hasDefault: true,
    );
    ratingCount = _i1.ColumnInt(
      'ratingCount',
      this,
      hasDefault: true,
    );
    isVerified = _i1.ColumnBool(
      'isVerified',
      this,
      hasDefault: true,
    );
    isDocumentsSubmitted = _i1.ColumnBool(
      'isDocumentsSubmitted',
      this,
      hasDefault: true,
    );
    isFeatured = _i1.ColumnBool(
      'isFeatured',
      this,
      hasDefault: true,
    );
    isPremium = _i1.ColumnBool(
      'isPremium',
      this,
      hasDefault: true,
    );
    premiumUntil = _i1.ColumnDateTime(
      'premiumUntil',
      this,
    );
    totalCompletedOrders = _i1.ColumnInt(
      'totalCompletedOrders',
      this,
      hasDefault: true,
    );
    totalEarnings = _i1.ColumnDouble(
      'totalEarnings',
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
    verifiedAt = _i1.ColumnDateTime(
      'verifiedAt',
      this,
    );
  }

  late final DriverProfileUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString displayName;

  late final _i1.ColumnString bio;

  late final _i1.ColumnString profilePhotoUrl;

  late final _i1.ColumnEnum<_i2.VehicleType> vehicleType;

  late final _i1.ColumnString vehicleMake;

  late final _i1.ColumnString vehicleModel;

  late final _i1.ColumnString vehiclePlate;

  late final _i1.ColumnInt vehicleYear;

  late final _i1.ColumnString vehiclePhotoUrl;

  late final _i1.ColumnInt experienceYears;

  late final _i1.ColumnEnum<_i3.DriverAvailabilityStatus> availabilityStatus;

  late final _i1.ColumnInt baseCityId;

  late final _i1.ColumnBool isOnline;

  late final _i1.ColumnDouble lastLocationLat;

  late final _i1.ColumnDouble lastLocationLng;

  late final _i1.ColumnDateTime lastLocationUpdatedAt;

  late final _i1.ColumnDateTime autoOfflineAt;

  late final _i1.ColumnDouble ratingAverage;

  late final _i1.ColumnInt ratingCount;

  late final _i1.ColumnBool isVerified;

  late final _i1.ColumnBool isDocumentsSubmitted;

  late final _i1.ColumnBool isFeatured;

  late final _i1.ColumnBool isPremium;

  late final _i1.ColumnDateTime premiumUntil;

  late final _i1.ColumnInt totalCompletedOrders;

  late final _i1.ColumnDouble totalEarnings;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime verifiedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    displayName,
    bio,
    profilePhotoUrl,
    vehicleType,
    vehicleMake,
    vehicleModel,
    vehiclePlate,
    vehicleYear,
    vehiclePhotoUrl,
    experienceYears,
    availabilityStatus,
    baseCityId,
    isOnline,
    lastLocationLat,
    lastLocationLng,
    lastLocationUpdatedAt,
    autoOfflineAt,
    ratingAverage,
    ratingCount,
    isVerified,
    isDocumentsSubmitted,
    isFeatured,
    isPremium,
    premiumUntil,
    totalCompletedOrders,
    totalEarnings,
    createdAt,
    updatedAt,
    verifiedAt,
  ];
}

class DriverProfileInclude extends _i1.IncludeObject {
  DriverProfileInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DriverProfile.t;
}

class DriverProfileIncludeList extends _i1.IncludeList {
  DriverProfileIncludeList._({
    _i1.WhereExpressionBuilder<DriverProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DriverProfile.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DriverProfile.t;
}

class DriverProfileRepository {
  const DriverProfileRepository._();

  /// Returns a list of [DriverProfile]s matching the given query parameters.
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
  Future<List<DriverProfile>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverProfileTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<DriverProfile>(
      where: where?.call(DriverProfile.t),
      orderBy: orderBy?.call(DriverProfile.t),
      orderByList: orderByList?.call(DriverProfile.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [DriverProfile] matching the given query parameters.
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
  Future<DriverProfile?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverProfileTable>? where,
    int? offset,
    _i1.OrderByBuilder<DriverProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DriverProfileTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<DriverProfile>(
      where: where?.call(DriverProfile.t),
      orderBy: orderBy?.call(DriverProfile.t),
      orderByList: orderByList?.call(DriverProfile.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [DriverProfile] by its [id] or null if no such row exists.
  Future<DriverProfile?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<DriverProfile>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [DriverProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [DriverProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<DriverProfile>> insert(
    _i1.Session session,
    List<DriverProfile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<DriverProfile>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [DriverProfile] and returns the inserted row.
  ///
  /// The returned [DriverProfile] will have its `id` field set.
  Future<DriverProfile> insertRow(
    _i1.Session session,
    DriverProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DriverProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DriverProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DriverProfile>> update(
    _i1.Session session,
    List<DriverProfile> rows, {
    _i1.ColumnSelections<DriverProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DriverProfile>(
      rows,
      columns: columns?.call(DriverProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DriverProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DriverProfile> updateRow(
    _i1.Session session,
    DriverProfile row, {
    _i1.ColumnSelections<DriverProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DriverProfile>(
      row,
      columns: columns?.call(DriverProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DriverProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DriverProfile?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<DriverProfileUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DriverProfile>(
      id,
      columnValues: columnValues(DriverProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DriverProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DriverProfile>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DriverProfileUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DriverProfileTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DriverProfileTable>? orderBy,
    _i1.OrderByListBuilder<DriverProfileTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DriverProfile>(
      columnValues: columnValues(DriverProfile.t.updateTable),
      where: where(DriverProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DriverProfile.t),
      orderByList: orderByList?.call(DriverProfile.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DriverProfile]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DriverProfile>> delete(
    _i1.Session session,
    List<DriverProfile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DriverProfile>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DriverProfile].
  Future<DriverProfile> deleteRow(
    _i1.Session session,
    DriverProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DriverProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DriverProfile>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DriverProfileTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DriverProfile>(
      where: where(DriverProfile.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DriverProfileTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DriverProfile>(
      where: where?.call(DriverProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
