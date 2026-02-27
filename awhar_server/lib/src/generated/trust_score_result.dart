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

abstract class TrustScoreResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TrustScoreResult._({
    required this.trustScore,
    required this.trustLevel,
    required this.totalOrders,
    required this.completedOrders,
    required this.cancelledOrders,
    required this.ghostOrders,
    required this.completionRate,
    required this.riskScore,
    required this.riskLevel,
    required this.verdict,
    required this.accountAgeDays,
    required this.totalValue,
    required this.computedAt,
    required this.source,
  });

  factory TrustScoreResult({
    required double trustScore,
    required String trustLevel,
    required int totalOrders,
    required int completedOrders,
    required int cancelledOrders,
    required int ghostOrders,
    required double completionRate,
    required int riskScore,
    required String riskLevel,
    required String verdict,
    required int accountAgeDays,
    required double totalValue,
    required DateTime computedAt,
    required String source,
  }) = _TrustScoreResultImpl;

  factory TrustScoreResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrustScoreResult(
      trustScore: (jsonSerialization['trustScore'] as num).toDouble(),
      trustLevel: jsonSerialization['trustLevel'] as String,
      totalOrders: jsonSerialization['totalOrders'] as int,
      completedOrders: jsonSerialization['completedOrders'] as int,
      cancelledOrders: jsonSerialization['cancelledOrders'] as int,
      ghostOrders: jsonSerialization['ghostOrders'] as int,
      completionRate: (jsonSerialization['completionRate'] as num).toDouble(),
      riskScore: jsonSerialization['riskScore'] as int,
      riskLevel: jsonSerialization['riskLevel'] as String,
      verdict: jsonSerialization['verdict'] as String,
      accountAgeDays: jsonSerialization['accountAgeDays'] as int,
      totalValue: (jsonSerialization['totalValue'] as num).toDouble(),
      computedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['computedAt'],
      ),
      source: jsonSerialization['source'] as String,
    );
  }

  double trustScore;

  String trustLevel;

  int totalOrders;

  int completedOrders;

  int cancelledOrders;

  int ghostOrders;

  double completionRate;

  int riskScore;

  String riskLevel;

  String verdict;

  int accountAgeDays;

  double totalValue;

  DateTime computedAt;

  String source;

  /// Returns a shallow copy of this [TrustScoreResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrustScoreResult copyWith({
    double? trustScore,
    String? trustLevel,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    int? ghostOrders,
    double? completionRate,
    int? riskScore,
    String? riskLevel,
    String? verdict,
    int? accountAgeDays,
    double? totalValue,
    DateTime? computedAt,
    String? source,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrustScoreResult',
      'trustScore': trustScore,
      'trustLevel': trustLevel,
      'totalOrders': totalOrders,
      'completedOrders': completedOrders,
      'cancelledOrders': cancelledOrders,
      'ghostOrders': ghostOrders,
      'completionRate': completionRate,
      'riskScore': riskScore,
      'riskLevel': riskLevel,
      'verdict': verdict,
      'accountAgeDays': accountAgeDays,
      'totalValue': totalValue,
      'computedAt': computedAt.toJson(),
      'source': source,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TrustScoreResult',
      'trustScore': trustScore,
      'trustLevel': trustLevel,
      'totalOrders': totalOrders,
      'completedOrders': completedOrders,
      'cancelledOrders': cancelledOrders,
      'ghostOrders': ghostOrders,
      'completionRate': completionRate,
      'riskScore': riskScore,
      'riskLevel': riskLevel,
      'verdict': verdict,
      'accountAgeDays': accountAgeDays,
      'totalValue': totalValue,
      'computedAt': computedAt.toJson(),
      'source': source,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TrustScoreResultImpl extends TrustScoreResult {
  _TrustScoreResultImpl({
    required double trustScore,
    required String trustLevel,
    required int totalOrders,
    required int completedOrders,
    required int cancelledOrders,
    required int ghostOrders,
    required double completionRate,
    required int riskScore,
    required String riskLevel,
    required String verdict,
    required int accountAgeDays,
    required double totalValue,
    required DateTime computedAt,
    required String source,
  }) : super._(
         trustScore: trustScore,
         trustLevel: trustLevel,
         totalOrders: totalOrders,
         completedOrders: completedOrders,
         cancelledOrders: cancelledOrders,
         ghostOrders: ghostOrders,
         completionRate: completionRate,
         riskScore: riskScore,
         riskLevel: riskLevel,
         verdict: verdict,
         accountAgeDays: accountAgeDays,
         totalValue: totalValue,
         computedAt: computedAt,
         source: source,
       );

  /// Returns a shallow copy of this [TrustScoreResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrustScoreResult copyWith({
    double? trustScore,
    String? trustLevel,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    int? ghostOrders,
    double? completionRate,
    int? riskScore,
    String? riskLevel,
    String? verdict,
    int? accountAgeDays,
    double? totalValue,
    DateTime? computedAt,
    String? source,
  }) {
    return TrustScoreResult(
      trustScore: trustScore ?? this.trustScore,
      trustLevel: trustLevel ?? this.trustLevel,
      totalOrders: totalOrders ?? this.totalOrders,
      completedOrders: completedOrders ?? this.completedOrders,
      cancelledOrders: cancelledOrders ?? this.cancelledOrders,
      ghostOrders: ghostOrders ?? this.ghostOrders,
      completionRate: completionRate ?? this.completionRate,
      riskScore: riskScore ?? this.riskScore,
      riskLevel: riskLevel ?? this.riskLevel,
      verdict: verdict ?? this.verdict,
      accountAgeDays: accountAgeDays ?? this.accountAgeDays,
      totalValue: totalValue ?? this.totalValue,
      computedAt: computedAt ?? this.computedAt,
      source: source ?? this.source,
    );
  }
}
