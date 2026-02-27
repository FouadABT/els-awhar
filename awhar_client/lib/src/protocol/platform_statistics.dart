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

abstract class PlatformStatistics implements _i1.SerializableModel {
  PlatformStatistics._({
    this.id,
    required this.periodType,
    required this.periodStart,
    required this.periodEnd,
    int? totalUsers,
    int? newUsers,
    int? activeUsers,
    int? totalDrivers,
    int? newDrivers,
    int? activeDrivers,
    int? verifiedDrivers,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    int? disputedOrders,
    double? totalRevenue,
    double? platformRevenue,
    double? subscriptionRevenue,
    double? averageOrdersPerUser,
    double? averageOrderValue,
    DateTime? createdAt,
  }) : totalUsers = totalUsers ?? 0,
       newUsers = newUsers ?? 0,
       activeUsers = activeUsers ?? 0,
       totalDrivers = totalDrivers ?? 0,
       newDrivers = newDrivers ?? 0,
       activeDrivers = activeDrivers ?? 0,
       verifiedDrivers = verifiedDrivers ?? 0,
       totalOrders = totalOrders ?? 0,
       completedOrders = completedOrders ?? 0,
       cancelledOrders = cancelledOrders ?? 0,
       disputedOrders = disputedOrders ?? 0,
       totalRevenue = totalRevenue ?? 0.0,
       platformRevenue = platformRevenue ?? 0.0,
       subscriptionRevenue = subscriptionRevenue ?? 0.0,
       averageOrdersPerUser = averageOrdersPerUser ?? 0.0,
       averageOrderValue = averageOrderValue ?? 0.0,
       createdAt = createdAt ?? DateTime.now();

  factory PlatformStatistics({
    int? id,
    required String periodType,
    required DateTime periodStart,
    required DateTime periodEnd,
    int? totalUsers,
    int? newUsers,
    int? activeUsers,
    int? totalDrivers,
    int? newDrivers,
    int? activeDrivers,
    int? verifiedDrivers,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    int? disputedOrders,
    double? totalRevenue,
    double? platformRevenue,
    double? subscriptionRevenue,
    double? averageOrdersPerUser,
    double? averageOrderValue,
    DateTime? createdAt,
  }) = _PlatformStatisticsImpl;

