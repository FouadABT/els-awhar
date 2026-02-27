import 'dart:async';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart' as mailer;
import 'package:serverpod/serverpod.dart';

import 'email_config.dart';
import 'email_template.dart';

/// Result of an email send operation
class EmailResult {
  final bool success;
  final String? messageId;
  final String? error;

  const EmailResult({
    required this.success,
    this.messageId,
    this.error,
  });

  factory EmailResult.success(String messageId) => EmailResult(
        success: true,
        messageId: messageId,
      );

  factory EmailResult.failure(String error) => EmailResult(
        success: false,
        error: error,
      );

  @override
  String toString() =>
      success ? 'EmailResult.success($messageId)' : 'EmailResult.failure($error)';
}

/// Email recipient with name and address
class EmailRecipient {
  final String email;
  final String? name;

  const EmailRecipient(this.email, [this.name]);

  Address toAddress() => Address(email, name);

  @override
  String toString() => name != null ? '$name <$email>' : email;
}

/// Modular email service for sending emails via SMTP
/// 
/// Supports Brevo (Sendinblue) and other SMTP providers.
/// Uses templates for consistent email formatting.
class EmailService {
  /// Singleton instance
  static EmailService? _instance;
  
  /// Email configuration
  late final EmailConfig _config;
  
  /// SMTP server configuration
  late final SmtpServer _smtpServer;
  
  /// Whether the service is initialized
  bool _isInitialized = false;

  /// Private constructor for singleton
  EmailService._();

  /// Get the singleton instance
  static EmailService get instance {
    _instance ??= EmailService._();
    return _instance!;
  }

  /// Initialize the email service with configuration
  /// 
  /// Call this once during server startup with config from YAML
  void initialize(EmailConfig config) {
    _config = config;
    
    if (config.isValid) {
      _smtpServer = SmtpServer(
        config.host,
        port: config.port,
        username: config.username,
        password: config.password,
        ssl: config.useSsl,
        allowInsecure: !config.useSsl, // Allow TLS on port 587
      );
      _isInitialized = true;
      print('📧 Email service initialized: ${config.host}:${config.port}');
    } else {
      _isInitialized = false;
      print('⚠️ Email service disabled: invalid or missing configuration');
    }
  }

  /// Initialize from Serverpod config
  /// 
  /// Reads email configuration from the server's YAML config
  void initializeFromConfig(Map<String, dynamic>? emailConfig) {
    if (emailConfig == null) {
      print('⚠️ Email service disabled: no email configuration found');
      _config = EmailConfig.disabled();
      _isInitialized = false;
      return;
    }

    initialize(EmailConfig.fromMap(emailConfig));
  }

  /// Check if email service is ready
  bool get isReady => _isInitialized && _config.isValid;

  /// Get current configuration (for debugging)
  EmailConfig get config => _config;

  /// Send a templated email
  /// 
  /// [templateType] - The type of email template to use
  /// [recipient] - The recipient email and optional name
  /// [variables] - Variables to replace in the template (e.g., {{name}})
  Future<EmailResult> sendTemplatedEmail({
    required EmailTemplateType templateType,
    required EmailRecipient recipient,
    required Map<String, String> variables,
  }) async {
    if (!isReady) {
      return EmailResult.failure('Email service is not configured');
    }

    try {
      // Get and process template
      final template = EmailTemplates.getTemplate(templateType)
          .replaceVariables({...variables, 'email': recipient.email});

      return await _sendEmail(
        recipient: recipient,
        subject: template.subject,
        htmlBody: template.htmlBody,
        textBody: template.textBody,
      );
    } catch (e) {
      return EmailResult.failure('Failed to send email: $e');
    }
  }

  /// Send a custom email with custom subject and body
  Future<EmailResult> sendCustomEmail({
    required EmailRecipient recipient,
    required String subject,
    required String htmlBody,
    String? textBody,
  }) async {
    if (!isReady) {
      return EmailResult.failure('Email service is not configured');
    }

    return await _sendEmail(
      recipient: recipient,
      subject: subject,
      htmlBody: htmlBody,
      textBody: textBody,
    );
  }

