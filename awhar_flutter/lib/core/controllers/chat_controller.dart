import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/chat_service.dart';
import '../services/media_upload_service.dart';
import '../controllers/auth_controller.dart';
import '../models/message.dart';
import 'package:awhar_client/awhar_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

class ChatController extends GetxController {
  final ChatService _chatService = Get.find<ChatService>();
  final AuthController _authController = Get.find<AuthController>();

  // Request info
  late String requestId;
  late ServiceRequest request;
  
  // User info
  String get currentUserId => _authController.currentUser.value?.id.toString() ?? '';
  final Rx<User?> otherUser = Rx<User?>(null);
  final RxBool isDriver = false.obs;

  // Messages
  final RxList<Message> messages = <Message>[].obs;
  StreamSubscription<List<Message>>? _messagesSubscription;

  // UI state
  final RxBool isLoading = true.obs;
  final RxBool isSending = false.obs;
  final RxInt unreadCount = 0.obs;

  // Controllers
  final TextEditingController messageController = TextEditingController();
  final FocusNode messageFocusNode = FocusNode();
  final ScrollController scrollController = ScrollController();
  
  // Reactive text state for UI updates
  final RxString messageText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    
    // Listen to text changes for reactive UI
    messageController.addListener(() {
      messageText.value = messageController.text;
    });
    
    // Get parameters from route
    requestId = Get.parameters['requestId'] ?? '';
    final requestData = Get.arguments as ServiceRequest?;
    
    if (requestId.isEmpty || requestData == null) {
      Get.back();
      Get.snackbar('errors.error'.tr, 'chat.invalid_request'.tr);
      return;
    }

