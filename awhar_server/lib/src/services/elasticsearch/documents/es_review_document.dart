/// Elasticsearch document for reviews index
/// Maps Review data for sentiment analysis and search
class EsReviewDocument {
  final int id;
  final int orderId;
  final int driverId;
  final int clientId;
  
  // Driver info (denormalized)
  final String? driverName;
  final String? driverPhoto;
  
  // Client info (denormalized)
  final String? clientName;
  
  // Review content
  final int rating;
  final String? comment;
  final String? driverResponse;
  
  // Computed sentiment (for AI analysis)
  final String? sentiment; // positive, neutral, negative
  final double? sentimentScore; // -1.0 to 1.0
  
  // Status
  final bool isVisible;
  final bool isVerified;
  final bool isFlagged;
  final String? flagReason;
  
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? driverRespondedAt;

  EsReviewDocument({
    required this.id,
    required this.orderId,
    required this.driverId,
    required this.clientId,
    this.driverName,
    this.driverPhoto,
    this.clientName,
    required this.rating,
    this.comment,
    this.driverResponse,
    this.sentiment,
    this.sentimentScore,
    required this.isVisible,
    required this.isVerified,
    required this.isFlagged,
    this.flagReason,
    required this.createdAt,
    required this.updatedAt,
    this.driverRespondedAt,
  });

  Map<String, dynamic> toJson() {
    // Compute sentiment if not provided
    final computedSentiment = sentiment ?? _computeSentiment();
    
    return {
      'id': id,
      'orderId': orderId,
      'driverId': driverId,
      'clientId': clientId,
      'driverName': driverName,
      'driverPhoto': driverPhoto,
      'clientName': clientName,
      'rating': rating,
      'comment': comment,
      'driverResponse': driverResponse,
      'sentiment': computedSentiment,
      'sentimentScore': sentimentScore ?? _computeSentimentScore(),
      'isVisible': isVisible,
      'isVerified': isVerified,
      'isFlagged': isFlagged,
      'flagReason': flagReason,
      'hasResponse': driverResponse != null,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'driverRespondedAt': driverRespondedAt?.toIso8601String(),
      'searchableText': _buildSearchableText(),
    };
  }

  /// Basic sentiment based on rating
  String _computeSentiment() {
    if (rating >= 4) return 'positive';
    if (rating >= 3) return 'neutral';
    return 'negative';
  }

  /// Score from -1 to 1 based on rating
  double _computeSentimentScore() {
    // Map 1-5 rating to -1 to 1
    return (rating - 3) / 2.0;
  }

  String _buildSearchableText() {
    final parts = <String>[
      if (comment != null) comment!,
      if (driverResponse != null) driverResponse!,
      if (driverName != null) driverName!,
      if (clientName != null) clientName!,
    ];
    return parts.join(' ');
  }

  String get documentId => 'review_$id';
}
