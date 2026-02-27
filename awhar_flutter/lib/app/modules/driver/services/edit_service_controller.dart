import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../core/controllers/driver_services_controller.dart';
import '../../../../core/theme/app_colors.dart';

/// Controller for editing driver services
class EditServiceController extends GetxController {
  // Dependencies
  late DriverServicesController servicesController;
  final ImagePicker _imagePicker = ImagePicker();
  
  // Route parameters
  late int serviceId;
  
  // Current service being edited
  final Rx<DriverService?> currentService = Rx<DriverService?>(null);
  
  // Form state
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  
  // Pricing
  final Rx<double?> basePrice = Rx<double?>(null);
  final Rx<double?> pricePerKm = Rx<double?>(null);
  final Rx<double?> pricePerHour = Rx<double?>(null);
  final Rx<double?> minPrice = Rx<double?>(null);
  
  // Availability
  final RxBool isAvailable = false.obs;
  
  // Images
  final RxList<File> newImages = <File>[].obs;
  final RxList<String> existingImageUrls = <String>[].obs;
  
  // Loading and error states
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;
  final RxBool isUploadingImages = false.obs;
  final RxString errorMessage = ''.obs;
  
  // Validation states
  final RxBool isTitleValid = false.obs;
  final RxBool isDescriptionValid = false.obs;
  final RxBool isFormChanged = false.obs;
  
