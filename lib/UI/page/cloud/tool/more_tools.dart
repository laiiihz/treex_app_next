import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:treex_app_next/UI/auth/widget/login_text_field.dart';
import 'package:treex_app_next/Utils/network/network_list.dart';
import 'package:treex_app_next/Utils/transfer_system/trans_upload.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';

class MoreTools extends StatefulWidget {
  MoreTools({
    Key key,
    @required this.heroTag,
    this.onChanged,
    @required this.initValue,
    @required this.path,
    @required this.share,
  }) : super(key: key);
  final bool initValue;
  final String heroTag;
  final ValueChanged onChanged;
  final String path;
  final bool share;
  @override
  State<StatefulWidget> createState() => _MoreToolsState();
}

class _MoreToolsState extends State<MoreTools> {
  bool _showFirst = true;
  bool _init = true;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _showFirst = widget.initValue;
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _init = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Hero(
                tag: widget.heroTag,
                child: Container(
                  height: 100,
                  child: Material(
                    color: Colors.transparent,
                    child: AnimatedSwitcher(
                      switchInCurve: Curves.easeInCubic,
                      switchOutCurve: Curves.easeOutCubic,
                      duration: Duration(milliseconds: 500),
                      child: _init
                          ? SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                IconButton(
                                  tooltip: S.of(context).newFolder,
                                  icon:
                                      Icon(MaterialCommunityIcons.folder_plus),
                                  onPressed: () {
                                    showMIUIConfirmDialog(
                                      context: context,
                                      child: TextField(
                                        controller: _textEditingController,
                                        decoration: InputDecoration(
                                          border: TF.border(),
                                          prefixIcon: Icon(
                                              MaterialCommunityIcons
                                                  .folder_plus),
                                        ),
                                      ),
                                      title: S.of(context).newFolder,
                                      confirm: () {
                                        NetworkList(context: context).newFolder(
                                          path: widget.path,
                                          folder: _textEditingController.text,
                                          share: widget.share,
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  tooltip: S.of(context).uploadFile,
                                  icon: Icon(MaterialCommunityIcons.upload),
                                  onPressed: () {
                                    FilePicker.getFile().then((file) {
                                      TransUpload.upload(
                                        file: file,
                                        share: widget.share,
                                        path: widget.path,
                                      );
                                    });
                                  },
                                ),
                                IconButton(
                                  tooltip: S.of(context).view,
                                  icon: AnimatedCrossFade(
                                    duration: Duration(milliseconds: 500),
                                    firstChild:
                                        Icon(MaterialCommunityIcons.view_list),
                                    secondChild:
                                        Icon(MaterialCommunityIcons.view_grid),
                                    crossFadeState: _showFirst
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _showFirst = !_showFirst;
                                    });
                                    widget.onChanged(_showFirst);
                                  },
                                ),
                              ],
                            ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: isDark(context) ? Colors.black : Colors.white,
                    borderRadius: UU.widgetBorderRadius(),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
