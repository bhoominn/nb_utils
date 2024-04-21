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

const Color aliceBlue = Color(0xFFF0F8FF);
const Color antiqueWhite = Color(0xFFFAEBD7);
const Color aqua = Color(0xFF00FFFF);
const Color aquamarine = Color(0xFF7FFFD4);
const Color azure = Color(0xFFF0FFFF);
const Color beige = Color(0xFFF5F5DC);
const Color bisque = Color(0xFFFFE4C4);
const Color black = Color(0xFF000000);
const Color blanchedAlmond = Color(0xFFFFEBCD);
const Color blueColor = Color(0xFF0000FF);
const Color blueViolet = Color(0xFF8A2BE2);
const Color brown = Color(0xFFA52A2A);
const Color burlyWood = Color(0xFFDEB887);
const Color cadetBlue = Color(0xFF5F9EA0);
const Color chartreuse = Color(0xFF7FFF00);
const Color chocolate = Color(0xFFD2691E);
const Color coral = Color(0xFFFF7F50);
const Color cornflowerBlue = Color(0xFF6495ED);
const Color cornSilk = Color(0xFFFFF8DC);
const Color crimson = Color(0xFFDC143C);
const Color cyan = Color(0xFF00FFFF);
const Color darkBlue = Color(0xFF00008B);
const Color darkCyan = Color(0xFF008B8B);
const Color darkGoldenRod = Color(0xFFB8860B);
const Color darkGray = Color(0xFFA9A9A9);
const Color darkGreen = Color(0xFF006400);
const Color darkGrey = Color(0xFFA9A9A9);
const Color darkKhaki = Color(0xFFBDB76B);
const Color darkMagenta = Color(0xFF8B008B);
const Color darkOliveGreen = Color(0xFF556B2F);
const Color darkOrange = Color(0xFFFF8C00);
const Color darkOrchid = Color(0xFF9932CC);
const Color darkRed = Color(0xFF8B0000);
const Color darkSalmon = Color(0xFFE9967A);
const Color darkSeaGreen = Color(0xFF8FBC8F);
const Color darkSlateBlue = Color(0xFF483D8B);
const Color darkSlateGray = Color(0xFF2F4F4F);
const Color darkSlateGrey = Color(0xFF2F4F4F);
const Color darkTurquoise = Color(0xFF00CED1);
const Color darkViolet = Color(0xFF9400D3);
const Color deepPink = Color(0xFFFF1493);
const Color deepSkyBlue = Color(0xFF00BFFF);
const Color dimGray = Color(0xFF696969);
const Color dimGrey = Color(0xFF696969);
const Color dodgerBlue = Color(0xFF1E90FF);
const Color fireBrick = Color(0xFFB22222);
const Color floralWhite = Color(0xFFFFFAF0);
const Color forestGreen = Color(0xFF228B22);
const Color fuchsia = Color(0xFFFF00FF);
const Color gainsBoro = Color(0xFFDCDCDC);
const Color ghostWhite = Color(0xFFF8F8FF);
const Color gold = Color(0xFFFFD700);
const Color goldenRod = Color(0xFFDAA520);
const Color gray = Color(0xFF808080);
const Color greenColor = Color(0xFF008000);
const Color greenYellow = Color(0xFFADFF2F);
const Color grey = Color(0xFF808080);
const Color honeyDew = Color(0xFFF0FFF0);
const Color hotPink = Color(0xFFFF69B4);
const Color indianRed = Color(0xFFCD5C5C);
const Color indigo = Color(0xFF4B0082);
const Color ivory = Color(0xFFFFFFF0);
const Color khaki = Color(0xFFF0E68C);
const Color lavender = Color(0xFFE6E6FA);
const Color lavenderBlush = Color(0xFFFFF0F5);
const Color lawnGreen = Color(0xFF7CFC00);
const Color lemonChiffon = Color(0xFFFFFACD);
const Color lightBlue = Color(0xFFADD8E6);
const Color lightCoral = Color(0xFFF08080);
const Color lightCyan = Color(0xFFE0FFFF);
const Color lightGoldenRodYellow = Color(0xFFFAFAD2);
const Color lightGray = Color(0xFFD3D3D3);
const Color lightGreen = Color(0xFF90EE90);
const Color lightGrey = Color(0xFFD3D3D3);
const Color lightPink = Color(0xFFFFB6C1);
const Color lightSalmon = Color(0xFFFFA07A);
const Color lightSeaGreen = Color(0xFF20B2AA);
const Color lightSkyBlue = Color(0xFF87CEFA);
const Color lightSlateGray = Color(0xFF778899);
const Color lightSlateGrey = Color(0xFF778899);
const Color lightSteelBlue = Color(0xFFB0C4DE);
const Color lightYellow = Color(0xFFFFFFE0);
const Color lime = Color(0xFF00FF00);
const Color limeGreen = Color(0xFF32CD32);
const Color linen = Color(0xFFFAF0E6);
const Color magenta = Color(0xFFFF00FF);
const Color maroon = Color(0xFF800000);
const Color mediumAquaMarine = Color(0xFF66CDAA);
const Color mediumBlue = Color(0xFF0000CD);
const Color mediumOrchid = Color(0xFFBA55D3);
const Color mediumPurple = Color(0xFF9370DB);
const Color mediumSeaGreen = Color(0xFF3CB371);
const Color mediumSlateBlue = Color(0xFF7B68EE);
const Color mediumSpringGreen = Color(0xFF00FA9A);
const Color mediumTurquoise = Color(0xFF48D1CC);
const Color mediumVioletRed = Color(0xFFC71585);
const Color midnightBlue = Color(0xFF191970);
const Color mintCream = Color(0xFFF5FFFA);
const Color mistyRose = Color(0xFFFFE4E1);
const Color moccasin = Color(0xFFFFE4B5);
const Color navajoWhite = Color(0xFFFFDEAD);
const Color navy = Color(0xFF000080);
const Color oldLace = Color(0xFFFDF5E6);
const Color olive = Color(0xFF808000);
const Color oliveDrab = Color(0xFF6B8E23);
const Color orange = Color(0xFFFFA500);
const Color orangeRed = Color(0xFFFF4500);
const Color orchid = Color(0xFFDA70D6);
const Color paleGoldenRod = Color(0xFFEEE8AA);
const Color paleGreen = Color(0xFF98FB98);
const Color paleTurquoise = Color(0xFFAFEEEE);
const Color paleVioletRed = Color(0xFFDB7093);
const Color papayaWhip = Color(0xFFFFEFD5);
const Color peachPuff = Color(0xFFFFDAB9);
const Color peru = Color(0xFFCD853F);
const Color pink = Color(0xFFFFC0CB);
const Color plum = Color(0xFFDDA0DD);
const Color powderBlue = Color(0xFFB0E0E6);
const Color purple = Color(0xFF800080);
const Color rebeccaPurple = Color(0xFF663399);
const Color redColor = Color(0xFFFF0000);
const Color rosyBrown = Color(0xFFBC8F8F);
const Color royalBlue = Color(0xFF4169E1);
const Color saddleBrown = Color(0xFF8B4513);
const Color salmon = Color(0xFFFA8072);
const Color sandyBrown = Color(0xFFF4A460);
const Color seaGreen = Color(0xFF2E8B57);
const Color seaShell = Color(0xFFFFF5EE);
const Color sienna = Color(0xFFA0522D);
const Color silver = Color(0xFFC0C0C0);
const Color skyBlue = Color(0xFF87CEEB);
const Color slateBlue = Color(0xFF6A5ACD);
const Color slateGray = Color(0xFF708090);
const Color slateGrey = Color(0xFF708090);
const Color snow = Color(0xFFFFFAFA);
const Color springGreen = Color(0xFF00FF7F);
const Color steelBlue = Color(0xFF4682B4);
const Color tan = Color(0xFFD2B48C);
const Color teal = Color(0xFF008080);
const Color thistle = Color(0xFFD8BFD8);
const Color tomato = Color(0xFFFF6347);
const Color turquoise = Color(0xFF40E0D0);
const Color violet = Color(0xFFEE82EE);
const Color wheat = Color(0xFFF5DEB3);
const Color white = Color(0xFFFFFFFF);
const Color whiteSmoke = Color(0xFFF5F5F5);
const Color yellow = Color(0xFFFFFF00);
const Color yellowGreen = Color(0xFF9ACD32);

/// Returns MaterialColor from Color
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
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
    hexColor = "FF$hexColor";
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
