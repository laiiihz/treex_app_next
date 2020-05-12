import 'dart:io';

import 'package:path_provider/path_provider.dart';

///Local File util
class LFU {
  static Directory _appPath;
  static Directory _avatarPath;
  static Directory _sharePath;
  static Directory _privatePath;

  static init() async {
    if (_appPath == null) {
      _appPath = await getExternalStorageDirectory();
    }
    //init treex dirs
    String appPathString = _appPath.path;
    String avatarPathString = '$appPathString/.AVATAR';
    String sharePathString = '$appPathString/share';
    String privatePathString = '$appPathString/private';
    List<String> paths = [
      avatarPathString,
      sharePathString,
      privatePathString,
    ];
    _avatarPath = Directory(avatarPathString);
    _sharePath = Directory(sharePathString);
    _privatePath = Directory(privatePathString);

    paths.forEach((element) {
      if (!Directory(element).existsSync()) {
        Directory(element).createSync();
      }
    });
  }

  static Directory get appPath => _appPath;
  static Directory get avatarPath => _avatarPath;
  static Directory get sharePath => _sharePath;
  static Directory get privatePath => _privatePath;
  static initMyFile(String name) async {
    bool isInit = await Directory('${_privatePath.path}/$name').exists();
    if (!isInit) await Directory('${_privatePath.path}/$name').create();
  }

  static Directory getMyFile(String name) {
    return Directory('${_privatePath.path}/$name');
  }
}
