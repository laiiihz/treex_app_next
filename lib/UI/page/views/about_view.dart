import 'package:flutter/cupertino.dart' as c;
import 'package:flutter/material.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';

class AboutView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return isIOS(context)
        ? c.CupertinoPageScaffold(
            child: c.CustomScrollView(
              slivers: <Widget>[
                c.CupertinoSliverNavigationBar(
                  largeTitle: buildCupertinoTitle(context, S.of(context).about),
                ),
              ],
            ),
          )
        : Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(S.of(context).about),
                  ),
                ),
              ],
            ),
          );
  }
}
