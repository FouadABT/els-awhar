import 'dart:async';
import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/ai_agents/ai_agents.dart';
import '../services/agent_stream_store.dart';
import '../services/smart_matching_service.dart';
import '../services/elasticsearch/kibana_agent_client.dart';

/// AI Agent Endpoint
/// 
/// Provides API access to Awhar's AI agents:
/// - Smart Driver Matching: Find best drivers for a request
/// - Request Concierge: Parse natural language into structured requests
/// - Demand Prediction: Predict demand hotspots
/// 
/// These agents are powered by Elasticsearch and designed for the
/// Elasticsearch Agent Builder Hackathon.
class AgentEndpoint extends Endpoint {

  // ============================================
  // DRIVER MATCHING AGENT
  // ============================================

  /// Find the best drivers for a service request
  /// 
  /// Now routes through the Kibana `awhar-match` Agent Builder agent
  /// which uses multi-factor scoring (distance, rating, workload, etc.)
  /// powered by 9 ES|QL tools running against live Elasticsearch data.
  ///
  /// Falls back to the legacy Dart-based matching if the Kibana agent fails.
  Future<AiDriverMatchingResponse> findBestDrivers(
    Session session, {
    int? serviceId,
    int? categoryId,
    required double latitude,
    required double longitude,
    double? radiusKm,
    bool? preferVerified,
    bool? preferPremium,
    double? minRating,
    int? maxResults,
  }) async {
    final stopwatch = Stopwatch()..start();

    try {
      // Build a lightweight ServiceRequest for the smart matching service
      final matchRequest = ServiceRequest(
        clientId: 0,
        serviceType: _categoryToServiceType(categoryId),
        status: RequestStatus.pending,
        pickupLocation: Location(
          latitude: latitude,
          longitude: longitude,
          address: 'Search location',
        ),
        destinationLocation: Location(
          latitude: latitude,
          longitude: longitude,
          address: 'Search location',
        ),
        basePrice: 0,
        distancePrice: 0,
        totalPrice: 0,
        clientName: 'API caller',
        createdAt: DateTime.now(),
        negotiationStatus: PriceNegotiationStatus.waiting_for_offers,
        isPurchaseRequired: false,
        notes: [
          if (serviceId != null) 'Service ID: $serviceId',
          if (categoryId != null) 'Category ID: $categoryId',
          if (radiusKm != null) 'Search radius: ${radiusKm}km',
          if (preferVerified == true) 'Prefer verified drivers',
          if (preferPremium == true) 'Prefer premium drivers',
          if (minRating != null) 'Minimum rating: $minRating',
        ].join(', '),
      );

      session.log(
        '[AgentEndpoint] 🤖 findBestDrivers via Kibana awhar-match agent '
        '(lat=$latitude, lng=$longitude, category=$categoryId)',
      );

      final matchResult = await SmartMatchingService.findMatchedDrivers(
        session,
        request: matchRequest,
        maxDrivers: maxResults ?? 5,
      );

      stopwatch.stop();

      if (matchResult.success && matchResult.hasMatches) {
        // Build recommendation list from matched driver IDs
        final recommendations = <AiDriverRecommendation>[];
        for (int i = 0; i < matchResult.matchedDriverUserIds.length; i++) {
          final userId = matchResult.matchedDriverUserIds[i];
          final profileId = i < matchResult.matchedDriverProfileIds.length
              ? matchResult.matchedDriverProfileIds[i]
              : userId;

          // Look up driver details
          final profile = await DriverProfile.db.findFirstRow(
            session,
            where: (t) => t.userId.equals(userId),
          );
          final user = await User.db.findById(session, userId);

          recommendations.add(AiDriverRecommendation(
            driverId: profileId,
            userId: userId,
            displayName: user?.fullName ?? profile?.displayName ?? 'Driver $userId',
            profilePhotoUrl: profile?.profilePhotoUrl,
            ratingAverage: profile?.ratingAverage,
            ratingCount: profile?.ratingCount,
            distanceKm: 0.0, // Distance is in the agent explanation
            isOnline: profile?.isOnline ?? true,
            isVerified: profile?.isVerified ?? false,
            isPremium: profile?.isPremium ?? false,
            totalCompletedOrders: profile?.totalCompletedOrders ?? 0,
            matchScore: 1.0 - (i * 0.15), // Descending score by rank
            confidence: i == 0
                ? AiConfidenceLevel.high
                : (i < 3 ? AiConfidenceLevel.medium : AiConfidenceLevel.low),
            matchReasons: ['🤖 AI-matched by awhar-match agent'],
          ));
        }

        session.log(
          '[AgentEndpoint] ✅ awhar-match returned ${recommendations.length} drivers '
          'in ${matchResult.processingTimeMs}ms',
        );

        return AiDriverMatchingResponse(
          agentType: AiAgentType.driverMatching,
          status: AiResponseStatus.success,
          processingTimeMs: stopwatch.elapsedMilliseconds,
          timestamp: DateTime.now(),
          recommendations: recommendations,
          explanation: matchResult.explanation,
          totalCandidatesEvaluated: matchResult.count,
        );
      }

      // Agent returned no matches — try legacy fallback
      session.log(
        '[AgentEndpoint] ⚠️ awhar-match returned 0 matches, trying legacy agent...',
        level: LogLevel.warning,
      );
      return _legacyFindBestDrivers(
        session,
        serviceId: serviceId,
        categoryId: categoryId,
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm,
        preferVerified: preferVerified,
        preferPremium: preferPremium,
        minRating: minRating,
        maxResults: maxResults,
      );
    } catch (e) {
      stopwatch.stop();
      session.log(
        '[AgentEndpoint] ❌ awhar-match failed: $e — trying legacy agent...',
        level: LogLevel.warning,
      );
      // Fall back to legacy Dart-based matching
      return _legacyFindBestDrivers(
        session,
        serviceId: serviceId,
        categoryId: categoryId,
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm,
        preferVerified: preferVerified,
        preferPremium: preferPremium,
        minRating: minRating,
        maxResults: maxResults,
      );
    }
  }

