import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../generated/transaction.dart' as tx;

/// Admin authentication and management endpoint
/// Supports standalone admin login with password
class AdminEndpoint extends Endpoint {
  
  // ========== AUTHENTICATION ==========
  
  /// Admin login with email and password
  Future<AdminLoginResponse> login(
    Session session, {
    required String email,
    required String firebaseUid, // Keep for backward compatibility, ignored for password login
    String? password,
  }) async {
    try {
      final trimmedEmail = email.toLowerCase().trim();
      session.log('[Admin] Login attempt: $trimmedEmail');

      // Find admin by email
      final admin = await AdminUser.db.findFirstRow(
        session,
        where: (t) => t.email.equals(trimmedEmail),
      );

      if (admin == null) {
        session.log('[Admin] Admin not found: $trimmedEmail', level: LogLevel.warning);
        return AdminLoginResponse(
          success: false,
          message: 'Invalid email or password',
        );
      }

      // Check if account is locked
      if (admin.lockedUntil != null && DateTime.now().isBefore(admin.lockedUntil!)) {
        return AdminLoginResponse(
          success: false,
          message: 'Account is locked. Try again later.',
        );
      }

      // Check if account is active
      if (!admin.isActive) {
        return AdminLoginResponse(
          success: false,
          message: 'Account is deactivated',
        );
      }

      // Verify password
      if (password != null && password.isNotEmpty) {
        final passwordHash = _hashPassword(password);
        if (admin.passwordHash != passwordHash) {
          // Increment failed attempts
          await AdminUser.db.updateRow(
            session,
            admin.copyWith(
              failedLoginAttempts: admin.failedLoginAttempts + 1,
              lockedUntil: admin.failedLoginAttempts >= 4 
                  ? DateTime.now().add(const Duration(minutes: 15)) 
                  : null,
            ),
          );
          
          session.log('[Admin] Invalid password: $trimmedEmail', level: LogLevel.warning);
          return AdminLoginResponse(
            success: false,
            message: 'Invalid email or password',
          );
        }
      } else {
        // For backward compatibility with Firebase login, check if it's a dev token
        if (firebaseUid != 'dev_admin_uid') {
          return AdminLoginResponse(
            success: false,
            message: 'Password is required',
          );
        }
      }

      // Generate admin session token
      final token = _generateSessionToken();
      final expiresAt = DateTime.now().add(const Duration(hours: 24));

      // Update last login info and reset failed attempts
      await AdminUser.db.updateRow(
        session,
        admin.copyWith(
          lastLoginAt: DateTime.now(),
          failedLoginAttempts: 0,
          lockedUntil: null,
          updatedAt: DateTime.now(),
        ),
      );

      session.log('[Admin] Login successful: $trimmedEmail');

      return AdminLoginResponse(
        success: true,
        message: 'Login successful',
        token: token,
        expiresAt: expiresAt,
        adminId: admin.id,
        adminEmail: admin.email,
        adminName: admin.name,
        adminPhotoUrl: admin.photoUrl,
        adminRole: admin.role,
      );
    } catch (e) {
      session.log('[Admin] Login error: $e', level: LogLevel.error);
      return AdminLoginResponse(
        success: false,
        message: 'An error occurred during login',
      );
    }
  }

  /// Login with password (new method without Firebase dependency)
  Future<AdminLoginResponse> loginWithPassword(
    Session session, {
    required String email,
    required String password,
  }) async {
    return login(session, email: email, firebaseUid: '', password: password);
  }

  /// Change admin password
  Future<bool> changePassword(
    Session session, {
    required int adminId,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final admin = await AdminUser.db.findById(session, adminId);
      if (admin == null) return false;

      // Verify current password
      final currentHash = _hashPassword(currentPassword);
      if (admin.passwordHash != currentHash) {
        session.log('[Admin] Invalid current password for admin: $adminId', level: LogLevel.warning);
        return false;
      }

      // Validate new password
      if (newPassword.length < 8) {
        session.log('[Admin] New password too short', level: LogLevel.warning);
        return false;
      }

      // Update password
      final newHash = _hashPassword(newPassword);
      await AdminUser.db.updateRow(
        session,
        admin.copyWith(
          passwordHash: newHash,
          updatedAt: DateTime.now(),
        ),
      );

      session.log('[Admin] Password changed for admin: $adminId');
      return true;
    } catch (e) {
      session.log('[Admin] Error changing password: $e', level: LogLevel.error);
      return false;
    }
  }

