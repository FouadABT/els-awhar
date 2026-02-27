import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/routes/app_routes.dart';

/// Controller for managing promotional banners
/// Fetches promos from backend and handles user interactions
class PromoController extends GetxController {
  // Reactive state
  final RxList<Promo> promos = <Promo>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxInt currentIndex = 0.obs;

  // Current user role
  String _userRole = 'client';

  /// Set the user role to fetch appropriate promos
  void setUserRole(String role) {
    _userRole = role;
    loadPromos();
  }

  /// Load promos for the current user role
  Future<void> loadPromos() async {
    try {
      isLoading.value = true;
      error.value = '';

      final client = Get.find<Client>();
      final result = await client.promo.getActivePromos(role: _userRole);

      promos.value = result;
      currentIndex.value = 0;

      debugPrint(
        '[PromoController] ✅ Loaded ${promos.length} promos for role: $_userRole',
      );
    } catch (e) {
      error.value = e.toString();
      debugPrint('[PromoController] ❌ Error loading promos: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Update carousel index
  void updateIndex(int index) {
    currentIndex.value = index;
  }

  /// Record promo view for analytics
  Future<void> recordView(int promoId) async {
    try {
      final client = Get.find<Client>();
      await client.promo.recordView(promoId: promoId);
    } catch (e) {
      debugPrint('[PromoController] ⚠️ Failed to record view: $e');
    }
  }

  /// Handle promo tap action
  Future<void> handlePromoTap(Promo promo) async {
    // Record click for analytics
    try {
      final client = Get.find<Client>();
      await client.promo.recordClick(promoId: promo.id!);
    } catch (e) {
      debugPrint('[PromoController] ⚠️ Failed to record click: $e');
    }

    // Handle action based on type
    switch (promo.actionType) {
      case 'none':
        // No action
        break;

      case 'link':
        // Open external link
        if (promo.actionValue != null && promo.actionValue!.isNotEmpty) {
          final uri = Uri.parse(promo.actionValue!);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        }
        break;

      case 'screen':
        // Navigate to app screen
        if (promo.actionValue != null && promo.actionValue!.isNotEmpty) {
          Get.toNamed(promo.actionValue!);
        }
        break;

      case 'store':
        // Navigate to store profile
        if (promo.actionValue != null) {
          final storeId = int.tryParse(promo.actionValue!);
          if (storeId != null) {
            Get.toNamed(
              AppRoutes.clientStoreDetail,
              arguments: {'storeId': storeId},
            );
          }
        }
        break;

      case 'driver':
        // Navigate to driver profile
        if (promo.actionValue != null) {
          final driverId = int.tryParse(promo.actionValue!);
          if (driverId != null) {
            Get.toNamed(
              AppRoutes.clientExplore,
              arguments: {'driverId': driverId},
            );
          }
        }
        break;

      case 'service':
        // Navigate to driver services (show service in explore)
        if (promo.actionValue != null) {
          final serviceId = int.tryParse(promo.actionValue!);
          if (serviceId != null) {
            Get.toNamed(
              AppRoutes.clientExplore,
              arguments: {'serviceId': serviceId},
            );
          }
        }
        break;

      default:
        debugPrint(
          '[PromoController] Unknown action type: ${promo.actionType}',
        );
    }
  }

  /// Get localized title based on current locale
  String getLocalizedTitle(Promo promo) {
    final locale = Get.locale?.languageCode ?? 'en';
    switch (locale) {
      case 'ar':
        return promo.titleAr ?? promo.titleEn;
      case 'fr':
        return promo.titleFr ?? promo.titleEn;
      case 'es':
        return promo.titleEs ?? promo.titleEn;
      default:
        return promo.titleEn;
    }
  }

  /// Get localized description based on current locale
  String? getLocalizedDescription(Promo promo) {
    final locale = Get.locale?.languageCode ?? 'en';
    switch (locale) {
      case 'ar':
        return promo.descriptionAr ?? promo.descriptionEn;
      case 'fr':
        return promo.descriptionFr ?? promo.descriptionEn;
      case 'es':
        return promo.descriptionEs ?? promo.descriptionEn;
      default:
        return promo.descriptionEn;
    }
  }

  /// Refresh promos
  Future<void> refresh() async {
    await loadPromos();
  }

  /// Check if there are any promos to show
  bool get hasPromos => promos.isNotEmpty;
}
