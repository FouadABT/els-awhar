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

abstract class Country implements _i1.SerializableModel {
  Country._({
    this.id,
    required this.code,
    required this.name,
    this.nameAr,
    this.nameFr,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyName,
    this.currencyNameAr,
    double? vatRate,
    String? vatName,
    this.phonePrefix,
    this.phonePlaceholder,
    String? defaultLanguage,
    double? minPrice,
    double? commissionRate,
    double? exchangeRateToMAD,
    this.exchangeRateUpdatedAt,
    bool? isActive,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : vatRate = vatRate ?? 0.0,
       vatName = vatName ?? 'VAT',
       defaultLanguage = defaultLanguage ?? 'en',
       minPrice = minPrice ?? 15.0,
       commissionRate = commissionRate ?? 0.05,
       exchangeRateToMAD = exchangeRateToMAD ?? 1.0,
       isActive = isActive ?? true,
       isDefault = isDefault ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Country({
    int? id,
    required String code,
    required String name,
    String? nameAr,
    String? nameFr,
    required String currencyCode,
    required String currencySymbol,
    required String currencyName,
    String? currencyNameAr,
    double? vatRate,
    String? vatName,
    String? phonePrefix,
    String? phonePlaceholder,
    String? defaultLanguage,
    double? minPrice,
    double? commissionRate,
    double? exchangeRateToMAD,
    DateTime? exchangeRateUpdatedAt,
    bool? isActive,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CountryImpl;

  factory Country.fromJson(Map<String, dynamic> jsonSerialization) {
    return Country(
      id: jsonSerialization['id'] as int?,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      nameAr: jsonSerialization['nameAr'] as String?,
      nameFr: jsonSerialization['nameFr'] as String?,
      currencyCode: jsonSerialization['currencyCode'] as String,
      currencySymbol: jsonSerialization['currencySymbol'] as String,
      currencyName: jsonSerialization['currencyName'] as String,
      currencyNameAr: jsonSerialization['currencyNameAr'] as String?,
      vatRate: (jsonSerialization['vatRate'] as num).toDouble(),
      vatName: jsonSerialization['vatName'] as String,
      phonePrefix: jsonSerialization['phonePrefix'] as String?,
      phonePlaceholder: jsonSerialization['phonePlaceholder'] as String?,
      defaultLanguage: jsonSerialization['defaultLanguage'] as String,
      minPrice: (jsonSerialization['minPrice'] as num).toDouble(),
      commissionRate: (jsonSerialization['commissionRate'] as num).toDouble(),
      exchangeRateToMAD: (jsonSerialization['exchangeRateToMAD'] as num)
          .toDouble(),
      exchangeRateUpdatedAt: jsonSerialization['exchangeRateUpdatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['exchangeRateUpdatedAt'],
            ),
      isActive: jsonSerialization['isActive'] as bool,
      isDefault: jsonSerialization['isDefault'] as bool,
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

  String code;

  String name;

  String? nameAr;

  String? nameFr;

  String currencyCode;

  String currencySymbol;

  String currencyName;

  String? currencyNameAr;

  double vatRate;

  String vatName;

  String? phonePrefix;

  String? phonePlaceholder;

  String defaultLanguage;

  double minPrice;

  double commissionRate;

  double exchangeRateToMAD;

  DateTime? exchangeRateUpdatedAt;

  bool isActive;

  bool isDefault;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Country]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Country copyWith({
    int? id,
    String? code,
    String? name,
    String? nameAr,
    String? nameFr,
    String? currencyCode,
    String? currencySymbol,
    String? currencyName,
    String? currencyNameAr,
    double? vatRate,
    String? vatName,
    String? phonePrefix,
    String? phonePlaceholder,
    String? defaultLanguage,
    double? minPrice,
    double? commissionRate,
    double? exchangeRateToMAD,
    DateTime? exchangeRateUpdatedAt,
    bool? isActive,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Country',
      if (id != null) 'id': id,
      'code': code,
      'name': name,
      if (nameAr != null) 'nameAr': nameAr,
      if (nameFr != null) 'nameFr': nameFr,
      'currencyCode': currencyCode,
      'currencySymbol': currencySymbol,
      'currencyName': currencyName,
      if (currencyNameAr != null) 'currencyNameAr': currencyNameAr,
      'vatRate': vatRate,
      'vatName': vatName,
      if (phonePrefix != null) 'phonePrefix': phonePrefix,
      if (phonePlaceholder != null) 'phonePlaceholder': phonePlaceholder,
      'defaultLanguage': defaultLanguage,
      'minPrice': minPrice,
      'commissionRate': commissionRate,
      'exchangeRateToMAD': exchangeRateToMAD,
      if (exchangeRateUpdatedAt != null)
        'exchangeRateUpdatedAt': exchangeRateUpdatedAt?.toJson(),
      'isActive': isActive,
      'isDefault': isDefault,
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

class _CountryImpl extends Country {
  _CountryImpl({
    int? id,
    required String code,
    required String name,
    String? nameAr,
    String? nameFr,
    required String currencyCode,
    required String currencySymbol,
    required String currencyName,
    String? currencyNameAr,
    double? vatRate,
    String? vatName,
    String? phonePrefix,
    String? phonePlaceholder,
    String? defaultLanguage,
    double? minPrice,
    double? commissionRate,
    double? exchangeRateToMAD,
    DateTime? exchangeRateUpdatedAt,
    bool? isActive,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         code: code,
         name: name,
         nameAr: nameAr,
         nameFr: nameFr,
         currencyCode: currencyCode,
         currencySymbol: currencySymbol,
         currencyName: currencyName,
         currencyNameAr: currencyNameAr,
         vatRate: vatRate,
         vatName: vatName,
         phonePrefix: phonePrefix,
         phonePlaceholder: phonePlaceholder,
         defaultLanguage: defaultLanguage,
         minPrice: minPrice,
         commissionRate: commissionRate,
         exchangeRateToMAD: exchangeRateToMAD,
         exchangeRateUpdatedAt: exchangeRateUpdatedAt,
         isActive: isActive,
         isDefault: isDefault,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Country]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Country copyWith({
    Object? id = _Undefined,
    String? code,
    String? name,
    Object? nameAr = _Undefined,
    Object? nameFr = _Undefined,
    String? currencyCode,
    String? currencySymbol,
    String? currencyName,
    Object? currencyNameAr = _Undefined,
    double? vatRate,
    String? vatName,
    Object? phonePrefix = _Undefined,
    Object? phonePlaceholder = _Undefined,
    String? defaultLanguage,
    double? minPrice,
    double? commissionRate,
    double? exchangeRateToMAD,
    Object? exchangeRateUpdatedAt = _Undefined,
    bool? isActive,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Country(
      id: id is int? ? id : this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      nameAr: nameAr is String? ? nameAr : this.nameAr,
      nameFr: nameFr is String? ? nameFr : this.nameFr,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyName: currencyName ?? this.currencyName,
      currencyNameAr: currencyNameAr is String?
          ? currencyNameAr
          : this.currencyNameAr,
      vatRate: vatRate ?? this.vatRate,
      vatName: vatName ?? this.vatName,
      phonePrefix: phonePrefix is String? ? phonePrefix : this.phonePrefix,
      phonePlaceholder: phonePlaceholder is String?
          ? phonePlaceholder
          : this.phonePlaceholder,
      defaultLanguage: defaultLanguage ?? this.defaultLanguage,
      minPrice: minPrice ?? this.minPrice,
      commissionRate: commissionRate ?? this.commissionRate,
      exchangeRateToMAD: exchangeRateToMAD ?? this.exchangeRateToMAD,
      exchangeRateUpdatedAt: exchangeRateUpdatedAt is DateTime?
          ? exchangeRateUpdatedAt
          : this.exchangeRateUpdatedAt,
      isActive: isActive ?? this.isActive,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
