import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as md;
import 'package:flutter_icons/flutter_icons.dart';

typedef ValueChanged = Function(int value);

class MoreToolsIOS extends StatefulWidget {
  MoreToolsIOS({
    Key key,
    @required this.onChanged,
  }) : super(key: key);
  final ValueChanged onChanged;
  @override
  State<StatefulWidget> createState() => _MoreToolsIOSState();
}

class _MoreToolsIOSState extends State<MoreToolsIOS> {
  int _now = 0;
  @override
  Widget build(BuildContext context) {
    return md.Material(
      color: md.Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: CupertinoSlidingSegmentedControl<int>(
              children: {
                0: Icon(MaterialCommunityIcons.view_grid),
                1: Icon(MaterialCommunityIcons.view_list),
              },
              groupValue: _now,
              onValueChanged: (value) {
                setState(() {
                  _now = value;
                });
                widget.onChanged(value);
              },
            ),
          ),
        ),
      ),
    );
  }
}
