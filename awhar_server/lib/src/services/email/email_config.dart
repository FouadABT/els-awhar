/// Email configuration for SMTP services
/// 
/// This class holds the SMTP configuration loaded from the server config files.
/// Supports Brevo (Sendinblue) and other SMTP providers.
class EmailConfig {
  /// SMTP server host (e.g., smtp-relay.brevo.com)
  final String host;
  
  /// SMTP port (typically 587 for TLS, 465 for SSL)
  final int port;
  
  /// SMTP username/login
  final String username;
  
  /// SMTP password/API key
  final String password;
  
  /// Default sender email address
  final String senderEmail;
  
  /// Default sender name
  final String senderName;
  
  /// Whether to use SSL (port 465) or TLS (port 587)
  final bool useSsl;
  
  /// Whether email service is enabled
  final bool enabled;

  const EmailConfig({
    required this.host,
    required this.port,
    required this.username,
    required this.password,
    required this.senderEmail,
    required this.senderName,
    this.useSsl = false,
    this.enabled = true,
  });

  /// Create config from a map (loaded from YAML config)
  factory EmailConfig.fromMap(Map<String, dynamic> map) {
    return EmailConfig(
      host: map['host'] as String? ?? 'smtp-relay.brevo.com',
      port: map['port'] as int? ?? 587,
      username: map['username'] as String? ?? '',
      password: map['password'] as String? ?? '',
      senderEmail: map['senderEmail'] as String? ?? 'noreply@awhar.com',
      senderName: map['senderName'] as String? ?? 'Awhar',
      useSsl: map['ssl'] as bool? ?? false,
      enabled: map['enabled'] as bool? ?? true,
    );
  }

  /// Create a disabled/empty config
  factory EmailConfig.disabled() {
    return const EmailConfig(
      host: '',
      port: 587,
      username: '',
      password: '',
      senderEmail: '',
      senderName: '',
      enabled: false,
    );
  }

  /// Check if config is valid
  bool get isValid => 
    enabled && 
    host.isNotEmpty && 
    username.isNotEmpty && 
    password.isNotEmpty &&
    senderEmail.isNotEmpty;

  @override
  String toString() => 'EmailConfig(host: $host, port: $port, enabled: $enabled)';
}
