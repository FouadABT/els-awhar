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

abstract class StoreProduct implements _i1.SerializableModel {
  StoreProduct._({
    this.id,
    required this.storeId,
    this.productCategoryId,
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
    bool? isAvailable,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isAvailable = isAvailable ?? true,
       displayOrder = displayOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory StoreProduct({
    int? id,
    required int storeId,
    int? productCategoryId,
    required String name,
    String? description,
    required double price,
    String? imageUrl,
    bool? isAvailable,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StoreProductImpl;

  factory StoreProduct.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreProduct(
      id: jsonSerialization['id'] as int?,
      storeId: jsonSerialization['storeId'] as int,
      productCategoryId: jsonSerialization['productCategoryId'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      price: (jsonSerialization['price'] as num).toDouble(),
      imageUrl: jsonSerialization['imageUrl'] as String?,
      isAvailable: jsonSerialization['isAvailable'] as bool,
      displayOrder: jsonSerialization['displayOrder'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int storeId;

  int? productCategoryId;

  String name;

  String? description;

  double price;

  String? imageUrl;

  bool isAvailable;

  int displayOrder;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [StoreProduct]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreProduct copyWith({
    int? id,
    int? storeId,
    int? productCategoryId,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    bool? isAvailable,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StoreProduct',
      if (id != null) 'id': id,
      'storeId': storeId,
      if (productCategoryId != null) 'productCategoryId': productCategoryId,
      'name': name,
      if (description != null) 'description': description,
      'price': price,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      'displayOrder': displayOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreProductImpl extends StoreProduct {
  _StoreProductImpl({
    int? id,
    required int storeId,
    int? productCategoryId,
    required String name,
    String? description,
    required double price,
    String? imageUrl,
    bool? isAvailable,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         storeId: storeId,
         productCategoryId: productCategoryId,
         name: name,
         description: description,
         price: price,
         imageUrl: imageUrl,
         isAvailable: isAvailable,
         displayOrder: displayOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StoreProduct]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreProduct copyWith({
    Object? id = _Undefined,
    int? storeId,
    Object? productCategoryId = _Undefined,
    String? name,
    Object? description = _Undefined,
    double? price,
    Object? imageUrl = _Undefined,
    bool? isAvailable,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StoreProduct(
      id: id is int? ? id : this.id,
      storeId: storeId ?? this.storeId,
      productCategoryId: productCategoryId is int?
          ? productCategoryId
          : this.productCategoryId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      price: price ?? this.price,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      isAvailable: isAvailable ?? this.isAvailable,
      displayOrder: displayOrder ?? this.displayOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