  // Reactive text for preview
  final RxString titleText = ''.obs;
  final RxString descriptionText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeFromRoute();
  }

  /// Initialize controller from route parameters
  void _initializeFromRoute() {
    try {
      // Get service ID from route parameters
      final parameters = Get.parameters;
      final serviceIdStr = parameters['serviceId'];
      
      if (serviceIdStr == null) {
        errorMessage.value = 'Service ID not provided';
        debugPrint('❌ Service ID not found in route parameters');
        return;
      }
      
      serviceId = int.parse(serviceIdStr);
      servicesController = Get.find<DriverServicesController>();
      
      // Load the service for editing
      _loadServiceForEditing();
    } catch (e) {
      debugPrint('❌ Error initializing edit controller: $e');
      errorMessage.value = 'Failed to load service';
    }
  }

  /// Load service data for editing
  void _loadServiceForEditing() {
    try {
      isLoading.value = true;
      
      // Find service in controller's list
      final service = servicesController.myServices.firstWhereOrNull(
        (s) => s.id == serviceId,
      );
      
      if (service == null) {
        debugPrint('❌ Service with ID $serviceId not found');
        errorMessage.value = 'Service not found';
        return;
      }
      
      debugPrint('✅ Loaded service: ${service.title}');
      currentService.value = service;
      
      // Populate form fields
      titleController.text = service.title ?? '';
      descriptionController.text = service.description ?? '';
      basePrice.value = service.basePrice;
      pricePerKm.value = service.pricePerKm;
      pricePerHour.value = service.pricePerHour;
      minPrice.value = service.minPrice;
      isAvailable.value = service.isAvailable;
      
      // Load existing images
      if (service.imageUrl != null && service.imageUrl!.isNotEmpty) {
        existingImageUrls.value = [service.imageUrl!];
      }
      
      // Update preview texts
      titleText.value = service.title ?? '';
      descriptionText.value = service.description ?? '';
      
      // Setup listeners for form changes
      _setupFormListeners();
      
      // Reset form changed flag
      isFormChanged.value = false;
      
    } catch (e) {
      debugPrint('❌ Error loading service: $e');
      errorMessage.value = 'Failed to load service details';
    } finally {
      isLoading.value = false;
    }
  }

  /// Setup listeners for form field changes
  void _setupFormListeners() {
    titleController.addListener(() {
      isTitleValid.value = titleController.text.trim().length >= 3;
      titleText.value = titleController.text.trim();
      _checkFormChanged();
    });
    
    descriptionController.addListener(() {
      isDescriptionValid.value = descriptionController.text.trim().length >= 10;
      descriptionText.value = descriptionController.text.trim();
      _checkFormChanged();
    });
  }

  /// Check if form has been changed from original values
  void _checkFormChanged() {
    final service = currentService.value;
    if (service == null) return;
    
    final titleChanged = titleController.text.trim() != (service.title ?? '');
    final descChanged = descriptionController.text.trim() != (service.description ?? '');
    final basePriceChanged = basePrice.value != service.basePrice;
    final pricePerKmChanged = pricePerKm.value != service.pricePerKm;
    final pricePerHourChanged = pricePerHour.value != service.pricePerHour;
    final minPriceChanged = minPrice.value != service.minPrice;
    final availableChanged = isAvailable.value != service.isAvailable;
    
    isFormChanged.value = titleChanged ||
        descChanged ||
        basePriceChanged ||
        pricePerKmChanged ||
        pricePerHourChanged ||
        minPriceChanged ||
        availableChanged;
  }

  /// Update base price
  void setBasePrice(double? value) {
    basePrice.value = value;
    _checkFormChanged();
  }

  /// Update price per km
  void setPricePerKm(double? value) {
    pricePerKm.value = value;
    _checkFormChanged();
  }

  /// Update price per hour
  void setPricePerHour(double? value) {
    pricePerHour.value = value;
    _checkFormChanged();
  }

  /// Update minimum price
  void setMinPrice(double? value) {
    minPrice.value = value;
    _checkFormChanged();
  }

  /// Toggle availability
  void toggleAvailability() {
    isAvailable.value = !isAvailable.value;
    _checkFormChanged();
  }

  /// Validate form before submission
  bool validateForm() {
    bool isValid = true;
    
    if (titleController.text.trim().length < 3) {
      isTitleValid.value = false;
      isValid = false;
    } else {
      isTitleValid.value = true;
    }
    
    if (descriptionController.text.trim().length < 10) {
      isDescriptionValid.value = false;
      isValid = false;
    } else {
      isDescriptionValid.value = true;
    }
    
    return isValid;
  }

  /// Submit form to update service
  Future<bool> submitUpdate() async {
    debugPrint('\n🎯 === UPDATE SERVICE CLICKED ===');
    
    if (!validateForm()) {
      debugPrint('❌ Form validation failed');
      Get.snackbar(
        'common.error'.tr,
        'driver.services.fill_required_fields'.tr,
      );
      return false;
    }
    
    if (!isFormChanged.value && newImages.isEmpty) {
      debugPrint('⚠️ No changes made');
      Get.snackbar(
        'common.info'.tr,
        'driver.services.no_changes'.tr,
      );
      return false;
    }
    
    try {
      isSaving.value = true;
      errorMessage.value = '';
      
      debugPrint('   Service ID: $serviceId');
      debugPrint('   Title: ${titleController.text.trim()}');
      debugPrint('   Description: ${descriptionController.text.trim()}');
      debugPrint('   Base Price: ${basePrice.value}');
      debugPrint('   Price/KM: ${pricePerKm.value}');
      debugPrint('   Price/Hour: ${pricePerHour.value}');
      debugPrint('   Min Price: ${minPrice.value}');
      debugPrint('   Is Available: ${isAvailable.value}');
      debugPrint('   New Images: ${newImages.length}');
      
      // Call the controller's updateService method
      final success = await servicesController.updateService(
        serviceId: serviceId,
        title: titleController.text.trim().isEmpty
            ? null
            : titleController.text.trim(),
        description: descriptionController.text.trim().isEmpty
            ? null
            : descriptionController.text.trim(),
        basePrice: basePrice.value,
        pricePerKm: pricePerKm.value,
        pricePerHour: pricePerHour.value,
        minPrice: minPrice.value,
        isAvailable: isAvailable.value,
      );
      
      if (!success) {
        debugPrint('❌ Service update failed');
        errorMessage.value = servicesController.errorMessage.value;
        return false;
      }

      debugPrint('✅ Service updated successfully');
      
      // Upload new images if any
      if (newImages.isNotEmpty) {
        debugPrint('📸 Uploading ${newImages.length} new images...');
        final uploadedCount = await uploadServiceImages();
        debugPrint('📊 Uploaded $uploadedCount images');
        
        // Reload service images to update the UI
        if (uploadedCount > 0) {
          debugPrint('🔄 Reloading service images...');
          final updatedImages = await servicesController.getServiceImages(serviceId);
          servicesController.serviceImageMap[serviceId] = updatedImages;
          debugPrint('✅ Service images reloaded: ${updatedImages.length} images');
        }
      }
      
      // Show success message
      Get.snackbar(
        'common.success'.tr,
        'driver.services.service_updated'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.brightness == Brightness.dark
            ? AppColors.dark.success
            : AppColors.light.success,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      
      // Navigate back to services list
      Get.back();
      return true;
    } catch (e) {
      debugPrint('❌ Error updating service: $e');
      errorMessage.value = 'errors.update_service'.tr;
      Get.snackbar(
        'common.error'.tr,
        'errors.update_service'.tr,
      );
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  /// Cancel editing and go back
  Future<void> cancelEdit() async {
    if (!isFormChanged.value) {
      Get.back();
      return;
    }
    
    // Show confirmation dialog
    Get.dialog(
      AlertDialog(
        title: Text('common.discard_changes'.tr),
        content: Text('driver.services.discard_confirmation'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('common.cancel'.tr),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Go back to services
            },
            child: Text('common.discard'.tr),
          ),
        ],
      ),
    );
  }

  /// Pick image from gallery
  Future<void> pickImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        newImages.add(imageFile);
        _checkFormChanged();
        debugPrint('✅ Image selected: ${pickedFile.name}');
      }
    } catch (e) {
      debugPrint('❌ Error picking image: $e');
      Get.snackbar(
        'common.error'.tr,
        'errors.pick_image_failed'.tr,
      );
    }
  }

  /// Remove new image from list
  void removeNewImage(int index) {
    if (index < newImages.length) {
      newImages.removeAt(index);
      _checkFormChanged();
    }
  }

  /// Remove existing image URL
  void removeExistingImage(String imageUrl) {
    existingImageUrls.remove(imageUrl);
    _checkFormChanged();
  }

  /// Upload new images for the service
  Future<int> uploadServiceImages() async {
    if (newImages.isEmpty) {
      return 0;
    }

    try {
      isUploadingImages.value = true;
      int uploadedCount = 0;

      for (final imageFile in newImages) {
        try {
          debugPrint('🔄 Uploading image: ${imageFile.path}');

          final imageResult = await servicesController.uploadServiceImage(
            driverServiceId: serviceId,
            imageFile: imageFile,
          );

          if (imageResult != null) {
            debugPrint('✅ Image uploaded successfully: ${imageResult.imageUrl}');
            uploadedCount++;
          } else {
            debugPrint('❌ Failed to upload image');
          }
        } catch (e) {
          debugPrint('❌ Error uploading image: $e');
        }
      }

      return uploadedCount;
    } finally {
      isUploadingImages.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