    request = requestData;
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    try {
      isLoading.value = true;

      // Determine if current user is driver
      final currentUser = _authController.currentUser.value;
      if (currentUser == null) {
        Get.back();
        return;
      }

      isDriver.value = request.driverId == currentUser.id;

      // Get other user info
      final client = Get.find<Client>();
      final otherUserId = isDriver.value ? request.clientId : request.driverId;
      
      if (otherUserId != null) {
        final response = await client.user.getUserById(userId: otherUserId);
        if (response.success && response.user != null) {
          otherUser.value = response.user;
        }
      }

      // Initialize chat in Firebase if needed
      debugPrint('[ChatController] 🔧 Initializing chat with requestId: $requestId');
      debugPrint('[ChatController] 👤 Current user ID: ${currentUser.id}');
      debugPrint('[ChatController] 👥 Client ID: ${request.clientId}, Driver ID: ${request.driverId}');
      
      await _chatService.initializeChat(
        requestId: requestId,
        participants: [
          request.clientId.toString(),
          if (request.driverId != null) request.driverId.toString(),
        ],
      );

      // Listen to messages
      debugPrint('[ChatController] 🎧 Starting to listen for messages on requestId: $requestId');
      _messagesSubscription = _chatService.listenToMessages(requestId).listen(
        (msgs) {
          debugPrint('[ChatController] 📩 Received ${msgs.length} messages');
          messages.assignAll(msgs);
          isLoading.value = false;

          // Mark as read if chat is open
          if (msgs.isNotEmpty) {
            _chatService.markAsRead(
              requestId: requestId,
              userId: currentUserId,
            );
          }
        },
        onError: (e) {
          debugPrint('[ChatController] ❌ Stream error: $e');
          isLoading.value = false;
        },
      );

      isLoading.value = false;
      debugPrint('[ChatController] ✅ Chat initialized: $requestId');
    } catch (e) {
      debugPrint('[ChatController] ❌ Error initializing chat: $e');
      isLoading.value = false;
      Get.snackbar('errors.error'.tr, 'chat.load_error'.tr);
    }
  }

  /// Force refresh messages from Firebase
  Future<void> refreshMessages() async {
    try {
      debugPrint('[ChatController] 🔄 Refreshing messages for: $requestId');
      
      // Cancel existing subscription
      await _messagesSubscription?.cancel();
      
      // Restart listener
      _messagesSubscription = _chatService.listenToMessages(requestId).listen(
        (msgs) {
          debugPrint('[ChatController] 📩 Refresh received ${msgs.length} messages');
          messages.assignAll(msgs);
          
          if (msgs.isNotEmpty) {
            _chatService.markAsRead(
              requestId: requestId,
              userId: currentUserId,
            );
          }
        },
        onError: (e) {
          debugPrint('[ChatController] ❌ Refresh stream error: $e');
        },
      );
    } catch (e) {
      debugPrint('[ChatController] ❌ Error refreshing: $e');
    }
  }

  /// Send a message
  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    
    if (text.isEmpty || isSending.value) return;

    try {
      isSending.value = true;

      final currentUser = _authController.currentUser.value;
      if (currentUser == null) {
        Get.snackbar('errors.error'.tr, 'auth.not_authenticated'.tr);
        return;
      }

      final success = await _chatService.sendMessage(
        requestId: requestId,
        text: text,
        senderId: currentUser.id.toString(),
        senderName: currentUser.fullName ?? 'Unknown',
        senderAvatar: currentUser.profilePhotoUrl,
      );

      if (success) {
        messageController.clear();
        debugPrint('[ChatController] ✅ Message sent successfully');
        
        // Scroll to bottom after a short delay to allow UI update
        Future.delayed(const Duration(milliseconds: 100), () {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      } else {
        Get.snackbar('errors.error'.tr, 'chat.send_error'.tr);
      }
    } catch (e) {
      debugPrint('[ChatController] ❌ Error sending message: $e');
      Get.snackbar('errors.error'.tr, 'chat.send_error'.tr);
    } finally {
      isSending.value = false;
    }
  }

  /// Send media message (audio, image, video)
  Future<void> sendMediaMessage(String mediaUrl, String mediaType, int sizeBytesOrDuration, {bool alreadySending = false}) async {
    if (!alreadySending && isSending.value) return;

    try {
      if (!alreadySending) isSending.value = true;

      final currentUser = _authController.currentUser.value;
      if (currentUser == null) {
        Get.snackbar('errors.error'.tr, 'auth.not_authenticated'.tr);
        return;
      }

      debugPrint('[ChatController] 📤 Sending media message: type=$mediaType, url=$mediaUrl');

      final success = await _chatService.sendMessage(
        requestId: requestId,
        text: '',
        senderId: currentUser.id.toString(),
        senderName: currentUser.fullName ?? 'Unknown',
        senderAvatar: currentUser.profilePhotoUrl,
        mediaUrl: mediaUrl,
        mediaType: mediaType,
      );

      if (success) {
        debugPrint('[ChatController] ✅ Media message sent successfully');
        
        // Scroll to bottom after a short delay to allow UI update
        Future.delayed(const Duration(milliseconds: 100), () {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      } else {
        debugPrint('[ChatController] ❌ Media message send failed');
        Get.snackbar('errors.error'.tr, 'chat.send_error'.tr);
      }
    } catch (e) {
      debugPrint('[ChatController] ❌ Error sending media message: $e');
      Get.snackbar('errors.error'.tr, 'chat.send_error'.tr);
    } finally {
      if (!alreadySending) isSending.value = false;
    }
  }

  /// Handle audio recording - upload and send
  Future<void> handleAudioRecording(File audioFile, int durationMs) async {
    if (isSending.value) return;

    try {
      isSending.value = true;
      debugPrint('[ChatController] 🎙️ Handling audio recording: duration=${durationMs}ms, file=${audioFile.path}');

      final mediaUploadService = Get.find<MediaUploadService>();
      
      // Upload audio to Firebase
      debugPrint('[ChatController] 📤 Uploading audio to Firebase...');
      final uploadResult = await mediaUploadService.uploadAudio(
        audioFile: audioFile,
        requestId: requestId,
        durationMs: durationMs,
      );

      if (uploadResult == null) {
        debugPrint('[ChatController] ❌ Upload returned null');
        Get.snackbar('errors.error'.tr, 'chat.upload_error'.tr);
        return;
      }

      final audioUrl = uploadResult['audioUrl'] ?? '';
      debugPrint('[ChatController] ✅ Upload complete: $audioUrl');
      
      if (audioUrl.isEmpty) {
        debugPrint('[ChatController] ❌ Audio URL is empty');
        Get.snackbar('errors.error'.tr, 'chat.upload_error'.tr);
        return;
      }

      // Send message with uploaded audio URL (pass alreadySending=true to avoid double lock)
      debugPrint('[ChatController] 📤 Sending audio message...');
      await sendMediaMessage(audioUrl, 'audio', durationMs, alreadySending: true);
      debugPrint('[ChatController] ✅ Audio message flow complete');
    } catch (e) {
      debugPrint('[ChatController] ❌ Error handling audio: $e');
      Get.snackbar('errors.error'.tr, 'chat.upload_error'.tr);
    } finally {
      isSending.value = false;
    }
  }

  @override
  void onClose() {
    _messagesSubscription?.cancel();
    messageController.dispose();
    messageFocusNode.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
