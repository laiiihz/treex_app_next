import 'package:flutter/cupertino.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/generated/l10n.dart';

class RecycleViewIOS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecycleViewIOSState();
}

class _RecycleViewIOSState extends State<RecycleViewIOS> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: buildCupertinoTitle(context, S.of(context).recycle_bin),
          ),
        ],
      ),
    );
  }
}
