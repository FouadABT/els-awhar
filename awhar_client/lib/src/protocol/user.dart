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
import 'user_role_enum.dart' as _i2;
import 'user_status_enum.dart' as _i3;
import 'language_enum.dart' as _i4;
import 'package:awhar_client/src/protocol/protocol.dart' as _i5;

abstract class User implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
