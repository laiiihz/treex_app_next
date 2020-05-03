import 'package:flutter/material.dart';
import 'package:treex_app_next/UI/auth/license/licenses_page.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';

class SignUpLicenseAndroid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpLicenseAndroid> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).userAgreement),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: LicensesPage(),
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.top,
                left: 10,
                right: 10,
                top: 10,
              ),
              child: Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: UU.widgetBorderRadius(),
                      ),
                      color: Theme.of(context).primaryColor,
                      child: Text(S.of(context).agree),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
