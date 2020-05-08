import 'package:flutter/cupertino.dart' as c;
import 'package:flutter/material.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';

class SignUpView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return isIOS(context)
        ? c.CupertinoPageScaffold(
            child: CustomScrollView(
              slivers: <Widget>[
                c.CupertinoSliverNavigationBar(
                  largeTitle:
                      buildCupertinoTitle(context, S.of(context).sign_up),
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(),
          );
  }
}
