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

abstract class ShoppingItem implements _i1.SerializableModel {
  ShoppingItem._({
    required this.item,
    int? quantity,
    this.notes,
  }) : quantity = quantity ?? 1;

  factory ShoppingItem({
    required String item,
    int? quantity,
    String? notes,
  }) = _ShoppingItemImpl;

  factory ShoppingItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShoppingItem(
      item: jsonSerialization['item'] as String,
      quantity: jsonSerialization['quantity'] as int,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  String item;

  int quantity;

  String? notes;

  /// Returns a shallow copy of this [ShoppingItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ShoppingItem copyWith({
    String? item,
    int? quantity,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ShoppingItem',
      'item': item,
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

class _ShoppingItemImpl extends ShoppingItem {
  _ShoppingItemImpl({
    required String item,
    int? quantity,
    String? notes,
  }) : super._(
         item: item,
         quantity: quantity,
         notes: notes,
       );

  /// Returns a shallow copy of this [ShoppingItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ShoppingItem copyWith({
    String? item,
    int? quantity,
    Object? notes = _Undefined,
  }) {
    return ShoppingItem(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
      notes: notes is String? ? notes : this.notes,
    );
  }
}
