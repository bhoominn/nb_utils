import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// [SizeListener] Listen to your child widget's size
class SizeListener extends StatefulWidget {
  final Widget child;
  final Function(Size) onSizeChange;

  final Duration? delayDuration;

  const SizeListener({
    super.key,
    required this.child,
    required this.onSizeChange,
    this.delayDuration,
  });

  @override
  _SizeListenerState createState() => _SizeListenerState();
}

class _SizeListenerState extends State<SizeListener> {
  GlobalKey widgetKey = GlobalKey();
  Size? oldSize;

  void postFrameCallback(_) async {
    BuildContext? context = widgetKey.currentContext;
    if (context == null) return;

    await Future.delayed(widget.delayDuration ?? Duration(milliseconds: 0));

    var newSize = context.size;
    if (oldSize == newSize || newSize == null) return;

    oldSize = newSize;
    widget.onSizeChange.call(newSize);
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(key: widgetKey, child: widget.child);
  }
}
