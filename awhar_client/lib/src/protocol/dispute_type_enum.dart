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

enum DisputeType implements _i1.SerializableModel {
  late_arrival,
  service_quality,
  payment_issue,
  behavior_issue,
  damaged_item,
  other;

  static DisputeType fromJson(int index) {
    switch (index) {
      case 0:
        return DisputeType.late_arrival;
      case 1:
        return DisputeType.service_quality;
      case 2:
        return DisputeType.payment_issue;
      case 3:
        return DisputeType.behavior_issue;
      case 4:
        return DisputeType.damaged_item;
      case 5:
        return DisputeType.other;
      default:
        throw ArgumentError(
          'Value "$index" cannot be converted to "DisputeType"',
        );
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
