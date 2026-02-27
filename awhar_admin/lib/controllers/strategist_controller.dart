import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:awhar_client/awhar_client.dart';
import '../core/services/api_service.dart';

/// Chat message model for strategist AI chat
class StrategistMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final int? processingTimeMs;
  final bool isError;
  final bool isLoading;
  final List<Map<String, dynamic>>? steps;

  StrategistMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
    this.processingTimeMs,
    this.isError = false,
    this.isLoading = false,
    this.steps,
  }) : timestamp = timestamp ?? DateTime.now();
}

/// Strategist page controller — ES-only analytics agent
class StrategistController extends GetxController {
  // ============================================
  // STATE
  // ============================================
  final RxBool isLoading = false.obs;
  final RxBool isChatLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Chat
  final RxList<StrategistMessage> chatMessages = <StrategistMessage>[].obs;
  final RxString currentConversationId = ''.obs;

  // Active section: 0 = Chat, 1 = ES Explorer
  final RxInt activeSection = 0.obs;

  // ES Explorer
  final RxList<Map<String, dynamic>> esIndices = <Map<String, dynamic>>[].obs;
  final RxMap<String, dynamic> selectedIndexMapping = <String, dynamic>{}.obs;
  final RxString selectedIndex = ''.obs;
  final RxBool isLoadingIndices = false.obs;
  final RxBool isLoadingMapping = false.obs;

  // Quick stats from ES
  final RxMap<String, dynamic> platformStats = <String, dynamic>{}.obs;
  final RxBool isLoadingStats = false.obs;

  static const String _strategistAgentId = 'awhar-strategist';

  Client get _client => ApiService.instance.client;

  @override
  void onInit() {
    super.onInit();
    refreshAll();
  }

  Future<void> refreshAll() async {
    await Future.wait([
      loadIndices(),
      loadPlatformStats(),
    ]);
  }

  // ============================================
  // AI STRATEGIST CHAT
  // ============================================

  /// Send message to the Strategist agent
  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // Add user message
    chatMessages.add(StrategistMessage(text: message, isUser: true));

    // Add loading placeholder
    chatMessages.add(StrategistMessage(
      text: 'Analyzing with Elasticsearch...',
      isUser: false,
      isLoading: true,
    ));
    isChatLoading.value = true;

    try {
      final response = await _client.agent.converseWithAgent(
        agentId: _strategistAgentId,
        message: message,
        conversationId: currentConversationId.value.isNotEmpty
            ? currentConversationId.value
            : null,
      );

      // Remove loading placeholder
      chatMessages.removeLast();

      if (response.success) {
        currentConversationId.value = response.conversationId;

        // Parse steps for tool usage display
        final steps = <Map<String, dynamic>>[];
        for (final step in response.steps) {
          steps.add({
            'type': step.type,
            'toolName': step.toolName,
            'hasOutput': (step.toolOutput ?? '').isNotEmpty,
          });
        }

        chatMessages.add(StrategistMessage(
          text: response.message,
          isUser: false,
          processingTimeMs: response.processingTimeMs,
          steps: steps.isNotEmpty ? steps : null,
        ));
      } else {
        chatMessages.add(StrategistMessage(
          text: response.errorMessage ?? 'Agent returned an error',
          isUser: false,
          isError: true,
        ));
      }
    } catch (e) {
      if (chatMessages.isNotEmpty && chatMessages.last.isLoading) {
        chatMessages.removeLast();
      }
      chatMessages.add(StrategistMessage(
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

  // ============================================
  // ES INDEX EXPLORER
  // ============================================

  /// Load all awhar-* indices from Elasticsearch
  Future<void> loadIndices() async {
    isLoadingIndices.value = true;
    try {
      // Returns Map<String, int>: {"awhar-drivers": 6, "awhar-services": 22, ...}
      final counts = await _client.elasticsearch.getDocumentCounts();
      debugPrint('[StrategistController] getDocumentCounts: $counts (${counts.length} entries)');
      
      if (counts.isEmpty) {
        debugPrint('[StrategistController] No index counts found');
        return;
      }
      
      // Convert to list of index objects
      final indexList = <Map<String, dynamic>>[];
      counts.forEach((indexName, docCount) {
        indexList.add({
          'index': indexName,
          'docsCount': docCount,
          'health': docCount >= 0 ? 'green' : 'red',
        });
      });
      
      // Sort by doc count descending
      indexList.sort((a, b) => (b['docsCount'] as int).compareTo(a['docsCount'] as int));
      
      debugPrint('[StrategistController] Loaded ${indexList.length} indices');
      esIndices.value = indexList;
    } catch (e, stack) {
      debugPrint('[StrategistController] Indices error: $e');
      debugPrint('[StrategistController] Stack: $stack');
    } finally {
      isLoadingIndices.value = false;
    }
  }

  /// Load mapping for a selected index
  Future<void> loadIndexMapping(String indexName) async {
    selectedIndex.value = indexName;
    isLoadingMapping.value = true;
    try {
      // Use agent to get mapping info since there's no direct client method
      final result = await _client.elasticsearch.checkIndex(indexName);
      selectedIndexMapping.value = result;
    } catch (e) {
      debugPrint('[StrategistController] Mapping error: $e');
    } finally {
      isLoadingMapping.value = false;
    }
  }

  /// Quick ask about a specific index
  void askAboutIndex(String indexName) {
    activeSection.value = 0; // Switch to chat
    sendMessage('Show me the latest 10 documents from the $indexName index with a summary of what data it contains');
  }

  // ============================================
  // PLATFORM STATS
  // ============================================

  /// Load quick platform stats via ES
  Future<void> loadPlatformStats() async {
    isLoadingStats.value = true;
    try {
      // Returns Map<String, int>: {"awhar-drivers": 6, "awhar-services": 22, ...}
      final counts = await _client.elasticsearch.getDocumentCounts();
      debugPrint('[StrategistController] Stats response: $counts (${counts.length} entries)');
      
      // Convert Map<String, int> to Map<String, dynamic> for the reactive var
      platformStats.value = counts.map((k, v) => MapEntry(k, v as dynamic));
      
      debugPrint('[StrategistController] Platform stats loaded: ${platformStats.length} entries');
    } catch (e, stack) {
      debugPrint('[StrategistController] Stats error: $e');
      debugPrint('[StrategistController] Stack: $stack');
    } finally {
      isLoadingStats.value = false;
    }
  }
}
