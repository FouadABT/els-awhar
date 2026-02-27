import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'auth_controller.dart';

/// Controller for managing driver's service catalog
/// Handles CRUD operations for driver services and images
class DriverServicesController extends GetxController {
  final Client _client = Get.find<Client>();
  final AuthController _authController = Get.find<AuthController>();
  final ImagePicker _imagePicker = ImagePicker();

  // ============================================================
  // OBSERVABLE STATE
  // ============================================================

  /// List of driver's services
  final RxList<DriverService> myServices = <DriverService>[].obs;

  /// Map of service images by service ID
  /// Key: service ID, Value: list of service images
  final RxMap<int, List<ServiceImage>> serviceImageMap = <int, List<ServiceImage>>{}.obs;

  /// All available service categories
  final RxList<ServiceCategory> categories = <ServiceCategory>[].obs;

  /// Currently selected category for filtering
  final Rx<ServiceCategory?> selectedCategory = Rx<ServiceCategory?>(null);

  /// Loading state
  final RxBool isLoading = false.obs;

  /// Error message
  final RxString errorMessage = ''.obs;

  /// Uploading state for image uploads
  final RxBool isUploading = false.obs;

  /// Upload progress (0.0 to 1.0)
  final RxDouble uploadProgress = 0.0.obs;

  /// Per-service loading state for toggle operations
  final RxMap<int, bool> serviceToggleLoading = <int, bool>{}.obs;

