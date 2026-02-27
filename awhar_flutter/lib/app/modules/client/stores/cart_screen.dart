import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency_helper.dart';
import 'cart_controller.dart';
import 'checkout_screen.dart';

/// Cart screen showing all items in the cart
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Text(
          'cart.title'.tr,
          style: AppTypography.headlineSmall(context).copyWith(color: colors.textPrimary),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Iconsax.arrow_left, color: colors.textPrimary),
        ),
        actions: [
          Obx(() {
            if (cartController.isEmpty) return const SizedBox();
            return TextButton(
              onPressed: () => _showClearCartDialog(context, colors, cartController),
              child: Text(
                'cart.clear'.tr,
                style: AppTypography.bodyMedium(context).copyWith(color: colors.error),
              ),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (cartController.isEmpty) {
          return _buildEmptyCart(context, colors);
        }

        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              color: colors.surface,
              child: Row(
                children: [
                  Icon(Iconsax.shop, color: colors.primary),
                  SizedBox(width: 8.w),
                  Text(
                    cartController.currentStoreName.value,
                    style: AppTypography.titleMedium(context).copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: cartController.items.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final item = cartController.items[index];
                  return _buildCartItem(context, colors, item, cartController);
                },
              ),
            ),
            _buildOrderSummary(context, colors, cartController),
          ],
        );
      }),
    );
  }

  Widget _buildEmptyCart(BuildContext context, dynamic colors) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Iconsax.shopping_cart, size: 80.sp, color: colors.textSecondary),
          SizedBox(height: 16.h),
          Text(
            'cart.empty'.tr,
            style: AppTypography.headlineSmall(context).copyWith(color: colors.textSecondary),
          ),
          SizedBox(height: 8.h),
          Text(
            'cart.empty_message'.tr,
            style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            child: Text('cart.browse_stores'.tr),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, dynamic colors, CartItem item, CartController cartController) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CachedNetworkImage(
              imageUrl: item.imageUrl ?? '',
              width: 70.w,
              height: 70.w,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                width: 70.w,
                height: 70.w,
                color: colors.primary.withValues(alpha: 0.1),
                child: Icon(Iconsax.box, color: colors.primary),
              ),
              errorWidget: (_, __, ___) => Container(
                width: 70.w,
                height: 70.w,
                color: colors.primary.withValues(alpha: 0.1),
                child: Icon(Iconsax.box, color: colors.primary),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppTypography.titleSmall(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  CurrencyHelper.format(item.price),
                  style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildQuantityButton(context, colors, Iconsax.minus,
                      () => cartController.decreaseQuantity(item.productId)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      '${item.quantity}',
                      style: AppTypography.titleMedium(context).copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildQuantityButton(context, colors, Iconsax.add,
                      () => cartController.increaseQuantity(item.productId)),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                CurrencyHelper.format(item.totalPrice),
                style: AppTypography.titleSmall(context).copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(BuildContext context, dynamic colors, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: colors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Icon(icon, size: 16.sp, color: colors.primary),
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, dynamic colors, CartController cartController) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('cart.subtotal'.tr, style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary)),
                Obx(() => Text(
                  CurrencyHelper.format(cartController.subtotal),
                  style: AppTypography.bodyMedium(context).copyWith(color: colors.textPrimary),
                )),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('cart.delivery_fee'.tr, style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary)),
                Text(
                  'cart.calculated_at_checkout'.tr,
                  style: AppTypography.labelSmall(context).copyWith(color: colors.textSecondary),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Obx(() {
              if (cartController.meetsMinimumOrder) return const SizedBox();
              final remaining = cartController.storeMinimumOrder.value - cartController.subtotal;
              return Container(
                padding: EdgeInsets.all(12.w),
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: colors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: colors.warning),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.warning_2, size: 20.sp, color: colors.warning),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        '${'cart.minimum_order_warning'.tr} ${CurrencyHelper.format(remaining)}',
                        style: AppTypography.labelSmall(context).copyWith(color: colors.warning),
                      ),
                    ),
                  ],
                ),
              );
            }),
            Obx(() => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: cartController.meetsMinimumOrder ? () => Get.to(() => const CheckoutScreen()) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  disabledBackgroundColor: colors.textSecondary.withValues(alpha: 0.3),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text(
                  '${'cart.checkout'.tr} (${CurrencyHelper.format(cartController.subtotal)})',
                  style: AppTypography.titleSmall(context).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  void _showClearCartDialog(BuildContext context, dynamic colors, CartController cartController) {
    Get.dialog(
      AlertDialog(
        title: Text('cart.clear_title'.tr),
        content: Text('cart.clear_message'.tr),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('common.cancel'.tr)),
          TextButton(
            onPressed: () {
              cartController.clearCart();
              Get.back();
              Get.back();
            },
            child: Text('cart.clear'.tr, style: TextStyle(color: colors.error)),
          ),
        ],
      ),
    );
  }
}
