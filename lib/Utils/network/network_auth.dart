import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/provider/network_provider.dart';

class NetworkAuth {
  BuildContext context;
  String _url;
  NetworkAuth({this.context}) {
    final np = Provider.of<NP>(context,listen: false);
    _url = np.fullUrl;
  }
}
