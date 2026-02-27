import 'package:serverpod/serverpod.dart';

/// Android App Links verification file
/// Serves /.well-known/assetlinks.json
class AndroidAssetLinksRoute extends WidgetRoute {
  /// Your Android app package name
  static const String packageName = 'com.awhar.main';

  /// SHA-256 certificate fingerprints for your app signing key
  /// For debug: Run `keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android`
  /// For release: Use your release keystore fingerprint
  static const List<String> sha256Fingerprints = [
    // Debug fingerprint
    'FA:C6:17:45:DC:09:03:78:6F:B9:ED:E6:2A:96:2B:39:9F:73:48:F0:BB:6F:89:9B:83:32:66:75:91:03:3B:9C',
    // Release fingerprint (Fouad ABATOUY - awhar-release-key.jks)
    '24:F5:C2:80:D1:65:AE:B0:1A:B3:BB:CD:31:0F:20:2E:74:30:39:3F:BD:A9:51:4B:23:73:72:15:C0:41:99:B4',
  ];

  @override
  Future<WebWidget> build(Session session, Request request) async {
    final assetLinks = [
      {
        'relation': ['delegate_permission/common.handle_all_urls'],
        'target': {
          'namespace': 'android_app',
          'package_name': packageName,
          'sha256_cert_fingerprints': sha256Fingerprints,
        },
      },
    ];

    return JsonWidget(object: assetLinks);
  }
}

/// iOS Universal Links verification file
/// Serves /.well-known/apple-app-site-association
class AppleAppSiteAssociationRoute extends WidgetRoute {
  /// Your Apple Team ID + Bundle ID
  /// Format: <TEAM_ID>.<BUNDLE_ID>
  /// Find Team ID in Apple Developer Portal -> Membership
  static const String appId = 'XXXXXXXXXX.com.awhar.app';

  @override
  Future<WebWidget> build(Session session, Request request) async {
    final aasa = {
      'applinks': {
        'apps': <String>[],
        'details': [
          {
            'appID': appId,
            'paths': [
              '/order/*',
              '/driver/*',
              '/invite/*',
              '/request/*',
              '/share/*',
              '/*', // Catch-all for deep links
            ],
          },
        ],
      },
      'webcredentials': {
        'apps': [appId],
      },
    };

    return JsonWidget(object: aasa);
  }
}

/// Base class for Deep Link Fallback Routes
/// When app is not installed, shows a landing page with download options
abstract class _BaseDeepLinkFallbackRoute extends WidgetRoute {
  /// App Store URL (iOS)
  static const String appStoreUrl =
      'https://apps.apple.com/app/awhar/id123456789'; // Replace with actual

  /// Play Store URL (Android)
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.awhar.app';

  String get title;
  String get description;
  String get actionText => 'Open in Awhar';
  String get linkType;

  @override
  Future<WebWidget> build(Session session, Request request) async {
    final userAgent =
        request.headers['user-agent']?.firstOrNull?.toLowerCase() ?? '';

    // Detect platform
    final isIOS = userAgent.contains('iphone') || userAgent.contains('ipad');
    final isAndroid = userAgent.contains('android');

    // Generate responsive HTML
    final html = _generateLandingPage(
      title: title,
      description: description,
      actionText: actionText,
      isIOS: isIOS,
      isAndroid: isAndroid,
      originalPath: '/$linkType',
    );

    return HtmlWidget(html: html);
  }

  String _generateLandingPage({
    required String title,
    required String description,
    required String actionText,
    required bool isIOS,
    required bool isAndroid,
    required String originalPath,
  }) {
    final storeUrl = isIOS
        ? _BaseDeepLinkFallbackRoute.appStoreUrl
        : _BaseDeepLinkFallbackRoute.playStoreUrl;
    final playStoreUrl = _BaseDeepLinkFallbackRoute.playStoreUrl;
    final appStoreUrl = _BaseDeepLinkFallbackRoute.appStoreUrl;
    final storeLabel = isIOS ? 'App Store' : 'Google Play';
    final storeIcon = isIOS ? '🍎' : '🤖';

    return '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>$title - Awhar</title>
  <meta name="description" content="$description">
  
  <!-- Open Graph for Social Sharing -->
  <meta property="og:title" content="$title - Awhar">
  <meta property="og:description" content="$description">
  <meta property="og:type" content="website">
  <meta property="og:image" content="/static/images/awhar_logo.png">
  
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
    }
    
