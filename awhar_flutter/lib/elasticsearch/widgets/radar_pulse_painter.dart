import 'dart:math';
import 'package:flutter/material.dart';

/// Custom painter for the radar/pulse scanning animation.
/// Draws concentric rings that pulse outward from center,
/// a rotating sweep line, and driver dots that appear.
class RadarPulsePainter extends CustomPainter {
  final double pulseProgress; // 0.0 to 1.0 — ring expansion
  final double sweepAngle; // Current sweep line angle in radians
  final Color primaryColor;
  final Color accentColor;
  final List<RadarDot> driverDots;
  final double glowIntensity; // 0.0 to 1.0

  RadarPulsePainter({
    required this.pulseProgress,
    required this.sweepAngle,
    required this.primaryColor,
    required this.accentColor,
    this.driverDots = const [],
    this.glowIntensity = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = min(size.width, size.height) / 2;

    // Draw background grid circles (subtle)
    _drawGridCircles(canvas, center, maxRadius);

    // Draw crosshair lines (subtle)
    _drawCrosshairs(canvas, center, maxRadius);

    // Draw pulsing rings
    _drawPulseRings(canvas, center, maxRadius);

    // Draw sweep gradient
    _drawSweep(canvas, center, maxRadius);

    // Draw center dot (user position)
    _drawCenterDot(canvas, center);

    // Draw driver dots
    for (final dot in driverDots) {
      _drawDriverDot(canvas, center, maxRadius, dot);
    }
  }

  void _drawGridCircles(Canvas canvas, Offset center, double maxRadius) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = primaryColor.withValues(alpha: 0.08);

    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(center, maxRadius * (i / 4), paint);
    }
  }

  void _drawCrosshairs(Canvas canvas, Offset center, double maxRadius) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3
      ..color = primaryColor.withValues(alpha: 0.06);

    canvas.drawLine(
      Offset(center.dx - maxRadius, center.dy),
      Offset(center.dx + maxRadius, center.dy),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - maxRadius),
      Offset(center.dx, center.dy + maxRadius),
      paint,
    );
  }

  void _drawPulseRings(Canvas canvas, Offset center, double maxRadius) {
    // Three staggered pulse rings
    for (int i = 0; i < 3; i++) {
      final offset = i * 0.33;
      final progress = (pulseProgress + offset) % 1.0;
      final radius = maxRadius * progress;
      final opacity = (1.0 - progress) * 0.3 * glowIntensity;

      if (opacity > 0) {
        final paint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0 * (1.0 - progress) + 0.5
          ..color = accentColor.withValues(alpha: opacity.clamp(0.0, 1.0));

        canvas.drawCircle(center, radius, paint);
      }
    }
  }

  void _drawSweep(Canvas canvas, Offset center, double maxRadius) {
    // Rotating gradient sweep
    final sweepPaint = Paint()
      ..shader = SweepGradient(
        center: Alignment.center,
        startAngle: sweepAngle - 0.8,
        endAngle: sweepAngle,
        colors: [
          accentColor.withValues(alpha: 0.0),
          accentColor.withValues(alpha: 0.15 * glowIntensity),
        ],
        tileMode: TileMode.clamp,
      ).createShader(Rect.fromCircle(center: center, radius: maxRadius));

    canvas.drawCircle(center, maxRadius, sweepPaint);

    // Sweep leading edge line
    final lineEnd = Offset(
      center.dx + maxRadius * cos(sweepAngle),
      center.dy + maxRadius * sin(sweepAngle),
    );
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = accentColor.withValues(alpha: 0.35 * glowIntensity);

    canvas.drawLine(center, lineEnd, linePaint);
  }

  void _drawCenterDot(Canvas canvas, Offset center) {
    // Outer glow
    final glowPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.15 * glowIntensity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(center, 8, glowPaint);

    // Inner dot
    final dotPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 4, dotPaint);

    // White center
    final whiteDot = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 1.5, whiteDot);
  }

  void _drawDriverDot(
      Canvas canvas, Offset center, double maxRadius, RadarDot dot) {
    final pos = Offset(
      center.dx + maxRadius * dot.normalizedX,
      center.dy + maxRadius * dot.normalizedY,
    );

    final opacity = dot.opacity.clamp(0.0, 1.0);

    // Glow
    final glowPaint = Paint()
      ..color = dot.color.withValues(alpha: 0.3 * opacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(pos, 6 * dot.scale, glowPaint);

    // Dot
    final dotPaint = Paint()
      ..color = dot.color.withValues(alpha: opacity)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(pos, 4 * dot.scale, dotPaint);

    // White center
    final whiteDot = Paint()
      ..color = Colors.white.withValues(alpha: opacity * 0.8)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(pos, 1.5 * dot.scale, whiteDot);
  }

  @override
  bool shouldRepaint(covariant RadarPulsePainter oldDelegate) => true;
}

/// Represents a driver dot on the radar
class RadarDot {
  final double normalizedX; // -1.0 to 1.0
  final double normalizedY; // -1.0 to 1.0
  final Color color;
  final double opacity; // 0.0 to 1.0 (for fade-in)
  final double scale; // 1.0 = normal

  const RadarDot({
    required this.normalizedX,
    required this.normalizedY,
    this.color = const Color(0xFF2ECC71),
    this.opacity = 1.0,
    this.scale = 1.0,
  });
}
