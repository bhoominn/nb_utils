import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// [SizeListener] Calculated the size of it's child in runtime.
/// Simply wrap your widget with [SizeListener] and listen to size changes with [onChange].
class SizeListener extends StatefulWidget {
  /// Widget to calculate it's size.
  final Widget child;

  /// [onChange] will be called when the [Size] changes.
  /// [onChange] will return the value ONLY once if it didn't change, and it will NOT return a value if it's equals to [Size.zero]
  final Function(Size) onChange;

  const SizeListener({
    Key? key,
    required this.onChange,
    required this.child,
  }) : super(key: key);

  @override
  _SizeListenerState createState() => _SizeListenerState();
}

class _SizeListenerState extends State<SizeListener> {
  var widgetKey = GlobalKey();
  var oldSize;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    super.initState();
  }

  void postFrameCallback(_) async {
    var context = widgetKey.currentContext!;

    await Future.delayed(
        Duration(milliseconds: 100)); // wait till the widget is built
    Size newSize = context.size!;
    if (newSize == Size.zero) return;
    if (oldSize == newSize) return;
    oldSize = newSize;
    widget.onChange(newSize);
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }
}
