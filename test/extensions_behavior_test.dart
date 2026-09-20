import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' hide isMacOS;
import 'package:nb_utils/nb_utils.dart';

void main() {
  test('Color.toHex matches expected values', () {
    expect(const Color(0xFF112233).toHex(), '#112233');
    expect(const Color(0x80112233).toHex(includeAlpha: true), '#80112233');
    expect(const Color(0xFFFFFFFF).toHex(leadingHashSign: false), 'ffffff');
    expect(const Color(0xFF000000).isDark(), isTrue);
    expect(const Color(0xFFFFFFFF).isLight(), isTrue);
    expect(const Color(0xFF808080).getBrightness(), closeTo(128, 0.001));
  });

  test('createMaterialColor keeps the primary value', () {
    expect(createMaterialColor(const Color(0xFF336699)).toARGB32(), 0xFF336699);
  });

  test('platform getters follow defaultTargetPlatform', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    expect(isAndroid, isTrue);
    expect(isMobile, isTrue);
    expect(isIOS, isFalse);
    expect(isDesktop, isFalse);
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    expect(isMacOS, isTrue);
    expect(isApple, isTrue);
    expect(isDesktop, isTrue);
    expect(isMobile, isFalse);
    debugDefaultTargetPlatformOverride = null;
  });
}
