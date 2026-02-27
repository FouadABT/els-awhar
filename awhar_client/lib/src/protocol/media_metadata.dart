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

abstract class MediaMetadata implements _i1.SerializableModel {
  MediaMetadata._({
    this.id,
    required this.messageId,
    required this.userId,
    required this.requestId,
    required this.mediaUrl,
    required this.mediaType,
    required this.fileName,
    required this.fileSizeBytes,
    this.durationMs,
    this.thumbnailUrl,
    int? downloadCount,
    this.lastAccessedAt,
    required this.uploadedAt,
    required this.createdAt,
    required this.updatedAt,
  }) : downloadCount = downloadCount ?? 0;

  factory MediaMetadata({
    int? id,
    required String messageId,
    required int userId,
    required int requestId,
    required String mediaUrl,
    required String mediaType,
    required String fileName,
    required int fileSizeBytes,
    int? durationMs,
    String? thumbnailUrl,
    int? downloadCount,
    DateTime? lastAccessedAt,
    required DateTime uploadedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MediaMetadataImpl;

  factory MediaMetadata.fromJson(Map<String, dynamic> jsonSerialization) {
    return MediaMetadata(
      id: jsonSerialization['id'] as int?,
      messageId: jsonSerialization['messageId'] as String,
      userId: jsonSerialization['userId'] as int,
      requestId: jsonSerialization['requestId'] as int,
      mediaUrl: jsonSerialization['mediaUrl'] as String,
      mediaType: jsonSerialization['mediaType'] as String,
      fileName: jsonSerialization['fileName'] as String,
      fileSizeBytes: jsonSerialization['fileSizeBytes'] as int,
      durationMs: jsonSerialization['durationMs'] as int?,
      thumbnailUrl: jsonSerialization['thumbnailUrl'] as String?,
      downloadCount: jsonSerialization['downloadCount'] as int,
      lastAccessedAt: jsonSerialization['lastAccessedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastAccessedAt'],
            ),
      uploadedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['uploadedAt'],
      ),
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

  String messageId;

  int userId;

  int requestId;

  String mediaUrl;

  String mediaType;

  String fileName;

  int fileSizeBytes;

  int? durationMs;

  String? thumbnailUrl;

  int downloadCount;

  DateTime? lastAccessedAt;

  DateTime uploadedAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [MediaMetadata]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MediaMetadata copyWith({
    int? id,
    String? messageId,
    int? userId,
    int? requestId,
    String? mediaUrl,
    String? mediaType,
    String? fileName,
    int? fileSizeBytes,
    int? durationMs,
    String? thumbnailUrl,
    int? downloadCount,
    DateTime? lastAccessedAt,
    DateTime? uploadedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MediaMetadata',
      if (id != null) 'id': id,
      'messageId': messageId,
      'userId': userId,
      'requestId': requestId,
      'mediaUrl': mediaUrl,
      'mediaType': mediaType,
      'fileName': fileName,
      'fileSizeBytes': fileSizeBytes,
      if (durationMs != null) 'durationMs': durationMs,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      'downloadCount': downloadCount,
      if (lastAccessedAt != null) 'lastAccessedAt': lastAccessedAt?.toJson(),
      'uploadedAt': uploadedAt.toJson(),
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

class _MediaMetadataImpl extends MediaMetadata {
  _MediaMetadataImpl({
    int? id,
    required String messageId,
    required int userId,
    required int requestId,
    required String mediaUrl,
    required String mediaType,
    required String fileName,
    required int fileSizeBytes,
    int? durationMs,
    String? thumbnailUrl,
    int? downloadCount,
    DateTime? lastAccessedAt,
    required DateTime uploadedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         messageId: messageId,
         userId: userId,
         requestId: requestId,
         mediaUrl: mediaUrl,
         mediaType: mediaType,
         fileName: fileName,
         fileSizeBytes: fileSizeBytes,
         durationMs: durationMs,
         thumbnailUrl: thumbnailUrl,
         downloadCount: downloadCount,
         lastAccessedAt: lastAccessedAt,
         uploadedAt: uploadedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [MediaMetadata]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MediaMetadata copyWith({
    Object? id = _Undefined,
    String? messageId,
    int? userId,
    int? requestId,
    String? mediaUrl,
    String? mediaType,
    String? fileName,
    int? fileSizeBytes,
    Object? durationMs = _Undefined,
    Object? thumbnailUrl = _Undefined,
    int? downloadCount,
    Object? lastAccessedAt = _Undefined,
    DateTime? uploadedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MediaMetadata(
      id: id is int? ? id : this.id,
      messageId: messageId ?? this.messageId,
      userId: userId ?? this.userId,
      requestId: requestId ?? this.requestId,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaType: mediaType ?? this.mediaType,
      fileName: fileName ?? this.fileName,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      durationMs: durationMs is int? ? durationMs : this.durationMs,
      thumbnailUrl: thumbnailUrl is String? ? thumbnailUrl : this.thumbnailUrl,
      downloadCount: downloadCount ?? this.downloadCount,
      lastAccessedAt: lastAccessedAt is DateTime?
          ? lastAccessedAt
          : this.lastAccessedAt,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
