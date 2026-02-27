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

abstract class Service implements _i1.SerializableModel {
  Service._({
    this.id,
    required this.categoryId,
    required this.nameEn,
    this.nameAr,
    this.nameFr,
    this.nameEs,
    this.descriptionEn,
    this.descriptionAr,
    this.descriptionFr,
    this.descriptionEs,
    this.iconName,
    this.imageUrl,
    this.suggestedPriceMin,
    this.suggestedPriceMax,
    bool? isActive,
    int? displayOrder,
    bool? isPopular,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isActive = isActive ?? true,
       displayOrder = displayOrder ?? 0,
       isPopular = isPopular ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Service({
    int? id,
    required int categoryId,
    required String nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    String? iconName,
    String? imageUrl,
    double? suggestedPriceMin,
    double? suggestedPriceMax,
    bool? isActive,
    int? displayOrder,
    bool? isPopular,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ServiceImpl;

  factory Service.fromJson(Map<String, dynamic> jsonSerialization) {
    return Service(
      id: jsonSerialization['id'] as int?,
      categoryId: jsonSerialization['categoryId'] as int,
      nameEn: jsonSerialization['nameEn'] as String,
      nameAr: jsonSerialization['nameAr'] as String?,
      nameFr: jsonSerialization['nameFr'] as String?,
      nameEs: jsonSerialization['nameEs'] as String?,
      descriptionEn: jsonSerialization['descriptionEn'] as String?,
      descriptionAr: jsonSerialization['descriptionAr'] as String?,
      descriptionFr: jsonSerialization['descriptionFr'] as String?,
      descriptionEs: jsonSerialization['descriptionEs'] as String?,
      iconName: jsonSerialization['iconName'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      suggestedPriceMin: (jsonSerialization['suggestedPriceMin'] as num?)
          ?.toDouble(),
      suggestedPriceMax: (jsonSerialization['suggestedPriceMax'] as num?)
          ?.toDouble(),
      isActive: jsonSerialization['isActive'] as bool,
      displayOrder: jsonSerialization['displayOrder'] as int,
      isPopular: jsonSerialization['isPopular'] as bool,
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

  int categoryId;

  String nameEn;

  String? nameAr;

  String? nameFr;

  String? nameEs;

  String? descriptionEn;

  String? descriptionAr;

  String? descriptionFr;

  String? descriptionEs;

  String? iconName;

  String? imageUrl;

  double? suggestedPriceMin;

  double? suggestedPriceMax;

  bool isActive;

  int displayOrder;

  bool isPopular;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Service]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Service copyWith({
    int? id,
    int? categoryId,
    String? nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    String? iconName,
    String? imageUrl,
    double? suggestedPriceMin,
    double? suggestedPriceMax,
    bool? isActive,
    int? displayOrder,
    bool? isPopular,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Service',
      if (id != null) 'id': id,
      'categoryId': categoryId,
      'nameEn': nameEn,
      if (nameAr != null) 'nameAr': nameAr,
      if (nameFr != null) 'nameFr': nameFr,
      if (nameEs != null) 'nameEs': nameEs,
      if (descriptionEn != null) 'descriptionEn': descriptionEn,
      if (descriptionAr != null) 'descriptionAr': descriptionAr,
      if (descriptionFr != null) 'descriptionFr': descriptionFr,
      if (descriptionEs != null) 'descriptionEs': descriptionEs,
      if (iconName != null) 'iconName': iconName,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (suggestedPriceMin != null) 'suggestedPriceMin': suggestedPriceMin,
      if (suggestedPriceMax != null) 'suggestedPriceMax': suggestedPriceMax,
      'isActive': isActive,
      'displayOrder': displayOrder,
      'isPopular': isPopular,
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

class _ServiceImpl extends Service {
  _ServiceImpl({
    int? id,
    required int categoryId,
    required String nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    String? iconName,
    String? imageUrl,
    double? suggestedPriceMin,
    double? suggestedPriceMax,
    bool? isActive,
    int? displayOrder,
    bool? isPopular,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         categoryId: categoryId,
         nameEn: nameEn,
         nameAr: nameAr,
         nameFr: nameFr,
         nameEs: nameEs,
         descriptionEn: descriptionEn,
         descriptionAr: descriptionAr,
         descriptionFr: descriptionFr,
         descriptionEs: descriptionEs,
         iconName: iconName,
         imageUrl: imageUrl,
         suggestedPriceMin: suggestedPriceMin,
         suggestedPriceMax: suggestedPriceMax,
         isActive: isActive,
         displayOrder: displayOrder,
         isPopular: isPopular,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Service]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Service copyWith({
    Object? id = _Undefined,
    int? categoryId,
    String? nameEn,
    Object? nameAr = _Undefined,
    Object? nameFr = _Undefined,
    Object? nameEs = _Undefined,
    Object? descriptionEn = _Undefined,
    Object? descriptionAr = _Undefined,
    Object? descriptionFr = _Undefined,
    Object? descriptionEs = _Undefined,
    Object? iconName = _Undefined,
    Object? imageUrl = _Undefined,
    Object? suggestedPriceMin = _Undefined,
    Object? suggestedPriceMax = _Undefined,
    bool? isActive,
    int? displayOrder,
    bool? isPopular,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Service(
      id: id is int? ? id : this.id,
      categoryId: categoryId ?? this.categoryId,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr is String? ? nameAr : this.nameAr,
      nameFr: nameFr is String? ? nameFr : this.nameFr,
      nameEs: nameEs is String? ? nameEs : this.nameEs,
      descriptionEn: descriptionEn is String?
          ? descriptionEn
          : this.descriptionEn,
      descriptionAr: descriptionAr is String?
          ? descriptionAr
          : this.descriptionAr,
      descriptionFr: descriptionFr is String?
          ? descriptionFr
          : this.descriptionFr,
      descriptionEs: descriptionEs is String?
          ? descriptionEs
          : this.descriptionEs,
      iconName: iconName is String? ? iconName : this.iconName,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      suggestedPriceMin: suggestedPriceMin is double?
          ? suggestedPriceMin
          : this.suggestedPriceMin,
      suggestedPriceMax: suggestedPriceMax is double?
          ? suggestedPriceMax
          : this.suggestedPriceMax,
      isActive: isActive ?? this.isActive,
      displayOrder: displayOrder ?? this.displayOrder,
      isPopular: isPopular ?? this.isPopular,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
