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
import 'package:awhar_client/src/protocol/protocol.dart' as _i2;

abstract class SubscriptionPlan implements _i1.SerializableModel {
  SubscriptionPlan._({
    this.id,
    required this.nameEn,
    this.nameAr,
    this.nameFr,
    this.nameEs,
    this.descriptionEn,
    this.descriptionAr,
    this.descriptionFr,
    this.descriptionEs,
    required this.priceAmount,
    String? currency,
    required this.durationMonths,
    required this.features,
    bool? isActive,
    bool? isFeatured,
    int? displayOrder,
    this.commissionRate,
    bool? priorityListing,
    bool? badgeEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : currency = currency ?? 'MAD',
       isActive = isActive ?? true,
       isFeatured = isFeatured ?? false,
       displayOrder = displayOrder ?? 0,
       priorityListing = priorityListing ?? false,
       badgeEnabled = badgeEnabled ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SubscriptionPlan({
    int? id,
    required String nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    required double priceAmount,
    String? currency,
    required int durationMonths,
    required List<String> features,
    bool? isActive,
    bool? isFeatured,
    int? displayOrder,
    double? commissionRate,
    bool? priorityListing,
    bool? badgeEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubscriptionPlanImpl;

  factory SubscriptionPlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubscriptionPlan(
      id: jsonSerialization['id'] as int?,
      nameEn: jsonSerialization['nameEn'] as String,
      nameAr: jsonSerialization['nameAr'] as String?,
      nameFr: jsonSerialization['nameFr'] as String?,
      nameEs: jsonSerialization['nameEs'] as String?,
      descriptionEn: jsonSerialization['descriptionEn'] as String?,
      descriptionAr: jsonSerialization['descriptionAr'] as String?,
      descriptionFr: jsonSerialization['descriptionFr'] as String?,
      descriptionEs: jsonSerialization['descriptionEs'] as String?,
      priceAmount: (jsonSerialization['priceAmount'] as num).toDouble(),
      currency: jsonSerialization['currency'] as String,
      durationMonths: jsonSerialization['durationMonths'] as int,
      features: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['features'],
      ),
      isActive: jsonSerialization['isActive'] as bool,
      isFeatured: jsonSerialization['isFeatured'] as bool,
      displayOrder: jsonSerialization['displayOrder'] as int,
      commissionRate: (jsonSerialization['commissionRate'] as num?)?.toDouble(),
      priorityListing: jsonSerialization['priorityListing'] as bool,
      badgeEnabled: jsonSerialization['badgeEnabled'] as bool,
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

  double priceAmount;

  String currency;

  int durationMonths;

  List<String> features;

  bool isActive;

  bool isFeatured;

  int displayOrder;

  double? commissionRate;

  bool priorityListing;

  bool badgeEnabled;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [SubscriptionPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubscriptionPlan copyWith({
    int? id,
    String? nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    double? priceAmount,
    String? currency,
    int? durationMonths,
    List<String>? features,
    bool? isActive,
    bool? isFeatured,
    int? displayOrder,
    double? commissionRate,
    bool? priorityListing,
    bool? badgeEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubscriptionPlan',
      if (id != null) 'id': id,
      'nameEn': nameEn,
      if (nameAr != null) 'nameAr': nameAr,
      if (nameFr != null) 'nameFr': nameFr,
      if (nameEs != null) 'nameEs': nameEs,
      if (descriptionEn != null) 'descriptionEn': descriptionEn,
      if (descriptionAr != null) 'descriptionAr': descriptionAr,
      if (descriptionFr != null) 'descriptionFr': descriptionFr,
      if (descriptionEs != null) 'descriptionEs': descriptionEs,
      'priceAmount': priceAmount,
      'currency': currency,
      'durationMonths': durationMonths,
      'features': features.toJson(),
      'isActive': isActive,
      'isFeatured': isFeatured,
      'displayOrder': displayOrder,
      if (commissionRate != null) 'commissionRate': commissionRate,
      'priorityListing': priorityListing,
      'badgeEnabled': badgeEnabled,
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

class _SubscriptionPlanImpl extends SubscriptionPlan {
  _SubscriptionPlanImpl({
    int? id,
    required String nameEn,
    String? nameAr,
    String? nameFr,
    String? nameEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    required double priceAmount,
    String? currency,
    required int durationMonths,
    required List<String> features,
    bool? isActive,
    bool? isFeatured,
    int? displayOrder,
    double? commissionRate,
    bool? priorityListing,
    bool? badgeEnabled,
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
         priceAmount: priceAmount,
         currency: currency,
         durationMonths: durationMonths,
         features: features,
         isActive: isActive,
         isFeatured: isFeatured,
         displayOrder: displayOrder,
         commissionRate: commissionRate,
         priorityListing: priorityListing,
         badgeEnabled: badgeEnabled,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SubscriptionPlan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubscriptionPlan copyWith({
    Object? id = _Undefined,
    String? nameEn,
    Object? nameAr = _Undefined,
    Object? nameFr = _Undefined,
    Object? nameEs = _Undefined,
    Object? descriptionEn = _Undefined,
    Object? descriptionAr = _Undefined,
    Object? descriptionFr = _Undefined,
    Object? descriptionEs = _Undefined,
    double? priceAmount,
    String? currency,
    int? durationMonths,
    List<String>? features,
    bool? isActive,
    bool? isFeatured,
    int? displayOrder,
    Object? commissionRate = _Undefined,
    bool? priorityListing,
    bool? badgeEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubscriptionPlan(
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
      priceAmount: priceAmount ?? this.priceAmount,
      currency: currency ?? this.currency,
      durationMonths: durationMonths ?? this.durationMonths,
      features: features ?? this.features.map((e0) => e0).toList(),
      isActive: isActive ?? this.isActive,
      isFeatured: isFeatured ?? this.isFeatured,
      displayOrder: displayOrder ?? this.displayOrder,
      commissionRate: commissionRate is double?
          ? commissionRate
          : this.commissionRate,
      priorityListing: priorityListing ?? this.priorityListing,
      badgeEnabled: badgeEnabled ?? this.badgeEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
