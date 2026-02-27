import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Endpoint for managing blocked users
class BlockedUserEndpoint extends Endpoint {
  /// Block a user
  Future<BlockedUser?> blockUser(
    Session session, {
    required int userId,
    required int blockedUserId,
    String? reason,
  }) async {
    // Check if already blocked
    final existing = await BlockedUser.db.findFirstRow(
      session,
      where: (t) => (t.userId.equals(userId) & t.blockedUserId.equals(blockedUserId)),
    );

    if (existing != null) {
      return existing; // Already blocked
    }

    // Create block record
    final blockedUser = BlockedUser(
      userId: userId,
      blockedUserId: blockedUserId,
      reason: reason,
      createdAt: DateTime.now(),
    );

    return await BlockedUser.db.insertRow(session, blockedUser);
  }

  /// Unblock a user
  Future<bool> unblockUser(
    Session session, {
    required int userId,
    required int blockedUserId,
  }) async {
    final existing = await BlockedUser.db.findFirstRow(
      session,
      where: (t) => (t.userId.equals(userId) & t.blockedUserId.equals(blockedUserId)),
    );

    if (existing == null) {
      return true; // Not blocked
    }

    await BlockedUser.db.deleteRow(session, existing);
    return true;
  }

  /// Get list of blocked users for a user
  Future<List<BlockedUser>> getBlockedUsers(
    Session session, {
    required int userId,
  }) async {
    return await BlockedUser.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Check if a user is blocked
  Future<bool> isUserBlocked(
    Session session, {
    required int userId,
    required int targetUserId,
  }) async {
    final blocked = await BlockedUser.db.findFirstRow(
      session,
      where: (t) => (t.userId.equals(userId) & t.blockedUserId.equals(targetUserId)),
    );
    return blocked != null;
  }

  /// Check if blocked by another user
  Future<bool> isBlockedByUser(
    Session session, {
    required int userId,
    required int otherUserId,
  }) async {
    final blocked = await BlockedUser.db.findFirstRow(
      session,
      where: (t) => (t.userId.equals(otherUserId) & t.blockedUserId.equals(userId)),
    );
    return blocked != null;
  }
}
