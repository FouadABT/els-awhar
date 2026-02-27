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
import 'es_popular_service.dart' as _i2;
import 'package:awhar_server/src/generated/protocol.dart' as _i3;

abstract class EsPopularServicesResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  EsPopularServicesResult._({required this.services});

  factory EsPopularServicesResult({
    required List<_i2.EsPopularService> services,
  }) = _EsPopularServicesResultImpl;

  factory EsPopularServicesResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EsPopularServicesResult(
      services: _i3.Protocol().deserialize<List<_i2.EsPopularService>>(
        jsonSerialization['services'],
      ),
    );
  }

  List<_i2.EsPopularService> services;

  /// Returns a shallow copy of this [EsPopularServicesResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EsPopularServicesResult copyWith({List<_i2.EsPopularService>? services});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EsPopularServicesResult',
      'services': services.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EsPopularServicesResult',
      'services': services.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _EsPopularServicesResultImpl extends EsPopularServicesResult {
  _EsPopularServicesResultImpl({required List<_i2.EsPopularService> services})
    : super._(services: services);

  /// Returns a shallow copy of this [EsPopularServicesResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EsPopularServicesResult copyWith({List<_i2.EsPopularService>? services}) {
    return EsPopularServicesResult(
      services: services ?? this.services.map((e0) => e0.copyWith()).toList(),
    );
  }
}
