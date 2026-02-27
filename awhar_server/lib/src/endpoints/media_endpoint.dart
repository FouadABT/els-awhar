import 'package:serverpod/serverpod.dart';

import 'package:awhar_server/src/generated/protocol.dart';

/// Media endpoint
/// Records media metadata, lists media by request, and tracks access/downloads.
class MediaEndpoint extends Endpoint {
  Future<bool> ping(Session session) async {
    return true;
  }

  /// Record a media metadata entry after a successful upload to Firebase Storage.
  Future<MediaMetadata?> recordMedia(
    Session session, {
    required String messageId,
    required int userId,
    required int requestId,
    required String mediaUrl,
    required String mediaType, // 'image' | 'audio' | 'video'
    required String fileName,
    required int fileSizeBytes,
    int? durationMs,
    String? thumbnailUrl,
    DateTime? uploadedAt,
  }) async {
    try {
      final now = DateTime.now();
      final metadata = MediaMetadata(
        messageId: messageId,
        userId: userId,
        requestId: requestId,
        mediaUrl: mediaUrl,
        mediaType: mediaType,
        fileName: fileName,
        fileSizeBytes: fileSizeBytes,
        durationMs: durationMs,
        thumbnailUrl: thumbnailUrl,
        downloadCount: 0,
        lastAccessedAt: null,
        uploadedAt: uploadedAt ?? now,
        createdAt: now,
        updatedAt: now,
      );

      final inserted = await MediaMetadata.db.insertRow(session, metadata);
      session.log('[Media] Recorded media \\${inserted.id} for request \\${requestId}');
      return inserted;
    } catch (e) {
      session.log('[Media] recordMedia error: \\${e}', level: LogLevel.error);
      return null;
    }
  }

  /// List media entries by `requestId` (e.g. all media for a chat thread/request).
  Future<List<MediaMetadata>> listByRequest(
    Session session, {
    required int requestId,
  }) async {
    try {
      final rows = await MediaMetadata.db.find(
        session,
        where: (t) => t.requestId.equals(requestId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
      );
      return rows;
    } catch (e) {
      session.log('[Media] listByRequest error: \\${e}', level: LogLevel.error);
      return <MediaMetadata>[];
    }
  }

  /// Increment download count and update last accessed time for a media entry.
  Future<bool> incrementDownload(
    Session session, {
    required int id,
  }) async {
    try {
      final row = await MediaMetadata.db.findById(session, id);
      if (row == null) return false;

      row.downloadCount = row.downloadCount + 1;
      row.lastAccessedAt = DateTime.now();
      row.updatedAt = DateTime.now();

      await MediaMetadata.db.updateRow(session, row);
      session.log('[Media] Incremented download count for media \\${id}');
      return true;
    } catch (e) {
      session.log('[Media] incrementDownload error: \\${e}', level: LogLevel.error);
      return false;
    }
  }
}
