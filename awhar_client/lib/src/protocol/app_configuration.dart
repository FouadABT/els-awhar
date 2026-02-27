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

abstract class AppConfiguration implements _i1.SerializableModel {
  AppConfiguration._({
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyName,
    required this.minPrice,
    required this.commissionRate,
    required this.appName,
    required this.supportEmail,
    required this.supportPhone,
    required this.termsUrl,
    required this.privacyUrl,
    required this.maxImageSizeMb,
    required this.defaultLanguage,
  });

  factory AppConfiguration({
    required String currencyCode,
    required String currencySymbol,
    required String currencyName,
    required double minPrice,
    required double commissionRate,
    required String appName,
    required String supportEmail,
    required String supportPhone,
    required String termsUrl,
    required String privacyUrl,
    required double maxImageSizeMb,
    required String defaultLanguage,
  }) = _AppConfigurationImpl;

  factory AppConfiguration.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppConfiguration(
      currencyCode: jsonSerialization['currencyCode'] as String,
      currencySymbol: jsonSerialization['currencySymbol'] as String,
      currencyName: jsonSerialization['currencyName'] as String,
      minPrice: (jsonSerialization['minPrice'] as num).toDouble(),
      commissionRate: (jsonSerialization['commissionRate'] as num).toDouble(),
      appName: jsonSerialization['appName'] as String,
      supportEmail: jsonSerialization['supportEmail'] as String,
      supportPhone: jsonSerialization['supportPhone'] as String,
      termsUrl: jsonSerialization['termsUrl'] as String,
      privacyUrl: jsonSerialization['privacyUrl'] as String,
      maxImageSizeMb: (jsonSerialization['maxImageSizeMb'] as num).toDouble(),
      defaultLanguage: jsonSerialization['defaultLanguage'] as String,
    );
  }

  /// Currency settings
  String currencyCode;

  String currencySymbol;

  String currencyName;

  /// Pricing settings
  double minPrice;

  double commissionRate;

  /// App info
  String appName;

  String supportEmail;

  String supportPhone;

  String termsUrl;

  String privacyUrl;

  /// Upload settings
  double maxImageSizeMb;

  /// Localization
  String defaultLanguage;

  /// Returns a shallow copy of this [AppConfiguration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AppConfiguration copyWith({
    String? currencyCode,
    String? currencySymbol,
    String? currencyName,
    double? minPrice,
    double? commissionRate,
    String? appName,
    String? supportEmail,
    String? supportPhone,
    String? termsUrl,
    String? privacyUrl,
    double? maxImageSizeMb,
    String? defaultLanguage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppConfiguration',
      'currencyCode': currencyCode,
      'currencySymbol': currencySymbol,
      'currencyName': currencyName,
      'minPrice': minPrice,
      'commissionRate': commissionRate,
      'appName': appName,
      'supportEmail': supportEmail,
      'supportPhone': supportPhone,
      'termsUrl': termsUrl,
      'privacyUrl': privacyUrl,
      'maxImageSizeMb': maxImageSizeMb,
      'defaultLanguage': defaultLanguage,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AppConfigurationImpl extends AppConfiguration {
  _AppConfigurationImpl({
    required String currencyCode,
    required String currencySymbol,
    required String currencyName,
    required double minPrice,
    required double commissionRate,
    required String appName,
    required String supportEmail,
    required String supportPhone,
    required String termsUrl,
    required String privacyUrl,
    required double maxImageSizeMb,
    required String defaultLanguage,
  }) : super._(
         currencyCode: currencyCode,
         currencySymbol: currencySymbol,
         currencyName: currencyName,
         minPrice: minPrice,
         commissionRate: commissionRate,
         appName: appName,
         supportEmail: supportEmail,
         supportPhone: supportPhone,
         termsUrl: termsUrl,
         privacyUrl: privacyUrl,
         maxImageSizeMb: maxImageSizeMb,
         defaultLanguage: defaultLanguage,
       );

  /// Returns a shallow copy of this [AppConfiguration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AppConfiguration copyWith({
    String? currencyCode,
    String? currencySymbol,
    String? currencyName,
    double? minPrice,
    double? commissionRate,
    String? appName,
    String? supportEmail,
    String? supportPhone,
    String? termsUrl,
    String? privacyUrl,
    double? maxImageSizeMb,
    String? defaultLanguage,
  }) {
    return AppConfiguration(
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyName: currencyName ?? this.currencyName,
      minPrice: minPrice ?? this.minPrice,
      commissionRate: commissionRate ?? this.commissionRate,
      appName: appName ?? this.appName,
      supportEmail: supportEmail ?? this.supportEmail,
      supportPhone: supportPhone ?? this.supportPhone,
      termsUrl: termsUrl ?? this.termsUrl,
      privacyUrl: privacyUrl ?? this.privacyUrl,
      maxImageSizeMb: maxImageSizeMb ?? this.maxImageSizeMb,
      defaultLanguage: defaultLanguage ?? this.defaultLanguage,
    );
  }
}
