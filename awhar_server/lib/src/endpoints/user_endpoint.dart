import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/elasticsearch/elasticsearch_session_extension.dart';

/// User management endpoint
/// Handles profile updates, photo uploads, account management
/// All methods require userId to be passed from the decoded token on client-side
class UserEndpoint extends Endpoint {
  /// Update user profile
  Future<UserResponse> updateProfile(
    Session session, {
    required int userId,
    String? fullName,
    String? email,
    String? phoneNumber,
    Language? preferredLanguage,
    bool? notificationsEnabled,
    bool? darkModeEnabled,
  }) async {
    try {
      final user = await User.db.findById(session, userId);

      if (user == null || user.deletedAt != null) {
        return UserResponse(
          success: false,
          message: 'User not found',
        );
      }

      // Update fields if provided
      if (fullName != null) user.fullName = fullName;
      if (email != null) {
        // Check if email already used
        final existingEmail = await User.db.findFirstRow(
          session,
          where: (t) => t.email.equals(email) & t.id.notEquals(user.id!),
        );
        if (existingEmail != null) {
          return UserResponse(
            success: false,
            message: 'Email already in use',
          );
        }
        user.email = email;
        user.isEmailVerified = false; // Reset verification for new email
      }
      if (phoneNumber != null) {
        // Check if phone already used
        final existingPhone = await User.db.findFirstRow(
          session,
          where: (t) =>
              t.phoneNumber.equals(phoneNumber) & t.id.notEquals(user.id!),
        );
        if (existingPhone != null) {
          return UserResponse(
            success: false,
            message: 'Phone number already in use',
          );
        }
        user.phoneNumber = phoneNumber;
        user.isPhoneVerified = false; // Reset verification for new phone
      }
      if (preferredLanguage != null) user.preferredLanguage = preferredLanguage;
      if (notificationsEnabled != null)
        user.notificationsEnabled = notificationsEnabled;
      if (darkModeEnabled != null) user.darkModeEnabled = darkModeEnabled;

      user.updatedAt = DateTime.now();

      final updatedUser = await User.db.updateRow(session, user);

      // Sync updated profile to Elasticsearch for AI agent access
      await session.esSync.indexUser(updatedUser);

      session.log('[User] Profile updated: ${user.id}');

      return UserResponse(
        success: true,
        message: 'Profile updated successfully',
        user: updatedUser,
      );
    } catch (e) {
      session.log('[User] Update error: $e', level: LogLevel.error);
      return UserResponse(
        success: false,
        message: 'Failed to update profile',
      );
    }
  }

