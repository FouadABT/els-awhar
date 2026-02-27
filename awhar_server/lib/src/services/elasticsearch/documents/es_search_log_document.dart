/// Elasticsearch document for search logs index
/// Tracks user searches for analytics and AI improvement
class EsSearchLogDocument {
  final String id; // UUID
  final int? userId;
  final String query;
  final String searchType; // drivers, services, stores, products
  final Map<String, dynamic>? filters;
  final int resultCount;
  final List<String>? clickedResults;
  final Map<String, double>? location;
  final String? sessionId;
  final String? deviceType;
  final String? language;
  final DateTime timestamp;

  EsSearchLogDocument({
    required this.id,
    this.userId,
    required this.query,
    required this.searchType,
    this.filters,
    required this.resultCount,
    this.clickedResults,
    this.location,
    this.sessionId,
    this.deviceType,
    this.language,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'query': query,
      'searchType': searchType,
      'filters': filters,
      'resultCount': resultCount,
      'clickedResults': clickedResults ?? [],
      'location': location,
      'sessionId': sessionId,
      'deviceType': deviceType,
      'language': language,
      'timestamp': timestamp.toIso8601String(),
      // Computed fields
      'hasResults': resultCount > 0,
      'hasClicks': (clickedResults?.isNotEmpty ?? false),
      'queryLength': query.length,
      'wordCount': query.split(' ').length,
    };
  }

  String get documentId => 'search_$id';
}
