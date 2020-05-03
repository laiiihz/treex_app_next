import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';

class AccountDetailViewAndroid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountDetailViewAndroidState();
}

class _AccountDetailViewAndroidState extends State<AccountDetailViewAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            stretch: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('User'),
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
                          color: Colors.red,
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