    .container {
      background: white;
      border-radius: 24px;
      padding: 40px 30px;
      max-width: 400px;
      width: 100%;
      text-align: center;
      box-shadow: 0 20px 60px rgba(0,0,0,0.3);
    }
    
    .logo {
      width: 96px;
      height: 96px;
      border-radius: 24px;
      margin: 0 auto 24px;
      display: block;
      object-fit: contain;
      box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    }
    
    h1 {
      font-size: 24px;
      color: #1a1a2e;
      margin-bottom: 12px;
      font-weight: 700;
    }
    
    p {
      font-size: 16px;
      color: #666;
      margin-bottom: 32px;
      line-height: 1.5;
    }
    
    .btn {
      display: inline-block;
      padding: 16px 32px;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      text-decoration: none;
      border-radius: 12px;
      font-size: 16px;
      font-weight: 600;
      margin-bottom: 16px;
      width: 100%;
      transition: transform 0.2s, box-shadow 0.2s;
    }
    
    .btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
    }
    
    .btn-secondary {
      background: #f5f5f5;
      color: #333;
    }
    
    .btn-secondary:hover {
      box-shadow: 0 8px 20px rgba(0,0,0,0.1);
    }
    
    .store-badge {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
    }
    
    .divider {
      margin: 24px 0;
      color: #999;
      font-size: 14px;
    }
    
    .footer {
      margin-top: 24px;
      font-size: 12px;
      color: #999;
    }
  </style>
</head>
<body>
  <div class="container">
    <img src="/static/images/awhar_logo.png" alt="Awhar logo" class="logo" />
    <h1>$title</h1>
    <p>$description</p>
    
    <!-- Primary: Open in App button (custom scheme) -->
    <a href="awhar:/$originalPath" class="btn" id="openAppBtn">
      <span class="store-badge">
        <span>📱</span>
        <span>Open in Awhar App</span>
      </span>
    </a>
    
    <p class="divider">— or download the app —</p>
    
    ${isIOS || isAndroid ? '''
    <a href="$storeUrl" class="btn btn-secondary">
      <span class="store-badge">
        <span>$storeIcon</span>
        <span>Get it on $storeLabel</span>
      </span>
    </a>
    ''' : '''
    <a href="$playStoreUrl" class="btn btn-secondary">
      <span class="store-badge">
        <span>🤖</span>
        <span>Get it on Google Play</span>
      </span>
    </a>
    <a href="$appStoreUrl" class="btn btn-secondary">
      <span class="store-badge">
        <span>🍎</span>
        <span>Download on App Store</span>
      </span>
    </a>
    '''}
    
    <div class="footer">
      <p>© 2026 Awhar. Morocco's trusted service marketplace.</p>
    </div>
  </div>
  
  <script>
    // Do NOT auto-redirect - let user tap the button
    // The "Open in Awhar App" button uses awhar:// scheme directly
    console.log('Deep link page loaded for: $originalPath');
  </script>
</body>
</html>
''';
  }
}

/// Order/Request fallback route
class OrderFallbackRoute extends _BaseDeepLinkFallbackRoute {
  @override
  String get title => 'View Order Details';

  @override
  String get description => 'Open Awhar to see your order details';

  @override
  String get linkType => 'order';
}

/// Driver profile fallback route
class DriverFallbackRoute extends _BaseDeepLinkFallbackRoute {
  @override
  String get title => 'View Driver Profile';

  @override
  String get description =>
      'Open Awhar to see this driver\'s profile and services';

  @override
  String get linkType => 'driver';
}

/// Invitation fallback route
class InviteFallbackRoute extends _BaseDeepLinkFallbackRoute {
  @override
  String get title => 'You\'re Invited!';

  @override
  String get description =>
      'Join Awhar - Morocco\'s premier service marketplace';

  @override
  String get actionText => 'Accept Invitation';

  @override
  String get linkType => 'invite';
}

/// Request fallback route
class RequestFallbackRoute extends _BaseDeepLinkFallbackRoute {
  @override
  String get title => 'View Request Details';

  @override
  String get description => 'Open Awhar to see this service request';

  @override
  String get linkType => 'request';
}

/// Share fallback route
class ShareFallbackRoute extends _BaseDeepLinkFallbackRoute {
  @override
  String get title => 'Awhar';

  @override
  String get description => 'Your trusted service marketplace in Morocco';

  @override
  String get linkType => 'share';
}

/// Simple HTML widget for returning raw HTML content
class HtmlWidget extends WebWidget {
  final String html;

  HtmlWidget({required this.html});

  @override
  String toString() => html;
}
