import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../core/services/image_picker_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../controllers/concierge_controller.dart';
import '../widgets/concierge_chat.dart';
import '../widgets/voice_input_button.dart';

/// AI Concierge Request Screen — conversational service request creation.
///
/// ## Architecture: Kibana Agent Builder
///
/// This screen connects to AI agents configured in Kibana Agent Builder:
///
/// ```
/// User types message → Serverpod proxy → Kibana Agent Builder API
///                                             ↓
///                                        LLM (Claude/GPT)
///                                             ↓
///                                        ES|QL Tools
///                                             ↓
///                                     Elasticsearch Data
///                                             ↓
///                              Agent response + tool steps
///                                             ↓
///                                    Chat UI with steps
/// ```
///
/// The agent uses ES|QL tools to query awhar-services, awhar-products,
/// awhar-knowledge-base, etc. directly — no Dart agent code involved.
///
/// Falls back to direct ELSER search if Agent Builder is unavailable.
///
/// Elasticsearch features demonstrated:
/// - Kibana Agent Builder with ES|QL tools
/// - LLM connectors (Claude, GPT, Gemini)
/// - Multi-turn conversation management
/// - ELSER v2 semantic search (fallback)
/// - Multi-language support (EN/FR/AR)
class ConciergeRequestScreen extends StatefulWidget {
  const ConciergeRequestScreen({super.key});

  @override
  State<ConciergeRequestScreen> createState() => _ConciergeRequestScreenState();
}

class _ConciergeRequestScreenState extends State<ConciergeRequestScreen> {
  late final ConciergeController _controller;
  final _scrollController = ScrollController();
  final _inputController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isVoiceMode = false;
  File? _attachedImage;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(ConciergeController());

