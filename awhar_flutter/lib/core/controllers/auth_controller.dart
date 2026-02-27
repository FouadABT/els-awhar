import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

import '../services/auth_service.dart';
import '../services/notification_service.dart';
import '../services/deep_link_service.dart';
import '../services/storage_service.dart';
import '../services/analytics_service.dart';
import '../services/device_fingerprint_service.dart';
import 'notification_controller.dart';

/// Authentication controller using GetX
/// Manages auth state, user data, and auth flow navigation
class AuthController extends GetxController {
  late final AuthService _authService;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Timer for proactive token refresh
  Timer? _tokenRefreshTimer;

  /// Key for storing last login timestamp
  static const String _lastLoginKey = 'last_login_timestamp';

  /// Key for storing user ID (needed since Serverpod JWT uses UUID, not our int ID)
  static const String _userIdKey = 'user_id';

  /// Key for storing active role selection
  static const String _activeRoleKey = 'active_role';

  /// Session validity duration (6 months in milliseconds)
  static const int _sessionValidityMs = 180 * 24 * 60 * 60 * 1000; // 180 days

  // ============================================================
  // OBSERVABLE STATE
  // ============================================================

  /// Current authenticated user
  final Rx<User?> currentUser = Rx<User?>(null);

  /// Active role for users with multiple roles
  final Rx<UserRole?> activeRole = Rx<UserRole?>(null);

  /// Access token for API calls
  final RxString accessToken = ''.obs;

  /// Refresh token for token renewal
  final RxString refreshToken = ''.obs;

  /// Auth loading state
  final RxBool isLoading = false.obs;

  /// Auth error message
  final RxString errorMessage = ''.obs;

  /// Phone verification ID (for OTP flow)
  final RxString verificationId = ''.obs;

  /// Selected role during registration
  final Rx<UserRole> selectedRole = UserRole.client.obs;

  /// Whether auth check is complete
  final RxBool isInitialized = false.obs;

  // ============================================================
  // GETTERS
  // ============================================================

  /// Whether user is authenticated
  bool get isAuthenticated =>
      currentUser.value != null && accessToken.isNotEmpty;

  /// Alias for isAuthenticated (used by DeepLinkService)
  bool get isLoggedIn => isAuthenticated;

  /// Whether user is a driver
  bool get isDriver =>
      currentUser.value?.roles.contains(UserRole.driver) ?? false;

  /// Whether user is currently in driver mode (for multi-role users)
  bool get isDriverMode => primaryRole == UserRole.driver;

  /// Whether user is a client
  bool get isClient =>
      currentUser.value?.roles.contains(UserRole.client) ?? false;

  /// Whether user is admin
  bool get isAdmin =>
      currentUser.value?.roles.contains(UserRole.admin) ?? false;

  /// User's primary role (respects activeRole if set)
  UserRole? get primaryRole {
    if (activeRole.value != null && hasRole(activeRole.value!)) {
      return activeRole.value;
    }
    return currentUser.value?.roles.isNotEmpty == true
        ? currentUser.value!.roles.first
        : null;
  }

  /// Check if user has a specific role
  bool hasRole(UserRole role) {
    return currentUser.value?.roles.contains(role) ?? false;
  }

  /// Check if user has multiple roles
  bool get hasMultipleRoles => (currentUser.value?.roles.length ?? 0) > 1;

  /// User's email
  String? get email => currentUser.value?.email;

  /// User's phone
  String get phone => currentUser.value?.phoneNumber ?? '';

  /// User's full name
  String get fullName => currentUser.value?.fullName ?? '';

  /// User's profile photo URL
  String? get photoUrl => currentUser.value?.profilePhotoUrl;

  /// User ID from current user or token
  int? get userId =>
      currentUser.value?.id ??
      _authService.getUserIdFromToken(accessToken.value);

  // ============================================================
  // LIFECYCLE
  // ============================================================

  @override
  void onInit() {
    super.onInit();
    _initAuthService();
  }

  void _initAuthService() {
    final client = Get.find<Client>();
    _authService = AuthService(client);

    // Configure JWT auth provider with automatic refresh
    debugPrint('[AuthController] 🔐 Setting up JWT Auth Provider...');
    _setupJwtAuthProvider(client);

    // Listen to Firebase auth state changes
    _authService.authStateChanges.listen((firebaseUser) {
      if (firebaseUser == null && isAuthenticated) {
        // Firebase user signed out, clear local state
        _clearAuthState();
      }
    });

    // Check for existing session
    _checkExistingSession();
  }

