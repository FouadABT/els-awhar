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

abstract class StoreReport implements _i1.SerializableModel {
  StoreReport._({
    this.id,
    this.storeOrderId,
    required this.reporterId,
    required this.reporterType,
    required this.reportedType,
    required this.reportedId,
    required this.reason,
    required this.description,
    this.evidenceUrls,
    String? status,
    this.resolution,
    this.resolvedBy,
    this.resolvedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : status = status ?? 'pending',
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory StoreReport({
    int? id,
    int? storeOrderId,
    required int reporterId,
    required String reporterType,
    required String reportedType,
    required int reportedId,
    required String reason,
    required String description,
    String? evidenceUrls,
    String? status,
    String? resolution,
    int? resolvedBy,
    DateTime? resolvedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StoreReportImpl;

  factory StoreReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreReport(
      id: jsonSerialization['id'] as int?,
      storeOrderId: jsonSerialization['storeOrderId'] as int?,
      reporterId: jsonSerialization['reporterId'] as int,
      reporterType: jsonSerialization['reporterType'] as String,
      reportedType: jsonSerialization['reportedType'] as String,
      reportedId: jsonSerialization['reportedId'] as int,
      reason: jsonSerialization['reason'] as String,
      description: jsonSerialization['description'] as String,
      evidenceUrls: jsonSerialization['evidenceUrls'] as String?,
      status: jsonSerialization['status'] as String,
      resolution: jsonSerialization['resolution'] as String?,
      resolvedBy: jsonSerialization['resolvedBy'] as int?,
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
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

  int? storeOrderId;

  int reporterId;

  String reporterType;

  String reportedType;

  int reportedId;

  String reason;

  String description;

  String? evidenceUrls;

  String status;

  String? resolution;

  int? resolvedBy;

  DateTime? resolvedAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [StoreReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreReport copyWith({
    int? id,
    int? storeOrderId,
    int? reporterId,
    String? reporterType,
    String? reportedType,
    int? reportedId,
    String? reason,
    String? description,
    String? evidenceUrls,
    String? status,
    String? resolution,
    int? resolvedBy,
    DateTime? resolvedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreReport',
      if (id != null) 'id': id,
      if (storeOrderId != null) 'storeOrderId': storeOrderId,
      'reporterId': reporterId,
      'reporterType': reporterType,
      'reportedType': reportedType,
      'reportedId': reportedId,
      'reason': reason,
      'description': description,
      if (evidenceUrls != null) 'evidenceUrls': evidenceUrls,
      'status': status,
      if (resolution != null) 'resolution': resolution,
      if (resolvedBy != null) 'resolvedBy': resolvedBy,
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
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

class _StoreReportImpl extends StoreReport {
  _StoreReportImpl({
    int? id,
    int? storeOrderId,
    required int reporterId,
    required String reporterType,
    required String reportedType,
    required int reportedId,
    required String reason,
    required String description,
    String? evidenceUrls,
    String? status,
    String? resolution,
    int? resolvedBy,
    DateTime? resolvedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         storeOrderId: storeOrderId,
         reporterId: reporterId,
         reporterType: reporterType,
         reportedType: reportedType,
         reportedId: reportedId,
         reason: reason,
         description: description,
         evidenceUrls: evidenceUrls,
         status: status,
         resolution: resolution,
         resolvedBy: resolvedBy,
         resolvedAt: resolvedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StoreReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreReport copyWith({
    Object? id = _Undefined,
    Object? storeOrderId = _Undefined,
    int? reporterId,
    String? reporterType,
    String? reportedType,
    int? reportedId,
    String? reason,
    String? description,
    Object? evidenceUrls = _Undefined,
    String? status,
    Object? resolution = _Undefined,
    Object? resolvedBy = _Undefined,
    Object? resolvedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StoreReport(
      id: id is int? ? id : this.id,
      storeOrderId: storeOrderId is int? ? storeOrderId : this.storeOrderId,
      reporterId: reporterId ?? this.reporterId,
      reporterType: reporterType ?? this.reporterType,
      reportedType: reportedType ?? this.reportedType,
      reportedId: reportedId ?? this.reportedId,
      reason: reason ?? this.reason,
      description: description ?? this.description,
      evidenceUrls: evidenceUrls is String? ? evidenceUrls : this.evidenceUrls,
      status: status ?? this.status,
      resolution: resolution is String? ? resolution : this.resolution,
      resolvedBy: resolvedBy is int? ? resolvedBy : this.resolvedBy,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
