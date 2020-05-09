import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app_next/UI/global_widget/logo.dart';
import 'package:treex_app_next/UI/global_widget/treex_notification.dart';
import 'package:treex_app_next/UI/tools/app_search_tool.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: MIUIScrollPhysics(),
      key: UniqueKey(),
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200,
          floating: true,
          pinned: true,
          stretch: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(MaterialCommunityIcons.progress_download),
              onPressed: () {
                Navigator.of(context).pushNamed('transfer/download');
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (BuildContext context, Animation animation,
                        Animation secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: AppSearchTool(),
                      );
                    },
                  ),
                );
              },
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            title: Logo(
              standard: true,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Placeholder(),
        ),
      ],
    );
  }
}
