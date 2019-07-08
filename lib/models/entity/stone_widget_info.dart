import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_base/models/entity/product_entity.dart';

class StoneWidgetInfo {
  //Số thứ tự
  int index = 0;

  //Góc chiếm giữ bởi item trên vòng
  double occupyAngle = 0;

  //Vị trí hiện tại của item
  Offset position = Offset(0, 0);

  //Vị trí trước đó item sẽ di chuyển tới
  Offset oldPosition = Offset(0, 0);

  //Góc của item so với container đang chứa
  double angleInParent = 0;

  //Góc trước đó của item so với container đang chứa
  double oldAngleInParent = 0;

  //Ảnh của item
  Image image;

  //Bán kính của item
  double radius = 20.0;

  //Bán kính của item tren app
  double radiusInApp = 0;

  //Bán kính của item tới tâm của vòng tay
  double radiusToCenter = 100;

  //Ban kính của item tới tâm trên app
  double radiusToCenterInApp = 0;

  //Góc của item trên màn hình
  double angleInScreen = 0;
  Size parentSize = Size(0, 0);

  ProductEntity productEntity;

  void generatePosition(double braceletRadiusInScreen) {
    radiusToCenterInApp = braceletRadiusInScreen;
    radiusInApp = radius / radiusToCenter * radiusToCenterInApp;
    //
    occupyAngle = 4 * asin(radius / 2 / radiusToCenter);

    position = Offset(
          radiusToCenterInApp * cos(angleInParent),
          radiusToCenterInApp * sin(angleInParent),
        ) +
        Offset(parentSize.width / 2, parentSize.height / 2);

    oldPosition = Offset(
          radiusToCenterInApp * cos(oldAngleInParent),
          radiusToCenterInApp * sin(oldAngleInParent),
        ) +
        Offset(parentSize.width / 2, parentSize.height / 2);

    print('$angleInParent $position');
  }
}
