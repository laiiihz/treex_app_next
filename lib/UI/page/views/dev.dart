import 'package:flutter/material.dart';
import 'package:treex_app_next/UI/global_widget/treex_notification.dart';

class DevView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DevViewState();
}

class _DevViewState extends State<DevView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dev mode'),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              showTN(
                context,
                icon: Icons.check,
                title: 'check',
              );
            },
            child: Text('toast'),
          ),
        ],
      ),
    );
  }
}
