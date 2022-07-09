import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';

class AnimatedScrollView extends StatefulWidget {
  /// ListView.builder properties
  final ScrollController? controller;
  final int? itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final Clip clipBehavior;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final bool? primary;
  final String? restorationId;
  final bool reverse;

  /// Animation Configuration
  final ListAnimationType listAnimationType;

  final SlideConfiguration? slideConfiguration;
  final FadeInConfiguration? fadeInConfiguration;
  final ScaleConfiguration? scaleConfiguration;
  final FlipConfiguration? flipConfiguration;

  final VoidCallback? onNextPage;
  final VoidCallback? onPageScrollChange;

  AnimatedScrollView({
    Key? key,
    this.controller,
    this.itemCount,
    this.padding,
    this.physics,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.primary,
    this.restorationId,
    this.reverse = false,
    required this.itemBuilder,
    this.listAnimationType = ListAnimationType.Slide,
    this.slideConfiguration,
    this.fadeInConfiguration,
    this.scaleConfiguration,
    this.flipConfiguration,
    this.onNextPage,
    this.onPageScrollChange,
  }) : super(key: key);

  @override
  State<AnimatedScrollView> createState() => _AnimatedScrollViewState();
}

class _AnimatedScrollViewState extends State<AnimatedScrollView> {
  ScrollController? scrollController;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    if (widget.controller != null) {
      scrollController = widget.controller;
    } else {
      scrollController = ScrollController();
    }

    if (widget.onNextPage != null) {
      /// Enable Pagination

      scrollController!.addListener(() {
        if (scrollController!.position.maxScrollExtent ==
            scrollController!.offset) {
          widget.onNextPage?.call();
        }

        if (widget.onPageScrollChange != null) {
          widget.onPageScrollChange!.call();
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

    scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiterWidget(
      child: SingleChildScrollView(
        controller: scrollController,
        physics: widget.physics,
        padding: widget.padding,
        scrollDirection: Axis.vertical,
        clipBehavior: widget.clipBehavior,
        dragStartBehavior: widget.dragStartBehavior,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        primary: widget.primary,
        restorationId: widget.restorationId,
        reverse: widget.reverse,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.itemCount.validate(), (index) {
            return AnimationConfigurationClass.staggeredList(
              position: index,
              child: AnimatedItemWidget(
                listAnimationType: widget.listAnimationType,
                fadeInConfiguration: widget.fadeInConfiguration,
                scaleConfiguration: widget.scaleConfiguration,
                slideConfiguration: widget.slideConfiguration,
                flipConfiguration: widget.flipConfiguration,
                child: widget.itemBuilder.call(context, index),
              ),
            );
          }),
        ),
      ),
    );
  }
}
