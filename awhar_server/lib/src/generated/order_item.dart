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

abstract class OrderItem
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  OrderItem._({
    required this.productId,
    required this.quantity,
    this.notes,
  });

  factory OrderItem({
    required int productId,
    required int quantity,
    String? notes,
  }) = _OrderItemImpl;

  factory OrderItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderItem(
      productId: jsonSerialization['productId'] as int,
      quantity: jsonSerialization['quantity'] as int,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  int productId;

  int quantity;

  String? notes;

  /// Returns a shallow copy of this [OrderItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderItem copyWith({
    int? productId,
    int? quantity,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderItem',
      'productId': productId,
      'quantity': quantity,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderItem',
      'productId': productId,
      'quantity': quantity,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderItemImpl extends OrderItem {
  _OrderItemImpl({
    required int productId,
    required int quantity,
    String? notes,
  }) : super._(
         productId: productId,
         quantity: quantity,
         notes: notes,
       );

  /// Returns a shallow copy of this [OrderItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderItem copyWith({
    int? productId,
    int? quantity,
    Object? notes = _Undefined,
  }) {
    return OrderItem(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      notes: notes is String? ? notes : this.notes,
    );
  }
}
