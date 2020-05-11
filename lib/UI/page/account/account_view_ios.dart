import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as md;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/UI/page/account/widget/used_space_box.dart';
import 'package:treex_app_next/UI/page/views/account_detail_view.dart';
import 'package:treex_app_next/Utils/network/network_logout.dart';
import 'package:treex_app_next/Utils/shared_preferences_util.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/provider/network_provider.dart';
import 'package:treex_app_next/static/color_palettes.dart';

class AccountViewIOS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountView();
}

class _AccountView extends State<AccountViewIOS> {
  @override
  Widget build(BuildContext context) {
    final np = Provider.of<NP>(context);
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: buildCupertinoTitle(context, S.of(context).accountView),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            CupertinoButton(
              child: Column(
                children: <Widget>[
                  UsedSpaceBox(),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Hero(
                          tag: 'avatar',
                          child: md.CircleAvatar(
                            backgroundColor:
                                Color(0xff000000 + np.profile.backgroundColor),
                            child: Text(np.profile.name[0]),
                          ),
                        ),
                      ),
                      Text(np.profile.name),
                      Spacer(),
                      Text('已使用1G/5G'),
                    ],
                  ),
                ],
              ),
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => AccountDetailView(),
                  ),
                );
              },
            ),
            md.Divider(height: 0),
            _buildSettingsItem(
              icon: MaterialCommunityIcons.network,
              text: S.of(context).networkSettings,
              color: CupertinoColors.systemGrey,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushNamed('network');
              },
            ),
            _buildSettingsItem(
              icon: md.Icons.lock,
              text: S.of(context).safety,
              color: CupertinoColors.systemBlue,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushNamed('safety');
              },
            ),
            _buildSettingsItem(
              icon: md.Icons.settings,
              text: S.of(context).settings,
              color: CupertinoColors.systemPink,
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('settings');
              },
            ),
            _buildSettingsItem(
              icon: md.Icons.info,
              text: S.of(context).about,
              color: CupertinoColors.systemTeal,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushNamed('about');
              },
            ),
            _buildSettingsItem(
              icon: md.Icons.device_unknown,
              text: S.of(context).questions,
              color: CupertinoColors.systemGreen,
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('settings');
              },
            ),
            SizedBox(height: 50),
            CupertinoButton(
              child: Text(
                S.of(context).logout,
                style: TextStyle(color: CP.warn(context)),
              ),
              onPressed: () {
                NetworkLogout(context: context).logout();
                SPU.shared.setString('token', '');
                Navigator.of(context, rootNavigator: true)
                    .pushReplacementNamed('login');
              },
            ),
          ]),
        ),
      ],
    );
  }

  _buildSettingsItem({
    String text,
    IconData icon,
    VoidCallback onPressed,
    Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: CupertinoButton(
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: UU.widgetBorderRadius(),
                    ),
                    child: Icon(
                      icon,
                      color: CupertinoColors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    text,
                    style: TextStyle(
                      color: isDark(context)
                          ? CupertinoColors.white
                          : CupertinoColors.black,
                    ),
                  ),
                ],
              ),
              onPressed: onPressed),
        ),
        md.Divider(
          height: 0,
          indent: 70,
        ),
      ],
    );
  }
}
