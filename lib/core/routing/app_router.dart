import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/calculator/view/calculator_page.dart';
import '../../features/resources/view/resources_page.dart';
import '../../features/settings/view/settings_page.dart';
import '../../shared/widgets/app_shell.dart';

/// Application router using go_router with ShellRoute for 
/// persistent bottom navigation (proper mobile tab behavior).
class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  /// Named routes
  static const String calculatorPath = '/calculator';
  static const String resourcesPath = '/resources';
  static const String settingsPath = '/settings';

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: calculatorPath,
    routes: [
      /// ShellRoute wraps all tabs with a persistent bottom navigation bar.
      /// This prevents rebuilding the entire app when switching tabs.
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return AppShell(child: child);
        },
        routes: [
          GoRoute(
            path: calculatorPath,
            name: 'calculator',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CalculatorPage(),
            ),
          ),
          GoRoute(
            path: resourcesPath,
            name: 'resources',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ResourcesPage(),
            ),
          ),
          GoRoute(
            path: settingsPath,
            name: 'settings',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsPage(),
            ),
          ),
        ],
      ),
    ],
  );
}
