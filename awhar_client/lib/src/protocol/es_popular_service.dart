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

abstract class EsPopularService implements _i1.SerializableModel {
  EsPopularService._({
    required this.serviceId,
    this.serviceName,
    this.categoryName,
    required this.driverCount,
  });

  factory EsPopularService({
    required int serviceId,
    String? serviceName,
    String? categoryName,
    required int driverCount,
  }) = _EsPopularServiceImpl;

  factory EsPopularService.fromJson(Map<String, dynamic> jsonSerialization) {
    return EsPopularService(
      serviceId: jsonSerialization['serviceId'] as int,
      serviceName: jsonSerialization['serviceName'] as String?,
      categoryName: jsonSerialization['categoryName'] as String?,
      driverCount: jsonSerialization['driverCount'] as int,
    );
  }

  int serviceId;

  String? serviceName;

  String? categoryName;

  int driverCount;

  /// Returns a shallow copy of this [EsPopularService]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EsPopularService copyWith({
    int? serviceId,
    String? serviceName,
    String? categoryName,
    int? driverCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EsPopularService',
      'serviceId': serviceId,
      if (serviceName != null) 'serviceName': serviceName,
      if (categoryName != null) 'categoryName': categoryName,
      'driverCount': driverCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EsPopularServiceImpl extends EsPopularService {
  _EsPopularServiceImpl({
    required int serviceId,
    String? serviceName,
    String? categoryName,
    required int driverCount,
  }) : super._(
         serviceId: serviceId,
         serviceName: serviceName,
         categoryName: categoryName,
         driverCount: driverCount,
       );

  /// Returns a shallow copy of this [EsPopularService]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EsPopularService copyWith({
    int? serviceId,
    Object? serviceName = _Undefined,
    Object? categoryName = _Undefined,
    int? driverCount,
  }) {
    return EsPopularService(
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName is String? ? serviceName : this.serviceName,
      categoryName: categoryName is String? ? categoryName : this.categoryName,
      driverCount: driverCount ?? this.driverCount,
    );
  }
}
