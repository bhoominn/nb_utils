import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

// GradientBorder
class GradientBorder extends StatelessWidget {
  final Gradient gradient;
  final Widget child;
  final double strokeWidth;
  final double? borderRadius;
  final double padding;

  GradientBorder({
    required this.gradient,
    required this.child,
    this.strokeWidth = 1,
    this.borderRadius,
    this.padding = 0,
    splashColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GradientPainter(
        gradient: gradient,
        strokeWidth: strokeWidth,
        borderRadius: borderRadius ?? defaultRadius,
      ),
      child: Container(
        padding: EdgeInsets.all(padding + strokeWidth),
        child: IntrinsicWidth(child: child),
      ),
    );
  }
}

class GradientPainter extends CustomPainter {
  final Gradient gradient;
  final double strokeWidth;
  final double borderRadius;
  final Paint paintObject = Paint();

  GradientPainter({
    required this.gradient,
    required this.strokeWidth,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Rect innerRect = Rect.fromLTRB(strokeWidth, strokeWidth,
        size.width - strokeWidth, size.height - strokeWidth);
    RRect innerRoundedRect =
        RRect.fromRectAndRadius(innerRect, Radius.circular(borderRadius));

    Rect outerRect = Offset.zero & size;
    RRect outerRoundedRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(borderRadius));

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
