import 'package:flutter/cupertino.dart';

class DownloadViewIOS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DownloadViewIOSState();
}

class _DownloadViewIOSState extends State<DownloadViewIOS> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(),
        ],
      ),
    );
  }
}
