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

abstract class DeviceFingerprintRecord implements _i1.SerializableModel {
  DeviceFingerprintRecord._({
    this.id,
    required this.fingerprintHash,
    this.deviceId,
    this.deviceModel,
    this.deviceBrand,
    this.screenWidth,
    this.screenHeight,
    this.screenDensity,
    this.cpuCores,
    this.isPhysicalDevice,
    this.osVersion,
    this.timezone,
    this.language,
    this.appVersion,
    this.lastIpAddress,
    required this.userIds,
    required this.riskScore,
    this.riskFactors,
    required this.isBlocked,
    this.notes,
    required this.firstSeenAt,
    required this.lastSeenAt,
  });

  factory DeviceFingerprintRecord({
    int? id,
    required String fingerprintHash,
    String? deviceId,
    String? deviceModel,
    String? deviceBrand,
    int? screenWidth,
    int? screenHeight,
    double? screenDensity,
    int? cpuCores,
    bool? isPhysicalDevice,
    String? osVersion,
    String? timezone,
    String? language,
    String? appVersion,
    String? lastIpAddress,
    required String userIds,
    required double riskScore,
    String? riskFactors,
    required bool isBlocked,
    String? notes,
    required DateTime firstSeenAt,
    required DateTime lastSeenAt,
  }) = _DeviceFingerprintRecordImpl;

  factory DeviceFingerprintRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DeviceFingerprintRecord(
      id: jsonSerialization['id'] as int?,
      fingerprintHash: jsonSerialization['fingerprintHash'] as String,
      deviceId: jsonSerialization['deviceId'] as String?,
      deviceModel: jsonSerialization['deviceModel'] as String?,
      deviceBrand: jsonSerialization['deviceBrand'] as String?,
      screenWidth: jsonSerialization['screenWidth'] as int?,
      screenHeight: jsonSerialization['screenHeight'] as int?,
      screenDensity: (jsonSerialization['screenDensity'] as num?)?.toDouble(),
      cpuCores: jsonSerialization['cpuCores'] as int?,
      isPhysicalDevice: jsonSerialization['isPhysicalDevice'] as bool?,
      osVersion: jsonSerialization['osVersion'] as String?,
      timezone: jsonSerialization['timezone'] as String?,
      language: jsonSerialization['language'] as String?,
      appVersion: jsonSerialization['appVersion'] as String?,
      lastIpAddress: jsonSerialization['lastIpAddress'] as String?,
      userIds: jsonSerialization['userIds'] as String,
      riskScore: (jsonSerialization['riskScore'] as num).toDouble(),
      riskFactors: jsonSerialization['riskFactors'] as String?,
      isBlocked: jsonSerialization['isBlocked'] as bool,
      notes: jsonSerialization['notes'] as String?,
      firstSeenAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['firstSeenAt'],
      ),
      lastSeenAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastSeenAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Fingerprint identification
  String fingerprintHash;

  /// Device identifiers (can be multiple per fingerprint due to reinstalls)
  String? deviceId;

  /// Device identifiers (can be multiple per fingerprint due to reinstalls)
  String? deviceModel;

  /// Device identifiers (can be multiple per fingerprint due to reinstalls)
  String? deviceBrand;

  /// Screen info
  int? screenWidth;

  int? screenHeight;

  double? screenDensity;

  /// Hardware specs
  int? cpuCores;

  bool? isPhysicalDevice;

  /// OS info
  String? osVersion;

  /// Locale info
  String? timezone;

  /// Locale info
  String? language;

  /// App info
  String? appVersion;

  /// Network info (captured on each check)
  String? lastIpAddress;

  /// User associations (multi-value - stored as JSON array)
  /// These are the user IDs that have used this device
  String userIds;

  /// Risk assessment
  double riskScore;

  /// Risk assessment
  String? riskFactors;

  /// Risk assessment
  bool isBlocked;

  /// Admin notes
  String? notes;

  /// Timestamps
  DateTime firstSeenAt;

  DateTime lastSeenAt;

