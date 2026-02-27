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
import 'price_negotiation_status_enum.dart' as _i2;
import 'order_status_enum.dart' as _i3;
import 'canceller_type_enum.dart' as _i4;

abstract class Order implements _i1.SerializableModel {
  Order._({
    this.id,
    required this.clientId,
    this.driverId,
    required this.serviceId,
    this.pickupAddressId,
    this.dropoffAddressId,
    this.pickupLatitude,
    this.pickupLongitude,
    this.pickupAddress,
    this.dropoffLatitude,
    this.dropoffLongitude,
    this.dropoffAddress,
    this.estimatedDistanceKm,
    this.estimatedPrice,
    this.agreedPrice,
    this.finalPrice,
    String? currency,
    String? currencySymbol,
    this.clientProposedPrice,
    this.driverCounterPrice,
    this.priceNegotiationStatus,
    this.notes,
    this.clientInstructions,
    this.expiresAt,
    this.status,
    DateTime? createdAt,
    this.acceptedAt,
    this.startedAt,
    this.completedAt,
    this.cancelledAt,
    this.cancellationReason,
    this.cancelledByUserId,
    this.cancelledBy,
  }) : currency = currency ?? 'MAD',
       currencySymbol = currencySymbol ?? 'DH',
       createdAt = createdAt ?? DateTime.now();

  factory Order({
    int? id,
    required int clientId,
    int? driverId,
    required int serviceId,
    int? pickupAddressId,
    int? dropoffAddressId,
    double? pickupLatitude,
    double? pickupLongitude,
    String? pickupAddress,
    double? dropoffLatitude,
    double? dropoffLongitude,
    String? dropoffAddress,
    double? estimatedDistanceKm,
    double? estimatedPrice,
    double? agreedPrice,
    double? finalPrice,
    String? currency,
    String? currencySymbol,
    double? clientProposedPrice,
    double? driverCounterPrice,
    _i2.PriceNegotiationStatus? priceNegotiationStatus,
    String? notes,
    String? clientInstructions,
    DateTime? expiresAt,
    _i3.OrderStatus? status,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
    String? cancellationReason,
    int? cancelledByUserId,
    _i4.CancellerType? cancelledBy,
  }) = _OrderImpl;

