import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../core/controllers/proposal_controller.dart';
import '../core/controllers/request_controller.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/utils/currency_helper.dart';
import 'report_screen.dart';

/// Screen to view and manage driver proposals for a request
class ProposalsScreen extends StatefulWidget {
  const ProposalsScreen({Key? key}) : super(key: key);

  @override
  State<ProposalsScreen> createState() => _ProposalsScreenState();
}

class _ProposalsScreenState extends State<ProposalsScreen> {
  final ProposalController proposalController = Get.put(ProposalController());
  final RequestController requestController = Get.find<RequestController>();
  late int requestId;

  @override
  void initState() {
    super.initState();
    requestId = Get.arguments as int;
    proposalController.loadProposalsForRequest(requestId);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text('Driver Proposals', style: TextStyle(color: colors.textPrimary, fontSize: 22.sp, fontWeight: FontWeight.w600)),
        backgroundColor: colors.surface,
        elevation: 0,
        actions: [
          Obx(() => IconButton(
                onPressed: () => proposalController.loadProposalsForRequest(requestId),
                icon: proposalController.isLoading.value
                    ? SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(colors.primary),
                        ),
                      )
                    : Icon(Icons.refresh, color: colors.textPrimary),
              )),
        ],
      ),
      body: Obx(() {
        if (proposalController.isLoading.value && proposalController.proposals.isEmpty) {
          return Center(
            child: CircularProgressIndicator(color: colors.primary),
          );
        }

        if (proposalController.proposals.isEmpty) {
          return _buildEmptyState(colors);
        }

        return RefreshIndicator(
          onRefresh: () => proposalController.loadProposalsForRequest(requestId),
          child: ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: proposalController.proposals.length,
            itemBuilder: (context, index) {
              final proposal = proposalController.proposals[index];
              return _buildProposalCard(proposal, colors);
            },
          ),
        );
      }),
    );
  }

  Widget _buildEmptyState(AppColorScheme colors) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.hourglass_empty_rounded,
              size: 80.sp,
              color: colors.textSecondary.withOpacity(0.5),
            ),
            SizedBox(height: 24.h),
            Text(
              'Waiting for Drivers',
              style: TextStyle(color: colors.textPrimary, fontSize: 22.sp, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              'Nearby drivers will send their proposals soon. You\'ll be notified when they arrive.',
              style: TextStyle(color: colors.textSecondary, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            CircularProgressIndicator(color: colors.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildProposalCard(DriverProposal proposal, AppColorScheme colors) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Driver info
            Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: colors.primary.withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    color: colors.primary,
                    size: 32.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        proposal.driverName,
                        style: TextStyle(color: colors.textPrimary, fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16.sp),
                          SizedBox(width: 4.w),
                          Text(
                            proposal.driverRating?.toStringAsFixed(1) ?? "New Driver",
                            style: TextStyle(color: colors.textSecondary, fontSize: 12.sp),
                          ),
                          if (proposal.driverPhone != null) ...[
                            SizedBox(width: 12.w),
                            Icon(Icons.phone, color: colors.primary, size: 16.sp),
                            SizedBox(width: 4.w),
                            Text(
                              proposal.driverPhone!,
                              style: TextStyle(color: colors.textSecondary, fontSize: 12.sp),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                // Report driver button
                IconButton(
                  onPressed: () {
                    Get.to(() => ReportScreen(driverId: proposal.driverId));
                  },
                  icon: Icon(Iconsax.flag, color: colors.textSecondary, size: 20.sp),
                  tooltip: 'report.report_driver'.tr,
                ),
              ],
            ),
            
            SizedBox(height: 16.h),
            
            // Proposal details
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    Icons.access_time,
                    'Arrival Time',
                    '${proposal.estimatedArrival} minutes',
                    colors,
                  ),
                  if (proposal.proposedPrice != null) ...[
                    SizedBox(height: 8.h),
                    _buildDetailRow(
                      Icons.attach_money,
                      'Proposed Price',
                      CurrencyHelper.format(proposal.proposedPrice!),
                      colors,
                    ),
                  ],
                  if (proposal.driverVehicleInfo != null) ...[
                    SizedBox(height: 8.h),
                    _buildDetailRow(
                      Icons.directions_car,
                      'Vehicle',
                      proposal.driverVehicleInfo!,
                      colors,
                    ),
                  ],
                ],
              ),
            ),
            
            // Message
            if (proposal.message != null && proposal.message!.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colors.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.message, color: colors.primary, size: 20.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        proposal.message!,
                        style: TextStyle(color: colors.textSecondary, fontSize: 14.sp),
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
                  child: OutlinedButton(
                    onPressed: () => proposalController.rejectProposal(proposal),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colors.error,
                      side: BorderSide(color: colors.error),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text('Decline', style: TextStyle(fontSize: 15.sp)),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () async {
                      final request = await proposalController.acceptProposal(proposal);
                      if (request != null) {
                        requestController.activeRequest.value = request;
                        Get.back();
                        Get.toNamed('/track-delivery', arguments: request.id);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Accept Driver',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, AppColorScheme colors) {
    return Row(
      children: [
        Icon(icon, color: colors.primary, size: 20.sp),
        SizedBox(width: 8.w),
        Text(
          '$label: ',
          style: TextStyle(color: colors.textSecondary, fontSize: 12.sp),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: colors.textPrimary, fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
