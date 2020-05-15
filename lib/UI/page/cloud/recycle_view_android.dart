import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:treex_app_next/Utils/network/network_list.dart';
import 'package:treex_app_next/generated/l10n.dart';

class RecycleViewAndroid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecycleViewAndroidState();
}

class _RecycleViewAndroidState extends State<RecycleViewAndroid> {
  bool _showList = true;
  List<RecycleEntity> _recycleList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).recycleBin),
        actions: <Widget>[
          Hero(
            tag: 'recycle_bin',
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: _deleteRecycle,
              ),
            ),
          ),
        ],
      ),
      body: LiquidPullToRefresh(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_recycleList[index].name),
              subtitle: Text(_recycleList[index].path),
            );
          },
          itemCount: _recycleList.length,
        ),
        onRefresh: _updateRecycle,
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
