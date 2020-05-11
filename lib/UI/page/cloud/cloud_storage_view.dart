import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:treex_app_next/UI/page/cloud/tool/more_tools.dart';
import 'package:treex_app_next/UI/page/cloud/widget/file_widget.dart';
import 'package:treex_app_next/Utils/file_util.dart';
import 'package:treex_app_next/Utils/network/network_list.dart';
import 'package:treex_app_next/generated/l10n.dart';

class CloudStorageView extends StatefulWidget {
  CloudStorageView({
    Key key,
    @required this.heroTag,
    @required this.icon,
    @required this.name,
    @required this.type,
  }) : super(key: key);
  final String name;
  final String type;
  final String heroTag;
  final IconData icon;
  @override
  State<StatefulWidget> createState() => _CloudStorageViewState();
}

class _CloudStorageViewState extends State<CloudStorageView> {
  bool _showList = true;
  List<NTLEntity> _files = [];
  bool _loading = false;
  Key _key = UniqueKey();
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
                        _key = UniqueKey();
                        _showList = value;
                      });
                    },
                    initValue: _showList,
                    path: '.',
                  ),
                );
              },
            ),
          );
        },
      ),
      appBar: AppBar(
        title: Text(widget.name),
        bottom: PreferredSize(
          child: Container(
            height: 40,
            child: ListView.builder(
              physics: MIUIScrollPhysics(),
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return FlatButton(
                  onPressed: () {
                    _updatePath();
                    for (int i = 0; i < index; i++) {
                      _pathStack.removeAt(0);
                    }
                    _updateFile();
                  },
                  child: Text(_pathStack[index].name),
                );
              },
              itemCount: _pathStack.length,
            ),
          ),
          preferredSize: Size.fromHeight(40),
        ),
        actions: <Widget>[
          Hero(
            tag: widget.heroTag,
            child: Center(
              child: AnimatedCrossFade(
                firstChild: Icon(widget.icon),
                secondChild: CircularProgressIndicator(),
                crossFadeState: _loading
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: Duration(milliseconds: 1000),
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: WillPopScope(
        child: LiquidPullToRefresh(
          child: PageTransitionSwitcher(
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
            child: Builder(
              key: _key,
              builder: (BuildContext context) {
                return _files.length == 0
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              MaterialCommunityIcons.inbox,
                              size: 50,
                            ),
                            SizedBox(height: 20),
                            Text(S.of(context).emptyFolder),
                          ],
                        ),
                      )
                    : _showList
                        ? ListView.builder(
                            physics: MIUIScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return FileWidget(
                                entity: _files[index],
                                onPressed: () {
                                  _onTap(index);
                                },
                                share: widget.type == 'share',
                              );
                            },
                            itemCount: _files.length,
                          )
                        : GridView.builder(
                            physics: MIUIScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (BuildContext context, int index) {
                              return FileWidget(
                                entity: _files[index],
                                isGrid: true,
                                onPressed: () {
                                  _onTap(index);
                                },
                                share: widget.type == 'share',
                              );
                            },
                            itemCount: _files.length,
                          );
              },
            ),
          ),
          onRefresh: () async => await _updateFile(),
          springAnimationDurationInMilliseconds: 300,
          showChildOpacityTransition: false,
          color: Theme.of(context).primaryColor,
        ),
        onWillPop: () async {
          _pathStack.removeAt(0);
          if (_pathStack.length == 0)
            return true;
          else {
            await _updateFile();
            return false;
          }
        },
      ),
    );
  }

  _updateFile() async {
    setState(() => _loading = true);
    await NetworkList(context: context)
        .getFile(widget.type, path: _pathStack[0].path)
        .then((list) {
      setState(() {
        _key = UniqueKey();
        _loading = false;
        _files = list;
      });
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
