import 'package:flutter/material.dart';

enum DirectionMarguee { oneDirection, twoDirection }

/// Marquee Text
class Marquee extends StatelessWidget {
  final Widget child;
  final TextDirection textDirection;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;
  final DirectionMarguee directionMarguee;

  Marquee({
    required this.child,
    this.direction = Axis.horizontal,
    this.textDirection = TextDirection.ltr,
    this.animationDuration = const Duration(milliseconds: 5000),
    this.backDuration = const Duration(milliseconds: 5000),
    this.pauseDuration = const Duration(milliseconds: 2000),
    this.directionMarguee = DirectionMarguee.twoDirection,
    Key? key,
  }) : super(key: key);

  final ScrollController scrollController = ScrollController();

  scroll() async {
    while (true) {
      if (scrollController.hasClients) {
        await Future.delayed(pauseDuration);
        if (scrollController.hasClients) {
          await scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: animationDuration,
              curve: Curves.easeIn);
        }
        await Future.delayed(pauseDuration);
        if (scrollController.hasClients) {
          switch (directionMarguee) {
            case DirectionMarguee.oneDirection:
              scrollController.jumpTo(
                0.0,
              );
              break;
            case DirectionMarguee.twoDirection:
              await scrollController.animateTo(0.0,
                  duration: backDuration, curve: Curves.easeOut);
              break;
          }
        }
      } else {
        await Future.delayed(pauseDuration);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    scroll();
    return Directionality(
      textDirection: textDirection,
      child: SingleChildScrollView(
        scrollDirection: direction,
        controller: scrollController,
        child: child,
      ),
    );
  }
}
