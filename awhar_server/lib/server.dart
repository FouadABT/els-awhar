import 'dart:io';

import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:serverpod/serverpod.dart' hide Transaction;
import 'package:serverpod/serverpod.dart' as serverpod show Transaction;
import 'package:serverpod/web_server.dart' show SpaRoute;
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/services/notification_service.dart';
import 'src/services/driver_cleanup_service.dart';
import 'src/services/notification_planner_service.dart';
import 'src/services/smart_matching_service.dart';
import 'src/services/email/email.dart';
import 'src/services/elasticsearch/elasticsearch_service.dart';
import 'src/services/ai_agents/ai_agent_service.dart';
import 'src/web/routes/app_config_route.dart';
import 'src/web/routes/root.dart';
import 'src/web/routes/deep_link_routes.dart';
import 'src/endpoints/settings_endpoint.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Load environment variables from .env file
  _loadEnvironment();
  
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(args, Protocol(), Endpoints());

  // Initialize Email Service (SMTP)
  _initializeEmailService(pod);

  // Initialize Firebase Admin SDK for push notifications
  // This will use Application Default Credentials from environment
  try {
    final session = await pod.createSession();
    await NotificationService.initialize(session);
    await session.close();
  } catch (e) {
    print('[Server] Failed to initialize notifications: $e');
    // Continue server startup even if notifications fail
  }

  // Initialize driver cleanup service (hourly cron job)
  try {
    DriverCleanupService.initialize(pod);
  } catch (e) {
    print('[Server] Failed to initialize driver cleanup service: $e');
    // Continue server startup even if cleanup service fails
  }

  // Initialize smart matching service (needs Serverpod ref for background sessions)
  SmartMatchingService.initialize(pod);

  // ═══════════════════════════════════════════════════════════════════════════
  // Initialize Elasticsearch Service (Agent Builder Hackathon)
  // ═══════════════════════════════════════════════════════════════════════════
  try {
    final esInitialized = await ElasticsearchService.instance.initialize(
      createIndices: true,
    );
    if (esInitialized) {
      print('[Server] ✅ Elasticsearch service initialized');
      
      // Initialize AI Agent Service (requires Elasticsearch)
      try {
        await AiAgentService.instance.initialize();
        print('[Server] ✅ AI Agent service initialized');
      } catch (e) {
        print('[Server] ⚠️ AI Agent service failed to initialize: $e');
      }

      // Initialize AI Notification Planner (runs every 6 hours)
      try {
        NotificationPlannerService.initialize(pod);
        print('[Server] ✅ Notification Planner service initialized');
      } catch (e) {
        print('[Server] ⚠️ Notification Planner failed to initialize: $e');
      }
    } else {
      print('[Server] ⚠️ Elasticsearch service failed to initialize');
    }
  } catch (e) {
    print('[Server] ⚠️ Elasticsearch not available: $e');
    // Continue server startup even if Elasticsearch fails
  }

  // Initialize authentication services for the server.
  // Token managers will be used to validate and issue authentication keys,
  // and the identity providers will be the authentication options available for users.
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      // Use JWT for authentication keys towards the server.
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      // Configure the email identity provider for email/password authentication.
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: _sendRegistrationCode,
        sendPasswordResetVerificationCode: _sendPasswordResetCode,
      ),
    ],
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // Deep Linking Routes (App Links / Universal Links)
  // MUST be registered BEFORE admin dashboard to avoid conflicts
  // ═══════════════════════════════════════════════════════════════════════════

  // Android App Links verification
  pod.webServer.addRoute(
    AndroidAssetLinksRoute(),
    '/.well-known/assetlinks.json',
  );

  // iOS Universal Links verification
  pod.webServer.addRoute(
    AppleAppSiteAssociationRoute(),
    '/.well-known/apple-app-site-association',
  );

  // Deep link fallback pages (when app is not installed)
  pod.webServer.addRoute(DriverFallbackRoute(), '/driver/*');
  pod.webServer.addRoute(OrderFallbackRoute(), '/order/*');
  pod.webServer.addRoute(InviteFallbackRoute(), '/invite/*');
  pod.webServer.addRoute(RequestFallbackRoute(), '/request/*');
  pod.webServer.addRoute(ShareFallbackRoute(), '/share/*');

  // ═══════════════════════════════════════════════════════════════════════════
  // Admin Dashboard - MUST be registered AFTER specific routes
  // ═══════════════════════════════════════════════════════════════════════════
  final adminDir = Directory(Uri(path: 'web/admin').toFilePath());
  if (adminDir.existsSync()) {
    // FlutterRoute handles all sub-routes, static files, and fallback to index.html
    pod.webServer.addRoute(FlutterRoute(adminDir), '/admin');
    print('[Server] ✅ Admin dashboard available at /admin/');
  } else {
    print('[Server] ⚠️ Admin dashboard not built. Run: serverpod run admin_build');
  }

  // ═══════════════════════════════════════════════════════════════════════════

  // Serve static files (CSS, images) from web/static
  final staticDir = Directory(Uri(path: 'web/static').toFilePath());
  if (staticDir.existsSync()) {
    // Serve static files from /static/ path to avoid conflicts with admin dashboard
    pod.webServer.addRoute(StaticRoute.directory(staticDir), '/static');
  }

  // Setup the app config route.
  // We build this configuration based on the servers api url and serve it to
  // the flutter app.
  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '/app/assets/assets/config.json',
  );

  // Checks if the flutter web app has been built and serves it if it has.
  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    // Serve the flutter web app under the /app path.
    pod.webServer.addRoute(
      FlutterRoute(
        Directory(
          Uri(path: 'web/app').toFilePath(),
        ),
      ),
      '/app',
    );
  } else {
    // If the flutter web app has not been built, serve the build app page.
    pod.webServer.addRoute(
      StaticRoute.file(
        File(
          Uri(path: 'web/pages/build_flutter_app.html').toFilePath(),
        ),
      ),
      '/app/**',
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Landing Page - Served at root (/) - MUST be registered LAST
  // This catches all remaining routes not matched by specific paths above
  // ═══════════════════════════════════════════════════════════════════════════
  final landingDir = Directory(Uri(path: 'web/landing').toFilePath());
  if (landingDir.existsSync()) {
    final landingIndex = File(Uri(path: 'web/landing/index.html').toFilePath());
    final landingNextDir = Directory(Uri(path: 'web/landing/_next').toFilePath());
    
    // Serve Next.js static assets from /_next/ path (JS, CSS, fonts)
    if (landingNextDir.existsSync()) {
      pod.webServer.addRoute(StaticRoute.directory(landingNextDir), '/_next');
    }
    
    // Serve static files (images, logo, etc.) from landing page root
    final logoFile = File(Uri(path: 'web/landing/logo.png').toFilePath());
    if (logoFile.existsSync()) {
      pod.webServer.addRoute(StaticRoute.file(logoFile), '/logo.png');
    }
    
    final heroFile = File(Uri(path: 'web/landing/hero-app.png').toFilePath());
    if (heroFile.existsSync()) {
      pod.webServer.addRoute(StaticRoute.file(heroFile), '/hero-app.png');
    }
    
    // Serve landing page sub-pages (contact, privacy, terms, delete-account)
    final landingPages = ['contact', 'privacy', 'terms', 'delete-account'];
    for (final page in landingPages) {
      final pageFile = File(Uri(path: 'web/landing/$page/index.html').toFilePath());
      if (pageFile.existsSync()) {
        // Only register with trailing slash to avoid route conflicts
        pod.webServer.addRoute(StaticRoute.file(pageFile), '/$page/');
      }
    }
    
    // Serve root index.html specifically
    pod.webServer.addRoute(StaticRoute.file(landingIndex), '/');
    pod.webServer.addRoute(StaticRoute.file(landingIndex), '/index.html');
    
    print('[Server] ✅ Landing page available at /');
  } else {
    print('[Server] ⚠️ Landing page not built. Run: cd landing_page && npm run export');
  }

  // Start the server.
  await pod.start();

  // Seed default system settings after server starts
  try {
    final session = await pod.createSession();
    final settingsEndpoint = SettingsEndpoint();
    await settingsEndpoint.initializeDefaultSettings(session);
    await session.close();
    print('[Server] ✅ Default system settings initialized');
  } catch (e) {
    print('[Server] ⚠️ Failed to initialize default settings: $e');
    // Non-fatal, continue server operation
  }
}

void _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required serverpod.Transaction? transaction,
}) async {
  // Log for debugging
  session.log('[EmailIdp] Registration code ($email): $verificationCode');
  
  // Send verification email via SMTP
  if (EmailService.instance.isReady) {
    final result = await EmailService.instance.sendVerificationEmail(
      email: email,
      name: email.split('@').first,
      code: verificationCode,
    );
    if (result.success) {
      session.log('[EmailIdp] Verification email sent to $email');
    } else {
      session.log('[EmailIdp] Failed to send email: ${result.error}');
    }
  }
}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required serverpod.Transaction? transaction,
}) async {
  // Log for debugging
  session.log('[EmailIdp] Password reset code ($email): $verificationCode');
  
  // Send password reset email via SMTP
  if (EmailService.instance.isReady) {
    final result = await EmailService.instance.sendPasswordResetEmail(
      email: email,
      name: email.split('@').first,
      code: verificationCode,
    );
    if (result.success) {
      session.log('[EmailIdp] Password reset email sent to $email');
    } else {
      session.log('[EmailIdp] Failed to send email: ${result.error}');
    }
  }
}

