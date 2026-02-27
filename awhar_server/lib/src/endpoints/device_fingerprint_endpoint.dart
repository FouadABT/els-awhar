import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/elasticsearch/elasticsearch_session_extension.dart';

/// Device Fingerprint Endpoint
/// 
/// Handles device fingerprint registration, checking, and fraud detection.
/// Used to detect multi-account fraud by tracking device hardware signatures.
class DeviceFingerprintEndpoint extends Endpoint {
  
  // Risk score thresholds
  static const double _lowRiskThreshold = 30.0;
  static const double _mediumRiskThreshold = 50.0;
  static const double _highRiskThreshold = 70.0;
  
  // Risk weights
  static const double _sameDeviceMultiAccountWeight = 50.0;
  static const double _promoAbuseWeight = 40.0;
  
  /// Check a device fingerprint before signup/login
  /// Returns risk assessment and whether to allow the action
  /// 
  /// Call this BEFORE creating a new user account to detect fraud
  Future<DeviceFingerprintCheckResult> checkFingerprint(
    Session session,
    DeviceFingerprintInput input,
  ) async {
    // Look for existing fingerprint record
    final existing = await DeviceFingerprintRecord.db.findFirstRow(
      session,
      where: (t) => t.fingerprintHash.equals(input.fingerprintHash),
    );
    
    if (existing == null) {
      // New device - no risk
      return DeviceFingerprintCheckResult(
        fingerprintHash: input.fingerprintHash,
        riskScore: 0.0,
        riskLevel: 'low',
        riskFactors: [],
        isAllowed: true,
        requiresVerification: false,
        isBlocked: false,
        linkedUserCount: 0,
        message: 'New device - no previous records',
      );
    }
    
    // Calculate risk based on existing record
    final riskFactors = <String>[];
    double riskScore = existing.riskScore;
    
    // Parse existing user IDs
    final userIds = _parseUserIds(existing.userIds);
    
    // Check if device is blocked
    if (existing.isBlocked) {
      return DeviceFingerprintCheckResult(
        fingerprintHash: input.fingerprintHash,
        riskScore: 100.0,
        riskLevel: 'critical',
        riskFactors: ['Device has been blocked'],
        isAllowed: false,
        requiresVerification: false,
        isBlocked: true,
        linkedUserCount: userIds.length,
        firstSeenAt: existing.firstSeenAt,
        lastSeenAt: existing.lastSeenAt,
        message: 'This device has been blocked due to suspicious activity',
      );
    }
    
    // Check for multiple accounts
    if (userIds.length >= 2) {
      riskFactors.add('Multiple accounts detected on this device (${userIds.length} accounts)');
      riskScore += _sameDeviceMultiAccountWeight * (userIds.length - 1);
    }
    
    // Check existing risk factors
    if (existing.riskFactors != null) {
      final existingFactors = _parseRiskFactors(existing.riskFactors!);
      riskFactors.addAll(existingFactors);
    }
    
    // Cap risk score at 100
    riskScore = riskScore.clamp(0.0, 100.0);
    
    // Determine risk level
    final riskLevel = _getRiskLevel(riskScore);
    
    // Determine if action is allowed
    final isAllowed = riskScore < _highRiskThreshold;
    final requiresVerification = riskScore >= _mediumRiskThreshold && riskScore < _highRiskThreshold;
    
    // Update last seen
    await DeviceFingerprintRecord.db.updateRow(
      session,
      existing.copyWith(
        lastSeenAt: DateTime.now(),
      ),
    );
    
    return DeviceFingerprintCheckResult(
      fingerprintHash: input.fingerprintHash,
      riskScore: riskScore,
      riskLevel: riskLevel,
      riskFactors: riskFactors,
      isAllowed: isAllowed,
      requiresVerification: requiresVerification,
      isBlocked: false,
      linkedUserCount: userIds.length,
      firstSeenAt: existing.firstSeenAt,
      lastSeenAt: DateTime.now(),
      message: isAllowed 
        ? (requiresVerification ? 'Additional verification required' : null)
        : 'Account creation blocked due to suspicious activity',
    );
  }
  
