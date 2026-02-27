import 'dart:convert';

import 'package:awhar_client/awhar_client.dart';
import 'package:flutter/foundation.dart';

/// Entity types that can be extracted from Agent Builder tool outputs.
enum EntityType { service, store, product, category, driver, order, helpArticle, platform }

/// A parsed entity from an agent tool output.
///
/// Each entity represents a real ES document (service, store, driver, etc.)
/// the agent found via its ES|QL tools.
class ParsedEntity {
  final EntityType type;
  final String name;
  final String? description;
  final String? city;
  final double? price;
  final double? priceMin;
  final double? priceMax;
  final double? rating;
  final String? category;
  final int? popularity;
  final bool? isActive;
  final String? imageUrl;
  final String? phone;
  final String? address;
  final String? storeName;
  final int? count;
  final int? entityId;
  final Map<String, dynamic> raw;

  const ParsedEntity({
    required this.type,
    required this.name,
    this.description,
    this.city,
    this.price,
    this.priceMin,
    this.priceMax,
    this.rating,
    this.category,
    this.popularity,
    this.isActive,
    this.imageUrl,
    this.phone,
    this.address,
    this.storeName,
    this.count,
    this.entityId,
    this.raw = const {},
  });
}

/// Result of parsing all tool outputs from an agent response.
class ParsedEntities {
  final List<ParsedEntity> entities;

  /// Which tool produced these entities.
  final String toolName;

  const ParsedEntities({
    required this.entities,
    required this.toolName,
  });

  bool get isEmpty => entities.isEmpty;
  bool get isNotEmpty => entities.isNotEmpty;
}

/// Parses [AgentBuilderStep] tool outputs into typed [ParsedEntity] lists.
///
/// Maps each tool name to a specific entity type:
/// - `search_services`, `category_services`, `popular_services`, `price_filter` → services
/// - `browse_categories` → categories
/// - `search_stores`, `stores_by_city` → stores
/// - `help_articles`, `help_by_category` → help articles
/// - `platform_overview` → platform info
class EntityParser {
  EntityParser._();

  // ============================================
  // SMART CARD FILTERING
  // ============================================

  /// Tools whose results should always be shown as entity cards.
  /// These are user-facing search/browse tools.
  static const _alwaysShowCards = {
    'search_services', 'category_services', 'popular_services', 'price_filter',
    'search_products', 'store_products', 'products_by_category', 'product_categories',
    'browse_categories',
    'search_stores', 'stores_by_city',
    'help_articles', 'help_by_category',
  };

  /// Tools whose results should NEVER be shown as cards.
  /// These are internal context-gathering tools the agent calls automatically.
  static const _neverShowCards = {
    'user_profile',       // Auto-called on first message for context
    'platform_overview',  // Stats only, not card-worthy
    'search',             // platform.core.search — raw internal query
    'execute_esql',       // platform.core.execute_esql — raw internal query
    'generate_esql',      // platform.core.generate_esql — query generation
    'get_index_mapping',  // platform.core — schema introspection
    'list_indices',       // platform.core — index listing
    'index_explorer',     // platform.core — index browsing
  };

  /// Tools that should show cards ONLY when they are the primary action
  /// (not when paired with other context tools in the same response).
  static const _contextualShowCards = {
    'user_orders',  // Show only if user explicitly asked about orders
  };

  /// Decide if a tool's output should generate entity cards.
  ///
  /// Logic:
  /// 1. Always-show tools → show
  /// 2. Never-show tools → skip
  /// 3. Contextual tools → show only if no "always-show" tools are present
  ///    (meaning the user specifically asked for this data)
  /// 4. Unknown tools → show (forward-compatible)
  static bool _shouldShowCards(String toolName, Set<String> allToolsInResponse) {
    if (_alwaysShowCards.contains(toolName)) return true;
    if (_neverShowCards.contains(toolName)) return false;
    if (_contextualShowCards.contains(toolName)) {
      // Show order cards ONLY if no other "always-show" tool was called,
      // meaning the user specifically asked about their orders
      final hasExplicitUserTool = allToolsInResponse.any(_alwaysShowCards.contains);
      return !hasExplicitUserTool;
    }
    // Unknown tool → show by default (forward-compatible)
    return true;
  }

