import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// Activity Guidelines by Age page.
class ActivityGuidelinesPage extends StatelessWidget {
  const ActivityGuidelinesPage({super.key});

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
        title: const Text('Guidelines'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg, vertical: AppTheme.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity Guidelines by Age',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'CDC recommendations for physical activity to maintain optimal cardiovascular health and BMI levels.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg, vertical: 8),
              child: _GuidelineCard(
                icon: Icons.child_care,
                title: 'Children & Adolescents',
                requirementLabel: 'Daily Requirement',
                requirementMins: '60',
                requirementText: 'Moderate-to-vigorous activity daily.',
                isDark: isDark,
                imageUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBURXjbCW8IC_lYD7TmyqdWHs7xWtshRECUQHO7vZ5VPX71qdAVBSLAzQJZqhC5jSF6oEo3zjjsmobBv1blMuovnWcifJZsXl43gsnb1HFC4fcl8jA2-M5AvmYC-UeoVcbHfgttzfJ9UvU30IhXuar70Q4eF__pDoBtKZt4L0B9lr896pib04quPBmfs4UNy9xoQavRx9-EZu-1Mr8Jd_laTaY0BqHAQFVyI4UgdCcTtpE8FSnCYO4COwgYJVcvVOCLlqiwo1pAPHQ',
                bullets: const [
                  _BulletItem(
                    title: 'Aerobic Activity',
                    subtitle: 'Running or soccer (at least 3 days/week).',
                  ),
                  _BulletItem(
                    title: 'Muscle Strengthening',
                    subtitle: 'Climbing or push-ups (3 days/week).',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg, vertical: 8),
              child: _GuidelineCard(
                icon: Icons.directions_run,
                title: 'Adults (18-64)',
                requirementLabel: 'Weekly Requirement',
                requirementMins: '150',
                requirementText: 'Moderate-intensity aerobic activity per week.',
                isDark: isDark,
                imageUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuB_50DOdEbEJiaACv8PCYCVOukMk8nndsAnj-Bdh2ISnl-aQXout3mBQLwgC2xYOS1HbYzYWlFfncNmgAsfAxVi_Rd71FFf8HuLa4nJDdF-1f_7yaTJgE-8cLNsneL_nLjy9pYJZs0VAC41Fipi7ITp8rxQZ7B2fP5CMBqErOcnxiwBVqxIHZgE8Dw2wytm2Jw0_bo4wY2DZb8HQ2sch1mQPaL9FjCTPMpoir1L0hIuFMKHc5Mlriy3dMXYl9OcQQdBKiKOOcQFpVk',
                customContent: Column(
                  children: [
                    _AdultActivityRow(
                      icon: Icons.fitness_center,
                      title: 'Muscle Strengthening',
                      badgeText: '2 Days/Week',
                      isDark: isDark,
                    ),
                    const SizedBox(height: 12),
                    _AdultActivityRow(
                      icon: Icons.monitor_heart,
                      title: 'Moderate Aerobic',
                      badgeText: 'Brisk Walk',
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg, vertical: 8),
              child: _GuidelineCard(
                icon: Icons.elderly,
                title: 'Older Adults (65+)',
                requirementLabel: 'Balance & Multi-component',
                requirementMins: '150',
                requirementText:
                    'Weekly aerobic plus balance-focused training.',
                isDark: isDark,
                imageUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBPVMdMWykOZ-mIUTTh0eXXqMb5vln4a3wFdGEXPGVnWRuvRk62Szvzqn_bGSOSynFlw0PqJPHV6jQnLwUMFPeKc55jULVpHg7vjeUh-6T-o34qAqvEXxsaK89Eo2hnytKLXSwOP_ZemAjs1kUJdB0A8vpFtLBbfMoQgZ2smJyFivj1gNuNUXSfh9eHod2ncagxpj-uugnU84JNMbgM7VcN4bfrEVGGCSo-vyZ138mHT55wT9FTxWi-hpcXMjZOayWWv8qM1w2qwU4',
                customContent: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                      left: BorderSide(
                        color: colorScheme.primary,
                        width: 4,
                      ),
                    ),
                  ),
                  child: Text(
                    '"Older adults should determine their level of effort for physical activity relative to their level of fitness."',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? Colors.blue[100]?.withValues(alpha: 0.8)
                          : Colors.blue[900]?.withValues(alpha: 0.8),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg, vertical: 24),
              child: Text(
                'SOURCE: CENTERS FOR DISEASE CONTROL AND PREVENTION (CDC)',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GuidelineCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String requirementLabel;
  final String requirementMins;
  final String requirementText;
  final bool isDark;
  final String imageUrl;
  final List<_BulletItem>? bullets;
  final Widget? customContent;

  const _GuidelineCard({
    required this.icon,
    required this.title,
    required this.requirementLabel,
    required this.requirementMins,
    required this.requirementText,
    required this.isDark,
    required this.imageUrl,
    this.bullets,
    this.customContent,
  });

  Color _getTextColor(BuildContext context) {
    if (isDark) return Colors.white;
    return Colors.black87;
  }

  Color _getSecondaryTextColor(BuildContext context) {
    if (isDark) return Colors.white.withValues(alpha: 0.7);
    return Colors.black54;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        border: Border.all(
          color: isDark
              ? const Color(0xFF334155) // slate-700
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
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: colorScheme.primary, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _getTextColor(context),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF334155).withValues(alpha: 0.4)
                        : colorScheme.primaryContainer.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF334155)
                          : colorScheme.outline.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        requirementLabel.toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                          letterSpacing: 1.0,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            requirementMins,
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: _getTextColor(context),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'mins',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        requirementText,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: _getSecondaryTextColor(context),
                        ),
                      ),
                    ],
                  ),
                ),
                if (bullets != null || customContent != null)
                  const SizedBox(height: 16),
                ...?bullets?.map((b) => _BulletItem(
                      title: b.title,
                      subtitle: b.subtitle,
                      isDark: isDark,
                    )),
                ?customContent,
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 120, // h-32
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool? isDark;

  const _BulletItem({
    required this.title,
    required this.subtitle,
    this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final effectiveIsDark = isDark ?? (theme.brightness == Brightness.dark);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: colorScheme.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: effectiveIsDark ? Colors.grey[200] : Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: effectiveIsDark
                        ? Colors.white.withValues(alpha: 0.6)
                        : Colors.black54,
                    fontSize: 12,
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

class _AdultActivityRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String badgeText;
  final bool isDark;

  const _AdultActivityRow({
    required this.icon,
    required this.title,
    required this.badgeText,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF334155).withValues(alpha: 0.2)
            : colorScheme.surface,
        border: Border.all(
          color: isDark
              ? const Color(0xFF334155)
              : colorScheme.outline.withValues(alpha: 0.1),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(icon, color: colorScheme.primary, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.grey[200] : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              badgeText,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
