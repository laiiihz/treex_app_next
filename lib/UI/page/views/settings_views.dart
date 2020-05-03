import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:treex_app_next/UI/page/views/about_view_android.dart';
import 'package:treex_app_next/UI/page/views/about_view_ios.dart';
import 'package:treex_app_next/UI/page/views/network_view_android.dart';
import 'package:treex_app_next/UI/page/views/network_view_ios.dart';
import 'package:treex_app_next/UI/page/views/safety_view_android.dart';
import 'package:treex_app_next/UI/page/views/safety_view_ios.dart';
import 'package:treex_app_next/UI/page/views/settings_view_android.dart';
import 'package:treex_app_next/UI/page/views/settings_view_ios.dart';
import 'package:treex_app_next/UI/page/views/account_detail_view_android.dart';
import 'package:treex_app_next/UI/page/views/account_detail_view_ios.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';

class SettingsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return isIOS(context) ? SettingsViewIOS() : SettingsViewAndroid();
  }
}

class SafetyView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SafetyViewState();
}

class _SafetyViewState extends State<SafetyView> {
  @override
  Widget build(BuildContext context) {
    return isIOS(context) ? SafetyViewIOS() : SafetyViewAndroid();
  }
}

class AboutView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return isIOS(context) ? AboutViewIOS() : AboutViewAndroid();
  }
}

class NetworkView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NetworkViewState();
}

class _NetworkViewState extends State<NetworkView> {
  String _wifiAddr = '';
  ConnectivityResult _result = ConnectivityResult.none;
  StreamSubscription<ConnectivityResult> _subscription;
  IconData _connectIconData = MaterialCommunityIcons.null_;
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
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isIOS(context)
        ? NetworkViewIOS(
            result: _result,
            wifiAddr: _wifiAddr,
            icon: _connectIconData,
          )
        : NetworkViewAndroid(
            result: _result,
            wifiAddr: _wifiAddr,
            icon: _connectIconData,
          );
  }
}

class AccountDetailView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountDetailViewState();
}

class _AccountDetailViewState extends State<AccountDetailView> {
  @override
  Widget build(BuildContext context) {
    return isIOS(context) ? AccountDetailViewIOS() : AccountDetailViewAndroid();
  }
}

String buildConnectivityResultString(
    BuildContext context, ConnectivityResult result) {
  switch (result) {
    case ConnectivityResult.none:
      return S.of(context).noNetwork;
    case ConnectivityResult.mobile:
      return S.of(context).mobile;
    case ConnectivityResult.wifi:
      return S.of(context).wifi;
    default:
      return S.of(context).noNetwork;
  }
}
