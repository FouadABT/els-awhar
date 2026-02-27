import 'package:get/get.dart';

import '../../../core/services/storage_service.dart';
import 'onboarding_controller.dart';

/// Binding for onboarding module
class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(
      () => OnboardingController(Get.find<StorageService>()),
    );
  }
}
