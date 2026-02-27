import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../services/chat_service.dart';

class ConversationsController extends GetxController {
  final AuthController _auth = Get.find<AuthController>();
  final ChatService _chat = Get.find<ChatService>();

  final RxMap<String, DateTime> lastActivityByRequestId = <String, DateTime>{}.obs;
  final RxMap<String, int> unreadByRequestId = <String, int>{}.obs;

  StreamSubscription<DatabaseEvent>? _chatsAddedSub;
  StreamSubscription<DatabaseEvent>? _chatsChangedSub;

  @override
  void onInit() {
    super.onInit();
    _maybeStart();
    ever(_auth.currentUser, (_) => _restart());
  }

  void _maybeStart() {
    final uid = _auth.currentUser.value?.id?.toString();
    if (uid == null) return;
    _startListeners(uid);
  }

  void _restart() {
    _disposeListeners();
    lastActivityByRequestId.clear();
    unreadByRequestId.clear();
    _maybeStart();
  }

  void _startListeners(String uid) {
    final db = _chat.database;
    final ref = db.ref('chats');

    // Initial sync: load all chats once and compute
    ref.get().then((snapshot) async {
      if (!snapshot.exists || snapshot.value == null) return;
      final data = snapshot.value;
      if (data is! Map) return;
      for (final entry in data.entries) {
        final chatId = entry.key.toString();
        final v = entry.value;
        if (v is Map && _includesUser(v['participants'], uid)) {
          await _updateForChat(chatId, v, uid);
        }
      }
    });

    // Listen for new chats
    _chatsAddedSub = ref.onChildAdded.listen((event) async {
      final chatId = event.snapshot.key?.toString();
      final v = event.snapshot.value;
      if (chatId == null) return;
      if (v is Map && _includesUser(v['participants'], uid)) {
        await _updateForChat(chatId, v, uid);
      }
    });

    // Listen for changes (new messages, unread updates)
    _chatsChangedSub = ref.onChildChanged.listen((event) async {
      final chatId = event.snapshot.key?.toString();
      final v = event.snapshot.value;
      if (chatId == null) return;
      if (v is Map && _includesUser(v['participants'], uid)) {
        await _updateForChat(chatId, v, uid);
      }
    });
  }

  bool _includesUser(dynamic participants, String uid) {
    if (participants == null) return false;
    if (participants is List) {
      return participants.map((e) => e.toString()).contains(uid);
    }
    if (participants is Map) {
      return participants.values.map((e) => e.toString()).contains(uid);
    }
    return false;
  }

  Future<void> _updateForChat(String chatId, Map v, String uid) async {
    try {
      // Unread
      final unreadMap = v['unreadCount'];
      if (unreadMap is Map && unreadMap[uid] != null) {
        final count = int.tryParse(unreadMap[uid].toString()) ?? 0;
        unreadByRequestId[chatId] = count;
      }

      // Last activity: prefer scanning messages for true latest
      DateTime? latest;
      if (v['messages'] is Map) {
        final msgs = v['messages'] as Map;
        for (final mv in msgs.values) {
          if (mv is Map) {
            final ts = mv['timestamp'] ?? mv['timestap'] ?? mv['time'] ?? mv['createdAt'] ?? mv['updatedAt'];
            final dt = _parseTimestamp(ts);
            if (dt != null && (latest == null || dt.isAfter(latest))) latest = dt;
          }
        }
      }
      // Fallback to metadata
      if (latest == null) {
        final lma = v['lastMessageAt'] ?? v['updatedAt'];
        latest = _parseTimestamp(lma);
      }
      // If still null, ask ChatService to scan
      latest ??= await _chat.getLatestMessageTime(chatId);

      if (latest != null) {
        lastActivityByRequestId[chatId] = latest;
      }
      if (kDebugMode) {
        debugPrint('[Conversations] chatId=$chatId lastActivity=${latest?.toIso8601String()} unread=${unreadByRequestId[chatId] ?? 0}');
      }
    } catch (e) {
      if (kDebugMode) debugPrint('[Conversations] update error: $e');
    }
  }

  DateTime? _parseTimestamp(dynamic raw) {
    if (raw == null) return null;
    if (raw is int) return DateTime.fromMillisecondsSinceEpoch(raw);
    if (raw is String) {
      final parts = raw.split('::');
      return DateTime.tryParse(parts.isNotEmpty ? parts.last : raw);
    }
    return null;
  }

  // Called by NotificationService to immediately reflect new messages
  Future<void> bumpFromNotification(String requestId) async {
    lastActivityByRequestId[requestId] = DateTime.now();
    final uid = _auth.currentUser.value?.id?.toString();
    if (uid != null) {
      final current = unreadByRequestId[requestId] ?? 0;
      unreadByRequestId[requestId] = current + 1;
      // Also schedule a precise sync from RTDB
      try {
        final db = _chat.database;
        final snap = await db.ref('chats/$requestId').get();
        if (snap.exists && snap.value is Map) {
          await _updateForChat(requestId, snap.value as Map, uid);
        }
      } catch (_) {}
    }
  }

  @override
  void onClose() {
    _disposeListeners();
    super.onClose();
  }

  void _disposeListeners() {
    _chatsAddedSub?.cancel();
    _chatsChangedSub?.cancel();
    _chatsAddedSub = null;
    _chatsChangedSub = null;
  }
}
