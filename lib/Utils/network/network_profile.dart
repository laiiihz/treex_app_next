import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:treex_app_next/Utils/network/network_with_token.dart';

class NetworkProfile extends NUT {
  NetworkProfile({@required BuildContext context}) : super(context: context);
  Future profile() async {
    Response response = await dio.get('/treex/profile');
    np.setProfile((response.data as dynamic));
  }
}
