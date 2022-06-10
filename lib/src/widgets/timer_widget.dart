import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

/// TimerWidget - Use this widget if you want to do something every X seconds or any duration.
class TimerWidget extends StatefulWidget {
  final void Function() function;
  final Widget child;
  final Duration duration;

  final int? initialDelay;
  final bool enableWidgetBindingObserver;
  final bool enableTimer;

  TimerWidget({
    required this.function,
    required this.child,
    required this.duration,
    this.initialDelay,
    this.enableWidgetBindingObserver = false,
    this.enableTimer = true,
    Key? key,
  }) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> with WidgetsBindingObserver {
  Timer? timer;

  @override
  void initState() {
    if (widget.initialDelay != null) {
      widget.initialDelay!.seconds.delay.then((value) {
        init();
      });
    } else {
      1.seconds.delay.then((v) {
        widget.function.call();
      });
    }

    makeNullable(WidgetsBinding.instance)!.addObserver(this);
    super.initState();
  }

  void init() async {
    timer = Timer(widget.duration, () {
      if (widget.enableTimer) widget.function.call();

      init();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    makeNullable(WidgetsBinding.instance)!.removeObserver(this);
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (widget.enableWidgetBindingObserver) {
      if (state == AppLifecycleState.resumed) {
        init();
      } else if (state == AppLifecycleState.paused) {
        timer?.cancel();
      }
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
