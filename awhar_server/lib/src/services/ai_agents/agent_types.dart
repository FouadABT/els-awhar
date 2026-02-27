/// AI Agent Types and Enums
/// 
/// Defines the types of AI agents available in Awhar

/// Available AI agent types
enum AgentType {
  /// Smart Driver Matching - Finds best drivers for a request
  driverMatching,
  
  /// Request Concierge - Parses natural language into structured requests
  requestConcierge,
  
  /// Demand Prediction - Predicts demand hotspots
  demandPrediction,
  
  /// Dispute Resolution - Helps resolve disputes
  disputeResolution,
  
  /// Help Center - Searches knowledge base for FAQ/policy answers
  helpCenter,
}

/// Agent response status
enum AgentResponseStatus {
  /// Successfully processed
  success,
  
  /// Partial results (some data missing)
  partial,
  
  /// Failed to process
  failed,
  
  /// Request needs clarification
  needsClarification,
  
  /// Timed out
  timeout,
}

/// Confidence level for agent recommendations
enum ConfidenceLevel {
  /// High confidence (>80%)
  high,
  
  /// Medium confidence (50-80%)
  medium,
  
  /// Low confidence (<50%)
  low,
}

extension ConfidenceLevelExtension on ConfidenceLevel {
  double get minScore {
    switch (this) {
      case ConfidenceLevel.high:
        return 0.8;
      case ConfidenceLevel.medium:
        return 0.5;
      case ConfidenceLevel.low:
        return 0.0;
    }
  }
  
  String get description {
    switch (this) {
      case ConfidenceLevel.high:
        return 'High confidence - strongly recommended';
      case ConfidenceLevel.medium:
        return 'Medium confidence - good match with some considerations';
      case ConfidenceLevel.low:
        return 'Low confidence - limited data available';
    }
  }
}
