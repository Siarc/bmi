import 'package:equatable/equatable.dart';

/// Events for the BMI Calculator BLoC.
abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object?> get props => [];
}



/// User updated age.
class AgeChanged extends CalculatorEvent {
  final int age;
  const AgeChanged(this.age);

  @override
  List<Object?> get props => [age];
}

/// User updated height (feet).
class HeightFeetChanged extends CalculatorEvent {
  final int feet;
  const HeightFeetChanged(this.feet);

  @override
  List<Object?> get props => [feet];
}

/// User updated height (inches).
class HeightInchesChanged extends CalculatorEvent {
  final int inches;
  const HeightInchesChanged(this.inches);

  @override
  List<Object?> get props => [inches];
}

/// User updated height (cm) — for metric mode.
class HeightCmChanged extends CalculatorEvent {
  final double heightCm;
  const HeightCmChanged(this.heightCm);

  @override
  List<Object?> get props => [heightCm];
}

/// User updated weight (lbs).
class WeightLbsChanged extends CalculatorEvent {
  final double weightLbs;
  const WeightLbsChanged(this.weightLbs);

  @override
  List<Object?> get props => [weightLbs];
}

/// User updated weight (kg) — for metric mode.
class WeightKgChanged extends CalculatorEvent {
  final double weightKg;
  const WeightKgChanged(this.weightKg);

  @override
  List<Object?> get props => [weightKg];
}

/// User toggled between Standard (ft/lbs) and Metric (cm/kg).
class UnitSystemChanged extends CalculatorEvent {
  final bool isMetric;
  const UnitSystemChanged(this.isMetric);

  @override
  List<Object?> get props => [isMetric];
}

/// User pressed Calculate button.
class CalculateBmiRequested extends CalculatorEvent {
  const CalculateBmiRequested();
}

/// Reset calculator to initial state (wipes all inputs).
class CalculatorReset extends CalculatorEvent {
  const CalculatorReset();
}

/// Clears the BMI result object but preserves user inputs.
/// Used when navigating back from result to calculator page.
class ClearBmiResult extends CalculatorEvent {
  const ClearBmiResult();
}
