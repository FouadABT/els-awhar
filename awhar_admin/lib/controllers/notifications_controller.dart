import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:awhar_client/awhar_client.dart';
import '../core/services/api_service.dart';

/// Chat message model for admin AI chat
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final int? processingTimeMs;
  final bool isError;
  final bool isLoading;

  ChatMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
    this.processingTimeMs,
    this.isError = false,
    this.isLoading = false,
  }) : timestamp = timestamp ?? DateTime.now();
}

/// Notifications controller — manages AI chat, stats, history, and sending
class NotificationsController extends GetxController {
  // ============================================
  // STATE
  // ============================================
  final RxBool isLoading = false.obs;
  final RxBool isSending = false.obs;
  final RxBool isChatLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString successMessage = ''.obs;

  // Stats from ES
  final RxMap<String, dynamic> stats = <String, dynamic>{}.obs;

  // Notification history from ES
  final RxList<Map<String, dynamic>> history = <Map<String, dynamic>>[].obs;

  // Planner status
  final RxMap<String, dynamic> plannerStatus = <String, dynamic>{}.obs;

  // AI Chat
  final RxList<ChatMessage> chatMessages = <ChatMessage>[].obs;
  final RxString currentConversationId = ''.obs;

  // Active tab
  final RxInt activeTab = 0.obs;

  // Filter
  final RxString historyFilter = 'all'.obs;

  // Agent IDs
  static const String _conciergeAgentId = 'awhar-concierge';
  static const String _strategistAgentId = 'awhar-strategist';
  static const String _pulseAgentId = 'awhar-pulse';

  // Currently selected agent for chat
  final RxString selectedAgentId = 'awhar-pulse'.obs;

  Client get _client => ApiService.instance.client;

  @override
  void onInit() {
    super.onInit();
    loadAll();
  }

