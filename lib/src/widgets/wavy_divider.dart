import 'package:flutter/material.dart';

/// A wavy divider that can be used to separate content.
class WavyDivider extends StatelessWidget {
  final double? width;
  final Color? color;

  const WavyDivider({super.key, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: width,
      child: CustomPaint(
        painter: WavyLinePainter(width: width, color: color),
        child: Container(),
      ),
    );
  }
}

/// A custom painter that paints a wavy line.
class WavyLinePainter extends CustomPainter {
  final double? width;
  final Color? color;

  const WavyLinePainter({this.width, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color ?? Colors.grey.shade300
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path path = Path();
    double waveWidth = size.width / (width != null ? (width! * 0.03) : 25);
    double waveHeight = 6;

    path.moveTo(0, size.height / 2);
    for (double i = 0; i < size.width; i += waveWidth) {
      path.relativeQuadraticBezierTo(
        waveWidth / 4,
        -waveHeight,
        waveWidth / 2,
        0,
      );
      path.relativeQuadraticBezierTo(
        waveWidth / 4,
        waveHeight,
        waveWidth / 2,
        0,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
