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

abstract class Favorite implements _i1.SerializableModel {
  Favorite._({
    this.id,
    required this.clientId,
    required this.driverId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Favorite({
    int? id,
    required int clientId,
    required int driverId,
    DateTime? createdAt,
  }) = _FavoriteImpl;

  factory Favorite.fromJson(Map<String, dynamic> jsonSerialization) {
    return Favorite(
      id: jsonSerialization['id'] as int?,
      clientId: jsonSerialization['clientId'] as int,
      driverId: jsonSerialization['driverId'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int clientId;

  int driverId;

  DateTime createdAt;

  /// Returns a shallow copy of this [Favorite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Favorite copyWith({
    int? id,
    int? clientId,
    int? driverId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Favorite',
      if (id != null) 'id': id,
      'clientId': clientId,
      'driverId': driverId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FavoriteImpl extends Favorite {
  _FavoriteImpl({
    int? id,
    required int clientId,
    required int driverId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         clientId: clientId,
         driverId: driverId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Favorite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Favorite copyWith({
    Object? id = _Undefined,
    int? clientId,
    int? driverId,
    DateTime? createdAt,
  }) {
    return Favorite(
      id: id is int? ? id : this.id,
      clientId: clientId ?? this.clientId,
      driverId: driverId ?? this.driverId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
