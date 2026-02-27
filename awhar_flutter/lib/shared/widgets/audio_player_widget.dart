import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/services/global_audio_player_service.dart';

/// Widget for playing audio messages in chat
/// Features: Play/pause, seek, speed control, progress indicator
class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;
  final int? durationMs;
  final Color? backgroundColor;
  final Color? primaryColor;
  final Color? textColor;
  final VoidCallback? onPlayComplete;

  const AudioPlayerWidget({
    super.key,
    required this.audioUrl,
    this.durationMs,
    this.backgroundColor,
    this.primaryColor,
    this.textColor,
    this.onPlayComplete,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late GlobalAudioPlayerService _audioService;
  
  // State variables
  bool _isPlaying = false;
  bool _isLoading = false;
  bool _hasError = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  double _playbackSpeed = 1.0;

  // Subscriptions
  StreamSubscription<PlayerState>? _playerStateSubscription;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration?>? _durationSubscription;
  Worker? _activeUrlWorker;

  @override
  void initState() {
    super.initState();
    _audioService = Get.find<GlobalAudioPlayerService>();
    
    // Don't initialize player here - wait for user to click play
    // This prevents race conditions when multiple audios load at once
    _setupListeners();
    
    // Listen to active URL changes to reset state when another audio plays
    _activeUrlWorker = ever(_audioService.currentUrl, (String activeUrl) {
      if (mounted && activeUrl != widget.audioUrl && _isPlaying) {
        setState(() {
          _isPlaying = false;
          _currentPosition = Duration.zero;
        });
      }
    });
    
    // Set duration from metadata if available
    if (widget.durationMs != null) {
      _totalDuration = Duration(milliseconds: widget.durationMs!);
    }
  }

  @override
  void dispose() {
    _playerStateSubscription?.cancel();
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _activeUrlWorker?.dispose();
    super.dispose();
  }

  /// Setup listeners for player streams
  void _setupListeners() {
    final audioPlayer = _audioService.getPlayer();

    // Listen to player state changes
    _playerStateSubscription = audioPlayer.playerStateStream.listen((state) {
      // Only update if this is the currently active audio
      if (mounted && _audioService.isActiveAudio(widget.audioUrl)) {
        setState(() {
          _isPlaying = state.playing;
          _hasError = state.processingState == ProcessingState.idle && !state.playing;
        });

        // Notify completion
        if (state.processingState == ProcessingState.completed) {
          widget.onPlayComplete?.call();
          audioPlayer.seek(Duration.zero);
          audioPlayer.pause();
        }
      }
    });

    // Listen to position changes
    _positionSubscription = audioPlayer.positionStream.listen((position) {
      // Only update if this is the currently active audio
      if (mounted && _audioService.isActiveAudio(widget.audioUrl)) {
        setState(() => _currentPosition = position);
      }
    });

    // Listen to duration changes
    _durationSubscription = audioPlayer.durationStream.listen((duration) {
      // Only update duration from stream if:
      // 1. This is the currently active audio
      // 2. We don't have metadata duration (prefer metadata over stream)
      // 3. Duration is not null
      if (mounted && 
          duration != null && 
          widget.durationMs == null &&
          _audioService.isActiveAudio(widget.audioUrl)) {
        setState(() => _totalDuration = duration);
      }
    });
  }

  /// Initialize audio player (called on first play)
  Future<void> _initializePlayer() async {
    try {
      setState(() => _isLoading = true);

      // Load audio URL using global service
      await _audioService.setUrl(widget.audioUrl);
      
      // Restore metadata duration after loading (stream might have overwritten it)
      if (widget.durationMs != null) {
        _totalDuration = Duration(milliseconds: widget.durationMs!);
      }

      setState(() => _isLoading = false);
      debugPrint('[AudioPlayerWidget] ✅ Initialized for: ${widget.audioUrl}');
    } catch (e) {
      debugPrint('[AudioPlayerWidget] ❌ Initialization error: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  /// Toggle play/pause
  Future<void> _togglePlayPause() async {
    try {
      // If this is not the active audio, load it first
      if (!_audioService.isActiveAudio(widget.audioUrl)) {
        await _initializePlayer();
        setState(() {
          _currentPosition = Duration.zero;
          _isPlaying = false;
        });
      }
      
      if (_isPlaying) {
        await _audioService.pause();
      } else {
        await _audioService.play();
      }
    } catch (e) {
      debugPrint('[AudioPlayerWidget] ❌ Play/Pause error: $e');
      setState(() => _hasError = true);
    }
  }

  /// Seek to position
  Future<void> _seek(Duration position) async {
    try {
      await _audioService.seek(position);
    } catch (e) {
      debugPrint('[AudioPlayerWidget] ❌ Seek error: $e');
    }
  }

  /// Change playback speed
  Future<void> _changeSpeed() async {
    try {
      double newSpeed;
      if (_playbackSpeed == 1.0) {
        newSpeed = 1.5;
      } else if (_playbackSpeed == 1.5) {
        newSpeed = 2.0;
      } else {
        newSpeed = 1.0;
      }

      await _audioService.setSpeed(newSpeed);
      setState(() => _playbackSpeed = newSpeed);
    } catch (e) {
      debugPrint('[AudioPlayerWidget] ❌ Speed change error: $e');
    }
  }

  /// Format duration to MM:SS
  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;

    final bgColor = widget.backgroundColor ?? colors.surface;
    final primaryColor = widget.primaryColor ?? colors.primary;
    final textColor = widget.textColor ?? colors.textPrimary;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.border, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              // Play/Pause button
              _buildPlayButton(primaryColor),
              
              SizedBox(width: 12.w),

              // Animated waveform and duration
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Animated waveform visualization
                    _buildAnimatedWaveform(primaryColor),

                    // Time labels
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(_currentPosition),
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: textColor.withValues(alpha: 0.7),
                            ),
                          ),
                          Text(
                            _formatDuration(_totalDuration),
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: textColor.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8.w),

              // Speed control button
              _buildSpeedButton(primaryColor, textColor),
            ],
          ),
        ],
      ),
    );
  }

  /// Build animated waveform visualization
  Widget _buildAnimatedWaveform(Color primaryColor) {
    final barCount = 20;
    
    // Calculate progress (0.0 to 1.0)
    final progress = _totalDuration.inMilliseconds > 0
        ? (_currentPosition.inMilliseconds / _totalDuration.inMilliseconds).clamp(0.0, 1.0)
        : 0.0;
    
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final screenWidth = MediaQuery.of(context).size.width - 120;
        final clampedMs = ((details.globalPosition.dx / screenWidth) * _totalDuration.inMilliseconds).round().clamp(0, _totalDuration.inMilliseconds);
        final position = Duration(milliseconds: clampedMs);
        _seek(position);
      },
      child: Container(
        height: 36.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(barCount, (index) {
            // Calculate which bars should be highlighted based on progress
            final barProgress = (index + 1) / barCount;
            final isPlayed = barProgress <= progress;
            
            // Create a pseudo-random but consistent waveform pattern
            // Mix of high and low bars for visual interest
            final basePattern = [1.0, 0.6, 0.8, 0.5, 0.9, 0.4, 0.7, 0.6, 0.85, 0.5];
            final patternValue = basePattern[index % basePattern.length];
            
            // Height based on pattern and playback state
            final baseHeight = 4.0;
            final maxHeight = 28.0;
            final targetHeight = baseHeight + (patternValue * (maxHeight - baseHeight));
            
            // Add animation smoothness based on playing state
            final animatedHeight = _isPlaying
                ? targetHeight
                : targetHeight * 0.7; // Smaller when not playing
            
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: _isPlaying ? 150 : 300),
                    width: 2.5.w,
                    height: animatedHeight.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: isPlayed
                            ? [primaryColor, primaryColor.withValues(alpha: 0.6)]
                            : [primaryColor.withValues(alpha: 0.3), primaryColor.withValues(alpha: 0.1)],
                      ),
                      borderRadius: BorderRadius.circular(1.5.r),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  /// Build play/pause button
  Widget _buildPlayButton(Color primaryColor) {
    if (_isLoading) {
      return SizedBox(
        width: 40.w,
        height: 40.w,
        child: Center(
          child: SizedBox(
            width: 20.w,
            height: 20.w,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          ),
        ),
      );
    }

    if (_hasError) {
      return Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 20.sp,
        ),
      );
    }

    return InkWell(
      onTap: _togglePlayPause,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          _isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
          size: 24.sp,
        ),
      ),
    );
  }

  /// Build speed control button
  Widget _buildSpeedButton(Color primaryColor, Color textColor) {
    return InkWell(
      onTap: _changeSpeed,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          '${_playbackSpeed}x',
          style: TextStyle(
            fontSize: 11.sp,
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
