# BMI Calculator

A production-ready Flutter BMI Calculator application built with **Clean Architecture**, **BLoC pattern**, and a strict theme system extracted from a reference Stitch design project.

## Architecture

This project follows **Feature-based Clean Architecture** with clear separation of concerns:

```
lib/
├── core/                          # Shared infrastructure
│   ├── theme/                     # Theme system (colors, typography, theme data)
│   │   ├── app_theme.dart         # Light & Dark ThemeData definitions
│   │   ├── app_colors.dart        # All colors extracted from reference
│   │   └── app_text_styles.dart   # Typography scale using Google Fonts Inter
│   ├── routing/                   # go_router configuration
│   │   └── app_router.dart        # ShellRoute-based routing with bottom nav
│   └── constants/                 # App-wide constants
│       └── app_constants.dart     # BMI thresholds, conversion factors
│
├── features/                      # Feature modules
│   ├── calculator/                # BMI calculation feature
│   │   ├── bloc/                  # CalculatorBloc (events, state, bloc)
│   │   ├── models/                # BmiResult model
│   │   └── view/                  # CalculatorPage UI
│   ├── history/                   # Calculation history feature
│   │   ├── bloc/                  # HistoryBloc
│   │   └── view/                  # HistoryPage with charts
│   ├── resources/                 # Health resources feature
│   │   └── view/                  # ResourcesPage
│   └── settings/                  # App settings feature
│       ├── bloc/                  # ThemeCubit + SettingsBloc
│       └── view/                  # SettingsPage
│
├── shared/                        # Shared widgets
│   └── widgets/
│       └── app_shell.dart         # Shell with persistent bottom nav
│
└── main.dart                      # App entry point
```

## Theme System

### Color Extraction from Reference

All colors are **extracted from the reference Stitch design project** located in the `reference/` folder. The reference contains both light and dark mode HTML designs with Tailwind CSS configurations.

**Key color mappings:**

| Role | Light | Dark | Hex |
|------|-------|------|-----|
| Primary | Deep Blue | Bright Blue | `#2563EB` / `#3B82F6` |
| Background | Gray-100 | Slate-950 | `#F3F4F6` / `#0F172A` |
| Surface/Card | White | Slate-800 | `#FFFFFF` / `#1E293B` |
| Text Primary | Gray-800 | Slate-50 | `#1F2937` / `#F8FAFC` |
| Text Secondary | Gray-500 | Slate-400 | `#6B7280` / `#94A3B8` |
| Border | Gray-200 | Slate-700 | `#E5E7EB` / `#334155` |

BMI category colors: Underweight (`#3ABFF8`), Normal (`#10B981`), Overweight (`#F59E0B`), Obese (`#EF4444`).

### How the Theme System Works

1. `AppColors` — static color constants extracted from reference
2. `AppTextStyles` — typography scale using Google Fonts Inter
3. `AppTheme` — builds `ThemeData` for both light and dark modes

**Usage in widgets:**
```dart
// Access theme colors
final colorScheme = Theme.of(context).colorScheme;
final primaryColor = colorScheme.primary;

// Access text styles
final titleStyle = Theme.of(context).textTheme.displayMedium;

// NEVER do this:
// Color(0xFF...) or Colors.red
```

## Routing

Uses **go_router** with `ShellRoute` for persistent bottom navigation:

- `/calculator` — BMI Calculator (input form)
- `/history` — Calculation history with charts
- `/resources` — Health resources library
- `/settings` — Theme toggle and unit settings

The `ShellRoute` ensures the bottom navigation bar persists across tab switches without rebuilding the entire app.

## State Management

Uses **flutter_bloc** (BLoC pattern):

| Bloc/Cubit | Purpose |
|-----------|---------|
| `CalculatorBloc` | Manages calculator form inputs and BMI computation |
| `HistoryBloc` | Tracks BMI calculation history |
| `ThemeCubit` | Toggles between light/dark theme |
| `SettingsBloc` | Manages unit system (Standard/Metric) |

All BLoCs use **Equatable** for proper state comparison and efficient rebuilds.

## Features

### Calculator
- Gender selection (Male/Female cards)
- Age, Height, Weight inputs
- Standard (ft/in, lbs) and Metric (cm, kg) unit systems
- BMI calculation with result bottom sheet
- BMI scale visualization with category colors

### History
- Chronological list of past calculations
- **Line chart** (fl_chart) showing BMI trend over time
- **Pie chart** showing BMI category distribution
- Color-coded category indicators

### Resources
- Curated health resource cards with themed icons
- "What you can do" and "Understand your data" sections
- "Find a Doctor" CTA card

### Settings
- Dark/Light theme toggle
- Metric/Standard unit toggle
- About section with version info

## Adding a New Feature

1. Create a new directory under `lib/features/<feature_name>/`
2. Add `bloc/`, `models/`, and `view/` subdirectories
3. Create BLoC with events and state (use Equatable)
4. Create the page widget using `Theme.of(context)` for all styling
5. Register the BLoC in `main.dart`'s `MultiBlocProvider`
6. Add a route in `core/routing/app_router.dart`
7. Add a navigation item in `shared/widgets/app_shell.dart`

## Pending TODOs

- [ ] **Persistent Storage**: Implement Hive or SharedPreferences for history persistence across app restarts (see `history_bloc.dart`)
- [ ] **Doctor Locator**: Implement the "Find a Doctor" feature with location-based search (see `resources_page.dart`)
- [ ] **Resource Detail Pages**: Build individual detail pages for each health resource card
- [ ] **User Profile**: Add user profile management
- [ ] **BMI History Export**: Allow exporting history data
- [ ] **Onboarding**: First-time user onboarding flow

## Dependencies

| Package | Purpose |
|---------|---------|
| `flutter_bloc` | State management (BLoC pattern) |
| `equatable` | Value equality for events/states |
| `go_router` | Declarative routing with ShellRoute |
| `fl_chart` | Line and Pie charts for history |
| `google_fonts` | Inter font family from Google Fonts |

## Getting Started

```bash
flutter pub get
flutter run
```