    // Handle navigation arguments for resume/new conversation
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      if (args['resumeConversationId'] != null) {
        _controller.resumeConversation(args['resumeConversationId'] as String);
      } else if (args['newConversation'] == true) {
        _controller.startNewConversation();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _inputController.dispose();
    _focusNode.dispose();
    Get.delete<ConciergeController>();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _onSend() {
    final text = _inputController.text.trim();

    // If image is attached, send image message
    if (_attachedImage != null) {
      final img = _attachedImage!;
      _inputController.clear();
      setState(() => _attachedImage = null);
      _controller.sendImageMessage(img, text: text);
      _scrollToBottom();
      Future.delayed(const Duration(milliseconds: 500), _scrollToBottom);
      return;
    }

    if (text.isEmpty) return;
    _inputController.clear();
    _controller.sendMessage(text);
    _scrollToBottom();

    // Scroll again after the response arrives
    Future.delayed(
      const Duration(milliseconds: 500),
      _scrollToBottom,
    );
  }

  Future<void> _pickImage() async {
    final picker = Get.find<ImagePickerService>();
    final file = await picker.showImageSourcePicker();
    if (file != null && mounted) {
      setState(() => _attachedImage = file);
    }
  }

  void _onProceedToForm() {
    final args = _controller.buildRequestArguments();
    Get.toNamed(AppRoutes.createRequest, arguments: args);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: _buildAppBar(context, colors),
      body: Column(
        children: [
          // ES info banner (for judges)
          _buildEsBanner(context, colors),

          // Chat messages
          Expanded(
            child: ConciergeChat(
              controller: _controller,
              scrollController: _scrollController,
            ),
          ),

          // "Proceed to form" button when service is selected
          Obx(() {
            if (_controller.selectedServiceIndex.value >= 0) {
              return _buildProceedButton(context, colors);
            }
            return const SizedBox.shrink();
          }),

          // Input bar
          _buildInputBar(context, colors),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    AppColorScheme colors,
  ) {
    return AppBar(
      backgroundColor: colors.surfaceElevated,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: colors.textPrimary),
        onPressed: () => Get.back(),
      ),
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              'assets/appiconnobackgound.png',
              width: 32.w,
              height: 32.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'concierge_chat.title'.tr,
                style: AppTypography.titleSmall(context).copyWith(
                  color: colors.textPrimary,
                ),
              ),
              Text(
                'concierge_chat.subtitle'.tr,
                style: AppTypography.labelSmall(context).copyWith(
                  color: colors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        // Conversation history
        IconButton(
          icon: Icon(Icons.history, color: colors.textMuted, size: 20.sp),
          onPressed: () => Get.toNamed(AppRoutes.aiConciergeHistory),
          tooltip: 'concierge_history.title'.tr,
        ),
        // Reset chat
        IconButton(
          icon: Icon(Icons.refresh, color: colors.textMuted, size: 20.sp),
          onPressed: () {
            _controller.resetChat();
            _inputController.clear();
          },
          tooltip: 'concierge_chat.reset'.tr,
        ),
      ],
    );
  }

  /// Banner showing ES feature info — visible for judges to understand
  /// what's happening under the hood.
  Widget _buildEsBanner(BuildContext context, AppColorScheme colors) {
    return Obx(() {
      final toolCount = _controller.totalToolCalls.value;

      if (toolCount == 0) return const SizedBox.shrink();

      final modeLabel = 'Elasticsearch Agent';
      final toolInfo = toolCount > 0 ? ' • $toolCount tools' : '';

      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        color: colors.infoSoft,
        child: Row(
          children: [
            Icon(Icons.bolt, size: 14.sp, color: colors.info),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                '$modeLabel'
                '$toolInfo'
                '${_controller.detectedLanguage.value.isNotEmpty ? ' • ${_controller.detectedLanguage.value.toUpperCase()}' : ''}',
                style: AppTypography.labelSmall(context).copyWith(
                  color: colors.info,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildProceedButton(BuildContext context, AppColorScheme colors) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: colors.surfaceElevated,
        border: Border(
          top: BorderSide(color: colors.border, width: 0.5),
        ),
      ),
      child: ElevatedButton.icon(
        onPressed: _onProceedToForm,
        icon: const Icon(Icons.arrow_forward, color: Colors.white),
        label: Text(
          'concierge_chat.proceed_to_form'.tr,
          style: AppTypography.labelLarge(context).copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  void _onVoiceResult(String text) {
    setState(() => _isVoiceMode = false);
    _inputController.text = text;
    _onSend();
  }

  Widget _buildInputBar(BuildContext context, AppColorScheme colors) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image preview strip
        if (_attachedImage != null) _buildImagePreview(colors),

        // Input row
        Container(
          padding: EdgeInsets.only(
            left: 12.w,
            right: 8.w,
            top: 8.h,
            bottom: MediaQuery.of(context).padding.bottom + 8.h,
          ),
          decoration: BoxDecoration(
            color: colors.surfaceElevated,
            border: Border(
              top: BorderSide(color: colors.border, width: 0.5),
            ),
          ),
          child: Obx(() {
            final processing = _controller.isProcessing.value;

            // Voice mode: show the listening overlay
            if (_isVoiceMode) {
              return VoiceInputButton(
                onResult: _onVoiceResult,
                isProcessing: processing,
              );
            }

            // Normal text mode
            return Row(
              children: [
                // Mic button
                GestureDetector(
                  onTap: processing
                      ? null
                      : () => setState(() => _isVoiceMode = true),
                  child: Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: processing
                          ? colors.textMuted.withValues(alpha: 0.15)
                          : colors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.mic_rounded,
                      color: processing ? colors.textMuted : colors.primary,
                      size: 18.sp,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),

                // Image attach button
                GestureDetector(
                  onTap: processing ? null : _pickImage,
                  child: Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: _attachedImage != null
                          ? colors.primary.withValues(alpha: 0.2)
                          : processing
                              ? colors.textMuted.withValues(alpha: 0.15)
                              : colors.surface,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _attachedImage != null
                            ? colors.primary
                            : colors.border,
                        width: _attachedImage != null ? 1.5 : 1,
                      ),
                    ),
                    child: Icon(
                      Icons.photo_camera_rounded,
                      color: _attachedImage != null
                          ? colors.primary
                          : processing
                              ? colors.textMuted
                              : colors.textSecondary,
                      size: 18.sp,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),

                // Text field
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    focusNode: _focusNode,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _onSend(),
                    maxLines: 3,
                    minLines: 1,
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: colors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: _attachedImage != null
                          ? 'concierge_chat.image_hint'.tr
                          : 'concierge_chat.input_hint'.tr,
                      hintStyle: AppTypography.bodyMedium(context).copyWith(
                        color: colors.textMuted,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide(color: colors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide(color: colors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide:
                            BorderSide(color: colors.primary, width: 1.5),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      filled: true,
                      fillColor: colors.surface,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),

                // Send button
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: processing ? colors.textMuted : colors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: processing ? null : _onSend,
                    icon: Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  /// Thumbnail preview of attached image with remove button.
  Widget _buildImagePreview(AppColorScheme colors) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: colors.surfaceElevated,
        border: Border(
          top: BorderSide(color: colors.border, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.file(
              _attachedImage!,
              width: 56.w,
              height: 56.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10.w),

          // Label
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'concierge_chat.image_attached'.tr,
                  style: AppTypography.labelMedium(context).copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'concierge_chat.image_attached_hint'.tr,
                  style: AppTypography.labelSmall(context).copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ],
            ),
          ),

          // Remove button
          GestureDetector(
            onTap: () => setState(() => _attachedImage = null),
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: colors.errorSoft,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_rounded,
                color: colors.error,
                size: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
