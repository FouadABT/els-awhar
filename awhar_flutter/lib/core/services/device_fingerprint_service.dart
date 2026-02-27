import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:awhar_client/awhar_client.dart';

/// Device Fingerprint Service for Fraud Detection
/// 
/// Collects device hardware information to create a unique fingerprint
/// that survives app reinstalls. Used to detect multi-account fraud.
/// 
/// Fingerprint components (weighted by stability):
/// - Device Model + Screen (30%) - Very stable
/// - Storage + RAM (20%) - Hardware bound
/// - Device ID (25%) - Best identifier
/// - Timezone + Language (15%) - Usually same
/// - OS Version + Carrier (10%) - Can change
class DeviceFingerprintService extends GetxService {
  static const String _fingerprintStorageKey = 'device_fingerprint_cache';
  
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  /// Cached fingerprint to avoid recalculating
  DeviceFingerprint? _cachedFingerprint;
  
  /// Initialize the service
  Future<DeviceFingerprintService> init() async {
    try {
      // Try to load cached fingerprint
      final cached = await _secureStorage.read(key: _fingerprintStorageKey);
      if (cached != null) {
        _cachedFingerprint = DeviceFingerprint.fromJson(jsonDecode(cached));
        if (kDebugMode) {
          print('[DeviceFingerprint] ✅ Loaded cached fingerprint: ${_cachedFingerprint?.fingerprintHash.substring(0, 16)}...');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('[DeviceFingerprint] ⚠️ Could not load cached fingerprint: $e');
      }
    }
    return this;
  }
  
  /// Get current device fingerprint
  /// Returns cached version if available, otherwise generates new one
  Future<DeviceFingerprint> getFingerprint() async {
    if (_cachedFingerprint != null) {
      return _cachedFingerprint!;
    }
    
    final fingerprint = await _generateFingerprint();
    _cachedFingerprint = fingerprint;
    
    // Cache for future use
    try {
      await _secureStorage.write(
        key: _fingerprintStorageKey,
        value: jsonEncode(fingerprint.toJson()),
      );
    } catch (e) {
      if (kDebugMode) {
        print('[DeviceFingerprint] ⚠️ Could not cache fingerprint: $e');
      }
    }
    
    return fingerprint;
  }
  
  /// Force regenerate fingerprint (use after significant device changes)
  Future<DeviceFingerprint> regenerateFingerprint() async {
    _cachedFingerprint = null;
    await _secureStorage.delete(key: _fingerprintStorageKey);
    return getFingerprint();
  }
  
  /// Generate device fingerprint from hardware info
  Future<DeviceFingerprint> _generateFingerprint() async {
    if (kDebugMode) {
      print('[DeviceFingerprint] 🔍 Generating device fingerprint...');
    }
    
    final components = DeviceFingerprintComponents();
    
    try {
      if (Platform.isAndroid) {
        await _collectAndroidInfo(components);
      } else if (Platform.isIOS) {
        await _collectIosInfo(components);
      } else {
        // Fallback for other platforms (web, desktop)
        await _collectFallbackInfo(components);
      }
      
      // Get app info
      final packageInfo = await PackageInfo.fromPlatform();
      components.appVersion = packageInfo.version;
      components.appBuildNumber = packageInfo.buildNumber;
      
      // Get timezone and locale
      components.timezone = DateTime.now().timeZoneName;
      components.language = Platform.localeName;
      
    } catch (e) {
      if (kDebugMode) {
        print('[DeviceFingerprint] ❌ Error collecting device info: $e');
      }
    }
    
    // Generate hash from components
    final fingerprintHash = _generateHash(components);
    
    final fingerprint = DeviceFingerprint(
      fingerprintHash: fingerprintHash,
      components: components,
      collectedAt: DateTime.now(),
    );
    
    if (kDebugMode) {
      print('[DeviceFingerprint] ✅ Generated fingerprint: ${fingerprintHash.substring(0, 16)}...');
      print('[DeviceFingerprint] 📱 Device: ${components.deviceModel}');
      print('[DeviceFingerprint] 📐 Screen: ${components.screenWidth}x${components.screenHeight}');
    }
    
    return fingerprint;
  }
  
  /// Collect Android device information
  Future<void> _collectAndroidInfo(DeviceFingerprintComponents components) async {
    final androidInfo = await _deviceInfo.androidInfo;
    
    // Device identifiers
    components.deviceId = androidInfo.id; // ANDROID_ID
    components.deviceModel = '${androidInfo.manufacturer} ${androidInfo.model}';
    components.deviceBrand = androidInfo.brand;
    
    // Hardware specs
    components.cpuCores = androidInfo.supportedAbis.length; // Approximation
    components.isPhysicalDevice = androidInfo.isPhysicalDevice;
    
    // OS info
    components.osVersion = 'Android ${androidInfo.version.release}';
    components.sdkVersion = androidInfo.version.sdkInt.toString();
    
    // Screen info (from Flutter's view)
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final size = view.physicalSize;
    components.screenWidth = size.width.toInt();
    components.screenHeight = size.height.toInt();
    components.screenDensity = view.devicePixelRatio;
    
    // Hardware fingerprint from Android
    components.hardwareFingerprint = androidInfo.fingerprint;
    
    // Board and hardware info
    components.board = androidInfo.board;
    components.hardware = androidInfo.hardware;
  }
  
  /// Collect iOS device information
  Future<void> _collectIosInfo(DeviceFingerprintComponents components) async {
    final iosInfo = await _deviceInfo.iosInfo;
    
    // Device identifiers
    components.deviceId = iosInfo.identifierForVendor ?? 'unknown';
    components.deviceModel = iosInfo.utsname.machine;
    components.deviceBrand = 'Apple';
    
    // Hardware specs
    components.isPhysicalDevice = iosInfo.isPhysicalDevice;
    
    // OS info
    components.osVersion = 'iOS ${iosInfo.systemVersion}';
    
    // iOS specific
    components.iosName = iosInfo.name;
    components.iosSystemName = iosInfo.systemName;
  }
  
  /// Collect fallback info for other platforms
  Future<void> _collectFallbackInfo(DeviceFingerprintComponents components) async {
    components.deviceId = 'unknown';
    components.deviceModel = 'Unknown Device';
    components.osVersion = Platform.operatingSystemVersion;
    components.isPhysicalDevice = true;
  }
  
  /// Generate SHA256 hash from fingerprint components
  String _generateHash(DeviceFingerprintComponents components) {
    // Build a stable string from key components
    // Weighted by stability - more stable = higher in the string
    final stableComponents = [
      // High weight (very stable)
      components.deviceModel ?? '',
      components.screenWidth?.toString() ?? '',
      components.screenHeight?.toString() ?? '',
      components.deviceBrand ?? '',
      
      // Medium weight (hardware bound)
      components.cpuCores?.toString() ?? '',
      components.board ?? '',
      components.hardware ?? '',
      
      // Lower weight (can change)
      components.timezone ?? '',
      components.language ?? '',
      
      // Device ID (best identifier but can be reset)
      components.deviceId ?? '',
    ];
    
    final combinedString = stableComponents.join('|');
    final bytes = utf8.encode(combinedString);
    final digest = sha256.convert(bytes);
    
    return digest.toString();
  }
  
  /// Calculate similarity between two fingerprints (0.0 to 1.0)
  double calculateSimilarity(DeviceFingerprint a, DeviceFingerprint b) {
    if (a.fingerprintHash == b.fingerprintHash) {
      return 1.0;
    }
    
    final ac = a.components;
    final bc = b.components;
    
    double score = 0.0;
    double totalWeight = 0.0;
    
    // Device model (30%)
    if (ac.deviceModel == bc.deviceModel) {
      score += 0.30;
    }
    totalWeight += 0.30;
    
    // Screen resolution (15%)
    if (ac.screenWidth == bc.screenWidth && ac.screenHeight == bc.screenHeight) {
      score += 0.15;
    }
    totalWeight += 0.15;
    
    // Device brand (10%)
    if (ac.deviceBrand == bc.deviceBrand) {
      score += 0.10;
    }
    totalWeight += 0.10;
    
    // Device ID (25%)
    if (ac.deviceId == bc.deviceId && ac.deviceId != null && ac.deviceId!.isNotEmpty) {
      score += 0.25;
    }
    totalWeight += 0.25;
    
    // Timezone (10%)
    if (ac.timezone == bc.timezone) {
      score += 0.10;
    }
    totalWeight += 0.10;
    
    // Language (10%)
    if (ac.language == bc.language) {
      score += 0.10;
    }
    totalWeight += 0.10;
    
    return score / totalWeight;
  }
  
  /// Get fingerprint as a map for sending to server
  Future<Map<String, dynamic>> getFingerprintForServer() async {
    final fingerprint = await getFingerprint();
    return {
      'fingerprintHash': fingerprint.fingerprintHash,
      'deviceId': fingerprint.components.deviceId,
      'deviceModel': fingerprint.components.deviceModel,
      'deviceBrand': fingerprint.components.deviceBrand,
      'screenWidth': fingerprint.components.screenWidth,
      'screenHeight': fingerprint.components.screenHeight,
      'screenDensity': fingerprint.components.screenDensity,
      'osVersion': fingerprint.components.osVersion,
      'timezone': fingerprint.components.timezone,
      'language': fingerprint.components.language,
      'cpuCores': fingerprint.components.cpuCores,
      'isPhysicalDevice': fingerprint.components.isPhysicalDevice,
      'appVersion': fingerprint.components.appVersion,
      'collectedAt': fingerprint.collectedAt.toIso8601String(),
    };
  }
  
  // ============================================================
  // CONVENIENCE METHODS FOR AUTH INTEGRATION
  // ============================================================
  
  /// Get cached fingerprint (null if not collected yet)
  DeviceFingerprint? get fingerprint => _cachedFingerprint;
  
  /// Get the fingerprint hash string
  String? get fingerprintHash => _cachedFingerprint?.fingerprintHash;
  
  /// Check if fingerprint has been collected
  bool get isCollected => _cachedFingerprint != null;
  
  /// Collect fingerprint (alias for getFingerprint)
  Future<void> collectFingerprint() async {
    _cachedFingerprint = await getFingerprint();
  }
  
  /// Convert to DeviceFingerprintInput for server calls
  DeviceFingerprintInput toServerInput() {
    final fp = _cachedFingerprint;
    if (fp == null) {
      throw Exception('Fingerprint not collected. Call collectFingerprint() first.');
    }
    
    return DeviceFingerprintInput(
      fingerprintHash: fp.fingerprintHash,
      deviceId: fp.components.deviceId,
      deviceModel: fp.components.deviceModel,
      deviceBrand: fp.components.deviceBrand,
      screenWidth: fp.components.screenWidth,
      screenHeight: fp.components.screenHeight,
      screenDensity: fp.components.screenDensity,
      cpuCores: fp.components.cpuCores,
      isPhysicalDevice: fp.components.isPhysicalDevice,
      osVersion: fp.components.osVersion,
      timezone: fp.components.timezone,
      language: fp.components.language,
      appVersion: fp.components.appVersion,
    );
  }
}

/// Device Fingerprint data class
class DeviceFingerprint {
  final String fingerprintHash;
  final DeviceFingerprintComponents components;
  final DateTime collectedAt;
  
