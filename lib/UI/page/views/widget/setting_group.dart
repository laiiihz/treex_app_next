import 'package:flutter/material.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/static/theme.dart';

class SettingGroup extends StatefulWidget {
  SettingGroup({
    Key key,
    @required this.title,
    this.color,
  }) : super(key: key);
  final String title;
  final Color color;
  @override
  State<StatefulWidget> createState() => _SettingGroupState();
}

class _SettingGroupState extends State<SettingGroup> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.title,
        style: TextStyle(
          fontWeight: getFontWeight(context),
          color: widget.color == null
              ? AppTheme(context).getPrimary()
              : widget.color,
        ),
      ),
    );
  }
}
