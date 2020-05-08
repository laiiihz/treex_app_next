import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';
import 'package:treex_app_next/generated/l10n.dart';

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
