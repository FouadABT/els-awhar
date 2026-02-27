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

enum RequestStatus implements _i1.SerializableModel {
  pending,
  driver_proposed,
  accepted,
  driver_arriving,
  in_progress,
  completed,
  cancelled;

  static RequestStatus fromJson(String name) {
    switch (name) {
      case 'pending':
        return RequestStatus.pending;
      case 'driver_proposed':
        return RequestStatus.driver_proposed;
      case 'accepted':
        return RequestStatus.accepted;
      case 'driver_arriving':
        return RequestStatus.driver_arriving;
      case 'in_progress':
        return RequestStatus.in_progress;
      case 'completed':
        return RequestStatus.completed;
      case 'cancelled':
        return RequestStatus.cancelled;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "RequestStatus"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
