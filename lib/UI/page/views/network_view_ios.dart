import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart' as md;
import 'package:provider/provider.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/UI/global_widget/treex_cupertino_text_filed.dart';
import 'package:treex_app_next/UI/page/views/settings_views.dart';
import 'package:treex_app_next/UI/page/views/widget/cupertino_network_info.dart';
import 'package:treex_app_next/UI/page/views/widget/extra_network_settings.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/provider/app_provider.dart';

class NetworkViewIOS extends StatefulWidget {
  NetworkViewIOS({
    Key key,
    @required this.icon,
    @required this.result,
    @required this.wifiAddr,
  }) : super(key: key);
  final IconData icon;
  final ConnectivityResult result;
  final String wifiAddr;
  @override
  State<StatefulWidget> createState() => _NetworkViewIOSState();
}

class _NetworkViewIOSState extends State<NetworkViewIOS> {
  //ip settings
  bool _httpsIsOn = true;
  String _ipAddr = '';
  String _ipPort = '';
  TextEditingController _ipAddrTextEdit = TextEditingController();
  TextEditingController _ipPortTextEdit = TextEditingController();
  FocusNode _ipAddrFocusNode = FocusNode();
  FocusNode _ipPortFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _ipAddrTextEdit.dispose();
    _ipPortTextEdit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AP>(context);
    return CupertinoPageScaffold(
      child: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                largeTitle:
                    buildCupertinoTitle(context, S.of(context).networkSettings),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  CupertinoNetworkInfoIOS(
                    icon: widget.icon,
                    prefix: S.of(context).networkStatus,
                    suffix:
                        buildConnectivityResultString(context, widget.result),
                  ),
                  widget.result == ConnectivityResult.wifi
                      ? CupertinoNetworkInfoIOS(
                          icon: MaterialCommunityIcons.ip,
                          prefix: S.of(context).ip,
                          suffix: widget.wifiAddr,
                        )
                      : SizedBox(),
                  md.Divider(),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TreexCupertinoTextFiledIOS(
                      context: context,
                      light: true,
                      controller: _ipAddrTextEdit,
                      focusNode: _ipAddrFocusNode,
                      placeholder: S.of(context).ipAddress,
                      prefix: Icon(MaterialCommunityIcons.ip_network),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TreexCupertinoTextFiledIOS(
                      context: context,
                      light: true,
                      controller: _ipPortTextEdit,
                      focusNode: _ipPortFocusNode,
                      onEditingComplete: () {},
                      onChanged: (value) {},
                      placeholder: S.of(context).port,
                      prefix: Icon(MaterialCommunityIcons.network_outline),
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 10),
                        Text(S.of(context).https),
                        Spacer(),
                        CupertinoSwitch(
                          value: ap.https,
                          onChanged: (value) {
                            ap.netHttps(value);
                          },
                        ),
                      ],
                    ),
                    onPressed: () {
                      ap.netHttps(!ap.https);
                    },
                  ),
                  ExtraNetworkSettings(),
                ]),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  CupertinoButton(
                    child: Icon(MaterialCommunityIcons.refresh),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: CupertinoButton.filled(
                      child: Text(S.of(context).save),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
