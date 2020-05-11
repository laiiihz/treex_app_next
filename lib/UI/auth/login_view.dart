import 'dart:async';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/UI/auth/license/sign_up_license.dart';
import 'package:treex_app_next/UI/auth/widget/login_text_field.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_icon_button.dart';
import 'package:treex_app_next/UI/global_widget/logo.dart';
import 'package:treex_app_next/UI/global_widget/treex_cupertino_text_field.dart';
import 'package:treex_app_next/UI/global_widget/treex_notification.dart';
import 'package:treex_app_next/UI/painter/circle_painter.dart';
import 'package:treex_app_next/Utils/network/network_auth.dart';
import 'package:treex_app_next/Utils/network/network_test.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/provider/network_provider.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  int _seed = DateTime.now().millisecondsSinceEpoch;
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
  Timer _timer;
  Key _painterKey = UniqueKey();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final np = Provider.of<NP>(context, listen: false);
      NetworkTest(
        port: np.networkPort,
        baseUrl: np.urlPrefix,
        https: np.https,
        context: context,
        onErr: () {},
      ).check().then((value) {
        if (!value) {
          Navigator.of(context).pushNamed('network');
          showTN(
            context,
            title: S.of(context).networkFail,
            icon: MaterialCommunityIcons.network_off,
            type: StatusType.FAIL,
          );
        }
      });
    });
    _timer = Timer.periodic(
      Duration(milliseconds: 3000),
      (timer) {
        _painterKey = UniqueKey();
        setState(() {
          _seed = _getNowSeed();
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
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
          AnimatedSwitcher(
            duration: Duration(milliseconds: 3000),
            child: CustomPaint(
              key: _painterKey,
              size: MediaQuery.of(context).size,
              painter: CirclePainter(seed: _seed),
            ),
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
                          ? TreexCupertinoTextFieldIOS(
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
                                hintText: S.of(context).enterAccount,
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
                      return Theme.of(context).platform == TargetPlatform.iOS
                          ? TreexCupertinoTextFieldIOS(
                              context: context,
                              placeholder: S.of(context).password,
                              obscureText: !_showPassword,
                              controller: _passwordController,
                              focusNode: _passwordFocusNode,
                              prefix: clear,
                              suffix: eye,
                              onEditingComplete: _lostFocus,
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
                              onEditingComplete: _lostFocus,
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
                                        child: Text(S.of(context).signUp),
                                        onPressed: action,
                                      )
                                    : OutlineButton(
                                        onPressed: action,
                                        child: Text(S.of(context).signUp),
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
                          onPressed: _canLogin ? _auth : null,
                          borderRadius: UU.widgetBorderRadius(),
                        )
                      : RaisedButton(
                          onPressed: _canLogin ? _auth : null,
                          child: Text(S.of(context).login),
                          shape: RoundedRectangleBorder(
                            borderRadius: UU.widgetBorderRadius(),
                          ),
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
    _painterKey = UniqueKey();
    setState(() {
      _canLogin = _passwordController.text.length != 0 &&
          _accountController.text.length != 0;
    });
  }

  //丢失焦点
  _lostFocus() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  _auth() {
    showLoading(context);
    _lostFocus();
    NetworkAuth(context)
        .auth(
      account: _accountController.text,
      password: _passwordController.text,
    )
        .then((value) {
      closeLoading();
      switch (value) {
        case loginResult.NO_USER:
          showTN(
            context,
            title: '没有该用户',
            icon: MaterialCommunityIcons.account_alert,
            type: StatusType.INFO,
          );
          switch (Theme.of(context).platform) {
            case TargetPlatform.android:
            case TargetPlatform.fuchsia:
              showMIUIConfirmDialog(
                context: context,
                child: SizedBox(),
                title: S.of(context).signupNewQuestion,
                confirm: _gotoSignupLicenses,
              );
              break;
            case TargetPlatform.iOS:
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoActionSheet(
                    title: Text(S.of(context).signupNewQuestion),
                    actions: [
                      CupertinoActionSheetAction(
                        onPressed: () => _gotoSignupLicenses(goBack: true),
                        child: Text(S.of(context).signUp),
                      ),
                    ],
                    cancelButton: CupertinoButton(
                      child: Text(S.of(context).cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
              );
              break;
            case TargetPlatform.linux:
              break;
            case TargetPlatform.macOS:
              break;
            case TargetPlatform.windows:
              break;
          }
          break;
        case loginResult.SUCCESS:
          showTN(
            context,
            title: '登录成功',
            icon: MaterialCommunityIcons.check,
            type: StatusType.SUCCESS,
          );
          showLoading(context);
          Navigator.of(context).pushReplacementNamed('home');
          break;
        case loginResult.PASSWORD_WRONG:
          showTN(
            context,
            title: '密码错误',
            icon: MaterialCommunityIcons.onepassword,
            type: StatusType.WARN,
          );
          _onForgetPassword();
          break;
        case loginResult.UNKNOWN:
          break;
        case loginResult.ERR:
          break;
      }
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

  _getNowSeed() {
    setState(() {
      _seed = DateTime.now().millisecondsSinceEpoch;
    });
  }

  _gotoSignupLicenses({bool goBack = false}) {
    if (goBack) Navigator.pop(context);
    Navigator.of(context).pushNamed('licenses');
  }
}
