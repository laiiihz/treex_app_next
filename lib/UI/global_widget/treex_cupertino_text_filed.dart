import 'package:flutter/cupertino.dart';
import 'package:treex_app_next/Utils/ui_util.dart';

typedef EditCallBack = Function(String value);

class TreexCupertinoTextFiledIOS extends CupertinoTextField {
  TreexCupertinoTextFiledIOS({
    BuildContext context,
    String placeholder,
    TextStyle textStyle,
    TextEditingController controller,
    Widget prefix,
    Widget suffix,
    VoidCallback onEditingComplete,
    EditCallBack onChanged,
    FocusNode focusNode,
    bool obscureText = false,
    bool light = false,
  }) : super(
          style: TextStyle(
            color:
                isDark(context) ? CupertinoColors.white : CupertinoColors.black,
          ),
          controller: controller,
          placeholder: placeholder,
          onEditingComplete: onEditingComplete,
          prefix: prefix,
          suffix: suffix,
          obscureText: obscureText,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: UU.widgetBorderRadius(),
            color: isDark(context)
                ? CupertinoColors.black.withAlpha(100)
                : light
                    ? CupertinoColors.black.withAlpha(25)
                    : CupertinoColors.white.withAlpha(100),
          ),
          focusNode: focusNode,
          onChanged: onChanged,
        );
}
