import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/Utils/file_util.dart';
import 'package:treex_app_next/Utils/network/network_list.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/provider/app_provider.dart';
import 'package:treex_app_next/static/color_palettes.dart';

class FileWidget extends StatefulWidget {
  FileWidget({
    Key key,
    @required this.entity,
    this.isGrid = false,
  }) : super(key: key);
  final NTLEntity entity;
  final bool isGrid;
  @override
  State<StatefulWidget> createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AP>(context);
    return Material(
      color: Colors.transparent,
      child: widget.isGrid
          ? isIOS(context)
              ? Padding(
                  padding: EdgeInsets.all(10),
                  child: CupertinoContextMenu(
                    actions: [
                      CupertinoContextMenuAction(child: Text('重命名')),
                      CupertinoContextMenuAction(
                          child: Text(
                        '删除',
                        style: TextStyle(color: CP.warn(context)),
                      )),
                    ],
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: Container(
                          height: 100,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FileUtil.getFileIcon(
                                  isDir: widget.entity.isDir,
                                  name: widget.entity.name,
                                ),
                                size: 50,
                              ),
                              Center(
                                child: Text(
                                  widget.entity.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          ),
                        ),
                        borderRadius: UU.widgetBorderRadius(),
                        onTap: () {},
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Icon(
                            FileUtil.getFileIcon(
                              isDir: widget.entity.isDir,
                              name: widget.entity.name,
                            ),
                            size: 50,
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.entity.name,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                    borderRadius: UU.widgetBorderRadius(),
                    onTap: () {},
                    onLongPress: () {
                      _onLongPress(context);
                    },
                  ),
                )
          : isIOS(context)
              ? Material(
                  child: _buildListTile(),
                )
              : _buildListTile(),
    );
  }

  _buildListTile() {
    final ap = Provider.of<AP>(context);
    return ListTile(
      onTap: () {},
      onLongPress: () {
        _onLongPress(context);
      },
      leading: Icon(
        FileUtil.getFileIcon(
          isDir: widget.entity.isDir,
          name: widget.entity.name,
        ),
      ),
      title: Text(widget.entity.name),
      subtitle: Text(FileUtil.getFileDate(
        widget.entity.date,
        context: context,
        detail: ap.fileDetail,
      )),
    );
  }

  _onLongPress(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text('操作'),
            actions: <Widget>[
              CupertinoActionSheetAction(onPressed: () {}, child: Text('重命名')),
              CupertinoActionSheetAction(
                  onPressed: () {},
                  child: Text(
                    '删除',
                    style: TextStyle(color: CP.warn(context)),
                  )),
            ],
            cancelButton: CupertinoButton(
              child: Text(S.of(context).cancelUpper),
              onPressed: () => Navigator.of(context).pop(),
            ),
          );
        },
      );
    } else {
      RenderBox renderBox = context.findRenderObject() as RenderBox;
      Offset offset = renderBox.localToGlobal(Offset.zero);
      final size = MediaQuery.of(context).size;
      showMenu(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: UU.widgetBorderRadius(),
        ),
        position: RelativeRect.fromLTRB(
          offset.dx + renderBox.size.width / 2,
          offset.dy + renderBox.size.height / 2,
          size.width,
          size.height,
        ),
        items: [
          PopupMenuItem(
            child: Text('重命名'),
          ),
          PopupMenuItem(
            child: Text(
              '删除',
              style: TextStyle(
                color: CP.warn(context),
              ),
            ),
          ),
        ],
      );
    }
  }
}
