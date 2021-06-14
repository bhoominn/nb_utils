import 'dart:math';

import 'package:flutter/material.dart';

extension DoubleExtensions on double? {
  /// Validate given double is not null and returns given value if null.
  double validate({double value = 0.0}) => this ?? value;

  /// 100.0.isBetween(50.0, 150.0) // true;
  /// 100.0.isBetween(100.0, 100.0) // true;
  /// ```
  bool isBetween(num first, num second) {
    final lower = min(first, second);
    final upper = max(first, second);
    return this.validate() >= lower && this.validate() <= upper;
  }

  /// Returns Size
  Size get size => Size(this!, this!);
}