  // ============================================================
  // LIFECYCLE
  // ============================================================

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    loadMyServices();
  }

  // ============================================================
  // LOAD DATA
  // ============================================================

  /// Load all service categories
  Future<void> loadCategories() async {
    try {
      debugPrint('🔵 Loading categories...');
      final result = await _client.service.getCategories(activeOnly: true);
      categories.value = result;
      debugPrint('✅ Loaded ${result.length} categories');
      for (var cat in result) {
        debugPrint('  - Category: ${cat.name} (ID: ${cat.id})');
      }
    } catch (e) {
      debugPrint('❌ Error loading categories: $e');
      errorMessage.value = 'errors.load_categories'.tr;
    }
  }

  /// Load services for a specific category
  Future<List<Service>> loadServicesByCategory(int categoryId) async {
    try {
      debugPrint('🔵 Loading services for category ID: $categoryId');
      final services = await _client.service.getServicesByCategory(
        categoryId: categoryId,
        activeOnly: true,
      );
      debugPrint(
        '✅ Loaded ${services.length} services for category $categoryId',
      );
      for (var service in services) {
        debugPrint('  - Service: ${service.nameEn} (ID: ${service.id})');
      }
      return services;
    } catch (e) {
      debugPrint('❌ Error loading services by category: $e');
      debugPrint('Stack trace: ${StackTrace.current}');
      return [];
    }
  }

  /// Load driver's services
  Future<void> loadMyServices() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final userId = _authController.currentUser.value?.id;
      debugPrint('\n📦 === LOADING MY SERVICES ===');
      debugPrint('   User ID: $userId');

      if (userId == null) {
        debugPrint('❌ User ID is null!');
        errorMessage.value = 'errors.driver_not_found'.tr;
        return;
      }

      debugPrint('📡 Calling backend getDriverServices...');
      // Use userId as driverId - backend will handle driver_profile lookup
      final result = await _client.driver.getDriverServices(driverId: userId);

      debugPrint('📥 Received ${result.length} services from backend');
      for (var service in result) {
        debugPrint(
          '   - Service ID: ${service.id}, Title: ${service.title}, Active: ${service.isActive}',
        );
      }

      myServices.value = result;

      // Fetch images for each service
      debugPrint('📸 Loading service images...');
      serviceImageMap.clear();
      for (var service in result) {
        if (service.id != null) {
          final images = await getServiceImages(service.id!);
          serviceImageMap[service.id!] = images;
          debugPrint(
            '   ✅ Service ID ${service.id}: ${images.length} images',
          );
        }
      }

      debugPrint('✅ myServices updated. Total count: ${myServices.length}');
      debugPrint('   hasServices: $hasServices');
      debugPrint('   activeServicesCount: $activeServicesCount');
    } catch (e, stackTrace) {
      debugPrint('❌ Error loading driver services: $e');
      debugPrint('Stack trace: $stackTrace');
      errorMessage.value = 'errors.load_services'.tr;
    } finally {
      isLoading.value = false;
      debugPrint('🏁 === LOAD MY SERVICES FINISHED ===\n');
    }
  }

  /// Get services filtered by category
  List<DriverService> getServicesByCategory(int? categoryId) {
    if (categoryId == null) return myServices;
    return myServices.where((s) => s.categoryId == categoryId).toList();
  }

  // ============================================================
  // ADD SERVICE
  // ============================================================

  /// Add a new driver service
  Future<int?> addService({
    required int serviceId,
    required int categoryId,
    String? title,
    String? description,
    double? basePrice,
    double? pricePerKm,
    double? pricePerHour,
    double? minPrice,
  }) async {
    try {
      debugPrint('🚀 === ADD SERVICE STARTED ===');
      debugPrint('   Service ID: $serviceId');
      debugPrint('   Category ID: $categoryId');
      debugPrint('   Title: $title');
      debugPrint('   Description: $description');
      debugPrint('   Base Price: $basePrice');
      debugPrint('   Price/KM: $pricePerKm');
      debugPrint('   Price/Hour: $pricePerHour');
      debugPrint('   Min Price: $minPrice');

      isLoading.value = true;
      errorMessage.value = '';

      final userId = _authController.currentUser.value?.id;
      debugPrint('   User ID: $userId');

      if (userId == null) {
        debugPrint('❌ User ID is null!');
        errorMessage.value = 'errors.driver_not_found'.tr;
        return null;
      }

      debugPrint('📡 Calling backend API...');
      final result = await _client.driver.addDriverService(
        driverId: userId,
        serviceId: serviceId,
        categoryId: categoryId,
        title: title,
        description: description,
        basePrice: basePrice,
        pricePerKm: pricePerKm,
        pricePerHour: pricePerHour,
        minPrice: minPrice,
      );

      debugPrint('📥 Backend response received');
      debugPrint('   Result: ${result?.id}');

      if (result != null) {
        myServices.add(result);
        debugPrint(
          '✅ Service added successfully! ID: ${result.id}, Total services: ${myServices.length}',
        );
        Get.snackbar(
          'common.success'.tr,
          'driver.services.service_added'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return result.id; // Return the service ID
      } else {
        debugPrint('❌ Backend returned null result');
        errorMessage.value = 'errors.add_service_failed'.tr;
        return null;
      }
    } catch (e, stackTrace) {
      debugPrint('❌ === ERROR ADDING SERVICE ===');
      debugPrint('Error: $e');
      debugPrint('Stack trace: $stackTrace');
      errorMessage.value = 'errors.add_service'.tr;
      Get.snackbar(
        'common.error'.tr,
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
      return null;
    } finally {
      isLoading.value = false;
      debugPrint('🏁 === ADD SERVICE FINISHED ===\n');
    }
  }

  // ============================================================
  // UPDATE SERVICE
  // ============================================================

  /// Update an existing driver service
  Future<bool> updateService({
    required int serviceId,
    String? title,
    String? description,
    double? basePrice,
    double? pricePerKm,
    double? pricePerHour,
    double? minPrice,
    bool? isAvailable,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _client.driver.updateDriverService(
        serviceId: serviceId,
        title: title,
        description: description,
        basePrice: basePrice,
        pricePerKm: pricePerKm,
        pricePerHour: pricePerHour,
        minPrice: minPrice,
        isAvailable: isAvailable,
      );

      if (result != null) {
        final index = myServices.indexWhere((s) => s.id == serviceId);
        if (index != -1) {
          myServices[index] = result;
        }
        Get.snackbar(
          'common.success'.tr,
          'driver.services.service_updated'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      } else {
        errorMessage.value = 'errors.update_service_failed'.tr;
        return false;
      }
    } catch (e) {
      debugPrint('Error updating service: $e');
      errorMessage.value = 'errors.update_service'.tr;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // DELETE SERVICE
  // ============================================================

  /// Delete a driver service
  Future<bool> deleteService(int serviceId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _client.driver.deleteDriverService(
        serviceId: serviceId,
      );

      if (result) {
        myServices.removeWhere((s) => s.id == serviceId);
        Get.snackbar(
          'common.success'.tr,
          'driver.services.service_deleted'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      } else {
        errorMessage.value = 'errors.delete_service_failed'.tr;
        return false;
      }
    } catch (e) {
      debugPrint('Error deleting service: $e');
      errorMessage.value = 'errors.delete_service'.tr;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // TOGGLE AVAILABILITY
  // ============================================================

  /// Toggle service availability (quick enable/disable)
  /// Uses optimistic updates with rollback on error
  Future<bool> toggleServiceAvailability(
    int serviceId,
    bool newAvailability,
  ) async {
    // Prevent duplicate toggles
    if (serviceToggleLoading[serviceId] == true) {
      debugPrint('⚠️ Toggle already in progress for service $serviceId');
      return false;
    }

    // Find service and store original state for rollback
    final index = myServices.indexWhere((s) => s.id == serviceId);
    if (index == -1) {
      debugPrint('❌ Service $serviceId not found in myServices');
      return false;
    }

    final originalService = myServices[index];
    final oldAvailability = originalService.isAvailable;

    try {
      // Set loading state
      serviceToggleLoading[serviceId] = true;
      debugPrint(
        '🔄 Toggling service $serviceId: $oldAvailability → $newAvailability',
      );

      // Optimistic update: Update UI immediately
      final optimisticService = DriverService(
        id: originalService.id,
        driverId: originalService.driverId,
        serviceId: originalService.serviceId,
        categoryId: originalService.categoryId,
        priceType: originalService.priceType,
        title: originalService.title,
        description: originalService.description,
        customDescription: originalService.customDescription,
        basePrice: originalService.basePrice,
        pricePerKm: originalService.pricePerKm,
        pricePerHour: originalService.pricePerHour,
        minPrice: originalService.minPrice,
        imageUrl: originalService.imageUrl,
        viewCount: originalService.viewCount,
        inquiryCount: originalService.inquiryCount,
        bookingCount: originalService.bookingCount,
        isActive: originalService.isActive,
        isAvailable: newAvailability, // Optimistically update this field
        availableFrom: originalService.availableFrom,
        availableUntil: originalService.availableUntil,
        displayOrder: originalService.displayOrder,
        createdAt: originalService.createdAt,
        updatedAt: DateTime.now(),
      );
      myServices[index] = optimisticService;
      myServices.refresh(); // Force UI update

      // Call backend API
      final result = await _client.driver.toggleServiceAvailability(
        serviceId: serviceId,
        isAvailable: newAvailability,
      );

      if (result != null) {
        // Backend success: Update with server response
        myServices[index] = result;
        myServices.refresh();
        debugPrint('✅ Service $serviceId toggled successfully');

        // Show success feedback
        Get.snackbar(
          'common.success'.tr,
          newAvailability
              ? 'driver.services.service_activated'.tr
              : 'driver.services.service_paused'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: newAvailability ? Colors.green : Colors.orange,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          margin: EdgeInsets.all(8),
        );

        return true;
      } else {
        // Backend returned null: Rollback
        debugPrint('⚠️ Backend returned null, rolling back service $serviceId');
        myServices[index] = originalService;
        myServices.refresh();

        Get.snackbar(
          'common.error'.tr,
          'errors.toggle_service_failed'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: EdgeInsets.all(8),
        );

        return false;
      }
    } catch (e, stackTrace) {
      // Error: Rollback optimistic update
      debugPrint('❌ Error toggling service $serviceId: $e');
      debugPrint('Stack trace: $stackTrace');

      myServices[index] = originalService;
      myServices.refresh();

      Get.snackbar(
        'common.error'.tr,
        'errors.network_error'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.all(8),
      );

      return false;
    } finally {
      // Clear loading state
      serviceToggleLoading.remove(serviceId);
      debugPrint('🏁 Toggle operation completed for service $serviceId');
    }
  }

  // ============================================================
  // REORDER SERVICES
  // ============================================================

  /// Reorder driver services
  Future<bool> reorderServices(List<int> serviceIds) async {
    try {
      final userId = _authController.currentUser.value?.id;
      if (userId == null) return false;

      final result = await _client.driver.reorderDriverServices(
        driverId: userId,
        serviceIds: serviceIds,
      );

      if (result) {
        await loadMyServices(); // Reload to get updated order
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error reordering services: $e');
      return false;
    }
  }

  // ============================================================
  // IMAGE MANAGEMENT
  // ============================================================

  /// Pick image from gallery or camera
  Future<File?> pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error picking image: $e');
      errorMessage.value = 'errors.pick_image'.tr;
      return null;
    }
  }

  /// Pick multiple images from gallery
  Future<List<File>> pickMultipleImages({int maxImages = 5}) async {
    try {
      final List<XFile> pickedFiles = await _imagePicker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFiles.length > maxImages) {
        Get.snackbar(
          'common.warning'.tr,
          'driver.services.max_images_warning'.trParams({'max': '$maxImages'}),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return pickedFiles
            .sublist(0, maxImages)
            .map((xfile) => File(xfile.path))
            .toList();
      }

      return pickedFiles.map((xfile) => File(xfile.path)).toList();
    } catch (e) {
      debugPrint('Error picking multiple images: $e');
      errorMessage.value = 'errors.pick_images'.tr;
      return [];
    }
  }

  /// Compress image before upload
  Future<File?> compressImage(File file) async {
    try {
      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        '${file.parent.path}/compressed_${file.uri.pathSegments.last}',
        quality: 70,
        minWidth: 800,
        minHeight: 600,
      );

      return result != null ? File(result.path) : null;
    } catch (e) {
      debugPrint('Error compressing image: $e');
      return file; // Return original if compression fails
    }
  }

  /// Upload service image
  Future<ServiceImage?> uploadServiceImage({
    required int driverServiceId,
    required File imageFile,
    String? caption,
  }) async {
    try {
      isUploading.value = true;
      uploadProgress.value = 0.0;

      debugPrint('📸 === UPLOADING SERVICE IMAGE ===');
      debugPrint('   Service ID: $driverServiceId');
      debugPrint('   File: ${imageFile.path}');

      // Compress image
      uploadProgress.value = 0.3;
      debugPrint('🔄 Compressing image...');
      final compressedFile = await compressImage(imageFile);
      if (compressedFile == null) {
        debugPrint('❌ Image compression failed');
        errorMessage.value = 'errors.compress_image'.tr;
        return null;
      }
      debugPrint('✅ Image compressed: ${await compressedFile.length()} bytes');

      // Read file as bytes
      uploadProgress.value = 0.5;
      final bytes = await compressedFile.readAsBytes();
      final byteData = ByteData.view(bytes.buffer);

      // Generate unique filename
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = imageFile.path.split('.').last;
      final filename = 'service_${driverServiceId}_${timestamp}.$extension';

      debugPrint('🚀 Uploading to backend: $filename');
      uploadProgress.value = 0.7;

      // Upload to backend storage (this needs a new endpoint)
      // For now, use the uploadProfilePhoto pattern
      final imageUrl = await _uploadImageToStorage(
        bytes: byteData,
        filename: filename,
        folder: 'service-images/$driverServiceId',
      );

      if (imageUrl == null) {
        debugPrint('❌ Failed to get image URL from backend');
        errorMessage.value = 'errors.upload_image'.tr;
        return null;
      }

      debugPrint('✅ Image uploaded: $imageUrl');
      uploadProgress.value = 0.9;

      // Save image metadata to database
      final result = await _client.driver.uploadServiceImage(
        driverServiceId: driverServiceId,
        imageUrl: imageUrl,
        caption: caption,
        fileSize: bytes.length,
      );

      uploadProgress.value = 1.0;
      debugPrint('✅ Image metadata saved to database');

      return result;
    } catch (e, stackTrace) {
      debugPrint('❌ Error uploading service image: $e');
      debugPrint('Stack trace: $stackTrace');
      errorMessage.value = 'errors.upload_image'.tr;
      return null;
    } finally {
      isUploading.value = false;
      uploadProgress.value = 0.0;
    }
  }

  /// Upload image to storage (helper method)
  Future<String?> _uploadImageToStorage({
    required ByteData bytes,
    required String filename,
    required String folder,
  }) async {
    try {
      debugPrint('📤 Uploading to backend storage...');

      // Extract service ID from folder path (format: "service-images/{serviceId}")
      final parts = folder.split('/');
      final serviceIdStr = parts.isNotEmpty ? parts.last : '';
      final serviceId = int.tryParse(serviceIdStr);

      if (serviceId == null) {
        debugPrint('❌ Invalid service ID in folder: $folder');
        return null;
      }

      // Call the new backend endpoint
      final imageUrl = await _client.driver.uploadServiceImageFile(
        driverServiceId: serviceId,
        imageData: bytes,
        fileName: filename,
      );

      if (imageUrl != null) {
        debugPrint('✅ Image URL received: $imageUrl');
      } else {
        debugPrint('❌ Backend returned null URL');
      }

      return imageUrl;
    } catch (e, stackTrace) {
      debugPrint('❌ Error in _uploadImageToStorage: $e');
      debugPrint('Stack trace: $stackTrace');
      return null;
    }
  }

  /// Get service images
  Future<List<ServiceImage>> getServiceImages(int driverServiceId) async {
    try {
      return await _client.driver.getServiceImages(
        driverServiceId: driverServiceId,
      );
    } catch (e) {
      debugPrint('Error getting service images: $e');
      return [];
    }
  }

  /// Delete service image
  Future<bool> deleteServiceImage(int imageId) async {
    try {
      return await _client.driver.deleteServiceImage(imageId: imageId);
    } catch (e) {
      debugPrint('Error deleting service image: $e');
      return false;
    }
  }

  // ============================================================
  // HELPERS
  // ============================================================

  /// Get active services count
  int get activeServicesCount =>
      myServices.where((s) => s.isActive && s.isAvailable).length;

  /// Check if driver has any services
  bool get hasServices => myServices.isNotEmpty;

  /// Clear error message
  void clearError() {
    errorMessage.value = '';
  }
}
