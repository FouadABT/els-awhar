import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import '../services/elasticsearch/elasticsearch.dart';

/// Authentication endpoint for Firebase-based auth
/// Handles registration, login, and token management
class FirebaseAuthEndpoint extends Endpoint {
  /// Register a new user with Firebase token
  /// Creates user in database after verifying Firebase token
  Future<AuthResponse> registerWithFirebase(
    Session session, {
    required String firebaseIdToken,
    required String fullName,
    required UserRole role,
    String? email,
    String? phoneNumber,
    String? profilePhotoUrl,
  }) async {
    try {
      session.log('[Auth] Registration attempt - Name: $fullName, Role: $role, Email: $email, Phone: $phoneNumber');
      
      // Verify Firebase token
      final firebaseUser = await _verifyFirebaseToken(session, firebaseIdToken);
      if (firebaseUser == null) {
        session.log('[Auth] Registration failed: Token verification failed', level: LogLevel.warning);
        return AuthResponse(
          success: false,
          message: 'Invalid Firebase token',
        );
      }

      session.log('[Auth] Token verified for registration - Firebase UID: ${firebaseUser['uid']}, email: ${firebaseUser['email']}, phone: ${firebaseUser['phone_number']}');

      // Validate phone number is provided for driver role
      final finalPhoneNumber = phoneNumber ?? firebaseUser['phone_number'] as String?;
      if (role == UserRole.driver && (finalPhoneNumber == null || finalPhoneNumber.trim().isEmpty)) {
        return AuthResponse(
          success: false,
          message: 'Phone number is required for driver registration',
        );
      }

      // Check if user already exists
      final existingUser = await User.db.findFirstRow(
        session,
        where: (t) => t.firebaseUid.equals(firebaseUser['uid']),
      );

      if (existingUser != null) {
        return AuthResponse(
          success: false,
          message: 'User already registered. Please login instead.',
        );
      }

      // Check if phone number already exists (if provided)
      if (finalPhoneNumber != null && finalPhoneNumber.trim().isNotEmpty) {
        final existingPhoneUser = await User.db.findFirstRow(
          session,
          where: (t) => t.phoneNumber.equals(finalPhoneNumber.trim()),
        );
        
        if (existingPhoneUser != null) {
          return AuthResponse(
            success: false,
            message: 'This phone number is already registered. Please use a different number or login.',
          );
        }
      }

      // Create new user
      final user = User(
        firebaseUid: firebaseUser['uid'] as String,
        fullName: fullName,
        phoneNumber: finalPhoneNumber?.trim().isNotEmpty == true ? finalPhoneNumber!.trim() : null,
        email: email ?? firebaseUser['email'] as String?,
        profilePhotoUrl: profilePhotoUrl ?? firebaseUser['photo_url'] as String?,
        roles: [role],
        status: UserStatus.active,
        isPhoneVerified: firebaseUser['phone_number'] != null,
        isEmailVerified: firebaseUser['email_verified'] as bool? ?? false,
        preferredLanguage: Language.en,
        notificationsEnabled: true,
        darkModeEnabled: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final createdUser = await User.db.insertRow(session, user);
      session.log('[Auth] User created with ID: ${createdUser.id}');

      // Create role-specific records
      if (role == UserRole.driver) {
        session.log('[Auth] Creating driver profile for user ${createdUser.id}...');
        final driverProfile = DriverProfile(
          userId: createdUser.id!,
          displayName: fullName,
          experienceYears: 0,
          ratingAverage: 0.0,
          ratingCount: 0,
          isVerified: false,
          isDocumentsSubmitted: false,
          isFeatured: false,
          isPremium: false,
          totalCompletedOrders: 0,
          totalEarnings: 0.0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          isOnline: false,
        );
        final createdDriver = await DriverProfile.db.insertRow(session, driverProfile);
        session.log('[Auth] ✅ Driver profile created');
        
        // Sync new driver to Elasticsearch
        await session.esSync.indexDriver(createdDriver);

        // Also create UserClient record so drivers can act as clients (favorite, order)
        final existingClient = await UserClient.db.findFirstRow(
          session,
          where: (t) => t.userId.equals(createdUser.id!),
        );
        if (existingClient == null) {
          await UserClient.db.insertRow(
            session,
            UserClient(
              userId: createdUser.id!,
              createdAt: DateTime.now(),
            ),
          );
          session.log('[Auth] ✅ UserClient record created for driver');
        }
      }

      // Create UserClient record when registering as client
      if (role == UserRole.client) {
        final existingClient = await UserClient.db.findFirstRow(
          session,
          where: (t) => t.userId.equals(createdUser.id!),
        );
        if (existingClient == null) {
          await UserClient.db.insertRow(
            session,
            UserClient(
              userId: createdUser.id!,
              createdAt: DateTime.now(),
            ),
          );
          session.log('[Auth] ✅ UserClient record created');
        }
      }

      // Generate JWT tokens using Serverpod's auth system
      session.log('[Auth] 🔐 Generating JWT tokens for new user...');
      final authSuccess = await _generateJwtTokens(session, createdUser);

      session.log('[Auth] User registered: ${createdUser.id} - ${createdUser.email ?? createdUser.phoneNumber}');

      return AuthResponse(
        success: true,
        message: 'Registration successful',
        user: createdUser,
        accessToken: authSuccess.token,
        refreshToken: authSuccess.refreshToken,
      );
    } catch (e) {
      session.log('[Auth] Registration error: $e', level: LogLevel.error);
      return AuthResponse(
        success: false,
        message: 'Registration failed: ${e.toString()}',
      );
    }
  }

  /// Login with Firebase token
  /// Verifies token and returns user data with JWT
  Future<AuthResponse> loginWithFirebase(
    Session session, {
    required String firebaseIdToken,
  }) async {
    try {
      session.log('[Auth] Login attempt with Firebase token (first 20 chars): ${firebaseIdToken.substring(0, firebaseIdToken.length > 20 ? 20 : firebaseIdToken.length)}...');
      
      // Verify Firebase token
      final firebaseUser = await _verifyFirebaseToken(session, firebaseIdToken);
      if (firebaseUser == null) {
        session.log('[Auth] Token verification failed', level: LogLevel.warning);
        return AuthResponse(
          success: false,
          message: 'Invalid Firebase token',
        );
      }

      session.log('[Auth] Token verified for Firebase UID: ${firebaseUser['uid']}, email: ${firebaseUser['email']}, phone: ${firebaseUser['phone_number']}');

      // Find user in database
      final user = await User.db.findFirstRow(
        session,
        where: (t) => t.firebaseUid.equals(firebaseUser['uid']),
      );

      if (user == null) {
        session.log('[Auth] User not found in database for Firebase UID: ${firebaseUser['uid']}');
        return AuthResponse(
          success: false,
          message: 'User not found. Please register first.',
          requiresRegistration: true,
        );
      }

      session.log('[Auth] User found - ID: ${user.id}, email: ${user.email}, phone: ${user.phoneNumber}');

      // Check if user is banned or deleted
      if (user.status == UserStatus.banned) {
        return AuthResponse(
          success: false,
          message: 'Your account has been banned. Contact support.',
        );
      }

      if (user.deletedAt != null) {
        return AuthResponse(
          success: false,
          message: 'Account not found.',
        );
      }

      // Update last seen
      user.lastSeenAt = DateTime.now();
      user.updatedAt = DateTime.now();
      
      // Update verification status from Firebase
      if (firebaseUser['email_verified'] == true && !user.isEmailVerified) {
        user.isEmailVerified = true;
      }
      if (firebaseUser['phone_number'] != null && !user.isPhoneVerified) {
        user.isPhoneVerified = true;
      }

      await User.db.updateRow(session, user);

      // Generate JWT tokens using Serverpod's auth system
      session.log('[Auth] 🔐 Generating JWT tokens for login...');
      final authSuccess = await _generateJwtTokens(session, user);

      session.log('[Auth] User logged in: ${user.id} - ${user.email ?? user.phoneNumber}');

      return AuthResponse(
        success: true,
        message: 'Login successful',
        user: user,
        accessToken: authSuccess.token,
        refreshToken: authSuccess.refreshToken,
      );
    } catch (e) {
      session.log('[Auth] Login error: $e', level: LogLevel.error);
      return AuthResponse(
        success: false,
        message: 'Login failed: ${e.toString()}',
      );
    }
  }

  /// Refresh access token using refresh token
  /// Note: Serverpod JWT has its own refresh mechanism, but we support our custom refresh too
  Future<AuthResponse> refreshToken(
    Session session, {
    required String refreshToken,
  }) async {
    try {
      // First try Serverpod's JWT refresh mechanism
      try {
        final jwt = AuthServices.getTokenManager<JwtTokenManager>().jwt;
        final authSuccess = await jwt.refreshAccessToken(session, refreshToken: refreshToken);
        
        session.log('[Auth] ✅ JWT tokens refreshed successfully');
        
        return AuthResponse(
          success: true,
          message: 'Token refreshed',
          accessToken: authSuccess.token,
          refreshToken: authSuccess.refreshToken,
        );
      } catch (jwtError) {
        session.log('[Auth] JWT refresh failed, trying custom refresh: $jwtError');
      }
      
      // Fall back to custom refresh token logic
      final payload = _verifyRefreshToken(refreshToken);
      if (payload == null) {
        return AuthResponse(
          success: false,
          message: 'Invalid or expired refresh token',
        );
      }

      final userId = payload['userId'] as int;
      final user = await User.db.findById(session, userId);

      if (user == null || user.deletedAt != null) {
        return AuthResponse(
          success: false,
          message: 'User not found',
        );
      }

      // Generate new JWT tokens using Serverpod's auth system
      session.log('[Auth] 🔐 Generating new JWT tokens for refresh...');
      final authSuccess = await _generateJwtTokens(session, user);

      return AuthResponse(
        success: true,
        message: 'Token refreshed',
        accessToken: authSuccess.token,
        refreshToken: authSuccess.refreshToken,
      );
    } catch (e) {
      session.log('[Auth] Token refresh error: $e', level: LogLevel.error);
      return AuthResponse(
        success: false,
        message: 'Token refresh failed',
      );
    }
  }

  /// Get current user by token (pass userId from decoded token)
  Future<AuthResponse> getCurrentUser(
    Session session, {
    required int userId,
  }) async {
    try {
      session.log('[Auth] 🔍 getCurrentUser called for userId: $userId');
      
      session.log('[Auth] Fetching user from database...');
      final user = await User.db.findById(session, userId);
      
      if (user == null || user.deletedAt != null) {
        session.log('[Auth] ❌ User not found or deleted: $userId');
        return AuthResponse(
          success: false,
          message: 'User not found',
        );
      }

      session.log('[Auth] ✅ User found: ${user.fullName} (ID: ${user.id})');
      session.log('[Auth] 📷 User profilePhotoUrl: ${user.profilePhotoUrl}');
      session.log('[Auth] 📧 User email: ${user.email}');
      
      return AuthResponse(
        success: true,
        message: 'User retrieved',
        user: user,
      );
    } catch (e) {
      session.log('[Auth] Get user error: $e', level: LogLevel.error);
      return AuthResponse(
        success: false,
        message: 'Failed to get user',
      );
    }
  }

  /// Logout - client should clear tokens
  Future<AuthResponse> logout(Session session) async {
    return AuthResponse(
      success: true,
      message: 'Logged out successfully',
    );
  }

  /// Check if email exists
  Future<bool> checkEmailExists(Session session, String email) async {
    final user = await User.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
    return user != null;
  }

  /// Check if phone exists
  Future<bool> checkPhoneExists(Session session, String phone) async {
    final user = await User.db.findFirstRow(
      session,
      where: (t) => t.phoneNumber.equals(phone),
    );
    return user != null;
  }

  // ============================================================
  // PRIVATE HELPER METHODS
  // ============================================================

  /// Verify Firebase ID token by calling Firebase Auth REST API
  Future<Map<String, dynamic>?> _verifyFirebaseToken(
    Session session,
    String idToken,
  ) async {
    try {
      session.log('[Auth] Verifying Firebase token...');
      
      // Use Firebase Auth REST API to verify token
      // Firebase Web API Key from your Firebase project
      final response = await http.post(
        Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=AIzaSyCxWnbc4AwroaGf28txrwkBqCgG42bfmrs',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idToken': idToken}),
      );

      session.log('[Auth] Firebase API response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final users = data['users'] as List?;
        if (users != null && users.isNotEmpty) {
          final user = users[0] as Map<String, dynamic>;
          session.log('[Auth] Token verified successfully - UID: ${user['localId']}, Email: ${user['email']}, Phone: ${user['phoneNumber']}');
          return {
            'uid': user['localId'],
            'email': user['email'],
            'email_verified': user['emailVerified'] ?? false,
            'phone_number': user['phoneNumber'],
            'display_name': user['displayName'],
            'photo_url': user['photoUrl'],
          };
        } else {
          session.log('[Auth] Firebase API returned empty users array', level: LogLevel.warning);
        }
      }

      session.log('[Auth] Firebase token verification failed: ${response.body}', level: LogLevel.warning);
      return null;
    } catch (e) {
      session.log('[Auth] Firebase verification error: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Generate auth tokens using Serverpod's built-in JWT authentication system
  /// This creates proper JWT tokens that work with Serverpod's auth middleware
  Future<AuthSuccess> _generateJwtTokens(Session session, User user) async {
    session.log('[Auth] 🔐 Creating JWT tokens for user ${user.id} using Serverpod auth...');
    
    // Get AuthUsers and TokenManager from Serverpod's auth services
    final authUsers = AuthServices.instance.authUsers;
    final tokenManager = AuthServices.instance.tokenManager;
    
    // Create a new AuthUser for this session
    // Serverpod auto-generates the UUID for auth users
    session.log('[Auth] Creating new AuthUser for session...');
    final authUser = await authUsers.create(session);
    final authUserId = authUser.id;
    
    session.log('[Auth] AuthUser created with ID: $authUserId');
    
    // Issue JWT tokens using Serverpod's token manager
    final authSuccess = await tokenManager.issueToken(
      session,
      authUserId: authUserId,
      method: 'firebase',  // Authentication method
      scopes: {}, // Add scopes if needed
    );
    
    session.log('[Auth] ✅ JWT tokens created - Strategy: ${authSuccess.authStrategy}');
    session.log('[Auth] 🔑 Access Token (first 20 chars): ${authSuccess.token.substring(0, authSuccess.token.length > 20 ? 20 : authSuccess.token.length)}...');
    
    return authSuccess;
  }

  /// Verify refresh token (fallback for custom refresh tokens)
  Map<String, dynamic>? _verifyRefreshToken(String token) {
    try {
      final decoded = utf8.decode(base64Url.decode(token));
      final payload = jsonDecode(decoded) as Map<String, dynamic>;

      final expiresAt = payload['exp'] as int;
      if (DateTime.now().millisecondsSinceEpoch > expiresAt) {
        return null; // Token expired
      }

      if (payload['type'] != 'refresh') {
        return null; // Not a refresh token
      }

      return payload;
    } catch (e) {
      return null;
    }
  }
}
