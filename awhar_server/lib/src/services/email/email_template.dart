/// Email template types supported by the email service
enum EmailTemplateType {
  /// Welcome email sent after registration
  welcome,
  
  /// Password reset email
  passwordReset,
  
  /// Email verification
  emailVerification,
  
  /// Order confirmation
  orderConfirmation,
  
  /// Order status update
  orderStatusUpdate,
  
  /// Driver accepted order
  driverAccepted,
  
  /// Order completed
  orderCompleted,
  
  /// Custom/generic email
  custom,
}

/// Email template with subject and body
class EmailTemplate {
  final String subject;
  final String htmlBody;
  final String? textBody;

  const EmailTemplate({
    required this.subject,
    required this.htmlBody,
    this.textBody,
  });

  /// Replace placeholders in template with actual values
  /// Placeholders are in format {{key}}
  EmailTemplate replaceVariables(Map<String, String> variables) {
    String processedSubject = subject;
    String processedHtmlBody = htmlBody;
    String? processedTextBody = textBody;

    variables.forEach((key, value) {
      processedSubject = processedSubject.replaceAll('{{$key}}', value);
      processedHtmlBody = processedHtmlBody.replaceAll('{{$key}}', value);
      if (processedTextBody != null) {
        processedTextBody = processedTextBody!.replaceAll('{{$key}}', value);
      }
    });

    return EmailTemplate(
      subject: processedSubject,
      htmlBody: processedHtmlBody,
      textBody: processedTextBody,
    );
  }
}

/// Collection of email templates
class EmailTemplates {
  /// App name for templates
  static const String appName = 'Awhar';
  
