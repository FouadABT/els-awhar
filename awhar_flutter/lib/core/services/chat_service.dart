import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:awhar_client/awhar_client.dart';
import '../models/message.dart';
import '../models/chat.dart';
import '../controllers/auth_controller.dart';
import '../constants/firebase_config.dart';

/// Service for managing in-app chat with Firebase Realtime Database
class ChatService extends GetxService {
  late final FirebaseDatabase _database;
  final AuthController _authController = Get.find<AuthController>();

  static const int maxMessageLength = 1000;
  static const int messageLoadLimit = 50;

  /// Initialize chat service
  @override
  void onInit() {
    super.onInit();
    // Initialize with Firebase config
    _database = FirebaseDatabase.instanceFor(
      app: FirebaseDatabase.instance.app,
      databaseURL: FirebaseConfig.realtimeDatabaseUrl,
    );
    _database.setPersistenceEnabled(FirebaseConfig.enablePersistence);
    debugPrint('[ChatService] 💬 Initialized with URL: ${FirebaseConfig.realtimeDatabaseUrl}');
  }

  /// Expose configured FirebaseDatabase instance
  FirebaseDatabase get database => _database;

  /// Get chat reference for a request
  DatabaseReference _getChatRef(String requestId) {
    final path = 'chats/$requestId';
    debugPrint('[ChatService] 📁 Chat ref path: $path');
    return _database.ref(path);
  }

  /// Get messages reference for a request
  DatabaseReference _getMessagesRef(String requestId) {
    final path = 'chats/$requestId/messages';
    debugPrint('[ChatService] 📁 Messages ref path: $path');
    return _database.ref(path);
  }

  /// Get direct chat reference (client <-> driver without request)
  DatabaseReference _getDirectChatRef(String clientId, String driverId) {
    // Use consistent ordering to ensure same chat for both users
    final sortedIds = [clientId, driverId]..sort();
    final chatId = '${sortedIds[0]}_${sortedIds[1]}';
    final path = 'direct_chats/$chatId';
    debugPrint('[ChatService] 📁 Direct chat ref path: $path');
    return _database.ref(path);
  }

  /// Get direct messages reference
  DatabaseReference _getDirectMessagesRef(String clientId, String driverId) {
    final sortedIds = [clientId, driverId]..sort();
    final chatId = '${sortedIds[0]}_${sortedIds[1]}';
    final path = 'direct_chats/$chatId/messages';
    debugPrint('[ChatService] 📁 Direct messages ref path: $path');
    return _database.ref(path);
  }

