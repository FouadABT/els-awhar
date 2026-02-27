import 'message.dart';

/// Chat model for request conversations
/// Represents a chat conversation between client and driver
class Chat {
  final String requestId;
  final List<String> participants; // [clientId, driverId]
  final Message? lastMessage;
  final DateTime updatedAt;
  final Map<String, int> unreadCount; // userId -> count

  Chat({
    required this.requestId,
    required this.participants,
    this.lastMessage,
    required this.updatedAt,
    Map<String, int>? unreadCount,
  }) : unreadCount = unreadCount ?? {};

  /// Create Chat from Firebase JSON
  factory Chat.fromJson(Map<String, dynamic> json, String requestId) {
    Message? lastMessage;
    if (json['lastMessage'] != null) {
      lastMessage = Message.fromJson(
        json['lastMessage'] as Map<String, dynamic>,
        'last',
      );
    }

    final unreadCountMap = <String, int>{};
    if (json['unreadCount'] != null) {
      final unreadData = json['unreadCount'] as Map<String, dynamic>;
      unreadData.forEach((key, value) {
        unreadCountMap[key] = value as int;
      });
    }

    return Chat(
      requestId: requestId,
      participants: List<String>.from(json['participants'] as List),
      lastMessage: lastMessage,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      unreadCount: unreadCountMap,
    );
  }

  /// Convert Chat to Firebase JSON
  Map<String, dynamic> toJson() {
    return {
      'participants': participants,
      if (lastMessage != null) 'lastMessage': lastMessage!.toJson(),
      'updatedAt': updatedAt.toIso8601String(),
      'unreadCount': unreadCount,
    };
  }

  /// Get unread count for specific user
  int getUnreadCountForUser(String userId) {
    return unreadCount[userId] ?? 0;
  }

  /// Create a copy with updated fields
  Chat copyWith({
    String? requestId,
    List<String>? participants,
    Message? lastMessage,
    DateTime? updatedAt,
    Map<String, int>? unreadCount,
  }) {
    return Chat(
      requestId: requestId ?? this.requestId,
      participants: participants ?? this.participants,
      lastMessage: lastMessage ?? this.lastMessage,
      updatedAt: updatedAt ?? this.updatedAt,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  String toString() {
    return 'Chat(requestId: $requestId, participants: $participants, unreadCount: $unreadCount)';
  }
}
