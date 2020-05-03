import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';

class PrivateList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PrivateListState();
}

class _PrivateListState extends State<PrivateList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: UniqueKey(),
      physics: MIUIScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Text('private');
      },
    );
  }
}
