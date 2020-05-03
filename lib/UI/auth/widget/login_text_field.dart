import 'package:flutter/material.dart';
import 'package:treex_app_next/Utils/ui_util.dart';


///TextField Styles
class TF {
  ///Text Filed Filled Color
  static Color fillColor(BuildContext context) =>
      isDark(context) ? Colors.white12 : Colors.black12;

  static border() => OutlineInputBorder(
        borderRadius: UU.widgetBorderRadius(),
      );
}