  // ========== ADMIN USER MANAGEMENT ==========

  /// Get all admin users
  Future<List<AdminUser>> getAllAdmins(Session session) async {
    try {
      return await AdminUser.db.find(
        session,
        orderBy: (t) => t.createdAt,
        orderDescending: true,
      );
    } catch (e) {
      session.log('[Admin] Error getting admins: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get admin by ID
  Future<AdminUser?> getAdmin(Session session, {required int adminId}) async {
    try {
      return await AdminUser.db.findById(session, adminId);
    } catch (e) {
      session.log('[Admin] Error getting admin: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Create new admin user
  Future<AdminUser?> createAdmin(
    Session session, {
    required String email,
    required String password,
    required String name,
    String? photoUrl,
    String role = 'admin',
    List<String>? permissions,
    int? createdBy,
  }) async {
    try {
      // Check if email already exists
      final existing = await AdminUser.db.findFirstRow(
        session,
        where: (t) => t.email.equals(email.toLowerCase().trim()),
      );
      if (existing != null) {
        session.log('[Admin] Email already exists: $email', level: LogLevel.warning);
        return null;
      }

      // Validate password
      if (password.length < 8) {
        session.log('[Admin] Password too short', level: LogLevel.warning);
        return null;
      }

      final passwordHash = _hashPassword(password);
      final now = DateTime.now();

      final admin = AdminUser(
        email: email.toLowerCase().trim(),
        passwordHash: passwordHash,
        name: name,
        photoUrl: photoUrl,
        role: role,
        permissions: permissions,
        isActive: true,
        failedLoginAttempts: 0,
        createdAt: now,
        updatedAt: now,
        createdBy: createdBy,
      );

      final created = await AdminUser.db.insertRow(session, admin);
      session.log('[Admin] Admin created: ${created.email}');
      return created;
    } catch (e) {
      session.log('[Admin] Error creating admin: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Update admin user
  Future<AdminUser?> updateAdmin(
    Session session, {
    required int adminId,
    String? email,
    String? name,
    String? photoUrl,
    String? role,
    List<String>? permissions,
    bool? isActive,
  }) async {
    try {
      final admin = await AdminUser.db.findById(session, adminId);
      if (admin == null) return null;

      // Check if email is being changed and if it's already taken
      if (email != null && email.toLowerCase().trim() != admin.email) {
        final existing = await AdminUser.db.findFirstRow(
          session,
          where: (t) => t.email.equals(email.toLowerCase().trim()),
        );
        if (existing != null) {
          session.log('[Admin] Email already taken: $email', level: LogLevel.warning);
          return null;
        }
      }

      final updated = admin.copyWith(
        email: email?.toLowerCase().trim() ?? admin.email,
        name: name ?? admin.name,
        photoUrl: photoUrl ?? admin.photoUrl,
        role: role ?? admin.role,
        permissions: permissions ?? admin.permissions,
        isActive: isActive ?? admin.isActive,
        updatedAt: DateTime.now(),
      );

      await AdminUser.db.updateRow(session, updated);
      session.log('[Admin] Admin updated: $adminId');
      return updated;
    } catch (e) {
      session.log('[Admin] Error updating admin: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Reset admin password (by another admin)
  Future<bool> resetAdminPassword(
    Session session, {
    required int adminId,
    required String newPassword,
  }) async {
    try {
      final admin = await AdminUser.db.findById(session, adminId);
      if (admin == null) return false;

      if (newPassword.length < 8) {
        session.log('[Admin] New password too short', level: LogLevel.warning);
        return false;
      }

      final newHash = _hashPassword(newPassword);
      await AdminUser.db.updateRow(
        session,
        admin.copyWith(
          passwordHash: newHash,
          failedLoginAttempts: 0,
          lockedUntil: null,
          updatedAt: DateTime.now(),
        ),
      );

      session.log('[Admin] Password reset for admin: $adminId');
      return true;
    } catch (e) {
      session.log('[Admin] Error resetting password: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Delete admin user
  Future<bool> deleteAdmin(Session session, {required int adminId}) async {
    try {
      final admin = await AdminUser.db.findById(session, adminId);
      if (admin == null) return false;

      // Prevent deleting super_admin
      if (admin.role == 'super_admin') {
        // Check if there's another super_admin
        final superAdmins = await AdminUser.db.find(
          session,
          where: (t) => t.role.equals('super_admin'),
        );
        if (superAdmins.length <= 1) {
          session.log('[Admin] Cannot delete the last super_admin', level: LogLevel.warning);
          return false;
        }
      }

      await AdminUser.db.deleteRow(session, admin);
      session.log('[Admin] Admin deleted: $adminId');
      return true;
    } catch (e) {
      session.log('[Admin] Error deleting admin: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Toggle admin active status
  Future<bool> toggleAdminStatus(Session session, {required int adminId}) async {
    try {
      final admin = await AdminUser.db.findById(session, adminId);
      if (admin == null) return false;

      await AdminUser.db.updateRow(
        session,
        admin.copyWith(
          isActive: !admin.isActive,
          updatedAt: DateTime.now(),
        ),
      );

      session.log('[Admin] Admin status toggled: $adminId -> ${!admin.isActive}');
      return true;
    } catch (e) {
      session.log('[Admin] Error toggling admin status: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Get current admin profile
  Future<AdminUser?> getProfile(Session session, {required int adminId}) async {
    return getAdmin(session, adminId: adminId);
  }

  /// Update current admin profile
  Future<AdminUser?> updateProfile(
    Session session, {
    required int adminId,
    String? name,
    String? photoUrl,
  }) async {
    return updateAdmin(
      session,
      adminId: adminId,
      name: name,
      photoUrl: photoUrl,
    );
  }

  // ========== HELPER METHODS ==========

  /// Hash password using SHA256
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Get dashboard statistics
  Future<DashboardStats> getDashboardStats(Session session) async {
    try {
      // Count users
      final totalUsers = await User.db.count(session);
      
      // Count drivers
      final totalDrivers = await DriverProfile.db.count(session);
      final onlineDrivers = await DriverProfile.db.count(
        session,
        where: (t) => t.isOnline.equals(true),
      );

      // Count clients (users that are not drivers)
      final totalClients = totalUsers - totalDrivers;

      // Count stores
      final totalStores = await Store.db.count(session);
      final activeStores = await Store.db.count(
        session,
        where: (t) => t.isActive.equals(true),
      );

      // Count requests
      final totalRequests = await ServiceRequest.db.count(session);
      final pendingRequests = await ServiceRequest.db.count(
        session,
        where: (t) => t.status.equals(RequestStatus.pending),
      );
      final completedRequests = await ServiceRequest.db.count(
        session,
        where: (t) => t.status.equals(RequestStatus.completed),
      );

      // Count orders
      final totalOrders = await StoreOrder.db.count(session);
      final pendingOrders = await StoreOrder.db.count(
        session,
        where: (t) => t.status.equals(StoreOrderStatus.pending),
      );

      // Count reports
      final pendingReports = await Report.db.count(
        session,
        where: (t) => t.status.equals(ReportStatus.pending),
      );

      // Calculate revenue (from completed transactions)
      final transactions = await tx.Transaction.db.find(
        session,
        where: (t) => t.status.equals(TransactionStatus.completed),
      );
      double totalRevenue = 0;
      double totalCommission = 0;
      for (final trans in transactions) {
        totalRevenue += trans.amount;
        totalCommission += trans.platformCommission;
      }

      return DashboardStats(
        totalUsers: totalUsers,
        totalDrivers: totalDrivers,
        onlineDrivers: onlineDrivers,
        totalClients: totalClients,
        totalStores: totalStores,
        activeStores: activeStores,
        totalRequests: totalRequests,
        pendingRequests: pendingRequests,
        completedRequests: completedRequests,
        totalOrders: totalOrders,
        pendingOrders: pendingOrders,
        pendingReports: pendingReports,
        totalRevenue: totalRevenue,
        totalCommission: totalCommission,
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      session.log('[Admin] Error getting dashboard stats: $e', level: LogLevel.error);
      return DashboardStats(
        totalUsers: 0,
        totalDrivers: 0,
        onlineDrivers: 0,
        totalClients: 0,
        totalStores: 0,
        activeStores: 0,
        totalRequests: 0,
        pendingRequests: 0,
        completedRequests: 0,
        totalOrders: 0,
        pendingOrders: 0,
        pendingReports: 0,
        totalRevenue: 0,
        totalCommission: 0,
        updatedAt: DateTime.now(),
      );
    }
  }

  /// Get total user count
  Future<int> getUserCount(Session session) async {
    try {
      return await User.db.count(session);
    } catch (e) {
      session.log('[Admin] Error getting user count: $e', level: LogLevel.error);
      return 0;
    }
  }

  /// List all users with pagination and filters
  Future<List<User>> listUsers(
    Session session, {
    int page = 1,
    int limit = 20,
    String? search,
    String? role,
    String? status,
  }) async {
    try {
      final offset = (page - 1) * limit;

      // Build query with filters
      if (search != null && search.isNotEmpty) {
        return await User.db.find(
          session,
          where: (t) =>
              t.fullName.ilike('%$search%') |
              t.email.ilike('%$search%') |
              t.phoneNumber.ilike('%$search%'),
          orderBy: (t) => t.createdAt,
          orderDescending: true,
          limit: limit,
          offset: offset,
        );
      }

      return await User.db.find(
        session,
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      session.log('[Admin] Error listing users: $e', level: LogLevel.error);
      return [];
    }
  }

  /// List all drivers with pagination
  Future<List<DriverProfile>> listDrivers(
    Session session, {
    int page = 1,
    int limit = 20,
    String? search,
    bool? onlineOnly,
    bool? verifiedOnly,
  }) async {
    try {
      final offset = (page - 1) * limit;

      var results = await DriverProfile.db.find(
        session,
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );

      if (onlineOnly == true) {
        results = await DriverProfile.db.find(
          session,
          where: (t) => t.isOnline.equals(true),
          orderBy: (t) => t.createdAt,
          orderDescending: true,
          limit: limit,
          offset: offset,
        );
      }

      if (verifiedOnly == true) {
        results = await DriverProfile.db.find(
          session,
          where: (t) => t.isVerified.equals(true),
          orderBy: (t) => t.createdAt,
          orderDescending: true,
          limit: limit,
          offset: offset,
        );
      }

      return results;
    } catch (e) {
      session.log('[Admin] Error listing drivers: $e', level: LogLevel.error);
      return [];
    }
  }

  /// List all stores with pagination
  Future<List<Store>> listStores(
    Session session, {
    int page = 1,
    int limit = 20,
    String? search,
    bool? activeOnly,
  }) async {
    try {
      final offset = (page - 1) * limit;

      if (activeOnly == true) {
        return await Store.db.find(
          session,
          where: (t) => t.isActive.equals(true),
          orderBy: (t) => t.createdAt,
          orderDescending: true,
          limit: limit,
          offset: offset,
        );
      }

      return await Store.db.find(
        session,
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      session.log('[Admin] Error listing stores: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get total store count
  Future<int> getStoreCount(Session session) async {
    try {
      final stores = await Store.db.find(session);
      return stores.length;
    } catch (e) {
      session.log('[Admin] Error getting store count: $e', level: LogLevel.error);
      return 0;
    }
  }

  /// Activate a store
  Future<bool> activateStore(Session session, int storeId) async {
    try {
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        session.log('[Admin] Store not found: $storeId', level: LogLevel.warning);
        return false;
      }

      store.isActive = true;
      store.updatedAt = DateTime.now();
      await Store.db.updateRow(session, store);

      session.log('[Admin] Store activated: $storeId');
      return true;
    } catch (e) {
      session.log('[Admin] Error activating store: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Deactivate a store
  Future<bool> deactivateStore(Session session, {
    required int storeId,
    String? reason,
  }) async {
    try {
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        session.log('[Admin] Store not found: $storeId', level: LogLevel.warning);
        return false;
      }

      store.isActive = false;
      store.updatedAt = DateTime.now();
      await Store.db.updateRow(session, store);

      session.log('[Admin] Store deactivated: $storeId (reason: $reason)');
      return true;
    } catch (e) {
      session.log('[Admin] Error deactivating store: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Delete a store permanently
  Future<bool> deleteStore(Session session, int storeId) async {
    try {
      final store = await Store.db.findById(session, storeId);
      if (store == null) {
        session.log('[Admin] Store not found: $storeId', level: LogLevel.warning);
        return false;
      }

      await Store.db.deleteRow(session, store);
      session.log('[Admin] Store deleted: $storeId');
      return true;
    } catch (e) {
      session.log('[Admin] Error deleting store: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Suspend a user
  Future<bool> suspendUser(
    Session session, {
    required int userId,
    String? reason,
    DateTime? suspendUntil,
  }) async {
    try {
      final user = await User.db.findById(session, userId);
      if (user == null) return false;

      user.isSuspended = true;
      user.suspendedUntil = suspendUntil;
      user.suspensionReason = reason;
      user.updatedAt = DateTime.now();

      await User.db.updateRow(session, user);
      session.log('[Admin] User suspended: $userId');
      return true;
    } catch (e) {
      session.log('[Admin] Error suspending user: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Unsuspend a user
  Future<bool> unsuspendUser(Session session, int userId) async {
    try {
      final user = await User.db.findById(session, userId);
      if (user == null) return false;

      user.isSuspended = false;
      user.suspendedUntil = null;
      user.suspensionReason = null;
      user.updatedAt = DateTime.now();

      await User.db.updateRow(session, user);
      session.log('[Admin] User unsuspended: $userId');
      return true;
    } catch (e) {
      session.log('[Admin] Error unsuspending user: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Ban a user (permanent suspension)
  Future<bool> banUser(
    Session session, {
    required int userId,
    String? reason,
  }) async {
    try {
      final user = await User.db.findById(session, userId);
      if (user == null) return false;

      // Ban is a permanent suspension (set far future date)
      user.isSuspended = true;
      user.suspendedUntil = DateTime(2100, 1, 1); // Effectively permanent
      user.suspensionReason = reason ?? 'Banned by admin';
      user.updatedAt = DateTime.now();

      await User.db.updateRow(session, user);
      session.log('[Admin] User banned: $userId');
      return true;
    } catch (e) {
      session.log('[Admin] Error banning user: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Delete a user
  Future<bool> deleteUser(Session session, int userId) async {
    try {
      final user = await User.db.findById(session, userId);
      if (user == null) return false;

      await User.db.deleteRow(session, user);
      session.log('[Admin] User deleted: $userId');
      return true;
    } catch (e) {
      session.log('[Admin] Error deleting user: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Verify a driver
  Future<bool> verifyDriver(Session session, int driverId) async {
    try {
      final driver = await DriverProfile.db.findById(session, driverId);
      if (driver == null) return false;

      driver.isVerified = true;
      driver.verifiedAt = DateTime.now();
      driver.updatedAt = DateTime.now();

      await DriverProfile.db.updateRow(session, driver);
      session.log('[Admin] Driver verified: $driverId');
      return true;
    } catch (e) {
      session.log('[Admin] Error verifying driver: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Create an admin user
  Future<User?> createAdminUser(
    Session session, {
    required String firebaseUid,
    required String email,
    required String fullName,
  }) async {
    try {
      // Check if Firebase UID already exists
      final existing = await User.db.findFirstRow(
        session,
        where: (t) => t.firebaseUid.equals(firebaseUid),
      );

      if (existing != null) {
        // Update existing user to have admin role
        if (!existing.roles.contains(UserRole.admin)) {
          existing.roles.add(UserRole.admin);
          existing.updatedAt = DateTime.now();
          await User.db.updateRow(session, existing);
          session.log('[Admin] Admin role added to existing user: $email');
        }
        return existing;
      }

      final user = User(
        firebaseUid: firebaseUid,
        email: email.toLowerCase().trim(),
        fullName: fullName,
        roles: [UserRole.admin],
        isEmailVerified: true,
        isPhoneVerified: false,
        notificationsEnabled: true,
        darkModeEnabled: false,
        preferredLanguage: Language.en,
        isSuspended: false,
        totalReportsMade: 0,
        totalReportsReceived: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final savedUser = await User.db.insertRow(session, user);
      session.log('[Admin] Admin user created: $email');
      return savedUser;
    } catch (e) {
      session.log('[Admin] Error creating admin user: $e', level: LogLevel.error);
      return null;
    }
  }

  /// Get total driver count
  Future<int> getDriverCount(Session session) async {
    try {
      final drivers = await DriverProfile.db.find(session);
      return drivers.length;
    } catch (e) {
      session.log('[Admin] Error getting driver count: $e', level: LogLevel.error);
      return 0;
    }
  }

  /// Unverify a driver
  Future<bool> unverifyDriver(Session session, int driverId) async {
    try {
      final driver = await DriverProfile.db.findById(session, driverId);
      if (driver == null) {
        session.log('[Admin] Driver not found: $driverId', level: LogLevel.warning);
        return false;
      }

      driver.isVerified = false;
      await DriverProfile.db.updateRow(session, driver);

      session.log('[Admin] Driver unverified: $driverId');
      return true;
    } catch (e) {
      session.log('[Admin] Error unverifying driver: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Suspend a driver (Note: DriverProfile doesn't have suspension fields, so we just log it)
  Future<bool> suspendDriver(Session session, {
    required int driverId,
    String? reason,
  }) async {
    try {
      final driver = await DriverProfile.db.findById(session, driverId);
      if (driver == null) {
        session.log('[Admin] Driver not found: $driverId', level: LogLevel.warning);
        return false;
      }

      // TODO: Add suspension fields to DriverProfile model
      // For now, just log the suspension
      session.log('[Admin] Driver suspension requested: $driverId (reason: $reason)');
      session.log('[Admin] Note: DriverProfile needs suspension fields (isSuspended, suspensionReason, suspendedUntil)', level: LogLevel.warning);
      return true;
    } catch (e) {
      session.log('[Admin] Error suspending driver: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Delete a driver permanently
  Future<bool> deleteDriver(Session session, int driverId) async {
    try {
      final driver = await DriverProfile.db.findById(session, driverId);
      if (driver == null) {
        session.log('[Admin] Driver not found: $driverId', level: LogLevel.warning);
        return false;
      }

      await DriverProfile.db.deleteRow(session, driver);
      session.log('[Admin] Driver deleted: $driverId');
      return true;
    } catch (e) {
      session.log('[Admin] Error deleting driver: $e', level: LogLevel.error);
      return false;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Orders Management
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get total order count
  Future<int> getOrderCount(Session session) async {
    try {
      final orders = await StoreOrder.db.find(session);
      return orders.length;
    } catch (e) {
      session.log('[Admin] Error getting order count: $e', level: LogLevel.error);
      return 0;
    }
  }

  /// List all store orders with pagination
  Future<List<StoreOrder>> listOrders(
    Session session, {
    int page = 1,
    int limit = 20,
    StoreOrderStatus? statusFilter,
  }) async {
    try {
      final offset = (page - 1) * limit;

      if (statusFilter != null) {
        return await StoreOrder.db.find(
          session,
          where: (t) => t.status.equals(statusFilter),
          orderBy: (t) => t.createdAt,
          orderDescending: true,
          limit: limit,
          offset: offset,
        );
      }

      return await StoreOrder.db.find(
        session,
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      session.log('[Admin] Error listing orders: $e', level: LogLevel.error);
      return [];
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Service Requests Management
  // ═══════════════════════════════════════════════════════════════════════════

  /// List all service requests with pagination
  Future<List<ServiceRequest>> listRequests(
    Session session, {
    int page = 1,
    int limit = 20,
    RequestStatus? statusFilter,
  }) async {
    try {
      final offset = (page - 1) * limit;

      if (statusFilter != null) {
        return await ServiceRequest.db.find(
          session,
          where: (t) => t.status.equals(statusFilter),
          orderBy: (t) => t.createdAt,
          orderDescending: true,
          limit: limit,
          offset: offset,
        );
      }

      return await ServiceRequest.db.find(
        session,
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      session.log('[Admin] Error listing requests: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Get total service request count
  Future<int> getRequestCount(
    Session session, {
    RequestStatus? statusFilter,
  }) async {
    try {
      if (statusFilter != null) {
        return await ServiceRequest.db.count(
          session,
          where: (t) => t.status.equals(statusFilter),
        );
      }
      return await ServiceRequest.db.count(session);
    } catch (e) {
      session.log('[Admin] Error getting request count: $e', level: LogLevel.error);
      return 0;
    }
  }

  /// Update request status
  Future<ServiceRequest?> updateRequestStatus(
    Session session,
    int requestId,
    RequestStatus status, {
    String? note,
  }) async {
    try {
      final request = await ServiceRequest.db.findById(session, requestId);
      if (request == null) return null;

      request.status = status;
      final now = DateTime.now();

      switch (status) {
        case RequestStatus.accepted:
          request.acceptedAt ??= now;
          break;
        case RequestStatus.driver_arriving:
          request.driverArrivingAt ??= now;
          break;
        case RequestStatus.in_progress:
          request.startedAt ??= now;
          break;
        case RequestStatus.completed:
          request.completedAt ??= now;
          break;
        case RequestStatus.cancelled:
          request.cancelledAt ??= now;
          if (note != null && note.isNotEmpty) {
            request.cancellationReason = note;
          }
          break;
        default:
          break;
      }

      if (status != RequestStatus.cancelled && note != null && note.isNotEmpty) {
        request.notes = note;
      }

      return await ServiceRequest.db.updateRow(session, request);
    } catch (e) {
      session.log('[Admin] Error updating request status: $e', level: LogLevel.error);
      return null;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Transactions Management
  // ═══════════════════════════════════════════════════════════════════════════

  /// List all transactions with pagination
  Future<List<tx.Transaction>> listTransactions(
    Session session, {
    int page = 1,
    int limit = 20,
    TransactionStatus? statusFilter,
  }) async {
    try {
      final offset = (page - 1) * limit;

      if (statusFilter != null) {
        return await tx.Transaction.db.find(
          session,
          where: (t) => t.status.equals(statusFilter),
          orderBy: (t) => t.createdAt,
          orderDescending: true,
          limit: limit,
          offset: offset,
        );
      }

      return await tx.Transaction.db.find(
        session,
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      session.log('[Admin] Error listing transactions: $e', level: LogLevel.error);
      return [];
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Reports Management
  // ═══════════════════════════════════════════════════════════════════════════

  /// List all reports with pagination
  Future<List<Report>> listReports(
    Session session, {
    int page = 1,
    int limit = 20,
    ReportStatus? statusFilter,
  }) async {
    try {
      final offset = (page - 1) * limit;

      if (statusFilter != null) {
        return await Report.db.find(
          session,
          where: (t) => t.status.equals(statusFilter),
          orderBy: (t) => t.createdAt,
          orderDescending: true,
          limit: limit,
          offset: offset,
        );
      }

      return await Report.db.find(
        session,
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      session.log('[Admin] Error listing reports: $e', level: LogLevel.error);
      return [];
    }
  }

  /// Resolve a report
  Future<bool> resolveReport(
    Session session, {
    required int reportId,
    required ReportResolution resolution,
    String? adminNotes,
  }) async {
    try {
      final report = await Report.db.findById(session, reportId);
      if (report == null) return false;

      report.status = ReportStatus.resolved;
      report.resolution = resolution;
      report.adminNotes = adminNotes;
      report.resolvedAt = DateTime.now();

      await Report.db.updateRow(session, report);
      session.log('[Admin] Report resolved: $reportId');
      return true;
    } catch (e) {
      session.log('[Admin] Error resolving report: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Get recent platform activities
  Future<List<RecentActivity>> getRecentActivities(Session session, {int limit = 10}) async {
    session.log('[Admin] Starting getRecentActivities with limit: $limit');
    
    try {
      final activities = <RecentActivity>[];
      
      // Get recent user registrations
      try {
        session.log('[Admin] Querying recent users...');
        final recentUsers = await User.db.find(
          session,
          orderBy: (t) => t.createdAt,
          orderDescending: true,
          limit: 3,
        );
        session.log('[Admin] Found ${recentUsers.length} recent users');
        
        for (final user in recentUsers) {
          if (user.id != null) {
            final hasDriverRole = user.roles.contains(UserRole.driver);
            activities.add(RecentActivity(
              activityType: 'user_registration',
              title: 'New User Registration',
              description: '${user.fullName} joined as ${hasDriverRole ? 'Driver' : 'Client'}',
              relatedId: user.id,
              relatedType: 'user',
              createdAt: user.createdAt,
            ));
          }
        }
      } catch (e) {
        session.log('[Admin] Error querying users: $e', level: LogLevel.warning);
      }
      
      // Get recent store orders
      try {
        session.log('[Admin] Querying recent store orders...');
        final recentOrders = await StoreOrder.db.find(
          session,
          orderBy: (t) => t.createdAt,
          orderDescending: true,
          limit: 3,
        );
        session.log('[Admin] Found ${recentOrders.length} recent orders');
        
        for (final order in recentOrders) {
          if (order.id != null) {
            String statusText = 'placed';
            String activityType = 'order_placed';
            
            if (order.status == StoreOrderStatus.delivered) {
              statusText = 'completed';
              activityType = 'order_completed';
            } else if (order.status == StoreOrderStatus.cancelled) {
              statusText = 'cancelled';
            } else if (order.status == StoreOrderStatus.inDelivery) {
              statusText = 'in delivery';
            }
            
            activities.add(RecentActivity(
              activityType: activityType,
              title: activityType == 'order_completed' ? 'Order Completed' : 'New Order Placed',
              description: 'Order #${order.orderNumber} - $statusText',
              relatedId: order.id,
              relatedType: 'store_order',
              createdAt: order.deliveredAt ?? order.createdAt,
            ));
          }
        }
      } catch (e) {
        session.log('[Admin] Error querying orders: $e', level: LogLevel.warning);
      }
      
      // Get recent ratings
      try {
        session.log('[Admin] Querying recent ratings...');
        final recentRatings = await Rating.db.find(
          session,
          orderBy: (t) => t.createdAt,
          orderDescending: true,
          limit: 2,
        );
        session.log('[Admin] Found ${recentRatings.length} recent ratings');
        
        for (final rating in recentRatings) {
          if (rating.id != null) {
            activities.add(RecentActivity(
              activityType: 'new_rating',
              title: 'New Review',
              description: '${rating.ratingValue}-star rating received',
              relatedId: rating.id,
              relatedType: 'rating',
              createdAt: rating.createdAt,
            ));
          }
        }
      } catch (e) {
        session.log('[Admin] Error querying ratings: $e', level: LogLevel.warning);
      }
      
      // Get recent transactions
      try {
        session.log('[Admin] Querying recent transactions...');
        final recentTransactions = await tx.Transaction.db.find(
          session,
          orderBy: (t) => t.createdAt,
          orderDescending: true,
          limit: 2,
        );
        session.log('[Admin] Found ${recentTransactions.length} recent transactions');
        
        for (final transaction in recentTransactions) {
          if (transaction.id != null && transaction.status == TransactionStatus.completed) {
            activities.add(RecentActivity(
              activityType: 'payment_processed',
              title: 'Payment Processed',
              description: '${transaction.amount.toStringAsFixed(2)} MAD ${transaction.type == TransactionType.earning ? 'earned' : 'processed'}',
              relatedId: transaction.id,
              relatedType: 'transaction',
              createdAt: transaction.createdAt,
            ));
          }
        }
      } catch (e) {
        session.log('[Admin] Error querying transactions: $e', level: LogLevel.warning);
      }
      
      // Sort all activities by date and limit
      activities.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      
      final result = activities.take(limit).toList();
      session.log('[Admin] Returning ${result.length} recent activities');
      return result;
    } catch (e, stackTrace) {
      session.log('[Admin] Error getting recent activities: $e\n$stackTrace', level: LogLevel.error);
      return [];
    }
  }

  /// Dismiss a report
  Future<bool> dismissReport(
    Session session, {
    required int reportId,
    String? reason,
  }) async {
    try {
      final report = await Report.db.findById(session, reportId);
      if (report == null) return false;

      report.status = ReportStatus.dismissed;
      report.resolution = ReportResolution.dismissed;
      report.adminNotes = reason ?? 'Report dismissed by admin';
      report.resolvedAt = DateTime.now();

      await Report.db.updateRow(session, report);
      session.log('[Admin] Report dismissed: $reportId');
      return true;
    } catch (e) {
      session.log('[Admin] Error dismissing report: $e', level: LogLevel.error);
      return false;
    }
  }

  String _generateSessionToken() {
    final random = Random.secure();
    final values = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }
}