  // ============================================
  // MAIN EXTRACTION
  // ============================================

  /// Extract all entities from agent steps.
  ///
  /// Returns a list of [ParsedEntities] groups — one per tool call
  /// that produced parseable entity data.
  ///
  /// Smart filtering ensures only user-relevant results become cards:
  /// - `user_profile` (auto-called for context) → never shows cards
  /// - `user_orders` (auto-called on first msg) → only shows if user asked
  /// - `platform.core.*` tools → never shows cards
  static List<ParsedEntities> extractAll(List<AgentBuilderStep>? steps) {
    if (steps == null || steps.isEmpty) {
      debugPrint('[EntityParser] No steps to parse');
      return [];
    }

    debugPrint('');
    debugPrint('[EntityParser] ========================================');
    debugPrint('[EntityParser] PARSING ${steps.length} STEPS');
    debugPrint('[EntityParser] ========================================');

    // First pass: collect all tool names to make smart filtering decisions
    final allToolNames = <String>{};
    for (final step in steps) {
      if (step.toolName != null) {
        allToolNames.add(_normalizeToolName(step.toolName!));
      }
    }
    debugPrint('[EntityParser] All tools in response: $allToolNames');

    final results = <ParsedEntities>[];

    for (int i = 0; i < steps.length; i++) {
      final step = steps[i];
      final rawToolName = step.toolName ?? 'unknown';
      final toolName = _normalizeToolName(rawToolName);

      debugPrint('');
      debugPrint('[EntityParser] --- Step[$i] ---');
      debugPrint('[EntityParser]   type=${step.type}');
      debugPrint('[EntityParser]   rawToolName=$rawToolName');
      debugPrint('[EntityParser]   normalizedTool=$toolName');
      debugPrint('[EntityParser]   hasOutput=${step.toolOutput != null} (${step.toolOutput?.length ?? 0} chars)');
      debugPrint('[EntityParser]   hasText=${step.text != null}');

      // Smart filtering: decide if this tool should produce cards
      if (!_shouldShowCards(toolName, allToolNames)) {
        final reason = _neverShowCards.contains(toolName)
            ? 'in never-show list'
            : 'contextual tool suppressed (other primary tools present)';
        debugPrint('[EntityParser]   SKIPPED: $reason');
        continue;
      }

      // Try toolOutput first, fall back to text field
      final rawData = step.toolOutput ?? step.text;
      if (rawData == null || rawData.isEmpty) {
        debugPrint('[EntityParser]   SKIPPED: no data');
        continue;
      }

      // Log data preview
      final preview = rawData.length > 400 ? '${rawData.substring(0, 400)}...' : rawData;
      debugPrint('[EntityParser]   data: $preview');

      final entities = _parseToolOutput(toolName, rawData);
      debugPrint('[EntityParser]   → parsed ${entities.length} entities');

      if (entities.isNotEmpty) {
        // Log each entity summary
        for (int j = 0; j < entities.length; j++) {
          final e = entities[j];
          debugPrint('[EntityParser]   entity[$j]: type=${e.type.name}, '
              'id=${e.entityId}, name="${e.name}", price=${e.price ?? e.priceMin}, '
              'category=${e.category}, store=${e.storeName}, img=${e.imageUrl != null}');
        }
        results.add(ParsedEntities(
          entities: entities,
          toolName: toolName,
        ));
      }
    }

    debugPrint('');
    debugPrint('[EntityParser] ========================================');
    debugPrint('[EntityParser] RESULT: ${results.length} entity groups, '
        '${results.fold<int>(0, (sum, g) => sum + g.entities.length)} total entities');
    debugPrint('[EntityParser] ========================================');
    debugPrint('');
    return results;
  }

