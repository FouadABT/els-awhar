/// Elasticsearch document for service requests index
/// Maps ServiceRequest data for analytics and history
class EsRequestDocument {
  final int id;
  final int clientId;
  final int? driverId;
  final String serviceType;
  final String status;
  
  // Client info
  final String? clientName;
  final String? clientPhone;
  
  // Driver info
  final String? driverName;
  final String? driverPhone;
  
  // Locations
  final Map<String, double>? pickupLocation;
  final Map<String, double>? destinationLocation;
  
  // Pricing
  final double basePrice;
  final double totalPrice;
  final double? agreedPrice;
  final String currency;
  final String currencySymbol;
  
  // Details
  final String? itemDescription;
  final String? specialInstructions;
  final bool isPurchaseRequired;
  final bool isFragile;
  
  // Distance/Time
  final double? distance;
  final int? estimatedDuration;
  
  // Timestamps for analytics
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final DateTime? cancelledAt;
  
  // Cancellation info
  final int? cancelledBy;
  final String? cancellationReason;
  
  // Fraud Detection
  final String? deviceFingerprint;

  EsRequestDocument({
    required this.id,
    required this.clientId,
    this.driverId,
    required this.serviceType,
    required this.status,
    this.clientName,
    this.clientPhone,
    this.driverName,
    this.driverPhone,
    this.pickupLocation,
    this.destinationLocation,
    required this.basePrice,
    required this.totalPrice,
    this.agreedPrice,
    required this.currency,
    required this.currencySymbol,
    this.itemDescription,
    this.specialInstructions,
    required this.isPurchaseRequired,
    required this.isFragile,
    this.distance,
    this.estimatedDuration,
    required this.createdAt,
    this.acceptedAt,
    this.startedAt,
    this.completedAt,
    this.cancelledAt,
    this.cancelledBy,
    this.cancellationReason,
    this.deviceFingerprint,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientId': clientId,
      'driverId': driverId,
      'serviceType': serviceType,
      'status': status,
      'clientName': clientName,
      'clientPhone': clientPhone,
      'driverName': driverName,
      'driverPhone': driverPhone,
      'pickupLocation': pickupLocation,
      'destinationLocation': destinationLocation,
      'basePrice': basePrice,
      'totalPrice': totalPrice,
      'agreedPrice': agreedPrice,
      'currency': currency,
      'currencySymbol': currencySymbol,
      'itemDescription': itemDescription,
      'specialInstructions': specialInstructions,
      'isPurchaseRequired': isPurchaseRequired,
      'isFragile': isFragile,
      'distance': distance,
      'estimatedDuration': estimatedDuration,
      'createdAt': createdAt.toIso8601String(),
      'acceptedAt': acceptedAt?.toIso8601String(),
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'cancelledAt': cancelledAt?.toIso8601String(),
      'cancelledBy': cancelledBy,
      'cancellationReason': cancellationReason,
      'deviceFingerprint': deviceFingerprint,
      // Computed fields
      'isCompleted': completedAt != null,
      'isCancelled': cancelledAt != null,
      'durationMinutes': _calculateDuration(),
    };
  }

  int? _calculateDuration() {
    if (completedAt != null) {
      return completedAt!.difference(createdAt).inMinutes;
    }
    return null;
  }

  String get documentId => 'request_$id';
}
