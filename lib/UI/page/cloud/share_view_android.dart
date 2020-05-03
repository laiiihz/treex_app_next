import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app_next/UI/page/cloud/tool/more_tools.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/UI/global_widget/app_bar_big_icon.dart';

class ShareViewAndroid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShareViewAndroidState();
}

class _ShareViewAndroidState extends State<ShareViewAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'share',
        onPressed: () {
          Navigator.of(context, nullOk: false).push(
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: MoreTools(
                    heroTag: 'share',
                  ),
                );
              },
            ),
          );
        },
      ),
      body: CustomScrollView(
        physics: MIUIScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(S.of(context).share_files),
              background: AppBarBigIcon(
                icon: Icons.inbox,
                tag: 'share_store',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
