import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

/// Controller for reviews screen
class ReviewsController extends GetxController {
  final Client _client = Get.find<Client>();
  
  final String revieweeType; // 'store', 'driver', or 'client'
  final int revieweeId;
  final String revieweeName;
  final double? initialRating;
  
  ReviewsController({
    required this.revieweeType,
    required this.revieweeId,
    required this.revieweeName,
    this.initialRating,
  });
  
  final RxList<ReviewWithReviewer> reviews = <ReviewWithReviewer>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxDouble averageRating = 0.0.obs;
  final RxMap<int, int> ratingDistribution = <int, int>{}.obs;
  
  @override
  void onInit() {
    super.onInit();
    if (initialRating != null) {
      averageRating.value = initialRating!;
    }
    loadReviews();
  }
  
  Future<void> loadReviews() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      reviews.value = await _client.storeReview.getReviewsForReviewee(
        revieweeType: revieweeType,
        revieweeId: revieweeId,
        offset: 0,
      );
      
      if (reviews.isNotEmpty) {
        _calculateStatistics();
      }
    } catch (e) {
      errorMessage.value = 'reviews.load_error'.tr;
      print('Error loading reviews: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  void _calculateStatistics() {
    // Calculate average rating
    final total = reviews.fold<double>(0, (sum, review) => sum + review.rating);
    averageRating.value = total / reviews.length;
    
    // Calculate rating distribution
    ratingDistribution.value = {
      5: reviews.where((r) => r.rating == 5).length,
      4: reviews.where((r) => r.rating == 4).length,
      3: reviews.where((r) => r.rating == 3).length,
      2: reviews.where((r) => r.rating == 2).length,
      1: reviews.where((r) => r.rating == 1).length,
    };
  }
}

/// Screen displaying all reviews for a store, driver, or client
class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    
    // Get parameters from arguments safely
    final args = Get.arguments as Map<String, dynamic>?;
    
    if (args == null || args['revieweeId'] == null) {
      return Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          backgroundColor: colors.surface,
          title: Text('reviews.title'.tr),
        ),
        body: Center(
          child: Text(
            'reviews.invalid_arguments'.tr,
            style: AppTypography.bodyLarge(context).copyWith(
              color: colors.textSecondary,
            ),
          ),
        ),
      );
    }
    
    final controller = Get.put(
      ReviewsController(
        revieweeType: args['revieweeType'] ?? 'store',
        revieweeId: args['revieweeId'] as int,
        revieweeName: args['revieweeName'] ?? '',
        initialRating: args['initialRating'] as double?,
      ),
      tag: '${args['revieweeType']}_${args['revieweeId']}',
    );
    
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
          'reviews.title'.tr,
          style: AppTypography.headlineLarge(context).copyWith(
            color: colors.textPrimary,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: colors.primary),
          );
        }
        
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.emoji_sad, size: 64.sp, color: colors.textSecondary),
                SizedBox(height: 16.h),
                Text(
                  controller.errorMessage.value,
                  style: AppTypography.bodyLarge(context).copyWith(
                    color: colors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: controller.loadReviews,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('reviews.retry'.tr),
                ),
              ],
            ),
          );
        }
        
        if (controller.reviews.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.star, size: 64.sp, color: colors.textSecondary),
                SizedBox(height: 16.h),
                Text(
                  'reviews.no_reviews'.tr,
                  style: AppTypography.bodyLarge(context).copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }
        
        return CustomScrollView(
          slivers: [
            // Rating Summary Header
            SliverToBoxAdapter(
              child: _buildRatingSummary(context, colors, controller),
            ),
            
            // Reviews List
            SliverPadding(
              padding: EdgeInsets.all(16.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final review = controller.reviews[index];
                    return _buildReviewCard(context, colors, review, controller);
                  },
                  childCount: controller.reviews.length,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
  
  Widget _buildRatingSummary(BuildContext context, AppColorScheme colors, ReviewsController controller) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Entity name
          Text(
            controller.revieweeName,
            style: AppTypography.headlineLarge(context).copyWith(
              color: colors.textPrimary,
              fontSize: 24.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          
          Row(
            children: [
              // Average Rating
              Expanded(
                child: Column(
                  children: [
                    Text(
                      controller.averageRating.value.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 48.sp,
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (index) {
                          return Icon(
                            index < controller.averageRating.value.round()
                                ? Iconsax.star_1
                                : Iconsax.star,
                            size: 18.sp,
                            color: Colors.amber,
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${controller.reviews.length} ${'reviews.total_reviews'.tr}',
                      style: AppTypography.labelMedium(context).copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(width: 20.w),
              
              // Rating Distribution
              Expanded(
                flex: 2,
                child: Column(
                  children: List.generate(5, (index) {
                    final rating = 5 - index;
                    final count = controller.ratingDistribution[rating] ?? 0;
                    final total = controller.reviews.length;
                    final percentage = total > 0 ? (count / total) : 0.0;
                    
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Row(
                        children: [
                          Text(
                            '$rating',
                            style: AppTypography.labelSmall(context).copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(Iconsax.star_1, size: 12.sp, color: Colors.amber),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3.r),
                              child: LinearProgressIndicator(
                                value: percentage,
                                backgroundColor: colors.border,
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                                minHeight: 6.h,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          SizedBox(
                            width: 20.w,
                            child: Text(
                              '$count',
                              style: AppTypography.labelSmall(context).copyWith(
                                color: colors.textSecondary,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildReviewCard(BuildContext context, AppColorScheme colors, ReviewWithReviewer review, ReviewsController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
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
              // Reviewer Avatar with real photo
              if (review.reviewerPhotoUrl != null)
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage: CachedNetworkImageProvider(review.reviewerPhotoUrl!),
                  backgroundColor: colors.primary.withOpacity(0.1),
                )
              else
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: colors.primary.withOpacity(0.1),
                  child: Icon(
                    Iconsax.user,
                    size: 20.sp,
                    color: colors.primary,
                  ),
                ),
              SizedBox(width: 12.w),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewerName ?? 'reviews.anonymous_user'.tr,
                      style: AppTypography.titleSmall(context).copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      timeago.format(review.createdAt, locale: Get.locale?.languageCode ?? 'en'),
                      style: AppTypography.labelSmall(context).copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(width: 8.w),
              
              // Rating badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getRatingColor(review.rating).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Iconsax.star_1,
                      size: 14.sp,
                      color: _getRatingColor(review.rating),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      review.rating.toString(),
                      style: AppTypography.labelMedium(context).copyWith(
                        color: _getRatingColor(review.rating),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          if (review.comment != null && review.comment!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text(
              review.comment!,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textPrimary,
              ),
            ),
          ],
          
          // Response from owner/store
          if (review.response != null && review.response!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: colors.primary.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Iconsax.message_text,
                        size: 16.sp,
                        color: colors.primary,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'reviews.response'.tr,
                        style: AppTypography.labelMedium(context).copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    review.response!,
                    style: AppTypography.bodySmall(context).copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  Color _getRatingColor(int rating) {
    if (rating >= 4) return Colors.green;
    if (rating == 3) return Colors.orange;
    return Colors.red;
  }
}
