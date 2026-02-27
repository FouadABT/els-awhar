import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:awhar_flutter/core/services/location_service.dart';
import 'package:awhar_client/awhar_client.dart';

/// Smart Search result item model
class SmartSearchItem {
  final String type; // 'service', 'store', 'product', 'knowledge'
  final int? id;
  final String? docId;
  final String title;
  final String? subtitle;
  final String? description;
  final String? category;
  final String? imageUrl;
  final String? iconName;
  final double? price;
  final double? rating;
  final double? distance;
  final double score;

  SmartSearchItem({
    required this.type,
    this.id,
    this.docId,
    required this.title,
    this.subtitle,
    this.description,
    this.category,
    this.imageUrl,
    this.iconName,
    this.price,
    this.rating,
    this.distance,
    required this.score,
  });

  factory SmartSearchItem.fromJson(Map<String, dynamic> json, String type) {
    switch (type) {
      case 'service':
        return SmartSearchItem(
          type: type,
          id: json['serviceId'] as int?,
          title: json['nameEn'] ?? json['nameAr'] ?? json['nameFr'] ?? '',
          subtitle: json['categoryName'] ?? json['categoryNameEn'] ?? '',
          description: json['descriptionEn'] ?? json['descriptionAr'] ?? '',
          category: json['categoryName'] ?? json['categoryNameEn'],
          iconName: json['iconName'] as String?,
          price: _toDouble(json['basePrice'] ?? json['suggestedPriceMin']),
          score: _toDouble(json['_score']) ?? 0.0,
        );
      case 'store':
        return SmartSearchItem(
          type: type,
          id: json['storeId'] as int?,
          title: json['name'] ?? json['nameEn'] ?? '',
          subtitle: json['category'] ?? json['categoryName'] ?? '',
          description: json['description'] ?? json['tagline'] ?? '',
          category: json['category'] ?? json['categoryName'],
          imageUrl: json['logoUrl'] as String?,
          rating: _toDouble(json['rating']),
          distance: _toDouble(json['distance']),
          score: _toDouble(json['_score']) ?? 0.0,
        );
      case 'product':
        return SmartSearchItem(
          type: type,
          id: json['productId'] as int?,
          title: json['name'] ?? '',
          subtitle: json['storeName'] ?? '',
          description: json['description'] ?? '',
          category: json['category'],
          imageUrl: json['imageUrl'] as String?,
          price: _toDouble(json['price']),
          score: _toDouble(json['_score']) ?? 0.0,
        );
      case 'knowledge':
        return SmartSearchItem(
          type: type,
          docId: json['docId'] as String?,
          title: json['title'] ?? '',
          subtitle: json['category'] ?? '',
          description: json['content'] ?? '',
          category: json['category'],
          score: _toDouble(json['_score']) ?? 0.0,
        );
      default:
        return SmartSearchItem(
          type: type,
          title: json['title'] ?? json['name'] ?? '',
          score: 0.0,
        );
    }
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}

/// Smart Search Controller
/// Handles semantic search using ELSER + BM25 hybrid ranking
class SmartSearchController extends GetxController {
  final Client _client = Get.find<Client>();
  final _storage = GetStorage();
  static const _historyKey = 'smart_search_history';

  // Search state
  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;
  final RxBool hasSearched = false.obs;
  final RxString errorMessage = ''.obs;

  // Results grouped by type
  final RxList<SmartSearchItem> serviceResults = <SmartSearchItem>[].obs;
  final RxList<SmartSearchItem> storeResults = <SmartSearchItem>[].obs;
  final RxList<SmartSearchItem> productResults = <SmartSearchItem>[].obs;
  final RxList<SmartSearchItem> knowledgeResults = <SmartSearchItem>[].obs;

  // Suggestions
  final RxList<String> suggestions = <String>[].obs;
  final RxBool isLoadingSuggestions = false.obs;

  // Popular searches
  final RxList<String> popularSearches = <String>[].obs;

