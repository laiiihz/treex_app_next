import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:treex_app_next/Utils/file_util.dart';
import 'package:treex_app_next/Utils/network/network_with_token.dart';

class TransUpload {
  static List<UploadTask> uploadTasks = [];
  static NUTFullURL _nut;
  static init(String fullURL, String token) {
    _nut = NUTFullURL(token: token, fullURL: fullURL);
  }

  static upload({
    @required File file,
    @required bool share,
    @required String path,
  }) async {
    UploadTask uploadTask =
        UploadTask(name: FileUtil.getFileName(file.path), file: file);
    uploadTasks.add(uploadTask);
    Response response = await _nut.dio.post(
      '/treex/upload',
      data: FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
        'path': path,
        'share': share,
      }),
      onReceiveProgress: (put, all) {},
      cancelToken: uploadTask.cancelToken,
    );
  }
}

class UploadTask {
  String name = '';
  CancelToken cancelToken = new CancelToken();
  File file;
  double percent = 0;
  UploadTask({
    @required this.name,
    @required this.file,
  });
}