  /// Normalize tool name by stripping common prefixes.
  static String _normalizeToolName(String name) {
    return name
        .replaceAll('awhar.concierge.', '')
        .replaceAll('awhar_concierge_', '')
        .replaceAll('platform.core.', '')
        .replaceAll('platform_core_', '')
        .replaceAll('awhar.', '')
        .replaceAll('awhar_', '')
        .replaceAll('concierge.', '')
        .toLowerCase()
        .trim();
  }

  /// Map tool name → entity type.
  static EntityType _entityTypeForTool(String tool) {
    // Order matters: more specific checks first
    if (tool.contains('product_categor')) return EntityType.category;
    if (tool.contains('browse_categor')) return EntityType.category;
    if (tool.contains('categor') && !tool.contains('product') && !tool.contains('service') && !tool.contains('store')) {
      return EntityType.category;
    }
    if (tool.contains('product') || tool.contains('menu')) return EntityType.product;
    if (tool.contains('service') || tool.contains('price_filter') || tool.contains('popular')) {
      return EntityType.service;
    }
    if (tool.contains('store') || tool.contains('shop') || tool.contains('restaurant')) {
      return EntityType.store;
    }
    if (tool.contains('order') || tool.contains('request')) return EntityType.order;
    if (tool.contains('driver') || tool.contains('match')) return EntityType.driver;
    if (tool.contains('help') || tool.contains('article') || tool.contains('knowledge')) {
      return EntityType.helpArticle;
    }
    if (tool.contains('platform') || tool.contains('overview')) {
      return EntityType.platform;
    }
    if (tool.contains('user') || tool.contains('profile')) {
      return EntityType.platform; // user profile → platform info
    }
    // For generic platform tools (search, execute_esql, generate_esql),
    // the entity type will be inferred from the actual data later
    return EntityType.service; // default — will be re-inferred from data
  }

  /// Infer entity type from the data fields themselves.
  static EntityType _inferEntityType(Map<String, dynamic> map) {
    // Product: has price + storeName (product in a store)
    if (map.containsKey('productId') ||
        (map.containsKey('price') && map.containsKey('storeName') && !map.containsKey('rating'))) {
      return EntityType.product;
    }
    // Service: has nameEn + suggestedPriceMin
    if (map.containsKey('nameEn') && map.containsKey('suggestedPriceMin')) {
      return EntityType.service;
    }
    // Store: has rating or hasDelivery (store-specific fields)
    if (map.containsKey('hasDelivery') || map.containsKey('hasPickup') ||
        (map.containsKey('rating') && map.containsKey('minimumOrderAmount'))) {
      return EntityType.store;
    }
    // Order: has serviceType + status
    if (map.containsKey('serviceType') && map.containsKey('status')) {
      return EntityType.order;
    }
    // Driver: has vehicleType or driverId
    if (map.containsKey('driverId') ||
        (map.containsKey('displayName') && map.containsKey('vehicleType'))) {
      return EntityType.driver;
    }
    // Category: has category-aggregate fields (serviceCount, product_count)
    if ((map.containsKey('serviceCount') || map.containsKey('product_count')) &&
        map.containsKey('categoryName')) {
      return EntityType.category;
    }
    if (map.containsKey('categoryNameEn') && !map.containsKey('nameEn')) {
      return EntityType.category;
    }
    // User profile
    if (map.containsKey('fullName') || map.containsKey('userId')) {
      return EntityType.platform;
    }
    return EntityType.service;
  }

