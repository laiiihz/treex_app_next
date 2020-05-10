import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as md;
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/UI/page/cloud/tool/bottom_tools_ios.dart';
import 'package:treex_app_next/UI/page/cloud/tool/more_tools_ios.dart';
import 'package:treex_app_next/UI/page/cloud/widget/file_widget.dart';
import 'package:treex_app_next/Utils/network/network_list.dart';
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
  Key _listKey = UniqueKey();
  Key _gridKey = UniqueKey();

  List<NTLEntity> _files = [];
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    _updateFile('.');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CP.cupertinoBG(context),
        middle: buildCupertinoTitle(context, S.of(context).shareFiles),
        previousPageTitle: S.of(context).shareFiles,
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
                            return FileWidget(entity: _files[index]);
                          },
                          itemCount: _files.length,
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
                            return FileWidget(
                              entity: _files[index],
                              isGrid: true,
                            );
                          },
                          itemCount: _files.length,
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
              AnimatedPositioned(
                child: BottomToolsIOS(),
                bottom: _showTool ? 50 : -10,
                left: 0,
                right: 0,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOutCirc,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _updateFile(String path) async {
    setState(() => _loading = true);
    await NetworkList(context: context)
        .getFile('share', path: path)
        .then((list) {
      setState(() {
        _gridKey = UniqueKey();
        _listKey = UniqueKey();
        _loading = false;
        _files = list;
      });
    });
  }
}
