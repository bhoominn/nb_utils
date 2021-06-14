import 'package:flutter/material.dart';

extension Hex on Color {
  /// return hex String
  String toHex({bool leadingHashSign = true, bool includeAlpha = false}) =>
      '${leadingHashSign ? '#' : ''}'
      '${includeAlpha ? alpha.toRadixString(16).padLeft(2, '0') : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  /// Return true if given Color is dark
  bool isDark() => this.getBrightness() < 128.0;

  /// Return true if given Color is light
  bool isLight() => !this.isDark();

  /// Returns Brightness of give Color
  double getBrightness() =>
      (this.red * 299 + this.green * 587 + this.blue * 114) / 1000;

  /// Returns Luminance of give Color
  double getLuminance() => this.computeLuminance();
}
