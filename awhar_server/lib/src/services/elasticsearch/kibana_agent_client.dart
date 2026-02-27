/// Kibana Agent Builder Client
///
/// HTTP client that calls Kibana's Agent Builder REST API to invoke
/// AI agents configured in the Kibana UI. This is the bridge between
/// the Serverpod backend and Kibana-hosted agents.
///
/// ## Architecture
///
/// ```
/// Flutter App → Serverpod Endpoint → KibanaAgentClient → Kibana Agent Builder
///                                                              ↓
///                                                         LLM (Claude/GPT)
///                                                              ↓
///                                                         ES|QL Tools
///                                                              ↓
///                                                      Elasticsearch Data
/// ```
///
/// ## Kibana Agent Builder API (from Kibana source: routes/chat.ts)
///
/// ```
/// POST /api/agent_builder/converse          (sync)
/// POST /api/agent_builder/converse/async    (streaming)
/// GET  /api/agent_builder/agents            (list agents)
/// GET  /api/agent_builder/conversations     (list conversations)
/// ```
///
/// ## Why this approach?
///
/// Agents are configured in Kibana Agent Builder (not in Dart code) because:
/// 1. Agent Builder provides visual agent configuration UI
/// 2. Tools are ES|QL queries that run directly on Elasticsearch
/// 3. LLM connectors (Claude, GPT, Gemini) are managed by Elastic
/// 4. Multi-turn conversation state is managed by Kibana
/// 5. This is what the Elasticsearch Agent Builder Hackathon evaluates

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'elasticsearch_config.dart';

/// A single SSE event from the Agent Builder streaming API.
///
/// Maps to Kibana's ChatEventType enum:
/// - reasoning: Agent thinking step
/// - tool_call: Agent calling a tool
/// - tool_progress: Tool execution progress
/// - tool_result: Tool finished with results
/// - message_chunk: Part of final answer streaming
/// - message_complete: Full final answer
/// - thinking_complete: Timing info
/// - round_complete: Everything done
class KibanaStreamEvent {
  final String type;
  final Map<String, dynamic> data;

  KibanaStreamEvent({required this.type, required this.data});

  /// Whether this event signals the round is complete.
  bool get isComplete => type == 'round_complete';

  /// Whether this is a reasoning/thinking step.
  bool get isReasoning => type == 'reasoning';

  /// Whether this is a tool call event.
  bool get isToolCall => type == 'tool_call';

  /// Whether this is a tool result event.
  bool get isToolResult => type == 'tool_result';

  /// Whether this is a message chunk (streaming answer).
  bool get isMessageChunk => type == 'message_chunk';

  /// Whether this is the complete message.
  bool get isMessageComplete => type == 'message_complete';

  /// Whether this is a tool progress event.
  bool get isToolProgress => type == 'tool_progress';

  /// Whether this is thinking complete (timing info).
  bool get isThinkingComplete => type == 'thinking_complete';

  @override
  String toString() => 'KibanaStreamEvent($type, ${data.keys.toList()})';
}

/// Response from the Kibana Agent Builder converse API
class KibanaConverseResult {
  final String conversationId;
  final String? roundId;
  final String message;
  final List<Map<String, dynamic>> steps;
  final bool success;
  final String? errorMessage;
  final String? agentId;

  // --- model_usage fields ---
  final String? model;
  final int? llmCalls;
  final int? inputTokens;
  final int? outputTokens;

  KibanaConverseResult({
    required this.conversationId,
    this.roundId,
    required this.message,
    this.steps = const [],
    this.success = true,
    this.errorMessage,
    this.agentId,
    this.model,
    this.llmCalls,
    this.inputTokens,
    this.outputTokens,
  });
}

/// Client for Kibana Agent Builder REST API
class KibanaAgentClient {
  final String kibanaUrl;
  final String apiKey;
  final http.Client _httpClient;

  /// API version required by Kibana
  static const String _apiVersion = '2023-10-31';

