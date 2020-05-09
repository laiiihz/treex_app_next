import 'package:flutter/material.dart';
import 'package:treex_app_next/Utils/ui_util.dart';

///Color palettes
///
///config Color palettes
class CP {
  ///应用主色调
  static Color primary = Colors.blue[500];

  ///应用暗色主色调
  static Color primaryDark = Colors.blue[900];

  ///应用强调色
  static Color secondary = Colors.pink[500];

  ///应用暗色强调色
  static Color secondaryDark = Colors.pink[700];

  ///应用品牌色
  static Color brandRed = Colors.red;

  static Color _warn = Colors.red;
  static Color _success = Colors.green;
  static Color _info = Colors.yellow;
  static Color _fail = Colors.pink;

  static Color _warnDark = Colors.red[800];
  static Color _successDark = Colors.green[800];
  static Color _infoDark = Colors.yellow[800];
  static Color _failDark = Colors.pink[600];

  static Color _cupertinoBGLight = Color(0xFFF9F9F9);
  static Color _cupertinoBGDark = Color(0xFF1D1D1D);
  static Color cupertinoBG(BuildContext context) =>
      isDark(context) ? _cupertinoBGDark : _cupertinoBGLight;

  static warn(BuildContext context) => isDark(context) ? _warnDark : _warn;
  static success(BuildContext context) =>
      isDark(context) ? _successDark : _success;
  static info(BuildContext context) => isDark(context) ? _infoDark : _info;
  static fail(BuildContext context) => isDark(context) ? _failDark : _fail;
}
