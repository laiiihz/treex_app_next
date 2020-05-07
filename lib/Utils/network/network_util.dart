import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/provider/app_provider.dart';

class NU {
  //app provider
  Dio dio;
  BuildContext context;
  NU({
    BuildContext context,
    String baseUrl,
    String port,
    bool https,
    bool http2 = false,
  }) {
    context = context;
    dio = Dio()
      ..options.connectTimeout = 3000
      ..options.baseUrl = buildUrl(
        baseUrl: baseUrl,
        port: port,
        https: https,
      );
    //https check
    if (https) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback = (cert, host, port) {
          return true;
          //todo:Self sign file check here
        };
      };
    }
  }
}

String buildUrl({
  String baseUrl,
  String port,
  bool https,
}) {
  return '${https ? 'https' : 'http'}://$baseUrl:$port';
}
