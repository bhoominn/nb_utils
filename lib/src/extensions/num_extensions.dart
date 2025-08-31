import 'dart:math';
import 'package:nb_utils/nb_utils.dart';

// num Extensions
extension NumExt on num? {
  /// Validate given double is not null and returns given value if null.
  num validate({num value = 0}) => this ?? value;

  /// Returns price with currency
  String toCurrencyAmount() => "$defaultCurrencySymbol${validate()}";

  /// Returns true if the validated number is greater than 0.
  bool get isPositive => validate() > 0;

  /// Returns true if the validated number is less than 0.
  bool get isNegative => validate() < 0;

  /// Returns true if the validated number is equal to 0.
  bool get isZero => validate() == 0;

  /// Formats the validated number to a string with a fixed number of [fractionDigits].
  /// Returns "0.00" (or based on [fractionDigits]) if the number is null.
  String toDoubleDigits(int fractionDigits) {
    return validate().toStringAsFixed(fractionDigits);
  }

  /// Calculates what percentage the validated number is of a given [total].
  /// Returns 0.0 if [total] is 0 or null.
  double percentageOf(num total) {
    if (total == 0) return 0.0;
    return (validate() / total) * 100;
  }

  /// Checks if the validated number falls within a specified range [[min], [max]].
  /// By default, the check is inclusive. Set [inclusive] to false for an exclusive check.
  bool isBetween(num min, num max, {bool inclusive = true}) {
    final num value = validate();
    return inclusive
        ? value >= min && value <= max
        : value > min && value < max;
  }

  /// Returns the absolute value of the validated number.
  num abs() => validate().abs();

  /// Clamps the validated number to be within the range [lowerLimit, upperLimit].
  num clamp(num lowerLimit, num upperLimit) {
    return validate().clamp(lowerLimit, upperLimit);
  }

  /// Rounds the validated number to a specified number of decimal [precision].
  /// For example, (10.12345).roundToPrecision(2) will return 10.12
  double roundToPrecision(int precision) {
    final num value = validate();
    if (value is int) return value.toDouble();
    if (value is double) {
      final num mod = pow(10.0, precision);
      return ((value * mod).round().toDouble() / mod);
    }
    return value.toDouble(); // Should not happen given validate()
  }

  /// Returns true if the validated number has no fractional part.
  bool get isInteger => validate() % 1 == 0;
}
