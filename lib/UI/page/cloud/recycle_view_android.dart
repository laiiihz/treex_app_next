import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/UI/global_widget/app_bar_big_icon.dart';

class RecycleViewAndroid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecycleViewAndroidState();
}

class _RecycleViewAndroidState extends State<RecycleViewAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: MIUIScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(S.of(context).recycle_bin),
              background: AppBarBigIcon(
                icon: Icons.delete,
                tag: 'recycle_bin',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