  /// Parse a single tool output into entities.
  static List<ParsedEntity> _parseToolOutput(String toolName, String rawOutput) {
    try {
      final entityType = _entityTypeForTool(toolName);
      debugPrint('[EntityParser]   toolType=$toolName → entityType=${entityType.name}');

      // Try to parse as JSON
      dynamic parsed;
      try {
        parsed = jsonDecode(rawOutput);
        debugPrint('[EntityParser]   JSON parsed OK: ${parsed.runtimeType}');
      } catch (e) {
        debugPrint('[EntityParser]   JSON parse failed: $e');
        // Try to extract JSON from within the string
        final jsonMatch = RegExp(r'\{[\s\S]*\}|\[[\s\S]*\]').firstMatch(rawOutput);
        if (jsonMatch != null) {
          try {
            parsed = jsonDecode(jsonMatch.group(0)!);
            debugPrint('[EntityParser]   Extracted embedded JSON: ${parsed.runtimeType}');
          } catch (_) {
            debugPrint('[EntityParser]   Embedded JSON also failed');
            return [];
          }
        } else {
          debugPrint('[EntityParser]   No JSON found in output');
          return [];
        }
      }

      // Handle double-encoded JSON
      if (parsed is String) {
        debugPrint('[EntityParser]   Double-encoded JSON detected, decoding again...');
        try {
          parsed = jsonDecode(parsed);
        } catch (_) {
          debugPrint('[EntityParser]   Second decode failed');
          return [];
        }
      }

      if (parsed is Map<String, dynamic>) {
        debugPrint('[EntityParser]   Parsing as Map (keys: ${parsed.keys.toList()})');
        return _parseMapOutput(parsed, entityType);
      } else if (parsed is List) {
        debugPrint('[EntityParser]   Parsing as List (${parsed.length} items)');
        return _parseListOutput(parsed, entityType);
      }

      debugPrint('[EntityParser]   Unexpected parsed type: ${parsed.runtimeType}');
      return [];
    } catch (e) {
      debugPrint('[EntityParser] Error parsing tool output for $toolName: $e');
      return [];
    }
  }

  /// Parse a map-format output (ES|QL style with columns + values).
  static List<ParsedEntity> _parseMapOutput(
      Map<String, dynamic> data, EntityType entityType) {
    // tabular_data wrapper: {type: "tabular_data", data: {columns: [...], values: [...]}}
    if (data['type'] == 'tabular_data' && data.containsKey('data')) {
      final inner = data['data'];
      if (inner is Map<String, dynamic>) {
        return _parseMapOutput(inner, entityType);
      }
    }

    // ES|QL format: {"columns": [...], "values": [[...], ...]}
    // Also handles: {"source": "esql", "query": "...", "columns": [...], "values": [...]}
    if (data.containsKey('columns') && data.containsKey('values')) {
      return _parseEsqlResult(data, entityType);
    }

    // Direct object format: single entity - check for ANY recognizable field
    if (_looksLikeEntity(data)) {
      // Re-infer entity type from actual fields if tool name was unknown
      final inferredType = _inferEntityType(data);
      return [_mapToEntity(data, inferredType)];
    }

    // Resource format from platform.core.search: {"reference": {...}, "content": {"highlights": [...]}}
    if (data.containsKey('reference') && data.containsKey('content')) {
      final content = data['content'] as Map<String, dynamic>?;
      final highlights = content?['highlights'] as List?;
      if (highlights != null && highlights.isNotEmpty) {
        // Extract name from first highlight (format: "Name. Description. Category. Store")
        final firstHighlight = highlights.first.toString();
        final parts = firstHighlight.split('. ');
        if (parts.isNotEmpty) {
          return [ParsedEntity(
            type: entityType,
            name: parts[0],
            description: parts.length > 1 ? parts.sublist(1).join('. ') : null,
            raw: data,
          )];
        }
      }
      return [];
    }

    // Nested result: {"results": [...]}
    if (data.containsKey('results') && data['results'] is List) {
      return _parseListOutput(data['results'] as List, entityType);
    }

    // Nested data: {"data": [...]}
    if (data.containsKey('data') && data['data'] is List) {
      return _parseListOutput(data['data'] as List, entityType);
    }

    // Nested hits: {"hits": {"hits": [...]}}
    if (data.containsKey('hits') && data['hits'] is Map) {
      final hits = data['hits'] as Map<String, dynamic>;
      if (hits.containsKey('hits') && hits['hits'] is List) {
        final hitsList = (hits['hits'] as List)
            .whereType<Map<String, dynamic>>()
            .map((h) => (h['_source'] as Map<String, dynamic>?) ?? h)
            .toList();
        return _parseListOutput(hitsList, entityType);
      }
    }

    debugPrint('[EntityParser] Map had keys ${data.keys.toList()} but no parseable structure');
    return [];
  }

