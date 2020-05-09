import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/provider/app_provider.dart';
import 'package:treex_app_next/static/static_values.dart';

class CupertinoSettingMoreItem extends StatefulWidget {
  CupertinoSettingMoreItem({
    Key key,
    @required this.title,
    @required this.leading,
    @required this.trailing,
    this.actions,
    this.color,
  }) : super(key: key);
  final String title;
  final Widget leading;
  final Widget trailing;
  final Color color;

  ///cupertino actions
  final List<Widget> actions;
  @override
  State<StatefulWidget> createState() => _SettingMoreItemState();
}

class _SettingMoreItemState extends State<CupertinoSettingMoreItem> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Row(
        children: <Widget>[
          widget.leading,
          SizedBox(width: 30),
          Text(
            widget.title,
            style: TextStyle(color: widget.color),
          ),
          Spacer(),
          widget.trailing,
        ],
      ),
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return CupertinoActionSheet(
              title: Text(widget.title),
              actions: widget.actions,
              cancelButton: CupertinoButton(
                child: Text(S.of(context).cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        );
      },
    );
  }
}

typedef DynamicCallBack = Function(dynamic callback);

Widget cupertinoPlatformAction(BuildContext context, TargetPlatform platform) =>
    CupertinoActionSheetAction(
      onPressed: () {
        final ap = Provider.of<AP>(context, listen: false);
        ap.changePlatform(
          platform,
          platformsStringMap(context)[platform],
        );
        if (platform == TargetPlatform.iOS) ap.changeAutoDarkMode(true);
        Navigator.of(context, rootNavigator: true).pop();
      },
      child: Text(platformsStringMap(context)[platform]),
    );
