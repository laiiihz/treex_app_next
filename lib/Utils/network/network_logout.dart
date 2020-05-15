import 'package:flutter/widgets.dart';
import 'package:treex_app_next/Utils/network/network_with_token.dart';

class NetworkLogout extends NUT {
  NetworkLogout({@required BuildContext context}) : super(context: context);
  logout() async {
    await dio.delete('/treex/logout');
  }

  remove() async {
    await dio.delete('/treex/remove');
  }
}
