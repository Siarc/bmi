import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// Resources Page — educational BMI information and health resources.
/// Matches the reference "Health Resources Library" design.
class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Improve Your Health',
            style: theme.textTheme.headlineMedium),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingLg,
          vertical: AppTheme.spacingXxl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Explore our curated library of resources designed to help '
              'you understand your BMI and take actionable steps towards '
              'better heart health.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
            const SizedBox(height: AppTheme.spacingXxxl),
            _SectionHeader(
              icon: Icons.accessibility_new,
              title: 'What you can do',
            ),
            const SizedBox(height: AppTheme.spacingLg),
            _ResourceCard(
              bgColor: AppColors.blueCardBg,
              iconColor: AppColors.accentBlue,
              icon: Icons.monitor_weight_outlined,
              title: 'Maintain a healthy weight',
              subtitle: 'Tips for balancing calories and activity.',
              onTap: () => context.push(AppRouter.maintainHealthyWeightPath),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            _ResourceCard(
              bgColor: AppColors.roseCardBg,
              iconColor: AppColors.accentRose,
              icon: Icons.favorite_outline,
              title: 'Eat heart-healthy',
              subtitle: 'Foods that lower blood pressure naturally.',
              onTap: () => context.push(AppRouter.heartHealthyDietPath),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            _ResourceCard(
              bgColor: AppColors.emeraldCardBg,
              iconColor: AppColors.accentEmerald,
              icon: Icons.restaurant_menu,
              title: 'Healthy Recipes',
              subtitle: 'Delicious, low-sodium meals for your heart.',
            ),
            const SizedBox(height: AppTheme.spacingMd),
            _ResourceCard(
              bgColor: AppColors.amberCardBg,
              iconColor: AppColors.accentAmber,
              icon: Icons.directions_run,
              title: 'Increase Activity',
              subtitle: 'Add movement to your daily routine.',
              onTap: () => context.push(AppRouter.increasePhysicalActivityPath),
            ),
            const SizedBox(height: AppTheme.spacingXxxl),
            _SectionHeader(
              icon: Icons.analytics_outlined,
              title: 'Understand your data',
            ),
            const SizedBox(height: AppTheme.spacingLg),
            _ResourceCard(
              bgColor: AppColors.indigoCardBg,
              iconColor: AppColors.accentIndigo,
              icon: Icons.info_outline,
              title: 'What is Obesity?',
              subtitle: 'Risks and treatments for obesity.',
            ),
            const SizedBox(height: AppTheme.spacingMd),
            _ResourceCard(
              bgColor: AppColors.cyanCardBg,
              iconColor: AppColors.accentCyan,
              icon: Icons.speed,
              title: 'Control your numbers',
              subtitle: 'BMI, cholesterol, and blood pressure.',
            ),
            const SizedBox(height: AppTheme.spacingMd),
            _ResourceCard(
              bgColor: AppColors.roseCardBg,
              iconColor: AppColors.accentRose,
              icon: Icons.trending_up,
              title: 'Risks of Overweight',
              subtitle: 'Learn about the health risks associated with a high BMI.',
              onTap: () => context.push(AppRouter.risksOverweightPath),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            _ResourceCard(
              bgColor: AppColors.blueCardBg,
              iconColor: AppColors.accentBlue,
              icon: Icons.trending_down,
              title: 'Risks of Underweight',
              subtitle: 'Understand health complications of low body weight.',
              onTap: () => context.push(AppRouter.risksUnderweightPath),
            ),
            const SizedBox(height: AppTheme.spacingXxxl),
            _FindDoctorCard(),
            const SizedBox(height: AppTheme.spacingXxxl),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 24),
        const SizedBox(width: AppTheme.spacingSm),
        Text(title, style: theme.textTheme.titleLarge),
      ],
    );
  }
}

class _ResourceCard extends StatelessWidget {
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  const _ResourceCard({
    required this.bgColor,
    required this.iconColor,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingLg),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(color: cs.outline.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: AppTheme.spacingLg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.headlineSmall?.copyWith(
                    fontSize: 15,
                  )),
                  const SizedBox(height: 2),
                  Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant, fontSize: 13,
                  )),
                ],
              ),
            ),
            Icon(Icons.chevron_right,
                color: cs.onSurfaceVariant.withValues(alpha: 0.5), size: 20),
          ],
        ),
      ),
    );
  }
}

/// "Find a Doctor" CTA card from the reference design.
class _FindDoctorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingXxl),
      decoration: BoxDecoration(
        color: AppColors.ctaBackground,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        boxShadow: [
          BoxShadow(
            color: AppColors.ctaBackground.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Need professional advice?',
              style: theme.textTheme.displaySmall?.copyWith(
                color: Colors.white,
              )),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            'Find a healthcare provider to discuss your personal '
            'health plan and get expert guidance.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: AppTheme.spacingXxl),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              // TODO: Implement doctor locator feature
              // Navigate to a doctor finder screen with location/specialty search.
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.ctaBackground,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
              ),
              child: Text('Find a Doctor',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: AppColors.ctaBackground,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
