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

enum StoreOrderStatus implements _i1.SerializableModel {
  pending,
  confirmed,
  preparing,
  ready,
  driverAssigned,
  pickedUp,
  inDelivery,
  delivered,
  cancelled,
  rejected;

  static StoreOrderStatus fromJson(int index) {
    switch (index) {
      case 0:
        return StoreOrderStatus.pending;
      case 1:
        return StoreOrderStatus.confirmed;
      case 2:
        return StoreOrderStatus.preparing;
      case 3:
        return StoreOrderStatus.ready;
      case 4:
        return StoreOrderStatus.driverAssigned;
      case 5:
        return StoreOrderStatus.pickedUp;
      case 6:
        return StoreOrderStatus.inDelivery;
      case 7:
        return StoreOrderStatus.delivered;
      case 8:
        return StoreOrderStatus.cancelled;
      case 9:
        return StoreOrderStatus.rejected;
      default:
        throw ArgumentError(
          'Value "$index" cannot be converted to "StoreOrderStatus"',
        );
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
