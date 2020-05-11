import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/UI/page/account/widget/used_space_box.dart';
import 'package:treex_app_next/UI/page/views/account_detail_view.dart';
import 'package:treex_app_next/Utils/shared_preferences_util.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/provider/network_provider.dart';
import 'package:treex_app_next/static/color_palettes.dart';

class AccountView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final np = Provider.of<NP>(context);
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
              title: Text(np.profile.name),
              background: Stack(
                children: <Widget>[
                  Hero(
                    tag: 'account',
                    child: Container(
                      color: Color(0xff000000 + np.profile.backgroundColor),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AccountDetailView(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              UsedSpaceBox(),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('network');
                },
                title: Text(S.of(context).networkSettings),
                leading: Icon(MaterialCommunityIcons.network),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('safety');
                },
                title: Text(S.of(context).safety),
                leading: Icon(Icons.lock),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('settings');
                },
                title: Text(S.of(context).settings),
                leading: Icon(Icons.settings),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('about');
                },
                title: Text(S.of(context).about),
                leading: Icon(Icons.info),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('settings');
                },
                title: Text(S.of(context).questions),
                leading: Icon(Icons.device_unknown),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('dev');
                },
                title: Text(S.of(context).dev),
                leading: Icon(Icons.developer_mode),
              ),
              SizedBox(height: 50),
              FlatButton(
                onPressed: () {
                  SPU.shared.setString('token', '');
                  Navigator.of(context, rootNavigator: true)
                      .pushReplacementNamed('login');
                },
                child: Text(
                  S.of(context).logout,
                  style: TextStyle(color: CP.warn(context)),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
