import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';

class ShareList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShareListState();
}

class _ShareListState extends State<ShareList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: UniqueKey(),
      physics: MIUIScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Text('share');
      },
    );
  }
}
