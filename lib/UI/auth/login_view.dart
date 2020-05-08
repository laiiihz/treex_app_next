import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app_next/UI/auth/license/sign_up_license.dart';
import 'package:treex_app_next/UI/auth/widget/login_text_field.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_icon_button.dart';
import 'package:treex_app_next/UI/global_widget/logo.dart';
import 'package:treex_app_next/UI/global_widget/treex_cupertino_text_filed.dart';
import 'package:treex_app_next/UI/page/home_structure.dart';
import 'package:treex_app_next/UI/painter/circle_painter.dart';
import 'package:treex_app_next/Utils/CryptoUtil.dart';
import 'package:treex_app_next/Utils/network/network_auth.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  static int _seed = DateTime.now().millisecondsSinceEpoch;
  ScrollController _scrollController = ScrollController();
  FocusNode _accountFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  TextEditingController _accountController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;
  bool _canLogin = false;
  double test = 0;

  ///forget password
  ///
  /// if password wrong 3 times,then show a forget password dialog
  int _forgetPassword = 0;

  @override
  void dispose() {
    super.dispose();
    _accountController.dispose();
    _passwordController.dispose();
    _scrollController.dispose();
    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: CirclePainter(seed: _seed),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Material(
              color: Colors.transparent,
              child: ListView(
                controller: _scrollController,
                physics: MIUIScrollPhysics(),
                padding: EdgeInsets.only(
                  top: 100,
                  bottom: 60,
                  left: 60,
                  right: 60,
                ),
                children: <Widget>[
                  Center(
                    child: Logo(),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width - 50,
                    child: FlareActor(
                      'assets/treex-next.flr',
                      animation: 'logo',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Builder(
                    builder: (BuildContext context) {
                      Widget clear = IconButton(
                        icon: Icon(Icons.account_circle),
                        onPressed: () {
                          _accountController.clear();
                          setState(() {
                            _canLogin = false;
                          });
                        },
                      );
                      VoidCallback onEditingComplete = () {
                        _passwordFocusNode.requestFocus();
                      };
                      return Theme.of(context).platform == TargetPlatform.iOS
                          ? TreexCupertinoTextFiledIOS(
                              context: context,
                              placeholder: S.of(context).account,
                              controller: _accountController,
                              onEditingComplete: onEditingComplete,
                              prefix: clear,
                              focusNode: _accountFocusNode,
                              onChanged: _onChange,
                            )
                          : TextField(
                              controller: _accountController,
                              focusNode: _accountFocusNode,
                              decoration: InputDecoration(
                                labelText: S.of(context).account,
                                hintText: S.of(context).enter_account,
                                prefixIcon: clear,
                                border: TF.border(),
                                fillColor: TF.fillColor(context),
                                filled: true,
                              ),
                              onChanged: _onChange,
                              onEditingComplete: onEditingComplete,
                            );
                    },
                  ),
                  SizedBox(height: 10),
                  Builder(
                    builder: (BuildContext context) {
                      Widget clear = IconButton(
                        icon: Icon(Icons.lock),
                        onPressed: () {
                          _passwordController.clear();
                          setState(() {
                            _canLogin = false;
                          });
                        },
                      );
                      Widget eye = IconButton(
                        icon: AnimatedCrossFade(
                          duration: Duration(milliseconds: 500),
                          crossFadeState: _showPassword
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          secondChild: Icon(
                            Icons.visibility,
                          ),
                          firstChild: Icon(
                            Icons.visibility_off,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      );
                      VoidCallback onEditingComplete = () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      };
                      return Theme.of(context).platform == TargetPlatform.iOS
                          ? TreexCupertinoTextFiledIOS(
                              context: context,
                              placeholder: S.of(context).password,
                              obscureText: !_showPassword,
                              controller: _passwordController,
                              focusNode: _passwordFocusNode,
                              prefix: clear,
                              suffix: eye,
                              onEditingComplete: onEditingComplete,
                              onChanged: _onChange,
                            )
                          : TextField(
                              obscureText: !_showPassword,
                              controller: _passwordController,
                              focusNode: _passwordFocusNode,
                              decoration: InputDecoration(
                                labelText: S.of(context).password,
                                prefixIcon: clear,
                                suffixIcon: eye,
                                border: TF.border(),
                                fillColor: TF.fillColor(context),
                                filled: true,
                              ),
                              onEditingComplete: onEditingComplete,
                              onChanged: _onChange,
                            );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? CupertinoIconButton(
                              icon: Icons.settings,
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed('network');
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.settings),
                              onPressed: () {
                                Navigator.of(context).pushNamed('network');
                              },
                            ),
                      OpenContainer(
                        transitionType: ContainerTransitionType.fade,
                        closedColor: Colors.transparent,
                        transitionDuration: const Duration(milliseconds: 500),
                        openBuilder: (context, action) {
                          return SignUpLicense();
                        },
                        closedElevation: 0,
                        openColor: Colors.transparent,
                        openElevation: 0,
                        openShape: RoundedRectangleBorder(
                          borderRadius: UU.widgetBorderRadius(),
                        ),
                        closedBuilder: (context, action) {
                          return Padding(
                            padding: EdgeInsets.all(1),
                            child: Builder(
                              builder: (BuildContext context) {
                                return Theme.of(context).platform ==
                                        TargetPlatform.iOS
                                    ? CupertinoButton(
                                        child: Text(S.of(context).sign_up),
                                        onPressed: action,
                                      )
                                    : OutlineButton(
                                        onPressed: action,
                                        child: Text(S.of(context).sign_up),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: UU.widgetBorderRadius(),
                                        ),
                                      );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Theme.of(context).platform == TargetPlatform.iOS
                      ? CupertinoButton.filled(
                          child: Text(S.of(context).login),
                          onPressed: _canLogin ? () {} : null,
                          borderRadius: UU.widgetBorderRadius(),
                        )
                      : RaisedButton(
                          onPressed: _canLogin ? () {} : null,
                          child: Text(S.of(context).login),
                          shape: RoundedRectangleBorder(
                            borderRadius: UU.widgetBorderRadius(),
                          ),
                        ),
                  //TODO:dev button
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomeStructure(),
                        ),
                      );
                    },
                    child: Text('dev'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      String password = CryptoUtil.password(
                        raw: _passwordController.text,
                        name: _accountController.text,
                      );
                      NetworkAuth(context).auth(
                        account: _accountController.text,
                        password: password,
                      );
                    },
                    child: Text('check'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onChange(text) {
    setState(() {
      _canLogin = _passwordController.text.length != 0 &&
          _accountController.text.length != 0;
    });
  }

  _onForgetPassword() {
    _forgetPassword++;
    if (_forgetPassword == 3) {
      _forgetPassword = 0;
      showMIUIConfirmDialog(
        context: context,
        child: SizedBox(),
        title: S.of(context).forgetPassword,
        confirm: () {},
        confirmString: S.of(context).forgetPasswordConfirm,
      );
    }
  }
}
