import 'package:flutter/cupertino.dart' as cup;
import 'package:flutter/widgets.dart';
import 'package:treex_app_next/UI/auth/sign_up_view_ios.dart';
import 'package:treex_app_next/UI/auth/sign_up_view_android.dart';
import 'package:treex_app_next/Utils/ui_util.dart';

class SignUpView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return isIOS(context)
        ? cup.CupertinoPageScaffold(
            child: SignUpViewIOS(),
          )
        : SignUpViewAndroid();
  }
}
