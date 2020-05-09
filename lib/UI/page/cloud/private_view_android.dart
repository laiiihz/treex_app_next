import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:treex_app_next/UI/page/cloud/tool/more_tools.dart';
import 'package:treex_app_next/generated/l10n.dart';

class PrivateViewAndroid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PrivateViewAndroidState();
}

class _PrivateViewAndroidState extends State<PrivateViewAndroid> {
  bool _showList = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        child: Icon(MaterialCommunityIcons.filter),
        onPressed: () {
          Navigator.of(context, nullOk: false).push(
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: MoreTools(
                    heroTag: 'fab',
                    onChanged: (value) {
                      setState(() {
                        _showList = value;
                      });
                    },
                    initValue: _showList,
                  ),
                );
              },
            ),
          );
        },
      ),
      appBar: AppBar(
        title: Text(S.of(context).privateFiles),
        actions: <Widget>[
          Hero(
            tag: 'private_store',
            child: Icon(Icons.dns),
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
