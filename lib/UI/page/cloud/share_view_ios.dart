import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as md;
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/UI/page/cloud/tool/more_tools_ios.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/static/color_palettes.dart';

class ShareViewIOS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShareViewIOSState();
}

class _ShareViewIOSState extends State<ShareViewIOS> {
  int _nowIndex = 0;
  bool _showTool = true;
  double _startY = 0;
  final _listKey = UniqueKey();
  final _gridKey = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor:
            isDark(context) ? CP.cupertinoBGDark : CP.cupertinoBGLight,
        middle: buildCupertinoTitle(context, S.of(context).share_files),
        previousPageTitle: S.of(context).share_files,
      ),
      child: Listener(
        onPointerDown: (event) {
          _startY = event.position.dy;
        },
        onPointerUp: (event) {
          double temp = event.position.dy;
          setState(() {
            if ((temp - _startY).abs() > 100) {
              _showTool = (temp - _startY) > 0;
            }
          });
        },
        child: md.Material(
          color: md.Colors.transparent,
          child: Stack(
            children: <Widget>[
              PageTransitionSwitcher(
                transitionBuilder: (Widget child,
                    Animation<double> primaryAnimation,
                    Animation<double> secondaryAnimation) {
                  return SharedAxisTransition(
                    animation: primaryAnimation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                    child: child,
                  );
                },
                child: _nowIndex == 0
                    ? Container(
                        key: _listKey,
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 50),
                          itemBuilder: (BuildContext context, int index) {
                            return Text('test');
                          },
                        ),
                      )
                    : Container(
                        key: _gridKey,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          padding: EdgeInsets.only(top: 50),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Text('test'),
                            );
                          },
                        ),
                      ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 600),
                curve: Curves.easeInOutCubic,
                top: _showTool ? 0 : -50,
                left: 0,
                right: 0,
                child: MoreToolsIOS(
                  onChanged: (value) {
                    setState(() {
                      _nowIndex = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
