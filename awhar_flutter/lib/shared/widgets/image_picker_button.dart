import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/services/image_picker_service.dart';
import '../../core/services/media_upload_service.dart';

/// Button to pick and upload images in chat
/// Shows bottom sheet with camera/gallery options
/// Handles compression, upload, and progress tracking
class ImagePickerButton extends StatelessWidget {
  final Function(String imageUrl, String thumbnailUrl, int fileSizeBytes)
      onImageUploaded;
  final bool enabled;
  final Color? iconColor;

  const ImagePickerButton({
    super.key,
    required this.onImageUploaded,
    this.enabled = true,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final imagePickerService = Get.find<ImagePickerService>();
    final mediaUploadService = Get.find<MediaUploadService>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      final isProcessing = imagePickerService.isProcessing.value;

      return IconButton(
        icon: Icon(
          Icons.image,
          color: enabled
              ? (iconColor ?? Get.theme.colorScheme.primary)
              : (isDark ? Colors.grey[700] : Colors.grey[400]),
        ),
        onPressed: enabled && !isProcessing ? _handleImagePick : null,
      );
    });
  }

  /// Handle image pick and upload
  Future<void> _handleImagePick() async {
    final imagePickerService = Get.find<ImagePickerService>();
    final mediaUploadService = Get.find<MediaUploadService>();

    // Show bottom sheet to choose camera or gallery
    final imageFile = await imagePickerService.showImageSourcePicker(
      enableCropping: true,
      maxWidth: 1080,
      maxHeight: 1920,
      imageQuality: 85,
    );

    if (imageFile == null) {
      // User cancelled
      return;
    }

    try {
      // Show loading dialog
      Get.dialog(
        PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Get.theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(strokeWidth: 3.w),
                  SizedBox(height: 16.h),
                  Text(
                    'uploading_image'.tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );

      // Compress image
      final compressedFile = await mediaUploadService.compressImage(imageFile);
      if (compressedFile == null) {
        Get.back(); // Close loading dialog
        Get.snackbar(
          'error'.tr,
          'image_compression_failed'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error.withValues(alpha: 0.8),
          colorText: Get.theme.colorScheme.onError,
        );
        return;
      }

      // Upload image
      final requestId =
          Get.parameters['requestId'] ?? 'unknown'; // Get from route
      final uploadResult = await mediaUploadService.uploadImage(
        imageFile: compressedFile,
        requestId: requestId,
      );

      Get.back(); // Close loading dialog

      if (uploadResult != null) {
        // Success
        onImageUploaded(
          uploadResult['imageUrl']!,
          uploadResult['thumbnailUrl'] ?? '',
          int.parse(uploadResult['fileSize']!),
        );

        Get.snackbar(
          'success'.tr,
          'image_uploaded_successfully'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      } else {
        // Upload failed
        Get.snackbar(
          'error'.tr,
          'image_upload_failed'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error.withValues(alpha: 0.8),
          colorText: Get.theme.colorScheme.onError,
        );
      }
    } catch (e) {
      Get.back(); // Close loading dialog if still open
      Get.snackbar(
        'error'.tr,
        '${'image_upload_failed'.tr}: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error.withValues(alpha: 0.8),
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }
}

/// Advanced image picker with multiple image support
/// Use for bulk upload scenarios (multiple images at once)
class MultiImagePickerButton extends StatelessWidget {
  final Function(List<Map<String, dynamic>> images) onImagesUploaded;
  final int maxImages;
  final bool enabled;
  final Color? iconColor;
  final String? buttonText;

  const MultiImagePickerButton({
    super.key,
    required this.onImagesUploaded,
    this.maxImages = 10,
    this.enabled = true,
    this.iconColor,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final imagePickerService = Get.find<ImagePickerService>();
    final mediaUploadService = Get.find<MediaUploadService>();

    return Obx(() {
        final isProcessing = imagePickerService.isProcessing.value;

      if (buttonText != null) {
        // Button with text
        return ElevatedButton.icon(
          onPressed: enabled && !isProcessing ? _handleMultipleImagePick : null,
          icon: Icon(Icons.photo_library),
          label: Text(buttonText!),
        );
      }

      // Icon button only
      return IconButton(
        icon: Icon(
          Icons.photo_library,
          color: enabled
              ? (iconColor ?? Get.theme.colorScheme.primary)
              : Colors.grey,
        ),
        onPressed: enabled && !isProcessing ? _handleMultipleImagePick : null,
      );
    });
  }

  /// Handle multiple image pick and upload
  Future<void> _handleMultipleImagePick() async {
    final imagePickerService = Get.find<ImagePickerService>();
    final mediaUploadService = Get.find<MediaUploadService>();

    // Pick multiple images
    final imageFiles = await imagePickerService.pickMultipleFromGallery(
      maxImages: maxImages,
      maxWidth: 1080,
      maxHeight: 1920,
      imageQuality: 85,
    );

    if (imageFiles.isEmpty) {
      // User cancelled
      return;
    }

    try {
      // Show loading dialog
      Get.dialog(
        PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Get.theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(strokeWidth: 3.w),
                  SizedBox(height: 16.h),
                  Text(
                    'uploading_images'.tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '0 / ${imageFiles.length}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Get.theme.colorScheme.onSurface
                          .withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );

      final uploadedImages = <Map<String, dynamic>>[];
      final requestId = Get.parameters['requestId'] ?? 'unknown';

      for (int i = 0; i < imageFiles.length; i++) {
        final imageFile = imageFiles[i];

        // Compress
        final compressedFile =
            await mediaUploadService.compressImage(imageFile);
        if (compressedFile == null) continue;

        // Upload
        final uploadResult = await mediaUploadService.uploadImage(
          imageFile: compressedFile,
          requestId: requestId,
        );

        if (uploadResult != null) {
          uploadedImages.add({
            'imageUrl': uploadResult['imageUrl']!,
            'thumbnailUrl': uploadResult['thumbnailUrl'] ?? '',
            'fileSizeBytes': int.parse(uploadResult['fileSize']!),
          });
        }

        // Update progress dialog
        // TODO: Update dialog with progress text
      }

      Get.back(); // Close loading dialog

      if (uploadedImages.isNotEmpty) {
        onImagesUploaded(uploadedImages);
        Get.snackbar(
          'success'.tr,
          '${uploadedImages.length} ${'images_uploaded_successfully'.tr}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'error'.tr,
          'no_images_uploaded'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error.withValues(alpha: 0.8),
          colorText: Get.theme.colorScheme.onError,
        );
      }
    } catch (e) {
      Get.back(); // Close loading dialog if still open
      Get.snackbar(
        'error'.tr,
        '${'images_upload_failed'.tr}: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error.withValues(alpha: 0.8),
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }
}
