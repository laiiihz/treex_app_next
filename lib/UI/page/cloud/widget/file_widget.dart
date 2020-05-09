import 'package:flutter/material.dart';
import 'package:treex_app_next/Utils/network/network_list.dart';

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
    return widget.isGrid
        ? GridTile(
            child: Text(widget.entity.name),
          )
        : ListTile(
            title: Text(widget.entity.name),
          );
  }
}