  /// Returns a shallow copy of this [DeviceFingerprintRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceFingerprintRecord copyWith({
    int? id,
    String? fingerprintHash,
    String? deviceId,
    String? deviceModel,
    String? deviceBrand,
    int? screenWidth,
    int? screenHeight,
    double? screenDensity,
    int? cpuCores,
    bool? isPhysicalDevice,
    String? osVersion,
    String? timezone,
    String? language,
    String? appVersion,
    String? lastIpAddress,
    String? userIds,
    double? riskScore,
    String? riskFactors,
    bool? isBlocked,
    String? notes,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceFingerprintRecord',
      if (id != null) 'id': id,
      'fingerprintHash': fingerprintHash,
      if (deviceId != null) 'deviceId': deviceId,
      if (deviceModel != null) 'deviceModel': deviceModel,
      if (deviceBrand != null) 'deviceBrand': deviceBrand,
      if (screenWidth != null) 'screenWidth': screenWidth,
      if (screenHeight != null) 'screenHeight': screenHeight,
      if (screenDensity != null) 'screenDensity': screenDensity,
      if (cpuCores != null) 'cpuCores': cpuCores,
      if (isPhysicalDevice != null) 'isPhysicalDevice': isPhysicalDevice,
      if (osVersion != null) 'osVersion': osVersion,
      if (timezone != null) 'timezone': timezone,
      if (language != null) 'language': language,
      if (appVersion != null) 'appVersion': appVersion,
      if (lastIpAddress != null) 'lastIpAddress': lastIpAddress,
      'userIds': userIds,
      'riskScore': riskScore,
      if (riskFactors != null) 'riskFactors': riskFactors,
      'isBlocked': isBlocked,
      if (notes != null) 'notes': notes,
      'firstSeenAt': firstSeenAt.toJson(),
      'lastSeenAt': lastSeenAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceFingerprintRecordImpl extends DeviceFingerprintRecord {
  _DeviceFingerprintRecordImpl({
    int? id,
    required String fingerprintHash,
    String? deviceId,
    String? deviceModel,
    String? deviceBrand,
    int? screenWidth,
    int? screenHeight,
    double? screenDensity,
    int? cpuCores,
    bool? isPhysicalDevice,
    String? osVersion,
    String? timezone,
    String? language,
    String? appVersion,
    String? lastIpAddress,
    required String userIds,
    required double riskScore,
    String? riskFactors,
    required bool isBlocked,
    String? notes,
    required DateTime firstSeenAt,
    required DateTime lastSeenAt,
  }) : super._(
         id: id,
         fingerprintHash: fingerprintHash,
         deviceId: deviceId,
         deviceModel: deviceModel,
         deviceBrand: deviceBrand,
         screenWidth: screenWidth,
         screenHeight: screenHeight,
         screenDensity: screenDensity,
         cpuCores: cpuCores,
         isPhysicalDevice: isPhysicalDevice,
         osVersion: osVersion,
         timezone: timezone,
         language: language,
         appVersion: appVersion,
         lastIpAddress: lastIpAddress,
         userIds: userIds,
         riskScore: riskScore,
         riskFactors: riskFactors,
         isBlocked: isBlocked,
         notes: notes,
         firstSeenAt: firstSeenAt,
         lastSeenAt: lastSeenAt,
       );

  /// Returns a shallow copy of this [DeviceFingerprintRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceFingerprintRecord copyWith({
    Object? id = _Undefined,
    String? fingerprintHash,
    Object? deviceId = _Undefined,
    Object? deviceModel = _Undefined,
    Object? deviceBrand = _Undefined,
    Object? screenWidth = _Undefined,
    Object? screenHeight = _Undefined,
    Object? screenDensity = _Undefined,
    Object? cpuCores = _Undefined,
    Object? isPhysicalDevice = _Undefined,
    Object? osVersion = _Undefined,
    Object? timezone = _Undefined,
    Object? language = _Undefined,
    Object? appVersion = _Undefined,
    Object? lastIpAddress = _Undefined,
    String? userIds,
    double? riskScore,
    Object? riskFactors = _Undefined,
    bool? isBlocked,
    Object? notes = _Undefined,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
  }) {
    return DeviceFingerprintRecord(
      id: id is int? ? id : this.id,
      fingerprintHash: fingerprintHash ?? this.fingerprintHash,
      deviceId: deviceId is String? ? deviceId : this.deviceId,
      deviceModel: deviceModel is String? ? deviceModel : this.deviceModel,
      deviceBrand: deviceBrand is String? ? deviceBrand : this.deviceBrand,
      screenWidth: screenWidth is int? ? screenWidth : this.screenWidth,
      screenHeight: screenHeight is int? ? screenHeight : this.screenHeight,
      screenDensity: screenDensity is double?
          ? screenDensity
          : this.screenDensity,
      cpuCores: cpuCores is int? ? cpuCores : this.cpuCores,
      isPhysicalDevice: isPhysicalDevice is bool?
          ? isPhysicalDevice
          : this.isPhysicalDevice,
      osVersion: osVersion is String? ? osVersion : this.osVersion,
      timezone: timezone is String? ? timezone : this.timezone,
      language: language is String? ? language : this.language,
      appVersion: appVersion is String? ? appVersion : this.appVersion,
      lastIpAddress: lastIpAddress is String?
          ? lastIpAddress
          : this.lastIpAddress,
      userIds: userIds ?? this.userIds,
      riskScore: riskScore ?? this.riskScore,
      riskFactors: riskFactors is String? ? riskFactors : this.riskFactors,
      isBlocked: isBlocked ?? this.isBlocked,
      notes: notes is String? ? notes : this.notes,
      firstSeenAt: firstSeenAt ?? this.firstSeenAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    );
  }
}
