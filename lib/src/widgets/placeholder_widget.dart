import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

/// Set nicely colored PlaceHolder while image is loading
class PlaceHolderWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Duration? animationDuration;
  final Color? color;

  final BoxShape? shape;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;

  PlaceHolderWidget({
    this.height,
    this.width,
    this.animationDuration,
    this.padding,
    this.margin,
    this.color,
    this.alignment,
    this.shape,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.gradient,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: height,
      duration: animationDuration ?? 1.seconds,
      width: width,
      decoration: BoxDecoration(
        color:
            color ?? lightColors[Random.secure().nextInt(lightColors.length)],
        shape: shape ?? BoxShape.rectangle,
        borderRadius: borderRadius,
        border: border,
        boxShadow: boxShadow,
        gradient: gradient,
      ),
      alignment: alignment,
      padding: padding,
      margin: margin,
    );
  }
}
