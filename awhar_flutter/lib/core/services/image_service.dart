import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:awhar_client/awhar_client.dart';
import '../theme/app_colors.dart';

/// Service for handling image operations
/// - Pick from gallery or camera
/// - Crop images
/// - Compress images (max 5MB)
/// - Upload to backend
class ImageService {
  final ImagePicker _picker = ImagePicker();
  final Client _client;

  // Maximum file size: 5MB
  static const int maxFileSizeBytes = 5 * 1024 * 1024;

  ImageService(this._client);

  /// Pick image from gallery
  Future<File?> pickFromGallery({bool crop = true}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (image == null) return null;

      final file = File(image.path);

      // Crop if requested
      if (crop) {
        return await _cropImage(file);
      }

      return file;
    } catch (e) {
      debugPrint('[ImageService] Pick from gallery error: $e');
      return null;
    }
  }

  /// Pick image from camera
  Future<File?> pickFromCamera({bool crop = true}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (image == null) return null;

      final file = File(image.path);

      // Crop if requested
      if (crop) {
        return await _cropImage(file);
      }

      return file;
    } catch (e) {
      debugPrint('[ImageService] Pick from camera error: $e');
      return null;
    }
  }

  /// Show bottom sheet to choose image source
  Future<File?> pickImage(BuildContext context, {bool crop = true}) async {
    try {
      debugPrint('[ImageService] Showing image source bottom sheet...');
      
      final result = await showModalBottomSheet<ImageSource>(
        context: context,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.dark.surface
            : AppColors.light.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => _ImageSourceBottomSheet(),
      );

      debugPrint('[ImageService] Selected source: $result');

      if (result == null) {
        debugPrint('[ImageService] No source selected');
        return null;
      }

      if (result == ImageSource.gallery) {
        debugPrint('[ImageService] Picking from gallery...');
        return await pickFromGallery(crop: crop);
      } else {
        debugPrint('[ImageService] Picking from camera...');
        return await pickFromCamera(crop: crop);
      }
    } catch (e, stackTrace) {
      debugPrint('[ImageService] pickImage error: $e');
      debugPrint('[ImageService] Stack trace: $stackTrace');
      return null;
    }
  }

  /// Crop image with circular aspect ratio for profile photos
  Future<File?> _cropImage(File imageFile) async {
    try {
      debugPrint('[ImageService] Starting crop for: ${imageFile.path}');
      
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 90,
        maxWidth: 1024,
        maxHeight: 1024,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Profile Photo',
            toolbarColor: AppColors.light.primary,
            toolbarWidgetColor: Colors.white,
            statusBarColor: AppColors.light.primary,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls: false,
            showCropGrid: true,
            cropFrameStrokeWidth: 3,
            activeControlsWidgetColor: AppColors.light.primary,
          ),
          IOSUiSettings(
            title: 'Crop Profile Photo',
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: false,
          ),
        ],
      );

      if (croppedFile == null) {
        debugPrint('[ImageService] Crop cancelled');
        return null;
      }

      debugPrint('[ImageService] Cropped to: ${croppedFile.path}');
      return File(croppedFile.path);
    } catch (e, stackTrace) {
      debugPrint('[ImageService] Crop error: $e');
      debugPrint('[ImageService] Crop stack trace: $stackTrace');
      return imageFile; // Return original if crop fails
    }
  }

  /// Compress image to ensure it's under 5MB
  Future<File?> compressImage(File file) async {
    try {
      // Check current file size
      final fileSize = await file.length();
      debugPrint('[ImageService] Original file size: ${(fileSize / 1024 / 1024).toStringAsFixed(2)} MB');

      // If already under limit, return as is
      if (fileSize <= maxFileSizeBytes) {
        return file;
      }

      // Calculate compression quality needed
      int quality = 85;
      File compressedFile = file;

      while (quality > 10) {
        final tempDir = await getTemporaryDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final targetPath = '${tempDir.path}/compressed_$timestamp.jpg';

        final result = await FlutterImageCompress.compressAndGetFile(
          compressedFile.absolute.path,
          targetPath,
          quality: quality,
          format: CompressFormat.jpeg,
        );

        if (result == null) break;

        compressedFile = File(result.path);
        final compressedSize = await compressedFile.length();
        
        debugPrint('[ImageService] Compressed to: ${(compressedSize / 1024 / 1024).toStringAsFixed(2)} MB with quality: $quality');

        if (compressedSize <= maxFileSizeBytes) {
          return compressedFile;
        }

        // Reduce quality for next iteration
        quality -= 10;
      }

      // If still too large after max compression, return null
      final finalSize = await compressedFile.length();
      if (finalSize > maxFileSizeBytes) {
        debugPrint('[ImageService] Could not compress image below 5MB');
        return null;
      }

      return compressedFile;
    } catch (e) {
      debugPrint('[ImageService] Compression error: $e');
      return null;
    }
  }

  /// Upload profile photo to backend
  Future<String?> uploadProfilePhoto(File file, int userId) async {
    try {
      debugPrint('[ImageService] Starting upload for user: $userId');
      debugPrint('[ImageService] File path: ${file.path}');
      
      // Compress image first
      debugPrint('[ImageService] Compressing image...');
      final compressedFile = await compressImage(file);
      if (compressedFile == null) {
        debugPrint('[ImageService] Image compression failed or file too large');
        return null;
      }

      debugPrint('[ImageService] Compressed file: ${compressedFile.path}');

      // Read file as bytes
      debugPrint('[ImageService] Reading file bytes...');
      final bytes = await compressedFile.readAsBytes();
      debugPrint('[ImageService] File size: ${bytes.length} bytes');

      // Convert to ByteData for Serverpod
      final byteData = ByteData.sublistView(bytes);

      // Get filename
      final fileName = compressedFile.path.split('/').last;
      debugPrint('[ImageService] Filename: $fileName');

      // Upload to backend
      debugPrint('[ImageService] Calling backend uploadProfilePhoto...');
      final response = await _client.user.uploadProfilePhoto(
        userId: userId,
        photoData: byteData,
        fileName: fileName,
      );

      debugPrint('[ImageService] Backend response: success=${response.success}, message=${response.message}');

      if (response.success && response.user?.profilePhotoUrl != null) {
        debugPrint('[ImageService] Photo uploaded successfully: ${response.user!.profilePhotoUrl}');
        return response.user!.profilePhotoUrl;
      }

      debugPrint('[ImageService] Upload failed: ${response.message}');
      return null;
    } catch (e, stackTrace) {
      debugPrint('[ImageService] Upload error: $e');
      debugPrint('[ImageService] Stack trace: $stackTrace');
      return null;
    }
  }

  /// Get file size in MB
  Future<double> getFileSizeMB(File file) async {
    final bytes = await file.length();
    return bytes / 1024 / 1024;
  }

  /// Validate file size
  Future<bool> isFileSizeValid(File file) async {
    final bytes = await file.length();
    return bytes <= maxFileSizeBytes;
  }
}

/// Bottom sheet for selecting image source
class _ImageSourceBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library, color: colors.primary),
              title: Text('Choose from Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: colors.primary),
              title: Text('Take a Photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
