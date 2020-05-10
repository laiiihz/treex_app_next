import 'dart:math';

import 'package:flutter/cupertino.dart' as c;
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app_next/UI/auth/widget/login_text_field.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/UI/global_widget/treex_bottom_bar.dart';
import 'package:treex_app_next/UI/global_widget/treex_cupertino_bottom_bar.dart';
import 'package:treex_app_next/UI/global_widget/treex_cupertino_text_field.dart';
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
                          child: TreexCupertinoTextFieldIOS(
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
                          child: TreexCupertinoTextFieldIOS(
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
                              onPressed: _showPasswordFunc,
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
            body: Column(
              children: <Widget>[
                Expanded(
                  child: CustomScrollView(
                    physics: MIUIScrollPhysics(),
                    slivers: <Widget>[
                      SliverAppBar(
                        pinned: true,
                        floating: true,
                        stretch: true,
                        expandedHeight: 200,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(S.of(context).signUp),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: _accountController,
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                icon: Icon(MaterialCommunityIcons.account),
                                onPressed: _clearAccount,
                              ),
                              labelText: S.of(context).account,
                              border: TF.border(),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                icon: Icon(MaterialCommunityIcons.lock),
                                onPressed: _clearPassword,
                              ),
                              suffixIcon: IconButton(
                                icon: c.AnimatedCrossFade(
                                  firstChild: Icon(Icons.visibility_off),
                                  secondChild: Icon(Icons.visibility),
                                  crossFadeState: _showPassword
                                      ? c.CrossFadeState.showFirst
                                      : c.CrossFadeState.showSecond,
                                  duration: Duration(milliseconds: 500),
                                ),
                                onPressed: _showPasswordFunc,
                              ),
                              labelText: S.of(context).password,
                              border: TF.border(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TreexBottomBar(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: _signup,
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
  }

  ///清空用户名框
  _clearAccount() {
    _accountController.clear();
  }

  ///清空密码框
  _clearPassword() {
    _passwordController.clear();
  }

  ///注册
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
            title: S.of(context).signupSuccess,
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

  _showPasswordFunc() {
    _showPassword
        ? showTN(
            context,
            title: S.of(context).notShowPassword,
            icon: Icons.visibility_off,
            type: StatusType.NULL,
          )
        : showTN(
            context,
            title: S.of(context).showPassword,
            icon: Icons.visibility,
            type: StatusType.SUCCESS,
          );
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}
