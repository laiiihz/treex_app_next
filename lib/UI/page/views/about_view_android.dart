import 'package:flutter/material.dart';
import 'package:treex_app_next/generated/l10n.dart';

class AboutViewAndroid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutViewAndroidState();
}

class _AboutViewAndroidState extends State<AboutViewAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
