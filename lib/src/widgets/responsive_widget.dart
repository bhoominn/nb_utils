import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

/// set different layout based on current screen size (mobile, web, desktop)
class Responsive extends StatelessWidget {
  final Widget? web;
  final Widget mobile;
  final Widget? tablet;
  final bool? useFullWidth;
  final double? width;
  final double? minHeight;
  final Widget? defaultWidget;

  Responsive({
    this.web,
    required this.mobile,
    this.tablet,
    this.useFullWidth,
    this.width,
    this.minHeight,
    this.defaultWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.device == DeviceSize.tablet) {
          return tablet ?? mobile;
        } else if (constraints.device == DeviceSize.mobile) {
          return mobile;
        } else if (constraints.device == DeviceSize.desktop) {
          /// $desktopBreakpointGlobal checkout this variable to breakout desktop widget

          if (minHeight != null && constraints.minHeight < minHeight!) {
            return defaultWidget.validate();
          } else {
            return Container(
              alignment: Alignment.topCenter,
              child: Container(
                constraints: useFullWidth.validate(value: true)
                    ? null
                    : BoxConstraints(
                        maxWidth: width ?? (context.width() * 0.9)),
                child: web ?? SizedBox(),
              ),
            );
          }
        }
        return web ?? tablet ?? mobile;
      },
    );
  }
}
