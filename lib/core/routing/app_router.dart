import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/calculator/view/calculator_page.dart';
import '../../features/calculator/view/bmi_result_page.dart';
import '../../features/resources/view/resources_page.dart';
import '../../features/resources/view/risks_of_overweight_page.dart';
import '../../features/resources/view/risks_of_underweight_page.dart';
import '../../features/resources/view/maintain_healthy_weight_page.dart';
import '../../features/resources/view/heart_healthy_diet_page.dart';
import '../../features/resources/view/increase_physical_activity_page.dart';
import '../../features/resources/view/activity_guidelines_page.dart';
import '../../features/resources/view/understanding_obesity_page.dart';
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
  static const String resultPath = '/result';
  static const String resourcesPath = '/resources';
  static const String risksOverweightPath = '/risks-of-overweight';
  static const String risksUnderweightPath = '/risks-of-underweight';
  static const String maintainHealthyWeightPath = '/maintain-healthy-weight';
  static const String heartHealthyDietPath = '/heart-healthy-diet';
  static const String increasePhysicalActivityPath = '/increase-physical-activity';
  static const String activityGuidelinesPath = '/activity-guidelines';
  static const String understandingObesityPath = '/understanding-obesity';
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

      /// Result page uses the root navigator so it covers the shell
      /// (no bottom navigation bar is shown on the result screen).
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: resultPath,
        name: 'result',
        builder: (context, state) => const BmiResultPage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: risksOverweightPath,
        name: 'risksOverweight',
        builder: (context, state) => const RisksOfOverweightPage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: risksUnderweightPath,
        name: 'risksUnderweight',
        builder: (context, state) => const RisksOfUnderweightPage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: maintainHealthyWeightPath,
        name: 'maintainHealthyWeight',
        builder: (context, state) => const MaintainHealthyWeightPage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: heartHealthyDietPath,
        name: 'heartHealthyDiet',
        builder: (context, state) => const HeartHealthyDietPage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: increasePhysicalActivityPath,
        name: 'increasePhysicalActivity',
        builder: (context, state) => const IncreasePhysicalActivityPage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: activityGuidelinesPath,
        name: 'activityGuidelines',
        builder: (context, state) => const ActivityGuidelinesPage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: understandingObesityPath,
        name: 'understandingObesity',
        builder: (context, state) => const UnderstandingObesityPage(),
      ),
    ],
  );
}
