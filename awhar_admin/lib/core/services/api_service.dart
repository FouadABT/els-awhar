import 'package:awhar_client/awhar_client.dart';
import 'package:flutter/foundation.dart';

/// Singleton service for managing the Serverpod client connection
class ApiService {
  static ApiService? _instance;
  static ApiService get instance => _instance ??= ApiService._();

  ApiService._();

  Client? _client;
  Client get client => _client!;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  /// Initialize the Serverpod client
  /// Uses api.awhar.com in production, localhost in development
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Determine the API URL based on environment
    String apiUrl;
    
    if (kDebugMode) {
      // Development - use localhost or your local IP
      apiUrl = 'http://localhost:8080/';
    } else {
      // Production - use the deployed API
      apiUrl = 'https://api.awhar.com/';
    }

    // If running on web in production, check if we're on admin.awhar.com
    if (kIsWeb && !kDebugMode) {
      apiUrl = 'https://api.awhar.com/';
    }

    debugPrint('[ApiService] Initializing client with URL: $apiUrl');

    // Create the client without authentication key manager for admin dashboard
    // Admin authentication is handled via login endpoint
    // Timeout set to 120s for Agent Builder calls (LLM + multi-tool chains can take 60s+)
    _client = Client(
      apiUrl,
      connectionTimeout: const Duration(seconds: 120),
    );

    _isInitialized = true;
    debugPrint('[ApiService] Client initialized successfully');
  }

  /// Close the client connection
  Future<void> dispose() async {
    if (_isInitialized && _client != null) {
      _client = null;
      _isInitialized = false;
    }
  }
}
