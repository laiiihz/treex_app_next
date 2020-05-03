import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/provider/app_provider.dart';

import 'color_palettes.dart';

///global app theme
///
/// * Material App theme data
///
/// * global color palettes
///
/// ┝ primaryColor
///
/// ┕ secondaryColor
class AppTheme {
  BuildContext context;
  AP ap;
  AppTheme(this.context) {
    ap = Provider.of<AP>(context);
  }
  FloatingActionButtonThemeData _fabTheme() => FloatingActionButtonThemeData(
        backgroundColor: getSecondary(),
        shape: RoundedRectangleBorder(
          borderRadius: UU.widgetBorderRadius(),
        ),
      );
  ThemeData themeDataDark() => ThemeData.dark().copyWith(
        primaryColor: CP.primaryDark,
        floatingActionButtonTheme: _fabTheme(),
        platform: ap.targetPlatform,
      );

  ThemeData themeDataLight() => ThemeData.light().copyWith(
        primaryColor: CP.primary,
        floatingActionButtonTheme: _fabTheme(),
        platform: ap.targetPlatform,
      );
  Color getPrimary({bool reverse = false}) {
    if (reverse) {
      return isDark(context) ? CP.primaryDark : CP.primary;
    }
    return isDark(context) ? CP.primary : CP.primaryDark;
  }

  Color getSecondary() => isDark(context) ? CP.secondaryDark : CP.secondary;
}
