import 'package:flutter/material.dart';
import 'package:treex_app_next/Utils/ui_util.dart';

class Logo extends StatefulWidget {
  Logo({
    Key key,
    this.standard = false,
  }) : super(key: key);
  final bool standard;
  @override
  State<StatefulWidget> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: widget.standard ? 25 : 60,
        ),
        children: [
          TextSpan(
            text: 'Tree',
            style: TextStyle(
              color: isDark(context) ? Colors.white70 : Colors.black87,
              fontWeight: isDark(context) ? FontWeight.w300 : FontWeight.w500,
            ),
          ),
          TextSpan(
            text: 'x',
            style: TextStyle(
              color: Colors.red,
              fontWeight: isDark(context) ? FontWeight.w700 : FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
