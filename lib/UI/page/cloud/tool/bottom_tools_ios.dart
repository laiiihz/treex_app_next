import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as md;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:treex_app_next/static/color_palettes.dart';

class BottomToolsIOS extends StatefulWidget {
  BottomToolsIOS({
    Key key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _BottomToolsIOSState();
}

class _BottomToolsIOSState extends State<BottomToolsIOS> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: md.Material(
            color: md.Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: CP.cupertinoBG(context, reverse: true).withAlpha(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  md.IconButton(
                    icon: Icon(MaterialCommunityIcons.upload),
                    onPressed: () {},
                  ),
                  md.IconButton(
                    icon: Icon(md.Icons.add),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