  /// Map category ID to service type for prompt building
  static ServiceType _categoryToServiceType(int? categoryId) {
    switch (categoryId) {
      case 1: return ServiceType.delivery; // Food
      case 2: return ServiceType.delivery; // Delivery
      case 3: return ServiceType.ride;     // Transport
      case 4: return ServiceType.purchase; // Shopping
      case 5: return ServiceType.task;     // Professional
      case 6: return ServiceType.moving;   // Moving
      default: return ServiceType.other;
    }
  }

  /// Legacy findBestDrivers using Dart-based ES direct queries (fast fallback)
  Future<AiDriverMatchingResponse> _legacyFindBestDrivers(
    Session session, {
    int? serviceId,
    int? categoryId,
    required double latitude,
    required double longitude,
    double? radiusKm,
    bool? preferVerified,
    bool? preferPremium,
    double? minRating,
    int? maxResults,
  }) async {
    final agentService = AiAgentService();

    if (!agentService.isInitialized) {
      return AiDriverMatchingResponse(
        agentType: AiAgentType.driverMatching,
        status: AiResponseStatus.error,
        errorMessage: 'AI Agent service not initialized',
        processingTimeMs: 0,
        timestamp: DateTime.now(),
        recommendations: [],
        explanation: 'Service not available',
        totalCandidatesEvaluated: 0,
      );
    }

    final stopwatch = Stopwatch()..start();

    try {
      final result = await agentService.findBestDrivers(
        session,
        serviceId: serviceId,
        categoryId: categoryId,
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm,
        preferVerified: preferVerified ?? true,
        preferPremium: preferPremium ?? false,
        minRating: minRating,
        maxResults: maxResults ?? 5,
      );

      stopwatch.stop();
      return _convertDriverMatchingResponse(result, stopwatch.elapsedMilliseconds);
    } catch (e) {
      stopwatch.stop();
      return AiDriverMatchingResponse(
        agentType: AiAgentType.driverMatching,
        status: AiResponseStatus.error,
        errorMessage: e.toString(),
        processingTimeMs: stopwatch.elapsedMilliseconds,
        timestamp: DateTime.now(),
        recommendations: [],
        explanation: 'Error processing request',
        totalCandidatesEvaluated: 0,
      );
    }
  }

  // ============================================
  // REQUEST CONCIERGE AGENT
  // ============================================

  /// Parse a natural language service request
  /// 
  /// Examples:
  /// - "I need someone to pick up groceries from Marjane"
  /// - "Can someone help me move furniture tomorrow?"
  /// - "I need a ride to the airport at 6am"
  /// 
  /// Returns:
  /// - Parsed service request with category, locations, estimated price
  /// - Clarifying questions if more info needed
  /// - Similar services for alternatives
  Future<AiRequestConciergeResponse> parseServiceRequest(
    Session session, {
    required String request,
    String? language,
    double? latitude,
    double? longitude,
    int? userId,
  }) async {
    final agentService = AiAgentService();
    
    if (!agentService.isInitialized) {
      return AiRequestConciergeResponse(
        agentType: AiAgentType.requestConcierge,
        status: AiResponseStatus.error,
        errorMessage: 'AI Agent service not initialized',
        processingTimeMs: 0,
        timestamp: DateTime.now(),
        humanReadableSummary: 'Service not available',
      );
    }

    final stopwatch = Stopwatch()..start();
    
    try {
      final result = await agentService.parseServiceRequest(
        session,
        naturalLanguageRequest: request,
        language: language ?? 'en',
        userLatitude: latitude,
        userLongitude: longitude,
        userId: userId,
      );

      stopwatch.stop();
      
      // Convert internal model to protocol model
      return _convertConciergeResponse(result, stopwatch.elapsedMilliseconds);
    } catch (e) {
      stopwatch.stop();
      return AiRequestConciergeResponse(
        agentType: AiAgentType.requestConcierge,
        status: AiResponseStatus.error,
        errorMessage: e.toString(),
        processingTimeMs: stopwatch.elapsedMilliseconds,
        timestamp: DateTime.now(),
        humanReadableSummary: 'Error processing request',
      );
    }
  }

  // ============================================
  // DEMAND PREDICTION AGENT
  // ============================================

  /// Predict demand hotspots for drivers
  /// 
  /// Analyzes historical patterns to identify:
  /// - High-demand areas
  /// - Peak time windows
  /// - Service category trends
  /// - Driver positioning recommendations
  Future<AiDemandPredictionResponse> predictDemand(
    Session session, {
    required double latitude,
    required double longitude,
    double? radiusKm,
    int? hoursAhead,
    int? categoryId,
  }) async {
    final agentService = AiAgentService();
    
    if (!agentService.isInitialized) {
      return AiDemandPredictionResponse(
        agentType: AiAgentType.demandPrediction,
        status: AiResponseStatus.error,
        errorMessage: 'AI Agent service not initialized',
        processingTimeMs: 0,
        timestamp: DateTime.now(),
        hotspots: [],
        predictionHorizonHours: hoursAhead ?? 24,
        overallDemandLevel: 'unknown',
        recommendations: [],
      );
    }

    final stopwatch = Stopwatch()..start();
    
    try {
      final result = await agentService.predictDemand(
        session,
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm ?? 20.0,
        hoursAhead: hoursAhead ?? 24,
        categoryId: categoryId,
      );

      stopwatch.stop();
      
      // Convert internal model to protocol model
      return _convertDemandPredictionResponse(result, stopwatch.elapsedMilliseconds);
    } catch (e) {
      stopwatch.stop();
      return AiDemandPredictionResponse(
        agentType: AiAgentType.demandPrediction,
        status: AiResponseStatus.error,
        errorMessage: e.toString(),
        processingTimeMs: stopwatch.elapsedMilliseconds,
        timestamp: DateTime.now(),
        hotspots: [],
        predictionHorizonHours: hoursAhead ?? 24,
        overallDemandLevel: 'unknown',
        recommendations: [],
      );
    }
  }

  // ============================================
  // HELP CENTER AGENT (ELSER Semantic Search)
  // ============================================

