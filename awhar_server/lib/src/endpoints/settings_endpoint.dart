import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Endpoint for managing system settings
/// These settings are configurable from the admin dashboard
class SettingsEndpoint extends Endpoint {
  /// Get a single setting by key
  Future<String?> getSetting(Session session, String key) async {
    final setting = await SystemSetting.db.findFirstRow(
      session,
      where: (t) => t.key.equals(key),
    );
    return setting?.value;
  }

  /// Get multiple settings by keys
  Future<Map<String, String>> getSettings(
    Session session,
    List<String> keys,
  ) async {
    final settings = await SystemSetting.db.find(
      session,
      where: (t) => t.key.inSet(keys.toSet()),
    );

    final result = <String, String>{};
    for (final setting in settings) {
      result[setting.key] = setting.value;
    }
    return result;
  }

  /// Get all settings (for admin dashboard or app initialization)
  Future<Map<String, String>> getAllSettings(Session session) async {
    final settings = await SystemSetting.db.find(session);

    final result = <String, String>{};
    for (final setting in settings) {
      result[setting.key] = setting.value;
    }

    // Add defaults for any missing settings
    final defaults = _getDefaultSettings();
    for (final entry in defaults.entries) {
      if (!result.containsKey(entry.key)) {
        result[entry.key] = entry.value;
      }
    }

    return result;
  }

  /// Set a setting value (admin only)
  Future<bool> setSetting(
    Session session, {
    required String key,
    required String value,
    String? description,
  }) async {
    try {
      // Check if setting exists
      final existing = await SystemSetting.db.findFirstRow(
        session,
        where: (t) => t.key.equals(key),
      );

      if (existing != null) {
        // Update existing
        existing.value = value;
        existing.updatedAt = DateTime.now();
        if (description != null) {
          existing.description = description;
        }
        await SystemSetting.db.updateRow(session, existing);
      } else {
        // Create new
        final setting = SystemSetting(
          key: key,
          value: value,
          description: description,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await SystemSetting.db.insertRow(session, setting);
      }

      session.log('Setting updated: $key = $value');
      return true;
    } catch (e) {
      session.log('Error setting $key: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Set multiple settings at once (admin only)
  Future<bool> setSettings(
    Session session,
    Map<String, String> settings,
  ) async {
    try {
      for (final entry in settings.entries) {
        await setSetting(
          session,
          key: entry.key,
          value: entry.value,
        );
      }
      return true;
    } catch (e) {
      session.log('Error setting multiple settings: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Delete a setting (admin only)
  Future<bool> deleteSetting(Session session, String key) async {
    try {
      final deleted = await SystemSetting.db.deleteWhere(
        session,
        where: (t) => t.key.equals(key),
      );
      return deleted.isNotEmpty;
    } catch (e) {
      session.log('Error deleting setting $key: $e', level: LogLevel.error);
      return false;
    }
  }

  /// Get app configuration (public settings for mobile app)
  /// This returns a structured JSON with all public settings
  Future<AppConfiguration> getAppConfiguration(Session session) async {
    final settings = await getAllSettings(session);

    return AppConfiguration(
      currencyCode: settings['currency_code'] ?? 'MAD',
      currencySymbol: settings['currency_symbol'] ?? 'DH',
      currencyName: settings['currency_name'] ?? 'Moroccan Dirham',
      minPrice: double.tryParse(settings['min_price'] ?? '15') ?? 15.0,
      commissionRate:
          double.tryParse(settings['commission_rate'] ?? '0.05') ?? 0.05,
      appName: settings['app_name'] ?? 'Awhar',
      supportEmail: settings['support_email'] ?? 'support@awhar.com',
      supportPhone: settings['support_phone'] ?? '+212600000000',
      termsUrl: settings['terms_url'] ?? 'https://awhar.com/terms',
      privacyUrl: settings['privacy_url'] ?? 'https://awhar.com/privacy',
      maxImageSizeMb:
          double.tryParse(settings['max_image_size_mb'] ?? '5') ?? 5.0,
      defaultLanguage: settings['default_language'] ?? 'en',
    );
  }

  /// Initialize default settings if they don't exist
  Future<void> initializeDefaultSettings(Session session) async {
    final defaults = _getDefaultSettings();

    for (final entry in defaults.entries) {
      final existing = await SystemSetting.db.findFirstRow(
        session,
        where: (t) => t.key.equals(entry.key),
      );

      if (existing == null) {
        final setting = SystemSetting(
          key: entry.key,
          value: entry.value,
          description: _getSettingDescription(entry.key),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await SystemSetting.db.insertRow(session, setting);
        session.log('Initialized default setting: ${entry.key}');
      }
    }
  }

  /// Default settings values
  Map<String, String> _getDefaultSettings() {
    return {
      'currency_code': 'MAD',
      'currency_symbol': 'DH',
      'currency_name': 'Moroccan Dirham',
      'min_price': '15',
      'commission_rate': '0.05',
      'app_name': 'Awhar',
      'support_email': 'support@awhar.com',
      'support_phone': '+212600000000',
      'terms_url': 'https://awhar.com/terms',
      'privacy_url': 'https://awhar.com/privacy',
      'max_image_size_mb': '5',
      'default_language': 'en',
    };
  }

  /// Setting descriptions
  String _getSettingDescription(String key) {
    final descriptions = {
      'currency_code': 'Currency code (e.g., MAD, USD, EUR)',
      'currency_symbol': 'Currency symbol (e.g., DH, \$, €)',
      'currency_name': 'Full currency name',
      'min_price': 'Minimum allowed price for services',
      'commission_rate': 'Platform commission rate (0.05 = 5%)',
      'app_name': 'Application name',
      'support_email': 'Customer support email',
      'support_phone': 'Customer support phone',
      'terms_url': 'Terms of service URL',
      'privacy_url': 'Privacy policy URL',
      'max_image_size_mb': 'Maximum image upload size in MB',
      'default_language': 'Default app language code',
    };
    return descriptions[key] ?? '';
  }
}
