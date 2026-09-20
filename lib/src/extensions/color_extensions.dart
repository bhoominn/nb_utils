import 'package:flutter/material.dart';

int _channel(double value) => (value * 255.0).round().clamp(0, 255);

// Color Extensions
extension Hex on Color {
  /// return hex String
  String toHex({bool leadingHashSign = true, bool includeAlpha = false}) =>
      '${leadingHashSign ? '#' : ''}'
      '${includeAlpha ? _channel(a).toRadixString(16).padLeft(2, '0') : ''}'
      '${_channel(r).toRadixString(16).padLeft(2, '0')}'
      '${_channel(g).toRadixString(16).padLeft(2, '0')}'
      '${_channel(b).toRadixString(16).padLeft(2, '0')}';

  /// Return true if given Color is dark
  bool isDark() => getBrightness() < 128.0;

  /// Return true if given Color is light
  bool isLight() => !isDark();

  /// Returns Brightness of give Color
  double getBrightness() =>
      (_channel(r) * 299 + _channel(g) * 587 + _channel(b) * 114) / 1000;

  /// Returns Luminance of give Color
  double getLuminance() => computeLuminance();
}
