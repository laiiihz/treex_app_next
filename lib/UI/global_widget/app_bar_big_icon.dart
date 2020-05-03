import 'package:flutter/material.dart';
import 'package:treex_app_next/Utils/ui_util.dart';

///BigIcon
class AppBarBigIcon extends StatelessWidget {
  AppBarBigIcon({
    Key key,
    @required this.icon,
    @required this.tag,
  }) : super(key: key);
  final IconData icon;
  final String tag;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0.9, 1),
      child: Hero(
        tag: this.tag,
        child: Icon(
          icon,
          size: 150,
          color: isDark(context) ? Colors.white38 : Colors.black38,
        ),
      ),
    );
  }
}