  factory PlatformStatistics.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlatformStatistics(
      id: jsonSerialization['id'] as int?,
      periodType: jsonSerialization['periodType'] as String,
      periodStart: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['periodStart'],
      ),
      periodEnd: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['periodEnd'],
      ),
      totalUsers: jsonSerialization['totalUsers'] as int,
      newUsers: jsonSerialization['newUsers'] as int,
      activeUsers: jsonSerialization['activeUsers'] as int,
      totalDrivers: jsonSerialization['totalDrivers'] as int,
      newDrivers: jsonSerialization['newDrivers'] as int,
      activeDrivers: jsonSerialization['activeDrivers'] as int,
      verifiedDrivers: jsonSerialization['verifiedDrivers'] as int,
      totalOrders: jsonSerialization['totalOrders'] as int,
      completedOrders: jsonSerialization['completedOrders'] as int,
      cancelledOrders: jsonSerialization['cancelledOrders'] as int,
      disputedOrders: jsonSerialization['disputedOrders'] as int,
      totalRevenue: (jsonSerialization['totalRevenue'] as num).toDouble(),
      platformRevenue: (jsonSerialization['platformRevenue'] as num).toDouble(),
      subscriptionRevenue: (jsonSerialization['subscriptionRevenue'] as num)
          .toDouble(),
      averageOrdersPerUser: (jsonSerialization['averageOrdersPerUser'] as num)
          .toDouble(),
      averageOrderValue: (jsonSerialization['averageOrderValue'] as num)
          .toDouble(),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String periodType;

  DateTime periodStart;

  DateTime periodEnd;

  int totalUsers;

  int newUsers;

  int activeUsers;

  int totalDrivers;

  int newDrivers;

  int activeDrivers;

  int verifiedDrivers;

  int totalOrders;

  int completedOrders;

  int cancelledOrders;

  int disputedOrders;

  double totalRevenue;

  double platformRevenue;

  double subscriptionRevenue;

  double averageOrdersPerUser;

  double averageOrderValue;

  DateTime createdAt;

  /// Returns a shallow copy of this [PlatformStatistics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlatformStatistics copyWith({
    int? id,
    String? periodType,
    DateTime? periodStart,
    DateTime? periodEnd,
    int? totalUsers,
    int? newUsers,
    int? activeUsers,
    int? totalDrivers,
    int? newDrivers,
    int? activeDrivers,
    int? verifiedDrivers,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    int? disputedOrders,
    double? totalRevenue,
    double? platformRevenue,
    double? subscriptionRevenue,
    double? averageOrdersPerUser,
    double? averageOrderValue,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlatformStatistics',
      if (id != null) 'id': id,
      'periodType': periodType,
      'periodStart': periodStart.toJson(),
      'periodEnd': periodEnd.toJson(),
      'totalUsers': totalUsers,
      'newUsers': newUsers,
      'activeUsers': activeUsers,
      'totalDrivers': totalDrivers,
      'newDrivers': newDrivers,
      'activeDrivers': activeDrivers,
      'verifiedDrivers': verifiedDrivers,
      'totalOrders': totalOrders,
      'completedOrders': completedOrders,
      'cancelledOrders': cancelledOrders,
      'disputedOrders': disputedOrders,
      'totalRevenue': totalRevenue,
      'platformRevenue': platformRevenue,
      'subscriptionRevenue': subscriptionRevenue,
      'averageOrdersPerUser': averageOrdersPerUser,
      'averageOrderValue': averageOrderValue,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlatformStatisticsImpl extends PlatformStatistics {
  _PlatformStatisticsImpl({
    int? id,
    required String periodType,
    required DateTime periodStart,
    required DateTime periodEnd,
    int? totalUsers,
    int? newUsers,
    int? activeUsers,
    int? totalDrivers,
    int? newDrivers,
    int? activeDrivers,
    int? verifiedDrivers,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    int? disputedOrders,
    double? totalRevenue,
    double? platformRevenue,
    double? subscriptionRevenue,
    double? averageOrdersPerUser,
    double? averageOrderValue,
    DateTime? createdAt,
  }) : super._(
         id: id,
         periodType: periodType,
         periodStart: periodStart,
         periodEnd: periodEnd,
         totalUsers: totalUsers,
         newUsers: newUsers,
         activeUsers: activeUsers,
         totalDrivers: totalDrivers,
         newDrivers: newDrivers,
         activeDrivers: activeDrivers,
         verifiedDrivers: verifiedDrivers,
         totalOrders: totalOrders,
         completedOrders: completedOrders,
         cancelledOrders: cancelledOrders,
         disputedOrders: disputedOrders,
         totalRevenue: totalRevenue,
         platformRevenue: platformRevenue,
         subscriptionRevenue: subscriptionRevenue,
         averageOrdersPerUser: averageOrdersPerUser,
         averageOrderValue: averageOrderValue,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PlatformStatistics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlatformStatistics copyWith({
    Object? id = _Undefined,
    String? periodType,
    DateTime? periodStart,
    DateTime? periodEnd,
    int? totalUsers,
    int? newUsers,
    int? activeUsers,
    int? totalDrivers,
    int? newDrivers,
    int? activeDrivers,
    int? verifiedDrivers,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    int? disputedOrders,
    double? totalRevenue,
    double? platformRevenue,
    double? subscriptionRevenue,
    double? averageOrdersPerUser,
    double? averageOrderValue,
    DateTime? createdAt,
  }) {
    return PlatformStatistics(
      id: id is int? ? id : this.id,
      periodType: periodType ?? this.periodType,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      totalUsers: totalUsers ?? this.totalUsers,
      newUsers: newUsers ?? this.newUsers,
      activeUsers: activeUsers ?? this.activeUsers,
      totalDrivers: totalDrivers ?? this.totalDrivers,
      newDrivers: newDrivers ?? this.newDrivers,
      activeDrivers: activeDrivers ?? this.activeDrivers,
      verifiedDrivers: verifiedDrivers ?? this.verifiedDrivers,
      totalOrders: totalOrders ?? this.totalOrders,
      completedOrders: completedOrders ?? this.completedOrders,
      cancelledOrders: cancelledOrders ?? this.cancelledOrders,
      disputedOrders: disputedOrders ?? this.disputedOrders,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      platformRevenue: platformRevenue ?? this.platformRevenue,
      subscriptionRevenue: subscriptionRevenue ?? this.subscriptionRevenue,
      averageOrdersPerUser: averageOrdersPerUser ?? this.averageOrdersPerUser,
      averageOrderValue: averageOrderValue ?? this.averageOrderValue,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
