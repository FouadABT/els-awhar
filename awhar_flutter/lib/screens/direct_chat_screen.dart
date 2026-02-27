import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:awhar_client/awhar_client.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/services/chat_service.dart';
import '../core/services/media_upload_service.dart';
import '../core/controllers/auth_controller.dart';
import '../core/models/message.dart';
import '../core/utils/url_utils.dart';
import '../shared/widgets/image_picker_button.dart';
import '../shared/widgets/audio_record_button.dart';
import '../shared/widgets/image_message_widget.dart';
import '../shared/widgets/audio_player_widget.dart';
import '../core/services/audio_recording_service.dart';
import '../core/services/presence_service.dart';
import 'report_screen.dart';

/// Direct chat screen (Client <-> Driver without request)
class DirectChatScreen extends StatefulWidget {
  const DirectChatScreen({super.key});

  @override
  State<DirectChatScreen> createState() => _DirectChatScreenState();
}

class _DirectChatScreenState extends State<DirectChatScreen> {
  final ChatService _chatService = Get.find<ChatService>();
  final AuthController _authController = Get.find<AuthController>();
  
  // Message list
  final RxList<Message> messages = <Message>[].obs;
  StreamSubscription<List<Message>>? _messagesSubscription;
  
  // UI controllers
  final TextEditingController messageController = TextEditingController();
  final FocusNode messageFocusNode = FocusNode();
  final ScrollController scrollController = ScrollController();
  
  // State
  final RxBool isLoading = true.obs;
  final RxBool isSending = false.obs;
  
  // Other user info (driver)
  late DriverProfile driver;
  String get currentUserId => _authController.currentUser.value?.id.toString() ?? '';
  String get currentUserName => _authController.currentUser.value?.fullName ?? 'You';
  String? get currentUserAvatar => _authController.currentUser.value?.profilePhotoUrl;
  
