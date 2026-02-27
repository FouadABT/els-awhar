import '../../config/app_runtime.dart';

class UrlUtils {
  /// Ensure image URLs point to the current API base.
  /// If the URL references `serverpod_cloud_storage` on an old host,
  /// rewrite it to use the configured `AppRuntime.apiBaseUrl`.
  static String? normalizeImageUrl(String? url) {
    if (url == null || url.isEmpty) return url;
    final base = AppRuntime.apiBaseUrl;
    if (base == null || base.isEmpty) return url;

    try {
      final uri = Uri.parse(url);
      final isServerpodStorage = uri.path.contains('serverpod_cloud_storage');
      if (!isServerpodStorage) return url;

      // Build a normalized URL: {base}/serverpod_cloud_storage + existing query
      final normalized = Uri.parse('$base/serverpod_cloud_storage')
          .replace(query: uri.query)
          .toString();
      return normalized;
    } catch (_) {
      return url;
    }
  }
}
