import 'dart:math';

import 'package:flutter/material.dart';

class RibbonWidget extends CustomPainter {
  Key key;
  Color startColor;
  Color endColor;
  Color border;

  RibbonWidget({
    this.key,
    this.startColor = Colors.green,
    this.endColor = Colors.blue,
    this.border = Colors.yellow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final Gradient gradient = new LinearGradient(
      colors: <Color>[
        startColor,
        endColor,
      ],
      stops: [
        0.0,
        1.0,
      ],
    );

    Rect rect = new Rect.fromLTWH(0, 0, size.width, size.height);

    Paint linePaint = new Paint()
      ..shader = gradient.createShader(rect)
      ..color = startColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    List<Offset> lines = List<Offset>();
    lines.add(Offset(0, 0));
    lines.add(Offset(size.width, 0));
    lines.add(Offset(size.width - size.height / 3, size.height / 2));
    lines.add(Offset(size.width, size.height));
    lines.add(Offset(0, size.height));

    canvas.drawPath(
      Path()..addPolygon(lines, true),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
