import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:awhar_client/awhar_client.dart';
import 'dart:async';
import '../../core/controllers/proposal_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Beautiful animated notification that appears from top with auto-dismiss timer
class ProposalNotificationCard extends StatefulWidget {
  final DriverProposal proposal;
  final VoidCallback onDismiss;
  final Function(DriverProposal) onAccept;
  final int autoDissmissSeconds;

  const ProposalNotificationCard({
    Key? key,
    required this.proposal,
    required this.onDismiss,
    required this.onAccept,
    this.autoDissmissSeconds = 15,
  }) : super(key: key);

  @override
  State<ProposalNotificationCard> createState() => _ProposalNotificationCardState();
}

class _ProposalNotificationCardState extends State<ProposalNotificationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  Timer? _dismissTimer;
  late int _secondsRemaining;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.autoDissmissSeconds;

    // Setup animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    // Start animation
    _animationController.forward();

    // Start countdown timer
    _startTimer();
  }

  void _startTimer() {
    _dismissTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsRemaining--;
      });

      if (_secondsRemaining <= 0) {
        timer.cancel();
        _dismiss();
      }
    });
  }

  void _dismiss() {
    _animationController.reverse().then((_) {
      widget.onDismiss();
    });
  }

  void _accept() {
    _dismissTimer?.cancel();
    widget.onAccept(widget.proposal);
    _dismiss();
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.primary,
                colors.primary.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: colors.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with timer
                  Row(
                    children: [
                      // Icon
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.local_shipping_rounded,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      
                      // Title
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'New Driver Proposal',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Driver wants to deliver your order',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 13.sp,
                                ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Timer badge
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: _secondsRemaining <= 5
                              ? Colors.red.shade700
                              : Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: Colors.white,
                              size: 16.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '${_secondsRemaining}s',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Close button
                      SizedBox(width: 8.w),
                      IconButton(
                        onPressed: _dismiss,
                        icon: const Icon(Icons.close, color: Colors.white),
                        iconSize: 20.sp,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 16.h),
                  
                  // Driver info
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        // Driver avatar
                        CircleAvatar(
                          radius: 24.r,
                          backgroundColor: Colors.white.withOpacity(0.3),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 28.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        
                        // Driver details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.proposal.driverName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    '${widget.proposal.driverRating?.toStringAsFixed(1) ?? "New"}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.white.withOpacity(0.9),
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'Arrives in ${widget.proposal.estimatedArrival} min',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Message if provided
                  if (widget.proposal.message != null && widget.proposal.message!.isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.message_outlined,
                            color: Colors.white.withOpacity(0.9),
                            size: 16.sp,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              widget.proposal.message!,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14.sp,
                                fontStyle: FontStyle.italic,
                              ),
                              maxLines: 2,
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
                      // View Details button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _dismissTimer?.cancel();
                            _dismiss();
                            Get.toNamed('/proposals', arguments: widget.proposal.requestId);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              side: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                            ),
                          ),
                          child: Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(width: 12.w),
                      
                      // Accept button
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _accept,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: colors.primary,
                            elevation: 4,
                            shadowColor: Colors.black.withOpacity(0.3),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
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
          ),
        ),
      ),
    );
  }
}
