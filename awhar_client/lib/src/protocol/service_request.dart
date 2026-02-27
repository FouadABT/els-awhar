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
import 'request_status.dart' as _i2;
import 'price_negotiation_status_enum.dart' as _i3;
import 'service_type.dart' as _i4;
import 'location.dart' as _i5;
import 'shopping_item.dart' as _i6;
import 'package:awhar_client/src/protocol/protocol.dart' as _i7;

abstract class ServiceRequest implements _i1.SerializableModel {
  ServiceRequest._({
    this.id,
    required this.clientId,
    this.driverId,
    this.proposedDriverId,
    required this.serviceType,
    _i2.RequestStatus? status,
    this.pickupLocation,
    required this.destinationLocation,
    required this.basePrice,
    required this.distancePrice,
    required this.totalPrice,
    this.estimatedPurchaseCost,
    this.deliveryFee,
    this.distance,
    this.estimatedDuration,
    String? currency,
    String? currencySymbol,
    this.clientOfferedPrice,
    this.driverCounterPrice,
    this.agreedPrice,
    _i3.PriceNegotiationStatus? negotiationStatus,
    bool? isPaid,
    this.itemDescription,
    this.recipientName,
    this.recipientPhone,
    this.specialInstructions,
    this.packageSize,
    bool? isFragile,
    bool? isPurchaseRequired,
    this.shoppingList,
    this.attachments,
    this.catalogServiceId,
    this.catalogDriverId,
    this.notes,
    required this.clientName,
    this.clientPhone,
    this.driverName,
    this.driverPhone,
    this.proposedDriverName,
    this.proposedDriverPhone,
    this.cancelledBy,
    this.cancellationReason,
    this.deviceFingerprint,
    DateTime? createdAt,
    this.acceptedAt,
    this.driverArrivingAt,
    this.startedAt,
    this.completedAt,
    this.cancelledAt,
  }) : status = status ?? _i2.RequestStatus.pending,
       currency = currency ?? 'MAD',
       currencySymbol = currencySymbol ?? 'DH',
       negotiationStatus =
           negotiationStatus ?? _i3.PriceNegotiationStatus.waiting_for_offers,
       isPaid = isPaid ?? false,
       isFragile = isFragile ?? false,
       isPurchaseRequired = isPurchaseRequired ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory ServiceRequest({
    int? id,
    required int clientId,
    int? driverId,
    int? proposedDriverId,
    required _i4.ServiceType serviceType,
    _i2.RequestStatus? status,
    _i5.Location? pickupLocation,
    required _i5.Location destinationLocation,
    required double basePrice,
    required double distancePrice,
    required double totalPrice,
    double? estimatedPurchaseCost,
    double? deliveryFee,
    double? distance,
    int? estimatedDuration,
    String? currency,
    String? currencySymbol,
    double? clientOfferedPrice,
    double? driverCounterPrice,
    double? agreedPrice,
    _i3.PriceNegotiationStatus? negotiationStatus,
    bool? isPaid,
    String? itemDescription,
    String? recipientName,
    String? recipientPhone,
    String? specialInstructions,
    String? packageSize,
    bool? isFragile,
    bool? isPurchaseRequired,
    List<_i6.ShoppingItem>? shoppingList,
    List<String>? attachments,
    int? catalogServiceId,
    int? catalogDriverId,
    String? notes,
    required String clientName,
    String? clientPhone,
    String? driverName,
    String? driverPhone,
    String? proposedDriverName,
    String? proposedDriverPhone,
    int? cancelledBy,
    String? cancellationReason,
    String? deviceFingerprint,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? driverArrivingAt,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
  }) = _ServiceRequestImpl;

