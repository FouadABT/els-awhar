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
import 'package:serverpod/serverpod.dart' as _i1;
import 'request_status.dart' as _i2;
import 'price_negotiation_status_enum.dart' as _i3;
import 'service_type.dart' as _i4;
import 'location.dart' as _i5;
import 'shopping_item.dart' as _i6;
import 'package:awhar_server/src/generated/protocol.dart' as _i7;

abstract class ServiceRequest
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = ServiceRequestTable();

  static const db = ServiceRequestRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ServiceRequest',
      if (id != null) 'id': id,
      'clientId': clientId,
      if (driverId != null) 'driverId': driverId,
      if (proposedDriverId != null) 'proposedDriverId': proposedDriverId,
      'serviceType': serviceType.toJson(),
      'status': status.toJson(),
      if (pickupLocation != null)
        'pickupLocation': pickupLocation?.toJsonForProtocol(),
      'destinationLocation': destinationLocation.toJsonForProtocol(),
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
        'shoppingList': shoppingList?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
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

  static ServiceRequestInclude include() {
    return ServiceRequestInclude._();
  }

  static ServiceRequestIncludeList includeList({
    _i1.WhereExpressionBuilder<ServiceRequestTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ServiceRequestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ServiceRequestTable>? orderByList,
    ServiceRequestInclude? include,
  }) {
    return ServiceRequestIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ServiceRequest.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ServiceRequest.t),
      include: include,
    );
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

class ServiceRequestUpdateTable extends _i1.UpdateTable<ServiceRequestTable> {
  ServiceRequestUpdateTable(super.table);

  _i1.ColumnValue<int, int> clientId(int value) => _i1.ColumnValue(
    table.clientId,
    value,
  );

  _i1.ColumnValue<int, int> driverId(int? value) => _i1.ColumnValue(
    table.driverId,
    value,
  );

  _i1.ColumnValue<int, int> proposedDriverId(int? value) => _i1.ColumnValue(
    table.proposedDriverId,
    value,
  );

  _i1.ColumnValue<_i4.ServiceType, _i4.ServiceType> serviceType(
    _i4.ServiceType value,
  ) => _i1.ColumnValue(
    table.serviceType,
    value,
  );

