import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:flutter/foundation.dart';

/// Authentication service that bridges Firebase Auth with Serverpod backend
/// Handles all auth operations: Google, Email/Password, Phone
class AuthService {
  final firebase.FirebaseAuth _firebaseAuth = firebase.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final Client _client;
  bool _googleSignInInitialized = false;

  // TODO: Replace with your actual Web Client ID from Firebase Console
  // Firebase Console → Authentication → Sign-in method → Google → Web SDK configuration
  static const String _webClientId = '77569114860-k3h0nt9u1g5rued8k5tdf9hn3hp30974.apps.googleusercontent.com';

  /// Current Firebase user
  firebase.User? get firebaseUser => _firebaseAuth.currentUser;

  /// Stream of auth state changes
  Stream<firebase.User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Whether user is signed in
  bool get isSignedIn => firebaseUser != null;

  AuthService(this._client);

  // ============================================================
  // GOOGLE SIGN IN
  // ============================================================

  /// Initialize Google Sign In (must be called before signInWithGoogle)
  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_googleSignInInitialized) {
      // serverClientId is required for Android - use Web Client ID from Firebase Console
      await _googleSignIn.initialize(
        serverClientId: _webClientId,
      );
      _googleSignInInitialized = true;
    }
  }

  /// Sign in with Google
  /// Returns Firebase ID token for backend verification
  Future<AuthResult> signInWithGoogle() async {
    try {
      // Ensure Google Sign-In is initialized
      await _ensureGoogleSignInInitialized();

      // Try to authenticate with Google
      GoogleSignInAccount? googleAccount;
      
      // First try lightweight authentication (auto sign-in for returning users)
      final lightweightResult = await _googleSignIn.attemptLightweightAuthentication();
      if (lightweightResult != null) {
        googleAccount = lightweightResult;
      } else {
        // Show sign-in UI
        if (_googleSignIn.supportsAuthenticate()) {
          googleAccount = await _googleSignIn.authenticate();
        } else {
          return AuthResult.error('Google Sign-In not supported on this platform');
        }
      }

      // Get the ID token from Google Sign-In
      final String? googleIdToken = googleAccount.authentication.idToken;
      if (googleIdToken == null) {
        return AuthResult.error('Failed to get Google ID token');
      }

      // Create Firebase credential with just the idToken
      // (google_sign_in v7 doesn't provide accessToken for auth)
      final credential = firebase.GoogleAuthProvider.credential(
        idToken: googleIdToken,
      );

      // Sign in to Firebase
      final userCredential = await _firebaseAuth.signInWithCredential(credential);

      // Get Firebase ID token for backend
      final idToken = await userCredential.user?.getIdToken();
      if (idToken == null) {
        return AuthResult.error('Failed to get Firebase token');
      }

      return AuthResult.success(
        idToken: idToken,
        email: userCredential.user?.email,
        displayName: userCredential.user?.displayName,
        photoUrl: userCredential.user?.photoURL,
        isNewUser: userCredential.additionalUserInfo?.isNewUser ?? false,
      );
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return AuthResult.cancelled();
      }
      return AuthResult.error('Google sign-in failed: ${e.description ?? e.code.name}');
    } on firebase.FirebaseAuthException catch (e) {
      return AuthResult.error(_getFirebaseErrorMessage(e.code));
    } catch (e) {
      return AuthResult.error('Google sign-in failed: ${e.toString()}');
    }
  }

  // ============================================================
  // EMAIL/PASSWORD SIGN IN
  // ============================================================

  /// Sign in with email and password
  Future<AuthResult> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final idToken = await userCredential.user?.getIdToken();
      if (idToken == null) {
        return AuthResult.error('Failed to get Firebase token');
      }

      return AuthResult.success(
        idToken: idToken,
        email: userCredential.user?.email,
        isNewUser: false,
        isEmailVerified: userCredential.user?.emailVerified ?? false,
      );
    } on firebase.FirebaseAuthException catch (e) {
      return AuthResult.error(_getFirebaseErrorMessage(e.code));
    } catch (e) {
      return AuthResult.error('Email sign-in failed: ${e.toString()}');
    }
  }

  /// Create account with email and password
  Future<AuthResult> createAccountWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final idToken = await userCredential.user?.getIdToken();
      if (idToken == null) {
        return AuthResult.error('Failed to get Firebase token');
      }

      return AuthResult.success(
        idToken: idToken,
        email: userCredential.user?.email,
        isNewUser: true,
        isEmailVerified: false,
      );
    } on firebase.FirebaseAuthException catch (e) {
      return AuthResult.error(_getFirebaseErrorMessage(e.code));
    } catch (e) {
      return AuthResult.error('Account creation failed: ${e.toString()}');
    }
  }

  /// Send password reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Send email verification to current user
  Future<bool> sendEmailVerification() async {
    try {
      await firebaseUser?.sendEmailVerification();
      return true;
    } catch (e) {
      return false;
    }
  }

  // ============================================================
  // PHONE AUTHENTICATION
  // ============================================================

  /// Start phone verification
  /// Returns verification ID to be used with verifyPhoneCode
  Future<PhoneVerificationResult> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onError,
  }) async {
    final completer = _PhoneVerificationCompleter();

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (firebase.PhoneAuthCredential credential) async {
        // Auto-verification on Android
        try {
          final userCredential = await _firebaseAuth.signInWithCredential(credential);
          final idToken = await userCredential.user?.getIdToken();
          completer.complete(PhoneVerificationResult.autoVerified(
            idToken: idToken!,
            phoneNumber: phoneNumber,
          ));
        } catch (e) {
          onError('Auto-verification failed');
        }
      },
      verificationFailed: (firebase.FirebaseAuthException e) {
        onError(_getFirebaseErrorMessage(e.code));
        completer.complete(PhoneVerificationResult.error(e.message ?? 'Verification failed'));
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
        completer.complete(PhoneVerificationResult.codeSent(verificationId));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Timeout, user must enter code manually
      },
      timeout: const Duration(seconds: 60),
    );

    return completer.future;
  }

  /// Verify phone with SMS code
  Future<AuthResult> verifyPhoneCode({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = firebase.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      final idToken = await userCredential.user?.getIdToken();

      if (idToken == null) {
        return AuthResult.error('Failed to get Firebase token');
      }

      return AuthResult.success(
        idToken: idToken,
        phoneNumber: userCredential.user?.phoneNumber,
        isNewUser: userCredential.additionalUserInfo?.isNewUser ?? false,
      );
    } on firebase.FirebaseAuthException catch (e) {
      return AuthResult.error(_getFirebaseErrorMessage(e.code));
    } catch (e) {
      return AuthResult.error('Phone verification failed: ${e.toString()}');
    }
  }

  // ============================================================
  // BACKEND INTEGRATION
  // ============================================================

  /// Register user on Serverpod backend after Firebase auth
  Future<AuthResponse> registerWithBackend({
    required String firebaseIdToken,
    required String fullName,
    required UserRole role,
    String? email,
    String? phoneNumber,
    String? profilePhotoUrl,
  }) async {
    try {
      return await _client.firebaseAuth.registerWithFirebase(
        firebaseIdToken: firebaseIdToken,
        fullName: fullName,
        role: role,
        email: email,
        phoneNumber: phoneNumber,
        profilePhotoUrl: profilePhotoUrl,
      );
    } catch (e) {
      debugPrint('[AuthService] Backend registration error: $e');
      return AuthResponse(
        success: false,
        message: 'Failed to connect to server',
      );
    }
  }

  /// Login to Serverpod backend with Firebase token
  Future<AuthResponse> loginWithBackend(String firebaseIdToken) async {
    try {
      return await _client.firebaseAuth.loginWithFirebase(
        firebaseIdToken: firebaseIdToken,
      );
    } catch (e) {
      debugPrint('[AuthService] Backend login error: $e');
      return AuthResponse(
        success: false,
        message: 'Failed to connect to server',
      );
    }
  }

  /// Refresh backend access token
  Future<AuthResponse> refreshBackendToken(String refreshToken) async {
    try {
      return await _client.firebaseAuth.refreshToken(refreshToken: refreshToken);
    } catch (e) {
      debugPrint('[AuthService] Token refresh error: $e');
      return AuthResponse(
        success: false,
        message: 'Failed to refresh token',
      );
    }
  }

  /// Get current user from backend
  Future<AuthResponse> getCurrentUser(int userId) async {
    try {
      return await _client.firebaseAuth.getCurrentUser(userId: userId);
    } catch (e) {
      debugPrint('[AuthService] Get user error: $e');
      return AuthResponse(
        success: false,
        message: 'Failed to get user',
      );
    }
  }

  // ============================================================
  // SIGN OUT
  // ============================================================

  /// Sign out from Firebase and Google
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      if (_googleSignInInitialized) {
        await _googleSignIn.signOut();
      }
    } catch (e) {
      debugPrint('[AuthService] Sign out error: $e');
    }
  }

  // ============================================================
  // TOKEN UTILITIES
  // ============================================================

  /// Get fresh Firebase ID token
  Future<String?> getFirebaseIdToken({bool forceRefresh = false}) async {
    try {
      var user = firebaseUser;

      // Firebase can have a persisted user but fail to mint a token until
      // after a reload (common right after app start).
      if (user != null) {
        await user.reload();
        user = _firebaseAuth.currentUser;
      }

      final token = await user?.getIdToken(forceRefresh);
      if (token == null || token.isEmpty) {
        debugPrint('[AuthService] getFirebaseIdToken returned empty token');
      }
      return token;
    } catch (e) {
      debugPrint('[AuthService] getFirebaseIdToken error: $e');
      return null;
    }
  }

  /// Decode JWT token to get payload (userId, roles, etc.)
  /// Supports both Serverpod JWT tokens (3-part) and our simple base64 tokens
  Map<String, dynamic>? decodeToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length == 3) {
        // Standard JWT token (header.payload.signature)
        // Decode the payload (middle part)
        String payload = parts[1];
        // Add padding if needed for base64 decoding
        while (payload.length % 4 != 0) {
          payload += '=';
        }
        final decoded = utf8.decode(base64Url.decode(payload));
        return jsonDecode(decoded) as Map<String, dynamic>;
      } else if (parts.length == 1) {
        // Our simple base64 token (legacy format)
        final decoded = utf8.decode(base64Url.decode(token));
        return jsonDecode(decoded) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      debugPrint('[AuthService] Failed to decode token: $e');
      return null;
    }
  }

  /// Check if token is expired
  /// Works with both Serverpod JWT tokens and our legacy tokens
  bool isTokenExpired(String token) {
    final payload = decodeToken(token);
    if (payload == null) return true;

    // Check 'exp' claim (both JWT standard and our legacy format)
    final exp = payload['exp'];
    if (exp == null) return true;

    // JWT exp is in seconds, our legacy format is in milliseconds
    int expMs;
    if (exp is int) {
      // If exp is less than 10 trillion, it's in seconds (JWT standard)
      // If greater, it's in milliseconds (our legacy format)
      expMs = exp < 10000000000000 ? exp * 1000 : exp;
    } else {
      return true;
    }

    return DateTime.now().millisecondsSinceEpoch > expMs;
  }

  /// Get user ID from token
  /// Note: For Serverpod JWT tokens, this returns null since they use UUID 'sub' field
  /// The app should use the User object from the AuthResponse instead
  int? getUserIdFromToken(String token) {
    final payload = decodeToken(token);
    if (payload == null) return null;
    
    // Try our legacy format first
    if (payload.containsKey('userId')) {
      return payload['userId'] as int?;
    }
    
    // Serverpod JWT uses 'sub' for authUserId (UUID), not our int user ID
    // Return null - the app should use currentUser.value?.id instead
    return null;
  }

  // ============================================================
  // HELPERS
  // ============================================================

  String _getFirebaseErrorMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'errors.invalid_email';
      case 'user-disabled':
        return 'errors.user_disabled';
      case 'user-not-found':
        return 'errors.user_not_found';
      case 'wrong-password':
        return 'errors.wrong_password';
      case 'email-already-in-use':
        return 'errors.email_already_in_use';
      case 'weak-password':
        return 'errors.weak_password';
      case 'operation-not-allowed':
        return 'errors.operation_not_allowed';
      case 'invalid-verification-code':
        return 'errors.invalid_verification_code';
      case 'invalid-verification-id':
        return 'errors.invalid_verification_id';
      case 'too-many-requests':
        return 'errors.too_many_requests';
      case 'network-request-failed':
        return 'errors.network_request_failed';
      case 'account-exists-with-different-credential':
        return 'errors.account_exists_with_different_credential';
      default:
        return 'errors.authentication_failed';
    }
  }
}