  /// Send a message in a chat
  Future<bool> sendMessage({
    required String requestId,
    required String text,
    required String senderId,
    required String senderName,
    String? senderAvatar,
    String? mediaUrl,
    String? mediaType,
    String? mediaFileName,
    int? mediaSizeBytes,
    int? mediaDurationMs,
    String? mediaThumbnailUrl,
  }) async {
    try {
      // Validate message
      final hasText = text.trim().isNotEmpty;
      final hasMedia = mediaUrl != null && mediaUrl.isNotEmpty;
      
      if (!hasText && !hasMedia) {
        debugPrint('[ChatService] ❌ Cannot send empty message');
        return false;
      }

      if (hasText && text.length > maxMessageLength) {
        debugPrint('[ChatService] ❌ Message too long: ${text.length} characters');
        return false;
      }

      final trimmedText = hasText ? text.trim() : '';
      final now = DateTime.now();
      
      debugPrint('[ChatService] 📤 Sending message to chat: $requestId from sender: $senderId');
      if (hasMedia) {
        debugPrint('[ChatService] 📎 Media attached: $mediaType ($mediaFileName)');
      }

      // Create message object with a unique key
      final messageKey = _getMessagesRef(requestId).push().key ?? '${now.millisecondsSinceEpoch}_$senderId';
      final message = Message(
        id: messageKey,
        senderId: senderId,
        text: trimmedText,
        timestamp: now,
        read: false,
        senderName: senderName,
        senderAvatar: senderAvatar,
        mediaUrl: mediaUrl,
        mediaType: mediaType,
        mediaFileName: mediaFileName,
        mediaSizeBytes: mediaSizeBytes,
        mediaDurationMs: mediaDurationMs,
        mediaThumbnailUrl: mediaThumbnailUrl,
      );

      // Get chat reference
      final chatRef = _getChatRef(requestId);
      final messagesRef = _getMessagesRef(requestId);
      
      debugPrint('[ChatService] 📝 Writing to path: chats/$requestId/messages/$messageKey');

      // Save message
      await messagesRef.child(messageKey).set(message.toJson());

      // Update chat metadata
      final chatSnapshot = await chatRef.get();
      final participantsData = chatSnapshot.child('participants').value;
      
      // Parse participants list properly
      List<String>? participants;
      if (participantsData != null) {
        if (participantsData is List) {
          participants = participantsData.map((e) => e.toString()).toList();
        } else if (participantsData is Map) {
          participants = participantsData.values.map((e) => e.toString()).toList();
        }
      }
      
      debugPrint('[ChatService] 👥 Participants: $participants');

      if (participants == null || participants.isEmpty) {
        // First message - initialize chat
        debugPrint('[ChatService] 🆕 Initializing new chat');
        await chatRef.set({
          'participants': [senderId],
          'updatedAt': now.toIso8601String(),
          'lastMessage': message.toJson(),
          'unreadCount': {},
        });
      } else {
        // Update existing chat
        final updates = <String, dynamic>{
          'updatedAt': now.toIso8601String(),
          'lastMessage': message.toJson(),
        };

        // Increment unread count for other participants
        final unreadCountRaw = chatSnapshot.child('unreadCount').value;
        Map<String, int> unreadCountData = {};
        
        if (unreadCountRaw is Map) {
          unreadCountRaw.forEach((key, value) {
            unreadCountData[key.toString()] = (value as int?) ?? 0;
          });
        }
        
        for (var participantId in participants) {
          if (participantId != senderId) {
            final currentCount = unreadCountData[participantId] ?? 0;
            updates['unreadCount/$participantId'] = currentCount + 1;
            debugPrint('[ChatService] 🔔 Incrementing unread for $participantId: ${currentCount + 1}');
          }
        }

        await chatRef.update(updates);
      }

      debugPrint('[ChatService] ✅ Message sent: $requestId');
      
      // Send backend notification to recipient
      try {
        // Get the recipient ID (the other participant who is not the sender)
        final recipientId = participants?.firstWhere(
          (id) => id != senderId,
          orElse: () => '',
        );
        
        if (recipientId != null && recipientId.isNotEmpty) {
          final client = Get.find<Client>();
          final recipientIdInt = int.tryParse(recipientId);
          final senderIdInt = int.tryParse(senderId);
          final requestIdInt = int.tryParse(requestId);
          
          if (recipientIdInt != null && senderIdInt != null && requestIdInt != null) {
            debugPrint('[ChatService] 📤 Sending notification to recipient: $recipientId');
            final success = await client.chat.notifyNewMessage(
              requestId: requestIdInt,
              recipientUserId: recipientIdInt,
              senderId: senderIdInt,
              senderName: senderName,
              messageText: trimmedText,
            );
            
            if (success) {
              debugPrint('[ChatService] ✅ Backend notification sent');
            } else {
              debugPrint('[ChatService] ⚠️ Backend notification failed');
            }
          }
        }
      } catch (notifError) {
        // Don't fail message sending if notification fails
        debugPrint('[ChatService] ⚠️ Error sending notification: $notifError');
      }
      
      return true;
    } catch (e, stackTrace) {
      debugPrint('[ChatService] ❌ Error sending message: $e');
      debugPrint('[ChatService] Stack trace: $stackTrace');
      return false;
    }
  }