  _i1.ColumnValue<_i2.RequestStatus, _i2.RequestStatus> status(
    _i2.RequestStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<_i5.Location, _i5.Location> pickupLocation(
    _i5.Location? value,
  ) => _i1.ColumnValue(
    table.pickupLocation,
    value,
  );

  _i1.ColumnValue<_i5.Location, _i5.Location> destinationLocation(
    _i5.Location value,
  ) => _i1.ColumnValue(
    table.destinationLocation,
    value,
  );

  _i1.ColumnValue<double, double> basePrice(double value) => _i1.ColumnValue(
    table.basePrice,
    value,
  );

  _i1.ColumnValue<double, double> distancePrice(double value) =>
      _i1.ColumnValue(
        table.distancePrice,
        value,
      );

  _i1.ColumnValue<double, double> totalPrice(double value) => _i1.ColumnValue(
    table.totalPrice,
    value,
  );

  _i1.ColumnValue<double, double> estimatedPurchaseCost(double? value) =>
      _i1.ColumnValue(
        table.estimatedPurchaseCost,
        value,
      );

  _i1.ColumnValue<double, double> deliveryFee(double? value) => _i1.ColumnValue(
    table.deliveryFee,
    value,
  );

  _i1.ColumnValue<double, double> distance(double? value) => _i1.ColumnValue(
    table.distance,
    value,
  );

  _i1.ColumnValue<int, int> estimatedDuration(int? value) => _i1.ColumnValue(
    table.estimatedDuration,
    value,
  );

  _i1.ColumnValue<String, String> currency(String value) => _i1.ColumnValue(
    table.currency,
    value,
  );

  _i1.ColumnValue<String, String> currencySymbol(String value) =>
      _i1.ColumnValue(
        table.currencySymbol,
        value,
      );

  _i1.ColumnValue<double, double> clientOfferedPrice(double? value) =>
      _i1.ColumnValue(
        table.clientOfferedPrice,
        value,
      );

  _i1.ColumnValue<double, double> driverCounterPrice(double? value) =>
      _i1.ColumnValue(
        table.driverCounterPrice,
        value,
      );

  _i1.ColumnValue<double, double> agreedPrice(double? value) => _i1.ColumnValue(
    table.agreedPrice,
    value,
  );

  _i1.ColumnValue<_i3.PriceNegotiationStatus, _i3.PriceNegotiationStatus>
  negotiationStatus(_i3.PriceNegotiationStatus? value) => _i1.ColumnValue(
    table.negotiationStatus,
    value,
  );

  _i1.ColumnValue<bool, bool> isPaid(bool value) => _i1.ColumnValue(
    table.isPaid,
    value,
  );

  _i1.ColumnValue<String, String> itemDescription(String? value) =>
      _i1.ColumnValue(
        table.itemDescription,
        value,
      );

  _i1.ColumnValue<String, String> recipientName(String? value) =>
      _i1.ColumnValue(
        table.recipientName,
        value,
      );

  _i1.ColumnValue<String, String> recipientPhone(String? value) =>
      _i1.ColumnValue(
        table.recipientPhone,
        value,
      );

  _i1.ColumnValue<String, String> specialInstructions(String? value) =>
      _i1.ColumnValue(
        table.specialInstructions,
        value,
      );

  _i1.ColumnValue<String, String> packageSize(String? value) => _i1.ColumnValue(
    table.packageSize,
    value,
  );

  _i1.ColumnValue<bool, bool> isFragile(bool value) => _i1.ColumnValue(
    table.isFragile,
    value,
  );

  _i1.ColumnValue<bool, bool> isPurchaseRequired(bool value) => _i1.ColumnValue(
    table.isPurchaseRequired,
    value,
  );

  _i1.ColumnValue<List<_i6.ShoppingItem>, List<_i6.ShoppingItem>> shoppingList(
    List<_i6.ShoppingItem>? value,
  ) => _i1.ColumnValue(
    table.shoppingList,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> attachments(
    List<String>? value,
  ) => _i1.ColumnValue(
    table.attachments,
    value,
  );

  _i1.ColumnValue<int, int> catalogServiceId(int? value) => _i1.ColumnValue(
    table.catalogServiceId,
    value,
  );

  _i1.ColumnValue<int, int> catalogDriverId(int? value) => _i1.ColumnValue(
    table.catalogDriverId,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );

  _i1.ColumnValue<String, String> clientName(String value) => _i1.ColumnValue(
    table.clientName,
    value,
  );

  _i1.ColumnValue<String, String> clientPhone(String? value) => _i1.ColumnValue(
    table.clientPhone,
    value,
  );

  _i1.ColumnValue<String, String> driverName(String? value) => _i1.ColumnValue(
    table.driverName,
    value,
  );

  _i1.ColumnValue<String, String> driverPhone(String? value) => _i1.ColumnValue(
    table.driverPhone,
    value,
  );

  _i1.ColumnValue<String, String> proposedDriverName(String? value) =>
      _i1.ColumnValue(
        table.proposedDriverName,
        value,
      );

  _i1.ColumnValue<String, String> proposedDriverPhone(String? value) =>
      _i1.ColumnValue(
        table.proposedDriverPhone,
        value,
      );

  _i1.ColumnValue<int, int> cancelledBy(int? value) => _i1.ColumnValue(
    table.cancelledBy,
    value,
  );

  _i1.ColumnValue<String, String> cancellationReason(String? value) =>
      _i1.ColumnValue(
        table.cancellationReason,
        value,
      );

  _i1.ColumnValue<String, String> deviceFingerprint(String? value) =>
      _i1.ColumnValue(
        table.deviceFingerprint,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> acceptedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.acceptedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> driverArrivingAt(DateTime? value) =>
      _i1.ColumnValue(
        table.driverArrivingAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> startedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.startedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> cancelledAt(DateTime? value) =>
      _i1.ColumnValue(
        table.cancelledAt,
        value,
      );
}

class ServiceRequestTable extends _i1.Table<int?> {
  ServiceRequestTable({super.tableRelation})
    : super(tableName: 'service_requests') {
    updateTable = ServiceRequestUpdateTable(this);
    clientId = _i1.ColumnInt(
      'clientId',
      this,
    );
    driverId = _i1.ColumnInt(
      'driverId',
      this,
    );
    proposedDriverId = _i1.ColumnInt(
      'proposedDriverId',
      this,
    );
    serviceType = _i1.ColumnEnum(
      'serviceType',
      this,
      _i1.EnumSerialization.byName,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    pickupLocation = _i1.ColumnSerializable<_i5.Location>(
      'pickupLocation',
      this,
    );
    destinationLocation = _i1.ColumnSerializable<_i5.Location>(
      'destinationLocation',
      this,
    );
    basePrice = _i1.ColumnDouble(
      'basePrice',
      this,
    );
    distancePrice = _i1.ColumnDouble(
      'distancePrice',
      this,
    );
    totalPrice = _i1.ColumnDouble(
      'totalPrice',
      this,
    );
    estimatedPurchaseCost = _i1.ColumnDouble(
      'estimatedPurchaseCost',
      this,
    );
    deliveryFee = _i1.ColumnDouble(
      'deliveryFee',
      this,
    );
    distance = _i1.ColumnDouble(
      'distance',
      this,
    );
    estimatedDuration = _i1.ColumnInt(
      'estimatedDuration',
      this,
    );
    currency = _i1.ColumnString(
      'currency',
      this,
      hasDefault: true,
    );
    currencySymbol = _i1.ColumnString(
      'currencySymbol',
      this,
      hasDefault: true,
    );
    clientOfferedPrice = _i1.ColumnDouble(
      'clientOfferedPrice',
      this,
    );
    driverCounterPrice = _i1.ColumnDouble(
      'driverCounterPrice',
      this,
    );
    agreedPrice = _i1.ColumnDouble(
      'agreedPrice',
      this,
    );
    negotiationStatus = _i1.ColumnEnum(
      'negotiationStatus',
      this,
      _i1.EnumSerialization.byIndex,
      hasDefault: true,
    );
    isPaid = _i1.ColumnBool(
      'isPaid',
      this,
      hasDefault: true,
    );
    itemDescription = _i1.ColumnString(
      'itemDescription',
      this,
    );
    recipientName = _i1.ColumnString(
      'recipientName',
      this,
    );
    recipientPhone = _i1.ColumnString(
      'recipientPhone',
      this,
    );
    specialInstructions = _i1.ColumnString(
      'specialInstructions',
      this,
    );
    packageSize = _i1.ColumnString(
      'packageSize',
      this,
    );
    isFragile = _i1.ColumnBool(
      'isFragile',
      this,
      hasDefault: true,
    );
    isPurchaseRequired = _i1.ColumnBool(
      'isPurchaseRequired',
      this,
      hasDefault: true,
    );
    shoppingList = _i1.ColumnSerializable<List<_i6.ShoppingItem>>(
      'shoppingList',
      this,
    );
    attachments = _i1.ColumnSerializable<List<String>>(
      'attachments',
      this,
    );
    catalogServiceId = _i1.ColumnInt(
      'catalogServiceId',
      this,
    );
    catalogDriverId = _i1.ColumnInt(
      'catalogDriverId',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    clientName = _i1.ColumnString(
      'clientName',
      this,
    );
    clientPhone = _i1.ColumnString(
      'clientPhone',
      this,
    );
    driverName = _i1.ColumnString(
      'driverName',
      this,
    );
    driverPhone = _i1.ColumnString(
      'driverPhone',
      this,
    );
    proposedDriverName = _i1.ColumnString(
      'proposedDriverName',
      this,
    );
    proposedDriverPhone = _i1.ColumnString(
      'proposedDriverPhone',
      this,
    );
    cancelledBy = _i1.ColumnInt(
      'cancelledBy',
      this,
    );
    cancellationReason = _i1.ColumnString(
      'cancellationReason',
      this,
    );
    deviceFingerprint = _i1.ColumnString(
      'deviceFingerprint',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    acceptedAt = _i1.ColumnDateTime(
      'acceptedAt',
      this,
    );
    driverArrivingAt = _i1.ColumnDateTime(
      'driverArrivingAt',
      this,
    );
    startedAt = _i1.ColumnDateTime(
      'startedAt',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
    cancelledAt = _i1.ColumnDateTime(
      'cancelledAt',
      this,
    );
  }

  late final ServiceRequestUpdateTable updateTable;

  late final _i1.ColumnInt clientId;

  late final _i1.ColumnInt driverId;

  late final _i1.ColumnInt proposedDriverId;

  late final _i1.ColumnEnum<_i4.ServiceType> serviceType;

  late final _i1.ColumnEnum<_i2.RequestStatus> status;

  late final _i1.ColumnSerializable<_i5.Location> pickupLocation;

  late final _i1.ColumnSerializable<_i5.Location> destinationLocation;

  late final _i1.ColumnDouble basePrice;

  late final _i1.ColumnDouble distancePrice;

  late final _i1.ColumnDouble totalPrice;

  late final _i1.ColumnDouble estimatedPurchaseCost;

  late final _i1.ColumnDouble deliveryFee;

  late final _i1.ColumnDouble distance;

  late final _i1.ColumnInt estimatedDuration;

  late final _i1.ColumnString currency;

  late final _i1.ColumnString currencySymbol;

  late final _i1.ColumnDouble clientOfferedPrice;

  late final _i1.ColumnDouble driverCounterPrice;

  late final _i1.ColumnDouble agreedPrice;

  late final _i1.ColumnEnum<_i3.PriceNegotiationStatus> negotiationStatus;

  late final _i1.ColumnBool isPaid;

  late final _i1.ColumnString itemDescription;

  late final _i1.ColumnString recipientName;

  late final _i1.ColumnString recipientPhone;

  late final _i1.ColumnString specialInstructions;

  late final _i1.ColumnString packageSize;

  late final _i1.ColumnBool isFragile;

  late final _i1.ColumnBool isPurchaseRequired;

  late final _i1.ColumnSerializable<List<_i6.ShoppingItem>> shoppingList;

  late final _i1.ColumnSerializable<List<String>> attachments;

  late final _i1.ColumnInt catalogServiceId;

  late final _i1.ColumnInt catalogDriverId;

  late final _i1.ColumnString notes;

  late final _i1.ColumnString clientName;

  late final _i1.ColumnString clientPhone;

  late final _i1.ColumnString driverName;

  late final _i1.ColumnString driverPhone;

  late final _i1.ColumnString proposedDriverName;

  late final _i1.ColumnString proposedDriverPhone;

  late final _i1.ColumnInt cancelledBy;

  late final _i1.ColumnString cancellationReason;

  late final _i1.ColumnString deviceFingerprint;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime acceptedAt;

  late final _i1.ColumnDateTime driverArrivingAt;

  late final _i1.ColumnDateTime startedAt;

  late final _i1.ColumnDateTime completedAt;

  late final _i1.ColumnDateTime cancelledAt;

  @override
  List<_i1.Column> get columns => [
    id,
    clientId,
    driverId,
    proposedDriverId,
    serviceType,
    status,
    pickupLocation,
    destinationLocation,
    basePrice,
    distancePrice,
    totalPrice,
    estimatedPurchaseCost,
    deliveryFee,
    distance,
    estimatedDuration,
    currency,
    currencySymbol,
    clientOfferedPrice,
    driverCounterPrice,
    agreedPrice,
    negotiationStatus,
    isPaid,
    itemDescription,
    recipientName,
    recipientPhone,
    specialInstructions,
    packageSize,
    isFragile,
    isPurchaseRequired,
    shoppingList,
    attachments,
    catalogServiceId,
    catalogDriverId,
    notes,
    clientName,
    clientPhone,
    driverName,
    driverPhone,
    proposedDriverName,
    proposedDriverPhone,
    cancelledBy,
    cancellationReason,
    deviceFingerprint,
    createdAt,
    acceptedAt,
    driverArrivingAt,
    startedAt,
    completedAt,
    cancelledAt,
  ];
}

class ServiceRequestInclude extends _i1.IncludeObject {
  ServiceRequestInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ServiceRequest.t;
}

class ServiceRequestIncludeList extends _i1.IncludeList {
  ServiceRequestIncludeList._({
    _i1.WhereExpressionBuilder<ServiceRequestTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ServiceRequest.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ServiceRequest.t;
}

class ServiceRequestRepository {
  const ServiceRequestRepository._();

  /// Returns a list of [ServiceRequest]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<ServiceRequest>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ServiceRequestTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ServiceRequestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ServiceRequestTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ServiceRequest>(
      where: where?.call(ServiceRequest.t),
      orderBy: orderBy?.call(ServiceRequest.t),
      orderByList: orderByList?.call(ServiceRequest.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ServiceRequest] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<ServiceRequest?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ServiceRequestTable>? where,
    int? offset,
    _i1.OrderByBuilder<ServiceRequestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ServiceRequestTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ServiceRequest>(
      where: where?.call(ServiceRequest.t),
      orderBy: orderBy?.call(ServiceRequest.t),
      orderByList: orderByList?.call(ServiceRequest.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ServiceRequest] by its [id] or null if no such row exists.
  Future<ServiceRequest?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ServiceRequest>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ServiceRequest]s in the list and returns the inserted rows.
  ///
  /// The returned [ServiceRequest]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ServiceRequest>> insert(
    _i1.Session session,
    List<ServiceRequest> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ServiceRequest>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ServiceRequest] and returns the inserted row.
  ///
  /// The returned [ServiceRequest] will have its `id` field set.
  Future<ServiceRequest> insertRow(
    _i1.Session session,
    ServiceRequest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ServiceRequest>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ServiceRequest]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ServiceRequest>> update(
    _i1.Session session,
    List<ServiceRequest> rows, {
    _i1.ColumnSelections<ServiceRequestTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ServiceRequest>(
      rows,
      columns: columns?.call(ServiceRequest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ServiceRequest]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ServiceRequest> updateRow(
    _i1.Session session,
    ServiceRequest row, {
    _i1.ColumnSelections<ServiceRequestTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ServiceRequest>(
      row,
      columns: columns?.call(ServiceRequest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ServiceRequest] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ServiceRequest?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ServiceRequestUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ServiceRequest>(
      id,
      columnValues: columnValues(ServiceRequest.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ServiceRequest]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ServiceRequest>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ServiceRequestUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ServiceRequestTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ServiceRequestTable>? orderBy,
    _i1.OrderByListBuilder<ServiceRequestTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ServiceRequest>(
      columnValues: columnValues(ServiceRequest.t.updateTable),
      where: where(ServiceRequest.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ServiceRequest.t),
      orderByList: orderByList?.call(ServiceRequest.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ServiceRequest]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ServiceRequest>> delete(
    _i1.Session session,
    List<ServiceRequest> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ServiceRequest>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ServiceRequest].
  Future<ServiceRequest> deleteRow(
    _i1.Session session,
    ServiceRequest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ServiceRequest>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ServiceRequest>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ServiceRequestTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ServiceRequest>(
      where: where(ServiceRequest.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ServiceRequestTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ServiceRequest>(
      where: where?.call(ServiceRequest.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