  /// Load all data in parallel
  Future<void> loadAll() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      await Future.wait([
        loadStats(),
        loadHistory(),
        loadStatus(),
      ]);
    } catch (e) {
      debugPrint('[NotificationsController] Error loading: $e');
      errorMessage.value = 'Failed to load data: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Load notification stats from ES
  Future<void> loadStats() async {
    try {
      final result = await _client.notificationPlanner.getStats();
      final decoded = jsonDecode(result);
      if (decoded is Map<String, dynamic>) {
        stats.value = decoded;
      }
    } catch (e) {
      debugPrint('[NotificationsController] Stats error: $e');
    }
  }

  /// Load notification history from ES
  Future<void> loadHistory({String? type, String? status}) async {
    try {
      final result = await _client.notificationPlanner.getHistory(
        limit: 50,
        type: type,
        status: status,
      );
      final decoded = jsonDecode(result);
      if (decoded is Map<String, dynamic> && decoded['notifications'] is List) {
        history.value = List<Map<String, dynamic>>.from(
          (decoded['notifications'] as List).map((n) => Map<String, dynamic>.from(n)),
        );
      }
    } catch (e) {
      debugPrint('[NotificationsController] History error: $e');
    }
  }

  /// Load planner status
  Future<void> loadStatus() async {
    try {
      final result = await _client.notificationPlanner.getStatus();
      final decoded = jsonDecode(result);
      if (decoded is Map<String, dynamic>) {
        plannerStatus.value = decoded;
      }
    } catch (e) {
      debugPrint('[NotificationsController] Status error: $e');
    }
  }

  // ============================================
  // AI AGENT CHAT
  // ============================================

  /// Send message to the selected Elastic Agent
  Future<void> sendChatMessage(String message) async {
    if (message.trim().isEmpty) return;

    // Add user message
    chatMessages.add(ChatMessage(text: message, isUser: true));

    // Add loading placeholder
    chatMessages.add(ChatMessage(
      text: 'Thinking...',
      isUser: false,
      isLoading: true,
    ));
    isChatLoading.value = true;

    try {
      final response = await _client.agent.converseWithAgent(
        agentId: selectedAgentId.value,
        message: message,
        conversationId: currentConversationId.value.isNotEmpty
            ? currentConversationId.value
            : null,
      );

      // Remove loading placeholder
      chatMessages.removeLast();

      if (response.success) {
        // Store conversation ID for multi-turn
        currentConversationId.value = response.conversationId;

        chatMessages.add(ChatMessage(
          text: response.message,
          isUser: false,
          processingTimeMs: response.processingTimeMs,
        ));
      } else {
        chatMessages.add(ChatMessage(
          text: response.errorMessage ?? 'Agent returned an error',
          isUser: false,
          isError: true,
        ));
      }
    } catch (e) {
      // Remove loading placeholder
      if (chatMessages.isNotEmpty && chatMessages.last.isLoading) {
        chatMessages.removeLast();
      }
      chatMessages.add(ChatMessage(
        text: 'Error: ${e.toString()}',
        isUser: false,
        isError: true,
      ));
    } finally {
      isChatLoading.value = false;
    }
  }

  /// Clear chat and start new conversation
  void clearChat() {
    chatMessages.clear();
    currentConversationId.value = '';
  }

  /// Switch agent
  void switchAgent(String agentId) {
    selectedAgentId.value = agentId;
    clearChat();
  }

  // ============================================
  // CUSTOM NOTIFICATION SENDING
  // ============================================

  /// Send custom notification to specific users
  Future<void> sendCustomNotification({
    required String userIds,
    required String title,
    required String body,
    String? priority,
    String? type,
  }) async {
    isSending.value = true;
    errorMessage.value = '';
    successMessage.value = '';

    try {
      final result = await _client.notificationPlanner.sendCustomNotification(
        userIds: userIds,
        title: title,
        body: body,
        priority: priority,
        type: type,
      );

      final decoded = jsonDecode(result);
      if (decoded['success'] == true) {
        successMessage.value =
            'Sent ${decoded['sent']}/${decoded['total']} notifications in ${decoded['duration_ms']}ms';
        // Refresh data
        await loadAll();
      } else {
        errorMessage.value = decoded['error'] ?? 'Failed to send notifications';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isSending.value = false;
    }
  }

  /// Send broadcast notification
  Future<void> sendBroadcast({
    required String title,
    required String body,
    String targetGroup = 'all',
    int limit = 100,
  }) async {
    isSending.value = true;
    errorMessage.value = '';
    successMessage.value = '';

    try {
      final result = await _client.notificationPlanner.sendBroadcast(
        title: title,
        body: body,
        targetGroup: targetGroup,
        limit: limit,
      );

      final decoded = jsonDecode(result);
      if (decoded['success'] == true) {
        successMessage.value =
            'Broadcast sent: ${decoded['sent']}/${decoded['total']} in ${decoded['duration_ms']}ms';
        await loadAll();
      } else {
        errorMessage.value = decoded['error'] ?? 'Broadcast failed';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isSending.value = false;
    }
  }

  // ============================================
  // PLANNER ACTIONS
  // ============================================

  /// Trigger AI planner dry run
  Future<void> triggerDryRun() async {
    isSending.value = true;
    errorMessage.value = '';
    successMessage.value = '';

    try {
      final result = await _client.notificationPlanner.dryRun();
      final decoded = jsonDecode(result);
      successMessage.value =
          'Dry run: ${decoded['planned']} planned, ${decoded['eligible']} eligible, '
          '${decoded['skipped_dedup'] ?? 0} deduped in ${decoded['duration_ms']}ms';
      await loadAll();
    } catch (e) {
      errorMessage.value = 'Dry run error: $e';
    } finally {
      isSending.value = false;
    }
  }

  /// Trigger real notification cycle
  Future<void> triggerRealCycle() async {
    isSending.value = true;
    errorMessage.value = '';
    successMessage.value = '';

    try {
      final result = await _client.notificationPlanner.runCycle(dryRun: false);
      final decoded = jsonDecode(result);
      successMessage.value =
          'Cycle complete: ${decoded['sent']} sent, ${decoded['failed']} failed in ${decoded['duration_ms']}ms';
      await loadAll();
    } catch (e) {
      errorMessage.value = 'Cycle error: $e';
    } finally {
      isSending.value = false;
    }
  }

  /// Get agent display name
  String getAgentName(String agentId) {
    switch (agentId) {
      case _conciergeAgentId:
        return 'Concierge';
      case _strategistAgentId:
        return 'Strategist';
      case _pulseAgentId:
        return 'Pulse (Notifications)';
      default:
        return agentId;
    }
  }
}
