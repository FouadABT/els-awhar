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

abstract class Promo implements _i1.SerializableModel {
  Promo._({
    this.id,
    required this.titleEn,
    this.titleAr,
    this.titleFr,
    this.titleEs,
    this.descriptionEn,
    this.descriptionAr,
    this.descriptionFr,
    this.descriptionEs,
    required this.imageUrl,
    required this.targetRoles,
    String? actionType,
    this.actionValue,
    int? priority,
    bool? isActive,
    this.startDate,
    this.endDate,
    int? viewCount,
    int? clickCount,
    required this.createdAt,
    this.updatedAt,
    this.createdBy,
  }) : actionType = actionType ?? 'none',
       priority = priority ?? 0,
       isActive = isActive ?? true,
       viewCount = viewCount ?? 0,
       clickCount = clickCount ?? 0;

  factory Promo({
    int? id,
    required String titleEn,
    String? titleAr,
    String? titleFr,
    String? titleEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    required String imageUrl,
    required String targetRoles,
    String? actionType,
    String? actionValue,
    int? priority,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
    int? viewCount,
    int? clickCount,
    required DateTime createdAt,
    DateTime? updatedAt,
    int? createdBy,
  }) = _PromoImpl;

  factory Promo.fromJson(Map<String, dynamic> jsonSerialization) {
    return Promo(
      id: jsonSerialization['id'] as int?,
      titleEn: jsonSerialization['titleEn'] as String,
      titleAr: jsonSerialization['titleAr'] as String?,
      titleFr: jsonSerialization['titleFr'] as String?,
      titleEs: jsonSerialization['titleEs'] as String?,
      descriptionEn: jsonSerialization['descriptionEn'] as String?,
      descriptionAr: jsonSerialization['descriptionAr'] as String?,
      descriptionFr: jsonSerialization['descriptionFr'] as String?,
      descriptionEs: jsonSerialization['descriptionEs'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String,
      targetRoles: jsonSerialization['targetRoles'] as String,
      actionType: jsonSerialization['actionType'] as String,
      actionValue: jsonSerialization['actionValue'] as String?,
      priority: jsonSerialization['priority'] as int,
      isActive: jsonSerialization['isActive'] as bool,
      startDate: jsonSerialization['startDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startDate']),
      endDate: jsonSerialization['endDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      viewCount: jsonSerialization['viewCount'] as int,
      clickCount: jsonSerialization['clickCount'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      createdBy: jsonSerialization['createdBy'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String titleEn;

  String? titleAr;

  String? titleFr;

  String? titleEs;

  String? descriptionEn;

  String? descriptionAr;

  String? descriptionFr;

  String? descriptionEs;

  String imageUrl;

  String targetRoles;

  String actionType;

  String? actionValue;

  int priority;

  bool isActive;

  DateTime? startDate;

  DateTime? endDate;

  int viewCount;

  int clickCount;

  DateTime createdAt;

  DateTime? updatedAt;

  int? createdBy;

  /// Returns a shallow copy of this [Promo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Promo copyWith({
    int? id,
    String? titleEn,
    String? titleAr,
    String? titleFr,
    String? titleEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    String? imageUrl,
    String? targetRoles,
    String? actionType,
    String? actionValue,
    int? priority,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
    int? viewCount,
    int? clickCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? createdBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Promo',
      if (id != null) 'id': id,
      'titleEn': titleEn,
      if (titleAr != null) 'titleAr': titleAr,
      if (titleFr != null) 'titleFr': titleFr,
      if (titleEs != null) 'titleEs': titleEs,
      if (descriptionEn != null) 'descriptionEn': descriptionEn,
      if (descriptionAr != null) 'descriptionAr': descriptionAr,
      if (descriptionFr != null) 'descriptionFr': descriptionFr,
      if (descriptionEs != null) 'descriptionEs': descriptionEs,
      'imageUrl': imageUrl,
      'targetRoles': targetRoles,
      'actionType': actionType,
      if (actionValue != null) 'actionValue': actionValue,
      'priority': priority,
      'isActive': isActive,
      if (startDate != null) 'startDate': startDate?.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      'viewCount': viewCount,
      'clickCount': clickCount,
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (createdBy != null) 'createdBy': createdBy,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PromoImpl extends Promo {
  _PromoImpl({
    int? id,
    required String titleEn,
    String? titleAr,
    String? titleFr,
    String? titleEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    required String imageUrl,
    required String targetRoles,
    String? actionType,
    String? actionValue,
    int? priority,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
    int? viewCount,
    int? clickCount,
    required DateTime createdAt,
    DateTime? updatedAt,
    int? createdBy,
  }) : super._(
         id: id,
         titleEn: titleEn,
         titleAr: titleAr,
         titleFr: titleFr,
         titleEs: titleEs,
         descriptionEn: descriptionEn,
         descriptionAr: descriptionAr,
         descriptionFr: descriptionFr,
         descriptionEs: descriptionEs,
         imageUrl: imageUrl,
         targetRoles: targetRoles,
         actionType: actionType,
         actionValue: actionValue,
         priority: priority,
         isActive: isActive,
         startDate: startDate,
         endDate: endDate,
         viewCount: viewCount,
         clickCount: clickCount,
         createdAt: createdAt,
         updatedAt: updatedAt,
         createdBy: createdBy,
       );

  /// Returns a shallow copy of this [Promo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Promo copyWith({
    Object? id = _Undefined,
    String? titleEn,
    Object? titleAr = _Undefined,
    Object? titleFr = _Undefined,
    Object? titleEs = _Undefined,
    Object? descriptionEn = _Undefined,
    Object? descriptionAr = _Undefined,
    Object? descriptionFr = _Undefined,
    Object? descriptionEs = _Undefined,
    String? imageUrl,
    String? targetRoles,
    String? actionType,
    Object? actionValue = _Undefined,
    int? priority,
    bool? isActive,
    Object? startDate = _Undefined,
    Object? endDate = _Undefined,
    int? viewCount,
    int? clickCount,
    DateTime? createdAt,
    Object? updatedAt = _Undefined,
    Object? createdBy = _Undefined,
  }) {
    return Promo(
      id: id is int? ? id : this.id,
      titleEn: titleEn ?? this.titleEn,
      titleAr: titleAr is String? ? titleAr : this.titleAr,
      titleFr: titleFr is String? ? titleFr : this.titleFr,
      titleEs: titleEs is String? ? titleEs : this.titleEs,
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
      imageUrl: imageUrl ?? this.imageUrl,
      targetRoles: targetRoles ?? this.targetRoles,
      actionType: actionType ?? this.actionType,
      actionValue: actionValue is String? ? actionValue : this.actionValue,
      priority: priority ?? this.priority,
      isActive: isActive ?? this.isActive,
      startDate: startDate is DateTime? ? startDate : this.startDate,
      endDate: endDate is DateTime? ? endDate : this.endDate,
      viewCount: viewCount ?? this.viewCount,
      clickCount: clickCount ?? this.clickCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      createdBy: createdBy is int? ? createdBy : this.createdBy,
    );
  }
}
