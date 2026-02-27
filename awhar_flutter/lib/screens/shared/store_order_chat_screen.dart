import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/controllers/auth_controller.dart';
import '../../core/services/audio_recording_service.dart';
import '../../core/services/media_upload_service.dart';
import '../../shared/widgets/image_picker_button.dart';
import '../../shared/widgets/audio_player_widget.dart';

/// Store Order Chat Controller
/// Manages 3-way chat between client, store, and driver
class StoreOrderChatController extends GetxController {
  late final Client _client;
  late final AuthController _authController;

  final int orderId;
  final String userRole; // 'client', 'store', 'driver'

  StoreOrderChatController({
    required this.orderId,
    required this.userRole,
  });

  /// Get current user ID
  int? get _userId => _authController.currentUser.value?.id;
  String get _userName => _authController.currentUser.value?.fullName ?? 'User';

  // ============================================================
  // OBSERVABLE STATE
  // ============================================================

  /// Chat messages
  final RxList<StoreOrderChatMessage> messages = <StoreOrderChatMessage>[].obs;

  /// Chat info
  final Rx<StoreOrderChat?> chat = Rx<StoreOrderChat?>(null);

  /// Participant info
  final RxString clientName = 'Client'.obs;
  final RxString storeName = 'Store'.obs;
  final RxString driverName = 'Driver'.obs;
  final RxnInt driverId = RxnInt(null);

  /// Loading states
  final RxBool isLoading = false.obs;
  final RxBool isSending = false.obs;

  /// Error message
  final RxString errorMessage = ''.obs;

  // ============================================================
  // LIFECYCLE
  // ============================================================

  @override
  void onInit() {
    super.onInit();
    _client = Get.find<Client>();
    _authController = Get.find<AuthController>();
  }

  @override
  void onReady() {
    super.onReady();
    loadChat();
  }

  // ============================================================
  // CHAT LOADING
  // ============================================================

  /// Load or create chat and messages
  Future<void> loadChat() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Get or create chat
      final orderChat = await _client.storeDelivery.getOrCreateOrderChat(
        orderId: orderId,
      );
      chat.value = orderChat;

      // Load participant names
      await _loadParticipantsInfo();