  /// Set up Serverpod's JWT auth provider with automatic token refresh
  void _setupJwtAuthProvider(Client client) {
    client.authKeyProvider = JwtAuthKeyProvider(
      getAuthInfo: () async {
        // Get stored tokens
        final access = await _storage.read(key: 'access_token');
        final refresh = await _storage.read(key: 'refresh_token');

        if (access == null || refresh == null) {
          debugPrint('[AuthController] ❌ No stored auth tokens');
          return null;
        }

        // Decode token to get expiration
        final payload = _authService.decodeToken(access);
        if (payload == null) {
          debugPrint('[AuthController] ❌ Failed to decode token');
          return null;
        }

        final exp = payload['exp'];
        DateTime? expiresAt;
        if (exp != null && exp is int) {
          // JWT exp is in seconds
          final expMs = exp < 10000000000000 ? exp * 1000 : exp;
          expiresAt = DateTime.fromMillisecondsSinceEpoch(expMs);
        }

        debugPrint(
          '[AuthController] ✅ Loaded auth tokens, expires: $expiresAt',
        );
        return AuthSuccess(
          authStrategy: 'jwt',
          token: access,
          refreshToken: refresh,
          tokenExpiresAt: expiresAt,
          authUserId: UuidValue.fromString(payload['sub'] ?? ''),
          scopeNames: {},
        );
      },
      onRefreshAuthInfo: (authSuccess) async {
        debugPrint('[AuthController] 💾 Saving refreshed tokens...');
        // Save the new tokens
        await _storage.write(key: 'access_token', value: authSuccess.token);
        await _storage.write(
          key: 'refresh_token',
          value: authSuccess.refreshToken,
        );

        // Update controller state
        accessToken.value = authSuccess.token;
        refreshToken.value = authSuccess.refreshToken ?? '';

        debugPrint('[AuthController] ✅ Refreshed tokens saved');
      },
      refreshEndpoint: client.refreshJwtTokens,
    );

    debugPrint('[AuthController] ✅ JWT Auth Provider configured');
  }

  @override
  void onClose() {
    _tokenRefreshTimer?.cancel();
    super.onClose();
  }

  Future<void> _checkExistingSession() async {
    try {
      isLoading.value = true;
      debugPrint(
        '[AuthController] 🔍 ========================================',
      );
      debugPrint('[AuthController] 🔍 CHECKING EXISTING SESSION');
      debugPrint(
        '[AuthController] 🔍 ========================================',
      );

      // Load stored tokens and last login timestamp
      debugPrint(
        '[AuthController] 📖 Reading stored tokens from secure storage...',
      );
      final storedAccessToken = await _storage.read(key: 'access_token');
      final storedRefreshToken = await _storage.read(key: 'refresh_token');
      final lastLoginStr = await _storage.read(key: _lastLoginKey);

      debugPrint(
        '[AuthController] Access Token: ${storedAccessToken != null ? "Found (${storedAccessToken.length} chars)" : "NOT FOUND"}',
      );
      debugPrint(
        '[AuthController] Refresh Token: ${storedRefreshToken != null ? "Found (${storedRefreshToken.length} chars)" : "NOT FOUND"}',
      );
      debugPrint('[AuthController] Last Login: ${lastLoginStr ?? "NOT FOUND"}');

      // Check if session is within 6 months
      if (lastLoginStr != null) {
        final lastLogin = int.tryParse(lastLoginStr);
        if (lastLogin != null) {
          final elapsed = DateTime.now().millisecondsSinceEpoch - lastLogin;
          final daysElapsed = elapsed / (24 * 60 * 60 * 1000);
          debugPrint(
            '[AuthController] ⏱️  Session age: ${daysElapsed.toStringAsFixed(1)} days (limit: 180 days)',
          );

          if (elapsed > _sessionValidityMs) {
            debugPrint(
              '[AuthController] ❌ Session EXPIRED (over 6 months). Clearing auth state.',
            );
            await _clearAuthState();
            isLoading.value = false;
            isInitialized.value = true;
            return;
          } else {
            debugPrint('[AuthController] ✅ Session still valid');
          }
        }
      } else {
        debugPrint('[AuthController] ⚠️  No last login timestamp found');
      }

      if (storedAccessToken != null && storedRefreshToken != null) {
        debugPrint('[AuthController] ✅ Found stored tokens');

        // Check if access token is valid
        debugPrint(
          '[AuthController] 🔍 Checking if access token is expired...',
        );
        final isExpired = _authService.isTokenExpired(storedAccessToken);
        debugPrint('[AuthController] Token expired: $isExpired');

        if (!isExpired) {
          debugPrint('[AuthController] ✅ Access token is VALID');
          debugPrint(
            '[AuthController] 💾 Setting token values in controller...',
          );
          accessToken.value = storedAccessToken;
          refreshToken.value = storedRefreshToken;

          // JWT auth provider automatically picks up tokens via getAuthInfo callback
          debugPrint(
            '[AuthController] 📡 JWT auth provider has access to tokens',
          );

          // JwtAuthKeyProvider handles automatic token refresh - no manual scheduling needed
          debugPrint(
            '[AuthController] ⏰ JWT auth provider will handle token refresh automatically',
          );

          // Fetch user data using stored user ID (since Serverpod JWT uses UUID, not our int ID)
          debugPrint('[AuthController] 👤 Reading stored user ID...');
          final storedUserId = await _storage.read(key: _userIdKey);
          int? id = storedUserId != null ? int.tryParse(storedUserId) : null;

          // Fallback: try to extract from token (for legacy tokens)
          if (id == null) {
            debugPrint(
              '[AuthController] 👤 Trying to extract user ID from token...',
            );
            id = _authService.getUserIdFromToken(storedAccessToken);
          }
          debugPrint('[AuthController] User ID: $id');

          if (id != null) {
            debugPrint(
              '[AuthController] 📡 Fetching user data from backend...',
            );
            final response = await _authService.getCurrentUser(id);
            debugPrint(
              '[AuthController] Backend response - Success: ${response.success}, User: ${response.user != null}',
            );

            if (response.success && response.user != null) {
              currentUser.value = response.user;
              debugPrint(
                '[AuthController] ✅ User loaded successfully: ${response.user?.fullName}',
              );

              // Load active role preference
              await _loadActiveRole();

              debugPrint('[AuthController] 🎉 SESSION RESTORED SUCCESSFULLY');
            } else {
              debugPrint(
                '[AuthController] ❌ Failed to fetch user data: ${response.message}',
              );
            }
          } else {
            debugPrint(
              '[AuthController] ❌ Could not extract user ID from token',
            );
          }
        } else {
          debugPrint(
            '[AuthController] ⏰ Access token EXPIRED, attempting refresh...',
          );
          // Try to refresh token
          final refreshed = await _refreshWithFallback(storedRefreshToken);
          if (!refreshed) {
            debugPrint(
              '[AuthController] ❌ Token refresh FAILED, clearing state',
            );
            await _clearAuthState();
          } else {
            debugPrint('[AuthController] ✅ Token refresh SUCCEEDED');
          }
        }
      } else {
        debugPrint('[AuthController] ❌ No stored tokens found');
        // Try to recover from Firebase session
        debugPrint(
          '[AuthController] 🔄 Attempting to recover from Firebase session...',
        );
        await _tryRecoverFromFirebase();
      }
    } catch (e) {
      debugPrint('[AuthController] Session check error: $e');
    } finally {
      isLoading.value = false;
      isInitialized.value = true;
    }
  }

