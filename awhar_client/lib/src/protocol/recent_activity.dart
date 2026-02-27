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

abstract class RecentActivity implements _i1.SerializableModel {
  RecentActivity._({
    required this.activityType,
    required this.title,
    required this.description,
    this.relatedId,
    this.relatedType,
    required this.createdAt,
    this.metadata,
  });

  factory RecentActivity({
    required String activityType,
    required String title,
    required String description,
    int? relatedId,
    String? relatedType,
    required DateTime createdAt,
    String? metadata,
  }) = _RecentActivityImpl;

  factory RecentActivity.fromJson(Map<String, dynamic> jsonSerialization) {
    return RecentActivity(
      activityType: jsonSerialization['activityType'] as String,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      relatedId: jsonSerialization['relatedId'] as int?,
      relatedType: jsonSerialization['relatedType'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      metadata: jsonSerialization['metadata'] as String?,
    );
  }

  String activityType;

  String title;

  String description;

  int? relatedId;

  String? relatedType;

  DateTime createdAt;

  String? metadata;

  /// Returns a shallow copy of this [RecentActivity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RecentActivity copyWith({
    String? activityType,
    String? title,
    String? description,
    int? relatedId,
    String? relatedType,
    DateTime? createdAt,
    String? metadata,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RecentActivity',
      'activityType': activityType,
      'title': title,
      'description': description,
      if (relatedId != null) 'relatedId': relatedId,
      if (relatedType != null) 'relatedType': relatedType,
      'createdAt': createdAt.toJson(),
      if (metadata != null) 'metadata': metadata,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RecentActivityImpl extends RecentActivity {
  _RecentActivityImpl({
    required String activityType,
    required String title,
    required String description,
    int? relatedId,
    String? relatedType,
    required DateTime createdAt,
    String? metadata,
  }) : super._(
         activityType: activityType,
         title: title,
         description: description,
         relatedId: relatedId,
         relatedType: relatedType,
         createdAt: createdAt,
         metadata: metadata,
       );

  /// Returns a shallow copy of this [RecentActivity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RecentActivity copyWith({
    String? activityType,
    String? title,
    String? description,
    Object? relatedId = _Undefined,
    Object? relatedType = _Undefined,
    DateTime? createdAt,
    Object? metadata = _Undefined,
  }) {
    return RecentActivity(
      activityType: activityType ?? this.activityType,
      title: title ?? this.title,
      description: description ?? this.description,
      relatedId: relatedId is int? ? relatedId : this.relatedId,
      relatedType: relatedType is String? ? relatedType : this.relatedType,
      createdAt: createdAt ?? this.createdAt,
      metadata: metadata is String? ? metadata : this.metadata,
    );
  }
}
