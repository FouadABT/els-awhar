import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Promo Banner Endpoint
/// Handles CRUD operations for promotional banners
/// Admin methods require admin authentication
class PromoEndpoint extends Endpoint {
  
  // ========== PUBLIC METHODS (For App Users) ==========
  
  /// Get active promos for a specific user role
  /// Filters by: isActive, date range, and target role
  Future<List<Promo>> getActivePromos(
    Session session, {
    required String role, // 'client', 'driver', 'store'
  }) async {
    try {
      final now = DateTime.now();
      
      // Get all active promos
      final promos = await Promo.db.find(
        session,
        where: (t) => t.isActive.equals(true),
        orderBy: (t) => t.priority,
        orderDescending: true,
      );
      
      // Filter by role and date range
      final filteredPromos = promos.where((promo) {
        // Check if this promo targets the user's role
        final targetRoles = promo.targetRoles.split(',').map((r) => r.trim()).toList();
        if (!targetRoles.contains(role) && !targetRoles.contains('all')) {
          return false;
        }
        
        // Check start date
        if (promo.startDate != null && now.isBefore(promo.startDate!)) {
          return false;
        }
        
        // Check end date
        if (promo.endDate != null && now.isAfter(promo.endDate!)) {
          return false;
        }
        
        return true;
      }).toList();
      
      session.log('[Promo] Returning ${filteredPromos.length} active promos for role: $role');
      return filteredPromos;
      
    } catch (e) {
      session.log('[Promo] Error getting active promos: $e', level: LogLevel.error);
      return [];
    }
  }
  
  /// Record a promo view (for analytics)
  Future<bool> recordView(Session session, {required int promoId}) async {
    try {
      final promo = await Promo.db.findById(session, promoId);
      if (promo == null) return false;
      
      await Promo.db.updateRow(
        session,
        promo.copyWith(viewCount: promo.viewCount + 1),
      );
      
      return true;
    } catch (e) {
      session.log('[Promo] Error recording view: $e', level: LogLevel.error);
      return false;
    }
  }
  
  /// Record a promo click (for analytics)
  Future<bool> recordClick(Session session, {required int promoId}) async {
    try {
      final promo = await Promo.db.findById(session, promoId);
      if (promo == null) return false;
      
      await Promo.db.updateRow(
        session,
        promo.copyWith(clickCount: promo.clickCount + 1),
      );
      
      return true;
    } catch (e) {
      session.log('[Promo] Error recording click: $e', level: LogLevel.error);
      return false;
    }
  }
  
  // ========== ADMIN METHODS ==========
  
  /// Get all promos (admin only)
  Future<List<Promo>> getAllPromos(Session session) async {
    try {
      final promos = await Promo.db.find(
        session,
        orderBy: (t) => t.createdAt,
        orderDescending: true,
      );
      
      session.log('[Promo] Admin: Returning ${promos.length} promos');
      return promos;
      
    } catch (e) {
      session.log('[Promo] Error getting all promos: $e', level: LogLevel.error);
      return [];
    }
  }
  
  /// Get a single promo by ID (admin only)
  Future<Promo?> getPromo(Session session, {required int promoId}) async {
    try {
      return await Promo.db.findById(session, promoId);
    } catch (e) {
      session.log('[Promo] Error getting promo: $e', level: LogLevel.error);
      return null;
    }
  }
  
  /// Create a new promo (admin only)
  Future<Promo?> createPromo(
    Session session, {
    required String titleEn,
    String? titleAr,
    String? titleFr,
    String? titleEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    required String imageUrl,
    required String targetRoles,
    String actionType = 'none',
    String? actionValue,
    int priority = 0,
    bool isActive = true,
    DateTime? startDate,
    DateTime? endDate,
    int? createdBy,
  }) async {
    try {
      final promo = Promo(
        titleEn: titleEn,
        titleAr: titleAr,
        titleFr: titleFr,
        titleEs: titleEs,
        descriptionEn: descriptionEn,
        descriptionAr: descriptionAr,
        descriptionFr: descriptionFr,
        descriptionEs: descriptionEs,
        imageUrl: imageUrl,
        targetRoles: targetRoles,
        actionType: actionType,
        actionValue: actionValue,
        priority: priority,
        isActive: isActive,
        startDate: startDate,
        endDate: endDate,
        viewCount: 0,
        clickCount: 0,
        createdAt: DateTime.now(),
        createdBy: createdBy,
      );
      
      final created = await Promo.db.insertRow(session, promo);
      session.log('[Promo] Created promo: ${created.id} - ${created.titleEn}');
      return created;
      
    } catch (e) {
      session.log('[Promo] Error creating promo: $e', level: LogLevel.error);
      return null;
    }
  }
  
