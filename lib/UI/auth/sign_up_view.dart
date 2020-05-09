import 'dart:math';

import 'package:flutter/cupertino.dart' as c;
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/UI/global_widget/treex_cupertino_bottom_bar.dart';
import 'package:treex_app_next/UI/global_widget/treex_cupertino_text_filed.dart';
import 'package:treex_app_next/UI/global_widget/treex_notification.dart';
import 'package:treex_app_next/Utils/network/network_auth.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';

class SignUpView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpView> {
  TextEditingController _accountController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return isIOS(context)
        ? c.CupertinoPageScaffold(
            child: c.Stack(
              children: <Widget>[
                c.CustomScrollView(
                  slivers: <Widget>[
                    c.CupertinoSliverNavigationBar(
                      largeTitle:
                          buildCupertinoTitle(context, S.of(context).signUp),
                    ),
                    c.SliverToBoxAdapter(
                      child: c.Padding(
                        padding: c.EdgeInsets.all(10),
                        child: Material(
                          color: Colors.transparent,
                          child: TreexCupertinoTextFiledIOS(
                            context: context,
                            controller: _accountController,
                            whiteBG: true,
                            placeholder: S.of(context).account,
                            prefix: IconButton(
                              icon: Icon(MaterialCommunityIcons.account),
                              onPressed: _clearAccount,
                            ),
                          ),
                        ),
                      ),
                    ),
                    c.SliverToBoxAdapter(
                      child: c.Padding(
                        padding: c.EdgeInsets.all(10),
                        child: Material(
                          color: Colors.transparent,
                          child: TreexCupertinoTextFiledIOS(
                            context: context,
                            whiteBG: true,
                            obscureText: !_showPassword,
                            controller: _passwordController,
                            placeholder: S.of(context).password,
                            prefix: IconButton(
                              icon: Icon(MaterialCommunityIcons.lock),
                              onPressed: _clearPassword,
                            ),
                            suffix: IconButton(
                              icon: c.AnimatedCrossFade(
                                firstChild: Icon(Icons.visibility_off),
                                secondChild: Icon(Icons.visibility),
                                crossFadeState: _showPassword
                                    ? c.CrossFadeState.showFirst
                                    : c.CrossFadeState.showSecond,
                                duration: Duration(milliseconds: 500),
                              ),
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                c.Positioned(
                  child: TreexCupertinoBottomBar(
                    children: [
                      c.Expanded(
                        child: c.CupertinoButton.filled(
                          child: c.Text(S.of(context).signUp),
                          onPressed: _signup,
                        ),
                      ),
                    ],
                  ),
                  bottom: 0,
                  left: 0,
                  right: 0,
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: c.Text(S.of(context).signUp),
            ),
          );
  }

  _clearAccount() {
    _accountController.clear();
  }

  _clearPassword() {
    _passwordController.clear();
  }

  _signup() {
    showLoading(context);
    NetworkAuth(context)
        .signup(
      name: _accountController.text,
      password: _passwordController.text,
    )
        .then((value) {
      closeLoading();
      switch (value) {
        case signUpResult.SUCCESS:
          showTN(
            context,
            title: S.of(context).SignupSuccess,
            icon: Icons.check,
            type: StatusType.SUCCESS,
          );
          Navigator.of(context, rootNavigator: true).pop();
          break;
        case signUpResult.PASSWORD_NULL:
          break;
        case signUpResult.FAIL:
          break;
        case signUpResult.HAVE_USER:
          showTN(
            context,
            title: S.of(context).accountSignuped,
            icon: MaterialCommunityIcons.account_alert_outline,
            type: StatusType.INFO,
          );
          _accountController.text =
              '${_accountController.text}${Random().nextInt(999)}';
          break;
        case signUpResult.UNKNOWN:
          showTN(
            context,
            title: S.of(context).unknownFault,
            icon: MaterialCommunityIcons.account_alert_outline,
            type: StatusType.INFO,
          );
          break;
        case signUpResult.ERR:
          // TODO: Handle this case.
          break;
      }
    });
  }
}
