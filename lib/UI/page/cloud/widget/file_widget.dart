import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/UI/auth/widget/login_text_field.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_blur_parent.dart';
import 'package:treex_app_next/UI/global_widget/treex_cupertino_text_field.dart';
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
    @required this.onPressed,
    @required this.share,
  }) : super(key: key);
  final NTLEntity entity;
  final bool isGrid;
  final VoidCallback onPressed;
  final bool share;
  @override
  State<StatefulWidget> createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.entity.name;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: widget.isGrid
          ? isIOS(context)
              ? Padding(
                  padding: EdgeInsets.all(10),
                  child: CupertinoContextMenu(
                    actions: [
                      CupertinoContextMenuAction(
                          child: Text(S.of(context).download)),
                      CupertinoContextMenuAction(
                        child: Text(S.of(context).rename),
                        onPressed: _showRenameDialog,
                      ),
                      CupertinoContextMenuAction(
                        child: Text(
                          S.of(context).delete,
                          style: TextStyle(color: CP.warn(context)),
                        ),
                        onPressed: widget.share
                            ? () {
                                _checkDelete();
                              }
                            : () {
                                _delete();
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                      ),
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
                        onTap: widget.onPressed,
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
                    onTap: widget.onPressed,
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
      onTap: widget.onPressed,
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
            title: Text(S.of(context).operation),
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: _showRenameDialog,
                child: Text(S.of(context).rename),
              ),
              CupertinoActionSheetAction(
                onPressed: widget.share ? _checkDelete : _delete,
                child: Text(
                  S.of(context).delete,
                  style: TextStyle(color: CP.warn(context)),
                ),
              ),
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
      showMenu<String>(
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
            value: 'download',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(S.of(context).download),
                Icon(MaterialCommunityIcons.download),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'rename',
            child: Text(S.of(context).rename),
          ),
          PopupMenuItem(
            value: 'delete',
            child: Text(
              S.of(context).delete,
              style: TextStyle(
                color: CP.warn(context),
              ),
            ),
          ),
        ],
      ).then(
        (value) {
          switch (value) {
            case 'download':
              break;
            case 'rename':
              showMIUIConfirmDialog(
                context: context,
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    border: TF.border(),
                  ),
                ),
                title: S.of(context).rename,
                confirm: _onlyRename,
              );
              break;
            case 'delete':
              widget.share
                  ? showMIUIConfirmDialog(
                      context: context,
                      child: SizedBox(),
                      title: S.of(context).delete,
                      confirm: _delete,
                    )
                  : _delete();
              break;
          }
        },
      );
    }
  }

  _rename() {
    _onlyRename();
    Navigator.of(context, rootNavigator: true).pop();
  }

  _onlyRename() {
    NetworkList(context: context).rename(
      path: widget.entity.path,
      name: _textEditingController.text,
      share: widget.share,
    );
  }

  _showRenameDialog() {
    Navigator.of(context, rootNavigator: true).pop();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(S.of(context).rename),
          content: TreexCupertinoTextFieldIOS(
            context: context,
            controller: _textEditingController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(S.of(context).cancelUpper),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(S.of(context).confirmUpper),
              onPressed: _rename,
            ),
          ],
        );
      },
    );
  }

  _delete() {
    NetworkList(context: context)
        .delete(share: widget.share, path: widget.entity.path);
  }

  _checkDelete() {
    Navigator.of(context, rootNavigator: true).pop();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(S.of(context).delete),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(S.of(context).cancelUpper),
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            ),
            CupertinoDialogAction(
              child: Text(S.of(context).confirmUpper),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                _delete();
              },
            ),
          ],
        );
      },
    );
  }
}
