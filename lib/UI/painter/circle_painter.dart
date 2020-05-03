import 'dart:math';

import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  int seed;
  CirclePainter({this.seed});
  @override
  void paint(Canvas canvas, Size size) {
    if (seed == null) seed = DateTime.now().millisecondsSinceEpoch;
    for (int i = 0; i < 20; i++) {
      var circlePainterTool = Paint()
        ..color = Color(Random(seed - i).nextInt(0xffffffff))
        ..strokeWidth = 2
        ..isAntiAlias = true
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(Random(seed + i).nextDouble() * size.width,
            Random(seed + i + 1).nextDouble() * size.height),
        Random(seed + i + 2).nextDouble() * 150,
        circlePainterTool,
      );
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return false;
  }
}
