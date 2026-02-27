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

abstract class DashboardStats implements _i1.SerializableModel {
  DashboardStats._({
    required this.totalUsers,
    required this.totalDrivers,
    required this.onlineDrivers,
    required this.totalClients,
    required this.totalStores,
    required this.activeStores,
    required this.totalRequests,
    required this.pendingRequests,
    required this.completedRequests,
    required this.totalOrders,
    required this.pendingOrders,
    required this.pendingReports,
    required this.totalRevenue,
    required this.totalCommission,
    required this.updatedAt,
  });

  factory DashboardStats({
    required int totalUsers,
    required int totalDrivers,
    required int onlineDrivers,
    required int totalClients,
    required int totalStores,
    required int activeStores,
    required int totalRequests,
    required int pendingRequests,
    required int completedRequests,
    required int totalOrders,
    required int pendingOrders,
    required int pendingReports,
    required double totalRevenue,
    required double totalCommission,
    required DateTime updatedAt,
  }) = _DashboardStatsImpl;

  factory DashboardStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return DashboardStats(
      totalUsers: jsonSerialization['totalUsers'] as int,
      totalDrivers: jsonSerialization['totalDrivers'] as int,
      onlineDrivers: jsonSerialization['onlineDrivers'] as int,
      totalClients: jsonSerialization['totalClients'] as int,
      totalStores: jsonSerialization['totalStores'] as int,
      activeStores: jsonSerialization['activeStores'] as int,
      totalRequests: jsonSerialization['totalRequests'] as int,
      pendingRequests: jsonSerialization['pendingRequests'] as int,
      completedRequests: jsonSerialization['completedRequests'] as int,
      totalOrders: jsonSerialization['totalOrders'] as int,
      pendingOrders: jsonSerialization['pendingOrders'] as int,
      pendingReports: jsonSerialization['pendingReports'] as int,
      totalRevenue: (jsonSerialization['totalRevenue'] as num).toDouble(),
      totalCommission: (jsonSerialization['totalCommission'] as num).toDouble(),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  int totalUsers;

  int totalDrivers;

  int onlineDrivers;

  int totalClients;

  int totalStores;

  int activeStores;

  int totalRequests;

  int pendingRequests;

  int completedRequests;

  int totalOrders;

  int pendingOrders;

  int pendingReports;

  double totalRevenue;

  double totalCommission;

  DateTime updatedAt;

  /// Returns a shallow copy of this [DashboardStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DashboardStats copyWith({
    int? totalUsers,
    int? totalDrivers,
    int? onlineDrivers,
    int? totalClients,
    int? totalStores,
    int? activeStores,
    int? totalRequests,
    int? pendingRequests,
    int? completedRequests,
    int? totalOrders,
    int? pendingOrders,
    int? pendingReports,
    double? totalRevenue,
    double? totalCommission,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardStats',
      'totalUsers': totalUsers,
      'totalDrivers': totalDrivers,
      'onlineDrivers': onlineDrivers,
      'totalClients': totalClients,
      'totalStores': totalStores,
      'activeStores': activeStores,
      'totalRequests': totalRequests,
      'pendingRequests': pendingRequests,
      'completedRequests': completedRequests,
      'totalOrders': totalOrders,
      'pendingOrders': pendingOrders,
      'pendingReports': pendingReports,
      'totalRevenue': totalRevenue,
      'totalCommission': totalCommission,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DashboardStatsImpl extends DashboardStats {
  _DashboardStatsImpl({
    required int totalUsers,
    required int totalDrivers,
    required int onlineDrivers,
    required int totalClients,
    required int totalStores,
    required int activeStores,
    required int totalRequests,
    required int pendingRequests,
    required int completedRequests,
    required int totalOrders,
    required int pendingOrders,
    required int pendingReports,
    required double totalRevenue,
    required double totalCommission,
    required DateTime updatedAt,
  }) : super._(
         totalUsers: totalUsers,
         totalDrivers: totalDrivers,
         onlineDrivers: onlineDrivers,
         totalClients: totalClients,
         totalStores: totalStores,
         activeStores: activeStores,
         totalRequests: totalRequests,
         pendingRequests: pendingRequests,
         completedRequests: completedRequests,
         totalOrders: totalOrders,
         pendingOrders: pendingOrders,
         pendingReports: pendingReports,
         totalRevenue: totalRevenue,
         totalCommission: totalCommission,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DashboardStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DashboardStats copyWith({
    int? totalUsers,
    int? totalDrivers,
    int? onlineDrivers,
    int? totalClients,
    int? totalStores,
    int? activeStores,
    int? totalRequests,
    int? pendingRequests,
    int? completedRequests,
    int? totalOrders,
    int? pendingOrders,
    int? pendingReports,
    double? totalRevenue,
    double? totalCommission,
    DateTime? updatedAt,
  }) {
    return DashboardStats(
      totalUsers: totalUsers ?? this.totalUsers,
      totalDrivers: totalDrivers ?? this.totalDrivers,
      onlineDrivers: onlineDrivers ?? this.onlineDrivers,
      totalClients: totalClients ?? this.totalClients,
      totalStores: totalStores ?? this.totalStores,
      activeStores: activeStores ?? this.activeStores,
      totalRequests: totalRequests ?? this.totalRequests,
      pendingRequests: pendingRequests ?? this.pendingRequests,
      completedRequests: completedRequests ?? this.completedRequests,
      totalOrders: totalOrders ?? this.totalOrders,
      pendingOrders: pendingOrders ?? this.pendingOrders,
      pendingReports: pendingReports ?? this.pendingReports,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      totalCommission: totalCommission ?? this.totalCommission,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
