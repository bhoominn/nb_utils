import 'package:flutter/material.dart';

typedef BoolWidgetBuilder = Widget Function(
    BuildContext context, bool isHovering);

/// Hover Widget is useful is web platform
class HoverWidget extends StatefulWidget {
  final BoolWidgetBuilder builder;
  final bool? opaque;

  HoverWidget({required this.builder, this.opaque});

  @override
  _HoverWidgetState createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<HoverWidget> {
  bool isHovering = false;

  void onEvent(bool value) {
    isHovering = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => onEvent(true),
      onExit: (event) => onEvent(false),
      onHover: (event) => onEvent(true),
      opaque: widget.opaque ?? true,
      child: widget.builder.call(context, isHovering),
    );
  }
}
