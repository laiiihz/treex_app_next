import 'package:flutter/cupertino.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/generated/l10n.dart';

class AccountDetailViewIOS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountDetailViewIOSState();
}

class _AccountDetailViewIOSState extends State<AccountDetailViewIOS> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: buildCupertinoTitle(context, 'User'),
            previousPageTitle: S.of(context).accountView,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                height: 100,
                child: Placeholder(
                  color: CupertinoColors.systemBlue,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
