import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:treex_app_next/Utils/network/network_list.dart';
import 'package:treex_app_next/Utils/network/network_with_token.dart';

class NetworkSearch extends NUT {
  NetworkSearch({@required BuildContext context}) : super(context: context);
  Future search({String query, bool share}) async {
    List<NTLEntity> searchResults = [];

    Response response = await dio.get('/treex/file/search', queryParameters: {
      'query': query,
      'share': share,
    });
    List<dynamic> result = response.data['search'];
    result.forEach((element) {
      searchResults.add(NTLEntity.fromDynamic(element));
    });
    return result;
  }
}