  /// Check if a map looks like an entity (has any known field).
  static bool _looksLikeEntity(Map<String, dynamic> data) {
    const knownFields = [
      'name', 'title', 'nameEn', 'nameAr', 'nameFr', 'nameEs',
      'displayName', 'fullName', 'service_name', 'store_name', 'driver_name',
      'storeName', 'categoryName', 'categoryNameEn',
      'clientName', 'driverName', 'article_title', 'label',
      // Aggregate fields that indicate a category row
      'serviceCount', 'product_count',
    ];
    return knownFields.any((f) => data.containsKey(f));
  }

  /// Parse ES|QL columnar format into entities.
  static List<ParsedEntity> _parseEsqlResult(
      Map<String, dynamic> data, EntityType entityType) {
    final columns = (data['columns'] as List)
        .map((c) => (c as Map<String, dynamic>)['name']?.toString() ?? '')
        .toList();
    final values = data['values'] as List;

    debugPrint('[EntityParser]   ES|QL: ${columns.length} cols × ${values.length} rows');
    debugPrint('[EntityParser]   columns: $columns');

    // Re-infer entity type from column names if tool was generic
    final inferredType = _inferEntityTypeFromColumns(columns, entityType);
    if (inferredType != entityType) {
      debugPrint('[EntityParser]   type re-inferred: ${entityType.name} → ${inferredType.name}');
    }

    final entities = <ParsedEntity>[];

    for (int rowIdx = 0; rowIdx < values.length; rowIdx++) {
      final row = values[rowIdx];
      if (row is! List) {
        debugPrint('[EntityParser]   row[$rowIdx] SKIP: not a List (${row.runtimeType})');
        continue;
      }
      final map = <String, dynamic>{};
      for (int i = 0; i < columns.length && i < row.length; i++) {
        map[columns[i]] = row[i];
      }
      if (rowIdx < 3) { // Log first 3 rows for debugging
        debugPrint('[EntityParser]   row[$rowIdx]: $map');
      }
      entities.add(_mapToEntity(map, inferredType));
    }

    return entities;
  }

  /// Infer entity type from ES|QL column names.
  static EntityType _inferEntityTypeFromColumns(List<String> columns, EntityType fallback) {
    final joined = columns.join(' ').toLowerCase();
    // Product: has productId or (price + storeName)
    if (joined.contains('productid') ||
        (joined.contains('price') && joined.contains('storename') && !joined.contains('rating'))) {
      return EntityType.product;
    }
    // Category aggregate: has serviceCount or product_count with categoryName
    if ((joined.contains('servicecount') || joined.contains('product_count')) &&
        joined.contains('categoryname')) {
      return EntityType.category;
    }
    // Store: has rating, hasdelivery etc.
    if (joined.contains('hasdelivery') || joined.contains('haspickup') ||
        (joined.contains('rating') && joined.contains('minimumorderamount'))) {
      return EntityType.store;
    }
    // Order: has serviceType + status
    if (joined.contains('servicetype') && joined.contains('status')) {
      return EntityType.order;
    }
    if (joined.contains('driverid') || joined.contains('vehicletype')) return EntityType.driver;
    if (joined.contains('categoryname') && !joined.contains('nameen') && !joined.contains('price')) {
      return EntityType.category;
    }
    if (joined.contains('suggestedpricemin') || joined.contains('nameen')) return EntityType.service;
    return fallback;
  }

