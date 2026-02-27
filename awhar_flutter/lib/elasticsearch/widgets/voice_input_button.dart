import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Supported voice input languages with their STT locale IDs.
enum VoiceLang {
  arabic('ar_MA', 'العربية', '🇲🇦'),
  french('fr_FR', 'Français', '🇫🇷'),
  english('en_US', 'English', '🇺🇸');

  final String localeId;
  final String label;
  final String flag;
  const VoiceLang(this.localeId, this.label, this.flag);

  VoiceLang get next => VoiceLang.values[(index + 1) % VoiceLang.values.length];
}

/// Professional voice input button for the AI Concierge chat.
///
/// Features:
/// - Tap to start/stop listening
/// - Real-time speech-to-text transcription
/// - Animated pulse ring while listening
/// - Live waveform visualizer
/// - Auto-detects locale (Arabic/Darija, French, Spanish, English)
/// - Sends transcribed text to the chat on completion
class VoiceInputButton extends StatefulWidget {
  /// Called with the final transcribed text when the user is done speaking.
  final ValueChanged<String> onResult;

  /// Whether the parent is currently processing (disables the button).
  final bool isProcessing;

  const VoiceInputButton({
    super.key,
    required this.onResult,
    this.isProcessing = false,
  });

  @override
  State<VoiceInputButton> createState() => _VoiceInputButtonState();
}

