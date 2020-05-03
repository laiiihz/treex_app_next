import 'package:flutter/cupertino.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/UI/tools/cupertino_tools_button.dart';
import 'package:treex_app_next/generated/l10n.dart';

class HomeViewIOS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeViewIOS> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: buildCupertinoTitle(context, S.of(context).homeView),
          trailing: CupertinoToolsButton(),
        ),
      ],
    );
  }
}
