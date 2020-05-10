import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/UI/global_widget/treex_notification.dart';
import 'package:treex_app_next/UI/page/views/widget/cupertino_setting_more_item.dart';
import 'package:treex_app_next/UI/page/views/widget/setting_group.dart';
import 'package:treex_app_next/UI/page/views/widget/setting_more_item.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/provider/app_provider.dart';
import 'package:treex_app_next/static/static_values.dart';
import 'package:flutter/cupertino.dart' as c;

class SettingsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AP>(context);
    return isIOS(context)
        ? c.CupertinoPageScaffold(
            child: Material(
              child: CustomScrollView(
                slivers: <Widget>[
                  c.CupertinoSliverNavigationBar(
                    largeTitle:
                        buildCupertinoTitle(context, S.of(context).settings),
                  ),
                  c.SliverList(
                    delegate: c.SliverChildListDelegate([
                      SettingGroup(title: S.of(context).display),
                      CupertinoSettingMoreItem(
                        title: S.of(context).appTheme,
                        leading: Icon(Icons.all_inclusive),
                        trailing: Material(
                          child: Chip(
                            label: Text(ap.platformString),
                          ),
                        ),
                        actions: <Widget>[
                          cupertinoPlatformAction(
                              context, TargetPlatform.android),
                          cupertinoPlatformAction(context, TargetPlatform.iOS),
                          cupertinoPlatformAction(
                              context, TargetPlatform.fuchsia),
                        ],
                      ),
                      ListTile(
                        enabled: false,
                        title: Text(S.of(context).autoDarkMode),
                        leading: Icon(Icons.brightness_auto),
                        trailing:
                            c.CupertinoSwitch(value: true, onChanged: null),
                      ),
                      SettingGroup(title: S.of(context).fileDisplay),
                      ListTile(
                        onTap: () {
                          ap.setFileDetail(!ap.fileDetail);
                        },
                        leading: c.Icon(MaterialCommunityIcons.file_table),
                        title: Text(S.of(context).detail_date),
                        trailing: c.CupertinoSwitch(
                          value: !ap.fileDetail,
                          onChanged: (value) {
                            ap.setFileDetail(!value);
                          },
                        ),
                      ),
                      SettingGroup(title: S.of(context).others),
                      ListTile(
                        onTap: () {
                          ap.changeFastStartUp(!ap.fastStartup);
                        },
                        title: Text(S.of(context).fastStartup),
                        leading: Icon(MaterialCommunityIcons.clock_fast),
                        trailing: c.CupertinoSwitch(
                          value: ap.fastStartup,
                          onChanged: (value) {
                            ap.changeFastStartUp(value);
                          },
                        ),
                      ),
                      ListTile(
                        leading: Icon(MaterialCommunityIcons.auto_fix),
                        title: Text('沉浸状态栏'),
                        onTap: () {
                          ap.setStatusBarTransparent(!ap.transparentStatusBar);
                        },
                        trailing: c.CupertinoSwitch(
                            value: ap.transparentStatusBar,
                            onChanged: (value) {
                              ap.setStatusBarTransparent(value);
                            }),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            body: CustomScrollView(
              physics: MIUIScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  floating: true,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(S.of(context).settings),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    SettingGroup(
                      title: S.of(context).display,
                    ),
                    SettingMoreItem(
                      leading: Icon(Icons.all_inclusive),
                      trailing: Chip(
                        backgroundColor: Colors.green,
                        label: Text(ap.platformString),
                      ),
                      title: S.of(context).appTheme,
                      items: [
                        PopupMenuItem(
                          child: Text(S.of(context).material),
                          value: TargetPlatform.android,
                        ),
                        PopupMenuItem(
                          child: Text(S.of(context).cupertino),
                          value: TargetPlatform.iOS,
                        ),
                        PopupMenuItem(
                          child: Text(S.of(context).fuchsia),
                          value: TargetPlatform.fuchsia,
                        ),
                      ],
                      callBack: (platform) {
                        if (platform != null)
                          ap.changePlatform(
                            platform,
                            platformsStringMap(context)[platform],
                          );
                        if (platform == TargetPlatform.iOS)
                          ap.changeAutoDarkMode(true);
                      },
                    ),
                    ListTile(
                      leading: Icon(MaterialCommunityIcons.theme_light_dark),
                      title: Text(S.of(context).darkMode),
                      trailing: Switch(
                        value: ap.autoDarkMode
                            ? Theme.of(context).brightness == Brightness.dark
                            : ap.darkMode,
                        onChanged: ap.autoDarkMode
                            ? null
                            : (value) {
                                ap.changeDarkMode(value);
                                showTN(
                                  context,
                                  title: value
                                      ? S.of(context).darkMode
                                      : S.of(context).lightMode,
                                  icon: value
                                      ? Icons.brightness_3
                                      : Icons.brightness_7,
                                );
                              },
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.brightness_auto),
                      title: Text(S.of(context).autoDarkMode),
                      trailing: Switch(
                        value: ap.autoDarkMode,
                        onChanged: (value) {
                          ap.changeAutoDarkMode(value);
                          showTN(
                            context,
                            title: value
                                ? S.of(context).autoDarkMode
                                : S.of(context).closeAutoDarkMode,
                            icon: value
                                ? Icons.brightness_auto
                                : Icons.brightness_7,
                          );
                        },
                      ),
                    ),
                    SettingGroup(title: S.of(context).fileDisplay),
                    ListTile(
                      onTap: () {
                        ap.setFileDetail(!ap.fileDetail);
                      },
                      leading: c.Icon(MaterialCommunityIcons.file_table),
                      title: Text(S.of(context).detail_date),
                      trailing: Switch(
                        value: !ap.fileDetail,
                        onChanged: (value) {
                          ap.setFileDetail(!value);
                        },
                      ),
                    ),
                    SettingGroup(title: S.of(context).others),
                    ListTile(
                      leading: Icon(MaterialCommunityIcons.clock_fast),
                      title: Text(S.of(context).fastStartup),
                      trailing: Switch(
                        value: ap.fastStartup,
                        onChanged: (value) {
                          ap.changeFastStartUp(value);
                        },
                      ),
                    ),
                    ListTile(
                      leading: Icon(MaterialCommunityIcons.auto_fix),
                      title: Text('沉浸状态栏'),
                      onTap: () {
                        ap.setStatusBarTransparent(!ap.transparentStatusBar);
                      },
                      trailing: Switch(
                          value: ap.transparentStatusBar,
                          onChanged: (value) {
                            ap.setStatusBarTransparent(value);
                          }),
                    ),
                  ]),
                ),
              ],
            ),
          );
  }
}