  /// Update an existing promo (admin only)
  Future<Promo?> updatePromo(
    Session session, {
    required int promoId,
    String? titleEn,
    String? titleAr,
    String? titleFr,
    String? titleEs,
    String? descriptionEn,
    String? descriptionAr,
    String? descriptionFr,
    String? descriptionEs,
    String? imageUrl,
    String? targetRoles,
    String? actionType,
    String? actionValue,
    int? priority,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final promo = await Promo.db.findById(session, promoId);
      if (promo == null) {
        session.log('[Promo] Promo not found: $promoId', level: LogLevel.warning);
        return null;
      }
      
      final updated = promo.copyWith(
        titleEn: titleEn ?? promo.titleEn,
        titleAr: titleAr ?? promo.titleAr,
        titleFr: titleFr ?? promo.titleFr,
        titleEs: titleEs ?? promo.titleEs,
        descriptionEn: descriptionEn ?? promo.descriptionEn,
        descriptionAr: descriptionAr ?? promo.descriptionAr,
        descriptionFr: descriptionFr ?? promo.descriptionFr,
        descriptionEs: descriptionEs ?? promo.descriptionEs,
        imageUrl: imageUrl ?? promo.imageUrl,
        targetRoles: targetRoles ?? promo.targetRoles,
        actionType: actionType ?? promo.actionType,
        actionValue: actionValue ?? promo.actionValue,
        priority: priority ?? promo.priority,
        isActive: isActive ?? promo.isActive,
        startDate: startDate ?? promo.startDate,
        endDate: endDate ?? promo.endDate,
        updatedAt: DateTime.now(),
      );
      
      final result = await Promo.db.updateRow(session, updated);
      session.log('[Promo] Updated promo: ${result.id}');
      return result;
      
    } catch (e) {
      session.log('[Promo] Error updating promo: $e', level: LogLevel.error);
      return null;
    }
  }
  
  /// Toggle promo active status (admin only)
  Future<bool> togglePromoStatus(
    Session session, {
    required int promoId,
  }) async {
    try {
      final promo = await Promo.db.findById(session, promoId);
      if (promo == null) return false;
      
      await Promo.db.updateRow(
        session,
        promo.copyWith(
          isActive: !promo.isActive,
          updatedAt: DateTime.now(),
        ),
      );
      
      session.log('[Promo] Toggled promo ${promo.id} status to: ${!promo.isActive}');
      return true;
      
    } catch (e) {
      session.log('[Promo] Error toggling status: $e', level: LogLevel.error);
      return false;
    }
  }
  
  /// Delete a promo (admin only)
  Future<bool> deletePromo(Session session, {required int promoId}) async {
    try {
      final promo = await Promo.db.findById(session, promoId);
      if (promo == null) {
        session.log('[Promo] Promo not found for deletion: $promoId', level: LogLevel.warning);
        return false;
      }
      
      await Promo.db.deleteRow(session, promo);
      session.log('[Promo] Deleted promo: $promoId');
      return true;
      
    } catch (e) {
      session.log('[Promo] Error deleting promo: $e', level: LogLevel.error);
      return false;
    }
  }
  
  /// Get promo analytics (admin only)
  Future<Map<String, dynamic>> getPromoAnalytics(
    Session session, {
    required int promoId,
  }) async {
    try {
      final promo = await Promo.db.findById(session, promoId);
      if (promo == null) {
        return {'error': 'Promo not found'};
      }
      
      final clickRate = promo.viewCount > 0 
          ? (promo.clickCount / promo.viewCount * 100).toStringAsFixed(2)
          : '0.00';
      
      return {
        'promoId': promo.id,
        'title': promo.titleEn,
        'viewCount': promo.viewCount,
        'clickCount': promo.clickCount,
        'clickRate': '$clickRate%',
        'isActive': promo.isActive,
        'createdAt': promo.createdAt.toIso8601String(),
      };
      
    } catch (e) {
      session.log('[Promo] Error getting analytics: $e', level: LogLevel.error);
      return {'error': e.toString()};
    }
  }
}
