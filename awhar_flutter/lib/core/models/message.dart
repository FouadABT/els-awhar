/// Message model for in-app chat
/// Represents a single message in a chat conversation
class Message {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool read;
  final String? senderName;
  final String? senderAvatar;

  // Media attachment fields
  final String? mediaUrl;           // Firebase Cloud Storage URL for the media file
  final String? mediaType;          // Type of media: 'image', 'audio', 'video'
  final String? mediaFileName;      // Original filename of the media
  final int? mediaSizeBytes;        // File size in bytes for display purposes
  final int? mediaDurationMs;       // Duration in milliseconds for audio/video
  final String? mediaThumbnailUrl;  // Thumbnail URL for images/videos

  Message({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    this.read = false,
    this.senderName,
    this.senderAvatar,
    this.mediaUrl,
    this.mediaType,
    this.mediaFileName,
    this.mediaSizeBytes,
    this.mediaDurationMs,
    this.mediaThumbnailUrl,
  });

  /// Create Message from Firebase JSON
  factory Message.fromJson(Map<String, dynamic> json, String id) {
    DateTime _parseTs(dynamic raw) {
      if (raw == null) {
        return DateTime.now();
      }
      if (raw is int) {
        // epoch millis
        return DateTime.fromMillisecondsSinceEpoch(raw);
      }
      if (raw is String) {
        // Handle prefixed formats like 'timestap::2026-01-07T...'
        final parts = raw.split('::');
        final iso = parts.isNotEmpty ? parts.last : raw;
        final parsed = DateTime.tryParse(iso);
        if (parsed != null) return parsed;
      }
      // Fallback
      return DateTime.now();
    }

    // Accept multiple possible timestamp keys
    final tsRaw = json['timestamp'] ?? json['timestap'] ?? json['time'] ?? json['createdAt'] ?? json['updatedAt'];

    return Message(
      id: id,
      senderId: json['senderId'] as String,
      text: json['text'] as String,
      timestamp: _parseTs(tsRaw),
      read: json['read'] as bool? ?? false,
      senderName: json['senderName'] as String?,
      senderAvatar: json['senderAvatar'] as String?,
      // Media fields
      mediaUrl: json['mediaUrl'] as String?,
      mediaType: json['mediaType'] as String?,
      mediaFileName: json['mediaFileName'] as String?,
      mediaSizeBytes: json['mediaSizeBytes'] as int?,
      mediaDurationMs: json['mediaDurationMs'] as int?,
      mediaThumbnailUrl: json['mediaThumbnailUrl'] as String?,
    );
  }

  /// Convert Message to Firebase JSON
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'read': read,
      if (senderName != null) 'senderName': senderName,
      if (senderAvatar != null) 'senderAvatar': senderAvatar,
      // Media fields
      if (mediaUrl != null) 'mediaUrl': mediaUrl,
      if (mediaType != null) 'mediaType': mediaType,
      if (mediaFileName != null) 'mediaFileName': mediaFileName,
      if (mediaSizeBytes != null) 'mediaSizeBytes': mediaSizeBytes,
      if (mediaDurationMs != null) 'mediaDurationMs': mediaDurationMs,
      if (mediaThumbnailUrl != null) 'mediaThumbnailUrl': mediaThumbnailUrl,
    };
  }

  /// Create a copy with updated fields
  Message copyWith({
    String? id,
    String? senderId,
    String? text,
    DateTime? timestamp,
    bool? read,
    String? senderName,
    String? senderAvatar,
    String? mediaUrl,
    String? mediaType,
    String? mediaFileName,
    int? mediaSizeBytes,
    int? mediaDurationMs,
    String? mediaThumbnailUrl,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      read: read ?? this.read,
      senderName: senderName ?? this.senderName,
      senderAvatar: senderAvatar ?? this.senderAvatar,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaType: mediaType ?? this.mediaType,
      mediaFileName: mediaFileName ?? this.mediaFileName,
      mediaSizeBytes: mediaSizeBytes ?? this.mediaSizeBytes,
      mediaDurationMs: mediaDurationMs ?? this.mediaDurationMs,
      mediaThumbnailUrl: mediaThumbnailUrl ?? this.mediaThumbnailUrl,
    );
  }

  @override
  String toString() {
    return 'Message(id: $id, senderId: $senderId, text: $text, timestamp: $timestamp, read: $read, mediaType: $mediaType)';
  }
}
