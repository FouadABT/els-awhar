import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';

/// Service for handling image picking from camera or gallery
/// Supports cropping, compression, and permission handling
class ImagePickerService extends GetxController {
  final ImagePicker _picker = ImagePicker();

  // Reactive state
  final RxBool isProcessing = false.obs;
  final RxString errorMessage = ''.obs;
  final RxDouble processingProgress = 0.0.obs;

  /// Pick image from camera
  /// Returns File if successful, null if cancelled or error
  Future<File?> pickFromCamera({
    bool enableCropping = true,
    int maxWidth = 1080,
    int maxHeight = 1920,
    int imageQuality = 85,
  }) async {
    try {
      isProcessing.value = true;
      errorMessage.value = '';
      processingProgress.value = 0.0;

      // Check camera permission
      final cameraStatus = await Permission.camera.request();
      if (!cameraStatus.isGranted) {
        errorMessage.value = 'camera_permission_required'.tr;
        return null;
      }

      processingProgress.value = 0.2;

      // Pick image from camera
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: maxWidth.toDouble(),
        maxHeight: maxHeight.toDouble(),
        imageQuality: imageQuality,
      );

      if (image == null) {
        // User cancelled
        return null;
      }

      processingProgress.value = 0.5;

      // Crop image if enabled
      if (enableCropping) {
        final croppedFile = await _cropImage(File(image.path));
        processingProgress.value = 1.0;
        return croppedFile;
      }

      processingProgress.value = 1.0;
      return File(image.path);
    } catch (e) {
      errorMessage.value = 'camera_error'.tr + ': $e';
      Get.snackbar(
        'error'.tr,
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error.withValues(alpha: 0.8),
        colorText: Get.theme.colorScheme.onError,
      );
      return null;
    } finally {
      isProcessing.value = false;
      processingProgress.value = 0.0;
    }
  }

  /// Pick image from gallery
  /// Returns File if successful, null if cancelled or error
  Future<File?> pickFromGallery({
    bool enableCropping = true,
    int maxWidth = 1080,
    int maxHeight = 1920,
    int imageQuality = 85,
  }) async {
    try {
      isProcessing.value = true;
      errorMessage.value = '';
      processingProgress.value = 0.0;

      // Check storage permission (Android)
      if (Platform.isAndroid) {
        final storageStatus = await Permission.photos.request();
        if (!storageStatus.isGranted) {
          errorMessage.value = 'storage_permission_required'.tr;
          return null;
        }
      }

      // iOS uses photo library permission
      if (Platform.isIOS) {
        final photoStatus = await Permission.photos.request();
        if (!photoStatus.isGranted) {
          errorMessage.value = 'photo_library_permission_required'.tr;
          return null;
        }
      }

      processingProgress.value = 0.2;

      // Pick image from gallery
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth.toDouble(),
        maxHeight: maxHeight.toDouble(),
        imageQuality: imageQuality,
      );

      if (image == null) {
        // User cancelled
        return null;
      }

      processingProgress.value = 0.5;

      // Crop image if enabled
      if (enableCropping) {
        final croppedFile = await _cropImage(File(image.path));
        processingProgress.value = 1.0;
        return croppedFile;
      }

      processingProgress.value = 1.0;
      return File(image.path);
    } catch (e) {
      errorMessage.value = 'gallery_error'.tr + ': $e';
      Get.snackbar(
        'error'.tr,
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error.withValues(alpha: 0.8),
        colorText: Get.theme.colorScheme.onError,
      );
      return null;
    } finally {
      isProcessing.value = false;
      processingProgress.value = 0.0;
    }
  }

  /// Pick multiple images from gallery
  /// Returns list of Files, empty if cancelled or error
  Future<List<File>> pickMultipleFromGallery({
    int maxImages = 10,
    int maxWidth = 1080,
    int maxHeight = 1920,
    int imageQuality = 85,
  }) async {
    try {
      isProcessing.value = true;
      errorMessage.value = '';
      processingProgress.value = 0.0;

      // Check storage permission
      if (Platform.isAndroid) {
        final storageStatus = await Permission.photos.request();
        if (!storageStatus.isGranted) {
          errorMessage.value = 'storage_permission_required'.tr;
          return [];
        }
      }

      if (Platform.isIOS) {
        final photoStatus = await Permission.photos.request();
        if (!photoStatus.isGranted) {
          errorMessage.value = 'photo_library_permission_required'.tr;
          return [];
        }
      }

      processingProgress.value = 0.2;

      // Pick multiple images
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: maxWidth.toDouble(),
        maxHeight: maxHeight.toDouble(),
        imageQuality: imageQuality,
      );

      if (images.isEmpty) {
        // User cancelled
        return [];
      }

      // Limit number of images
      final limitedImages = images.take(maxImages).toList();

      processingProgress.value = 0.8;

      // Convert to File list
      final files = limitedImages.map((xFile) => File(xFile.path)).toList();

      processingProgress.value = 1.0;
      return files;
    } catch (e) {
      errorMessage.value = 'gallery_error'.tr + ': $e';
      Get.snackbar(
        'error'.tr,
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error.withValues(alpha: 0.8),
        colorText: Get.theme.colorScheme.onError,
      );
      return [];
    } finally {
      isProcessing.value = false;
      processingProgress.value = 0.0;
    }
  }

  /// Show bottom sheet to choose camera or gallery
  /// Returns File if successful, null if cancelled
  Future<File?> showImageSourcePicker({
    bool enableCropping = true,
    int maxWidth = 1080,
    int maxHeight = 1920,
    int imageQuality = 85,
  }) async {
    return Get.bottomSheet<File?>(
      Container(
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 12, bottom: 20),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Get.theme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'choose_image_source'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Get.theme.colorScheme.onSurface,
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Camera option
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: Get.theme.colorScheme.primary,
                ),
                title: Text(
                  'take_photo'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    color: Get.theme.colorScheme.onSurface,
                  ),
                ),
                onTap: () async {
                  // Pick file first, then close with result
                  final file = await pickFromCamera(
                    enableCropping: enableCropping,
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                    imageQuality: imageQuality,
                  );
                  Get.back(result: file); // Close bottom sheet with file
                },
              ),

              // Gallery option
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: Get.theme.colorScheme.primary,
                ),
                title: Text(
                  'choose_from_gallery'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    color: Get.theme.colorScheme.onSurface,
                  ),
                ),
                onTap: () async {
                  // Pick file first, then close with result
                  final file = await pickFromGallery(
                    enableCropping: enableCropping,
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                    imageQuality: imageQuality,
                  );
                  Get.back(result: file); // Close bottom sheet with file
                },
              ),

              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
    );
  }

  /// Crop image with custom aspect ratio
  /// Returns cropped File or null if cancelled
  Future<File?> _cropImage(File imageFile) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'crop_image'.tr,
            toolbarColor: Get.theme.colorScheme.primary,
            toolbarWidgetColor: Get.theme.colorScheme.onPrimary,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            hideBottomControls: false,
            showCropGrid: true,
          ),
          IOSUiSettings(
            title: 'crop_image'.tr,
            cancelButtonTitle: 'cancel'.tr,
            doneButtonTitle: 'done'.tr,
            aspectRatioLockEnabled: false,
            resetAspectRatioEnabled: true,
            aspectRatioPickerButtonHidden: false,
          ),
        ],
      );

      if (croppedFile == null) {
        return null;
      }

      return File(croppedFile.path);
    } catch (e) {
      errorMessage.value = '${'crop_error'.tr}: $e';
      return imageFile; // Return original if crop fails
    }
  }

  /// Request camera permission explicitly
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      errorMessage.value = 'camera_permission_required'.tr;
      Get.snackbar(
        'error'.tr,
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error.withValues(alpha: 0.8),
        colorText: Get.theme.colorScheme.onError,
      );
      return false;
    }
    return true;
  }

  /// Request storage/photo library permission explicitly
  Future<bool> requestStoragePermission() async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      status = await Permission.photos.request();
    } else {
      status = await Permission.photos.request();
    }

    if (!status.isGranted) {
      errorMessage.value = Platform.isAndroid
          ? 'storage_permission_required'.tr
          : 'photo_library_permission_required'.tr;
      Get.snackbar(
        'error'.tr,
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error.withValues(alpha: 0.8),
        colorText: Get.theme.colorScheme.onError,
      );
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    // Cleanup if needed
    super.onClose();
  }
}