      // Load messages
      await loadMessages();
    } catch (e) {
      debugPrint('[StoreOrderChatController] Error loading chat: $e');
      errorMessage.value = 'Failed to load chat';
    } finally {
      isLoading.value = false;
    }
  }

  /// Load participant names from server
  Future<void> _loadParticipantsInfo() async {
    try {
      final info = await _client.storeDelivery.getChatParticipantsInfo(
        orderId: orderId,
      );
      if (info != null) {
        clientName.value = info.clientName;
        storeName.value = info.storeName;
        if (info.driverName != null) {
          driverName.value = info.driverName!;
          driverId.value = info.driverId;
        }
      }
    } catch (e) {
      debugPrint('[StoreOrderChatController] Error loading participants: $e');
    }
  }

  /// Load chat messages
  Future<void> loadMessages() async {
    try {
      final chatMessages = await _client.storeDelivery.getChatMessages(
        orderId: orderId,
        limit: 100,
        offset: 0,
      );
      // Reverse to show oldest first
      messages.assignAll(chatMessages.reversed.toList());
    } catch (e) {
      debugPrint('[StoreOrderChatController] Error loading messages: $e');
    }
  }

  @override
  /// Refresh messages
  Future<void> refresh() async {
    await loadMessages();
  }

  // ============================================================
  // SENDING MESSAGES
  // ============================================================

  /// Send a text message
  Future<bool> sendMessage(String content) async {
    if (content.trim().isEmpty || _userId == null) return false;

    try {
      isSending.value = true;

      final message = await _client.storeDelivery.sendChatMessage(
        orderId: orderId,
        senderId: _userId!,
        senderRole: userRole,
        senderName: _userName,
        content: content.trim(),
        messageType: 'text',
      );

      if (message != null) {
        messages.add(message);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreOrderChatController] Error sending message: $e');
      errorMessage.value = 'Failed to send message';
      return false;
    } finally {
      isSending.value = false;
    }
  }

  /// Send a location message
  Future<bool> sendLocation(double lat, double lng) async {
    if (_userId == null) return false;

    try {
      isSending.value = true;

      final message = await _client.storeDelivery.sendChatMessage(
        orderId: orderId,
        senderId: _userId!,
        senderRole: userRole,
        senderName: _userName,
        content: 'Shared location',
        messageType: 'location',
        latitude: lat,
        longitude: lng,
      );

      if (message != null) {
        messages.add(message);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreOrderChatController] Error sending location: $e');
      return false;
    } finally {
      isSending.value = false;
    }
  }

  /// Send an image message
  Future<bool> sendImageMessage(String imageUrl) async {
    if (_userId == null || imageUrl.isEmpty) return false;

    try {
      isSending.value = true;
      debugPrint(
        '[StoreOrderChatController] 📤 Sending image message: $imageUrl',
      );

      final message = await _client.storeDelivery.sendChatMessage(
        orderId: orderId,
        senderId: _userId!,
        senderRole: userRole,
        senderName: _userName,
        content: '📷 Image',
        messageType: 'image',
        attachmentUrl: imageUrl,
      );

      if (message != null) {
        messages.add(message);
        debugPrint('[StoreOrderChatController] ✅ Image message sent');
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreOrderChatController] Error sending image: $e');
      errorMessage.value = 'Failed to send image';
      return false;
    } finally {
      isSending.value = false;
    }
  }

  /// Send an audio message
  Future<bool> sendAudioMessage(String audioUrl, int durationMs) async {
    if (_userId == null || audioUrl.isEmpty) return false;

    try {
      isSending.value = true;
      debugPrint(
        '[StoreOrderChatController] 📤 Sending audio message: $audioUrl',
      );

      final message = await _client.storeDelivery.sendChatMessage(
        orderId: orderId,
        senderId: _userId!,
        senderRole: userRole,
        senderName: _userName,
        content:
            '🎙️ Voice message (${(durationMs / 1000).toStringAsFixed(1)}s)',
        messageType: 'audio',
        attachmentUrl: audioUrl,
      );

      if (message != null) {
        messages.add(message);
        debugPrint('[StoreOrderChatController] ✅ Audio message sent');
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreOrderChatController] Error sending audio: $e');
      errorMessage.value = 'Failed to send audio';
      return false;
    } finally {
      isSending.value = false;
    }
  }

  /// Handle audio recording - upload and send
  Future<bool> handleAudioRecording(File audioFile, int durationMs) async {
    if (isSending.value) return false;

    try {
      isSending.value = true;
      debugPrint(
        '[StoreOrderChatController] 🎙️ Handling audio recording: duration=${durationMs}ms',
      );

      final mediaUploadService = Get.find<MediaUploadService>();

      // Upload audio to Firebase
      final uploadResult = await mediaUploadService.uploadAudio(
        audioFile: audioFile,
        requestId: orderId.toString(),
        durationMs: durationMs,
      );

      if (uploadResult == null) {
        debugPrint('[StoreOrderChatController] ❌ Upload returned null');
        Get.snackbar('Error', 'Failed to upload audio');
        return false;
      }

      final audioUrl = uploadResult['audioUrl'] ?? '';
      if (audioUrl.isEmpty) {
        debugPrint('[StoreOrderChatController] ❌ Audio URL is empty');
        Get.snackbar('Error', 'Failed to upload audio');
        return false;
      }

      // Send the audio message
      isSending.value = false; // Reset before calling sendAudioMessage
      return await sendAudioMessage(audioUrl, durationMs);
    } catch (e) {
      debugPrint('[StoreOrderChatController] ❌ Error handling audio: $e');
      Get.snackbar('Error', 'Failed to send audio');
      return false;
    } finally {
      isSending.value = false;
    }
  }

  /// Share current location as a message
  Future<bool> shareLocation() async {
    if (_userId == null) return false;

    try {
      isSending.value = true;
      debugPrint('[StoreOrderChatController] 📍 Requesting location...');

      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'Permission Required',
          'Location permission is needed to share your location',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return false;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      final locationUrl =
          'https://maps.google.com/?q=${position.latitude},${position.longitude}';
      final locationContent =
          '📍 Location: ${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';

      debugPrint('[StoreOrderChatController] 📍 Sending location: $locationContent');

      final message = await _client.storeDelivery.sendChatMessage(
        orderId: orderId,
        senderId: _userId!,
        senderRole: userRole,
        senderName: _userName,
        content: locationContent,
        messageType: 'location',
        attachmentUrl: locationUrl,
        latitude: position.latitude,
        longitude: position.longitude,
      );

      if (message != null) {
        messages.add(message);
        debugPrint('[StoreOrderChatController] ✅ Location message sent');
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[StoreOrderChatController] ❌ Error sharing location: $e');
      Get.snackbar(
        'Error',
        'Failed to share location: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isSending.value = false;
    }
  }

  // ============================================================
  // HELPERS
  // ============================================================

  /// Check if message is from current user
  bool isMyMessage(StoreOrderChatMessage message) {
    return message.senderId == _userId;
  }

  /// Get role color
  Color getRoleColor(String role) {
    switch (role) {
      case 'client':
        return Colors.blue;
      case 'store':
        return Colors.purple;
      case 'driver':
        return Colors.green;
      case 'system':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  /// Get role icon
  IconData getRoleIcon(String role) {
    switch (role) {
      case 'client':
        return Iconsax.user;
      case 'store':
        return Iconsax.shop;
      case 'driver':
        return Iconsax.car;
      case 'system':
        return Iconsax.info_circle;
      default:
        return Iconsax.user;
    }
  }
}

/// Store Order Chat Screen
/// 3-way chat between client, store, and driver
class StoreOrderChatScreen extends StatefulWidget {
  final int orderId;
  final String userRole; // 'client', 'store', 'driver'

  const StoreOrderChatScreen({
    super.key,
    required this.orderId,
    required this.userRole,
  });

  @override
  State<StoreOrderChatScreen> createState() => _StoreOrderChatScreenState();
}

class _StoreOrderChatScreenState extends State<StoreOrderChatScreen> {
  late final StoreOrderChatController _controller;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = Get.put(
      StoreOrderChatController(
        orderId: widget.orderId,
        userRole: widget.userRole,
      ),
      tag: 'chat_${widget.orderId}',
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    Get.delete<StoreOrderChatController>(tag: 'chat_${widget.orderId}');
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Chat',
              style: AppTypography.titleMedium(context).copyWith(
                color: colors.textPrimary,
              ),
            ),
            Obx(() {
              final chat = _controller.chat.value;
              if (chat == null) return const SizedBox.shrink();
              return Text(
                _getParticipantsText(chat),
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 11.sp,
                ),
              );
            }),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Iconsax.refresh, color: colors.primary),
            onPressed: () => _controller.refresh(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat participants indicator
          _ParticipantsBar(controller: _controller, colors: colors),

          // Messages
          Expanded(
            child: Obx(() {
              if (_controller.isLoading.value && _controller.messages.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_controller.messages.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.message,
                        size: 64.sp,
                        color: colors.textSecondary.withOpacity(0.5),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No messages yet',
                        style: AppTypography.bodyMedium(context).copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Start the conversation!',
                        style: TextStyle(
                          color: colors.textSecondary.withOpacity(0.7),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                );
              }

              WidgetsBinding.instance.addPostFrameCallback(
                (_) => _scrollToBottom(),
              );

              return ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(16.w),
                itemCount: _controller.messages.length,
                itemBuilder: (context, index) {
                  final message = _controller.messages[index];
                  final showHeader =
                      index == 0 ||
                      _controller.messages[index - 1].senderRole !=
                          message.senderRole;

                  return _MessageBubble(
                    message: message,
                    controller: _controller,
                    colors: colors,
                    showHeader: showHeader,
                  );
                },
              );
            }),
          ),

          // Input bar
          _MessageInputBar(
            controller: _controller,
            messageController: _messageController,
            colors: colors,
            onSent: _scrollToBottom,
          ),
        ],
      ),
    );
  }

  String _getParticipantsText(StoreOrderChat chat) {
    final participants = <String>[];
    participants.add(_controller.clientName.value);
    participants.add(_controller.storeName.value);
    if (chat.driverId != null) {
      participants.add(_controller.driverName.value);
    }
    return participants.join(' • ');
  }
}

