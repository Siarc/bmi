import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// Central theme configuration for the BMI Calculator app.
/// Provides [lightTheme] and [darkTheme] — both strictly derived
/// from the reference Stitch design project.
///
/// Border radius system (from reference):
///   - DEFAULT: 12px (0.75rem) — inputs, small cards
///   - xl: 16px (1rem) — larger cards, rounded buttons
///   - 2xl: 24px (1.5rem) — hero cards, CTA sections
///   - full: 9999px — pills, avatars
///
/// Spacing system (from reference):
///   - px: 24px (px-6) — horizontal page padding
///   - py: 16-24px — vertical section spacing
///   - gap: 12-16px — card grid gaps
///   - card padding: 16-20px — internal card padding
class AppTheme {
  AppTheme._();

  // ──────────────────────────────────────────────
  // Border Radius Constants (matches reference)
  // ──────────────────────────────────────────────
  static const double radiusSm = 8.0;    // rounded-lg
  static const double radiusMd = 12.0;   // DEFAULT (0.75rem)
  static const double radiusLg = 16.0;   // rounded-xl (1rem)
  static const double radiusXl = 24.0;   // rounded-2xl (1.5rem)

  // ──────────────────────────────────────────────
  // Spacing Constants (matches reference px/py)
  // ──────────────────────────────────────────────
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 12.0;
  static const double spacingLg = 16.0;
  static const double spacingXl = 20.0;
  static const double spacingXxl = 24.0;
  static const double spacingXxxl = 32.0;

  // ──────────────────────────────────────────────
  // LIGHT THEME
  // ──────────────────────────────────────────────
  static ThemeData get lightTheme {
    final textTheme = AppTextStyles.textTheme(AppColors.lightTextPrimary);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppTextStyles.fontFamily,
      textTheme: textTheme,

      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        primaryContainer: AppColors.lightInfoBackground,
        onPrimaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFFE0F2FE),
        onSecondaryContainer: AppColors.secondary,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightTextPrimary,
        surfaceContainerHighest: AppColors.lightBackground,
        onSurfaceVariant: AppColors.lightTextSecondary,
        outline: AppColors.lightBorder,
        outlineVariant: AppColors.lightBorderSubtle,
        error: AppColors.bmiObese,
        onError: Colors.white,
        tertiary: AppColors.accentEmerald,
        onTertiary: Colors.white,
      ),

      scaffoldBackgroundColor: AppColors.lightBackground,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: true,
        titleTextStyle: textTheme.headlineMedium?.copyWith(
          color: AppColors.primaryDark,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: const IconThemeData(color: AppColors.lightTextSecondary),
      ),

      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightInputBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacingLg,
          vertical: spacingLg,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2.0,
          ),
        ),
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: AppColors.lightTextTertiary,
        ),
        labelStyle: textTheme.titleSmall?.copyWith(
          color: AppColors.lightTextSecondary,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: AppColors.primary.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(
            horizontal: spacingXxl,
            vertical: spacingLg + 4,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(
            horizontal: spacingXxl,
            vertical: spacingLg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.lightNavBackground,
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStatePropertyAll(
          textTheme.labelSmall?.copyWith(
            color: AppColors.lightTextTertiary,
          ),
        ),
        iconTheme: const WidgetStatePropertyAll(
          IconThemeData(
            color: AppColors.lightTextTertiary,
            size: 26,
          ),
        ),
        height: 64,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.lightBorder,
        thickness: 1,
        space: 0,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return AppColors.lightTextTertiary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.lightBorder;
        }),
      ),

      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.lightBorder,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withValues(alpha: 0.12),
        trackHeight: 4,
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.lightSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusLg),
          ),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightInfoBackground,
        labelStyle: textTheme.bodySmall?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(
          horizontal: spacingSm,
          vertical: spacingXs,
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────
  // DARK THEME
  // ──────────────────────────────────────────────
  static ThemeData get darkTheme {
    final textTheme = AppTextStyles.textTheme(AppColors.darkTextPrimary);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppTextStyles.fontFamily,
      textTheme: textTheme,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        onPrimary: Colors.white,
        primaryContainer: AppColors.darkInfoBackground,
        onPrimaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFF1E3A5F),
        onSecondaryContainer: AppColors.accentCyan,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkTextPrimary,
        surfaceContainerHighest: AppColors.darkBackground,
        onSurfaceVariant: AppColors.darkTextSecondary,
        outline: AppColors.darkBorder,
        outlineVariant: AppColors.darkBorderSubtle,
        error: AppColors.bmiObese,
        onError: Colors.white,
        tertiary: AppColors.accentEmerald,
        onTertiary: Colors.white,
      ),

      scaffoldBackgroundColor: AppColors.darkBackground,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.headlineMedium?.copyWith(
          color: Colors.white,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: AppColors.darkTextSecondary),
      ),

      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          side: BorderSide(
            color: AppColors.darkBorder.withValues(alpha: 0.5),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacingLg,
          vertical: spacingLg,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(
            color: AppColors.darkBorder.withValues(alpha: 0.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(
            color: AppColors.darkBorder.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(
            color: AppColors.primaryLight,
            width: 2.0,
          ),
        ),
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: AppColors.darkTextTertiary,
        ),
        labelStyle: textTheme.titleSmall?.copyWith(
          color: AppColors.darkTextSecondary,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: Colors.white,
          elevation: 6,
          shadowColor: AppColors.primaryLight.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(
            horizontal: spacingXxl,
            vertical: spacingLg + 4,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          side: BorderSide(
            color: AppColors.primaryLight.withValues(alpha: 0.5),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: spacingXxl,
            vertical: spacingLg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.darkNavBackground,
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStatePropertyAll(
          textTheme.labelSmall?.copyWith(
            color: AppColors.darkTextTertiary,
          ),
        ),
        iconTheme: const WidgetStatePropertyAll(
          IconThemeData(
            color: AppColors.darkTextTertiary,
            size: 26,
          ),
        ),
        height: 64,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.darkBorderSubtle,
        thickness: 1,
        space: 0,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return AppColors.darkTextTertiary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return AppColors.darkBorder;
        }),
      ),

      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primaryLight,
        inactiveTrackColor: AppColors.darkBorder,
        thumbColor: AppColors.primaryLight,
        overlayColor: AppColors.primaryLight.withValues(alpha: 0.12),
        trackHeight: 4,
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.darkSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusLg),
          ),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkInfoBackground,
        labelStyle: textTheme.bodySmall?.copyWith(
          color: AppColors.primaryLight,
          fontWeight: FontWeight.w700,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(
          horizontal: spacingSm,
          vertical: spacingXs,
        ),
      ),
    );
  }
}
