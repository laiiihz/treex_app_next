import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:treex_app_next/Utils/network/network_util.dart';

class NetworkTest extends NU {
  final VoidCallback onErr;
  NetworkTest({
    bool https = true,
    @required String port,
    @required String baseUrl,
    BuildContext context,
    this.onErr,
  }) : super(
          https: https,
          port: port,
          baseUrl: baseUrl,
        ) {
    this.init();
  }
  Future<bool> check() async {
    Response response = await dio.get('/test').catchError((err) {
      debugPrint('@@@netowrk test:Network Error');
      debugPrint(err.toString());
      onErr();
    });
    return response == null ? false : response.statusCode == 200;
  }

  static Future networkCheck({String path, VoidCallback onErr}) async {
    Dio dio = Dio();
    Response response = await dio.get(path).catchError((_) {
      onErr();
    });
    return response == null ? false : response.statusCode == 200;
  }
}
