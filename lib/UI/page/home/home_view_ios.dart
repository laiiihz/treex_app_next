import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_icon_button.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/UI/page/views/transfer/transfer_download_view_ios.dart';
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
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CupertinoIconButton(
                icon: MaterialCommunityIcons.progress_download,
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(
                      builder: (context) => TransferDownloadViewIOS(
                        previous: S.of(context).homeView,
                      ),
                    ),
                  );
                },
              ),
              CupertinoToolsButton(),
            ],
          ),
        ),
      ],
    );
  }
}
