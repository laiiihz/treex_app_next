import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app_next/UI/page/views/widget/setting_group.dart';
import 'package:treex_app_next/generated/l10n.dart';

class SafetyViewAndroid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SafetyViewAndroidState();
}

class _SafetyViewAndroidState extends State<SafetyViewAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
