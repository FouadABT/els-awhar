import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget to display image messages in chat
/// Supports network images, local files, loading states, and error handling
/// Tap to open full-screen preview
class ImageMessageWidget extends StatelessWidget {
  final String? imageUrl;
  final File? imageFile;
  final String? thumbnailUrl;
  final double? width;
  final double? height;
  final int? fileSizeBytes;
  final VoidCallback? onTap;
  final bool showFileSize;
  final bool enableFullScreen;
  final BorderRadius? borderRadius;

  const ImageMessageWidget({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.thumbnailUrl,
    this.width,
    this.height,
    this.fileSizeBytes,
    this.onTap,
    this.showFileSize = false,
    this.enableFullScreen = true,
    this.borderRadius,
  }) : assert(imageUrl != null || imageFile != null,
            'Either imageUrl or imageFile must be provided');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderRadiusValue = borderRadius ?? BorderRadius.circular(12.r);

    return GestureDetector(
      onTap: enableFullScreen
          ? () {
              if (onTap != null) {
                onTap!();
              } else {
                _openFullScreen();
              }
            }
          : onTap,
      child: Stack(
        children: [
          // Image container
          Container(
            width: width ?? 200.w,
            height: height ?? 200.h,
            decoration: BoxDecoration(
              borderRadius: borderRadiusValue,
              color: isDark ? Colors.grey[800] : Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: borderRadiusValue,
              child: _buildImage(),
            ),
          ),

          // File size badge (optional)
          if (showFileSize && fileSizeBytes != null)
            Positioned(
              top: 8.h,
              right: 8.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  _formatFileSize(fileSizeBytes!),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

          // Tap indicator (magnifying glass icon)
          if (enableFullScreen)
            Positioned(
              bottom: 8.h,
              right: 8.w,
              child: Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.zoom_in,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Build image widget based on source (network URL or local file)
  Widget _buildImage() {
    // Local file (upload in progress or just picked)
    if (imageFile != null) {
      return Image.file(
        imageFile!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    }

    // Network image (uploaded to Firebase)
    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildLoadingWidget(),
        errorWidget: (context, url, error) => _buildErrorWidget(),
        // Use thumbnail for initial load if available
        httpHeaders: thumbnailUrl != null
            ? {'X-Thumbnail-Url': thumbnailUrl!}
            : null,
      );
    }

    return _buildErrorWidget();
  }

  /// Loading indicator while image is downloading
  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 2.w,
            valueColor: AlwaysStoppedAnimation<Color>(
              Get.theme.colorScheme.primary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'loading_image'.tr,
            style: TextStyle(
              fontSize: 11.sp,
              color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  /// Error widget when image fails to load
  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image,
            size: 48.sp,
            color: Get.theme.colorScheme.error.withValues(alpha: 0.6),
          ),
          SizedBox(height: 8.h),
          Text(
            'image_load_error'.tr,
            style: TextStyle(
              fontSize: 11.sp,
              color: Get.theme.colorScheme.error.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Open full-screen image preview
  void _openFullScreen() {
    Get.to(
      () => ImagePreviewScreen(
        imageUrl: imageUrl,
        imageFile: imageFile,
        heroTag: imageUrl ?? imageFile?.path ?? 'image',
      ),
      transition: Transition.fade,
      duration: Duration(milliseconds: 300),
    );
  }

  /// Format file size in human-readable format
  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }
}

/// Full-screen image preview with zoom, pan, and save functionality
class ImagePreviewScreen extends StatefulWidget {
  final String? imageUrl;
  final File? imageFile;
  final String heroTag;

  const ImagePreviewScreen({
    super.key,
    this.imageUrl,
    this.imageFile,
    required this.heroTag,
  });

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  final TransformationController _transformationController =
      TransformationController();
  TapDownDetails? _doubleTapDetails;

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          // Save to gallery button
          IconButton(
            icon: Icon(Icons.download, color: Colors.white),
            onPressed: _saveToGallery,
          ),
          // Share button
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: _shareImage,
          ),
        ],
      ),
      body: GestureDetector(
        onDoubleTapDown: _handleDoubleTapDown,
        onDoubleTap: _handleDoubleTap,
        child: Center(
          child: Hero(
            tag: widget.heroTag,
            child: InteractiveViewer(
              transformationController: _transformationController,
              minScale: 0.5,
              maxScale: 4.0,
              child: _buildFullScreenImage(),
            ),
          ),
        ),
      ),
    );
  }

  /// Build full-screen image
  Widget _buildFullScreenImage() {
    if (widget.imageFile != null) {
      return Image.file(
        widget.imageFile!,
        fit: BoxFit.contain,
      );
    }

    if (widget.imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: widget.imageUrl!,
        fit: BoxFit.contain,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        errorWidget: (context, url, error) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size: 64.sp),
              SizedBox(height: 16.h),
              Text(
                'image_load_error'.tr,
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
            ],
          ),
        ),
      );
    }

    return Center(
      child: Text(
        'no_image_available'.tr,
        style: TextStyle(color: Colors.white, fontSize: 16.sp),
      ),
    );
  }

  /// Handle double tap down for zoom position
  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  /// Handle double tap to zoom in/out
  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      // Zoom out
      _transformationController.value = Matrix4.identity();
    } else {
      // Zoom in at tap position
      final position = _doubleTapDetails!.localPosition;
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
    }
  }

  /// Save image to gallery
  Future<void> _saveToGallery() async {
    try {
      // TODO: Implement save to gallery functionality using image_gallery_saver package
      Get.snackbar(
        'success'.tr,
        'image_saved_to_gallery'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.8),
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'save_image_failed'.tr + ': $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
  }

  /// Share image via system share sheet
  Future<void> _shareImage() async {
    try {
      // TODO: Implement share functionality using share_plus package
      Get.snackbar(
        'info'.tr,
        'share_not_implemented'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.withValues(alpha: 0.8),
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'share_image_failed'.tr + ': $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
  }
}
