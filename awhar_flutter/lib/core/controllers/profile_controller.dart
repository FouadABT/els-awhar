import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:awhar_client/awhar_client.dart';

import '../services/image_service.dart';
import 'auth_controller.dart';

/// Profile controller for managing user profile operations
class ProfileController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();
  late final ImageService _imageService;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isUploadingPhoto = false.obs;
  final RxBool isLoadingDriverReviews = false.obs;
  final RxDouble driverReviewAverage = 0.0.obs;
  final RxInt driverReviewCount = 0.obs;
  final RxBool isLoadingClientGivenReviews = false.obs;
  final RxDouble clientGivenAverage = 0.0.obs;
  final RxInt clientGivenCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final client = Get.find<Client>();
    _imageService = ImageService(client);

    final current = _authController.currentUser.value;
    if (current != null && current.roles.contains(UserRole.driver)) {
      loadDriverReviewStats();
      loadClientGivenReviewStats();
    }

    ever(_authController.currentUser, (user) {
      if (user != null && user.roles.contains(UserRole.driver)) {
        loadDriverReviewStats();
        loadClientGivenReviewStats();
      }
    });
  }

  /// Load driver reviews summary from store reviews
  Future<void> loadDriverReviewStats() async {
    try {
      final userId = _authController.userId ?? _authController.currentUser.value?.id;
      if (userId == null) return;

      isLoadingDriverReviews.value = true;

      final client = Get.find<Client>();
      final reviews = await client.storeReview.getReviewsForReviewee(
        revieweeType: 'driver',
        revieweeId: userId,
        offset: 0,
        limit: 50,
      );

      if (reviews.isEmpty) {
        driverReviewAverage.value = 0.0;
        driverReviewCount.value = 0;
        return;
      }

      final total = reviews.fold<double>(0, (sum, r) => sum + r.rating);
      driverReviewAverage.value = total / reviews.length;
      driverReviewCount.value = reviews.length;
    } catch (e) {
      debugPrint('[ProfileController] ❌ Load driver reviews failed: $e');
    } finally {
      isLoadingDriverReviews.value = false;
    }
  }

  /// Load client review stats given by this driver
  Future<void> loadClientGivenReviewStats() async {
    try {
      final userId = _authController.userId ?? _authController.currentUser.value?.id;
      if (userId == null) return;

      isLoadingClientGivenReviews.value = true;

      final client = Get.find<Client>();
      final stats = await client.rating.getRatingsGivenStats(
        userId,
        ratingType: RatingType.driver_to_client,
      );

      clientGivenAverage.value = stats.averageRating;
      clientGivenCount.value = stats.totalRatings;
    } catch (e) {
      debugPrint('[ProfileController] ❌ Load client given reviews failed: $e');
    } finally {
      isLoadingClientGivenReviews.value = false;
    }
  }

  /// Get current user
  User? get currentUser => _authController.currentUser.value;

  /// Get user ID
  int? get userId => _authController.userId;

  /// Fix photo URL - replace 0.0.0.0 with actual server host
  Future<bool> fixPhotoUrl() async {
    try {
      if (userId == null) {
        debugPrint('[ProfileController] ❌ Cannot fix photo URL: userId is null');
        return false;
      }

      debugPrint('[ProfileController] 🔧 Fixing photo URL for user $userId...');
      
      final client = Get.find<Client>();
      final response = await client.user.fixPhotoUrls(userId: userId!);
      
      if (response.success) {
        debugPrint('[ProfileController] ✅ Photo URL fixed successfully');
        debugPrint('[ProfileController] 📷 New URL: ${response.user?.profilePhotoUrl}');
        
        // Refresh user data to update UI
        await _authController.refreshUserData();
        
        Get.snackbar(
          'Success',
          'Photo URL fixed successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        
        return true;
      } else {
        debugPrint('[ProfileController] ❌ Failed to fix photo URL: ${response.message}');
        return false;
      }
    } catch (e) {
      debugPrint('[ProfileController] ❌ Fix photo URL error: $e');
      return false;
    }
  }

  /// Upload profile photo
  Future<bool> uploadProfilePhoto(BuildContext context) async {
    try {
      debugPrint('[ProfileController] Starting photo upload...');
      
      if (userId == null) {
        debugPrint('[ProfileController] Error: userId is null');
        return false;
      }

      debugPrint('[ProfileController] User ID: $userId');
      isUploadingPhoto.value = true;
      errorMessage.value = '';

      // Pick image
      debugPrint('[ProfileController] Opening image picker...');
      final imageFile = await _imageService.pickImage(context);
      
      if (imageFile == null) {
        debugPrint('[ProfileController] No image selected');
        isUploadingPhoto.value = false;
        return false;
      }

      debugPrint('[ProfileController] Image selected: ${imageFile.path}');

      // Validate file size
      debugPrint('[ProfileController] Validating file size...');
      final isValid = await _imageService.isFileSizeValid(imageFile);
      if (!isValid) {
        debugPrint('[ProfileController] Image too large');
        errorMessage.value = 'Image is too large. Max size is 5MB';
        isUploadingPhoto.value = false;
        return false;
      }

      // Upload to backend
      debugPrint('[ProfileController] Uploading to backend...');
      final photoUrl = await _imageService.uploadProfilePhoto(imageFile, userId!);

      if (photoUrl == null) {
        debugPrint('[ProfileController] Upload returned null');
        errorMessage.value = 'Failed to upload photo';
        isUploadingPhoto.value = false;
        return false;
      }

      debugPrint('[ProfileController] 📸 Photo uploaded successfully!');
      debugPrint('[ProfileController] 📸 Photo URL returned from backend: $photoUrl');

      // Refresh user data
      debugPrint('[ProfileController] 🔄 Refreshing user data to get updated photo URL...');
      await _authController.refreshUserData();
      
      // Check if user data now has the photo URL
      final currentUser = _authController.currentUser.value;
      debugPrint('[ProfileController] ✅ User data refreshed');
      debugPrint('[ProfileController] 📷 User photoUrl after refresh: ${currentUser?.profilePhotoUrl}');
      debugPrint('[ProfileController] 👤 User full name: ${currentUser?.fullName}');

      isUploadingPhoto.value = false;
      debugPrint('[ProfileController] ✅ Upload completed successfully');
      
      Get.snackbar(
        'Success',
        'Profile photo updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      return true;
    } catch (e, stackTrace) {
      debugPrint('[ProfileController] Upload photo error: $e');
      debugPrint('[ProfileController] Stack trace: $stackTrace');
      errorMessage.value = 'Failed to upload photo: $e';
      isUploadingPhoto.value = false;
      return false;
    }
  }

  /// Update profile
  Future<bool> updateProfile({
    String? fullName,
    String? email,
    String? phoneNumber,
    Language? preferredLanguage,
    bool? notificationsEnabled,
    bool? darkModeEnabled,
  }) async {
    try {
      if (userId == null) return false;

      isLoading.value = true;
      errorMessage.value = '';

      final client = Get.find<Client>();
      final response = await client.user.updateProfile(
        userId: userId!,
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        preferredLanguage: preferredLanguage,
        notificationsEnabled: notificationsEnabled,
        darkModeEnabled: darkModeEnabled,
      );

      if (response.success && response.user != null) {
        _authController.currentUser.value = response.user;
        isLoading.value = false;

        Get.snackbar(
          'Success',
          'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        return true;
      }

      errorMessage.value = response.message;
      isLoading.value = false;
      return false;
    } catch (e) {
      debugPrint('[ProfileController] Update profile error: $e');
      errorMessage.value = 'Failed to update profile';
      isLoading.value = false;
      return false;
    }
  }

  /// Clear error
  void clearError() => errorMessage.value = '';
}
