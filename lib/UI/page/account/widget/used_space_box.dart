import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/provider/network_provider.dart';

class UsedSpaceBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UsedSpaceBoxState();
}

class _UsedSpaceBoxState extends State<UsedSpaceBox> {
  @override
  Widget build(BuildContext context) {
    final np = Provider.of<NP>(context);
    return Column(
      children: <Widget>[
        LinearProgressIndicator(
          value: np.spaceEntity == null
              ? null
              : np.spaceEntity.used / np.spaceEntity.all,
        ),
        Row(
          children: <Widget>[],
        ),
      ],
    );
  }
}
