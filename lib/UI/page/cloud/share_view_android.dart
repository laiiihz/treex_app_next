import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
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
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(MaterialCommunityIcons.inbox),
            ),
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
              ),
      ),
    );
  }

  _updateFile() {
    NetworkList(context: context).getFile('share').then((list) {
      setState(() {
        _files = list;
      });
    });
  }
}
