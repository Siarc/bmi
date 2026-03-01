import 'package:equatable/equatable.dart';

/// BMI calculation result model.
/// Encapsulates all data from a single BMI calculation.
class BmiResult extends Equatable {
  final double height; // in cm
  final double weight; // in kg
  final double bmi;
  final String category;
  final DateTime date;
  final int age;

  const BmiResult({
    required this.height,
    required this.weight,
    required this.bmi,
    required this.category,
    required this.date,
    required this.age,
  });

  /// Calculate BMI from height (cm) and weight (kg).
  static double calculateBmi(double heightCm, double weightKg) {
    if (heightCm <= 0 || weightKg <= 0) return 0;
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  /// Determine BMI category based on WHO standards.
  static String getCategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25.0) return 'Normal';
    if (bmi < 30.0) return 'Overweight';
    return 'Obese';
  }

  /// Get a health message based on BMI category.
  String get healthMessage {
    switch (category) {
      case 'Underweight':
        return 'You are underweight. Consider consulting a healthcare provider about a balanced nutrition plan.';
      case 'Normal':
        return 'Great! You have a healthy weight. Keep maintaining your balanced lifestyle.';
      case 'Overweight':
        return 'You are slightly overweight. Small changes in diet and activity can help.';
      case 'Obese':
        return 'Your BMI indicates obesity. Please consult a healthcare provider for a personalized plan.';
      default:
        return '';
    }
  }

  @override
  List<Object?> get props => [height, weight, bmi, category, date, age];
}
