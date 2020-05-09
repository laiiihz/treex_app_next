import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app_next/UI/global_widget/treex_bottom_bar.dart';
import 'package:treex_app_next/generated/l10n.dart';

class FirstStartUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FirstStartUpState();
}

class _FirstStartUpState extends State<FirstStartUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('startup'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: TreexBottomBarN(
              single: true,
              onCancel: () {
                SystemNavigator.pop(animated: true);
              },
              onConfirm: () {
                showMIUIConfirmDialog(
                  context: context,
                  child: Container(
                    height: 300,
                    child: ListView(
                      children: <Widget>[],
                    ),
                  ),
                  title: S.of(context).requestPermission,
                  confirm: () {
                    Navigator.of(context).pushReplacementNamed('login');
                  },
                  confirmString: S.of(context).agree,
                  cancelString: S.of(context).disagree,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
