import 'package:flutter/cupertino.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_icon_button.dart';
import 'package:treex_app_next/UI/tools/tools_page.dart';

class CupertinoToolsButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CupertinoToolsButtonState();
}

class _CupertinoToolsButtonState extends State<CupertinoToolsButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoIconButton(
      icon: CupertinoIcons.add_circled,
      onPressed: () {
        Navigator.of(
          context,
          rootNavigator: true,
        ).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) {
              return ToolsPage();
            },
          ),
        );
      },
    );
  }
}
