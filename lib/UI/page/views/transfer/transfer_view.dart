import 'package:flutter/widgets.dart';
import 'package:treex_app_next/UI/page/views/transfer/download_view_ios.dart';
import 'package:treex_app_next/Utils/ui_util.dart';

class DownloadViewAndroid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DownloadViewAndroidState();
}

class _DownloadViewAndroidState extends State<DownloadViewAndroid> {
  @override
  Widget build(BuildContext context) {
    return isIOS(context) ? DownloadViewIOS() : DownloadViewAndroid();
  }
}
