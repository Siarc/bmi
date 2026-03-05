import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// Risks of Underweight Guide page — matches the Stitch reference design.
class RisksOfUnderweightPage extends StatelessWidget {
  const RisksOfUnderweightPage({super.key});

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
        title: const Text('Risks of Underweight Guide'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero Banner ──
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg,
                  vertical: AppTheme.spacingXxl),
              child: Container(
                height: 176,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusXl),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              colorScheme.primary.withValues(alpha: 0.1),
                              const Color(0xFF06B6D4).withValues(alpha: 0.1),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.medical_services,
                              color: colorScheme.primary, size: 48),
                          const SizedBox(height: AppTheme.spacingSm),
                          Text(
                            'Health Risk Education',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Based on CDC & NHS Guidelines',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Section: Nutritional & Blood Health ──
            _SectionHeader(
              icon: Icons.restaurant,
              title: 'Nutritional & Blood Health',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg),
              child: Column(
                children: [
                  _NutritionCard(
                    icon: Icons.restaurant_menu,
                    title: 'Malnutrition',
                    description:
                        'Inadequate intake of essential vitamins and minerals needed for organ function.',
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  _NutritionCard(
                    icon: Icons.bloodtype,
                    title: 'Anemia',
                    description:
                        'Low red blood cell count leading to fatigue, dizziness, and shortness of breath.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXxl),

            // ── Section: Structural & Immune ──
            _SectionHeader(
              icon: Icons.accessibility,
              title: 'Structural & Immune',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg),
              child: Column(
                children: [
                  _ImmuneCard(
                    icon: Icons.accessibility,
                    title: 'Osteoporosis',
                    description:
                        'Brittle bones and increased fracture risk due to nutrient deficiency.',
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  _ImmuneCard(
                    icon: Icons.verified_user,
                    title: 'Weakened Immunity',
                    description:
                        'Higher susceptibility to infections and slower recovery times.',
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  _ImmuneCard(
                    icon: Icons.healing,
                    title: 'Slow Healing',
                    description:
                        'Body takes longer to repair wounds and surgical incisions.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXxl),

            // ── Section: Growth & Reproductive ──
            _SectionHeader(
              icon: Icons.child_care,
              title: 'Growth & Reproductive',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg),
              child: Column(
                children: [
                  _LeftBorderedCard(
                    icon: Icons.trending_up,
                    title: 'Developmental Delays',
                    description:
                        'Critical for children and teens; low BMI can stunt growth and brain development.',
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  _LeftBorderedCard(
                    icon: Icons.female,
                    title: 'Hormonal Imbalances',
                    description:
                        'Irregular menstrual cycles (amenorrhea) and potential infertility issues.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXxl),

            // ── Section: Potential Underlying Factors ──
            _SectionHeader(
              icon: Icons.search,
              title: 'Potential Underlying Factors',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg),
              child: Wrap(
                spacing: AppTheme.spacingSm,
                runSpacing: AppTheme.spacingSm,
                children: const [
                  _FactorChip(label: 'Eating Disorders'),
                  _FactorChip(label: 'Hyperthyroidism'),
                  _FactorChip(label: 'Celiac Disease'),
                  _FactorChip(label: 'Malabsorption'),
                  _FactorChip(label: 'Type 1 Diabetes'),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXxl),

            // ── Section: Self-Reflection Questions ──
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg),
              child: Container(
                padding: const EdgeInsets.all(AppTheme.spacingXxl),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF0F172A)
                      : colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.08),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withValues(alpha: isDark ? 0.3 : 0.05),
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
                        Icon(Icons.quiz,
                            color: colorScheme.primary, size: 22),
                        const SizedBox(width: AppTheme.spacingSm),
                        Text(
                          'Self-Reflection Questions',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingXl),
                    _CheckboxQuestion(
                      question:
                          'Do you often feel tired or cold even in warm environments?',
                    ),
                    const SizedBox(height: AppTheme.spacingXl),
                    _CheckboxQuestion(
                      question:
                          'Have you experienced unintended weight loss recently?',
                    ),
                    const SizedBox(height: AppTheme.spacingXl),
                    _CheckboxQuestion(
                      question:
                          'Is your hair thinning or skin unusually dry?',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingXxl),

            // ── Peer Note on BMI ──
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg),
              child: Container(
                padding: const EdgeInsets.all(AppTheme.spacingXl),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline,
                        color: colorScheme.primary, size: 20),
                    const SizedBox(width: AppTheme.spacingLg),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            height: 1.6,
                            fontStyle: FontStyle.italic,
                          ),
                          children: [
                            TextSpan(
                              text: 'Peer Note on BMI: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                color: theme.textTheme.bodyLarge?.color,
                              ),
                            ),
                            const TextSpan(
                              text:
                                  'While BMI is a useful screening tool, it does not measure body fat directly or account for muscle mass and bone density. Always consult a healthcare provider for a complete clinical assessment.',
                            ),
                          ],
                        ),
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
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NutritionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _NutritionCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingXl),
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
          Icon(icon, color: colorScheme.primary, size: 30),
          const SizedBox(height: AppTheme.spacingMd),
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
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _ImmuneCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _ImmuneCard({
    required this.icon,
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
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary.withValues(alpha: 0.1),
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.1),
              ),
            ),
            child: Icon(icon, color: colorScheme.primary, size: 22),
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
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
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

class _LeftBorderedCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _LeftBorderedCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingXl),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: colorScheme.primary,
              width: 4,
            ),
          ),
        ),
        padding: const EdgeInsets.only(left: AppTheme.spacingMd),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colorScheme.primary, size: 22),
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
      ),
    );
  }
}

class _FactorChip extends StatelessWidget {
  final String label;
  const _FactorChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingLg, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.4),
        ),
      ),
      child: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _CheckboxQuestion extends StatelessWidget {
  final String question;
  const _CheckboxQuestion({required this.question});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: isDark
                    ? const Color(0xFF475569) // slate-600
                    : const Color(0xFF9CA3AF), // gray-400
                width: 2,
              ),
              color: isDark
                  ? const Color(0xFF1E293B) // slate-800
                  : Colors.white,
            ),
          ),
        ),
        const SizedBox(width: AppTheme.spacingLg),
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
