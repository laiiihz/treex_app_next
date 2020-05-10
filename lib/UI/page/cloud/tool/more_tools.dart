import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';

class MoreTools extends StatefulWidget {
  MoreTools({
    Key key,
    @required this.heroTag,
    this.onChanged,
    @required this.initValue,
  }) : super(key: key);
  final bool initValue;
  final String heroTag;
  final ValueChanged onChanged;
  @override
  State<StatefulWidget> createState() => _MoreToolsState();
}

class _MoreToolsState extends State<MoreTools> {
  bool _showFirst = true;
  Widget _child = SizedBox();

  @override
  void initState() {
    super.initState();
    _showFirst = widget.initValue;
    Future.delayed(Duration.zero, () {
      setState(() {
        _child = Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(MaterialCommunityIcons.folder_plus),
              onPressed: () {
                Navigator.of(context).pop();
                showMIUIConfirmDialog(
                  context: context,
                  child: TextField(),
                  title: '新建文件夹',
                  confirm: () {},
                );
              },
            ),
            IconButton(
              tooltip: S.of(context).uploadFile,
              icon: Icon(MaterialCommunityIcons.upload),
              onPressed: () {},
            ),
            IconButton(
              tooltip: S.of(context).view,
              icon: AnimatedCrossFade(
                duration: Duration(milliseconds: 500),
                firstChild: Icon(MaterialCommunityIcons.view_list),
                secondChild: Icon(MaterialCommunityIcons.view_grid),
                crossFadeState: _showFirst
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
              onPressed: () {
                setState(() {
                  _showFirst = !_showFirst;
                });
                widget.onChanged(_showFirst);
              },
            ),
          ],
        );
      });
    });
  }

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
                  child: Material(
                    color: Colors.transparent,
                    child: AnimatedSwitcher(
                      switchInCurve: Curves.easeInCubic,
                      switchOutCurve: Curves.easeOutCubic,
                      duration: Duration(milliseconds: 500),
                      child: _child,
                    ),
                  ),
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
