/// AI Agent Response Models
/// 
/// Data structures for agent inputs and outputs

import 'agent_types.dart';

/// Base class for all agent responses
abstract class AgentResponse {
  final AgentType agentType;
  final AgentResponseStatus status;
  final String? errorMessage;
  final int processingTimeMs;
  final DateTime timestamp;

  AgentResponse({
    required this.agentType,
    required this.status,
    this.errorMessage,
    required this.processingTimeMs,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson();
}

/// Driver recommendation from the matching agent
class DriverRecommendation {
  final int driverId;
  final int userId;
  final String? displayName;
  final String? profilePhotoUrl;
  final double? ratingAverage;
  final int? ratingCount;
  final double distanceKm;
  final bool isOnline;
  final bool isVerified;
  final bool isPremium;
  final int? totalCompletedOrders;
  final double matchScore; // 0.0 to 1.0
  final ConfidenceLevel confidence;
  final List<String> matchReasons;
  final Map<String, dynamic>? metadata;

  DriverRecommendation({
    required this.driverId,
    required this.userId,
    this.displayName,
    this.profilePhotoUrl,
    this.ratingAverage,
    this.ratingCount,
    required this.distanceKm,
    this.isOnline = false,
    this.isVerified = false,
    this.isPremium = false,
    this.totalCompletedOrders,
    required this.matchScore,
    required this.confidence,
    required this.matchReasons,
    this.metadata,
  });

  Map<String, dynamic> toJson() => {
    'driverId': driverId,
    'userId': userId,
    'displayName': displayName,
    'profilePhotoUrl': profilePhotoUrl,
    'ratingAverage': ratingAverage,
    'ratingCount': ratingCount,
    'distanceKm': distanceKm,
    'isOnline': isOnline,
    'isVerified': isVerified,
    'isPremium': isPremium,
    'totalCompletedOrders': totalCompletedOrders,
    'matchScore': matchScore,
    'confidence': confidence.name,
    'matchReasons': matchReasons,
    'metadata': metadata,
  };
}

/// Response from Driver Matching Agent
class DriverMatchingResponse extends AgentResponse {
  final List<DriverRecommendation> recommendations;
  final String explanation;
  final int totalCandidatesEvaluated;
  final Map<String, dynamic>? searchCriteria;

  DriverMatchingResponse({
    required super.status,
    super.errorMessage,
    required super.processingTimeMs,
    required this.recommendations,
    required this.explanation,
    required this.totalCandidatesEvaluated,
    this.searchCriteria,
  }) : super(agentType: AgentType.driverMatching);

  @override
  Map<String, dynamic> toJson() => {
    'agentType': agentType.name,
    'status': status.name,
    'errorMessage': errorMessage,
    'processingTimeMs': processingTimeMs,
    'timestamp': timestamp.toIso8601String(),
    'recommendations': recommendations.map((r) => r.toJson()).toList(),
    'explanation': explanation,
    'totalCandidatesEvaluated': totalCandidatesEvaluated,
    'searchCriteria': searchCriteria,
  };
}

/// Parsed location from natural language
class ParsedLocation {
  final String originalText;
  final String? normalizedName;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? placeType; // 'store', 'address', 'landmark', 'unknown'
  final double confidence;

  ParsedLocation({
    required this.originalText,
    this.normalizedName,
    this.latitude,
    this.longitude,
    this.address,
    this.placeType,
    required this.confidence,
  });

  Map<String, dynamic> toJson() => {
    'originalText': originalText,
    'normalizedName': normalizedName,
    'latitude': latitude,
    'longitude': longitude,
    'address': address,
    'placeType': placeType,
    'confidence': confidence,
  };
}

/// Structured request parsed by concierge agent
class ParsedServiceRequest {
  final int? serviceId;
  final String? serviceName;
  final int? categoryId;
  final String? categoryName;
  final ParsedLocation? pickupLocation;
  final ParsedLocation? dropoffLocation;
  final String? description;
  final double? estimatedPrice;
  final double? priceMin;
  final double? priceMax;
  final String? priceType; // 'fixed', 'hourly', 'negotiable'
  final List<String>? specialRequirements;
  final DateTime? scheduledTime;
  final bool isUrgent;

  ParsedServiceRequest({
    this.serviceId,
    this.serviceName,
    this.categoryId,
    this.categoryName,
    this.pickupLocation,
    this.dropoffLocation,
    this.description,
    this.estimatedPrice,
    this.priceMin,
    this.priceMax,
    this.priceType,
    this.specialRequirements,
    this.scheduledTime,
    this.isUrgent = false,
  });

  Map<String, dynamic> toJson() => {
    'serviceId': serviceId,
    'serviceName': serviceName,
    'categoryId': categoryId,
    'categoryName': categoryName,
    'pickupLocation': pickupLocation?.toJson(),
    'dropoffLocation': dropoffLocation?.toJson(),
    'description': description,
    'estimatedPrice': estimatedPrice,
    'priceMin': priceMin,
    'priceMax': priceMax,
    'priceType': priceType,
    'specialRequirements': specialRequirements,
    'scheduledTime': scheduledTime?.toIso8601String(),
    'isUrgent': isUrgent,
  };
}

/// Clarifying question from concierge agent
class ClarifyingQuestion {
  final String question;
  final String field; // which field needs clarification
  final List<String>? suggestedOptions;
  final bool isRequired;

  ClarifyingQuestion({
    required this.question,
    required this.field,
    this.suggestedOptions,
    this.isRequired = true,
  });

  Map<String, dynamic> toJson() => {
    'question': question,
    'field': field,
    'suggestedOptions': suggestedOptions,
    'isRequired': isRequired,
  };
}

/// Response from Request Concierge Agent
class RequestConciergeResponse extends AgentResponse {
  final String originalInput;
  final ParsedServiceRequest? parsedRequest;
  final ConfidenceLevel confidence;
  final List<ClarifyingQuestion> clarifyingQuestions;
  final String? summary;
  final List<Map<String, dynamic>>? similarServices;

  RequestConciergeResponse({
    required super.status,
    super.errorMessage,
    required super.processingTimeMs,
    required this.originalInput,
    this.parsedRequest,
    required this.confidence,
    this.clarifyingQuestions = const [],
    this.summary,
    this.similarServices,
  }) : super(agentType: AgentType.requestConcierge);

  @override
  Map<String, dynamic> toJson() => {
    'agentType': agentType.name,
    'status': status.name,
    'errorMessage': errorMessage,
    'processingTimeMs': processingTimeMs,
    'timestamp': timestamp.toIso8601String(),
    'originalInput': originalInput,
    'parsedRequest': parsedRequest?.toJson(),
    'confidence': confidence.name,
    'clarifyingQuestions': clarifyingQuestions.map((q) => q.toJson()).toList(),
    'summary': summary,
    'similarServices': similarServices,
  };
}

/// Demand hotspot prediction
class DemandHotspot {
  final double latitude;
  final double longitude;
  final double radiusKm;
  final String? areaName;
  final double predictedDemand; // relative score 0-100
  final int? predictedRequests; // estimated number of requests
  final String? peakTimeWindow; // e.g., "18:00-20:00"
  final List<String>? topServiceCategories;
  final String? recommendation;

  DemandHotspot({
    required this.latitude,
    required this.longitude,
    required this.radiusKm,
    this.areaName,
    required this.predictedDemand,
    this.predictedRequests,
    this.peakTimeWindow,
    this.topServiceCategories,
    this.recommendation,
  });

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    'radiusKm': radiusKm,
    'areaName': areaName,
    'predictedDemand': predictedDemand,
    'predictedRequests': predictedRequests,
    'peakTimeWindow': peakTimeWindow,
    'topServiceCategories': topServiceCategories,
    'recommendation': recommendation,
  };
}

/// Response from Demand Prediction Agent
class DemandPredictionResponse extends AgentResponse {
  final DateTime predictionStartTime;
  final DateTime predictionEndTime;
  final List<DemandHotspot> hotspots;
  final String summary;
  final Map<String, dynamic>? historicalContext;
  final List<String>? driverPositioningRecommendations;

