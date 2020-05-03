import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/provider/app_provider.dart';

class NU {
  //app provider
  AP _ap;
  Dio _dio;
  NU({
    BuildContext context,
    String baseUrl,
    String path,
  }) {
    _ap = Provider.of<AP>(context);
  }
}
