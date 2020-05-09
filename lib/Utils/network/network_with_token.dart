import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/Utils/network/network_util.dart';
import 'package:treex_app_next/provider/network_provider.dart';

///network Util with Token
class NUT extends NU {
  NP np;
  NUT({@required BuildContext context}) : super() {
    np = Provider.of<NP>(context, listen: false);
    this.baseUrl = np.urlPrefix;
    this.port = np.networkPort;
    this.https = np.https;
    this.init();
    dio
      ..options.headers = {
        'Authorization': np.token,
      };
  }
}
