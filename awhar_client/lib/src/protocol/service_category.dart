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

abstract class ServiceCategory implements _i1.SerializableModel {
  ServiceCategory._({
    this.id,
    required this.name,
    required this.nameAr,
    required this.nameFr,
    this.nameEs,
    required this.icon,
    this.description,
    int? displayOrder,
    bool? isActive,
    double? defaultRadiusKm,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : displayOrder = displayOrder ?? 0,
       isActive = isActive ?? true,
       defaultRadiusKm = defaultRadiusKm ?? 10.0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory ServiceCategory({
    int? id,
    required String name,
    required String nameAr,
    required String nameFr,
    String? nameEs,
    required String icon,
    String? description,
    int? displayOrder,
    bool? isActive,
    double? defaultRadiusKm,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ServiceCategoryImpl;

  factory ServiceCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return ServiceCategory(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      nameAr: jsonSerialization['nameAr'] as String,
      nameFr: jsonSerialization['nameFr'] as String,
      nameEs: jsonSerialization['nameEs'] as String?,
      icon: jsonSerialization['icon'] as String,
      description: jsonSerialization['description'] as String?,
      displayOrder: jsonSerialization['displayOrder'] as int,
      isActive: jsonSerialization['isActive'] as bool,
      defaultRadiusKm: (jsonSerialization['defaultRadiusKm'] as num).toDouble(),
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

  String name;

  String nameAr;

  String nameFr;

  String? nameEs;

  String icon;

  String? description;

  int displayOrder;

  bool isActive;

  double defaultRadiusKm;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ServiceCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ServiceCategory copyWith({
    int? id,
    String? name,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? icon,
    String? description,
    int? displayOrder,
    bool? isActive,
    double? defaultRadiusKm,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ServiceCategory',
      if (id != null) 'id': id,
      'name': name,
      'nameAr': nameAr,
      'nameFr': nameFr,
      if (nameEs != null) 'nameEs': nameEs,
      'icon': icon,
      if (description != null) 'description': description,
      'displayOrder': displayOrder,
      'isActive': isActive,
      'defaultRadiusKm': defaultRadiusKm,
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

class _ServiceCategoryImpl extends ServiceCategory {
  _ServiceCategoryImpl({
    int? id,
    required String name,
    required String nameAr,
    required String nameFr,
    String? nameEs,
    required String icon,
    String? description,
    int? displayOrder,
    bool? isActive,
    double? defaultRadiusKm,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         nameAr: nameAr,
         nameFr: nameFr,
         nameEs: nameEs,
         icon: icon,
         description: description,
         displayOrder: displayOrder,
         isActive: isActive,
         defaultRadiusKm: defaultRadiusKm,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ServiceCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ServiceCategory copyWith({
    Object? id = _Undefined,
    String? name,
    String? nameAr,
    String? nameFr,
    Object? nameEs = _Undefined,
    String? icon,
    Object? description = _Undefined,
    int? displayOrder,
    bool? isActive,
    double? defaultRadiusKm,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ServiceCategory(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      nameFr: nameFr ?? this.nameFr,
      nameEs: nameEs is String? ? nameEs : this.nameEs,
      icon: icon ?? this.icon,
      description: description is String? ? description : this.description,
      displayOrder: displayOrder ?? this.displayOrder,
      isActive: isActive ?? this.isActive,
      defaultRadiusKm: defaultRadiusKm ?? this.defaultRadiusKm,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
