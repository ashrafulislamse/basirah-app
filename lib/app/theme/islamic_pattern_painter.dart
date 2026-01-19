import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Islamic Octagon Star Pattern Painter
/// 
/// Creates a subtle 8-point star geometric pattern
/// commonly found in Islamic art and architecture
class IslamicPatternPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  
  IslamicPatternPainter({
    this.color = Colors.white,
    this.strokeWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double patternSize = 50.0;
    final double radius = patternSize / 2;

    // Grid loop to cover the canvas
    for (double y = 0; y < size.height + patternSize; y += patternSize * 0.866) {
      for (double x = 0; x < size.width + patternSize; x += patternSize) {
        // Offset every other row for a honeycomb-like layout
        final double xOffset = (y ~/ (patternSize * 0.866)) % 2 == 0 ? 0 : patternSize / 2;
        _drawOctagonStar(canvas, paint, Offset(x + xOffset, y), radius);
      }
    }
  }

  void _drawOctagonStar(Canvas canvas, Paint paint, Offset center, double radius) {
    final path = Path();
    
    // Draw 8-point star (octagon)
    for (int i = 0; i < 8; i++) {
      double angle = (i * 45) * (math.pi / 180);
      double x = center.dx + radius * math.cos(angle);
      double y = center.dy + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    
    canvas.drawPath(path, paint);
    
    // Add a small circle in the center of each star for detail
    canvas.drawCircle(center, radius * 0.35, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Reusable Islamic Pattern Overlay Widget
class IslamicPatternOverlay extends StatelessWidget {
  final double opacity;
  final Color patternColor;
  final double borderRadius;
  
  const IslamicPatternOverlay({
    super.key,
    this.opacity = 0.06,
    this.patternColor = Colors.white,
    this.borderRadius = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Opacity(
          opacity: opacity,
          child: CustomPaint(
            painter: IslamicPatternPainter(color: patternColor),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }
}
