import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treex_app_next/UI/auth/license/static_licenses.dart';

class LicensesPage extends StatefulWidget {
  LicensesPage({Key key, this.shrinkWrap = false}) : super(key: key);
  final bool shrinkWrap;
  @override
  State<StatefulWidget> createState() => _LicensesPageState();
}

class _LicensesPageState extends State<LicensesPage> {
  int _nowIndex = 0;
  Widget _mainLicensesList(BuildContext context) => ListView(
        shrinkWrap: widget.shrinkWrap,
        padding: widget.shrinkWrap ? EdgeInsets.only(top: 0) : null,
        key: UniqueKey(),
        children: <Widget>[
          ListTile(
            title: Text('GPL v3'),
            subtitle: Text('GNU GENERAL PUBLIC LICENSE'),
            onTap: () {
              setState(() {
                _nowIndex = 1;
              });
            },
          ),
        ],
      );
  Widget _gplLicense(BuildContext context) => SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 100),
        key: UniqueKey(),
        child: Text(StaticLicenses.getGPL(context)),
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
