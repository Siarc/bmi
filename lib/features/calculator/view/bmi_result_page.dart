import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/calculator_bloc.dart';
import '../bloc/calculator_event.dart';

class BmiResultPage extends StatelessWidget {
  const BmiResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CalculatorBloc>().state;
    final result = state.result;

    if (result == null) {
      // In case of a hot reload or direct navigation where state is lost
      return const Scaffold(
        body: Center(child: Text('No result found')),
      );
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Ideal weight calculation
    final heightM = result.height / 100;
    final minWeightKg = 18.5 * heightM * heightM;
    final maxWeightKg = 25.0 * heightM * heightM;

    String idealWeightStr;
    String weightUnitStr;
    if (state.isMetric) {
      idealWeightStr =
          '${minWeightKg.toStringAsFixed(1)} - ${maxWeightKg.toStringAsFixed(1)}';
      weightUnitStr = 'kg';
    } else {
      final minLbs = minWeightKg / 0.453592;
      final maxLbs = maxWeightKg / 0.453592;
      idealWeightStr =
          '${minLbs.toStringAsFixed(0)} - ${maxLbs.toStringAsFixed(0)}';
      weightUnitStr = 'lbs';
    }

    // Ponderal index calculation
    final ponderalIndex = result.weight / (heightM * heightM * heightM);
    final piStr = ponderalIndex.toStringAsFixed(1);

    Color categoryColor;
    switch (result.category) {
      case 'Underweight':
        categoryColor = AppColors.bmiUnderweight;
        break;
      case 'Healthy Weight':
        categoryColor = AppColors.bmiNormal;
        break;
      case 'Overweight':
        categoryColor = AppColors.bmiOverweight;
        break;
      case 'Class 1 Obesity':
      case 'Class 2 Obesity':
      case 'Class 3 Obesity':
        categoryColor = AppColors.bmiObese;
        break;
      default:
        categoryColor = colorScheme.primary;
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          context.read<CalculatorBloc>().add(const ClearBmiResult());
        }
      },
      child: Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<CalculatorBloc>().add(const ClearBmiResult());
            context.pop();
          },
        ),
        title: const Text('Your Result'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {}, // Optional share functionality
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingXl),
        child: Column(
          children: [
            // Main Gauge Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  vertical: AppTheme.spacingXxl, horizontal: AppTheme.spacingLg),
              decoration: BoxDecoration(
                color: isDark ? colorScheme.surface : colorScheme.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  )
                ],
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.1),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'BODY MASS INDEX',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXxl),

                  // Custom Gauge
                  SizedBox(
                    height: 120,
                    child: _BmiGauge(bmi: result.bmi),
                  ),
                  const SizedBox(height: AppTheme.spacingLg),

                  Text(
                    result.bmi.toStringAsFixed(1),
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontSize: 56,
                      fontWeight: FontWeight.w800,
                      color: theme.textTheme.bodyLarge?.color,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingMd),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingLg,
                      vertical: AppTheme.spacingSm,
                    ),
                    decoration: BoxDecoration(
                      color: categoryColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: categoryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: categoryColor.withValues(alpha: 0.5),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${result.category} Weight',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: categoryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXxl),

                  Text(
                    result.healthMessage,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingLg),

            // Metrics Cards Row
            Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    icon: Icons.monitor_weight_outlined,
                    label: 'IDEAL WEIGHT',
                    value: idealWeightStr,
                    unit: weightUnitStr,
                  ),
                ),
                const SizedBox(width: AppTheme.spacingLg),
                Expanded(
                  child: _MetricCard(
                    icon: Icons.analytics_outlined,
                    label: 'PONDERAL INDEX',
                    value: piStr,
                    unit: 'kg/m³',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingLg),

            // Classifications Table
            Container(
              decoration: BoxDecoration(
                color: isDark ? colorScheme.surface : colorScheme.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.1),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingLg,
                        vertical: AppTheme.spacingMd),
                    color: colorScheme.onSurface.withValues(alpha: 0.03),
                    child: Row(
                      children: [
                        Icon(Icons.table_chart_outlined,
                            size: 20, color: colorScheme.onSurfaceVariant),
                        const SizedBox(width: AppTheme.spacingMd),
                        Text(
                          'BMI CLASSIFICATIONS',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _ClassificationRow(
                    category: 'Underweight',
                    range: '< 18.5',
                    isActive: result.category == 'Underweight',
                    color: AppColors.bmiUnderweight,
                  ),
                  _ClassificationRow(
                    category: 'Healthy Weight',
                    range: '18.5 - 25',
                    isActive: result.category == 'Healthy Weight',
                    color: AppColors.bmiNormal,
                  ),
                  _ClassificationRow(
                    category: 'Overweight',
                    range: '25 - 30',
                    isActive: result.category == 'Overweight',
                    color: AppColors.bmiOverweight,
                  ),
                  _ClassificationRow(
                    category: 'Class 1 Obesity',
                    range: '30 - 35',
                    isActive: result.category == 'Class 1 Obesity',
                    color: AppColors.bmiObese,
                  ),
                  _ClassificationRow(
                    category: 'Class 2 Obesity',
                    range: '35 - 40',
                    isActive: result.category == 'Class 2 Obesity',
                    color: AppColors.bmiObese,
                  ),
                  _ClassificationRow(
                    category: 'Class 3 Obesity',
                    range: '> 40',
                    isActive: result.category == 'Class 3 Obesity',
                    color: AppColors.bmiObese,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXxl),

            // Recalculate Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<CalculatorBloc>().add(const CalculatorReset());
                  context.pop();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('New Calculation'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXxl),

            // Health Resources Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Health Resources',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to resources tab
                    context.go(AppRouter.resourcesPath);
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingMd),

            // Resources Links
            _ResourceLinkCard(
              icon: Icons.restaurant_menu,
              iconColor: colorScheme.primary,
              title: 'Healthy Eating Plan',
              subtitle: 'Discover balanced diets tailored for your BMI goals.',
            ),
            const SizedBox(height: AppTheme.spacingMd),
            _ResourceLinkCard(
              icon: Icons.favorite,
              iconColor: AppColors.accentPink,
              title: 'Health Risks Evaluation',
              subtitle: 'Learn about potential health implications and prevention.',
            ),
            const SizedBox(height: 100), // padding for navigation bar overlap
          ],
        ),
      ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;

  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: colorScheme.primary),
              const SizedBox(width: AppTheme.spacingSm),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingLg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ClassificationRow extends StatelessWidget {
  final String category;
  final String range;
  final bool isActive;
  final Color color;

  const _ClassificationRow({
    required this.category,
    required this.range,
    required this.isActive,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingLg,
        vertical: AppTheme.spacingMd,
      ),
      decoration: BoxDecoration(
        color: isActive ? color.withValues(alpha: 0.1) : null,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.05),
          ),
          left: isActive
              ? BorderSide(color: color, width: 4)
              : const BorderSide(color: Colors.transparent, width: 4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                category,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? color : theme.colorScheme.onSurfaceVariant,
                ),
              ),
              if (isActive) ...[
                const SizedBox(width: AppTheme.spacingSm),
                Icon(Icons.check_circle, size: 16, color: color),
              ]
            ],
          ),
          Text(
            range,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? theme.textTheme.bodyLarge?.color : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResourceLinkCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _ResourceLinkCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingLg),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: AppTheme.spacingLg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

