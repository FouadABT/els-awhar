/// Elasticsearch Client Service
///
/// Core client for communicating with Elasticsearch Cloud.
/// Handles all HTTP requests to Elasticsearch with proper authentication.

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'elasticsearch_config.dart';
import 'elasticsearch_exceptions.dart';

/// Main Elasticsearch client for Awhar
class ElasticsearchClient {
  final ElasticsearchConfig config;
  final http.Client _httpClient;

  ElasticsearchClient({
    required this.config,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// Test connection to Elasticsearch cluster
  /// Returns cluster info if successful
  Future<Map<String, dynamic>> testConnection() async {
    try {
      final response = await _httpClient.get(
        Uri.parse(config.infoUrl),
        headers: config.headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw ElasticsearchConnectionException(
          'Failed to connect to Elasticsearch: ${response.statusCode}',
          statusCode: response.statusCode,
          body: response.body,
        );
      }
    } catch (e) {
      if (e is ElasticsearchException) rethrow;
      throw ElasticsearchConnectionException(
        'Failed to connect to Elasticsearch: $e',
      );
    }
  }

  /// Get cluster health status
  Future<Map<String, dynamic>> getClusterHealth() async {
    try {
      final response = await _httpClient.get(
        Uri.parse(config.healthUrl),
        headers: config.headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw ElasticsearchException(
          'Failed to get cluster health: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ElasticsearchException) rethrow;
      throw ElasticsearchException('Failed to get cluster health: $e');
    }
  }

  /// Create an index with the given mapping
  Future<Map<String, dynamic>> createIndex(
    String indexName,
    Map<String, dynamic> mapping,
  ) async {
    final url = config.indexUrl(indexName);

    try {
      final response = await _httpClient.put(
        Uri.parse(url),
        headers: config.headers,
        body: json.encode(mapping),
      );

      final responseBody = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseBody;
      } else if (response.statusCode == 400 &&
          responseBody['error']?['type'] == 'resource_already_exists_exception') {
        // Index already exists - not an error
        return {'acknowledged': true, 'already_exists': true};
      } else {
        throw ElasticsearchIndexException(
          'Failed to create index $indexName: ${response.statusCode}',
          statusCode: response.statusCode,
          body: response.body,
        );
      }
    } catch (e) {
      if (e is ElasticsearchException) rethrow;
      throw ElasticsearchIndexException('Failed to create index $indexName: $e');
    }
  }

  /// Check if an index exists
  Future<bool> indexExists(String indexName) async {
    final url = config.indexUrl(indexName);

    try {
      final response = await _httpClient.head(
        Uri.parse(url),
        headers: config.headers,
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Delete an index
  Future<Map<String, dynamic>> deleteIndex(String indexName) async {
    final url = config.indexUrl(indexName);

    try {
      final response = await _httpClient.delete(
        Uri.parse(url),
        headers: config.headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 404) {
        return {'acknowledged': true, 'not_found': true};
      } else {
        throw ElasticsearchIndexException(
          'Failed to delete index $indexName: ${response.statusCode}',
          statusCode: response.statusCode,
          body: response.body,
        );
      }
    } catch (e) {
      if (e is ElasticsearchException) rethrow;
      throw ElasticsearchIndexException('Failed to delete index $indexName: $e');
    }
  }

  /// Index a single document
  Future<Map<String, dynamic>> indexDocument(
    String indexName,
    String documentId,
    Map<String, dynamic> document,
  ) async {
    final url = '${config.indexUrl(indexName)}/_doc/$documentId';

    try {
      final response = await _httpClient.put(
        Uri.parse(url),
        headers: config.headers,
        body: json.encode(document),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw ElasticsearchDocumentException(
          'Failed to index document $documentId: ${response.statusCode}',
          statusCode: response.statusCode,
          body: response.body,
        );
      }
    } catch (e) {
      if (e is ElasticsearchException) rethrow;
      throw ElasticsearchDocumentException(
        'Failed to index document $documentId: $e',
      );
    }
  }

  /// Get a document by ID
  Future<Map<String, dynamic>?> getDocument(
    String indexName,
    String documentId,
  ) async {
    final url = '${config.indexUrl(indexName)}/_doc/$documentId';

    try {
      final response = await _httpClient.get(
        Uri.parse(url),
        headers: config.headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw ElasticsearchDocumentException(
          'Failed to get document $documentId: ${response.statusCode}',
          statusCode: response.statusCode,
          body: response.body,
        );
      }
    } catch (e) {
      if (e is ElasticsearchException) rethrow;
      throw ElasticsearchDocumentException(
        'Failed to get document $documentId: $e',
      );
    }
  }

  /// Delete a document by ID
  Future<Map<String, dynamic>> deleteDocument(
    String indexName,
    String documentId,
  ) async {
    final url = '${config.indexUrl(indexName)}/_doc/$documentId';

    try {
      final response = await _httpClient.delete(
        Uri.parse(url),
        headers: config.headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 404) {
        return {'result': 'not_found'};
      } else {
        throw ElasticsearchDocumentException(
          'Failed to delete document $documentId: ${response.statusCode}',
          statusCode: response.statusCode,
          body: response.body,
        );
      }
    } catch (e) {
      if (e is ElasticsearchException) rethrow;
      throw ElasticsearchDocumentException(
        'Failed to delete document $documentId: $e',
      );
    }
  }

  /// Search documents in an index
  Future<Map<String, dynamic>> search(
    String indexName,
    Map<String, dynamic> query, {
    int from = 0,
    int size = 10,
  }) async {
    final url = config.searchUrl(indexName);

    final body = {
      'from': from,
      'size': size,
      ...query,
    };

    try {
      final response = await _httpClient.post(
        Uri.parse(url),
        headers: config.headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw ElasticsearchSearchException(
          'Search failed on $indexName: ${response.statusCode}',
          statusCode: response.statusCode,
          body: response.body,
        );
      }
    } catch (e) {
      if (e is ElasticsearchException) rethrow;
      throw ElasticsearchSearchException('Search failed on $indexName: $e');
    }
  }

  /// Bulk index multiple documents
  Future<Map<String, dynamic>> bulkIndex(
    String indexName,
    List<Map<String, dynamic>> documents,
    List<String> documentIds,
  ) async {
    if (documents.length != documentIds.length) {
      throw ArgumentError('documents and documentIds must have the same length');
    }

    final buffer = StringBuffer();
    final fullIndexName = '${config.indexPrefix}-$indexName';

    for (var i = 0; i < documents.length; i++) {
      // Action line
      buffer.writeln(json.encode({
        'index': {
          '_index': fullIndexName,
          '_id': documentIds[i],
        }
      }));
      // Document line
      buffer.writeln(json.encode(documents[i]));
    }

    try {
      final response = await _httpClient.post(
        Uri.parse(config.bulkUrl),
        headers: config.headers,
        body: buffer.toString(),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw ElasticsearchDocumentException(
          'Bulk index failed: ${response.statusCode}',
          statusCode: response.statusCode,
          body: response.body,
        );
      }
    } catch (e) {
      if (e is ElasticsearchException) rethrow;
      throw ElasticsearchDocumentException('Bulk index failed: $e');
    }
  }

  /// Close the HTTP client
  void close() {
    _httpClient.close();
  }
}
