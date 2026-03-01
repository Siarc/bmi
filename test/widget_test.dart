import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/features/calculator/models/bmi_result.dart';

void main() {
  group('BmiResult', () {
    test('calculateBmi returns correct value', () {
      // 170cm, 70kg -> BMI ~= 24.22
      final bmi = BmiResult.calculateBmi(170, 70);
      expect(bmi, closeTo(24.22, 0.1));
    });

    test('getCategory returns correct category', () {
      expect(BmiResult.getCategory(17.0), 'Underweight');
      expect(BmiResult.getCategory(22.0), 'Normal');
      expect(BmiResult.getCategory(27.0), 'Overweight');
      expect(BmiResult.getCategory(35.0), 'Obese');
    });

    test('calculateBmi returns 0 for invalid input', () {
      expect(BmiResult.calculateBmi(0, 70), 0);
      expect(BmiResult.calculateBmi(170, 0), 0);
    });
  });
}
