import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awhar_client/awhar_client.dart';

class TestEmailScreen extends StatefulWidget {
  const TestEmailScreen({super.key});

  @override
  State<TestEmailScreen> createState() => _TestEmailScreenState();
}

class _TestEmailScreenState extends State<TestEmailScreen> {
  bool _isSending = false;
  String _result = '';

  Future<void> _sendTestEmail() async {
    setState(() {
      _isSending = true;
      _result = 'Sending...';
    });

    try {
      final client = Get.find<Client>();
      final success = await client.email.sendTestEmail('fouad.abt@gmail.com');
      
      setState(() {
        _isSending = false;
        _result = success 
          ? '✅ Email sent successfully to fouad.abt@gmail.com!' 
          : '❌ Failed to send email';
      });
    } catch (e) {
      setState(() {
        _isSending = false;
        _result = '❌ Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Email Service'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Test Email Service',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Will send a welcome email to:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 4),
              const Text(
                'fouad.abt@gmail.com',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isSending ? null : _sendTestEmail,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                ),
                child: _isSending
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        'Send Test Email',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
              const SizedBox(height: 24),
              if (_result.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _result.contains('✅') 
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _result.contains('✅') ? Colors.green : Colors.red,
                    ),
                  ),
                  child: Text(
                    _result,
                    style: TextStyle(
                      fontSize: 16,
                      color: _result.contains('✅') ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
