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

enum PriceNegotiationStatus implements _i1.SerializableModel {
  waiting_for_offers,
  offer_received,
  client_countered,
  driver_countered,
  price_agreed,
  negotiation_failed;

  static PriceNegotiationStatus fromJson(int index) {
    switch (index) {
      case 0:
        return PriceNegotiationStatus.waiting_for_offers;
      case 1:
        return PriceNegotiationStatus.offer_received;
      case 2:
        return PriceNegotiationStatus.client_countered;
      case 3:
        return PriceNegotiationStatus.driver_countered;
      case 4:
        return PriceNegotiationStatus.price_agreed;
      case 5:
        return PriceNegotiationStatus.negotiation_failed;
      default:
        throw ArgumentError(
          'Value "$index" cannot be converted to "PriceNegotiationStatus"',
        );
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
