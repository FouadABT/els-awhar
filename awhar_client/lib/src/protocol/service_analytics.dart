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

abstract class ServiceAnalytics implements _i1.SerializableModel {
  ServiceAnalytics._({
    this.id,
    required this.driverServiceId,
    int? totalViews,
    int? uniqueViews,
    this.lastViewedAt,
    int? totalInquiries,
    int? totalBookings,
    double? conversionRate,
    int? averageResponseTime,
    double? completionRate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : totalViews = totalViews ?? 0,
       uniqueViews = uniqueViews ?? 0,
       totalInquiries = totalInquiries ?? 0,
       totalBookings = totalBookings ?? 0,
       conversionRate = conversionRate ?? 0.0,
       averageResponseTime = averageResponseTime ?? 0,
       completionRate = completionRate ?? 0.0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory ServiceAnalytics({
    int? id,
    required int driverServiceId,
    int? totalViews,
    int? uniqueViews,
    DateTime? lastViewedAt,
    int? totalInquiries,
    int? totalBookings,
    double? conversionRate,
    int? averageResponseTime,
    double? completionRate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ServiceAnalyticsImpl;

  factory ServiceAnalytics.fromJson(Map<String, dynamic> jsonSerialization) {
    return ServiceAnalytics(
      id: jsonSerialization['id'] as int?,
      driverServiceId: jsonSerialization['driverServiceId'] as int,
      totalViews: jsonSerialization['totalViews'] as int,
      uniqueViews: jsonSerialization['uniqueViews'] as int,
      lastViewedAt: jsonSerialization['lastViewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastViewedAt'],
            ),
      totalInquiries: jsonSerialization['totalInquiries'] as int,
      totalBookings: jsonSerialization['totalBookings'] as int,
      conversionRate: (jsonSerialization['conversionRate'] as num).toDouble(),
      averageResponseTime: jsonSerialization['averageResponseTime'] as int,
      completionRate: (jsonSerialization['completionRate'] as num).toDouble(),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int driverServiceId;

  int totalViews;

  int uniqueViews;

  DateTime? lastViewedAt;

  int totalInquiries;

  int totalBookings;

  double conversionRate;

  int averageResponseTime;

  double completionRate;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ServiceAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ServiceAnalytics copyWith({
    int? id,
    int? driverServiceId,
    int? totalViews,
    int? uniqueViews,
    DateTime? lastViewedAt,
    int? totalInquiries,
    int? totalBookings,
    double? conversionRate,
    int? averageResponseTime,
    double? completionRate,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ServiceAnalytics',
      if (id != null) 'id': id,
      'driverServiceId': driverServiceId,
      'totalViews': totalViews,
      'uniqueViews': uniqueViews,
      if (lastViewedAt != null) 'lastViewedAt': lastViewedAt?.toJson(),
      'totalInquiries': totalInquiries,
      'totalBookings': totalBookings,
      'conversionRate': conversionRate,
      'averageResponseTime': averageResponseTime,
      'completionRate': completionRate,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ServiceAnalyticsImpl extends ServiceAnalytics {
  _ServiceAnalyticsImpl({
    int? id,
    required int driverServiceId,
    int? totalViews,
    int? uniqueViews,
    DateTime? lastViewedAt,
    int? totalInquiries,
    int? totalBookings,
    double? conversionRate,
    int? averageResponseTime,
    double? completionRate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         driverServiceId: driverServiceId,
         totalViews: totalViews,
         uniqueViews: uniqueViews,
         lastViewedAt: lastViewedAt,
         totalInquiries: totalInquiries,
         totalBookings: totalBookings,
         conversionRate: conversionRate,
         averageResponseTime: averageResponseTime,
         completionRate: completionRate,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ServiceAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ServiceAnalytics copyWith({
    Object? id = _Undefined,
    int? driverServiceId,
    int? totalViews,
    int? uniqueViews,
    Object? lastViewedAt = _Undefined,
    int? totalInquiries,
    int? totalBookings,
    double? conversionRate,
    int? averageResponseTime,
    double? completionRate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ServiceAnalytics(
      id: id is int? ? id : this.id,
      driverServiceId: driverServiceId ?? this.driverServiceId,
      totalViews: totalViews ?? this.totalViews,
      uniqueViews: uniqueViews ?? this.uniqueViews,
      lastViewedAt: lastViewedAt is DateTime?
          ? lastViewedAt
          : this.lastViewedAt,
      totalInquiries: totalInquiries ?? this.totalInquiries,
      totalBookings: totalBookings ?? this.totalBookings,
      conversionRate: conversionRate ?? this.conversionRate,
      averageResponseTime: averageResponseTime ?? this.averageResponseTime,
      completionRate: completionRate ?? this.completionRate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