  /// Listen to messages in a chat (real-time stream)
  Stream<List<Message>> listenToMessages(String requestId) {
    debugPrint('[ChatService] 🎧 Starting message listener for chat: $requestId');
    debugPrint('[ChatService] 🔗 Path: chats/$requestId/messages');
    
    final messagesRef = _getMessagesRef(requestId);
    
    // Keep sync enabled for real-time updates
    messagesRef.keepSynced(true);
    
    return messagesRef
        .orderByChild('timestamp')
        .limitToLast(messageLoadLimit)
        .onValue
        .map((event) {
      final messages = <Message>[];

      debugPrint('[ChatService] 📨 Firebase event received for chat: $requestId');
      debugPrint('[ChatService] 📦 Snapshot exists: ${event.snapshot.exists}, value type: ${event.snapshot.value?.runtimeType}');
      
      if (event.snapshot.value != null) {
        final rawData = event.snapshot.value;
        debugPrint('[ChatService] 🧾 Raw messages JSON for chat $requestId: $rawData');
        Map<dynamic, dynamic> data = {};
        
        // Handle both Map and List formats from Firebase
        if (rawData is Map) {
          data = rawData;
        } else if (rawData is List) {
          // Convert list to map
          for (int i = 0; i < rawData.length; i++) {
            if (rawData[i] != null) {
              data[i.toString()] = rawData[i];
            }
          }
        }
        
        debugPrint('[ChatService] 📝 Processing ${data.length} messages');
        
        data.forEach((key, value) {
          try {
            if (value is Map) {
              debugPrint('[ChatService] 🧾 Raw message [$key]: $value');
              final message = Message.fromJson(
                Map<String, dynamic>.from(value),
                key.toString(),
              );
              messages.add(message);
              debugPrint('[ChatService] 📩 Message: ${message.id} from ${message.senderId}: "${message.text.substring(0, message.text.length > 20 ? 20 : message.text.length)}..."');
            }
          } catch (e) {
            debugPrint('[ChatService] ⚠️ Error parsing message $key: $e');
          }
        });

        // Sort by timestamp descending (newest first for reverse list)
        messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        debugPrint('[ChatService] ✅ Returning ${messages.length} messages');
      } else {
        debugPrint('[ChatService] 📭 No messages in chat yet');
      }

      return messages;
    });
  }

  /// Mark all messages as read for current user
  Future<void> markAsRead({
    required String requestId,
    required String userId,
  }) async {
    try {
      final chatRef = _getChatRef(requestId);
      final messagesRef = _getMessagesRef(requestId);

      // Get all unread messages
      final messagesSnapshot = await messagesRef.get();
      
      if (messagesSnapshot.value != null) {
        final data = messagesSnapshot.value as Map<dynamic, dynamic>;
        final updates = <String, dynamic>{};

        data.forEach((key, value) {
          final messageData = Map<String, dynamic>.from(value as Map);
          final senderId = messageData['senderId'] as String;
          final read = messageData['read'] as bool? ?? false;

          // Mark as read if not sent by current user and not already read
          if (senderId != userId && !read) {
            updates['$key/read'] = true;
          }
        });

        if (updates.isNotEmpty) {
          await messagesRef.update(updates);
        }
      }

      // Reset unread count for current user
      await chatRef.update({
        'unreadCount/$userId': 0,
      });

      debugPrint('[ChatService] ✅ Messages marked as read: $requestId');
    } catch (e) {
      debugPrint('[ChatService] ❌ Error marking as read: $e');
    }
  }

  /// Get unread message count for current user
  Future<int> getUnreadCount(String requestId, String userId) async {
    try {
      final chatRef = _getChatRef(requestId);
      final snapshot = await chatRef.child('unreadCount/$userId').get();
      
      if (snapshot.value != null) {
        return snapshot.value as int;
      }
      
      return 0;
    } catch (e) {
      debugPrint('[ChatService] ❌ Error getting unread count: $e');
      return 0;
    }
  }

  /// Listen to unread count for current user (real-time)
  Stream<int> listenToUnreadCount(String requestId, String userId) {
    return _getChatRef(requestId)
        .child('unreadCount/$userId')
        .onValue
        .map((event) {
      if (event.snapshot.value != null) {
        return event.snapshot.value as int;
      }
      return 0;
    });
  }

  /// Get chat info
  Future<Chat?> getChat(String requestId) async {
    try {
      final chatRef = _getChatRef(requestId);
      final snapshot = await chatRef.get();

      if (snapshot.value != null) {
        debugPrint('[ChatService] 🧾 Raw chat JSON for request $requestId: ${snapshot.value}');
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        return Chat.fromJson(data, requestId);
      }

      return null;
    } catch (e) {
      debugPrint('[ChatService] ❌ Error getting chat: $e');
      return null;
    }
  }

