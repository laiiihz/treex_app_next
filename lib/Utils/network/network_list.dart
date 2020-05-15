import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
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

  Future delete({
    @required bool share,
    @required String path,
  }) async {
    Response response = await dio.delete(
      '/treex/${share ? 'share' : 'file'}',
      queryParameters: {'path': path},
    );
  }

  Future newFolder({
    @required String path,
    @required String folder,
    @required bool share,
  }) async {
    Response response = await dio.put(
      '/treex/file/newFolder',
      queryParameters: {
        'path': path,
        'folder': folder,
        'share': share,
      },
    );
  }

  Future recycle() async {
    Response response = await dio.get('/treex/file/recycle');
    List<dynamic> rawList = response.data['recycleFiles'];
    List<RecycleEntity> recycleLists = [];
    rawList.forEach((element) {
      recycleLists.add(RecycleEntity.fromDynamic(element));
    });
    return recycleLists;
  }

  Future clearRecycle() async {
    await dio.delete('/treex/file/clear');
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

class RecycleEntity {
  String name = '';
  String path = '';
  RecycleEntity.fromDynamic(dynamic entity) {
    this.name = entity['name'];
    this.path = entity['path'];
  }
}
