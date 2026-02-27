import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:awhar_client/awhar_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../core/controllers/auth_controller.dart';
import '../../core/services/location_service.dart';
import '../agents/concierge_agent.dart';
import '../services/conversation_storage_service.dart';
import '../services/vision_service.dart';

/// Represents a single message in the concierge chat.
class ConciergeMessage {
  final String id;
  final bool isUser;
  final String text;
  final DateTime timestamp;

  /// For AI messages — the parsed service data (null for user messages).
  final AiParsedServiceRequest? parsedRequest;

  /// For AI messages — the full response (null for user messages).
  final AiRequestConciergeResponse? conciergeResponse;

  /// For Agent Builder messages — tool execution steps.
  final List<AgentBuilderStep>? agentSteps;

  /// Whether this message contains service suggestions to pick from.
  final bool hasSuggestions;

  /// Whether this is a "thinking/loading" placeholder.
  final bool isLoading;

  /// Whether this is from Agent Builder (vs legacy ELSER).
  final bool isAgentBuilder;

  /// Whether this message is streaming (being built live from SSE events).
  final bool isStreaming;

  /// Current reasoning text being shown during streaming.
  final String? streamingReasoning;

  /// Current tool being called during streaming.
  final String? streamingToolName;

  /// Message text accumulated from streaming chunks so far.
  final String? streamingText;

  /// Streaming progress steps (tool calls seen so far).
  final List<String>? streamingToolNames;

  /// Local image file path for user messages with image attachments.
  final String? imagePath;

  /// LLM model used (e.g. "google-gemini-2.5-flash").
  final String? model;

  /// Number of LLM calls made during this round.
  final int? llmCalls;

  /// Total input tokens consumed.
  final int? inputTokens;

  /// Total output tokens consumed.
  final int? outputTokens;

  /// Estimated cost in USD (visible model only).
  final double? estimatedCostUsd;

