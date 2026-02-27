/// Request Concierge Agent
/// 
/// AI-powered agent that parses natural language service requests
/// and converts them into structured, actionable requests.
/// 
/// Examples:
/// - "I need someone to pick up groceries from Marjane and deliver to my house"
/// - "Can someone help me move furniture from my apartment?"
/// - "I need a driver to take me to the airport tomorrow at 6am"
/// 
/// The agent uses Elasticsearch to:
/// - Match intent to service catalog
/// - Find similar past requests for pricing
/// - Suggest appropriate categories

import 'package:serverpod/serverpod.dart';
import '../elasticsearch/elasticsearch.dart';
import 'agent_types.dart';
import 'agent_models.dart';

/// Input for the request concierge agent
class RequestConciergeInput {
  final String naturalLanguageRequest;
  final String language; // 'en', 'ar', 'fr', 'es'
  final double? userLatitude;
  final double? userLongitude;
  final int? userId;

  RequestConciergeInput({
    required this.naturalLanguageRequest,
    this.language = 'en',
    this.userLatitude,
    this.userLongitude,
    this.userId,
  });
}

/// Request Concierge Agent
/// 
/// Workflow:
/// 1. Parse natural language to extract intent
/// 2. Search service catalog for matching services
/// 3. Extract location mentions
/// 4. Look up historical pricing
/// 5. Generate structured request or ask clarifying questions
class RequestConciergeAgent {
  final ElasticsearchSearchService _searchService;

  RequestConciergeAgent(this._searchService);

  // Common service keywords mapping
  static const Map<String, List<String>> _serviceKeywords = {
    'delivery': ['deliver', 'delivery', 'pick up', 'pickup', 'drop off', 'dropoff', 'groceries', 'food', 'package', 'parcel'],
    'transport': ['ride', 'drive', 'taxi', 'uber', 'airport', 'station', 'take me', 'transport'],
    'moving': ['move', 'moving', 'furniture', 'relocate', 'relocation', 'apartment', 'house'],
    'cleaning': ['clean', 'cleaning', 'maid', 'housekeeping', 'wash', 'laundry'],
    'repair': ['fix', 'repair', 'broken', 'plumber', 'electrician', 'handyman', 'maintenance'],
    'beauty': ['haircut', 'hair', 'makeup', 'nails', 'beauty', 'salon', 'barber'],
    'tutoring': ['teach', 'tutor', 'tutoring', 'lesson', 'class', 'education', 'learn'],
    'photography': ['photo', 'photographer', 'photography', 'video', 'videographer', 'shoot'],
    'catering': ['cook', 'chef', 'catering', 'food preparation', 'event'],
    'errand': ['errand', 'task', 'help', 'assistant', 'shopping'],
  };

  // Location indicators
  static const List<String> _locationIndicators = [
    'from', 'to', 'at', 'in', 'near', 'around', 'downtown', 'center',
    'marjane', 'carrefour', 'mall', 'airport', 'station', 'hospital',
    'hotel', 'restaurant', 'cafe', 'home', 'house', 'apartment', 'office',
    'school', 'university', 'mosque', 'church', 'market', 'souk',
  ];

  // Time indicators
  static const List<String> _timeIndicators = [
    'today', 'tomorrow', 'now', 'asap', 'urgent', 'morning', 'afternoon',
    'evening', 'night', 'am', 'pm', 'o\'clock', 'hour', 'minute',
    'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday',
  ];

  /// Parse a natural language request
  Future<RequestConciergeResponse> parseRequest(
    Session session,
    RequestConciergeInput input,
  ) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      final text = input.naturalLanguageRequest.toLowerCase().trim();
      
      if (text.isEmpty || text.length < 5) {
        stopwatch.stop();
        return RequestConciergeResponse(
          status: AgentResponseStatus.needsClarification,
          processingTimeMs: stopwatch.elapsedMilliseconds,
          originalInput: input.naturalLanguageRequest,
          confidence: ConfidenceLevel.low,
          clarifyingQuestions: [
            ClarifyingQuestion(
              question: 'Could you please describe what service you need in more detail?',
              field: 'description',
              isRequired: true,
            ),
          ],
        );
      }

      // Step 1: Detect service category
      final detectedCategory = _detectServiceCategory(text);
      
      // Step 2: ELSER-powered hybrid semantic search (BM25 + ELSER via RRF)
      // KEY DIFFERENTIATOR: understands intent, not just keywords
      // e.g., "move heavy things" → matches "Furniture Moving Service"
      // e.g., "need ride to airport" → matches "Airport Transfer"
      SmartSearchResult? smartResults;
      try {
        smartResults = await _searchService.smartSearch(
          session,
          query: text,
          language: input.language,
          types: ['services', 'knowledge'],
          sizePerType: 5,
        );
        print('[Concierge] 🧠 ELSER semantic search: ${smartResults.services.length} services, ${smartResults.knowledge.length} KB hits');
      } catch (e) {
        print('[Concierge] ⚠️ ELSER search failed, using BM25 fallback: $e');
      }

