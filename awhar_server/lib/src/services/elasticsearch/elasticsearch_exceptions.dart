/// Elasticsearch Exceptions
///
/// Custom exception classes for Elasticsearch operations.
/// Provides detailed error information for debugging.

/// Base exception class for all Elasticsearch errors
class ElasticsearchException implements Exception {
  final String message;
  final int? statusCode;
  final String? body;

  ElasticsearchException(
    this.message, {
    this.statusCode,
    this.body,
  });

  @override
  String toString() {
    final buffer = StringBuffer('ElasticsearchException: $message');
    if (statusCode != null) {
      buffer.write(' (Status: $statusCode)');
    }
    if (body != null && body!.isNotEmpty) {
      buffer.write('\nResponse: $body');
    }
    return buffer.toString();
  }
}

/// Exception for connection-related errors
class ElasticsearchConnectionException extends ElasticsearchException {
  ElasticsearchConnectionException(
    super.message, {
    super.statusCode,
    super.body,
  });

  @override
  String toString() {
    return 'ElasticsearchConnectionException: $message';
  }
}

/// Exception for index-related errors
class ElasticsearchIndexException extends ElasticsearchException {
  ElasticsearchIndexException(
    super.message, {
    super.statusCode,
    super.body,
  });

  @override
  String toString() {
    return 'ElasticsearchIndexException: $message';
  }
}

/// Exception for document-related errors
class ElasticsearchDocumentException extends ElasticsearchException {
  ElasticsearchDocumentException(
    super.message, {
    super.statusCode,
    super.body,
  });

  @override
  String toString() {
    return 'ElasticsearchDocumentException: $message';
  }
}

/// Exception for search-related errors
class ElasticsearchSearchException extends ElasticsearchException {
  ElasticsearchSearchException(
    super.message, {
    super.statusCode,
    super.body,
  });

  @override
  String toString() {
    return 'ElasticsearchSearchException: $message';
  }
}

/// Exception for sync-related errors
class ElasticsearchSyncException extends ElasticsearchException {
  ElasticsearchSyncException(
    super.message, {
    super.statusCode,
    super.body,
  });

  @override
  String toString() {
    return 'ElasticsearchSyncException: $message';
  }
}