  /// Send email to multiple recipients
  Future<List<EmailResult>> sendBulkEmail({
    required List<EmailRecipient> recipients,
    required String subject,
    required String htmlBody,
    String? textBody,
  }) async {
    if (!isReady) {
      return recipients
          .map((_) => EmailResult.failure('Email service is not configured'))
          .toList();
    }

    final results = <EmailResult>[];
    for (final recipient in recipients) {
      final result = await _sendEmail(
        recipient: recipient,
        subject: subject,
        htmlBody: htmlBody,
        textBody: textBody,
      );
      results.add(result);
      
      // Small delay to avoid rate limiting
      await Future.delayed(const Duration(milliseconds: 100));
    }
    return results;
  }

  /// Internal method to send an email
  Future<EmailResult> _sendEmail({
    required EmailRecipient recipient,
    required String subject,
    required String htmlBody,
    String? textBody,
  }) async {
    try {
      final message = mailer.Message()
        ..from = Address(_config.senderEmail, _config.senderName)
        ..recipients.add(recipient.toAddress())
        ..subject = subject
        ..html = htmlBody;

      if (textBody != null) {
        message.text = textBody;
      }

      final sendReport = await send(message, _smtpServer);
      
      print('📧 Email sent to ${recipient.email}: ${sendReport.toString()}');
      
      return EmailResult.success(sendReport.toString());
    } on MailerException catch (e) {
      print('❌ Email failed to ${recipient.email}: ${e.message}');
      for (var p in e.problems) {
        print('   Problem: ${p.code}: ${p.msg}');
      }
      return EmailResult.failure(e.message);
    } catch (e) {
      print('❌ Email error: $e');
      return EmailResult.failure(e.toString());
    }
  }

  // ============================================================
  // Convenience methods for common email types
  // ============================================================

  /// Send welcome email to new user
  Future<EmailResult> sendWelcomeEmail({
    required String email,
    required String name,
    String? appLink,
  }) {
    return sendTemplatedEmail(
      templateType: EmailTemplateType.welcome,
      recipient: EmailRecipient(email, name),
      variables: {
        'name': name,
        'appLink': appLink ?? 'https://awhar.com',
      },
    );
  }

  /// Send password reset email
  Future<EmailResult> sendPasswordResetEmail({
    required String email,
    required String name,
    required String code,
  }) {
    return sendTemplatedEmail(
      templateType: EmailTemplateType.passwordReset,
      recipient: EmailRecipient(email, name),
      variables: {
        'name': name,
        'code': code,
      },
    );
  }

  /// Send email verification code
  Future<EmailResult> sendVerificationEmail({
    required String email,
    required String name,
    required String code,
  }) {
    return sendTemplatedEmail(
      templateType: EmailTemplateType.emailVerification,
      recipient: EmailRecipient(email, name),
      variables: {
        'name': name,
        'code': code,
      },
    );
  }

  /// Send order confirmation
  Future<EmailResult> sendOrderConfirmation({
    required String email,
    required String name,
    required String orderId,
    required String serviceName,
    required String date,
    required String total,
    String? trackLink,
  }) {
    return sendTemplatedEmail(
      templateType: EmailTemplateType.orderConfirmation,
      recipient: EmailRecipient(email, name),
      variables: {
        'name': name,
        'orderId': orderId,
        'serviceName': serviceName,
        'date': date,
        'total': total,
        'trackLink': trackLink ?? 'https://awhar.com',
      },
    );
  }

  /// Send driver accepted notification
  Future<EmailResult> sendDriverAcceptedEmail({
    required String email,
    required String name,
    required String orderId,
    required String driverName,
    required String driverPhone,
    String? vehicleInfo,
    String? trackLink,
  }) {
    return sendTemplatedEmail(
      templateType: EmailTemplateType.driverAccepted,
      recipient: EmailRecipient(email, name),
      variables: {
        'name': name,
        'orderId': orderId,
        'driverName': driverName,
        'driverPhone': driverPhone,
        'vehicleInfo': vehicleInfo ?? '',
        'trackLink': trackLink ?? 'https://awhar.com',
      },
    );
  }

  /// Send order completed email
  Future<EmailResult> sendOrderCompletedEmail({
    required String email,
    required String name,
    required String orderId,
    required String serviceName,
    required String total,
    String? rateLink,
  }) {
    return sendTemplatedEmail(
      templateType: EmailTemplateType.orderCompleted,
      recipient: EmailRecipient(email, name),
      variables: {
        'name': name,
        'orderId': orderId,
        'serviceName': serviceName,
        'total': total,
        'rateLink': rateLink ?? 'https://awhar.com',
      },
    );
  }
}
