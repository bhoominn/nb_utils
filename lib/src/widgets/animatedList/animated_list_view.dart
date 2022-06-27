import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AnimatedListView extends StatelessWidget {
  /// ListView.builder properties
  final ScrollController? controller;
  final int? itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final Axis scrollDirection;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final Clip clipBehavior;
  final DragStartBehavior dragStartBehavior;
  final int? Function(Key)? findChildIndexCallback;
  final double? itemExtent;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final bool? primary;
  final Widget? prototypeItem;
  final String? restorationId;
  final bool reverse;
  final int? semanticChildCount;

  /// Animation Configuration
  final ListAnimationType listAnimationType;

  final SlideConfiguration? slideConfiguration;
  final FadeInConfiguration? fadeInConfiguration;
  final ScaleConfiguration? scaleConfiguration;
  final FlipConfiguration? flipConfiguration;

  AnimatedListView({
    Key? key,
    this.controller,
    this.itemCount,
    this.padding,
    this.physics,
    this.scrollDirection = Axis.vertical,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.findChildIndexCallback,
    this.itemExtent,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.primary,
    this.prototypeItem,
    this.restorationId,
    this.reverse = false,
    this.semanticChildCount,
    required this.itemBuilder,
    this.shrinkWrap = false,
    this.listAnimationType = ListAnimationType.Slide,
    this.slideConfiguration,
    this.fadeInConfiguration,
    this.scaleConfiguration,
    this.flipConfiguration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiterClass(
      child: ListView.builder(
        controller: controller,
        physics: physics,
        padding: padding,
        itemCount: itemCount,
        shrinkWrap: shrinkWrap,
        scrollDirection: scrollDirection,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        cacheExtent: cacheExtent,
        clipBehavior: clipBehavior,
        dragStartBehavior: dragStartBehavior,
        findChildIndexCallback: findChildIndexCallback,
        itemExtent: itemExtent,
        keyboardDismissBehavior: keyboardDismissBehavior,
        primary: primary,
        prototypeItem: prototypeItem,
        restorationId: restorationId,
        reverse: reverse,
        semanticChildCount: semanticChildCount,
        itemBuilder: (_, index) => AnimationConfigurationClass.staggeredList(
          position: index,
          child: AnimatedItemWidget(
            listAnimationType: listAnimationType,
            fadeInConfiguration: fadeInConfiguration,
            scaleConfiguration: scaleConfiguration,
            slideConfiguration: slideConfiguration,
            flipConfiguration: flipConfiguration,
            child: itemBuilder.call(_, index),
          ),
        ),
      ),
    );
  }
}