class _ParticipantsBar extends StatelessWidget {
  final StoreOrderChatController controller;
  final dynamic colors;

  const _ParticipantsBar({
    required this.controller,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.surface,
            colors.background,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: colors.textSecondary.withValues(alpha: 0.1),
        ),
      ),
      child: Obx(() {
        final chat = controller.chat.value;
        final hasDriver = chat?.driverId != null;
        
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.people,
                  size: 14.sp,
                  color: colors.textSecondary,
                ),
                SizedBox(width: 6.w),
                Text(
                  'chat.participants'.tr,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            // Participants row
            Row(
              children: [
                // Client
                Expanded(
                  child: _ParticipantCard(
                    name: controller.clientName.value,
                    role: 'client.title'.tr,
                    icon: Iconsax.user,
                    color: Colors.blue,
                    isCurrentUser: controller.userRole == 'client',
                    colors: colors,
                  ),
                ),
                // Connector line
                _ConnectorLine(color: Colors.purple.withValues(alpha: 0.3)),
                // Store
                Expanded(
                  child: _ParticipantCard(
                    name: controller.storeName.value,
                    role: 'store.title'.tr,
                    icon: Iconsax.shop,
                    color: Colors.purple,
                    isCurrentUser: controller.userRole == 'store',
                    colors: colors,
                  ),
                ),
                // Connector line
                _ConnectorLine(
                  color: hasDriver 
                      ? Colors.green.withValues(alpha: 0.3) 
                      : Colors.grey.withValues(alpha: 0.2),
                ),
                // Driver
                Expanded(
                  child: _ParticipantCard(
                    name: hasDriver ? controller.driverName.value : null,
                    role: 'driver.title'.tr,
                    icon: Icons.two_wheeler,
                    color: Colors.green,
                    isCurrentUser: controller.userRole == 'driver',
                    isDisabled: !hasDriver,
                    colors: colors,
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}

/// Connector line between participants
class _ConnectorLine extends StatelessWidget {
  final Color color;
  
  const _ConnectorLine({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16.w,
      height: 2.h,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(1.r),
      ),
    );
  }
}

/// Individual participant card with avatar and name
class _ParticipantCard extends StatelessWidget {
  final String? name;
  final String role;
  final IconData icon;
  final Color color;
  final bool isCurrentUser;
  final bool isDisabled;
  final dynamic colors;

  const _ParticipantCard({
    required this.name,
    required this.role,
    required this.icon,
    required this.color,
    required this.colors,
    this.isCurrentUser = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = isDisabled ? Colors.grey : color;
    final displayName = name ?? 'common.waiting'.tr;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar circle
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDisabled 
                ? Colors.grey.withValues(alpha: 0.1)
                : effectiveColor.withValues(alpha: isCurrentUser ? 1.0 : 0.1),
            border: isCurrentUser
                ? Border.all(color: effectiveColor, width: 2.5)
                : Border.all(
                    color: effectiveColor.withValues(alpha: 0.3),
                    width: 1,
                  ),
            boxShadow: isCurrentUser
                ? [
                    BoxShadow(
                      color: effectiveColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            size: 18.sp,
            color: isDisabled 
                ? Colors.grey 
                : (isCurrentUser ? Colors.white : effectiveColor),
          ),
        ),
        SizedBox(height: 6.h),
        // Name
        SizedBox(
          width: 70.w,
          child: Text(
            displayName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.w500,
              color: isDisabled 
                  ? Colors.grey 
                  : (isCurrentUser ? effectiveColor : colors.textPrimary),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // Role label
        SizedBox(height: 2.h),
        Text(
          role,
          style: TextStyle(
            fontSize: 8.sp,
            color: colors.textSecondary,
          ),
        ),
        // "You" indicator
        if (isCurrentUser) ...[
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: effectiveColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              'common.you'.tr,
              style: TextStyle(
                fontSize: 8.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _ParticipantChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isActive;
  final bool isDisabled;

  const _ParticipantChip({
    required this.label,
    required this.icon,
    required this.color,
    this.isActive = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isDisabled
            ? Colors.grey.withValues(alpha: 0.1)
            : (isActive ? color : color.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(16.r),
        border: isActive ? Border.all(color: color, width: 2) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14.sp,
            color: isDisabled ? Colors.grey : (isActive ? Colors.white : color),
          ),
          SizedBox(width: 4.w),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                color: isDisabled
                    ? Colors.grey
                    : (isActive ? Colors.white : color),
                fontSize: 11.sp,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final StoreOrderChatMessage message;
  final StoreOrderChatController controller;
  final dynamic colors;
  final bool showHeader;

  const _MessageBubble({
    required this.message,
    required this.controller,
    required this.colors,
    required this.showHeader,
  });

  @override
  Widget build(BuildContext context) {
    final isMe = controller.isMyMessage(message);
    final roleColor = controller.getRoleColor(message.senderRole);

    // System messages
    if (message.senderRole == 'system') {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          message.content,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.sp,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 4.h,
          top: showHeader ? 8.h : 0,
          left: isMe ? 48.w : 0,
          right: isMe ? 0 : 48.w,
        ),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            // Header with name and role
            if (showHeader)
              Padding(
                padding: EdgeInsets.only(bottom: 4.h, left: 4.w, right: 4.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      controller.getRoleIcon(message.senderRole),
                      size: 12.sp,
                      color: roleColor,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      message.senderName,
                      style: TextStyle(
                        color: roleColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

            // Message bubble
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isMe ? roleColor : colors.surface,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image message
                  if (message.messageType == 'image' &&
                      message.attachmentUrl != null &&
                      message.attachmentUrl!.isNotEmpty)
                    GestureDetector(
                      onTap: () => _openFullImage(message.attachmentUrl!),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: CachedNetworkImage(
                          imageUrl: message.attachmentUrl!,
                          width: 200.w,
                          height: 200.h,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 200.w,
                            height: 200.h,
                            color: colors.background,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: colors.primary,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 200.w,
                            height: 200.h,
                            color: colors.background,
                            child: Icon(
                              Icons.broken_image,
                              color: colors.textSecondary,
                              size: 48.sp,
                            ),
                          ),
                        ),
                      ),
                    )
                  // Audio message
                  else if (message.messageType == 'audio' &&
                      message.attachmentUrl != null &&
                      message.attachmentUrl!.isNotEmpty)
                    Container(
                      constraints: BoxConstraints(maxWidth: 240.w),
                      child: AudioPlayerWidget(
                        audioUrl: message.attachmentUrl!,
                      ),
                    )
                  // Location message
                  else if (message.messageType == 'location' &&
                      message.latitude != null &&
                      message.longitude != null)
                    GestureDetector(
                      onTap: () =>
                          _openLocation(message.latitude!, message.longitude!),
                      child: Container(
                        width: 200.w,
                        decoration: BoxDecoration(
                          color: colors.background,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isMe
                                ? Colors.white.withOpacity(0.2)
                                : colors.primary.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Map thumbnail
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.r),
                                topRight: Radius.circular(12.r),
                              ),
                              child: Stack(
                                children: [
                                  // Google Maps Static API thumbnail
                                  CachedNetworkImage(
                                    imageUrl:
                                        'https://maps.googleapis.com/maps/api/staticmap?center=${message.latitude},${message.longitude}&zoom=15&size=400x200&markers=color:red%7C${message.latitude},${message.longitude}&key=AIzaSyDSM4oBnZ5LKHSVDVBfYDK0yvJPV3PDH0c',
                                    width: 200.w,
                                    height: 120.h,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      width: 200.w,
                                      height: 120.h,
                                      color: colors.background,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: colors.primary,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      width: 200.w,
                                      height: 120.h,
                                      color: colors.background,
                                      child: Center(
                                        child: Icon(
                                          Iconsax.location,
                                          color: colors.primary,
                                          size: 40.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Overlay with "Open in Maps" hint
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.7),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.map_outlined,
                                            size: 14.sp,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            'Open in Maps',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Coordinates info
                            Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.location,
                                    size: 14.sp,
                                    color: isMe
                                        ? Colors.white70
                                        : colors.primary,
                                  ),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: Text(
                                      '${message.latitude!.toStringAsFixed(4)}, ${message.longitude!.toStringAsFixed(4)}',
                                      style: TextStyle(
                                        color: isMe
                                            ? Colors.white70
                                            : colors.textSecondary,
                                        fontSize: 11.sp,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  // Text message (default)
                  else
                    Text(
                      message.content,
                      style: TextStyle(
                        color: isMe ? Colors.white : colors.textPrimary,
                        fontSize: 14.sp,
                      ),
                    ),

                  // Timestamp
                  SizedBox(height: 4.h),
                  Text(
                    DateFormat('HH:mm').format(message.createdAt),
                    style: TextStyle(
                      color: isMe ? Colors.white60 : colors.textSecondary,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openLocation(double lat, double lng) async {
    try {
      final mapUrl = 'https://maps.google.com/?q=$lat,$lng';
      debugPrint('[StoreOrderChat] Opening location: $mapUrl');
      
      // Open in Google Maps or browser
      if (await canLaunchUrl(Uri.parse(mapUrl))) {
        await launchUrl(
          Uri.parse(mapUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        Get.snackbar(
          'Error',
          'Could not open maps',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint('[StoreOrderChat] Error opening location: $e');
      Get.snackbar(
        'Error',
        'Failed to open location',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _openFullImage(String imageUrl) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            // Full screen image
            GestureDetector(
              onTap: () => Get.back(),
              child: InteractiveViewer(
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.broken_image,
                      color: Colors.white,
                      size: 64,
                    ),
                  ),
                ),
              ),
            ),
            // Close button
            Positioned(
              top: 48,
              right: 16,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageInputBar extends StatefulWidget {
  final StoreOrderChatController controller;
  final TextEditingController messageController;
  final dynamic colors;
  final VoidCallback onSent;

  const _MessageInputBar({
    required this.controller,
    required this.messageController,
    required this.colors,
    required this.onSent,
  });

  @override
  State<_MessageInputBar> createState() => _MessageInputBarState();
}

class _MessageInputBarState extends State<_MessageInputBar> {
  final RxString _messageText = ''.obs;

  @override
  void initState() {
    super.initState();
    widget.messageController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    _messageText.value = widget.messageController.text;
  }

  @override
  void dispose() {
    widget.messageController.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioService = Get.find<AudioRecordingService>();

    return Obx(() {
      final isRecording = audioService.isRecording.value;

      return Container(
        decoration: BoxDecoration(
          color: widget.colors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
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
                ? _buildRecordingBar(audioService)
                : _buildNormalInputBar(),
          ),
        ),
      );
    });
  }

  Widget _buildNormalInputBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Image attachment button
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: widget.colors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: ImagePickerButton(
            onImageUploaded: (imageUrl, thumbnailUrl, fileSizeBytes) async {
              await widget.controller.sendImageMessage(imageUrl);
              widget.onSent();
            },
            iconColor: widget.colors.primary,
          ),
        ),

        SizedBox(width: 4.w),

        // Location button
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: widget.colors.textSecondary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Iconsax.location,
              color: widget.colors.textSecondary,
              size: 20.sp,
            ),
            onPressed: () => _shareLocation(context),
            padding: EdgeInsets.zero,
          ),
        ),

        SizedBox(width: 8.w),

        // Text input
        Expanded(
          child: Container(
            constraints: BoxConstraints(maxHeight: 120.h),
            decoration: BoxDecoration(
              color: widget.colors.background,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: widget.colors.primary.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: TextField(
              controller: widget.messageController,
              style: TextStyle(color: widget.colors.textPrimary),
              maxLines: 5,
              minLines: 1,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(
                  color: widget.colors.textSecondary.withOpacity(0.6),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
              ),
            ),
          ),
        ),

        SizedBox(width: 8.w),

        // Send or Mic button
        Obx(() {
          final hasText = _messageText.value.trim().isNotEmpty;
          final isSending = widget.controller.isSending.value;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.colors.primary,
                  widget.colors.primary.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: widget.colors.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(22.r),
                onTap: isSending ? null : (hasText ? _sendMessage : null),
                onLongPress: isSending || hasText
                    ? null
                    : () {
                        // Start audio recording
                        Get.find<AudioRecordingService>().startRecording();
                      },
                child: Center(
                  child: isSending
                      ? SizedBox(
                          width: 22.w,
                          height: 22.w,
                          child: const CircularProgressIndicator(
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
                            size: 22.sp,
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

  Widget _buildRecordingBar(AudioRecordingService audioService) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(
          color: Colors.red.withOpacity(0.3),
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
                color: Colors.red.withOpacity(0.2),
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
            child: Obx(() => _buildAnimatedWaveform(audioService)),
          ),

          SizedBox(width: 12.w),

          // Recording duration
          Obx(
            () => Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
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
                          color: Colors.red.withOpacity(value),
                          shape: BoxShape.circle,
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
            ),
          ),

          SizedBox(width: 12.w),

          // Send button
          GestureDetector(
            onTap: () async {
              final path = await audioService.stopRecording();
              if (path != null && path.isNotEmpty) {
                final file = File(path);
                final durationMs = audioService.recordingDuration.value * 1000;
                final success = await widget.controller.handleAudioRecording(
                  file,
                  durationMs,
                );
                if (success) {
                  widget.onSent();
                }
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
                    color: Colors.green.withOpacity(0.3),
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

  Widget _buildAnimatedWaveform(AudioRecordingService audioService) {
    final amplitude = audioService.amplitude.value;
    const barCount = 20;

    return SizedBox(
      height: 32.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(barCount, (index) {
          const baseHeight = 4.0;
          const maxHeight = 28.0;
          final targetHeight =
              baseHeight + (amplitude * (maxHeight - baseHeight));
          final variation = (index % 5) * 0.12 + (index % 3) * 0.08;
          final barHeight = (targetHeight * (0.7 + variation)).clamp(
            baseHeight,
            maxHeight,
          );

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
                  Colors.red.withOpacity(0.5),
                ],
              ),
              borderRadius: BorderRadius.circular(2.r),
            ),
          );
        }),
      ),
    );
  }

  void _sendMessage() async {
    final text = widget.messageController.text.trim();
    if (text.isEmpty) return;

    final success = await widget.controller.sendMessage(text);
    if (success) {
      widget.messageController.clear();
      widget.onSent();
    }
  }

  void _shareLocation(BuildContext context) async {
    final hasText = _messageText.value.trim().isNotEmpty;
    if (hasText) {
      // Send message first if there's text
      _sendMessage();
      return;
    }

    // Share location
    final success = await widget.controller.shareLocation();
    if (success) {
      widget.onSent();
    }
  }
}