  /// Try to recover session using Firebase's persistent auth
  Future<bool> _tryRecoverFromFirebase() async {
    try {
      final firebaseUser = _authService.firebaseUser;
      if (firebaseUser == null) {
        debugPrint('[AuthController] No Firebase user found');
        return false;
      }

      debugPrint(
        '[AuthController] Found Firebase user, attempting silent login...',
      );

      // Get fresh Firebase ID token
      final idToken = await _authService.getFirebaseIdToken(forceRefresh: true);
      if (idToken == null) {
        debugPrint('[AuthController] Could not get Firebase ID token');
        return false;
      }

      // Try login with backend
      final response = await _authService.loginWithBackend(idToken);
      if (response.success && response.user != null) {
        await _saveAuthState(
          response.accessToken!,
          response.refreshToken!,
          response.user,
        );
        debugPrint('[AuthController] Session recovered from Firebase');
        return true;
      }

      return false;
    } catch (e) {
      debugPrint('[AuthController] Firebase recovery error: $e');
      return false;
    }
  }

  /// Refresh token with Firebase fallback
  Future<bool> _refreshWithFallback(String storedRefreshToken) async {
    // First try regular token refresh
    final response = await _authService.refreshBackendToken(storedRefreshToken);
    if (response.success) {
      await _saveAuthState(
        response.accessToken!,
        response.refreshToken!,
        response.user,
      );
      debugPrint('[AuthController] Token refreshed successfully');
      return true;
    }

    // If refresh fails, try Firebase recovery
    debugPrint('[AuthController] Refresh failed, trying Firebase recovery...');
    return await _tryRecoverFromFirebase();
  }