  /// Register a device fingerprint for a user
  /// Call this AFTER successful signup/login
  Future<DeviceFingerprintCheckResult> registerFingerprint(
    Session session,
    int userId,
    DeviceFingerprintInput input,
  ) async {
    // Look for existing fingerprint
    final existing = await DeviceFingerprintRecord.db.findFirstRow(
      session,
      where: (t) => t.fingerprintHash.equals(input.fingerprintHash),
    );
    
    final now = DateTime.now();
    final riskFactors = <String>[];
    double riskScore = 0.0;
    
    if (existing != null) {
      // Parse existing user IDs
      final userIds = _parseUserIds(existing.userIds);
      
      // Check if this user is already registered
      if (userIds.contains(userId)) {
        // Same user, same device - just update last seen
        await DeviceFingerprintRecord.db.updateRow(
          session,
          existing.copyWith(
            lastSeenAt: now,
            appVersion: input.appVersion,
          ),
        );
        
        return DeviceFingerprintCheckResult(
          fingerprintHash: input.fingerprintHash,
          riskScore: existing.riskScore,
          riskLevel: _getRiskLevel(existing.riskScore),
          riskFactors: _parseRiskFactors(existing.riskFactors ?? '[]'),
          isAllowed: !existing.isBlocked,
          requiresVerification: false,
          isBlocked: existing.isBlocked,
          linkedUserCount: userIds.length,
          firstSeenAt: existing.firstSeenAt,
          lastSeenAt: now,
          message: 'Device already registered for this user',
        );
      }
      
      // New user on existing device - potential multi-account
      userIds.add(userId);
      
      // Increase risk score for multi-account
      riskScore = existing.riskScore + _sameDeviceMultiAccountWeight;
      riskFactors.add('New account created on device with existing accounts');
      
      // Merge risk factors
      final existingFactors = _parseRiskFactors(existing.riskFactors ?? '[]');
      riskFactors.addAll(existingFactors);
      
      // Cap at 100
      riskScore = riskScore.clamp(0.0, 100.0);
      
      // Update existing record
      await DeviceFingerprintRecord.db.updateRow(
        session,
        existing.copyWith(
          userIds: jsonEncode(userIds),
          riskScore: riskScore,
          riskFactors: jsonEncode(riskFactors),
          lastSeenAt: now,
          appVersion: input.appVersion,
        ),
      );
      
      // Sync to ES
      await _syncToElasticsearch(session, existing.copyWith(
        userIds: jsonEncode(userIds),
        riskScore: riskScore,
        riskFactors: jsonEncode(riskFactors),
        lastSeenAt: now,
      ));
      
      return DeviceFingerprintCheckResult(
        fingerprintHash: input.fingerprintHash,
        riskScore: riskScore,
        riskLevel: _getRiskLevel(riskScore),
        riskFactors: riskFactors,
        isAllowed: riskScore < _highRiskThreshold,
        requiresVerification: riskScore >= _mediumRiskThreshold,
        isBlocked: existing.isBlocked,
        linkedUserCount: userIds.length,
        firstSeenAt: existing.firstSeenAt,
        lastSeenAt: now,
        message: 'Device linked to multiple accounts - monitoring enabled',
      );
    } else {
      // New device - create record
      final record = DeviceFingerprintRecord(
        fingerprintHash: input.fingerprintHash,
        deviceId: input.deviceId,
        deviceModel: input.deviceModel,
        deviceBrand: input.deviceBrand,
        screenWidth: input.screenWidth,
        screenHeight: input.screenHeight,
        screenDensity: input.screenDensity,
        cpuCores: input.cpuCores,
        isPhysicalDevice: input.isPhysicalDevice,
        osVersion: input.osVersion,
        timezone: input.timezone,
        language: input.language,
        appVersion: input.appVersion,
        userIds: jsonEncode([userId]),
        riskScore: 0.0,
        riskFactors: jsonEncode([]),
        isBlocked: false,
        firstSeenAt: now,
        lastSeenAt: now,
      );
      
      final inserted = await DeviceFingerprintRecord.db.insertRow(session, record);
      
      // Sync to ES
      await _syncToElasticsearch(session, inserted);
      
      return DeviceFingerprintCheckResult(
        fingerprintHash: input.fingerprintHash,
        riskScore: 0.0,
        riskLevel: 'low',
        riskFactors: [],
        isAllowed: true,
        requiresVerification: false,
        isBlocked: false,
        linkedUserCount: 1,
        firstSeenAt: now,
        lastSeenAt: now,
        message: 'Device registered successfully',
      );
    }
  }
  
  /// Get fingerprint record by hash (admin only)
  Future<DeviceFingerprintRecord?> getFingerprintByHash(
    Session session,
    String fingerprintHash,
  ) async {
    return await DeviceFingerprintRecord.db.findFirstRow(
      session,
      where: (t) => t.fingerprintHash.equals(fingerprintHash),
    );
  }
  
  /// Get all fingerprints for a user ID
  Future<List<DeviceFingerprintRecord>> getFingerprintsForUser(
    Session session,
    int userId,
  ) async {
    // This requires a text search since userIds is stored as JSON
    final all = await DeviceFingerprintRecord.db.find(session);
    
    return all.where((record) {
      final userIds = _parseUserIds(record.userIds);
      return userIds.contains(userId);
    }).toList();
  }
  
