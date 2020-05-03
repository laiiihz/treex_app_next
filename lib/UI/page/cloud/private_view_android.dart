import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/UI/global_widget/app_bar_big_icon.dart';

class PrivateViewAndroid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PrivateViewAndroidState();
}

class _PrivateViewAndroidState extends State<PrivateViewAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        height: 150,
        springAnimationDurationInMilliseconds: 500,
        color: Colors.black26,
        showChildOpacityTransition: false,
        child: CustomScrollView(
          physics: MIUIScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              stretch: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(S.of(context).private_files),
                background: AppBarBigIcon(
                  icon: Icons.dns,
                  tag: 'private_store',
                ),
              ),
            ),
          ],
        ),
        onRefresh: () async {},
      ),
    );
  }
}
