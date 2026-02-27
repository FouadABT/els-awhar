import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/controllers/auth_controller.dart';
import '../../../../core/utils/currency_helper.dart';
import '../../../../screens/location_picker_screen.dart';
import 'cart_controller.dart';
import 'client_store_order_screen.dart';

/// Controller for checkout process
class CheckoutController extends GetxController {
  final _client = Get.find<Client>();
  final _authController = Get.find<AuthController>();
  final _cartController = Get.find<CartController>();

  // Delivery address
  final RxString deliveryAddress = ''.obs;
  final RxDouble deliveryLatitude = 0.0.obs;
  final RxDouble deliveryLongitude = 0.0.obs;

  // Payment method - cash only
  final RxString paymentMethod = 'cash'.obs;
  final RxList<String> paymentMethods = <String>['cash'].obs;

  // States
  final RxBool isLoading = false.obs;
  final RxBool isCalculating = false.obs;
  final RxString errorMessage = ''.obs;

  // Delivery validation
  final RxBool isWithinDeliveryZone = true.obs;
  final RxDouble distanceToStore = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadDefaultAddress();
    validateDeliveryZone();
  }

  void _loadDefaultAddress() {
    final user = _authController.currentUser.value;
    
    debugPrint('🔧 Loading default delivery address');
    debugPrint('  User: ${user?.fullName}');
    debugPrint('  User Location: ${user?.currentLatitude}, ${user?.currentLongitude}');
    
    if (user != null && user.currentLatitude != null && user.currentLatitude != 0) {
      deliveryLatitude.value = user.currentLatitude!;
      deliveryLongitude.value = user.currentLongitude!;
      debugPrint('  Using user location: ${deliveryLatitude.value}, ${deliveryLongitude.value}');
    } else {
      // Use Casablanca as default fallback
      deliveryLatitude.value = 33.5731;
      deliveryLongitude.value = -7.5898;
      debugPrint('  Using default Casablanca location: ${deliveryLatitude.value}, ${deliveryLongitude.value}');
    }
    deliveryAddress.value = 'Current Location';
  }

  Future<void> validateDeliveryZone() async {
    try {
      isCalculating.value = true;

      debugPrint('🔍 Validating delivery zone:');
      debugPrint('  Store ID: ${_cartController.currentStoreId.value}');
      debugPrint('  Client Lat: ${deliveryLatitude.value}');
      debugPrint('  Client Lng: ${deliveryLongitude.value}');

      final result = await _client.store.isWithinDeliveryZone(
        storeId: _cartController.currentStoreId.value,
        clientLatitude: deliveryLatitude.value,
        clientLongitude: deliveryLongitude.value,
      );

      debugPrint('✅ Delivery zone validation result: $result');
      isWithinDeliveryZone.value = result;
      
      // Estimate distance (simplified)
      distanceToStore.value = 3.0; // Default estimate
      _cartController.calculateDeliveryFee(distanceToStore.value);
    } catch (e) {
      debugPrint('❌ Delivery zone validation error: $e');
      errorMessage.value = 'Failed to validate delivery zone';
      isWithinDeliveryZone.value = false;
    } finally {
      isCalculating.value = false;
    }
  }

  void setPaymentMethod(String method) {
    paymentMethod.value = method;
  }

  void setDeliveryAddress(String address, double lat, double lng) {
    debugPrint('📍 Setting delivery address:');
    debugPrint('  Address: $address');
    debugPrint('  Latitude: $lat');
    debugPrint('  Longitude: $lng');
    
    deliveryAddress.value = address;
    deliveryLatitude.value = lat;
    deliveryLongitude.value = lng;
    validateDeliveryZone();
  }

  Future<void> placeOrder() async {
    if (!isWithinDeliveryZone.value) {
      Get.snackbar(
        'checkout.error'.tr,
        'checkout.outside_delivery_zone'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final userId = _authController.currentUser.value?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final order = await _client.storeOrder.createOrder(
        storeId: _cartController.currentStoreId.value,
        clientId: userId,
        items: _cartController.getItemsForApi(),
        deliveryAddress: deliveryAddress.value,
        deliveryLatitude: deliveryLatitude.value,
        deliveryLongitude: deliveryLongitude.value,
        clientNotes: _cartController.orderNotes.value.isEmpty ? null : _cartController.orderNotes.value,
      );

      _cartController.clearCart();

      if (order != null && order.id != null) {
        Get.off(() => ClientStoreOrderScreen(orderId: order.id!));
      }

      Get.snackbar(
        'checkout.success'.tr,
        'checkout.order_placed'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'checkout.error'.tr,
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

/// Checkout screen for placing store orders
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final checkoutController = Get.put(CheckoutController());
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Text(
          'checkout.title'.tr,
          style: AppTypography.headlineSmall(context).copyWith(color: colors.textPrimary),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Iconsax.arrow_left, color: colors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDeliverySection(context, colors, checkoutController),
            SizedBox(height: 16.h),
            _buildPaymentSection(context, colors, checkoutController),
            SizedBox(height: 16.h),
            _buildOrderSummary(context, colors, cartController),
            SizedBox(height: 16.h),
            _buildOrderItems(context, colors, cartController),
          ],
        ),
      ),
      bottomNavigationBar: _buildPlaceOrderButton(context, colors, checkoutController, cartController),
    );
  }

  Widget _buildDeliverySection(BuildContext context, dynamic colors, CheckoutController controller) {
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
              Icon(Iconsax.location, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                'checkout.delivery_address'.tr,
                style: AppTypography.titleSmall(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: () => _showAddressSelector(context, colors, controller),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: colors.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() => Text(
                      controller.deliveryAddress.value.isEmpty
                          ? 'checkout.select_address'.tr
                          : controller.deliveryAddress.value,
                      style: AppTypography.bodyMedium(context).copyWith(
                        color: controller.deliveryAddress.value.isEmpty
                            ? colors.textSecondary
                            : colors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ),
                  Icon(Iconsax.arrow_right_3, size: 16.sp, color: colors.textSecondary),
                ],
              ),
            ),
          ),
          Obx(() {
            if (controller.isCalculating.value) {
              return Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: CircularProgressIndicator(strokeWidth: 2, color: colors.primary),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'checkout.validating_address'.tr,
                      style: AppTypography.labelSmall(context).copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
              );
            }

            if (!controller.isWithinDeliveryZone.value && controller.deliveryAddress.value.isNotEmpty) {
              return Container(
                margin: EdgeInsets.only(top: 8.h),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: colors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: colors.error),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.warning_2, size: 16.sp, color: colors.error),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'checkout.outside_delivery_zone'.tr,
                        style: AppTypography.labelSmall(context).copyWith(color: colors.error),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (controller.distanceToStore.value > 0 && controller.isWithinDeliveryZone.value) {
              return Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Row(
                  children: [
                    Icon(Iconsax.tick_circle, size: 16.sp, color: Colors.green),
                    SizedBox(width: 8.w),
                    Text(
                      '${controller.distanceToStore.value.toStringAsFixed(1)} km ${'checkout.from_store'.tr}',
                      style: AppTypography.labelSmall(context).copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          }),
        ],
      ),
    );
  }

  Widget _buildPaymentSection(BuildContext context, dynamic colors, CheckoutController controller) {
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
              Icon(Iconsax.wallet, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                'checkout.payment_method'.tr,
                style: AppTypography.titleSmall(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Obx(() => Column(
            children: controller.paymentMethods.map((method) {
              final isSelected = controller.paymentMethod.value == method;
              return GestureDetector(
                onTap: () => controller.setPaymentMethod(method),
                child: Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: isSelected ? colors.primary.withValues(alpha: 0.1) : colors.background,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: isSelected ? colors.primary : colors.border),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        method == 'cash' ? Iconsax.money : Iconsax.card,
                        color: isSelected ? colors.primary : colors.textSecondary,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          'checkout.payment_$method'.tr,
                          style: AppTypography.bodyMedium(context).copyWith(
                            color: isSelected ? colors.primary : colors.textPrimary,
                          ),
                        ),
                      ),
                      if (isSelected) Icon(Iconsax.tick_circle, color: colors.primary, size: 20.sp),
                    ],
                  ),
                ),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, dynamic colors, CartController cartController) {
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
              Icon(Iconsax.receipt_1, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                'checkout.order_summary'.tr,
                style: AppTypography.titleSmall(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Obx(() => Column(
            children: [
              _buildSummaryRow(context, colors, 'checkout.subtotal'.tr, CurrencyHelper.format(cartController.subtotal)),
              SizedBox(height: 8.h),
              _buildSummaryRow(context, colors, 'checkout.delivery_fee'.tr, CurrencyHelper.format(cartController.deliveryFee.value)),
              Divider(height: 24.h, color: colors.border),
              _buildSummaryRow(context, colors, 'checkout.total'.tr, CurrencyHelper.format(cartController.total), isBold: true),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, dynamic colors, String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isBold
              ? AppTypography.titleSmall(context).copyWith(color: colors.textPrimary, fontWeight: FontWeight.bold)
              : AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
        ),
        Text(
          value,
          style: isBold
              ? AppTypography.titleSmall(context).copyWith(color: colors.primary, fontWeight: FontWeight.bold)
              : AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildOrderItems(BuildContext context, dynamic colors, CartController cartController) {
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
              Icon(Iconsax.shopping_bag, color: colors.primary),
              SizedBox(width: 8.w),
              Text(
                'checkout.items'.tr,
                style: AppTypography.titleSmall(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Obx(() => Text(
                '${cartController.totalItems} ${'checkout.items_count'.tr}',
                style: AppTypography.labelSmall(context).copyWith(color: colors.textSecondary),
              )),
            ],
          ),
          SizedBox(height: 12.h),
          Obx(() => Column(
            children: cartController.items.map((item) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: colors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        '${item.quantity}x',
                        style: AppTypography.labelSmall(context).copyWith(color: colors.primary),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        item.name,
                        style: AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      CurrencyHelper.format(item.totalPrice),
                      style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }

  Widget _buildPlaceOrderButton(
    BuildContext context,
    dynamic colors,
    CheckoutController checkoutController,
    CartController cartController,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        child: Obx(() => SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: checkoutController.isLoading.value ||
                    !checkoutController.isWithinDeliveryZone.value ||
                    checkoutController.deliveryAddress.value.isEmpty
                ? null
                : () => checkoutController.placeOrder(),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              disabledBackgroundColor: colors.textSecondary.withValues(alpha: 0.3),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
            child: checkoutController.isLoading.value
                ? SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : Text(
                    '${'checkout.place_order'.tr} (${CurrencyHelper.format(cartController.total)})',
                    style: AppTypography.titleSmall(context).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
          ),
        )),
      ),
    );
  }

  void _showAddressSelector(BuildContext context, dynamic colors, CheckoutController controller) async {
    final result = await Get.to<Map<String, dynamic>>(
      () => const LocationPickerScreen(),
      arguments: {
        'isPickup': false,
        'lat': controller.deliveryLatitude.value,
        'lng': controller.deliveryLongitude.value,
      },
    );

    if (result != null) {
      debugPrint('📦 Location picker result: $result');
      
      final lat = result['lat'] ?? result['latitude'] ?? controller.deliveryLatitude.value;
      final lng = result['lng'] ?? result['longitude'] ?? controller.deliveryLongitude.value;
      final address = result['address'] ?? 'Selected Location';
      
      debugPrint('✅ Extracted coordinates: lat=$lat, lng=$lng');
      
      controller.setDeliveryAddress(address, lat as double, lng as double);
    } else {
      debugPrint('❌ Location picker cancelled');
    }
  }
}
