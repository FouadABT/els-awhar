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

enum ReportReason implements _i1.SerializableModel {
  spam,
  inappropriate_content,
  harassment,
  fake_profile,
  scam,
  illegal_activity,
  safety_concern,
  fraud,
  poor_service,
  wrong_information,
  other;

  static ReportReason fromJson(int index) {
    switch (index) {
      case 0:
        return ReportReason.spam;
      case 1:
        return ReportReason.inappropriate_content;
      case 2:
        return ReportReason.harassment;
      case 3:
        return ReportReason.fake_profile;
      case 4:
        return ReportReason.scam;
      case 5:
        return ReportReason.illegal_activity;
      case 6:
        return ReportReason.safety_concern;
      case 7:
        return ReportReason.fraud;
      case 8:
        return ReportReason.poor_service;
      case 9:
        return ReportReason.wrong_information;
      case 10:
        return ReportReason.other;
      default:
        throw ArgumentError(
          'Value "$index" cannot be converted to "ReportReason"',
        );
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