// Custom Gauge Implementation
class _BmiGauge extends StatelessWidget {
  final double bmi;
  const _BmiGauge({this.bmi = 23.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Custom drawn semi-circle gradient and gauge
            CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: _GaugePainter(),
            ),
            
            // Labels specific to WHO scale
            Positioned(bottom: 0, left: 0, child: _Label('15')),
            Positioned(top: 10, left: 30, child: _Label('18.5')),
            Positioned(top: -15, child: _Label('25')),
            Positioned(top: 10, right: 30, child: _Label('30')),
            Positioned(bottom: 0, right: 0, child: _Label('40')),

            // Animated needle
            _GaugeNeedle(bmi: bmi),
          ],
        );
      },
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.labelSmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height),
      radius: size.height,
    );

    // We only need the top half of the circle
    final startAngle = pi;
    final sweepAngle = pi;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 32
      ..strokeCap = StrokeCap.butt;

    // Gradient based on typical distribution shown in the HTML design:
    paint.shader = SweepGradient(
      startAngle: pi,
      endAngle: 2 * pi,
      colors: [
        AppColors.bmiUnderweight,
        AppColors.bmiUnderweight,
        AppColors.bmiNormal,
        AppColors.bmiNormal,
        AppColors.bmiOverweight,
        AppColors.bmiOverweight,
        AppColors.bmiObese,
        AppColors.bmiObese,
      ],
      stops: const [
        0.0,
        0.14,
        0.14,
        0.40,
        0.40,
        0.60,
        0.60,
        1.0,
      ],
      transform: const GradientRotation(pi),
    ).createShader(rect);

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GaugeNeedle extends StatefulWidget {
  final double bmi;
  const _GaugeNeedle({required this.bmi});

  @override
  State<_GaugeNeedle> createState() => _GaugeNeedleState();
}

class _GaugeNeedleState extends State<_GaugeNeedle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    final angle = _calculateAngle(widget.bmi);
    
    _animation = Tween<double>(begin: -pi / 2, end: angle).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  double _calculateAngle(double bmi) {
    // Math to position needle between 15 and 40
    // Returns angle between -pi/2 (left) and pi/2 (right) where 0 is vertical top
    final limitBmi = bmi.clamp(15.0, 40.0);
    final percentage = (limitBmi - 15.0) / 25.0; // 0.0 to 1.0
    return (-pi / 2) + (percentage * pi);
  }

  @override
  void didUpdateWidget(covariant _GaugeNeedle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bmi != widget.bmi) {
      final angle = _calculateAngle(widget.bmi);
      _animation = Tween<double>(begin: _animation.value, end: angle).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final needleColor = isDark ? Colors.white : theme.colorScheme.onSurface;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value,
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 4,
                height: 90,
                decoration: BoxDecoration(
                  color: needleColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
                  boxShadow: [
                    BoxShadow(
                      color: needleColor.withValues(alpha: 0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: needleColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.scaffoldBackgroundColor,
                    width: 4,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
