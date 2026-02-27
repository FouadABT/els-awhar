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
import 'proposal_status.dart' as _i2;

abstract class DriverProposal implements _i1.SerializableModel {
  DriverProposal._({
    this.id,
    required this.requestId,
    required this.driverId,
    this.proposedPrice,
    required this.estimatedArrival,
    this.message,
    required this.driverName,
    this.driverPhone,
    double? driverRating,
    this.driverVehicleInfo,
    _i2.ProposalStatus? status,
    DateTime? createdAt,
    this.acceptedAt,
    this.rejectedAt,
  }) : driverRating = driverRating ?? 0.0,
       status = status ?? _i2.ProposalStatus.pending,
       createdAt = createdAt ?? DateTime.now();

  factory DriverProposal({
    int? id,
    required int requestId,
    required int driverId,
    double? proposedPrice,
    required int estimatedArrival,
    String? message,
    required String driverName,
    String? driverPhone,
    double? driverRating,
    String? driverVehicleInfo,
    _i2.ProposalStatus? status,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? rejectedAt,
  }) = _DriverProposalImpl;

  factory DriverProposal.fromJson(Map<String, dynamic> jsonSerialization) {
    return DriverProposal(
      id: jsonSerialization['id'] as int?,
      requestId: jsonSerialization['requestId'] as int,
      driverId: jsonSerialization['driverId'] as int,
      proposedPrice: (jsonSerialization['proposedPrice'] as num?)?.toDouble(),
      estimatedArrival: jsonSerialization['estimatedArrival'] as int,
      message: jsonSerialization['message'] as String?,
      driverName: jsonSerialization['driverName'] as String,
      driverPhone: jsonSerialization['driverPhone'] as String?,
      driverRating: (jsonSerialization['driverRating'] as num?)?.toDouble(),
      driverVehicleInfo: jsonSerialization['driverVehicleInfo'] as String?,
      status: _i2.ProposalStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      acceptedAt: jsonSerialization['acceptedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['acceptedAt']),
      rejectedAt: jsonSerialization['rejectedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['rejectedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int requestId;

  int driverId;

  double? proposedPrice;

  int estimatedArrival;

  String? message;

  String driverName;

  String? driverPhone;

  double? driverRating;

  String? driverVehicleInfo;

  _i2.ProposalStatus status;

  DateTime createdAt;

  DateTime? acceptedAt;

  DateTime? rejectedAt;

  /// Returns a shallow copy of this [DriverProposal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DriverProposal copyWith({
    int? id,
    int? requestId,
    int? driverId,
    double? proposedPrice,
    int? estimatedArrival,
    String? message,
    String? driverName,
    String? driverPhone,
    double? driverRating,
    String? driverVehicleInfo,
    _i2.ProposalStatus? status,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? rejectedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DriverProposal',
      if (id != null) 'id': id,
      'requestId': requestId,
      'driverId': driverId,
      if (proposedPrice != null) 'proposedPrice': proposedPrice,
      'estimatedArrival': estimatedArrival,
      if (message != null) 'message': message,
      'driverName': driverName,
      if (driverPhone != null) 'driverPhone': driverPhone,
      if (driverRating != null) 'driverRating': driverRating,
      if (driverVehicleInfo != null) 'driverVehicleInfo': driverVehicleInfo,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
      if (rejectedAt != null) 'rejectedAt': rejectedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DriverProposalImpl extends DriverProposal {
  _DriverProposalImpl({
    int? id,
    required int requestId,
    required int driverId,
    double? proposedPrice,
    required int estimatedArrival,
    String? message,
    required String driverName,
    String? driverPhone,
    double? driverRating,
    String? driverVehicleInfo,
    _i2.ProposalStatus? status,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? rejectedAt,
  }) : super._(
         id: id,
         requestId: requestId,
         driverId: driverId,
         proposedPrice: proposedPrice,
         estimatedArrival: estimatedArrival,
         message: message,
         driverName: driverName,
         driverPhone: driverPhone,
         driverRating: driverRating,
         driverVehicleInfo: driverVehicleInfo,
         status: status,
         createdAt: createdAt,
         acceptedAt: acceptedAt,
         rejectedAt: rejectedAt,
       );

  /// Returns a shallow copy of this [DriverProposal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DriverProposal copyWith({
    Object? id = _Undefined,
    int? requestId,
    int? driverId,
    Object? proposedPrice = _Undefined,
    int? estimatedArrival,
    Object? message = _Undefined,
    String? driverName,
    Object? driverPhone = _Undefined,
    Object? driverRating = _Undefined,
    Object? driverVehicleInfo = _Undefined,
    _i2.ProposalStatus? status,
    DateTime? createdAt,
    Object? acceptedAt = _Undefined,
    Object? rejectedAt = _Undefined,
  }) {
    return DriverProposal(
      id: id is int? ? id : this.id,
      requestId: requestId ?? this.requestId,
      driverId: driverId ?? this.driverId,
      proposedPrice: proposedPrice is double?
          ? proposedPrice
          : this.proposedPrice,
      estimatedArrival: estimatedArrival ?? this.estimatedArrival,
      message: message is String? ? message : this.message,
      driverName: driverName ?? this.driverName,
      driverPhone: driverPhone is String? ? driverPhone : this.driverPhone,
      driverRating: driverRating is double? ? driverRating : this.driverRating,
      driverVehicleInfo: driverVehicleInfo is String?
          ? driverVehicleInfo
          : this.driverVehicleInfo,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      acceptedAt: acceptedAt is DateTime? ? acceptedAt : this.acceptedAt,
      rejectedAt: rejectedAt is DateTime? ? rejectedAt : this.rejectedAt,
    );
  }
}