  /// Parse a list of items.
  static List<ParsedEntity> _parseListOutput(
      List items, EntityType entityType) {
    final entities = <ParsedEntity>[];

    for (final item in items) {
      if (item is! Map<String, dynamic>) continue;

      // Check if this is a resource-format item with reference + content
      if (item.containsKey('reference') && item.containsKey('content')) {
        final content = item['content'] as Map<String, dynamic>?;
        final highlights = content?['highlights'] as List?;
        if (highlights != null && highlights.isNotEmpty) {
          final firstHighlight = highlights.first.toString();
          final parts = firstHighlight.split('. ');
          if (parts.isNotEmpty) {
            entities.add(ParsedEntity(
              type: entityType,
              name: parts[0],
              description: parts.length > 1 ? parts.sublist(1).join('. ') : null,
              raw: item,
            ));
          }
        }
        continue;
      }

      // Check for Kibana tool result wrappers.
      // Tool results come as a list of items with {type, data, tool_result_id}.
      // Types: "query" (just the ES|QL string), "esql_results" (actual data),
      //        "tabular_data" (alternative format).
      if (item.containsKey('type') && item.containsKey('data')) {
        final wrapperType = item['type']?.toString() ?? '';
        final innerData = item['data'];

        // Skip "query" type — it's just the ES|QL query string, not results
        if (wrapperType == 'query') {
          debugPrint('[EntityParser]     Skipping wrapper type="query" (ES|QL query text)');
          continue;
        }

        // "esql_results" or "tabular_data" — unwrap and parse the inner data
        if ((wrapperType == 'esql_results' || wrapperType == 'tabular_data') &&
            innerData is Map<String, dynamic>) {
          debugPrint('[EntityParser]     Unwrapping "$wrapperType" wrapper → parsing inner data');
          entities.addAll(_parseMapOutput(innerData, entityType));
          continue;
        }

        // Generic wrapper with a list inside
        if (innerData is List) {
          debugPrint('[EntityParser]     Unwrapping "$wrapperType" wrapper → parsing inner list');
          entities.addAll(_parseListOutput(innerData, entityType));
          continue;
        }

        // Unknown wrapper with map data — try to parse it
        if (innerData is Map<String, dynamic>) {
          debugPrint('[EntityParser]     Unwrapping "$wrapperType" wrapper → parsing inner map');
          entities.addAll(_parseMapOutput(innerData, entityType));
          continue;
        }
      }

      // Check if this item has tool_result_id (Kibana wrapper) but no recognizable
      // entity fields — skip it rather than creating an "Unknown" entity
      if (item.containsKey('tool_result_id') && !_looksLikeEntity(item)) {
        debugPrint('[EntityParser]     Skipping tool_result wrapper (no entity fields)');
        continue;
      }

      // Regular entity map
      entities.add(_mapToEntity(item, entityType));
    }

    return entities;
  }

