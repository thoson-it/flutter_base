import 'dart:math';

import 'package:flutter/material.dart';

class RibbonWidget extends CustomPainter {
  Key key;
  Color startColor;
  Color endColor;
  double cornerRadius;

  RibbonWidget({
    this.key,
    this.startColor = Colors.green,
    this.endColor = Colors.blue,
    this.cornerRadius = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
//    canvas.clipPath()
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

    Rect rect = new Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height,
    );

//    Paint line = new Paint()..shader = gradient.createShader(rect);
    Paint line = new Paint()
      ..color = startColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    List<Offset> top = List<Offset>();
    //Top left
    top.add(Offset(0, 0));
    //Top right
    top.add(Offset(size.width - cornerRadius, 0));
    List<Offset> right = List<Offset>();
    right.add(Offset(size.width - cornerRadius, cornerRadius));
    right.add(Offset(size.width - size.height / 3, size.height / 2));
    right.add(Offset(size.width - cornerRadius, size.height - cornerRadius));
//    points.add(Offset(size.width, size.height));
//    points.add(Offset(0, size.height));

    num degToRad(num deg) => deg * (pi / 180.0);

    canvas.drawPath(
      Path()
        ..addPolygon(top, false)
        ..addArc(
          Rect.fromCircle(center: Offset(size.width - 10 - cornerRadius,
              cornerRadius / 2),
              radius:
          cornerRadius),
          degToRad(315),
          degToRad(90),
        )
        ..addPolygon(right, false),
      line,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

//class MyPainter extends CustomPainter {
//  Color lineColor;
//  Color completeColor;
//  double completePercent;
//  double width;
//
//  MyPainter(
//      {this.lineColor, this.completeColor, this.completePercent, this.width});
//
//  @override
//  void paint(Canvas canvas, Size size) {
//    // a fancy rainbow gradient
//    final Gradient gradient = new RadialGradient(
//      colors: <Color>[
//        Colors.green.withOpacity(1.0),
//        Colors.green.withOpacity(0.3),
//        Colors.yellow.withOpacity(0.2),
//        Colors.red.withOpacity(0.1),
//        Colors.red.withOpacity(0.0),
//      ],
//      stops: [
//        0.0,
//        0.5,
//        0.7,
//        0.9,
//        1.0,
//      ],
//    );
//
//    Rect rect = new Rect.fromCircle(
//      center: new Offset(165.0, 55.0),
//      radius: 180.0,
//    );
//
//    Paint line = new Paint()
////      ..color = lineColor
//      ..strokeCap = StrokeCap.round
//      ..style = PaintingStyle.fill
//      ..shader = gradient.createShader(rect)
//      ..strokeWidth = width;
//
//
//
//    Paint complete = new Paint()
//      ..color = completeColor
//      ..strokeCap = StrokeCap.butt
//      ..style = PaintingStyle.stroke
//      ..strokeWidth = width;
//
//    List<Offset> points = List<Offset>();
//    points.add(Offset(0, 0));
//    points.add(Offset(size.width, 0));
//    points.add(Offset(size.width, size.height));
//
//    canvas.drawPath(
//      Path()..addPolygon(points, false),
//      line,
//    );
//
////    Offset center = new Offset(size.width / 2, size.height / 2);
////    double radius = min(size.width / 2, size.height / 2);
////    canvas.drawCircle(center, radius, line);
////    double arcAngle = 2 * pi * (completePercent / 100);
////    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -pi / 2,
////        arcAngle, false, complete);
//  }
//
//  @override
//  bool shouldRepaint(CustomPainter oldDelegate) {
//    return true;
//  }
//}
