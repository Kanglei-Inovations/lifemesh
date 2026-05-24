import 'dart:math';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class RadarScanner extends StatefulWidget {
  const RadarScanner({super.key});

  @override
  State<RadarScanner> createState() => _RadarScannerState();
}

class _RadarScannerState extends State<RadarScanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: RadarPainter(_controller.value),
          size: const Size(300, 300),
        );
      },
    );
  }
}

class RadarPainter extends CustomPainter {
  final double angle;

  RadarPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final bgPaint = Paint()
      ..color = AppColors.cyanBlue.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, bgPaint);

    final linePaint = Paint()
      ..color = AppColors.cyanBlue.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw concentric circles
    for (var i = 1; i <= 4; i++) {
      canvas.drawCircle(center, radius * (i / 4), linePaint);
    }

    // Draw cross lines
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx + radius, center.dy),
      linePaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      linePaint,
    );

    // Draw scanning sweep
    final sweepPaint = Paint()
      ..shader = SweepGradient(
        center: Alignment.center,
        startAngle: 0.0,
        endAngle: pi * 2,
        colors: [
          AppColors.cyanBlue.withValues(alpha: 0.0),
          AppColors.cyanBlue.withValues(alpha: 0.5),
        ],
        stops: const [0.75, 1.0],
        transform: GradientRotation(angle * pi * 2),
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, Paint()..shader = sweepPaint as Shader?);

    // Draw leading edge
    final edgeAngle = angle * pi * 2;
    final edgePaint = Paint()
      ..color = AppColors.cyanBlue
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      center,
      Offset(
        center.dx + cos(edgeAngle) * radius,
        center.dy + sin(edgeAngle) * radius,
      ),
      edgePaint,
    );
  }

  @override
  bool shouldRepaint(covariant RadarPainter oldDelegate) => true;
}
