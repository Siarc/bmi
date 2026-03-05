import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// Risks of Overweight Guide page — matches the Stitch reference design.
class RisksOfOverweightPage extends StatelessWidget {
  const RisksOfOverweightPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Risks of Overweight Guide'),
        centerTitle: true,
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
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuCoh5KdBOX9C_Viw_HxLIoAat5ahEvO4yLMgjWQA1MrbPvHdeV7ovk_1nNGsXbBZxUbFy2zHJZks62nomwS1w7xcUVrJWaSN41_K6MxDjdRlV8yCc05g_O35ieULm5iDwoijBQvzJt85h9O1GNXQIlL-QhaXxZqMYI-LU-T41LIQ0GCi6FdiktCqNejBRHw7WYXALPJHOoQYfzSqGZBbC5xG5zrSZ2g24DYXerofsh9LrrD5G1v7qRvvV1Pi_Vqhs799A7DzhOC1F8',
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
                              Color(0xCC000000),
                              Color(0x4D000000),
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
                              'Risks of Being Overweight',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Understanding the medical impact of BMI',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
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

            // ── Section: Cardiovascular & Metabolic ──
            _SectionHeader(
              icon: Icons.favorite,
              title: 'Cardiovascular & Metabolic',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg),
              child: Column(
                children: [
                  _RiskDetailCard(
                    icon: Icons.monitor_heart_outlined,
                    iconBgColor: isDark
                        ? const Color(0x66991B1B)
                        : const Color(0x33EF4444),
                    iconColor: isDark
                        ? const Color(0xFFF87171)
                        : const Color(0xFFDC2626),
                    title: 'Hypertension',
                    description:
                        'High blood pressure increases heart workload and damages arteries over time.',
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  _RiskDetailCard(
                    icon: Icons.science_outlined,
                    iconBgColor: isDark
                        ? const Color(0x661E3A8A)
                        : const Color(0x333B82F6),
                    iconColor: isDark
                        ? const Color(0xFF60A5FA)
                        : const Color(0xFF2563EB),
                    title: 'Dyslipidemia',
                    description:
                        'Abnormal levels of blood fats like LDL cholesterol and triglycerides.',
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  _RiskDetailCard(
                    icon: Icons.bloodtype_outlined,
                    iconBgColor: isDark
                        ? const Color(0x66924400)
                        : const Color(0x33F59E0B),
                    iconColor: isDark
                        ? const Color(0xFFFBBF24)
                        : const Color(0xFFD97706),
                    title: 'Type 2 Diabetes',
                    description:
                        'Insulin resistance caused by excess adipose tissue affecting glucose regulation.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXxl),

            // ── Section: Physical & Structural ──
            _SectionHeader(
              icon: Icons.accessibility_new,
              title: 'Physical & Structural',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.1),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    _SimpleListTile(
                      icon: Icons.accessibility,
                      label: 'Osteoarthritis',
                      showDivider: true,
                    ),
                    _SimpleListTile(
                      icon: Icons.air,
                      label: 'Sleep Apnea',
                      showDivider: true,
                    ),
                    _SimpleListTile(
                      icon: Icons.medication_liquid,
                      label: 'Gallbladder Disease',
                      showDivider: false,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXxl),

            // ── Section: Systemic Risks ──
            _SectionHeader(
              icon: Icons.biotech,
              title: 'Systemic Risks',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg),
              child: Container(
                padding: const EdgeInsets.all(AppTheme.spacingLg),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    _SystemicRiskItem(
                      boldText: 'Cancer Risk:',
                      description:
                          ' Increased risk of breast, colon, and kidney cancers.',
                    ),
                    const SizedBox(height: AppTheme.spacingMd),
                    _SystemicRiskItem(
                      boldText: 'Chronic Inflammation:',
                      description:
                          ' Fat cells produce pro-inflammatory cytokines.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXxl),

            // ── Section: Mental Health & Lifestyle ──
            _SectionHeader(
              icon: Icons.psychology,
              title: 'Mental Health & Lifestyle',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg),
              child: Row(
                children: [
                  Expanded(
                    child: _MentalHealthCard(
                      icon: Icons.mood_bad,
                      iconColor: const Color(0xFF818CF8), // indigo-400
                      label: 'Depression &\nAnxiety',
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMd),
                  Expanded(
                    child: _MentalHealthCard(
                      icon: Icons.timer_off,
                      iconColor: AppColors.accentAmber,
                      label: 'Quality of Life',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXxl),

            // ── Section: Self-Reflection Questions ──
            _SectionHeader(
              icon: Icons.help_outline,
              title: 'Self-Reflection Questions',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg),
              child: Container(
                padding: const EdgeInsets.all(AppTheme.spacingXl),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1A1F2C)
                      : colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: const [
                    _SelfReflectionItem(
                      question:
                          'Do I find myself getting out of breath during activities that used to feel easy?',
                    ),
                    SizedBox(height: AppTheme.spacingLg),
                    _SelfReflectionItem(
                      question:
                          'Am I experiencing persistent pain in my knees, hips, or lower back?',
                    ),
                    SizedBox(height: AppTheme.spacingLg),
                    _SelfReflectionItem(
                      question:
                          'Do I frequently feel sluggish or crashing after meals?',
                    ),
                    SizedBox(height: AppTheme.spacingLg),
                    _SelfReflectionItem(
                      question:
                          'Has anyone told me that I snore loudly or seem to stop breathing in my sleep?',
                    ),
                    SizedBox(height: AppTheme.spacingLg),
                    _SelfReflectionItem(
                      question:
                          'Am I eating to satisfy physical hunger, or to manage emotions?',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXxl),

            // ── Note on BMI ──
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg),
              child: Container(
                padding: const EdgeInsets.all(AppTheme.spacingXxl),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1A1F2C)
                      : colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning_amber_rounded,
                            color: AppColors.accentAmber),
                        const SizedBox(width: AppTheme.spacingSm),
                        Text(
                          'A Note on BMI',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingMd),
                    Text(
                      'BMI is a screening tool, not a diagnostic one. It does not measure body fat directly and cannot distinguish between fat and muscle mass. Consult a healthcare provider for a complete clinical assessment.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.6,
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

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingLg, vertical: AppTheme.spacingLg),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 24),
          const SizedBox(width: AppTheme.spacingSm),
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _RiskDetailCard extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final String description;

  const _RiskDetailCard({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.description,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: AppTheme.spacingMd),
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
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
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

class _SimpleListTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool showDivider;

  const _SimpleListTile({
    required this.icon,
    required this.label,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: showDivider
            ? Border(
                bottom: BorderSide(
                  color: colorScheme.outline.withValues(alpha: 0.08),
                ),
              )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingLg,
          vertical: AppTheme.spacingLg,
        ),
        child: Row(
          children: [
            Icon(icon, color: colorScheme.onSurfaceVariant, size: 22),
            const SizedBox(width: AppTheme.spacingMd),
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.info_outline,
                size: 16,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
          ],
        ),
      ),
    );
  }
}

class _SystemicRiskItem extends StatelessWidget {
  final String boldText;
  final String description;

  const _SystemicRiskItem({
    required this.boldText,
    required this.description,
  });

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
          child: RichText(
            text: TextSpan(
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: boldText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                TextSpan(text: description),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MentalHealthCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;

  const _MentalHealthCard({
    required this.icon,
    required this.iconColor,
    required this.label,
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
        children: [
          Icon(icon, color: iconColor, size: 32),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SelfReflectionItem extends StatelessWidget {
  final String question;
  const _SelfReflectionItem({required this.question});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_box, color: colorScheme.primary, size: 20),
        const SizedBox(width: AppTheme.spacingMd),
        Expanded(
          child: Text(
            question,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
