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

abstract class StoreOrderItem implements _i1.SerializableModel {
  StoreOrderItem._({
    this.id,
    required this.storeOrderId,
    this.productId,
    required this.productName,
    required this.productPrice,
    this.productImageUrl,
    required this.quantity,
    required this.itemTotal,
    this.notes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory StoreOrderItem({
    int? id,
    required int storeOrderId,
    int? productId,
    required String productName,
    required double productPrice,
    String? productImageUrl,
    required int quantity,
    required double itemTotal,
    String? notes,
    DateTime? createdAt,
  }) = _StoreOrderItemImpl;

  factory StoreOrderItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreOrderItem(
      id: jsonSerialization['id'] as int?,
      storeOrderId: jsonSerialization['storeOrderId'] as int,
      productId: jsonSerialization['productId'] as int?,
      productName: jsonSerialization['productName'] as String,
      productPrice: (jsonSerialization['productPrice'] as num).toDouble(),
      productImageUrl: jsonSerialization['productImageUrl'] as String?,
      quantity: jsonSerialization['quantity'] as int,
      itemTotal: (jsonSerialization['itemTotal'] as num).toDouble(),
      notes: jsonSerialization['notes'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int storeOrderId;

  int? productId;

  String productName;

  double productPrice;

  String? productImageUrl;

  int quantity;

  double itemTotal;

  String? notes;

  DateTime createdAt;

  /// Returns a shallow copy of this [StoreOrderItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreOrderItem copyWith({
    int? id,
    int? storeOrderId,
    int? productId,
    String? productName,
    double? productPrice,
    String? productImageUrl,
    int? quantity,
    double? itemTotal,
    String? notes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreOrderItem',
      if (id != null) 'id': id,
      'storeOrderId': storeOrderId,
      if (productId != null) 'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      if (productImageUrl != null) 'productImageUrl': productImageUrl,
      'quantity': quantity,
      'itemTotal': itemTotal,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreOrderItemImpl extends StoreOrderItem {
  _StoreOrderItemImpl({
    int? id,
    required int storeOrderId,
    int? productId,
    required String productName,
    required double productPrice,
    String? productImageUrl,
    required int quantity,
    required double itemTotal,
    String? notes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         storeOrderId: storeOrderId,
         productId: productId,
         productName: productName,
         productPrice: productPrice,
         productImageUrl: productImageUrl,
         quantity: quantity,
         itemTotal: itemTotal,
         notes: notes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [StoreOrderItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreOrderItem copyWith({
    Object? id = _Undefined,
    int? storeOrderId,
    Object? productId = _Undefined,
    String? productName,
    double? productPrice,
    Object? productImageUrl = _Undefined,
    int? quantity,
    double? itemTotal,
    Object? notes = _Undefined,
    DateTime? createdAt,
  }) {
    return StoreOrderItem(
      id: id is int? ? id : this.id,
      storeOrderId: storeOrderId ?? this.storeOrderId,
      productId: productId is int? ? productId : this.productId,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      productImageUrl: productImageUrl is String?
          ? productImageUrl
          : this.productImageUrl,
      quantity: quantity ?? this.quantity,
      itemTotal: itemTotal ?? this.itemTotal,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
