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

abstract class UserClient implements _i1.SerializableModel {
  UserClient._({
    this.id,
    required this.userId,
    this.defaultAddressId,
    this.defaultCityId,
    int? totalOrders,
    DateTime? createdAt,
  }) : totalOrders = totalOrders ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory UserClient({
    int? id,
    required int userId,
    int? defaultAddressId,
    int? defaultCityId,
    int? totalOrders,
    DateTime? createdAt,
  }) = _UserClientImpl;

  factory UserClient.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserClient(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      defaultAddressId: jsonSerialization['defaultAddressId'] as int?,
      defaultCityId: jsonSerialization['defaultCityId'] as int?,
      totalOrders: jsonSerialization['totalOrders'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int? defaultAddressId;

  int? defaultCityId;

  int totalOrders;

  DateTime createdAt;

  /// Returns a shallow copy of this [UserClient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserClient copyWith({
    int? id,
    int? userId,
    int? defaultAddressId,
    int? defaultCityId,
    int? totalOrders,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserClient',
      if (id != null) 'id': id,
      'userId': userId,
      if (defaultAddressId != null) 'defaultAddressId': defaultAddressId,
      if (defaultCityId != null) 'defaultCityId': defaultCityId,
      'totalOrders': totalOrders,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserClientImpl extends UserClient {
  _UserClientImpl({
    int? id,
    required int userId,
    int? defaultAddressId,
    int? defaultCityId,
    int? totalOrders,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         defaultAddressId: defaultAddressId,
         defaultCityId: defaultCityId,
         totalOrders: totalOrders,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UserClient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserClient copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? defaultAddressId = _Undefined,
    Object? defaultCityId = _Undefined,
    int? totalOrders,
    DateTime? createdAt,
  }) {
    return UserClient(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      defaultAddressId: defaultAddressId is int?
          ? defaultAddressId
          : this.defaultAddressId,
      defaultCityId: defaultCityId is int? ? defaultCityId : this.defaultCityId,
      totalOrders: totalOrders ?? this.totalOrders,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