  /// Base HTML wrapper for all emails
  static String _wrapHtml(String content) {
    return '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>$appName</title>
  <style>
    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
    .header { background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%); padding: 30px; text-align: center; border-radius: 12px 12px 0 0; }
    .header h1 { color: white; margin: 0; font-size: 28px; }
    .content { background: white; padding: 40px; border-radius: 0 0 12px 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
    .button { display: inline-block; background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%); color: white; padding: 14px 28px; text-decoration: none; border-radius: 8px; font-weight: 600; margin: 20px 0; }
    .footer { text-align: center; padding: 20px; color: #666; font-size: 12px; }
    .code { background: #f0f0f0; padding: 15px 30px; font-size: 32px; font-weight: bold; letter-spacing: 5px; border-radius: 8px; display: inline-block; margin: 20px 0; }
    h2 { color: #333; margin-top: 0; }
    p { color: #555; line-height: 1.6; }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>$appName</h1>
    </div>
    <div class="content">
      $content
    </div>
    <div class="footer">
      <p>&copy; ${DateTime.now().year} $appName. All rights reserved.</p>
      <p>This email was sent to {{email}}</p>
    </div>
  </div>
</body>
</html>
''';
  }

  /// Welcome email template
  static EmailTemplate welcome() {
    return EmailTemplate(
      subject: 'Welcome to $appName! 🎉',
      htmlBody: _wrapHtml('''
        <h2>Welcome to $appName, {{name}}! 👋</h2>
        <p>We're thrilled to have you join our community. With $appName, you can:</p>
        <ul>
          <li>Order services from trusted providers</li>
          <li>Track your orders in real-time</li>
          <li>Connect with reliable drivers</li>
        </ul>
        <p>Get started by exploring our services!</p>
        <a href="{{appLink}}" class="button">Open $appName</a>
        <p>If you have any questions, our support team is always here to help.</p>
      '''),
      textBody: '''
Welcome to $appName, {{name}}!

We're thrilled to have you join our community.

Get started by opening the app and exploring our services.

Best regards,
The $appName Team
      ''',
    );
  }

  /// Password reset email template
  static EmailTemplate passwordReset() {
    return EmailTemplate(
      subject: 'Reset Your $appName Password',
      htmlBody: _wrapHtml('''
        <h2>Password Reset Request</h2>
        <p>Hi {{name}},</p>
        <p>We received a request to reset your password. Use the code below to reset it:</p>
        <div class="code">{{code}}</div>
        <p>This code will expire in <strong>15 minutes</strong>.</p>
        <p>If you didn't request this, you can safely ignore this email.</p>
        <p style="color: #999; font-size: 12px;">For security, never share this code with anyone.</p>
      '''),
      textBody: '''
Password Reset Request

Hi {{name}},

We received a request to reset your password. Use this code: {{code}}

This code will expire in 15 minutes.

If you didn't request this, you can safely ignore this email.

Best regards,
The $appName Team
      ''',
    );
  }

  /// Email verification template
  static EmailTemplate emailVerification() {
    return EmailTemplate(
      subject: 'Verify Your Email - $appName',
      htmlBody: _wrapHtml('''
        <h2>Verify Your Email Address</h2>
        <p>Hi {{name}},</p>
        <p>Thanks for signing up! Please verify your email using the code below:</p>
        <div class="code">{{code}}</div>
        <p>This code will expire in <strong>30 minutes</strong>.</p>
        <p>If you didn't create an account, you can ignore this email.</p>
      '''),
      textBody: '''
Verify Your Email Address

Hi {{name}},

Thanks for signing up! Please verify your email using this code: {{code}}

This code will expire in 30 minutes.

Best regards,
The $appName Team
      ''',
    );
  }

  /// Order confirmation template
  static EmailTemplate orderConfirmation() {
    return EmailTemplate(
      subject: 'Order Confirmed - #{{orderId}}',
      htmlBody: _wrapHtml('''
        <h2>Order Confirmed! ✅</h2>
        <p>Hi {{name}},</p>
        <p>Your order <strong>#{{orderId}}</strong> has been confirmed.</p>
        <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0;">
          <p style="margin: 5px 0;"><strong>Service:</strong> {{serviceName}}</p>
          <p style="margin: 5px 0;"><strong>Date:</strong> {{date}}</p>
          <p style="margin: 5px 0;"><strong>Total:</strong> {{total}} MAD</p>
        </div>
        <p>We'll notify you when a driver accepts your order.</p>
        <a href="{{trackLink}}" class="button">Track Order</a>
      '''),
      textBody: '''
Order Confirmed!

Hi {{name}},

Your order #{{orderId}} has been confirmed.

Service: {{serviceName}}
Date: {{date}}
Total: {{total}} MAD

We'll notify you when a driver accepts your order.

Best regards,
The $appName Team
      ''',
    );
  }

  /// Driver accepted order template
  static EmailTemplate driverAccepted() {
    return EmailTemplate(
      subject: 'Driver Assigned - Order #{{orderId}}',
      htmlBody: _wrapHtml('''
        <h2>Driver Assigned! 🚗</h2>
        <p>Hi {{name}},</p>
        <p>Good news! A driver has accepted your order <strong>#{{orderId}}</strong>.</p>
        <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0;">
          <p style="margin: 5px 0;"><strong>Driver:</strong> {{driverName}}</p>
          <p style="margin: 5px 0;"><strong>Phone:</strong> {{driverPhone}}</p>
          <p style="margin: 5px 0;"><strong>Vehicle:</strong> {{vehicleInfo}}</p>
        </div>
        <p>You can track your order in real-time in the app.</p>
        <a href="{{trackLink}}" class="button">Track Order</a>
      '''),
      textBody: '''
Driver Assigned!

Hi {{name}},

A driver has accepted your order #{{orderId}}.

Driver: {{driverName}}
Phone: {{driverPhone}}
Vehicle: {{vehicleInfo}}

Track your order in the app.

Best regards,
The $appName Team
      ''',
    );
  }

  /// Order completed template
  static EmailTemplate orderCompleted() {
    return EmailTemplate(
      subject: 'Order Completed - #{{orderId}}',
      htmlBody: _wrapHtml('''
        <h2>Order Completed! 🎉</h2>
        <p>Hi {{name}},</p>
        <p>Your order <strong>#{{orderId}}</strong> has been completed successfully.</p>
        <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0;">
          <p style="margin: 5px 0;"><strong>Service:</strong> {{serviceName}}</p>
          <p style="margin: 5px 0;"><strong>Total:</strong> {{total}} MAD</p>
        </div>
        <p>We hope you had a great experience! Please take a moment to rate your driver.</p>
        <a href="{{rateLink}}" class="button">Rate Your Experience</a>
        <p style="color: #999; margin-top: 20px;">Thank you for using $appName!</p>
      '''),
      textBody: '''
Order Completed!

Hi {{name}},

Your order #{{orderId}} has been completed successfully.

Service: {{serviceName}}
Total: {{total}} MAD

We hope you had a great experience!

Thank you for using $appName!
      ''',
    );
  }

  /// Get template by type
  static EmailTemplate getTemplate(EmailTemplateType type) {
    switch (type) {
      case EmailTemplateType.welcome:
        return welcome();
      case EmailTemplateType.passwordReset:
        return passwordReset();
      case EmailTemplateType.emailVerification:
        return emailVerification();
      case EmailTemplateType.orderConfirmation:
        return orderConfirmation();
      case EmailTemplateType.driverAccepted:
        return driverAccepted();
      case EmailTemplateType.orderCompleted:
        return orderCompleted();
      case EmailTemplateType.orderStatusUpdate:
      case EmailTemplateType.custom:
        throw ArgumentError('Use sendCustomEmail for custom templates');
    }
  }
}
