/// Elasticsearch document for store orders index
/// Maps StoreOrder data for analytics, tracking, and search
class EsStoreOrderDocument {
  final int id;
  final String orderNumber;
  final int storeId;
  final int clientId;
  final int? driverId;
  final String status;
  
  // Store info
  final String? storeName;
  final String? storeLogoUrl;
  final Map<String, double>? storeLocation;
  
  // Client info
  final String? clientName;
  final String? clientPhone;
  
  // Driver info
  final String? driverName;
  final String? driverPhone;
  
  // Delivery location
  final String deliveryAddress;
  final Map<String, double> deliveryLocation;
  final double? deliveryDistance;
  
  // Pricing
  final double subtotal;
  final double deliveryFee;
  final double total;
  final String currency;
  final String currencySymbol;
  final double platformCommission;
  final double driverEarnings;
  
  // Order details
  final int itemCount;
  final List<Map<String, dynamic>>? items;
  final String? clientNotes;
  final String? storeNotes;
  
  // Cancellation info
  final String? cancelledBy;
  final String? cancellationReason;
  
  // Timestamps for analytics
  final DateTime createdAt;
  final DateTime? confirmedAt;
  final DateTime? readyAt;
  final DateTime? pickedUpAt;
  final DateTime? deliveredAt;
  final DateTime? cancelledAt;

  EsStoreOrderDocument({
    required this.id,
    required this.orderNumber,
    required this.storeId,
    required this.clientId,
    this.driverId,
    required this.status,
    this.storeName,
    this.storeLogoUrl,
    this.storeLocation,
    this.clientName,
    this.clientPhone,
    this.driverName,
    this.driverPhone,
    required this.deliveryAddress,
    required this.deliveryLocation,
    this.deliveryDistance,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.currency,
    required this.currencySymbol,
    required this.platformCommission,
    required this.driverEarnings,
    required this.itemCount,
    this.items,
    this.clientNotes,
    this.storeNotes,
    this.cancelledBy,
    this.cancellationReason,
    required this.createdAt,
    this.confirmedAt,
    this.readyAt,
    this.pickedUpAt,
    this.deliveredAt,
    this.cancelledAt,
  });

  /// Convert to JSON for Elasticsearch indexing
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'storeId': storeId,
      'clientId': clientId,
      'driverId': driverId,
      'status': status,
      'storeName': storeName,
      'storeLogoUrl': storeLogoUrl,
      'storeLocation': storeLocation,
      'clientName': clientName,
      'clientPhone': clientPhone,
      'driverName': driverName,
      'driverPhone': driverPhone,
      'deliveryAddress': deliveryAddress,
      'deliveryLocation': deliveryLocation,
      'deliveryDistance': deliveryDistance,
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'total': total,
      'currency': currency,
      'currencySymbol': currencySymbol,
      'platformCommission': platformCommission,
      'driverEarnings': driverEarnings,
      'itemCount': itemCount,
      'items': items,
      'clientNotes': clientNotes,
      'storeNotes': storeNotes,
      'cancelledBy': cancelledBy,
      'cancellationReason': cancellationReason,
      'createdAt': createdAt.toIso8601String(),
      'confirmedAt': confirmedAt?.toIso8601String(),
      'readyAt': readyAt?.toIso8601String(),
      'pickedUpAt': pickedUpAt?.toIso8601String(),
      'deliveredAt': deliveredAt?.toIso8601String(),
      'cancelledAt': cancelledAt?.toIso8601String(),
    };
  }
}
