/// AI Agent Service
/// 
/// Central service for managing all AI agents in Awhar.
/// Provides unified access to:
/// - Driver Matching Agent
/// - Request Concierge Agent  
/// - Demand Prediction Agent
/// 
/// This service is designed to work with Elasticsearch Agent Builder
/// for the hackathon submission.

import 'package:serverpod/serverpod.dart';
import '../elasticsearch/elasticsearch.dart';
import 'agent_types.dart';
import 'agent_models.dart';
import 'driver_matching_agent.dart';
import 'request_concierge_agent.dart';
import 'demand_prediction_agent.dart';

/// AI Agent Service - Central hub for all AI agents
class AiAgentService {
  // Singleton
  static AiAgentService? _instance;
  static AiAgentService get instance {
    _instance ??= AiAgentService._();
    return _instance!;
  }

  factory AiAgentService() => instance;

  AiAgentService._();

  // Agents
  DriverMatchingAgent? _driverMatchingAgent;
  RequestConciergeAgent? _requestConciergeAgent;
  DemandPredictionAgent? _demandPredictionAgent;

  bool _isInitialized = false;

  /// Check if the service is initialized
  bool get isInitialized => _isInitialized;

  /// Initialize the AI agent service
  /// Must be called after ElasticsearchService is initialized
  Future<void> initialize() async {
    if (_isInitialized) return;

    final es = ElasticsearchService();
    if (!es.isInitialized) {
      throw StateError(
        'AiAgentService requires ElasticsearchService to be initialized first.',
      );
    }

    final searchService = es.searchService;
    if (searchService == null) {
      throw StateError('ElasticsearchSearchService not available.');
    }

    // Initialize agents
    _driverMatchingAgent = DriverMatchingAgent(searchService);
    _requestConciergeAgent = RequestConciergeAgent(searchService);
    _demandPredictionAgent = DemandPredictionAgent(es.client, es.config);

    _isInitialized = true;
    print('[AiAgentService] ✅ AI agents initialized');
    print('[AiAgentService] 📊 Available agents: Driver Matching, Request Concierge, Demand Prediction');
  }

  /// Get the Driver Matching Agent
  DriverMatchingAgent get driverMatching {
    if (_driverMatchingAgent == null) {
      throw StateError('AiAgentService not initialized. Call initialize() first.');
    }
    return _driverMatchingAgent!;
  }

  /// Get the Request Concierge Agent
  RequestConciergeAgent get requestConcierge {
    if (_requestConciergeAgent == null) {
      throw StateError('AiAgentService not initialized. Call initialize() first.');
    }
    return _requestConciergeAgent!;
  }

  /// Get the Demand Prediction Agent
  DemandPredictionAgent get demandPrediction {
    if (_demandPredictionAgent == null) {
      throw StateError('AiAgentService not initialized. Call initialize() first.');
    }
    return _demandPredictionAgent!;
  }

  // ============================================
  // CONVENIENCE METHODS
  // ============================================

