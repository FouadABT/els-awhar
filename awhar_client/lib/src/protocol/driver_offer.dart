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
import 'offer_status_enum.dart' as _i2;

abstract class DriverOffer implements _i1.SerializableModel {
  DriverOffer._({
    this.id,
    required this.orderId,
    required this.driverId,
    required this.offeredPrice,
    this.message,
    this.status,
    DateTime? createdAt,
    this.respondedAt,
    this.expiresAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory DriverOffer({
    int? id,
    required int orderId,
    required int driverId,
    required double offeredPrice,
    String? message,
    _i2.OfferStatus? status,
    DateTime? createdAt,
    DateTime? respondedAt,
    DateTime? expiresAt,
  }) = _DriverOfferImpl;

  factory DriverOffer.fromJson(Map<String, dynamic> jsonSerialization) {
    return DriverOffer(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      driverId: jsonSerialization['driverId'] as int,
      offeredPrice: (jsonSerialization['offeredPrice'] as num).toDouble(),
      message: jsonSerialization['message'] as String?,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.OfferStatus.fromJson((jsonSerialization['status'] as int)),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      respondedAt: jsonSerialization['respondedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['respondedAt'],
            ),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int orderId;

  int driverId;

  double offeredPrice;

  String? message;

  _i2.OfferStatus? status;

  DateTime createdAt;

  DateTime? respondedAt;

  DateTime? expiresAt;

  /// Returns a shallow copy of this [DriverOffer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DriverOffer copyWith({
    int? id,
    int? orderId,
    int? driverId,
    double? offeredPrice,
    String? message,
    _i2.OfferStatus? status,
    DateTime? createdAt,
    DateTime? respondedAt,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DriverOffer',
      if (id != null) 'id': id,
      'orderId': orderId,
      'driverId': driverId,
      'offeredPrice': offeredPrice,
      if (message != null) 'message': message,
      if (status != null) 'status': status?.toJson(),
      'createdAt': createdAt.toJson(),
      if (respondedAt != null) 'respondedAt': respondedAt?.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DriverOfferImpl extends DriverOffer {
  _DriverOfferImpl({
    int? id,
    required int orderId,
    required int driverId,
    required double offeredPrice,
    String? message,
    _i2.OfferStatus? status,
    DateTime? createdAt,
    DateTime? respondedAt,
    DateTime? expiresAt,
  }) : super._(
         id: id,
         orderId: orderId,
         driverId: driverId,
         offeredPrice: offeredPrice,
         message: message,
         status: status,
         createdAt: createdAt,
         respondedAt: respondedAt,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [DriverOffer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DriverOffer copyWith({
    Object? id = _Undefined,
    int? orderId,
    int? driverId,
    double? offeredPrice,
    Object? message = _Undefined,
    Object? status = _Undefined,
    DateTime? createdAt,
    Object? respondedAt = _Undefined,
    Object? expiresAt = _Undefined,
  }) {
    return DriverOffer(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      driverId: driverId ?? this.driverId,
      offeredPrice: offeredPrice ?? this.offeredPrice,
      message: message is String? ? message : this.message,
      status: status is _i2.OfferStatus? ? status : this.status,
      createdAt: createdAt ?? this.createdAt,
      respondedAt: respondedAt is DateTime? ? respondedAt : this.respondedAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
    );
  }
}
