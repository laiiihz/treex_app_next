import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treex_app_next/UI/auth/widget/login_text_field.dart';
import 'package:treex_app_next/UI/page/views/settings_views.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';

class NetworkViewAndroid extends StatefulWidget {
  NetworkViewAndroid({
    Key key,
    @required this.icon,
    @required this.result,
    @required this.wifiAddr,
  }) : super(key: key);
  final IconData icon;
  final ConnectivityResult result;
  final String wifiAddr;
  @override
  State<StatefulWidget> createState() => _NetworkViewAndroidState();
}

class _NetworkViewAndroidState extends State<NetworkViewAndroid> {
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              physics: MIUIScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  floating: true,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(S.of(context).networkSettings),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(MaterialCommunityIcons.qrcode_scan),
                      onPressed: () {
                        showMIUIConfirmDialog(
                          context: context,
                          single: true,
                          child: Container(
                            height: 250,
                            child: QrImage(
                              data: '0',
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          title: S.of(context).shareNetworkSettings,
                          confirm: () {},
                        );
                      },
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    ListTile(
                      leading: Icon(widget.icon),
                      title: Text(S.of(context).networkStatus),
                      trailing: Text(buildConnectivityResultString(
                          context, widget.result)),
                    ),
                    widget.result == ConnectivityResult.wifi
                        ? ListTile(
                            leading: Icon(MaterialCommunityIcons.ip),
                            title: Text(S.of(context).ip),
                            trailing: Text(widget.wifiAddr),
                          )
                        : SizedBox(),
                    Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '${_httpsIsOn ? 'https' : 'http'}://${_ipAddrTextEdit.text}:${_ipPortTextEdit.text}',
                        style: TextStyle(
                            color: isDark(context)
                                ? Colors.white30
                                : Colors.black38),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _ipAddrTextEdit,
                        focusNode: _ipAddrFocusNode,
                        decoration: InputDecoration(
                          labelText: S.of(context).ipAddress,
                          border: TF.border(),
                          prefixIcon: Icon(MaterialCommunityIcons.ip_network),
                          fillColor: TF.fillColor(context),
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _ipPortTextEdit,
                        focusNode: _ipPortFocusNode,
                        decoration: InputDecoration(
                          labelText: S.of(context).port,
                          border: TF.border(),
                          prefixIcon:
                              Icon(MaterialCommunityIcons.network_outline),
                          fillColor: TF.fillColor(context),
                          filled: true,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(MaterialCommunityIcons.security_network),
                      title: Text(
                        S.of(context).https,
                        style: TextStyle(
                          color: _httpsIsOn ? Colors.green : Colors.red,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _httpsIsOn = !_httpsIsOn;
                        });
                      },
                      trailing: Switch(
                        value: _httpsIsOn,
                        onChanged: (value) {
                          setState(() {
                            _httpsIsOn = value;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.top,
              left: 10,
              right: 10,
            ),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(MaterialCommunityIcons.refresh),
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: UU.widgetBorderRadius(),
                    ),
                    child: Text(S.of(context).save),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
