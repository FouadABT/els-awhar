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

enum DriverAvailabilityStatus implements _i1.SerializableModel {
  offline,
  available,
  busy,
  on_break;

  static DriverAvailabilityStatus fromJson(int index) {
    switch (index) {
      case 0:
        return DriverAvailabilityStatus.offline;
      case 1:
        return DriverAvailabilityStatus.available;
      case 2:
        return DriverAvailabilityStatus.busy;
      case 3:
        return DriverAvailabilityStatus.on_break;
      default:
        throw ArgumentError(
          'Value "$index" cannot be converted to "DriverAvailabilityStatus"',
        );
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
