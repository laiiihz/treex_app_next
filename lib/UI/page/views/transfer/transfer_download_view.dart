import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as c;
import 'package:treex_app_next/Utils/transfer_system/trans_download.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/static/color_palettes.dart';

class TransferDownloadView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransferDownloadViewState();
}

class _TransferDownloadViewState extends State<TransferDownloadView> {
  bool _downloadedView = false;
  @override
  Widget build(BuildContext context) {
    return isIOS(context)
        ? c.CupertinoPageScaffold(
            child: CustomScrollView(
              slivers: <Widget>[
                c.CupertinoSliverNavigationBar(),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(),
            body: Stack(
              children: <Widget>[
                ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(TransDownload.downloadTasks[index].name),
                    );
                  },
                  itemCount: TransDownload.downloadTasks.length,
                ),
                AnimatedPositioned(
                  curve: Curves.easeInOutCubic,
                  bottom: _downloadedView
                      ? -(MediaQuery.of(context).size.height - 150)
                      : 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 100,
                    decoration: c.BoxDecoration(
                      color: CP.cupertinoBG(context),
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
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _downloadedView = !_downloadedView;
                            });
                          },
                        ),
                        Center(
                          child: Text(
                            'Downloaded',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                  duration: Duration(milliseconds: 500),
                ),
              ],
            ),
          );
  }
}