  ConciergeMessage({
    required this.id,
    required this.isUser,
    required this.text,
    DateTime? timestamp,
    this.parsedRequest,
    this.conciergeResponse,
    this.agentSteps,
    this.hasSuggestions = false,
    this.isLoading = false,
    this.isAgentBuilder = false,
    this.isStreaming = false,
    this.streamingReasoning,
    this.streamingToolName,
    this.streamingText,
    this.streamingToolNames,
    this.imagePath,
    this.model,
    this.llmCalls,
    this.inputTokens,
    this.outputTokens,
    this.estimatedCostUsd,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Create a user message.
  factory ConciergeMessage.user(String text, {String? imagePath}) =>
      ConciergeMessage(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        isUser: true,
        text: text,
        imagePath: imagePath,
      );

  /// Create an AI loading indicator message.
  factory ConciergeMessage.loading() => ConciergeMessage(
        id: 'loading_${DateTime.now().millisecondsSinceEpoch}',
        isUser: false,
        text: '',
        isLoading: true,
      );

  /// Create an AI response message with parsed results (legacy ELSER).
  factory ConciergeMessage.aiResponse({
    required AiRequestConciergeResponse response,
  }) {
    final parsed = response.parsedRequest;
    final hasServices =
        parsed != null && parsed.detectedServices.isNotEmpty;

    return ConciergeMessage(
      id: 'ai_${DateTime.now().millisecondsSinceEpoch}',
      isUser: false,
      text: response.humanReadableSummary,
      parsedRequest: parsed,
      conciergeResponse: response,
      hasSuggestions: hasServices,
    );
  }

  /// Create an Agent Builder response message.
  ///
  /// Shows the agent's natural language response + tool execution steps.
  /// This is the PRIMARY message type for hackathon demo.
  factory ConciergeMessage.agentBuilder({
    required AgentBuilderConverseResponse response,
  }) {
    return ConciergeMessage(
      id: 'agent_${DateTime.now().millisecondsSinceEpoch}',
      isUser: false,
      text: response.message,
      agentSteps: response.steps,
      isAgentBuilder: true,
      // Agent Builder responses are conversational text, not structured cards
      hasSuggestions: false,
      model: response.model,
      llmCalls: response.llmCalls,
      inputTokens: response.inputTokens,
      outputTokens: response.outputTokens,
      estimatedCostUsd: response.estimatedCostUsd,
    );
  }

  /// Create a streaming placeholder — updated live as SSE events arrive.
  ///
  /// This message is replaced in the RxList as new events come in,
  /// giving the user real-time visibility into:
  /// - Agent reasoning ("Let me search for...")
  /// - Tool calls ("Searching services...", "Querying prices...")
  /// - Answer text streaming chunk by chunk
  factory ConciergeMessage.streaming({
    required String id,
    String? reasoning,
    String? toolName,
    String? text,
    List<String>? toolNames,
    List<AgentBuilderStep>? steps,
  }) {
    return ConciergeMessage(
      id: id,
      isUser: false,
      text: text ?? '',
      isAgentBuilder: true,
      isStreaming: true,
      streamingReasoning: reasoning,
      streamingToolName: toolName,
      streamingText: text,
      streamingToolNames: toolNames,
      agentSteps: steps,
    );
  }

  /// Create an AI error message.
  factory ConciergeMessage.error(String errorText) => ConciergeMessage(
        id: 'error_${DateTime.now().millisecondsSinceEpoch}',
        isUser: false,
        text: errorText,
      );

  /// Create the initial welcome message.
  factory ConciergeMessage.welcome(String text) => ConciergeMessage(
        id: 'welcome',
        isUser: false,
        text: text,
      );
}

/// Controller for the AI Concierge chat screen.
///
/// ## Architecture: Kibana Agent Builder Integration
///
/// PRIMARY flow (Agent Builder):
/// 1. User describes need in natural language
/// 2. Message sent to Kibana Agent Builder via Serverpod proxy
/// 3. Kibana agent uses LLM + ES|QL tools to process request
/// 4. Agent's response + tool steps shown in chat UI
/// 5. Multi-turn conversation for refinement
///
/// FALLBACK flow (Direct ELSER):
/// 1. If Agent Builder is unavailable, falls back to Dart ELSER agents
/// 2. Uses ELSER hybrid search on awhar-services
/// 3. Returns structured service cards
///
/// Elasticsearch features demonstrated:
/// - Agent Builder with ES|QL tools
/// - ELSER v2 semantic search (fallback)
/// - Hybrid RRF retrieval (fallback)
/// - Knowledge base RAG enrichment (fallback)
class ConciergeController extends GetxController {
  final ConciergeAgent _agent = ConciergeAgent();
  final ConversationStorageService _storage = ConversationStorageService();

  // Chat state
  final RxList<ConciergeMessage> messages = <ConciergeMessage>[].obs;
  final RxBool isProcessing = false.obs;

  // Agent Builder state
  final RxString currentConversationId = ''.obs;
  final RxBool useAgentBuilder = true.obs; // PRIMARY: Agent Builder

  /// Local conversation ID for storage (separate from Kibana conversation ID).
  String _localConversationId = '';

  /// The Kibana Agent Builder agent ID for the Concierge.
  /// Created via PUT /api/agent_builder/agents/awhar-concierge
  /// Tools: platform.core.search, generate_esql, execute_esql, get_index_mapping, list_indices, index_explorer
  String conciergeAgentId = 'awhar-concierge';

  /// The LLM connector to use. Must match a Kibana connector ID.
  /// Available: Anthropic-Claude-Sonnet-4-5, Google-Gemini-2-5-Pro, OpenAI-GPT-5-2
  /// Using GPT-4.1 Mini for fast, cost-efficient responses
  String defaultConnectorId = 'OpenAI-GPT-4-1-Mini';

  // Selected service from AI suggestions (legacy flow)
  final Rx<AiParsedServiceRequest?> selectedParsedRequest =
      Rx<AiParsedServiceRequest?>(null);
  final RxInt selectedServiceIndex = (-1).obs;
  final RxString selectedServiceName = ''.obs;

  // Extracted data for form population
  final RxString extractedLocation = ''.obs;
  final RxString extractedTime = ''.obs;
  final RxBool extractedUrgent = false.obs;
  final RxString detectedLanguage = ''.obs;
  final RxString userDescription = ''.obs;

  // Confidence tracking
  final Rx<AiConfidenceLevel> confidence =
      Rx<AiConfidenceLevel>(AiConfidenceLevel.low);

  // Processing metrics (for demo/judges)
  final RxInt lastProcessingTimeMs = 0.obs;
  final RxInt totalToolCalls = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Try to resume the last active conversation, or start fresh
    final activeId = _storage.activeConversationId;
    if (activeId != null) {
      resumeConversation(activeId);
    } else {
      _startNewLocalConversation();
    }
  }

  /// Start a brand-new local conversation.
  void _startNewLocalConversation() {
    _localConversationId =
        'conv_${DateTime.now().millisecondsSinceEpoch}';
    currentConversationId.value = '';
    messages.clear();
    _addWelcome();
    _storage.setActiveConversation(_localConversationId);
  }

  /// Resume a previously saved conversation.
  void resumeConversation(String localConvId) {
    final data = _storage.loadConversation(localConvId);
    if (data == null || data.messages.isEmpty) {
      _startNewLocalConversation();
      return;
    }

    _localConversationId = localConvId;
    currentConversationId.value = data.agentConversationId ?? '';
    messages.clear();

    // Restore messages from storage (including agent steps for entity cards)
    for (final stored in data.messages) {
      if (stored.isWelcome) {
        messages.add(ConciergeMessage.welcome(stored.text));
      } else {
        // Restore agentSteps from serialized JSON if available
        List<AgentBuilderStep>? restoredSteps;
        if (stored.agentStepsJson != null && stored.agentStepsJson!.isNotEmpty) {
          try {
            restoredSteps = stored.agentStepsJson!
                .map((json) => AgentBuilderStep.fromJson(json))
                .toList();
          } catch (e) {
            debugPrint('[ConciergeCtrl] Failed to restore agent steps: $e');
          }
        }

        messages.add(ConciergeMessage(
          id: stored.id,
          isUser: stored.isUser,
          text: stored.text,
          timestamp: stored.timestamp,
          isAgentBuilder: stored.isAgentBuilder,
          agentSteps: restoredSteps,
        ));
      }
    }

    _storage.setActiveConversation(_localConversationId);
    debugPrint('[ConciergeCtrl] Resumed conversation: $localConvId '
        '(${data.messages.length} messages)');
  }

  /// Start a new conversation (clears current, keeps history).
  void startNewConversation() {
    _autoSave(); // Save current first
    _startNewLocalConversation();
  }

  /// Get conversation history list.
  List<ConversationSummary> getConversationHistory() {
    return _storage.getConversations();
  }

  /// Delete a conversation from history.
  void deleteConversation(String conversationId) {
    _storage.deleteConversation(conversationId);
  }

  /// Get the current local conversation ID.
  String get localConversationId => _localConversationId;

  void _addWelcome() {
    messages.add(ConciergeMessage.welcome(
      'concierge_chat.welcome'.tr,
    ));
  }

  /// Detect language from user text for the backend.
  String _detectLanguage(String text) {
    // Arabic characters
    if (RegExp(r'[\u0600-\u06FF]').hasMatch(text)) return 'ar';
    // French indicators
    final frenchWords = [
      'je',
      'besoin',
      'cherche',
      'veux',
      'livraison',
      'aide',
      'pour',
      'faire',
      'avec',
      'dans'
    ];
    final lower = text.toLowerCase();
    final frenchCount =
        frenchWords.where((w) => lower.contains(w)).length;
    if (frenchCount >= 2) return 'fr';
    return 'en';
  }

  /// Send a user message with an image attachment.
  ///
  /// Flow:
  /// 1. Show image + text in chat immediately
  /// 2. Use Gemini Vision to describe the image
  /// 3. Send combined description + user text to the agent
  Future<void> sendImageMessage(File imageFile, {String text = ''}) async {
    if (isProcessing.value) return;

    final userText = text.trim().isNotEmpty
        ? text.trim()
        : 'concierge_chat.image_sent'.tr;

    // Show user message with image immediately
    messages.add(ConciergeMessage.user(
      userText,
      imagePath: imageFile.path,
    ));

    final loadingMsg = ConciergeMessage.loading();
    messages.add(loadingMsg);
    isProcessing.value = true;

    try {
      // Describe image with Gemini Vision
      debugPrint('[ConciergeCtrl] Describing image with Gemini Vision...');
      String description;
      try {
        description = await VisionService().describeImage(
          imageFile,
          userHint: text.trim().isNotEmpty ? text.trim() : null,
        );
      } catch (e) {
        debugPrint('[ConciergeCtrl] Vision failed: $e');
        messages.removeWhere((m) => m.id == loadingMsg.id);
        messages.add(ConciergeMessage.error(
          'concierge_chat.image_error'.tr,
        ));
        isProcessing.value = false;
        return;
      }

      if (description.isEmpty) {
        messages.removeWhere((m) => m.id == loadingMsg.id);
        messages.add(ConciergeMessage.error(
          'concierge_chat.image_error'.tr,
        ));
        isProcessing.value = false;
        return;
      }

      // Build combined prompt for the agent
      final combinedText = text.trim().isNotEmpty
          ? '[The user sent a photo. Image content: $description]\n\nUser message: ${text.trim()}'
          : '[The user sent a photo. Image content: $description]\n\nPlease help me with what you see in the image.';

      debugPrint('[ConciergeCtrl] Vision description: $description');

      // Send combined text to agent
      userDescription.value = combinedText;
      final lang = _detectLanguage(text.isNotEmpty ? text : description);
      detectedLanguage.value = lang;

      if (useAgentBuilder.value) {
        await _sendViaAgentBuilder(combinedText, loadingMsg);
      } else {
        await _sendViaElser(combinedText, lang, loadingMsg);
      }
    } catch (e) {
      debugPrint('[ConciergeCtrl] sendImageMessage error: $e');
      messages.removeWhere((m) => m.id == loadingMsg.id);
      messages.add(ConciergeMessage.error(
        'concierge_chat.error_generic'.tr,
      ));
    } finally {
      isProcessing.value = false;
    }
  }

  /// Send a user message — uses Agent Builder (primary) or ELSER (fallback).
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || isProcessing.value) return;

