import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Service for managing Firebase Cloud Storage operations
/// Handles uploading and downloading media files (images, audio, videos)
class FirebaseStorageService extends GetxService {
  late final FirebaseStorage _storage;
  
  // Storage configuration
  static const String _chatMediaBucket = 'chats';
  static const int maxUploadSizeBytes = 100 * 1024 * 1024; // 100MB
  static const int maxImageSizeMB = 5; // 5MB
  static const int maxAudioSizeMB = 10; // 10MB
  
  // Reactive state
  final RxDouble uploadProgress = 0.0.obs;
  final RxBool isUploading = false.obs;
  final RxString? uploadError = RxString('');

  @override
  void onInit() {
    super.onInit();
    _initializeFirebaseStorage();
  }

  /// Initialize Firebase Storage instance
  void _initializeFirebaseStorage() {
    try {
      _storage = FirebaseStorage.instance;
      debugPrint('[FirebaseStorageService] ✅ Initialized successfully');
    } catch (e) {
      debugPrint('[FirebaseStorageService] ❌ Initialization error: $e');
      uploadError?.value = 'Failed to initialize Firebase Storage';
    }
  }

  /// Get the FirebaseStorage instance
  FirebaseStorage get storage => _storage;

  // ═══════════════════════════════════════════════════════════════════════════
  // IMAGE UPLOAD
  // ═══════════════════════════════════════════════════════════════════════════

  /// Upload image to Firebase Storage
  /// Returns the download URL on success, null on failure
  Future<String?> uploadImage({
    required File imageFile,
    required String requestId,
    required String fileName,
    VoidCallback? onProgress,
  }) async {
    try {
      final fileSize = await imageFile.length();
      if (fileSize > maxImageSizeMB * 1024 * 1024) {
        debugPrint('[FirebaseStorageService] ❌ Image too large: ${fileSize ~/ (1024 * 1024)}MB');
        uploadError?.value = 'Image size exceeds ${maxImageSizeMB}MB limit';
        return null;
      }

      isUploading.value = true;
      uploadProgress.value = 0.0;
      uploadError?.value = '';

      final path = '$_chatMediaBucket/$requestId/images/$fileName';
      final ref = _storage.ref(path);

      debugPrint('[FirebaseStorageService] 📤 Uploading image to: $path');

      // Upload with progress tracking
      final uploadTask = ref.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        uploadProgress.value = progress;
        onProgress?.call();
        debugPrint('[FirebaseStorageService] 📊 Upload progress: ${(progress * 100).toStringAsFixed(1)}%');
      });

      await uploadTask;
      final downloadUrl = await ref.getDownloadURL();

