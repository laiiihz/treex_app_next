import 'package:flutter/material.dart';

class UsedSpaceBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UsedSpaceBoxState();
}

class _UsedSpaceBoxState extends State<UsedSpaceBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LinearProgressIndicator(),
        Row(
          children: <Widget>[],
        ),
      ],
    );
  }
}
