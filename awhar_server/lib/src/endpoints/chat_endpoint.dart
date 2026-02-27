import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/notification_service.dart';

/// Chat management endpoint
/// Handles chat messages, syncing with Firebase, read receipts
class ChatEndpoint extends Endpoint {
  /// Send a chat message (also syncs to Firebase)
  Future<ChatMessage?> sendMessage(
    Session session, {
    required int orderId,
    required int senderId,
    required int receiverId,
    required String message,
    MessageType? messageType,
    String? attachmentUrl,
    String? firebaseId,
  }) async {
    try {
      final chatMessage = ChatMessage(
        orderId: orderId,
        senderId: senderId,
        receiverId: receiverId,
        message: message,
        messageType: messageType ?? MessageType.text,
        attachmentUrl: attachmentUrl,
        firebaseId: firebaseId,
        isRead: false,
        createdAt: DateTime.now(),
      );

      return await ChatMessage.db.insertRow(session, chatMessage);
    } catch (e) {
      session.log('Error sending message: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Get chat messages for an order
  Future<List<ChatMessage>> getMessages(
    Session session, {
    required int orderId,
    int? limit,
    DateTime? before,
  }) async {
    try {
      final messages = await ChatMessage.db.find(
        session,
        where: (t) => t.orderId.equals(orderId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
      );

      // Filter by 'before' timestamp if provided
      if (before != null) {
        return messages.where((m) => m.createdAt.isBefore(before)).toList();
      }

      return messages;
    } catch (e) {
      session.log('Error getting messages: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get unread message count for a user
  Future<int> getUnreadCount(
    Session session, {
    required int userId,
  }) async {
    try {
      final messages = await ChatMessage.db.find(
        session,
        where: (t) => t.receiverId.equals(userId) & t.isRead.equals(false),
      );

      return messages.length;
    } catch (e) {
      session.log('Error getting unread count: $e', level: LogLevel.error);
      return 0;
    }
  }

  /// Mark messages as read
  Future<int> markAsRead(
    Session session, {
    required int orderId,
    required int userId,
  }) async {
    try {
      final messages = await ChatMessage.db.find(
        session,
        where: (t) =>
            t.orderId.equals(orderId) &
            t.receiverId.equals(userId) &
            t.isRead.equals(false),
      );

      int markedCount = 0;

      for (final message in messages) {
        message.isRead = true;
        message.readAt = DateTime.now();
        await ChatMessage.db.updateRow(session, message);
        markedCount++;
      }

      return markedCount;
    } catch (e) {
      session.log('Error marking messages as read: $e', level: LogLevel.error);
      return 0;
    }
  }

  /// Mark specific message as read
  Future<ChatMessage?> markMessageAsRead(
    Session session, {
    required int messageId,
  }) async {
    try {
      final message = await ChatMessage.db.findById(session, messageId);

      if (message == null) {
        return null;
      }

      message.isRead = true;
      message.readAt = DateTime.now();

      return await ChatMessage.db.updateRow(session, message);
    } catch (e) {
      session.log('Error marking message as read: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Sync message from Firebase to PostgreSQL
  Future<ChatMessage?> syncFromFirebase(
    Session session, {
    required String firebaseId,
    required int orderId,
    required int senderId,
    required int receiverId,
    required String message,
    MessageType? messageType,
    String? attachmentUrl,
    required DateTime createdAt,
  }) async {
    try {
      // Check if already synced
      final existing = await ChatMessage.db.findFirstRow(
        session,
        where: (t) => t.firebaseId.equals(firebaseId),
      );

      if (existing != null) {
        return existing;
      }

      // Create new synced message
      final chatMessage = ChatMessage(
        orderId: orderId,
        senderId: senderId,
        receiverId: receiverId,
        message: message,
        messageType: messageType ?? MessageType.text,
        attachmentUrl: attachmentUrl,
        firebaseId: firebaseId,
        isRead: false,
        createdAt: createdAt,
      );

      return await ChatMessage.db.insertRow(session, chatMessage);
    } catch (e) {
      session.log('Error syncing from Firebase: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Get chat history for admin (all messages for an order)
  Future<List<ChatMessage>> getAdminChatHistory(
    Session session, {
    required int orderId,
  }) async {
    try {
      return await ChatMessage.db.find(
        session,
        where: (t) => t.orderId.equals(orderId),
        orderBy: (t) => t.createdAt,
      );
    } catch (e) {
      session.log('Error getting admin chat history: $e',
          level: LogLevel.error);
      return [];
    }
  }

  /// Send a notification for a new chat message
  /// Called by client after sending message to Firebase Realtime DB
  Future<bool> notifyNewMessage(
    Session session, {
    required int requestId,
    required int recipientUserId,
    required int senderId,
    required String senderName,
    required String messageText,
  }) async {
    try {
      await NotificationService.notifyChatMessage(
        session,
        recipientUserId: recipientUserId,
        senderName: senderName,
        messageText: messageText,
        requestId: requestId,
        senderId: senderId,
      );

      return true;
    } catch (e) {
      session.log('[ChatEndpoint] ❌ Error sending notification: $e', level: LogLevel.error);
      return false;
    }
  }
}
