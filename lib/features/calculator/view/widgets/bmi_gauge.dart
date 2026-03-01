import 'dart:math';

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class BmiGauge extends StatefulWidget {
  final double bmi;

  const BmiGauge({
    super.key,
    required this.bmi,
  });

  @override
  State<BmiGauge> createState() => _BmiGaugeState();
}

class _BmiGaugeState extends State<BmiGauge> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800));

    final tween = Tween<double>(begin: 15.0, end: widget.bmi);
    _animation = tween.animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(BmiGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bmi != widget.bmi) {
      _animation = Tween<double>(begin: _animation.value, end: widget.bmi).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutCubic,
        ),
      );
      _controller.forward(from: 0.0);
    }
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
      builder: (context, child) {
        return CustomPaint(
          size: const Size(double.infinity, double.infinity),
          painter: _BmiGaugePainter(
            bmi: _animation.value,
            targetBmi: widget.bmi,
            context: context,
          ),
        );
      },
    );
  }
}

class _BmiGaugePainter extends CustomPainter {
  final double bmi;
  final double targetBmi;
  final BuildContext context;

  _BmiGaugePainter({
    required this.bmi,
    required this.targetBmi,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Geometry
    final strokeWidth = 32.0;
    final labelPadding = 24.0; // Extra room for labels text
    
    // We need to ensure labels (radius + strokeWidth/2 + 18 + textWidth/2) fit in width
    // And center.dy - (radius + strokeWidth/2 + 18) >= 0 for top labels
    
    final maxRByWidth = (size.width / 2) - (strokeWidth / 2) - labelPadding;
    final maxRByHeight = (size.height - 10) - (strokeWidth / 2) - labelPadding;
    
    final radius = min(maxRByWidth, maxRByHeight).clamp(50.0, 200.0);
    final center = Offset(size.width / 2, size.height - 10);
    final rect = Rect.fromCircle(center: center, radius: radius);

    final shaderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: 2 * pi,
        colors: [
          AppColors.bmiObese, // 0.0: Wrap guard for 40+ side (Red)
          AppColors.bmiUnderweight, // 0.45: Bleed guard for 15 side (Blue)
          AppColors.bmiUnderweight, // 0.50: Start of BMI 15 (Blue)
          AppColors.bmiUnderweight, // 0.57: End of Underweight
          AppColors.bmiNormal, // 0.57: Start of Normal (Green)
          AppColors.bmiNormal, // 0.70: End of Normal
          AppColors.bmiOverweight, // 0.70: Start of Overweight (Orange)
          AppColors.bmiOverweight, // 0.80: End of Overweight
          AppColors.bmiObese, // 0.80: Start of Obese (Red)
          AppColors.bmiObese, // 1.00: BMI 40+
        ],
        stops: const [
          0.0,
          0.45,
          0.50,
          0.57,
          0.57,
          0.70,
          0.70,
          0.80,
          0.80,
          1.0,
        ],
      ).createShader(rect);

    // Adding shadow to the gauge arc for depth
    final shadowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = Colors.black.withValues(alpha: 0.1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawArc(rect.translate(0, 4), pi, pi, false, shadowPaint);

    // Draw main colored arc
    canvas.drawArc(rect, pi, pi, false, shaderPaint);

    // Dividers and Labels for specific points
    final tickValues = <double>[18.5, 25.0, 30.0, 35.0];
    for (var value in tickValues) {
      double pct = (value - 15.0) / 25.0;
      double angle = pi + pct * pi;
      
      // Divider
      double innerR = radius - strokeWidth/2 + 2;
      double outerR = radius + strokeWidth/2 - 2;
      double x1 = center.dx + innerR * cos(angle);
      double y1 = center.dy + innerR * sin(angle);
      double x2 = center.dx + outerR * cos(angle);
      double y2 = center.dy + outerR * sin(angle);
      
      canvas.drawLine(
        Offset(x1, y1), 
        Offset(x2, y2), 
        Paint()
          ..color = theme.colorScheme.surface
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round
      );

      // Value Label hovering slightly outside
      double labelR = radius + strokeWidth/2 + 18;
      _drawLabel(canvas, center, labelR, angle, value.toString(), theme);
    }

    // Min and max labels
    _drawLabel(canvas, center, radius + strokeWidth/2 + 18, pi, '15', theme);
    _drawLabel(canvas, center, radius + strokeWidth/2 + 18, 2 * pi, '40+', theme);

    // Calculate dynamic needle position based on animated bmi
    double clampedBmi = bmi.clamp(15.0, 40.0);
    double needlePct = (clampedBmi - 15.0) / 25.0;
    double needleAngle = pi + needlePct * pi;

    // Determine current category color for the needle center and glow
    Color categoryColor;
    if (targetBmi < 18.5) {
      categoryColor = AppColors.bmiUnderweight;
    } else if (targetBmi < 25.0) {
      categoryColor = AppColors.bmiNormal;
    } else if (targetBmi < 30.0) {
      categoryColor = AppColors.bmiOverweight;
    } else {
      categoryColor = AppColors.bmiObese;
    }

    _drawNeedle(canvas, center, radius, needleAngle, categoryColor, theme, isDark);
  }

  void _drawLabel(Canvas canvas, Offset center, double radius, double angle, String text, ThemeData theme) {
    double lx = center.dx + radius * cos(angle);
    double ly = center.dy + radius * sin(angle);

    final span = TextSpan(
      text: text,
      style: theme.textTheme.labelSmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
        fontWeight: FontWeight.bold,
        fontSize: 10,
      ),
    );
    final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout();
    
    // Align horizontally/vertically based on text size to keep it centered at coordinates
    tp.paint(canvas, Offset(lx - tp.width/2, ly - tp.height/2));
  }

  void _drawNeedle(
    Canvas canvas, 
    Offset center, 
    double radius, 
    double angle, 
    Color color, 
    ThemeData theme,
    bool isDark,
  ) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    
    // Needle uses X-axis (0 radians points straight along the translated path)

    // Needle pivot glow base
    final pivotShadow = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawCircle(Offset.zero, 16, pivotShadow);

    // Draw Needle path
    final path = Path();
    path.moveTo(0, -6); // Wide base
    path.lineTo(radius - 12, -2); // Tapering
    path.lineTo(radius + 5, 0); // Sharp point extended into the arc
    path.lineTo(radius - 12, 2); // Tapering back
    path.lineTo(0, 6); // Wide base bottom
    path.close();

    final needlePaint = Paint()
      ..color = isDark ? Colors.white : theme.colorScheme.onSurface
      ..style = PaintingStyle.fill;
    
    // Needle shadow
    canvas.drawPath(path.shift(const Offset(0, 4)), Paint()
      ..color = Colors.black.withValues(alpha: 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4));

    // Draw needle
    canvas.drawPath(path, needlePaint);

    // Inner pivot circle design
    canvas.drawCircle(
      Offset.zero, 
      12, 
      Paint()..color = isDark ? Colors.white : theme.colorScheme.onSurface
    );
    canvas.drawCircle(
      Offset.zero, 
      6, 
      Paint()..color = color
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _BmiGaugePainter oldDelegate) {
    return oldDelegate.bmi != bmi || oldDelegate.targetBmi != targetBmi;
  }
}
