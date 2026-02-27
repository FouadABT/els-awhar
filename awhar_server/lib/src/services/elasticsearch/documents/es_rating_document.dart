/// Elasticsearch document for ratings index
/// Maps rating data from both service requests and store orders
/// Combines PG `ratings` and `store_reviews` tables into a unified index
class EsRatingDocument {
  final int id;
  final String ratingSource; // 'service_request' or 'store_order'
  final int? requestId; // For service_request ratings
  final int? storeOrderId; // For store_order ratings
  final int raterId;
  final int ratedEntityId;
  final String ratedEntityType; // 'driver', 'client', 'store', 'driver_to_client'
  final int ratingValue;
  final String? comment;
  final String? response;
  
  // Denormalized names
  final String? raterName;
  final String? ratedEntityName;
  
  // Computed
  final String sentiment;
  final double sentimentScore;
  
  // Timestamps
  final DateTime createdAt;
  final DateTime? responseAt;

  EsRatingDocument({
    required this.id,
    required this.ratingSource,
    this.requestId,
    this.storeOrderId,
    required this.raterId,
    required this.ratedEntityId,
    required this.ratedEntityType,
    required this.ratingValue,
    this.comment,
    this.response,
    this.raterName,
    this.ratedEntityName,
    required this.sentiment,
    required this.sentimentScore,
    required this.createdAt,
    this.responseAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'ratingId': id,
      'ratingSource': ratingSource,
      'requestId': requestId,
      'storeOrderId': storeOrderId,
      'raterId': raterId,
      'ratedEntityId': ratedEntityId,
      'ratedEntityType': ratedEntityType,
      'ratingValue': ratingValue,
      'comment': comment,
      'response': response,
      'raterName': raterName,
      'ratedEntityName': ratedEntityName,
      'sentiment': sentiment,
      'sentimentScore': sentimentScore,
      'hasComment': comment != null && comment!.isNotEmpty,
      'hasResponse': response != null && response!.isNotEmpty,
      'createdAt': createdAt.toIso8601String(),
      'responseAt': responseAt?.toIso8601String(),
    };
  }

  String get documentId => '${ratingSource}_$id';
  
  /// Compute sentiment from rating value (1-5)
  static String computeSentiment(int rating) {
    if (rating >= 4) return 'positive';
    if (rating >= 3) return 'neutral';
    return 'negative';
  }

  /// Compute sentiment score from rating value (maps 1-5 to -1.0 to 1.0)
  static double computeSentimentScore(int rating) {
    return (rating - 3) / 2.0;
  }
}
