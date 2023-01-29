import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'color_extractor.dart';

const scaffoldLightColor = Color(0xFFEBF2F7);
const scaffoldDarkColor = Color(0xFF0E1116);
const cardDarkColor = Color(0xFF1C1F26);
const dividerDarkColor = Color(0xFF393D45);
const cardLightColor = Color(0xFFF6F7F9);

const textPrimaryColor = Color(0xFF2E3033);
const textSecondaryColor = Color(0xFF757575);
const viewLineColor = Color(0xFFEAEAEA);
const errorColor = Color(0xFFFF6347);
const transparentColor = Color(0x00000000);

const whiteColor = Colors.white;
const blackColor = Colors.black;

//

const Color aliceBlue = const Color(0xFFF0F8FF);
const Color antiqueWhite = const Color(0xFFFAEBD7);
const Color aqua = const Color(0xFF00FFFF);
const Color aquamarine = const Color(0xFF7FFFD4);
const Color azure = const Color(0xFFF0FFFF);
const Color beige = const Color(0xFFF5F5DC);
const Color bisque = const Color(0xFFFFE4C4);
const Color black = const Color(0xFF000000);
const Color blanchedAlmond = const Color(0xFFFFEBCD);
const Color blueColor = const Color(0xFF0000FF);
const Color blueViolet = const Color(0xFF8A2BE2);
const Color brown = const Color(0xFFA52A2A);
const Color burlyWood = const Color(0xFFDEB887);
const Color cadetBlue = const Color(0xFF5F9EA0);
const Color chartreuse = const Color(0xFF7FFF00);
const Color chocolate = const Color(0xFFD2691E);
const Color coral = const Color(0xFFFF7F50);
const Color cornflowerBlue = const Color(0xFF6495ED);
const Color cornSilk = const Color(0xFFFFF8DC);
const Color crimson = const Color(0xFFDC143C);
const Color cyan = const Color(0xFF00FFFF);
const Color darkBlue = const Color(0xFF00008B);
const Color darkCyan = const Color(0xFF008B8B);
const Color darkGoldenRod = const Color(0xFFB8860B);
const Color darkGray = const Color(0xFFA9A9A9);
const Color darkGreen = const Color(0xFF006400);
const Color darkGrey = const Color(0xFFA9A9A9);
const Color darkKhaki = const Color(0xFFBDB76B);
const Color darkMagenta = const Color(0xFF8B008B);
const Color darkOliveGreen = const Color(0xFF556B2F);
const Color darkOrange = const Color(0xFFFF8C00);
const Color darkOrchid = const Color(0xFF9932CC);
const Color darkRed = const Color(0xFF8B0000);
const Color darkSalmon = const Color(0xFFE9967A);
const Color darkSeaGreen = const Color(0xFF8FBC8F);
const Color darkSlateBlue = const Color(0xFF483D8B);
const Color darkSlateGray = const Color(0xFF2F4F4F);
const Color darkSlateGrey = const Color(0xFF2F4F4F);
const Color darkTurquoise = const Color(0xFF00CED1);
const Color darkViolet = const Color(0xFF9400D3);
const Color deepPink = const Color(0xFFFF1493);
const Color deepSkyBlue = const Color(0xFF00BFFF);
const Color dimGray = const Color(0xFF696969);
const Color dimGrey = const Color(0xFF696969);
const Color dodgerBlue = const Color(0xFF1E90FF);
const Color fireBrick = const Color(0xFFB22222);
const Color floralWhite = const Color(0xFFFFFAF0);
const Color forestGreen = const Color(0xFF228B22);
const Color fuchsia = const Color(0xFFFF00FF);
const Color gainsBoro = const Color(0xFFDCDCDC);
const Color ghostWhite = const Color(0xFFF8F8FF);
const Color gold = const Color(0xFFFFD700);
const Color goldenRod = const Color(0xFFDAA520);
const Color gray = const Color(0xFF808080);
const Color greenColor = const Color(0xFF008000);
const Color greenYellow = const Color(0xFFADFF2F);
const Color grey = const Color(0xFF808080);
const Color honeyDew = const Color(0xFFF0FFF0);
const Color hotPink = const Color(0xFFFF69B4);
const Color indianRed = const Color(0xFFCD5C5C);
const Color indigo = const Color(0xFF4B0082);
const Color ivory = const Color(0xFFFFFFF0);
const Color khaki = const Color(0xFFF0E68C);
const Color lavender = const Color(0xFFE6E6FA);
const Color lavenderBlush = const Color(0xFFFFF0F5);
const Color lawnGreen = const Color(0xFF7CFC00);
const Color lemonChiffon = const Color(0xFFFFFACD);
const Color lightBlue = const Color(0xFFADD8E6);
const Color lightCoral = const Color(0xFFF08080);
const Color lightCyan = const Color(0xFFE0FFFF);
const Color lightGoldenRodYellow = const Color(0xFFFAFAD2);
const Color lightGray = const Color(0xFFD3D3D3);
const Color lightGreen = const Color(0xFF90EE90);
const Color lightGrey = const Color(0xFFD3D3D3);
const Color lightPink = const Color(0xFFFFB6C1);
const Color lightSalmon = const Color(0xFFFFA07A);
const Color lightSeaGreen = const Color(0xFF20B2AA);
const Color lightSkyBlue = const Color(0xFF87CEFA);
const Color lightSlateGray = const Color(0xFF778899);
const Color lightSlateGrey = const Color(0xFF778899);
const Color lightSteelBlue = const Color(0xFFB0C4DE);
const Color lightYellow = const Color(0xFFFFFFE0);
const Color lime = const Color(0xFF00FF00);
const Color limeGreen = const Color(0xFF32CD32);
const Color linen = const Color(0xFFFAF0E6);
const Color magenta = const Color(0xFFFF00FF);
const Color maroon = const Color(0xFF800000);
const Color mediumAquaMarine = const Color(0xFF66CDAA);
const Color mediumBlue = const Color(0xFF0000CD);
const Color mediumOrchid = const Color(0xFFBA55D3);
const Color mediumPurple = const Color(0xFF9370DB);
const Color mediumSeaGreen = const Color(0xFF3CB371);
const Color mediumSlateBlue = const Color(0xFF7B68EE);
const Color mediumSpringGreen = const Color(0xFF00FA9A);
const Color mediumTurquoise = const Color(0xFF48D1CC);
const Color mediumVioletRed = const Color(0xFFC71585);
const Color midnightBlue = const Color(0xFF191970);
const Color mintCream = const Color(0xFFF5FFFA);
const Color mistyRose = const Color(0xFFFFE4E1);
const Color moccasin = const Color(0xFFFFE4B5);
const Color navajoWhite = const Color(0xFFFFDEAD);
const Color navy = const Color(0xFF000080);
const Color oldLace = const Color(0xFFFDF5E6);
const Color olive = const Color(0xFF808000);
const Color oliveDrab = const Color(0xFF6B8E23);
const Color orange = const Color(0xFFFFA500);
const Color orangeRed = const Color(0xFFFF4500);
const Color orchid = const Color(0xFFDA70D6);
const Color paleGoldenRod = const Color(0xFFEEE8AA);
const Color paleGreen = const Color(0xFF98FB98);
const Color paleTurquoise = const Color(0xFFAFEEEE);
const Color paleVioletRed = const Color(0xFFDB7093);
const Color papayaWhip = const Color(0xFFFFEFD5);
const Color peachPuff = const Color(0xFFFFDAB9);
const Color peru = const Color(0xFFCD853F);
const Color pink = const Color(0xFFFFC0CB);
const Color plum = const Color(0xFFDDA0DD);
const Color powderBlue = const Color(0xFFB0E0E6);
const Color purple = const Color(0xFF800080);
const Color rebeccaPurple = const Color(0xFF663399);
const Color redColor = const Color(0xFFFF0000);
const Color rosyBrown = const Color(0xFFBC8F8F);
const Color royalBlue = const Color(0xFF4169E1);
const Color saddleBrown = const Color(0xFF8B4513);
const Color salmon = const Color(0xFFFA8072);
const Color sandyBrown = const Color(0xFFF4A460);
const Color seaGreen = const Color(0xFF2E8B57);
const Color seaShell = const Color(0xFFFFF5EE);
const Color sienna = const Color(0xFFA0522D);
const Color silver = const Color(0xFFC0C0C0);
const Color skyBlue = const Color(0xFF87CEEB);
const Color slateBlue = const Color(0xFF6A5ACD);
const Color slateGray = const Color(0xFF708090);
const Color slateGrey = const Color(0xFF708090);
const Color snow = const Color(0xFFFFFAFA);
const Color springGreen = const Color(0xFF00FF7F);
const Color steelBlue = const Color(0xFF4682B4);
const Color tan = const Color(0xFFD2B48C);
const Color teal = const Color(0xFF008080);
const Color thistle = const Color(0xFFD8BFD8);
const Color tomato = const Color(0xFFFF6347);
const Color turquoise = const Color(0xFF40E0D0);
const Color violet = const Color(0xFFEE82EE);
const Color wheat = const Color(0xFFF5DEB3);
const Color white = const Color(0xFFFFFFFF);
const Color whiteSmoke = const Color(0xFFF5F5F5);
const Color yellow = const Color(0xFFFFFF00);
const Color yellowGreen = const Color(0xFF9ACD32);

/// Returns MaterialColor from Color
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

/// Returns Color from hex String.
///
/// ```dart
/// Color color = getColorFromHex('#E5E5E5');
///
/// returns default color if not able to parse given hex
/// ```
Color getColorFromHex(String hexColor, {Color? defaultColor}) {
  if (hexColor.isEmpty) {
    if (defaultColor != null) {
      return defaultColor;
    } else {
      throw ArgumentError('Can not parse provided hex $hexColor');
    }
  }

  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

/// Light Colors
List<Color> lightColors = [
  mistyRose,
  whiteSmoke,
  linen,
  Color(0xffcffada),
  Color(0xFFf0efeb),
  Color(0xffd4dffa),
  Color(0xfff8eadf),
  Color(0xfffcdce1),
  Color(0xffddf8fa),
  Color(0xfffcfade),
  Color(0xffe2f8d8),
  Color(0xfffdf2e8),
  Color(0xffece8fd),
  Color(0xffdcfaf2),
];

/// get colors used in image
Future<List<int>?> getColorFromImage(ui.Image image, [int quality = 10]) async {
  final palette = await getPaletteFromImage(image, 5, quality);
  if (palette == null) return null;

  return palette[0];
}