      debugPrint('[FirebaseStorageService] ✅ Image uploaded successfully: $downloadUrl');
      isUploading.value = false;
      return downloadUrl;
    } catch (e) {
      debugPrint('[FirebaseStorageService] ❌ Image upload error: $e');
      uploadError?.value = 'Failed to upload image: $e';
      isUploading.value = false;
      return null;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // AUDIO UPLOAD
  // ═══════════════════════════════════════════════════════════════════════════

  /// Upload audio file to Firebase Storage
  /// Returns the download URL on success, null on failure
  Future<String?> uploadAudio({
    required File audioFile,
    required String requestId,
    required String fileName,
    VoidCallback? onProgress,
  }) async {
    try {
      final fileSize = await audioFile.length();
      if (fileSize > maxAudioSizeMB * 1024 * 1024) {
        debugPrint('[FirebaseStorageService] ❌ Audio too large: ${fileSize ~/ (1024 * 1024)}MB');
        uploadError?.value = 'Audio size exceeds ${maxAudioSizeMB}MB limit';
        return null;
      }

      isUploading.value = true;
      uploadProgress.value = 0.0;
      uploadError?.value = '';

      final path = '$_chatMediaBucket/$requestId/audio/$fileName';
      final ref = _storage.ref(path);

      debugPrint('[FirebaseStorageService] 📤 Uploading audio to: $path');

      // Upload with progress tracking
      final uploadTask = ref.putFile(
        audioFile,
        SettableMetadata(contentType: 'audio/aac'),
      );

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        uploadProgress.value = progress;
        onProgress?.call();
        debugPrint('[FirebaseStorageService] 📊 Upload progress: ${(progress * 100).toStringAsFixed(1)}%');
      });

      await uploadTask;
      final downloadUrl = await ref.getDownloadURL();

      debugPrint('[FirebaseStorageService] ✅ Audio uploaded successfully: $downloadUrl');
      isUploading.value = false;
      return downloadUrl;
    } catch (e) {
      debugPrint('[FirebaseStorageService] ❌ Audio upload error: $e');
      uploadError?.value = 'Failed to upload audio: $e';
      isUploading.value = false;
      return null;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // VIDEO UPLOAD
  // ═══════════════════════════════════════════════════════════════════════════

  /// Upload video file to Firebase Storage
  /// Returns the download URL on success, null on failure
  Future<String?> uploadVideo({
    required File videoFile,
    required String requestId,
    required String fileName,
    VoidCallback? onProgress,
  }) async {
    try {
      final fileSize = await videoFile.length();
      if (fileSize > 50 * 1024 * 1024) { // 50MB max for video
        debugPrint('[FirebaseStorageService] ❌ Video too large: ${fileSize ~/ (1024 * 1024)}MB');
        uploadError?.value = 'Video size exceeds 50MB limit';
        return null;
      }

      isUploading.value = true;
      uploadProgress.value = 0.0;
      uploadError?.value = '';

      final path = '$_chatMediaBucket/$requestId/videos/$fileName';
      final ref = _storage.ref(path);

      debugPrint('[FirebaseStorageService] 📤 Uploading video to: $path');

      final uploadTask = ref.putFile(
        videoFile,
        SettableMetadata(contentType: 'video/mp4'),
      );

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        uploadProgress.value = progress;
        onProgress?.call();
        debugPrint('[FirebaseStorageService] 📊 Upload progress: ${(progress * 100).toStringAsFixed(1)}%');
      });

      await uploadTask;
      final downloadUrl = await ref.getDownloadURL();

      debugPrint('[FirebaseStorageService] ✅ Video uploaded successfully: $downloadUrl');
      isUploading.value = false;
      return downloadUrl;
    } catch (e) {
      debugPrint('[FirebaseStorageService] ❌ Video upload error: $e');
      uploadError?.value = 'Failed to upload video: $e';
      isUploading.value = false;
      return null;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // GENERIC FILE OPERATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Upload file to custom path in Firebase Storage
  /// Returns the download URL on success, null on failure
  Future<String?> uploadFile({
    required File file,
    required String path,
    String? contentType,
    VoidCallback? onProgress,
  }) async {
    try {
      final fileSize = await file.length();
      if (fileSize > maxImageSizeMB * 1024 * 1024) {
        debugPrint('[FirebaseStorageService] ❌ File too large: ${fileSize ~/ (1024 * 1024)}MB');
        uploadError?.value = 'File size exceeds ${maxImageSizeMB}MB limit';
        return null;
      }

      isUploading.value = true;
      uploadProgress.value = 0.0;
      uploadError?.value = '';

      final ref = _storage.ref(path);
      debugPrint('[FirebaseStorageService] 📤 Uploading file to: $path');

      // Upload with progress tracking
      final uploadTask = ref.putFile(
        file,
        SettableMetadata(contentType: contentType ?? 'image/jpeg'),
      );

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        uploadProgress.value = progress;
        onProgress?.call();
        debugPrint('[FirebaseStorageService] 📊 Upload progress: ${(progress * 100).toStringAsFixed(1)}%');
      });

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      isUploading.value = false;
      debugPrint('[FirebaseStorageService] ✅ File uploaded successfully: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      debugPrint('[FirebaseStorageService] ❌ File upload error: $e');
      uploadError?.value = 'Failed to upload file: $e';
      isUploading.value = false;
      return null;
    }
  }

  /// Delete a file from Firebase Storage
  Future<bool> deleteFile({
    required String requestId,
    required String fileName,
    required String fileType, // 'images', 'audio', 'videos'
  }) async {
    try {
      final path = '$_chatMediaBucket/$requestId/$fileType/$fileName';
      final ref = _storage.ref(path);

      await ref.delete();
      debugPrint('[FirebaseStorageService] ✅ File deleted: $path');
      return true;
    } catch (e) {
      debugPrint('[FirebaseStorageService] ❌ File deletion error: $e');
      return false;
    }
  }

  /// Get download URL for a file
  Future<String?> getDownloadUrl({
    required String requestId,
    required String fileName,
    required String fileType,
  }) async {
    try {
      final path = '$_chatMediaBucket/$requestId/$fileType/$fileName';
      final ref = _storage.ref(path);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      debugPrint('[FirebaseStorageService] ❌ Error getting download URL: $e');
      return null;
    }
  }

  /// Get file metadata (size, last modified, etc.)
  Future<FullMetadata?> getFileMetadata({
    required String requestId,
    required String fileName,
    required String fileType,
  }) async {
    try {
      final path = '$_chatMediaBucket/$requestId/$fileType/$fileName';
      final ref = _storage.ref(path);
      final metadata = await ref.getMetadata();
      return metadata;
    } catch (e) {
      debugPrint('[FirebaseStorageService] ❌ Error getting metadata: $e');
      return null;
    }
  }

  /// Download file to a local path
  Future<bool> downloadFile({
    required String requestId,
    required String fileName,
    required String fileType,
    required String localPath,
    VoidCallback? onProgress,
  }) async {
    try {
      isUploading.value = true;
      uploadProgress.value = 0.0;

      final path = '$_chatMediaBucket/$requestId/$fileType/$fileName';
      final ref = _storage.ref(path);
      final file = File(localPath);

      final downloadTask = ref.writeToFile(file);

      downloadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        uploadProgress.value = progress;
        onProgress?.call();
        debugPrint('[FirebaseStorageService] 📊 Download progress: ${(progress * 100).toStringAsFixed(1)}%');
      });

      await downloadTask;
      debugPrint('[FirebaseStorageService] ✅ File downloaded: $localPath');
      isUploading.value = false;
      return true;
    } catch (e) {
      debugPrint('[FirebaseStorageService] ❌ Download error: $e');
      uploadError?.value = 'Failed to download file: $e';
      isUploading.value = false;
      return false;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // UTILITIES
  // ═══════════════════════════════════════════════════════════════════════════

  /// Cancel ongoing upload/download
  void cancelTransfer() {
    isUploading.value = false;
    uploadProgress.value = 0.0;
    debugPrint('[FirebaseStorageService] ⏹️ Transfer cancelled');
  }

  /// Reset error message
  void clearError() {
    uploadError?.value = '';
  }

  /// Format bytes to human-readable size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }
}
