import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app_next/UI/global_widget/icon_with_text.dart';
import 'package:treex_app_next/UI/page/cloud/cloud_storage_view.dart';
import 'package:treex_app_next/UI/tools/app_search_tool.dart';
import 'package:treex_app_next/generated/l10n.dart';

class CloudView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CloudViewState();
}

class _CloudViewState extends State<CloudView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: MIUIScrollPhysics(),
      key: UniqueKey(),
      slivers: <Widget>[
        SliverAppBar(
          floating: true,
          stretch: true,
          pinned: true,
          expandedHeight: 200,
          title: Text(S.of(context).cloudView),
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: EdgeInsets.all(10),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconWithText(
                          child: Hero(
                            tag: 'share_store',
                            child: Icon(Icons.inbox),
                          ),
                          text: S.of(context).shareFiles,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CloudStorageView(
                                heroTag: 'share_store',
                                icon: Icons.inbox,
                                name: S.of(context).shareFiles,
                                share: true,
                              ),
                            ));
                          },
                        ),
                        IconWithText(
                          child: Hero(
                            tag: 'private_store',
                            child: Icon(Icons.dns),
                          ),
                          text: S.of(context).privateFiles,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CloudStorageView(
                                heroTag: 'private_store',
                                icon: Icons.dns,
                                name: S.of(context).privateFiles,
                                share: false,
                              ),
                            ));
                          },
                        ),
                        IconWithText(
                          child: Hero(
                            tag: 'recycle_bin',
                            child: Icon(Icons.delete_outline),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('cloud/recycle');
                          },
                          text: S.of(context).recycleBin,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
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
        ),
      ],
    );
  }
}