  // Search history (persisted via GetStorage)
  final RxList<String> searchHistory = <String>[].obs;

  // Voice search state
  final stt.SpeechToText _speech = stt.SpeechToText();
  final RxBool isListening = false.obs;
  final RxBool isSpeechAvailable = false.obs;
  final RxString lastVoiceResult = ''.obs;

  // Debounce timer
  Timer? _debounceTimer;
  Timer? _suggestionTimer;

  int get totalResults =>
      serviceResults.length +
      storeResults.length +
      productResults.length +
      knowledgeResults.length;

  bool get hasResults => totalResults > 0;

  @override
  void onInit() {
    super.onInit();
    _loadPopularSearches();
    _loadSearchHistory();
    _initSpeech();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    _suggestionTimer?.cancel();
    if (isListening.value) _speech.stop();
    super.onClose();
  }

  // ============================================
  // VOICE SEARCH (speech_to_text)
  // ============================================

  /// Initialize speech recognition engine
  Future<void> _initSpeech() async {
    try {
      isSpeechAvailable.value = await _speech.initialize(
        onStatus: (status) {
          isListening.value = status == 'listening';
        },
        onError: (error) {
          isListening.value = false;
          if (error.permanent) isSpeechAvailable.value = false;
        },
      );
    } catch (_) {
      isSpeechAvailable.value = false;
    }
  }

  /// Start voice listening — auto-detects locale from app language
  Future<void> startListening({
    Function(String text)? onResult,
  }) async {
    if (!isSpeechAvailable.value) return;
    if (isListening.value) {
      await stopListening();
      return;
    }

    isListening.value = true;
    lastVoiceResult.value = '';

    await _speech.listen(
      onResult: (result) {
        lastVoiceResult.value = result.recognizedWords;
        if (result.finalResult && result.recognizedWords.isNotEmpty) {
          onResult?.call(result.recognizedWords);
          search(result.recognizedWords);
        }
      },
      localeId: _getSpeechLocale(),
      listenFor: const Duration(seconds: 15),
      pauseFor: const Duration(seconds: 3),
    );
  }

  /// Stop voice listening
  Future<void> stopListening() async {
    await _speech.stop();
    isListening.value = false;
  }

  /// Get speech locale based on app language
  String _getSpeechLocale() {
    final lang = Get.locale?.languageCode ?? 'en';
    switch (lang) {
      case 'ar':
        return 'ar_MA'; // Moroccan Arabic
      case 'fr':
        return 'fr_FR';
      case 'es':
        return 'es_ES';
      default:
        return 'en_US';
    }
  }

  /// Called on every text change — loads suggestions with debounce
  void onSearchChanged(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      suggestions.clear();
      return;
    }

    _suggestionTimer?.cancel();
    _suggestionTimer = Timer(const Duration(milliseconds: 300), () {
      _loadSuggestions(query);
    });
  }

  /// Execute full smart search
  Future<void> search(String query) async {
    if (query.trim().isEmpty) return;

    searchQuery.value = query.trim();
    isSearching.value = true;
    hasSearched.value = true;
    errorMessage.value = '';

    // Add to history
    _addToHistory(query.trim());

    try {
      // Get current location for geo-aware results
      double? lat;
      double? lon;
      try {
        final locationService = Get.find<LocationService>();
        final position = locationService.currentPosition.value;
        if (position != null) {
          lat = position.latitude;
          lon = position.longitude;
        }
      } catch (_) {
        // Location not available — proceed without geo
      }

      // Detect language from query
      final language = _detectLanguage(query);

      final result = await _client.search.smartSearch(
        query: query.trim(),
        language: language,
        lat: lat,
        lon: lon,
        radiusKm: 50.0,
        sizePerType: 5,
      );

      _parseResults(result);
    } catch (e) {
      errorMessage.value = e.toString();
      _clearResults();
    } finally {
      isSearching.value = false;
    }
  }

