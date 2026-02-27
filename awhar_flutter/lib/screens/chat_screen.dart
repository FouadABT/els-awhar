import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/controllers/chat_controller.dart';
import '../../core/controllers/auth_controller.dart';
import '../../core/models/message.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/services/chat_service.dart';
import '../../core/services/audio_recording_service.dart';
import '../../core/utils/url_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../shared/widgets/image_picker_button.dart';
import '../../shared/widgets/audio_record_button.dart';
import '../../shared/widgets/image_message_widget.dart';
import '../../shared/widgets/audio_player_widget.dart';
import 'report_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Obx(() {
          final otherUser = controller.otherUser.value;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                otherUser?.fullName ?? 'chat.title'.tr,
                style: AppTypography.titleLarge(context).copyWith(color: colors.textPrimary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (otherUser != null)
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Text(
                    controller.isDriver.value ? 'client'.tr : 'driver'.tr,
                    style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary),
                  ),
                ),
            ],
          );
        }),
        actions: [
          // Report user menu
          Obx(() {
            final otherUser = controller.otherUser.value;
            if (otherUser == null) return const SizedBox.shrink();
            return PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: colors.textPrimary),
              onSelected: (value) {
                if (value == 'report') {
                  Get.to(() => ReportScreen(
                    driverId: controller.isDriver.value ? null : otherUser.id,
                    clientId: controller.isDriver.value ? otherUser.id : null,
                  ));
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'report',
                  child: Row(
                    children: [
                      Icon(Icons.flag_outlined, color: colors.error, size: 20.sp),
                      SizedBox(width: 12.w),
                      Text(
                        'report.report_user'.tr,
                        style: TextStyle(color: colors.error),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(color: colors.primary),
                );
              }

              final messages = controller.messages;

              if (messages.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 64.sp,
                        color: colors.textSecondary.withValues(alpha: 0.5),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'chat.no_messages'.tr,
                        style: AppTypography.bodyMedium(context).copyWith(color: colors.textSecondary),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'chat.start_conversation'.tr,
                        style: AppTypography.bodySmall(context).copyWith(color: colors.textSecondary),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                controller: controller.scrollController,
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isMe = message.senderId == controller.currentUserId;
                  
                  // Debug logging for media messages
                  if (message.mediaUrl != null) {
                    debugPrint('[ChatScreen] 📎 MEDIA MESSAGE ${message.id}: type=${message.mediaType}, url=${message.mediaUrl}, senderId=${message.senderId}');
                  } else {
                    debugPrint('[ChatScreen] 💬 TEXT MESSAGE ${message.id}: text="${message.text.substring(0, message.text.length > 30 ? 30 : message.text.length)}", senderId=${message.senderId}');
                  }
                  
                  final showTimestamp = index == messages.length - 1 ||
                      messages[index + 1].timestamp.difference(message.timestamp).inMinutes.abs() > 5;

                  return _MessageBubble(
                    message: message,
                    isMe: isMe,
                    showTimestamp: showTimestamp,
                    isDark: isDark,
                    currentUserAvatar: Get.find<AuthController>().currentUser.value?.profilePhotoUrl,
                  );
                },
              );
            }),
          ),

          // Modern Message Input Bar
          _buildModernInputBar(context, colors, controller, isDark),
        ],
      ),
    );
  }
}

/// Modern chat input bar with beautiful UI/UX
Widget _buildModernInputBar(BuildContext context, AppColorScheme colors, ChatController controller, bool isDark) {
  final audioService = Get.find<AudioRecordingService>();
  
  return Obx(() {
    final isRecording = audioService.isRecording.value;
    
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: isRecording 
              ? _buildRecordingBar(context, colors, controller, audioService)
              : _buildNormalInputBar(context, colors, controller, isDark),
        ),
      ),
    );
  });
}

/// Normal input bar (text + buttons)
Widget _buildNormalInputBar(BuildContext context, AppColorScheme colors, ChatController controller, bool isDark) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      // Attachment button (image)
      Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: colors.primary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: ImagePickerButton(
          onImageUploaded: (imageUrl, thumbnailUrl, fileSizeBytes) async {
            await controller.sendMediaMessage(imageUrl, 'image', fileSizeBytes);
          },
          iconColor: colors.primary,
        ),
      ),
      
      SizedBox(width: 8.w),
      
      // Text input field with modern design
      Expanded(
        child: Container(
          constraints: BoxConstraints(maxHeight: 120.h),
          decoration: BoxDecoration(
            color: isDark ? colors.background : Colors.grey[100],
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: colors.primary.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller.messageController,
            focusNode: controller.messageFocusNode,
            style: AppTypography.bodyMedium(context).copyWith(
              color: colors.textPrimary,
            ),
            maxLines: 5,
            minLines: 1,
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
              hintText: 'chat.type_message'.tr,
              hintStyle: AppTypography.bodyMedium(context).copyWith(
                color: colors.textSecondary.withValues(alpha: 0.6),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
          ),
        ),
      ),
      
      SizedBox(width: 8.w),
      
      // Send or Mic button (switches based on text)
      Obx(() {
        final hasText = controller.messageText.value.trim().isNotEmpty;
        final isSending = controller.isSending.value;
        
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.primary,
                colors.primary.withValues(alpha: 0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colors.primary.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24.r),
              onTap: isSending ? null : (hasText ? controller.sendMessage : null),
              onLongPress: isSending || hasText ? null : () {
                // Start audio recording
                Get.find<AudioRecordingService>().startRecording();
              },
              child: Center(
                child: isSending
                    ? SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          hasText ? Icons.send_rounded : Icons.mic_rounded,
                          key: ValueKey(hasText),
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
              ),
            ),
          ),
        );
      }),
    ],
  );
}

