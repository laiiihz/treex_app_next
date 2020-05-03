import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app_next/UI/global_widget/icon_with_text.dart';
import 'package:treex_app_next/generated/l10n.dart';

class CloudView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CloudViewState();
}

class _CloudViewState extends State<CloudView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: MIUIScrollPhysics(),
      key: UniqueKey(),
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200,
          title: Text('title'),
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
                          text: S.of(context).share_files,
                          onTap: () {
                            Navigator.of(context).pushNamed('cloud/share');
                          },
                        ),
                        IconWithText(
                          child: Hero(
                            tag: 'private_store',
                            child: Icon(Icons.dns),
                          ),
                          text: S.of(context).private_files,
                          onTap: () {
                            Navigator.of(context).pushNamed('cloud/private');
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
                          text: S.of(context).recycle_bin,
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
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
