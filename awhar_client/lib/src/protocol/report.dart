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
import 'reporter_type_enum.dart' as _i2;
import 'report_reason_enum.dart' as _i3;
import 'report_status_enum.dart' as _i4;
import 'report_resolution_enum.dart' as _i5;
import 'package:awhar_client/src/protocol/protocol.dart' as _i6;

abstract class Report implements _i1.SerializableModel {
  Report._({
    this.id,
    required this.reportedByUserId,
    this.reporterType,
    this.reportedDriverId,
    this.reportedClientId,
    this.reportedStoreId,
    this.reportedOrderId,
    this.reportedType,
    this.reportReason,
    required this.description,
    this.evidenceUrls,
    this.status,
    this.resolution,
    this.reviewedByAdminId,
    this.reviewNotes,
    this.adminNotes,
    this.reviewedAt,
    this.resolvedAt,
    this.resolvedBy,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Report({
    int? id,
    required int reportedByUserId,
    _i2.ReporterType? reporterType,
    int? reportedDriverId,
    int? reportedClientId,
    int? reportedStoreId,
    int? reportedOrderId,
    _i2.ReporterType? reportedType,
    _i3.ReportReason? reportReason,
    required String description,
    List<String>? evidenceUrls,
    _i4.ReportStatus? status,
    _i5.ReportResolution? resolution,
    int? reviewedByAdminId,
    String? reviewNotes,
    String? adminNotes,
    DateTime? reviewedAt,
    DateTime? resolvedAt,
    int? resolvedBy,
    DateTime? createdAt,
  }) = _ReportImpl;

  factory Report.fromJson(Map<String, dynamic> jsonSerialization) {
    return Report(
      id: jsonSerialization['id'] as int?,
      reportedByUserId: jsonSerialization['reportedByUserId'] as int,
      reporterType: jsonSerialization['reporterType'] == null
          ? null
          : _i2.ReporterType.fromJson(
              (jsonSerialization['reporterType'] as int),
            ),
      reportedDriverId: jsonSerialization['reportedDriverId'] as int?,
      reportedClientId: jsonSerialization['reportedClientId'] as int?,
      reportedStoreId: jsonSerialization['reportedStoreId'] as int?,
      reportedOrderId: jsonSerialization['reportedOrderId'] as int?,
      reportedType: jsonSerialization['reportedType'] == null
          ? null
          : _i2.ReporterType.fromJson(
              (jsonSerialization['reportedType'] as int),
            ),
      reportReason: jsonSerialization['reportReason'] == null
          ? null
          : _i3.ReportReason.fromJson(
              (jsonSerialization['reportReason'] as int),
            ),
      description: jsonSerialization['description'] as String,
      evidenceUrls: jsonSerialization['evidenceUrls'] == null
          ? null
          : _i6.Protocol().deserialize<List<String>>(
              jsonSerialization['evidenceUrls'],
            ),
      status: jsonSerialization['status'] == null
          ? null
          : _i4.ReportStatus.fromJson((jsonSerialization['status'] as int)),
      resolution: jsonSerialization['resolution'] == null
          ? null
          : _i5.ReportResolution.fromJson(
              (jsonSerialization['resolution'] as int),
            ),
      reviewedByAdminId: jsonSerialization['reviewedByAdminId'] as int?,
      reviewNotes: jsonSerialization['reviewNotes'] as String?,
      adminNotes: jsonSerialization['adminNotes'] as String?,
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
      resolvedBy: jsonSerialization['resolvedBy'] as int?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int reportedByUserId;

  _i2.ReporterType? reporterType;

  int? reportedDriverId;

  int? reportedClientId;

  int? reportedStoreId;

  int? reportedOrderId;

  _i2.ReporterType? reportedType;

  _i3.ReportReason? reportReason;

  String description;

  List<String>? evidenceUrls;

  _i4.ReportStatus? status;

  _i5.ReportResolution? resolution;

  int? reviewedByAdminId;

  String? reviewNotes;

  String? adminNotes;

  DateTime? reviewedAt;

  DateTime? resolvedAt;

  int? resolvedBy;

  DateTime createdAt;

  /// Returns a shallow copy of this [Report]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Report copyWith({
    int? id,
    int? reportedByUserId,
    _i2.ReporterType? reporterType,
    int? reportedDriverId,
    int? reportedClientId,
    int? reportedStoreId,
    int? reportedOrderId,
    _i2.ReporterType? reportedType,
    _i3.ReportReason? reportReason,
    String? description,
    List<String>? evidenceUrls,
    _i4.ReportStatus? status,
    _i5.ReportResolution? resolution,
    int? reviewedByAdminId,
    String? reviewNotes,
    String? adminNotes,
    DateTime? reviewedAt,
    DateTime? resolvedAt,
    int? resolvedBy,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Report',
      if (id != null) 'id': id,
      'reportedByUserId': reportedByUserId,
      if (reporterType != null) 'reporterType': reporterType?.toJson(),
      if (reportedDriverId != null) 'reportedDriverId': reportedDriverId,
      if (reportedClientId != null) 'reportedClientId': reportedClientId,
      if (reportedStoreId != null) 'reportedStoreId': reportedStoreId,
      if (reportedOrderId != null) 'reportedOrderId': reportedOrderId,
      if (reportedType != null) 'reportedType': reportedType?.toJson(),
      if (reportReason != null) 'reportReason': reportReason?.toJson(),
      'description': description,
      if (evidenceUrls != null) 'evidenceUrls': evidenceUrls?.toJson(),
      if (status != null) 'status': status?.toJson(),
      if (resolution != null) 'resolution': resolution?.toJson(),
      if (reviewedByAdminId != null) 'reviewedByAdminId': reviewedByAdminId,
      if (reviewNotes != null) 'reviewNotes': reviewNotes,
      if (adminNotes != null) 'adminNotes': adminNotes,
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      if (resolvedBy != null) 'resolvedBy': resolvedBy,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReportImpl extends Report {
  _ReportImpl({
    int? id,
    required int reportedByUserId,
    _i2.ReporterType? reporterType,
    int? reportedDriverId,
    int? reportedClientId,
    int? reportedStoreId,
    int? reportedOrderId,
    _i2.ReporterType? reportedType,
    _i3.ReportReason? reportReason,
    required String description,
    List<String>? evidenceUrls,
    _i4.ReportStatus? status,
    _i5.ReportResolution? resolution,
    int? reviewedByAdminId,
    String? reviewNotes,
    String? adminNotes,
    DateTime? reviewedAt,
    DateTime? resolvedAt,
    int? resolvedBy,
    DateTime? createdAt,
  }) : super._(
         id: id,
         reportedByUserId: reportedByUserId,
         reporterType: reporterType,
         reportedDriverId: reportedDriverId,
         reportedClientId: reportedClientId,
         reportedStoreId: reportedStoreId,
         reportedOrderId: reportedOrderId,
         reportedType: reportedType,
         reportReason: reportReason,
         description: description,
         evidenceUrls: evidenceUrls,
         status: status,
         resolution: resolution,
         reviewedByAdminId: reviewedByAdminId,
         reviewNotes: reviewNotes,
         adminNotes: adminNotes,
         reviewedAt: reviewedAt,
         resolvedAt: resolvedAt,
         resolvedBy: resolvedBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Report]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Report copyWith({
    Object? id = _Undefined,
    int? reportedByUserId,
    Object? reporterType = _Undefined,
    Object? reportedDriverId = _Undefined,
    Object? reportedClientId = _Undefined,
    Object? reportedStoreId = _Undefined,
    Object? reportedOrderId = _Undefined,
    Object? reportedType = _Undefined,
    Object? reportReason = _Undefined,
    String? description,
    Object? evidenceUrls = _Undefined,
    Object? status = _Undefined,
    Object? resolution = _Undefined,
    Object? reviewedByAdminId = _Undefined,
    Object? reviewNotes = _Undefined,
    Object? adminNotes = _Undefined,
    Object? reviewedAt = _Undefined,
    Object? resolvedAt = _Undefined,
    Object? resolvedBy = _Undefined,
    DateTime? createdAt,
  }) {
    return Report(
      id: id is int? ? id : this.id,
      reportedByUserId: reportedByUserId ?? this.reportedByUserId,
      reporterType: reporterType is _i2.ReporterType?
          ? reporterType
          : this.reporterType,
      reportedDriverId: reportedDriverId is int?
          ? reportedDriverId
          : this.reportedDriverId,
      reportedClientId: reportedClientId is int?
          ? reportedClientId
          : this.reportedClientId,
      reportedStoreId: reportedStoreId is int?
          ? reportedStoreId
          : this.reportedStoreId,
      reportedOrderId: reportedOrderId is int?
          ? reportedOrderId
          : this.reportedOrderId,
      reportedType: reportedType is _i2.ReporterType?
          ? reportedType
          : this.reportedType,
      reportReason: reportReason is _i3.ReportReason?
          ? reportReason
          : this.reportReason,
      description: description ?? this.description,
      evidenceUrls: evidenceUrls is List<String>?
          ? evidenceUrls
          : this.evidenceUrls?.map((e0) => e0).toList(),
      status: status is _i4.ReportStatus? ? status : this.status,
      resolution: resolution is _i5.ReportResolution?
          ? resolution
          : this.resolution,
      reviewedByAdminId: reviewedByAdminId is int?
          ? reviewedByAdminId
          : this.reviewedByAdminId,
      reviewNotes: reviewNotes is String? ? reviewNotes : this.reviewNotes,
      adminNotes: adminNotes is String? ? adminNotes : this.adminNotes,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
      resolvedBy: resolvedBy is int? ? resolvedBy : this.resolvedBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
