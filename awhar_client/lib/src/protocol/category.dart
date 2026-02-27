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

abstract class Category implements _i1.SerializableModel {
  Category._({
    this.id,
    required this.nameEn,
    this.nameAr,
    this.nameFr,
    this.nameEs,
    this.descriptionEn,
    this.descriptionAr,
    this.descriptionFr,
    this.descriptionEs,
    required this.iconName,
    this.iconUrl,
    this.colorHex,
    bool? isActive,
    int? displayOrder,
    this.parentCategoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isActive = isActive ?? true,
       displayOrder = displayOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Category({
    int? id,
    required String nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    required String iconName,
    String? iconUrl,
    String? colorHex,
    bool? isActive,
    int? displayOrder,
    int? parentCategoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CategoryImpl;

  factory Category.fromJson(Map<String, dynamic> jsonSerialization) {
    return Category(
      id: jsonSerialization['id'] as int?,
      nameEn: jsonSerialization['nameEn'] as String,
      nameAr: jsonSerialization['nameAr'] as String?,
      nameFr: jsonSerialization['nameFr'] as String?,
      nameEs: jsonSerialization['nameEs'] as String?,
      descriptionEn: jsonSerialization['descriptionEn'] as String?,
      descriptionAr: jsonSerialization['descriptionAr'] as String?,
      descriptionFr: jsonSerialization['descriptionFr'] as String?,
      descriptionEs: jsonSerialization['descriptionEs'] as String?,
      iconName: jsonSerialization['iconName'] as String,
      iconUrl: jsonSerialization['iconUrl'] as String?,
      colorHex: jsonSerialization['colorHex'] as String?,
      isActive: jsonSerialization['isActive'] as bool,
      displayOrder: jsonSerialization['displayOrder'] as int,
      parentCategoryId: jsonSerialization['parentCategoryId'] as int?,
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

  String nameEn;

  String? nameAr;

  String? nameFr;

  String? nameEs;

  String? descriptionEn;

  String? descriptionAr;

  String? descriptionFr;

  String? descriptionEs;

  String iconName;

  String? iconUrl;

  String? colorHex;

  bool isActive;

  int displayOrder;

  int? parentCategoryId;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Category]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Category copyWith({
    int? id,
    String? nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    String? iconName,
    String? iconUrl,
    String? colorHex,
    bool? isActive,
    int? displayOrder,
    int? parentCategoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Category',
      if (id != null) 'id': id,
      'nameEn': nameEn,
      if (nameAr != null) 'nameAr': nameAr,
      if (nameFr != null) 'nameFr': nameFr,
      if (nameEs != null) 'nameEs': nameEs,
      if (descriptionEn != null) 'descriptionEn': descriptionEn,
      if (descriptionAr != null) 'descriptionAr': descriptionAr,
      if (descriptionFr != null) 'descriptionFr': descriptionFr,
      if (descriptionEs != null) 'descriptionEs': descriptionEs,
      'iconName': iconName,
      if (iconUrl != null) 'iconUrl': iconUrl,
      if (colorHex != null) 'colorHex': colorHex,
      'isActive': isActive,
      'displayOrder': displayOrder,
      if (parentCategoryId != null) 'parentCategoryId': parentCategoryId,
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

class _CategoryImpl extends Category {
  _CategoryImpl({
    int? id,
    required String nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    required String iconName,
    String? iconUrl,
    String? colorHex,
    bool? isActive,
    int? displayOrder,
    int? parentCategoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         nameEn: nameEn,
         nameAr: nameAr,
         nameFr: nameFr,
         nameEs: nameEs,
         descriptionEn: descriptionEn,
         descriptionAr: descriptionAr,
         descriptionFr: descriptionFr,
         descriptionEs: descriptionEs,
         iconName: iconName,
         iconUrl: iconUrl,
         colorHex: colorHex,
         isActive: isActive,
         displayOrder: displayOrder,
         parentCategoryId: parentCategoryId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Category]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Category copyWith({
    Object? id = _Undefined,
    String? nameEn,
    Object? nameAr = _Undefined,
    Object? nameFr = _Undefined,
    Object? nameEs = _Undefined,
    Object? descriptionEn = _Undefined,
    Object? descriptionAr = _Undefined,
    Object? descriptionFr = _Undefined,
    Object? descriptionEs = _Undefined,
    String? iconName,
    Object? iconUrl = _Undefined,
    Object? colorHex = _Undefined,
    bool? isActive,
    int? displayOrder,
    Object? parentCategoryId = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: id is int? ? id : this.id,
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
      iconName: iconName ?? this.iconName,
      iconUrl: iconUrl is String? ? iconUrl : this.iconUrl,
      colorHex: colorHex is String? ? colorHex : this.colorHex,
      isActive: isActive ?? this.isActive,
      displayOrder: displayOrder ?? this.displayOrder,
      parentCategoryId: parentCategoryId is int?
          ? parentCategoryId
          : this.parentCategoryId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