  /// Search help articles and FAQ using ELSER semantic search
  /// 
  /// Uses AI-powered semantic understanding to match questions to answers:
  /// - "how do I get my money back?" → Refund Policy article
  /// - "delete my account" → Account Deletion FAQ
  /// - "how to become a driver?" → Driver Registration Guide
  /// 
  /// Powered by Elasticsearch ELSER (Elastic Learned Sparse EncodeR)
  /// for true semantic understanding beyond keyword matching.
  Future<AiHelpSearchResponse> searchHelp(
    Session session, {
    required String question,
    String? language,
    String? category,
    int? maxResults,
  }) async {
    final agentService = AiAgentService();
    
    if (!agentService.isInitialized) {
      return AiHelpSearchResponse(
        agentType: AiAgentType.helpCenter,
        status: AiResponseStatus.error,
        errorMessage: 'AI Agent service not initialized',
        processingTimeMs: 0,
        timestamp: DateTime.now(),
        question: question,
        articles: [],
        summary: 'Help service not available',
      );
    }

    final stopwatch = Stopwatch()..start();
    
    try {
      final result = await agentService.searchHelp(
        session,
        question: question,
        language: language ?? 'en',
        category: category,
        maxResults: maxResults ?? 5,
      );

      stopwatch.stop();
      
      return AiHelpSearchResponse(
        agentType: AiAgentType.helpCenter,
        status: _convertStatus(result.status),
        errorMessage: result.errorMessage,
        processingTimeMs: stopwatch.elapsedMilliseconds,
        timestamp: result.timestamp,
        question: question,
        articles: result.articles.map((a) => AiHelpArticle(
          title: a.title,
          content: a.content,
          category: a.category,
          relevanceScore: a.relevanceScore,
        )).toList(),
        summary: result.summary,
        topCategory: result.topCategory,
      );
    } catch (e) {
      stopwatch.stop();
      return AiHelpSearchResponse(
        agentType: AiAgentType.helpCenter,
        status: AiResponseStatus.error,
        errorMessage: e.toString(),
        processingTimeMs: stopwatch.elapsedMilliseconds,
        timestamp: DateTime.now(),
        question: question,
        articles: [],
        summary: 'Error searching help articles',
      );
    }
  }

  // ============================================
  // KIBANA AGENT BUILDER INTEGRATION
  // ============================================

