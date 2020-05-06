import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';

class TreexBottomBar extends StatefulWidget {
  TreexBottomBar({
    Key key,
    this.onCancel,
    this.onConfirm,
    this.confirmString,
    this.cancelString,
    this.single = false,
  }) : super(key: key);
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final String confirmString;
  final String cancelString;
  final bool single;
  @override
  State<StatefulWidget> createState() => __TreexBottomBarState();
}

class __TreexBottomBarState extends State<TreexBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 10,
        left: 10,
        right: 10,
        top: 10,
      ),
      decoration: BoxDecoration(),
      child: Row(
        children: <Widget>[
          widget.single
              ? SizedBox()
              : FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: UU.widgetBorderRadius(),
                  ),
                  onPressed: widget.onCancel,
                  child: Text(widget.cancelString == null
                      ? S.of(context).cancelUpper
                      : widget.cancelString),
                ),
          Expanded(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: UU.widgetBorderRadius(),
              ),
              onPressed: widget.onConfirm,
              child: Text(widget.confirmString == null
                  ? S.of(context).confirmUpper
                  : widget.confirmString),
            ),
          ),
        ],
      ),
    );
  }
}
