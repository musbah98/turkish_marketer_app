// Custom painter to draw the triangle

import 'package:flutter/material.dart';

// Custom painter to draw the triangle
class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFFD4380D)
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.width); // Bottom-left corner
    path.lineTo(size.height, 0); // Bottom-right corner
    path.lineTo(0, 0); // Top-right corner
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
