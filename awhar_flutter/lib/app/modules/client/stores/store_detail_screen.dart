import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency_helper.dart';
import '../../../../core/controllers/auth_controller.dart';
import '../../../../screens/report_screen.dart';
import 'cart_controller.dart';
import 'cart_screen.dart';

/// Controller for store detail screen
class StoreDetailController extends GetxController {
  final int storeId;
  final _client = Get.find<Client>();

  StoreDetailController({required this.storeId});

  final Rx<Store?> store = Rx<Store?>(null);
  final RxList<StoreProduct> products = <StoreProduct>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentGalleryIndex = 0.obs;

  /// CarouselSlider controller for gallery
  final CarouselSliderController carouselController = CarouselSliderController();

  @override
  void onInit() {
    super.onInit();
    loadStoreDetails();
    loadProducts();
  }

  @override
  void onClose() {
    // CarouselSliderController doesn't need disposal
    super.onClose();
  }

  /// Parse gallery images from JSON string
  List<String> get galleryImages {
    final storeData = store.value;
    if (storeData?.galleryImages == null || storeData!.galleryImages!.isEmpty) {
      return [];
    }
    try {
      return List<String>.from(jsonDecode(storeData.galleryImages!));
    } catch (_) {
      return [];
    }
  }

  /// Get all display images (cover + gallery)
  List<String> get allImages {
    final images = <String>[];
    if (store.value?.coverImageUrl != null) {
      images.add(store.value!.coverImageUrl!);
    }
    images.addAll(galleryImages);
    return images;
  }

  /// Parse working hours from JSON
  Map<String, dynamic>? get workingHours {
    final storeData = store.value;
    if (storeData?.workingHours == null || storeData!.workingHours!.isEmpty) {
      return null;
    }
    try {
      return Map<String, dynamic>.from(jsonDecode(storeData.workingHours!));
    } catch (_) {
      return null;
    }
  }