/// Initialize the email service with SMTP configuration
void _initializeEmailService(Serverpod pod) {
  try {
    // Get password from passwords.yaml
    final emailPassword = pod.getPassword('emailPassword');
    
    if (emailPassword != null && emailPassword.isNotEmpty) {
      // Initialize with Brevo SMTP settings
      EmailService.instance.initialize(EmailConfig(
        host: 'smtp-relay.brevo.com',
        port: 587,
        username: '9bd488001@smtp-brevo.com',
        password: emailPassword,
        senderEmail: 'noreply@awhar.com',
        senderName: 'Awhar',
        useSsl: false,
        enabled: true,
      ));
      print('[Server] ✅ Email service initialized with Brevo SMTP');
    } else {
      print('[Server] ⚠️ Email password not found in passwords.yaml - email service disabled');
      EmailService.instance.initialize(EmailConfig.disabled());
    }
  } catch (e) {
    print('[Server] ❌ Failed to initialize email service: $e');
    EmailService.instance.initialize(EmailConfig.disabled());
  }
}

/// Load environment variables from .env file
/// This loads the .env file from the parent directory (awhar_backend)
void _loadEnvironment() {
  try {
    // Try loading from parent directory first (where .env is located)
    final parentEnvFile = File('../.env');
    final currentEnvFile = File('.env');
    
    File? envFile;
    if (parentEnvFile.existsSync()) {
      envFile = parentEnvFile;
      print('[Server] Loading environment from ../.env');
    } else if (currentEnvFile.existsSync()) {
      envFile = currentEnvFile;
      print('[Server] Loading environment from ./.env');
    }
    
    if (envFile != null) {
      final env = dotenv.DotEnv(includePlatformEnvironment: true)..load([envFile.path]);
      
      // Set environment variables for the process
      for (final key in env.map.keys) {
        // Only set if not already set in platform environment
        if (Platform.environment[key] == null) {
          // We can't directly set Platform.environment, but dotenv makes them available
          // through env[key]. For Elasticsearch, we'll read from dotenv directly.
        }
      }
      
      // Store dotenv instance globally for access by services
      _dotEnv = env;
      
      print('[Server] ✅ Environment variables loaded');
    } else {
      print('[Server] ⚠️ No .env file found');
    }
  } catch (e) {
    print('[Server] ⚠️ Failed to load environment: $e');
  }
}

/// Global dotenv instance
dotenv.DotEnv? _dotEnv;

/// Get environment variable from dotenv or platform
String? getEnv(String key) {
  return _dotEnv?[key] ?? Platform.environment[key];
}
