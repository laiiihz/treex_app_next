import 'package:flutter/cupertino.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/generated/l10n.dart';

class PrivateViewIOS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PrivateViewIOSState();
}

class _PrivateViewIOSState extends State<PrivateViewIOS> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: buildCupertinoTitle(context, S.of(context).private_files),
          ),
        ],
      ),
    );
  }
}
