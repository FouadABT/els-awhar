import 'package:get/get.dart';

import '../services/app_settings_service.dart';

/// Global helper class for currency formatting
/// Provides static methods for easy access throughout the app
/// Supports dynamic currency based on country/context
class CurrencyHelper {
  CurrencyHelper._(); // Private constructor

  static AppSettingsService get _settings => AppSettingsService.to;

  // ============= Default Currency Info (from app settings) =============

  /// Get default currency code (e.g., "MAD")
  static String get code => _settings.currencyCode;

  /// Get default currency symbol (e.g., "DH")
  static String get symbol => _settings.currencySymbol;

  /// Get default currency name (e.g., "Moroccan Dirham")
  static String get name => _settings.currencyName;

  // ============= Dynamic Formatting Methods =============

  /// Format a price with default currency symbol
  /// Example: format(150) => "150 DH"
  static String format(double amount) {
    return _settings.formatPrice(amount);
  }

  /// Format a price with specific currency symbol
  /// Example: formatWithSymbol(150, '\$') => "150 \$"
  static String formatWithSymbol(double amount, String currencySymbol) {
    if (amount == amount.roundToDouble()) {
      return '${amount.toInt()} $currencySymbol';
    }
    return '${amount.toStringAsFixed(2)} $currencySymbol';
  }

  /// Format a price with currency code
  /// Example: formatWithCode(150) => "150 MAD"
  static String formatWithCode(double amount, [String? currencyCode]) {
    final codeToUse = currencyCode ?? code;
    if (amount == amount.roundToDouble()) {
      return '${amount.toInt()} $codeToUse';
    }
    return '${amount.toStringAsFixed(2)} $codeToUse';
  }

  /// Format a price range with specific currency
  /// Example: formatRange(100, 200, 'DH') => "100 - 200 DH"
  static String formatRange(double min, double max, [String? currencySymbol]) {
    final symbolToUse = currencySymbol ?? symbol;
    final minStr = min == min.roundToDouble() ? '${min.toInt()}' : min.toStringAsFixed(2);
    final maxStr = max == max.roundToDouble() ? '${max.toInt()}' : max.toStringAsFixed(2);
    return '$minStr - $maxStr $symbolToUse';
  }

  /// Format just the amount without currency
  /// Example: formatAmount(150.50) => "150.50"
  static String formatAmount(double amount) {
    if (amount == amount.roundToDouble()) {
      return '${amount.toInt()}';
    }
    return amount.toStringAsFixed(2);
  }

  /// Format with custom suffix
  /// Example: formatWith(150, "MAD") => "150 MAD"
  static String formatWith(double amount, String suffix) {
    if (amount == amount.roundToDouble()) {
      return '${amount.toInt()} $suffix';
    }
    return '${amount.toStringAsFixed(2)} $suffix';
  }

  // ============= Commission =============

  /// Get commission rate (e.g., 0.05 for 5%)
  static double get commissionRate => _settings.commissionRate;

  /// Calculate commission amount
  static double calculateCommission(double amount) {
    return amount * commissionRate;
  }

  /// Format commission amount with currency
  static String formatCommission(double amount, [String? currencySymbol]) {
    final commission = amount * commissionRate;
    return formatWithSymbol(commission, currencySymbol ?? symbol);
  }

  // ============= Pricing =============

  /// Get minimum allowed price
  static double get minPrice => _settings.minPrice;

  /// Check if price is valid (above minimum)
  static bool isValidPrice(double price) {
    return price >= minPrice;
  }

  // ============= Parsing =============

  /// Parse a price string to double
  /// Handles formats like "150 DH", "150.50 MAD", "150", "150 \$"
  static double? parse(String priceString) {
    try {
      // Remove common currency symbols and codes
      final cleaned = priceString
          .replaceAll(symbol, '')
          .replaceAll(code, '')
          .replaceAll('DH', '')
          .replaceAll('MAD', '')
          .replaceAll('USD', '')
          .replaceAll('EUR', '')
          .replaceAll('\$', '')
          .replaceAll('€', '')
          .replaceAll(',', '.')
          .trim();

      return double.tryParse(cleaned);
    } catch (e) {
      return null;
    }
  }

  // ============= Currency Symbol Lookup =============

  /// Get currency symbol from currency code
  static String getSymbolFromCode(String currencyCode) {
    const symbols = {
      'MAD': 'DH',
      'USD': '\$',
      'EUR': '€',
      'GBP': '£',
      'CAD': 'CA\$',
      'AUD': 'A\$',
      'SAR': 'ر.س',
      'AED': 'د.إ',
      'EGP': 'E£',
      'TND': 'DT',
      'DZD': 'DA',
    };
    return symbols[currencyCode.toUpperCase()] ?? currencyCode;
  }

  /// Get currency name from code
  static String getNameFromCode(String currencyCode) {
    const names = {
      'MAD': 'Moroccan Dirham',
      'USD': 'US Dollar',
      'EUR': 'Euro',
      'GBP': 'British Pound',
      'CAD': 'Canadian Dollar',
      'AUD': 'Australian Dollar',
      'SAR': 'Saudi Riyal',
      'AED': 'UAE Dirham',
      'EGP': 'Egyptian Pound',
      'TND': 'Tunisian Dinar',
      'DZD': 'Algerian Dinar',
    };
    return names[currencyCode.toUpperCase()] ?? currencyCode;
  }
}

/// Extension on double for easy currency formatting
extension CurrencyExtension on double {
  /// Format as currency with default symbol
  /// Example: 150.0.toCurrency => "150 DH"
  String get toCurrency => CurrencyHelper.format(this);

  /// Format as currency with default code
  /// Example: 150.0.toCurrencyCode => "150 MAD"
  String get toCurrencyCode => CurrencyHelper.formatWithCode(this);

  /// Format as currency with specific symbol
  /// Example: 150.0.toCurrencyWith('\$') => "150 \$"
  String toCurrencyWith(String symbol) => CurrencyHelper.formatWithSymbol(this, symbol);
}

/// Extension on int for easy currency formatting
extension CurrencyIntExtension on int {
  /// Format as currency with default symbol
  /// Example: 150.toCurrency => "150 DH"
  String get toCurrency => CurrencyHelper.format(toDouble());

  /// Format as currency with default code
  /// Example: 150.toCurrencyCode => "150 MAD"
  String get toCurrencyCode => CurrencyHelper.formatWithCode(toDouble());

  /// Format as currency with specific symbol
  /// Example: 150.toCurrencyWith('\$') => "150 \$"
  String toCurrencyWith(String symbol) => CurrencyHelper.formatWithSymbol(toDouble(), symbol);
}
