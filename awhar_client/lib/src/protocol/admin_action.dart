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
import 'admin_action_type_enum.dart' as _i2;

abstract class AdminAction implements _i1.SerializableModel {
  AdminAction._({
    this.id,
    required this.adminUserId,
    this.actionType,
    required this.targetType,
    required this.targetId,
    this.reason,
    this.notes,
    this.metadata,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AdminAction({
    int? id,
    required int adminUserId,
    _i2.AdminActionType? actionType,
    required String targetType,
    required int targetId,
    String? reason,
    String? notes,
    String? metadata,
    DateTime? createdAt,
  }) = _AdminActionImpl;

  factory AdminAction.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminAction(
      id: jsonSerialization['id'] as int?,
      adminUserId: jsonSerialization['adminUserId'] as int,
      actionType: jsonSerialization['actionType'] == null
          ? null
          : _i2.AdminActionType.fromJson(
              (jsonSerialization['actionType'] as int),
            ),
      targetType: jsonSerialization['targetType'] as String,
      targetId: jsonSerialization['targetId'] as int,
      reason: jsonSerialization['reason'] as String?,
      notes: jsonSerialization['notes'] as String?,
      metadata: jsonSerialization['metadata'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int adminUserId;

  _i2.AdminActionType? actionType;

  String targetType;

  int targetId;

  String? reason;

  String? notes;

  String? metadata;

  DateTime createdAt;

  /// Returns a shallow copy of this [AdminAction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminAction copyWith({
    int? id,
    int? adminUserId,
    _i2.AdminActionType? actionType,
    String? targetType,
    int? targetId,
    String? reason,
    String? notes,
    String? metadata,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminAction',
      if (id != null) 'id': id,
      'adminUserId': adminUserId,
      if (actionType != null) 'actionType': actionType?.toJson(),
      'targetType': targetType,
      'targetId': targetId,
      if (reason != null) 'reason': reason,
      if (notes != null) 'notes': notes,
      if (metadata != null) 'metadata': metadata,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminActionImpl extends AdminAction {
  _AdminActionImpl({
    int? id,
    required int adminUserId,
    _i2.AdminActionType? actionType,
    required String targetType,
    required int targetId,
    String? reason,
    String? notes,
    String? metadata,
    DateTime? createdAt,
  }) : super._(
         id: id,
         adminUserId: adminUserId,
         actionType: actionType,
         targetType: targetType,
         targetId: targetId,
         reason: reason,
         notes: notes,
         metadata: metadata,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AdminAction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminAction copyWith({
    Object? id = _Undefined,
    int? adminUserId,
    Object? actionType = _Undefined,
    String? targetType,
    int? targetId,
    Object? reason = _Undefined,
    Object? notes = _Undefined,
    Object? metadata = _Undefined,
    DateTime? createdAt,
  }) {
    return AdminAction(
      id: id is int? ? id : this.id,
      adminUserId: adminUserId ?? this.adminUserId,
      actionType: actionType is _i2.AdminActionType?
          ? actionType
          : this.actionType,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      reason: reason is String? ? reason : this.reason,
      notes: notes is String? ? notes : this.notes,
      metadata: metadata is String? ? metadata : this.metadata,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
