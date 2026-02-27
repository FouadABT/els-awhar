import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/auth_controller.dart';

/// Store Review Screen
/// Allows clients to leave a review for a store after order delivery
class StoreReviewScreen extends StatefulWidget {
  final int storeId;
  final int orderId;
  final String storeName;

  const StoreReviewScreen({
    super.key,
    required this.storeId,
    required this.orderId,
    required this.storeName,
  });

  @override
  State<StoreReviewScreen> createState() => _StoreReviewScreenState();
}

class _StoreReviewScreenState extends State<StoreReviewScreen> {
  late final Client _client;
  late final AuthController _auth;

  final RxBool _isSubmitting = false.obs;
  final TextEditingController _commentController = TextEditingController();
  int _rating = 5;
  int _foodQualityRating = 5;
  int _packagingRating = 5;

  @override
  void initState() {
    super.initState();
    _client = Get.find<Client>();
    _auth = Get.find<AuthController>();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    final userId = _auth.currentUser.value?.id;
    if (userId == null) {
      Get.snackbar('Error', 'You must be signed in');
      return;
    }

    try {
      _isSubmitting.value = true;
      final review = await _client.storeReview.createStoreReview(
        orderId: widget.orderId,
        storeId: widget.storeId,
        clientId: userId,
        rating: _rating,
        comment: _commentController.text.trim().isNotEmpty
            ? _commentController.text.trim()
            : null,
        foodQualityRating: _foodQualityRating,
        packagingRating: _packagingRating,
      );

      if (review != null) {
        Get.back();
        Get.snackbar(
          'review.success_title'.tr,
          'review.success_message'.tr,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar('review.error_title'.tr, 'review.error_message'.tr);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _isSubmitting.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(
          'review.rate_store'.tr,
          style: AppTypography.titleMedium(context)
              .copyWith(color: colors.textPrimary),
        ),
        backgroundColor: colors.surface,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Store name
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40.r,
                    backgroundColor: colors.primary.withOpacity(0.1),
                    child: Icon(Iconsax.shop,
                        size: 40.sp, color: colors.primary),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    widget.storeName,
                    style: AppTypography.headlineMedium(context)
                        .copyWith(color: colors.textPrimary),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'review.how_was_experience'.tr,
                    style: AppTypography.bodyMedium(context)
                        .copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Overall rating
            _buildRatingSection(
              context,
              colors,
              'review.overall_rating'.tr,
              _rating,
              (val) => setState(() => _rating = val),
            ),
            SizedBox(height: 16.h),

            // Food quality rating
            _buildRatingSection(
              context,
              colors,
              'review.food_quality'.tr,
              _foodQualityRating,
              (val) => setState(() => _foodQualityRating = val),
            ),
            SizedBox(height: 16.h),

            // Packaging rating
            _buildRatingSection(
              context,
              colors,
              'review.packaging'.tr,
              _packagingRating,
              (val) => setState(() => _packagingRating = val),
            ),
            SizedBox(height: 24.h),

            // Comment
            Text(
              'review.comment'.tr,
              style: AppTypography.labelLarge(context)
                  .copyWith(color: colors.textSecondary),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'review.comment_hint'.tr,
              ),
            ),
            SizedBox(height: 24.h),

            // Submit button
            Obx(() => SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton.icon(
                    onPressed: _isSubmitting.value ? null : _submitReview,
                    icon: _isSubmitting.value
                        ? SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Icon(Iconsax.tick_circle),
                    label: Text(_isSubmitting.value
                        ? 'review.submitting'.tr
                        : 'review.submit'.tr),
                  ),
                )),
            SizedBox(height: 12.h),

            // Skip button
            Center(
              child: TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'review.skip'.tr,
                  style: TextStyle(color: colors.textSecondary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingSection(
    BuildContext context,
    dynamic colors,
    String label,
    int currentRating,
    Function(int) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelLarge(context)
              .copyWith(color: colors.textSecondary),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            final starIndex = index + 1;
            return GestureDetector(
              onTap: () => onChanged(starIndex),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Icon(
                  starIndex <= currentRating
                      ? Iconsax.star_1
                      : Iconsax.star,
                  size: 36.sp,
                  color: starIndex <= currentRating
                      ? Colors.amber
                      : colors.textSecondary.withOpacity(0.3),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
