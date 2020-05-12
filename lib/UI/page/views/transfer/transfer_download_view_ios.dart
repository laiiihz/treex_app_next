import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:treex_app_next/UI/global_widget/animated_linear_progress.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_icon_button.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/Utils/file_util.dart';
import 'package:treex_app_next/Utils/transfer_system/trans_download.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/static/color_palettes.dart';
import 'package:flutter/material.dart' as md;

class TransferDownloadViewIOS extends StatefulWidget {
  TransferDownloadViewIOS({
    Key key,
    this.previous,
  }) : super(key: key);
  final String previous;

  @override
  State<StatefulWidget> createState() => _TransferDownloadViewIOSState();
}

class _TransferDownloadViewIOSState extends State<TransferDownloadViewIOS> {
  Timer _timer;
  bool _firstPage = true;
  bool _showDownloaded = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CP.cupertinoBG(context),
        previousPageTitle: widget.previous,
        middle: buildCupertinoTitle(context, S.of(context).download),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: md.Material(
              color: md.Colors.transparent,
              child: CupertinoSlidingSegmentedControl(
                children: {
                  1: Text(S.of(context).download),
                  2: Text(S.of(context).upload),
                },
                onValueChanged: (value) {
                  setState(() {
                    _firstPage = (value == 1);
                  });
                },
                groupValue: _firstPage ? 1 : 2,
              ),
            ),
          ),
          Expanded(
            child: md.Material(
              child: PageTransitionSwitcher(
                reverse: _firstPage,
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
                child: _firstPage
                    ? Stack(
                        children: <Widget>[
                          ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              final task = TransDownload.downloadTasks[index];
                              return md.ListTile(
                                leading: Icon(
                                  FileUtil.getFileIcon(
                                      isDir: false, name: task.name),
                                ),
                                title: Text(task.name),
                                trailing: CupertinoIconButton(
                                  icon: CupertinoIcons.clear_circled_solid,
                                  onPressed: () {
                                    task.cancelToken.cancel();
                                    TransDownload.downloadTasks.remove(task);
                                    setState(() {});
                                  },
                                ),
                                subtitle: AnimatedLinearProgress(
                                  value: task.percent,
                                ),
                              );
                            },
                            itemCount: TransDownload.downloadTasks.length,
                          ),
                          AnimatedPositioned(
                            curve: Curves.easeInOutCubic,
                            bottom: _showDownloaded
                                ? 0
                                : -(MediaQuery.of(context).size.height - 190),
                            left: 0,
                            right: 0,
                            duration: Duration(milliseconds: 500),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: md.BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                                color: CP.cupertinoBG(context),
                              ),
                              height: MediaQuery.of(context).size.height - 140,
                              child: Column(
                                children: <Widget>[
                                  GestureDetector(
                                    child: Container(
                                      color: md.Colors.transparent,
                                      height: 50,
                                      child: Center(
                                        child: Container(
                                          height: 5,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: CP.cupertinoBG(context,
                                                reverse: true),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onVerticalDragStart: (event) {
                                      setState(() {
                                        _showDownloaded = !_showDownloaded;
                                      });
                                    },
                                    onVerticalDragDown: (event) {},
                                  ),
                                  Center(
                                    child: Text(
                                      S.of(context).downloaded,
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final task = TransDownload
                                            .downloadedTasks[index];
                                        return md.Material(
                                          color: md.Colors.transparent,
                                          child: md.ListTile(
                                            leading: Icon(
                                              FileUtil.getFileIcon(
                                                  isDir: false,
                                                  name: task.name),
                                            ),
                                            title: Text(task.name),
                                            trailing: md.IconButton(
                                              icon: Icon(CupertinoIcons.clear),
                                              onPressed: () {
                                                TransDownload.downloadedTasks
                                                    .removeAt(index);
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount:
                                          TransDownload.downloadedTasks.length,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return Text('test');
                        },
                      ),
              ),
              color: md.Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
