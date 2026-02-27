import 'package:get/get.dart';

import '../../../core/controllers/auth_controller.dart';

/// Binding for authentication screens
/// Initializes AuthController when navigating to auth routes
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // AuthController should already be initialized globally
    // but ensure it's available
    if (!Get.isRegistered<AuthController>()) {
      Get.put(AuthController(), permanent: true);
    }
  }
}