  DeviceFingerprint({
    required this.fingerprintHash,
    required this.components,
    required this.collectedAt,
  });
  
  Map<String, dynamic> toJson() => {
    'fingerprintHash': fingerprintHash,
    'components': components.toJson(),
    'collectedAt': collectedAt.toIso8601String(),
  };
  
  factory DeviceFingerprint.fromJson(Map<String, dynamic> json) => DeviceFingerprint(
    fingerprintHash: json['fingerprintHash'] as String,
    components: DeviceFingerprintComponents.fromJson(json['components'] as Map<String, dynamic>),
    collectedAt: DateTime.parse(json['collectedAt'] as String),
  );
}

/// Device fingerprint component data
class DeviceFingerprintComponents {
  DeviceFingerprintComponents();
  
  // Device identifiers
  String? deviceId;
  String? deviceModel;
  String? deviceBrand;
  
  // Screen info
  int? screenWidth;
  int? screenHeight;
  double? screenDensity;
  
  // Hardware specs
  int? cpuCores;
  bool? isPhysicalDevice;
  String? board;
  String? hardware;
  String? hardwareFingerprint;
  
  // OS info
  String? osVersion;
  String? sdkVersion;
  
  // Locale info
  String? timezone;
  String? language;
  
  // App info
  String? appVersion;
  String? appBuildNumber;
  
