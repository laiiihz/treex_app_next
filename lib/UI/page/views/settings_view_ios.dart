import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as md;
import 'package:provider/provider.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/UI/page/views/widget/cupertino_setting_more_item.dart';
import 'package:treex_app_next/UI/page/views/widget/setting_group.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/provider/app_provider.dart';

class SettingsViewIOS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsView();
}

class _SettingsView extends State<SettingsViewIOS> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AP>(context);
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: buildCupertinoTitle(context, S.of(context).settings),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              md.Material(
                child: SettingGroup(title: S.of(context).display),
              ),
              CupertinoSettingMoreItem(
                title: S.of(context).appTheme,
                leading: Icon(md.Icons.all_inclusive),
                trailing: md.Material(
                  child: md.Chip(
                    label: Text(ap.platformString),
                  ),
                ),
                actions: <Widget>[
                  cupertinoPlatformAction(context, TargetPlatform.android),
                  cupertinoPlatformAction(context, TargetPlatform.iOS),
                  cupertinoPlatformAction(context, TargetPlatform.fuchsia),
                ],
              ),
              md.Material(
                color: md.Colors.transparent,
                child: md.ListTile(
                  enabled: false,
                  title: Text(S.of(context).autoDarkMode),
                  leading: Icon(md.Icons.brightness_auto),
                  trailing: CupertinoSwitch(value: true, onChanged: null),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
