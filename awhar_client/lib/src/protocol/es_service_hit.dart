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

abstract class EsServiceHit implements _i1.SerializableModel {
  EsServiceHit._({
    required this.id,
    this.categoryId,
    this.categoryName,
    this.nameEn,
    this.nameAr,
    this.nameFr,
    this.nameEs,
    this.descriptionEn,
    required this.isActive,
    this.score,
  });

  factory EsServiceHit({
    required int id,
    int? categoryId,
    String? categoryName,
    String? nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    required bool isActive,
    double? score,
  }) = _EsServiceHitImpl;

  factory EsServiceHit.fromJson(Map<String, dynamic> jsonSerialization) {
    return EsServiceHit(
      id: jsonSerialization['id'] as int,
      categoryId: jsonSerialization['categoryId'] as int?,
      categoryName: jsonSerialization['categoryName'] as String?,
      nameEn: jsonSerialization['nameEn'] as String?,
      nameAr: jsonSerialization['nameAr'] as String?,
      nameFr: jsonSerialization['nameFr'] as String?,
      nameEs: jsonSerialization['nameEs'] as String?,
      descriptionEn: jsonSerialization['descriptionEn'] as String?,
      isActive: jsonSerialization['isActive'] as bool,
      score: (jsonSerialization['score'] as num?)?.toDouble(),
    );
  }

  int id;

  int? categoryId;

  String? categoryName;

  String? nameEn;

  String? nameAr;

  String? nameFr;

  String? nameEs;

  String? descriptionEn;

  bool isActive;

  double? score;

  /// Returns a shallow copy of this [EsServiceHit]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EsServiceHit copyWith({
    int? id,
    int? categoryId,
    String? categoryName,
    String? nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    bool? isActive,
    double? score,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EsServiceHit',
      'id': id,
      if (categoryId != null) 'categoryId': categoryId,
      if (categoryName != null) 'categoryName': categoryName,
      if (nameEn != null) 'nameEn': nameEn,
      if (nameAr != null) 'nameAr': nameAr,
      if (nameFr != null) 'nameFr': nameFr,
      if (nameEs != null) 'nameEs': nameEs,
      if (descriptionEn != null) 'descriptionEn': descriptionEn,
      'isActive': isActive,
      if (score != null) 'score': score,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EsServiceHitImpl extends EsServiceHit {
  _EsServiceHitImpl({
    required int id,
    int? categoryId,
    String? categoryName,
    String? nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    required bool isActive,
    double? score,
  }) : super._(
         id: id,
         categoryId: categoryId,
         categoryName: categoryName,
         nameEn: nameEn,
         nameAr: nameAr,
         nameFr: nameFr,
         nameEs: nameEs,
         descriptionEn: descriptionEn,
         isActive: isActive,
         score: score,
       );

  /// Returns a shallow copy of this [EsServiceHit]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EsServiceHit copyWith({
    int? id,
    Object? categoryId = _Undefined,
    Object? categoryName = _Undefined,
    Object? nameEn = _Undefined,
    Object? nameAr = _Undefined,
    Object? nameFr = _Undefined,
    Object? nameEs = _Undefined,
    Object? descriptionEn = _Undefined,
    bool? isActive,
    Object? score = _Undefined,
  }) {
    return EsServiceHit(
      id: id ?? this.id,
      categoryId: categoryId is int? ? categoryId : this.categoryId,
      categoryName: categoryName is String? ? categoryName : this.categoryName,
      nameEn: nameEn is String? ? nameEn : this.nameEn,
      nameAr: nameAr is String? ? nameAr : this.nameAr,
      nameFr: nameFr is String? ? nameFr : this.nameFr,
      nameEs: nameEs is String? ? nameEs : this.nameEs,
      descriptionEn: descriptionEn is String?
          ? descriptionEn
          : this.descriptionEn,
      isActive: isActive ?? this.isActive,
      score: score is double? ? score : this.score,
    );
  }
}
