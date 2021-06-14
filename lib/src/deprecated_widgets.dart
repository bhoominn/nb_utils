import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

extension TextExtension on Text {
  @Deprecated(
      'This style is not anymore maintained and will be deleted in next major update (4.0).')
  Text withStyle({
    double fontSize = 16,
    FontWeight? fontWeight,
    Color color = textPrimaryColor,
    FontStyle? fontStyle,
    Paint? foreground,
    double? wordSpacing,
    Color? backgroundColor,
    Color? decorationColor,
    TextDecoration? textDecoration,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    List<Shadow>? shadows,
    double? letterSpacing,
    Locale? locale,
    TextBaseline? textBaseline,
    Paint? background,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    List<FontFeature>? fontFeatures,
    String? debugLabel,
    double? height,
    bool? inherit,
  }) {
    final style = TextStyle().copyWith(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      foreground: foreground,
      wordSpacing: wordSpacing,
      backgroundColor: backgroundColor,
      decorationColor: decorationColor,
      decoration: textDecoration,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      shadows: shadows,
      letterSpacing: letterSpacing,
      locale: locale,
      textBaseline: textBaseline,
      background: background,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
      fontFeatures: fontFeatures,
      debugLabel: debugLabel,
      height: height,
      inherit: inherit,
    );

    return Text(
      this.data!,
      style: style,
      textAlign: this.textAlign,
      strutStyle: this.strutStyle,
      softWrap: this.softWrap,
      semanticsLabel: this.semanticsLabel,
      locale: this.locale,
      overflow: this.overflow,
      textWidthBasis: this.textWidthBasis,
      textDirection: this.textDirection,
      textScaleFactor: this.textScaleFactor,
      maxLines: this.maxLines,
    );
  }
}

extension S on String? {
  @deprecated
  Text text({
    String defaultValue = '',
    TextStyle? style,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextAlign? textAlign,
    bool? softWrap,
    Locale? locale,
    Key? key,
    String? semanticsLabel,
    StrutStyle? strutStyle,
    double? textScaleFactor,
    TextWidthBasis? textWidthBasis,
  }) {
    return Text(
      this.validate(value: defaultValue),
      style: style,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      softWrap: softWrap,
      locale: locale,
      key: key,
      semanticsLabel: semanticsLabel,
      strutStyle: strutStyle,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }

  @Deprecated('Use convertYouTubeUrlToId() instead')
  String convertUrlToId({bool trimWhitespaces = true}) {
    return convertYouTubeUrlToId(trimWhitespaces: trimWhitespaces);
  }

  /// Returns a list of chars from a String
  @Deprecated('Use toList() instead')
  List<String> toCharArray() =>
      this != null && this.validate().trim().isNotEmpty
          ? this.validate().split('')
          : [];
}
