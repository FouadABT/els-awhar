import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/theme/admin_theme.dart';
import 'core/services/api_service.dart';
import 'controllers/auth_controller.dart';
import 'routes/admin_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize GetStorage for session persistence
  await GetStorage.init();
  
  // Initialize Serverpod client
  await ApiService.instance.initialize();
  
  // Register AuthController
  Get.put(AuthController());
  
  runApp(const AwharAdminApp());
}

class AwharAdminApp extends StatelessWidget {
  const AwharAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    
    return Obx(() => GetMaterialApp(
      title: 'Awhar Admin Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AdminTheme.light,
      darkTheme: AdminTheme.dark,
      themeMode: ThemeMode.light,
      
      // Start at login if not authenticated, otherwise dashboard
      initialRoute: authController.isAuthenticated.value 
          ? AdminRoutes.dashboard 
          : AdminRoutes.login,
      
      getPages: AdminPages.pages,
      
      // Default transition
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ));
  }
}
