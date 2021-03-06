import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/UI/page/account/widget/used_space_box.dart';
import 'package:treex_app_next/UI/page/views/account_detail_view.dart';
import 'package:treex_app_next/UI/page/views/network_view.dart';
import 'package:treex_app_next/Utils/network/network_logout.dart';
import 'package:treex_app_next/Utils/network/network_profile.dart';
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
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final np = Provider.of<NP>(context, listen: false);
      NetworkProfile(context: context).space().then((value) {
        np.setSpaceEntity(value);
      });
    });
  }

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
            backgroundColor: Color(0xff000000 + np.profile.backgroundColor),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(np.profile.name),
              background: Stack(
                children: <Widget>[
                  Hero(
                    tag: 'account',
                    child: np.avatarFile == null
                        ? SizedBox()
                        : Image.file(
                            np.avatarFile,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.width,
                            width: MediaQuery.of(context).size.width,
                          ),
                  ),
                  Material(
                    color: Colors.black54,
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NetworkView(readonly: true),
                    ),
                  );
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
                  NetworkLogout(context: context).logout();
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