  DemandPredictionResponse({
    required super.status,
    super.errorMessage,
    required super.processingTimeMs,
    required this.predictionStartTime,
    required this.predictionEndTime,
    required this.hotspots,
    required this.summary,
    this.historicalContext,
    this.driverPositioningRecommendations,
  }) : super(agentType: AgentType.demandPrediction);

  @override
  Map<String, dynamic> toJson() => {
    'agentType': agentType.name,
    'status': status.name,
    'errorMessage': errorMessage,
    'processingTimeMs': processingTimeMs,
    'timestamp': timestamp.toIso8601String(),
    'predictionStartTime': predictionStartTime.toIso8601String(),
    'predictionEndTime': predictionEndTime.toIso8601String(),
    'hotspots': hotspots.map((h) => h.toJson()).toList(),
    'summary': summary,
    'historicalContext': historicalContext,
    'driverPositioningRecommendations': driverPositioningRecommendations,
  };
}

// ============================================
// HELP CENTER / KNOWLEDGE BASE MODELS
// ============================================

/// A single help/FAQ article from the knowledge base
class HelpArticle {
  final String title;
  final String content;
  final String category;
  final double relevanceScore;
  final Map<String, dynamic>? metadata;

  HelpArticle({
    required this.title,
    required this.content,
    required this.category,
    required this.relevanceScore,
    this.metadata,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'content': content,
    'category': category,
    'relevanceScore': relevanceScore,
    'metadata': metadata,
  };
}

/// Response from the Help Center agent
class HelpSearchResponse extends AgentResponse {
  final String question;
  final List<HelpArticle> articles;
  final String summary;
  final String? topCategory;

  HelpSearchResponse({
    required super.status,
    super.errorMessage,
    required super.processingTimeMs,
    required this.question,
    required this.articles,
    required this.summary,
    this.topCategory,
  }) : super(agentType: AgentType.helpCenter);

  @override
  Map<String, dynamic> toJson() => {
    'agentType': agentType.name,
    'status': status.name,
    'errorMessage': errorMessage,
    'processingTimeMs': processingTimeMs,
    'timestamp': timestamp.toIso8601String(),
    'question': question,
    'articles': articles.map((a) => a.toJson()).toList(),
    'summary': summary,
    'topCategory': topCategory,
    'totalArticles': articles.length,
  };
}
