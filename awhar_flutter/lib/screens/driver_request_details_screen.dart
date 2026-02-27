import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/controllers/request_controller.dart';
import '../core/controllers/auth_controller.dart';
import '../core/utils/currency_helper.dart';
import '../core/services/trust_score_service.dart';
import '../shared/widgets/trust_badge.dart';

class DriverRequestDetailsScreen extends StatefulWidget {
  final ServiceRequest request;

  const DriverRequestDetailsScreen({
    super.key,
    required this.request,
  });

  @override
  State<DriverRequestDetailsScreen> createState() =>
      _DriverRequestDetailsScreenState();
}

class _DriverRequestDetailsScreenState
    extends State<DriverRequestDetailsScreen> {
  final controller = Get.find<RequestController>();
  final authController = Get.find<AuthController>();
  final _trustService = Get.find<TrustScoreService>();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool isSubmitting = false;
  TrustScoreResult? _trustResult;

  @override
  void initState() {
    super.initState();
    // Pre-fill with client's offered price if available
    if (widget.request.clientOfferedPrice != null) {
      _priceController.text =
          widget.request.clientOfferedPrice!.toStringAsFixed(0);
    }
    // Fetch trust score for this client
    _fetchTrustScore();
  }

  Future<void> _fetchTrustScore() async {
    final result = await _trustService.getTrustScore(widget.request.clientId);
    if (mounted && result != null) {
      setState(() => _trustResult = result);
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    _messageController.dispose();
    super.dispose();
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
          icon: Icon(Iconsax.arrow_left_copy, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'home.request_details'.tr,
          style: AppTypography.titleLarge(context)
              .copyWith(color: colors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Client's Offered Price (if available)
            if (widget.request.clientOfferedPrice != null)
              _buildClientOfferBanner(colors),

            SizedBox(height: 16.h),

            // Service Details Card
            _buildServiceDetailsCard(colors),

            SizedBox(height: 16.h),

            // Locations Card
            _buildLocationsCard(colors),

            SizedBox(height: 16.h),

            // Purchase Details Card (for purchase/task types)
            if (widget.request.serviceType == ServiceType.purchase ||
                widget.request.serviceType == ServiceType.task)
              _buildPurchaseDetailsCard(colors),

            if (widget.request.serviceType == ServiceType.purchase ||
                widget.request.serviceType == ServiceType.task)
              SizedBox(height: 16.h),

            // Client Info Card
            _buildClientInfoCard(colors),

            SizedBox(height: 16.h),

            // Earnings Calculator
            _buildEarningsCalculator(colors),

            SizedBox(height: 24.h),

            // Action Buttons
            _buildActionButtons(colors),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildClientOfferBanner(AppColorScheme colors) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary.withOpacity(0.15), colors.primary.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.primary.withOpacity(0.3), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: colors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Iconsax.money_copy, color: colors.primary, size: 24.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'negotiation.client_offers'.tr,
                  style: AppTypography.labelSmall(context)
                      .copyWith(color: colors.textSecondary, fontSize: 11.sp),
                ),
                SizedBox(height: 2.h),
                Text(
                  CurrencyHelper.formatWithSymbol(widget.request.clientOfferedPrice!, widget.request.currencySymbol),
                  style: AppTypography.headlineMedium(context).copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Icon(Iconsax.verify_copy, color: colors.success, size: 20.sp),
        ],
      ),
    );
  }

  Widget _buildServiceDetailsCard(AppColorScheme colors) {
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
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Iconsax.box_copy, color: colors.primary, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  widget.request.serviceType.name.toUpperCase(),
                  style: AppTypography.titleMedium(context)
                      .copyWith(color: colors.textPrimary, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          if (widget.request.notes != null && widget.request.notes!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                widget.request.notes!,
                style: AppTypography.bodyMedium(context)
                    .copyWith(color: colors.textSecondary),
              ),
            ),
          ],
          SizedBox(height: 12.h),
          Divider(color: colors.border),
          SizedBox(height: 12.h),
          _buildDetailRow(
            colors,
            Iconsax.calendar_copy,
            'home.requested_at'.tr,
            _formatDate(widget.request.createdAt),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationsCard(AppColorScheme colors) {
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
          Text(
            'home.locations'.tr,
            style: AppTypography.titleMedium(context)
                .copyWith(color: colors.textPrimary, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12.h),
          _buildLocationItem(
            colors,
            Iconsax.location_copy,
            'home.pickup'.tr,
            widget.request.pickupLocation?.address ?? 
            (widget.request.pickupLocation != null 
                ? '${widget.request.pickupLocation!.latitude.toStringAsFixed(4)}, ${widget.request.pickupLocation!.longitude.toStringAsFixed(4)}' 
                : 'driver.flexible_pickup'.tr),
            widget.request.pickupLocation == null ? colors.warning : colors.success,
          ),
          SizedBox(height: 12.h),
          _buildLocationItem(
            colors,
            Iconsax.location_tick_copy,
            'home.dropoff'.tr,
            widget.request.destinationLocation.address ?? '${widget.request.destinationLocation.latitude.toStringAsFixed(4)}, ${widget.request.destinationLocation.longitude.toStringAsFixed(4)}',
            colors.error,
          ),
          SizedBox(height: 12.h),
          Divider(color: colors.border),
          SizedBox(height: 12.h),
          _buildDetailRow(
            colors,
            Iconsax.routing_copy,
            'home.distance'.tr,
            '${widget.request.distance?.toStringAsFixed(1) ?? "--"} km',
          ),
          SizedBox(height: 8.h),
          _buildDetailRow(
            colors,
            Iconsax.clock_copy,
            'home.duration'.tr,
            '${widget.request.estimatedDuration} min',
          ),
        ],
      ),
    );
  }

  Widget _buildLocationItem(
    AppColorScheme colors,
    IconData icon,
    String label,
    String value,
    Color iconColor,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: iconColor, size: 18.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.labelSmall(context)
                    .copyWith(color: colors.textSecondary, fontSize: 11.sp),
              ),
              Text(
                value,
                style: AppTypography.bodyMedium(context)
                    .copyWith(color: colors.textPrimary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPurchaseDetailsCard(AppColorScheme colors) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.warning.withOpacity(0.1),
            colors.warning.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.warning.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: colors.warning.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  widget.request.serviceType == ServiceType.purchase
                      ? Iconsax.bag_2
                      : Iconsax.clipboard_text,
                  color: colors.warning,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.request.serviceType == ServiceType.purchase
                          ? 'driver.purchase_required'.tr
                          : 'driver.task_required'.tr,
                      style: AppTypography.titleMedium(context).copyWith(
                        color: colors.warning,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'driver.purchase_notice'.tr,
                      style: AppTypography.labelSmall(context).copyWith(
                        color: colors.textSecondary,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Item description
          if (widget.request.itemDescription != null &&
              widget.request.itemDescription!.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'concierge.what_do_you_need'.tr,
                    style: AppTypography.labelSmall(context)
                        .copyWith(color: colors.textSecondary, fontSize: 11.sp),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    widget.request.itemDescription!,
                    style: AppTypography.bodyMedium(context)
                        .copyWith(color: colors.textPrimary),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
          ],
          // Estimated purchase cost
          if (widget.request.estimatedPurchaseCost != null &&
              widget.request.estimatedPurchaseCost! > 0) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'driver.estimated_cost'.tr,
                  style: AppTypography.bodyMedium(context)
                      .copyWith(color: colors.textSecondary),
                ),
                Text(
                  CurrencyHelper.formatWithSymbol(widget.request.estimatedPurchaseCost!, widget.request.currencySymbol),
                  style: AppTypography.titleMedium(context).copyWith(
                    color: colors.warning,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
          ],
          // Delivery fee
          if (widget.request.clientOfferedPrice != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'driver.delivery_fee'.tr,
                  style: AppTypography.bodyMedium(context)
                      .copyWith(color: colors.textSecondary),
                ),
                Text(
                  CurrencyHelper.formatWithSymbol(widget.request.clientOfferedPrice!, widget.request.currencySymbol),
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(color: colors.border),
            SizedBox(height: 12.h),
          ],
          // Total earnings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'driver.total_earnings'.tr,
                style: AppTypography.bodyLarge(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                CurrencyHelper.formatWithSymbol((widget.request.estimatedPurchaseCost ?? 0) + (widget.request.clientOfferedPrice ?? 0), widget.request.currencySymbol),
                style: AppTypography.headlineSmall(context).copyWith(
                  color: colors.success,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClientInfoCard(AppColorScheme colors) {
    final trustScore = _trustResult?.trustScore ?? 50.0;
    final trustLevel = _trustResult?.trustLevel ?? 'FAIR';

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'home.client_info'.tr,
                style: AppTypography.titleMedium(context)
                    .copyWith(color: colors.textPrimary, fontWeight: FontWeight.w600),
              ),
              // Trust Badge - compact inline
              TrustBadge(
                trustScore: trustScore,
                trustLevel: trustLevel,
                size: TrustBadgeSize.small,
                showLabel: true,
                showScore: true,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: colors.primary.withOpacity(0.1),
                child: Icon(Iconsax.user_copy, color: colors.primary, size: 24.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.request.clientName ?? 'Client #${widget.request.clientId}',
                      style: AppTypography.bodyMedium(context)
                          .copyWith(color: colors.textPrimary, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Icon(Iconsax.star_copy, color: Colors.amber, size: 14.sp),
                        SizedBox(width: 4.w),
                        Text(
                          '4.8',
                          style: AppTypography.labelSmall(context)
                              .copyWith(color: colors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsCalculator(AppColorScheme colors) {
    final clientPrice = widget.request.clientOfferedPrice ?? widget.request.totalPrice;
    final inputPrice = double.tryParse(_priceController.text) ?? clientPrice;
    final commission = inputPrice * 0.05; // 5% commission
    final earnings = inputPrice - commission;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.success.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.success.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.calculator_copy, color: colors.success, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'negotiation.estimated_earnings'.tr,
                style: AppTypography.titleMedium(context)
                    .copyWith(color: colors.textPrimary, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildEarningsRow(colors, 'negotiation.your_counter_offer'.tr, inputPrice),
          SizedBox(height: 8.h),
          _buildEarningsRow(colors, 'Platform Commission (5%)', -commission, isNegative: true),
          SizedBox(height: 8.h),
          Divider(color: colors.border),
          SizedBox(height: 8.h),
          _buildEarningsRow(colors, 'negotiation.your_earnings'.tr, earnings, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildEarningsRow(
    AppColorScheme colors,
    String label,
    double amount, {
    bool isNegative = false,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTypography.titleMedium(context).copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                )
              : AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
        ),
        Text(
          '${isNegative ? '-' : ''}${CurrencyHelper.formatWithSymbol(amount, widget.request.currencySymbol)}',
          style: isTotal
              ? AppTypography.titleMedium(context).copyWith(
                  color: colors.success,
                  fontWeight: FontWeight.bold,
                )
              : AppTypography.bodyMedium(context).copyWith(
                  color: isNegative ? colors.error : colors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(AppColorScheme colors) {
    final clientPrice = widget.request.clientOfferedPrice ?? widget.request.totalPrice;

    return Column(
      children: [
        // Accept Client's Price Button
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton.icon(
            onPressed: isSubmitting ? null : () => _handleAcceptClientPrice(clientPrice),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.success,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            icon: Icon(Iconsax.tick_circle_copy, size: 20.sp),
            label: Text(
              'negotiation.accept_client_price'.tr,
              style: AppTypography.labelLarge(context).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),

        // Make Counter-Offer Button
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: OutlinedButton.icon(
            onPressed: isSubmitting ? null : _showCounterOfferDialog,
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.primary,
              side: BorderSide(color: colors.primary, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            icon: Icon(Iconsax.message_text_copy, size: 20.sp),
            label: Text(
              'negotiation.send_counter_offer'.tr,
              style: AppTypography.labelLarge(context).copyWith(
                color: colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    AppColorScheme colors,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, color: colors.textSecondary, size: 16.sp),
        SizedBox(width: 8.w),
        Text(
          label,
          style: AppTypography.labelSmall(context)
              .copyWith(color: colors.textSecondary),
        ),
        Spacer(),
        Text(
          value,
          style: AppTypography.bodyMedium(context)
              .copyWith(color: colors.textPrimary, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  void _showCounterOfferDialog() {
    final colors = Theme.of(context).brightness == Brightness.dark
        ? AppColors.dark
        : AppColors.light;
    final clientPrice = widget.request.clientOfferedPrice ?? widget.request.totalPrice;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Row(
          children: [
            Icon(Iconsax.money_send_copy, color: colors.primary, size: 24.sp),
            SizedBox(width: 12.w),
            Text(
              'negotiation.send_counter_offer'.tr,
              style: AppTypography.titleLarge(context)
                  .copyWith(color: colors.textPrimary),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Client's offer reference
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'negotiation.client_offers'.tr,
                      style: AppTypography.bodyMedium(context)
                          .copyWith(color: colors.textSecondary),
                    ),
                    Text(
                      CurrencyHelper.formatWithSymbol(clientPrice, widget.request.currencySymbol),
                      style: AppTypography.titleMedium(context).copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Counter-offer input
              Text(
                'negotiation.your_counter_offer'.tr,
                style: AppTypography.labelLarge(context)
                    .copyWith(color: colors.textPrimary),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                style: AppTypography.bodyMedium(context)
                    .copyWith(color: colors.textPrimary),
                decoration: InputDecoration(
                  hintText: '${clientPrice.toStringAsFixed(0)}',
                  hintStyle: AppTypography.bodyMedium(context)
                      .copyWith(color: colors.textSecondary.withOpacity(0.5)),
                  suffixText: CurrencyHelper.symbol,
                  filled: true,
                  fillColor: colors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: colors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: colors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: colors.primary, width: 2),
                  ),
                ),
                onChanged: (value) {
                  setState(() {}); // Refresh earnings calculator
                },
              ),
              SizedBox(height: 16.h),

              // Warning if price too high
              if (_priceController.text.isNotEmpty) ...[
                Builder(
                  builder: (context) {
                    final counterPrice = double.tryParse(_priceController.text) ?? 0;
                    final percentDiff = ((counterPrice - clientPrice) / clientPrice * 100).round();
                    
                    if (percentDiff > 30) {
                      return Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: colors.warning.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: colors.warning.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Iconsax.warning_2_copy, color: colors.warning, size: 18.sp),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'negotiation.price_too_high_warning'.trParams({'percent': percentDiff.toString()}),
                                style: AppTypography.labelSmall(context)
                                    .copyWith(color: colors.textSecondary),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
                SizedBox(height: 16.h),
              ],

              // Optional message
              Text(
                'negotiation.why_this_price'.tr,
                style: AppTypography.labelLarge(context)
                    .copyWith(color: colors.textPrimary),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _messageController,
                maxLines: 3,
                style: AppTypography.bodyMedium(context)
                    .copyWith(color: colors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Optional explanation...',
                  hintStyle: AppTypography.bodyMedium(context)
                      .copyWith(color: colors.textSecondary.withOpacity(0.5)),
                  filled: true,
                  fillColor: colors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: colors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: colors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: colors.primary, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'common.cancel'.tr,
              style: AppTypography.labelLarge(context)
                  .copyWith(color: colors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _handleCounterOffer();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'common.send'.tr,
              style: AppTypography.labelLarge(context)
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleAcceptClientPrice(double price) async {
    final commission = price * 0.05;
    final earnings = price - commission;

    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: (Theme.of(context).brightness == Brightness.dark
                ? AppColors.dark
                : AppColors.light)
            .surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          'negotiation.accept_client_price'.tr,
          style: AppTypography.titleLarge(context).copyWith(
            color: (Theme.of(context).brightness == Brightness.dark
                    ? AppColors.dark
                    : AppColors.light)
                .textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildEarningsRow(
              Theme.of(context).brightness == Brightness.dark
                  ? AppColors.dark
                  : AppColors.light,
              'negotiation.client_offers'.tr,
              price,
            ),
            SizedBox(height: 8.h),
            _buildEarningsRow(
              Theme.of(context).brightness == Brightness.dark
                  ? AppColors.dark
                  : AppColors.light,
              'Platform Commission (5%)',
              -commission,
              isNegative: true,
            ),
            SizedBox(height: 8.h),
            Divider(),
            SizedBox(height: 8.h),
            _buildEarningsRow(
              Theme.of(context).brightness == Brightness.dark
                  ? AppColors.dark
                  : AppColors.light,
              'negotiation.your_earnings'.tr,
              earnings,
              isTotal: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('common.cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: (Theme.of(context).brightness == Brightness.dark
                      ? AppColors.dark
                      : AppColors.light)
                  .success,
            ),
            child: Text(
              'common.accept'.tr,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() => isSubmitting = true);
      try {
        // TODO: Call backend to accept client's price
        Get.snackbar(
          'common.success'.tr,
          'negotiation.offer_accepted_success'.tr,
          backgroundColor: (Theme.of(context).brightness == Brightness.dark
                  ? AppColors.dark
                  : AppColors.light)
              .success,
          colorText: Colors.white,
        );
        Get.back(); // Return to previous screen
      } catch (e) {
        Get.snackbar(
          'common.error'.tr,
          e.toString(),
          backgroundColor: (Theme.of(context).brightness == Brightness.dark
                  ? AppColors.dark
                  : AppColors.light)
              .error,
          colorText: Colors.white,
        );
      } finally {
        setState(() => isSubmitting = false);
      }
    }
  }

  Future<void> _handleCounterOffer() async {
    final counterPrice = double.tryParse(_priceController.text);
    if (counterPrice == null || counterPrice < 15) {
      Get.snackbar(
        'common.error'.tr,
        'negotiation.price_too_low'.tr,
        backgroundColor: (Theme.of(context).brightness == Brightness.dark
                ? AppColors.dark
                : AppColors.light)
            .error,
        colorText: Colors.white,
      );
      return;
    }

    setState(() => isSubmitting = true);
    try {
      // TODO: Call backend to send counter-offer
      Get.snackbar(
        'common.success'.tr,
        'negotiation.offer_sent'.tr,
        backgroundColor: (Theme.of(context).brightness == Brightness.dark
                ? AppColors.dark
                : AppColors.light)
            .success,
        colorText: Colors.white,
      );
      Get.back(); // Return to previous screen
    } catch (e) {
      Get.snackbar(
        'common.error'.tr,
        e.toString(),
        backgroundColor: (Theme.of(context).brightness == Brightness.dark
                ? AppColors.dark
                : AppColors.light)
            .error,
        colorText: Colors.white,
      );
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}
