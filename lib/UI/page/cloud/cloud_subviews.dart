import 'package:flutter/widgets.dart';
import 'package:treex_app_next/UI/page/cloud/private_view_android.dart';
import 'package:treex_app_next/UI/page/cloud/private_view_ios.dart';
import 'package:treex_app_next/UI/page/cloud/recycle_view_android.dart';
import 'package:treex_app_next/UI/page/cloud/recycle_view_ios.dart';
import 'package:treex_app_next/UI/page/cloud/share_view_android.dart';
import 'package:treex_app_next/UI/page/cloud/share_view_ios.dart';
import 'package:treex_app_next/Utils/ui_util.dart';

class PrivateView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PrivateViewState();
}

class _PrivateViewState extends State<PrivateView> {
  @override
  Widget build(BuildContext context) {
    return isIOS(context) ? PrivateViewIOS() : PrivateViewAndroid();
  }
}

class ShareView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShareViewState();
}

class _ShareViewState extends State<ShareView> {
  @override
  Widget build(BuildContext context) {
    return isIOS(context) ? ShareViewIOS() : ShareViewAndroid();
  }
}

class RecycleView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecycleViewState();
}

class _RecycleViewState extends State<RecycleView> {
  @override
  Widget build(BuildContext context) {
    return isIOS(context) ? RecycleViewIOS() : RecycleViewAndroid();
  }
}
