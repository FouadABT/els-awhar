import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:awhar_client/awhar_client.dart';
import '../core/services/api_service.dart';

/// Promos controller - manages promotional banners for admin
class PromosController extends GetxController {
  // Loading state
  final RxBool isLoading = false.obs;
  final RxBool isActionLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString successMessage = ''.obs;

  // Promo list
  final RxList<Promo> promos = <Promo>[].obs;

  // Selected promo for editing
  final Rx<Promo?> selectedPromo = Rx<Promo?>(null);

  // Filter
  final RxString statusFilter = 'all'.obs; // 'all', 'active', 'inactive'

  @override
  void onInit() {
    super.onInit();
    loadPromos();
  }

  /// Load all promos from the server
  Future<void> loadPromos() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      if (!ApiService.instance.isInitialized) {
        throw Exception('API not initialized');
      }

      final result = await ApiService.instance.client.promo.getAllPromos();
      promos.value = result;
      debugPrint('[PromosController] Loaded ${result.length} promos');
    } catch (e) {
      debugPrint('[PromosController] Error loading promos: $e');
      errorMessage.value = 'Failed to load promos: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Get filtered promos based on status filter
  List<Promo> get filteredPromos {
    switch (statusFilter.value) {
      case 'active':
        return promos.where((p) => p.isActive).toList();
      case 'inactive':
        return promos.where((p) => !p.isActive).toList();
      default:
        return promos.toList();
    }
  }

  /// Create a new promo
  Future<bool> createPromo({
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
  }) async {
    isActionLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await ApiService.instance.client.promo.createPromo(
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
      );

      if (result != null) {
        await loadPromos();
        successMessage.value = 'Promo created successfully';
        return true;
      }
      errorMessage.value = 'Failed to create promo';
      return false;
    } catch (e) {
      debugPrint('[PromosController] Error creating promo: $e');
      errorMessage.value = 'Failed to create promo: $e';
      return false;
    } finally {
      isActionLoading.value = false;
    }
  }

  /// Update an existing promo
  Future<bool> updatePromo({
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
    isActionLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await ApiService.instance.client.promo.updatePromo(
        promoId: promoId,
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
      );

      if (result != null) {
        await loadPromos();
        successMessage.value = 'Promo updated successfully';
        return true;
      }
      errorMessage.value = 'Failed to update promo';
      return false;
    } catch (e) {
      debugPrint('[PromosController] Error updating promo: $e');
      errorMessage.value = 'Failed to update promo: $e';
      return false;
    } finally {
      isActionLoading.value = false;
    }
  }

  /// Toggle promo active status
  Future<bool> togglePromoStatus(int promoId) async {
    isActionLoading.value = true;

    try {
      final success = await ApiService.instance.client.promo.togglePromoStatus(
        promoId: promoId,
      );

      if (success) {
        await loadPromos();
        successMessage.value = 'Promo status updated';
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[PromosController] Error toggling status: $e');
      errorMessage.value = 'Failed to toggle status';
      return false;
    } finally {
      isActionLoading.value = false;
    }
  }

  /// Delete a promo
  Future<bool> deletePromo(int promoId) async {
    isActionLoading.value = true;

    try {
      final success = await ApiService.instance.client.promo.deletePromo(
        promoId: promoId,
      );

      if (success) {
        await loadPromos();
        successMessage.value = 'Promo deleted successfully';
        return true;
      }
      errorMessage.value = 'Failed to delete promo';
      return false;
    } catch (e) {
      debugPrint('[PromosController] Error deleting promo: $e');
      errorMessage.value = 'Failed to delete promo: $e';
      return false;
    } finally {
      isActionLoading.value = false;
    }
  }

  /// Get analytics for a specific promo
  Future<Map<String, dynamic>?> getPromoAnalytics(int promoId) async {
    try {
      final result = await ApiService.instance.client.promo.getPromoAnalytics(
        promoId: promoId,
      );
      return result;
    } catch (e) {
      debugPrint('[PromosController] Error getting analytics: $e');
      return null;
    }
  }

  /// Set status filter
  void setStatusFilter(String filter) {
    statusFilter.value = filter;
  }

  /// Clear messages
  void clearMessages() {
    errorMessage.value = '';
    successMessage.value = '';
  }
}
