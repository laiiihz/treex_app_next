import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treex_app_next/UI/auth/license/static_licenses.dart';
import 'package:treex_app_next/generated/l10n.dart';

class LicensesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LicensesPageState();
}

class _LicensesPageState extends State<LicensesPage> {
  int _nowIndex = 0;
  Widget _mainLicensesList(BuildContext context) => ListView(
        key: UniqueKey(),
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: ListTile(
              title: Text(S.of(context).gplV3),
              subtitle: Text(S.of(context).gnuGeneralPublicLicense),
              onTap: () {
                setState(() {
                  _nowIndex = 1;
                });
              },
            ),
          ),
        ],
      );
  Widget _gplLicense(BuildContext context) => SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 100),
        key: UniqueKey(),
        child: Material(
          color: Colors.transparent,
          child: Text(StaticLicenses.getGPL(context)),
        ),
      );
  List<Widget> _widgets = [SizedBox()];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _widgets = [
        _mainLicensesList(context),
        _gplLicense(context),
      ];
      setState(() {
        _nowIndex = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: PageTransitionSwitcher(
        duration: Duration(milliseconds: 600),
        transitionBuilder: (child, animation, secondAnimation) {
          return SharedAxisTransition(
            child: child,
            animation: animation,
            secondaryAnimation: secondAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
          );
        },
        child: _widgets[_nowIndex],
      ),
      onWillPop: () async {
        if (_nowIndex == 0) {
          return true;
        } else {
          setState(() {
            _nowIndex = 0;
          });
          return false;
        }
      },
    );
  }
}
