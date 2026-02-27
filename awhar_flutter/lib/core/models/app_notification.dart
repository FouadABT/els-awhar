/// Model for app notifications
class AppNotification {
  final String id;
  final String title;
  final String body;
  final String? type;
  final String? requestId;
  final DateTime timestamp;
  final bool isRead;
  final Map<String, dynamic>? data;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    this.type,
    this.requestId,
    required this.timestamp,
    this.isRead = false,
    this.data,
  });

  /// Create from Firebase message data
  factory AppNotification.fromRemoteMessage({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) {
    return AppNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      body: body,
      type: data?['type'] as String?,
      requestId: data?['request_id'] as String?,
      timestamp: DateTime.now(),
      isRead: false,
      data: data,
    );
  }

  /// Create from JSON (for local storage)
  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: json['type'] as String?,
      requestId: json['requestId'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['isRead'] as bool? ?? false,
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  /// Convert to JSON (for local storage)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'type': type,
      'requestId': requestId,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'data': data,
    };
  }

  /// Create a copy with updated fields
  AppNotification copyWith({
    String? id,
    String? title,
    String? body,
    String? type,
    String? requestId,
    DateTime? timestamp,
    bool? isRead,
    Map<String, dynamic>? data,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      requestId: requestId ?? this.requestId,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      data: data ?? this.data,
    );
  }
}
