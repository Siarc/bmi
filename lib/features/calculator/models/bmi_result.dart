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

  /// Determine BMI category based on clinical standards.
  /// Determine BMI category based on clinical standards (WHO).
  static String getCategory(double bmi) {
    if (bmi < 16.0) return 'Severe Thinness';
    if (bmi < 17.0) return 'Moderate Thinness';
    if (bmi < 18.5) return 'Mild Thinness';
    if (bmi < 25.0) return 'Normal';
    if (bmi < 30.0) return 'Overweight';
    if (bmi < 35.0) return 'Obese Class I';
    if (bmi < 40.0) return 'Obese Class II';
    return 'Obese Class III';
  }

  /// Get a health message based on BMI category.
  /// Get a health message based on BMI category.
  String get healthMessage {
    switch (category) {
      case 'Severe Thinness':
        return 'Your BMI indicates severe thinness. It is important to consult a healthcare provider for a thorough health evaluation.';
      case 'Moderate Thinness':
        return 'Your BMI indicates moderate thinness. Consider speaking with a doctor or nutritionist about achieving a healthy weight.';
      case 'Mild Thinness':
        return 'Your BMI indicates mild thinness. Focus on a balanced, nutrient-dense diet to support your health goals.';
      case 'Normal':
        return 'Great! You have a healthy weight. Keep maintaining your balanced lifestyle and stay active.';
      case 'Overweight':
        return 'You are slightly overweight. Small, sustainable changes in diet and daily activity can help you reach a healthy range.';
      case 'Obese Class I':
        return 'Your BMI indicates Class I obesity. Focus on nutrition and consistent physical activity to improve your overall health.';
      case 'Obese Class II':
        return 'Your BMI indicates Class II obesity. Consider consulting a healthcare professional for personalized health guidance.';
      case 'Obese Class III':
        return 'Your BMI indicates Class III obesity. Please seek medical advice to manage potential health risks and develop a care plan.';
      default:
        return '';
    }
  }

  @override
  List<Object?> get props => [height, weight, bmi, category, date, age];
}