  // iOS specific
  String? iosName;
  String? iosSystemName;
  
  Map<String, dynamic> toJson() => {
    'deviceId': deviceId,
    'deviceModel': deviceModel,
    'deviceBrand': deviceBrand,
    'screenWidth': screenWidth,
    'screenHeight': screenHeight,
    'screenDensity': screenDensity,
    'cpuCores': cpuCores,
    'isPhysicalDevice': isPhysicalDevice,
    'board': board,
    'hardware': hardware,
    'hardwareFingerprint': hardwareFingerprint,
    'osVersion': osVersion,
    'sdkVersion': sdkVersion,
    'timezone': timezone,
    'language': language,
    'appVersion': appVersion,
    'appBuildNumber': appBuildNumber,
    'iosName': iosName,
    'iosSystemName': iosSystemName,
  };
  
  factory DeviceFingerprintComponents.fromJson(Map<String, dynamic> json) {
    final components = DeviceFingerprintComponents();
    components.deviceId = json['deviceId'] as String?;
    components.deviceModel = json['deviceModel'] as String?;
    components.deviceBrand = json['deviceBrand'] as String?;
    components.screenWidth = json['screenWidth'] as int?;
    components.screenHeight = json['screenHeight'] as int?;
    components.screenDensity = (json['screenDensity'] as num?)?.toDouble();
    components.cpuCores = json['cpuCores'] as int?;
    components.isPhysicalDevice = json['isPhysicalDevice'] as bool?;
    components.board = json['board'] as String?;
    components.hardware = json['hardware'] as String?;
    components.hardwareFingerprint = json['hardwareFingerprint'] as String?;
    components.osVersion = json['osVersion'] as String?;
    components.sdkVersion = json['sdkVersion'] as String?;
    components.timezone = json['timezone'] as String?;
    components.language = json['language'] as String?;
    components.appVersion = json['appVersion'] as String?;
    components.appBuildNumber = json['appBuildNumber'] as String?;
    components.iosName = json['iosName'] as String?;
    components.iosSystemName = json['iosSystemName'] as String?;
    return components;
  }
}
