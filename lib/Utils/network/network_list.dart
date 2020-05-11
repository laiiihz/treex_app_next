import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:treex_app_next/Utils/network/network_with_token.dart';

class NetworkList extends NUT {
  NetworkList({@required BuildContext context}) : super(context: context);
  Future<List<NTLEntity>> getFile(
    String suffix, {
    @required String path,
  }) async {
    Response response = await dio.get(
      '/treex/$suffix',
      queryParameters: {'path': path},
    );
    List<dynamic> filesRaw = response.data['files'];
    List<NTLEntity> files = [];
    filesRaw.forEach((element) => files.add(NTLEntity.fromDynamic(element)));
    return files;
  }

  Future rename({
    @required String path,
    @required String name,
    @required bool share,
  }) async {
    Response response = await dio.put(
      '/treex/file/rename',
      queryParameters: {
        'new': name,
        'share': share,
        'file': path,
      },
    );
  }
}

///Network List Entity
class NTLEntity {
  DateTime date;
  String path;
  String name;
  bool isDir;
  int length;
  //only working when is dir
  int child;
  NTLEntity.fromDynamic(dynamic entity) {
    this.date = DateTime.fromMillisecondsSinceEpoch((entity['date'] as int));
    this.path = entity['path'];
    this.name = entity['name'];
    this.isDir = entity['isDir'];
    this.length = entity['length'];
    this.child = entity['child'];
  }
}

class PathEntity {
  String name;
  String parent;
  String path;
  PathEntity({this.name, this.parent, this.path});
}
