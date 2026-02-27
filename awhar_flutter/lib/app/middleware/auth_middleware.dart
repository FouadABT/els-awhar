import 'package:awhar_client/awhar_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/controllers/auth_controller.dart';
import '../routes/app_routes.dart';

/// Middleware to check if user is authenticated
class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();

    // Wait for auth initialization to complete
    if (!authController.isInitialized.value) {
      // Return null to allow navigation, HomeScreen will show loading
      return null;
    }

    if (!authController.isAuthenticated) {
      return const RouteSettings(name: AppRoutes.authLogin);
    }
    return null;
  }
}

/// Middleware to protect driver-only routes
class DriverMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();

    // Wait for auth initialization
    if (!authController.isInitialized.value) {
      return null;
    }

    // Check if authenticated first
    if (!authController.isAuthenticated) {
      return const RouteSettings(name: AppRoutes.authLogin);
    }

    // Check if user has driver role
    if (!authController.hasRole(UserRole.driver)) {
      Get.snackbar(
        'access_denied'.tr,
        'driver_only_feature'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return const RouteSettings(name: AppRoutes.home);
    }

    return null;
  }
}

/// Middleware to protect client-only routes
class ClientMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();

    // Wait for auth initialization
    if (!authController.isInitialized.value) {
      return null;
    }

    // Check if authenticated first
    if (!authController.isAuthenticated) {
      return const RouteSettings(name: AppRoutes.authLogin);
    }

    // Check if user has client role
    if (!authController.hasRole(UserRole.client)) {
      Get.snackbar(
        'access_denied'.tr,
        'client_only_feature'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return const RouteSettings(name: AppRoutes.home);
    }

    return null;
  }
}

/// Middleware to protect routes that require specific role
class RoleMiddleware extends GetMiddleware {
  final UserRole requiredRole;

  RoleMiddleware(this.requiredRole);

  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();

    // Check if authenticated first
    if (!authController.isAuthenticated) {
      return const RouteSettings(name: AppRoutes.authLogin);
    }

    // Check if user has required role
    if (!authController.hasRole(requiredRole)) {
      final roleString = requiredRole == UserRole.driver ? 'driver' : 'client';
      Get.snackbar(
        'access_denied'.tr,
        '${roleString}_only_feature'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return const RouteSettings(name: AppRoutes.home);
    }

    return null;
  }
}

/// Middleware to redirect users who are already authenticated
class GuestMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();

    if (authController.isAuthenticated) {
      return const RouteSettings(name: AppRoutes.home);
    }
    return null;
  }
}
