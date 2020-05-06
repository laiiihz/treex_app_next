import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:treex_app_next/UI/global_widget/treex_notification.dart';
import 'package:treex_app_next/Utils/network_util.dart';

class NetworkTest extends NU {
  final VoidCallback onErr;
  NetworkTest({
    bool https,
    String port,
    String baseUrl,
    BuildContext context,
    this.onErr,
  }) : super(
          https: https,
          port: port,
          baseUrl: baseUrl,
          context: context,
        );
  Future<bool> check() async {
    Response response = await dio.get('/').catchError((_) {
      onErr();
    });
    return response == null ? false : response.statusCode == 200;
  }
}