    userDescription.value = text.trim();
    final lang = _detectLanguage(text);
    detectedLanguage.value = lang;

    // Add user message
    messages.add(ConciergeMessage.user(text.trim()));

    // Add loading indicator
    final loadingMsg = ConciergeMessage.loading();
    messages.add(loadingMsg);
    isProcessing.value = true;

    debugPrint('[ConciergeCtrl] sendMessage: useAgentBuilder=${useAgentBuilder.value}, lang=$lang');

    try {
      if (useAgentBuilder.value) {
        await _sendViaAgentBuilder(text.trim(), loadingMsg);
      } else {
        await _sendViaElser(text.trim(), lang, loadingMsg);
      }
    } catch (e) {
      debugPrint('[ConciergeCtrl] sendMessage error: $e');
      messages.removeWhere((m) => m.id == loadingMsg.id);
      messages.add(ConciergeMessage.error(
        'concierge_chat.error_generic'.tr,
      ));
    } finally {
      isProcessing.value = false;
    }
  }

  /// PRIMARY: Send via Kibana Agent Builder with REAL-TIME STREAMING.
  ///
  /// Flow:
  /// 1. Call startAgentConverse() → get session ID instantly
  /// 2. Show streaming message bubble with "Thinking..." state
  /// 3. Poll every 500ms for SSE events from the server
  /// 4. Update the message bubble live with reasoning, tools, answer chunks
  /// 5. On complete, replace with final message
  ///
  /// This gives Kibana-like real-time visibility into agent reasoning.
  Future<void> _sendViaAgentBuilder(String text, ConciergeMessage loadingMsg) async {
    // Get user info from AuthController
    int? userId;
    try {
      final auth = Get.find<AuthController>();
      userId = auth.userId;
    } catch (_) {}

    // Get location from LocationService (request fresh position if needed)
    double? lat;
    double? lng;
    try {
      final location = Get.find<LocationService>();
      // Try to get a fresh GPS position for the concierge
      if (location.currentPosition.value == null) {
        await location.getCurrentPosition();
      }
      lat = location.currentPosition.value?.latitude;
      lng = location.currentPosition.value?.longitude;
    } catch (_) {}

    debugPrint('[ConciergeCtrl] Agent Builder STREAM: agentId=$conciergeAgentId, '
        'userId=$userId, loc=$lat,$lng');

    try {
      // Step 1: Start the streaming session — returns immediately
      final sessionId = await _agent.startConverse(
        agentId: conciergeAgentId,
        message: text,
        conversationId: currentConversationId.value.isNotEmpty
            ? currentConversationId.value
            : null,
        connectorId: defaultConnectorId,
        userId: userId,
        latitude: lat,
        longitude: lng,
      );

      debugPrint('[ConciergeCtrl] Stream started: sessionId=$sessionId');

      // Step 2: Replace loading dots with a streaming message
      final streamMsgId = 'stream_${DateTime.now().millisecondsSinceEpoch}';
      messages.removeWhere((m) => m.id == loadingMsg.id);
      messages.add(ConciergeMessage.streaming(
        id: streamMsgId,
        reasoning: 'Thinking...',
      ));

      // Step 3: Poll for events every 500ms
      int lastEventIndex = 0;
      String? currentReasoning;
      String? currentToolName;
      String accumulatedText = '';
      final toolNamesSeen = <String>[];
      final completer = Completer<void>();
      bool isPolling = false; // Guard against concurrent polls

      final timer = Timer.periodic(const Duration(milliseconds: 500), (t) async {
        if (isPolling || completer.isCompleted) return; // Skip if previous poll still running
        isPolling = true;

        try {
          final status = await _agent.pollStream(
            streamSessionId: sessionId,
            lastEventIndex: lastEventIndex,
          );

          // Process new events
          for (final event in status.events) {
            lastEventIndex++;
            final eventData = _decodeEventData(event.data);
            final eventType = event.type;

            debugPrint('[ConciergeCtrl] SSE event: $eventType keys=${eventData.keys.toList()}');

            switch (eventType) {
              case 'reasoning':
                currentReasoning = eventData['reasoning']?.toString()
                    ?? eventData['text']?.toString()
                    ?? eventData['raw']?.toString()
                    ?? eventData['data']?.toString()
                    ?? '';
                break;
              case 'tool_call':
                currentToolName = eventData['tool_id']?.toString()
                    ?? eventData['tool_name']?.toString()
                    ?? eventData['toolId']?.toString()
                    ?? eventData['name']?.toString()
                    ?? 'tool';
                if (!toolNamesSeen.contains(currentToolName)) {
                  toolNamesSeen.add(currentToolName!);
                }
                break;
              case 'tool_result':
                // Tool finished — clear current tool name
                currentToolName = null;
                break;
              case 'tool_progress':
                // Optional progress update
                break;
              case 'message_chunk':
                final chunk = eventData['text_chunk']?.toString()
                    ?? eventData['chunk']?.toString()
                    ?? eventData['text']?.toString()
                    ?? eventData['raw']?.toString()
                    ?? '';
                if (chunk.isNotEmpty) accumulatedText += chunk;
                break;
              case 'message_complete':
                accumulatedText = eventData['message_content']?.toString()
                    ?? eventData['message']?.toString()
                    ?? eventData['text']?.toString()
                    ?? eventData['raw']?.toString()
                    ?? accumulatedText;
                break;
              case 'thinking_complete':
                currentReasoning = null; // Done thinking
                break;
            }

            // Update the streaming message in-place
            final idx = messages.indexWhere((m) => m.id == streamMsgId);
            if (idx >= 0) {
              messages[idx] = ConciergeMessage.streaming(
                id: streamMsgId,
                reasoning: currentReasoning,
                toolName: currentToolName,
                text: accumulatedText.isNotEmpty ? accumulatedText : null,
                toolNames: toolNamesSeen.isNotEmpty ? List.from(toolNamesSeen) : null,
              );
            }
          }

          // Check if done
          if (status.status == 'complete') {
            t.cancel();

            // Replace streaming message with final message
            final idx = messages.indexWhere((m) => m.id == streamMsgId);
            if (idx >= 0) {
              final finalText = status.finalMessage ?? accumulatedText;
              final finalSteps = status.steps ?? [];

              // Track metrics
              lastProcessingTimeMs.value = status.processingTimeMs ?? 0;
              final toolCalls = finalSteps
                  .where((s) => s.toolName != null && s.toolName!.isNotEmpty)
                  .length;
              totalToolCalls.value += toolCalls;

              // Store conversation ID
              if (status.conversationId != null && status.conversationId!.isNotEmpty) {
                currentConversationId.value = status.conversationId!;
              }

              messages[idx] = ConciergeMessage(
                id: 'agent_${DateTime.now().millisecondsSinceEpoch}',
                isUser: false,
                text: finalText,
                agentSteps: finalSteps,
                isAgentBuilder: true,
              );

              debugPrint('[ConciergeCtrl] Stream complete: ${finalText.length} chars, '
                  '$toolCalls tools, ${status.processingTimeMs}ms');
            }

            _autoSave();
            if (!completer.isCompleted) completer.complete();
            return;
          }

          if (status.status == 'error') {
            t.cancel();
            final idx = messages.indexWhere((m) => m.id == streamMsgId);
            if (idx >= 0) {
              messages[idx] = ConciergeMessage.error(
                status.errorMessage ?? 'concierge_chat.error_generic'.tr,
              );
            }
            if (!completer.isCompleted) completer.complete();
            return;
          }
        } catch (e) {
          debugPrint('[ConciergeCtrl] Poll error: $e');
          // Don't cancel timer on transient errors — retry next poll
        } finally {
          isPolling = false;
        }
      });

      // Wait for the stream to complete (max 3 minutes)
      await completer.future.timeout(
        const Duration(minutes: 3),
        onTimeout: () {
          timer.cancel();
          final idx = messages.indexWhere((m) => m.id == streamMsgId);
          if (idx >= 0) {
            messages[idx] = ConciergeMessage.error('Request timed out. Please try again.');
          }
        },
      );
    } catch (e) {
      debugPrint('[ConciergeCtrl] Stream start error: $e');
      // Fall back to non-streaming approach
      debugPrint('[ConciergeCtrl] Falling back to sync converse...');
      await _sendViaAgentBuilderSync(text, loadingMsg);
    }
  }

  /// Decode JSON event data safely.
  Map<String, dynamic> _decodeEventData(String data) {
    try {
      final parsed = json.decode(data);
      if (parsed is Map<String, dynamic>) return parsed;
      return {'raw': parsed};
    } catch (_) {
      return {'raw': data};
    }
  }

  /// FALLBACK: Non-streaming Agent Builder (original sync approach).
  ///
  /// Used when streaming fails to start.
  Future<void> _sendViaAgentBuilderSync(String text, ConciergeMessage loadingMsg) async {
    int? userId;
    try {
      final auth = Get.find<AuthController>();
      userId = auth.userId;
    } catch (_) {}

    double? lat;
    double? lng;
    try {
      final location = Get.find<LocationService>();
      lat = location.currentPosition.value?.latitude;
      lng = location.currentPosition.value?.longitude;
    } catch (_) {}

    final response = await _agent.converse(
      agentId: conciergeAgentId,
      message: text,
      conversationId: currentConversationId.value.isNotEmpty
          ? currentConversationId.value
          : null,
      connectorId: defaultConnectorId,
      userId: userId,
      latitude: lat,
      longitude: lng,
    );

    messages.removeWhere((m) => m.id == loadingMsg.id);
    lastProcessingTimeMs.value = response.processingTimeMs;

    if (!response.success) {
      if (response.errorMessage?.contains('404') == true ||
          response.errorMessage?.contains('not found') == true) {
        final lang = _detectLanguage(text);
        await _sendViaElser(text, lang, loadingMsg);
        return;
      }
      messages.add(ConciergeMessage.error(
        response.errorMessage ?? 'concierge_chat.error_generic'.tr,
      ));
      return;
    }

    if (response.conversationId.isNotEmpty) {
      currentConversationId.value = response.conversationId;
    }

    messages.add(ConciergeMessage.agentBuilder(response: response));
    _autoSave();
  }

  /// FALLBACK: Send via direct ELSER semantic search.
  ///
  /// Flow: Flutter → Serverpod → Dart Agents → ELSER Queries → Response
  Future<void> _sendViaElser(String text, String lang, ConciergeMessage loadingMsg) async {
    debugPrint('[ConciergeCtrl] ELSER fallback...');

    // Get user location for geo-aware search
    double? lat;
    double? lng;
    try {
      final location = Get.find<LocationService>();
      lat = location.currentPosition.value?.latitude;
      lng = location.currentPosition.value?.longitude;
    } catch (_) {
      // Location service not available — proceed without
    }

    // Call the concierge agent (ELSER hybrid search on ES)
    final response = await _agent.parseRequest(
      text: text,
      language: lang,
      latitude: lat,
      longitude: lng,
    );

    // Remove loading indicator
    messages.removeWhere((m) => m.id == loadingMsg.id);

    // Track metrics
    lastProcessingTimeMs.value = response.processingTimeMs;

    if (response.status == AiResponseStatus.error) {
      messages.add(ConciergeMessage.error(
        response.errorMessage ?? 'concierge_chat.error_generic'.tr,
      ));
      return;
    }

    // Store parsed request data
    final parsed = response.parsedRequest;
    if (parsed != null) {
      selectedParsedRequest.value = parsed;
      confidence.value = parsed.parsingConfidence;

      // Extract location and time info
      if (parsed.detectedLocation != null) {
        extractedLocation.value = parsed.detectedLocation!;
      }
      if (parsed.detectedScheduledTime != null) {
        extractedTime.value = parsed.detectedScheduledTime!;
      }
      extractedUrgent.value = parsed.isUrgent;
    }

    // Add AI response with suggestions
    messages.add(ConciergeMessage.aiResponse(response: response));

    // Auto-save conversation
    _autoSave();
  }

  /// User selects one of the suggested services.
  void selectService(int index, String serviceName) {
    selectedServiceIndex.value = index;
    selectedServiceName.value = serviceName;

    // Add confirmation message
    messages.add(ConciergeMessage(
      id: 'select_${DateTime.now().millisecondsSinceEpoch}',
      isUser: false,
      text: '${'concierge_chat.service_selected'.tr} $serviceName\n\n'
          '${'concierge_chat.proceed_hint'.tr}',
    ));
  }

  /// Build form arguments to pass to the create request screen.
  ///
  /// This allows the existing form to auto-fill with AI-parsed data.
  Map<String, dynamic> buildRequestArguments() {
    final parsed = selectedParsedRequest.value;
    final args = <String, dynamic>{
      'fromConcierge': true,
      'description': userDescription.value,
    };

    if (parsed != null) {
      if (parsed.suggestedServiceIds.isNotEmpty) {
        args['serviceId'] = parsed.suggestedServiceIds.first;
      }
      if (selectedServiceName.value.isNotEmpty) {
        args['serviceName'] = selectedServiceName.value;
      }
      if (parsed.detectedLocation != null) {
        args['locationHint'] = parsed.detectedLocation;
      }
      if (parsed.suggestedLatitude != null) {
        args['latitude'] = parsed.suggestedLatitude;
      }
      if (parsed.suggestedLongitude != null) {
        args['longitude'] = parsed.suggestedLongitude;
      }
      if (parsed.isUrgent) {
        args['urgent'] = true;
      }
      if (parsed.suggestedScheduledTime != null) {
        args['scheduledTime'] =
            parsed.suggestedScheduledTime!.toIso8601String();
      }
    }

    return args;
  }

  /// Auto-save the current conversation to local storage.
  void _autoSave() {
    final storedMessages = messages
        .where((m) => !m.isLoading && !m.isStreaming)
        .map((m) => StoredMessage(
              id: m.id,
              isUser: m.isUser,
              text: m.text,
              timestamp: m.timestamp,
              isAgentBuilder: m.isAgentBuilder,
              isWelcome: m.id == 'welcome',
              toolCallCount: m.agentSteps
                      ?.where(
                          (s) => s.toolName != null && s.toolName!.isNotEmpty)
                      .length ??
                  0,
              agentStepsJson: m.agentSteps
                  ?.map((s) => s.toJson())
                  .toList(),
            ))
        .toList();

    if (storedMessages.where((m) => m.isUser).isEmpty) return;

    _storage.saveConversation(
      conversationId: _localConversationId,
      title: '',
      messages: storedMessages,
      agentConversationId: currentConversationId.value.isNotEmpty
          ? currentConversationId.value
          : null,
    );
  }

  /// Reset chat — starts a brand-new conversation.
  void resetChat() {
    _autoSave(); // Save current before clearing
    selectedParsedRequest.value = null;
    selectedServiceIndex.value = -1;
    selectedServiceName.value = '';
    extractedLocation.value = '';
    extractedTime.value = '';
    extractedUrgent.value = false;
    detectedLanguage.value = '';
    userDescription.value = '';
    confidence.value = AiConfidenceLevel.low;
    lastProcessingTimeMs.value = 0;
    totalToolCalls.value = 0;
    _startNewLocalConversation();
  }

  @override
  void onClose() {
    _autoSave();
    super.onClose();
  }
}