  /// Get the timestamp of the latest message in a chat by scanning all messages
  Future<DateTime?> getLatestMessageTime(String requestId) async {
    try {
      final messagesRef = _getMessagesRef(requestId);
      final snapshot = await messagesRef.get();

      if (!snapshot.exists || snapshot.value == null) {
        debugPrint('[ChatService] 📭 No messages found for request $requestId');
        return null;
      }

      final rawData = snapshot.value;
      debugPrint('[ChatService] 🔍 Scanning messages for latest time in request $requestId');

      DateTime? latestTime;
      if (rawData is Map) {
        for (final entry in rawData.entries) {
          final value = entry.value;
          if (value is Map) {
            final tsRaw = value['timestamp'] ?? value['timestap'] ?? value['time'] ?? value['createdAt'] ?? value['updatedAt'];
            DateTime? msgTime;
            if (tsRaw is String) {
              final parts = tsRaw.split('::');
              final iso = parts.isNotEmpty ? parts.last : tsRaw;
              msgTime = DateTime.tryParse(iso);
            } else if (tsRaw is int) {
              msgTime = DateTime.fromMillisecondsSinceEpoch(tsRaw);
            }
            if (msgTime != null && (latestTime == null || msgTime.isAfter(latestTime))) {
              latestTime = msgTime;
            }
          }
        }
      }

      debugPrint('[ChatService] ⏱️ Latest message time for request $requestId: ${latestTime?.toIso8601String() ?? "none"}');
      return latestTime;
    } catch (e) {
      debugPrint('[ChatService] ❌ Error getting latest message time: $e');
      return null;
    }
  }

  /// Add participant to chat (for initializing chat)
  Future<void> initializeChat({
    required String requestId,
    required List<String> participants,
  }) async {
    try {
      debugPrint('[ChatService] 🔧 initializeChat for request: $requestId with participants: $participants');
      
      final chatRef = _getChatRef(requestId);
      final snapshot = await chatRef.get();

      if (!snapshot.exists) {
        // Create new chat
        await chatRef.set({
          'participants': participants,
          'updatedAt': DateTime.now().toIso8601String(),
          'unreadCount': {},
        });
        debugPrint('[ChatService] ✅ Chat created: $requestId');
      } else {
        // Chat exists - merge participants
        final existingParticipantsRaw = snapshot.child('participants').value;
        Set<String> allParticipants = {};
        
        // Parse existing participants
        if (existingParticipantsRaw is List) {
          allParticipants.addAll(existingParticipantsRaw.map((e) => e.toString()));
        } else if (existingParticipantsRaw is Map) {
          allParticipants.addAll(existingParticipantsRaw.values.map((e) => e.toString()));
        }
        
        // Add new participants
        allParticipants.addAll(participants);
        
        // Update if there are new participants
        final existingCount = existingParticipantsRaw is List ? existingParticipantsRaw.length : 0;
        if (allParticipants.length > existingCount) {
          await chatRef.update({
            'participants': allParticipants.toList(),
            'updatedAt': DateTime.now().toIso8601String(),
          });
          debugPrint('[ChatService] ✅ Chat updated with new participants: ${allParticipants.toList()}');
        } else {
          debugPrint('[ChatService] ℹ️ Chat already exists with all participants');
        }
      }
    } catch (e) {
      debugPrint('[ChatService] ❌ Error initializing chat: $e');
    }
  }

  /// Check if user has access to chat
  Future<bool> hasAccess(String requestId, String userId) async {
    try {
      final chatRef = _getChatRef(requestId);
      final snapshot = await chatRef.child('participants').get();

      if (snapshot.value != null) {
        final participants = List<String>.from(snapshot.value as List);
        return participants.contains(userId);
      }

      return false;
    } catch (e) {
      debugPrint('[ChatService] ❌ Error checking access: $e');
      return false;
    }
  }

