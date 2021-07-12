/*
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class GradientBorder extends StatelessWidget {
  final Widget child;
  final double radius;
  final double strokeWidth;
  final Gradient gradient;
  final EdgeInsets? padding;

  GradientBorder({
    required this.strokeWidth,
    required this.radius,
    required this.gradient,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GPainter(strokeWidth: strokeWidth, radius: radius, gradient: gradient),
      child: Container(padding: padding ?? EdgeInsets.all(6), child: child),
    );
  }
}

class GPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  GPainter({required double strokeWidth, required double radius, required Gradient gradient})
      : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient;

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect = RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth, size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
*/
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class GradientBorder extends StatelessWidget {
  GradientBorder({
    required this.gradient,
    required this.child,
    this.strokeWidth = 1,
    this.borderRadius,
    this.padding = 0,
    splashColor,
  });

  Gradient gradient;
  Widget child;
  double strokeWidth;
  double? borderRadius;
  double padding;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GradientPainter(gradient: gradient, strokeWidth: strokeWidth, borderRadius: borderRadius ?? defaultRadius),
      child: Container(padding: EdgeInsets.all(padding + strokeWidth), child: IntrinsicWidth(child: child)),
    );
  }
}

class GradientPainter extends CustomPainter {
  GradientPainter({required this.gradient, required this.strokeWidth, required this.borderRadius});

  final Gradient gradient;
  final double strokeWidth;
  final double borderRadius;
  final Paint paintObject = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    Rect innerRect = Rect.fromLTRB(strokeWidth, strokeWidth, size.width - strokeWidth, size.height - strokeWidth);
    RRect innerRoundedRect = RRect.fromRectAndRadius(innerRect, Radius.circular(borderRadius));

    Rect outerRect = Offset.zero & size;
    RRect outerRoundedRect = RRect.fromRectAndRadius(outerRect, Radius.circular(borderRadius));

    paintObject.shader = gradient.createShader(outerRect);
    Path borderPath = _calculateBorderPath(outerRoundedRect, innerRoundedRect);
    canvas.drawPath(borderPath, paintObject);
  }

  Path _calculateBorderPath(RRect outerRRect, RRect innerRRect) {
    Path outerRectPath = Path()..addRRect(outerRRect);
    Path innerRectPath = Path()..addRRect(innerRRect);
    return Path.combine(PathOperation.difference, outerRectPath, innerRectPath);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
