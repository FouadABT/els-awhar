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
import 'user_role_enum.dart' as _i2;
import 'user_status_enum.dart' as _i3;
import 'language_enum.dart' as _i4;
import 'package:awhar_server/src/generated/protocol.dart' as _i5;

abstract class User implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  User._({
    this.id,
    required this.firebaseUid,
    required this.fullName,
    this.phoneNumber,
    this.email,
    this.profilePhotoUrl,
    required this.roles,
    this.status,
    bool? isOnline,
    bool? isPhoneVerified,
    bool? isEmailVerified,
    double? rating,
    int? totalRatings,
    int? totalRatingsAsClient,
    double? ratingAsClient,
    this.vehicleInfo,
    this.vehiclePlate,
    double? averageRating,
    int? totalTrips,
    this.currentLatitude,
    this.currentLongitude,
    this.lastLocationUpdate,
    this.preferredLanguage,
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    this.fcmToken,
    bool? isSuspended,
    this.suspendedUntil,
    this.suspensionReason,
    int? totalReportsReceived,
    int? totalReportsMade,
    double? trustScore,
    String? trustLevel,
    this.trustScoreUpdatedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.lastSeenAt,
    this.deletedAt,
  }) : isOnline = isOnline ?? false,
       isPhoneVerified = isPhoneVerified ?? false,
       isEmailVerified = isEmailVerified ?? false,
       rating = rating ?? 0.0,
       totalRatings = totalRatings ?? 0,
       totalRatingsAsClient = totalRatingsAsClient ?? 0,
       ratingAsClient = ratingAsClient ?? 0.0,
       averageRating = averageRating ?? 0.0,
       totalTrips = totalTrips ?? 0,
       notificationsEnabled = notificationsEnabled ?? true,
       darkModeEnabled = darkModeEnabled ?? false,
       isSuspended = isSuspended ?? false,
       totalReportsReceived = totalReportsReceived ?? 0,
       totalReportsMade = totalReportsMade ?? 0,
       trustScore = trustScore ?? 0.0,
       trustLevel = trustLevel ?? 'FAIR',
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory User({
    int? id,
    required String firebaseUid,
    required String fullName,
    String? phoneNumber,
    String? email,
    String? profilePhotoUrl,
    required List<_i2.UserRole> roles,
    _i3.UserStatus? status,
    bool? isOnline,
    bool? isPhoneVerified,
    bool? isEmailVerified,
    double? rating,
    int? totalRatings,
    int? totalRatingsAsClient,
    double? ratingAsClient,
    String? vehicleInfo,
    String? vehiclePlate,
    double? averageRating,
    int? totalTrips,
    double? currentLatitude,
    double? currentLongitude,
    DateTime? lastLocationUpdate,
    _i4.Language? preferredLanguage,
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    String? fcmToken,
    bool? isSuspended,
    DateTime? suspendedUntil,
    String? suspensionReason,
    int? totalReportsReceived,
    int? totalReportsMade,
    double? trustScore,
    String? trustLevel,
    DateTime? trustScoreUpdatedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastSeenAt,
    DateTime? deletedAt,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] as int?,
      firebaseUid: jsonSerialization['firebaseUid'] as String,
      fullName: jsonSerialization['fullName'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String?,
      email: jsonSerialization['email'] as String?,
      profilePhotoUrl: jsonSerialization['profilePhotoUrl'] as String?,
      roles: _i5.Protocol().deserialize<List<_i2.UserRole>>(
        jsonSerialization['roles'],
      ),
      status: jsonSerialization['status'] == null
          ? null
          : _i3.UserStatus.fromJson((jsonSerialization['status'] as int)),
      isOnline: jsonSerialization['isOnline'] as bool,
      isPhoneVerified: jsonSerialization['isPhoneVerified'] as bool,
      isEmailVerified: jsonSerialization['isEmailVerified'] as bool,
      rating: (jsonSerialization['rating'] as num?)?.toDouble(),
      totalRatings: jsonSerialization['totalRatings'] as int,
      totalRatingsAsClient: jsonSerialization['totalRatingsAsClient'] as int,
      ratingAsClient: (jsonSerialization['ratingAsClient'] as num?)?.toDouble(),
      vehicleInfo: jsonSerialization['vehicleInfo'] as String?,
      vehiclePlate: jsonSerialization['vehiclePlate'] as String?,
      averageRating: (jsonSerialization['averageRating'] as num?)?.toDouble(),
      totalTrips: jsonSerialization['totalTrips'] as int,
      currentLatitude: (jsonSerialization['currentLatitude'] as num?)
          ?.toDouble(),
      currentLongitude: (jsonSerialization['currentLongitude'] as num?)
          ?.toDouble(),
      lastLocationUpdate: jsonSerialization['lastLocationUpdate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastLocationUpdate'],
            ),
      preferredLanguage: jsonSerialization['preferredLanguage'] == null
          ? null
          : _i4.Language.fromJson(
              (jsonSerialization['preferredLanguage'] as int),
            ),
      notificationsEnabled: jsonSerialization['notificationsEnabled'] as bool,
      darkModeEnabled: jsonSerialization['darkModeEnabled'] as bool,
      fcmToken: jsonSerialization['fcmToken'] as String?,
      isSuspended: jsonSerialization['isSuspended'] as bool,
      suspendedUntil: jsonSerialization['suspendedUntil'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['suspendedUntil'],
            ),
      suspensionReason: jsonSerialization['suspensionReason'] as String?,
      totalReportsReceived: jsonSerialization['totalReportsReceived'] as int,
      totalReportsMade: jsonSerialization['totalReportsMade'] as int,
      trustScore: (jsonSerialization['trustScore'] as num?)?.toDouble(),
      trustLevel: jsonSerialization['trustLevel'] as String?,
      trustScoreUpdatedAt: jsonSerialization['trustScoreUpdatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['trustScoreUpdatedAt'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      lastSeenAt: jsonSerialization['lastSeenAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastSeenAt']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  static final t = UserTable();

  static const db = UserRepository._();

  @override
  int? id;

  String firebaseUid;

  String fullName;

  String? phoneNumber;

  String? email;

  String? profilePhotoUrl;

  List<_i2.UserRole> roles;

  _i3.UserStatus? status;

  bool isOnline;

  bool isPhoneVerified;

  bool isEmailVerified;

  double? rating;

  int totalRatings;

  int totalRatingsAsClient;

  double? ratingAsClient;

  String? vehicleInfo;

  String? vehiclePlate;

  double? averageRating;

  int totalTrips;

  double? currentLatitude;

  double? currentLongitude;

  DateTime? lastLocationUpdate;

  _i4.Language? preferredLanguage;

  bool notificationsEnabled;

  bool darkModeEnabled;

  String? fcmToken;

  bool isSuspended;

  DateTime? suspendedUntil;

  String? suspensionReason;

  int totalReportsReceived;

  int totalReportsMade;

  double? trustScore;

  String? trustLevel;

  DateTime? trustScoreUpdatedAt;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? lastSeenAt;

  DateTime? deletedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  User copyWith({
    int? id,
    String? firebaseUid,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? profilePhotoUrl,
    List<_i2.UserRole>? roles,
    _i3.UserStatus? status,
    bool? isOnline,
    bool? isPhoneVerified,
    bool? isEmailVerified,
    double? rating,
    int? totalRatings,
    int? totalRatingsAsClient,
    double? ratingAsClient,
    String? vehicleInfo,
    String? vehiclePlate,
    double? averageRating,
    int? totalTrips,
    double? currentLatitude,
    double? currentLongitude,
    DateTime? lastLocationUpdate,
    _i4.Language? preferredLanguage,
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    String? fcmToken,
    bool? isSuspended,
    DateTime? suspendedUntil,
    String? suspensionReason,
    int? totalReportsReceived,
    int? totalReportsMade,
    double? trustScore,
    String? trustLevel,
    DateTime? trustScoreUpdatedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastSeenAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'User',
      if (id != null) 'id': id,
      'firebaseUid': firebaseUid,
      'fullName': fullName,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (email != null) 'email': email,
      if (profilePhotoUrl != null) 'profilePhotoUrl': profilePhotoUrl,
      'roles': roles.toJson(valueToJson: (v) => v.toJson()),
      if (status != null) 'status': status?.toJson(),
      'isOnline': isOnline,
      'isPhoneVerified': isPhoneVerified,
      'isEmailVerified': isEmailVerified,
      if (rating != null) 'rating': rating,
      'totalRatings': totalRatings,
      'totalRatingsAsClient': totalRatingsAsClient,
      if (ratingAsClient != null) 'ratingAsClient': ratingAsClient,
      if (vehicleInfo != null) 'vehicleInfo': vehicleInfo,
      if (vehiclePlate != null) 'vehiclePlate': vehiclePlate,
      if (averageRating != null) 'averageRating': averageRating,
      'totalTrips': totalTrips,
      if (currentLatitude != null) 'currentLatitude': currentLatitude,
      if (currentLongitude != null) 'currentLongitude': currentLongitude,
      if (lastLocationUpdate != null)
        'lastLocationUpdate': lastLocationUpdate?.toJson(),
      if (preferredLanguage != null)
        'preferredLanguage': preferredLanguage?.toJson(),
      'notificationsEnabled': notificationsEnabled,
      'darkModeEnabled': darkModeEnabled,
      if (fcmToken != null) 'fcmToken': fcmToken,
      'isSuspended': isSuspended,
      if (suspendedUntil != null) 'suspendedUntil': suspendedUntil?.toJson(),
      if (suspensionReason != null) 'suspensionReason': suspensionReason,
      'totalReportsReceived': totalReportsReceived,
      'totalReportsMade': totalReportsMade,
      if (trustScore != null) 'trustScore': trustScore,
      if (trustLevel != null) 'trustLevel': trustLevel,
      if (trustScoreUpdatedAt != null)
        'trustScoreUpdatedAt': trustScoreUpdatedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (lastSeenAt != null) 'lastSeenAt': lastSeenAt?.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'User',
      if (id != null) 'id': id,
      'firebaseUid': firebaseUid,
      'fullName': fullName,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (email != null) 'email': email,
      if (profilePhotoUrl != null) 'profilePhotoUrl': profilePhotoUrl,
      'roles': roles.toJson(valueToJson: (v) => v.toJson()),
      if (status != null) 'status': status?.toJson(),
      'isOnline': isOnline,
      'isPhoneVerified': isPhoneVerified,
      'isEmailVerified': isEmailVerified,
      if (rating != null) 'rating': rating,
      'totalRatings': totalRatings,
      'totalRatingsAsClient': totalRatingsAsClient,
      if (ratingAsClient != null) 'ratingAsClient': ratingAsClient,
      if (vehicleInfo != null) 'vehicleInfo': vehicleInfo,
      if (vehiclePlate != null) 'vehiclePlate': vehiclePlate,
      if (averageRating != null) 'averageRating': averageRating,
      'totalTrips': totalTrips,
      if (currentLatitude != null) 'currentLatitude': currentLatitude,
      if (currentLongitude != null) 'currentLongitude': currentLongitude,
      if (lastLocationUpdate != null)
        'lastLocationUpdate': lastLocationUpdate?.toJson(),
      if (preferredLanguage != null)
        'preferredLanguage': preferredLanguage?.toJson(),
      'notificationsEnabled': notificationsEnabled,
      'darkModeEnabled': darkModeEnabled,
      if (fcmToken != null) 'fcmToken': fcmToken,
      'isSuspended': isSuspended,
      if (suspendedUntil != null) 'suspendedUntil': suspendedUntil?.toJson(),
      if (suspensionReason != null) 'suspensionReason': suspensionReason,
      'totalReportsReceived': totalReportsReceived,
      'totalReportsMade': totalReportsMade,
      if (trustScore != null) 'trustScore': trustScore,
      if (trustLevel != null) 'trustLevel': trustLevel,
      if (trustScoreUpdatedAt != null)
        'trustScoreUpdatedAt': trustScoreUpdatedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (lastSeenAt != null) 'lastSeenAt': lastSeenAt?.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  static UserInclude include() {
    return UserInclude._();
  }

  static UserIncludeList includeList({
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    UserInclude? include,
  }) {
    return UserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(User.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(User.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    required String firebaseUid,
    required String fullName,
    String? phoneNumber,
    String? email,
    String? profilePhotoUrl,
    required List<_i2.UserRole> roles,
    _i3.UserStatus? status,
    bool? isOnline,
    bool? isPhoneVerified,
    bool? isEmailVerified,
    double? rating,
    int? totalRatings,
    int? totalRatingsAsClient,
    double? ratingAsClient,
    String? vehicleInfo,
    String? vehiclePlate,
    double? averageRating,
    int? totalTrips,
    double? currentLatitude,
    double? currentLongitude,
    DateTime? lastLocationUpdate,
    _i4.Language? preferredLanguage,
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    String? fcmToken,
    bool? isSuspended,
    DateTime? suspendedUntil,
    String? suspensionReason,
    int? totalReportsReceived,
    int? totalReportsMade,
    double? trustScore,
    String? trustLevel,
    DateTime? trustScoreUpdatedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastSeenAt,
    DateTime? deletedAt,
  }) : super._(
         id: id,
         firebaseUid: firebaseUid,
         fullName: fullName,
         phoneNumber: phoneNumber,
         email: email,
         profilePhotoUrl: profilePhotoUrl,
         roles: roles,
         status: status,
         isOnline: isOnline,
         isPhoneVerified: isPhoneVerified,
         isEmailVerified: isEmailVerified,
         rating: rating,
         totalRatings: totalRatings,
         totalRatingsAsClient: totalRatingsAsClient,
         ratingAsClient: ratingAsClient,
         vehicleInfo: vehicleInfo,
         vehiclePlate: vehiclePlate,
         averageRating: averageRating,
         totalTrips: totalTrips,
         currentLatitude: currentLatitude,
         currentLongitude: currentLongitude,
         lastLocationUpdate: lastLocationUpdate,
         preferredLanguage: preferredLanguage,
         notificationsEnabled: notificationsEnabled,
         darkModeEnabled: darkModeEnabled,
         fcmToken: fcmToken,
         isSuspended: isSuspended,
         suspendedUntil: suspendedUntil,
         suspensionReason: suspensionReason,
         totalReportsReceived: totalReportsReceived,
         totalReportsMade: totalReportsMade,
         trustScore: trustScore,
         trustLevel: trustLevel,
         trustScoreUpdatedAt: trustScoreUpdatedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
         lastSeenAt: lastSeenAt,
         deletedAt: deletedAt,
       );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  User copyWith({
    Object? id = _Undefined,
    String? firebaseUid,
    String? fullName,
    Object? phoneNumber = _Undefined,
    Object? email = _Undefined,
    Object? profilePhotoUrl = _Undefined,
    List<_i2.UserRole>? roles,
    Object? status = _Undefined,
    bool? isOnline,
    bool? isPhoneVerified,
    bool? isEmailVerified,
    Object? rating = _Undefined,
    int? totalRatings,
    int? totalRatingsAsClient,
    Object? ratingAsClient = _Undefined,
    Object? vehicleInfo = _Undefined,
    Object? vehiclePlate = _Undefined,
    Object? averageRating = _Undefined,
    int? totalTrips,
    Object? currentLatitude = _Undefined,
    Object? currentLongitude = _Undefined,
    Object? lastLocationUpdate = _Undefined,
    Object? preferredLanguage = _Undefined,
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    Object? fcmToken = _Undefined,
    bool? isSuspended,
    Object? suspendedUntil = _Undefined,
    Object? suspensionReason = _Undefined,
    int? totalReportsReceived,
    int? totalReportsMade,
    Object? trustScore = _Undefined,
    Object? trustLevel = _Undefined,
    Object? trustScoreUpdatedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? lastSeenAt = _Undefined,
    Object? deletedAt = _Undefined,
  }) {
    return User(
      id: id is int? ? id : this.id,
      firebaseUid: firebaseUid ?? this.firebaseUid,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber is String? ? phoneNumber : this.phoneNumber,
      email: email is String? ? email : this.email,
      profilePhotoUrl: profilePhotoUrl is String?
          ? profilePhotoUrl
          : this.profilePhotoUrl,
      roles: roles ?? this.roles.map((e0) => e0).toList(),
      status: status is _i3.UserStatus? ? status : this.status,
      isOnline: isOnline ?? this.isOnline,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      rating: rating is double? ? rating : this.rating,
      totalRatings: totalRatings ?? this.totalRatings,
      totalRatingsAsClient: totalRatingsAsClient ?? this.totalRatingsAsClient,
      ratingAsClient: ratingAsClient is double?
          ? ratingAsClient
          : this.ratingAsClient,
      vehicleInfo: vehicleInfo is String? ? vehicleInfo : this.vehicleInfo,
      vehiclePlate: vehiclePlate is String? ? vehiclePlate : this.vehiclePlate,
      averageRating: averageRating is double?
          ? averageRating
          : this.averageRating,
      totalTrips: totalTrips ?? this.totalTrips,
      currentLatitude: currentLatitude is double?
          ? currentLatitude
          : this.currentLatitude,
      currentLongitude: currentLongitude is double?
          ? currentLongitude
          : this.currentLongitude,
      lastLocationUpdate: lastLocationUpdate is DateTime?
          ? lastLocationUpdate
          : this.lastLocationUpdate,
      preferredLanguage: preferredLanguage is _i4.Language?
          ? preferredLanguage
          : this.preferredLanguage,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      fcmToken: fcmToken is String? ? fcmToken : this.fcmToken,
      isSuspended: isSuspended ?? this.isSuspended,
      suspendedUntil: suspendedUntil is DateTime?
          ? suspendedUntil
          : this.suspendedUntil,
      suspensionReason: suspensionReason is String?
          ? suspensionReason
          : this.suspensionReason,
      totalReportsReceived: totalReportsReceived ?? this.totalReportsReceived,
      totalReportsMade: totalReportsMade ?? this.totalReportsMade,
      trustScore: trustScore is double? ? trustScore : this.trustScore,
      trustLevel: trustLevel is String? ? trustLevel : this.trustLevel,
      trustScoreUpdatedAt: trustScoreUpdatedAt is DateTime?
          ? trustScoreUpdatedAt
          : this.trustScoreUpdatedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSeenAt: lastSeenAt is DateTime? ? lastSeenAt : this.lastSeenAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}

class UserUpdateTable extends _i1.UpdateTable<UserTable> {
  UserUpdateTable(super.table);

  _i1.ColumnValue<String, String> firebaseUid(String value) => _i1.ColumnValue(
    table.firebaseUid,
    value,
  );

  _i1.ColumnValue<String, String> fullName(String value) => _i1.ColumnValue(
    table.fullName,
    value,
  );

  _i1.ColumnValue<String, String> phoneNumber(String? value) => _i1.ColumnValue(
    table.phoneNumber,
    value,
  );

  _i1.ColumnValue<String, String> email(String? value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<String, String> profilePhotoUrl(String? value) =>
      _i1.ColumnValue(
        table.profilePhotoUrl,
        value,
      );

  _i1.ColumnValue<List<_i2.UserRole>, List<_i2.UserRole>> roles(
    List<_i2.UserRole> value,
  ) => _i1.ColumnValue(
    table.roles,
    value,
  );

  _i1.ColumnValue<_i3.UserStatus, _i3.UserStatus> status(
    _i3.UserStatus? value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<bool, bool> isOnline(bool value) => _i1.ColumnValue(
    table.isOnline,
    value,
  );

  _i1.ColumnValue<bool, bool> isPhoneVerified(bool value) => _i1.ColumnValue(
    table.isPhoneVerified,
    value,
  );

  _i1.ColumnValue<bool, bool> isEmailVerified(bool value) => _i1.ColumnValue(
    table.isEmailVerified,
    value,
  );

  _i1.ColumnValue<double, double> rating(double? value) => _i1.ColumnValue(
    table.rating,
    value,
  );

  _i1.ColumnValue<int, int> totalRatings(int value) => _i1.ColumnValue(
    table.totalRatings,
    value,
  );

  _i1.ColumnValue<int, int> totalRatingsAsClient(int value) => _i1.ColumnValue(
    table.totalRatingsAsClient,
    value,
  );

  _i1.ColumnValue<double, double> ratingAsClient(double? value) =>
      _i1.ColumnValue(
        table.ratingAsClient,
        value,
      );

  _i1.ColumnValue<String, String> vehicleInfo(String? value) => _i1.ColumnValue(
    table.vehicleInfo,
    value,
  );

  _i1.ColumnValue<String, String> vehiclePlate(String? value) =>
      _i1.ColumnValue(
        table.vehiclePlate,
        value,
      );

  _i1.ColumnValue<double, double> averageRating(double? value) =>
      _i1.ColumnValue(
        table.averageRating,
        value,
      );

  _i1.ColumnValue<int, int> totalTrips(int value) => _i1.ColumnValue(
    table.totalTrips,
    value,
  );

  _i1.ColumnValue<double, double> currentLatitude(double? value) =>
      _i1.ColumnValue(
        table.currentLatitude,
        value,
      );

  _i1.ColumnValue<double, double> currentLongitude(double? value) =>
      _i1.ColumnValue(
        table.currentLongitude,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lastLocationUpdate(DateTime? value) =>
      _i1.ColumnValue(
        table.lastLocationUpdate,
        value,
      );

  _i1.ColumnValue<_i4.Language, _i4.Language> preferredLanguage(
    _i4.Language? value,
  ) => _i1.ColumnValue(
    table.preferredLanguage,
    value,
  );

  _i1.ColumnValue<bool, bool> notificationsEnabled(bool value) =>
      _i1.ColumnValue(
        table.notificationsEnabled,
        value,
      );

  _i1.ColumnValue<bool, bool> darkModeEnabled(bool value) => _i1.ColumnValue(
    table.darkModeEnabled,
    value,
  );

  _i1.ColumnValue<String, String> fcmToken(String? value) => _i1.ColumnValue(
    table.fcmToken,
    value,
  );

  _i1.ColumnValue<bool, bool> isSuspended(bool value) => _i1.ColumnValue(
    table.isSuspended,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> suspendedUntil(DateTime? value) =>
      _i1.ColumnValue(
        table.suspendedUntil,
        value,
      );

  _i1.ColumnValue<String, String> suspensionReason(String? value) =>
      _i1.ColumnValue(
        table.suspensionReason,
        value,
      );

  _i1.ColumnValue<int, int> totalReportsReceived(int value) => _i1.ColumnValue(
    table.totalReportsReceived,
    value,
  );

  _i1.ColumnValue<int, int> totalReportsMade(int value) => _i1.ColumnValue(
    table.totalReportsMade,
    value,
  );

  _i1.ColumnValue<double, double> trustScore(double? value) => _i1.ColumnValue(
    table.trustScore,
    value,
  );

  _i1.ColumnValue<String, String> trustLevel(String? value) => _i1.ColumnValue(
    table.trustLevel,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> trustScoreUpdatedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.trustScoreUpdatedAt,
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

  _i1.ColumnValue<DateTime, DateTime> lastSeenAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastSeenAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> deletedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.deletedAt,
        value,
      );
}

class UserTable extends _i1.Table<int?> {
  UserTable({super.tableRelation}) : super(tableName: 'users') {
    updateTable = UserUpdateTable(this);
    firebaseUid = _i1.ColumnString(
      'firebaseUid',
      this,
    );
    fullName = _i1.ColumnString(
      'fullName',
      this,
    );
    phoneNumber = _i1.ColumnString(
      'phoneNumber',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    profilePhotoUrl = _i1.ColumnString(
      'profilePhotoUrl',
      this,
    );
    roles = _i1.ColumnSerializable<List<_i2.UserRole>>(
      'roles',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byIndex,
    );
    isOnline = _i1.ColumnBool(
      'isOnline',
      this,
      hasDefault: true,
    );
    isPhoneVerified = _i1.ColumnBool(
      'isPhoneVerified',
      this,
      hasDefault: true,
    );
    isEmailVerified = _i1.ColumnBool(
      'isEmailVerified',
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
    totalRatingsAsClient = _i1.ColumnInt(
      'totalRatingsAsClient',
      this,
      hasDefault: true,
    );
    ratingAsClient = _i1.ColumnDouble(
      'ratingAsClient',
      this,
      hasDefault: true,
    );
    vehicleInfo = _i1.ColumnString(
      'vehicleInfo',
      this,
    );
    vehiclePlate = _i1.ColumnString(
      'vehiclePlate',
      this,
    );
    averageRating = _i1.ColumnDouble(
      'averageRating',
      this,
      hasDefault: true,
    );
    totalTrips = _i1.ColumnInt(
      'totalTrips',
      this,
      hasDefault: true,
    );
    currentLatitude = _i1.ColumnDouble(
      'currentLatitude',
      this,
    );
    currentLongitude = _i1.ColumnDouble(
      'currentLongitude',
      this,
    );
    lastLocationUpdate = _i1.ColumnDateTime(
      'lastLocationUpdate',
      this,
    );
    preferredLanguage = _i1.ColumnEnum(
      'preferredLanguage',
      this,
      _i1.EnumSerialization.byIndex,
    );
    notificationsEnabled = _i1.ColumnBool(
      'notificationsEnabled',
      this,
      hasDefault: true,
    );
    darkModeEnabled = _i1.ColumnBool(
      'darkModeEnabled',
      this,
      hasDefault: true,
    );
    fcmToken = _i1.ColumnString(
      'fcmToken',
      this,
    );
    isSuspended = _i1.ColumnBool(
      'isSuspended',
      this,
      hasDefault: true,
    );
    suspendedUntil = _i1.ColumnDateTime(
      'suspendedUntil',
      this,
    );
    suspensionReason = _i1.ColumnString(
      'suspensionReason',
      this,
    );
    totalReportsReceived = _i1.ColumnInt(
      'totalReportsReceived',
      this,
      hasDefault: true,
    );
    totalReportsMade = _i1.ColumnInt(
      'totalReportsMade',
      this,
      hasDefault: true,
    );
    trustScore = _i1.ColumnDouble(
      'trustScore',
      this,
      hasDefault: true,
    );
    trustLevel = _i1.ColumnString(
      'trustLevel',
      this,
      hasDefault: true,
    );
    trustScoreUpdatedAt = _i1.ColumnDateTime(
      'trustScoreUpdatedAt',
      this,
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
    lastSeenAt = _i1.ColumnDateTime(
      'lastSeenAt',
      this,
    );
    deletedAt = _i1.ColumnDateTime(
      'deletedAt',
      this,
    );
  }

  late final UserUpdateTable updateTable;

  late final _i1.ColumnString firebaseUid;

  late final _i1.ColumnString fullName;

  late final _i1.ColumnString phoneNumber;

  late final _i1.ColumnString email;

  late final _i1.ColumnString profilePhotoUrl;

  late final _i1.ColumnSerializable<List<_i2.UserRole>> roles;

  late final _i1.ColumnEnum<_i3.UserStatus> status;

  late final _i1.ColumnBool isOnline;

  late final _i1.ColumnBool isPhoneVerified;

  late final _i1.ColumnBool isEmailVerified;

  late final _i1.ColumnDouble rating;

  late final _i1.ColumnInt totalRatings;

  late final _i1.ColumnInt totalRatingsAsClient;

  late final _i1.ColumnDouble ratingAsClient;

  late final _i1.ColumnString vehicleInfo;

  late final _i1.ColumnString vehiclePlate;

  late final _i1.ColumnDouble averageRating;

  late final _i1.ColumnInt totalTrips;

  late final _i1.ColumnDouble currentLatitude;

  late final _i1.ColumnDouble currentLongitude;

  late final _i1.ColumnDateTime lastLocationUpdate;

  late final _i1.ColumnEnum<_i4.Language> preferredLanguage;

  late final _i1.ColumnBool notificationsEnabled;

  late final _i1.ColumnBool darkModeEnabled;

  late final _i1.ColumnString fcmToken;

  late final _i1.ColumnBool isSuspended;

  late final _i1.ColumnDateTime suspendedUntil;

  late final _i1.ColumnString suspensionReason;

  late final _i1.ColumnInt totalReportsReceived;

  late final _i1.ColumnInt totalReportsMade;

  late final _i1.ColumnDouble trustScore;

  late final _i1.ColumnString trustLevel;

  late final _i1.ColumnDateTime trustScoreUpdatedAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime lastSeenAt;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    firebaseUid,
    fullName,
    phoneNumber,
    email,
    profilePhotoUrl,
    roles,
    status,
    isOnline,
    isPhoneVerified,
    isEmailVerified,
    rating,
    totalRatings,
    totalRatingsAsClient,
    ratingAsClient,
    vehicleInfo,
    vehiclePlate,
    averageRating,
    totalTrips,
    currentLatitude,
    currentLongitude,
    lastLocationUpdate,
    preferredLanguage,
    notificationsEnabled,
    darkModeEnabled,
    fcmToken,
    isSuspended,
    suspendedUntil,
    suspensionReason,
    totalReportsReceived,
    totalReportsMade,
    trustScore,
    trustLevel,
    trustScoreUpdatedAt,
    createdAt,
    updatedAt,
    lastSeenAt,
    deletedAt,
  ];
}

class UserInclude extends _i1.IncludeObject {
  UserInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => User.t;
}

class UserIncludeList extends _i1.IncludeList {
  UserIncludeList._({
    _i1.WhereExpressionBuilder<UserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(User.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => User.t;
}

class UserRepository {
  const UserRepository._();

  /// Returns a list of [User]s matching the given query parameters.
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
  Future<List<User>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [User] matching the given query parameters.
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
  Future<User?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [User] by its [id] or null if no such row exists.
  Future<User?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<User>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [User]s in the list and returns the inserted rows.
  ///
  /// The returned [User]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<User>> insert(
    _i1.Session session,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<User>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [User] and returns the inserted row.
  ///
  /// The returned [User] will have its `id` field set.
  Future<User> insertRow(
    _i1.Session session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<User>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [User]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<User>> update(
    _i1.Session session,
    List<User> rows, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<User>(
      rows,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  /// Updates a single [User]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<User> updateRow(
    _i1.Session session,
    User row, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<User>(
      row,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  /// Updates a single [User] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<User?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<UserUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<User>(
      id,
      columnValues: columnValues(User.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [User]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<User>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<UserUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<User>(
      columnValues: columnValues(User.t.updateTable),
      where: where(User.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [User]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<User>> delete(
    _i1.Session session,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<User>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [User].
  Future<User> deleteRow(
    _i1.Session session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<User>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<User>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<User>(
      where: where(User.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<User>(
      where: where?.call(User.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
