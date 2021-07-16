import 'package:flutter/material.dart';

extension ScrollExtension on ScrollController {
  /// Scroll to top with given animation duration
  Future<void> animToTop({milliseconds = 300}) async {
    this.animateTo(
      0,
      duration: Duration(milliseconds: milliseconds),
      curve: Curves.decelerate,
    );
  }

  /// Scroll to bottom with given animation duration
  Future<void> animToBottom({milliseconds = 300}) async {
    this.animateTo(
      this.position.maxScrollExtent,
      duration: Duration(milliseconds: milliseconds),
      curve: Curves.linear,
    );
  }

  /// Scroll to given position with given animation duration
  Future<void> animateToPosition(double position, {milliseconds = 300}) async {
    this.animateTo(
      position,
      duration: Duration(milliseconds: milliseconds),
      curve: Curves.linear,
    );
  }

  /// Scroll to top without animation
  void jumpToTop() => this.jumpTo(0);

  /// Scroll to bottom without animation
  void jumpToBottom() => this.jumpTo(this.position.maxScrollExtent);
}
