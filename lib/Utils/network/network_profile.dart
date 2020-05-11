import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:treex_app_next/Utils/file_util.dart';
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
