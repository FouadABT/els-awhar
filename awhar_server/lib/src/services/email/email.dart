/// Email service module
/// 
/// Provides modular SMTP email functionality for the Awhar backend.
/// Supports Brevo (Sendinblue) and other SMTP providers.
/// 
/// Usage:
/// ```dart
/// // Initialize in main.dart
/// EmailService.instance.initialize(EmailConfig(
///   host: 'smtp-relay.brevo.com',
///   port: 587,
///   username: 'your-username',
///   password: 'your-api-key',
///   senderEmail: 'noreply@awhar.com',
///   senderName: 'Awhar',
/// ));
/// 
/// // Send emails from anywhere
/// await EmailService.instance.sendWelcomeEmail(
///   email: 'user@example.com',
///   name: 'John Doe',
/// );
/// ```

library email;

export 'email_config.dart';
export 'email_service.dart';
export 'email_template.dart';
