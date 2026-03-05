import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// Heart-Healthy Diet Guide page matching the Stitch reference design.
class HeartHealthyDietPage extends StatelessWidget {
  const HeartHealthyDietPage({super.key});

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
          color: colorScheme.primary,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Heart-Healthy Diet'),
        centerTitle: false,
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
                  height: 192, // h-48 in Tailwind
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuDajHPnwiXX2hy-59TKcz_YT4jaBvnKvBGYxSToOzKqFKRBnwHRRj-GVvtB3WnROxtR8PXJKjufFxdUplXVtzg9mxW7nZv-Hyp7UsH61lpjD3Tl6Lin7H69jbgMUFJrukcNhq2N-TVw2jgpFQWcPg445duw_p1FD9Si-yRcc_rtTFKFJZzn7sVu3_PfwH4y_lirxhNV_QSXtx4b4GjZuxKOXWUuXkYfgZsfK9Bk0e2cSaMyH5tUbrkpJy_67uCFZGZ9JKj5kieqVrs',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              colorScheme.primary.withValues(alpha: 0.9),
                              colorScheme.primary.withValues(alpha: 0.4),
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
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(9999),
                              ),
                              child: Text(
                                'NHLBI GUIDELINES',
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
                              'Eat a Heart-Healthy Diet',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Lower your BMI and blood pressure.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white.withValues(alpha: 0.8),
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

            // ── What to Eat ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'What to Eat',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'View All',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingLg),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: AppTheme.spacingMd,
                    crossAxisSpacing: AppTheme.spacingMd,
                    childAspectRatio: 0.85,
                    children: [
                      _FoodCard(
                        icon: Icons.eco,
                        iconColor: Colors.green[500]!, // Green
                        iconBgColor: isDark ? Colors.green[500]!.withValues(alpha: 0.2) : Colors.green[100]!,
                        title: 'Fruits & Veggies',
                        subtitle: 'Leafy greens, berries, citrus fruits.',
                      ),
                      _FoodCard(
                        icon: Icons.bakery_dining,
                        iconColor: Colors.amber[500]!, // Amber
                        iconBgColor: isDark ? Colors.amber[500]!.withValues(alpha: 0.2) : Colors.amber[100]!,
                        title: 'Whole Grains',
                        subtitle: 'Oatmeal, brown rice, and quinoa.',
                      ),
                      _FoodCard(
                        icon: Icons.set_meal,
                        iconColor: Colors.blue[400]!, // Blue
                        iconBgColor: isDark ? Colors.blue[500]!.withValues(alpha: 0.2) : Colors.blue[100]!,
                        title: 'Lean Proteins',
                        subtitle: 'Fish, beans, skinless poultry.',
                      ),
                      _FoodCard(
                        icon: Icons.water_drop,
                        iconColor: AppColors.accentEmerald, // Emerald
                        iconBgColor: AppColors.emeraldCardBg,
                        title: 'Healthy Fats',
                        subtitle: 'Nuts, seeds, and avocados.',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── What to Limit ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What to Limit',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingLg),
                  _LimitItem(
                    icon: Icons.do_not_disturb_on,
                    iconColor: Colors.red[500]!,
                    iconBgColor: isDark ? Colors.red[500]!.withValues(alpha: 0.1) : Colors.red[50]!,
                    title: 'Sodium & Salts',
                    subtitle: 'Aim for less than 2,300mg per day.',
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  _LimitItem(
                    icon: Icons.warning,
                    iconColor: Colors.orange[500]!,
                    iconBgColor: isDark ? Colors.orange[500]!.withValues(alpha: 0.1) : Colors.orange[50]!,
                    title: 'Saturated Fats',
                    subtitle: 'Limit butter, cheese, and red meats.',
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  _LimitItem(
                    icon: Icons.icecream,
                    iconColor: isDark ? Colors.yellow[500]! : Colors.yellow[600]!,
                    iconBgColor: isDark ? Colors.yellow[500]!.withValues(alpha: 0.1) : Colors.yellow[50]!,
                    title: 'Added Sugars',
                    subtitle: 'Reduce soda, sweets, and desserts.',
                  ),
                ],
              ),
            ),

            // ── DASH Highlight Box ──
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.dashBlue, // The special dash-blue
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.dashBlue.withValues(alpha: 0.4),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -64,
                      top: -64,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.verified, color: Color(0xFF93C5FD), size: 24), // blue-300
                            const SizedBox(width: 8),
                            Text(
                              'The DASH Eating Plan',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppTheme.spacingLg),
                        Text(
                          'Dietary Approaches to Stop Hypertension (DASH) is proven to lower blood pressure and LDL cholesterol levels.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFFDBEAFE), // blue-100
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.dashBlue,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                              ),
                            ),
                            child: const Text('View Sample Plan', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ── Quick Tips ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Tips',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingLg),
                  _QuickTipCard(
                    icon: Icons.manage_search,
                    title: 'Read Nutrition Labels',
                    subtitle: 'Focus on sodium % Daily Value (DV).',
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  _QuickTipCard(
                    icon: Icons.swap_horiz,
                    title: 'Smart Swaps',
                    subtitle: 'Use herbs instead of salt for flavoring.',
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

// ─────────────────────────────────────────────
// Private Widgets
// ─────────────────────────────────────────────

class _FoodCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;

  const _FoodCard({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: isDark ? const Color(0xFF334155).withValues(alpha: 0.5) : colorScheme.outline.withValues(alpha: 0.1),
        ),
        boxShadow: isDark
            ? [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 16)]
            : [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const Spacer(),
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
              height: 1.3,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _LimitItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;

  const _LimitItem({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: isDark ? const Color(0xFF334155).withValues(alpha: 0.5) : colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: AppTheme.spacingLg),
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
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
        ],
      ),
    );
  }
}

class _QuickTipCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _QuickTipCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: colorScheme.primary, size: 32),
          const SizedBox(width: AppTheme.spacingLg),
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
                const SizedBox(height: 2),
                Text(
                  subtitle,
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
