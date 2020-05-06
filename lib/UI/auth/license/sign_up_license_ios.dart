import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:treex_app_next/UI/auth/license/licenses_page.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/static/color_palettes.dart';

class SignUpLicenseIOS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpLicenseIOS> {
  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor:
                  isDark(context) ? CP.cupertinoBGDark : CP.cupertinoBGLight,
              middle: buildCupertinoTitle(context, S.of(context).userAgreement),
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
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark(context)
                        ? CupertinoColors.black.withAlpha(100)
                        : CupertinoColors.white.withAlpha(100),
                    border: Border(
                      top: BorderSide(
                        width: 0.5,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.top,
                    left: 10,
                    right: 10,
                    top: 10,
                  ),
                  child: Row(
                    children: <Widget>[
                      CupertinoButton(
                        child: Text(S.of(context).disagree),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Expanded(
                        child: CupertinoButton.filled(
                          child: Text(S.of(context).agree),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed('signup');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottom: 0,
            left: 0,
            right: 0,
          ),
        ],
      );
}
