import 'package:flutter/widgets.dart';
import 'package:treex_app_next/UI/page/cloud/recycle_view_android.dart';
import 'package:treex_app_next/UI/page/cloud/recycle_view_ios.dart';
import 'package:treex_app_next/Utils/ui_util.dart';

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
