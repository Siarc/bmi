import 'package:flutter/material.dart';

/// All colors extracted from the reference Stitch design project.
/// These are the ONLY colors to be used across the entire app.
/// Usage: Access via `Theme.of(context).colorScheme` or `Theme.of(context).extension<AppColors>()`.
class AppColors {
  AppColors._();

  // ──────────────────────────────────────────────
  // Primary Brand Colors (from reference)
  // ──────────────────────────────────────────────
  static const Color primary = Color(0xFF2563EB);         // Vibrant professional blue
  static const Color primaryLight = Color(0xFF3B82F6);    // Brighter blue used in dark mode accents
  static const Color primaryDark = Color(0xFF1E3A8A);     // Deep blue (NIH-inspired)
  static const Color secondary = Color(0xFF0F766E);       // Teal accent for health
  static const Color dashBlue = Color(0xFF1E3A8A);        // DASH eating plan / CTA card

  // ──────────────────────────────────────────────
  // Light Theme Colors
  // ──────────────────────────────────────────────
  static const Color lightBackground = Color(0xFFF3F4F6);       // background-light
  static const Color lightSurface = Color(0xFFFFFFFF);           // surface-light / cards
  static const Color lightTextPrimary = Color(0xFF1F2937);       // text-light
  static const Color lightTextSecondary = Color(0xFF6B7280);     // gray-500
  static const Color lightTextTertiary = Color(0xFF9CA3AF);      // gray-400
  static const Color lightBorder = Color(0xFFE5E7EB);           // gray-200
  static const Color lightBorderSubtle = Color(0xFFF3F4F6);     // gray-100 borders
  static const Color lightInputBackground = Color(0xFFFFFFFF);  // white inputs
  static const Color lightNavBackground = Color(0xFFFFFFFF);    // white nav bar
  static const Color lightInfoBackground = Color(0xFFEFF6FF);   // blue-50 info card
  static const Color lightInfoBorder = Color(0xFFDBEAFE);       // blue-100
  static const Color lightInfoText = Color(0xFF1E40AF);         // blue-800

  // ──────────────────────────────────────────────
  // Dark Theme Colors
  // ──────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF0F172A);         // slate-950 / background-dark
  static const Color darkBackgroundAlt = Color(0xFF121212);      // deep charcoal variant
  static const Color darkSurface = Color(0xFF1E293B);            // slate-800 / surface-dark / card-dark
  static const Color darkSurfaceElevated = Color(0xFF334155);    // slate-700 / inner-card-dark
  static const Color darkTextPrimary = Color(0xFFF8FAFC);        // slate-50 / text-primary-dark
  static const Color darkTextSecondary = Color(0xFF94A3B8);      // slate-400 / text-secondary-dark
  static const Color darkTextTertiary = Color(0xFF64748B);       // slate-500
  static const Color darkBorder = Color(0xFF334155);             // slate-700
  static const Color darkBorderSubtle = Color(0xFF1E293B);       // slate-800
  static const Color darkInputBackground = Color(0xFF1E1E1E);   // surface-card dark
  static const Color darkNavBackground = Color(0xFF0F172A);      // slate-900 nav bg
  static const Color darkInfoBackground = Color(0x331E3A8A);    // blue-900/20
  static const Color darkInfoBorder = Color(0xFF1E3A8A);        // blue-800
  static const Color darkInfoText = Color(0xFFBFDBFE);          // blue-200

  // ──────────────────────────────────────────────
  // BMI Category Colors
  // ──────────────────────────────────────────────
  static const Color bmiUnderweight = Color(0xFF3ABFF8);   // sky blue
  static const Color bmiNormal = Color(0xFF10B981);        // emerald-500
  static const Color bmiOverweight = Color(0xFFF59E0B);    // amber-500
  static const Color bmiObese = Color(0xFFEF4444);         // red-500

  // ──────────────────────────────────────────────
  // Accent / Semantic Colors (from resource cards)
  // ──────────────────────────────────────────────
  static const Color accentBlue = Color(0xFF3B82F6);       // blue-500
  static const Color accentRose = Color(0xFFF43F5E);       // rose-500
  static const Color accentEmerald = Color(0xFF10B981);    // emerald-500
  static const Color accentAmber = Color(0xFFF59E0B);      // amber-500
  static const Color accentIndigo = Color(0xFF6366F1);     // indigo-500
  static const Color accentCyan = Color(0xFF06B6D4);       // cyan-500
  static const Color accentPink = Color(0xFFEC4899);       // pink-500

  // Tinted backgrounds for resource cards (dark mode)
  static const Color blueCardBg = Color(0x333B82F6);       // blue-500/20
  static const Color roseCardBg = Color(0x33F43F5E);       // rose-500/20
  static const Color emeraldCardBg = Color(0x3310B981);    // emerald-500/20
  static const Color amberCardBg = Color(0x33F59E0B);      // amber-500/20
  static const Color indigoCardBg = Color(0x336366F1);     // indigo-500/20
  static const Color cyanCardBg = Color(0x3306B6D4);       // cyan-500/20

  // CTA / Button colors
  static const Color ctaBackground = Color(0xFF1D4ED8);     // blue-700 (Find a Doctor card bg)
  static const Color ctaForeground = Color(0xFFFFFFFF);     // white
}
