import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/calculator_bloc.dart';
import '../bloc/calculator_event.dart';
import '../bloc/calculator_state.dart';

/// Calculator Page — main BMI input screen.
/// Matches the reference Stitch design for both light and dark themes.
class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CalculatorView();
  }
}

class _CalculatorView extends StatefulWidget {
  const _CalculatorView();

  @override
  State<_CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<_CalculatorView> {
  final _ageController = TextEditingController();
  final _heightFeetController = TextEditingController();
  final _heightInchesController = TextEditingController();
  final _heightCmController = TextEditingController();
  final _weightController = TextEditingController();
  late bool _lastIsMetric;

  @override
  void initState() {
    super.initState();
    final state = context.read<CalculatorBloc>().state;
    _lastIsMetric = state.isMetric;
    
    // Initialize controllers with current state values
    _ageController.text = state.age > 0 ? state.age.toString() : '';
    _heightCmController.text = state.heightCm > 0 ? state.heightCm.toString() : '';
    _heightFeetController.text = state.heightFeet > 0 ? state.heightFeet.toString() : '';
    _heightInchesController.text = state.heightInches > 0 ? state.heightInches.toString() : '';
    _weightController.text = state.isMetric 
        ? (state.weightKg > 0 ? state.weightKg.toString() : '')
        : (state.weightLbs > 0 ? state.weightLbs.toString() : '');
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heightFeetController.dispose();
    _heightInchesController.dispose();
    _heightCmController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: colorScheme.primary,
          ),
        ),
        centerTitle: true,
        actions: const [],
      ),
      body: BlocConsumer<CalculatorBloc, CalculatorState>(
        listener: (context, state) {
          if (state.result != null && state.isCalculating == false) {
             context.push(AppRouter.resultPath);
          }
          
          // Sync controllers on unit toggle
          if (state.isMetric != _lastIsMetric) {
            _lastIsMetric = state.isMetric;
            if (state.isMetric) {
              _heightCmController.text = state.heightCm > 0 ? state.heightCm.toString() : '';
              _weightController.text = state.weightKg > 0 ? state.weightKg.toString() : '';
            } else {
              _heightFeetController.text = state.heightFeet > 0 ? state.heightFeet.toString() : '';
              _heightInchesController.text = state.heightInches > 0 ? state.heightInches.toString() : '';
              _weightController.text = state.weightLbs > 0 ? state.weightLbs.toString() : '';
            }
          }

          // Handle full reset (triggered from New Calculation button)
          if (state.age == 0 && state.heightCm == 0 && state.weightKg == 0) {
            _ageController.clear();
            _heightCmController.clear();
            _heightFeetController.clear();
            _heightInchesController.clear();
            _weightController.clear();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingXxl,
              vertical: AppTheme.spacingLg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title section
                Text(
                  'Calculate Your BMI',
                  style: theme.textTheme.displayMedium,
                ),
                const SizedBox(height: AppTheme.spacingSm),
                Text(
                  'Enter your details below to find out your Body Mass Index and health status.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXxl),

                // Unit toggle (Standard / Metric)
                _UnitToggle(
                  isMetric: state.isMetric,
                  onChanged: (isMetric) {
                    context.read<CalculatorBloc>().add(
                          UnitSystemChanged(isMetric),
                        );
                  },
                ),
                const SizedBox(height: AppTheme.spacingXxl),



                // Age input
                _SectionLabel(label: 'Age'),
                const SizedBox(height: AppTheme.spacingSm),
                _InputField(
                  controller: _ageController,
                  placeholder: '25',
                  suffix: 'years',
                  validator: (v) {
                    if (v == null || v.isEmpty) return null;
                    final val = int.tryParse(v);
                    if (val == null || val < 1 || val > 120) return 'Invalid age';
                    return null;
                  },
                  onChanged: (value) {
                    final age = int.tryParse(value) ?? 0;
                    context.read<CalculatorBloc>().add(AgeChanged(age));
                  },
                ),
                const SizedBox(height: AppTheme.spacingXxl),

                // Height input
                _SectionLabel(label: 'Height'),
                const SizedBox(height: AppTheme.spacingSm),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.05, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: state.isMetric
                      ? _InputField(
                          key: const ValueKey('height_cm'),
                          controller: _heightCmController,
                          placeholder: '170',
                          suffix: 'cm',
                          validator: (v) {
                            if (v == null || v.isEmpty) return null;
                            final val = double.tryParse(v);
                            if (val == null || val < 50 || val > 300) return '50-300 cm';
                            return null;
                          },
                          onChanged: (value) {
                            final cm = double.tryParse(value) ?? 0;
                            context.read<CalculatorBloc>().add(HeightCmChanged(cm));
                          },
                        )
                      : Row(
                          key: const ValueKey('height_ft_in'),
                          children: [
                            Expanded(
                              child: _InputField(
                                controller: _heightFeetController,
                                placeholder: '5',
                                suffix: 'ft',
                                validator: (v) {
                                  if (v == null || v.isEmpty) return null;
                                  final val = int.tryParse(v);
                                  if (val == null || val < 1 || val > 9) return '1-9 ft';
                                  return null;
                                },
                                onChanged: (value) {
                                  final ft = int.tryParse(value) ?? 0;
                                  context
                                      .read<CalculatorBloc>()
                                      .add(HeightFeetChanged(ft));
                                },
                              ),
                            ),
                            const SizedBox(width: AppTheme.spacingLg),
                            Expanded(
                              child: _InputField(
                                controller: _heightInchesController,
                                placeholder: '10',
                                suffix: 'in',
                                validator: (v) {
                                  if (v == null || v.isEmpty) return null;
                                  final val = int.tryParse(v);
                                  if (val == null || val < 0 || val > 11) return '0-11 in';
                                  return null;
                                },
                                onChanged: (value) {
                                  final inches = int.tryParse(value) ?? 0;
                                  context
                                      .read<CalculatorBloc>()
                                      .add(HeightInchesChanged(inches));
                                },
                              ),
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: AppTheme.spacingXxl),

                // Weight input
                _SectionLabel(label: 'Weight'),
                const SizedBox(height: AppTheme.spacingSm),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.05, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: _InputField(
                    key: ValueKey('weight_${state.isMetric ? 'kg' : 'lbs'}'),
                    controller: _weightController,
                    placeholder: state.isMetric ? '70' : '160',
                    suffix: state.isMetric ? 'kg' : 'lbs',
                    validator: (v) {
                      if (v == null || v.isEmpty) return null;
                      final val = double.tryParse(v);
                      if (val == null) return 'Invalid';
                      if (state.isMetric) {
                        if (val < 2 || val > 500) return '2-500 kg';
                      } else {
                        if (val < 4 || val > 1000) return '4-1000 lbs';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      final w = double.tryParse(value) ?? 0;
                      if (state.isMetric) {
                        context.read<CalculatorBloc>().add(WeightKgChanged(w));
                      } else {
                        context.read<CalculatorBloc>().add(WeightLbsChanged(w));
                      }
                    },
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXxl),

                // Calculate button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: state.canCalculate
                        ? () {
                            context
                                .read<CalculatorBloc>()
                                .add(const CalculateBmiRequested());
                          }
                        : null,
                    icon: const Icon(Icons.calculate),
                    label: const Text('Calculate BMI'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusLg),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXxxl),

                // Info card
                _InfoCard(),
                const SizedBox(height: AppTheme.spacingXxl),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ──────────────────────────────────────────────
// Sub-widgets
// ──────────────────────────────────────────────

/// Section label matching reference: uppercase, semibold, secondary color.
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      label,
      style: theme.textTheme.titleSmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

/// Unit toggle matching reference: pill-shaped segment control, animated smoothly.
class _UnitToggle extends StatelessWidget {
  final bool isMetric;
  final ValueChanged<bool> onChanged;

  const _UnitToggle({required this.isMetric, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark
            ? colorScheme.surface
            : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: isDark
            ? Border.all(color: colorScheme.outline.withValues(alpha: 0.3))
            : null,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final buttonWidth = constraints.maxWidth / 2;
          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                left: isMetric ? buttonWidth : 0,
                width: buttonWidth,
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? colorScheme.primary : colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                    boxShadow: [
                      BoxShadow(
                        color: (isDark ? colorScheme.primary : Colors.black)
                            .withValues(alpha: 0.15),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onChanged(false),
                      behavior: HitTestBehavior.opaque,
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: !isMetric
                                ? (isDark ? Colors.white : colorScheme.primary)
                                : colorScheme.onSurfaceVariant,
                            fontWeight: !isMetric ? FontWeight.w600 : FontWeight.w500,
                          ),
                          child: const Text('Standard'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onChanged(true),
                      behavior: HitTestBehavior.opaque,
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: isMetric
                                ? (isDark ? Colors.white : colorScheme.primary)
                                : colorScheme.onSurfaceVariant,
                            fontWeight: isMetric ? FontWeight.w600 : FontWeight.w500,
                          ),
                          child: const Text('Metric'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}



/// Styled input field matching reference: rounded, shadow, suffix unit label.
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final String suffix;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;

  const _InputField({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.suffix,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      style: theme.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        hintText: placeholder,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingLg,
          vertical: 18,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: AppTheme.spacingLg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                suffix,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      ),
      onChanged: onChanged,
    );
  }
}

/// Info card at the bottom matching the reference blue info box.
class _InfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkInfoBackground
            : AppColors.lightInfoBackground,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(
          color: isDark
              ? AppColors.darkInfoBorder
              : AppColors.lightInfoBorder,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: AppTheme.spacingMd),
          Expanded(
            child: Text(
              'BMI is a general screening tool, not a perfect measure. Both men and women use the same BMI formula and categories. However, it does not consider muscle mass, fat distribution, or bone density. Please consult a healthcare provider for a localized assessment.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark
                    ? AppColors.darkInfoText
                    : AppColors.lightInfoText,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
