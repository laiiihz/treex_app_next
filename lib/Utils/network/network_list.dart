import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:treex_app_next/Utils/network/network_with_token.dart';

class NetworkList extends NUT {
  NetworkList({@required BuildContext context}) : super(context: context);
  Future<List<NTLEntity>> getFile(String suffix) async {
    Response response = await dio.get(
      '/treex/$suffix',
      queryParameters: {'path': '.'},
    );
    List<dynamic> filesRaw = response.data['files'];
    List<NTLEntity> files = [];
    filesRaw.forEach((element) => files.add(NTLEntity.fromDynamic(element)));
    return files;
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