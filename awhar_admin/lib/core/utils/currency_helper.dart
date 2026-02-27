/// Currency helper for admin panel
/// Provides utility methods for formatting currency values
class CurrencyHelper {
  CurrencyHelper._(); // Private constructor

  // ============= Default Currency (Morocco) =============
  static const String defaultCode = 'MAD';
  static const String defaultSymbol = 'DH';
  static const String defaultName = 'Moroccan Dirham';

  // ============= Currency Mappings =============
  static const Map<String, String> _currencySymbols = {
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

  static const Map<String, String> _currencyNames = {
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

  // ============= Formatting Methods =============

  /// Format a price with default currency symbol (DH)
  /// Example: format(150) => "150 DH"
  static String format(double amount) {
    return formatWithSymbol(amount, defaultSymbol);
  }

  /// Format a price with specific currency symbol
  /// Example: formatWithSymbol(150, '\$') => "150 \$"
  static String formatWithSymbol(double amount, String symbol) {
    if (amount == amount.roundToDouble()) {
      return '${amount.toInt()} $symbol';
    }
    return '${amount.toStringAsFixed(2)} $symbol';
  }

  /// Format a price with currency code
  /// Example: formatWithCode(150, 'MAD') => "150 MAD"
  static String formatWithCode(double amount, [String? currencyCode]) {
    final code = currencyCode ?? defaultCode;
    if (amount == amount.roundToDouble()) {
      return '${amount.toInt()} $code';
    }
    return '${amount.toStringAsFixed(2)} $code';
  }

  /// Format a price using the currency code to get the symbol
  /// Example: formatAuto(150, 'USD') => "150 \$"
  static String formatAuto(double amount, String? currencyCode) {
    final code = currencyCode ?? defaultCode;
    final symbol = getSymbolFromCode(code);
    return formatWithSymbol(amount, symbol);
  }

  /// Format a price range
  /// Example: formatRange(100, 200, 'DH') => "100 - 200 DH"
  static String formatRange(double min, double max, [String? symbol]) {
    final symbolToUse = symbol ?? defaultSymbol;
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

  // ============= Currency Lookup =============

  /// Get currency symbol from currency code
  static String getSymbolFromCode(String currencyCode) {
    return _currencySymbols[currencyCode.toUpperCase()] ?? currencyCode;
  }

  /// Get currency name from code
  static String getNameFromCode(String currencyCode) {
    return _currencyNames[currencyCode.toUpperCase()] ?? currencyCode;
  }

  /// Get all supported currencies
  static List<Map<String, String>> getSupportedCurrencies() {
    return _currencySymbols.entries
        .map((e) => {
              'code': e.key,
              'symbol': e.value,
              'name': _currencyNames[e.key] ?? e.key,
            })
        .toList();
  }

  // ============= Parsing =============

  /// Parse a price string to double
  static double? parse(String priceString) {
    try {
      // Remove common currency symbols and codes
      String cleaned = priceString;
      for (final symbol in _currencySymbols.values) {
        cleaned = cleaned.replaceAll(symbol, '');
      }
      for (final code in _currencySymbols.keys) {
        cleaned = cleaned.replaceAll(code, '');
      }
      cleaned = cleaned.replaceAll(',', '.').trim();
      return double.tryParse(cleaned);
    } catch (e) {
      return null;
    }
  }
}

/// Extension on double for easy currency formatting in admin
extension AdminCurrencyExtension on double {
  /// Format as currency with default symbol (DH)
  String get toCurrency => CurrencyHelper.format(this);

  /// Format as currency with specific symbol
  String toCurrencyWith(String symbol) =>
      CurrencyHelper.formatWithSymbol(this, symbol);

  /// Format as currency using currency code to get symbol
  String toCurrencyAuto(String? currencyCode) =>
      CurrencyHelper.formatAuto(this, currencyCode);
}
