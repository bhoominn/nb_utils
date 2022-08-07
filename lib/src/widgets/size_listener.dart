import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

/// [SizeListener] Listen to your child widget's size
class SizeListener extends StatefulWidget {
  final Widget child;
  final Function(Size) onSizeChange;

  final Duration? delayDuration;

  const SizeListener({
    Key? key,
    required this.child,
    required this.onSizeChange,
    this.delayDuration,
  }) : super(key: key);

  @override
  _SizeListenerState createState() => _SizeListenerState();
}

class _SizeListenerState extends State<SizeListener> {
  GlobalKey widgetKey = GlobalKey();
  Size? oldSize;

  @override
  void initState() {
    afterBuildCreated(() => postFrameCallback);
    super.initState();
  }

  void postFrameCallback(_) async {
    var context = widgetKey.currentContext!;

    await Future.delayed(widget.delayDuration ?? Duration(milliseconds: 200));
    Size newSize = context.size!;

    if (newSize == Size.zero) return;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onSizeChange.call(newSize);
  }

  @override
  void didUpdateWidget(covariant SizeListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    afterBuildCreated(() => postFrameCallback);
  }

  @override
  Widget build(BuildContext context) {
    //SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }
}
