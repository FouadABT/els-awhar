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
import 'package:awhar_server/src/generated/protocol.dart' as _i2;

abstract class DeviceFingerprintCheckResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DeviceFingerprintCheckResult._({
    required this.fingerprintHash,
    required this.riskScore,
    required this.riskLevel,
    required this.riskFactors,
    required this.isAllowed,
    required this.requiresVerification,
    required this.isBlocked,
    required this.linkedUserCount,
    this.linkedUserIds,
    this.firstSeenAt,
    this.lastSeenAt,
    this.message,
  });

  factory DeviceFingerprintCheckResult({
    required String fingerprintHash,
    required double riskScore,
    required String riskLevel,
    required List<String> riskFactors,
    required bool isAllowed,
    required bool requiresVerification,
    required bool isBlocked,
    required int linkedUserCount,
    List<int>? linkedUserIds,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
    String? message,
  }) = _DeviceFingerprintCheckResultImpl;

  factory DeviceFingerprintCheckResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DeviceFingerprintCheckResult(
      fingerprintHash: jsonSerialization['fingerprintHash'] as String,
      riskScore: (jsonSerialization['riskScore'] as num).toDouble(),
      riskLevel: jsonSerialization['riskLevel'] as String,
      riskFactors: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['riskFactors'],
      ),
      isAllowed: jsonSerialization['isAllowed'] as bool,
      requiresVerification: jsonSerialization['requiresVerification'] as bool,
      isBlocked: jsonSerialization['isBlocked'] as bool,
      linkedUserCount: jsonSerialization['linkedUserCount'] as int,
      linkedUserIds: jsonSerialization['linkedUserIds'] == null
          ? null
          : _i2.Protocol().deserialize<List<int>>(
              jsonSerialization['linkedUserIds'],
            ),
      firstSeenAt: jsonSerialization['firstSeenAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['firstSeenAt'],
            ),
      lastSeenAt: jsonSerialization['lastSeenAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastSeenAt']),
      message: jsonSerialization['message'] as String?,
    );
  }

  /// The fingerprint record (if found)
  String fingerprintHash;

  /// Risk assessment
  double riskScore;

  /// Risk assessment
  String riskLevel;

  /// Risk assessment
  List<String> riskFactors;

  /// Decision
  bool isAllowed;

  /// Decision
  bool requiresVerification;

  /// Decision
  bool isBlocked;

  /// Previous accounts on this device
  int linkedUserCount;

  /// Previous accounts on this device
  List<int>? linkedUserIds;

  /// Timestamps
  DateTime? firstSeenAt;

  DateTime? lastSeenAt;

  /// Message for display
  String? message;

  /// Returns a shallow copy of this [DeviceFingerprintCheckResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceFingerprintCheckResult copyWith({
    String? fingerprintHash,
    double? riskScore,
    String? riskLevel,
    List<String>? riskFactors,
    bool? isAllowed,
    bool? requiresVerification,
    bool? isBlocked,
    int? linkedUserCount,
    List<int>? linkedUserIds,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceFingerprintCheckResult',
      'fingerprintHash': fingerprintHash,
      'riskScore': riskScore,
      'riskLevel': riskLevel,
      'riskFactors': riskFactors.toJson(),
      'isAllowed': isAllowed,
      'requiresVerification': requiresVerification,
      'isBlocked': isBlocked,
      'linkedUserCount': linkedUserCount,
      if (linkedUserIds != null) 'linkedUserIds': linkedUserIds?.toJson(),
      if (firstSeenAt != null) 'firstSeenAt': firstSeenAt?.toJson(),
      if (lastSeenAt != null) 'lastSeenAt': lastSeenAt?.toJson(),
      if (message != null) 'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DeviceFingerprintCheckResult',
      'fingerprintHash': fingerprintHash,
      'riskScore': riskScore,
      'riskLevel': riskLevel,
      'riskFactors': riskFactors.toJson(),
      'isAllowed': isAllowed,
      'requiresVerification': requiresVerification,
      'isBlocked': isBlocked,
      'linkedUserCount': linkedUserCount,
      if (linkedUserIds != null) 'linkedUserIds': linkedUserIds?.toJson(),
      if (firstSeenAt != null) 'firstSeenAt': firstSeenAt?.toJson(),
      if (lastSeenAt != null) 'lastSeenAt': lastSeenAt?.toJson(),
      if (message != null) 'message': message,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceFingerprintCheckResultImpl extends DeviceFingerprintCheckResult {
  _DeviceFingerprintCheckResultImpl({
    required String fingerprintHash,
    required double riskScore,
    required String riskLevel,
    required List<String> riskFactors,
    required bool isAllowed,
    required bool requiresVerification,
    required bool isBlocked,
    required int linkedUserCount,
    List<int>? linkedUserIds,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
    String? message,
  }) : super._(
         fingerprintHash: fingerprintHash,
         riskScore: riskScore,
         riskLevel: riskLevel,
         riskFactors: riskFactors,
         isAllowed: isAllowed,
         requiresVerification: requiresVerification,
         isBlocked: isBlocked,
         linkedUserCount: linkedUserCount,
         linkedUserIds: linkedUserIds,
         firstSeenAt: firstSeenAt,
         lastSeenAt: lastSeenAt,
         message: message,
       );

  /// Returns a shallow copy of this [DeviceFingerprintCheckResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceFingerprintCheckResult copyWith({
    String? fingerprintHash,
    double? riskScore,
    String? riskLevel,
    List<String>? riskFactors,
    bool? isAllowed,
    bool? requiresVerification,
    bool? isBlocked,
    int? linkedUserCount,
    Object? linkedUserIds = _Undefined,
    Object? firstSeenAt = _Undefined,
    Object? lastSeenAt = _Undefined,
    Object? message = _Undefined,
  }) {
    return DeviceFingerprintCheckResult(
      fingerprintHash: fingerprintHash ?? this.fingerprintHash,
      riskScore: riskScore ?? this.riskScore,
      riskLevel: riskLevel ?? this.riskLevel,
      riskFactors: riskFactors ?? this.riskFactors.map((e0) => e0).toList(),
      isAllowed: isAllowed ?? this.isAllowed,
      requiresVerification: requiresVerification ?? this.requiresVerification,
      isBlocked: isBlocked ?? this.isBlocked,
      linkedUserCount: linkedUserCount ?? this.linkedUserCount,
      linkedUserIds: linkedUserIds is List<int>?
          ? linkedUserIds
          : this.linkedUserIds?.map((e0) => e0).toList(),
      firstSeenAt: firstSeenAt is DateTime? ? firstSeenAt : this.firstSeenAt,
      lastSeenAt: lastSeenAt is DateTime? ? lastSeenAt : this.lastSeenAt,
      message: message is String? ? message : this.message,
    );
  }
}
