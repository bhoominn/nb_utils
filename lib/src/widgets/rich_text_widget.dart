import 'package:flutter/material.dart';

// RichTextWidget
class RichTextWidget extends StatelessWidget {
  final List<TextSpan> list;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final StrutStyle? strutStyle;
  final Locale? locale;

  const RichTextWidget({
    required this.list,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.textDirection,
    this.strutStyle,
    this.locale,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: list),
      overflow: overflow ?? TextOverflow.clip,
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.left,
      textDirection: textDirection,
      strutStyle: strutStyle,
      locale: locale,
    );
  }
}
