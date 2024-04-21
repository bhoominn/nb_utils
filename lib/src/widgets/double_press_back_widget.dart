import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

/// A widget that handles double press back navigation.
///
/// This widget allows users to navigate back by pressing the back button
/// twice within a 1-second window. It displays a customizable message
/// prompting the user for the second press.
class DoublePressBackWidget extends StatefulWidget {
  /// The child widget to display.
  final Widget child;

  /// The message to display when prompting the user to double press back.
  final String? message;

  /// Callback function that gets called on pop confirmation (double press).
  final VoidCallback? onWillPop; // Changed type to VoidCallback

  DoublePressBackWidget({
    super.key,
    required this.child,
    this.message,
    this.onWillPop,
  });

  @override
  State<DoublePressBackWidget> createState() => _DoublePressBackWidgetState();
}

class _DoublePressBackWidgetState extends State<DoublePressBackWidget> {
  DateTime? _currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Allow pop only after 2 seconds since last press
      canPop: _currentBackPressTime != null,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          // User confirmed with double press within 2 seconds
          widget.onWillPop?.call(); // Call the user-defined callback
          Navigator.pop(context); // Assuming this triggers back navigation
          return;
        }

        _currentBackPressTime = DateTime.now();
        setState(() {});
        toast(widget.message ?? 'Press back again to exit');

        // Start a timer to reset state after 2 seconds
        Future.delayed(const Duration(seconds: 2), () {
          _currentBackPressTime = null;
          setState(() {});
        });
      },
      child: widget.child,
    );
  }
}