  /// Converse with a Kibana Agent Builder agent.
  ///
  /// This is the primary integration with Elasticsearch's Agent Builder.
  /// Instead of running AI logic in Dart, this proxies to Kibana where
  /// agents are configured with:
  /// - LLM connectors (Claude, GPT, Gemini)
  /// - ES|QL tools that query Elasticsearch indices directly
  /// - System instructions and guardrails
  /// - Multi-turn conversation management
  ///
  /// ## Available Agents:
  /// - **Concierge**: Helps clients describe service requests, matches services
  /// - **Shield**: Fraud detection and risk analysis
  /// - **Order Coordinator**: Driver matching and dispatch optimization
  ///
  /// ## Architecture:
  /// ```
  /// Flutter → Serverpod → KibanaAgentClient → Kibana Agent Builder
  ///                                               ↓
  ///                                          LLM + ES|QL Tools
  ///                                               ↓
  ///                                         Elasticsearch Data
  /// ```
  Future<AgentBuilderConverseResponse> converseWithAgent(
    Session session, {
    required String agentId,
    required String message,
    String? conversationId,
    String? connectorId,
    int? userId,
    double? latitude,
    double? longitude,
  }) async {
    final stopwatch = Stopwatch()..start();

    session.log(
      '[AgentEndpoint] converseWithAgent: agentId=$agentId, userId=$userId, '
      'msg="${message.length > 60 ? '${message.substring(0, 60)}...' : message}"',
      level: LogLevel.info,
    );

    try {
      final kibanaClient = KibanaAgentClient.fromEnvironment();

      // Build enriched input with user context
      final enrichedInput = await _buildEnrichedInput(
        session,
        message: message,
        userId: userId,
        latitude: latitude,
        longitude: longitude,
        conversationId: conversationId,
      );

      final result = await kibanaClient.converse(
        agentId: agentId,
        input: enrichedInput,
        conversationId: conversationId,
        connectorId: connectorId,
      );

      stopwatch.stop();

      session.log(
        '[AgentEndpoint] converseWithAgent completed in ${stopwatch.elapsedMilliseconds}ms, '
        'success=${result.success}, steps=${result.steps.length}',
        level: LogLevel.info,
      );

      // Convert steps to protocol objects
      // DEBUG: Log raw step keys for diagnosis
      for (int i = 0; i < result.steps.length; i++) {
        session.log(
          '[AgentEndpoint] Raw step[$i] keys: ${result.steps[i].keys.toList()}',
          level: LogLevel.info,
        );
      }

      final protocolSteps = result.steps.map((step) {
        final stepType = step['type']?.toString() ?? 'unknown';

        // Kibana uses 'tool_id' for the tool name (not 'tool_name')
        final toolName = step['tool_id']?.toString()
            ?? step['tool_name']?.toString()
            ?? step['toolName']?.toString()
            ?? step['name']?.toString()
            ?? step['action']?.toString();

        // Kibana puts tool results in 'results' array, each with 'type' and 'data'
        // Extract the most useful result data (prefer tabular_data, then all resources, then other)
        String? toolOutput;
        final rawResults = step['results'];
        if (rawResults is List && rawResults.isNotEmpty) {
          // First pass: look for tabular_data (best structured format)
          Map<String, dynamic>? tabularResult;
          final resourceResults = <Map<String, dynamic>>[];

          for (final r in rawResults) {
            if (r is! Map<String, dynamic>) continue;
            final rType = r['type']?.toString();
            if (rType == 'tabular_data') {
              tabularResult = r;
            } else if (rType == 'resource') {
              resourceResults.add(r);
            }
          }

          if (tabularResult != null) {
            // Use tabular_data — it has columns + values
            final data = tabularResult['data'];
            toolOutput = data != null
                ? (data is String ? data : json.encode(data))
                : null;
          } else if (resourceResults.isNotEmpty) {
            // Collect all resource data into a list for the parser
            final resourceDataList = resourceResults
                .map((r) => r['data'])
                .where((d) => d != null)
                .toList();
            toolOutput = json.encode(resourceDataList);
          } else {
            // Fallback: encode all results
            toolOutput = json.encode(rawResults);
          }
        }

        // Fallback: try legacy field names
        if (toolOutput == null) {
          final rawOutput = step['output']
              ?? step['tool_output']
              ?? step['toolOutput']
              ?? step['result']
              ?? step['data'];
          toolOutput = rawOutput != null
              ? (rawOutput is String ? rawOutput : json.encode(rawOutput))
              : null;
        }

        // Kibana uses 'params' for tool input (not 'input')
        final rawInput = step['params']
            ?? step['input']
            ?? step['tool_input']
            ?? step['toolInput']
            ?? step['parameters']
            ?? step['args'];
        final toolInput = rawInput != null
            ? (rawInput is String ? rawInput : json.encode(rawInput))
            : null;

        // For reasoning steps, put reasoning text in the 'text' field
        final text = step['text']?.toString()
            ?? step['message']?.toString()
            ?? step['reasoning']?.toString();

        session.log(
          '[AgentEndpoint] Step: type=$stepType, toolName=$toolName, '
          'hasOutput=${toolOutput != null}, outputLen=${toolOutput?.length ?? 0}, '
          'hasText=${text != null}',
          level: LogLevel.info,
        );

        if (toolOutput != null) {
          final preview = toolOutput.length > 200
              ? '${toolOutput.substring(0, 200)}...'
              : toolOutput;
          session.log(
            '[AgentEndpoint] Step output preview: $preview',
            level: LogLevel.info,
          );
        }

        return AgentBuilderStep(
          type: stepType,
          toolName: toolName,
          toolInput: toolInput,
          toolOutput: toolOutput,
          text: text,
        );
      }).toList();

      // Calculate estimated cost in USD based on model rates (per 1M tokens)
      double? estimatedCostUsd;
      if (result.inputTokens != null && result.outputTokens != null && result.model != null) {
        final modelName = result.model!.toLowerCase();
        double inputRate;  // per 1M tokens
        double outputRate; // per 1M tokens

        if (modelName.contains('gemini-2.5-pro') || modelName.contains('gemini-2-5-pro')) {
          inputRate = 1.875;
          outputRate = 14.0;
        } else if (modelName.contains('gemini-2.5-flash') || modelName.contains('gemini-2-5-flash')) {
          inputRate = 0.45;
          outputRate = 3.5;
        } else if (modelName.contains('gemini-3.0-pro') || modelName.contains('gemini-3-0-pro')) {
          inputRate = 3.0;
          outputRate = 16.8;
        } else if (modelName.contains('gemini-3.0-flash') || modelName.contains('gemini-3-0-flash')) {
          inputRate = 0.75;
          outputRate = 4.2;
        } else if (modelName.contains('claude') && modelName.contains('opus')) {
          inputRate = 7.5;
          outputRate = 35.0;
        } else if (modelName.contains('claude') && modelName.contains('sonnet')) {
          inputRate = 4.5;
          outputRate = 21.0;
        } else {
          // Default: assume Gemini Flash
          inputRate = 0.45;
          outputRate = 3.5;
        }

        estimatedCostUsd = (result.inputTokens! / 1000000.0 * inputRate) +
            (result.outputTokens! / 1000000.0 * outputRate);
      }

      return AgentBuilderConverseResponse(
        conversationId: result.conversationId,
        roundId: result.roundId,
        message: result.message,
        steps: protocolSteps,
        processingTimeMs: stopwatch.elapsedMilliseconds,
        success: result.success,
        errorMessage: result.errorMessage,
        agentId: agentId,
        model: result.model,
        llmCalls: result.llmCalls,
        inputTokens: result.inputTokens,
        outputTokens: result.outputTokens,
        estimatedCostUsd: estimatedCostUsd,
      );
    } catch (e) {
      stopwatch.stop();

      session.log(
        '[AgentEndpoint] converseWithAgent error after ${stopwatch.elapsedMilliseconds}ms: $e',
        level: LogLevel.error,
      );

      return AgentBuilderConverseResponse(
        conversationId: conversationId ?? '',
        message: 'Failed to communicate with Agent Builder: $e',
        steps: [],
        processingTimeMs: stopwatch.elapsedMilliseconds,
        success: false,
        errorMessage: e.toString(),
        agentId: agentId,
      );
    }
  }

  // ============================================
  // STREAMING AGENT CONVERSE (Start + Poll)
  // ============================================

  /// Start a streaming conversation with a Kibana Agent Builder agent.
  ///
  /// Returns a session ID immediately. The server consumes the SSE
  /// stream from Kibana in the background, collecting events.
  /// Flutter polls [pollAgentStream] every 500ms to get new events.
  ///
  /// This enables real-time display of:
  /// - Agent reasoning steps ("Let me search for...")
  /// - Tool calls being executed (search_services, get_prices, etc.)
  /// - Tool results arriving
  /// - The answer streaming in chunk by chunk
  Future<String> startAgentConverse(
    Session session, {
    required String agentId,
    required String message,
    String? conversationId,
    String? connectorId,
    int? userId,
    double? latitude,
    double? longitude,
  }) async {
    // Clean up expired sessions (older than 5 minutes)
    cleanupExpiredStreamSessions();

    final sessionId = 'stream_${DateTime.now().millisecondsSinceEpoch}_${agentId.hashCode.abs()}';

    session.log(
      '[AgentEndpoint] startAgentConverse: sessionId=$sessionId, agentId=$agentId',
      level: LogLevel.info,
    );

    // Create session entry
    final streamSession = AgentStreamSession(
      sessionId: sessionId,
      agentId: agentId,
    );
    activeStreamSessions[sessionId] = streamSession;

    // Build enriched input
    final enrichedInput = await _buildEnrichedInput(
      session,
      message: message,
      userId: userId,
      latitude: latitude,
      longitude: longitude,
      conversationId: conversationId,
    );

    // Start background SSE consumption (fire and forget)
    _consumeSseStream(
      streamSession: streamSession,
      agentId: agentId,
      input: enrichedInput,
      conversationId: conversationId,
      connectorId: connectorId,
    );

    return sessionId;
  }

