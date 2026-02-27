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

abstract class ServiceImage implements _i1.SerializableModel {
  ServiceImage._({
    this.id,
    required this.driverServiceId,
    required this.imageUrl,
    this.thumbnailUrl,
    int? displayOrder,
    this.caption,
    this.fileSize,
    this.width,
    this.height,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : displayOrder = displayOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory ServiceImage({
    int? id,
    required int driverServiceId,
    required String imageUrl,
    String? thumbnailUrl,
    int? displayOrder,
    String? caption,
    int? fileSize,
    int? width,
    int? height,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ServiceImageImpl;

  factory ServiceImage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ServiceImage(
      id: jsonSerialization['id'] as int?,
      driverServiceId: jsonSerialization['driverServiceId'] as int,
      imageUrl: jsonSerialization['imageUrl'] as String,
      thumbnailUrl: jsonSerialization['thumbnailUrl'] as String?,
      displayOrder: jsonSerialization['displayOrder'] as int,
      caption: jsonSerialization['caption'] as String?,
      fileSize: jsonSerialization['fileSize'] as int?,
      width: jsonSerialization['width'] as int?,
      height: jsonSerialization['height'] as int?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int driverServiceId;

  String imageUrl;

  String? thumbnailUrl;

  int displayOrder;

  String? caption;

  int? fileSize;

  int? width;

  int? height;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ServiceImage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ServiceImage copyWith({
    int? id,
    int? driverServiceId,
    String? imageUrl,
    String? thumbnailUrl,
    int? displayOrder,
    String? caption,
    int? fileSize,
    int? width,
    int? height,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ServiceImage',
      if (id != null) 'id': id,
      'driverServiceId': driverServiceId,
      'imageUrl': imageUrl,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      'displayOrder': displayOrder,
      if (caption != null) 'caption': caption,
      if (fileSize != null) 'fileSize': fileSize,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ServiceImageImpl extends ServiceImage {
  _ServiceImageImpl({
    int? id,
    required int driverServiceId,
    required String imageUrl,
    String? thumbnailUrl,
    int? displayOrder,
    String? caption,
    int? fileSize,
    int? width,
    int? height,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         driverServiceId: driverServiceId,
         imageUrl: imageUrl,
         thumbnailUrl: thumbnailUrl,
         displayOrder: displayOrder,
         caption: caption,
         fileSize: fileSize,
         width: width,
         height: height,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ServiceImage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ServiceImage copyWith({
    Object? id = _Undefined,
    int? driverServiceId,
    String? imageUrl,
    Object? thumbnailUrl = _Undefined,
    int? displayOrder,
    Object? caption = _Undefined,
    Object? fileSize = _Undefined,
    Object? width = _Undefined,
    Object? height = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ServiceImage(
      id: id is int? ? id : this.id,
      driverServiceId: driverServiceId ?? this.driverServiceId,
      imageUrl: imageUrl ?? this.imageUrl,
      thumbnailUrl: thumbnailUrl is String? ? thumbnailUrl : this.thumbnailUrl,
      displayOrder: displayOrder ?? this.displayOrder,
      caption: caption is String? ? caption : this.caption,
      fileSize: fileSize is int? ? fileSize : this.fileSize,
      width: width is int? ? width : this.width,
      height: height is int? ? height : this.height,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
