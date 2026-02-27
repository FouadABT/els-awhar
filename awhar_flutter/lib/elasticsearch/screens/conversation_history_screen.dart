import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../services/conversation_storage_service.dart';

/// Screen showing the list of past AI Concierge conversations.
///
/// Users can:
/// - Resume an existing conversation
/// - Start a new conversation
/// - Delete old conversations
class ConversationHistoryScreen extends StatefulWidget {
  const ConversationHistoryScreen({super.key});

  @override
  State<ConversationHistoryScreen> createState() =>
      _ConversationHistoryScreenState();
}

class _ConversationHistoryScreenState
    extends State<ConversationHistoryScreen> {
  final ConversationStorageService _storage = ConversationStorageService();
  late List<ConversationSummary> _conversations;

  @override
  void initState() {
    super.initState();
    _conversations = _storage.getConversations();
  }

  void _refresh() {
    setState(() {
      _conversations = _storage.getConversations();
    });
  }

  void _openConversation(String conversationId) {
    _storage.setActiveConversation(conversationId);
    Get.toNamed(AppRoutes.aiConcierge, arguments: {
      'resumeConversationId': conversationId,
    });
  }

  void _startNew() {
    _storage.clearActiveConversation();
    Get.toNamed(AppRoutes.aiConcierge, arguments: {
      'newConversation': true,
    });
  }

  void _deleteConversation(String conversationId) {
    _storage.deleteConversation(conversationId);
    _refresh();
    Get.snackbar(
      'concierge_history.deleted_title'.tr,
      'concierge_history.deleted_message'.tr,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surfaceElevated,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'concierge_history.title'.tr,
          style: AppTypography.titleSmall(context).copyWith(
            color: colors.textPrimary,
          ),
        ),
        actions: [
          if (_conversations.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete_sweep_outlined,
                  color: colors.textMuted, size: 22.sp),
              onPressed: () => _showClearAllDialog(colors),
              tooltip: 'concierge_history.clear_all'.tr,
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _startNew,
        backgroundColor: colors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'concierge_history.new_chat'.tr,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _conversations.isEmpty
          ? _buildEmptyState(colors)
          : _buildList(colors),
    );
  }

  Widget _buildEmptyState(AppColorScheme colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: colors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.auto_awesome,
              color: colors.primary,
              size: 40.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'concierge_history.empty_title'.tr,
            style: AppTypography.titleSmall(context).copyWith(
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'concierge_history.empty_subtitle'.tr,
            style: AppTypography.bodyMedium(context).copyWith(
              color: colors.textMuted,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: _startNew,
            icon: const Icon(Icons.auto_awesome, color: Colors.white),
            label: Text(
              'concierge_history.start_first'.tr,
              style: const TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(AppColorScheme colors) {
    return ListView.separated(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 12.h,
        bottom: 80.h, // Space for FAB
      ),
      itemCount: _conversations.length,
      separatorBuilder: (_, _a) => SizedBox(height: 8.h),
      itemBuilder: (context, index) {
        final conv = _conversations[index];
        return _buildConversationTile(conv, colors);
      },
    );
  }

  Widget _buildConversationTile(
      ConversationSummary conv, AppColorScheme colors) {
    final isToday = _isToday(conv.updatedAt);
    final timeLabel = isToday
        ? _formatTime(conv.updatedAt)
        : _formatDate(conv.updatedAt);

    return Dismissible(
      key: Key(conv.conversationId),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
          color: colors.error,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => _deleteConversation(conv.conversationId),
      child: Material(
        color: colors.surfaceElevated,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: () => _openConversation(conv.conversationId),
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Row(
              children: [
                // Chat icon
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: colors.primarySoft,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    color: colors.primary,
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                // Title & preview
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        conv.title,
                        style: AppTypography.bodyMedium(context).copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        conv.preview,
                        style: AppTypography.labelSmall(context).copyWith(
                          color: colors.textMuted,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                // Time & count
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      timeLabel,
                      style: AppTypography.labelSmall(context).copyWith(
                        color: colors.textMuted,
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primarySoft,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '${conv.messageCount}',
                        style: TextStyle(
                          color: colors.primary,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
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
    );
  }

  void _showClearAllDialog(AppColorScheme colors) {
    Get.dialog(
      AlertDialog(
        title: Text('concierge_history.clear_all_title'.tr),
        content: Text('concierge_history.clear_all_message'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('common.cancel'.tr),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _storage.clearAll();
              _refresh();
            },
            child: Text(
              'concierge_history.clear_all'.tr,
              style: TextStyle(color: colors.error),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DATE HELPERS
  // ═══════════════════════════════════════════════════════════════════════════

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  String _formatTime(DateTime date) {
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}';
  }
}
