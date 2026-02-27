import 'package:awhar_client/awhar_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Thin wrapper around Serverpod's AI Agent endpoints.
///
/// ## Two Integration Modes:
///
/// ### Mode 1: Kibana Agent Builder (PRIMARY — for Hackathon)
/// Uses `converseWithAgent()` → Kibana's Agent Builder REST API
/// - Agent logic configured in Kibana UI (not code)
/// - LLM (Claude/GPT/Gemini) handles reasoning
/// - ES|QL tools query Elasticsearch directly
/// - Multi-turn conversation support
/// - Shows tool execution steps in UI
///
/// ### Mode 2: Direct ELSER (LEGACY)
/// Uses `parseServiceRequest()` → Custom Dart agents with ELSER
/// - ELSER hybrid search on awhar-services
/// - Custom NLP parsing in Dart
/// - No LLM involved, pure search
///
/// Mode 1 is architecturally correct for the hackathon because
/// agents are configured in Elasticsearch, not in code.
class ConciergeAgent {
  final Client _client;

  ConciergeAgent({Client? client})
      : _client = client ?? Get.find<Client>();

  // ============================================
  // KIBANA AGENT BUILDER (PRIMARY)
  // ============================================

  /// Converse with a Kibana Agent Builder agent.
  ///
  /// This is the primary integration path. The agent (configured in Kibana)
  /// uses LLM + ES|QL tools to process the user's request.
  ///
  /// Flow:
  /// Flutter → Serverpod → Kibana Agent Builder → LLM + ES|QL → Response
  Future<AgentBuilderConverseResponse> converse({
    required String agentId,
    required String message,
    String? conversationId,
    String? connectorId,
    int? userId,
    double? latitude,
    double? longitude,
  }) async {
    debugPrint('[ConciergeAgent] converse: agentId=$agentId, userId=$userId, msg="${message.length > 50 ? '${message.substring(0, 50)}...' : message}"');

    try {
      final response = await _client.agent.converseWithAgent(
        agentId: agentId,
        message: message,
        conversationId: conversationId,
        connectorId: connectorId,
        userId: userId,
        latitude: latitude,
        longitude: longitude,
      );

      debugPrint('[ConciergeAgent] converse result: success=${response.success}, '
          'steps=${response.steps.length}, msg=${response.message.length} chars');

      return response;
    } catch (e) {
      debugPrint('[ConciergeAgent] converse error: $e');
      return AgentBuilderConverseResponse(
        conversationId: conversationId ?? '',
        message: 'Failed to reach AI agent: $e',
        steps: [],
        processingTimeMs: 0,
        success: false,
        errorMessage: e.toString(),
        agentId: agentId,
      );
    }
  }

  // ============================================
  // STREAMING AGENT BUILDER (REAL-TIME)
  // ============================================

  /// Start a streaming conversation — returns a session ID immediately.
  ///
  /// The server consumes SSE from Kibana in the background.
  /// Call [pollStream] every 500ms to get real-time events.
  Future<String> startConverse({
    required String agentId,
    required String message,
    String? conversationId,
    String? connectorId,
    int? userId,
    double? latitude,
    double? longitude,
  }) async {
    debugPrint('[ConciergeAgent] startConverse (streaming): agentId=$agentId');

    try {
      return await _client.agent.startAgentConverse(
        agentId: agentId,
        message: message,
        conversationId: conversationId,
        connectorId: connectorId,
        userId: userId,
        latitude: latitude,
        longitude: longitude,
      );
    } catch (e) {
      debugPrint('[ConciergeAgent] startConverse error: $e');
      rethrow;
    }
  }

  /// Poll for streaming events from an active session.
  ///
  /// Returns new events since [lastEventIndex].
  /// Status is 'processing', 'complete', or 'error'.
  Future<AgentStreamStatus> pollStream({
    required String streamSessionId,
    int? lastEventIndex,
  }) async {
    try {
      return await _client.agent.pollAgentStream(
        streamSessionId: streamSessionId,
        lastEventIndex: lastEventIndex,
      );
    } catch (e) {
      debugPrint('[ConciergeAgent] pollStream error: $e');
      return AgentStreamStatus(
        sessionId: streamSessionId,
        status: 'error',
        events: [],
        errorMessage: e.toString(),
      );
    }
  }

  // ============================================
  // LEGACY: DIRECT ELSER (FALLBACK)
  // ============================================

  /// Parse a natural-language service request using ELSER semantic search.
  ///
  /// LEGACY: This calls the Dart-coded RequestConciergeAgent which does
  /// ELSER hybrid search directly. Kept as fallback if Kibana is unreachable.
  Future<AiRequestConciergeResponse> parseRequest({
    required String text,
    String? language,
    double? latitude,
    double? longitude,
    int? userId,
  }) async {
    debugPrint('[ConciergeAgent] parseRequest (ELSER fallback): "${text.length > 50 ? '${text.substring(0, 50)}...' : text}"');

    try {
      return await _client.agent.parseServiceRequest(
        request: text,
        language: language,
        latitude: latitude,
        longitude: longitude,
        userId: userId,
      );
    } catch (e) {
      debugPrint('[ConciergeAgent] parseRequest error: $e');
      return AiRequestConciergeResponse(
        agentType: AiAgentType.requestConcierge,
        status: AiResponseStatus.error,
        errorMessage: e.toString(),
        processingTimeMs: 0,
        timestamp: DateTime.now(),
        humanReadableSummary: 'Failed to process request: $e',
      );
    }
  }

  /// Full pipeline: parse request + find matching drivers.
  ///
  /// LEGACY: Uses Dart agents directly.
  Future<AiFullRequestResponse> processFullRequest({
    required String text,
    required double latitude,
    required double longitude,
    String? language,
  }) async {
    try {
      return await _client.agent.processFullRequest(
        request: text,
        latitude: latitude,
        longitude: longitude,
        language: language,
      );
    } catch (e) {
      return AiFullRequestResponse(
        totalProcessingTimeMs: 0,
        timestamp: DateTime.now(),
      );
    }
  }

  /// Search help articles using pure ELSER semantic search on knowledge base.
  ///
  /// LEGACY: Uses Dart HelpCenter agent.
  Future<AiHelpSearchResponse> searchHelp({
    required String question,
    String? language,
    String? category,
    int? maxResults,
  }) async {
    try {
      return await _client.agent.searchHelp(
        question: question,
        language: language,
        category: category,
        maxResults: maxResults,
      );
    } catch (e) {
      return AiHelpSearchResponse(
        agentType: AiAgentType.helpCenter,
        status: AiResponseStatus.error,
        errorMessage: e.toString(),
        processingTimeMs: 0,
        timestamp: DateTime.now(),
        question: question,
        articles: [],
        summary: 'Failed to search: $e',
      );
    }
  }
}