  /// Convert a flat key-value map to a [ParsedEntity].
  ///
  /// Handles actual ES field names: nameEn, nameAr, nameFr, nameEs,
  /// displayName, categoryNameEn, suggestedPriceMin, suggestedPriceMax, etc.
  static ParsedEntity _mapToEntity(
      Map<String, dynamic> map, EntityType entityType) {
    // Name resolution with logging
    final nameKeys = [
      'nameEn', 'nameAr', 'nameFr', 'nameEs',
      'name', 'storeName',
      'displayName',
      'fullName',
      'clientName', 'driverName',
      'title', 'service_name', 'store_name', 'driver_name',
      'category_name', 'article_title', 'label',
      'categoryNameEn', 'categoryNameAr', 'categoryNameFr', 'categoryName',
    ];
    final resolvedName = _firstString(map, nameKeys);
    final name = resolvedName ?? _fallbackName(map);

    // Log name resolution for debugging
    if (resolvedName != null) {
      // Find which key matched
      final matchedKey = nameKeys.firstWhere(
        (k) => map[k] != null && map[k].toString().isNotEmpty,
        orElse: () => '?',
      );
      debugPrint('[EntityParser]     → name="$name" (from key: $matchedKey)');
    } else {
      debugPrint('[EntityParser]     → name="$name" (FALLBACK! keys: ${map.keys.toList()})');
    }

    return ParsedEntity(
      type: entityType,
      name: name,
      description: _firstString(map, [
        'descriptionEn', 'descriptionAr', 'descriptionFr', 'descriptionEs',
        'description', 'details', 'summary', 'content', 'article_content',
        'bio', 'tagline', 'aboutText',
      ]),
      city: _firstString(map, [
        'city', 'baseCityName', 'location', 'address_city',
      ]),
      price: _firstDouble(map, [
        'price', 'basePrice', 'base_price', 'avg_price',
        'minimumOrderAmount', 'price_amount',
      ]),
      priceMin: _firstDouble(map, [
        'suggestedPriceMin', 'price_min', 'min_price', 'price_range_min',
      ]),
      priceMax: _firstDouble(map, [
        'suggestedPriceMax', 'price_max', 'max_price', 'price_range_max',
      ]),
      rating: _firstDouble(map, [
        'rating', 'ratingAverage', 'avg_rating', 'average_rating', 'driver_rating',
      ]),
      category: _firstString(map, [
        'categoryNameEn', 'categoryNameAr', 'categoryNameFr', 'categoryNameEs',
        'categoryName', 'category', 'service_category', 'type', 'storeType',
      ]),
      popularity: _firstInt(map, [
        'totalOrders', 'totalCompletedOrders', 'popularity',
        'order_count', 'total_orders', 'request_count', 'service_count',
        'productCount',
      ]),
      isActive: map['isActive'] as bool? ?? map['is_active'] as bool?
          ?? map['active'] as bool? ?? map['isAvailable'] as bool?,
      imageUrl: _firstString(map, [
        'imageUrl', 'logoUrl', 'coverImageUrl', 'storeLogoUrl', 'profilePhotoUrl',
      ]),
      phone: _firstString(map, [
        'phone', 'whatsappNumber', 'phone_number', 'contact',
      ]),
      address: _firstString(map, [
        'address', 'full_address', 'street',
      ]),
      storeName: _firstString(map, [
        'storeName', 'store_name',
      ]),
      count: _firstInt(map, [
        'serviceCount', 'product_count', 'totalOrders', 'totalCompletedOrders',
        'count', 'total', 'order_count',
      ]),
      entityId: _firstInt(map, [
        'id', 'storeId', 'productId', 'serviceId', 'driverId',
        'store_id', 'product_id', 'service_id', 'driver_id',
        'orderId', 'requestId',
      ]),
      raw: map,
    );
  }

  /// Smart fallback: find first non-null string value that looks like a name.
  static String _fallbackName(Map<String, dynamic> map) {
    // Try any string value that isn't a date, boolean, or very long
    for (final entry in map.entries) {
      final val = entry.value;
      if (val is String && val.isNotEmpty && val.length < 100) {
        // Skip fields that are clearly not names
        final key = entry.key.toLowerCase();
        if (key.contains('date') || key.contains('time') || key.contains('at') ||
            key.contains('id') || key.contains('url') || key.contains('email') ||
            key.contains('phone') || key.contains('source') || key.contains('query') ||
            key.contains('type') || key.contains('language') || key.contains('currency')) {
          continue;
        }
        return val;
      }
    }
    return 'Unknown';
  }

  /// Get first non-null string value from multiple candidate keys.
  static String? _firstString(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final val = map[key];
      if (val != null && val.toString().isNotEmpty) {
        return val.toString();
      }
    }
    return null;
  }

  /// Get first non-null double from candidate keys.
  static double? _firstDouble(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final val = map[key];
      if (val is num) return val.toDouble();
      if (val is String) {
        final parsed = double.tryParse(val);
        if (parsed != null) return parsed;
      }
    }
    return null;
  }

  /// Get first non-null int from candidate keys.
  static int? _firstInt(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final val = map[key];
      if (val is int) return val;
      if (val is num) return val.toInt();
      if (val is String) {
        final parsed = int.tryParse(val);
        if (parsed != null) return parsed;
      }
    }
    return null;
  }
}
