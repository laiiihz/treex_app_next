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
  }) {
    context = context;
    dio = Dio()
      ..options.connectTimeout = 3000
      ..options.baseUrl = buildUrl(
        baseUrl: baseUrl,
        port: port,
        https: https,
      );
  }
}

String buildUrl({
  String baseUrl,
  String port,
  bool https,
}) {
  return '${https ? 'https' : 'http'}://$baseUrl:$port';
}
