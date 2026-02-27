import 'package:get/get.dart';
import 'package:awhar_client/awhar_client.dart';
import '../../../core/controllers/auth_controller.dart';

/// Controller for main home screen with bottom navigation
class HomeController extends GetxController {
  /// Current selected tab index
  final RxInt currentIndex = 0.obs;

  /// AuthController for role management
  late final AuthController _authController;

  /// Client tab names for translation keys
  static const List<String> clientTabKeys = [
    'home.title',
    'client.explore.title',
    'client.orders.title',
    'messages.title',
    'profile.title',
  ];

  /// Driver tab names for translation keys
  static const List<String> driverTabKeys = [
    'driver.dashboard.title',
    'driver.rides.title',
    'driver.earnings.title',
    'messages.title',
    'profile.title',
  ];

  /// Store tab names for translation keys
  static const List<String> storeTabKeys = [
    'store_management.title',
    'store_management.orders',
    'store_management.products',
    'messages.title',
    'profile.title',
  ];

  @override
  void onInit() {
    super.onInit();
    _authController = Get.find<AuthController>();
  }

  /// Get navigation items count based on role
  int get tabCount => 5;

  /// Check if currently in driver mode
  bool get isDriverMode {
    final activeRole = _authController.primaryRole;
    return activeRole == UserRole.driver;
  }

  /// Check if currently in store mode
  bool get isStoreMode {
    final activeRole = _authController.primaryRole;
    return activeRole == UserRole.store;
  }

  /// Get tab keys based on current role
  List<String> get tabKeys {
    if (isDriverMode) return driverTabKeys;
    if (isStoreMode) return storeTabKeys;
    return clientTabKeys;
  }

  /// Change the current tab
  void changeTab(int index) {
    if (index >= 0 && index < tabCount) {
      currentIndex.value = index;
    }
  }

  /// Get current tab key for title
  String get currentTabKey => tabKeys[currentIndex.value];

  /// Reset to first tab (useful when switching roles)
  void resetToHome() {
    currentIndex.value = 0;
  }
}