  Future<void> loadStoreDetails() async {
    try {
      isLoading.value = true;
      store.value = await _client.store.getStoreById(storeId);

      // Set current store in cart controller for delivery zone validation
      if (store.value != null) {
        final cartController = Get.find<CartController>();
        cartController.setStore(store.value!);
      }
    } catch (e) {
      errorMessage.value = 'Failed to load store details';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadProducts() async {
    try {
      final result = await _client.storeProduct.getProducts(
        storeId: storeId,
        availableOnly: true,
      );
      products.assignAll(result);
    } catch (e) {
      errorMessage.value = 'Failed to load products';
    }
  }

  Future<void> refreshStore() async {
    await loadStoreDetails();
    await loadProducts();
  }
}

/// Store detail screen with products
class StoreDetailScreen extends StatelessWidget {
  final int storeId;

  const StoreDetailScreen({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final controller = Get.put(StoreDetailController(storeId: storeId));
    final cartController = Get.put(CartController());

    return Scaffold(
      backgroundColor: colors.background,
      body: Obx(() {
        if (controller.isLoading.value && controller.store.value == null) {
          return Center(
            child: CircularProgressIndicator(color: colors.primary),
          );
        }

        if (controller.errorMessage.value.isNotEmpty &&
            controller.store.value == null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.warning_2, size: 48.sp, color: colors.error),
                SizedBox(height: 16.h),
                Text(
                  controller.errorMessage.value,
                  style: AppTypography.bodyMedium(
                    context,
                  ).copyWith(color: colors.textSecondary),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: controller.refreshStore,
                  child: Text('common.retry'.tr),
                ),
              ],
            ),
          );
        }

        final store = controller.store.value;
        if (store == null) return const SizedBox();

        return CustomScrollView(
          slivers: [
            _buildAppBar(context, colors, store, controller),
            SliverToBoxAdapter(
              child: _buildStoreHeader(context, colors, store),
            ),
            SliverToBoxAdapter(child: _buildQuickStats(context, colors, store)),
            SliverToBoxAdapter(
              child: _buildLocationMap(context, colors, store),
            ),
            SliverToBoxAdapter(
              child: _buildAboutSection(context, colors, store),
            ),
            SliverToBoxAdapter(
              child: _buildContactSection(context, colors, store),
            ),
            SliverToBoxAdapter(
              child: _buildWorkingHoursSection(context, colors, controller),
            ),
            SliverToBoxAdapter(
              child: _buildServiceOptionsSection(context, colors, store),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 8.h),
                child: Row(
                  children: [
                    Icon(Iconsax.box, size: 18.sp, color: colors.primary),
                    SizedBox(width: 6.w),
                    Text(
                      'store_detail.products'.tr,
                      style: AppTypography.titleMedium(context).copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildProductGrid(context, colors, controller, cartController),
          ],
        );
      }),
      bottomNavigationBar: _buildCartBar(context, colors, cartController),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    dynamic colors,
    Store store,
    StoreDetailController controller,
  ) {
    final images = controller.allImages;

    return SliverAppBar(
      expandedHeight: 250.h,
      pinned: true,
      backgroundColor: colors.surface,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: colors.background.withValues(alpha: 0.8),
            shape: BoxShape.circle,
          ),
          child: Icon(Iconsax.arrow_left, color: colors.textPrimary),
        ),
      ),
      actions: [
        // Report store button
        IconButton(
          onPressed: () {
            _showReportStoreDialog(context, colors, store);
          },
          icon: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: colors.background.withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.flag, color: colors.textSecondary, size: 20.sp),
          ),
          tooltip: 'report.report_store'.tr,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Background image gallery - MUST BE FIRST
            if (images.isNotEmpty)
              CarouselSlider.builder(
                carouselController: controller.carouselController,
                itemCount: images.length,
                itemBuilder: (context, index, realIndex) => GestureDetector(
                  onTap: () {
                    print('🖼️ Gallery tapped - Image $index');
                    _showFullScreenGallery(
                      context,
                      colors,
                      images,
                      index,
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (_, __) => Container(
                      color: colors.primary.withValues(alpha: 0.2),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: colors.primary.withValues(alpha: 0.2),
                      child: Icon(
                        Iconsax.shop,
                        size: 64.sp,
                        color: colors.primary,
                      ),
                    ),
                  ),
                ),
                options: CarouselOptions(
                  height: double.infinity,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: images.length > 1,
                  autoPlay: false,
                  enlargeCenterPage: false,
                  scrollPhysics: const BouncingScrollPhysics(),
                  onPageChanged: (index, reason) {
                    print('📸 Gallery changed to index: $index (reason: $reason)');
                    controller.currentGalleryIndex.value = index;
                  },
                ),
              )
            else
              Container(
                color: colors.primary.withValues(alpha: 0.2),
                child: Icon(Iconsax.shop, size: 64.sp, color: colors.primary),
              ),
            
            // Dark overlay - DON'T block touch events
            IgnorePointer(
              child: Container(
                color: Colors.black.withValues(alpha: 0.3),
              ),
            ),
            
            // Gallery indicator dots
            if (images.length > 1)
              Positioned(
                bottom: 16.h,
                left: 0,
                right: 0,
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      images.length,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        width: controller.currentGalleryIndex.value == index
                            ? 24.w
                            : 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: controller.currentGalleryIndex.value == index
                              ? colors.primary
                              : Colors.white.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showFullScreenGallery(
    BuildContext context,
    dynamic colors,
    List<String> images,
    int initialIndex,
  ) {
    Get.to(
      () => _FullScreenGallery(
        images: images,
        initialIndex: initialIndex,
        colors: colors,
      ),
      transition: Transition.fadeIn,
    );
  }

  void _showReportStoreDialog(
    BuildContext context,
    dynamic colors,
    Store store,
  ) {
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
            Icon(Iconsax.flag, color: colors.error, size: 48.sp),
            SizedBox(height: 16.h),
            Text(
              'report.report_store'.tr,
              style: AppTypography.titleLarge(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'report.report_store_description'.tr,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  // Navigate to report screen with store info
                  // Using clientId to pass store owner ID
                  Get.to(() => ReportScreen(storeId: store.id));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.error,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'report.continue_report'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
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

  Widget _buildStoreInfo(BuildContext context, dynamic colors, Store store) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colors.border),
                ),
                child: store.logoUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(11.r),
                        child: CachedNetworkImage(
                          imageUrl: store.logoUrl!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(Iconsax.shop, color: colors.primary, size: 28.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            store.name,
                            style: AppTypography.headlineSmall(
                              context,
                            ).copyWith(color: colors.textPrimary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: store.isOpen ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            store.isOpen
                                ? 'store_browsing.open'.tr
                                : 'store_browsing.closed'.tr,
                            style: AppTypography.labelSmall(
                              context,
                            ).copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    GestureDetector(
                      onTap: () {
                        print('Store reviews tap: id=${store.id}, totalRatings=${store.totalRatings}');
                        if (store.totalRatings > 0 && store.id != null) {
                          Get.toNamed('/reviews', arguments: {
                            'revieweeType': 'store',
                            'revieweeId': store.id!,
                            'revieweeName': store.name,
                            'initialRating': store.rating,
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Iconsax.star_1, size: 16.sp, color: Colors.amber),
                          SizedBox(width: 4.w),
                          Text(
                            store.rating.toStringAsFixed(1),
                            style: AppTypography.titleSmall(context).copyWith(
                              color: colors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '(${store.totalRatings} ${'store_detail.reviews'.tr})',
                            style: AppTypography.labelSmall(
                              context,
                            ).copyWith(
                              color: colors.primary,
                              decoration: store.totalRatings > 0
                                  ? TextDecoration.underline
                                  : null,
                            ),
                          ),
                          if (store.totalRatings > 0) ...[
                            SizedBox(width: 4.w),
                            Icon(Icons.chevron_right,
                                size: 16.sp, color: colors.primary),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (store.description != null) ...[
            SizedBox(height: 12.h),
            Text(
              store.description!,
              style: AppTypography.bodyMedium(
                context,
              ).copyWith(color: colors.textSecondary),
            ),
          ],
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(
                  context,
                  colors,
                  Iconsax.location,
                  'store_detail.delivery_zone'.tr,
                  '${store.deliveryRadiusKm.toStringAsFixed(1)} km',
                ),
                Container(width: 1, height: 30.h, color: colors.border),
                _buildInfoItem(
                  context,
                  colors,
                  Iconsax.clock,
                  'store_detail.min_order'.tr,
                  CurrencyHelper.format(store.minimumOrderAmount ?? 0),
                ),
                Container(width: 1, height: 30.h, color: colors.border),
                _buildInfoItem(
                  context,
                  colors,
                  Iconsax.truck_fast,
                  'store_detail.delivery'.tr,
                  'store_detail.from_10'.tr,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    dynamic colors,
    IconData icon,
    String label,
    String value,
  ) {
    return Column(
      children: [
        Icon(icon, size: 20.sp, color: colors.primary),
        SizedBox(height: 4.h),
        Text(
          value,
          style: AppTypography.titleSmall(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: AppTypography.labelSmall(
            context,
          ).copyWith(color: colors.textSecondary),
        ),
      ],
    );
  }

  /// About section with tagline and bio
  Widget _buildAboutSection(BuildContext context, dynamic colors, Store store) {
    final hasAbout = store.aboutText != null && store.aboutText!.isNotEmpty;

    if (!hasAbout) return const SizedBox();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.document_text, size: 16.sp, color: colors.primary),
              SizedBox(width: 6.w),
              Text(
                'store_detail.about'.tr,
                style: AppTypography.titleMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            store.aboutText!,
            style: AppTypography.bodyMedium(context).copyWith(
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  /// Contact section with phone, whatsapp, social links
  Widget _buildContactSection(
    BuildContext context,
    dynamic colors,
    Store store,
  ) {
    final hasPhone = store.phone != null && store.phone!.isNotEmpty;
    final hasWhatsapp =
        store.whatsappNumber != null && store.whatsappNumber!.isNotEmpty;
    final hasWebsite = store.websiteUrl != null && store.websiteUrl!.isNotEmpty;
    final hasFacebook =
        store.facebookUrl != null && store.facebookUrl!.isNotEmpty;
    final hasInstagram =
        store.instagramUrl != null && store.instagramUrl!.isNotEmpty;

    if (!hasPhone &&
        !hasWhatsapp &&
        !hasWebsite &&
        !hasFacebook &&
        !hasInstagram) {
      return const SizedBox();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.call_calling, size: 16.sp, color: colors.primary),
              SizedBox(width: 6.w),
              Text(
                'store_detail.contact'.tr,
                style: AppTypography.titleMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: [
              // In-app chat button (always visible)
              _buildModernContactChip(
                context,
                colors,
                icon: Iconsax.messages_1,
                label: 'store_detail.chat'.tr,
                color: Colors.teal,
                onTap: () => _openStoreChat(context, colors, store),
              ),
              if (hasPhone)
                _buildModernContactChip(
                  context,
                  colors,
                  icon: Iconsax.call,
                  label: 'store_detail.call'.tr,
                  color: colors.primary,
                  onTap: () => _launchUrl('tel:${store.phone}'),
                ),
              if (hasWhatsapp)
                _buildModernContactChip(
                  context,
                  colors,
                  icon: Iconsax.message,
                  label: 'WhatsApp',
                  color: colors.primary,
                  onTap: () =>
                      _launchUrl('https://wa.me/${store.whatsappNumber}'),
                ),
              if (hasWebsite)
                _buildModernContactChip(
                  context,
                  colors,
                  icon: Iconsax.global,
                  label: 'store_detail.website'.tr,
                  color: colors.primary,
                  onTap: () => _launchUrl(store.websiteUrl!),
                ),
              if (hasFacebook)
                _buildModernContactChip(
                  context,
                  colors,
                  icon: Iconsax.link,
                  label: 'Facebook',
                  color: colors.primary,
                  onTap: () => _launchUrl(store.facebookUrl!),
                ),
              if (hasInstagram)
                _buildModernContactChip(
                  context,
                  colors,
                  icon: Iconsax.camera,
                  label: 'Instagram',
                  color: colors.primary,
                  onTap: () => _launchUrl(store.instagramUrl!),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernContactChip(
    BuildContext context,
    dynamic colors, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: colors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14.sp, color: colors.primary),
            SizedBox(width: 4.w),
            Text(
              label,
              style: AppTypography.labelSmall(context).copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactChip(
    BuildContext context,
    dynamic colors, {
    required IconData icon,
    required String label,
    Color? color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: (color ?? colors.primary).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: (color ?? colors.primary).withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16.sp, color: color ?? colors.primary),
            SizedBox(width: 6.w),
            Text(
              label,
              style: AppTypography.labelMedium(context).copyWith(
                color: color ?? colors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      Get.snackbar('Error', 'Could not open link');
    }
  }

  /// Open chat with store - opens direct chat with store owner
  Future<void> _openStoreChat(
    BuildContext context,
    dynamic colors,
    Store store,
  ) async {
    try {
      final authController = Get.find<AuthController>();
      final userId = authController.currentUser.value?.id;

      if (userId == null) {
        Get.snackbar(
          'Login Required',
          'Please login to chat with the store',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Open direct chat with store owner
      // Using DirectChatScreen which supports client-to-peer messaging
      // Pass store owner info as DriverProfile (reusing existing structure)
      Get.toNamed(
        '/direct-chat',
        arguments: DriverProfile(
          userId: store.userId,
          displayName: store.name,
          profilePhotoUrl: store.logoUrl,
        ),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not open chat. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Show dialog when no active order exists
  void _showNoActiveOrderDialog(
    BuildContext context,
    dynamic colors,
    Store store,
  ) {
    final hasPhone = store.phone != null && store.phone!.isNotEmpty;
    final hasWhatsapp =
        store.whatsappNumber != null && store.whatsappNumber!.isNotEmpty;

    Get.dialog(
      AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(Iconsax.message_question, color: colors.primary),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'store_detail.no_active_order'.tr,
                style: AppTypography.titleMedium(context).copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'store_detail.chat_after_order'.tr,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary,
              ),
            ),
            if (hasPhone || hasWhatsapp) ...[
              SizedBox(height: 16.h),
              Text(
                'store_detail.contact_external'.tr,
                style: AppTypography.bodySmall(context).copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
          ],
        ),
        actions: [
          if (hasWhatsapp)
            TextButton.icon(
              onPressed: () {
                Get.back();
                _launchUrl('https://wa.me/${store.whatsappNumber}');
              },
              icon: Icon(Iconsax.message, color: Colors.green),
              label: Text(
                'WhatsApp',
                style: TextStyle(color: Colors.green),
              ),
            ),
          if (hasPhone)
            TextButton.icon(
              onPressed: () {
                Get.back();
                _launchUrl('tel:${store.phone}');
              },
              icon: Icon(Iconsax.call, color: colors.primary),
              label: Text(
                'store_detail.call'.tr,
                style: TextStyle(color: colors.primary),
              ),
            ),
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'common.close'.tr,
              style: TextStyle(color: colors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  /// Working hours section
  Widget _buildWorkingHoursSection(
    BuildContext context,
    dynamic colors,
    StoreDetailController controller,
  ) {
    final workingHours = controller.workingHours;
    if (workingHours == null) return const SizedBox();

    final dayNames = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday',
    ];
    final dayLabels = {
      'monday': 'store_detail.monday'.tr,
      'tuesday': 'store_detail.tuesday'.tr,
      'wednesday': 'store_detail.wednesday'.tr,
      'thursday': 'store_detail.thursday'.tr,
      'friday': 'store_detail.friday'.tr,
      'saturday': 'store_detail.saturday'.tr,
      'sunday': 'store_detail.sunday'.tr,
    };

    // Get current day
    final now = DateTime.now();
    final currentDay = dayNames[now.weekday - 1];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.clock, size: 16.sp, color: colors.primary),
              SizedBox(width: 6.w),
              Text(
                'store_detail.working_hours'.tr,
                style: AppTypography.titleSmall(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          ...dayNames.map((day) {
            final dayHours = workingHours[day];
            final isToday = day == currentDay;
            final isClosed = dayHours == null || dayHours['closed'] == true;

            return Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Row(
                children: [
                  SizedBox(
                    width: 80.w,
                    child: Text(
                      dayLabels[day] ?? day,
                      style: AppTypography.bodySmall(context).copyWith(
                        color: isToday ? colors.primary : colors.textPrimary,
                        fontWeight: isToday
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      isClosed
                          ? 'store_detail.closed'.tr
                          : '${dayHours['open'] ?? '09:00'} - ${dayHours['close'] ?? '18:00'}',
                      style: AppTypography.bodySmall(context).copyWith(
                        color: isClosed ? colors.error : colors.textSecondary,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Service options section (delivery, pickup, payment methods)
  Widget _buildServiceOptionsSection(
    BuildContext context,
    dynamic colors,
    Store store,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.verify, size: 16.sp, color: colors.primary),
              SizedBox(width: 6.w),
              Text(
                'store_detail.services'.tr,
                style: AppTypography.titleSmall(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: [
              if (store.hasDelivery == true)
                _buildModernServiceBadge(
                  context,
                  colors,
                  Iconsax.truck_fast,
                  'store_detail.delivery'.tr,
                  colors.primary,
                ),
              if (store.hasPickup == true)
                _buildModernServiceBadge(
                  context,
                  colors,
                  Iconsax.box,
                  'store_detail.pickup'.tr,
                  colors.primary,
                ),
              if (store.acceptsCash == true)
                _buildModernServiceBadge(
                  context,
                  colors,
                  Iconsax.money,
                  'store_detail.cash'.tr,
                  colors.primary,
                ),
              if (store.acceptsCard == true)
                _buildModernServiceBadge(
                  context,
                  colors,
                  Iconsax.card,
                  'store_detail.card'.tr,
                  colors.primary,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernServiceBadge(
    BuildContext context,
    dynamic colors,
    IconData icon,
    String label,
    Color accentColor,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: colors.primary),
          SizedBox(width: 4.w),
          Text(
            label,
            style: AppTypography.labelSmall(context).copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(
    BuildContext context,
    dynamic colors,
    StoreDetailController controller,
    CartController cartController,
  ) {
    return Obx(() {
      if (controller.products.isEmpty) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(32.w),
            child: Center(
              child: Column(
                children: [
                  Icon(Iconsax.box, size: 64.sp, color: colors.textSecondary),
                  SizedBox(height: 16.h),
                  Text(
                    'store_detail.no_products'.tr,
                    style: AppTypography.bodyMedium(
                      context,
                    ).copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      return SliverPadding(
        padding: EdgeInsets.all(12.w),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w,
            childAspectRatio: 0.75,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildProductCard(
              context,
              colors,
              controller.products[index],
              cartController,
            ),
            childCount: controller.products.length,
          ),
        ),
      );
    });
  }

  Widget _buildProductCard(
    BuildContext context,
    dynamic colors,
    StoreProduct product,
    CartController cartController,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (_, __) => Container(
                  color: colors.primary.withValues(alpha: 0.1),
                  child: Icon(Iconsax.box, color: colors.primary),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: colors.primary.withValues(alpha: 0.1),
                  child: Icon(Iconsax.box, color: colors.primary),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTypography.titleSmall(context).copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: Text(
                      product.description ?? '',
                      style: AppTypography.labelSmall(
                        context,
                      ).copyWith(color: colors.textSecondary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        CurrencyHelper.format(product.price),
                        style: AppTypography.titleSmall(context).copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Obx(() {
                        final quantity = cartController.getItemQuantity(
                          product.id!,
                        );
                        if (quantity > 0) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: colors.primary,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              '$quantity',
                              style: AppTypography.labelSmall(
                                context,
                              ).copyWith(color: Colors.white),
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: product.isAvailable
                              ? () => cartController.addItem(product)
                              : null,
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              color: product.isAvailable
                                  ? colors.primary
                                  : colors.textSecondary,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Iconsax.add,
                              color: Colors.white,
                              size: 16.sp,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartBar(
    BuildContext context,
    dynamic colors,
    CartController cartController,
  ) {
    return Obx(() {
      if (cartController.items.isEmpty) return const SizedBox();

      return Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(top: BorderSide(color: colors.border)),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.shopping_cart, color: colors.primary),
                    SizedBox(width: 8.w),
                    Text(
                      '${cartController.totalItems}',
                      style: AppTypography.titleSmall(context).copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'store_detail.total'.tr,
                      style: AppTypography.labelSmall(
                        context,
                      ).copyWith(color: colors.textSecondary),
                    ),
                    Text(
                      CurrencyHelper.format(cartController.subtotal),
                      style: AppTypography.titleSmall(context).copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => const CartScreen()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                ),
                child: Text('store_detail.view_cart'.tr),
              ),
            ],
          ),
        ),
      );
    });
  }
}

/// Full screen gallery viewer
Widget _buildStoreHeader(BuildContext context, dynamic colors, Store store) {
  final tagline = store.tagline?.isNotEmpty == true
      ? store.tagline!
      : store.description ?? '';

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
    padding: EdgeInsets.all(12.w),
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
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: colors.border),
              ),
              child: store.logoUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: CachedNetworkImage(
                        imageUrl: store.logoUrl!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(Iconsax.shop, color: colors.primary, size: 32.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.name,
                    style: AppTypography.titleMedium(context).copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: store.isOpen ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              store.isOpen
                                  ? 'store_browsing.open'.tr
                                  : 'store_browsing.closed'.tr,
                              style: AppTypography.labelMedium(context)
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 6.w),
                      GestureDetector(
                        onTap: store.totalRatings > 0 && store.id != null
                            ? () {
                                Get.toNamed('/reviews', arguments: {
                                  'revieweeType': 'store',
                                  'revieweeId': store.id!,
                                  'revieweeName': store.name,
                                  'initialRating': store.rating,
                                });
                              }
                            : null,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: colors.surface,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: colors.border),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Iconsax.star_1,
                                size: 12.sp,
                                color: colors.primary,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                store.rating.toStringAsFixed(1),
                                style: AppTypography.labelMedium(context)
                                    .copyWith(
                                      color: colors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              if (store.totalRatings > 0) ...[
                                SizedBox(width: 2.w),
                                Icon(
                                  Icons.chevron_right,
                                  size: 14.sp,
                                  color: colors.primary,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        if (tagline.isNotEmpty) ...[
          SizedBox(height: 6.h),
          Text(
            tagline,
            style: AppTypography.bodyMedium(context).copyWith(
              color: colors.textSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    ),
  );
}

Widget _buildQuickStats(BuildContext context, dynamic colors, Store store) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
    child: Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: store.totalRatings > 0 && store.id != null
                ? () {
                    Get.toNamed('/reviews', arguments: {
                      'revieweeType': 'store',
                      'revieweeId': store.id!,
                      'revieweeName': store.name,
                      'initialRating': store.rating,
                    });
                  }
                : null,
            child: _buildStatCard(
              context,
              colors,
              Iconsax.star_1,
              '${store.totalRatings}',
              'store_detail.reviews'.tr,
              Color(0xFFF59E0B),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            context,
            colors,
            Iconsax.truck_fast,
            '${store.deliveryRadiusKm.toStringAsFixed(0)}km',
            'store_detail.delivery_zone'.tr,
            Color(0xFF10B981),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStatCard(
  BuildContext context,
  dynamic colors,
  IconData icon,
  String value,
  String label,
  Color accentColor,
) {
  return Container(
    padding: EdgeInsets.all(8.w),
    decoration: BoxDecoration(
      color: colors.surface,
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(color: colors.border),
    ),
    child: Column(
      children: [
        Icon(icon, size: 18.sp, color: colors.primary),
        SizedBox(height: 4.h),
        Text(
          value,
          style: AppTypography.titleSmall(context).copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: AppTypography.labelSmall(context).copyWith(
            color: colors.textSecondary,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget _buildLocationMap(BuildContext context, dynamic colors, Store store) {
  if (store.latitude == null || store.longitude == null)
    return SizedBox.shrink();

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
    decoration: BoxDecoration(
      color: colors.surface,
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(color: colors.border),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              Icon(Iconsax.location, size: 16.sp, color: colors.primary),
              SizedBox(width: 6.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'store_detail.location'.tr,
                      style: AppTypography.titleSmall(context).copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (store.address != null) ...[
                      Text(
                        store.address!,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: colors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => _showFullMap(context, colors, store),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
                child: SizedBox(
                  height: 180.h,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(store.latitude!, store.longitude!),
                      zoom: 15,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('store'),
                        position: LatLng(store.latitude!, store.longitude!),
                        infoWindow: InfoWindow(title: store.name),
                      ),
                    },
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    myLocationButtonEnabled: false,
                    liteModeEnabled: true,
                  ),
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Iconsax.maximize_4,
                        size: 14.sp,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'store_detail.view_full_map'.tr,
                        style: AppTypography.labelSmall(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void _showFullMap(BuildContext context, dynamic colors, Store store) {
  Get.to(
    () => _FullMapView(store: store, colors: colors),
    transition: Transition.fadeIn,
  );
}

class _FullScreenGallery extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  final dynamic colors;

  const _FullScreenGallery({
    required this.images,
    required this.initialIndex,
    required this.colors,
  });

  @override
  State<_FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<_FullScreenGallery> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
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
          onPressed: () => Get.back(),
          icon: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.close_circle, color: Colors.white, size: 24.sp),
          ),
        ),
        title: Text(
          '${_currentIndex + 1} / ${widget.images.length}',
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        itemBuilder: (context, index) => InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Center(
            child: CachedNetworkImage(
              imageUrl: widget.images[index],
              fit: BoxFit.contain,
              placeholder: (_, __) =>
                  CircularProgressIndicator(color: widget.colors.primary),
              errorWidget: (_, __, ___) => Icon(
                Iconsax.image,
                size: 64.sp,
                color: Colors.white54,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FullMapView extends StatelessWidget {
  final Store store;
  final dynamic colors;

  const _FullMapView({required this.store, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(store.latitude!, store.longitude!),
              zoom: 16,
            ),
            markers: {
              Marker(
                markerId: MarkerId('store'),
                position: LatLng(store.latitude!, store.longitude!),
                infoWindow: InfoWindow(
                  title: store.name,
                  snippet: store.address ?? '',
                ),
              ),
            },
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            mapToolbarEnabled: true,
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 16.h,
            left: 16.w,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Iconsax.arrow_left_2,
                  color: Colors.black,
                  size: 24.sp,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 24.h,
            left: 16.w,
            right: 16.w,
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50.w,
                        height: 50.w,
                        decoration: BoxDecoration(
                          color: colors.background,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: colors.border),
                        ),
                        child: store.logoUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(11.r),
                                child: CachedNetworkImage(
                                  imageUrl: store.logoUrl!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(
                                Iconsax.shop,
                                color: colors.primary,
                                size: 24.sp,
                              ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              store.name,
                              style: AppTypography.titleLarge(context).copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (store.address != null) ...[
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.location,
                                    size: 14.sp,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: Text(
                                      store.address!,
                                      style: AppTypography.bodySmall(
                                        context,
                                      ).copyWith(color: Colors.grey),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final url =
                                'https://www.google.com/maps/dir/?api=1&destination=${store.latitude},${store.longitude}';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(
                                Uri.parse(url),
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                          icon: Icon(Iconsax.routing, size: 20.sp),
                          label: Text('store_detail.get_directions'.tr),
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
                      if (store.phone != null) ...[
                        SizedBox(width: 12.w),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: IconButton(
                            onPressed: () async {
                              final url = 'tel:${store.phone}';
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url));
                              }
                            },
                            icon: Icon(
                              Iconsax.call,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                            padding: EdgeInsets.all(14.w),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
