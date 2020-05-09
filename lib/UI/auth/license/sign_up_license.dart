import 'package:flutter/cupertino.dart' as c;
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:treex_app_next/UI/auth/license/licenses_page.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/UI/global_widget/treex_bottom_bar.dart';
import 'package:treex_app_next/UI/global_widget/treex_cupertino_bottom_bar.dart';
import 'package:treex_app_next/UI/global_widget/treex_notification.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/static/color_palettes.dart';

class SignUpLicense extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpLicense> {
  @override
  Widget build(BuildContext context) => Theme.of(context).platform ==
          TargetPlatform.iOS
      ? Stack(
          children: <Widget>[
            c.CupertinoPageScaffold(
              navigationBar: c.CupertinoNavigationBar(
                backgroundColor: CP.cupertinoBG(context),
                middle:
                    buildCupertinoTitle(context, S.of(context).userAgreement),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: LicensesPage(),
                  ),
                ],
              ),
            ),
            Positioned(
              child: TreexCupertinoBottomBar(
                children: <Widget>[
                  c.CupertinoButton(
                    child: Text(S.of(context).disagree),
                    onPressed: _disagree,
                  ),
                  Expanded(
                    child: c.CupertinoButton.filled(
                      child: Text(S.of(context).agree),
                      onPressed: _agree,
                    ),
                  ),
                ],
              ),
              bottom: 0,
              left: 0,
              right: 0,
            ),
          ],
        )
      : Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).userAgreement),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: LicensesPage(),
              ),
              TreexBottomBar(
                children: <Widget>[
                  FlatButton(
                    onPressed: _disagree,
                    child: Text(
                      S.of(context).disagree,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: UU.widgetBorderRadius(),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: _agree,
                      shape: RoundedRectangleBorder(
                        borderRadius: UU.widgetBorderRadius(),
                      ),
                      color: Theme.of(context).primaryColor,
                      child: Text(S.of(context).agree),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );

  _disagree() {
    showTN(context, title: '取消注册', icon: MaterialCommunityIcons.cancel);
    Navigator.of(context).pop();
  }

  _agree() {
    Navigator.of(context).pop();
    Navigator.of(context, rootNavigator: true).pushNamed('signup');
  }
}
