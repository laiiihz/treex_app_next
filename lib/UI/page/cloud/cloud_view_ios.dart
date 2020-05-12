import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/UI/page/cloud/cloud_storage_view_ios.dart';
import 'package:treex_app_next/UI/page/cloud/cloud_subviews.dart';
import 'package:treex_app_next/UI/tools/cupertino_tools_button.dart';
import 'package:treex_app_next/generated/l10n.dart';

class CloudViewIOS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CloudViewState();
}

class _CloudViewState extends State<CloudViewIOS> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: buildCupertinoTitle(context, S.of(context).cloudView),
          trailing: CupertinoToolsButton(),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            _buildFileButton(
              text: S.of(context).shareFiles,
              view: CloudStorageViewIOS(
                share: true,
                icon: Icons.inbox,
                name: S.of(context).shareFiles,
              ),
              icon: Icons.inbox,
            ),
            _buildFileButton(
              text: S.of(context).privateFiles,
              view: CloudStorageViewIOS(
                share: false,
                icon: Icons.dns,
                name: S.of(context).privateFiles,
              ),
              icon: Icons.dns,
            ),
            _buildFileButton(
              text: S.of(context).recycleBin,
              view: RecycleView(),
              icon: Icons.delete_outline,
            ),
          ]),
        ),
      ],
    );
  }

  _buildFileButton({String text, Widget view, IconData icon}) {
    return CupertinoButton(
      child: Row(
        children: <Widget>[
          Icon(icon),
          SizedBox(width: 20),
          Text(text),
        ],
      ),
      onPressed: () {
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => view),
        );
      },
    );
  }
}
