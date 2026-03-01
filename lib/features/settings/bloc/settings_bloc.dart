import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ──────────────────────────────────────────────
// Theme Events
// ──────────────────────────────────────────────
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

/// Toggle between light and dark theme.
class ThemeToggled extends ThemeEvent {
  const ThemeToggled();
}

/// Set theme explicitly.
class ThemeSet extends ThemeEvent {
  final ThemeMode themeMode;
  const ThemeSet(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

// ──────────────────────────────────────────────
// Theme Cubit
// ──────────────────────────────────────────────

/// Cubit for managing theme mode (light/dark).
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void toggleTheme() {
    if (state == ThemeMode.dark) {
      emit(ThemeMode.light);
    } else {
      emit(ThemeMode.dark);
    }
  }

  void setTheme(ThemeMode mode) {
    emit(mode);
  }

  bool get isDark => state == ThemeMode.dark;
}