/// Recording bar UI (when recording audio)
Widget _buildRecordingBar(BuildContext context, AppColorScheme colors, ChatController controller, AudioRecordingService audioService) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
    decoration: BoxDecoration(
      color: Colors.red.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(28.r),
      border: Border.all(
        color: Colors.red.withValues(alpha: 0.3),
        width: 1.5,
      ),
    ),
    child: Row(
      children: [
        // Cancel button
        GestureDetector(
          onTap: () async {
            await audioService.cancelRecording();
          },
          child: Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.delete_outline_rounded,
              color: Colors.red,
              size: 22.sp,
            ),
          ),
        ),
        
        SizedBox(width: 12.w),
        
        // Waveform visualization
        Expanded(
          child: Obx(() => _buildAnimatedWaveform(colors, audioService)),
        ),
        
        SizedBox(width: 12.w),
        
        // Recording duration
        Obx(() => Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pulsing recording indicator
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.5, end: 1.0),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, child) {
                  return Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: value),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withValues(alpha: value * 0.5),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(width: 6.w),
              Text(
                audioService.formattedDuration,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )),
        
        SizedBox(width: 12.w),
        
        // Send button
        GestureDetector(
          onTap: () async {
            final path = await audioService.stopRecording();
            if (path != null && path.isNotEmpty) {
              final file = File(path);
              final durationMs = audioService.recordingDuration.value * 1000;
              await controller.handleAudioRecording(file, durationMs);
            }
          },
          child: Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.green.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withValues(alpha: 0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.send_rounded,
              color: Colors.white,
              size: 22.sp,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Animated waveform visualization
Widget _buildAnimatedWaveform(AppColorScheme colors, AudioRecordingService audioService) {
  final amplitude = audioService.amplitude.value;
  final barCount = 30;
  
  return SizedBox(
    height: 36.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(barCount, (index) {
        // Create animated bars based on amplitude with variation
        final baseHeight = 4.0;
        final maxHeight = 32.0;
        final targetHeight = baseHeight + (amplitude * (maxHeight - baseHeight));
        
        // Add smooth variation for realistic waveform
        final variation = (index % 5) * 0.12 + (index % 3) * 0.08;
        final barHeight = (targetHeight * (0.7 + variation)).clamp(baseHeight, maxHeight);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 80),
          width: 3.w,
          height: barHeight.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.red,
                Colors.red.withValues(alpha: 0.5),
              ],
            ),
            borderRadius: BorderRadius.circular(2.r),
          ),
        );
      }),
    ),
  );
}

Widget _buildMessageContent({
  required Message message,
  required AppColorScheme colors,
  required BuildContext context,
  required bool isMe,
}) {
  // Image message
  if (message.mediaType == 'image' && message.mediaUrl != null && message.mediaUrl!.isNotEmpty) {
    debugPrint('[ChatScreen] 🖼️ Rendering IMAGE message: ${message.mediaUrl}');
    return Container(
      constraints: BoxConstraints(maxWidth: 240.w),
      decoration: BoxDecoration(
        color: isMe ? colors.primary : colors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isMe ? 16.r : 4.r),
          topRight: Radius.circular(isMe ? 4.r : 16.r),
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
        border: Border.all(
          color: colors.textSecondary.withValues(alpha: 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isMe ? 16.r : 4.r),
          topRight: Radius.circular(isMe ? 4.r : 16.r),
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
        child: ImageMessageWidget(
          imageUrl: message.mediaUrl,
        ),
      ),
    );
  }

  // Audio message
  if (message.mediaType == 'audio' && message.mediaUrl != null && message.mediaUrl!.isNotEmpty) {
    debugPrint('[ChatScreen] 🔊 Rendering AUDIO message: ${message.mediaUrl}');
    return Container(
      constraints: BoxConstraints(maxWidth: 280.w),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isMe ? colors.primary : colors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isMe ? 16.r : 4.r),
          topRight: Radius.circular(isMe ? 4.r : 16.r),
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
        border: Border.all(
          color: colors.textSecondary.withValues(alpha: 0.1),
        ),
      ),
      child: AudioPlayerWidget(
        audioUrl: message.mediaUrl!,
        durationMs: message.mediaDurationMs,
      ),
    );
  }

  // Text message (default)
  return Container(
    constraints: BoxConstraints(maxWidth: 280.w),
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
    decoration: BoxDecoration(
      color: isMe ? colors.primary : colors.surface,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(isMe ? 16.r : 4.r),
        topRight: Radius.circular(isMe ? 4.r : 16.r),
        bottomLeft: Radius.circular(16.r),
        bottomRight: Radius.circular(16.r),
      ),
    ),
    child: Text(
      message.text,
      style: AppTypography.bodyMedium(context).copyWith(
        color: isMe ? Colors.white : colors.textPrimary,
      ),
    ),
  );
}

