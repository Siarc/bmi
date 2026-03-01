import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography scale extracted from the reference Stitch design.
/// Font Family: Inter (primary), Manrope (used in resource/guide pages).
/// All text styles align with the reference: extrabold headings, semibold labels,
/// and clean body text with proper tracking.
class AppTextStyles {
  AppTextStyles._();

  /// Base font family — Inter (used across calculator, settings, resources)
  static String get fontFamily => 'Inter';

  /// Build the full TextTheme using Google Fonts Inter.
  /// The scale matches the reference: 3xl=30, 2xl=24, xl=20, lg=18, base=16,
  /// sm=14, xs=12, [10px]=10.
  static TextTheme textTheme(Color textColor) {
    return GoogleFonts.interTextTheme(
      TextTheme(
        // displayLarge — 30px extrabold (Activity Guidelines hero title)
        displayLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
          height: 1.2,
          color: textColor,
        ),
        // displayMedium — 24px bold (section titles like "Calculate Your BMI")
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
          height: 1.3,
          color: textColor,
        ),
        // displaySmall — 20px bold (card titles)
        displaySmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 1.3,
          color: textColor,
        ),
        // headlineMedium — 18px bold (app bar titles)
        headlineMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
          height: 1.4,
          color: textColor,
        ),
        // headlineSmall — 16px semibold (sub headings)
        headlineSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.4,
          color: textColor,
        ),
        // titleLarge — 18px bold (lg titles)
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
          height: 1.4,
          color: textColor,
        ),
        // titleMedium — 16px medium (standard titles)
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.5,
          color: textColor,
        ),
        // titleSmall — 14px semibold (labels, field titles)
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: textColor,
        ),
        // bodyLarge — 16px regular (primary body)
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.6,
          color: textColor,
        ),
        // bodyMedium — 14px regular (secondary body / descriptions)
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: textColor,
        ),
        // bodySmall — 12px regular (small text / info)
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: textColor,
        ),
        // labelLarge — 14px bold (buttons)
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
          height: 1.5,
          color: textColor,
        ),
        // labelMedium — 12px semibold (uppercase labels, tracker labels)
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
          height: 1.5,
          color: textColor,
        ),
        // labelSmall — 10px bold (bottom nav labels, tags)
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          height: 1.4,
          color: textColor,
        ),
      ),
    );
  }
}
