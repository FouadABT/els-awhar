import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../controllers/concierge_controller.dart';

/// A chat message bubble for the AI Concierge conversation.
///
/// Displays user messages (right-aligned, primary color) and
/// AI messages (left-aligned, surface color) with appropriate styling.
/// AI messages support full Markdown rendering (bold, italic, lists, etc.).
class ConciergeMessageBubble extends StatefulWidget {
  final ConciergeMessage message;

  const ConciergeMessageBubble({
    super.key,
    required this.message,
  });

  @override
  State<ConciergeMessageBubble> createState() => _ConciergeMessageBubbleState();
}

/// Shared TTS instance so only one message speaks at a time.
FlutterTts? _sharedTts;
String? _currentSpeakingId;

class _ConciergeMessageBubbleState extends State<ConciergeMessageBubble> {
  ConciergeMessage get message => widget.message;
  bool _isSpeaking = false;

  FlutterTts get _tts {
    _sharedTts ??= FlutterTts();
    return _sharedTts!;
  }

  @override
  void dispose() {
    if (_currentSpeakingId == message.id) {
      _tts.stop();
      _currentSpeakingId = null;
    }
    super.dispose();
  }

  Future<void> _toggleSpeak() async {
    if (_isSpeaking) {
      await _tts.stop();
      _currentSpeakingId = null;
      if (mounted) setState(() => _isSpeaking = false);
      return;
    }

    // Stop any other bubble that's speaking
    if (_currentSpeakingId != null) {
      await _tts.stop();
    }

    // Strip markdown for cleaner TTS
    final plainText = _stripMarkdown(message.text);
    if (plainText.trim().isEmpty) return;

    // Auto-detect language
    final lang = _detectLanguage(plainText);
    await _tts.setLanguage(lang);
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);

    _tts.setCompletionHandler(() {
      _currentSpeakingId = null;
      if (mounted) setState(() => _isSpeaking = false);
    });

