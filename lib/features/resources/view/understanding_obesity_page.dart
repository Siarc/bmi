import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../calculator/bloc/calculator_bloc.dart';

/// Understanding Obesity Guide page.
class UnderstandingObesityPage extends StatelessWidget {
  const UnderstandingObesityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          behavior: HitTestBehavior.opaque,
          child: const Center(
            child: Icon(Icons.arrow_back_ios_new, size: 20),
          ),
        ),
        title: const Text('Understanding Obesity'),
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: isDark
            ? theme.scaffoldBackgroundColor.withValues(alpha: 0.9)
            : theme.scaffoldBackgroundColor.withValues(alpha: 0.9),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero Banner ──
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  border: Border.all(
                    color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.transparent,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBw_9XaTi31UJzMXP_Xchz7XSV092dJEeC3UWNIUPPG4BiP-OtRs1s2FU8DC-4OFewoXXzcZQaunRqntq3skKl5zGc_KailjtiEiHV3quYDbUyL-cbr4Psy8VU0lt5afin_1itmFsn7h54cDrvdjBc4Euex2n4bk5zHYROOM1SdfpJv5T1c6ZR73AJ9YMqgsuSxfFSjs0W52Jxhem-cBIw07ymkVkjsAtQg55t6VEMxhubb1a-jiYzvyTX94dK7JzrT-qNZU8WcaOI',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.8),
                            Colors.black.withValues(alpha: 0.2),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NHLBI HEALTH GUIDELINES',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: isDark ? Colors.blue[300] : Colors.blue[200],
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2.0,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Your Comprehensive \nGuide to Better Health',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── What is Obesity? ──
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.info, color: colorScheme.primary, size: 20),
                      ),
                      const SizedBox(width: AppTheme.spacingMd),
                      Text(
                        'What is Obesity?',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  Text(
                    "Obesity is a complex, chronic disease involving an excessive amount of body fat. It's a significant medical condition that increases the risk of other health complications.",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingLg),
                  
                  // BMI Card
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacingXl),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B).withValues(alpha: 0.5) : Colors.blueGrey.shade50.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                      border: Border.all(
                        color: isDark ? const Color(0xFF334155).withValues(alpha: 0.5) : colorScheme.outline.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CLINICAL DEFINITION',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurfaceVariant,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'BMI ≥ 30.0',
                                  style: theme.textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () => context.go(AppRouter.calculatorPath),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.primary,
                                foregroundColor: Colors.white,
                                elevation: 4,
                                textStyle: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text('CALCULATE MINE'),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppTheme.spacingXl),
                        // BMI Scale Visual
                        Builder(
                          builder: (context) {
                            final bmi = context.watch<CalculatorBloc>().state.result?.bmi;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: TweenAnimationBuilder<double>(
                                tween: Tween<double>(begin: 15.0, end: bmi ?? 15.0),
                                duration: const Duration(milliseconds: 1200),
                                curve: Curves.easeOutCubic,
                                builder: (context, value, child) {
                                  return CustomPaint(
                                    size: const Size(double.infinity, 12),
                                    painter: _BmiSpectrumPainter(bmi == null ? null : value, isDark),
                                  );
                                },
                              ),
                            );
                          }
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('UNDER', style: _scaleTextStyle(theme)),
                                Text('<18.5', style: _valueTextStyle(theme)),
                              ],
                            ),
                            Column(
                              children: [
                                Text('NORMAL', style: _scaleTextStyle(theme)),
                                Text('18.5-24.9', style: _valueTextStyle(theme)),
                              ],
                            ),
                            Column(
                              children: [
                                Text('OVER', style: _scaleTextStyle(theme)),
                                Text('25-29.9', style: _valueTextStyle(theme)),
                              ],
                            ),
                            Column(
                              children: [
                                Text('OBESE', style: _scaleTextStyle(theme).copyWith(color: Colors.red[400])),
                                Text('30+', style: _valueTextStyle(theme)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Causes & Risk Factors ──
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Factors Influencing Weight',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  _RiskFactorItem(
                    icon: Icons.science, // genetics equivalent
                    iconColor: Colors.indigo,
                    title: 'Genetics',
                    description: 'Inherited traits influencing fat storage and metabolic rate.',
                  ),
                  const SizedBox(height: AppTheme.spacingSm),
                  _RiskFactorItem(
                    icon: Icons.restaurant,
                    iconColor: Colors.amber,
                    title: 'Lifestyle Choices',
                    description: 'High-calorie diets and physical inactivity patterns.',
                  ),
                  const SizedBox(height: AppTheme.spacingSm),
                  _RiskFactorItem(
                    icon: Icons.holiday_village,
                    iconColor: Colors.teal, // emerald equivalent
                    title: 'Environment',
                    description: 'Limited access to fresh foods or safe physical activity zones.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppTheme.spacingLg),
            // ── Health Risks ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg, vertical: 24),
              decoration: BoxDecoration(
                color: isDark ? Colors.black.withValues(alpha: 0.2) : Colors.blueGrey.withValues(alpha: 0.05),
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: isDark ? const Color(0xFF334155).withValues(alpha: 0.5) : colorScheme.outline.withValues(alpha: 0.1),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Associated Health Risks',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingLg),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _HealthRiskBox(
                          icon: Icons.favorite,
                          iconSemanticLabel: 'Heart Icon',
                          iconBgColor: Colors.red.withValues(alpha: 0.1),
                          iconColor: Colors.red,
                          title: 'Heart Disease',
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingSm),
                      Expanded(
                        child: _HealthRiskBox(
                          icon: Icons.bloodtype, // blood_pressure equivalent
                          iconSemanticLabel: 'Blood Drop Icon',
                          iconBgColor: Colors.orange.withValues(alpha: 0.1),
                          iconColor: Colors.orange,
                          title: 'Type 2 Diabetes',
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingSm),
                      Expanded(
                        child: _HealthRiskBox(
                          icon: Icons.air,
                          iconSemanticLabel: 'Wind Icon',
                          iconBgColor: Colors.lightBlue.withValues(alpha: 0.1),
                          iconColor: Colors.lightBlue,
                          title: 'Sleep Apnea',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingXl),
                  Center(
                    child: Text(
                      'Maintaining a healthy weight can significantly reduce these risks.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingXxl),
            Center(
              child: Text(
                'SOURCE: WHO / CDC',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _scaleTextStyle(ThemeData theme) {
    return theme.textTheme.labelSmall!.copyWith(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
    );
  }

  TextStyle _valueTextStyle(ThemeData theme) {
    return theme.textTheme.bodySmall!.copyWith(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: theme.colorScheme.onSurface,
    );
  }
}

class _RiskFactorItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  const _RiskFactorItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B).withValues(alpha: 0.3) : colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: iconColor.withValues(alpha: 0.2),
              ),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HealthRiskBox extends StatelessWidget {
  final IconData icon;
  final String iconSemanticLabel;
  final Color iconBgColor;
  final Color iconColor;
  final String title;

  const _HealthRiskBox({
    required this.icon,
    required this.iconSemanticLabel,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        // Learn more action
      },
      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B).withValues(alpha: 0.6) : colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: isDark ? Colors.white.withValues(alpha: 0.05) : colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Semantics(
                label: iconSemanticLabel,
                child: Icon(icon, color: iconColor, size: 28),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Icon(
              Icons.expand_more, 
              size: 16, 
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _BmiSpectrumPainter extends CustomPainter {
  final double? currentBmi;
  final bool isDark;

  _BmiSpectrumPainter(this.currentBmi, this.isDark);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.blue[400]!,
          Colors.green[400]!,
          Colors.orange[400]!,
          Colors.red[400]!,
        ],
        stops: const [0.1, 0.4, 0.7, 0.9],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
      
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height), 
      const Radius.circular(6)
    );
    canvas.drawRRect(rrect, paint);

    if (currentBmi != null) {
      // Normal BMI range for visualization: roughly 15 to 40
      double normalized = ((currentBmi! - 15) / 25).clamp(0.0, 1.0);
      double x = normalized * size.width;
      
      final needleMainPaint = Paint()
        ..color = isDark ? Colors.white : Colors.black87
        ..style = PaintingStyle.fill;
        
      final needleInnerPaint = Paint()
        ..color = isDark ? Colors.black : Colors.white
        ..style = PaintingStyle.fill;
      
      final path = Path()
        ..moveTo(x, -6)
        ..lineTo(x - 5, -14)
        ..lineTo(x + 5, -14)
        ..close();
        
      canvas.drawPath(path, needleMainPaint);
      
      canvas.drawCircle(Offset(x, size.height / 2), size.height / 2 + 3, needleMainPaint);
      canvas.drawCircle(Offset(x, size.height / 2), size.height / 2 + 1, needleInnerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _BmiSpectrumPainter oldDelegate) {
    return oldDelegate.currentBmi != currentBmi || oldDelegate.isDark != isDark;
  }
}
