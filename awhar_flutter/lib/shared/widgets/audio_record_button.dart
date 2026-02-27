import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../core/services/audio_recording_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Audio recording button with waveform visualization
/// Features: Hold to record, waveform animation, duration display, cancel gesture
class AudioRecordButton extends StatefulWidget {
  final Function(File audioFile, int durationMs) onAudioRecorded;
  final Color? primaryColor;
  final Color? backgroundColor;

  const AudioRecordButton({
    super.key,
    required this.onAudioRecorded,
    this.primaryColor,
    this.backgroundColor,
  });

  @override
  State<AudioRecordButton> createState() => _AudioRecordButtonState();
}

class _AudioRecordButtonState extends State<AudioRecordButton>
    with SingleTickerProviderStateMixin {
  final AudioRecordingService _recordingService = Get.find<AudioRecordingService>();
  
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  bool _isDragging = false;
  double _dragDistance = 0.0;
  static const double _cancelThreshold = 100.0; // Drag 100px to cancel

  @override
  void initState() {
    super.initState();
    
    // Pulse animation for recording indicator
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  /// Handle long press start (start recording)
  Future<void> _handleLongPressStart() async {
    final success = await _recordingService.startRecording();
    if (success) {
      setState(() {});
    } else {
      // Show error
      Get.snackbar(
        'error'.tr,
        _recordingService.errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
  }

  /// Handle long press end (stop recording and send)
  Future<void> _handleLongPressEnd() async {
    if (_isDragging && _dragDistance > _cancelThreshold) {
      // Cancel recording
      await _recordingService.cancelRecording();
      setState(() {
        _isDragging = false;
        _dragDistance = 0.0;
      });
      return;
    }

    final path = await _recordingService.stopRecording();
    
    setState(() {
      _isDragging = false;
      _dragDistance = 0.0;
    });

    if (path != null && path.isNotEmpty) {
      final file = File(path);
      final durationMs = _recordingService.recordingDuration.value * 1000;
      
      // Call callback with audio file
      widget.onAudioRecorded(file, durationMs);
      
      debugPrint('[AudioRecordButton] 🎙️ Audio recorded: $path, duration: ${durationMs}ms');
    } else if (_recordingService.errorMessage.value.isNotEmpty) {
      // Show error
      Get.snackbar(
        'error'.tr,
        _recordingService.errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
  }

  /// Handle drag update (for cancel gesture)
  void _handleDragUpdate(double dx) {
    setState(() {
      _isDragging = true;
      _dragDistance = dx.abs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    
    final primaryColor = widget.primaryColor ?? colors.primary;

    return Obx(() {
      final isRecording = _recordingService.isRecording.value;

      if (isRecording) {
        return _buildRecordingUI(colors, primaryColor);
      } else {
        return _buildMicButton(primaryColor);
      }
    });
  }

  /// Build microphone button (not recording)
  Widget _buildMicButton(Color primaryColor) {
    return GestureDetector(
      onLongPress: _handleLongPressStart,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: primaryColor.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.mic,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }

  /// Build recording UI (active recording)
  Widget _buildRecordingUI(AppColorScheme colors, Color primaryColor) {
    final isCancelling = _dragDistance > _cancelThreshold;

    return GestureDetector(
      onLongPressEnd: (_) => _handleLongPressEnd(),
      onHorizontalDragUpdate: (details) => _handleDragUpdate(details.localPosition.dx),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isCancelling 
              ? Colors.red.withValues(alpha: 0.15) 
              : colors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isCancelling ? Colors.red : primaryColor,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: (isCancelling ? Colors.red : primaryColor).withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Recording indicator - Enhanced pulse
            ScaleTransition(
              scale: _pulseAnimation,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isCancelling ? Colors.red : Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withValues(alpha: 0.5),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Waveform visualization - Enhanced
            Expanded(
              child: Obx(() => _buildWaveform(colors, primaryColor, isCancelling)),
            ),

            const SizedBox(width: 12),

            // Duration - Enhanced
            Obx(() => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (isCancelling ? Colors.red : primaryColor).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _recordingService.formattedDuration,
                style: TextStyle(
                  fontSize: 14,
                  color: isCancelling ? Colors.red : primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),

            const SizedBox(width: 12),

            // Cancel/Send indicator - Enhanced
            AnimatedRotation(
              turns: isCancelling ? 0.25 : 0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isCancelling ? Icons.delete_outline : Icons.send,
                color: isCancelling ? Colors.red : primaryColor,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build waveform visualization - Enhanced
  Widget _buildWaveform(AppColorScheme colors, Color primaryColor, bool isCancelling) {
    final amplitude = _recordingService.amplitude.value;
    final baseHeight = 4.0;
    final maxHeight = 32.0;

    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(20, (index) {
          // Create animated bars based on amplitude with smooth variation
          final targetHeight = baseHeight + (amplitude * (maxHeight - baseHeight));
          
          // Add sine wave variation for better waveform look
          final variation = (index % 4) * 0.15;
          final barHeight = (targetHeight * (0.8 + variation)).clamp(baseHeight, maxHeight);

          return AnimatedContainer(
            duration: const Duration(milliseconds: 80),
            width: 3,
            height: barHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  isCancelling 
                      ? Colors.red 
                      : primaryColor,
                  isCancelling 
                      ? Colors.red.withValues(alpha: 0.5) 
                      : primaryColor.withValues(alpha: 0.5),
                ],
              ),
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: (isCancelling ? Colors.red : primaryColor).withValues(alpha: 0.3),
                  blurRadius: 2,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

/// Simple audio record button (without waveform)
/// Used for simpler UI or when space is limited
class SimpleAudioRecordButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isRecording;
  final Color? color;

  const SimpleAudioRecordButton({
    super.key,
    required this.onPressed,
    this.isRecording = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    final buttonColor = color ?? colors.primary;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isRecording ? Colors.red : buttonColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isRecording ? Icons.stop : Icons.mic,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
