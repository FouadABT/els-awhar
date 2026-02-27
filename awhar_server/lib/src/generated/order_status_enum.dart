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

enum OrderStatus implements _i1.SerializableModel {
  pending,
  negotiating,
  accepted,
  driver_en_route,
  arrived,
  in_progress,
  completed,
  rated,
  expired,
  cancelled_by_client,
  cancelled_by_driver,
  cancelled_by_admin,
  disputed;

  static OrderStatus fromJson(int index) {
    switch (index) {
      case 0:
        return OrderStatus.pending;
      case 1:
        return OrderStatus.negotiating;
      case 2:
        return OrderStatus.accepted;
      case 3:
        return OrderStatus.driver_en_route;
      case 4:
        return OrderStatus.arrived;
      case 5:
        return OrderStatus.in_progress;
      case 6:
        return OrderStatus.completed;
      case 7:
        return OrderStatus.rated;
      case 8:
        return OrderStatus.expired;
      case 9:
        return OrderStatus.cancelled_by_client;
      case 10:
        return OrderStatus.cancelled_by_driver;
      case 11:
        return OrderStatus.cancelled_by_admin;
      case 12:
        return OrderStatus.disputed;
      default:
        throw ArgumentError(
          'Value "$index" cannot be converted to "OrderStatus"',
        );
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
