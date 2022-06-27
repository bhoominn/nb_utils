import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AnimatedWrap extends StatelessWidget {
  /// Wrap properties
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final Clip? clipBehavior;
  final WrapCrossAlignment? crossAxisAlignment;
  final double? runSpacing;
  final double? spacing;
  final WrapAlignment? runAlignment;
  final WrapAlignment? alignment;
  final Axis? direction;
  final TextDirection? textDirection;
  final VerticalDirection? verticalDirection;

  /// Animation Configuration
  final int columnCount;
  final ListAnimationType listAnimationType;

  final SlideConfiguration? slideConfiguration;
  final FadeInConfiguration? fadeInConfiguration;
  final ScaleConfiguration? scaleConfiguration;
  final FlipConfiguration? flipConfiguration;

  AnimatedWrap({
    Key? key,
    this.itemCount = 0,
    required this.itemBuilder,
    this.clipBehavior,
    this.crossAxisAlignment,
    this.runSpacing,
    this.spacing,
    this.runAlignment,
    this.alignment,
    this.direction,
    this.textDirection,
    this.verticalDirection,
    this.columnCount = 1,
    this.listAnimationType = ListAnimationType.Slide,
    this.slideConfiguration,
    this.fadeInConfiguration,
    this.scaleConfiguration,
    this.flipConfiguration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiterWidget(
      child: Wrap(
        clipBehavior: clipBehavior ?? Clip.none,
        crossAxisAlignment: crossAxisAlignment ?? WrapCrossAlignment.start,
        runSpacing: runSpacing ?? 0.0,
        spacing: spacing ?? 0.0,
        runAlignment: runAlignment ?? WrapAlignment.start,
        alignment: alignment ?? WrapAlignment.start,
        direction: direction ?? Axis.horizontal,
        textDirection: textDirection,
        verticalDirection: verticalDirection ?? VerticalDirection.down,
        children: List.generate(itemCount, (index) {
          return AnimationConfigurationClass.staggeredGrid(
            position: index,
            columnCount: columnCount,
            child: AnimatedItemWidget(
              listAnimationType: listAnimationType,
              fadeInConfiguration: fadeInConfiguration,
              scaleConfiguration: scaleConfiguration,
              slideConfiguration: slideConfiguration,
              flipConfiguration: flipConfiguration,
              child: itemBuilder.call(context, index),
            ),
          );
        }),
      ),
    );
  }
}
