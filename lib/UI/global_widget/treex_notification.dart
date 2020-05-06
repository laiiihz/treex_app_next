import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/static/color_palettes.dart';

enum StatusType {
  SUCCESS,
  FAIL,
  INFO,
  WARN,
  NULL,
}

Map<StatusType, Color> statusColor = {
  StatusType.SUCCESS: CP.success,
  StatusType.FAIL: CP.fail,
  StatusType.INFO: CP.info,
  StatusType.WARN: CP.warn,
  StatusType.NULL: Colors.black26,
};

Map<StatusType, Color> statusColorDark = {
  StatusType.SUCCESS: CP.successDark,
  StatusType.FAIL: CP.failDark,
  StatusType.INFO: CP.infoDark,
  StatusType.WARN: CP.warnDark,
  StatusType.NULL: Colors.white24,
};

///showToastNotification
showTN(
  BuildContext context, {
  @required String title,
  StatusType type = StatusType.NULL,
  @required IconData icon,
  Color color,
}) {
  BotToast.showCustomNotification(
    toastBuilder: (_) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              color: color == null
                  ? isDark(context) ? Colors.black54 : Colors.white54
                  : color,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDark(context)
                          ? statusColorDark[type]
                          : statusColor[type],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      icon,
                      color: isDark(context) ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    title,
                    style: TextStyle(
                      color: isDark(context) ? Colors.white70 : Colors.black87,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

showLoading(BuildContext context) {
  BotToast.showCustomLoading(
    toastBuilder: (_) {
      return isIOS(context)
          ? CupertinoActivityIndicator()
          : CircularProgressIndicator();
    },
    wrapAnimation: (animation, _, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    wrapToastAnimation: (animation, _, child) {
      return ScaleTransition(
        scale: animation,
        child: child,
      );
    },
  );
}

closeLoading() {
  BotToast.closeAllLoading();
}