// ============================================================
// RESULT CLASSES
// ============================================================

/// Result of Firebase authentication attempt
class AuthResult {
  final bool success;
  final bool cancelled;
  final String? error;
  final String? idToken;
  final String? email;
  final String? phoneNumber;
  final String? displayName;
  final String? photoUrl;
  final bool isNewUser;
  final bool isEmailVerified;

  AuthResult._({
    required this.success,
    this.cancelled = false,
    this.error,
    this.idToken,
    this.email,
    this.phoneNumber,
    this.displayName,
    this.photoUrl,
    this.isNewUser = false,
    this.isEmailVerified = false,
  });

  factory AuthResult.success({
    required String idToken,
    String? email,
    String? phoneNumber,
    String? displayName,
    String? photoUrl,
    bool isNewUser = false,
    bool isEmailVerified = false,
  }) {
    return AuthResult._(
      success: true,
      idToken: idToken,
      email: email,
      phoneNumber: phoneNumber,
      displayName: displayName,
      photoUrl: photoUrl,
      isNewUser: isNewUser,
      isEmailVerified: isEmailVerified,
    );
  }

  factory AuthResult.error(String message) {
    return AuthResult._(success: false, error: message);
  }

  factory AuthResult.cancelled() {
    return AuthResult._(success: false, cancelled: true);
  }
}

