import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'store/store_location_screen.dart';
import 'store/store_working_hours_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'dart:convert';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/controllers/auth_controller.dart';
import '../core/controllers/profile_controller.dart';
import '../core/controllers/store_controller.dart';
import '../core/services/location_service.dart';
import '../core/services/image_picker_service.dart';
import '../core/services/media_upload_service.dart';
import '../core/services/firebase_storage_service.dart';
import '../core/services/deep_link_service.dart';
import '../app/controllers/theme_controller.dart';
import '../app/controllers/locale_controller.dart';
import '../core/utils/url_utils.dart';
import '../shared/widgets/profile_qr_code_widget.dart';
import 'store/store_profile_screen.dart';
import 'store_gallery_screen.dart';

// Re-export AppThemeMode for use in this file
typedef _AppThemeMode = AppThemeMode;

/// Minimal professional profile screen
class EnhancedProfileScreen extends StatelessWidget {
  const EnhancedProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final authController = Get.find<AuthController>();

    // Initialize profile controller if not exists
    if (!Get.isRegistered<ProfileController>()) {
      Get.put(ProfileController());
    }
    final profileController = Get.find<ProfileController>();

    // Force refresh review stats when profile is opened (for drivers)
    final user = authController.currentUser.value;
    if (user != null && user.roles.contains(UserRole.driver)) {
      profileController.loadDriverReviewStats();
      profileController.loadClientGivenReviewStats();
    }

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text('nav.profile'.tr),
        centerTitle: true,
        backgroundColor: colors.background,
        elevation: 0,
      ),
      body: Obx(() {
        // Show loading while auth is initializing
        if (!authController.isInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = authController.currentUser.value;

        // If no user, show sign-in prompt
        if (user == null) {
          return _buildNotSignedIn(context, colors);
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              _buildProfileHeader(context, colors, user, profileController),
              SizedBox(height: 32.h),
              // Role switcher for multi-role users
              Obx(() {
                if (authController.hasMultipleRoles) {
                  return Column(
                    children: [
                      _buildRoleSwitcher(context, colors, authController),
                      SizedBox(height: 24.h),
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),
              // Store Management Card (only for store owners)
              Obx(() {
                final activeRole = authController.activeRole.value;
                final isStore = activeRole == UserRole.store || 
                                user.roles.contains(UserRole.store);
                if (isStore) {
                  return Column(
                    children: [
                      _buildStoreManagementSection(context, colors),
                      SizedBox(height: 24.h),
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),
              _buildQuickStats(context, colors, authController),
              SizedBox(height: 24.h),
              _buildRatingSection(context, colors, authController, profileController),
              SizedBox(height: 32.h),
              _buildSettingsMenu(context, colors, authController, profileController),
              SizedBox(height: 40.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildNotSignedIn(BuildContext context, AppColorScheme colors) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Iconsax.user, size: 48.w, color: colors.primary),
            ),
            SizedBox(height: 24.h),
            Text(
              'profile.not_logged_in'.tr,
              style: AppTypography.headlineSmall(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'profile.login_to_continue'.tr,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.toNamed('/auth/login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text('auth.sign_in'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, AppColorScheme colors, dynamic user, ProfileController controller) {
    return Column(
      children: [
        // Avatar with edit button
        Stack(
          children: [
            Obx(() {
              if (controller.isUploadingPhoto.value) {
                return Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: colors.surface),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              return _buildAvatar(context, colors, user.profilePhotoUrl, user.fullName);
            }),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => controller.uploadProfilePhoto(context),
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: colors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.background, width: 2),
                  ),
                  child: Icon(Iconsax.camera, size: 16.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          user.fullName ?? 'profile.no_name'.tr,
          style: AppTypography.headlineSmall(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          user.email ?? user.phoneNumber ?? '',
          style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRoleBadge(context, colors, user.roles?.first),
            // Show share and QR buttons for drivers
            if (user.roles?.contains(UserRole.driver) == true) ...[
              SizedBox(width: 12.w),
              _buildQRCodeButton(context, colors, user),
              SizedBox(width: 8.w),
              _buildShareProfileButton(context, colors, user),
            ],
          ],
        ),
      ],
    );
  }

  /// Build QR code button for drivers
  Widget _buildQRCodeButton(BuildContext context, AppColorScheme colors, dynamic user) {
    return InkWell(
      onTap: () => _showQRCode(context, user),
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: colors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: colors.primary.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code_2, size: 16.sp, color: colors.primary),
            SizedBox(width: 6.w),
            Text(
              'profile.qr_code'.tr,
              style: AppTypography.labelMedium(context).copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build share profile button for drivers
  Widget _buildShareProfileButton(BuildContext context, AppColorScheme colors, dynamic user) {
    return InkWell(
      onTap: () => _shareDriverProfile(context, user),
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: colors.success.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: colors.success.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Iconsax.share, size: 14.sp, color: colors.success),
            SizedBox(width: 6.w),
            Text(
              'profile.share'.tr,
              style: AppTypography.labelMedium(context).copyWith(
                color: colors.success,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Share driver profile via deep link
  void _shareDriverProfile(BuildContext context, dynamic user) async {
    final userId = user.id;
    final userName = user.fullName ?? 'Driver';
    
    if (userId == null) {
      Get.snackbar('Error', 'Unable to share profile');
      return;
    }

    final deepLink = DeepLinkService.generateDriverLink(userId);
    final shareText = 'profile.share_message'.trParams({
      'name': userName,
      'link': deepLink,
    });

    debugPrint('[EnhancedProfile] 📤 Sharing driver profile: $deepLink');

    try {
      await Share.share(
        shareText,
        subject: 'profile.share_subject'.trParams({'name': userName}),
      );
    } catch (e) {
      debugPrint('[EnhancedProfile] ❌ Share failed: $e');
      Get.snackbar('Error', 'Failed to share profile');
    }
  }

  /// Show QR code for driver profile
  void _showQRCode(BuildContext context, dynamic user) {
    final userId = user.id;
    final userName = user.fullName ?? 'Driver';
    final profilePhoto = user.profilePhotoUrl;

    if (userId == null) {
      Get.snackbar('Error', 'Unable to generate QR code');
      return;
    }

    debugPrint('[EnhancedProfile] 📱 Showing QR code for driver: $userId');

    ProfileQRCodeWidget.show(
      context: context,
      profileType: 'driver',
      profileId: userId,
      profileName: userName,
      profilePhoto: profilePhoto,
    );
  }

  Widget _buildAvatar(BuildContext context, AppColorScheme colors, String? photoUrl, String? fullName) {
    final size = 100.w;
    debugPrint('[EnhancedProfileScreen] 📷 Building avatar - photoUrl: $photoUrl');
    debugPrint('[EnhancedProfileScreen] photoUrl isEmpty: ${photoUrl?.isEmpty}, photoUrl isNull: ${photoUrl == null}');
    
    if (photoUrl != null && photoUrl.isNotEmpty) {
      debugPrint('[EnhancedProfileScreen] ✅ Using photo URL: $photoUrl');
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colors.primary.withValues(alpha: 0.3), width: 3),
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: UrlUtils.normalizeImageUrl(photoUrl) ?? photoUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: colors.surface, child: const Center(child: CircularProgressIndicator())),
            errorWidget: (context, url, error) {
              debugPrint('[EnhancedProfileScreen] ❌ Image load error: $error, url: $url');
              return _buildFallbackAvatar(colors, fullName, size);
            },
          ),
        ),
      );
    }
    debugPrint('[EnhancedProfileScreen] ⚠️ No photo URL, showing initials');
    return _buildFallbackAvatar(colors, fullName, size);
  }

  Widget _buildFallbackAvatar(AppColorScheme colors, String? fullName, double size) {
    final initials = _getInitials(fullName ?? '');
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: colors.primary.withValues(alpha: 0.1)),
      child: Center(
        child: Text(initials, style: TextStyle(color: colors.primary, fontSize: size * 0.35, fontWeight: FontWeight.bold)),
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty || parts[0].isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  Widget _buildRoleBadge(BuildContext context, AppColorScheme colors, dynamic role) {
    final isDriver = role?.toString().contains('driver') ?? false;
    final label = isDriver ? 'profile.driver'.tr : 'profile.client'.tr;
    final icon = isDriver ? Iconsax.car : Iconsax.user;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(color: colors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: colors.primary),
          SizedBox(width: 6.w),
          Text(label, style: AppTypography.labelMedium(context).copyWith(color: colors.primary, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildRatingSection(BuildContext context, AppColorScheme colors, AuthController authController, ProfileController profileController) {
    return Obx(() {
      final user = authController.currentUser.value;
      if (user == null) return const SizedBox.shrink();

      final isDriver = user.roles.contains(UserRole.driver);
      final driverRating = profileController.driverReviewAverage.value;
      final driverTotalRatings = profileController.driverReviewCount.value;
      final clientRating = isDriver
          ? profileController.clientGivenAverage.value
          : (user.ratingAsClient ?? 0.0);
      final clientTotalRatings = isDriver
          ? profileController.clientGivenCount.value
          : user.totalRatingsAsClient;
      final loading = profileController.isLoadingDriverReviews.value;

      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Iconsax.star_1, size: 20.sp, color: colors.warning),
                SizedBox(width: 8.w),
                Text(
                  'rating.reviews'.tr,
                  style: AppTypography.titleMedium(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            if (isDriver && loading) ...[
              Center(
                child: SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: CircularProgressIndicator(strokeWidth: 2, color: colors.primary),
                ),
              ),
              SizedBox(height: 12.h),
            ],

            // Show driver rating if user is a driver
            if (isDriver) ...[
              _buildRatingRow(
                context,
                colors,
                'driver'.tr,
                driverRating,
                driverTotalRatings,
                Iconsax.car,
              ),
              SizedBox(height: 12.h),
            ],

            // Always show client rating
            _buildRatingRow(
              context,
              colors,
              'client'.tr,
              clientRating,
              clientTotalRatings,
              Iconsax.user,
            ),

            // View all reviews button (driver reviews)
            if (isDriver && driverTotalRatings > 0) ...[
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Get.toNamed(
                    '/reviews',
                    arguments: {
                      'revieweeType': 'driver',
                      'revieweeId': user.id,
                      'revieweeName': user.fullName,
                      'initialRating': driverRating,
                    },
                  ),
                  child: Text(
                    'rating.view_all_reviews'.tr,
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildRatingRow(
    BuildContext context,
    AppColorScheme colors,
    String label,
    double rating,
    int totalRatings,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 16.sp, color: colors.primary),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
              if (totalRatings > 0)
                Text(
                  'rating.based_on'.tr.replaceAll('{count}', totalRatings.toString()),
                  style: AppTypography.bodySmall(context).copyWith(
                    color: colors.textMuted,
                  ),
                ),
            ],
          ),
        ),
        // Star rating display
        if (totalRatings > 0) ...[
          Row(
            children: List.generate(5, (index) {
              final starValue = index + 1;
              final isFullStar = rating >= starValue;
              final isHalfStar = rating >= starValue - 0.5 && rating < starValue;
              return Icon(
                isFullStar ? Iconsax.star_1 : (isHalfStar ? Iconsax.star_1 : Iconsax.star),
                size: 16.sp,
                color: colors.warning,
              );
            }),
          ),
          SizedBox(width: 8.w),
          Text(
            rating.toStringAsFixed(1),
            style: AppTypography.titleMedium(context).copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ] else
          Text(
            'rating.no_reviews'.tr,
            style: AppTypography.bodyMedium(context).copyWith(
              color: colors.textMuted,
            ),
          ),
      ],
    );
  }

  Widget _buildQuickStats(BuildContext context, AppColorScheme colors, AuthController authController) {
    final user = authController.currentUser.value;
    if (user == null) return const SizedBox.shrink();
    
    // User table has these fields that we can display
    final isVerified = user.isPhoneVerified || user.isEmailVerified;
    final memberSince = user.createdAt;
    final lastSeen = user.lastSeenAt ?? user.updatedAt;
    
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          Expanded(child: _buildStatItem(
            context, colors, 
            isVerified ? Iconsax.verify : Iconsax.shield_cross, 
            'profile.verification'.tr, 
            isVerified ? 'profile.verified'.tr : 'profile.not_verified'.tr,
          )),
          Container(width: 1, height: 40.h, color: colors.border),
          Expanded(child: _buildStatItem(
            context, colors, 
            Iconsax.calendar, 
            'profile.member_since'.tr, 
            _formatDate(memberSince),
          )),
          Container(width: 1, height: 40.h, color: colors.border),
          Expanded(child: _buildStatItem(
            context, colors, 
            Iconsax.clock, 
            'profile.last_active'.tr, 
            _formatRelativeTime(lastSeen),
          )),
        ],
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.year}';
  }
  
  String _formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 5) return 'profile.just_now'.tr;
    if (diff.inHours < 1) return '${diff.inMinutes}m';
    if (diff.inDays < 1) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return _formatDate(date);
  }

  Widget _buildStatItem(BuildContext context, AppColorScheme colors, IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 20.sp, color: colors.primary),
        SizedBox(height: 8.h),
        Text(value, style: AppTypography.titleMedium(context).copyWith(color: colors.textPrimary, fontWeight: FontWeight.bold)),
        SizedBox(height: 2.h),
        Text(label, style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
      ],
    );
  }

  Widget _buildRoleSwitcher(BuildContext context, AppColorScheme colors, AuthController authController) {
    final user = authController.currentUser.value;
    if (user == null || user.roles.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.user_octagon, size: 20.sp, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                'profile.switch_role'.tr,
                style: AppTypography.bodyLarge(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: user.roles.map((role) {
              final isActive = authController.primaryRole == role;
              String label;
              IconData icon;
              
              switch (role) {
                case UserRole.client:
                  label = 'client'.tr;
                  icon = Iconsax.user;
                  break;
                case UserRole.driver:
                  label = 'driver'.tr;
                  icon = Iconsax.car;
                  break;
                case UserRole.store:
                  label = 'store'.tr;
                  icon = Iconsax.shop;
                  break;
                case UserRole.admin:
                  label = 'Admin';
                  icon = Iconsax.shield_tick;
                  break;
              }
              
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: role != user.roles.last ? 8.w : 0),
                  child: GestureDetector(
                    onTap: () => authController.switchActiveRole(role),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: isActive ? colors.primary : colors.background,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isActive ? colors.primary : colors.border,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            icon,
                            size: 24.sp,
                            color: isActive ? Colors.white : colors.textSecondary,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            label,
                            style: AppTypography.bodySmall(context).copyWith(
                              color: isActive ? Colors.white : colors.textPrimary,
                              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          if (user.roles.length == 1) ...[
            SizedBox(height: 12.h),
            TextButton.icon(
              onPressed: () => _showAddRoleDialog(context, colors, authController),
              icon: Icon(Iconsax.add_circle, size: 18.sp),
              label: Text('profile.add_role'.tr),
              style: TextButton.styleFrom(
                foregroundColor: colors.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Store Management Section - Clean menu style matching profile design
  Widget _buildStoreManagementSection(BuildContext context, AppColorScheme colors) {
    // Initialize store controller if not exists
    if (!Get.isRegistered<StoreController>()) {
      Get.put(StoreController());
    }
    final storeController = Get.find<StoreController>();

    return Obx(() {
      final store = storeController.myStore.value;
      
      // If no store, show registration prompt
      if (!storeController.hasStore) {
        return Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Iconsax.shop_add, size: 32.sp, color: colors.primary),
              ),
              SizedBox(height: 16.h),
              Text(
                'store_management.no_store_yet'.tr,
                style: AppTypography.bodyLarge(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'Register your store to start selling',
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Get.toNamed('/store/register'),
                  icon: Icon(Iconsax.add, size: 18.sp),
                  label: Text('store_management.register_now'.tr),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      // Store exists - show menu style management options
      return Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colors.border),
        ),
        child: Column(
          children: [
            // Store header with status
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  // Store logo
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: store!.logoUrl != null
                          ? CachedNetworkImage(
                              imageUrl: store.logoUrl!,
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) => Icon(
                                Iconsax.shop,
                                size: 24.sp,
                                color: colors.primary,
                              ),
                            )
                          : Icon(
                              Iconsax.shop,
                              size: 24.sp,
                              color: colors.primary,
                            ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          store.name,
                          style: AppTypography.bodyLarge(context).copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Container(
                              width: 6.w,
                              height: 6.w,
                              decoration: BoxDecoration(
                                color: store.isOpen ? Colors.green : Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              store.isOpen 
                                  ? 'store_management.store_open'.tr 
                                  : 'store_management.store_closed'.tr,
                              style: AppTypography.bodySmall(context).copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Iconsax.arrow_right_3, size: 18.sp, color: colors.textSecondary),
                ],
              ),
            ),
            _buildDivider(colors),
            // Edit Store Info
            _buildMenuItem(
              context,
              colors,
              Iconsax.edit,
              'store_management.store_profile'.tr,
              onTap: () => Get.to(() => const StoreProfileScreen()),
            ),
            _buildDivider(colors),
            // Gallery
            _buildMenuItem(
              context,
              colors,
              Iconsax.gallery,
              'store_profile.gallery'.tr,
              onTap: () => Get.to(() => const StoreGalleryScreen()),
            ),
            _buildDivider(colors),
            // Location & Address
            _buildMenuItem(
              context,
              colors,
              Iconsax.location,
              'store_detail.location'.tr,
              onTap: () => Get.to(() => const StoreLocationScreen()),
            ),
            _buildDivider(colors),
            // Working Hours
            _buildMenuItem(
              context,
              colors,
              Iconsax.clock,
              'store_management.working_hours'.tr,
              onTap: () => Get.to(() => const StoreWorkingHoursScreen()),
            ),
            _buildDivider(colors),
            // Store Logo & Cover
            _buildMenuItem(
              context,
              colors,
              Iconsax.image,
              'store_management.store_logo'.tr,
              onTap: () => _showLogoEditor(context, colors, storeController),
            ),
            _buildDivider(colors),
            // Service Options
            _buildMenuItem(
              context,
              colors,
              Iconsax.setting_2,
              'store_profile.service_options'.tr,
              onTap: () => _showServiceOptionsEditor(context, colors, storeController),
            ),
          ],
        ),
      );
    });
  }

  void _showAddRoleDialog(BuildContext context, AppColorScheme colors, AuthController authController) {
    final hasClient = authController.hasRole(UserRole.client);
    final hasDriver = authController.hasRole(UserRole.driver);
    
    final availableRole = hasClient ? UserRole.driver : UserRole.client;
    final roleLabel = hasClient ? 'driver'.tr : 'client'.tr;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('profile.add_role'.tr),
        content: Text('profile.add_role_description'.tr.replaceAll('{role}', roleLabel)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('common.cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await authController.addRole(availableRole);
              if (success) {
                Get.snackbar(
                  'common.success'.tr,
                  'profile.role_added'.tr,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: colors.success,
                  colorText: Colors.white,
                );
              } else {
                Get.snackbar(
                  'common.error'.tr,
                  authController.errorMessage.value,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: colors.error,
                  colorText: Colors.white,
                );
              }
            },
            child: Text('common.confirm'.tr),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsMenu(BuildContext context, AppColorScheme colors, AuthController authController, ProfileController profileController) {
    final user = authController.currentUser.value;
    final themeController = Get.find<ThemeController>();
    final localeController = Get.find<LocaleController>();
    
    return Container(
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(16.r), border: Border.all(color: colors.border)),
      child: Column(
        children: [
          // Edit Profile - navigates to edit screen
          _buildMenuItem(context, colors, Iconsax.user_edit, 'profile.edit_profile'.tr, onTap: () => _showEditProfileDialog(context, colors, user, profileController)),
          if (user?.roles.contains(UserRole.driver) ?? false) ...[
            _buildDivider(colors),
            _buildMenuItem(
              context,
              colors,
              Iconsax.location,
              'driver.change_location'.tr,
              onTap: () => Get.toNamed('/driver/location'),
            ),
          ],
          _buildDivider(colors),
          // Notifications Toggle - backed by user.notificationsEnabled
          _buildToggleMenuItem(
            context, colors, 
            Iconsax.notification, 
            'profile.notifications'.tr,
            value: user?.notificationsEnabled ?? true,
            onChanged: (value) => _updateNotificationSetting(profileController, value),
          ),
          _buildDivider(colors),
          // Dark Mode Toggle - backed by user.darkModeEnabled + local theme
          _buildToggleMenuItem(
            context, colors, 
            Iconsax.moon, 
            'profile.dark_mode'.tr,
            value: themeController.isDarkMode,
            onChanged: (value) => _updateThemeSetting(themeController, profileController, value),
          ),
          _buildDivider(colors),
          // Language - backed by user.preferredLanguage
          _buildMenuItem(context, colors, Iconsax.language_square, 'profile.language'.tr, 
            trailing: Text(localeController.currentLocaleName, style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary)),
            onTap: () => _showLanguageDialog(context, colors, localeController, profileController),
          ),
          _buildDivider(colors),
          // Terms & Conditions
          _buildMenuItem(context, colors, Iconsax.document_text, 'legal.terms_title'.tr, onTap: () => Get.toNamed('/legal/terms')),
          _buildDivider(colors),
          // Privacy Policy
          _buildMenuItem(context, colors, Iconsax.shield_tick, 'legal.privacy_title'.tr, onTap: () => Get.toNamed('/legal/privacy')),
          _buildDivider(colors),
          // Community Guidelines
          _buildMenuItem(context, colors, Iconsax.people, 'legal.guidelines_title'.tr, onTap: () => Get.toNamed('/legal/guidelines')),
          _buildDivider(colors),
          // Contact Support
          _buildMenuItem(context, colors, Iconsax.message_question, 'support.contact_support'.tr, onTap: () => _showContactSupportDialog(context, colors)),
          _buildDivider(colors),
          // Sign Out
          _buildMenuItem(context, colors, Iconsax.logout, 'profile.sign_out'.tr, onTap: () => _showSignOutDialog(context, colors, authController), isDestructive: true),
          _buildDivider(colors),
          // Delete Account
          _buildMenuItem(context, colors, Iconsax.trash, 'account.delete_title'.tr, onTap: () => Get.toNamed('/account/delete'), isDestructive: true),
        ],
      ),
    );
  }
  
  Widget _buildToggleMenuItem(BuildContext context, AppColorScheme colors, IconData icon, String title, {required bool value, required ValueChanged<bool> onChanged}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Icon(icon, size: 22.sp, color: colors.textPrimary),
          SizedBox(width: 12.w),
          Expanded(child: Text(title, style: AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary, fontWeight: FontWeight.w500))),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: colors.primary,
          ),
        ],
      ),
    );
  }
  
  void _updateNotificationSetting(ProfileController controller, bool enabled) {
    controller.updateProfile(notificationsEnabled: enabled);
  }
  
  void _updateThemeSetting(ThemeController themeController, ProfileController profileController, bool isDark) {
    themeController.setThemeMode(isDark ? _AppThemeMode.dark : _AppThemeMode.light);
    profileController.updateProfile(darkModeEnabled: isDark);
  }
  
  void _showLanguageDialog(BuildContext context, AppColorScheme colors, LocaleController localeController, ProfileController profileController) {
    Get.dialog(
      AlertDialog(
        title: Text('profile.select_language'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(context, colors, 'English', 'en', localeController, profileController),
            _buildLanguageOption(context, colors, 'العربية', 'ar', localeController, profileController),
            _buildLanguageOption(context, colors, 'Français', 'fr', localeController, profileController),
            _buildLanguageOption(context, colors, 'Español', 'es', localeController, profileController),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLanguageOption(BuildContext context, AppColorScheme colors, String name, String code, LocaleController localeController, ProfileController profileController) {
    final isSelected = localeController.currentLocale.languageCode == code;
    return ListTile(
      title: Text(name),
      trailing: isSelected ? Icon(Icons.check, color: colors.primary) : null,
      onTap: () {
        localeController.changeLocale(code);
        // Map to backend Language enum
        final langMap = {'en': Language.en, 'ar': Language.ar, 'fr': Language.fr, 'es': Language.es};
        profileController.updateProfile(preferredLanguage: langMap[code]);
        Get.back();
      },
    );
  }
  
  void _showEditProfileDialog(BuildContext context, AppColorScheme colors, User? user, ProfileController controller) {
    final nameController = TextEditingController(text: user?.fullName ?? '');
    final emailController = TextEditingController(text: user?.email ?? '');
    final phoneController = TextEditingController(text: user?.phoneNumber ?? '');
    
    Get.dialog(
      AlertDialog(
        title: Text('profile.edit_profile'.tr),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'profile.full_name'.tr, prefixIcon: const Icon(Iconsax.user)),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'profile.email'.tr, prefixIcon: const Icon(Iconsax.sms)),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'profile.phone'.tr, prefixIcon: const Icon(Iconsax.call)),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('common.cancel'.tr)),
          TextButton(
            onPressed: () async {
              Get.back();
              await controller.updateProfile(
                fullName: nameController.text.trim(),
                email: emailController.text.trim().isNotEmpty ? emailController.text.trim() : null,
                phoneNumber: phoneController.text.trim().isNotEmpty ? phoneController.text.trim() : null,
              );
            },
            child: Text('common.save'.tr),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, AppColorScheme colors, IconData icon, String title, {required VoidCallback onTap, bool isDestructive = false, Widget? trailing}) {
    final color = isDestructive ? colors.error : colors.textPrimary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, size: 22.sp, color: color),
            SizedBox(width: 12.w),
            Expanded(child: Text(title, style: AppTypography.bodyMedium(context).copyWith(color: color, fontWeight: FontWeight.w500))),
            if (trailing != null) trailing else Icon(Iconsax.arrow_right_3, size: 18.sp, color: colors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(AppColorScheme colors) => Divider(height: 1, color: colors.border, indent: 50.w);

  void _showSetTestLocationDialog(BuildContext context, AppColorScheme colors) {
    final locationService = Get.find<LocationService>();
    LatLng selectedLocation = const LatLng(33.5731, -7.5898); // Default: Casablanca
    final markers = <Marker>{}.obs;
    
    // Add initial marker
    markers.add(Marker(
      markerId: const MarkerId('test_location'),
      position: selectedLocation,
      draggable: true,
      onDragEnd: (newPosition) {
        selectedLocation = newPosition;
      },
    ));
    
    Get.dialog(
      Dialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Container(
          height: 600.h,
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  Icon(Iconsax.location, color: colors.primary, size: 24.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Set Test Location',
                      style: AppTypography.titleLarge(context).copyWith(color: colors.textPrimary),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Iconsax.close_circle, color: colors.textSecondary),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                'Tap on the map to select your test location',
                style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary),
              ),
              SizedBox(height: 16.h),
              
              // Map
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Obx(() => GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: selectedLocation,
                      zoom: 12,
                    ),
                    markers: markers.toSet(),
                    onTap: (position) {
                      selectedLocation = position;
                      markers.clear();
                      markers.add(Marker(
                        markerId: const MarkerId('test_location'),
                        position: position,
                        draggable: true,
                        onDragEnd: (newPosition) {
                          selectedLocation = newPosition;
                        },
                      ));
                    },
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: true,
                    mapToolbarEnabled: false,
                  )),
                ),
              ),
              
              SizedBox(height: 16.h),
              
              // Coordinates display
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.gps, color: colors.primary, size: 20.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        '${selectedLocation.latitude.toStringAsFixed(6)}, ${selectedLocation.longitude.toStringAsFixed(6)}',
                        style: AppTypography.bodySmall(context).copyWith(
                          color: colors.textPrimary,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 16.h),
              
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        locationService.clearTestLocation();
                        Get.back();
                        Get.snackbar(
                          'Location Reset',
                          'Using actual device location',
                          backgroundColor: colors.info,
                          colorText: Colors.white,
                          icon: Icon(Iconsax.gps, color: Colors.white),
                        );
                      },
                      icon: Icon(Iconsax.gps, size: 18.sp),
                      label: Text('Use GPS'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colors.error,
                        side: BorderSide(color: colors.error),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        locationService.setTestLocation(
                          selectedLocation.latitude,
                          selectedLocation.longitude,
                        );
                        Get.back();
                        Get.snackbar(
                          'Location Set',
                          'Test location: ${selectedLocation.latitude.toStringAsFixed(4)}, ${selectedLocation.longitude.toStringAsFixed(4)}',
                          backgroundColor: colors.success,
                          colorText: Colors.white,
                          icon: Icon(Iconsax.tick_circle, color: Colors.white),
                        );
                      },
                      icon: Icon(Iconsax.tick_circle, size: 18.sp),
                      label: Text('Set Location'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationOption(BuildContext context, AppColorScheme colors, String cityName, String coordinates, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: colors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: colors.primary.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cityName, style: AppTypography.bodyLarge(context).copyWith(color: colors.textPrimary, fontWeight: FontWeight.w600)),
                  SizedBox(height: 4.h),
                  Text(coordinates, style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary)),
                ],
              ),
            ),
            Icon(Iconsax.arrow_right_3, color: colors.primary, size: 20.sp),
          ],
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context, AppColorScheme colors, AuthController authController) {
    Get.dialog(
      AlertDialog(
        title: Text('profile.sign_out'.tr),
        content: Text('profile.sign_out_confirm'.tr),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('common.cancel'.tr)),
          TextButton(
            onPressed: () {
              Get.back();
              authController.signOut();
            },
            child: Text('profile.sign_out'.tr, style: TextStyle(color: colors.error)),
          ),
        ],
      ),
    );
  }

  void _showContactSupportDialog(BuildContext context, AppColorScheme colors) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Icon(Iconsax.message_question, color: colors.primary, size: 48.sp),
            SizedBox(height: 16.h),
            Text(
              'support.contact_support'.tr,
              style: AppTypography.titleLarge(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'support.contact_support_description'.tr,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            // Email option
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  Get.back();
                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: 'support@awhar.ma',
                    queryParameters: {
                      'subject': 'Awhar App Support Request',
                    },
                  );
                  if (await canLaunchUrl(emailUri)) {
                    await launchUrl(emailUri);
                  } else {
                    Get.snackbar(
                      'Error',
                      'Could not open email app',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                icon: Icon(Iconsax.sms),
                label: Text('support.email_us'.tr),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            // WhatsApp option
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  Get.back();
                  final Uri whatsappUri = Uri.parse('https://wa.me/212600000000?text=Hello, I need help with Awhar app');
                  if (await canLaunchUrl(whatsappUri)) {
                    await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
                  } else {
                    Get.snackbar(
                      'Error',
                      'Could not open WhatsApp',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                icon: Icon(Iconsax.message, color: colors.success),
                label: Text('support.whatsapp'.tr, style: TextStyle(color: colors.success)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: colors.success),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'common.cancel'.tr,
                style: TextStyle(color: colors.textSecondary),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // ============================================================
  // STORE MANAGEMENT DIALOGS
  // ============================================================

  void _showLocationEditor(BuildContext context, AppColorScheme colors, StoreController storeController) {
    final store = storeController.myStore.value;
    if (store == null) return;

    final addressController = TextEditingController(text: store.address);
    final cityController = TextEditingController(text: store.city);

    Get.dialog(
      Dialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Container(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Iconsax.location, color: colors.primary, size: 24.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'store_detail.location'.tr,
                        style: AppTypography.titleLarge(context).copyWith(color: colors.textPrimary),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Iconsax.close_circle, color: colors.textSecondary),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'store_management.store_address'.tr,
                    prefixIcon: Icon(Iconsax.location, color: colors.primary),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    filled: true,
                    fillColor: colors.background,
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    labelText: 'City',
                    prefixIcon: Icon(Iconsax.building, color: colors.primary),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    filled: true,
                    fillColor: colors.background,
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Iconsax.gps, color: colors.primary, size: 20.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current Location',
                              style: AppTypography.labelMedium(context).copyWith(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${store.latitude.toStringAsFixed(6)}, ${store.longitude.toStringAsFixed(6)}',
                              style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        ),
                        child: Text('common.cancel'.tr),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final success = await storeController.updateStore(
                            address: addressController.text.trim(),
                            city: cityController.text.trim(),
                          );
                          Get.back();
                          if (success) {
                            Get.snackbar(
                              'common.success'.tr,
                              'Location updated successfully',
                              backgroundColor: colors.success,
                              colorText: Colors.white,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        ),
                        child: Text('common.save'.tr),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showWorkingHoursEditor(BuildContext context, AppColorScheme colors, StoreController storeController) {
    Get.dialog(
      Dialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Iconsax.clock, color: colors.primary, size: 24.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'store_management.working_hours'.tr,
                      style: AppTypography.titleLarge(context).copyWith(color: colors.textPrimary),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Iconsax.close_circle, color: colors.textSecondary),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Icon(Iconsax.calendar_2, size: 48.sp, color: colors.primary),
                    SizedBox(height: 12.h),
                    Text(
                      'Set your store operating hours',
                      style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Coming soon',
                      style: AppTypography.bodySmall(context).copyWith(color: colors.textMuted),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar('Coming Soon', 'Working hours editor coming soon!');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text('Set Hours'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoEditor(BuildContext context, AppColorScheme colors, StoreController storeController) {
    final store = storeController.myStore.value;
    if (store == null) return;

    Get.dialog(
      Dialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Iconsax.image, color: colors.primary, size: 24.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Store Images',
                      style: AppTypography.titleLarge(context).copyWith(color: colors.textPrimary),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Iconsax.close_circle, color: colors.textSecondary),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              
              // Logo
              Obx(() {
                final currentStore = storeController.myStore.value;
                return Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: colors.background,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: colors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: currentStore?.logoUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: currentStore!.logoUrl!,
                                  fit: BoxFit.cover,
                                  errorWidget: (_, __, ___) => Icon(Iconsax.shop, size: 30.sp, color: colors.primary),
                                )
                              : Icon(Iconsax.shop, size: 30.sp, color: colors.primary),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Store Logo',
                              style: AppTypography.bodyLarge(context).copyWith(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Square image recommended',
                              style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _uploadStoreLogo(context, colors, storeController),
                        icon: Icon(Iconsax.edit, color: colors.primary),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 12.h),
              
              // Cover
              Obx(() {
                final currentStore = storeController.myStore.value;
                return Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: colors.background,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: colors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: currentStore?.coverImageUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: currentStore!.coverImageUrl!,
                                  fit: BoxFit.cover,
                                  errorWidget: (_, __, ___) => Icon(Iconsax.image, size: 30.sp, color: colors.primary),
                                )
                              : Icon(Iconsax.image, size: 30.sp, color: colors.primary),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cover Image',
                              style: AppTypography.bodyLarge(context).copyWith(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Wide banner image',
                              style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _uploadStoreCover(context, colors, storeController),
                        icon: Icon(Iconsax.edit, color: colors.primary),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  /// Upload store logo
  Future<void> _uploadStoreLogo(BuildContext context, AppColorScheme colors, StoreController storeController) async {
    final imagePickerService = Get.find<ImagePickerService>();
    final mediaUploadService = Get.find<MediaUploadService>();
    final storageService = Get.find<FirebaseStorageService>();

    // Pick image
    final imageFile = await imagePickerService.showImageSourcePicker(
      enableCropping: true,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );

    if (imageFile == null) return;

    try {
      // Show loading
      Get.dialog(
        PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(strokeWidth: 3.w),
                  SizedBox(height: 16.h),
                  Text(
                    'Uploading logo...',
                    style: AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary),
                  ),
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );

      // Compress
      final compressedFile = await mediaUploadService.compressImage(imageFile);
      if (compressedFile == null) {
        Get.back();
        Get.snackbar('Error', 'Failed to compress image', backgroundColor: colors.error, colorText: Colors.white);
        return;
      }

      // Upload to Firebase Storage
      final storeId = storeController.storeId;
      if (storeId == null) {
        Get.back();
        return;
      }

      final uploadResult = await storageService.uploadFile(
        file: compressedFile,
        path: 'stores/$storeId/logo_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      if (uploadResult == null) {
        Get.back();
        Get.snackbar('Error', 'Failed to upload logo', backgroundColor: colors.error, colorText: Colors.white);
        return;
      }

      // Update store with new logo URL
      final success = await storeController.updateStoreLogo(uploadResult);
      Get.back();

      if (success) {
        Get.snackbar(
          'Success',
          'Logo updated successfully',
          backgroundColor: colors.success,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar('Error', 'Failed to update logo', backgroundColor: colors.error, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Upload failed: $e', backgroundColor: colors.error, colorText: Colors.white);
    }
  }

  /// Upload store cover image
  Future<void> _uploadStoreCover(BuildContext context, AppColorScheme colors, StoreController storeController) async {
    final imagePickerService = Get.find<ImagePickerService>();
    final mediaUploadService = Get.find<MediaUploadService>();
    final storageService = Get.find<FirebaseStorageService>();

    // Pick image
    final imageFile = await imagePickerService.showImageSourcePicker(
      enableCropping: true,
      maxWidth: 1200,
      maxHeight: 600,
      imageQuality: 85,
    );

    if (imageFile == null) return;

    try {
      // Show loading
      Get.dialog(
        PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(strokeWidth: 3.w),
                  SizedBox(height: 16.h),
                  Text(
                    'Uploading cover image...',
                    style: AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary),
                  ),
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );

      // Compress
      final compressedFile = await mediaUploadService.compressImage(imageFile);
      if (compressedFile == null) {
        Get.back();
        Get.snackbar('Error', 'Failed to compress image', backgroundColor: colors.error, colorText: Colors.white);
        return;
      }

      // Upload to Firebase Storage
      final storeId = storeController.storeId;
      if (storeId == null) {
        Get.back();
        return;
      }

      final uploadResult = await storageService.uploadFile(
        file: compressedFile,
        path: 'stores/$storeId/cover_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      if (uploadResult == null) {
        Get.back();
        Get.snackbar('Error', 'Failed to upload cover', backgroundColor: colors.error, colorText: Colors.white);
        return;
      }

      // Update store with new cover URL
      final success = await storeController.updateStoreCoverImage(uploadResult);
      Get.back();

      if (success) {
        Get.snackbar(
          'Success',
          'Cover image updated successfully',
          backgroundColor: colors.success,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar('Error', 'Failed to update cover', backgroundColor: colors.error, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Upload failed: $e', backgroundColor: colors.error, colorText: Colors.white);
    }
  }

  void _showServiceOptionsEditor(BuildContext context, AppColorScheme colors, StoreController storeController) {
    final store = storeController.myStore.value;
    if (store == null) return;

    final hasDelivery = store.hasDelivery.obs;
    final hasPickup = store.hasPickup.obs;
    final acceptsCash = store.acceptsCash.obs;
    final acceptsCard = store.acceptsCard.obs;

    Get.dialog(
      Dialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Iconsax.setting_2, color: colors.primary, size: 24.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'store_profile.service_options'.tr,
                      style: AppTypography.titleLarge(context).copyWith(color: colors.textPrimary),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Iconsax.close_circle, color: colors.textSecondary),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              
              // Service Types
              Text(
                'store_profile.service_types'.tr,
                style: AppTypography.labelLarge(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              Obx(() => CheckboxListTile(
                title: Row(
                  children: [
                    Icon(Iconsax.truck_fast, size: 20.sp, color: colors.primary),
                    SizedBox(width: 8.w),
                    Text('store_profile.delivery'.tr),
                  ],
                ),
                value: hasDelivery.value,
                onChanged: (value) => hasDelivery.value = value ?? false,
                activeColor: colors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                contentPadding: EdgeInsets.zero,
              )),
              Obx(() => CheckboxListTile(
                title: Row(
                  children: [
                    Icon(Iconsax.box, size: 20.sp, color: colors.primary),
                    SizedBox(width: 8.w),
                    Text('store_profile.pickup'.tr),
                  ],
                ),
                value: hasPickup.value,
                onChanged: (value) => hasPickup.value = value ?? false,
                activeColor: colors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                contentPadding: EdgeInsets.zero,
              )),
              SizedBox(height: 16.h),
              
              // Payment Methods
              Text(
                'store_profile.payment_methods'.tr,
                style: AppTypography.labelLarge(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              Obx(() => CheckboxListTile(
                title: Row(
                  children: [
                    Icon(Iconsax.money, size: 20.sp, color: colors.primary),
                    SizedBox(width: 8.w),
                    Text('store_profile.cash'.tr),
                  ],
                ),
                value: acceptsCash.value,
                onChanged: (value) => acceptsCash.value = value ?? false,
                activeColor: colors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                contentPadding: EdgeInsets.zero,
              )),
              Obx(() => CheckboxListTile(
                title: Row(
                  children: [
                    Icon(Iconsax.card, size: 20.sp, color: colors.primary),
                    SizedBox(width: 8.w),
                    Text('store_profile.card'.tr),
                  ],
                ),
                value: acceptsCard.value,
                onChanged: (value) => acceptsCard.value = value ?? false,
                activeColor: colors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                contentPadding: EdgeInsets.zero,
              )),
              SizedBox(height: 20.h),
              
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text('common.cancel'.tr),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final success = await storeController.updateStoreExtended(
                          hasDelivery: hasDelivery.value,
                          hasPickup: hasPickup.value,
                          acceptsCash: acceptsCash.value,
                          acceptsCard: acceptsCard.value,
                        );
                        Get.back();
                        if (success) {
                          Get.snackbar(
                            'common.success'.tr,
                            'Service options updated',
                            backgroundColor: colors.success,
                            colorText: Colors.white,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text('common.save'.tr),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
