import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

/// Global audio player service to manage a single audio player instance
/// Ensures only one audio plays at a time, preventing audio conflicts
class GlobalAudioPlayerService extends GetxService {
  static GlobalAudioPlayerService get to => Get.find();

  late AudioPlayer _audioPlayer;
  
  // Track current playing URL to avoid recreating player for same audio
  final RxString currentUrl = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    _audioPlayer = AudioPlayer();
    debugPrint('[GlobalAudioPlayerService] ✅ Initialized');
  }

  /// Get the shared audio player instance
  AudioPlayer getPlayer() => _audioPlayer;
  
  /// Check if this URL is the currently active audio
  bool isActiveAudio(String url) => currentUrl.value == url;

  /// Stop all playback and reset
  Future<void> stopAll() async {
    try {
      if (_audioPlayer.playing) {
        await _audioPlayer.pause();
        await _audioPlayer.seek(Duration.zero);
      }
      currentUrl.value = '';
      debugPrint('[GlobalAudioPlayerService] ⏹️ Stopped all playback');
    } catch (e) {
      debugPrint('[GlobalAudioPlayerService] ❌ Error stopping: $e');
    }
  }

  /// Set audio URL (only loads if different from current)
  Future<void> setUrl(String url) async {
    try {
      // If same URL, don't reload
      if (currentUrl.value == url) {
        debugPrint('[GlobalAudioPlayerService] ℹ️ Same URL, skipping reload');
        return;
      }

      // Stop previous audio
      if (_audioPlayer.playing) {
        await _audioPlayer.pause();
        await _audioPlayer.seek(Duration.zero);
      }

      // Load new URL
      currentUrl.value = url;
      await _audioPlayer.setUrl(url);
      debugPrint('[GlobalAudioPlayerService] 📁 Loaded: $url');
    } catch (e) {
      debugPrint('[GlobalAudioPlayerService] ❌ Error setting URL: $e');
      currentUrl.value = '';
      rethrow;
    }
  }

  /// Play audio
  Future<void> play() async {
    try {
      if (!_audioPlayer.playing) {
        await _audioPlayer.play();
        debugPrint('[GlobalAudioPlayerService] ▶️ Playing');
      }
    } catch (e) {
      debugPrint('[GlobalAudioPlayerService] ❌ Error playing: $e');
      rethrow;
    }
  }

  /// Pause audio
  Future<void> pause() async {
    try {
      if (_audioPlayer.playing) {
        await _audioPlayer.pause();
        debugPrint('[GlobalAudioPlayerService] ⏸️ Paused');
      }
    } catch (e) {
      debugPrint('[GlobalAudioPlayerService] ❌ Error pausing: $e');
    }
  }

  /// Seek to position
  Future<void> seek(Duration position) async {
    try {
      await _audioPlayer.seek(position);
      debugPrint('[GlobalAudioPlayerService] ⏩ Seeked to ${position.inSeconds}s');
    } catch (e) {
      debugPrint('[GlobalAudioPlayerService] ❌ Error seeking: $e');
    }
  }

  /// Set playback speed
  Future<void> setSpeed(double speed) async {
    try {
      await _audioPlayer.setSpeed(speed);
      debugPrint('[GlobalAudioPlayerService] ⚡ Speed: ${speed}x');
    } catch (e) {
      debugPrint('[GlobalAudioPlayerService] ❌ Error setting speed: $e');
    }
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    debugPrint('[GlobalAudioPlayerService] ❌ Disposed');
    super.onClose();
  }
}
