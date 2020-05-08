import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/Utils/network/network_util.dart';
import 'package:treex_app_next/provider/network_provider.dart';

enum loginResult {
  NO_USER,
  SUCCESS,
  PASSWORD_WRONG,
  UNKNOWN,
  ERR,
}

class NetworkAuth extends NU {
  final BuildContext context;
  NP np;
  NetworkAuth(this.context) : super(baseUrl: '') {
    np = Provider.of<NP>(context, listen: false);
    this.baseUrl = np.urlPrefix;
    this.port = np.networkPort;
    this.https = np.https;
    this.init();
  }

  Future<loginResult> auth({
    String account,
    String password,
  }) async {
    Response result = await dio
        .get('/login?name=$account&password=$password')
        .catchError((err) {
      return Future.value(loginResult.ERR);
    });
    switch (result?.data['loginResult']['code']) {
      case 0:
        return loginResult.NO_USER;
      case 1:
        return loginResult.SUCCESS;
      case 2:
        return loginResult.PASSWORD_WRONG;
      default:
        return loginResult.UNKNOWN;
    }
  }
}
