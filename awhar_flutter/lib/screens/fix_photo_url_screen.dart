import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/controllers/profile_controller.dart';

/// Simple screen to fix photo URL
class FixPhotoUrlScreen extends StatelessWidget {
  const FixPhotoUrlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fix Photo URL'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'This will fix your photo URL\nfrom 0.0.0.0 to your server host',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () async {
                final success = await profileController.fixPhotoUrl();
                if (success && context.mounted) {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.build),
              label: const Text('Fix Photo URL'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
