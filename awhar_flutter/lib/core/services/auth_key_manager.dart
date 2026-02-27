import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:serverpod_client/serverpod_client.dart';

/// Custom authentication key provider for Serverpod 3.1.1+
/// Stores and retrieves JWT access tokens from secure storage
/// and provides them in Bearer token format for HTTP requests
class AuthKeyManager implements ClientAuthKeyProvider {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  static const String _accessTokenKey = 'access_token';
  
  /// Cached token in memory for faster access
  String? _cachedToken;
  
  /// Returns the authentication header value in Bearer token format
  /// This is called by Serverpod client before each authenticated request
  @override
  Future<String?> get authHeaderValue async {
    debugPrint('[AuthKeyManager] 🔑 authHeaderValue getter called');
    
    // Use cached token if available
    String? token = _cachedToken;
    if (token == null || token.isEmpty) {
      // Load from storage if not cached
      token = await get();
    }
    
    if (token == null || token.isEmpty) {
      debugPrint('[AuthKeyManager] ❌ No token found - returning null');
      return null;
    }
    
    // Log first/last 10 chars of token for debugging
    final tokenPreview = token.length > 20 
        ? '${token.substring(0, 10)}...${token.substring(token.length - 10)}'
        : token;
    debugPrint('[AuthKeyManager] ✅ Token found: $tokenPreview (length: ${token.length})');
    debugPrint('[AuthKeyManager] 📤 Returning Bearer token header');
    
    // Return in Bearer format as expected by JWT authentication
    return 'Bearer $token';
  }
  
  /// Retrieves the raw JWT access token from secure storage
  Future<String?> get() async {
    debugPrint('[AuthKeyManager] 📖 Reading token from secure storage...');
    final token = await _storage.read(key: _accessTokenKey);
    
    if (token != null) {
      _cachedToken = token; // Cache in memory
      debugPrint('[AuthKeyManager] ✅ Token retrieved and cached (length: ${token.length})');
    } else {
      _cachedToken = null;
      debugPrint('[AuthKeyManager] ⚠️  No token in storage');
    }
    
    return token;
  }
  
  /// Saves a JWT access token to secure storage
  Future<void> put(String token) async {
    debugPrint('[AuthKeyManager] 💾 Saving token to secure storage (length: ${token.length})...');
    
    // Save to cache AND storage
    _cachedToken = token;
    await _storage.write(key: _accessTokenKey, value: token);
    debugPrint('[AuthKeyManager] ✅ Token saved successfully to storage and cache');
    
    // Verify it was saved
    final verify = await _storage.read(key: _accessTokenKey);
    if (verify == token) {
      debugPrint('[AuthKeyManager] ✓ Token verification passed');
    } else {
      debugPrint('[AuthKeyManager] ⚠️  Token verification FAILED!');
      _cachedToken = null; // Clear cache if verification fails
    }
  }
  
  /// Removes the JWT access token from secure storage
  Future<void> remove() async {
    debugPrint('[AuthKeyManager] 🗑️  Removing token from secure storage...');
    
    // Clear cache AND storage
    _cachedToken = null;
    await _storage.delete(key: _accessTokenKey);
    debugPrint('[AuthKeyManager] ✅ Token removed from storage and cache');
    
    // Verify it was removed
    final verify = await _storage.read(key: _accessTokenKey);
    if (verify == null) {
      debugPrint('[AuthKeyManager] ✓ Token removal verified');
    } else {
      debugPrint('[AuthKeyManager] ⚠️  Token still exists after removal!');
    }
  }
}
