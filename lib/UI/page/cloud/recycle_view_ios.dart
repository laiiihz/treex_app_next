import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as md;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_icon_button.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/Utils/network/network_list.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/static/color_palettes.dart';

class RecycleViewIOS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecycleViewIOSState();
}

class _RecycleViewIOSState extends State<RecycleViewIOS> {
  List<RecycleEntity> _recycleList = [];

  @override
  void initState() {
    super.initState();
    _updateRecycle();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CP.cupertinoBG(context),
        middle: buildCupertinoTitle(context, S.of(context).recycleBin),
        previousPageTitle: S.of(context).cloudView,
        trailing: CupertinoIconButton(
          icon: MaterialCommunityIcons.delete_circle_outline,
          onPressed: _deleteRecycle,
        ),
      ),
      child: md.Material(
        child: LiquidPullToRefresh(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 50),
            itemBuilder: (BuildContext context, int index) {
              return md.ListTile(
                title: Text(_recycleList[index].name),
                subtitle: Text(
                  _recycleList[index].path,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
              );
            },
            itemCount: _recycleList.length,
          ),
          onRefresh: _updateRecycle,
        ),
      ),
    );
  }

  Future _updateRecycle() async {
    await NetworkList(context: context).recycle().then((value) {
      setState(() {
        _recycleList = value;
      });
    });
  }

  Future _deleteRecycle() async {
    await NetworkList(context: context).clearRecycle();
  }
}
