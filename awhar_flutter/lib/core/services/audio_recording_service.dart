import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

/// Service for handling audio recording functionality
/// Features: Record audio, manage recording state, save to file
class AudioRecordingService extends GetxController {
  final _audioRecorder = AudioRecorder();

  // Recording state
  final RxBool isRecording = false.obs;
  final RxBool isPaused = false.obs;
  final RxString recordingPath = ''.obs;
  final RxInt recordingDuration = 0.obs; // Duration in seconds
  final Rx<double> amplitude = 0.0.obs; // Current audio amplitude for waveform
  
  // Error handling
  final RxString errorMessage = ''.obs;

  // Timer for duration tracking
  Timer? _durationTimer;
  Timer? _amplitudeTimer;

  // Constants
  static const int maxRecordingDuration = 300; // 5 minutes max
  static const int minRecordingDuration = 1; // 1 second minimum

  @override
  void onInit() {
    super.onInit();
    _checkPermissions();
  }

  @override
  void onClose() {
    stopRecording();
    _audioRecorder.dispose();
    _durationTimer?.cancel();
    _amplitudeTimer?.cancel();
    super.onClose();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PERMISSION HANDLING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Check and request microphone permission
  Future<bool> _checkPermissions() async {
    try {
      final hasPermission = await _audioRecorder.hasPermission();
      if (!hasPermission) {
        errorMessage.value = 'Microphone permission denied';
        debugPrint('[AudioRecordingService] ❌ Microphone permission denied');
        return false;
      }
      debugPrint('[AudioRecordingService] ✅ Microphone permission granted');
      return true;
    } catch (e) {
      errorMessage.value = 'Failed to check permissions: $e';
      debugPrint('[AudioRecordingService] ❌ Permission check error: $e');
      return false;
    }
  }

  /// Request microphone permission explicitly
  Future<bool> requestPermission() async {
    try {
      final hasPermission = await _audioRecorder.hasPermission();
      if (!hasPermission) {
        errorMessage.value = 'microphone_permission_required'.tr;
        return false;
      }
      errorMessage.value = '';
      return true;
    } catch (e) {
      errorMessage.value = 'permission_error'.tr;
      debugPrint('[AudioRecordingService] ❌ Request permission error: $e');
      return false;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // RECORDING CONTROLS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Start recording audio
  Future<bool> startRecording() async {
    try {
      // Check permissions
      final hasPermission = await requestPermission();
      if (!hasPermission) {
        return false;
      }

      // Generate unique filename
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'audio_recording_$timestamp.m4a';
      final filePath = '${tempDir.path}/$fileName';

      // Configure recording settings
      const config = RecordConfig(
        encoder: AudioEncoder.aacLc, // AAC format (widely supported)
        bitRate: 128000, // 128 kbps (good quality, reasonable file size)
        sampleRate: 44100, // CD quality
        numChannels: 1, // Mono (smaller file size)
      );

      // Start recording
      await _audioRecorder.start(config, path: filePath);

      // Update state
      isRecording.value = true;
      isPaused.value = false;
      recordingPath.value = filePath;
      recordingDuration.value = 0;
      errorMessage.value = '';

      // Start duration timer
      _startDurationTimer();

      // Start amplitude monitoring for waveform
      _startAmplitudeMonitoring();

      debugPrint('[AudioRecordingService] 🎙️ Recording started: $filePath');
      return true;
    } catch (e) {
      errorMessage.value = 'recording_start_failed'.tr;
      debugPrint('[AudioRecordingService] ❌ Start recording error: $e');
      return false;
    }
  }

  /// Pause recording
  Future<bool> pauseRecording() async {
    try {
      if (!isRecording.value || isPaused.value) {
        return false;
      }

      await _audioRecorder.pause();
      isPaused.value = true;
      _durationTimer?.cancel();
      _amplitudeTimer?.cancel();

      debugPrint('[AudioRecordingService] ⏸️ Recording paused');
      return true;
    } catch (e) {
      errorMessage.value = 'recording_pause_failed'.tr;
      debugPrint('[AudioRecordingService] ❌ Pause recording error: $e');
      return false;
    }
  }

  /// Resume recording
  Future<bool> resumeRecording() async {
    try {
      if (!isRecording.value || !isPaused.value) {
        return false;
      }

      await _audioRecorder.resume();
      isPaused.value = false;
      _startDurationTimer();
      _startAmplitudeMonitoring();

      debugPrint('[AudioRecordingService] ▶️ Recording resumed');
      return true;
    } catch (e) {
      errorMessage.value = 'recording_resume_failed'.tr;
      debugPrint('[AudioRecordingService] ❌ Resume recording error: $e');
      return false;
    }
  }

  /// Stop recording and return the file path
  Future<String?> stopRecording() async {
    try {
      if (!isRecording.value) {
        return null;
      }

      final path = await _audioRecorder.stop();
      
      // Stop timers
      _durationTimer?.cancel();
      _amplitudeTimer?.cancel();

      // Reset state
      isRecording.value = false;
      isPaused.value = false;
      amplitude.value = 0.0;

      if (path == null || path.isEmpty) {
        errorMessage.value = 'recording_save_failed'.tr;
        debugPrint('[AudioRecordingService] ❌ Recording path is null');
        return null;
      }

      // Validate minimum duration
      if (recordingDuration.value < minRecordingDuration) {
        errorMessage.value = 'recording_too_short'.tr;
        debugPrint('[AudioRecordingService] ❌ Recording too short: ${recordingDuration.value}s');
        
        // Delete the file
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
        }
        
        recordingDuration.value = 0;
        recordingPath.value = '';
        return null;
      }

      debugPrint('[AudioRecordingService] ✅ Recording stopped: $path (${recordingDuration.value}s)');
      return path;
    } catch (e) {
      errorMessage.value = 'recording_stop_failed'.tr;
      debugPrint('[AudioRecordingService] ❌ Stop recording error: $e');
      
      // Reset state on error
      isRecording.value = false;
      isPaused.value = false;
      recordingDuration.value = 0;
      recordingPath.value = '';
      
      return null;
    }
  }

  /// Cancel recording and delete the file
  Future<bool> cancelRecording() async {
    try {
      final path = await stopRecording();
      
      if (path != null && path.isNotEmpty) {
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
          debugPrint('[AudioRecordingService] 🗑️ Recording cancelled and deleted');
        }
      }

      // Reset all state
      recordingDuration.value = 0;
      recordingPath.value = '';
      errorMessage.value = '';
      
      return true;
    } catch (e) {
      errorMessage.value = 'recording_cancel_failed'.tr;
      debugPrint('[AudioRecordingService] ❌ Cancel recording error: $e');
      return false;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MONITORING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Start duration timer (updates every second)
  void _startDurationTimer() {
    _durationTimer?.cancel();
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      recordingDuration.value++;

      // Auto-stop at max duration
      if (recordingDuration.value >= maxRecordingDuration) {
        debugPrint('[AudioRecordingService] ⏰ Max duration reached, stopping recording');
        stopRecording();
      }
    });
  }

  /// Start amplitude monitoring for waveform visualization
  void _startAmplitudeMonitoring() {
    _amplitudeTimer?.cancel();
    _amplitudeTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      try {
        final currentAmplitude = await _audioRecorder.getAmplitude();
        // Normalize amplitude to 0.0 - 1.0 range
        // getAmplitude returns Amplitude object with current dB level
        amplitude.value = (currentAmplitude.current + 50) / 50; // Normalize -50dB to 0dB → 0.0 to 1.0
        amplitude.value = amplitude.value.clamp(0.0, 1.0);
      } catch (e) {
        // Ignore amplitude errors (not critical)
        amplitude.value = 0.0;
      }
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // UTILITIES
  // ═══════════════════════════════════════════════════════════════════════════

  /// Check if currently recording
  bool get isCurrentlyRecording => isRecording.value && !isPaused.value;

  /// Get formatted duration string (MM:SS)
  String get formattedDuration {
    final minutes = recordingDuration.value ~/ 60;
    final seconds = recordingDuration.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Get remaining time string
  String get remainingTime {
    final remaining = maxRecordingDuration - recordingDuration.value;
    final minutes = remaining ~/ 60;
    final seconds = remaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Get recording progress (0.0 to 1.0)
  double get recordingProgress {
    return (recordingDuration.value / maxRecordingDuration).clamp(0.0, 1.0);
  }

  /// Clear error message
  void clearError() {
    errorMessage.value = '';
  }

  /// Get file size of current recording
  Future<int?> getRecordingFileSize() async {
    try {
      if (recordingPath.value.isEmpty) {
        return null;
      }

      final file = File(recordingPath.value);
      if (await file.exists()) {
        return await file.length();
      }
      return null;
    } catch (e) {
      debugPrint('[AudioRecordingService] ❌ Get file size error: $e');
      return null;
    }
  }
}
