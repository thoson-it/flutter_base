import 'package:flutter/material.dart';

class AppImages {
  AppImages._(); // this basically makes it so you can instantiate this class
  //Commons
  static const icSettingKey = "assets/images/commons/ic_setting.png";

  static Image image(String key) {
    return Image.asset(key);
  }
}
