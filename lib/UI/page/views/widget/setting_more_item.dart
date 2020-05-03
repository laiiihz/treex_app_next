import 'package:flutter/material.dart';

class SettingMoreItem extends StatefulWidget {
  SettingMoreItem({
    Key key,
    @required this.title,
    this.items,
    this.callBack,
    this.leading,
    this.trailing,
  }) : super(key: key);
  final String title;
  final List<PopupMenuEntry<dynamic>> items;
  final DynamicCallBack callBack;
  final Widget leading;
  final Widget trailing;
  @override
  State<StatefulWidget> createState() => _SettingMoreItemState();
}

class _SettingMoreItemState extends State<SettingMoreItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      trailing: widget.trailing,
      leading: widget.leading,
      onTap: () {
        RenderBox render = context.findRenderObject();
        showMenu<dynamic>(
          context: context,
          position: RelativeRect.fromLTRB(
            MediaQuery.of(context).size.width,
            render.localToGlobal(Offset.zero).dy,
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          ),
          items: widget.items,
        ).then(widget.callBack);
      },
    );
  }
}

typedef DynamicCallBack = Function(dynamic callback);
