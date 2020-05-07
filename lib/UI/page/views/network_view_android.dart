import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treex_app_next/UI/auth/widget/login_text_field.dart';
import 'package:treex_app_next/UI/global_widget/treex_notification.dart';
import 'package:treex_app_next/UI/page/views/settings_views.dart';
import 'package:treex_app_next/UI/page/views/widget/extra_network_settings.dart';
import 'package:treex_app_next/Utils/network/network_test.dart';
import 'package:treex_app_next/Utils/network/network_util.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/provider/network_provider.dart';

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
  //temp ip settings
  bool _httpsIsOn = true;
  String _ipAddr = '';
  String _ipPort = '';
  String _fullPath = '';

  TextEditingController _ipAddrTextEdit = TextEditingController();
  TextEditingController _ipPortTextEdit = TextEditingController();
  FocusNode _ipAddrFocusNode = FocusNode();
  FocusNode _ipPortFocusNode = FocusNode();
  bool _extraOpen = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final np = Provider.of<NP>(context, listen: false);
      _ipAddr = np.urlPrefix;
      _ipPort = np.networkPort;
      _httpsIsOn = np.https;
      _ipAddrTextEdit.text = np.urlPrefix;
      _ipPortTextEdit.text = np.networkPort;
      _fullPath = buildUrl(
        https: _httpsIsOn,
        baseUrl: _ipAddr,
        port: _ipPort,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _ipAddrTextEdit.dispose();
    _ipPortTextEdit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final np = Provider.of<NP>(context);
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
                        _fullPath,
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
                        onChanged: (value) {
                          _ipAddr = value;
                          _buildFullPath();
                        },
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
                        onChanged: (value) {
                          _ipPort = value;
                          _buildFullPath();
                        },
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
                      title: AnimatedDefaultTextStyle(
                        child: Text(S.of(context).https),
                        style: TextStyle(
                            fontSize: 18,
                            color: _httpsIsOn ? Colors.green : Colors.red),
                        duration: Duration(milliseconds: 500),
                      ),
                      onTap: () {
                        _httpsIsOn = !_httpsIsOn;
                        _buildFullPath();
                      },
                      trailing: Switch(
                        value: _httpsIsOn,
                        onChanged: (value) {
                          _httpsIsOn = !_httpsIsOn;
                          _buildFullPath();
                        },
                      ),
                    ),
                    ExtraNetworkSettings(),
                  ]),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                MaterialButton(
                  onPressed: _checkTreexNetwork,
                  onLongPress: _checkRealNetwork,
                  child: Icon(MaterialCommunityIcons.refresh),
                  shape: RoundedRectangleBorder(
                    borderRadius: UU.widgetBorderRadius(),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: saveData,
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

  _buildFullPath() {
    _fullPath = buildUrl(
      https: _httpsIsOn,
      baseUrl: _ipAddr,
      port: _ipPort,
    );
    setState(() {});
  }

  _checkRealNetwork() {
    showLoading(context);
    NetworkTest.networkCheck(
      path: 'https://baidu.com',
      onErr: () => showTN(
        context,
        title: S.of(context).connectionFail,
        icon: MaterialCommunityIcons.timer_off,
        type: StatusType.FAIL,
      ),
    ).then((value) {
      closeLoading();
      if (value)
        showTN(
          context,
          title: S.of(context).connectionSuccess,
          icon: MaterialCommunityIcons.check,
          type: StatusType.SUCCESS,
        );
    });
  }

  _checkTreexNetwork() {
    showLoading(context);
    NetworkTest(
      https: _httpsIsOn,
      baseUrl: _ipAddr,
      port: _ipPort,
      onErr: () => showTN(
        context,
        title: S.of(context).connectionFail,
        icon: MaterialCommunityIcons.timer_off,
        type: StatusType.FAIL,
      ),
      context: context,
    ).check().then((value) {
      closeLoading();
      if (value)
        showTN(
          context,
          title: S.of(context).connectionSuccess,
          icon: MaterialCommunityIcons.check,
          type: StatusType.SUCCESS,
        );
    });
  }

  saveData() async {
    saveDataFunc().then((_) {
      closeLoading();
    });
  }

  Future saveDataFunc() async {
    final np = Provider.of<NP>(context, listen: false);

    showLoading(context);
    bool realNetwork = await NetworkTest.networkCheck(
      path: 'https://baidu.com',
      onErr: () => showTN(
        context,
        title: S.of(context).connectionSuccess,
        icon: MaterialCommunityIcons.timer_off,
      ),
    );
    bool treexNetwork = await NetworkTest(
      port: _ipPort,
      baseUrl: _ipAddr,
      https: _httpsIsOn,
      onErr: () => showTN(
        context,
        title: S.of(context).connectionFail,
        icon: MaterialCommunityIcons.timer_off,
      ),
    ).check();
    if (!realNetwork)
      showTN(
        context,
        title: S.of(context).connectionFail,
        icon: MaterialCommunityIcons.timer_off,
      );
    if (!treexNetwork) {
      showTN(
        context,
        title: S.of(context).connectionFail,
        icon: MaterialCommunityIcons.timer_off,
      );
    }
    if (realNetwork && treexNetwork) {
      np.setBaseUrl(
        secure: _httpsIsOn,
        url: _ipAddr,
        port: _ipPort,
      );
      showTN(
        context,
        title: '保存成功',
        icon: MaterialCommunityIcons.check,
        type: StatusType.SUCCESS,
      );
    } else {
      showTN(
        context,
        title: '保存失败',
        icon: MaterialCommunityIcons.timer_off,
        type: StatusType.FAIL,
      );
    }
    closeLoading();
  }
}
