import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/UI/page/cloud/tool/bottom_tools_ios.dart';
import 'package:treex_app_next/UI/page/cloud/tool/more_tools_ios.dart';
import 'package:treex_app_next/UI/page/cloud/widget/file_widget.dart';
import 'package:treex_app_next/Utils/file_util.dart';
import 'package:treex_app_next/Utils/network/network_list.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/static/color_palettes.dart';
import 'package:flutter/material.dart' as md;

class CloudStorageViewIOS extends StatefulWidget {
  CloudStorageViewIOS({
    Key key,
    @required this.icon,
    @required this.name,
    @required this.share,
  }) : super(key: key);
  final String name;
  final bool share;
  final IconData icon;
  @override
  State<StatefulWidget> createState() => _CloudStorageViewIOSState();
}

class _CloudStorageViewIOSState extends State<CloudStorageViewIOS> {
  int _nowIndex = 0;
  bool _showTool = true;
  double _startY = 0;
  Key _key = UniqueKey();

  List<NTLEntity> _files = [];
  bool _loading = false;

  ScrollController _scrollController = ScrollController();

  List<PathEntity> _pathStack = [
    PathEntity(name: 'root', parent: '.', path: '.'),
  ];

  @override
  void initState() {
    super.initState();
    _updateFile();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CP.cupertinoBG(context),
        middle: buildCupertinoTitle(context, widget.name),
        previousPageTitle: S.of(context).cloudView,
        trailing: _loading ? md.CircularProgressIndicator() : SizedBox(),
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
              LiquidPullToRefresh(
                child: PageTransitionSwitcher(
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
                  child: Builder(
                    key: _key,
                    builder: (BuildContext context) {
                      return _nowIndex == 0
                          ? Container(
                              child: ListView.builder(
                                padding: EdgeInsets.only(
                                  top: _showTool ? 100 : 0,
                                  bottom: 100,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return FileWidget(
                                    entity: _files[index],
                                    onPressed: () {
                                      _onTap(index);
                                    },
                                    share: widget.share,
                                  );
                                },
                                itemCount: _files.length,
                              ),
                            )
                          : Container(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                padding: EdgeInsets.only(
                                  top: _showTool ? 100 : 0,
                                  bottom: 100,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return FileWidget(
                                    entity: _files[index],
                                    isGrid: true,
                                    onPressed: () {
                                      _onTap(index);
                                    },
                                    share: widget.share,
                                  );
                                },
                                itemCount: _files.length,
                              ),
                            );
                    },
                  ),
                ),
                onRefresh: () async => await _updateFile(),
                springAnimationDurationInMilliseconds: 300,
                showChildOpacityTransition: false,
                color: CP.cupertinoBG(context),
                backgroundColor: CP.cupertinoBG(context, reverse: true),
                height: 150,
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 600),
                curve: Curves.easeInOutCubic,
                top: _showTool ? 0 : -50,
                left: 0,
                right: 0,
                child: MoreToolsIOS(
                  onChanged: (value) {
                    _nowIndex = value;
                    setState(() {
                      _key = UniqueKey();
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
              AnimatedPositioned(
                top: _showTool ? 40 : -60,
                left: 0,
                right: 0,
                curve: Curves.easeInOutCirc,
                duration: Duration(milliseconds: 500),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: md.Material(
                        color: md.Colors.transparent,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: CP
                                .cupertinoBG(context, reverse: true)
                                .withAlpha(20),
                          ),
                          child: ListView.builder(
                            physics: MIUIScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController,
                            itemBuilder: (BuildContext context, int index) {
                              return md.FlatButton(
                                child: Text(_pathStack[index].name),
                                onPressed: () {
                                  _updatePath();
                                  for (int i = 0; i < index; i++) {
                                    _pathStack.removeAt(0);
                                  }
                                  _updateFile();
                                },
                              );
                            },
                            itemCount: _pathStack.length,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _updateFile() async {
    setState(() {
      _loading = true;
    });
    await NetworkList(context: context)
        .getFile(widget.share ? 'share' : 'file', path: _pathStack[0].path)
        .then((list) {
      _files = list;
      _loading = false;
      _key = UniqueKey();
      setState(() {});
    });
  }

  _onTap(int index) {
    _updatePath();
    if (_files[index].isDir) {
      _pathStack.insert(
          0,
          PathEntity(
            name: _files[index].name,
            path: _files[index].path,
            parent: FileUtil.getNetworkPathParent(_files[index].path),
          ));
      _updateFile();
    }
  }

  _updatePath() {
    _scrollController.animateTo(
      -20,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }
}
