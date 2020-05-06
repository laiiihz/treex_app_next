import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:folding_cell/folding_cell/widget.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';

class ExtraNetworkSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExtraNetworkSettingsState();
}

class _ExtraNetworkSettingsState extends State<ExtraNetworkSettings> {
  bool _isExpand = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (index, expand) {
        setState(() {
          _isExpand = !_isExpand;
        });
      },
      children: [
        ExpansionPanel(
          isExpanded: _isExpand,
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              leading: Icon(MaterialCommunityIcons.more),
              title: Text(S.of(context).extraNetworkSettings),
            );
          },
          body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: Text('Time Out'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
