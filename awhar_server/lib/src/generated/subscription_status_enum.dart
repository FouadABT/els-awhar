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

enum SubscriptionStatus implements _i1.SerializableModel {
  active,
  expired,
  cancelled,
  pending_payment;

  static SubscriptionStatus fromJson(int index) {
    switch (index) {
      case 0:
        return SubscriptionStatus.active;
      case 1:
        return SubscriptionStatus.expired;
      case 2:
        return SubscriptionStatus.cancelled;
      case 3:
        return SubscriptionStatus.pending_payment;
      default:
        throw ArgumentError(
          'Value "$index" cannot be converted to "SubscriptionStatus"',
        );
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
