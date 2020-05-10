import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/Utils/crypto_util.dart';
import 'package:treex_app_next/Utils/network/network_util.dart';
import 'package:treex_app_next/provider/network_provider.dart';

enum loginResult {
  NO_USER,
  SUCCESS,
  PASSWORD_WRONG,
  UNKNOWN,
  ERR,
}

enum signUpResult {
  SUCCESS,
  PASSWORD_NULL,
  FAIL,
  HAVE_USER,
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
    String hmacPassword = CryptoUtil.password(
      raw: password,
      name: account,
    );
    Response response = await dio.get('/login', queryParameters: {
      'name': account,
      'password': hmacPassword,
    }).catchError((err) {
      return Future.value(loginResult.ERR);
    });
    switch (response?.data['loginResult']['code']) {
      case 0:
        return loginResult.NO_USER;
      case 1:
        np.setToken(response.data['token']);
        np.setProfile(response.data['user']);
        return loginResult.SUCCESS;
      case 2:
        return loginResult.PASSWORD_WRONG;
      default:
        return loginResult.UNKNOWN;
    }
  }

  Future<signUpResult> signup({String name, String password}) async {
    String hmacPassword = CryptoUtil.password(
      raw: password,
      name: name,
    );
    Response response = await dio.put('/signup', queryParameters: {
      'name': name,
      'password': hmacPassword,
    }).catchError((err) {});
    switch (response?.data['signupResult']['code']) {
      case 0:
        return signUpResult.SUCCESS;
      case 1:
        return signUpResult.PASSWORD_NULL;
      case 2:
        return signUpResult.FAIL;
      case 3:
        return signUpResult.HAVE_USER;
      default:
        return signUpResult.UNKNOWN;
    }
  }
}