      // Extract knowledge base results for RAG contextual enrichment
      final knowledgeHits = smartResults?.knowledge ?? [];

      // Convert ELSER results to ServiceSearchHit for unified processing,
      // or fall back to BM25-only search if ELSER is unavailable
      final List<ServiceSearchHit> serviceHits;
      final bool usedSemanticSearch;
      if (smartResults != null && smartResults.services.isNotEmpty) {
        serviceHits = _convertSmartHitsToServiceHits(smartResults.services);
        usedSemanticSearch = true;
      } else {
        final fallback = await _searchService.searchServices(
          session,
          query: text,
          language: input.language,
          size: 5,
        );
        serviceHits = fallback.hits;
        usedSemanticSearch = false;
        print('[Concierge] 📝 BM25 fallback: ${serviceHits.length} results');
      }

      // Step 3: Extract locations
      final locations = _extractLocations(text);
      
      // Step 4: Detect urgency and timing
      final isUrgent = _detectUrgency(text);
      final scheduledTime = _detectScheduledTime(text);

      // Step 5: Build the parsed request
      ParsedServiceRequest? parsedRequest;
      ConfidenceLevel confidence;
      final clarifyingQuestions = <ClarifyingQuestion>[];
      List<Map<String, dynamic>>? similarServices;

      if (serviceHits.isNotEmpty) {
        final topService = serviceHits.first;
        confidence = topService.score > 5.0 
            ? ConfidenceLevel.high 
            : (topService.score > 2.0 
                ? ConfidenceLevel.medium 
                : ConfidenceLevel.low);

        // Build location objects
        ParsedLocation? pickupLocation;
        ParsedLocation? dropoffLocation;

        if (locations.isNotEmpty) {
          pickupLocation = ParsedLocation(
            originalText: locations.first,
            normalizedName: _normalizeLocationName(locations.first),
            latitude: input.userLatitude,
            longitude: input.userLongitude,
            placeType: _detectPlaceType(locations.first),
            confidence: 0.7,
          );
        }

        if (locations.length > 1) {
          dropoffLocation = ParsedLocation(
            originalText: locations[1],
            normalizedName: _normalizeLocationName(locations[1]),
            placeType: _detectPlaceType(locations[1]),
            confidence: 0.6,
          );
        }

        parsedRequest = ParsedServiceRequest(
          serviceId: topService.id,
          serviceName: _getServiceName(topService, input.language),
          categoryId: topService.categoryId,
          categoryName: topService.categoryName,
          pickupLocation: pickupLocation,
          dropoffLocation: dropoffLocation,
          description: input.naturalLanguageRequest,
          estimatedPrice: topService.suggestedPriceMin,
          priceMin: topService.suggestedPriceMin,
          priceMax: topService.suggestedPriceMax,
          priceType: 'negotiable',
          isUrgent: isUrgent,
          scheduledTime: scheduledTime,
        );

        // Add clarifying questions if needed
        if (locations.isEmpty) {
          clarifyingQuestions.add(ClarifyingQuestion(
            question: 'Where do you need this service?',
            field: 'location',
            suggestedOptions: ['My current location', 'Enter address'],
            isRequired: true,
          ));
        }

        if (detectedCategory == 'delivery' && locations.length < 2) {
          clarifyingQuestions.add(ClarifyingQuestion(
            question: 'Where should the items be delivered to?',
            field: 'dropoffLocation',
            isRequired: true,
          ));
        }

        // Include similar services for alternatives
        if (serviceHits.length > 1) {
          similarServices = serviceHits.skip(1).take(3).map((s) {
            return <String, dynamic>{
              'id': s.id,
              'name': _getServiceName(s, input.language),
              'categoryName': s.categoryName,
              'priceMin': s.suggestedPriceMin,
              'priceMax': s.suggestedPriceMax,
            };
          }).toList();
        }

        // Enrich with knowledge base context (RAG-style augmentation)
        if (knowledgeHits.isNotEmpty) {
          similarServices ??= [];
          for (final kb in knowledgeHits.take(2)) {
            similarServices.add({
              'id': 0,
              'name': kb.title,
              'categoryName': kb.category ?? 'help',
              'type': 'knowledge',
              'description': kb.description,
            });
          }
        }
      } else {
        // No service match found
        confidence = ConfidenceLevel.low;

        // Check if knowledge base has relevant answers
        if (knowledgeHits.isNotEmpty) {
          confidence = ConfidenceLevel.medium;
          similarServices = knowledgeHits.take(3).map((kb) {
            return <String, dynamic>{
              'id': 0,
              'name': kb.title,
              'categoryName': kb.category ?? 'help',
              'type': 'knowledge',
              'description': kb.description,
            };
          }).toList();
        }
        
        clarifyingQuestions.add(ClarifyingQuestion(
          question: 'I couldn\'t find an exact match for your request. What type of service are you looking for?',
          field: 'serviceCategory',
          suggestedOptions: ['Delivery', 'Transport/Ride', 'Moving', 'Cleaning', 'Repair', 'Other'],
          isRequired: true,
        ));
      }

