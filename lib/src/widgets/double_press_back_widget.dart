import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

DateTime? _currentBackPressTime;

/// A widget that handles double press back navigation.
class DoublePressBackWidget extends StatelessWidget {
  /// The child widget to display.
  final Widget child;

  /// The message to display when prompting the user to double press back.
  final String? message;

  /// Callback function that gets called on willPop.
  final WillPopCallback? onWillPop;

  DoublePressBackWidget({
    super.key,
    required this.child,
    this.message,
    this.onWillPop,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: () {
        DateTime now = DateTime.now();

        onWillPop?.call();
        if (_currentBackPressTime == null ||
            now.difference(_currentBackPressTime!) > Duration(seconds: 2)) {
          _currentBackPressTime = now;
          toast(message ?? 'Press back again to exit');

          return Future.value(false);
        }
        return Future.value(true);
      },
    );
  }
}