  /// Find the best drivers for a service request
  Future<DriverMatchingResponse> findBestDrivers(
    Session session, {
    int? serviceId,
    int? categoryId,
    required double latitude,
    required double longitude,
    double? radiusKm,
    bool preferVerified = true,
    bool preferPremium = false,
    double? minRating,
    int maxResults = 5,
  }) async {
    final input = DriverMatchingInput(
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

    return await driverMatching.findBestDrivers(session, input);
  }

  /// Parse a natural language service request
  Future<RequestConciergeResponse> parseServiceRequest(
    Session session, {
    required String naturalLanguageRequest,
    String language = 'en',
    double? userLatitude,
    double? userLongitude,
    int? userId,
  }) async {
    final input = RequestConciergeInput(
      naturalLanguageRequest: naturalLanguageRequest,
      language: language,
      userLatitude: userLatitude,
      userLongitude: userLongitude,
      userId: userId,
    );

    return await requestConcierge.parseRequest(session, input);
  }

  /// Predict demand hotspots
  Future<DemandPredictionResponse> predictDemand(
    Session session, {
    required double latitude,
    required double longitude,
    double radiusKm = 20.0,
    int hoursAhead = 24,
    int? categoryId,
  }) async {
    final input = DemandPredictionInput(
      latitude: latitude,
      longitude: longitude,
      radiusKm: radiusKm,
      hoursAhead: hoursAhead,
      categoryId: categoryId,
    );

    return await demandPrediction.predictDemand(session, input);
  }

  // ============================================
  // HELP CENTER / KNOWLEDGE BASE
  // ============================================

  /// Search the knowledge base for help/FAQ answers using ELSER semantic search.
  /// Powers the Help Center agent tool — understands natural language questions
  /// like "how do I get a refund?" and finds the most relevant KB articles.
  Future<HelpSearchResponse> searchHelp(
    Session session, {
    required String question,
    String language = 'en',
    String? category,
    int maxResults = 5,
  }) async {
    final stopwatch = Stopwatch()..start();

    try {
      final es = ElasticsearchService();
      if (!es.isInitialized || es.searchService == null) {
        stopwatch.stop();
        return HelpSearchResponse(
          status: AgentResponseStatus.failed,
          processingTimeMs: stopwatch.elapsedMilliseconds,
          question: question,
          articles: [],
          summary: 'Help service not available',
        );
      }

      final results = await es.searchService!.searchKnowledgeBase(
        session,
        query: question,
        category: category,
        language: language,
        size: maxResults,
      );

      stopwatch.stop();

      if (results.isEmpty) {
        return HelpSearchResponse(
          status: AgentResponseStatus.success,
          processingTimeMs: stopwatch.elapsedMilliseconds,
          question: question,
          articles: [],
          summary: 'No help articles found for your question. '
              'Try rephrasing or contact support.',
        );
      }

      // Build help articles from knowledge base hits
      final articles = results.map((hit) {
        return HelpArticle(
          title: hit.title,
          content: hit.description ?? '',
          category: hit.category ?? 'general',
          relevanceScore: hit.score,
        );
      }).toList();

      // Generate summary from top article
      final topArticle = articles.first;
      final summary = '**${topArticle.title}**\n\n'
          '${topArticle.content.length > 300 ? '${topArticle.content.substring(0, 300)}...' : topArticle.content}';

      return HelpSearchResponse(
        status: AgentResponseStatus.success,
        processingTimeMs: stopwatch.elapsedMilliseconds,
        question: question,
        articles: articles,
        summary: summary,
        topCategory: topArticle.category,
      );
    } catch (e) {
      stopwatch.stop();
      return HelpSearchResponse(
        status: AgentResponseStatus.failed,
        processingTimeMs: stopwatch.elapsedMilliseconds,
        question: question,
        articles: [],
        summary: 'Error searching help articles: $e',
      );
    }
  }

  /// Perform a smart semantic search using ELSER across all content types.
  /// Can be used by any agent that needs intelligent search capabilities.
  Future<SmartSearchResult?> smartSearch(
    Session session, {
    required String query,
    String language = 'en',
    double? lat,
    double? lon,
    double? radiusKm,
    List<String>? types,
    int sizePerType = 5,
  }) async {
    final es = ElasticsearchService();
    if (!es.isInitialized || es.searchService == null) return null;

    return await es.searchService!.smartSearch(
      session,
      query: query,
      language: language,
      lat: lat,
      lon: lon,
      radiusKm: radiusKm,
      types: types,
      sizePerType: sizePerType,
    );
  }

  // ============================================
  // AGENT LOGGING & ANALYTICS
  // ============================================

  /// Log an agent invocation for analytics
  Future<void> logAgentInvocation(
    Session session, {
    required AgentType agentType,
    required AgentResponseStatus status,
    required int processingTimeMs,
    Map<String, dynamic>? input,
    Map<String, dynamic>? output,
  }) async {
    try {
      final es = ElasticsearchService();
      if (!es.isInitialized) return;

      final document = {
        'agentType': agentType.name,
        'status': status.name,
        'processingTimeMs': processingTimeMs,
        'input': input,
        'resultCount': output?['recommendations']?.length ?? 
                       output?['hotspots']?.length ?? 0,
        'timestamp': DateTime.now().toUtc().toIso8601String(),
      };

      await es.client.indexDocument(
        'search-logs', // Reuse search logs index for agent logs
        'agent_${DateTime.now().millisecondsSinceEpoch}',
        document,
      );
    } catch (e) {
      // Silent fail for logging
      print('[AiAgentService] Warning: Failed to log agent invocation: $e');
    }
  }

  /// Shutdown the service
  void shutdown() {
    _driverMatchingAgent = null;
    _requestConciergeAgent = null;
    _demandPredictionAgent = null;
    _isInitialized = false;
    print('[AiAgentService] Service shut down');
  }
}
