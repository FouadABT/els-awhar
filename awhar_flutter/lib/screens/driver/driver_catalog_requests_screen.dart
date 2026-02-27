import 'package:awhar_client/awhar_client.dart';
import 'package:awhar_flutter/core/controllers/auth_controller.dart';
import 'package:awhar_flutter/core/controllers/request_controller.dart';
import 'package:awhar_flutter/core/theme/app_colors.dart';
import 'package:awhar_flutter/core/theme/app_typography.dart';
import 'package:awhar_flutter/core/utils/currency_helper.dart';
import 'package:awhar_flutter/screens/driver/catalog_request_detail_screen.dart';
import 'package:awhar_flutter/core/services/trust_score_service.dart';
import 'package:awhar_flutter/shared/widgets/trust_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

/// Screen for drivers to view catalog requests (requests from their service listings)
class DriverCatalogRequestsScreen extends StatefulWidget {
  const DriverCatalogRequestsScreen({super.key});

  @override
  State<DriverCatalogRequestsScreen> createState() =>
      _DriverCatalogRequestsScreenState();
}

class _DriverCatalogRequestsScreenState
    extends State<DriverCatalogRequestsScreen> {
  final RequestController controller = Get.find<RequestController>();
  final RxList<ServiceRequest> catalogRequests = <ServiceRequest>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCatalogRequests();
    });
  }

  Future<void> _loadCatalogRequests() async {
    isLoading.value = true;
    try {
      // Get the current user's ID (this is the User ID, not DriverProfile ID)
      final authController = Get.find<AuthController>();
      final userId = authController.currentUser.value?.id;
      
      print('[CatalogRequests] 🔍 DEBUG: currentUser = ${authController.currentUser.value?.fullName}');
      print('[CatalogRequests] 🔍 DEBUG: userId = $userId');
      print('[CatalogRequests] 🔍 DEBUG: email = ${authController.currentUser.value?.email}');
      
      if (userId == null) {
        print('[CatalogRequests] ❌ Error: User ID not found');
        Get.snackbar(
          'common.error'.tr,
          'Driver information not available',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Load ALL pending requests (no filter for testing)
      // This includes both catalog requests AND general concierge requests
      print('[CatalogRequests] 📡 Calling getAllPendingRequests');
      final client = Get.find<Client>();
      final requests = await client.request.getAllPendingRequests();
      
      catalogRequests.value = requests;
      print('[CatalogRequests] ✅ Loaded ${requests.length} pending requests');
      for (final req in requests) {
        print('[CatalogRequests]   📋 Request #${req.id}: ${req.clientName}, ${req.serviceType}');
      }
    } catch (e) {
      print('[CatalogRequests] ❌ Error loading: $e');
      Get.snackbar(
        'common.error'.tr,
        'Failed to load catalog requests',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
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
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'driver.catalog_requests'.tr,
          style: AppTypography.headlineMedium(context).copyWith(color: colors.textPrimary),
        ),
        actions: [
          IconButton(
            icon: Icon(Iconsax.refresh, color: colors.textPrimary),
            onPressed: _loadCatalogRequests,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadCatalogRequests,
        child: Obx(() {
          if (isLoading.value && catalogRequests.isEmpty) {
            return Center(
              child: CircularProgressIndicator(color: colors.primary),
            );
          }

          if (catalogRequests.isEmpty) {
            return _buildEmptyState(colors);
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: catalogRequests.length,
            itemBuilder: (context, index) {
              final request = catalogRequests[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to detail screen
                  Get.to(
                    () => CatalogRequestDetailScreen(request: request),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 300),
                  );
                },
                child: _CatalogRequestCard(
                  request: request,
                  colors: colors,
                  onAccept: () => _acceptRequest(request),
                  onReject: () => _rejectRequest(request),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildEmptyState(AppColorScheme colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.document_text_1,
            size: 80.sp,
            color: colors.textSecondary.withOpacity(0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            'driver.no_catalog_requests'.tr,
            style: AppTypography.headlineSmall(context).copyWith(color: colors.textSecondary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'driver.catalog_requests_hint'.tr,
            style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary.withOpacity(0.7)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _acceptRequest(ServiceRequest request) async {
    // Show confirmation dialog
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: Text('driver.accept_catalog_request'.tr),
        content: Text('driver.accept_catalog_request_confirm'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('common.cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: Text('common.accept'.tr),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      isLoading.value = true;
      await controller.acceptRequest(request.id!);
      
      catalogRequests.removeWhere((r) => r.id == request.id);
      
      Get.snackbar(
        'common.success'.tr,
        'driver.catalog_request_accepted'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );

      // Navigate to active request screen - pass the full request object
      Get.toNamed('/driver/active-request', arguments: request);
    } catch (e) {
      print('[CatalogRequests] Error accepting: $e');
      Get.snackbar(
        'common.error'.tr,
        'driver.catalog_request_accept_error'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _rejectRequest(ServiceRequest request) async {
    // Show confirmation dialog
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: Text('driver.reject_catalog_request'.tr),
        content: Text('driver.reject_catalog_request_confirm'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('common.cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('common.reject'.tr, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      isLoading.value = true;
      // TODO: Add reject endpoint in backend
      // For now, just remove from list
      catalogRequests.removeWhere((r) => r.id == request.id);
      
      Get.snackbar(
        'common.success'.tr,
        'driver.catalog_request_rejected'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    } catch (e) {
      print('[CatalogRequests] Error rejecting: $e');
      Get.snackbar(
        'common.error'.tr,
        'driver.catalog_request_reject_error'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

/// Card widget for catalog request
class _CatalogRequestCard extends StatelessWidget {
  final ServiceRequest request;
  final AppColorScheme colors;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const _CatalogRequestCard({
    required this.request,
    required this.colors,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final serviceType = request.serviceType.toString().split('.').last;
    final price = request.clientOfferedPrice ?? request.totalPrice;
    final timeAgo = _getTimeAgo(request.createdAt);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Client name + time
          Row(
            children: [
              FutureBuilder<String?>(
                future: _getClientAvatarUrl(request.clientId),
                builder: (context, snapshot) {
                  final avatarUrl = snapshot.data;
                  
                  if (avatarUrl != null && avatarUrl.isNotEmpty) {
                    return CircleAvatar(
                      radius: 20.r,
                      backgroundColor: colors.primary.withOpacity(0.1),
                      child: ClipOval(
                        child: Image.network(
                          avatarUrl,
                          width: 40.w,
                          height: 40.w,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Iconsax.user, color: colors.primary, size: 20.sp);
                          },
                        ),
                      ),
                    );
                  }
                  
                  return CircleAvatar(
                    radius: 20.r,
                    backgroundColor: colors.primary.withOpacity(0.1),
                    child: Icon(Iconsax.user, color: colors.primary, size: 20.sp),
                  );
                },
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.clientName,
                      style: AppTypography.headlineSmall(context).copyWith(color: colors.textPrimary),
                    ),
                    Row(
                      children: [
                        Text(
                          timeAgo,
                          style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary.withOpacity(0.7)),
                        ),
                        SizedBox(width: 6.w),
                        // Client trust badge
                        FutureBuilder<TrustScoreResult?>(
                          future: Get.find<TrustScoreService>().getTrustScore(request.clientId),
                          builder: (context, snap) {
                            if (!snap.hasData || snap.data == null) return const SizedBox.shrink();
                            return TrustBadge(
                              trustScore: snap.data!.trustScore,
                              trustLevel: snap.data!.trustLevel,
                              size: TrustBadgeSize.small,
                              showLabel: false,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: colors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'catalog'.tr.toUpperCase(),
                      style: AppTypography.bodySmall(context).copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Icon(Iconsax.arrow_right_1, color: colors.textSecondary, size: 16.sp),
                ],
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          // Service type
          Row(
            children: [
              Icon(Iconsax.category, color: colors.textSecondary, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                serviceType.tr,
                style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
              ),
            ],
          ),
          
          SizedBox(height: 12.h),
          
          // Destination
          if (request.destinationLocation != null) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Iconsax.location, color: colors.textSecondary, size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    request.destinationLocation.address ?? 'Delivery Location',
                    style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
          ],
          
          // Price
          Row(
            children: [
              Icon(Iconsax.money, color: colors.success, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                CurrencyHelper.formatWithSymbol(price, request.currencySymbol),
                style: AppTypography.headlineMedium(context).copyWith(color: colors.success),
              ),
            ],
          ),
          
          // Notes if any
          if (request.notes != null && request.notes!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Iconsax.message_text, color: colors.textSecondary.withOpacity(0.7), size: 16.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      request.notes!,
                      style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          SizedBox(height: 16.h),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onReject,
                  icon: const Icon(Iconsax.close_circle),
                  label: Text('common.reject'.tr),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.error.withOpacity(0.1),
                    foregroundColor: colors.error,
                    elevation: 0,
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
                  onPressed: onAccept,
                  icon: const Icon(Iconsax.tick_circle),
                  label: Text('common.accept'.tr),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
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
    );
  }

  String _getTimeAgo(DateTime? date) {
    if (date == null) return 'Just now';
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return DateFormat('MMM d, h:mm a').format(date);
  }

  /// Fetch client's profile photo URL by their user ID
  Future<String?> _getClientAvatarUrl(int? clientId) async {
    if (clientId == null) return null;
    
    try {
      final client = Get.find<Client>();
      final response = await client.user.getUserById(userId: clientId);
      return response.user?.profilePhotoUrl;
    } catch (e) {
      print('[CatalogRequests] Error fetching client avatar: $e');
      return null;
    }
  }
}
