import 'dart:convert';

import 'package:get_storage/get_storage.dart';

/// Stores and retrieves concierge chat conversations using GetStorage.
///
/// Each conversation is stored as a JSON-encoded list of simplified messages.
/// The storage key pattern is: `concierge_conv_{id}` for data,
/// and `concierge_conversations` for the index of all conversations.
class ConversationStorageService {
  static const String _indexKey = 'concierge_conversations';
  static const String _activeKey = 'concierge_active_conversation';
  static const int maxConversations = 50;

  final GetStorage _box = GetStorage();

  // ═══════════════════════════════════════════════════════════════════════════
  // CONVERSATION INDEX
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get list of all saved conversation summaries, newest first.
  List<ConversationSummary> getConversations() {
    final raw = _box.read<String>(_indexKey);
    if (raw == null) return [];
    try {
      final list = jsonDecode(raw) as List;
      final summaries =
          list.map((e) => ConversationSummary.fromJson(e)).toList();
      summaries.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return summaries;
    } catch (_) {
      return [];
    }
  }

  /// Save the conversation index.
  void _saveIndex(List<ConversationSummary> conversations) {
    final json = jsonEncode(conversations.map((c) => c.toJson()).toList());
    _box.write(_indexKey, json);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CONVERSATION DATA
  // ═══════════════════════════════════════════════════════════════════════════

  /// Save or update a conversation.
  void saveConversation({
    required String conversationId,
    required String title,
    required List<StoredMessage> messages,
    String? agentConversationId,
  }) {
    if (messages.isEmpty) return;

    // Save messages
    final key = _convKey(conversationId);
    final data = ConversationData(
      conversationId: conversationId,
      agentConversationId: agentConversationId,
      messages: messages,
    );
    _box.write(key, jsonEncode(data.toJson()));

    // Update index
    final conversations = getConversations();
    final existingIdx =
        conversations.indexWhere((c) => c.conversationId == conversationId);

    final lastUserMsg = messages.lastWhere(
      (m) => m.isUser,
      orElse: () => messages.last,
    );

    final summary = ConversationSummary(
      conversationId: conversationId,
      title: title.isNotEmpty ? title : _generateTitle(messages),
      preview: lastUserMsg.text.length > 80
          ? '${lastUserMsg.text.substring(0, 80)}...'
          : lastUserMsg.text,
      messageCount: messages.where((m) => !m.isWelcome).length,
      createdAt: existingIdx >= 0
          ? conversations[existingIdx].createdAt
          : DateTime.now(),
      updatedAt: DateTime.now(),
    );

    if (existingIdx >= 0) {
      conversations[existingIdx] = summary;
    } else {
      conversations.insert(0, summary);
    }

    // Trim old conversations
    if (conversations.length > maxConversations) {
      final removed = conversations.sublist(maxConversations);
      for (final r in removed) {
        _box.remove(_convKey(r.conversationId));
      }
      conversations.removeRange(maxConversations, conversations.length);
    }

    _saveIndex(conversations);
  }

  /// Load a conversation's messages.
  ConversationData? loadConversation(String conversationId) {
    final raw = _box.read<String>(_convKey(conversationId));
    if (raw == null) return null;
    try {
      return ConversationData.fromJson(jsonDecode(raw));
    } catch (_) {
      return null;
    }
  }

  /// Delete a conversation.
  void deleteConversation(String conversationId) {
    _box.remove(_convKey(conversationId));
    final conversations = getConversations();
    conversations.removeWhere((c) => c.conversationId == conversationId);
    _saveIndex(conversations);

    // Clear active if this was the active one
    if (activeConversationId == conversationId) {
      clearActiveConversation();
    }
  }

  /// Clear all conversations.
  void clearAll() {
    final conversations = getConversations();
    for (final c in conversations) {
      _box.remove(_convKey(c.conversationId));
    }
    _box.remove(_indexKey);
    _box.remove(_activeKey);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ACTIVE CONVERSATION TRACKING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get the currently active (last viewed) conversation ID.
  String? get activeConversationId => _box.read<String>(_activeKey);

  /// Set the active conversation.
  void setActiveConversation(String conversationId) {
    _box.write(_activeKey, conversationId);
  }

  /// Clear the active conversation (start fresh next time).
  void clearActiveConversation() {
    _box.remove(_activeKey);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPERS
  // ═══════════════════════════════════════════════════════════════════════════

  String _convKey(String id) => 'concierge_conv_$id';

  String _generateTitle(List<StoredMessage> messages) {
    final firstUser = messages.where((m) => m.isUser).firstOrNull;
    if (firstUser == null) return 'New Conversation';
    final text = firstUser.text;
    if (text.length <= 40) return text;
    return '${text.substring(0, 40)}...';
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// DATA MODELS
// ═══════════════════════════════════════════════════════════════════════════

/// Summary displayed in the conversation list.
class ConversationSummary {
  final String conversationId;
  final String title;
  final String preview;
  final int messageCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  ConversationSummary({
    required this.conversationId,
    required this.title,
    required this.preview,
    required this.messageCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ConversationSummary.fromJson(Map<String, dynamic> json) {
    return ConversationSummary(
      conversationId: json['conversationId'] as String,
      title: json['title'] as String? ?? 'Conversation',
      preview: json['preview'] as String? ?? '',
      messageCount: json['messageCount'] as int? ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'conversationId': conversationId,
        'title': title,
        'preview': preview,
        'messageCount': messageCount,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}

/// Full conversation data with all messages.
class ConversationData {
  final String conversationId;
  final String? agentConversationId;
  final List<StoredMessage> messages;

  ConversationData({
    required this.conversationId,
    this.agentConversationId,
    required this.messages,
  });

  factory ConversationData.fromJson(Map<String, dynamic> json) {
    return ConversationData(
      conversationId: json['conversationId'] as String,
      agentConversationId: json['agentConversationId'] as String?,
      messages: (json['messages'] as List? ?? [])
          .map((m) => StoredMessage.fromJson(m))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'conversationId': conversationId,
        'agentConversationId': agentConversationId,
        'messages': messages.map((m) => m.toJson()).toList(),
      };
}

/// Message for storage — includes serialized agent steps for entity card persistence.
class StoredMessage {
  final String id;
  final bool isUser;
  final String text;
  final DateTime timestamp;
  final bool isAgentBuilder;
  final bool isWelcome;
  final int toolCallCount;

  /// Serialized agent steps (tool calls + outputs) for restoring entity cards.
  final List<Map<String, dynamic>>? agentStepsJson;

  StoredMessage({
    required this.id,
    required this.isUser,
    required this.text,
    required this.timestamp,
    this.isAgentBuilder = false,
    this.isWelcome = false,
    this.toolCallCount = 0,
    this.agentStepsJson,
  });

  factory StoredMessage.fromJson(Map<String, dynamic> json) {
    return StoredMessage(
      id: json['id'] as String,
      isUser: json['isUser'] as bool? ?? false,
      text: json['text'] as String? ?? '',
      timestamp: DateTime.tryParse(json['timestamp'] as String? ?? '') ??
          DateTime.now(),
      isAgentBuilder: json['isAgentBuilder'] as bool? ?? false,
      isWelcome: json['isWelcome'] as bool? ?? false,
      toolCallCount: json['toolCallCount'] as int? ?? 0,
      agentStepsJson: (json['agentSteps'] as List?)
          ?.map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'isUser': isUser,
        'text': text,
        'timestamp': timestamp.toIso8601String(),
        'isAgentBuilder': isAgentBuilder,
        'isWelcome': isWelcome,
        'toolCallCount': toolCallCount,
        if (agentStepsJson != null) 'agentSteps': agentStepsJson,
      };
}