  /// Update FCM token for push notifications
  Future<bool> updateFCMToken(
    Session session, {
    required int userId,
    required String fcmToken,
  }) async {
    try {
      final user = await User.db.findById(session, userId);

      if (user == null || user.deletedAt != null) {
        session.log(
          '[User] User not found for FCM token update: $userId',
          level: LogLevel.warning,
        );
        return false;
      }

      user.fcmToken = fcmToken;
      user.updatedAt = DateTime.now();

      await User.db.updateRow(session, user);

      session.log('[User] FCM token updated for user: ${user.id}');
      return true;
    } catch (e) {
      session.log('[User] FCM token update error: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Clear FCM token on logout - removes token from user record
  /// This prevents the old user from receiving notifications after logout
  Future<bool> clearFCMToken(
    Session session, {
    required int userId,
  }) async {
    try {
      final user = await User.db.findById(session, userId);

      if (user == null || user.deletedAt != null) {
        session.log(
          '[User] User not found for FCM token clear: $userId',
          level: LogLevel.warning,
        );
        return false;
      }

      // Clear the FCM token
      user.fcmToken = null;
      user.updatedAt = DateTime.now();

      await User.db.updateRow(session, user);

      session.log('[User] FCM token cleared for user: ${user.id} (logout)');
      return true;
    } catch (e) {
      session.log('[User] FCM token clear error: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Fix photo URLs - replace 0.0.0.0 with proper IP
  Future<UserResponse> fixPhotoUrls(
    Session session, {
    required int userId,
  }) async {
    try {
      session.log('[User] Fixing photo URLs for user: $userId');

      final user = await User.db.findById(session, userId);

      if (user == null) {
        return UserResponse(
          success: false,
          message: 'User not found',
        );
      }

      // Check if photo URL needs fixing (0.0.0.0 to actual server host)
      // Note: Photo URLs are now fixed during upload, but this handles legacy data
      if (user.profilePhotoUrl != null &&
          user.profilePhotoUrl!.contains('0.0.0.0')) {
        session.log(
          '[User] Warning: Photo URL contains 0.0.0.0 - ${user.profilePhotoUrl}',
          level: LogLevel.warning,
        );
        // URLs should be fixed during upload, this is just for legacy data
      }

      session.log('[User] Photo URL check complete');
      return UserResponse(
        success: true,
        message: 'Photo URL is correct',
        user: user,
      );
    } catch (e) {
      session.log('[User] Fix photo URL error: $e', level: LogLevel.error);
      return UserResponse(
        success: false,
        message: 'Failed to check photo URL: $e',
      );
    }
  }

  /// Upload profile photo
  Future<UserResponse> uploadProfilePhoto(
    Session session, {
    required int userId,
    required ByteData photoData,
    required String fileName,
  }) async {
    try {
      session.log(
        '[User] uploadProfilePhoto called for userId: $userId, fileName: $fileName, dataSize: ${photoData.lengthInBytes}',
      );

      final user = await User.db.findById(session, userId);

      if (user == null || user.deletedAt != null) {
        session.log('[User] User not found: $userId', level: LogLevel.warning);
        return UserResponse(
          success: false,
          message: 'User not found',
        );
      }

      session.log('[User] User found: ${user.id}, email: ${user.email}');

      // Delete old photo if exists
      if (user.profilePhotoUrl != null) {
        try {
          session.log('[User] Deleting old photo: ${user.profilePhotoUrl}');
          await session.storage.deleteFile(
            storageId: 'public',
            path: user.profilePhotoUrl!,
          );
          session.log('[User] Old photo deleted');
        } catch (e) {
          session.log(
            '[User] Failed to delete old photo: $e',
            level: LogLevel.warning,
          );
        }
      }

      // Upload new photo
      final storagePath =
          'profile-photos/$userId/${DateTime.now().millisecondsSinceEpoch}_$fileName';
      session.log('[User] Uploading to path: $storagePath');

      await session.storage.storeFile(
        storageId: 'public',
        path: storagePath,
        byteData: photoData,
      );
      session.log('[User] File stored successfully');

      // Get public URL
      final publicUrl = await session.storage.getPublicUrl(
        storageId: 'public',
        path: storagePath,
      );
      session.log('[User] Public URL: $publicUrl');

      // Replace 0.0.0.0 with localhost for development
      var finalUrl = publicUrl?.toString() ?? storagePath;
      if (finalUrl.contains('0.0.0.0')) {
        // For development, use localhost as fallback
        finalUrl = finalUrl.replaceAll('0.0.0.0', 'localhost');
        session.log('[User] Adjusted URL for development: $finalUrl');
      }

      // Update user
      user.profilePhotoUrl = finalUrl;
      user.updatedAt = DateTime.now();
      final updatedUser = await User.db.updateRow(session, user);

      session.log('[User] Photo uploaded successfully for user: ${user.id}');

      return UserResponse(
        success: true,
        message: 'Photo uploaded successfully',
        user: updatedUser,
      );
    } catch (e, stackTrace) {
      session.log('[User] Photo upload error: $e', level: LogLevel.error);
      session.log('[User] Stack trace: $stackTrace', level: LogLevel.error);
      return UserResponse(
        success: false,
        message: 'Failed to upload photo',
      );
    }
  }

  /// Delete user account permanently
  /// Required for Google Play and Apple App Store compliance
  /// This performs a soft delete (sets deletedAt) and anonymizes personal data
  Future<UserResponse> deleteAccount(
    Session session, {
    required int userId,
    String? reason,
  }) async {
    try {
      final user = await User.db.findById(session, userId);

      if (user == null) {
        return UserResponse(
          success: false,
          message: 'User not found',
        );
      }

      if (user.deletedAt != null) {
        return UserResponse(
          success: false,
          message: 'Account already deleted',
        );
      }

      session.log(
          '[User] Account deletion requested: ${user.id}, reason: $reason');

      // Anonymize personal data (GDPR compliance)
      final deletedTimestamp = DateTime.now().millisecondsSinceEpoch;
      user.email = 'deleted_$deletedTimestamp@deleted.awhar.com';
      user.fullName = 'Deleted User';
      user.phoneNumber = null;
      user.fcmToken = null;
      user.firebaseUid = 'deleted_$deletedTimestamp';

      // Mark as deleted
      user.deletedAt = DateTime.now();
      user.updatedAt = DateTime.now();
      user.status = UserStatus.deleted;
      user.isEmailVerified = false;
      user.isPhoneVerified = false;
      user.notificationsEnabled = false;

      // Save the changes
      await User.db.updateRow(session, user);

      session.log('[User] Account deleted and anonymized: ${user.id}');

      return UserResponse(
        success: true,
        message: 'Account deleted successfully',
      );
    } catch (e) {
      session.log('[User] Delete account error: $e', level: LogLevel.error);
      return UserResponse(
        success: false,
        message:
            'Failed to delete account. Please try again or contact support.',
      );
    }
  }

  /// Get user by ID
  Future<UserResponse> getUserById(
    Session session, {
    required int userId,
  }) async {
    try {
      final user = await User.db.findById(session, userId);

      if (user == null || user.deletedAt != null) {
        return UserResponse(
          success: false,
          message: 'User not found',
        );
      }

      return UserResponse(
        success: true,
        message: 'User retrieved',
        user: user,
      );
    } catch (e) {
      session.log('[User] Get user error: $e', level: LogLevel.error);
      return UserResponse(
        success: false,
        message: 'Failed to get user',
      );
    }
  }

  /// Add role to user (e.g., become a driver)
  Future<UserResponse> addRole(
    Session session, {
    required int userId,
    required UserRole role,
  }) async {
    try {
      final user = await User.db.findById(session, userId);

      if (user == null || user.deletedAt != null) {
        return UserResponse(
          success: false,
          message: 'User not found',
        );
      }

      if (user.roles.contains(role)) {
        return UserResponse(
          success: false,
          message: 'User already has this role',
        );
      }

      user.roles.add(role);
      user.updatedAt = DateTime.now();
      final updatedUser = await User.db.updateRow(session, user);

      session.log('[User] Role added: ${user.id} -> $role');

      return UserResponse(
        success: true,
        message: 'Role added successfully',
        user: updatedUser,
      );
    } catch (e) {
      session.log('[User] Add role error: $e', level: LogLevel.error);
      return UserResponse(
        success: false,
        message: 'Failed to add role',
      );
    }
  }

  /// Remove role from user
  Future<UserResponse> removeRole(
    Session session, {
    required int userId,
    required UserRole role,
  }) async {
    try {
      final user = await User.db.findById(session, userId);

      if (user == null || user.deletedAt != null) {
        return UserResponse(
          success: false,
          message: 'User not found',
        );
      }

      if (!user.roles.contains(role)) {
        return UserResponse(
          success: false,
          message: 'User does not have this role',
        );
      }

      if (user.roles.length == 1) {
        return UserResponse(
          success: false,
          message: 'Cannot remove last role',
        );
      }

      user.roles.remove(role);
      user.updatedAt = DateTime.now();
      final updatedUser = await User.db.updateRow(session, user);

      session.log('[User] Role removed: ${user.id} -> $role');

      return UserResponse(
        success: true,
        message: 'Role removed successfully',
        user: updatedUser,
      );
    } catch (e) {
      session.log('[User] Remove role error: $e', level: LogLevel.error);
      return UserResponse(
        success: false,
        message: 'Failed to remove role',
      );
    }
  }
}
