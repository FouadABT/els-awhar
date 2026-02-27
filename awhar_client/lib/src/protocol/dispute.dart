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
import 'dispute_type_enum.dart' as _i2;
import 'dispute_status_enum.dart' as _i3;
import 'package:awhar_client/src/protocol/protocol.dart' as _i4;

abstract class Dispute implements _i1.SerializableModel {
  Dispute._({
    this.id,
    required this.orderId,
    required this.openedByUserId,
    required this.clientId,
    required this.driverId,
    this.disputeType,
    required this.title,
    required this.description,
    this.evidenceUrls,
    this.status,
    this.resolution,
    this.resolvedByAdminId,
    this.resolvedAt,
    this.refundAmount,
    bool? refundIssued,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : refundIssued = refundIssued ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Dispute({
    int? id,
    required int orderId,
    required int openedByUserId,
    required int clientId,
    required int driverId,
    _i2.DisputeType? disputeType,
    required String title,
    required String description,
    List<String>? evidenceUrls,
    _i3.DisputeStatus? status,
    String? resolution,
    int? resolvedByAdminId,
    DateTime? resolvedAt,
    double? refundAmount,
    bool? refundIssued,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DisputeImpl;

  factory Dispute.fromJson(Map<String, dynamic> jsonSerialization) {
    return Dispute(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      openedByUserId: jsonSerialization['openedByUserId'] as int,
      clientId: jsonSerialization['clientId'] as int,
      driverId: jsonSerialization['driverId'] as int,
      disputeType: jsonSerialization['disputeType'] == null
          ? null
          : _i2.DisputeType.fromJson((jsonSerialization['disputeType'] as int)),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      evidenceUrls: jsonSerialization['evidenceUrls'] == null
          ? null
          : _i4.Protocol().deserialize<List<String>>(
              jsonSerialization['evidenceUrls'],
            ),
      status: jsonSerialization['status'] == null
          ? null
          : _i3.DisputeStatus.fromJson((jsonSerialization['status'] as int)),
      resolution: jsonSerialization['resolution'] as String?,
      resolvedByAdminId: jsonSerialization['resolvedByAdminId'] as int?,
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
      refundAmount: (jsonSerialization['refundAmount'] as num?)?.toDouble(),
      refundIssued: jsonSerialization['refundIssued'] as bool,
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

  int orderId;

  int openedByUserId;

  int clientId;

  int driverId;

  _i2.DisputeType? disputeType;

  String title;

  String description;

  List<String>? evidenceUrls;

  _i3.DisputeStatus? status;

  String? resolution;

  int? resolvedByAdminId;

  DateTime? resolvedAt;

  double? refundAmount;

  bool refundIssued;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Dispute]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Dispute copyWith({
    int? id,
    int? orderId,
    int? openedByUserId,
    int? clientId,
    int? driverId,
    _i2.DisputeType? disputeType,
    String? title,
    String? description,
    List<String>? evidenceUrls,
    _i3.DisputeStatus? status,
    String? resolution,
    int? resolvedByAdminId,
    DateTime? resolvedAt,
    double? refundAmount,
    bool? refundIssued,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Dispute',
      if (id != null) 'id': id,
      'orderId': orderId,
      'openedByUserId': openedByUserId,
      'clientId': clientId,
      'driverId': driverId,
      if (disputeType != null) 'disputeType': disputeType?.toJson(),
      'title': title,
      'description': description,
      if (evidenceUrls != null) 'evidenceUrls': evidenceUrls?.toJson(),
      if (status != null) 'status': status?.toJson(),
      if (resolution != null) 'resolution': resolution,
      if (resolvedByAdminId != null) 'resolvedByAdminId': resolvedByAdminId,
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      if (refundAmount != null) 'refundAmount': refundAmount,
      'refundIssued': refundIssued,
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

class _DisputeImpl extends Dispute {
  _DisputeImpl({
    int? id,
    required int orderId,
    required int openedByUserId,
    required int clientId,
    required int driverId,
    _i2.DisputeType? disputeType,
    required String title,
    required String description,
    List<String>? evidenceUrls,
    _i3.DisputeStatus? status,
    String? resolution,
    int? resolvedByAdminId,
    DateTime? resolvedAt,
    double? refundAmount,
    bool? refundIssued,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         orderId: orderId,
         openedByUserId: openedByUserId,
         clientId: clientId,
         driverId: driverId,
         disputeType: disputeType,
         title: title,
         description: description,
         evidenceUrls: evidenceUrls,
         status: status,
         resolution: resolution,
         resolvedByAdminId: resolvedByAdminId,
         resolvedAt: resolvedAt,
         refundAmount: refundAmount,
         refundIssued: refundIssued,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Dispute]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Dispute copyWith({
    Object? id = _Undefined,
    int? orderId,
    int? openedByUserId,
    int? clientId,
    int? driverId,
    Object? disputeType = _Undefined,
    String? title,
    String? description,
    Object? evidenceUrls = _Undefined,
    Object? status = _Undefined,
    Object? resolution = _Undefined,
    Object? resolvedByAdminId = _Undefined,
    Object? resolvedAt = _Undefined,
    Object? refundAmount = _Undefined,
    bool? refundIssued,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Dispute(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      openedByUserId: openedByUserId ?? this.openedByUserId,
      clientId: clientId ?? this.clientId,
      driverId: driverId ?? this.driverId,
      disputeType: disputeType is _i2.DisputeType?
          ? disputeType
          : this.disputeType,
      title: title ?? this.title,
      description: description ?? this.description,
      evidenceUrls: evidenceUrls is List<String>?
          ? evidenceUrls
          : this.evidenceUrls?.map((e0) => e0).toList(),
      status: status is _i3.DisputeStatus? ? status : this.status,
      resolution: resolution is String? ? resolution : this.resolution,
      resolvedByAdminId: resolvedByAdminId is int?
          ? resolvedByAdminId
          : this.resolvedByAdminId,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
      refundAmount: refundAmount is double? ? refundAmount : this.refundAmount,
      refundIssued: refundIssued ?? this.refundIssued,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