/// Result of phone verification attempt
class PhoneVerificationResult {
  final bool success;
  final bool codeSent;
  final bool autoVerified;
  final String? verificationId;
  final String? idToken;
  final String? phoneNumber;
  final String? error;

  PhoneVerificationResult._({
    required this.success,
    this.codeSent = false,
    this.autoVerified = false,
    this.verificationId,
    this.idToken,
    this.phoneNumber,
    this.error,
  });

  factory PhoneVerificationResult.codeSent(String verificationId) {
    return PhoneVerificationResult._(
      success: true,
      codeSent: true,
      verificationId: verificationId,
    );
  }

  factory PhoneVerificationResult.autoVerified({
    required String idToken,
    required String phoneNumber,
  }) {
    return PhoneVerificationResult._(
      success: true,
      autoVerified: true,
      idToken: idToken,
      phoneNumber: phoneNumber,
    );
  }

  factory PhoneVerificationResult.error(String message) {
    return PhoneVerificationResult._(success: false, error: message);
  }
}

/// Helper class for phone verification async handling
class _PhoneVerificationCompleter {
  PhoneVerificationResult? _result;

  Future<PhoneVerificationResult> get future async {
    if (_result != null) return _result!;
    
    return Future.any([
      Future.delayed(const Duration(seconds: 120), () {
        return PhoneVerificationResult.error('Verification timeout');
      }),
      _waitForResult(),
    ]);
  }

