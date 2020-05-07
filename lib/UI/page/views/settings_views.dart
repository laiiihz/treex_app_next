import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';
import 'package:treex_app_next/UI/page/views/about_view_android.dart';
import 'package:treex_app_next/UI/page/views/about_view_ios.dart';
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
