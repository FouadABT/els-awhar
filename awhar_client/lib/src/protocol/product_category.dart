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

abstract class ProductCategory implements _i1.SerializableModel {
  ProductCategory._({
    this.id,
    required this.storeId,
    required this.name,
    this.imageUrl,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isActive = isActive ?? true,
       displayOrder = displayOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory ProductCategory({
    int? id,
    required int storeId,
    required String name,
    String? imageUrl,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProductCategoryImpl;

  factory ProductCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProductCategory(
      id: jsonSerialization['id'] as int?,
      storeId: jsonSerialization['storeId'] as int,
      name: jsonSerialization['name'] as String,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      isActive: jsonSerialization['isActive'] as bool,
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

  String name;

  String? imageUrl;

  bool isActive;

  int displayOrder;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ProductCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProductCategory copyWith({
    int? id,
    int? storeId,
    String? name,
    String? imageUrl,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProductCategory',
      if (id != null) 'id': id,
      'storeId': storeId,
      'name': name,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'isActive': isActive,
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

class _ProductCategoryImpl extends ProductCategory {
  _ProductCategoryImpl({
    int? id,
    required int storeId,
    required String name,
    String? imageUrl,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         storeId: storeId,
         name: name,
         imageUrl: imageUrl,
         isActive: isActive,
         displayOrder: displayOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ProductCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProductCategory copyWith({
    Object? id = _Undefined,
    int? storeId,
    String? name,
    Object? imageUrl = _Undefined,
    bool? isActive,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductCategory(
      id: id is int? ? id : this.id,
      storeId: storeId ?? this.storeId,
      name: name ?? this.name,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      isActive: isActive ?? this.isActive,
      displayOrder: displayOrder ?? this.displayOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
