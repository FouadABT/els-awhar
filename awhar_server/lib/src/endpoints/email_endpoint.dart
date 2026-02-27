import 'package:serverpod/serverpod.dart';

import '../services/email/email.dart';

/// Email endpoint for sending emails from the client
/// 
/// Provides methods to send various types of emails through the SMTP service.
class EmailEndpoint extends Endpoint {
  /// Check if email service is configured and ready
  Future<bool> isEmailServiceReady(Session session) async {
    return EmailService.instance.isReady;
  }

  /// Send a test email (for testing purposes)
  Future<bool> sendTestEmail(Session session, String recipientEmail) async {
    if (!EmailService.instance.isReady) {
      session.log('[EmailEndpoint] Email service not ready');
      return false;
    }

    final result = await EmailService.instance.sendWelcomeEmail(
      email: recipientEmail,
      name: 'Test User',
    );

    session.log('[EmailEndpoint] Test email result: ${result.success ? "SUCCESS" : "FAILED - ${result.error}"}');
    return result.success;
  }

  /// Send a welcome email to a user
  Future<bool> sendWelcomeEmail(
    Session session, {
    required String email,
    required String name,
  }) async {
    if (!EmailService.instance.isReady) {
      session.log('[EmailEndpoint] Email service not ready');
      return false;
    }

    final result = await EmailService.instance.sendWelcomeEmail(
      email: email,
      name: name,
    );

    return result.success;
  }

  /// Send an order confirmation email
  Future<bool> sendOrderConfirmation(
    Session session, {
    required String email,
    required String name,
    required String orderId,
    required String serviceName,
    required String date,
    required String total,
  }) async {
    if (!EmailService.instance.isReady) {
      session.log('[EmailEndpoint] Email service not ready');
      return false;
    }

    final result = await EmailService.instance.sendOrderConfirmation(
      email: email,
      name: name,
      orderId: orderId,
      serviceName: serviceName,
      date: date,
      total: total,
    );

    return result.success;
  }

  /// Send a driver accepted notification email
  Future<bool> sendDriverAcceptedNotification(
    Session session, {
    required String email,
    required String name,
    required String orderId,
    required String driverName,
    required String driverPhone,
    String? vehicleInfo,
  }) async {
    if (!EmailService.instance.isReady) {
      session.log('[EmailEndpoint] Email service not ready');
      return false;
    }

    final result = await EmailService.instance.sendDriverAcceptedEmail(
      email: email,
      name: name,
      orderId: orderId,
      driverName: driverName,
      driverPhone: driverPhone,
      vehicleInfo: vehicleInfo,
    );

    return result.success;
  }

  /// Send an order completed email
  Future<bool> sendOrderCompletedEmail(
    Session session, {
    required String email,
    required String name,
    required String orderId,
    required String serviceName,
    required String total,
  }) async {
    if (!EmailService.instance.isReady) {
      session.log('[EmailEndpoint] Email service not ready');
      return false;
    }

    final result = await EmailService.instance.sendOrderCompletedEmail(
      email: email,
      name: name,
      orderId: orderId,
      serviceName: serviceName,
      total: total,
    );

    return result.success;
  }

  /// Send a custom email (admin only - requires authentication)
  Future<bool> sendCustomEmail(
    Session session, {
    required String recipientEmail,
    String? recipientName,
    required String subject,
    required String htmlBody,
    String? textBody,
  }) async {
    // Check if user is authenticated and is admin
    // For now, just check authentication
    final auth = await session.authenticated;
    if (auth == null) {
      throw Exception('Authentication required');
    }

    if (!EmailService.instance.isReady) {
      session.log('[EmailEndpoint] Email service not ready');
      return false;
    }

    final result = await EmailService.instance.sendCustomEmail(
      recipient: EmailRecipient(recipientEmail, recipientName),
      subject: subject,
      htmlBody: htmlBody,
      textBody: textBody,
    );

    return result.success;
  }
}