  /// DEPRECATED: JwtAuthKeyProvider handles automatic token refresh
  /// This method is no longer used but kept for reference
  void _scheduleTokenRefresh(String token) {
    // JwtAuthKeyProvider automatically refreshes tokens before expiry
    // No manual scheduling needed
    debugPrint(
      '[AuthController] ⚠️  _scheduleTokenRefresh called but manual refresh is disabled',
    );
    debugPrint(
      '[AuthController] 📡 JwtAuthKeyProvider handles refresh automatically',
    );
    return;

    /* DISABLED - JwtAuthKeyProvider handles this
    _tokenRefreshTimer?.cancel();
    
    final payload = _authService.decodeToken(token);
    if (payload == null) return;
    
    final exp = payload['exp'] as int?;
    if (exp == null) return;
    
    // Calculate time until 5 minutes before expiry
    final expiresAt = DateTime.fromMillisecondsSinceEpoch(exp);
    final refreshAt = expiresAt.subtract(const Duration(minutes: 5));
    final delay = refreshAt.difference(DateTime.now());
    
    if (delay.isNegative) {
      // Token expires in less than 5 minutes, refresh now
      debugPrint('[AuthController] Token expiring soon, refreshing now...');
      refreshAccessToken();
      return;
    }
    
    debugPrint('[AuthController] Scheduled token refresh in ${delay.inMinutes} minutes');
    _tokenRefreshTimer = Timer(delay, () {
      debugPrint('[AuthController] Proactive token refresh triggered');
      refreshAccessToken();
    });
    */
  }

  // ============================================================
  // GOOGLE SIGN IN
  // ============================================================

  /// Sign in with Google
  Future<bool> signInWithGoogle() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _authService.signInWithGoogle();

      if (result.cancelled) {
        return false;
      }

      if (!result.success) {
        errorMessage.value = result.error ?? 'Google sign-in failed';
        return false;
      }

      // Try login with backend
      final response = await _authService.loginWithBackend(result.idToken!);

      if (response.success && response.user != null) {
        await _saveAuthState(
          response.accessToken!,
          response.refreshToken!,
          response.user,
          authMethod: 'google',
        );
        return true;
      }

      if (response.requiresRegistration == true) {
        // User needs to register - navigate to registration with Google data
        Get.toNamed(
          '/auth/register',
          arguments: {
            'idToken': result.idToken,
            'email': result.email,
            'displayName': result.displayName,
            'photoUrl': result.photoUrl,
            'authMethod': 'google',
          },
        );
        return false;
      }

