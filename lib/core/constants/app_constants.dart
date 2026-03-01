/// Application-wide constants.
class AppConstants {
  AppConstants._();

  /// App metadata
  static const String appName = 'BMI Calculator';
  static const String appVersion = '1.0.0';

  /// BMI category thresholds (WHO standards)
  static const double bmiUnderweightMax = 18.5;
  static const double bmiNormalMax = 24.9;
  static const double bmiOverweightMax = 29.9;

  /// Conversion factors
  static const double lbsToKg = 0.453592;
  static const double feetToCm = 30.48;
  static const double inchesToCm = 2.54;
  static const double kgToLbs = 2.20462;
  static const double cmToInches = 0.393701;

  /// Validation limits
  static const int minAge = 1;
  static const int maxAge = 120;
  static const double minHeightCm = 50;
  static const double maxHeightCm = 300;
  static const double minWeightKg = 10;
  static const double maxWeightKg = 500;
}
