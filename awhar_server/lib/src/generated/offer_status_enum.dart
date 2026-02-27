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

enum OfferStatus implements _i1.SerializableModel {
  pending,
  accepted,
  rejected,
  expired,
  withdrawn;

  static OfferStatus fromJson(int index) {
    switch (index) {
      case 0:
        return OfferStatus.pending;
      case 1:
        return OfferStatus.accepted;
      case 2:
        return OfferStatus.rejected;
      case 3:
        return OfferStatus.expired;
      case 4:
        return OfferStatus.withdrawn;
      default:
        throw ArgumentError(
          'Value "$index" cannot be converted to "OfferStatus"',
        );
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
