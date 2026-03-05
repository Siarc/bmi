import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// Maintain Healthy Weight tips page — matches the Stitch reference design.
class MaintainHealthyWeightPage extends StatelessWidget {
  const MaintainHealthyWeightPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Maintain Healthy Weight'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, size: 20),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero Banner ──
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                child: SizedBox(
                  height: 224, // h-56 in Tailwind is 14rem = 224px
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuA2WD3AOIlgvUbdzE6EHswXfUalxxzYmSeE1gITXheXkJ4n1KRIr4RQHyqWH-1IxKNtoRdCvIFAE7QO6mDwKED5K8UL7icWwptVY3ZQAKGq_OIT0dmQkKPeg0NApAeNOTvCm9DlyPYvX_tq41aXY-cI_2eh32KufjdRmUeJpTuitng2wMj2qFDeEAOPVDpI1UcuCSA3vGCC_YCI4xLK2ddO9k58RmHdq1ciU_sPC_qIAwW43RBy35ozeZA26XxexLurWXPh_CdYZis',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color(0xE60F172A), // background-dark/90
                              Color(0x330F172A), // background-dark/20
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 24,
                        left: 24,
                        right: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'FEATURED GUIDE',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Your Journey to Lasting Vitality',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
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
            ),

            // ── Why Weight Matters ──
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
              child: Container(
                padding: const EdgeInsets.all(AppTheme.spacingXl),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF334155) // slate-700 -> roughly slate-800
                        : colorScheme.outline.withValues(alpha: 0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                          ),
                          child: Icon(Icons.monitor_heart_outlined,
                              color: colorScheme.primary, size: 24),
                        ),
                        const SizedBox(width: AppTheme.spacingMd),
                        Text(
                          'Why Weight Matters',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingLg),
                    Text(
                      'Maintaining a healthy weight is fundamental for your overall well-being. It helps prevent and control many chronic diseases.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXl),
                    Text(
                      'INCREASED RISK FACTORS:',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingLg),
                    _RiskFactorItem(
                      icon: Icons.favorite,
                      iconColor: Colors.red[400]!,
                      title: 'Heart Disease & Stroke',
                    ),
                    const SizedBox(height: AppTheme.spacingMd),
                    _RiskFactorItem(
                      icon: Icons.monitor_heart_outlined, // Blood pressure equivalent
                      iconColor: Colors.orange[400]!,
                      title: 'High Blood Pressure',
                    ),
                    const SizedBox(height: AppTheme.spacingMd),
                    _RiskFactorItem(
                      icon: Icons.medical_services,
                      iconColor: Colors.blue[400]!,
                      title: 'Type 2 Diabetes',
                    ),
                  ],
                ),
              ),
            ),

            // ── Healthy Eating Plan ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(AppTheme.spacingXl),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF334155)
                        : colorScheme.outline.withValues(alpha: 0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.emeraldCardBg,
                            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                          ),
                          child: Icon(Icons.restaurant,
                              color: AppColors.accentEmerald, size: 24),
                        ),
                        const SizedBox(width: AppTheme.spacingMd),
                        Text(
                          'Healthy Eating Plan',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingLg),
                    Text(
                      'A healthy lifestyle is built on a foundation of diverse, nutrient-rich foods that fuel your body efficiently.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXl),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _FoodCategoryItem(
                          icon: Icons.eco_outlined, // Nutrition equivalent
                          iconColor: Colors.orange[400]!,
                          title: 'Whole Grains',
                        ),
                        _FoodCategoryItem(
                          icon: Icons.apple, // Apple equivalent
                          iconColor: Colors.red[400]!,
                          title: 'Fruits',
                        ),
                        _FoodCategoryItem(
                          icon: Icons.grass,
                          iconColor: AppColors.accentEmerald,
                          title: 'Vegetables',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingXl),
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacingLg),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF0F172A).withValues(alpha: 0.5) // slate-900/50
                            : colorScheme.primaryContainer.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF1E293B) // slate-800
                              : colorScheme.outline.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pro Tips',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingMd),
                          _TipItem(text: 'Control portion sizes to manage calorie intake.'),
                          const SizedBox(height: AppTheme.spacingMd),
                          _TipItem(text: 'Choose water over sugary drinks and sodas.'),
                          const SizedBox(height: AppTheme.spacingMd),
                          _TipItem(text: 'Limit foods with added sugars and saturated fats.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Private Widgets
// ─────────────────────────────────────────────

class _RiskFactorItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;

  const _RiskFactorItem({
    required this.icon,
    required this.iconColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A).withValues(alpha: 0.5) : colorScheme.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border(
          left: BorderSide(color: colorScheme.primary, width: 4),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: AppTheme.spacingMd),
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _FoodCategoryItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;

  const _FoodCategoryItem({
    required this.icon,
    required this.iconColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0F172A).withValues(alpha: 0.8) : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            border: Border.all(
              color: isDark ? const Color(0xFF334155) : theme.colorScheme.outline.withValues(alpha: 0.1),
            ),
          ),
          child: Center(
            child: Icon(icon, color: iconColor, size: 36),
          ),
        ),
        const SizedBox(height: AppTheme.spacingSm),
        Text(
          title,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _TipItem extends StatelessWidget {
  final String text;

  const _TipItem({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: colorScheme.primary, size: 20),
        const SizedBox(width: AppTheme.spacingMd),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
