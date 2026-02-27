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

abstract class EsProductHit
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  EsProductHit._({
    required this.id,
    this.storeId,
    this.storeName,
    this.storeLogoUrl,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.categoryName,
    required this.isAvailable,
    this.score,
  });

  factory EsProductHit({
    required int id,
    int? storeId,
    String? storeName,
    String? storeLogoUrl,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? categoryName,
    required bool isAvailable,
    double? score,
  }) = _EsProductHitImpl;

  factory EsProductHit.fromJson(Map<String, dynamic> jsonSerialization) {
    return EsProductHit(
      id: jsonSerialization['id'] as int,
      storeId: jsonSerialization['storeId'] as int?,
      storeName: jsonSerialization['storeName'] as String?,
      storeLogoUrl: jsonSerialization['storeLogoUrl'] as String?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      price: (jsonSerialization['price'] as num?)?.toDouble(),
      imageUrl: jsonSerialization['imageUrl'] as String?,
      categoryName: jsonSerialization['categoryName'] as String?,
      isAvailable: jsonSerialization['isAvailable'] as bool,
      score: (jsonSerialization['score'] as num?)?.toDouble(),
    );
  }

  int id;

  int? storeId;

  String? storeName;

  String? storeLogoUrl;

  String? name;

  String? description;

  double? price;

  String? imageUrl;

  String? categoryName;

  bool isAvailable;

  double? score;

  /// Returns a shallow copy of this [EsProductHit]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EsProductHit copyWith({
    int? id,
    int? storeId,
    String? storeName,
    String? storeLogoUrl,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? categoryName,
    bool? isAvailable,
    double? score,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EsProductHit',
      'id': id,
      if (storeId != null) 'storeId': storeId,
      if (storeName != null) 'storeName': storeName,
      if (storeLogoUrl != null) 'storeLogoUrl': storeLogoUrl,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (categoryName != null) 'categoryName': categoryName,
      'isAvailable': isAvailable,
      if (score != null) 'score': score,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EsProductHit',
      'id': id,
      if (storeId != null) 'storeId': storeId,
      if (storeName != null) 'storeName': storeName,
      if (storeLogoUrl != null) 'storeLogoUrl': storeLogoUrl,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (categoryName != null) 'categoryName': categoryName,
      'isAvailable': isAvailable,
      if (score != null) 'score': score,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EsProductHitImpl extends EsProductHit {
  _EsProductHitImpl({
    required int id,
    int? storeId,
    String? storeName,
    String? storeLogoUrl,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? categoryName,
    required bool isAvailable,
    double? score,
  }) : super._(
         id: id,
         storeId: storeId,
         storeName: storeName,
         storeLogoUrl: storeLogoUrl,
         name: name,
         description: description,
         price: price,
         imageUrl: imageUrl,
         categoryName: categoryName,
         isAvailable: isAvailable,
         score: score,
       );

  /// Returns a shallow copy of this [EsProductHit]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EsProductHit copyWith({
    int? id,
    Object? storeId = _Undefined,
    Object? storeName = _Undefined,
    Object? storeLogoUrl = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? price = _Undefined,
    Object? imageUrl = _Undefined,
    Object? categoryName = _Undefined,
    bool? isAvailable,
    Object? score = _Undefined,
  }) {
    return EsProductHit(
      id: id ?? this.id,
      storeId: storeId is int? ? storeId : this.storeId,
      storeName: storeName is String? ? storeName : this.storeName,
      storeLogoUrl: storeLogoUrl is String? ? storeLogoUrl : this.storeLogoUrl,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      price: price is double? ? price : this.price,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      categoryName: categoryName is String? ? categoryName : this.categoryName,
      isAvailable: isAvailable ?? this.isAvailable,
      score: score is double? ? score : this.score,
    );
  }
}