    _currentSpeakingId = message.id;
    setState(() => _isSpeaking = true);
    await _tts.speak(plainText);
  }

  /// Simple markdown stripping for TTS.
  String _stripMarkdown(String md) {
    return md
        .replaceAll(RegExp(r'```[\s\S]*?```'), '') // code blocks
        .replaceAll(RegExp(r'`[^`]+`'), '') // inline code
        .replaceAll(RegExp(r'#{1,6}\s'), '') // headers
        .replaceAll(RegExp(r'\*\*([^*]+)\*\*'), r'$1') // bold
        .replaceAll(RegExp(r'\*([^*]+)\*'), r'$1') // italic
        .replaceAll(RegExp(r'\[([^\]]+)\]\([^)]+\)'), r'$1') // links
        .replaceAll(RegExp(r'^[\-\*]\s', multiLine: true), '') // list bullets
        .replaceAll(RegExp(r'^\d+\.\s', multiLine: true), '') // numbered lists
        .replaceAll(RegExp(r'\|[^\n]+\|'), '') // tables
        .replaceAll(RegExp(r'---+'), '') // hr
        .replaceAll(RegExp(r'\n{3,}'), '\n\n') // excess newlines
        .trim();
  }

  /// Detect language from text content.
  String _detectLanguage(String text) {
    // Check for Arabic characters
    if (RegExp(r'[\u0600-\u06FF]').hasMatch(text)) return 'ar';
    // Check for French-specific characters
    if (RegExp(
      r'[\u00E0\u00E2\u00E7\u00E8\u00E9\u00EA\u00EB\u00EE\u00EF\u00F4\u00F9\u00FB\u00FC\u0153]',
      caseSensitive: false,
    ).hasMatch(text)) {
      return 'fr-FR';
    }
    // Heuristic: common French words
    final lower = text.toLowerCase();
    if (RegExp(
      r'\b(les|des|une|est|dans|pour|avec|sur|qui|que|vous|nous|pas|sont|cette|mais|aussi|tout|bien)\b',
    ).hasMatch(lower)) {
      return 'fr-FR';
    }
    return 'en-US';
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    if (message.isLoading) {
      return _buildLoadingBubble(context, colors);
    }

    if (message.isStreaming) {
      return _buildStreamingBubble(context, colors);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Row(
            mainAxisAlignment: message.isUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!message.isUser) ...[
                _buildAvatar(colors),
                SizedBox(width: 8.w),
              ],
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: message.isUser ? colors.primary : colors.surfaceElevated,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                      bottomLeft: Radius.circular(
                        message.isUser ? 16.r : 4.r,
                      ),
                      bottomRight: Radius.circular(
                        message.isUser ? 4.r : 16.r,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: message.isUser
                      ? _buildUserContent(context)
                      : _buildMarkdownBody(context, colors),
                ),
              ),

              // TTS play button for AI messages
              if (!message.isUser &&
                  !message.isLoading &&
                  !message.isStreaming &&
                  message.text.isNotEmpty)
                _buildTtsButton(context, colors),

              if (message.isUser) SizedBox(width: 8.w),
            ],
          ),
        ),

        // Token usage / cost info row below AI bubbles
        if (!message.isUser &&
            !message.isLoading &&
            !message.isStreaming &&
            message.inputTokens != null)
          _buildTokenUsageRow(colors),
      ],
    );
  }

  /// Build user message content — text only, or image + text.
  Widget _buildUserContent(BuildContext context) {
    final hasImage =
        message.imagePath != null && message.imagePath!.isNotEmpty;

    if (!hasImage) {
      return Text(
        message.text,
        style: AppTypography.bodyMedium(context).copyWith(
          color: Colors.white,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image thumbnail
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Image.file(
            File(message.imagePath!),
            width: 180.w,
            height: 140.h,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 180.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Icon(
                  Icons.broken_image_rounded,
                  color: Colors.white70,
                  size: 24.sp,
                ),
              ),
            ),
          ),
        ),
        if (message.text.isNotEmpty) ...[
          SizedBox(height: 6.h),
          Text(
            message.text,
            style: AppTypography.bodyMedium(context).copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ],
    );
  }

  /// Token usage and cost info displayed below AI bubbles.
  Widget _buildTokenUsageRow(AppColorScheme colors) {
    final input = message.inputTokens ?? 0;
    final output = message.outputTokens ?? 0;
    final cost = message.estimatedCostUsd;
    final model = message.model ?? '';
    final calls = message.llmCalls ?? 0;

    // Format model name for display
    String displayModel = model;
    if (model.contains('gemini-2.5-pro') || model.contains('gemini-2-5-pro')) {
      displayModel = 'Gemini 2.5 Pro';
    } else if (model.contains('gemini-2.5-flash') || model.contains('gemini-2-5-flash')) {
      displayModel = 'Gemini 2.5 Flash';
    } else if (model.contains('claude')) {
      displayModel = 'Claude';
    }

    final costStr = cost != null
        ? '\$${cost.toStringAsFixed(4)}'
        : '—';

    return Padding(
      padding: EdgeInsets.only(left: 42.w, top: 2.h, bottom: 2.h),
      child: Row(
        children: [
          Icon(Icons.token_outlined, size: 11.sp, color: colors.textMuted),
          SizedBox(width: 3.w),
          Text(
            '$displayModel  •  ${_formatTokens(input)} in / ${_formatTokens(output)} out  •  $calls calls  •  $costStr',
            style: TextStyle(
              fontSize: 10.sp,
              color: colors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  /// Format token count (e.g. 15922 → "15.9K")
  String _formatTokens(int tokens) {
    if (tokens >= 1000000) {
      return '${(tokens / 1000000).toStringAsFixed(1)}M';
    } else if (tokens >= 1000) {
      return '${(tokens / 1000).toStringAsFixed(1)}K';
    }
    return '$tokens';
  }

  /// Small play/stop button for text-to-speech on AI messages.
  Widget _buildTtsButton(BuildContext context, AppColorScheme colors) {
    return GestureDetector(
      onTap: _toggleSpeak,
      child: Padding(
        padding: EdgeInsets.only(left: 4.w, top: 2.h),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 28.w,
          height: 28.w,
          decoration: BoxDecoration(
            color: _isSpeaking
                ? colors.primary.withValues(alpha: 0.15)
                : colors.surface,
            shape: BoxShape.circle,
            border: Border.all(
              color: _isSpeaking
                  ? colors.primary.withValues(alpha: 0.4)
                  : colors.border,
              width: 1,
            ),
          ),
          child: Icon(
            _isSpeaking ? Icons.stop_rounded : Icons.volume_up_rounded,
            size: 14.sp,
            color: _isSpeaking ? colors.primary : colors.textMuted,
          ),
        ),
      ),
    );
  }

  /// Build a Markdown-rendered body for AI messages.
  ///
  /// Renders bold, italic, lists, code blocks, headers, and links
  /// from the LLM's raw markdown output.
  Widget _buildMarkdownBody(BuildContext context, AppColorScheme colors) {
    final textColor = colors.textPrimary;
    final baseStyle = AppTypography.bodyMedium(context).copyWith(
      color: textColor,
    );

    return MarkdownBody(
      data: message.text,
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        // Body text
        p: baseStyle,

        // Bold
        strong: baseStyle.copyWith(fontWeight: FontWeight.w700),

        // Italic
        em: baseStyle.copyWith(fontStyle: FontStyle.italic),

        // Headers
        h1: AppTypography.titleLarge(context).copyWith(
          color: textColor,
          fontWeight: FontWeight.w700,
        ),
        h2: AppTypography.titleMedium(context).copyWith(
          color: textColor,
          fontWeight: FontWeight.w700,
        ),
        h3: AppTypography.titleSmall(context).copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),

        // Links
        a: baseStyle.copyWith(
          color: colors.primary,
          decoration: TextDecoration.underline,
        ),

        // Lists
        listBullet: baseStyle.copyWith(color: colors.primary),
        listBulletPadding: EdgeInsets.only(right: 8.w),

        // Code inline
        code: baseStyle.copyWith(
          fontFamily: 'monospace',
          fontSize: 12.sp,
          backgroundColor: colors.surface,
          color: colors.primary,
        ),

        // Code block
        codeblockDecoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: colors.border,
          ),
        ),
        codeblockPadding: EdgeInsets.all(10.w),

        // Blockquote
        blockquote: baseStyle.copyWith(
          color: colors.textSecondary,
          fontStyle: FontStyle.italic,
        ),
        blockquoteDecoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: colors.primary.withValues(alpha: 0.5),
              width: 3,
            ),
          ),
        ),
        blockquotePadding: EdgeInsets.only(left: 12.w, top: 4.h, bottom: 4.h),

        // Table
        tableHead: baseStyle.copyWith(fontWeight: FontWeight.w600),
        tableBody: baseStyle,
        tableBorder: TableBorder.all(
          color: colors.border,
          width: 1,
        ),
        tableCellsPadding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 4.h,
        ),

        // Horizontal rule
        horizontalRuleDecoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: colors.border,
              width: 1,
            ),
          ),
        ),

        // Spacing
        pPadding: EdgeInsets.only(bottom: 4.h),
        h1Padding: EdgeInsets.only(bottom: 8.h),
        h2Padding: EdgeInsets.only(bottom: 6.h),
        h3Padding: EdgeInsets.only(bottom: 4.h),
      ),
    );
  }

  /// Build a streaming message bubble showing real-time agent activity.
  ///
  /// Displays:
  /// - Reasoning text with pulsing indicator ("Thinking: Let me search...")
  /// - Tool call badges as they happen ("🔍 search_services", "📊 get_prices")
  /// - Answer text streaming in as it's generated
  Widget _buildStreamingBubble(BuildContext context, AppColorScheme colors) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(colors),
          SizedBox(width: 8.w),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: colors.surfaceElevated,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(4.r),
                  bottomRight: Radius.circular(16.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Reasoning indicator
                  if (message.streamingReasoning != null &&
                      message.streamingReasoning!.isNotEmpty) ...[
                    Row(
                      children: [
                        _PulsingIcon(
                          icon: Icons.psychology,
                          color: colors.primary,
                          size: 16.sp,
                        ),
                        SizedBox(width: 6.w),
                        Flexible(
                          child: Text(
                            message.streamingReasoning!.length > 120
                                ? '${message.streamingReasoning!.substring(0, 120)}...'
                                : message.streamingReasoning!,
                            style: AppTypography.bodySmall(context).copyWith(
                              color: colors.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                  ],

                  // Tool call badges
                  if (message.streamingToolNames != null &&
                      message.streamingToolNames!.isNotEmpty) ...[
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 4.h,
                      children: message.streamingToolNames!.map((tool) {
                        final isActive = tool == message.streamingToolName;
                        return _ToolBadge(
                          toolName: tool,
                          isActive: isActive,
                          colors: colors,
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 8.h),
                  ],

                  // Active tool with spinner
                  if (message.streamingToolName != null &&
                      (message.streamingToolNames == null ||
                          message.streamingToolNames!.isEmpty)) ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 14.w,
                          height: 14.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colors.primary,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          _formatToolName(message.streamingToolName!),
                          style: AppTypography.bodySmall(context).copyWith(
                            color: colors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                  ],

                  // Answer text (streaming in)
                  if (message.streamingText != null &&
                      message.streamingText!.isNotEmpty)
                    _buildMarkdownBody(context, colors)
                  else if (message.streamingReasoning == null &&
                      message.streamingToolName == null &&
                      (message.streamingToolNames == null ||
                          message.streamingToolNames!.isEmpty))
                    // Nothing to show yet — show pulsing dots
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _AnimatedDot(delay: 0, color: colors.primary),
                        SizedBox(width: 4.w),
                        _AnimatedDot(delay: 200, color: colors.primary),
                        SizedBox(width: 4.w),
                        _AnimatedDot(delay: 400, color: colors.primary),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Format tool name for display: "awhar.search_services" → "Search Services"
  String _formatToolName(String toolName) {
    // Remove prefix
    var name = toolName;
    if (name.contains('.')) {
      name = name.split('.').last;
    }
    // Convert snake_case to Title Case
    return name
        .split('_')
        .map(
          (word) => word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1)}'
              : '',
        )
        .join(' ');
  }

  Widget _buildAvatar(AppColorScheme colors) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Image.asset(
        'assets/appiconnobackgound.png',
        width: 32.w,
        height: 32.w,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildLoadingBubble(BuildContext context, AppColorScheme colors) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(colors),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 14.h,
            ),
            decoration: BoxDecoration(
              color: colors.surfaceElevated,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _AnimatedDot(delay: 0, color: colors.primary),
                SizedBox(width: 4.w),
                _AnimatedDot(delay: 200, color: colors.primary),
                SizedBox(width: 4.w),
                _AnimatedDot(delay: 400, color: colors.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated dot for the "thinking" loading indicator.
class _AnimatedDot extends StatefulWidget {
  final int delay;
  final Color color;

  const _AnimatedDot({required this.delay, required this.color});

  @override
  State<_AnimatedDot> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<_AnimatedDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Opacity(
        opacity: _animation.value,
        child: Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

/// Pulsing icon for streaming reasoning indicator.
class _PulsingIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final double size;

  const _PulsingIcon({
    required this.icon,
    required this.color,
    required this.size,
  });

  @override
  State<_PulsingIcon> createState() => _PulsingIconState();
}

class _PulsingIconState extends State<_PulsingIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Opacity(
        opacity: _animation.value,
        child: Icon(
          widget.icon,
          color: widget.color,
          size: widget.size,
        ),
      ),
    );
  }
}

/// Tool call badge shown during streaming.
class _ToolBadge extends StatelessWidget {
  final String toolName;
  final bool isActive;
  final AppColorScheme colors;

  const _ToolBadge({
    required this.toolName,
    required this.isActive,
    required this.colors,
  });

  /// Get a descriptive icon for the tool.
  IconData get _toolIcon {
    final name = toolName.toLowerCase();
    if (name.contains('search')) return Icons.search;
    if (name.contains('price') || name.contains('cost'))
      return Icons.attach_money;
    if (name.contains('driver') || name.contains('match'))
      return Icons.person_search;
    if (name.contains('location') || name.contains('geo'))
      return Icons.location_on;
    if (name.contains('order') || name.contains('request'))
      return Icons.receipt_long;
    if (name.contains('user') || name.contains('profile')) return Icons.person;
    if (name.contains('review') || name.contains('rating')) return Icons.star;
    if (name.contains('index') || name.contains('mapping'))
      return Icons.storage;
    return Icons.build;
  }

  /// Format tool name: "awhar.search_services" → "Search Services"
  String get _displayName {
    var name = toolName;
    if (name.contains('.')) name = name.split('.').last;
    return name
        .split('_')
        .map(
          (w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '',
        )
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isActive
            ? colors.primary.withValues(alpha: 0.15)
            : colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isActive
              ? colors.primary.withValues(alpha: 0.4)
              : colors.border,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isActive) ...[
            SizedBox(
              width: 12.w,
              height: 12.w,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: colors.primary,
              ),
            ),
          ] else ...[
            Icon(
              Icons.check_circle,
              size: 12.sp,
              color: Colors.green,
            ),
          ],
          SizedBox(width: 4.w),
          Icon(_toolIcon, size: 12.sp, color: colors.primary),
          SizedBox(width: 4.w),
          Text(
            _displayName,
            style: TextStyle(
              fontSize: 11.sp,
              color: isActive ? colors.primary : colors.textSecondary,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
