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

abstract class StoreDeliveryRequest implements _i1.SerializableModel {
  StoreDeliveryRequest._({
    this.id,
    required this.storeOrderId,
    required this.storeId,
    required this.requestType,
    this.targetDriverId,
    required this.pickupAddress,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.deliveryAddress,
    required this.deliveryLatitude,
    required this.deliveryLongitude,
    this.distanceKm,
    required this.deliveryFee,
    required this.driverEarnings,
    String? status,
    this.assignedDriverId,
    this.expiresAt,
    DateTime? createdAt,
    this.acceptedAt,
    this.rejectedAt,
  }) : status = status ?? 'pending',
       createdAt = createdAt ?? DateTime.now();

  factory StoreDeliveryRequest({
    int? id,
    required int storeOrderId,
    required int storeId,
    required String requestType,
    int? targetDriverId,
    required String pickupAddress,
    required double pickupLatitude,
    required double pickupLongitude,
    required String deliveryAddress,
    required double deliveryLatitude,
    required double deliveryLongitude,
    double? distanceKm,
    required double deliveryFee,
    required double driverEarnings,
    String? status,
    int? assignedDriverId,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? rejectedAt,
  }) = _StoreDeliveryRequestImpl;

  factory StoreDeliveryRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return StoreDeliveryRequest(
      id: jsonSerialization['id'] as int?,
      storeOrderId: jsonSerialization['storeOrderId'] as int,
      storeId: jsonSerialization['storeId'] as int,
      requestType: jsonSerialization['requestType'] as String,
      targetDriverId: jsonSerialization['targetDriverId'] as int?,
      pickupAddress: jsonSerialization['pickupAddress'] as String,
      pickupLatitude: (jsonSerialization['pickupLatitude'] as num).toDouble(),
      pickupLongitude: (jsonSerialization['pickupLongitude'] as num).toDouble(),
      deliveryAddress: jsonSerialization['deliveryAddress'] as String,
      deliveryLatitude: (jsonSerialization['deliveryLatitude'] as num)
          .toDouble(),
      deliveryLongitude: (jsonSerialization['deliveryLongitude'] as num)
          .toDouble(),
      distanceKm: (jsonSerialization['distanceKm'] as num?)?.toDouble(),
      deliveryFee: (jsonSerialization['deliveryFee'] as num).toDouble(),
      driverEarnings: (jsonSerialization['driverEarnings'] as num).toDouble(),
      status: jsonSerialization['status'] as String,
      assignedDriverId: jsonSerialization['assignedDriverId'] as int?,
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
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

  int storeOrderId;

  int storeId;

  String requestType;

  int? targetDriverId;

  String pickupAddress;

  double pickupLatitude;

  double pickupLongitude;

  String deliveryAddress;

  double deliveryLatitude;

  double deliveryLongitude;

  double? distanceKm;

  double deliveryFee;

  double driverEarnings;

  String status;

  int? assignedDriverId;

  DateTime? expiresAt;

  DateTime createdAt;

  DateTime? acceptedAt;

  DateTime? rejectedAt;

  /// Returns a shallow copy of this [StoreDeliveryRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreDeliveryRequest copyWith({
    int? id,
    int? storeOrderId,
    int? storeId,
    String? requestType,
    int? targetDriverId,
    String? pickupAddress,
    double? pickupLatitude,
    double? pickupLongitude,
    String? deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
    double? distanceKm,
    double? deliveryFee,
    double? driverEarnings,
    String? status,
    int? assignedDriverId,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? rejectedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreDeliveryRequest',
      if (id != null) 'id': id,
      'storeOrderId': storeOrderId,
      'storeId': storeId,
      'requestType': requestType,
      if (targetDriverId != null) 'targetDriverId': targetDriverId,
      'pickupAddress': pickupAddress,
      'pickupLatitude': pickupLatitude,
      'pickupLongitude': pickupLongitude,
      'deliveryAddress': deliveryAddress,
      'deliveryLatitude': deliveryLatitude,
      'deliveryLongitude': deliveryLongitude,
      if (distanceKm != null) 'distanceKm': distanceKm,
      'deliveryFee': deliveryFee,
      'driverEarnings': driverEarnings,
      'status': status,
      if (assignedDriverId != null) 'assignedDriverId': assignedDriverId,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
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

class _StoreDeliveryRequestImpl extends StoreDeliveryRequest {
  _StoreDeliveryRequestImpl({
    int? id,
    required int storeOrderId,
    required int storeId,
    required String requestType,
    int? targetDriverId,
    required String pickupAddress,
    required double pickupLatitude,
    required double pickupLongitude,
    required String deliveryAddress,
    required double deliveryLatitude,
    required double deliveryLongitude,
    double? distanceKm,
    required double deliveryFee,
    required double driverEarnings,
    String? status,
    int? assignedDriverId,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? rejectedAt,
  }) : super._(
         id: id,
         storeOrderId: storeOrderId,
         storeId: storeId,
         requestType: requestType,
         targetDriverId: targetDriverId,
         pickupAddress: pickupAddress,
         pickupLatitude: pickupLatitude,
         pickupLongitude: pickupLongitude,
         deliveryAddress: deliveryAddress,
         deliveryLatitude: deliveryLatitude,
         deliveryLongitude: deliveryLongitude,
         distanceKm: distanceKm,
         deliveryFee: deliveryFee,
         driverEarnings: driverEarnings,
         status: status,
         assignedDriverId: assignedDriverId,
         expiresAt: expiresAt,
         createdAt: createdAt,
         acceptedAt: acceptedAt,
         rejectedAt: rejectedAt,
       );

  /// Returns a shallow copy of this [StoreDeliveryRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreDeliveryRequest copyWith({
    Object? id = _Undefined,
    int? storeOrderId,
    int? storeId,
    String? requestType,
    Object? targetDriverId = _Undefined,
    String? pickupAddress,
    double? pickupLatitude,
    double? pickupLongitude,
    String? deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
    Object? distanceKm = _Undefined,
    double? deliveryFee,
    double? driverEarnings,
    String? status,
    Object? assignedDriverId = _Undefined,
    Object? expiresAt = _Undefined,
    DateTime? createdAt,
    Object? acceptedAt = _Undefined,
    Object? rejectedAt = _Undefined,
  }) {
    return StoreDeliveryRequest(
      id: id is int? ? id : this.id,
      storeOrderId: storeOrderId ?? this.storeOrderId,
      storeId: storeId ?? this.storeId,
      requestType: requestType ?? this.requestType,
      targetDriverId: targetDriverId is int?
          ? targetDriverId
          : this.targetDriverId,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      pickupLatitude: pickupLatitude ?? this.pickupLatitude,
      pickupLongitude: pickupLongitude ?? this.pickupLongitude,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryLatitude: deliveryLatitude ?? this.deliveryLatitude,
      deliveryLongitude: deliveryLongitude ?? this.deliveryLongitude,
      distanceKm: distanceKm is double? ? distanceKm : this.distanceKm,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      driverEarnings: driverEarnings ?? this.driverEarnings,
      status: status ?? this.status,
      assignedDriverId: assignedDriverId is int?
          ? assignedDriverId
          : this.assignedDriverId,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      acceptedAt: acceptedAt is DateTime? ? acceptedAt : this.acceptedAt,
      rejectedAt: rejectedAt is DateTime? ? rejectedAt : this.rejectedAt,
    );
  }
}