  factory ServiceRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return ServiceRequest(
      id: jsonSerialization['id'] as int?,
      clientId: jsonSerialization['clientId'] as int,
      driverId: jsonSerialization['driverId'] as int?,
      proposedDriverId: jsonSerialization['proposedDriverId'] as int?,
      serviceType: _i4.ServiceType.fromJson(
        (jsonSerialization['serviceType'] as String),
      ),
      status: _i2.RequestStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      pickupLocation: jsonSerialization['pickupLocation'] == null
          ? null
          : _i7.Protocol().deserialize<_i5.Location>(
              jsonSerialization['pickupLocation'],
            ),
      destinationLocation: _i7.Protocol().deserialize<_i5.Location>(
        jsonSerialization['destinationLocation'],
      ),
      basePrice: (jsonSerialization['basePrice'] as num).toDouble(),
      distancePrice: (jsonSerialization['distancePrice'] as num).toDouble(),
      totalPrice: (jsonSerialization['totalPrice'] as num).toDouble(),
      estimatedPurchaseCost:
          (jsonSerialization['estimatedPurchaseCost'] as num?)?.toDouble(),
      deliveryFee: (jsonSerialization['deliveryFee'] as num?)?.toDouble(),
      distance: (jsonSerialization['distance'] as num?)?.toDouble(),
      estimatedDuration: jsonSerialization['estimatedDuration'] as int?,
      currency: jsonSerialization['currency'] as String,
      currencySymbol: jsonSerialization['currencySymbol'] as String,
      clientOfferedPrice: (jsonSerialization['clientOfferedPrice'] as num?)
          ?.toDouble(),
      driverCounterPrice: (jsonSerialization['driverCounterPrice'] as num?)
          ?.toDouble(),
      agreedPrice: (jsonSerialization['agreedPrice'] as num?)?.toDouble(),
      negotiationStatus: jsonSerialization['negotiationStatus'] == null
          ? null
          : _i3.PriceNegotiationStatus.fromJson(
              (jsonSerialization['negotiationStatus'] as int),
            ),
      isPaid: jsonSerialization['isPaid'] as bool,
      itemDescription: jsonSerialization['itemDescription'] as String?,
      recipientName: jsonSerialization['recipientName'] as String?,
      recipientPhone: jsonSerialization['recipientPhone'] as String?,
      specialInstructions: jsonSerialization['specialInstructions'] as String?,
      packageSize: jsonSerialization['packageSize'] as String?,
      isFragile: jsonSerialization['isFragile'] as bool,
      isPurchaseRequired: jsonSerialization['isPurchaseRequired'] as bool,
      shoppingList: jsonSerialization['shoppingList'] == null
          ? null
          : _i7.Protocol().deserialize<List<_i6.ShoppingItem>>(
              jsonSerialization['shoppingList'],
            ),
      attachments: jsonSerialization['attachments'] == null
          ? null
          : _i7.Protocol().deserialize<List<String>>(
              jsonSerialization['attachments'],
            ),
      catalogServiceId: jsonSerialization['catalogServiceId'] as int?,
      catalogDriverId: jsonSerialization['catalogDriverId'] as int?,
      notes: jsonSerialization['notes'] as String?,
      clientName: jsonSerialization['clientName'] as String,
      clientPhone: jsonSerialization['clientPhone'] as String?,
      driverName: jsonSerialization['driverName'] as String?,
      driverPhone: jsonSerialization['driverPhone'] as String?,
      proposedDriverName: jsonSerialization['proposedDriverName'] as String?,
      proposedDriverPhone: jsonSerialization['proposedDriverPhone'] as String?,
      cancelledBy: jsonSerialization['cancelledBy'] as int?,
      cancellationReason: jsonSerialization['cancellationReason'] as String?,
      deviceFingerprint: jsonSerialization['deviceFingerprint'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      acceptedAt: jsonSerialization['acceptedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['acceptedAt']),
      driverArrivingAt: jsonSerialization['driverArrivingAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['driverArrivingAt'],
            ),
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
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int clientId;

  int? driverId;

  int? proposedDriverId;

  _i4.ServiceType serviceType;

  _i2.RequestStatus status;

  _i5.Location? pickupLocation;

  _i5.Location destinationLocation;

  double basePrice;

  double distancePrice;

  double totalPrice;

  double? estimatedPurchaseCost;

  double? deliveryFee;

  double? distance;

  int? estimatedDuration;

  String currency;

  String currencySymbol;

  double? clientOfferedPrice;

  double? driverCounterPrice;

  double? agreedPrice;

  _i3.PriceNegotiationStatus? negotiationStatus;

  bool isPaid;

  String? itemDescription;

  String? recipientName;

  String? recipientPhone;

  String? specialInstructions;

  String? packageSize;

  bool isFragile;

  bool isPurchaseRequired;

  List<_i6.ShoppingItem>? shoppingList;

  List<String>? attachments;

  int? catalogServiceId;

  int? catalogDriverId;

  String? notes;

  String clientName;

  String? clientPhone;

  String? driverName;

  String? driverPhone;

  String? proposedDriverName;

  String? proposedDriverPhone;

  int? cancelledBy;

  String? cancellationReason;

  String? deviceFingerprint;

  DateTime createdAt;

  DateTime? acceptedAt;

  DateTime? driverArrivingAt;

  DateTime? startedAt;

  DateTime? completedAt;

  DateTime? cancelledAt;

  /// Returns a shallow copy of this [ServiceRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ServiceRequest copyWith({
    int? id,
    int? clientId,
    int? driverId,
    int? proposedDriverId,
    _i4.ServiceType? serviceType,
    _i2.RequestStatus? status,
    _i5.Location? pickupLocation,
    _i5.Location? destinationLocation,
    double? basePrice,
    double? distancePrice,
    double? totalPrice,
    double? estimatedPurchaseCost,
    double? deliveryFee,
    double? distance,
    int? estimatedDuration,
    String? currency,
    String? currencySymbol,
    double? clientOfferedPrice,
    double? driverCounterPrice,
    double? agreedPrice,
    _i3.PriceNegotiationStatus? negotiationStatus,
    bool? isPaid,
    String? itemDescription,
    String? recipientName,
    String? recipientPhone,
    String? specialInstructions,
    String? packageSize,
    bool? isFragile,
    bool? isPurchaseRequired,
    List<_i6.ShoppingItem>? shoppingList,
    List<String>? attachments,
    int? catalogServiceId,
    int? catalogDriverId,
    String? notes,
    String? clientName,
    String? clientPhone,
    String? driverName,
    String? driverPhone,
    String? proposedDriverName,
    String? proposedDriverPhone,
    int? cancelledBy,
    String? cancellationReason,
    String? deviceFingerprint,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? driverArrivingAt,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ServiceRequest',
      if (id != null) 'id': id,
      'clientId': clientId,
      if (driverId != null) 'driverId': driverId,
      if (proposedDriverId != null) 'proposedDriverId': proposedDriverId,
      'serviceType': serviceType.toJson(),
      'status': status.toJson(),
      if (pickupLocation != null) 'pickupLocation': pickupLocation?.toJson(),
      'destinationLocation': destinationLocation.toJson(),
      'basePrice': basePrice,
      'distancePrice': distancePrice,
      'totalPrice': totalPrice,
      if (estimatedPurchaseCost != null)
        'estimatedPurchaseCost': estimatedPurchaseCost,
      if (deliveryFee != null) 'deliveryFee': deliveryFee,
      if (distance != null) 'distance': distance,
      if (estimatedDuration != null) 'estimatedDuration': estimatedDuration,
      'currency': currency,
      'currencySymbol': currencySymbol,
      if (clientOfferedPrice != null) 'clientOfferedPrice': clientOfferedPrice,
      if (driverCounterPrice != null) 'driverCounterPrice': driverCounterPrice,
      if (agreedPrice != null) 'agreedPrice': agreedPrice,
      if (negotiationStatus != null)
        'negotiationStatus': negotiationStatus?.toJson(),
      'isPaid': isPaid,
      if (itemDescription != null) 'itemDescription': itemDescription,
      if (recipientName != null) 'recipientName': recipientName,
      if (recipientPhone != null) 'recipientPhone': recipientPhone,
      if (specialInstructions != null)
        'specialInstructions': specialInstructions,
      if (packageSize != null) 'packageSize': packageSize,
      'isFragile': isFragile,
      'isPurchaseRequired': isPurchaseRequired,
      if (shoppingList != null)
        'shoppingList': shoppingList?.toJson(valueToJson: (v) => v.toJson()),
      if (attachments != null) 'attachments': attachments?.toJson(),
      if (catalogServiceId != null) 'catalogServiceId': catalogServiceId,
      if (catalogDriverId != null) 'catalogDriverId': catalogDriverId,
      if (notes != null) 'notes': notes,
      'clientName': clientName,
      if (clientPhone != null) 'clientPhone': clientPhone,
      if (driverName != null) 'driverName': driverName,
      if (driverPhone != null) 'driverPhone': driverPhone,
      if (proposedDriverName != null) 'proposedDriverName': proposedDriverName,
      if (proposedDriverPhone != null)
        'proposedDriverPhone': proposedDriverPhone,
      if (cancelledBy != null) 'cancelledBy': cancelledBy,
      if (cancellationReason != null) 'cancellationReason': cancellationReason,
      if (deviceFingerprint != null) 'deviceFingerprint': deviceFingerprint,
      'createdAt': createdAt.toJson(),
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
      if (driverArrivingAt != null)
        'driverArrivingAt': driverArrivingAt?.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (cancelledAt != null) 'cancelledAt': cancelledAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ServiceRequestImpl extends ServiceRequest {
  _ServiceRequestImpl({
    int? id,
    required int clientId,
    int? driverId,
    int? proposedDriverId,
    required _i4.ServiceType serviceType,
    _i2.RequestStatus? status,
    _i5.Location? pickupLocation,
    required _i5.Location destinationLocation,
    required double basePrice,
    required double distancePrice,
    required double totalPrice,
    double? estimatedPurchaseCost,
    double? deliveryFee,
    double? distance,
    int? estimatedDuration,
    String? currency,
    String? currencySymbol,
    double? clientOfferedPrice,
    double? driverCounterPrice,
    double? agreedPrice,
    _i3.PriceNegotiationStatus? negotiationStatus,
    bool? isPaid,
    String? itemDescription,
    String? recipientName,
    String? recipientPhone,
    String? specialInstructions,
    String? packageSize,
    bool? isFragile,
    bool? isPurchaseRequired,
    List<_i6.ShoppingItem>? shoppingList,
    List<String>? attachments,
    int? catalogServiceId,
    int? catalogDriverId,
    String? notes,
    required String clientName,
    String? clientPhone,
    String? driverName,
    String? driverPhone,
    String? proposedDriverName,
    String? proposedDriverPhone,
    int? cancelledBy,
    String? cancellationReason,
    String? deviceFingerprint,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? driverArrivingAt,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
  }) : super._(
         id: id,
         clientId: clientId,
         driverId: driverId,
         proposedDriverId: proposedDriverId,
         serviceType: serviceType,
         status: status,
         pickupLocation: pickupLocation,
         destinationLocation: destinationLocation,
         basePrice: basePrice,
         distancePrice: distancePrice,
         totalPrice: totalPrice,
         estimatedPurchaseCost: estimatedPurchaseCost,
         deliveryFee: deliveryFee,
         distance: distance,
         estimatedDuration: estimatedDuration,
         currency: currency,
         currencySymbol: currencySymbol,
         clientOfferedPrice: clientOfferedPrice,
         driverCounterPrice: driverCounterPrice,
         agreedPrice: agreedPrice,
         negotiationStatus: negotiationStatus,
         isPaid: isPaid,
         itemDescription: itemDescription,
         recipientName: recipientName,
         recipientPhone: recipientPhone,
         specialInstructions: specialInstructions,
         packageSize: packageSize,
         isFragile: isFragile,
         isPurchaseRequired: isPurchaseRequired,
         shoppingList: shoppingList,
         attachments: attachments,
         catalogServiceId: catalogServiceId,
         catalogDriverId: catalogDriverId,
         notes: notes,
         clientName: clientName,
         clientPhone: clientPhone,
         driverName: driverName,
         driverPhone: driverPhone,
         proposedDriverName: proposedDriverName,
         proposedDriverPhone: proposedDriverPhone,
         cancelledBy: cancelledBy,
         cancellationReason: cancellationReason,
         deviceFingerprint: deviceFingerprint,
         createdAt: createdAt,
         acceptedAt: acceptedAt,
         driverArrivingAt: driverArrivingAt,
         startedAt: startedAt,
         completedAt: completedAt,
         cancelledAt: cancelledAt,
       );

  /// Returns a shallow copy of this [ServiceRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ServiceRequest copyWith({
    Object? id = _Undefined,
    int? clientId,
    Object? driverId = _Undefined,
    Object? proposedDriverId = _Undefined,
    _i4.ServiceType? serviceType,
    _i2.RequestStatus? status,
    Object? pickupLocation = _Undefined,
    _i5.Location? destinationLocation,
    double? basePrice,
    double? distancePrice,
    double? totalPrice,
    Object? estimatedPurchaseCost = _Undefined,
    Object? deliveryFee = _Undefined,
    Object? distance = _Undefined,
    Object? estimatedDuration = _Undefined,
    String? currency,
    String? currencySymbol,
    Object? clientOfferedPrice = _Undefined,
    Object? driverCounterPrice = _Undefined,
    Object? agreedPrice = _Undefined,
    Object? negotiationStatus = _Undefined,
    bool? isPaid,
    Object? itemDescription = _Undefined,
    Object? recipientName = _Undefined,
    Object? recipientPhone = _Undefined,
    Object? specialInstructions = _Undefined,
    Object? packageSize = _Undefined,
    bool? isFragile,
    bool? isPurchaseRequired,
    Object? shoppingList = _Undefined,
    Object? attachments = _Undefined,
    Object? catalogServiceId = _Undefined,
    Object? catalogDriverId = _Undefined,
    Object? notes = _Undefined,
    String? clientName,
    Object? clientPhone = _Undefined,
    Object? driverName = _Undefined,
    Object? driverPhone = _Undefined,
    Object? proposedDriverName = _Undefined,
    Object? proposedDriverPhone = _Undefined,
    Object? cancelledBy = _Undefined,
    Object? cancellationReason = _Undefined,
    Object? deviceFingerprint = _Undefined,
    DateTime? createdAt,
    Object? acceptedAt = _Undefined,
    Object? driverArrivingAt = _Undefined,
    Object? startedAt = _Undefined,
    Object? completedAt = _Undefined,
    Object? cancelledAt = _Undefined,
  }) {
    return ServiceRequest(
      id: id is int? ? id : this.id,
      clientId: clientId ?? this.clientId,
      driverId: driverId is int? ? driverId : this.driverId,
      proposedDriverId: proposedDriverId is int?
          ? proposedDriverId
          : this.proposedDriverId,
      serviceType: serviceType ?? this.serviceType,
      status: status ?? this.status,
      pickupLocation: pickupLocation is _i5.Location?
          ? pickupLocation
          : this.pickupLocation?.copyWith(),
      destinationLocation:
          destinationLocation ?? this.destinationLocation.copyWith(),
      basePrice: basePrice ?? this.basePrice,
      distancePrice: distancePrice ?? this.distancePrice,
      totalPrice: totalPrice ?? this.totalPrice,
      estimatedPurchaseCost: estimatedPurchaseCost is double?
          ? estimatedPurchaseCost
          : this.estimatedPurchaseCost,
      deliveryFee: deliveryFee is double? ? deliveryFee : this.deliveryFee,
      distance: distance is double? ? distance : this.distance,
      estimatedDuration: estimatedDuration is int?
          ? estimatedDuration
          : this.estimatedDuration,
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      clientOfferedPrice: clientOfferedPrice is double?
          ? clientOfferedPrice
          : this.clientOfferedPrice,
      driverCounterPrice: driverCounterPrice is double?
          ? driverCounterPrice
          : this.driverCounterPrice,
      agreedPrice: agreedPrice is double? ? agreedPrice : this.agreedPrice,
      negotiationStatus: negotiationStatus is _i3.PriceNegotiationStatus?
          ? negotiationStatus
          : this.negotiationStatus,
      isPaid: isPaid ?? this.isPaid,
      itemDescription: itemDescription is String?
          ? itemDescription
          : this.itemDescription,
      recipientName: recipientName is String?
          ? recipientName
          : this.recipientName,
      recipientPhone: recipientPhone is String?
          ? recipientPhone
          : this.recipientPhone,
      specialInstructions: specialInstructions is String?
          ? specialInstructions
          : this.specialInstructions,
      packageSize: packageSize is String? ? packageSize : this.packageSize,
      isFragile: isFragile ?? this.isFragile,
      isPurchaseRequired: isPurchaseRequired ?? this.isPurchaseRequired,
      shoppingList: shoppingList is List<_i6.ShoppingItem>?
          ? shoppingList
          : this.shoppingList?.map((e0) => e0.copyWith()).toList(),
      attachments: attachments is List<String>?
          ? attachments
          : this.attachments?.map((e0) => e0).toList(),
      catalogServiceId: catalogServiceId is int?
          ? catalogServiceId
          : this.catalogServiceId,
      catalogDriverId: catalogDriverId is int?
          ? catalogDriverId
          : this.catalogDriverId,
      notes: notes is String? ? notes : this.notes,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone is String? ? clientPhone : this.clientPhone,
      driverName: driverName is String? ? driverName : this.driverName,
      driverPhone: driverPhone is String? ? driverPhone : this.driverPhone,
      proposedDriverName: proposedDriverName is String?
          ? proposedDriverName
          : this.proposedDriverName,
      proposedDriverPhone: proposedDriverPhone is String?
          ? proposedDriverPhone
          : this.proposedDriverPhone,
      cancelledBy: cancelledBy is int? ? cancelledBy : this.cancelledBy,
      cancellationReason: cancellationReason is String?
          ? cancellationReason
          : this.cancellationReason,
      deviceFingerprint: deviceFingerprint is String?
          ? deviceFingerprint
          : this.deviceFingerprint,
      createdAt: createdAt ?? this.createdAt,
      acceptedAt: acceptedAt is DateTime? ? acceptedAt : this.acceptedAt,
      driverArrivingAt: driverArrivingAt is DateTime?
          ? driverArrivingAt
          : this.driverArrivingAt,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      cancelledAt: cancelledAt is DateTime? ? cancelledAt : this.cancelledAt,
    );
  }
}
