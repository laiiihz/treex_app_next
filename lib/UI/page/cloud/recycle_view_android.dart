import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:treex_app_next/generated/l10n.dart';

class RecycleViewAndroid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecycleViewAndroidState();
}

class _RecycleViewAndroidState extends State<RecycleViewAndroid> {
  bool _showList = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        child: Icon(MaterialCommunityIcons.filter),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: Text(S.of(context).recycleBin),
        actions: <Widget>[
          Hero(
            tag: 'recycle_bin',
            child: Icon(Icons.delete),
          ),
        ],
      ),
      body: PageTransitionSwitcher(
        reverse: _showList,
        transitionBuilder: (Widget child, Animation primaryAnimation,
            Animation secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.scaled,
            child: child,
          );
        },
        child: _showList
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Text('test');
                },
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return Text(index.toString());
                },
              ),
      ),
    );
  }
}
