import 'package:flutter/material.dart';
import 'package:treex_app_next/Utils/ui_util.dart';

class MoreTools extends StatefulWidget {
  MoreTools({
    Key key,
    @required this.heroTag,
  }) : super(key: key);
  final String heroTag;
  @override
  State<StatefulWidget> createState() => _MoreToolsState();
}

class _MoreToolsState extends State<MoreTools> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Hero(
                tag: widget.heroTag,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: isDark(context) ? Colors.black : Colors.white,
                    borderRadius: UU.widgetBorderRadius(),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