class _MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final bool showTimestamp;
  final bool isDark;
  final String? currentUserAvatar;

  const _MessageBubble({
    required this.message,
    required this.isMe,
    required this.showTimestamp,
    required this.isDark,
    this.currentUserAvatar,
  });

  @override
  Widget build(BuildContext context) {
    final colors = isDark ? AppColors.dark : AppColors.light;
    
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Other person's avatar (left side)
              if (!isMe) ...[
                Builder(builder: (context) {
                  final rawAvatar = message.senderAvatar;
                  final normalized = UrlUtils.normalizeImageUrl(rawAvatar ?? '');
                  debugPrint('[MessageBubble] 🖼️ Other person avatar - senderId=${message.senderId}, raw="${rawAvatar ?? ''}", normalized="${normalized ?? rawAvatar ?? ''}"');
                  
                  return CircleAvatar(
                    radius: 16.r,
                    backgroundColor: colors.primary.withValues(alpha: 0.2),
                    child: rawAvatar != null && rawAvatar.isNotEmpty
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: normalized ?? rawAvatar,
                              fit: BoxFit.cover,
                              width: 32.w,
                              height: 32.w,
                              errorWidget: (context, url, error) => Center(
                                child: Text(
                                  message.senderName?.substring(0, 1).toUpperCase() ?? 'U',
                                  style: AppTypography.labelSmall(context).copyWith(color: colors.primary),
                                ),
                              ),
                              placeholder: (context, url) => Center(
                                child: SizedBox(
                                  width: 12.w,
                                  height: 12.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                    valueColor: AlwaysStoppedAnimation(colors.primary),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              message.senderName?.substring(0, 1).toUpperCase() ?? 'U',
                              style: AppTypography.labelSmall(context).copyWith(color: colors.primary),
                            ),
                          ),
                  );
                }),
                SizedBox(width: 8.w),
              ],
              Flexible(
                child: _buildMessageContent(
                  message: message,
                  colors: colors,
                  context: context,
                  isMe: isMe,
                ),
              ),
              // Your avatar (right side)
              if (isMe) ...[
                SizedBox(width: 8.w),
                Builder(builder: (context) {
                  final rawAvatar = currentUserAvatar;
                  final normalized = UrlUtils.normalizeImageUrl(rawAvatar ?? '');
                  debugPrint('[MessageBubble] 🖼️ My avatar - raw="${rawAvatar ?? ''}", normalized="${normalized ?? rawAvatar ?? ''}"');
                  
                  return CircleAvatar(
                    radius: 16.r,
                    backgroundColor: colors.primary.withValues(alpha: 0.2),
                    child: rawAvatar != null && rawAvatar.isNotEmpty
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: normalized ?? rawAvatar,
                              fit: BoxFit.cover,
                              width: 32.w,
                              height: 32.w,
                              errorWidget: (context, url, error) => Center(
                                child: Text(
                                  'U',
                                  style: AppTypography.labelSmall(context).copyWith(color: colors.primary),
                                ),
                              ),
                              placeholder: (context, url) => Center(
                                child: SizedBox(
                                  width: 12.w,
                                  height: 12.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                    valueColor: AlwaysStoppedAnimation(colors.primary),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              'U',
                              style: AppTypography.labelSmall(context).copyWith(color: colors.primary),
                            ),
                          ),
                  );
                }),
              ],
            ],
          ),
          if (showTimestamp)
            Padding(
              padding: EdgeInsets.only(
                top: 4.h,
                left: isMe ? 0 : 40.w,
                right: isMe ? 8.w : 0,
              ),
              child: Row(
                mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Text(
                    ChatService.formatTimestamp(message.timestamp),
                    style: AppTypography.labelSmall(context).copyWith(color: colors.textSecondary),
                  ),
                  if (isMe && message.read) ...[
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.done_all,
                      size: 14.sp,
                      color: colors.primary,
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}
