import 'dart:async';
import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart' as c;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treex_app_next/UI/auth/widget/login_text_field.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/UI/global_widget/treex_cupertino_bottom_bar.dart';
import 'package:treex_app_next/UI/global_widget/treex_cupertino_text_filed.dart';
import 'package:treex_app_next/UI/global_widget/treex_notification.dart';
import 'package:treex_app_next/UI/page/views/settings_views.dart';
import 'package:treex_app_next/UI/page/views/widget/cupertino_network_info.dart';
import 'package:treex_app_next/UI/page/views/widget/extra_network_settings.dart';
import 'package:treex_app_next/Utils/network/network_test.dart';
import 'package:treex_app_next/Utils/network/network_util.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/provider/network_provider.dart';

class NetworkView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NetworkViewState();
}

class _NetworkViewState extends State<NetworkView> {
  //connectivity Values
  String _wifiAddr = '';
  ConnectivityResult _result = ConnectivityResult.none;
  StreamSubscription<ConnectivityResult> _subscription;
  IconData _connectIconData = MaterialCommunityIcons.null_;

  //temp ip settings
  bool _httpsIsOn = true;
  String _ipAddr = '';
  String _ipPort = '';
  String _fullPath = '';

  TextEditingController _ipAddrTextEdit = TextEditingController();
  TextEditingController _ipPortTextEdit = TextEditingController();
  FocusNode _ipAddrFocusNode = FocusNode();
  FocusNode _ipPortFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    getIpAddress() async {
      _wifiAddr = await Connectivity().getWifiIP() ?? '';
      setState(() {});
    }

    getIpAddress();

    _subscription = Connectivity().onConnectivityChanged.listen((status) {
      _result = status;
      switch (status) {
        case ConnectivityResult.none:
          _connectIconData = MaterialCommunityIcons.null_;
          break;
        case ConnectivityResult.mobile:
          _connectIconData = MaterialCommunityIcons.cellphone_android;
          break;
        case ConnectivityResult.wifi:
          _connectIconData = MaterialCommunityIcons.wifi;
          getIpAddress();
          break;
      }
      setState(() {});
    });
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
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final np = Provider.of<NP>(context);
    return isIOS(context)
        ? c.CupertinoPageScaffold(
            child: Stack(
              children: <Widget>[
                CustomScrollView(
                  slivers: <Widget>[
                    c.CupertinoSliverNavigationBar(
                      largeTitle: buildCupertinoTitle(
                          context, S.of(context).networkSettings),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        CupertinoNetworkInfoIOS(
                          icon: _connectIconData,
                          prefix: S.of(context).networkStatus,
                          suffix:
                              buildConnectivityResultString(context, _result),
                        ),
                        _result == ConnectivityResult.wifi
                            ? CupertinoNetworkInfoIOS(
                                icon: MaterialCommunityIcons.ip,
                                prefix: S.of(context).ip,
                                suffix: _wifiAddr,
                              )
                            : SizedBox(),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Material(
                            child: Text(
                              _fullPath,
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white30
                                      : Colors.black38),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TreexCupertinoTextFiledIOS(
                            context: context,
                            light: true,
                            controller: _ipAddrTextEdit,
                            focusNode: _ipAddrFocusNode,
                            onChanged: (value) {
                              _ipAddr = value;
                              _buildFullPath();
                            },
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
                            onChanged: (value) {
                              _ipPort = value;
                              _buildFullPath();
                            },
                            placeholder: S.of(context).port,
                            prefix:
                                Icon(MaterialCommunityIcons.network_outline),
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              AnimatedDefaultTextStyle(
                                child: Text(S.of(context).https),
                                style: TextStyle(
                                    fontSize: 18,
                                    color:
                                        _httpsIsOn ? Colors.green : Colors.red),
                                duration: Duration(milliseconds: 500),
                              ),
                              Spacer(),
                              CupertinoSwitch(
                                value: _httpsIsOn,
                                onChanged: (value) {
                                  _httpsIsOn = value;
                                  _buildFullPath();
                                },
                              ),
                            ],
                          ),
                          onPressed: () {
                            _httpsIsOn = !_httpsIsOn;
                            _buildFullPath();
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
                  child: TreexCupertinoBottomBar(
                    children: <Widget>[
                      c.GestureDetector(
                        onLongPress: _checkRealNetwork,
                        child: CupertinoButton(
                          child: Icon(MaterialCommunityIcons.refresh),
                          onPressed: _checkTreexNetwork,
                        ),
                      ),
                      Expanded(
                        child: CupertinoButton.filled(
                          child: Text(S.of(context).save),
                          onPressed: _saveData,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
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
                            leading: Icon(_connectIconData),
                            title: Text(S.of(context).networkStatus),
                            trailing: Text(buildConnectivityResultString(
                                context, _result)),
                          ),
                          _result == ConnectivityResult.wifi
                              ? ListTile(
                                  leading: Icon(MaterialCommunityIcons.ip),
                                  title: Text(S.of(context).ip),
                                  trailing: Text(_wifiAddr),
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
                                prefixIcon:
                                    Icon(MaterialCommunityIcons.ip_network),
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
                                prefixIcon: Icon(
                                    MaterialCommunityIcons.network_outline),
                                fillColor: TF.fillColor(context),
                                filled: true,
                              ),
                            ),
                          ),
                          ListTile(
                            leading:
                                Icon(MaterialCommunityIcons.security_network),
                            title: AnimatedDefaultTextStyle(
                              child: Text(S.of(context).https),
                              style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      _httpsIsOn ? Colors.green : Colors.red),
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
                          onPressed: _saveData,
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

  _saveData() async {
    _saveDataFunc().then((_) {
      closeLoading();
    });
  }

  Future _saveDataFunc() async {
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
        icon: MaterialCommunityIcons.content_save,
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
