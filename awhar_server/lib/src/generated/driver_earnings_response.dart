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
import 'transaction.dart' as _i2;
import 'package:awhar_server/src/generated/protocol.dart' as _i3;

/// DriverEarningsResponse
/// Response model for driver earnings data
abstract class DriverEarningsResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DriverEarningsResponse._({
    required this.totalEarnings,
    required this.totalCommission,
    required this.totalGross,
    required this.todayEarnings,
    required this.weekEarnings,
    required this.pendingEarnings,
    required this.completedRides,
    required this.activeRides,
    required this.transactions,
  });

  factory DriverEarningsResponse({
    required double totalEarnings,
    required double totalCommission,
    required double totalGross,
    required double todayEarnings,
    required double weekEarnings,
    required double pendingEarnings,
    required int completedRides,
    required int activeRides,
    required List<_i2.Transaction> transactions,
  }) = _DriverEarningsResponseImpl;

  factory DriverEarningsResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DriverEarningsResponse(
      totalEarnings: (jsonSerialization['totalEarnings'] as num).toDouble(),
      totalCommission: (jsonSerialization['totalCommission'] as num).toDouble(),
      totalGross: (jsonSerialization['totalGross'] as num).toDouble(),
      todayEarnings: (jsonSerialization['todayEarnings'] as num).toDouble(),
      weekEarnings: (jsonSerialization['weekEarnings'] as num).toDouble(),
      pendingEarnings: (jsonSerialization['pendingEarnings'] as num).toDouble(),
      completedRides: jsonSerialization['completedRides'] as int,
      activeRides: jsonSerialization['activeRides'] as int,
      transactions: _i3.Protocol().deserialize<List<_i2.Transaction>>(
        jsonSerialization['transactions'],
      ),
    );
  }

  double totalEarnings;

  double totalCommission;

  double totalGross;

  double todayEarnings;

  double weekEarnings;

  double pendingEarnings;

  int completedRides;

  int activeRides;

  List<_i2.Transaction> transactions;

  /// Returns a shallow copy of this [DriverEarningsResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DriverEarningsResponse copyWith({
    double? totalEarnings,
    double? totalCommission,
    double? totalGross,
    double? todayEarnings,
    double? weekEarnings,
    double? pendingEarnings,
    int? completedRides,
    int? activeRides,
    List<_i2.Transaction>? transactions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DriverEarningsResponse',
      'totalEarnings': totalEarnings,
      'totalCommission': totalCommission,
      'totalGross': totalGross,
      'todayEarnings': todayEarnings,
      'weekEarnings': weekEarnings,
      'pendingEarnings': pendingEarnings,
      'completedRides': completedRides,
      'activeRides': activeRides,
      'transactions': transactions.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DriverEarningsResponse',
      'totalEarnings': totalEarnings,
      'totalCommission': totalCommission,
      'totalGross': totalGross,
      'todayEarnings': todayEarnings,
      'weekEarnings': weekEarnings,
      'pendingEarnings': pendingEarnings,
      'completedRides': completedRides,
      'activeRides': activeRides,
      'transactions': transactions.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DriverEarningsResponseImpl extends DriverEarningsResponse {
  _DriverEarningsResponseImpl({
    required double totalEarnings,
    required double totalCommission,
    required double totalGross,
    required double todayEarnings,
    required double weekEarnings,
    required double pendingEarnings,
    required int completedRides,
    required int activeRides,
    required List<_i2.Transaction> transactions,
  }) : super._(
         totalEarnings: totalEarnings,
         totalCommission: totalCommission,
         totalGross: totalGross,
         todayEarnings: todayEarnings,
         weekEarnings: weekEarnings,
         pendingEarnings: pendingEarnings,
         completedRides: completedRides,
         activeRides: activeRides,
         transactions: transactions,
       );

  /// Returns a shallow copy of this [DriverEarningsResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DriverEarningsResponse copyWith({
    double? totalEarnings,
    double? totalCommission,
    double? totalGross,
    double? todayEarnings,
    double? weekEarnings,
    double? pendingEarnings,
    int? completedRides,
    int? activeRides,
    List<_i2.Transaction>? transactions,
  }) {
    return DriverEarningsResponse(
      totalEarnings: totalEarnings ?? this.totalEarnings,
      totalCommission: totalCommission ?? this.totalCommission,
      totalGross: totalGross ?? this.totalGross,
      todayEarnings: todayEarnings ?? this.todayEarnings,
      weekEarnings: weekEarnings ?? this.weekEarnings,
      pendingEarnings: pendingEarnings ?? this.pendingEarnings,
      completedRides: completedRides ?? this.completedRides,
      activeRides: activeRides ?? this.activeRides,
      transactions:
          transactions ?? this.transactions.map((e0) => e0.copyWith()).toList(),
    );
  }
}
