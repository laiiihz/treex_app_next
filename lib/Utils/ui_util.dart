import 'dart:math';

import 'package:flutter/material.dart';

///get app brightness
bool isDark(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

bool isIOS(BuildContext context) {
  return Theme.of(context).platform == TargetPlatform.iOS;
}

FontWeight getFontWeight(BuildContext context) {
  return isDark(context) ? FontWeight.w200 : FontWeight.w900;
}

///UI Utils
class UU {
  ///login Text Field Input Decoration
  static loginTFDecoration(BuildContext context) {
    return InputDecoration(
      filled: true,
      fillColor: isDark(context) ? Colors.white12 : Colors.black12,
    );
  }

  static widgetBorderRadius() {
    return BorderRadius.only(
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15),
      bottomRight: Radius.circular(15),
    );
  }

  static genDarkColor() {
    return Color(0xff000000 + Random().nextInt(0x666666));
  }
}
