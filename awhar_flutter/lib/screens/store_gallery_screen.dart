import 'dart:convert';
import 'dart:io';

import 'package:awhar_client/awhar_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../core/controllers/auth_controller.dart';
import '../core/controllers/store_controller.dart';
import '../core/services/firebase_storage_service.dart';
import '../core/services/image_picker_service.dart';
import '../core/services/media_upload_service.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class StoreGalleryScreen extends StatefulWidget {
  const StoreGalleryScreen({super.key});

  @override
  State<StoreGalleryScreen> createState() => _StoreGalleryScreenState();
}

class _StoreGalleryScreenState extends State<StoreGalleryScreen> {
  final storeController = Get.find<StoreController>();
  final RxList<String> galleryImages = <String>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    _loadGalleryImages();
  }

  void _loadGalleryImages() {
    final store = storeController.myStore.value;
    if (store?.galleryImages != null && store!.galleryImages!.isNotEmpty) {
      try {
        final images = List<String>.from(json.decode(store.galleryImages!));
        galleryImages.value = images;
      } catch (e) {
        debugPrint('[Gallery] Error parsing gallery: $e');
      }
    }
  }

  Future<void> _addImage() async {
    if (galleryImages.length >= 10) {
      final colors = Theme.of(context).brightness == Brightness.dark ? AppColors.dark : AppColors.light;
      Get.snackbar(
        'Limit Reached',
        'Maximum 10 images allowed',
        backgroundColor: colors.warning,
        colorText: Colors.white,
      );
      return;
    }

    final imagePickerService = Get.find<ImagePickerService>();
    final mediaUploadService = Get.find<MediaUploadService>();
    final storageService = Get.find<FirebaseStorageService>();
    final colors = Theme.of(context).brightness == Brightness.dark ? AppColors.dark : AppColors.light;

    final imageFile = await imagePickerService.showImageSourcePicker(
      enableCropping: false,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (imageFile == null) return;

    isLoading.value = true;

    try {
      final compressedFile = await mediaUploadService.compressImage(imageFile);
      if (compressedFile == null) {
        isLoading.value = false;
        Get.snackbar('Error', 'Failed to compress image', backgroundColor: colors.error, colorText: Colors.white);
        return;
      }

      final storeId = storeController.storeId;
      if (storeId == null) {
        isLoading.value = false;
        return;
      }

      final uploadResult = await storageService.uploadFile(
        file: compressedFile,
        path: 'stores/$storeId/gallery/${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      if (uploadResult == null) {
        isLoading.value = false;
        Get.snackbar('Error', 'Failed to upload image', backgroundColor: colors.error, colorText: Colors.white);
        return;
      }

      final authController = Get.find<AuthController>();
      final userId = authController.userId;
      if (userId == null) {
        isLoading.value = false;
        return;
      }

      final updatedStore = await Get.find<Client>().store.addGalleryImage(
        userId: userId,
        storeId: storeId,
        imageUrl: uploadResult,
      );

      isLoading.value = false;

      if (updatedStore != null) {
        galleryImages.add(uploadResult);
        storeController.myStore.value = updatedStore;
        Get.snackbar(
          'Success',
          'Image added to gallery',
          backgroundColor: colors.success,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar('Error', 'Failed to save image', backgroundColor: colors.error, colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Upload failed: $e', backgroundColor: colors.error, colorText: Colors.white);
    }
  }

  Future<void> _removeImage(int index) async {
    final colors = Theme.of(context).brightness == Brightness.dark ? AppColors.dark : AppColors.light;
    
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: colors.surface,
        title: Text('Remove Image', style: AppTypography.titleMedium(context)),
        content: Text('Are you sure you want to remove this image?', style: AppTypography.bodyMedium(context)),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('Cancel', style: TextStyle(color: colors.textSecondary)),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text('Remove', style: TextStyle(color: colors.error)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final imageUrl = galleryImages[index];
    final authController = Get.find<AuthController>();
    final userId = authController.userId;
    final storeId = storeController.storeId;

    if (userId == null || storeId == null) return;

    isLoading.value = true;

    try {
      final updatedStore = await Get.find<Client>().store.removeGalleryImage(
        userId: userId,
        storeId: storeId,
        imageUrl: imageUrl,
      );

      isLoading.value = false;

      if (updatedStore != null) {
        galleryImages.removeAt(index);
        storeController.myStore.value = updatedStore;
        Get.snackbar(
          'Removed',
          'Image removed from gallery',
          duration: Duration(seconds: 2),
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to remove image: $e', backgroundColor: colors.error, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Gallery',
          style: AppTypography.titleLarge(context).copyWith(color: colors.textPrimary),
        ),
        actions: [
          Obx(() => Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Center(
              child: Text(
                '${galleryImages.length}/10',
                style: AppTypography.bodyMedium(context).copyWith(
                  color: galleryImages.length >= 10 ? colors.error : colors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )),
        ],
      ),
      body: Obx(() {
        if (isLoading.value) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: colors.primary),
                SizedBox(height: 16.h),
                Text(
                  'Uploading...',
                  style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          );
        }

        if (galleryImages.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.gallery, size: 64.sp, color: colors.textMuted),
                SizedBox(height: 16.h),
                Text(
                  'No images yet',
                  style: AppTypography.titleMedium(context).copyWith(color: colors.textPrimary),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Add images to showcase your store',
                  style: AppTypography.bodySmall(context).copyWith(color: colors.textMuted),
                ),
                SizedBox(height: 24.h),
                ElevatedButton.icon(
                  onPressed: _addImage,
                  icon: Icon(Iconsax.add, size: 20.sp),
                  label: Text('Add First Image'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: EdgeInsets.all(16.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1,
          ),
          itemCount: galleryImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _showImagePreview(galleryImages[index]),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CachedNetworkImage(
                      imageUrl: galleryImages[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: (_, __) => Container(
                        color: colors.primary.withValues(alpha: 0.1),
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2, color: colors.primary),
                        ),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        color: colors.primary.withValues(alpha: 0.1),
                        child: Icon(Iconsax.image, color: colors.textSecondary, size: 32.sp),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: GestureDetector(
                      onTap: () => _removeImage(index),
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: colors.error,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(Icons.close, size: 16.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: Obx(() {
        if (galleryImages.isEmpty || galleryImages.length >= 10) return SizedBox.shrink();
        
        return FloatingActionButton.extended(
          onPressed: _addImage,
          backgroundColor: colors.primary,
          icon: Icon(Iconsax.add, color: Colors.white),
          label: Text('Add Image', style: TextStyle(color: Colors.white)),
        );
      }),
    );
  }

  void _showImagePreview(String imageUrl) {
    final colors = Theme.of(context).brightness == Brightness.dark ? AppColors.dark : AppColors.light;
    
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                placeholder: (_, __) => CircularProgressIndicator(color: colors.primary),
                errorWidget: (_, __, ___) => Icon(Iconsax.image, color: Colors.white, size: 48.sp),
              ),
            ),
            Positioned(
              top: 40.h,
              right: 20.w,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 24.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