      errorMessage.value = response.message;
      return false;
    } catch (e) {
      errorMessage.value = 'An error occurred';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // EMAIL SIGN IN
  // ============================================================

  /// Sign in with email and password
  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _authService.signInWithEmail(
        email: email,
        password: password,
      );

      if (!result.success) {
        errorMessage.value = result.error ?? 'Email sign-in failed';
        return false;
      }

      // Try login with backend
      final response = await _authService.loginWithBackend(result.idToken!);

      if (response.success && response.user != null) {
        await _saveAuthState(
          response.accessToken!,
          response.refreshToken!,
          response.user,
          authMethod: 'email',
        );
        return true;
      }

      if (response.requiresRegistration == true) {
        // User exists in Firebase but not in backend
        Get.toNamed(
          '/auth/register',
          arguments: {
            'idToken': result.idToken,
            'email': email,
            'authMethod': 'email',
          },
        );
        return false;
      }

      errorMessage.value = response.message;
      return false;
    } catch (e) {
      errorMessage.value = 'An error occurred';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Create account with email and password
  Future<bool> createAccountWithEmail({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
    required UserRole role,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _authService.createAccountWithEmail(
        email: email,
        password: password,
      );

      if (!result.success) {
        // Translate error message
        errorMessage.value =
            (result.error ?? 'errors.account_creation_failed').tr;
        return false;
      }

      // Register with backend
      final response = await _authService.registerWithBackend(
        firebaseIdToken: result.idToken!,
        fullName: fullName,
        role: role,
        email: email,
        phoneNumber: phoneNumber,
      );

      if (response.success && response.user != null) {
        await _saveAuthState(
          response.accessToken!,
          response.refreshToken!,
          response.user,
          isNewUser: true,
          authMethod: 'email',
        );
        return true;
      }

      // Handle backend errors (like duplicate phone)
      if (response.message.contains('phone number is already registered')) {
        errorMessage.value = 'errors.phone_already_in_use'.tr;
      } else {
        errorMessage.value = response.message;
      }
      return false;
    } catch (e) {
      errorMessage.value = 'errors.account_creation_failed'.tr;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Send password reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      return await _authService.sendPasswordResetEmail(email);
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // PHONE SIGN IN
  // ============================================================

  /// Start phone verification
  Future<bool> verifyPhoneNumber(String phoneNumber) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      verificationId.value = '';

      final result = await _authService.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        onCodeSent: (id) {
          verificationId.value = id;
        },
        onError: (error) {
          errorMessage.value = error;
        },
      );

      if (result.autoVerified && result.idToken != null) {
        // Auto-verified, proceed to login
        return await _handlePhoneAuthSuccess(result.idToken!, phoneNumber);
      }

      return result.codeSent;
    } catch (e) {
      errorMessage.value = 'Phone verification failed';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Verify phone with OTP code
  Future<bool> verifyOtpCode(String code) async {
    try {
      if (verificationId.isEmpty) {
        errorMessage.value = 'Verification session expired';
        return false;
      }

      isLoading.value = true;
      errorMessage.value = '';

      final result = await _authService.verifyPhoneCode(
        verificationId: verificationId.value,
        smsCode: code,
      );

      if (!result.success) {
        errorMessage.value = result.error ?? 'Verification failed';
        return false;
      }

      return await _handlePhoneAuthSuccess(
        result.idToken!,
        result.phoneNumber ?? '',
      );
    } catch (e) {
      errorMessage.value = 'Verification failed';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> _handlePhoneAuthSuccess(
    String idToken,
    String phoneNumber,
  ) async {
    // Try login with backend
    final response = await _authService.loginWithBackend(idToken);

    if (response.success && response.user != null) {
      await _saveAuthState(
        response.accessToken!,
        response.refreshToken!,
        response.user,
        authMethod: 'phone',
      );
      return true;
    }

    if (response.requiresRegistration == true) {
      Get.toNamed(
        '/auth/register',
        arguments: {
          'idToken': idToken,
          'phoneNumber': phoneNumber,
          'authMethod': 'phone',
        },
      );
      return false;
    }

    errorMessage.value = response.message;
    return false;
  }

  // ============================================================
  // REGISTRATION
  // ============================================================

  /// Complete registration with role selection
  Future<bool> completeRegistration({
    required String firebaseIdToken,
    required String fullName,
    required UserRole role,
    String? email,
    String? phoneNumber,
    String? profilePhotoUrl,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _authService.registerWithBackend(
        firebaseIdToken: firebaseIdToken,
        fullName: fullName,
        role: role,
        email: email,
        phoneNumber: phoneNumber,
        profilePhotoUrl: profilePhotoUrl,
      );

      if (response.success && response.user != null) {
        await _saveAuthState(
          response.accessToken!,
          response.refreshToken!,
          response.user,
          isNewUser: true,
          authMethod: 'phone',
        );
        return true;
      }

      errorMessage.value = response.message;
      return false;
    } catch (e) {
      errorMessage.value = 'An error occurred';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // SIGN OUT
  // ============================================================

  /// Sign out and clear all auth state
  Future<void> signOut() async {
    try {
      isLoading.value = true;

      // IMPORTANT: Clear FCM token BEFORE signing out
      // This prevents the old user from receiving notifications after logout
      try {
        final notificationService = Get.find<NotificationService>();
        await notificationService.clearFCMToken();
        debugPrint('[AuthController] ✅ FCM token cleared before logout');
      } catch (e) {
        debugPrint('[AuthController] ⚠️ Failed to clear FCM token: $e');
        // Continue with logout even if FCM clear fails
      }

      await _authService.signOut();
      await _clearAuthState();

      // Reset onboarding so user sees it again
      final storageService = Get.find<StorageService>();
      storageService.write('onboarding_completed', false);

      // Navigate to onboarding
      Get.offAllNamed('/onboarding');
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // DELETE ACCOUNT
  // ============================================================

  /// Permanently delete user account
  /// Required for Google Play and Apple App Store compliance
  Future<void> deleteAccount({String? reason}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final userId = currentUser.value?.id;
      if (userId == null) {
        throw Exception('User not found');
      }

      // Call server endpoint to delete account
      final client = Get.find<Client>();
      final response = await client.user.deleteAccount(
        userId: userId,
        reason: reason,
      );

      if (!response.success) {
        throw Exception(response.message);
      }

      debugPrint('[AuthController] Account deleted successfully');

      // Clear FCM token
      try {
        final notificationService = Get.find<NotificationService>();
        await notificationService.clearFCMToken();
      } catch (e) {
        debugPrint('[AuthController] Failed to clear FCM token: $e');
      }

      // Sign out from Firebase and clear local state
      await _authService.signOut();
      await _clearAuthState();

      // Navigate to login screen
      Get.offAllNamed('/auth/login');
    } catch (e) {
      debugPrint('[AuthController] Delete account error: $e');
      errorMessage.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // TOKEN MANAGEMENT
  // ============================================================

  /// Refresh access token
  Future<bool> refreshAccessToken() async {
    if (refreshToken.isEmpty) {
      debugPrint('[AuthController] No refresh token available');
      return await _tryRecoverFromFirebase();
    }

    try {
      final response = await _authService.refreshBackendToken(
        refreshToken.value,
      );
      if (response.success) {
        await _saveAuthState(
          response.accessToken!,
          response.refreshToken!,
          response.user,
        );
        debugPrint('[AuthController] Token refreshed successfully');
        return true;
      }

      // Fallback to Firebase recovery
      debugPrint(
        '[AuthController] Refresh failed, trying Firebase recovery...',
      );
      return await _tryRecoverFromFirebase();
    } catch (e) {
      debugPrint('[AuthController] Token refresh error: $e');
      return await _tryRecoverFromFirebase();
    }
  }

  // ============================================================
  // STATE MANAGEMENT
  // ============================================================

  Future<void> _saveAuthState(String access, String refresh, User? user, {bool isNewUser = false, String? authMethod}) async {
    debugPrint('[AuthController] 💾 ========================================');
    debugPrint('[AuthController] 💾 SAVING AUTH STATE');
    debugPrint('[AuthController] 💾 ========================================');

    debugPrint('[AuthController] Setting token values in controller...');
    accessToken.value = access;
    refreshToken.value = refresh;
    if (user != null) {
      currentUser.value = user;
      debugPrint('[AuthController] User: ${user.fullName} (ID: ${user.id})');

      // Store user ID separately (needed for Serverpod JWT which uses UUID, not our int ID)
      if (user.id != null) {
        await _storage.write(key: _userIdKey, value: user.id.toString());
        debugPrint('[AuthController] ✅ User ID saved to storage: ${user.id}');

        // SECURITY: Set user ID in NotificationController for user-specific notifications
        try {
          if (Get.isRegistered<NotificationController>()) {
            final notificationController = Get.find<NotificationController>();
            notificationController.setCurrentUser(user.id!);
            debugPrint(
              '[AuthController] ✅ NotificationController user set: ${user.id}',
            );
          }
        } catch (e) {
          debugPrint('[AuthController] ⚠️ Failed to set notification user: $e');
        }
        
        // ANALYTICS: Identify user and track login/signup
        try {
          if (Get.isRegistered<AnalyticsService>()) {
            final analytics = Get.find<AnalyticsService>();
            await analytics.identify(
              userId: user.id.toString(),
              isNewUser: isNewUser,
              properties: {
                'role': user.roles.isNotEmpty ? user.roles.first.name : 'client',
                'email': user.email ?? '',
                'full_name': user.fullName ?? '',
                'auth_method': authMethod ?? 'unknown',
              },
            );
            debugPrint('[AuthController] ✅ Analytics user identified: ${user.id}');
          }
        } catch (e) {
          debugPrint('[AuthController] ⚠️ Failed to identify analytics user: $e');
        }
        
        // DEVICE FINGERPRINT: Register device for fraud detection
        try {
          await _registerDeviceFingerprint(user.id!);
        } catch (e) {
          debugPrint('[AuthController] ⚠️ Failed to register device fingerprint: $e');
          // Don't throw - fingerprint failure shouldn't block login
        }
      }
    }

    debugPrint('[AuthController] Writing tokens to FlutterSecureStorage...');
    await _storage.write(key: 'access_token', value: access);
    await _storage.write(key: 'refresh_token', value: refresh);
    debugPrint('[AuthController] ✅ Tokens written to storage');

    // JWT auth provider will automatically pick up the new tokens via getAuthInfo callback
    debugPrint(
      '[AuthController] 📡 JWT auth provider will use updated tokens automatically',
    );

    // Store login timestamp for 6-month validation
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    await _storage.write(key: _lastLoginKey, value: timestamp);
    debugPrint('[AuthController] ✅ Login timestamp saved: $timestamp');

    // JwtAuthKeyProvider handles automatic token refresh - no manual scheduling needed
    debugPrint(
      '[AuthController] ⏰ JWT auth provider will handle token refresh automatically',
    );

    // Send FCM token to backend after successful login
    try {
      final notificationService = Get.find<NotificationService>();
      final fcmToken = notificationService.fcmToken.value;
      if (fcmToken.isNotEmpty && user?.id != null) {
        debugPrint('[AuthController] 📬 Sending FCM token to backend...');
        await notificationService.updateFCMToken();
        debugPrint('[AuthController] ✅ FCM token sent to backend');
      } else {
        debugPrint('[AuthController] ⚠️ FCM token not available yet');
      }
    } catch (e) {
      debugPrint('[AuthController] ⚠️ Failed to send FCM token: $e');
      // Don't throw - FCM token update failure shouldn't block login
    }

    // Process any pending deep link after successful login
    try {
      if (Get.isRegistered<DeepLinkService>()) {
        final deepLinkService = Get.find<DeepLinkService>();
        if (deepLinkService.hasPendingDeepLink) {
          debugPrint('[AuthController] 🔗 Processing pending deep link...');
          deepLinkService.processPendingDeepLink();
        }
      }
    } catch (e) {
      debugPrint('[AuthController] ⚠️ Failed to process pending deep link: $e');
    }

    debugPrint('[AuthController] ✅ Auth state saved successfully');
    debugPrint('[AuthController] 💾 ========================================');
  }

  Future<void> _clearAuthState() async {
    debugPrint(
      '[AuthController] 🗑️  ========================================',
    );
    debugPrint('[AuthController] 🗑️  CLEARING AUTH STATE');
    debugPrint(
      '[AuthController] 🗑️  ========================================',
    );

    debugPrint('[AuthController] Canceling token refresh timer...');
    _tokenRefreshTimer?.cancel();

    // SECURITY: Clear notifications before clearing user state
    try {
      if (Get.isRegistered<NotificationController>()) {
        final notificationController = Get.find<NotificationController>();
        notificationController.onUserLogout();
        debugPrint(
          '[AuthController] ✅ NotificationController cleared on logout',
        );
      }
    } catch (e) {
      debugPrint('[AuthController] ⚠️ Failed to clear notifications: $e');
    }
    
    // ANALYTICS: Reset user identity on logout
    try {
      if (Get.isRegistered<AnalyticsService>()) {
        final analytics = Get.find<AnalyticsService>();
        await analytics.reset();
        debugPrint('[AuthController] ✅ Analytics user reset on logout');
      }
    } catch (e) {
      debugPrint('[AuthController] ⚠️ Failed to reset analytics: $e');
    }

    debugPrint('[AuthController] Clearing controller state...');
    currentUser.value = null;
    activeRole.value = null;
    accessToken.value = '';
    refreshToken.value = '';
    verificationId.value = '';
    errorMessage.value = '';

    debugPrint('[AuthController] Deleting tokens from FlutterSecureStorage...');
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
    await _storage.delete(key: _lastLoginKey);
    await _storage.delete(key: _userIdKey);
    await _storage.delete(key: _activeRoleKey);
    debugPrint('[AuthController] ✅ Tokens and user data deleted from storage');

    // JWT auth provider will automatically detect cleared tokens via getAuthInfo callback
    debugPrint(
      '[AuthController] 📡 JWT auth provider will detect cleared state automatically',
    );

    debugPrint('[AuthController] ✅ Auth state cleared successfully');
    debugPrint(
      '[AuthController] 🗑️  ========================================',
    );
  }

  /// Clear error message
  void clearError() {
    errorMessage.value = '';
  }

  /// Set selected role
  void setRole(UserRole role) {
    selectedRole.value = role;
  }

  /// Refresh user data from backend
  Future<bool> refreshUserData() async {
    debugPrint('[AuthController] 🔄 refreshUserData() called');

    if (userId == null) {
      debugPrint('[AuthController] ❌ userId is null, cannot refresh');
      return false;
    }

    debugPrint('[AuthController] 🔍 Fetching user data for userId: $userId');

    try {
      final response = await _authService.getCurrentUser(userId!);

      debugPrint(
        '[AuthController] 📡 Received response - success: ${response.success}',
      );
      debugPrint(
        '[AuthController] 👤 User object: ${response.user != null ? "exists" : "null"}',
      );

      if (response.success && response.user != null) {
        debugPrint('[AuthController] ✅ User data valid');
        debugPrint(
          '[AuthController] 📷 User photoUrl: ${response.user!.profilePhotoUrl}',
        );
        debugPrint('[AuthController] 📧 User email: ${response.user!.email}');
        debugPrint(
          '[AuthController] 👤 User fullName: ${response.user!.fullName}',
        );

        currentUser.value = response.user;
        debugPrint('[AuthController] ✅ currentUser updated');
        return true;
      }

      debugPrint('[AuthController] ❌ Response not successful or user is null');
      return false;
    } catch (e) {
      debugPrint('[AuthController] ❌ Refresh user data error: $e');
      return false;
    }
  }

  // ============================================================
  // ROLE MANAGEMENT
  // ============================================================

  /// Switch active role for users with multiple roles
  Future<bool> switchActiveRole(UserRole newRole) async {
    try {
      debugPrint('[AuthController] 🔄 Switching active role to: $newRole');

      // Check if user has this role
      if (!hasRole(newRole)) {
        debugPrint('[AuthController] ❌ User does not have role: $newRole');
        errorMessage.value =
            'You do not have permission to switch to this role';
        return false;
      }

      // Update active role
      activeRole.value = newRole;

      // Persist to storage
      await _storage.write(key: _activeRoleKey, value: newRole.name);

      debugPrint('[AuthController] ✅ Active role switched to: $newRole');

      // Notify listeners (will trigger navigation update)
      currentUser.refresh();

      return true;
    } catch (e) {
      debugPrint('[AuthController] ❌ Switch role error: $e');
      errorMessage.value = 'Failed to switch role';
      return false;
    }
  }

  /// Load active role from storage
  Future<void> _loadActiveRole() async {
    try {
      final storedRole = await _storage.read(key: _activeRoleKey);
      if (storedRole != null) {
        // Try to parse stored role
        final role = UserRole.values.firstWhere(
          (r) => r.name == storedRole,
          orElse: () => UserRole.client,
        );

        // Only set if user still has this role
        if (hasRole(role)) {
          activeRole.value = role;
          debugPrint('[AuthController] ✅ Loaded active role: $role');
        } else {
          debugPrint(
            '[AuthController] ⚠️  Stored role not available, clearing',
          );
          await _storage.delete(key: _activeRoleKey);
        }
      }
    } catch (e) {
      debugPrint('[AuthController] ❌ Load active role error: $e');
    }
  }

  /// Add a role to the current user
  Future<bool> addRole(UserRole role) async {
    try {
      if (userId == null) return false;

      debugPrint('[AuthController] ➕ Adding role: $role');

      final response = await _authService.addUserRole(userId!, role);

      if (response.success && response.user != null) {
        currentUser.value = response.user;
        debugPrint('[AuthController] ✅ Role added successfully');
        return true;
      }

      errorMessage.value = response.message;
      return false;
    } catch (e) {
      debugPrint('[AuthController] ❌ Add role error: $e');
      errorMessage.value = 'Failed to add role';
      return false;
    }
  }

  /// Remove a role from the current user
  Future<bool> removeRole(UserRole role) async {
    try {
      if (userId == null) return false;

      debugPrint('[AuthController] ➖ Removing role: $role');

      final response = await _authService.removeUserRole(userId!, role);

      if (response.success && response.user != null) {
        currentUser.value = response.user;

        // If removed role was active role, clear it
        if (activeRole.value == role) {
          activeRole.value = null;
          await _storage.delete(key: _activeRoleKey);
        }

        debugPrint('[AuthController] ✅ Role removed successfully');
        return true;
      }

      errorMessage.value = response.message;
      return false;
    } catch (e) {
      debugPrint('[AuthController] ❌ Remove role error: $e');
      errorMessage.value = 'Failed to remove role';
      return false;
    }
  }
  
  // ============================================================
  // DEVICE FINGERPRINT (FRAUD DETECTION)
  // ============================================================
  
  /// Register device fingerprint for fraud detection
  /// Called automatically after successful authentication
  Future<void> _registerDeviceFingerprint(int userId) async {
    try {
      debugPrint('[AuthController] 🔐 ========================================');
      debugPrint('[AuthController] 🔐 REGISTERING DEVICE FINGERPRINT');
      debugPrint('[AuthController] 🔐 ========================================');
      
      // Get device fingerprint service
      if (!Get.isRegistered<DeviceFingerprintService>()) {
        Get.put(DeviceFingerprintService());
      }
      final fingerprintService = Get.find<DeviceFingerprintService>();
      
      // Ensure fingerprint is collected
      if (!fingerprintService.isCollected) {
        await fingerprintService.collectFingerprint();
      }
      
      final fingerprint = fingerprintService.fingerprint;
      if (fingerprint == null) {
        debugPrint('[AuthController] ⚠️ Could not collect device fingerprint');
        return;
      }
      
      debugPrint('[AuthController] 📱 Fingerprint hash: ${fingerprint.fingerprintHash}');
      debugPrint('[AuthController] 📱 Device: ${fingerprint.components.deviceModel}');
      
      // Get client and register fingerprint with backend
      final client = Get.find<Client>();
      final input = fingerprintService.toServerInput();
      
      final result = await client.deviceFingerprint.registerFingerprint(userId, input);
      
      debugPrint('[AuthController] ✅ Device registered - Risk: ${result.riskLevel} (${result.riskScore.toStringAsFixed(1)})');
      
      if (result.riskFactors.isNotEmpty) {
        debugPrint('[AuthController] ⚠️ Risk factors: ${result.riskFactors.join(", ")}');
      }
      
      if (result.linkedUserCount > 1) {
        debugPrint('[AuthController] 🔍 Device linked to ${result.linkedUserCount} accounts');
      }
      
      if (!result.isAllowed) {
        debugPrint('[AuthController] ❌ Device blocked due to suspicious activity');
        // Could trigger additional verification flow here
      }
      
      debugPrint('[AuthController] 🔐 ========================================');
    } catch (e) {
      debugPrint('[AuthController] ⚠️ Device fingerprint registration failed: $e');
      // Non-blocking - don't prevent login if fingerprint fails
    }
  }
}
