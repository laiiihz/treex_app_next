import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as c;
import 'package:treex_app_next/Utils/ui_util.dart';

class TransferDownloadView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransferDownloadViewState();
}

class _TransferDownloadViewState extends State<TransferDownloadView> {
  @override
  Widget build(BuildContext context) {
    return isIOS(context)
        ? c.CupertinoPageScaffold(
            child: CustomScrollView(
              slivers: <Widget>[
                c.CupertinoSliverNavigationBar(),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(),
          );
  }
}
