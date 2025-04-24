import 'package:flutter/material.dart';


class DotedLine extends StatelessWidget {
  const DotedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          size: Size(200, 1),
          painter: PaintLine(width: 2, spacing: 5, color: Colors.green),
        ),
      ),
    );
  }
}

class PaintLine extends CustomPainter {
  final double width;
  final double spacing;
  final Color color;

  PaintLine({required this.width, required this.spacing, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = width
          ..style = PaintingStyle.stroke;

    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + spacing, 0), paint);
      startX += 2 * spacing;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
