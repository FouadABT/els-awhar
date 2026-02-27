import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Debug helper to check if translations are loaded
class TranslationDebug {
  /// Check if a specific translation key exists
  static bool hasKey(String key) {
    final translation = key.tr;
    final exists = translation != key; // If .tr returns the key itself, it doesn't exist
    if (!exists && kDebugMode) {
      debugPrint('⚠️ Missing translation: $key');
    }
    return exists;
  }

  /// Print all loaded keys for current locale
  static void printLoadedKeys({int limit = 20}) {
    if (!kDebugMode) return;
    
    final locale = Get.locale?.languageCode ?? 'unknown';
    debugPrint('🌐 Current locale: $locale');
    debugPrint('📦 Checking translation keys...');
    
    final testKeys = [
      'common.ok',
      'request.create_title',
      'service_type.purchase',
      'service_type.task',
      'concierge.what_do_you_need',
      'concierge.add_photo',
      'concierge.location_preference',
      'concierge.anywhere_nearby',
      'concierge.specific_place',
      'concierge.item_cost_estimate',
      'concierge.delivery_fee_offer',
      'concierge.payment_notice_text',
    ];
    
    int found = 0;
    int missing = 0;
    
    for (final key in testKeys) {
      final translation = key.tr;
      if (translation == key) {
        debugPrint('❌ $key - MISSING');
        missing++;
      } else {
        debugPrint('✅ $key -> $translation');
        found++;
      }
    }
    
    debugPrint('📊 Summary: $found found, $missing missing out of ${testKeys.length} keys');
  }

  /// Force reload translations (useful for debugging)
  static Future<void> forceReloadTranslations() async {
    if (!kDebugMode) return;
    
    try {
      debugPrint('🔄 Force reloading translations...');
      // GetX doesn't have a built-in reload, but we can trigger locale change
      final currentLocale = Get.locale;
      if (currentLocale != null) {
        Get.updateLocale(currentLocale);
        debugPrint('✅ Translations reloaded for locale: ${currentLocale.languageCode}');
      }
    } catch (e) {
      debugPrint('❌ Failed to reload translations: $e');
    }
  }
}