  /// Poll for streaming events from an active agent conversation.
  ///
  /// Returns all events collected so far plus the session status.
  /// Flutter calls this every 500ms until status is 'complete' or 'error'.
  ///
  /// The [lastEventIndex] parameter enables incremental fetching:
  /// pass 0 on first call, then the length of events received to
  /// only get new events. If omitted, returns all events.
  Future<AgentStreamStatus> pollAgentStream(
    Session session, {
    required String streamSessionId,
    int? lastEventIndex,
  }) async {
    final streamSession = activeStreamSessions[streamSessionId];

    if (streamSession == null) {
      return AgentStreamStatus(
        sessionId: streamSessionId,
        status: 'error',
        events: [],
        errorMessage: 'Stream session not found or expired',
      );
    }

    // Get events (incremental or all)
    final startIndex = lastEventIndex ?? 0;
    final allEvents = streamSession.events;
    final newEvents = startIndex < allEvents.length
        ? allEvents.sublist(startIndex)
        : <AgentStreamEvent>[];

    final result = AgentStreamStatus(
      sessionId: streamSessionId,
      status: streamSession.status,
      events: newEvents,
      conversationId: streamSession.conversationId,
      finalMessage: streamSession.finalMessage,
      steps: streamSession.steps,
      errorMessage: streamSession.errorMessage,
      processingTimeMs: streamSession.processingTimeMs,
      agentId: streamSession.agentId,
    );

    // Clean up completed sessions after being polled
    if (streamSession.status == 'complete' || streamSession.status == 'error') {
      // Keep for 30 more seconds in case of late polls, then remove
      Future.delayed(const Duration(seconds: 30), () {
        activeStreamSessions.remove(streamSessionId);
      });
    }

    return result;
  }

  /// Consume SSE stream from Kibana in the background.
  ///
  /// Collects events into the stream session so polling can return them.
  /// Extracts tool steps and final message from the round_complete event.
  void _consumeSseStream({
    required AgentStreamSession streamSession,
    required String agentId,
    required String input,
    String? conversationId,
    String? connectorId,
  }) async {
    try {
      final kibanaClient = KibanaAgentClient.fromEnvironment();

      await for (final event in kibanaClient.converseStream(
        agentId: agentId,
        input: input,
        conversationId: conversationId,
        connectorId: connectorId,
      )) {
        // Add event to session
        streamSession.events.add(AgentStreamEvent(
          type: event.type,
          data: json.encode(event.data),
          timestamp: DateTime.now(),
        ));

        // Extract conversation ID from events
        if (event.type == 'conversation_id_set' || event.type == 'conversation_created') {
          streamSession.conversationId = event.data['conversation_id']?.toString()
              ?? event.data['conversationId']?.toString();
        }

        // Handle round_complete — extract final response and steps
        if (event.isComplete) {
          streamSession.stopwatch.stop();
          streamSession.processingTimeMs = streamSession.stopwatch.elapsedMilliseconds;

          print('[AgentEndpoint] round_complete keys=${event.data.keys.toList()}');

          final roundData = event.data['round'] as Map<String, dynamic>? ?? event.data;

          // Extract conversation ID (try multiple locations)
          streamSession.conversationId ??=
              roundData['conversation_id']?.toString()
              ?? roundData['conversationId']?.toString()
              ?? event.data['conversation_id']?.toString()
              ?? event.data['conversationId']?.toString();

          // Extract final message (try multiple paths)
          final response = roundData['response'] as Map<String, dynamic>?;
          String finalMsg = response?['message']?.toString()
              ?? roundData['message']?.toString()
              ?? event.data['message']?.toString()
              ?? '';

          // Fallback: assemble from message_chunk events if final message empty
          if (finalMsg.isEmpty) {
            final chunks = streamSession.events
                .where((e) => e.type == 'message_chunk')
                .map((e) {
                  try {
                    final d = json.decode(e.data) as Map<String, dynamic>;
                    return d['text_chunk']?.toString()
                        ?? d['chunk']?.toString()
                        ?? d['text']?.toString()
                        ?? d['raw']?.toString()
                        ?? '';
                  } catch (_) { return ''; }
                })
                .join('');
            if (chunks.isNotEmpty) finalMsg = chunks;
          }

          // Fallback: use message_complete event
          if (finalMsg.isEmpty) {
            final completeEvent = streamSession.events
                .where((e) => e.type == 'message_complete')
                .lastOrNull;
            if (completeEvent != null) {
              try {
                final d = json.decode(completeEvent.data) as Map<String, dynamic>;
                finalMsg = d['message_content']?.toString()
                    ?? d['message']?.toString()
                    ?? d['text']?.toString()
                    ?? d['raw']?.toString()
                    ?? '';
              } catch (_) {}
            }
          }

          streamSession.finalMessage = finalMsg;
          print('[AgentEndpoint] finalMessage length=${finalMsg.length}, preview=${finalMsg.length > 100 ? '${finalMsg.substring(0, 100)}...' : finalMsg}');

          // Extract and parse steps from round_complete
          final rawSteps = roundData['steps'] as List<dynamic>? ?? [];
          print('[AgentEndpoint] round_complete has ${rawSteps.length} steps');
          for (int si = 0; si < rawSteps.length && si < 3; si++) {
            final stepPreview = rawSteps[si];
            if (stepPreview is Map) {
              print('[AgentEndpoint] step[$si] keys=${(stepPreview as Map<String, dynamic>).keys.toList()}');
            } else {
              print('[AgentEndpoint] step[$si] type=${stepPreview.runtimeType}: $stepPreview');
            }
          }

          var steps = rawSteps.map((s) {
            if (s is! Map<String, dynamic>) {
              return AgentBuilderStep(type: 'unknown', text: s.toString());
            }

            final stepType = s['type']?.toString() ?? 'unknown';
            final toolName = s['tool_id']?.toString()
                ?? s['tool_name']?.toString()
                ?? s['toolName']?.toString()
                ?? s['name']?.toString()
                ?? s['action_id']?.toString()
                ?? s['function']?.toString();

            // Parse tool output from results array
            String? toolOutput;
            final rawResults = s['results'];
            if (rawResults is List && rawResults.isNotEmpty) {
              Map<String, dynamic>? tabularResult;
              final resourceResults = <Map<String, dynamic>>[];
              for (final r in rawResults) {
                if (r is! Map<String, dynamic>) continue;
                final rType = r['type']?.toString();
                if (rType == 'tabular_data') tabularResult = r;
                else if (rType == 'resource') resourceResults.add(r);
              }
              if (tabularResult != null) {
                final data = tabularResult['data'];
                toolOutput = data != null ? (data is String ? data : json.encode(data)) : null;
              } else if (resourceResults.isNotEmpty) {
                toolOutput = json.encode(resourceResults.map((r) => r['data']).where((d) => d != null).toList());
              } else {
                toolOutput = json.encode(rawResults);
              }
            }
            toolOutput ??= s['output']?.toString()
                ?? s['tool_output']?.toString()
                ?? s['result']?.toString();

            final rawInput = s['params'] ?? s['input'] ?? s['tool_input'] ?? s['parameters'] ?? s['arguments'];
            final toolInput = rawInput != null ? (rawInput is String ? rawInput : json.encode(rawInput)) : null;

            final text = s['text']?.toString() ?? s['message']?.toString() ?? s['reasoning']?.toString();

            print('[AgentEndpoint] Parsed step: type=$stepType, toolName=$toolName, '
                'hasOutput=${toolOutput != null}, outputLen=${toolOutput?.length ?? 0}, '
                'hasText=${text != null}');

            return AgentBuilderStep(
              type: stepType,
              toolName: toolName,
              toolInput: toolInput,
              toolOutput: toolOutput,
              text: text,
            );
          }).toList();

          // FALLBACK: If round_complete had no steps or steps have no tool names,
          // reconstruct steps from the individual SSE events we collected.
          final hasUsableSteps = steps.any((s) => s.toolName != null && s.toolName!.isNotEmpty);
          if (!hasUsableSteps && streamSession.events.isNotEmpty) {
            print('[AgentEndpoint] round_complete steps missing tool names — reconstructing from SSE events');
            steps = _reconstructStepsFromEvents(streamSession.events);
          }

          streamSession.steps = steps;

          streamSession.status = 'complete';
          print('[AgentEndpoint] Stream complete: ${streamSession.events.length} events, '
              '${steps.length} steps, ${streamSession.processingTimeMs}ms');
          return;
        }

        // Handle error events
        if (event.type == 'error') {
          streamSession.stopwatch.stop();
          streamSession.processingTimeMs = streamSession.stopwatch.elapsedMilliseconds;
          streamSession.errorMessage = event.data['message']?.toString() ?? 'Unknown error';
          streamSession.status = 'error';
          return;
        }
      }

      // Stream ended without round_complete
      if (streamSession.status == 'processing') {
        streamSession.stopwatch.stop();
        streamSession.processingTimeMs = streamSession.stopwatch.elapsedMilliseconds;
        // If we got message_complete events, piece together the message
        final messageChunks = streamSession.events
            .where((e) => e.type == 'message_chunk')
            .map((e) {
              try {
                final data = json.decode(e.data) as Map<String, dynamic>;
                return data['text_chunk']?.toString()
                    ?? data['chunk']?.toString()
                    ?? data['text']?.toString()
                    ?? data['raw']?.toString()
                    ?? '';
              } catch (_) { return ''; }
            })
            .join('');
        if (messageChunks.isNotEmpty) {
          streamSession.finalMessage = messageChunks;
        }
        streamSession.status = 'complete';
      }
    } catch (e) {
      print('[AgentEndpoint] _consumeSseStream error: $e');
      streamSession.stopwatch.stop();
      streamSession.processingTimeMs = streamSession.stopwatch.elapsedMilliseconds;
      streamSession.errorMessage = e.toString();
      streamSession.status = 'error';
    }
  }

