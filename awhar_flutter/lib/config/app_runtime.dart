class AppRuntime {
  /// Base API URL used by the app, e.g. "http://192.168.0.101:8080".
  static String? apiBaseUrl;

  /// Initialize at startup with the computed server URL.
  /// Accepts a URL that may end with a trailing slash, stores without it.
  static void init(String serverUrl) {
    if (serverUrl.isEmpty) return;
    apiBaseUrl = serverUrl.endsWith('/')
        ? serverUrl.substring(0, serverUrl.length - 1)
        : serverUrl;
  }
}
