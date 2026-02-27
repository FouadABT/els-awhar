/// Elasticsearch Module
///
/// Export all Elasticsearch-related classes from a single entry point.
/// 
/// Usage:
/// ```dart
/// import 'package:awhar_server/src/services/elasticsearch/elasticsearch.dart';
/// ```

// Core
export 'elasticsearch_config.dart';
export 'elasticsearch_client.dart';
export 'elasticsearch_exceptions.dart';
export 'elasticsearch_service.dart';
export 'elasticsearch_index_mappings.dart';

// Sync & Transform
export 'elasticsearch_sync_service.dart';
export 'elasticsearch_transformer.dart';
export 'elasticsearch_session_extension.dart';

// Search
export 'elasticsearch_search_service.dart';

// Document DTOs
export 'documents/documents.dart';