  // Cleanup is now handled by cleanupExpiredStreamSessions() from agent_stream_store.dart

  /// Reconstruct AgentBuilderSteps from individual SSE events.
  ///
  /// When the round_complete event doesn't include usable step data,
  /// we can reconstruct the tool call chain from the individual
  /// reasoning, tool_call, and tool_result SSE events.
  List<AgentBuilderStep> _reconstructStepsFromEvents(List<AgentStreamEvent> events) {
    final steps = <AgentBuilderStep>[];
    String? lastReasoning;
    String? currentToolName;

    for (final event in events) {
      Map<String, dynamic> data;
      try {
        data = json.decode(event.data) as Map<String, dynamic>;
      } catch (_) {
        continue;
      }

      switch (event.type) {
        case 'reasoning':
          lastReasoning = data['reasoning']?.toString()
              ?? data['text']?.toString()
              ?? data['raw']?.toString();
          if (lastReasoning != null && lastReasoning.isNotEmpty) {
            steps.add(AgentBuilderStep(
              type: 'reasoning',
              text: lastReasoning,
            ));
          }
          break;

        case 'tool_call':
          currentToolName = data['tool_id']?.toString()
              ?? data['tool_name']?.toString()
              ?? data['toolId']?.toString()
              ?? data['name']?.toString()
              ?? data['function']?.toString()
              ?? data['action_id']?.toString();
          final toolInput = data['params'] ?? data['input']
              ?? data['parameters'] ?? data['arguments'];
          steps.add(AgentBuilderStep(
            type: 'tool_call',
            toolName: currentToolName,
            toolInput: toolInput != null
                ? (toolInput is String ? toolInput : json.encode(toolInput))
                : null,
          ));
          break;

        case 'tool_result':
          // Apply the same tabular_data extraction logic as the non-streaming path
          // to avoid wrapping tabular data in a list that the Flutter parser can't handle
          String? outputStr;
          final rawResults = data['results'];
          if (rawResults is List && rawResults.isNotEmpty) {
            Map<String, dynamic>? tabularResult;
            final resourceResults = <Map<String, dynamic>>[];
            for (final r in rawResults) {
              if (r is! Map<String, dynamic>) continue;
              final rType = r['type']?.toString();
              if (rType == 'tabular_data') tabularResult = r;
              else if (rType == 'resource') resourceResults.add(r);
            }
            if (tabularResult != null) {
              final tData = tabularResult['data'];
              outputStr = tData != null
                  ? (tData is String ? tData : json.encode(tData))
                  : null;
            } else if (resourceResults.isNotEmpty) {
              final resourceDataList = resourceResults
                  .map((r) => r['data'])
                  .where((d) => d != null)
                  .toList();
              outputStr = json.encode(resourceDataList);
            } else {
              outputStr = json.encode(rawResults);
            }
          }
          // Fallback to other field names
          if (outputStr == null) {
            final output = data['output'] ?? data['result']
                ?? data['data'] ?? data['content'];
            outputStr = output != null
                ? (output is String ? output : json.encode(output))
                : null;
          }
          steps.add(AgentBuilderStep(
            type: 'tool_result',
            toolName: currentToolName,
            toolOutput: outputStr,
          ));
          break;
      }
    }

    print('[AgentEndpoint] Reconstructed ${steps.length} steps from ${events.length} SSE events');
    return steps;
  }


