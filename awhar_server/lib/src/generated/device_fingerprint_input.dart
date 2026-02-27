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

abstract class DeviceFingerprintInput
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DeviceFingerprintInput._({
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
  });

  factory DeviceFingerprintInput({
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
  }) = _DeviceFingerprintInputImpl;

  factory DeviceFingerprintInput.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DeviceFingerprintInput(
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
    );
  }

  /// The hash generated client-side
  String fingerprintHash;

  /// Device identifiers
  String? deviceId;

  String? deviceModel;

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

  String? language;

  /// App info
  String? appVersion;

  /// Returns a shallow copy of this [DeviceFingerprintInput]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceFingerprintInput copyWith({
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
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceFingerprintInput',
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
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DeviceFingerprintInput',
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
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceFingerprintInputImpl extends DeviceFingerprintInput {
  _DeviceFingerprintInputImpl({
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
  }) : super._(
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
       );

  /// Returns a shallow copy of this [DeviceFingerprintInput]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceFingerprintInput copyWith({
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
  }) {
    return DeviceFingerprintInput(
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
    );
  }
}
