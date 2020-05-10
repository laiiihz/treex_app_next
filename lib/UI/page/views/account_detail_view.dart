import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:flutter/cupertino.dart' as c;
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/provider/network_provider.dart';

class AccountDetailView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountDetailViewState();
}

class _AccountDetailViewState extends State<AccountDetailView> {
  @override
  Widget build(BuildContext context) {
    final np = Provider.of<NP>(context);
    return isIOS(context)
        ? c.CupertinoPageScaffold(
            child: c.CustomScrollView(
              slivers: <Widget>[
                c.CupertinoSliverNavigationBar(
                  largeTitle: buildCupertinoTitle(context, np.profile.name),
                  previousPageTitle: S.of(context).accountView,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: c.EdgeInsets.all(10),
                      child: c.CupertinoButton(
                        onPressed: () {
                          c.showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) {
                              return c.CupertinoActionSheet(
                                actions: <Widget>[
                                  c.CupertinoActionSheetAction(
                                    onPressed: () {},
                                    child: Text(''),
                                  ),
                                ],
                                cancelButton: c.CupertinoButton(
                                  child: c.Text(S.of(context).cancel),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: c.MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(S.of(context).updateAvatar),
                            c.Hero(
                              tag: 'avatar',
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(
                                    0xff000000 + np.profile.backgroundColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                  ]),
                ),
              ],
            ),
          )
        : Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  stretch: true,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(np.profile.name),
                    background: Stack(
                      children: <Widget>[
                        Positioned(
                          right: 50,
                          top: 80,
                          child: Hero(
                            tag: 'account',
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(
                                    0xff000000 + np.profile.backgroundColor),
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              showMIUIDialog(
                                context: context,
                                dyOffset: 0.5,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        '修改头像',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                label: 'account',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([]),
                ),
              ],
            ),
          );
  }
}
