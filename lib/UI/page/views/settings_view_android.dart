
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/UI/global_widget/treex_notification.dart';
import 'package:treex_app_next/UI/page/views/widget/setting_group.dart';
import 'package:treex_app_next/UI/page/views/widget/setting_more_item.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/provider/app_provider.dart';
import 'package:treex_app_next/static/static_values.dart';

class SettingsViewAndroid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsViewAndroid> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AP>(context);
    return Scaffold(
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
              SwitchListTile(
                title: Text(S.of(context).darkMode),
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
                          icon: value ? Icons.brightness_3 : Icons.brightness_7,
                        );
                      },
              ),
              SwitchListTile(
                title: Text(S.of(context).autoDarkMode),
                value: ap.autoDarkMode,
                onChanged: (value) {
                  ap.changeAutoDarkMode(value);
                  showTN(
                    context,
                    title: value
                        ? S.of(context).autoDarkMode
                        : S.of(context).closeAutoDarkMode,
                    icon: value ? Icons.brightness_auto : Icons.brightness_7,
                  );
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
