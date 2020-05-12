import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:treex_app_next/Utils/local_file_util.dart';
import 'package:treex_app_next/Utils/network/network_with_token.dart';

class NetworkProfile extends NUT {
  NetworkProfile({@required BuildContext context}) : super(context: context);
  Future profile() async {
    Response response = await dio.get('/treex/profile');
    np.setProfile((response.data as dynamic));
  }

  Future<SpaceEntity> space() async {
    Response response = await dio.get('/treex/profile/space');
    return response == null
        ? SpaceEntity()
        : SpaceEntity.fromDynamic(response.data);
  }

  Future setAvatar({File file, String type}) async {
    Response response = await dio.post(
      '/treex/profile/avatar',
      data: FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
        'type': type,
      }),
    );
  }

  Future<File> getAvatar({@required String name}) async {
    File avatarFile = File('${LFU.avatarPath.path}/$name');
    if (!avatarFile.existsSync()) {
      print(avatarFile.path);
      avatarFile = await avatarFile.create();
    }
    Response response =
        await dio.download('/treex/profile/avatar', avatarFile.path);
    return avatarFile;
  }
}

class SpaceEntity {
  int all = 0;
  int used = 0;
  SpaceEntity();
  SpaceEntity.fromDynamic(dynamic space) {
    this.all = space['all'];
    this.used = space['used'];
  }
}
