

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/calculator_bloc.dart';
import '../bloc/calculator_event.dart';
import 'widgets/bmi_gauge.dart';

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
                    height: 180,
                    child: BmiGauge(bmi: result.bmi),
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
                          result.category,
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
                    label: 'IDEAL WEIGHT',
                    value: idealWeightStr,
                    unit: weightUnitStr,
                    infoText: 'Ideal Body Weight (IBW) is the weight range considered healthy for your height. It is calculated using the healthy BMI range of 18.5 to 25.0 kg/m².',
                  ),
                ),
                const SizedBox(width: AppTheme.spacingLg),
                Expanded(
                  child: _MetricCard(
                    label: 'PONDERAL INDEX',
                    value: piStr,
                    unit: 'kg/m³',
                    infoText: 'The Ponderal Index (PI) is a measure of leanness of a person. Unlike BMI, which uses height squared (m²), PI uses height cubed (m³), making it more accurate for very short or very tall individuals.',
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
  final String label;
  final String value;
  final String unit;
  final String infoText;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.infoText,
  });

  void _showInfoOverlay(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingXl),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacingXl),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.radiusXl),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingLg),
              Text(
                content,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppTheme.spacingLg),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Got it'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              InkWell(
                onTap: () => _showInfoOverlay(context, label, infoText),
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.info_outline,
                    size: 16,
                    color: colorScheme.primary,
                  ),
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