  @override
  void initState() {
    super.initState();
    
    // Get peer info from arguments: can be DriverProfile (client side)
    // or a Map with client info (driver side inbox -> direct chat)
    final args = Get.arguments;
    DriverProfile? driverData;

    if (args is DriverProfile) {
      driverData = args;
    } else if (args is Map) {
      final clientIdStr = args['clientId']?.toString();
      final clientName = args['clientName']?.toString() ?? 'Client';
      final clientAvatar = args['clientAvatar']?.toString();

      final clientId = int.tryParse(clientIdStr ?? '');
      if (clientId != null) {
        driverData = DriverProfile(
          userId: clientId,
          displayName: clientName,
          profilePhotoUrl: clientAvatar,
        );
      }
    }

    if (driverData == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.back();
        Get.snackbar('errors.error'.tr, 'chat.invalid_request'.tr);
      });
      return;
    }

    driver = driverData;
    _initializeChat();
  }
  
  Future<void> _initializeChat() async {
    try {
      isLoading.value = true;
      
      final currentUser = _authController.currentUser.value;
      if (currentUser == null) {
        Get.back();
        return;
      }
      
      final clientId = currentUser.id.toString();
      final driverId = driver.userId.toString();
      
      debugPrint('[DirectChat] 🔧 Initializing: client=$clientId, driver=$driverId');
      
      // Initialize chat in Firebase with participant info
      await _chatService.initializeDirectChat(
        clientId: clientId,
        driverId: driverId,
        clientName: currentUser.fullName,
        clientAvatar: currentUser.profilePhotoUrl,
        driverName: driver.displayName,
        driverAvatar: driver.profilePhotoUrl,
      );
      
      // Listen to messages
      _messagesSubscription = _chatService.listenToDirectMessages(
        clientId,
        driverId,
      ).listen(
        (msgs) {
          debugPrint('[DirectChat] 📩 Received ${msgs.length} messages');
          messages.assignAll(msgs);
          isLoading.value = false;
          
          // Mark as read
          if (msgs.isNotEmpty) {
            _chatService.markDirectAsRead(
              clientId: clientId,
              driverId: driverId,
              userId: currentUserId,
            );
          }
        },
        onError: (e) {
          debugPrint('[DirectChat] ❌ Stream error: $e');
          isLoading.value = false;
        },
      );
      
      isLoading.value = false;
      debugPrint('[DirectChat] ✅ Initialized');
    } catch (e) {
      debugPrint('[DirectChat] ❌ Error initializing: $e');
      isLoading.value = false;
      Get.snackbar('errors.error'.tr, 'chat.load_error'.tr);
    }
  }
  
  Future<void> _sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty || isSending.value) return;
    
    isSending.value = true;
    
    try {
      final currentUser = _authController.currentUser.value;
      if (currentUser == null) return;
      
      final clientId = currentUser.id.toString();
      final driverId = driver.userId.toString();
      
      final success = await _chatService.sendDirectMessage(
        clientId: clientId,
        driverId: driverId,
        text: text,
        senderId: currentUserId,
        senderName: currentUserName,
        senderAvatar: currentUserAvatar,
      );
      
      if (success) {
        messageController.clear();
        messageFocusNode.requestFocus();
      } else {
        Get.snackbar('errors.error'.tr, 'chat.send_error'.tr);
      }
    } catch (e) {
      debugPrint('[DirectChat] ❌ Error sending: $e');
      Get.snackbar('errors.error'.tr, 'chat.send_error'.tr);
    } finally {
      isSending.value = false;
    }
  }

  /// Send media message (audio, image, video)
  Future<void> _sendMediaMessage(String mediaUrl, String mediaType, int sizeBytesOrDuration, {bool alreadySending = false}) async {
    if (!alreadySending && isSending.value) return;
    
    if (!alreadySending) {
      isSending.value = true;
    }
    
    try {
      final currentUser = _authController.currentUser.value;
      if (currentUser == null) return;
      
      final clientId = currentUser.id.toString();
      final driverId = driver.userId.toString();
      
      // For audio, sizeBytesOrDuration is duration in ms
      // For images, it's file size in bytes
      final success = await _chatService.sendDirectMessage(
        clientId: clientId,
        driverId: driverId,
        text: '',
        senderId: currentUserId,
        senderName: currentUserName,
        senderAvatar: currentUserAvatar,
        mediaUrl: mediaUrl,
        mediaType: mediaType,
        mediaSizeBytes: mediaType == 'image' ? sizeBytesOrDuration : null,
        mediaDurationMs: mediaType == 'audio' ? sizeBytesOrDuration : null,
      );
      
      if (success) {
        debugPrint('[DirectChat] ✅ Media message sent: $mediaType');
      } else {
        Get.snackbar('errors.error'.tr, 'chat.send_error'.tr);
      }
    } catch (e) {
      debugPrint('[DirectChat] ❌ Error sending media: $e');
      Get.snackbar('errors.error'.tr, 'chat.send_error'.tr);
    } finally {
      if (!alreadySending) {
        isSending.value = false;
      }
    }
  }

  /// Handle audio recording - upload and send
  Future<void> _handleAudioRecording(File audioFile, int durationMs) async {
    if (isSending.value) return;

    isSending.value = true;

    try {
      final mediaUploadService = Get.find<MediaUploadService>();
      
      debugPrint('[DirectChat] 🎙️ Uploading audio: ${audioFile.path}, duration: ${durationMs}ms');
      
      // Upload audio to Firebase
      final uploadResult = await mediaUploadService.uploadAudio(
        audioFile: audioFile,
        requestId: 'direct_chat_${driver.userId}',
        durationMs: durationMs,
      );

      if (uploadResult == null) {
        debugPrint('[DirectChat] ❌ Upload failed - no result');
        Get.snackbar('errors.error'.tr, 'chat.upload_error'.tr);
        return;
      }

      final audioUrl = uploadResult['audioUrl'] ?? '';
      if (audioUrl.isEmpty) {
        debugPrint('[DirectChat] ❌ Upload failed - empty URL');
        Get.snackbar('errors.error'.tr, 'chat.upload_error'.tr);
        return;
      }

      debugPrint('[DirectChat] ✅ Audio uploaded: $audioUrl');
      
      // Send message with uploaded audio URL - pass alreadySending: true to avoid double-lock
      await _sendMediaMessage(audioUrl, 'audio', durationMs, alreadySending: true);
    } catch (e) {
      debugPrint('[DirectChat] ❌ Error handling audio: $e');
      Get.snackbar('errors.error'.tr, 'chat.upload_error'.tr);
    } finally {
      isSending.value = false;
    }
  }
  
  @override
  void dispose() {
    _messagesSubscription?.cancel();
    messageController.dispose();
    messageFocusNode.dispose();
    scrollController.dispose();
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
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            // Driver avatar
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.primary.withValues(alpha: 0.1),
              ),
              child: driver.profilePhotoUrl != null
                  ? ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: UrlUtils.normalizeImageUrl(driver.profilePhotoUrl!) ?? driver.profilePhotoUrl!,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(
                          Iconsax.user,
                          color: colors.primary,
                          size: 20.sp,
                        ),
                      ),
                    )
                  : Icon(
                      Iconsax.user,
                      color: colors.primary,
                      size: 20.sp,
                    ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driver.displayName,
                    style: AppTypography.titleMedium(context).copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Presence overlay: prefer realtime presence; fallback to server field
                  StreamBuilder<bool>(
                    stream: Get.find<PresenceService>().watchUserOnline(driver.userId),
                    builder: (context, snapshot) {
                      final online = snapshot.data ?? driver.isOnline;
                      return Row(
                        children: [
                          if (online)
                            Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                color: colors.success,
                                shape: BoxShape.circle,
                              ),
                            ),
                          if (online) SizedBox(width: 4.w),
                          Text(
                            online ? 'common.online'.tr : 'common.offline'.tr,
                            style: AppTypography.bodySmall(context).copyWith(
                              color: online ? colors.success : colors.textSecondary,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Iconsax.more, color: colors.textPrimary),
            onSelected: (value) {
              if (value == 'report') {
                Get.to(() => ReportScreen(
                  driverId: driver.id,
                  clientId: driver.userId,
                ));
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'report',
                child: Row(
                  children: [
                    Icon(Iconsax.flag, color: colors.error, size: 20.sp),
                    SizedBox(width: 12.w),
                    Text(
                      'report.report_user'.tr,
                      style: TextStyle(color: colors.error),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: Obx(() {
              if (isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(color: colors.primary),
                );
              }
              
              final msgs = messages;
              
              if (msgs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.message,
                        size: 64.sp,
                        color: colors.textSecondary.withValues(alpha: 0.5),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'chat.no_messages'.tr,
                        style: AppTypography.bodyMedium(context).copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'chat.start_conversation'.tr,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              }
              
              return ListView.builder(
                controller: scrollController,
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                itemCount: msgs.length,
                itemBuilder: (context, index) {
                  final message = msgs[index];
                  final isMe = message.senderId == currentUserId;
                  
                  return _MessageBubble(
                    message: message,
                    isMe: isMe,
                    colors: colors,
                    currentUserAvatar: currentUserAvatar,
                  );
                },
              );
            }),
          ),
          // Modern Input bar
          _buildModernInputBar(context, colors),
        ],
      ),
    );
  }

  /// Build modern input bar with recording state
  Widget _buildModernInputBar(BuildContext context, AppColorScheme colors) {
    final audioService = Get.find<AudioRecordingService>();
    
    return Obx(() {
      final isRecording = audioService.isRecording.value;
      
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isRecording ? Colors.red.withValues(alpha: 0.1) : colors.surface,
          border: Border(top: BorderSide(color: isRecording ? Colors.red.withValues(alpha: 0.3) : colors.border)),
        ),
        child: SafeArea(
          child: isRecording
              ? _buildRecordingBar(context, colors, audioService)
              : _buildNormalInputBar(context, colors, audioService),
        ),
      );
    });
  }

  /// Normal input bar with text field, image, and mic button
  Widget _buildNormalInputBar(BuildContext context, AppColorScheme colors, AudioRecordingService audioService) {
    return Row(
      children: [
        // Attachment button (image picker)
        ImagePickerButton(
          onImageUploaded: (imageUrl, thumbnailUrl, fileSizeBytes) async {
            await _sendMediaMessage(imageUrl, 'image', fileSizeBytes);
          },
        ),
        SizedBox(width: 8.w),
        // Text field (no emoji button)
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: colors.surfaceElevated,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: colors.border.withValues(alpha: 0.5)),
            ),
            child: TextField(
              controller: messageController,
              focusNode: messageFocusNode,
              style: AppTypography.bodyMedium(context).copyWith(
                color: colors.textPrimary,
              ),
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
              maxLines: 4,
              minLines: 1,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (_) => setState(() {}),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        // Send or Mic button (animated switch)
        Builder(builder: (context) {
          final hasText = messageController.text.trim().isNotEmpty;
          
          return Obx(() {
            final sending = isSending.value;
          
          return GestureDetector(
            onTap: () {
              if (sending) return;
              if (hasText) {
                _sendMessage();
              } else {
                // Start recording
                audioService.startRecording();
              }
            },
            onLongPress: hasText ? null : () {
              // Long press to start recording
              audioService.startRecording();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: hasText 
                      ? [colors.primary, colors.primary.withValues(alpha: 0.8)]
                      : [Colors.redAccent, Colors.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (hasText ? colors.primary : Colors.red).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: sending
                  ? Center(
                      child: SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  : Icon(
                      hasText ? Iconsax.send_1 : Iconsax.microphone,
                      color: Colors.white,
                      size: 22.sp,
                    ),
            ),
          );
        });
      }),
      ],
    );
  }

  /// Recording bar with waveform, duration, and controls
  Widget _buildRecordingBar(BuildContext context, AppColorScheme colors, AudioRecordingService audioService) {
    return Row(
      children: [
        // Cancel button
        GestureDetector(
          onTap: () {
            audioService.cancelRecording();
          },
          child: Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.trash,
              color: Colors.red,
              size: 20.sp,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        // Waveform visualization
        Expanded(
          child: Container(
            height: 44.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(22.r),
            ),
            child: Row(
              children: [
                // Pulsing red dot
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 600),
                  tween: Tween(begin: 0.4, end: 1.0),
                  builder: (context, value, child) {
                    return Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: value),
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                ),
                SizedBox(width: 10.w),
                // Animated waveform
                Expanded(
                  child: Obx(() => _buildAnimatedWaveform(audioService)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        // Duration
        Obx(() {
          return Text(
            audioService.formattedDuration,
            style: AppTypography.bodyMedium(context).copyWith(
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          );
        }),
        SizedBox(width: 12.w),
        // Send button
        GestureDetector(
          onTap: () async {
            final durationSeconds = audioService.recordingDuration.value;
            final path = await audioService.stopRecording();
            if (path != null) {
              final file = File(path);
              final durationMs = durationSeconds * 1000;
              await _handleAudioRecording(file, durationMs);
            }
          },
          child: Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withValues(alpha: 0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Iconsax.send_1,
              color: Colors.white,
              size: 22.sp,
            ),
          ),
        ),
      ],
    );
  }

  /// Animated waveform bars responding to amplitude
  Widget _buildAnimatedWaveform(AudioRecordingService audioService) {
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
}

class _MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final AppColorScheme colors;
  final String? currentUserAvatar;
  
  const _MessageBubble({
    required this.message,
    required this.isMe,
    required this.colors,
    this.currentUserAvatar,
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Other person's avatar (left side)
          if (!isMe) ...[
            Builder(builder: (context) {
              final rawAvatar = message.senderAvatar;
              final normalized = UrlUtils.normalizeImageUrl(rawAvatar ?? '');
              debugPrint('[DirectMessageBubble] 🖼️ Other person avatar - senderId=${message.senderId}, raw="${rawAvatar ?? ''}", normalized="${normalized ?? rawAvatar ?? ''}"');
              
              return CircleAvatar(
                radius: 16.r,
                backgroundColor: colors.primary.withValues(alpha: 0.1),
                child: rawAvatar != null && rawAvatar.isNotEmpty
                    ? ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: normalized ?? rawAvatar,
                          fit: BoxFit.cover,
                          width: 32.w,
                          height: 32.w,
                          errorWidget: (context, url, error) => Icon(
                            Iconsax.user,
                            size: 16.sp,
                            color: colors.primary,
                          ),
                          placeholder: (context, url) => SizedBox(
                            width: 12.w,
                            height: 12.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              valueColor: AlwaysStoppedAnimation(colors.primary),
                            ),
                          ),
                        ),
                      )
                    : Icon(
                        Iconsax.user,
                        size: 16.sp,
                        color: colors.primary,
                      ),
              );
            }),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: _buildDirectMessageContent(
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
              debugPrint('[DirectMessageBubble] 🖼️ My avatar - raw="${rawAvatar ?? ''}", normalized="${normalized ?? rawAvatar ?? ''}"');
              
              return CircleAvatar(
                radius: 16.r,
                backgroundColor: colors.primary.withValues(alpha: 0.1),
                child: rawAvatar != null && rawAvatar.isNotEmpty
                    ? ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: normalized ?? rawAvatar,
                          fit: BoxFit.cover,
                          width: 32.w,
                          height: 32.w,
                          errorWidget: (context, url, error) => Icon(
                            Iconsax.user,
                            size: 16.sp,
                            color: colors.primary,
                          ),
                          placeholder: (context, url) => SizedBox(
                            width: 12.w,
                            height: 12.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              valueColor: AlwaysStoppedAnimation(colors.primary),
                            ),
                          ),
                        ),
                      )
                    : Icon(
                        Iconsax.user,
                        size: 16.sp,
                        color: colors.primary,
                      ),
              );
            }),
          ],
        ],
      ),
    );
  }
}