class _VoiceInputButtonState extends State<VoiceInputButton>
    with TickerProviderStateMixin {
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _speechAvailable = false;
  bool _isListening = false;
  String _transcribedText = '';
  String _partialText = '';
  double _soundLevel = 0.0;

  /// Current voice language — persisted across sessions.
  late VoiceLang _voiceLang;

  static const _storageKey = 'voice_input_lang';

  // Animations
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late Animation<double> _pulseAnimation;

  // Waveform bars
  final List<double> _waveformBars = List.filled(24, 0.15);
  Timer? _waveTimer;

  @override
  void initState() {
    super.initState();
    _loadSavedLang();
    _initAnimations();
    _initSpeech();
  }

  void _loadSavedLang() {
    try {
      final saved = GetStorage().read<int>(_storageKey);
      if (saved != null && saved < VoiceLang.values.length) {
        _voiceLang = VoiceLang.values[saved];
      } else {
        // Default to Arabic for Morocco
        _voiceLang = VoiceLang.arabic;
      }
    } catch (_) {
      _voiceLang = VoiceLang.arabic;
    }
  }

  void _cycleLang() {
    setState(() => _voiceLang = _voiceLang.next);
    GetStorage().write(_storageKey, _voiceLang.index);
    // If currently listening, restart with new locale
    if (_isListening) {
      _speech.stop();
      _startListening();
    }
  }

  void _initAnimations() {
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  Future<void> _initSpeech() async {
    try {
      _speechAvailable = await _speech.initialize(
        onStatus: _onSpeechStatus,
        onError: (error) {
          debugPrint('[VoiceInput] Speech error: ${error.errorMsg}');
          if (error.permanent) {
            setState(() => _speechAvailable = false);
          }
          _stopListening();
        },
      );
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint('[VoiceInput] Speech init failed: $e');
      _speechAvailable = false;
    }
  }

  void _onSpeechStatus(String status) {
    debugPrint('[VoiceInput] Speech status: $status');
    if (status == 'done' || status == 'notListening') {
      if (_isListening) {
        _finishListening();
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    _waveTimer?.cancel();
    if (_isListening) _speech.stop();
    super.dispose();
  }

  // ═══════════════════════════════════════════════════════════════════
  // LISTENING CONTROLS
  // ═══════════════════════════════════════════════════════════════════

  Future<void> _toggleListening() async {
    if (widget.isProcessing) return;

    if (_isListening) {
      _finishListening();
    } else {
      await _startListening();
    }
  }

  Future<void> _startListening() async {
    if (!_speechAvailable) {
      // Re-try init in case permission was granted after first attempt
      await _initSpeech();
      if (!_speechAvailable) {
        _showUnavailableSnack();
        return;
      }
    }

    HapticFeedback.mediumImpact();

    setState(() {
      _isListening = true;
      _transcribedText = '';
      _partialText = '';
      _soundLevel = 0.0;
    });

    _pulseController.repeat();
    _startWaveformSimulation();

    await _speech.listen(
      onResult: (result) {
        setState(() {
          _partialText = result.recognizedWords;
          if (result.finalResult && result.recognizedWords.isNotEmpty) {
            _transcribedText = result.recognizedWords;
          }
        });
      },
      onSoundLevelChange: (level) {
        // SpeechToText returns dBFS (-50 to 0 typically). Normalize to 0..1.
        final normalized = ((level + 50) / 50).clamp(0.0, 1.0);
        setState(() => _soundLevel = normalized);
      },
      localeId: _getSpeechLocale(),
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 4),
      cancelOnError: false,
      listenMode: stt.ListenMode.dictation,
    );
  }

  void _finishListening() {
    _speech.stop();
    _stopListening();

    final resultText = _transcribedText.isNotEmpty
        ? _transcribedText
        : _partialText;
    if (resultText.trim().isNotEmpty) {
      HapticFeedback.lightImpact();
      widget.onResult(resultText.trim());
    }
  }

  void _stopListening() {
    _pulseController.stop();
    _pulseController.reset();
    _waveTimer?.cancel();
    setState(() {
      _isListening = false;
      _soundLevel = 0.0;
      _waveformBars.fillRange(0, _waveformBars.length, 0.15);
    });
  }

  void _cancelListening() {
    HapticFeedback.lightImpact();
    _speech.cancel();
    _stopListening();
    setState(() {
      _transcribedText = '';
      _partialText = '';
    });
  }

  void _showUnavailableSnack() {
    Get.snackbar(
      'voice_input.unavailable_title'.tr,
      'voice_input.unavailable_message'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.red.shade900,
      duration: const Duration(seconds: 3),
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // WAVEFORM SIMULATION
  // ═══════════════════════════════════════════════════════════════════

  void _startWaveformSimulation() {
    final rng = math.Random();
    _waveTimer = Timer.periodic(const Duration(milliseconds: 80), (_) {
      if (!mounted || !_isListening) return;
      setState(() {
        for (int i = 0; i < _waveformBars.length; i++) {
          // Mix real sound level with randomness for organic feel
          final base = _soundLevel * 0.7;
          final noise = rng.nextDouble() * 0.3;
          _waveformBars[i] = (base + noise).clamp(0.08, 1.0);
        }
      });
    });
  }

  // ═══════════════════════════════════════════════════════════════════
  // LOCALE
  // ═══════════════════════════════════════════════════════════════════

  String _getSpeechLocale() => _voiceLang.localeId;

  // ═══════════════════════════════════════════════════════════════════
  // BUILD
  // ═══════════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    if (_isListening) {
      return _buildListeningOverlay(context);
    }
    return _buildMicButton(context);
  }

  /// The small mic button shown in the input bar (idle state).
  Widget _buildMicButton(BuildContext context) {
    final colors = AppColors.of(context);
    final disabled = widget.isProcessing || !_speechAvailable;

    return GestureDetector(
      onTap: disabled ? null : _toggleListening,
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: disabled
              ? colors.textMuted.withValues(alpha: 0.3)
              : colors.primary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.mic_rounded,
          color: disabled ? colors.textMuted : colors.primary,
          size: 22.sp,
        ),
      ),
    );
  }

  /// Full-width listening overlay that replaces the input bar.
  Widget _buildListeningOverlay(BuildContext context) {
    final colors = AppColors.of(context);
    final displayText = _partialText.isNotEmpty
        ? _partialText
        : 'voice_input.listening'.tr;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: colors.surfaceElevated,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(
          color: colors.primary.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Cancel button
          _buildCancelButton(colors),
          SizedBox(width: 6.w),

          // Language toggle
          _buildLangChip(colors),
          SizedBox(width: 6.w),

          // Waveform + transcription
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Live waveform
                SizedBox(
                  height: 24.h,
                  child: _buildWaveform(colors),
                ),
                SizedBox(height: 4.h),
                // Live transcription text
                Text(
                  displayText,
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: _partialText.isNotEmpty
                        ? colors.textPrimary
                        : colors.textMuted,
                    fontStyle: _partialText.isEmpty
                        ? FontStyle.italic
                        : FontStyle.normal,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),

          // Animated recording indicator + send
          _buildSendButton(colors),
        ],
      ),
    );
  }

  /// Tappable language chip — cycles ar → fr → en.
  Widget _buildLangChip(AppColorScheme colors) {
    return GestureDetector(
      onTap: _cycleLang,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: colors.primarySoft,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: colors.primary.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _voiceLang.flag,
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(width: 4.w),
            Text(
              _voiceLang.label,
              style: AppTypography.labelSmall(context).copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCancelButton(AppColorScheme colors) {
    return GestureDetector(
      onTap: _cancelListening,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: colors.errorSoft,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.close_rounded,
          color: colors.error,
          size: 18.sp,
        ),
      ),
    );
  }

  Widget _buildSendButton(AppColorScheme colors) {
    return GestureDetector(
      onTap: _finishListening,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Pulse ring
              Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.primary.withValues(
                        alpha: 1.5 - _pulseAnimation.value,
                      ),
                      width: 2,
                    ),
                  ),
                ),
              ),
              // Core button
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: colors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _partialText.isNotEmpty
                      ? Icons.send_rounded
                      : Icons.mic_rounded,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWaveform(AppColorScheme colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(_waveformBars.length, (i) {
        final height = (_waveformBars[i] * 20.h).clamp(2.0, 20.h);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 60),
          width: 2.5.w,
          height: height,
          decoration: BoxDecoration(
            color: colors.primary.withValues(
              alpha: 0.4 + (_waveformBars[i] * 0.6),
            ),
            borderRadius: BorderRadius.circular(2.r),
          ),
        );
      }),
    );
  }
}
