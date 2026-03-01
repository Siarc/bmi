import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/settings_bloc.dart';

/// Settings Page — theme toggle and app information.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Settings', style: theme.textTheme.headlineMedium),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingXxl),
        children: [
          // Appearance section
          Text(
            'APPEARANCE',
            style: theme.textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),
          _SettingsCard(
            child: SwitchListTile(
              title: Text('Dark Mode', style: theme.textTheme.bodyLarge),
              subtitle: Text(
                isDark ? 'Dark theme enabled' : 'Light theme enabled',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              value: isDark,
              onChanged: (_) {
                context.read<ThemeCubit>().toggleTheme();
              },
              secondary: Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                color: colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingXxl),

          const SizedBox(height: AppTheme.spacingXxl),

          // About section
          Text(
            'ABOUT',
            style: theme.textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),
          _SettingsCard(
            child: ListTile(
              leading: Icon(Icons.info_outline, color: colorScheme.primary),
              title: Text('Version', style: theme.textTheme.bodyLarge),
              trailing: Text(
                '1.0.0',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),
          _SettingsCard(
            child: ListTile(
              leading: Icon(Icons.privacy_tip_outlined,
                  color: colorScheme.primary),
              title:
                  Text('Privacy Policy', style: theme.textTheme.bodyLarge),
              trailing: Icon(Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final Widget child;
  const _SettingsCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        child: child,
      ),
    );
  }
}