  /// Format timestamp for display
  static String formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays == 0) {
      // Today - show time only
      final hour = timestamp.hour.toString().padLeft(2, '0');
      final minute = timestamp.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } else if (difference.inDays == 1) {
      // Yesterday
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      // This week - show day name
      const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
      return days[timestamp.weekday - 1];
    } else {
      // Older - show date
      final day = timestamp.day.toString().padLeft(2, '0');
      final month = timestamp.month.toString().padLeft(2, '0');
      final year = timestamp.year;
      return '$day/$month/$year';
    }
  }

  // ============================================================
  // DIRECT CHAT METHODS (Client <-> Driver without request)
  // ============================================================

  /// Initialize direct chat between client and driver
  Future<void> initializeDirectChat({
    required String clientId,
    required String driverId,
    String? clientName,
    String? clientAvatar,
    String? driverName,
    String? driverAvatar,
  }) async {
    try {
      debugPrint('[ChatService] 🔧 Initializing direct chat: client=$clientId, driver=$driverId');
      
      final chatRef = _getDirectChatRef(clientId, driverId);
      final snapshot = await chatRef.get();

      if (!snapshot.exists) {
        debugPrint('[ChatService] 📝 Creating new direct chat with:');
        debugPrint('[ChatService]    - clientId: $clientId (${clientId.runtimeType})');
        debugPrint('[ChatService]    - driverId: $driverId (${driverId.runtimeType})');
        debugPrint('[ChatService]    - clientName: $clientName');
        debugPrint('[ChatService]    - driverName: $driverName');
        
        // Create new direct chat with participant info
        final chatData = {
          'participants': [clientId, driverId],
          'clientId': clientId,
          'driverId': driverId,
          'clientName': clientName ?? 'Client',
          'clientAvatar': clientAvatar ?? '',
          'driverName': driverName ?? 'Driver',
          'driverAvatar': driverAvatar ?? '',
          'createdAt': DateTime.now().millisecondsSinceEpoch,
          'updatedAt': DateTime.now().toIso8601String(),
          'lastMessage': '',
          'lastMessageAt': DateTime.now().millisecondsSinceEpoch,
          'unreadCount': {},
        };
        
        await chatRef.set(chatData);
        debugPrint('[ChatService] ✅ Direct chat created successfully');
      } else {
        debugPrint('[ChatService] ℹ️ Direct chat already exists');
      }
    } catch (e) {
      debugPrint('[ChatService] ❌ Error initializing direct chat: $e');
    }
  }

  /// Send a message in direct chat
  Future<bool> sendDirectMessage({
    required String clientId,
    required String driverId,
    required String text,
    required String senderId,
    required String senderName,
    String? senderAvatar,
    String? mediaUrl,
    String? mediaType,
    String? mediaFileName,
    int? mediaSizeBytes,
    int? mediaDurationMs,
    String? mediaThumbnailUrl,
  }) async {
    try {
      final hasText = text.trim().isNotEmpty;
      final hasMedia = mediaUrl != null && mediaUrl.isNotEmpty;
      
      if (!hasText && !hasMedia) {
        debugPrint('[ChatService] ❌ Cannot send empty message');
        return false;
      }

      if (hasText && text.length > maxMessageLength) {
        debugPrint('[ChatService] ❌ Message too long: ${text.length} characters');
        return false;
      }

      final trimmedText = hasText ? text.trim() : '';
      final now = DateTime.now();
      
      debugPrint('[ChatService] 📤 Sending direct message from $senderId');
      if (hasMedia) {
        debugPrint('[ChatService] 📎 Media attached: $mediaType ($mediaFileName)');
      }

      // Create message
      final messagesRef = _getDirectMessagesRef(clientId, driverId);
      final messageKey = messagesRef.push().key ?? '${now.millisecondsSinceEpoch}_$senderId';
      final message = Message(
        id: messageKey,
        senderId: senderId,
        text: trimmedText,
        timestamp: now,
        read: false,
        senderName: senderName,
        senderAvatar: senderAvatar,
        mediaUrl: mediaUrl,
        mediaType: mediaType,
        mediaFileName: mediaFileName,
        mediaSizeBytes: mediaSizeBytes,
        mediaDurationMs: mediaDurationMs,
        mediaThumbnailUrl: mediaThumbnailUrl,
      );

      // Save message
      await messagesRef.child(messageKey).set(message.toJson());

      // Update chat metadata
      final chatRef = _getDirectChatRef(clientId, driverId);
      final chatSnapshot = await chatRef.get();
      
      // Get receiver ID
      final receiverId = senderId == clientId ? driverId : clientId;
      
      final updates = <String, dynamic>{
        'updatedAt': now.toIso8601String(),
        'lastMessage': trimmedText,
        'lastMessageAt': now.millisecondsSinceEpoch,
      };

      // Increment unread count for receiver
      if (chatSnapshot.exists) {
        final unreadCountRaw = chatSnapshot.child('unreadCount').value;
        int currentCount = 0;
        
        if (unreadCountRaw is Map) {
          currentCount = (unreadCountRaw[receiverId] as int?) ?? 0;
        }
        
        updates['unreadCount/$receiverId'] = currentCount + 1;
      } else {
        updates['unreadCount/$receiverId'] = 1;
      }

      await chatRef.update(updates);

      debugPrint('[ChatService] ✅ Direct message sent successfully');
      return true;
    } catch (e, stackTrace) {
      debugPrint('[ChatService] ❌ Error sending direct message: $e');
      debugPrint('[ChatService] Stack trace: $stackTrace');
      return false;
    }
  }

  /// Listen to direct chat messages
  Stream<List<Message>> listenToDirectMessages(String clientId, String driverId) {
    debugPrint('[ChatService] 🎧 Starting direct message listener: client=$clientId, driver=$driverId');
    
    final messagesRef = _getDirectMessagesRef(clientId, driverId);
    messagesRef.keepSynced(true);
    
    return messagesRef
        .orderByChild('timestamp')
        .limitToLast(messageLoadLimit)
        .onValue
        .map((event) {
      final messages = <Message>[];

      debugPrint('[ChatService] 📨 Direct message event received');
      
      if (event.snapshot.value != null) {
        final rawData = event.snapshot.value;
        debugPrint('[ChatService] 🧾 Raw direct messages JSON (client=$clientId, driver=$driverId): $rawData');
        Map<dynamic, dynamic> data = {};
        
        if (rawData is Map) {
          data = rawData;
        } else if (rawData is List) {
          for (int i = 0; i < rawData.length; i++) {
            if (rawData[i] != null) {
              data[i.toString()] = rawData[i];
            }
          }
        }
        
        debugPrint('[ChatService] 📝 Processing ${data.length} direct messages');
        
        data.forEach((key, value) {
          try {
            if (value is Map) {
              debugPrint('[ChatService] 🧾 Raw direct message [$key]: $value');
              final message = Message.fromJson(
                Map<String, dynamic>.from(value),
                key.toString(),
              );
              messages.add(message);
            }
          } catch (e) {
            debugPrint('[ChatService] ⚠️ Error parsing message $key: $e');
          }
        });

        messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        debugPrint('[ChatService] ✅ Returning ${messages.length} direct messages');
      } else {
        debugPrint('[ChatService] 📭 No direct messages yet');
      }

      return messages;
    });
  }

  /// Mark direct chat messages as read
  Future<void> markDirectAsRead({
    required String clientId,
    required String driverId,
    required String userId,
  }) async {
    try {
      final chatRef = _getDirectChatRef(clientId, driverId);
      final messagesRef = _getDirectMessagesRef(clientId, driverId);

      // Get all unread messages
      final messagesSnapshot = await messagesRef.get();
      
      if (messagesSnapshot.value != null) {
        final data = messagesSnapshot.value as Map<dynamic, dynamic>;
        final updates = <String, dynamic>{};

        data.forEach((key, value) {
          final messageData = Map<String, dynamic>.from(value as Map);
          final senderId = messageData['senderId'] as String;
          final read = messageData['read'] as bool? ?? false;

          if (senderId != userId && !read) {
            updates['$key/read'] = true;
          }
        });

        if (updates.isNotEmpty) {
          await messagesRef.update(updates);
        }
      }

      // Reset unread count for current user
      await chatRef.update({
        'unreadCount/$userId': 0,
      });

      debugPrint('[ChatService] ✅ Direct messages marked as read');
    } catch (e) {
      debugPrint('[ChatService] ❌ Error marking direct messages as read: $e');
    }
  }
}
