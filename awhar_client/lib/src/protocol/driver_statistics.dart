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

abstract class DriverStatistics implements _i1.SerializableModel {
  DriverStatistics._({
    this.id,
    required this.driverId,
    required this.periodType,
    required this.periodStart,
    required this.periodEnd,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    double? totalRevenue,
    double? platformCommission,
    double? netRevenue,
    double? averageRating,
    int? averageResponseTime,
    int? averageCompletionTime,
    double? hoursOnline,
    double? hoursOffline,
    DateTime? createdAt,
  }) : totalOrders = totalOrders ?? 0,
       completedOrders = completedOrders ?? 0,
       cancelledOrders = cancelledOrders ?? 0,
       totalRevenue = totalRevenue ?? 0.0,
       platformCommission = platformCommission ?? 0.0,
       netRevenue = netRevenue ?? 0.0,
       averageRating = averageRating ?? 0.0,
       averageResponseTime = averageResponseTime ?? 0,
       averageCompletionTime = averageCompletionTime ?? 0,
       hoursOnline = hoursOnline ?? 0.0,
       hoursOffline = hoursOffline ?? 0.0,
       createdAt = createdAt ?? DateTime.now();

  factory DriverStatistics({
    int? id,
    required int driverId,
    required String periodType,
    required DateTime periodStart,
    required DateTime periodEnd,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    double? totalRevenue,
    double? platformCommission,
    double? netRevenue,
    double? averageRating,
    int? averageResponseTime,
    int? averageCompletionTime,
    double? hoursOnline,
    double? hoursOffline,
    DateTime? createdAt,
  }) = _DriverStatisticsImpl;

  factory DriverStatistics.fromJson(Map<String, dynamic> jsonSerialization) {
    return DriverStatistics(
      id: jsonSerialization['id'] as int?,
      driverId: jsonSerialization['driverId'] as int,
      periodType: jsonSerialization['periodType'] as String,
      periodStart: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['periodStart'],
      ),
      periodEnd: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['periodEnd'],
      ),
      totalOrders: jsonSerialization['totalOrders'] as int,
      completedOrders: jsonSerialization['completedOrders'] as int,
      cancelledOrders: jsonSerialization['cancelledOrders'] as int,
      totalRevenue: (jsonSerialization['totalRevenue'] as num).toDouble(),
      platformCommission: (jsonSerialization['platformCommission'] as num)
          .toDouble(),
      netRevenue: (jsonSerialization['netRevenue'] as num).toDouble(),
      averageRating: (jsonSerialization['averageRating'] as num).toDouble(),
      averageResponseTime: jsonSerialization['averageResponseTime'] as int,
      averageCompletionTime: jsonSerialization['averageCompletionTime'] as int,
      hoursOnline: (jsonSerialization['hoursOnline'] as num).toDouble(),
      hoursOffline: (jsonSerialization['hoursOffline'] as num).toDouble(),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int driverId;

  String periodType;

  DateTime periodStart;

  DateTime periodEnd;

  int totalOrders;

  int completedOrders;

  int cancelledOrders;

  double totalRevenue;

  double platformCommission;

  double netRevenue;

  double averageRating;

  int averageResponseTime;

  int averageCompletionTime;

  double hoursOnline;

  double hoursOffline;

  DateTime createdAt;

  /// Returns a shallow copy of this [DriverStatistics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DriverStatistics copyWith({
    int? id,
    int? driverId,
    String? periodType,
    DateTime? periodStart,
    DateTime? periodEnd,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    double? totalRevenue,
    double? platformCommission,
    double? netRevenue,
    double? averageRating,
    int? averageResponseTime,
    int? averageCompletionTime,
    double? hoursOnline,
    double? hoursOffline,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DriverStatistics',
      if (id != null) 'id': id,
      'driverId': driverId,
      'periodType': periodType,
      'periodStart': periodStart.toJson(),
      'periodEnd': periodEnd.toJson(),
      'totalOrders': totalOrders,
      'completedOrders': completedOrders,
      'cancelledOrders': cancelledOrders,
      'totalRevenue': totalRevenue,
      'platformCommission': platformCommission,
      'netRevenue': netRevenue,
      'averageRating': averageRating,
      'averageResponseTime': averageResponseTime,
      'averageCompletionTime': averageCompletionTime,
      'hoursOnline': hoursOnline,
      'hoursOffline': hoursOffline,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DriverStatisticsImpl extends DriverStatistics {
  _DriverStatisticsImpl({
    int? id,
    required int driverId,
    required String periodType,
    required DateTime periodStart,
    required DateTime periodEnd,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    double? totalRevenue,
    double? platformCommission,
    double? netRevenue,
    double? averageRating,
    int? averageResponseTime,
    int? averageCompletionTime,
    double? hoursOnline,
    double? hoursOffline,
    DateTime? createdAt,
  }) : super._(
         id: id,
         driverId: driverId,
         periodType: periodType,
         periodStart: periodStart,
         periodEnd: periodEnd,
         totalOrders: totalOrders,
         completedOrders: completedOrders,
         cancelledOrders: cancelledOrders,
         totalRevenue: totalRevenue,
         platformCommission: platformCommission,
         netRevenue: netRevenue,
         averageRating: averageRating,
         averageResponseTime: averageResponseTime,
         averageCompletionTime: averageCompletionTime,
         hoursOnline: hoursOnline,
         hoursOffline: hoursOffline,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [DriverStatistics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DriverStatistics copyWith({
    Object? id = _Undefined,
    int? driverId,
    String? periodType,
    DateTime? periodStart,
    DateTime? periodEnd,
    int? totalOrders,
    int? completedOrders,
    int? cancelledOrders,
    double? totalRevenue,
    double? platformCommission,
    double? netRevenue,
    double? averageRating,
    int? averageResponseTime,
    int? averageCompletionTime,
    double? hoursOnline,
    double? hoursOffline,
    DateTime? createdAt,
  }) {
    return DriverStatistics(
      id: id is int? ? id : this.id,
      driverId: driverId ?? this.driverId,
      periodType: periodType ?? this.periodType,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      totalOrders: totalOrders ?? this.totalOrders,
      completedOrders: completedOrders ?? this.completedOrders,
      cancelledOrders: cancelledOrders ?? this.cancelledOrders,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      platformCommission: platformCommission ?? this.platformCommission,
      netRevenue: netRevenue ?? this.netRevenue,
      averageRating: averageRating ?? this.averageRating,
      averageResponseTime: averageResponseTime ?? this.averageResponseTime,
      averageCompletionTime:
          averageCompletionTime ?? this.averageCompletionTime,
      hoursOnline: hoursOnline ?? this.hoursOnline,
      hoursOffline: hoursOffline ?? this.hoursOffline,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
