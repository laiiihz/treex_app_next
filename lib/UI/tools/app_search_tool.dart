import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:treex_app_next/UI/tools/lists/local_list.dart';
import 'package:treex_app_next/UI/tools/lists/private_list.dart';
import 'package:treex_app_next/UI/tools/lists/share_list.dart';
import 'package:treex_app_next/generated/l10n.dart';

class AppSearchTool extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppSearchToolState();
}

class _AppSearchToolState extends State<AppSearchTool> {
  List<Widget> _nowLists = [];
  int _nowIndex = 0;
  bool _reverse = false;
  @override
  void initState() {
    super.initState();
    _nowLists = [
      LocalList(),
      PrivateList(),
      ShareList(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (text) {},
          onSubmitted: (text) {},
          decoration: InputDecoration(
            hintText: S.of(context).search,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
        ),
        bottom: PreferredSize(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildTabItem(0, text: S.of(context).local),
              _buildTabItem(1, text: S.of(context).private),
              _buildTabItem(2, text: S.of(context).share),
            ],
          ),
          preferredSize: Size.fromHeight(60),
        ),
      ),
      body: PageTransitionSwitcher(
        reverse: _reverse,
        transitionBuilder: (Widget child, Animation primaryAnimation,
            Animation secondaryAnimation) {
          return SharedAxisTransition(
            child: child,
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
          );
        },
        child: _nowLists[_nowIndex],
      ),
    );
  }

  _buildTabItem(
    int index, {
    String text,
  }) {
    return Stack(
      children: <Widget>[
        FlatButton(
          color: index == _nowIndex ? Colors.pink : Colors.transparent,
          onPressed: () {
            setState(() {
              _reverse = (index < _nowIndex);
              _nowIndex = index;
            });
          },
          child: Text(text),
        ),
      ],
    );
  }
}
