import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class NU {
  Dio dio;
  String baseUrl;
  String port;
  bool https;
  bool http2;
  int timeOut;
  NU({
    this.baseUrl = '',
    this.port = '443',
    this.https = true,
    this.http2 = false,
    this.timeOut = 3000,
  });

  init() {
    dio = Dio()
      ..options.connectTimeout = timeOut
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

  @override
  String toString() {
    return '''
    https:$https
    baseUrl:$baseUrl
    port:$port
    timeOut:$timeOut
    ''';
  }
}

class NUFullUrl {
  Dio dio;
  String fullUrl;
  int timeOut;
  NUFullUrl({
    this.fullUrl = '',
    this.timeOut = 3000,
  });

  init() {
    dio = Dio()
      ..options.connectTimeout = timeOut
      ..options.baseUrl = this.fullUrl;
    //https check
    if (this.fullUrl.contains('https://')) {
      print('https');
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
  return '${https ? 'https' : 'http'}://$baseUrl:$port/api';
}

String buildUrlHostOnly({
  String baseUrl,
  String port,
  bool https,
}) =>
    '${https ? 'https' : 'http'}://$baseUrl:$port';