  // ============================================
  // USER CONTEXT ENRICHMENT
  // ============================================

  /// Build enriched input by prepending user context.
  ///
  /// Only adds context on the FIRST message of a conversation (no conversationId).
  /// Includes userId and real-time GPS location so the agent knows
  /// who the user is and where they are without needing an extra ES query.
  Future<String> _buildEnrichedInput(
    Session session, {
    required String message,
    int? userId,
    double? latitude,
    double? longitude,
    String? conversationId,
  }) async {
    // Only inject context for the first message in a conversation
    if (conversationId != null && conversationId.isNotEmpty) {
      return message;
    }

    final contextParts = <String>[];

    if (userId != null) {
      contextParts.add('userId: $userId');
    }

    // Include real-time GPS coordinates so the agent knows the user's location
    if (latitude != null && longitude != null) {
      contextParts.add('userLatitude: $latitude');
      contextParts.add('userLongitude: $longitude');

      // Try to resolve city name from coordinates via user_clients → cities
      if (userId != null) {
        try {
          final userClients = await UserClient.db.find(
            session,
            where: (t) => t.userId.equals(userId),
            limit: 1,
          );
          if (userClients.isNotEmpty && userClients.first.defaultCityId != null) {
            final city = await City.db.findById(session, userClients.first.defaultCityId!);
            if (city != null) {
              contextParts.add('userCity: ${city.nameEn}');
              if (city.nameFr != null && city.nameFr != city.nameEn) {
                contextParts.add('userCityFr: ${city.nameFr}');
              }
            }
          }
        } catch (e) {
          session.log(
            '[AgentEndpoint] Could not resolve city name: $e',
            level: LogLevel.warning,
          );
        }
      }
    }

    if (contextParts.isNotEmpty) {
      final context = contextParts.join(', ');
      final enriched = '[$context] $message';
      session.log(
        '[AgentEndpoint] Enriched input: [$context] (agent will query ES for full profile)',
        level: LogLevel.info,
      );
      return enriched;
    }

    return message;
  }

  // ============================================
  // AGENT STATUS
  // ============================================

  /// Get the status of all AI agents
  Future<AiAgentStatusResponse> getAgentStatus(Session session) async {
    final agentService = AiAgentService();
    
    return AiAgentStatusResponse(
      agents: [
        AiAgentStatus(
          agentType: AiAgentType.driverMatching,
          isOnline: agentService.isInitialized,
          totalInvocations: 0,
          successRate: 1.0,
          averageResponseTimeMs: 100,
        ),
        AiAgentStatus(
          agentType: AiAgentType.requestConcierge,
          isOnline: agentService.isInitialized,
          totalInvocations: 0,
          successRate: 1.0,
          averageResponseTimeMs: 50,
        ),
        AiAgentStatus(
          agentType: AiAgentType.demandPrediction,
          isOnline: agentService.isInitialized,
          totalInvocations: 0,
          successRate: 1.0,
          averageResponseTimeMs: 200,
        ),
        AiAgentStatus(
          agentType: AiAgentType.helpCenter,
          isOnline: agentService.isInitialized,
          totalInvocations: 0,
          successRate: 1.0,
          averageResponseTimeMs: 80,
        ),
      ],
      elasticsearchConnected: agentService.isInitialized,
      lastHealthCheck: DateTime.now(),
    );
  }

  // ============================================
  // COMBINED AGENT FLOW
  // ============================================

  /// Full service request flow using multiple agents
  /// 
  /// 1. Parse natural language request (Concierge)
  /// 2. Find matching drivers (Matching)
  /// 3. Return combined result
  Future<AiFullRequestResponse> processFullRequest(
    Session session, {
    required String request,
    required double latitude,
    required double longitude,
    String? language,
  }) async {
    final agentService = AiAgentService();
    
    if (!agentService.isInitialized) {
      return AiFullRequestResponse(
        totalProcessingTimeMs: 0,
        timestamp: DateTime.now(),
      );
    }

    final stopwatch = Stopwatch()..start();

    // Step 1: Parse the request
    final parsedResult = await agentService.parseServiceRequest(
      session,
      naturalLanguageRequest: request,
      language: language ?? 'en',
      userLatitude: latitude,
      userLongitude: longitude,
    );

    // Step 2: If we have a parsed request, find matching drivers via Kibana awhar-match
    AiDriverMatchingResponse? kibanaMatchingResponse;
    
    if (parsedResult.status == AgentResponseStatus.success &&
        parsedResult.parsedRequest != null) {
      // Use the new findBestDrivers which routes through Kibana awhar-match
      kibanaMatchingResponse = await findBestDrivers(
        session,
        serviceId: parsedResult.parsedRequest!.serviceId,
        categoryId: parsedResult.parsedRequest!.categoryId,
        latitude: latitude,
        longitude: longitude,
      );
    }

    stopwatch.stop();

    return AiFullRequestResponse(
      conciergeResponse: _convertConciergeResponse(parsedResult, parsedResult.processingTimeMs),
      matchingResponse: kibanaMatchingResponse,
      totalProcessingTimeMs: stopwatch.elapsedMilliseconds,
      timestamp: DateTime.now(),
    );
  }

