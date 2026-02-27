import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/store_controller.dart';
import '../../core/services/deep_link_service.dart';
import '../../shared/widgets/profile_qr_code_widget.dart';
import 'package:share_plus/share_plus.dart';

/// Store profile screen
/// Displays and allows editing of store profile
class StoreProfileScreen extends StatefulWidget {
  const StoreProfileScreen({super.key});

  @override
  State<StoreProfileScreen> createState() => _StoreProfileScreenState();
}

class _StoreProfileScreenState extends State<StoreProfileScreen> {
  late final StoreController _storeController;
  final _formKey = GlobalKey<FormState>();
  
  // Basic info controllers
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  
  // Extended profile controllers
  late TextEditingController _taglineController;
  late TextEditingController _aboutController;
  late TextEditingController _whatsappController;
  late TextEditingController _websiteController;
  late TextEditingController _facebookController;
  late TextEditingController _instagramController;
  
  // Service options
  bool _acceptsCash = true;
  bool _acceptsCard = false;
  bool _hasDelivery = true;
  bool _hasPickup = false;
  
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _storeController = Get.find<StoreController>();
    _initControllers();
  }

  void _initControllers() {
    final store = _storeController.myStore.value;
    _nameController = TextEditingController(text: store?.name ?? '');
    _descriptionController = TextEditingController(text: store?.description ?? '');
    _phoneController = TextEditingController(text: store?.phone ?? '');
    _emailController = TextEditingController(text: store?.email ?? '');
    _addressController = TextEditingController(text: store?.address ?? '');
    
    // Extended profile
    _taglineController = TextEditingController(text: store?.tagline ?? '');
    _aboutController = TextEditingController(text: store?.aboutText ?? '');
    _whatsappController = TextEditingController(text: store?.whatsappNumber ?? '');
    _websiteController = TextEditingController(text: store?.websiteUrl ?? '');
    _facebookController = TextEditingController(text: store?.facebookUrl ?? '');
    _instagramController = TextEditingController(text: store?.instagramUrl ?? '');
    
    // Service options
    _acceptsCash = store?.acceptsCash ?? true;
    _acceptsCard = store?.acceptsCard ?? false;
    _hasDelivery = store?.hasDelivery ?? true;
    _hasPickup = store?.hasPickup ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _taglineController.dispose();
    _aboutController.dispose();
    _whatsappController.dispose();
    _websiteController.dispose();
    _facebookController.dispose();
    _instagramController.dispose();
    super.dispose();
  }

  /// Show QR code for store profile
  void _showStoreQRCode(BuildContext context, dynamic store) {
    final storeId = store.id;
    final storeName = store.name ?? 'Store';
    final storeLogo = store.logoUrl;

    if (storeId == null) {
      Get.snackbar('Error', 'Unable to generate QR code');
      return;
    }

    debugPrint('[StoreProfile] 📱 Showing QR code for store: $storeId');

    ProfileQRCodeWidget.show(
      context: context,
      profileType: 'store',
      profileId: storeId,
      profileName: storeName,
      profilePhoto: storeLogo,
    );
  }

  /// Share store profile via deep link
  void _shareStoreProfile(BuildContext context, dynamic store) async {
    final storeId = store.id;
    final storeName = store.name ?? 'Store';

    if (storeId == null) {
      Get.snackbar('Error', 'Unable to share profile');
      return;
    }

    // Generate deep link (using same pattern as driver)
    final deepLink = 'https://www.awhar.com/store/$storeId';
    final shareText = 'profile.share_store'.trParams({
      'name': storeName,
      'link': deepLink,
    });

    debugPrint('[StoreProfile] 📤 Sharing store profile: $deepLink');

    try {
      await Share.share(
        shareText,
        subject: 'profile.share_subject'.trParams({'name': storeName}),
      );
    } catch (e) {
      debugPrint('[StoreProfile] ❌ Share failed: $e');
      Get.snackbar('Error', 'Failed to share profile');
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
        title: Text(
          'store_management.store_profile'.tr,
          style: AppTypography.titleMedium(context).copyWith(
            color: colors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(() {
            final store = _storeController.myStore.value;
            if (store != null && !_isEditing) {
              return Row(
                children: [
                  // QR Code button
                  IconButton(
                    icon: Icon(Icons.qr_code_2, color: colors.primary),
                    onPressed: () => _showStoreQRCode(context, store),
                    tooltip: 'profile.qr_code'.tr,
                  ),
                  // Share button
                  IconButton(
                    icon: Icon(Iconsax.share, color: colors.success),
                    onPressed: () => _shareStoreProfile(context, store),
                    tooltip: 'profile.share'.tr,
                  ),
                  // Edit button
                  IconButton(
                    icon: Icon(Iconsax.edit, color: colors.textPrimary),
                    onPressed: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                  ),
                ],
              );
            }
            return IconButton(
              icon: Icon(Iconsax.close_circle, color: colors.textPrimary),
              onPressed: () {
                setState(() {
                  _isEditing = false;
                  _initControllers(); // Reset to original values
                });
              },
            );
          }),
        ],
      ),
      body: Obx(() {
        final store = _storeController.myStore.value;
        
        if (store == null) {
          return Center(
            child: Text(
              'store_management.no_store_yet'.tr,
              style: AppTypography.bodyLarge(context).copyWith(
                color: colors.textSecondary,
              ),
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Store header with logo and cover
              _buildStoreHeader(store, colors),
              SizedBox(height: 24.h),
              
              // Store status toggle
              _buildStatusCard(store, colors),
              SizedBox(height: 16.h),
              
              // Store info form/display
              _buildInfoSection(store, colors),
              SizedBox(height: 16.h),
              
              // Extended profile section (about, tagline)
              _buildExtendedProfileSection(store, colors),
              SizedBox(height: 16.h),
              
              // Contact & social links section
              _buildContactLinksSection(store, colors),
              SizedBox(height: 24.h),
              
              // Save button (when editing)
              if (_isEditing) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _storeController.isSaving.value ? null : _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: _storeController.isSaving.value
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'common.save'.tr,
                            style: AppTypography.labelLarge(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStoreHeader(dynamic store, dynamic colors) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Cover image
        Container(
          height: 150.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16.r),
            image: store.coverImageUrl != null
              ? DecorationImage(
                  image: CachedNetworkImageProvider(store.coverImageUrl!),
                  fit: BoxFit.cover,
                )
              : null,
          ),
          child: store.coverImageUrl == null
            ? Center(
                child: Icon(
                  Iconsax.image,
                  size: 48.sp,
                  color: colors.textSecondary,
                ),
              )
            : null,
        ),
        // Logo
        Positioned(
          bottom: -40.h,
          left: 16.w,
          child: Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: colors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: colors.surface, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: ClipOval(
              child: store.logoUrl != null
                ? CachedNetworkImage(
                    imageUrl: store.logoUrl!,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: colors.primary.withValues(alpha: 0.1),
                    child: Icon(
                      Iconsax.shop,
                      size: 36.sp,
                      color: colors.primary,
                    ),
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard(dynamic store, dynamic colors) {
    return Container(
      margin: EdgeInsets.only(top: 48.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          // Open/Closed status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store.isOpen 
                    ? 'store_management.store_open'.tr 
                    : 'store_management.store_closed'.tr,
                  style: AppTypography.labelLarge(context).copyWith(
                    color: store.isOpen ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  store.isOpen 
                    ? 'Accepting orders' 
                    : 'Not accepting orders',
                  style: AppTypography.bodySmall(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Toggle switch
          Switch.adaptive(
            value: store.isOpen,
            onChanged: (value) async {
              await _storeController.toggleStoreOpen();
            },
            activeTrackColor: colors.primary.withValues(alpha: 0.4),
            thumbColor: WidgetStateProperty.all(colors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(dynamic store, dynamic colors) {
    if (_isEditing) {
      return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'store_management.store_name'.tr,
                  prefixIcon: const Icon(Iconsax.shop),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  filled: true,
                  fillColor: colors.surface,
                ),
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'store_management.store_description'.tr,
                  prefixIcon: const Icon(Iconsax.document_text),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  filled: true,
                  fillColor: colors.surface,
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'store_management.store_phone'.tr,
                  prefixIcon: const Icon(Iconsax.call),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  filled: true,
                  fillColor: colors.surface,
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'store_management.store_email'.tr,
                  prefixIcon: const Icon(Iconsax.sms),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  filled: true,
                  fillColor: colors.surface,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name
          Text(
            store.name,
            style: AppTypography.headlineSmall(context).copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (store.description != null) ...[
            SizedBox(height: 8.h),
            Text(
              store.description!,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
              ),
            ),
          ],
          SizedBox(height: 16.h),
          // Contact info
          _buildInfoRow(Iconsax.call, store.phone, colors),
          if (store.email != null)
            _buildInfoRow(Iconsax.sms, store.email!, colors),
          _buildInfoRow(Iconsax.location, store.address, colors),
          _buildInfoRow(
            Iconsax.truck,
            'Delivery: ${store.deliveryRadiusKm.toStringAsFixed(0)} km radius',
            colors,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, dynamic colors) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: colors.textSecondary),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(dynamic store, dynamic colors) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'store_management.total_orders'.tr,
            store.totalOrders.toString(),
            Iconsax.shopping_bag,
            colors,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            'store_management.rating'.tr,
            store.rating.toStringAsFixed(1),
            Iconsax.star_1,
            colors,
            subtitle: '(${store.totalRatings} reviews)',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title, 
    String value, 
    IconData icon, 
    dynamic colors, {
    String? subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20.sp, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                title,
                style: AppTypography.labelMedium(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppTypography.headlineMedium(context).copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: AppTypography.bodySmall(context).copyWith(
                color: colors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Extended profile section (about, tagline)
  Widget _buildExtendedProfileSection(dynamic store, dynamic colors) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.info_circle, size: 20.sp, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                'store_profile.about_store'.tr,
                style: AppTypography.titleMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (_isEditing) ...[
            TextFormField(
              controller: _taglineController,
              decoration: InputDecoration(
                labelText: 'store_profile.tagline'.tr,
                hintText: 'store_profile.tagline_hint'.tr,
                prefixIcon: const Icon(Iconsax.quote_up),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                filled: true,
                fillColor: colors.background,
              ),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _aboutController,
              decoration: InputDecoration(
                labelText: 'store_profile.about'.tr,
                hintText: 'store_profile.about_hint'.tr,
                prefixIcon: const Icon(Iconsax.document_text),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                filled: true,
                fillColor: colors.background,
              ),
              maxLines: 4,
            ),
          ] else ...[
            if (store.tagline != null && store.tagline!.isNotEmpty) ...[
              Text(
                '"${store.tagline}"',
                style: AppTypography.bodyMedium(context).copyWith(
                  color: colors.primary,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 8.h),
            ],
            Text(
              store.aboutText ?? 'store_profile.no_about'.tr,
              style: AppTypography.bodyMedium(context).copyWith(
                color: store.aboutText != null ? colors.textPrimary : colors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Contact & social links section
  Widget _buildContactLinksSection(dynamic store, dynamic colors) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.link, size: 20.sp, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                'store_profile.contact_links'.tr,
                style: AppTypography.titleMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (_isEditing) ...[
            TextFormField(
              controller: _whatsappController,
              decoration: InputDecoration(
                labelText: 'WhatsApp',
                hintText: '+212 6XX XXX XXX',
                prefixIcon: const Icon(Iconsax.message),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                filled: true,
                fillColor: colors.background,
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _websiteController,
              decoration: InputDecoration(
                labelText: 'store_profile.website'.tr,
                hintText: 'https://www.example.com',
                prefixIcon: const Icon(Iconsax.global),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                filled: true,
                fillColor: colors.background,
              ),
              keyboardType: TextInputType.url,
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _facebookController,
              decoration: InputDecoration(
                labelText: 'Facebook',
                hintText: 'https://facebook.com/yourpage',
                prefixIcon: const Icon(Iconsax.link),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                filled: true,
                fillColor: colors.background,
              ),
              keyboardType: TextInputType.url,
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _instagramController,
              decoration: InputDecoration(
                labelText: 'Instagram',
                hintText: 'https://instagram.com/yourpage',
                prefixIcon: const Icon(Iconsax.camera),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                filled: true,
                fillColor: colors.background,
              ),
              keyboardType: TextInputType.url,
            ),
          ] else ...[
            if (store.whatsappNumber != null && store.whatsappNumber!.isNotEmpty)
              _buildLinkRow(Iconsax.message, 'WhatsApp', store.whatsappNumber!, colors),
            if (store.websiteUrl != null && store.websiteUrl!.isNotEmpty)
              _buildLinkRow(Iconsax.global, 'store_profile.website'.tr, store.websiteUrl!, colors),
            if (store.facebookUrl != null && store.facebookUrl!.isNotEmpty)
              _buildLinkRow(Iconsax.link, 'Facebook', 'store_profile.connected'.tr, colors),
            if (store.instagramUrl != null && store.instagramUrl!.isNotEmpty)
              _buildLinkRow(Iconsax.camera, 'Instagram', 'store_profile.connected'.tr, colors),
            if ((store.whatsappNumber == null || store.whatsappNumber!.isEmpty) &&
                (store.websiteUrl == null || store.websiteUrl!.isEmpty) &&
                (store.facebookUrl == null || store.facebookUrl!.isEmpty) &&
                (store.instagramUrl == null || store.instagramUrl!.isEmpty))
              Text(
                'store_profile.no_links'.tr,
                style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildLinkRow(IconData icon, String label, String value, dynamic colors) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: colors.primary),
          SizedBox(width: 12.w),
          Text(label, style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary)),
          const Spacer(),
          Text(value, style: AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary)),
        ],
      ),
    );
  }

  /// Service options section
  Widget _buildServiceOptionsSection(dynamic store, dynamic colors) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.setting_2, size: 20.sp, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                'store_profile.service_options'.tr,
                style: AppTypography.titleMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Service types
          Text(
            'store_profile.service_types'.tr,
            style: AppTypography.labelMedium(context).copyWith(color: colors.textSecondary),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              _buildOptionChip('store_profile.delivery'.tr, Iconsax.truck_fast, _hasDelivery, colors, 
                enabled: _isEditing, onChanged: (v) => setState(() => _hasDelivery = v)),
              SizedBox(width: 12.w),
              _buildOptionChip('store_profile.pickup'.tr, Iconsax.box, _hasPickup, colors,
                enabled: _isEditing, onChanged: (v) => setState(() => _hasPickup = v)),
            ],
          ),
          SizedBox(height: 16.h),
          // Payment methods
          Text(
            'store_profile.payment_methods'.tr,
            style: AppTypography.labelMedium(context).copyWith(color: colors.textSecondary),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              _buildOptionChip('store_profile.cash'.tr, Iconsax.money, _acceptsCash, colors,
                enabled: _isEditing, onChanged: (v) => setState(() => _acceptsCash = v)),
              SizedBox(width: 12.w),
              _buildOptionChip('store_profile.card'.tr, Iconsax.card, _acceptsCard, colors,
                enabled: _isEditing, onChanged: (v) => setState(() => _acceptsCard = v)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionChip(String label, IconData icon, bool selected, dynamic colors, {
    bool enabled = true,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: enabled ? () => onChanged(!selected) : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? colors.primary.withValues(alpha: 0.1) : colors.background,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: selected ? colors.primary : colors.border,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18.sp, color: selected ? colors.primary : colors.textSecondary),
            SizedBox(width: 8.w),
            Text(
              label,
              style: AppTypography.labelMedium(context).copyWith(
                color: selected ? colors.primary : colors.textSecondary,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Gallery section
  Widget _buildGallerySection(dynamic store, dynamic colors) {
    // Parse gallery images
    List<String> galleryImages = [];
    if (store.galleryImages != null && store.galleryImages!.isNotEmpty) {
      try {
        galleryImages = List<String>.from(jsonDecode(store.galleryImages!));
      } catch (_) {}
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.gallery, size: 20.sp, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                'store_profile.gallery'.tr,
                style: AppTypography.titleMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (_isEditing)
                TextButton.icon(
                  onPressed: _addGalleryImage,
                  icon: Icon(Iconsax.add, size: 18.sp),
                  label: Text('common.add'.tr),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          if (galleryImages.isEmpty)
            Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: colors.border, style: BorderStyle.solid),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.gallery, size: 32.sp, color: colors.textSecondary),
                  SizedBox(height: 8.h),
                  Text(
                    'store_profile.no_gallery'.tr,
                    style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            )
          else
            SizedBox(
              height: 100.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: galleryImages.length,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (context, index) => Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CachedNetworkImage(
                        imageUrl: galleryImages[index],
                        width: 100.w,
                        height: 100.h,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(color: colors.primary.withValues(alpha: 0.1)),
                        errorWidget: (_, __, ___) => Container(
                          color: colors.primary.withValues(alpha: 0.1),
                          child: Icon(Iconsax.image, color: colors.textSecondary),
                        ),
                      ),
                    ),
                    if (_isEditing)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => _removeGalleryImage(galleryImages[index]),
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: colors.error,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Iconsax.close_circle, size: 16.sp, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          SizedBox(height: 8.h),
          Text(
            'store_profile.gallery_hint'.tr,
            style: AppTypography.labelSmall(context).copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }

  Future<void> _addGalleryImage() async {
    // TODO: Implement image picker and upload
    Get.snackbar('Info', 'Image upload coming soon');
  }

  Future<void> _removeGalleryImage(String imageUrl) async {
    // TODO: Implement gallery image removal
    Get.snackbar('Info', 'Image removal coming soon');
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await _storeController.updateStoreExtended(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim().isNotEmpty 
        ? _descriptionController.text.trim() 
        : null,
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim().isNotEmpty 
        ? _emailController.text.trim() 
        : null,
      // Extended profile
      tagline: _taglineController.text.trim().isNotEmpty ? _taglineController.text.trim() : null,
      aboutText: _aboutController.text.trim().isNotEmpty ? _aboutController.text.trim() : null,
      whatsappNumber: _whatsappController.text.trim().isNotEmpty ? _whatsappController.text.trim() : null,
      websiteUrl: _websiteController.text.trim().isNotEmpty ? _websiteController.text.trim() : null,
      facebookUrl: _facebookController.text.trim().isNotEmpty ? _facebookController.text.trim() : null,
      instagramUrl: _instagramController.text.trim().isNotEmpty ? _instagramController.text.trim() : null,
      // Service options
      acceptsCash: _acceptsCash,
      acceptsCard: _acceptsCard,
      hasDelivery: _hasDelivery,
      hasPickup: _hasPickup,
    );

    if (success) {
      setState(() => _isEditing = false);
      Get.snackbar(
        'common.success'.tr,
        'store_management.update_store_success'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}
