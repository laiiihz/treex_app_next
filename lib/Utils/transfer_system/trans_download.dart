import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:treex_app_next/Utils/local_file_util.dart';
import 'package:treex_app_next/Utils/network/network_list.dart';
import 'package:treex_app_next/Utils/network/network_with_token.dart';

class TransDownload {
  static List<DownloadTask> downloadTasks = [];
  static List<DownloadTask> downloadedTasks = [];
  static NUTFullURL _nut;
  static init(String fullURL, String token) {
    _nut = NUTFullURL(token: token, fullURL: fullURL);
  }

  static download({
    @required NTLEntity entity,
    @required VoidCallback onDir,
    @required bool share,

    ///user name
    @required String name,
  }) async {
    Directory filePath = share ? LFU.sharePath : LFU.getMyFile(name);
    String myPath = entity.path.replaceAll('./', '');
    if (entity.isDir) {
      filePath = Directory('${filePath.path}/$myPath');
      filePath.createSync(recursive: true);
      onDir();
    } else {
      File file = File('${filePath.path}/$myPath');
      file = await file.create(recursive: true);
      //build DownloadTask
      DownloadTask downloadTask = DownloadTask(
        name: entity.name,
        file: file,
        entity: entity,
      );
      //add task to taskList
      downloadTasks.add(downloadTask);
      _nut.dio.download(
        '/treex/file/download',
        file.path,
        queryParameters: {
          'share': share,
          'path': entity.path,
        },
        cancelToken: downloadTask.cancelToken,
        onReceiveProgress: (get, all) {
          downloadTasks[downloadTasks.indexOf(downloadTask)].percent =
              get / all;
          if (get == all) {
            downloadedTasks.add(downloadTask);
            downloadTasks.remove(downloadTask);
          }
        },
      );
    }
  }
}

class DownloadTask {
  String name = '';
  CancelToken cancelToken = new CancelToken();
  File file;
  double percent = 0;
  NTLEntity entity;
  DownloadTask({
    @required this.name,
    @required this.file,
    @required this.entity,
  });
}
