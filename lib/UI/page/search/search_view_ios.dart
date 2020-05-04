import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as md;
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/static/color_palettes.dart';

class SearchViewIOSParent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: buildCupertinoTitle(context, S.of(context).search),
        backgroundColor:
            isDark(context) ? CP.cupertinoBGDark : CP.cupertinoBGLight,
      ),
      child: SearchViewIOS(),
    );
  }
}

class SearchViewIOS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchViewIOS> {
  int _nowSearchIndex = 0;
  TextEditingController _textEditingController = TextEditingController();

  final _localKey = UniqueKey();
  final _privateKey = UniqueKey();
  final _shareKey = UniqueKey();

  bool _reverse = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: CupertinoTextField(
            placeholder: S.of(context).search,
            prefix: Icon(md.Icons.search),
            prefixMode: OverlayVisibilityMode.notEditing,
            padding: EdgeInsets.all(10),
            controller: _textEditingController,
            decoration: BoxDecoration(
              color: isDark(context)
                  ? CupertinoColors.black
                  : CupertinoColors.black.withAlpha(30),
              borderRadius: UU.widgetBorderRadius(),
            ),
          ),
        ),
        md.Material(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: CupertinoSlidingSegmentedControl<int>(
              onValueChanged: (value) {
                _reverse = _nowSearchIndex > value;
                setState(() {
                  _nowSearchIndex = value;
                });
              },
              groupValue: _nowSearchIndex,
              children: {
                0: Text(S.of(context).local),
                1: Text(S.of(context).private),
                2: Text(S.of(context).share),
              },
            ),
          ),
        ),
        Expanded(
          child: md.Material(
            child: PageTransitionSwitcher(
              reverse: _reverse,
              transitionBuilder: (Widget child,
                  Animation<double> primaryAnimation,
                  Animation<double> secondaryAnimation) {
                return SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child,
                );
              },
              child: buildChild(_nowSearchIndex),
            ),
          ),
        ),
      ],
    );
  }

  buildChild(int index) {
    switch (index) {
      case 0:
        return ListView.builder(
          key: _localKey,
          itemBuilder: (BuildContext context, int index) {
            return Text('test');
          },
        );
      case 1:
        return ListView.builder(
          key: _privateKey,
          itemBuilder: (BuildContext context, int index) {
            return Text('test');
          },
        );
      case 2:
        return ListView.builder(
          key: _shareKey,
          itemBuilder: (BuildContext context, int index) {
            return Text('test');
          },
        );
    }
  }
}
