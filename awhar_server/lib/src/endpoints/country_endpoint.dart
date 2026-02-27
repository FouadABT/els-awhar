import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Endpoint for managing countries and currency information
class CountryEndpoint extends Endpoint {
  /// Get all active countries
  Future<List<Country>> getActiveCountries(Session session) async {
    return await Country.db.find(
      session,
      where: (t) => t.isActive.equals(true),
      orderBy: (t) => t.name,
    );
  }

  /// Get a country by its code (e.g., 'MA', 'US')
  Future<Country?> getCountryByCode(Session session, String code) async {
    return await Country.db.findFirstRow(
      session,
      where: (t) => t.code.equals(code.toUpperCase()),
    );
  }

  /// Get the default country (Morocco)
  Future<Country?> getDefaultCountry(Session session) async {
    // First try to get the one marked as default
    var country = await Country.db.findFirstRow(
      session,
      where: (t) => t.isDefault.equals(true) & t.isActive.equals(true),
    );

    // If no default, get Morocco
    if (country == null) {
      country = await Country.db.findFirstRow(
        session,
        where: (t) => t.code.equals('MA') & t.isActive.equals(true),
      );
    }

    // If still null, initialize and return Morocco
    if (country == null) {
      await initializeDefaultCountries(session);
      country = await Country.db.findFirstRow(
        session,
        where: (t) => t.code.equals('MA'),
      );
    }

    return country;
  }

  /// Get currency info for a specific country code
  Future<Map<String, dynamic>> getCurrencyInfo(
    Session session,
    String countryCode,
  ) async {
    final country = await getCountryByCode(session, countryCode);

    if (country == null) {
      // Return default (Morocco)
      return {
        'currencyCode': 'MAD',
        'currencySymbol': 'DH',
        'currencyName': 'Moroccan Dirham',
        'vatRate': 0.0,
        'minPrice': 15.0,
        'commissionRate': 0.05,
      };
    }

    return {
      'currencyCode': country.currencyCode,
      'currencySymbol': country.currencySymbol,
      'currencyName': country.currencyName,
      'vatRate': country.vatRate,
      'minPrice': country.minPrice,
      'commissionRate': country.commissionRate,
    };
  }

  /// Format a price with currency symbol
  Future<String> formatPrice(
    Session session,
    double amount,
    String countryCode,
  ) async {
    final country = await getCountryByCode(session, countryCode);
    final symbol = country?.currencySymbol ?? 'DH';

    // Remove decimals if whole number
    if (amount == amount.roundToDouble()) {
      return '${amount.toInt()} $symbol';
    }
    return '${amount.toStringAsFixed(2)} $symbol';
  }

