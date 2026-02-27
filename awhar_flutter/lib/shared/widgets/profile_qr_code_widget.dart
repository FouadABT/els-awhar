import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Reusable QR Code widget for sharing driver/store profiles
/// 
/// Generates a QR code that links to www.awhar.com with deep link parameters
/// Supports both driver and store profiles
class ProfileQRCodeWidget extends StatelessWidget {
  final String profileType; // 'driver' or 'store'
  final int profileId;
  final String profileName;
  final String? profilePhoto;

  const ProfileQRCodeWidget({
    super.key,
    required this.profileType,
    required this.profileId,
    required this.profileName,
    this.profilePhoto,
  });

  /// Generate the deep link URL for the profile
  String get deepLinkUrl {
    // Use www.awhar.com as the base URL
    return 'https://www.awhar.com/$profileType/$profileId';
  }

  /// Generate share text
  String get shareText {
    if (profileType == 'driver') {
      return 'profile.share_driver'.trParams({
        'name': profileName,
        'link': deepLinkUrl,
      });
    } else {
      return 'profile.share_store'.trParams({
        'name': profileName,
        'link': deepLinkUrl,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.qr_code_2,
                color: colors.primary,
                size: 28.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'profile.qr_title'.tr,
                      style: AppTypography.titleMedium(context).copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'profile.qr_subtitle'.tr,
                      style: AppTypography.bodySmall(context).copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 20.h),
          
          // QR Code
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: colors.border,
                width: 2,
              ),
            ),
            child: QrImageView(
              data: deepLinkUrl,
              version: QrVersions.auto,
              size: 200.w,
              backgroundColor: Colors.white,
              eyeStyle: QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: colors.primary,
              ),
              dataModuleStyle: QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: Colors.black,
              ),
              embeddedImage: profilePhoto != null && profilePhoto!.isNotEmpty
                  ? NetworkImage(profilePhoto!)
                  : null,
              embeddedImageStyle: QrEmbeddedImageStyle(
                size: Size(40.w, 40.w),
              ),
            ),
          ),
          
          SizedBox(height: 24.h),
          
          // Profile info with picture and name
          Column(
            children: [
              // Profile Picture
              if (profilePhoto != null && profilePhoto!.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.primary,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colors.primary.withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 40.r,
                    backgroundImage: NetworkImage(profilePhoto!),
                    backgroundColor: colors.background,
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.primary.withOpacity(0.1),
                    border: Border.all(
                      color: colors.primary,
                      width: 3,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 40.r,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      profileType == 'driver' ? Icons.person : Icons.store,
                      size: 40.sp,
                      color: colors.primary,
                    ),
                  ),
                ),
              
              SizedBox(height: 12.h),
              
              // Full Name
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  profileName,
                  style: AppTypography.titleLarge(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
              SizedBox(height: 4.h),
              
              // Profile Type Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  profileType == 'driver' ? 'driver.title'.tr : 'store.title'.tr,
                  style: AppTypography.bodySmall(context).copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          // URL display
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: colors.border,
                width: 1,
              ),
            ),
            child: Text(
              deepLinkUrl,
              style: AppTypography.bodySmall(context).copyWith(
                color: colors.textSecondary,
                fontFamily: 'monospace',
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _shareProfile(),
                  icon: Icon(Icons.share, size: 18.sp),
                  label: Text('common.share'.tr),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.textPrimary,
                  side: BorderSide(color: colors.border),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text('common.close'.tr),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Share the profile link
  void _shareProfile() async {
    try {
      await Share.share(
        shareText,
        subject: 'profile.share_subject'.trParams({'name': profileName}),
      );
    } catch (e) {
      debugPrint('[QRCode] ❌ Share failed: $e');
      Get.snackbar(
        'errors.title'.tr,
        'errors.share_failed'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Show QR code in a bottom sheet
  static void show({
    required BuildContext context,
    required String profileType,
    required int profileId,
    required String profileName,
    String? profilePhoto,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ProfileQRCodeWidget(
          profileType: profileType,
          profileId: profileId,
          profileName: profileName,
          profilePhoto: profilePhoto,
        ),
      ),
    );
  }
}
