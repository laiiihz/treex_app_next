import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:treex_app_next/Utils/ui_util.dart';

class TreexCupertinoBottomBar extends StatelessWidget {
  TreexCupertinoBottomBar({Key key, @required this.children}) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: isDark(context)
                ? CupertinoColors.black.withAlpha(100)
                : CupertinoColors.white.withAlpha(100),
            border: Border(
              top: BorderSide(
                color: isDark(context)
                    ? CupertinoColors.white.withAlpha(50)
                    : CupertinoColors.black.withAlpha(50),
              ),
            ),
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            children: this.children,
          ),
        ),
      ),
    );
  }
}
