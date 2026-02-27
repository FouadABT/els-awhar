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

enum AdminActionType implements _i1.SerializableModel {
  user_suspended,
  user_banned,
  user_activated,
  driver_verified,
  driver_rejected,
  dispute_resolved,
  content_removed,
  refund_issued;

  static AdminActionType fromJson(int index) {
    switch (index) {
      case 0:
        return AdminActionType.user_suspended;
      case 1:
        return AdminActionType.user_banned;
      case 2:
        return AdminActionType.user_activated;
      case 3:
        return AdminActionType.driver_verified;
      case 4:
        return AdminActionType.driver_rejected;
      case 5:
        return AdminActionType.dispute_resolved;
      case 6:
        return AdminActionType.content_removed;
      case 7:
        return AdminActionType.refund_issued;
      default:
        throw ArgumentError(
          'Value "$index" cannot be converted to "AdminActionType"',
        );
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