      // Generate summary (includes search mode indicator)
      final summary = _generateSummary(parsedRequest, confidence, detectedCategory);
      final enrichedSummary = usedSemanticSearch
          ? '$summary\n\n_🧠 Powered by ELSER semantic understanding_'
          : summary;

      stopwatch.stop();
      return RequestConciergeResponse(
        status: clarifyingQuestions.isEmpty 
            ? AgentResponseStatus.success 
            : AgentResponseStatus.needsClarification,
        processingTimeMs: stopwatch.elapsedMilliseconds,
        originalInput: input.naturalLanguageRequest,
        parsedRequest: parsedRequest,
        confidence: confidence,
        clarifyingQuestions: clarifyingQuestions,
        summary: enrichedSummary,
        similarServices: similarServices,
      );
    } catch (e) {
      stopwatch.stop();
      return RequestConciergeResponse(
        status: AgentResponseStatus.failed,
        errorMessage: 'Failed to parse request: $e',
        processingTimeMs: stopwatch.elapsedMilliseconds,
        originalInput: input.naturalLanguageRequest,
        confidence: ConfidenceLevel.low,
      );
    }
  }

  /// Detect the service category from text
  String? _detectServiceCategory(String text) {
    for (final entry in _serviceKeywords.entries) {
      for (final keyword in entry.value) {
        if (text.contains(keyword)) {
          return entry.key;
        }
      }
    }
    return null;
  }

  /// Extract location mentions from text
  List<String> _extractLocations(String text) {
    final locations = <String>[];
    final words = text.split(RegExp(r'\s+'));
    
    // Look for location patterns
    for (int i = 0; i < words.length; i++) {
      final word = words[i].toLowerCase();
      
      // Check for known location indicators
      if (_locationIndicators.contains(word)) {
        // Try to capture the next few words as a location
        if (i + 1 < words.length) {
          final locationWords = <String>[];
          for (int j = i + 1; j < words.length && j < i + 4; j++) {
            final nextWord = words[j].toLowerCase();
            // Stop at prepositions or time indicators
            final stopWords = ['to', 'from', 'at', 'and', 'then', ..._timeIndicators];
            if (stopWords.contains(nextWord)) {
              break;
            }
            locationWords.add(words[j]);
          }
          if (locationWords.isNotEmpty) {
            locations.add(locationWords.join(' '));
          }
        }
      }
      
      // Check for known place names
      for (final place in ['marjane', 'carrefour', 'airport', 'station', 'mall']) {
        if (word.contains(place)) {
          locations.add(words[i]);
          break;
        }
      }
    }
    
    return locations.toSet().toList(); // Remove duplicates
  }

  /// Detect if the request is urgent
  bool _detectUrgency(String text) {
    final urgentKeywords = ['urgent', 'asap', 'emergency', 'now', 'immediately', 'right away', 'hurry'];
    return urgentKeywords.any((keyword) => text.contains(keyword));
  }

  /// Try to detect scheduled time from text
  DateTime? _detectScheduledTime(String text) {
    final now = DateTime.now();
    
    if (text.contains('tomorrow')) {
      // Check for time indicators
      final timeMatch = RegExp(r'(\d{1,2})(?::(\d{2}))?\s*(am|pm)?').firstMatch(text);
      if (timeMatch != null) {
        var hour = int.tryParse(timeMatch.group(1) ?? '0') ?? 0;
        final minute = int.tryParse(timeMatch.group(2) ?? '0') ?? 0;
        final period = timeMatch.group(3);
        
        if (period == 'pm' && hour < 12) hour += 12;
        if (period == 'am' && hour == 12) hour = 0;
        
        return DateTime(now.year, now.month, now.day + 1, hour, minute);
      }
      return DateTime(now.year, now.month, now.day + 1, 9, 0); // Default to 9 AM
    }
    
    if (text.contains('today')) {
      final timeMatch = RegExp(r'(\d{1,2})(?::(\d{2}))?\s*(am|pm)?').firstMatch(text);
      if (timeMatch != null) {
        var hour = int.tryParse(timeMatch.group(1) ?? '0') ?? 0;
        final minute = int.tryParse(timeMatch.group(2) ?? '0') ?? 0;
        final period = timeMatch.group(3);
        
        if (period == 'pm' && hour < 12) hour += 12;
        if (period == 'am' && hour == 12) hour = 0;
        
        return DateTime(now.year, now.month, now.day, hour, minute);
      }
    }
    
    return null; // No specific time detected
  }

  /// Normalize location name
  String _normalizeLocationName(String location) {
    return location
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .trim()
        .split(' ')
        .map((w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : w)
        .join(' ');
  }

  /// Detect the type of place
  String _detectPlaceType(String location) {
    final loc = location.toLowerCase();
    
    if (['marjane', 'carrefour', 'store', 'shop', 'market', 'souk'].any((p) => loc.contains(p))) {
      return 'store';
    }
    if (['airport', 'station', 'gare'].any((p) => loc.contains(p))) {
      return 'transport_hub';
    }
    if (['home', 'house', 'apartment', 'my place'].any((p) => loc.contains(p))) {
      return 'residence';
    }
    if (['office', 'work', 'company'].any((p) => loc.contains(p))) {
      return 'office';
    }
    if (['restaurant', 'cafe', 'coffee'].any((p) => loc.contains(p))) {
      return 'food_establishment';
    }
    
    return 'unknown';
  }

  /// Get service name in the appropriate language
  String _getServiceName(ServiceSearchHit service, String language) {
    switch (language) {
      case 'ar':
        return service.nameAr ?? service.nameEn;
      case 'fr':
        return service.nameFr ?? service.nameEn;
      case 'es':
        return service.nameEs ?? service.nameEn;
      default:
        return service.nameEn;
    }
  }

  /// Generate a human-readable summary
  String _generateSummary(
    ParsedServiceRequest? request,
    ConfidenceLevel confidence,
    String? detectedCategory,
  ) {
    if (request == null) {
      return 'I need more information to understand your request. '
             'Please provide more details about the service you need.';
    }

    final buffer = StringBuffer();
    
    buffer.write('I understand you need ');
    buffer.write('**${request.serviceName ?? detectedCategory ?? "a service"}**');
    
    if (request.pickupLocation != null) {
      buffer.write(' from ${request.pickupLocation!.originalText}');
    }
    
    if (request.dropoffLocation != null) {
      buffer.write(' to ${request.dropoffLocation!.originalText}');
    }
    
    buffer.write('.');
    
    if (request.isUrgent) {
      buffer.write(' 🔴 **Marked as urgent.**');
    }
    
    if (request.scheduledTime != null) {
      buffer.write(' ⏰ Scheduled for ${_formatDateTime(request.scheduledTime!)}.');
    }
    
    if (request.estimatedPrice != null) {
      buffer.write('\n\n💰 **Estimated price:** ${request.priceMin?.toStringAsFixed(0) ?? "?"} - ${request.priceMax?.toStringAsFixed(0) ?? "?"} MAD');
    }
    
    buffer.write('\n\n');
    buffer.write('_Confidence: ${confidence.description}_');
    
    return buffer.toString();
  }

  String _formatDateTime(DateTime dt) {
    final now = DateTime.now();
    final isToday = dt.year == now.year && dt.month == now.month && dt.day == now.day;
    final isTomorrow = dt.year == now.year && dt.month == now.month && dt.day == now.day + 1;
    
    final timeStr = '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    
    if (isToday) return 'today at $timeStr';
    if (isTomorrow) return 'tomorrow at $timeStr';
    return '${dt.day}/${dt.month}/${dt.year} at $timeStr';
  }

  // ============================================
  // ELSER INTEGRATION HELPERS
  // ============================================

  /// Convert ELSER SmartSearchHit results to ServiceSearchHit for unified processing.
  /// RRF scores (0.01-0.03 range) are rescaled to match BM25 threshold expectations.
  /// This enables seamless fallback between ELSER semantic and BM25 keyword search.
  List<ServiceSearchHit> _convertSmartHitsToServiceHits(List<SmartSearchHit> hits) {
    return hits.map((h) => ServiceSearchHit(
      id: h.id,
      categoryId: h.raw['categoryId'] as int? ?? 0,
      categoryName: h.category,
      nameEn: h.raw['nameEn'] as String? ?? h.title,
      nameAr: h.raw['nameAr'] as String?,
      nameFr: h.raw['nameFr'] as String?,
      nameEs: h.raw['nameEs'] as String?,
      descriptionEn: h.raw['descriptionEn'] as String? ?? h.description,
      iconName: h.raw['iconName'] as String?,
      imageUrl: h.imageUrl,
      suggestedPriceMin: h.price,
      suggestedPriceMax: h.priceMax,
      isActive: h.raw['isActive'] as bool? ?? true,
      isPopular: h.raw['isPopular'] as bool? ?? false,
      // RRF scores ~0.01-0.033 → rescale ×200 to match BM25 thresholds (2.0/5.0)
      score: h.score * 200.0,
    )).toList();
  }
}