  // ============================================
  // CONVERSION HELPERS
  // ============================================

  AiDriverMatchingResponse _convertDriverMatchingResponse(
    DriverMatchingResponse result,
    int processingTimeMs,
  ) {
    return AiDriverMatchingResponse(
      agentType: AiAgentType.driverMatching,
      status: _convertStatus(result.status),
      errorMessage: result.errorMessage,
      processingTimeMs: processingTimeMs,
      timestamp: result.timestamp,
      recommendations: result.recommendations.map((r) => AiDriverRecommendation(
        driverId: r.driverId,
        userId: r.userId,
        displayName: r.displayName,
        profilePhotoUrl: r.profilePhotoUrl,
        ratingAverage: r.ratingAverage,
        ratingCount: r.ratingCount,
        distanceKm: r.distanceKm,
        isOnline: r.isOnline,
        isVerified: r.isVerified,
        isPremium: r.isPremium,
        totalCompletedOrders: r.totalCompletedOrders,
        matchScore: r.matchScore,
        confidence: _convertConfidence(r.confidence),
        matchReasons: r.matchReasons,
      )).toList(),
      explanation: result.explanation,
      totalCandidatesEvaluated: result.totalCandidatesEvaluated,
    );
  }

  AiRequestConciergeResponse _convertConciergeResponse(
    RequestConciergeResponse result,
    int processingTimeMs,
  ) {
    AiParsedServiceRequest? parsedRequest;
    if (result.parsedRequest != null) {
      final p = result.parsedRequest!;
      parsedRequest = AiParsedServiceRequest(
        originalText: result.originalInput,
        detectedServices: p.serviceName != null ? [p.serviceName!] : [],
        suggestedServiceIds: p.serviceId != null ? [p.serviceId!] : [],
        detectedLocation: p.pickupLocation?.originalText,
        suggestedLatitude: p.pickupLocation?.latitude,
        suggestedLongitude: p.pickupLocation?.longitude,
        detectedUrgency: p.isUrgent ? 'urgent' : 'normal',
        isUrgent: p.isUrgent,
        detectedScheduledTime: p.scheduledTime?.toIso8601String(),
        suggestedScheduledTime: p.scheduledTime,
        parsingConfidence: _convertConfidence(result.confidence),
        clarificationNeeded: result.clarifyingQuestions.isNotEmpty,
        clarificationQuestions: result.clarifyingQuestions.map((q) => q.question).toList(),
      );
    }

    return AiRequestConciergeResponse(
      agentType: AiAgentType.requestConcierge,
      status: _convertStatus(result.status),
      errorMessage: result.errorMessage,
      processingTimeMs: processingTimeMs,
      timestamp: result.timestamp,
      parsedRequest: parsedRequest,
      humanReadableSummary: result.summary ?? 'Unable to parse request',
    );
  }

  AiDemandPredictionResponse _convertDemandPredictionResponse(
    DemandPredictionResponse result,
    int processingTimeMs,
  ) {
    // Calculate prediction hours from time difference
    final predictionHours = result.predictionEndTime.difference(result.predictionStartTime).inHours;
    
    return AiDemandPredictionResponse(
      agentType: AiAgentType.demandPrediction,
      status: _convertStatus(result.status),
      errorMessage: result.errorMessage,
      processingTimeMs: processingTimeMs,
      timestamp: result.timestamp,
      hotspots: result.hotspots.map((h) => AiDemandHotspot(
        latitude: h.latitude,
        longitude: h.longitude,
        radiusKm: h.radiusKm,
        demandScore: h.predictedDemand,
        predictedRequests: h.predictedRequests ?? 0,
        peakHours: _parsePeakHours(h.peakTimeWindow),
        topServices: h.topServiceCategories ?? [],
        confidence: AiConfidenceLevel.medium, // Default confidence
        locationName: h.areaName,
      )).toList(),
      predictionHorizonHours: predictionHours,
      overallDemandLevel: _calculateOverallDemand(result.hotspots),
      recommendations: result.driverPositioningRecommendations ?? [],
    );
  }

  /// Parse peak hours from time window string like "18:00-20:00"
  List<int> _parsePeakHours(String? timeWindow) {
    if (timeWindow == null) return [];
    try {
      final parts = timeWindow.split('-');
      if (parts.length == 2) {
        final start = int.parse(parts[0].split(':')[0]);
        final end = int.parse(parts[1].split(':')[0]);
        return List.generate(end - start + 1, (i) => start + i);
      }
    } catch (_) {}
    return [];
  }

  /// Calculate overall demand level from hotspots
  String _calculateOverallDemand(List<DemandHotspot> hotspots) {
    if (hotspots.isEmpty) return 'low';
    final avgDemand = hotspots.fold<double>(0, (sum, h) => sum + h.predictedDemand) / hotspots.length;
    if (avgDemand >= 70) return 'high';
    if (avgDemand >= 40) return 'medium';
    return 'low';
  }

  AiResponseStatus _convertStatus(AgentResponseStatus status) {
    switch (status) {
      case AgentResponseStatus.success:
        return AiResponseStatus.success;
      case AgentResponseStatus.partial:
        return AiResponseStatus.partialSuccess;
      case AgentResponseStatus.failed:
        return AiResponseStatus.error;
      case AgentResponseStatus.needsClarification:
        return AiResponseStatus.partialSuccess;
      case AgentResponseStatus.timeout:
        return AiResponseStatus.timeout;
    }
  }

  AiConfidenceLevel _convertConfidence(ConfidenceLevel level) {
    switch (level) {
      case ConfidenceLevel.high:
        return AiConfidenceLevel.high;
      case ConfidenceLevel.medium:
        return AiConfidenceLevel.medium;
      case ConfidenceLevel.low:
        return AiConfidenceLevel.low;
    }
  }
}