  /// Initialize default countries (run on first setup)
  Future<void> initializeDefaultCountries(Session session) async {
    final countries = [
      Country(
        code: 'MA',
        name: 'Morocco',
        nameAr: 'المغرب',
        nameFr: 'Maroc',
        currencyCode: 'MAD',
        currencySymbol: 'DH',
        currencyName: 'Moroccan Dirham',
        currencyNameAr: 'الدرهم المغربي',
        vatRate: 0.20, // 20% TVA in Morocco
        vatName: 'TVA',
        phonePrefix: '+212',
        phonePlaceholder: '6XX-XXXXXX',
        defaultLanguage: 'ar',
        minPrice: 15.0,
        commissionRate: 0.05,
        exchangeRateToMAD: 1.0,
        isActive: true,
        isDefault: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Country(
        code: 'US',
        name: 'United States',
        nameAr: 'الولايات المتحدة',
        nameFr: 'États-Unis',
        currencyCode: 'USD',
        currencySymbol: '\$',
        currencyName: 'US Dollar',
        currencyNameAr: 'الدولار الأمريكي',
        vatRate: 0.0, // No federal VAT
        vatName: 'Tax',
        phonePrefix: '+1',
        phonePlaceholder: 'XXX-XXX-XXXX',
        defaultLanguage: 'en',
        minPrice: 5.0,
        commissionRate: 0.05,
        exchangeRateToMAD: 10.0, // 1 USD = ~10 MAD
        isActive: false, // Not active yet
        isDefault: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Country(
        code: 'FR',
        name: 'France',
        nameAr: 'فرنسا',
        nameFr: 'France',
        currencyCode: 'EUR',
        currencySymbol: '€',
        currencyName: 'Euro',
        currencyNameAr: 'اليورو',
        vatRate: 0.20, // 20% TVA in France
        vatName: 'TVA',
        phonePrefix: '+33',
        phonePlaceholder: 'X XX XX XX XX',
        defaultLanguage: 'fr',
        minPrice: 5.0,
        commissionRate: 0.05,
        exchangeRateToMAD: 11.0, // 1 EUR = ~11 MAD
        isActive: false, // Not active yet
        isDefault: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Country(
        code: 'ES',
        name: 'Spain',
        nameAr: 'إسبانيا',
        nameFr: 'Espagne',
        currencyCode: 'EUR',
        currencySymbol: '€',
        currencyName: 'Euro',
        currencyNameAr: 'اليورو',
        vatRate: 0.21, // 21% IVA in Spain
        vatName: 'IVA',
        phonePrefix: '+34',
        phonePlaceholder: 'XXX XXX XXX',
        defaultLanguage: 'es',
        minPrice: 5.0,
        commissionRate: 0.05,
        exchangeRateToMAD: 11.0, // 1 EUR = ~11 MAD
        isActive: false, // Not active yet
        isDefault: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    for (final country in countries) {
      final existing = await Country.db.findFirstRow(
        session,
        where: (t) => t.code.equals(country.code),
      );

      if (existing == null) {
        await Country.db.insertRow(session, country);
        session.log('Initialized country: ${country.name} (${country.code})');
      }
    }
  }

  /// Admin: Create or update a country
  Future<Country> upsertCountry(Session session, Country country) async {
    final existing = await Country.db.findFirstRow(
      session,
      where: (t) => t.code.equals(country.code),
    );

    if (existing != null) {
      final updated = country.copyWith(
        id: existing.id,
        updatedAt: DateTime.now(),
      );
      return await Country.db.updateRow(session, updated);
    } else {
      return await Country.db.insertRow(session, country);
    }
  }

  /// Admin: Update exchange rate for a country
  Future<bool> updateExchangeRate(
    Session session,
    String countryCode,
    double rateToMAD,
  ) async {
    final country = await getCountryByCode(session, countryCode);
    if (country == null) return false;

    final updated = country.copyWith(
      exchangeRateToMAD: rateToMAD,
      exchangeRateUpdatedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await Country.db.updateRow(session, updated);
    return true;
  }

  /// Admin: Toggle country active status
  Future<bool> toggleCountryStatus(
    Session session,
    String countryCode,
    bool isActive,
  ) async {
    final country = await getCountryByCode(session, countryCode);
    if (country == null) return false;

    final updated = country.copyWith(
      isActive: isActive,
      updatedAt: DateTime.now(),
    );

    await Country.db.updateRow(session, updated);
    return true;
  }

  /// Convert amount from one currency to another (via MAD as base)
  Future<double> convertCurrency(
    Session session,
    double amount,
    String fromCountryCode,
    String toCountryCode,
  ) async {
    if (fromCountryCode == toCountryCode) return amount;

    final fromCountry = await getCountryByCode(session, fromCountryCode);
    final toCountry = await getCountryByCode(session, toCountryCode);

    if (fromCountry == null || toCountry == null) return amount;

    // Convert to MAD first, then to target currency
    final amountInMAD = amount * fromCountry.exchangeRateToMAD;
    final amountInTarget = amountInMAD / toCountry.exchangeRateToMAD;

    return amountInTarget;
  }
}
