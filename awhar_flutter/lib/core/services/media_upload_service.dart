import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'firebase_storage_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:awhar_client/awhar_client.dart';
import '../controllers/auth_controller.dart';

/// Service for handling media uploads with compression and optimization
/// Manages image compression, audio file uploads, and file validation
class MediaUploadService extends GetxService {
  late final FirebaseStorageService _storageService;
  late final Client _client;

  // Image compression settings
  static const int maxImageWidth = 1080;
  static const int maxImageHeight = 1920;
  static const int imageQuality = 70; // 0-100
  static const int thumbnailSize = 300; // For thumbnail preview

  // Audio settings
  static const int audioQuality = 128; // kbps

  @override
  void onInit() {
    super.onInit();
    _storageService = Get.find<FirebaseStorageService>();
    _client = Get.find<Client>();
    debugPrint('[MediaUploadService] ✅ Initialized');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // IMAGE HANDLING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Compress image file before upload
  /// Returns compressed file, null if compression fails
  Future<File?> compressImage(File imageFile) async {
    try {
      debugPrint('[MediaUploadService] 🖼️ Compressing image: ${imageFile.path}');

      final originalSize = await imageFile.length();
      debugPrint('[MediaUploadService] Original size: ${FirebaseStorageService.formatFileSize(originalSize)}');

      final tempDir = await getTemporaryDirectory();
      final targetPath =
          '${tempDir.absolute.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';

      final result = await FlutterImageCompress.compressAndGetFile(
        imageFile.absolute.path,
        targetPath,
        quality: imageQuality,
        minWidth: maxImageWidth,
        minHeight: maxImageHeight,
        format: CompressFormat.jpeg,
      );

      if (result == null) {
        debugPrint('[MediaUploadService] ❌ Compression failed');
        return null;
      }

      final compressedFile = File(result.path);
      final compressedSize = await compressedFile.length();
      final savedPercent = ((originalSize - compressedSize) / originalSize * 100).toStringAsFixed(1);
      debugPrint('[MediaUploadService] ✅ Compressed: ${FirebaseStorageService.formatFileSize(compressedSize)} (saved $savedPercent%)');

      return compressedFile;
    } catch (e) {
      debugPrint('[MediaUploadService] ❌ Compression error: $e');
      return null;
    }
  }

  /// Create thumbnail for image
  /// Returns thumbnail file, null if creation fails
  Future<File?> createThumbnail(File imageFile) async {
    try {
      debugPrint('[MediaUploadService] 🔍 Creating thumbnail');

      final tempDir = await getTemporaryDirectory();
      final targetPath =
          '${tempDir.absolute.path}/thumb_${DateTime.now().millisecondsSinceEpoch}.jpg';

      final result = await FlutterImageCompress.compressAndGetFile(
        imageFile.absolute.path,
        targetPath,
        quality: 50,
        minWidth: thumbnailSize,
        minHeight: thumbnailSize,
        format: CompressFormat.jpeg,
      );

      if (result == null) {
        debugPrint('[MediaUploadService] ❌ Thumbnail creation failed');
        return null;
      }

      final thumbnailFile = File(result.path);
      debugPrint('[MediaUploadService] ✅ Thumbnail created: ${thumbnailFile.path}');
      return thumbnailFile;
    } catch (e) {
      debugPrint('[MediaUploadService] ❌ Thumbnail error: $e');
      return null;
    }
  }

  /// Upload image with compression
  Future<Map<String, String>?> uploadImage({
    required File imageFile,
    required String requestId,
    VoidCallback? onProgress,
  }) async {
    try {
      // Compress original image
      final compressedImage = await compressImage(imageFile);
      if (compressedImage == null) {
        debugPrint('[MediaUploadService] ❌ Failed to compress image');
        return null;
      }

      // Create thumbnail
      final thumbnail = await createThumbnail(compressedImage);

      // Upload main image
      final imageFileName = 'img_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final imageUrl = await _storageService.uploadImage(
        imageFile: compressedImage,
        requestId: requestId,
        fileName: imageFileName,
        onProgress: onProgress,
      );

      if (imageUrl == null) {
        debugPrint('[MediaUploadService] ❌ Failed to upload image');
        return null;
      }

      // Upload thumbnail if available
      String? thumbnailUrl;
      if (thumbnail != null) {
        final thumbFileName = 'thumb_${DateTime.now().millisecondsSinceEpoch}.jpg';
        thumbnailUrl = await _storageService.uploadImage(
          imageFile: thumbnail,
          requestId: requestId,
          fileName: thumbFileName,
        );
      }

      // Get file size
      final fileSize = await compressedImage.length();

      // Record metadata in Serverpod backend
      await _recordMediaMetadata(
        mediaUrl: imageUrl,
        mediaType: 'image',
        fileName: imageFileName,
        fileSizeBytes: fileSize,
        requestId: requestId,
        thumbnailUrl: thumbnailUrl,
      );

      debugPrint('[MediaUploadService] ✅ Image uploaded successfully');
      return {
        'imageUrl': imageUrl,
        if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
        'fileSize': fileSize.toString(),
      };
    } catch (e) {
      debugPrint('[MediaUploadService] ❌ Image upload error: $e');
      return null;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // AUDIO HANDLING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Upload audio file
  Future<Map<String, String>?> uploadAudio({
    required File audioFile,
    required String requestId,
    required int? durationMs,
    VoidCallback? onProgress,
  }) async {
    try {
      final fileSize = await audioFile.length();

      // Validate file size (max 10MB)
      if (fileSize > 10 * 1024 * 1024) {
        debugPrint('[MediaUploadService] ❌ Audio file too large: ${FirebaseStorageService.formatFileSize(fileSize)}');
        return null;
      }

      final audioFileName = 'audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
      final audioUrl = await _storageService.uploadAudio(
        audioFile: audioFile,
        requestId: requestId,
        fileName: audioFileName,
        onProgress: onProgress,
      );

      if (audioUrl == null) {
        debugPrint('[MediaUploadService] ❌ Failed to upload audio');
        return null;
      }

      // Record metadata in Serverpod backend
      await _recordMediaMetadata(
        mediaUrl: audioUrl,
        mediaType: 'audio',
        fileName: audioFileName,
        fileSizeBytes: fileSize,
        requestId: requestId,
        durationMs: durationMs,
      );

      debugPrint('[MediaUploadService] ✅ Audio uploaded successfully');
      return {
        'audioUrl': audioUrl,
        'fileSize': fileSize.toString(),
        if (durationMs != null) 'duration': durationMs.toString(),
      };
    } catch (e) {
      debugPrint('[MediaUploadService] ❌ Audio upload error: $e');
      return null;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // VIDEO HANDLING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Upload video file
  Future<Map<String, String>?> uploadVideo({
    required File videoFile,
    required String requestId,
    required int? durationMs,
    VoidCallback? onProgress,
  }) async {
    try {
      final fileSize = await videoFile.length();

      // Validate file size (max 50MB)
      if (fileSize > 50 * 1024 * 1024) {
        debugPrint('[MediaUploadService] ❌ Video file too large: ${FirebaseStorageService.formatFileSize(fileSize)}');
        return null;
      }

      final videoFileName = 'video_${DateTime.now().millisecondsSinceEpoch}.mp4';
      final videoUrl = await _storageService.uploadVideo(
        videoFile: videoFile,
        requestId: requestId,
        fileName: videoFileName,
        onProgress: onProgress,
      );

      if (videoUrl == null) {
        debugPrint('[MediaUploadService] ❌ Failed to upload video');
        return null;
      }

      // Create and upload thumbnail
      String? thumbnailUrl;
      // Note: Would need video_thumbnail package to extract frame
      // For now, we'll skip this feature

      // Record metadata in Serverpod backend
      await _recordMediaMetadata(
        mediaUrl: videoUrl,
        mediaType: 'video',
        fileName: videoFileName,
        fileSizeBytes: fileSize,
        requestId: requestId,
        durationMs: durationMs,
        thumbnailUrl: thumbnailUrl,
      );

      debugPrint('[MediaUploadService] ✅ Video uploaded successfully');
      return {
        'videoUrl': videoUrl,
        'fileSize': fileSize.toString(),
        'duration': durationMs?.toString() ?? '0',
        'thumbnailUrl': thumbnailUrl ?? '',
      };
    } catch (e) {
      debugPrint('[MediaUploadService] ❌ Video upload error: $e');
      return null;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BACKEND METADATA RECORDING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Record media metadata to Serverpod backend
  Future<void> _recordMediaMetadata({
    required String mediaUrl,
    required String mediaType,
    required String fileName,
    required int fileSizeBytes,
    required String requestId,
    int? durationMs,
    String? thumbnailUrl,
  }) async {
    try {
      final authController = Get.find<AuthController>();
      final currentUser = authController.currentUser.value;

      if (currentUser == null) {
        debugPrint('[MediaUploadService] ⚠️ No user logged in, skipping metadata recording');
        return;
      }

      // Generate a unique message ID for this media
      final messageId = 'media_${DateTime.now().millisecondsSinceEpoch}_${currentUser.id}';

      final metadata = await _client.media.recordMedia(
        messageId: messageId,
        userId: currentUser.id!,
        requestId: int.parse(requestId),
        mediaUrl: mediaUrl,
        mediaType: mediaType,
        fileName: fileName,
        fileSizeBytes: fileSizeBytes,
        durationMs: durationMs,
        thumbnailUrl: thumbnailUrl,
        uploadedAt: DateTime.now(),
      );

      if (metadata != null) {
        debugPrint('[MediaUploadService] ✅ Metadata recorded: ID ${metadata.id}');
      } else {
        debugPrint('[MediaUploadService] ⚠️ Metadata recording returned null');
      }
    } catch (e) {
      // Don't fail the upload if metadata recording fails
      debugPrint('[MediaUploadService] ⚠️ Failed to record metadata: $e');
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CLEANUP
  // ═══════════════════════════════════════════════════════════════════════════

  /// Delete temporary files created during compression
  Future<void> cleanupTemporaryFiles() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final files = tempDir.listSync();

      int deletedCount = 0;
      for (final file in files) {
        if (file is File && (file.path.contains('compressed_') || file.path.contains('thumb_'))) {
          await file.delete();
          deletedCount++;
        }
      }

      if (deletedCount > 0) {
        debugPrint('[MediaUploadService] 🗑️ Cleaned up $deletedCount temporary files');
      }
    } catch (e) {
      debugPrint('[MediaUploadService] ❌ Cleanup error: $e');
    }
  }

  /// Validate media file before upload
  Future<Map<String, dynamic>> validateMediaFile(File file) async {
    try {
      final fileSize = await file.length();
      final fileName = file.path.split('/').last;
      final fileExtension = fileName.split('.').last.toLowerCase();

      // Determine media type
      String mediaType = 'unknown';
      int maxSize = 5 * 1024 * 1024;

      if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(fileExtension)) {
        mediaType = 'image';
        maxSize = 5 * 1024 * 1024; // 5MB
      } else if (['m4a', 'mp3', 'wav', 'aac'].contains(fileExtension)) {
        mediaType = 'audio';
        maxSize = 10 * 1024 * 1024; // 10MB
      } else if (['mp4', 'mov', 'avi', 'mkv'].contains(fileExtension)) {
        mediaType = 'video';
        maxSize = 50 * 1024 * 1024; // 50MB
      }

      final isValid = fileSize <= maxSize;

      return {
        'isValid': isValid,
        'mediaType': mediaType,
        'fileSize': fileSize,
        'maxAllowed': maxSize,
        'fileName': fileName,
        'error': !isValid ? 'File exceeds ${FirebaseStorageService.formatFileSize(maxSize)} limit' : null,
      };
    } catch (e) {
      return {
        'isValid': false,
        'error': 'Failed to validate file: $e',
      };
    }
  }
}