  /// Block a device fingerprint (admin only)
  Future<DeviceFingerprintRecord?> blockFingerprint(
    Session session,
    String fingerprintHash,
    String reason,
  ) async {
    final record = await DeviceFingerprintRecord.db.findFirstRow(
      session,
      where: (t) => t.fingerprintHash.equals(fingerprintHash),
    );
    
    if (record == null) return null;
    
    final riskFactors = _parseRiskFactors(record.riskFactors ?? '[]');
    riskFactors.add('Blocked by admin: $reason');
    
    final updated = await DeviceFingerprintRecord.db.updateRow(
      session,
      record.copyWith(
        isBlocked: true,
        riskScore: 100.0,
        riskFactors: jsonEncode(riskFactors),
        notes: '${record.notes ?? ''}\n[${DateTime.now().toIso8601String()}] Blocked: $reason'.trim(),
      ),
    );
    
    // Sync to ES
    await _syncToElasticsearch(session, updated);
    
    return updated;
  }
  
  /// Unblock a device fingerprint (admin only)
  Future<DeviceFingerprintRecord?> unblockFingerprint(
    Session session,
    String fingerprintHash,
    String reason,
  ) async {
    final record = await DeviceFingerprintRecord.db.findFirstRow(
      session,
      where: (t) => t.fingerprintHash.equals(fingerprintHash),
    );
    
    if (record == null) return null;
    
    final riskFactors = _parseRiskFactors(record.riskFactors ?? '[]');
    riskFactors.add('Unblocked by admin: $reason');
    
    // Recalculate risk score based on user count
    final userIds = _parseUserIds(record.userIds);
    double newRiskScore = 0.0;
    if (userIds.length >= 2) {
      newRiskScore = _sameDeviceMultiAccountWeight * (userIds.length - 1);
    }
    
    final updated = await DeviceFingerprintRecord.db.updateRow(
      session,
      record.copyWith(
        isBlocked: false,
        riskScore: newRiskScore.clamp(0.0, 100.0),
        riskFactors: jsonEncode(riskFactors),
        notes: '${record.notes ?? ''}\n[${DateTime.now().toIso8601String()}] Unblocked: $reason'.trim(),
      ),
    );
    
    // Sync to ES
    await _syncToElasticsearch(session, updated);
    
    return updated;
  }
  
  /// Get high-risk devices (admin only)
  Future<List<DeviceFingerprintRecord>> getHighRiskDevices(
    Session session, {
    double minRiskScore = 50.0,
    int limit = 50,
  }) async {
    return await DeviceFingerprintRecord.db.find(
      session,
      where: (t) => t.riskScore >= minRiskScore,
      orderBy: (t) => t.riskScore,
      orderDescending: true,
      limit: limit,
    );
  }
  
  /// Get devices with multiple accounts (admin only)  
  Future<List<DeviceFingerprintRecord>> getMultiAccountDevices(
    Session session, {
    int minAccounts = 2,
    int limit = 50,
  }) async {
    final all = await DeviceFingerprintRecord.db.find(
      session,
      orderBy: (t) => t.lastSeenAt,
      orderDescending: true,
    );
    
    return all.where((record) {
      final userIds = _parseUserIds(record.userIds);
      return userIds.length >= minAccounts;
    }).take(limit).toList();
  }
  
  /// Report promo abuse for a fingerprint
  Future<DeviceFingerprintRecord?> reportPromoAbuse(
    Session session,
    String fingerprintHash,
    String promoCode,
  ) async {
    final record = await DeviceFingerprintRecord.db.findFirstRow(
      session,
      where: (t) => t.fingerprintHash.equals(fingerprintHash),
    );
    
    if (record == null) return null;
    
    final riskFactors = _parseRiskFactors(record.riskFactors ?? '[]');
    riskFactors.add('Promo abuse detected: $promoCode');
    
    final newRiskScore = (record.riskScore + _promoAbuseWeight).clamp(0.0, 100.0);
    
    final updated = await DeviceFingerprintRecord.db.updateRow(
      session,
      record.copyWith(
        riskScore: newRiskScore,
        riskFactors: jsonEncode(riskFactors),
      ),
    );
    
    // Sync to ES
    await _syncToElasticsearch(session, updated);
    
    return updated;
  }
  
  // ============================================================
  // Private Helper Methods
  // ============================================================
  
  List<int> _parseUserIds(String userIdsJson) {
    try {
      final decoded = jsonDecode(userIdsJson);
      if (decoded is List) {
        return decoded.cast<int>().toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
  
  List<String> _parseRiskFactors(String riskFactorsJson) {
    try {
      final decoded = jsonDecode(riskFactorsJson);
      if (decoded is List) {
        return decoded.cast<String>().toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
  
  String _getRiskLevel(double score) {
    if (score < _lowRiskThreshold) return 'low';
    if (score < _mediumRiskThreshold) return 'medium';
    if (score < _highRiskThreshold) return 'high';
    return 'critical';
  }
  
  /// Sync fingerprint record to Elasticsearch
  Future<void> _syncToElasticsearch(Session session, DeviceFingerprintRecord record) async {
    try {
      await session.esSync.indexDeviceFingerprint(record);
    } catch (e) {
      session.log('Error syncing fingerprint to ES: $e', level: LogLevel.warning);
    }
  }
}
