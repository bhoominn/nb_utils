import 'package:flutter/material.dart';

// HorizontalList widget is great when you don't want to give fix height to a item
class HorizontalList extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double? spacing;
  final double? runSpacing;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool reverse;
  final ScrollController? controller;

  final WrapAlignment? wrapAlignment;
  final WrapCrossAlignment? crossAxisAlignment;

  const HorizontalList({
    required this.itemCount,
    required this.itemBuilder,
    this.spacing,
    this.runSpacing,
    this.padding,
    this.physics,
    this.controller,
    this.reverse = false,
    this.wrapAlignment,
    this.crossAxisAlignment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: physics,
      padding: padding ?? const EdgeInsets.all(8),
      scrollDirection: Axis.horizontal,
      reverse: reverse,
      controller: controller,
      child: Wrap(
        spacing: spacing ?? 8,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        direction: Axis.horizontal,
        runAlignment: wrapAlignment ?? WrapAlignment.start,
        crossAxisAlignment: crossAxisAlignment ?? WrapCrossAlignment.start,
        runSpacing: runSpacing ?? 8,
        children: List.generate(
          itemCount,
          (index) => itemBuilder(context, index),
        ),
      ),
    );
  }
}