  KibanaAgentClient({
    required this.kibanaUrl,
    required this.apiKey,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// Create from environment variables
  factory KibanaAgentClient.fromEnvironment() {
    final kibanaUrl = _getEnvVar('KIBANA_URL');
    final apiKey = _getEnvVar('ELASTICSEARCH_API_KEY');

    if (kibanaUrl.isEmpty) {
      throw Exception(
        'KIBANA_URL environment variable is not set. '
        'Add it to your .env file: KIBANA_URL=https://your-project.kb.region.gcp.elastic.cloud',
      );
    }
    if (apiKey.isEmpty) {
      throw Exception(
        'ELASTICSEARCH_API_KEY environment variable is not set.',
      );
    }

    return KibanaAgentClient(
      kibanaUrl: kibanaUrl,
      apiKey: apiKey,
    );
  }

  /// Get environment variable
  static String _getEnvVar(String key) {
    // Try dotenv first (via ElasticsearchConfig's init)
    initializeElasticsearchEnv();
    final dotenvInstance = getDotEnvInstance();
    if (dotenvInstance != null) {
      final value = dotenvInstance[key];
      if (value != null && value.isNotEmpty) return value;
    }
    // Fall back to platform environment
    return Platform.environment[key] ?? '';
  }

  /// Per-agent connector overrides.
  /// Concierge uses GPT-4.1 Mini for fast, cost-efficient responses.
  /// All other agents use Gemini 2.5 Flash for speed and cost efficiency.
  static const Map<String, String> _agentConnectors = {
    'awhar-concierge': 'OpenAI-GPT-4-1-Mini',
  };

  /// Default connector for agents not in [_agentConnectors].
  static const String _defaultConnector = 'Google-Gemini-2-5-Flash';

  /// Resolve the connector for a given agent.
  String _resolveConnector(String agentId, String? override) {
    if (override != null) return override;
    return _agentConnectors[agentId] ?? _defaultConnector;
  }

  /// Common headers for Kibana API requests
  Map<String, String> get _headers => {
        'Authorization': 'ApiKey $apiKey',
        'Content-Type': 'application/json',
        'kbn-xsrf': 'true',
        'elastic-api-version': _apiVersion,
      };

  /// Send a message to a Kibana Agent Builder agent.
  ///
  /// This is the main integration point. The agent will:
  /// 1. Receive the user's natural language input
  /// 2. Use its configured LLM connector to reason about the request
  /// 3. Execute ES|QL tools against Elasticsearch indices
  /// 4. Return a synthesized response with tool execution steps
  ///
  /// [agentId] - The Kibana agent to use (e.g., Concierge, Shield)
  /// [input] - User's natural language message
  /// [conversationId] - Optional, for multi-turn conversations
  /// [connectorId] - Optional, override the LLM connector
  Future<KibanaConverseResult> converse({
    required String agentId,
    required String input,
    String? conversationId,
    String? connectorId,
  }) async {
    final url = '$kibanaUrl/api/agent_builder/converse';
    final stopwatch = Stopwatch()..start();

    // Resolve connector: per-agent mapping (e.g. Concierge → Gemini Pro) or default Flash
    final effectiveConnector = _resolveConnector(agentId, connectorId);

    final body = <String, dynamic>{
      'agent_id': agentId,
      'input': input,
      'connector_id': effectiveConnector,
    };
    if (conversationId != null) body['conversation_id'] = conversationId;

    print('[KibanaAgent] POST $url');
    print('[KibanaAgent] agent_id=$agentId, connector=$effectiveConnector, input="${input.length > 80 ? '${input.substring(0, 80)}...' : input}"');

    try {
      final response = await _httpClient
          .post(
            Uri.parse(url),
            headers: _headers,
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 120)); // Agent Builder can take time with LLM + tools

      stopwatch.stop();

      print('[KibanaAgent] Response: ${response.statusCode} in ${stopwatch.elapsedMilliseconds}ms');

      if (response.statusCode == 200) {
        // DEBUG: Log raw response body to diagnose step structure
        final rawBody = response.body;
        print('[KibanaAgent] RAW BODY (${rawBody.length} chars):');
        // Log in chunks to avoid truncation
        const chunkSize = 1500;
        for (int i = 0; i < rawBody.length; i += chunkSize) {
          final end = (i + chunkSize < rawBody.length) ? i + chunkSize : rawBody.length;
          print('[KibanaAgent] BODY[${i ~/ chunkSize}]: ${rawBody.substring(i, end)}');
        }

        final data = json.decode(response.body) as Map<String, dynamic>;
        
        // Log top-level keys
        print('[KibanaAgent] Top-level keys: ${data.keys.toList()}');
        
        return _parseConverseResponse(data, agentId);
      } else {
        final errorBody = response.body.length > 500
            ? response.body.substring(0, 500)
            : response.body;
        print('[KibanaAgent] ERROR ${response.statusCode}: $errorBody');
        return KibanaConverseResult(
          conversationId: conversationId ?? '',
          message: 'Agent Builder returned error ${response.statusCode}',
          success: false,
          errorMessage: 'HTTP ${response.statusCode}: $errorBody',
          agentId: agentId,
        );
      }
    } catch (e) {
      stopwatch.stop();
      print('[KibanaAgent] EXCEPTION after ${stopwatch.elapsedMilliseconds}ms: $e');
      return KibanaConverseResult(
        conversationId: conversationId ?? '',
        message: 'Failed to reach Agent Builder: $e',
        success: false,
        errorMessage: e.toString(),
        agentId: agentId,
      );
    }
  }

  /// List all configured agents from Kibana
  Future<List<Map<String, dynamic>>> listAgents() async {
    final url = '$kibanaUrl/api/agent_builder/agents';

    try {
      final response = await _httpClient
          .get(Uri.parse(url), headers: _headers)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) return data.cast<Map<String, dynamic>>();
        if (data is Map && data.containsKey('results')) {
          return (data['results'] as List).cast<Map<String, dynamic>>();
        }
        return [];
      } else {
        print('[KibanaAgent] listAgents error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('[KibanaAgent] listAgents exception: $e');
      return [];
    }
  }

  /// Test connectivity to Kibana
  Future<bool> testConnection() async {
    try {
      final response = await _httpClient
          .get(
            Uri.parse('$kibanaUrl/api/status'),
            headers: {'Authorization': 'ApiKey $apiKey'},
          )
          .timeout(const Duration(seconds: 10));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Parse the converse API response
  KibanaConverseResult _parseConverseResponse(
    Map<String, dynamic> data,
    String agentId,
  ) {
    final conversationId = data['conversation_id'] as String? ?? '';
    final roundId = data['round_id'] as String?;
    final response = data['response'] as Map<String, dynamic>? ?? {};
    final message = response['message'] as String? ?? '';
    final rawSteps = data['steps'] as List<dynamic>? ?? [];

    final steps = rawSteps.map((s) {
      if (s is Map<String, dynamic>) return s;
      return <String, dynamic>{'type': 'unknown', 'data': s.toString()};
    }).toList();

    print('[KibanaAgent] Parsed: conv=$conversationId, '
        'msg=${message.length} chars, ${steps.length} steps');

    // DEBUG: Log raw step structure for card rendering diagnosis
    for (int i = 0; i < steps.length; i++) {
      final s = steps[i];
      print('[KibanaAgent] Step[$i] keys: ${s.keys.toList()}');
      print('[KibanaAgent] Step[$i] type=${s['type']}, '
          'tool_id=${s['tool_id']}, tool_name=${s['tool_name']}, '
          'toolName=${s['toolName']}, name=${s['name']}');
      final output = s['output'] ?? s['tool_output'] ?? s['toolOutput'] ?? s['result'];
      if (output != null) {
        final outStr = output.toString();
        print('[KibanaAgent] Step[$i] output(${outStr.length} chars): '
            '${outStr.length > 200 ? '${outStr.substring(0, 200)}...' : outStr}');
      } else {
        print('[KibanaAgent] Step[$i] NO output field found');
      }
    }

    // Parse model_usage for token tracking
    final modelUsage = data['model_usage'] as Map<String, dynamic>?;
    final model = modelUsage?['model'] as String?;
    final llmCalls = modelUsage?['llm_calls'] as int?;
    final inputTokens = modelUsage?['input_tokens'] as int?;
    final outputTokens = modelUsage?['output_tokens'] as int?;

    if (modelUsage != null) {
      print('[KibanaAgent] model_usage: model=$model, llm_calls=$llmCalls, '
          'input_tokens=$inputTokens, output_tokens=$outputTokens');
    }

    return KibanaConverseResult(
      conversationId: conversationId,
      roundId: roundId,
      message: message,
      steps: steps,
      success: true,
      agentId: agentId,
      model: model,
      llmCalls: llmCalls,
      inputTokens: inputTokens,
      outputTokens: outputTokens,
    );
  }

  /// Close the HTTP client
  void close() {
    _httpClient.close();
  }

  // ============================================
  // STREAMING (SSE) CONVERSE
  // ============================================

  /// Stream a conversation with a Kibana Agent Builder agent.
  ///
  /// Uses the async endpoint: POST /api/agent_builder/converse/async
  /// Returns Server-Sent Events (SSE) as they arrive — enabling
  /// real-time display of reasoning, tool calls, and answer streaming.
  ///
  /// SSE event types from Kibana:
  /// - reasoning: Agent thinking/planning
  /// - tool_call: Agent invokes a tool { tool_id, params }
  /// - tool_progress: Tool execution progress { message }
  /// - tool_result: Tool results { tool_call_id, results[] }
  /// - message_chunk: Streaming answer text { text_chunk }
  /// - message_complete: Final full answer { message_content }
  /// - thinking_complete: Timing { time_to_first_token }
  /// - round_complete: Full round data { round }
  Stream<KibanaStreamEvent> converseStream({
    required String agentId,
    required String input,
    String? conversationId,
    String? connectorId,
  }) async* {
    final url = '$kibanaUrl/api/agent_builder/converse/async';
    final effectiveConnector = _resolveConnector(agentId, connectorId);

    final body = <String, dynamic>{
      'agent_id': agentId,
      'input': input,
      'connector_id': effectiveConnector,
    };
    if (conversationId != null) body['conversation_id'] = conversationId;

    print('[KibanaAgent] SSE POST $url');
    print('[KibanaAgent] SSE agent_id=$agentId, connector=$effectiveConnector, input="${input.length > 80 ? '${input.substring(0, 80)}...' : input}"');

    final request = http.Request('POST', Uri.parse(url))
      ..headers.addAll(_headers)
      ..body = json.encode(body);

    try {
      final streamedResponse = await _httpClient.send(request).timeout(
        const Duration(seconds: 180),
      );

      print('[KibanaAgent] SSE Response status: ${streamedResponse.statusCode}');

      if (streamedResponse.statusCode != 200) {
        final errorBody = await streamedResponse.stream.bytesToString();
        print('[KibanaAgent] SSE ERROR ${streamedResponse.statusCode}: $errorBody');
        yield KibanaStreamEvent(
          type: 'error',
          data: {
            'message': 'HTTP ${streamedResponse.statusCode}',
            'body': errorBody.length > 500 ? errorBody.substring(0, 500) : errorBody,
          },
        );
        return;
      }

      // Parse SSE stream
      // Format: "event: <type>\ndata: <json>\n\n"
      // Kibana may use \r\n or \n line endings
      String buffer = '';

      await for (final chunk in streamedResponse.stream.transform(utf8.decoder)) {
        // Normalize line endings: \r\n → \n
        buffer += chunk.replaceAll('\r\n', '\n').replaceAll('\r', '\n');

        // Process complete SSE messages (separated by double newline)
        while (buffer.contains('\n\n')) {
          final endIdx = buffer.indexOf('\n\n');
          final message = buffer.substring(0, endIdx).trim();
          buffer = buffer.substring(endIdx + 2);

          if (message.isEmpty) continue;

          final event = _parseSseMessage(message);
          if (event != null) {
            final _dataPreview = event.data.entries.take(3).map((e) {
              final v = e.value?.toString() ?? '';
              return '${e.key}=${v.length > 80 ? '${v.substring(0, 80)}...' : v}';
            }).join(', ');
            print('[KibanaAgent] SSE event: ${event.type} keys=${event.data.keys.toList()} preview=[$_dataPreview]');
            yield event;

            // Stop after round_complete
            if (event.isComplete) return;
          }
        }
      }

      // Process any remaining buffer
      final remaining = buffer.trim();
      if (remaining.isNotEmpty) {
        final event = _parseSseMessage(remaining);
        if (event != null) {
          print('[KibanaAgent] SSE final event: ${event.type}');
          yield event;
        }
      }
    } catch (e) {
      print('[KibanaAgent] SSE EXCEPTION: $e');
      yield KibanaStreamEvent(
        type: 'error',
        data: {'message': e.toString()},
      );
    }
  }

  /// Parse a single SSE message block into a KibanaStreamEvent.
  ///
  /// SSE format:
  /// ```
  /// event: reasoning
  /// data: {"reasoning": "Let me search..."}
  /// ```
  KibanaStreamEvent? _parseSseMessage(String message) {
    String? eventType;
    final dataLines = <String>[];

    for (final line in message.split('\n')) {
      final trimmed = line.trim();
      if (trimmed.startsWith('event:')) {
        eventType = trimmed.substring(6).trim();
      } else if (trimmed.startsWith('data:')) {
        // SSE spec: data can appear with or without space after colon
        final dataContent = trimmed.substring(5);
        dataLines.add(dataContent.startsWith(' ') ? dataContent.substring(1) : dataContent);
      } else if (trimmed.startsWith('id:') || trimmed.startsWith('retry:')) {
        // Standard SSE fields — ignore
      }
    }

    if (eventType == null && dataLines.isEmpty) return null;

    // Default event type
    eventType ??= 'message';

    // Combine multi-line data (SSE spec: join with newlines)
    final dataStr = dataLines.join('\n').trim();

    // Parse JSON data
    Map<String, dynamic> data = {};
    if (dataStr.isNotEmpty) {
      try {
        final parsed = json.decode(dataStr);
        if (parsed is Map<String, dynamic>) {
          data = parsed;
        } else {
          data = {'raw': parsed};
        }
      } catch (_) {
        data = {'raw': dataStr};
      }
    }

    // Unwrap Kibana's {"data": ...} wrapper if present.
    // Kibana SSE events wrap the actual payload inside a "data" key:
    //   event: reasoning
    //   data: {"data": {"reasoning": "Let me think..."}}
    // We unwrap so consumers see {"reasoning": "Let me think..."} directly.
    if (data.length == 1 && data.containsKey('data')) {
      final inner = data['data'];
      if (inner is Map<String, dynamic>) {
        data = inner;
      } else if (inner is String) {
        data = {'raw': inner, 'text': inner};
      } else if (inner != null) {
        data = {'raw': inner};
      }
    }

    return KibanaStreamEvent(type: eventType, data: data);
  }
}