  Future<PhoneVerificationResult> _waitForResult() async {
    while (_result == null) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    return _result!;
  }

  void complete(PhoneVerificationResult result) {
    _result = result;
  }
}

/// Role management methods
extension RoleManagement on AuthService {
  /// Add a role to a user
  Future<AuthResponse> addUserRole(int userId, UserRole role) async {
    try {
      final response = await _client.user.addRole(userId: userId, role: role);
      
      if (response.success) {
        return AuthResponse(
          success: true,
          user: response.user,
          message: 'Role added successfully',
        );
      }
      
      return AuthResponse(
        success: false,
        message: response.message,
      );
    } catch (e) {
      debugPrint('[AuthService] Add role error: $e');
      return AuthResponse(
        success: false,
        message: 'Failed to add role: $e',
      );
    }
  }

  /// Remove a role from a user
  Future<AuthResponse> removeUserRole(int userId, UserRole role) async {
    try {
      final response = await _client.user.removeRole(userId: userId, role: role);
      
      if (response.success) {
        return AuthResponse(
          success: true,
          user: response.user,
          message: 'Role removed successfully',
        );
      }
      
      return AuthResponse(
        success: false,
        message: response.message,
      );
    } catch (e) {
      debugPrint('[AuthService] Remove role error: $e');
      return AuthResponse(
        success: false,
        message: 'Failed to remove role: $e',
      );
    }
  }
}