Widget _buildDirectMessageContent({
  required Message message,
  required AppColorScheme colors,
  required BuildContext context,
  required bool isMe,
}) {
  // Image message
  if (message.mediaType == 'image' && message.mediaUrl != null) {
    return Container(
      constraints: BoxConstraints(maxWidth: 240.w),
      decoration: BoxDecoration(
        color: isMe ? colors.primary : colors.surfaceElevated,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
          bottomLeft: Radius.circular(isMe ? 16.r : 4.r),
          bottomRight: Radius.circular(isMe ? 4.r : 16.r),
        ),
        border: Border.all(
          color: colors.textSecondary.withValues(alpha: 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
          bottomLeft: Radius.circular(isMe ? 16.r : 4.r),
          bottomRight: Radius.circular(isMe ? 4.r : 16.r),
        ),
        child: ImageMessageWidget(
          imageUrl: message.mediaUrl,
        ),
      ),
    );
  }

  // Audio message
  if (message.mediaType == 'audio' && message.mediaUrl != null) {
    return Container(
      constraints: BoxConstraints(maxWidth: 280.w),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isMe ? colors.primary : colors.surfaceElevated,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
          bottomLeft: Radius.circular(isMe ? 16.r : 4.r),
          bottomRight: Radius.circular(isMe ? 4.r : 16.r),
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
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: isMe ? colors.primary : colors.surfaceElevated,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
        bottomLeft: Radius.circular(isMe ? 16.r : 4.r),
        bottomRight: Radius.circular(isMe ? 4.r : 16.r),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message.text,
          style: AppTypography.bodyMedium(context).copyWith(
            color: isMe ? Colors.white : colors.textPrimary,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          ChatService.formatTimestamp(message.timestamp),
          style: AppTypography.bodySmall(context).copyWith(
            color: isMe
                ? Colors.white.withValues(alpha: 0.7)
                : colors.textSecondary,
            fontSize: 11.sp,
          ),
        ),
      ],
    ),
  );
}
