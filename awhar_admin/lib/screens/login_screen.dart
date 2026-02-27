import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/admin_colors.dart';
import '../controllers/auth_controller.dart';

/// Professional admin login screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authController = Get.find<AuthController>();
      final success = await authController.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (success) {
        Get.offAllNamed('/dashboard');
      } else {
        Get.snackbar(
          'Login Failed',
          authController.errorMessage.value,
          backgroundColor: AdminColors.error,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.backgroundLight,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo & Branding
                _buildHeader(),
                const SizedBox(height: 48),
                
                // Login Card
                _buildLoginCard(),
                
                const SizedBox(height: 24),
                
                // Footer
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Logo Container with App Icon
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AdminColors.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            'appiconnobackgound.png',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Awhar Admin',
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AdminColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to manage your platform',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: AdminColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Judge credentials hint
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AdminColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AdminColors.primary.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, size: 18, color: AdminColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        'For judges, use these credentials:',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AdminColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Email: admin@awhar.com\nPassword: admin123',
                    style: GoogleFonts.robotoMono(
                      fontSize: 12,
                      color: AdminColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),
            
            // Email Field
            Text(
              'Email',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AdminColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'admin@awhar.com',
                prefixIcon: const Icon(Icons.email_outlined, size: 20),
                filled: true,
                fillColor: AdminColors.surfaceLight,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AdminColors.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AdminColors.borderLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AdminColors.primary, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!GetUtils.isEmail(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Password Field
            Text(
              'Password',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AdminColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                hintText: '••••••••',
                prefixIcon: const Icon(Icons.lock_outline, size: 20),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
                filled: true,
                fillColor: AdminColors.surfaceLight,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AdminColors.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AdminColors.borderLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AdminColors.primary, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 32),
            
            // Login Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AdminColors.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: AdminColors.primarySoft,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Sign In',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AdminColors.success,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Server Connected',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AdminColors.textMutedLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '© 2026 Awhar. All rights reserved.',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AdminColors.textMutedLight,
          ),
        ),
      ],
    );
  }
}
