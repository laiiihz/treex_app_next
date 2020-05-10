import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:treex_app_next/UI/page/cloud/tool/more_tools.dart';
import 'package:treex_app_next/UI/page/cloud/widget/file_widget.dart';
import 'package:treex_app_next/Utils/network/network_list.dart';
import 'package:treex_app_next/generated/l10n.dart';

class ShareViewAndroid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShareViewAndroidState();
}

class _ShareViewAndroidState extends State<ShareViewAndroid> {
  bool _showList = true;
  List<NTLEntity> _files = [];
  bool _loading = false;
  Key _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    _updateFile('.');
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
                  ),
                );
              },
            ),
          );
        },
      ),
      appBar: AppBar(
        title: Text(S.of(context).shareFiles),
        actions: <Widget>[
          Hero(
            tag: 'share_store',
            child: Center(
              child: AnimatedCrossFade(
                firstChild: Icon(MaterialCommunityIcons.inbox),
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
      body: LiquidPullToRefresh(
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
              return _showList
                  ? ListView.builder(
                      physics: MIUIScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return FileWidget(entity: _files[index]);
                      },
                      itemCount: _files.length,
                    )
                  : GridView.builder(
                      physics: MIUIScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return FileWidget(
                          entity: _files[index],
                          isGrid: true,
                        );
                      },
                      itemCount: _files.length,
                    );
            },
          ),
        ),
        onRefresh: () async => await _updateFile('.'),
        springAnimationDurationInMilliseconds: 300,
        showChildOpacityTransition: false,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  _updateFile(String path) async {
    setState(() => _loading = true);
    await NetworkList(context: context)
        .getFile('share', path: path)
        .then((list) {
      setState(() {
        _key = UniqueKey();
        _loading = false;
        _files = list;
      });
    });
  }
}
