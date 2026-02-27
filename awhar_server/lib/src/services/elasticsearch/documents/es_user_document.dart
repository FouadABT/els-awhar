/// Elasticsearch document for users index
/// Maps user data for segmentation, analytics, and concierge personalization
class EsUserDocument {
  final int id;
  final String fullName;
  final String? phoneNumber;
  final String? email;
  final List<String> roles; // client, driver, store
  final bool isOnline;
  final bool isPhoneVerified;
  final bool isEmailVerified;
  
  // Ratings
  final double rating;
  final int totalRatings;
  final double ratingAsClient;
  final int totalRatingsAsClient;
  
  // Activity
  final int totalTrips;
  
  // Location
  final Map<String, double>? location;
  final String? cityName;
  final int? cityId;
  final String? defaultAddress;
  
  // Preferences
  final String? preferredLanguage;
  final bool notificationsEnabled;
  
  // Status
  final bool isSuspended;
  final String? suspensionReason;
  final int totalReportsReceived;
  final int totalReportsMade;
  
  // Timestamps
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastSeenAt;

  EsUserDocument({
    required this.id,
    required this.fullName,
    this.phoneNumber,
    this.email,
    required this.roles,
    required this.isOnline,
    required this.isPhoneVerified,
    required this.isEmailVerified,
    required this.rating,
    required this.totalRatings,
    required this.ratingAsClient,
    required this.totalRatingsAsClient,
    required this.totalTrips,
    this.location,
    this.cityName,
    this.cityId,
    this.defaultAddress,
    this.preferredLanguage,
    required this.notificationsEnabled,
    required this.isSuspended,
    this.suspensionReason,
    required this.totalReportsReceived,
    required this.totalReportsMade,
    required this.createdAt,
    required this.updatedAt,
    this.lastSeenAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'roles': roles,
      'isOnline': isOnline,
      'isPhoneVerified': isPhoneVerified,
      'isEmailVerified': isEmailVerified,
      'rating': rating,
      'totalRatings': totalRatings,
      'ratingAsClient': ratingAsClient,
      'totalRatingsAsClient': totalRatingsAsClient,
      'totalTrips': totalTrips,
      'location': location,
      'cityName': cityName,
      'cityId': cityId,
      'defaultAddress': defaultAddress,
      'preferredLanguage': preferredLanguage,
      'notificationsEnabled': notificationsEnabled,
      'isSuspended': isSuspended,
      'suspensionReason': suspensionReason,
      'totalReportsReceived': totalReportsReceived,
      'totalReportsMade': totalReportsMade,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'lastSeenAt': lastSeenAt?.toIso8601String(),
    };
  }

  String get documentId => 'user_$id';
}
