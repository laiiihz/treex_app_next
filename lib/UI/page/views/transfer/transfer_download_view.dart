import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as c;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:treex_app_next/UI/global_widget/animated_linear_progress.dart';
import 'package:treex_app_next/Utils/file_util.dart';
import 'package:treex_app_next/Utils/transfer_system/trans_download.dart';
import 'package:treex_app_next/Utils/transfer_system/trans_upload.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/static/color_palettes.dart';

class TransferDownloadView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransferDownloadViewState();
}

class _TransferDownloadViewState extends State<TransferDownloadView>
    with SingleTickerProviderStateMixin {
  bool _downloadedView = false;
  Timer _timer;
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 2,
    );

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: S.of(context).download),
            Tab(
              child: Text(S.of(context).upload),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Stack(
            children: <Widget>[
              ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final task = TransDownload.downloadTasks[index];
                  return ListTile(
                    leading: Icon(
                      FileUtil.getFileIcon(
                        isDir: false,
                        name: task.name,
                      ),
                    ),
                    title: Text(task.name),
                    subtitle: AnimatedLinearProgress(
                      value: task.percent,
                    ),
                    trailing: IconButton(
                      icon: Icon(MaterialCommunityIcons.delete),
                      onPressed: () {
                        task.cancelToken.cancel();
                        TransDownload.downloadTasks.remove(task);
                        setState(() {});
                      },
                    ),
                  );
                },
                itemCount: TransDownload.downloadTasks.length,
              ),
              AnimatedPositioned(
                curve: Curves.easeInOutCubic,
                bottom: _downloadedView
                    ? -(MediaQuery.of(context).size.height - 190)
                    : 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height - 140,
                  decoration: c.BoxDecoration(
                    color:
                        isDark(context) ? Color(0xff222222) : Color(0xffdddddd),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          height: 50,
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Container(
                              height: 5,
                              width: 50,
                              decoration: BoxDecoration(
                                color: CP.cupertinoBG(context, reverse: true),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        onVerticalDragStart: (event) {
                          setState(() {
                            _downloadedView = !_downloadedView;
                          });
                        },
                      ),
                      Center(
                        child: Text(
                          S.of(context).downloaded,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(
                                  TransDownload.downloadedTasks[index].name),
                              trailing: IconButton(
                                icon: Icon(MaterialCommunityIcons.delete),
                                onPressed: () {
                                  TransDownload.downloadedTasks.removeAt(index);
                                  setState(() {});
                                },
                              ),
                            );
                          },
                          itemCount: TransDownload.downloadedTasks.length,
                        ),
                      ),
                    ],
                  ),
                ),
                duration: Duration(milliseconds: 500),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final task = TransUpload.uploadTasks[index];
                  return ListTile(
                    title: Text(task.name),
                    subtitle: AnimatedLinearProgress(
                      value: task.percent,
                    ),
                  );
                },
                itemCount: TransUpload.uploadTasks.length,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
