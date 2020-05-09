import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/UI/page/views/widget/cupertino_setting_more_item.dart';
import 'package:treex_app_next/UI/page/views/widget/setting_group.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:flutter/cupertino.dart' as c;
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/static/color_palettes.dart';

class SafetyView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SafetyViewState();
}

class _SafetyViewState extends State<SafetyView> {
  @override
  Widget build(BuildContext context) {
    return isIOS(context)
        ? c.CupertinoPageScaffold(
            child: c.CustomScrollView(
              slivers: <Widget>[
                c.CupertinoSliverNavigationBar(
                  largeTitle:
                      buildCupertinoTitle(context, S.of(context).safety),
                ),
                c.SliverList(
                  delegate: c.SliverChildListDelegate([
                    Material(
                      child: SettingGroup(
                        title: S.of(context).dangerZone,
                        color: Colors.pink,
                      ),
                    ),
                    CupertinoSettingMoreItem(
                      color: CP.warn(context),
                      title: S.of(context).deleteAllData,
                      leading: Icon(
                        MaterialCommunityIcons.radioactive,
                        color: CP.warn(context),
                      ),
                      trailing: c.SizedBox(),
                      actions: <Widget>[
                        c.CupertinoActionSheetAction(
                          onPressed: () {},
                          child: c.Text(
                            S.of(context).deleteAllData,
                            style: TextStyle(color: CP.warn(context)),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ],
            ),
          )
        : Scaffold(
            body: CustomScrollView(
              physics: MIUIScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  stretch: true,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(S.of(context).safety),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    SettingGroup(
                      title: S.of(context).dangerZone,
                      color: Colors.pink,
                    ),
                    ListTile(
                      onTap: () {
                        showMIUIConfirmDialog(
                          context: context,
                          child: Text(' '),
                          title: S.of(context).deleteAllData,
                          confirm: () {},
                        );
                      },
                      title: Text(
                        S.of(context).deleteAllData,
                        style: TextStyle(color: Colors.pink),
                      ),
                      leading: Icon(
                        MaterialCommunityIcons.radioactive,
                        color: Colors.pink,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          );
  }
}
