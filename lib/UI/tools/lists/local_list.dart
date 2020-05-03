import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';

class LocalList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocalListState();
}

class _LocalListState extends State<LocalList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: UniqueKey(),
      physics: MIUIScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Text('local');
      },
    );
  }
}
