import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/UI/global_widget/animated_blur.dart';
import 'package:treex_app_next/UI/global_widget/icon_with_text.dart';
import 'package:treex_app_next/UI/tools/qrcode_scan_view.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/provider/app_provider.dart';

class ToolsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  Color _color = Colors.transparent;
  double _blur = 0.0;
  bool _backLock = false;
  bool _showTools = false;
  @override
  void initState() {
    super.initState();
    AP ap = Provider.of<AP>(context, listen: false);

    Future.delayed(Duration.zero, () {
      ap.changeShowFAB(false);
      setState(() {
        _color = isDark(context) ? Colors.black45 : Colors.white38;
        _blur = 10;
        _showTools = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Material(
        color: Colors.transparent,
        child: AnimatedBlur(
            duration: Duration(milliseconds: 500),
            child: Stack(
              children: <Widget>[
                AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  color: _color,
                  child: InkWell(
                    onTap: !_backLock
                        ? () {
                            if (!_backLock) {
                              willPop().then((_) {
                                Navigator.of(context).pop();
                              });
                              _backLock = true;
                            }
                          }
                        : null,
                  ),
                ),
                AnimatedPositioned(
                  curve: Curves.easeInOutCubic,
                  bottom: _showTools ? 20 : -100,
                  left: 0,
                  right: 0,
                  child: IconWithText(
                    child: Icon(MaterialCommunityIcons.qrcode_scan),
                    text: S.of(context).qrcode,
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacement(
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return FadeTransition(
                              opacity: animation,
                              child: QrcodeScanView(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  duration: Duration(milliseconds: 500),
                ),
              ],
            ),
            value: _blur),
      ),
      onWillPop: willPop,
    );
  }

  Future<bool> willPop() async {
    AP ap = Provider.of<AP>(context, listen: false);
    ap.changeShowFAB(true);
    if (!_backLock) {
      _backLock = true;

      setState(() {
        _color = Colors.transparent;
        _blur = 0.0;
        _showTools = false;
      });
      await Future.delayed(Duration(milliseconds: 500), () {});
      return true;
    } else
      return false;
  }
}
