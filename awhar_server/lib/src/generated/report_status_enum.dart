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

enum ReportStatus implements _i1.SerializableModel {
  pending,
  under_review,
  resolved,
  dismissed;

  static ReportStatus fromJson(int index) {
    switch (index) {
      case 0:
        return ReportStatus.pending;
      case 1:
        return ReportStatus.under_review;
      case 2:
        return ReportStatus.resolved;
      case 3:
        return ReportStatus.dismissed;
      default:
        throw ArgumentError(
          'Value "$index" cannot be converted to "ReportStatus"',
        );
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