  factory Order.fromJson(Map<String, dynamic> jsonSerialization) {
    return Order(
      id: jsonSerialization['id'] as int?,
      clientId: jsonSerialization['clientId'] as int,
      driverId: jsonSerialization['driverId'] as int?,
      serviceId: jsonSerialization['serviceId'] as int,
      pickupAddressId: jsonSerialization['pickupAddressId'] as int?,
      dropoffAddressId: jsonSerialization['dropoffAddressId'] as int?,
      pickupLatitude: (jsonSerialization['pickupLatitude'] as num?)?.toDouble(),
      pickupLongitude: (jsonSerialization['pickupLongitude'] as num?)
          ?.toDouble(),
      pickupAddress: jsonSerialization['pickupAddress'] as String?,
      dropoffLatitude: (jsonSerialization['dropoffLatitude'] as num?)
          ?.toDouble(),
      dropoffLongitude: (jsonSerialization['dropoffLongitude'] as num?)
          ?.toDouble(),
      dropoffAddress: jsonSerialization['dropoffAddress'] as String?,
      estimatedDistanceKm: (jsonSerialization['estimatedDistanceKm'] as num?)
          ?.toDouble(),
      estimatedPrice: (jsonSerialization['estimatedPrice'] as num?)?.toDouble(),
      agreedPrice: (jsonSerialization['agreedPrice'] as num?)?.toDouble(),
      finalPrice: (jsonSerialization['finalPrice'] as num?)?.toDouble(),
      currency: jsonSerialization['currency'] as String,
      currencySymbol: jsonSerialization['currencySymbol'] as String,
      clientProposedPrice: (jsonSerialization['clientProposedPrice'] as num?)
          ?.toDouble(),
      driverCounterPrice: (jsonSerialization['driverCounterPrice'] as num?)
          ?.toDouble(),
      priceNegotiationStatus:
          jsonSerialization['priceNegotiationStatus'] == null
          ? null
          : _i2.PriceNegotiationStatus.fromJson(
              (jsonSerialization['priceNegotiationStatus'] as int),
            ),
      notes: jsonSerialization['notes'] as String?,
      clientInstructions: jsonSerialization['clientInstructions'] as String?,
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      status: jsonSerialization['status'] == null
          ? null
          : _i3.OrderStatus.fromJson((jsonSerialization['status'] as int)),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      acceptedAt: jsonSerialization['acceptedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['acceptedAt']),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      cancelledAt: jsonSerialization['cancelledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['cancelledAt'],
            ),
      cancellationReason: jsonSerialization['cancellationReason'] as String?,
      cancelledByUserId: jsonSerialization['cancelledByUserId'] as int?,
      cancelledBy: jsonSerialization['cancelledBy'] == null
          ? null
          : _i4.CancellerType.fromJson(
              (jsonSerialization['cancelledBy'] as int),
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int clientId;

  int? driverId;

  int serviceId;

  int? pickupAddressId;

  int? dropoffAddressId;

  double? pickupLatitude;

  double? pickupLongitude;

  String? pickupAddress;

  double? dropoffLatitude;

  double? dropoffLongitude;

  String? dropoffAddress;

  double? estimatedDistanceKm;

  double? estimatedPrice;

  double? agreedPrice;

  double? finalPrice;

  String currency;

  String currencySymbol;

  double? clientProposedPrice;

  double? driverCounterPrice;

  _i2.PriceNegotiationStatus? priceNegotiationStatus;

  String? notes;

  String? clientInstructions;

  DateTime? expiresAt;

  _i3.OrderStatus? status;

  DateTime createdAt;

  DateTime? acceptedAt;

  DateTime? startedAt;

  DateTime? completedAt;

  DateTime? cancelledAt;

  String? cancellationReason;

  int? cancelledByUserId;

  _i4.CancellerType? cancelledBy;

  /// Returns a shallow copy of this [Order]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Order copyWith({
    int? id,
    int? clientId,
    int? driverId,
    int? serviceId,
    int? pickupAddressId,
    int? dropoffAddressId,
    double? pickupLatitude,
    double? pickupLongitude,
    String? pickupAddress,
    double? dropoffLatitude,
    double? dropoffLongitude,
    String? dropoffAddress,
    double? estimatedDistanceKm,
    double? estimatedPrice,
    double? agreedPrice,
    double? finalPrice,
    String? currency,
    String? currencySymbol,
    double? clientProposedPrice,
    double? driverCounterPrice,
    _i2.PriceNegotiationStatus? priceNegotiationStatus,
    String? notes,
    String? clientInstructions,
    DateTime? expiresAt,
    _i3.OrderStatus? status,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
    String? cancellationReason,
    int? cancelledByUserId,
    _i4.CancellerType? cancelledBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Order',
      if (id != null) 'id': id,
      'clientId': clientId,
      if (driverId != null) 'driverId': driverId,
      'serviceId': serviceId,
      if (pickupAddressId != null) 'pickupAddressId': pickupAddressId,
      if (dropoffAddressId != null) 'dropoffAddressId': dropoffAddressId,
      if (pickupLatitude != null) 'pickupLatitude': pickupLatitude,
      if (pickupLongitude != null) 'pickupLongitude': pickupLongitude,
      if (pickupAddress != null) 'pickupAddress': pickupAddress,
      if (dropoffLatitude != null) 'dropoffLatitude': dropoffLatitude,
      if (dropoffLongitude != null) 'dropoffLongitude': dropoffLongitude,
      if (dropoffAddress != null) 'dropoffAddress': dropoffAddress,
      if (estimatedDistanceKm != null)
        'estimatedDistanceKm': estimatedDistanceKm,
      if (estimatedPrice != null) 'estimatedPrice': estimatedPrice,
      if (agreedPrice != null) 'agreedPrice': agreedPrice,
      if (finalPrice != null) 'finalPrice': finalPrice,
      'currency': currency,
      'currencySymbol': currencySymbol,
      if (clientProposedPrice != null)
        'clientProposedPrice': clientProposedPrice,
      if (driverCounterPrice != null) 'driverCounterPrice': driverCounterPrice,
      if (priceNegotiationStatus != null)
        'priceNegotiationStatus': priceNegotiationStatus?.toJson(),
      if (notes != null) 'notes': notes,
      if (clientInstructions != null) 'clientInstructions': clientInstructions,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      if (status != null) 'status': status?.toJson(),
      'createdAt': createdAt.toJson(),
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
      if (cancellationReason != null) 'cancellationReason': cancellationReason,
      if (cancelledByUserId != null) 'cancelledByUserId': cancelledByUserId,
      if (cancelledBy != null) 'cancelledBy': cancelledBy?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderImpl extends Order {
  _OrderImpl({
    int? id,
    required int clientId,
    int? driverId,
    required int serviceId,
    int? pickupAddressId,
    int? dropoffAddressId,
    double? pickupLatitude,
    double? pickupLongitude,
    String? pickupAddress,
    double? dropoffLatitude,
    double? dropoffLongitude,
    String? dropoffAddress,
    double? estimatedDistanceKm,
    double? estimatedPrice,
    double? agreedPrice,
    double? finalPrice,
    String? currency,
    String? currencySymbol,
    double? clientProposedPrice,
    double? driverCounterPrice,
    _i2.PriceNegotiationStatus? priceNegotiationStatus,
    String? notes,
    String? clientInstructions,
    DateTime? expiresAt,
    _i3.OrderStatus? status,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
    String? cancellationReason,
    int? cancelledByUserId,
    _i4.CancellerType? cancelledBy,
  }) : super._(
         id: id,
         clientId: clientId,
         driverId: driverId,
         serviceId: serviceId,
         pickupAddressId: pickupAddressId,
         dropoffAddressId: dropoffAddressId,
         pickupLatitude: pickupLatitude,
         pickupLongitude: pickupLongitude,
         pickupAddress: pickupAddress,
         dropoffLatitude: dropoffLatitude,
         dropoffLongitude: dropoffLongitude,
         dropoffAddress: dropoffAddress,
         estimatedDistanceKm: estimatedDistanceKm,
         estimatedPrice: estimatedPrice,
         agreedPrice: agreedPrice,
         finalPrice: finalPrice,
         currency: currency,
         currencySymbol: currencySymbol,
         clientProposedPrice: clientProposedPrice,
         driverCounterPrice: driverCounterPrice,
         priceNegotiationStatus: priceNegotiationStatus,
         notes: notes,
         clientInstructions: clientInstructions,
         expiresAt: expiresAt,
         status: status,
         createdAt: createdAt,
         acceptedAt: acceptedAt,
         startedAt: startedAt,
         completedAt: completedAt,
         cancelledAt: cancelledAt,
         cancellationReason: cancellationReason,
         cancelledByUserId: cancelledByUserId,
         cancelledBy: cancelledBy,
       );

  /// Returns a shallow copy of this [Order]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Order copyWith({
    Object? id = _Undefined,
    int? clientId,
    Object? driverId = _Undefined,
    int? serviceId,
    Object? pickupAddressId = _Undefined,
    Object? dropoffAddressId = _Undefined,
    Object? pickupLatitude = _Undefined,
    Object? pickupLongitude = _Undefined,
    Object? pickupAddress = _Undefined,
    Object? dropoffLatitude = _Undefined,
    Object? dropoffLongitude = _Undefined,
    Object? dropoffAddress = _Undefined,
    Object? estimatedDistanceKm = _Undefined,
    Object? estimatedPrice = _Undefined,
    Object? agreedPrice = _Undefined,
    Object? finalPrice = _Undefined,
    String? currency,
    String? currencySymbol,
    Object? clientProposedPrice = _Undefined,
    Object? driverCounterPrice = _Undefined,
    Object? priceNegotiationStatus = _Undefined,
    Object? notes = _Undefined,
    Object? clientInstructions = _Undefined,
    Object? expiresAt = _Undefined,
    Object? status = _Undefined,
    DateTime? createdAt,
    Object? acceptedAt = _Undefined,
    Object? startedAt = _Undefined,
    Object? completedAt = _Undefined,
    Object? cancelledAt = _Undefined,
    Object? cancellationReason = _Undefined,
    Object? cancelledByUserId = _Undefined,
    Object? cancelledBy = _Undefined,
  }) {
    return Order(
      id: id is int? ? id : this.id,
      clientId: clientId ?? this.clientId,
      driverId: driverId is int? ? driverId : this.driverId,
      serviceId: serviceId ?? this.serviceId,
      pickupAddressId: pickupAddressId is int?
          ? pickupAddressId
          : this.pickupAddressId,
      dropoffAddressId: dropoffAddressId is int?
          ? dropoffAddressId
          : this.dropoffAddressId,
      pickupLatitude: pickupLatitude is double?
          ? pickupLatitude
          : this.pickupLatitude,
      pickupLongitude: pickupLongitude is double?
          ? pickupLongitude
          : this.pickupLongitude,
      pickupAddress: pickupAddress is String?
          ? pickupAddress
          : this.pickupAddress,
      dropoffLatitude: dropoffLatitude is double?
          ? dropoffLatitude
          : this.dropoffLatitude,
      dropoffLongitude: dropoffLongitude is double?
          ? dropoffLongitude
          : this.dropoffLongitude,
      dropoffAddress: dropoffAddress is String?
          ? dropoffAddress
          : this.dropoffAddress,
      estimatedDistanceKm: estimatedDistanceKm is double?
          ? estimatedDistanceKm
          : this.estimatedDistanceKm,
      estimatedPrice: estimatedPrice is double?
          ? estimatedPrice
          : this.estimatedPrice,
      agreedPrice: agreedPrice is double? ? agreedPrice : this.agreedPrice,
      finalPrice: finalPrice is double? ? finalPrice : this.finalPrice,
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      clientProposedPrice: clientProposedPrice is double?
          ? clientProposedPrice
          : this.clientProposedPrice,
      driverCounterPrice: driverCounterPrice is double?
          ? driverCounterPrice
          : this.driverCounterPrice,
      priceNegotiationStatus:
          priceNegotiationStatus is _i2.PriceNegotiationStatus?
          ? priceNegotiationStatus
          : this.priceNegotiationStatus,
      notes: notes is String? ? notes : this.notes,
      clientInstructions: clientInstructions is String?
          ? clientInstructions
          : this.clientInstructions,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      status: status is _i3.OrderStatus? ? status : this.status,
      createdAt: createdAt ?? this.createdAt,
      acceptedAt: acceptedAt is DateTime? ? acceptedAt : this.acceptedAt,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      cancelledAt: cancelledAt is DateTime? ? cancelledAt : this.cancelledAt,
      cancellationReason: cancellationReason is String?
          ? cancellationReason
          : this.cancellationReason,
      cancelledByUserId: cancelledByUserId is int?
          ? cancelledByUserId
          : this.cancelledByUserId,
      cancelledBy: cancelledBy is _i4.CancellerType?
          ? cancelledBy
          : this.cancelledBy,
    );
  }
}
