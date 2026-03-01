import 'package:equatable/equatable.dart';
import '../models/bmi_result.dart';

/// State for the BMI Calculator BLoC.
class CalculatorState extends Equatable {
  final String gender;
  final int age;
  final int heightFeet;
  final int heightInches;
  final double heightCm;
  final double weightLbs;
  final double weightKg;
  final bool isMetric;
  final BmiResult? result;
  final bool isCalculating;

  const CalculatorState({
    this.gender = 'male',
    this.age = 0,
    this.heightFeet = 0,
    this.heightInches = 0,
    this.heightCm = 0,
    this.weightLbs = 0,
    this.weightKg = 0,
    this.isMetric = false,
    this.result,
    this.isCalculating = false,
  });

  /// Whether the form has valid data within standard ranges to calculate.
  bool get canCalculate {
    // Basic age validation (1-120)
    if (age < 1 || age > 120) return false;

    if (isMetric) {
      // Metric height (50-300cm) and weight (2-500kg)
      return heightCm >= 50 && heightCm <= 300 && 
             weightKg >= 2 && weightKg <= 500;
    } else {
      // Standard height (Feet: 1-9, Inches: 0-11) and weight (4-1000lbs)
      return (heightFeet >= 1 && heightFeet <= 9) && 
             (heightInches >= 0 && heightInches <= 11) && 
             (weightLbs >= 4 && weightLbs <= 1000);
    }
  }

  /// Get height in cm regardless of unit system.
  double get heightInCm {
    if (isMetric) return heightCm;
    return (heightFeet * 30.48) + (heightInches * 2.54);
  }

  /// Get weight in kg regardless of unit system.
  double get weightInKg {
    if (isMetric) return weightKg;
    return weightLbs * 0.453592;
  }

  CalculatorState copyWith({
    String? gender,
    int? age,
    int? heightFeet,
    int? heightInches,
    double? heightCm,
    double? weightLbs,
    double? weightKg,
    bool? isMetric,
    BmiResult? result,
    bool? isCalculating,
    bool clearResult = false,
  }) {
    return CalculatorState(
      gender: gender ?? this.gender,
      age: age ?? this.age,
      heightFeet: heightFeet ?? this.heightFeet,
      heightInches: heightInches ?? this.heightInches,
      heightCm: heightCm ?? this.heightCm,
      weightLbs: weightLbs ?? this.weightLbs,
      weightKg: weightKg ?? this.weightKg,
      isMetric: isMetric ?? this.isMetric,
      result: clearResult ? null : (result ?? this.result),
      isCalculating: isCalculating ?? this.isCalculating,
    );
  }

  @override
  List<Object?> get props => [
        gender,
        age,
        heightFeet,
        heightInches,
        heightCm,
        weightLbs,
        weightKg,
        isMetric,
        result,
        isCalculating,
      ];
}
