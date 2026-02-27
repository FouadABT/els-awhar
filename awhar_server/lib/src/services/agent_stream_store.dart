import '../generated/protocol.dart';

/// In-memory store for active streaming sessions.
///
/// Each session represents a background SSE consumption from
/// Kibana Agent Builder's /converse/async endpoint.
class AgentStreamSession {
  final String sessionId;
  final String agentId;
  final Stopwatch stopwatch = Stopwatch()..start();
  final List<AgentStreamEvent> events = [];
  String status = 'processing'; // processing, complete, error
  String? conversationId;
  String? finalMessage;
  List<AgentBuilderStep>? steps;
  String? errorMessage;
  int? processingTimeMs;
  final DateTime createdAt = DateTime.now();

  AgentStreamSession({required this.sessionId, required this.agentId});
}

/// Global store for active stream sessions.
/// Single server instance for hackathon — no distributed state needed.
final Map<String, AgentStreamSession> activeStreamSessions = {};

/// Clean up stream sessions older than 5 minutes
void cleanupExpiredStreamSessions() {
  final cutoff = DateTime.now().subtract(const Duration(minutes: 5));
  activeStreamSessions.removeWhere((_, session) => session.createdAt.isBefore(cutoff));
}