  /// Search knowledge base specifically
  Future<void> searchHelp(String query) async {
    if (query.trim().isEmpty) return;

    isSearching.value = true;
    errorMessage.value = '';

    try {
      final language = _detectLanguage(query);
      final result = await _client.search.searchKnowledgeBase(
        query: query.trim(),
        language: language,
        size: 10,
      );

      final data = jsonDecode(result);
      knowledgeResults.value = (data['results'] as List? ?? [])
          .map((r) => SmartSearchItem.fromJson(
              r as Map<String, dynamic>, 'knowledge'))
          .toList();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isSearching.value = false;
    }
  }

  /// Clear all state
  void clearSearch() {
    searchQuery.value = '';
    hasSearched.value = false;
    errorMessage.value = '';
    suggestions.clear();
    _clearResults();
  }

  void removeHistoryItem(String item) {
    searchHistory.remove(item);
    _saveSearchHistory();
  }

  void clearHistory() {
    searchHistory.clear();
    _saveSearchHistory();
  }

  // --- Private helpers ---

  void _parseResults(String jsonString) {
    try {
      final data = jsonDecode(jsonString);

      serviceResults.value = _parseGroup(data, 'services', 'service');
      storeResults.value = _parseGroup(data, 'stores', 'store');
      productResults.value = _parseGroup(data, 'products', 'product');
      knowledgeResults.value = _parseGroup(data, 'knowledge', 'knowledge');
    } catch (e) {
      errorMessage.value = 'Failed to parse results: $e';
      _clearResults();
    }
  }

  List<SmartSearchItem> _parseGroup(
      Map<String, dynamic> data, String key, String type) {
    final items = data[key] as List? ?? [];
    return items
        .map((item) =>
            SmartSearchItem.fromJson(item as Map<String, dynamic>, type))
        .toList();
  }

  void _clearResults() {
    serviceResults.clear();
    storeResults.clear();
    productResults.clear();
    knowledgeResults.clear();
  }

  Future<void> _loadSuggestions(String prefix) async {
    if (prefix.length < 2) return;
    isLoadingSuggestions.value = true;
    try {
      final result = await _client.search.getSearchSuggestions(
        prefix: prefix,
        size: 5,
      );
      final data = jsonDecode(result);
      final items = data['suggestions'] as List? ?? [];
      suggestions.value =
          items.map((s) => s['text']?.toString() ?? s.toString()).toList();
    } catch (_) {
      suggestions.clear();
    } finally {
      isLoadingSuggestions.value = false;
    }
  }

  Future<void> _loadPopularSearches() async {
    try {
      final result = await _client.search.getPopularSearches(size: 8);
      final data = jsonDecode(result);
      final items = data['searches'] as List? ?? [];
      popularSearches.value =
          items.map((s) => s['query']?.toString() ?? s.toString()).toList();
    } catch (_) {
      // Use fallback popular searches
      popularSearches.value = [
        'Food delivery',
        'Moving',
        'Pharmacy',
        'Courier',
        'Airport transfer',
        'Grocery',
      ];
    }
  }

  void _addToHistory(String query) {
    searchHistory.remove(query);
    searchHistory.insert(0, query);
    if (searchHistory.length > 10) {
      searchHistory.removeLast();
    }
    _saveSearchHistory();
  }

  void _loadSearchHistory() {
    final stored = _storage.read<List>(_historyKey);
    if (stored != null) {
      searchHistory.value = stored.cast<String>();
    }
  }

  void _saveSearchHistory() {
    _storage.write(_historyKey, searchHistory.toList());
  }

  /// Simple language detection based on character ranges
  String _detectLanguage(String text) {
    // Arabic characters: \u0600-\u06FF
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    if (arabicRegex.hasMatch(text)) return 'ar';

    // French accented characters
    final frenchRegex = RegExp(r'[àâäéèêëïîôùûüÿçœæ]', caseSensitive: false);
    if (frenchRegex.hasMatch(text)) return 'fr';

    return 'en';
  }
}
