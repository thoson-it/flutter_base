import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can instantiate this class

  static const _blackPrimaryValue = 0xFF0084ef;
  static const _pinkColorValue = 0xFFe1116c;
  static const _lightGrayValue = 0xA0e0e0e0;
  static const _grayValue = 0xA09e9e9e;
  static const _transparentGrayValue = 0xA0757575;
  static const _blueColorValue = 0xFF0084ef;
  static const _transparentGreenValue = 0xA000e676;
  static const _transparentBlackValue = 0xa0000000;
  static const _orangeColorValue = 0xFFd85456;
  static const _lightOrangeColorValue = 0xFFffd1d1;
  static const _lighterOrangeColorValue = 0xFFffeded;
  static const _lightPinkColorValue = 0xFFffd0da;
  static const _backgroundColorValue = 0xFFfafafa;

  static const Color mainColor = Color(_blackPrimaryValue);
  static const Color pinkColor = Color(_pinkColorValue);
  static const Color lightGrayColor = Color(_lightGrayValue);
  static const Color grayColor = Color(_grayValue);
  static const Color transparentGrayColor = Color(_transparentGrayValue);
  static const Color blueColor = Color(_blueColorValue);
  static const Color transparentGreenColor = Color(_transparentGreenValue);
  static const Color transparentBlackColor = Color(_transparentBlackValue);
  static const Color orangeColor = Color(_orangeColorValue);
  static const Color lightOrangeColor = Color(_lightOrangeColorValue);
  static const Color lighterOrangeColor = Color(_lighterOrangeColorValue);
  static const Color lightPinkColor = Color(_lightPinkColorValue);
  static const Color backgroundColor = Color(_backgroundColorValue);

  static Color fromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
