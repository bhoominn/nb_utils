import 'dart:async';

import 'package:flutter/material.dart';

/// TimerWidget
class TimerWidget extends StatefulWidget {
  final void Function() function;
  final Widget child;
  final Duration duration;

  final int? initialDelay;
  final bool pauseTimerOnAppPause;

  TimerWidget({
    required this.function,
    required this.child,
    required this.duration,
    this.initialDelay,
    this.pauseTimerOnAppPause = false,
  });

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> with WidgetsBindingObserver {
  Timer? timer;

  @override
  void initState() {
    if (widget.initialDelay != null) {
      Future.delayed(Duration(seconds: widget.initialDelay!)).then((value) {
        init();
      });
    } else {
      init();
    }

    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  void init() async {
    timer = Timer(widget.duration, () {
      widget.function.call();

      init();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (widget.pauseTimerOnAppPause) {
      if (state == AppLifecycleState.resumed) {
        init();
      } else if (state == AppLifecycleState.paused) {
        timer?.cancel();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
