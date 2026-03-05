import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// Increase Physical Activity tips page — matches the Stitch reference design.
class IncreasePhysicalActivityPage extends StatelessWidget {
  const IncreasePhysicalActivityPage({super.key});

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
        title: const Text('Physical Activity Guide'),
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
                borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                child: SizedBox(
                  height: 208, // h-52 is 13rem = 208px
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuDiP-hexaxWON7LwdSkf2l7n1nD_8fk3_6vMaCb4RUyYg09XnNrY2ENgL8bTdhci3m_4SPB-TZLDrgm_kyzPPqG3vWpIpiLMWPe_6KVLMNvrhoDb2HlMtQEjeFQtAmZW14vIM070lGXE6ZV2_QsjFBh_hJeaDMBWDTS165j3ZiEM758iIp7X36AAyAM9-vSl0XsQbSMR-y00a8VorfN6DvXA_-PnxVCq8qQBK0aTHQt-5F6ygcTxkWJgZetfxoNzIJZJ-bdmkGtCak',
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
                              Color(0xE60A0F1A), // background-dark/90
                              Color(0x66135BEC), // primary/40
                              Colors.transparent,
                            ],
                            stops: [0.0, 1.0, 1.0],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Text(
                                'HEALTH RESOURCE',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Increase Your\nDaily Movement',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                                fontSize: 24,
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

            // ── Getting Started ──
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(title: 'Getting Started'),
                  const SizedBox(height: AppTheme.spacingMd),
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacingXl),
                    decoration: _cardDecoration(isDark, colorScheme),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                            border: Border.all(
                              color: colorScheme.primary.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Icon(Icons.verified_user,
                              color: colorScheme.primary, size: 24),
                        ),
                        const SizedBox(width: AppTheme.spacingLg),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CDC Guidelines',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'For substantial health benefits, adults should aim for:',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: AppTheme.spacingLg),
                              _GuidelineItem(
                                highlightText: '150 minutes',
                                text: ' of moderate-intensity aerobic activity per week.',
                              ),
                              const SizedBox(height: AppTheme.spacingMd),
                              _GuidelineItem(
                                highlightText: '2 days',
                                text: ' of muscle-strengthening activity per week.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Benefits of Movement ──
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(title: 'Benefits of Movement'),
                  const SizedBox(height: AppTheme.spacingMd),
                  _BenefitItem(
                    icon: Icons.favorite,
                    iconColor: Colors.red[400]!,
                    iconBgColor: Colors.red.withValues(alpha: 0.1),
                    title: 'Heart Health',
                    subtitle: 'Improves circulation and lowers BP',
                    isDark: isDark,
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  _BenefitItem(
                    icon: Icons.fitness_center,
                    iconColor: Colors.orange[400]!,
                    iconBgColor: Colors.orange.withValues(alpha: 0.1),
                    title: 'Weight Control',
                    subtitle: 'Helps manage BMI and body fat',
                    isDark: isDark,
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  _BenefitItem(
                    icon: Icons.mood,
                    iconColor: Colors.blue[400]!,
                    iconBgColor: Colors.blue.withValues(alpha: 0.1),
                    title: 'Mood Booster',
                    subtitle: 'Reduces stress and releases endorphins',
                    isDark: isDark,
                  ),
                ],
              ),
            ),

            // ── Types of Activity ──
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(title: 'Types of Activity'),
                  const SizedBox(height: AppTheme.spacingMd),
                  Row(
                    children: [
                      Expanded(
                        child: _ActivityTypeItem(
                          icon: Icons.directions_run,
                          title: 'Aerobic',
                          description: 'Walking, swimming, cycling, or light jogging.',
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingLg),
                      Expanded(
                        child: _ActivityTypeItem(
                          icon: Icons.fitness_center, // Equivalent to 'weight'
                          title: 'Strengthening',
                          description: 'Free weights, resistance bands, or yoga.',
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Pro Tip ──
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF0B255E)
                      : Colors.blue[50], // deep-blue-tip equivalent
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  border: Border.all(
                    color: Colors.blue.withValues(alpha: 0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade900.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
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
                            color: Colors.blue[400]?.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.lightbulb,
                              color: isDark ? Colors.blue[300] : Colors.blue[700],
                              size: 20),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Pro Tip',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.blue[900],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? Colors.blue[100]?.withValues(alpha: 0.8)
                              : Colors.blue[900]?.withValues(alpha: 0.8),
                          height: 1.6,
                        ),
                        children: [
                          const TextSpan(text: 'Start slow and build up. Even '),
                          TextSpan(
                            text: '5-10 minutes',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.blue[200] : Colors.blue[800],
                            ),
                          ),
                          const TextSpan(
                            text:
                                ' of movement is better than none! Consistency is key to long-term heart health.',
                          ),
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

  BoxDecoration _cardDecoration(bool isDark, ColorScheme colorScheme) {
    return BoxDecoration(
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
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Private Widgets
// ─────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title.toUpperCase(),
      style: theme.textTheme.labelSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
        letterSpacing: 2.0,
      ),
    );
  }
}

class _GuidelineItem extends StatelessWidget {
  final String highlightText;
  final String text;

  const _GuidelineItem({
    required this.highlightText,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check_circle, color: colorScheme.primary, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              children: [
                TextSpan(
                  text: highlightText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                TextSpan(text: text),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final bool isDark;

  const _BenefitItem({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        border: Border.all(
          color: isDark
              ? const Color(0xFF334155)
              : colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: iconColor.withValues(alpha: 0.2),
              ),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 16),
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
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
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

class _ActivityTypeItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isDark;

  const _ActivityTypeItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        border: Border.all(
          color: isDark
              ? const Color(0xFF334155)
              : colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.2),
              ),
            ),
            child: Icon(icon, color: colorScheme.primary, size: 28),
          ),
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontSize: 12,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
