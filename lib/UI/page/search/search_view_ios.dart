import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as md;
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/UI/tools/cupertino_tools_button.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';

class SearchViewIOS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchViewIOS> {
  String _nowSearchIndex = 'local';
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: buildCupertinoTitle(context, S.of(context).search),
          trailing: CupertinoToolsButton(),
        ),
        SliverToBoxAdapter(
          child: Padding(
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
        ),
        SliverToBoxAdapter(
          child: md.Material(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: CupertinoSlidingSegmentedControl<String>(
                onValueChanged: (value) {
                  setState(() {
                    _nowSearchIndex = value;
                  });
                },
                groupValue: _nowSearchIndex,
                children: {
                  'local': Text(S.of(context).local),
                  'private': Text(S.of(context).private),
                  'share': Text(S.of(context).share),
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
