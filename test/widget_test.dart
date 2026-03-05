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
      expect(BmiResult.getCategory(15.0), 'Severe Thinness');
      expect(BmiResult.getCategory(16.5), 'Moderate Thinness');
      expect(BmiResult.getCategory(18.0), 'Mild Thinness');
      expect(BmiResult.getCategory(22.0), 'Normal');
      expect(BmiResult.getCategory(27.0), 'Overweight');
      expect(BmiResult.getCategory(32.0), 'Obese Class I');
      expect(BmiResult.getCategory(37.0), 'Obese Class II');
      expect(BmiResult.getCategory(45.0), 'Obese Class III');
    });

    test('calculateBmi returns 0 for invalid input', () {
      expect(BmiResult.calculateBmi(0, 70), 0);
      expect(BmiResult.calculateBmi(170, 0), 0);
    });
  });
}
